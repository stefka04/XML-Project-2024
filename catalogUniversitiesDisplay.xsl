<!--<?xml version="1.0" encoding="UTF-8"?>-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="xml" indent="yes" encoding="UTF-8"/>
	<xsl:key name="regionById" match="region" use="@id"/>
	<xsl:template match="/universityCatalog">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="cover" page-height="29.7cm" page-width="21cm" margin="0.5cm" background-color="#ead1dc">
					<fo:region-body background-color="white"/>
				</fo:simple-page-master>
				<fo:simple-page-master master-name="A4" page-height="29.7cm" page-width="21cm" margin="0.5cm" background-color="#ead1dc">
					<fo:region-body background-color="#ead1dc"/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="cover">
				<fo:flow flow-name="xsl-region-body">
					<fo:block font-family="Monotype Corsiva" font-size="48pt" font-weight="bold" text-align="center" margin-top="6cm" margin-bottom="1cm" color="white" background-color="#ead1dc">
                        Университети в България
                    </fo:block>
				</fo:flow>
			</fo:page-sequence>
			<!-- Съдържание -->
			<fo:page-sequence master-reference="cover">
				<fo:flow flow-name="xsl-region-body">
					<fo:block font-family="Times New Roman" font-size="20pt" text-align="center" font-weight="bold" margin-bottom="1cm" text-decoration="underline" color="#8c4061">
                Съдържание:
            </fo:block>
					<fo:list-block provisional-distance-between-starts="20pt" provisional-label-separation="10pt">
						<xsl:for-each select="//region">
							<fo:list-item>
								<fo:list-item-label end-indent="label-end()">
									<fo:block>•</fo:block>
								</fo:list-item-label>
								<fo:list-item-body start-indent="body-start()">
									<fo:block font-family="Times New Roman" font-size="12pt" color="#8c4061">
                                Университети в <xsl:value-of select="."/>
									</fo:block>
								</fo:list-item-body>
							</fo:list-item>
						</xsl:for-each>
					</fo:list-block>
				</fo:flow>
			</fo:page-sequence>
			<fo:page-sequence master-reference="A4" margin-left="0.5cm">
				<fo:flow flow-name="xsl-region-body">
					<!-- Process each region -->
					<xsl:for-each select="region">
						<fo:block break-before="page">
						<fo:block font-family="Monotype Corsiva" font-size="22pt" font-weight="bold" color="#8c4061" margin-top="0.3cm" text-align="center">
                            Университети в <xsl:value-of select="."/>
						</fo:block>
						</fo:block>
						<!-- Select universities matching the region -->
						<xsl:for-each select="//university[@region = current()/@id]">
						<xsl:if test="position() != 1">
						<fo:block break-before="page"/>
						</xsl:if>
							<fo:block margin-top="0.5cm" font-family="Monotype Corsiva" font-size="20pt" font-weight="bold" color="#8c4061" background-color="white" text-align="center">
								<xsl:value-of select="title"/>
							</fo:block>
							<!-- image -->
							<fo:block margin-top="0.5cm">
								<fo:external-graphic src="{image/@src}" content-height="scale-to-fit" content-width="6cm"/>
							</fo:block>
							<fo:block font-family="Monotype Corsiva" font-size="11pt" margin-left="1cm">
								<fo:inline font-weight="bold" text-decoration="underline">Контакти:</fo:inline>
								<fo:list-block>
									<!-- telephone -->
									<xsl:if test="contacts/telephone">
										<fo:list-item>
											<fo:list-item-label end-indent="label-end()">
												<fo:block>•</fo:block>
											</fo:list-item-label>
											<fo:list-item-body start-indent="body-start()">
												<fo:block font-family="Monotype Corsiva">телефон: <xsl:value-of select="contacts/telephone"/>
												</fo:block>
											</fo:list-item-body>
										</fo:list-item>
									</xsl:if>
									<!-- Email -->
									<xsl:if test="contacts/email">
										<fo:list-item>
											<fo:list-item-label end-indent="label-end()">
												<fo:block>•</fo:block>
											</fo:list-item-label>
											<fo:list-item-body start-indent="body-start()">
												<fo:block font-family="Monotype Corsiva">email: <xsl:value-of select="contacts/email"/>
												</fo:block>
											</fo:list-item-body>
										</fo:list-item>
									</xsl:if>
									<!-- website -->
									<fo:list-item>
										<fo:list-item-label end-indent="label-end()">
											<fo:block>•</fo:block>
										</fo:list-item-label>
										<fo:list-item-body start-indent="body-start()">
											<fo:block font-family="Monotype Corsiva">уебсайт: <xsl:value-of select="contacts/website/@href"/>
											</fo:block>
										</fo:list-item-body>
									</fo:list-item>
								</fo:list-block>
							</fo:block>
							<fo:block font-family="Monotype Corsiva" font-size="11pt" margin-left="1cm" margin-top="0.5cm">
								<fo:inline font-family="Monotype Corsiva" font-weight="bold" text-decoration="underline">Адрес:</fo:inline>
								<fo:block font-family="Monotype Corsiva">
									<xsl:value-of select="address/city"/>, 
                                    <xsl:value-of select="address/street"/>
								</fo:block>
							</fo:block>
							<!-- Funding -->
							<fo:block font-family="Monotype Corsiva" font-size="11pt" margin-left="1cm" margin-top="0.5cm">
								<fo:inline font-weight="bold" text-decoration="underline">Финансиране: </fo:inline>
								<xsl:value-of select="funding"/>
							</fo:block>
							<!-- Optional scholarships -->
							<xsl:if test="scholarships">
								<fo:block font-family="Monotype Corsiva" font-size="11pt" margin-left="1cm" margin-top="0.5cm">
									<fo:inline font-family="Monotype Corsiva" font-weight="bold" text-decoration="underline">Стипендии:</fo:inline>
									<fo:block font-family="Monotype Corsiva">уебсайт: <xsl:value-of select="scholarships/website/@href"/>
									</fo:block>
								</fo:block>
							</xsl:if>
							<!-- Affiliate(optional) -->
							<xsl:if test="affiliate">
								<fo:block font-family="Monotype Corsiva" font-weight="bold" text-decoration="underline" margin-left="1cm" margin-top="0.5cm">Филиали:</fo:block>
								<xsl:for-each select="affiliate">
									<fo:block font-family="Monotype Corsiva" font-size="11pt" margin-left="1cm" margin-top="0.5cm">
										<fo:block margin-top="0.5cm" font-family="Monotype Corsiva" font-size="12pt" font-weight="bold" color="#6C3082" background-color="#D6CADD" text-align="center">
											<xsl:value-of select="title"/>
										</fo:block>
										<fo:block font-family="Monotype Corsiva" font-size="11pt" margin-left="1cm" margin-top="0.5cm">
											<fo:inline font-family="Monotype Corsiva" font-weight="bold">Адрес:</fo:inline>
											<fo:block font-family="Monotype Corsiva">
												<xsl:value-of select="address/city"/>, 
                                    <xsl:value-of select="address/street"/>
											</fo:block>
										</fo:block>
										<fo:block font-family="Monotype Corsiva" font-size="11pt" margin-left="1cm" margin-top="0.5cm">
											<fo:inline font-weight="bold">Контакти:</fo:inline>
											<fo:list-block>
												<!-- telephone -->
												<xsl:if test="contacts/telephone">
													<fo:list-item>
														<fo:list-item-label end-indent="label-end()">
															<fo:block>•</fo:block>
														</fo:list-item-label>
														<fo:list-item-body start-indent="body-start()">
															<fo:block font-family="Monotype Corsiva">телефон: <xsl:value-of select="contacts/telephone"/>
															</fo:block>
														</fo:list-item-body>
													</fo:list-item>
												</xsl:if>
												<!-- Email -->
												<xsl:if test="contacts/email">
													<fo:list-item>
														<fo:list-item-label end-indent="label-end()">
															<fo:block>•</fo:block>
														</fo:list-item-label>
														<fo:list-item-body start-indent="body-start()">
															<fo:block font-family="Monotype Corsiva">email: <xsl:value-of select="contacts/email"/>
															</fo:block>
														</fo:list-item-body>
													</fo:list-item>
												</xsl:if>
												<!-- website -->
												<fo:list-item>
													<fo:list-item-label end-indent="label-end()">
														<fo:block>•</fo:block>
													</fo:list-item-label>
													<fo:list-item-body start-indent="body-start()">
														<fo:block font-family="Monotype Corsiva">уебсайт: <xsl:value-of select="contacts/website/@href"/>
														</fo:block>
													</fo:list-item-body>
												</fo:list-item>
											</fo:list-block>
										</fo:block>
									</fo:block>
								</xsl:for-each>
							</xsl:if>
							<!-- Faculties -->
							<xsl:if test="faculty">
								<fo:block font-family="Monotype Corsiva" font-weight="bold" text-decoration="underline" margin-left="1cm" margin-top="0.5cm">Факултети:</fo:block>
								<xsl:for-each select="faculty">
									<fo:block font-family="Monotype Corsiva" font-size="11pt" margin-left="1cm" margin-top="0.5cm">
										<fo:block margin-top="0.5cm" font-family="Monotype Corsiva" font-size="12pt" font-weight="bold" color="#ffffff" background-color=" #8c4061" text-align="center">
											<xsl:value-of select="title"/>
										</fo:block>
										<fo:list-block>
											<!-- telephone -->
											<xsl:if test="contacts/telephone">
												<fo:list-item>
													<fo:list-item-label end-indent="label-end()">
														<fo:block>•</fo:block>
													</fo:list-item-label>
													<fo:list-item-body start-indent="body-start()">
														<fo:block font-family="Monotype Corsiva">телефон: <xsl:value-of select="contacts/telephone"/>
														</fo:block>
													</fo:list-item-body>
												</fo:list-item>
											</xsl:if>
											<xsl:if test="contacts/email">
												<fo:list-item>
													<fo:list-item-label end-indent="label-end()">
														<fo:block>•</fo:block>
													</fo:list-item-label>
													<fo:list-item-body start-indent="body-start()">
														<fo:block font-family="Monotype Corsiva">имейл: <xsl:value-of select="contacts/email"/>
														</fo:block>
													</fo:list-item-body>
												</fo:list-item>
											</xsl:if>
											<fo:list-item>
												<fo:list-item-label end-indent="label-end()">
													<fo:block>•</fo:block>
												</fo:list-item-label>
												<fo:list-item-body start-indent="body-start()">
													<fo:block font-family="Monotype Corsiva">уебсайт: <xsl:value-of select="contacts/website/@href"/>
													</fo:block>
												</fo:list-item-body>
											</fo:list-item>
										</fo:list-block>
										<fo:block font-family="Monotype Corsiva">
											<!--Адрес:-->
											<fo:list-block>
												<fo:list-item>
													<fo:list-item-label end-indent="label-end()">
														<fo:block>•</fo:block>
													</fo:list-item-label>
													<fo:list-item-body start-indent="body-start()">
														<fo:block font-family="Monotype Corsiva">град:
                                            		<xsl:value-of select="address/city"/>
														</fo:block>
													</fo:list-item-body>
												</fo:list-item>
												<fo:list-item>
													<fo:list-item-label end-indent="label-end()">
														<fo:block>•</fo:block>
													</fo:list-item-label>
													<fo:list-item-body start-indent="body-start()">
														<fo:block font-family="Monotype Corsiva">улица:
                                           			 <xsl:value-of select="address/street"/>
														</fo:block>
													</fo:list-item-body>
												</fo:list-item>
											</fo:list-block>
										</fo:block>
										<fo:block font-family="Monotype Corsiva">
											<!--Администрация:-->
											<fo:list-block>
												<fo:list-item>
													<fo:list-item-label end-indent="label-end()">
														<fo:block>•</fo:block>
													</fo:list-item-label>
													<fo:list-item-body start-indent="body-start()">
														<fo:block font-family="Monotype Corsiva">Учебен отдел:
                                            			<xsl:value-of select="administration/scientific_department"/>
														</fo:block>
													</fo:list-item-body>
												</fo:list-item>
												<fo:list-item>
													<fo:list-item-label end-indent="label-end()">
														<fo:block>•</fo:block>
													</fo:list-item-label>
													<fo:list-item-body start-indent="body-start()">
														<fo:block font-family="Monotype Corsiva">Отдел "Студенти":
                                            			<xsl:value-of select="administration/students_department"/>
														</fo:block>
													</fo:list-item-body>
												</fo:list-item>
											</fo:list-block>
										</fo:block>
										<fo:block font-family="Monotype Corsiva">
											<!--Ръководство:-->
											<fo:list-block>
												<fo:list-item>
													<fo:list-item-label end-indent="label-end()">
														<fo:block>•</fo:block>
													</fo:list-item-label>
													<fo:list-item-body start-indent="body-start()">
														<fo:block font-family="Monotype Corsiva">Декан:
                                            			<xsl:value-of select="governance/dean"/>
														</fo:block>
													</fo:list-item-body>
												</fo:list-item>
												<xsl:if test="governance/vice_dean">
													<fo:list-item>
														<fo:list-item-label end-indent="label-end()">
															<fo:block>•</fo:block>
														</fo:list-item-label>
														<fo:list-item-body start-indent="body-start()">
															<fo:block font-family="Monotype Corsiva">Заместни-декан:
											<xsl:value-of select="governance/vice_dean"/>
															</fo:block>
														</fo:list-item-body>
													</fo:list-item>
												</xsl:if>
											</fo:list-block>
										</fo:block>
										<fo:block font-family="Monotype Corsiva">
											<!--Дисциплини:-->
											<xsl:value-of select="disciplines"/>
										</fo:block>
										<xsl:if test="image">
											<fo:block margin-top="0.5cm">
												<fo:external-graphic src="{image/@src}" content-width="5cm"/>
											</fo:block>
										</xsl:if>
									</fo:block>
								</xsl:for-each>
							</xsl:if>
							<!-- Administration -->
							<fo:block font-family="Monotype Corsiva" font-size="11pt" margin-left="1cm" margin-top="0.5cm">
								<fo:inline font-family="Monotype Corsiva" font-weight="bold" text-decoration="underline">Администрация:</fo:inline>
								<xsl:if test="administration/students_department">
									<fo:block font-family="Monotype Corsiva">Отдел "Студенти": <xsl:value-of select="administration/students_department"/>
									</fo:block>
								</xsl:if>
								<fo:block font-family="Monotype Corsiva">Учебен отдел: <xsl:value-of select="administration/scientific_department"/>
								</fo:block>
								<xsl:if test="administration/secretariat">
									<fo:block font-family="Monotype Corsiva">Секретариат: <xsl:value-of select="administration/secretariat"/>
									</fo:block>
								</xsl:if>
								<xsl:if test="administration/management">
									<fo:block font-family="Monotype Corsiva">Мениджмънт: <xsl:value-of select="administration/management"/>
									</fo:block>
								</xsl:if>
							</fo:block>
							<!-- University governance -->
							<fo:block font-family="Monotype Corsiva" font-size="11pt" margin-left="1cm" margin-top="0.5cm">
								<fo:inline font-weight="bold" text-decoration="underline">Ректор: </fo:inline>
								<xsl:value-of select="universityGovernance/rector"/>
							</fo:block>
							<!-- Degree -->
							<fo:block font-family="Monotype Corsiva" font-size="11pt" margin-left="1cm" margin-top="0.5cm">
								<fo:inline font-weight="bold" text-decoration="underline">Образователна степен: </fo:inline>
								<xsl:value-of select="degree"/>
							</fo:block>
							<!-- Optional dormitory -->
							<xsl:if test="dormitory">
								<fo:block font-family="Monotype Corsiva" font-size="11pt" margin-left="1cm" margin-top="0.5cm">
									<fo:inline font-family="Monotype Corsiva" font-weight="bold" text-decoration="underline">Общежития:</fo:inline>
									<fo:block font-family="Monotype Corsiva">
                                        Контакти:
                                        <fo:list-block>
											<!-- telephone -->
											<xsl:if test="dormitory/contacts/telephone">
												<fo:list-item>
													<fo:list-item-label end-indent="label-end()">
														<fo:block>•</fo:block>
													</fo:list-item-label>
													<fo:list-item-body start-indent="body-start()">
														<fo:block font-family="Monotype Corsiva">телефон: <xsl:value-of select="dormitory/contacts/telephone"/>
														</fo:block>
													</fo:list-item-body>
												</fo:list-item>
											</xsl:if>
											<!-- website -->
											<fo:list-item>
												<fo:list-item-label end-indent="label-end()">
													<fo:block>•</fo:block>
												</fo:list-item-label>
												<fo:list-item-body start-indent="body-start()">
													<fo:block font-family="Monotype Corsiva">уебсайт: <xsl:value-of select="dormitory/contacts/website/@href"/>
													</fo:block>
												</fo:list-item-body>
											</fo:list-item>
										</fo:list-block>
									</fo:block>
								</fo:block>
							</xsl:if>
							<!-- Institutions -->
							<xsl:if test="institutions">
								<fo:block font-family="Monotype Corsiva" font-size="11pt" margin-left="1cm" margin-top="0.5cm">
									<fo:inline font-weight="bold" text-decoration="underline">Институти: </fo:inline>
									<xsl:value-of select="institutions"/>
								</fo:block>
							</xsl:if>
							<!-- Optional dormitory -->
							<!-- Departments -->
							<xsl:if test="departments">
								<fo:block font-family="Monotype Corsiva" font-weight="bold" text-decoration="underline" margin-left="1cm" margin-top="0.5cm">Департаменти:</fo:block>
								<xsl:for-each select="departments">
									<fo:block font-family="Monotype Corsiva" font-size="11pt" margin-left="1cm" margin-top="0.5cm">
										<xsl:value-of select="title"/>
										<fo:block font-family="Monotype Corsiva">уебсайт: <xsl:value-of select="contacts/website/@href"/>
										</fo:block>
										<fo:block font-family="Monotype Corsiva">
                                        Адрес: 
                                        <xsl:value-of select="address/city"/>, 
                                        <xsl:value-of select="address/street"/>
										</fo:block>
									</fo:block>
								</xsl:for-each>
							</xsl:if>
						</xsl:for-each>
					</xsl:for-each>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
</xsl:stylesheet>