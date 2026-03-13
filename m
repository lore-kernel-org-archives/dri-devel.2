Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D784106FD87
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73FDD10EAE9;
	Fri, 13 Mar 2026 06:27:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="lR3Gr+qN";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="iK47H/6e";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D90710EAE9
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 06:27:46 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D5sO7R2322817; Fri, 13 Mar 2026 06:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=FIIYkNZkD5VO4A4T9THmk/KpOQoXvMF9uI2VC3IvJEI=; b=lR3
 Gr+qNvam7VpNyhYBb1LyWz/7yE505j6NyGcjqI6w3BmV3HybLzj3bTX+0iwZQ7fO
 KEjCyv53EC8Ql0U1TBOdCGt5SskyVWdNKahT6sohMBltme2w4WQKn5VL1o3HBPN2
 9De95jYw2bg1bZd55q0bc/GIPiZxmI3x5yDD4idB/QjIcD0g8+hD+Xd+8K+4jxfb
 MaBqpUo45O/mRGrtKMOPxOwBVzs/2U9m99+kIYzZgbv940o/DRk2o4FMtgLi2Jwm
 aB7ZZmORlUkaVgCAdv4b4uDl6hEBtIGb2LVfHjmfG4SIBZ/Z7ib0Bbv7kfuMBt1w
 vqnYVzTY0O+ZKPquyIQ==
Received: from cwxp265cu009.outbound.protection.outlook.com
 (mail-ukwestazon11021124.outbound.protection.outlook.com [52.101.100.124])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4ctxygj70t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 06:27:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWdIkAxcL1Av3CLM2c+Mg9tkAIiWB4TkpdRZ7etKu4lSQ7Ybha6ZFQtPRIzRB/e37LdGuO4ExTq66nnVlHoHvMuqsTbrkDGMVRXTcjkPNE0xVQPpC/Eo8xqpCOr7HDfANeEz0GPmv7RGkx/XldB0+AOrj/zDfEoDHzOO3itaHtFpnmdzgBn2I+9J8Fe7FFztZUQ2gLFIOygndolM1lidIsn6qCdkL07ooELUYAA623PFHkG/LOVQmmd9q/e/fNmU7F3rrTiI0pUZwN54+lSCxN18FGmwZsg3+5RfNEU9cByuM0RbtmlL9qHV3CM7nbH9mZN6yGoWfr3lReF5JyllqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIIYkNZkD5VO4A4T9THmk/KpOQoXvMF9uI2VC3IvJEI=;
 b=FclC7GyFMXYNe9G7g/mIGpHKlI0I3OH6qwuGTPmME1aVhkZIx2fNmZ2z1zFABj4bHT5ox95x6KGDkE9XxvPuBpk+PQkt6+39sfgKcdYh2gzlgbHKKRM09QSlwZ4ycnBzLqBrtG/My0NJjSSeIECU3xUmHbFCdRCeAO2M5YutF4WIofaCmCdqi3JnKdhflwTYaE+YspJ8TZJyyfGaU6HHfxS2hdVmmOJyfdwAwjWiVKPTfpZ0dKfCpnciHUvEiEkgkTB/nSOMQA+SWhb7JIwg7ari4ZGsewlLGgj60P2zqcAjBBEHsjM80elqnwm++rXii+0sL4Vw0l7mQvQpHFz70w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIIYkNZkD5VO4A4T9THmk/KpOQoXvMF9uI2VC3IvJEI=;
 b=iK47H/6evpRrTnsfW7DhNkazzdT352Kk6LrcK2l+WcX27jw9OeUcG9d959k2qEYilUuWjKYQti7+ZfiNnUxZTqs/qTQSbqmB1lQSZ1WEzt2fs5o/2kuuLO/y44GKFoPBuwYWl2XWmcokc8o9/OK+CxqNqm54Ws0nmPOgsOYKA9o=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LO2P265MB3198.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 06:27:31 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%5]) with mapi id 15.20.9700.017; Fri, 13 Mar 2026
 06:27:31 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Matt Coster <Matt.Coster@imgtec.com>
CC: "tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
 Frank Binns <Frank.Binns@imgtec.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] drm/imagination: Skip 2nd thread DM association for
 non META Firmware
Thread-Topic: [PATCH 2/2] drm/imagination: Skip 2nd thread DM association for
 non META Firmware
Thread-Index: AQHcrJBCulrkl/IiakmBIY/yJ9X/17WpPs6AgALMy4A=
Date: Fri, 13 Mar 2026 06:27:31 +0000
Message-ID: <1a7532df2235f2b432f63b648b1a8c3ce0ecfc87.camel@imgtec.com>
References: <20260305-b4-staging-layout_mars_base-v1-0-09831fa17cef@imgtec.com>
 <20260305-b4-staging-layout_mars_base-v1-2-09831fa17cef@imgtec.com>
 <db2d7031-7106-4cb5-b036-765e185cfedd@imgtec.com>
In-Reply-To: <db2d7031-7106-4cb5-b036-765e185cfedd@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LO2P265MB3198:EE_
x-ms-office365-filtering-correlation-id: 6cd65389-95f2-40da-8874-08de80c99b4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: rr/Eqp2fk21ymaIJCIJK0WhtnfrCSFcP/ujW3bscWajR+ysBqlQtniofWZ3r1OggTLKXTr5XlLw6ymIuvNy2lV+ghZb2ipEKTDoTrb0CZJ7SYsBS4qvA7jxw1BecWKPMDQVsQufvROHxjw6uWWONXNK+ZErKF3KhfNz0u1zUydH86qBqdHYUAiREyP1KLXqBQ4Nekj3QnMDYEfcrT/TIln6JSHP/2JWoS6iSBfxHgRFTT13YQeHCSTGoKkUstLt9ggFHvaBz+A+3dSZxjClG7RTrrHoOFjsp3q4lohZUSVWNLq444qHyIw4HVa+1oLqPpyfHXD9boW/T7PFsLYde8u7s1S9M4V0UdqBxoTw5CCr1fJNZ2h4LvIkgsnHfJo6xLBt7TDVleg1jo7+DEu5MV95BBywZVbjN0c8cN4QkGkAsgDENMLjRwMl/vyCiINxsOZ2r9XJcku0U/YGdiURHN7fbX2oY0Mavs55mbr4JNlF64bWdX3c/Yt39jVCEYngam/ttZaMNaKN3Y9r61aYV27a14fvXE78eBkh7qOq9Y/83HTXQY3m4C9BiiaW5irO2JfPOSpz42SNsInN7xUrMfQABiimNR9sKGGkVxFbHsjLNC2FJuIF6psT5OTbQA9JhCCRcXG8V1YHXfHHK2l6Sb5WCZGQMPXrKcxI18G0sOj0ea2dwU+uz8E6TUqGkgezIPmwFaWCZ6SnBADSdRitda1s7++2sPGWnndzNpHw1zThUrABd6+JOWax6BnnTDnUfsriH4NXPXacshOfbNbLjbqw1JRAmS8m3MZw0J4ZG1Ew=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTQ1bUgwWEZONXRwdVVSU3FvL3RJT1pOelY3eGhJNlhFUG9VLzM4YmtxSDhT?=
 =?utf-8?B?NTFrdFBua05XdTZrdUxEbU8ydngrbEllSU5XWnBpZjFjeUhjb3RZZ1FkK00w?=
 =?utf-8?B?R2pMREpMRkh2dVNPdEdTdHd2UlIwMVgxSER6bnhQTStPei9VT09aM3M2cWor?=
 =?utf-8?B?NVpRTU9Bbjk5di92YjhZTXRjNVlwMmttci9yT0d1OWZnR2pTbURNZ1MvMEhy?=
 =?utf-8?B?NmdNait6MjJ1UjhIZ1k2KzVMZzBnOEh0dStxZVB5SXFzdVpGc2ZlQmlHN3Z1?=
 =?utf-8?B?RzU1WE5NaU5wOGxJRm1DeGVVNFVidE90MjJPVXJNVnZiUlBIV1NZcGlIc2or?=
 =?utf-8?B?OXpoN2svS3cwd0xIdnUwUzRERUg5aDlzZ3BlVmVIbUd3WkIyMHhZOGdVTmth?=
 =?utf-8?B?R1QvZHl5VEVYcnZIbXNFWW5VcHVOaWN1Qzk4OWtNZXNMVzd1WnJGTkdmb1ls?=
 =?utf-8?B?OU1jQy9oaC9jeittRmVsNFQ0Uk8yd1d0Rm1zNThvTXJXZE1hM2oyb3VOL0Fk?=
 =?utf-8?B?M2l6ejUwaW1FOGFscTlaVlR5S29MMVdaRmlVS2xEcXNSdUgzZmd6ZjRWdkxo?=
 =?utf-8?B?U3VxK3IyS25WR0t2anRuUGljWTlBbXBFRjNXTk0xR3dVdjRsNEROWDFpaENk?=
 =?utf-8?B?eWRxMlJyMTZZQnJQU01sNDVxZnpURXBnVFdwWGY2TUJ3Z1FGZ2Z2ZlJVSGNM?=
 =?utf-8?B?K1RTaGNyYWRDK01idXdLTzcyWWQ3VHpDUlJFL2ZjSGZZYXRrbW9veFYwaFpu?=
 =?utf-8?B?YnZoOEExclMvVS9oZm5xeHFUdDlNVUluQkJZVGltbmxIaXRMdUNvZW56RWJU?=
 =?utf-8?B?MkNGTkxGSHZQekE5aEZsMk5LNEI3VWt3Z1NJVUZPbmJnb1pjdHprMVB4U0hI?=
 =?utf-8?B?VFlvU3U5NVRyeC9ZWEZxR1FiVGcra3JXTG1EckdlbmJnKzgzRXZUYVVFbzVV?=
 =?utf-8?B?c2EvVVVaWFVDdlMyQWhvUHpJaWRlRWNCQTd0cmJldUFlT0JRdWcwMmlydWJ4?=
 =?utf-8?B?dVZqd21YenIwd2U5RnFTM1R3bmQ2Ty9tTko5Z1l0c1ZPQjRYYjl3dmdRaWd0?=
 =?utf-8?B?TkhFOHAzK3VRbEZjRTh4TWRVNG9xb3BlcGZDN3hjSVNUOUMwN2F4L2VxL1Rn?=
 =?utf-8?B?RUtUQkw1S1drV2ZBTEVSRXFsWGZORUc5MDhmWXpFanAyVVJyTVJwTVBaYjNy?=
 =?utf-8?B?QlF6b3dMSlhhaEsrWU0za3UwaHFLZUFEUzBYQ1BieVVPc21CeGVjNUZOalZj?=
 =?utf-8?B?NGlTTzR5MU1DQ2pjbU03WVpweFM3YzIvbjRJSEp1VW9xVnhoTzMrRjdORlN1?=
 =?utf-8?B?ZW84alF3bUxjWVlIVThJeHBwYUdHcmltbUMwdFR5TWpxeVJmVmVNVTdKVXU5?=
 =?utf-8?B?cjhrZjBqV2FzOGJwME9TSEtESDRteWtKQ3BYaUlURVdoMTM1UHl5MHFOQWFP?=
 =?utf-8?B?VnVCb3BPOGg3dHBnNjFaMjN2dmYwNURXdjlhNG84UjF3Zk5meXNZLzV1UzhD?=
 =?utf-8?B?MTh1bkJVNVhZNk9QWUtTWFRiSm11OEhpcWk1QnJiZGxrT0M1ZDRSa21sa2JO?=
 =?utf-8?B?dUwrYm92ekt5Y3ByZEpaTkNzWW4xekFvM1AyQUltVENtaVVkelM4RnRlK3gv?=
 =?utf-8?B?aDNKWDV0M2I0VUVMeVUwZFVEanp6dGdxa3JCRDNOb0Rucm90RERpTlQxMXVN?=
 =?utf-8?B?eU05bkNJVStoVDhUSlg5cUdEK1BuL0NMZG54dlBrVko4ZWgzWmFJd25OSmJN?=
 =?utf-8?B?b0VRaEI1SWFLWmhVQ2hoaXVFb25rclp1dkVqeVkyQmx0NnhoQlhYVzA1bW5E?=
 =?utf-8?B?NncvY0dzWm5qbWdxd1V3aVNUN3VWNThGcTE4UW53Ti9tSnRDcXV1T1NOK0o4?=
 =?utf-8?B?VytVSXl0VW1NNGVKQndkYXl1cG9OMHZHT09mc2xJQ0pEZDBaZnlrZHI3VGdz?=
 =?utf-8?B?S25hdXBHTVJwUGNJaGx4VGFXdGsyMjVKSVZCcVBOZG94dnBxdEVCVVkzaEFC?=
 =?utf-8?B?MWdKTFZzRXFpSzh3Y3RhSFBPN0N6THpvR0M3S0wrTjZPNUVTczBhR0xnZ0tr?=
 =?utf-8?B?ZzhjN0QvcUQ2MVRuckE2NW1lUW8veVo3Q21KQVJQMmpoZ3VGejhnc05PemhP?=
 =?utf-8?B?MjhNWm0zS2Yvck9YVTJ4QTBCWTZCR2RyVE9QYWRnQlpCSVJKcDFwNjVxVTlt?=
 =?utf-8?B?TGYrd1h1Z2JtNmFob1UyRGFNN295MkdoeFc5bXlsbGtVN0owZ3hKYlVrTVNm?=
 =?utf-8?B?clNGT0lpc0JyU0RUSlc1V25zZWZIZkRVWjhMWHhuUlNiWmlRY0h6Umh6S2V2?=
 =?utf-8?B?RE0ySVlJdlo4L3JyMEIvVjZMQkc2OXE5NzJPcU9jNnZzNDR5RnVjOUIrVFZX?=
 =?utf-8?Q?zOaDFHwS6dAckmg0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C81589FDA9E884488322D34F86ABD27B@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZwaXdg3osVBBq7wwNvsUbLC+d/9yJfqEsyvOVh0IOLzKqWQ43gCZ5BL1SuGxUidMLNVhGLmmc4NB3hUu3jLoZu5WY7M3palmf8hy+RkaXG+eAu4JeHK59jWm4m1Luw1v70v+90IEnzZOzOprb0jmkVvA/Wzn5Fe9UK1Tjet4o+6nK2B4nb8qOG4i1hKmeBTYi9Dv8pMG+E9o3ScxEZTF7amk6uJh7hR8+lBgi9VwkjMebRt/mV30do0nGQUd4XR7LlSqC+wl6qrS7q8MnBrxdu0Ua6j537COe3xGhQwq458Rs4LIMAumQD2RG598rXsf5Kxavi2Qjvx/ba0bnsI9FA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd65389-95f2-40da-8874-08de80c99b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 06:27:31.5243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0iJ1Q4getP4kjSlLbrGbfAlOhI9KE6PBDV4+agiIxUF+s7hoojqxHqQyACbjH/ZV93Zz6wXCaN/yjftfxfzFn9yQiM3vOra2HF8Nfwf1dIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3198
X-Proofpoint-ORIG-GUID: 9TfYGqX0WKGCLrKElr66wt2LQ1GLIRK1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA0OSBTYWx0ZWRfX2h4ySVbJqDuR
 5CjYwnFAKcxkmll70008hlLu2PVPR+NgEMVrbkp2Bj5Jt97vKy7Ai4B7GOEo/6pJ3gbqRSfHrKL
 8u1K8MLGolNO08hWynJihiRkU3oyWMuoRKEVH1NxGjb4rIQmfCNxLDVN9Dbtp2zKpenO8QAKRWU
 swUfvfKfHWFJbDUH0lzlYJOGzX84P/9Zic4jNUzf2kM+1xIsUqYn7zvh6DVQc4ppcB0OodAOx3t
 gzAZ+fGNgDDz0/E56s40K3DSKAk+kCK/vRD2dP+dS1MvdNHGw647rU+IyX/oIHSnZQVxcxArVLK
 K4KU+1EF/j8qAxNxYKmbXcpCNfv8NUm8RKxlEpwn3XpnQRFwE8t3L47fU+78Jsbal5XiDms5JdF
 9S54wqBN7b2zpxZiMMyKPj/pGwLOeSuiwJ5PmlLVLFNVlbnYCb/+Q0yRHmaOOgvAM6mL4cqOKHT
 Y6DIygGjgku7b3Ros4w==
X-Proofpoint-GUID: 9TfYGqX0WKGCLrKElr66wt2LQ1GLIRK1
X-Authority-Analysis: v=2.4 cv=NevrFmD4 c=1 sm=1 tr=0 ts=69b3ae56 cx=c_pps
 a=mv9VF2DNUkA1Ha8aThKgsA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=ct4mjZn-H4WNQMw-4i0A:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

T24gV2VkLCAyMDI2LTAzLTExIGF0IDExOjQxICswMDAwLCBNYXR0IENvc3RlciB3cm90ZToNCj4g
T24gMDUvMDMvMjAyNiAxMTowNiwgQnJhamVzaCBHdXB0YSB3cm90ZToNCj4gPiBPbmx5IGEgTUVU
QSBmaXJtd2FyZSBjYW4gaGF2ZSB0d28gdGhyZWFkcy4NCj4gDQo+IElmIHRoaXMgaXMgaW52YWxp
ZCBiZWhhdmlvdXIgb24gbm9uLU1FVEEgZmlyd21hcmUgcHJvY2Vzc29ycywgc2hvdWxkDQo+IHRo
aXMgYmUgY29uc2lkZXJlZCBhIGZpeCAoYW5kIGdhaW4gYSBGaXhlczogdGFnKT8gSSBndWVzcyB0
ZWNobmljYWxseSBpdA0KPiBkb2Vzbid0IGZpeCB0aGUgY29tbWl0IHRoYXQgYWRkZWQgdGhlc2Ug
bGluZXNbMV0gc2luY2UgdGhhdCB3YXMgb25seQ0KPiBhZGRpbmcgc3VwcG9ydCBmb3IgTUVUQS4g
V291bGQgaXQgYmUgZml4aW5nIHRoZSBmb2xsb3cgdXAgdG8gYWRkIE1JUFMNCj4gc3VwcG9ydFsy
XT8gSSdtIG5vdCBzdXJlLiBNYXliZSBpdCBkb2Vzbid0IGV2ZW4gbmVlZCBhIEZpeGVzOiB0YWcu
DQo+IA0KVGhvc2Ugb3BlcmF0aW9ucyBhcmUgbm8tb3AgZm9yIG5vbi1NRVRBIGZpcm13YXJlLiBT
byBhbiBpbXByb3ZlbWVudCBhbmQgbm90DQpmaXhpbmcuDQpDaGFuZ2UgaXMgYXBwbGljYWJsZSBm
b3IgYW55IGZpcm13YXJlIHdoaWNoIGhhcyBvbmUgdGhyZWFkIGluY2x1ZGluZyBNSVBTLiBBbmQN
Cm5vIGFkZGl0aW9uYWwgZml4ZXMgZm9yIE1JUFMuDQoNCkEgdmVyc2lvbiAyIHdpbGwgYmUgZ2Vu
ZXJhdGVkIGFzIHBlciBwYXRjaCAxIHVwZGF0ZS4NCg0KLS0NCkJyYWplc2ggR3VwdGENCkU6IGJy
YWplc2guZ3VwdGFAaW1ndGVjLmNvbQ0KPiANCg==
