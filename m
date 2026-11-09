Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F00606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=Jl48s9Xw;
	dkim=pass (1024-bit key) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=O4m8x5tB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFF5D10F028;
	Mon,  9 Nov 2026 05:20:45 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9CE510F028;
 Mon,  9 Nov 2026 05:20:33 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6A95Fb8H1813550; Mon, 9 Nov 2026 05:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=mTbaFy88CVse08yf+bpEhhbRjJvVYfdSeIFsvMEO5D8=; b=Jl4
 8s9Xw28DHfNPR8EBUJGci6/RAojMA65LMhu7Ay/H4wg/T9jwLdobw89NfMB6MFHX
 iHOpYtscLBc5cJGzk1aGrR+zq3EmGKJArCOFhdzMzA/KEEfVOzXbGiqL6XM4p7Ct
 Zu5/frHeuUxHOcxHMpXhCo17MIwVdQ5VdCVRWbXfdnUnDLJssZvex9RtYq+Z1sL2
 lELMZrbp4stz71FvVTRe8qlNKQR0Cr1B8znJrSLqjyhNuUH18qjxzjaFEWL0Yxqa
 jAOVKCecdyMWvKCXw4sF6ov4N2dq7KFSpOknVL9TF6GdHGzdrGrny8/vu3eJrz5F
 gK3Sy5ystZKWcVley9Q==
Received: from cwxp265cu010.outbound.protection.outlook.com
 (mail-ukwestazon11022128.outbound.protection.outlook.com [52.101.101.128])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hsvxx18k6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT
 key_exchange=secp256r1); Mon, 09 Nov 2026 05:20:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFLaa2APoO4i6JKWNMhSPXXswCmqSTXI4ThivNhaqjw5QJxAPCqirR3nkmpqTsO+TvYmO39g9g9ZlQo4q0gaXXE4TBHImzgbvuAuxG58uoSkNl5PjA+1v083n6qBE9LW7JHISc3QRMh/VR4n4a/Fr2EQ+HmC45pdyRkBd6TpTy5698UiEPt2D+1zBll9t5vh1b/nfvYRW3O7+dTd2MqX6HzIRrDc2c6kyWN9oZvQbid8o+Fsu7Bv5DsZQrRPc3jdYIQSwCC0Od5im5CmYYGelAxtj2+ZQWCXJbBqN2sbq5WCA0789hZXtb93NZN9G0i1qXrtE6NoS/D31/BtMa+S/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTbaFy88CVse08yf+bpEhhbRjJvVYfdSeIFsvMEO5D8=;
 b=Xy8sipP648DteoOLId9aBZa8ad3kf/3ou01fS5W8k4sFYboFrcdVrrUVRV0GavTM7z9x76y/O0rf6JZ8QrlKjB/+QMn12c9/9vE81w/UFznNi0JUSYBhSDlrKp6eBK0gMLY5ZzIvDKZyUEZB/rUnJKTqpxcXwADim1pt2xhy0SKJuSdXnT0prEpWtfBgQdA7ruMPZn2oPrFhfB6atLNop5yihpkKl4w1GwKGbn9W1uhYky8Z+QHT2YZry+DJNJM/QcMAiuxYtppTKzJUj2hRMNJQhy8HhyoEpcXVOShR+c6b+X/EpXjy44r5dfN4AsJFOv5uVfjxhNWSKPFArnwxpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTbaFy88CVse08yf+bpEhhbRjJvVYfdSeIFsvMEO5D8=;
 b=O4m8x5tBG6CKXjue4eOo7VIJiKfHLMHWQR09sAsAufJttIpOANvTSdbwsEcqawENHEGShkVk06ITm2LdZzjBNu74YM5bRedch8oBr1E7HwfK+eRhIFXJDGom5GEzM5LYMlML0VGfiOxVi5stZvaIUvvsGnv57CZueR8RH3ZwHMk=
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b5::14)
 by LOFP265MB469462.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:705::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 05:20:23 +0000
Received: from LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722]) by LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6b99:94f7:a14f:a722%4]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 05:20:23 +0000
From: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
To: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "airlied@gmail.com" <airlied@gmail.com>, Alessio Belle
 <Alessio.Belle@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "gye976@gmail.com" <gye976@gmail.com>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] drm/imagination: MMU defines updates and
 improvements
Thread-Topic: [PATCH v3 0/2] drm/imagination: MMU defines updates and
 improvements
Thread-Index: AQHdbE8RFSIAhRZLH0qwmhdNK1hEe7clO2mA
Date: Mon, 9 Nov 2026 05:20:23 +0000
Message-ID: <bdcf6f525665823c05d37833a93f17c32df9c3ea.camel@imgtec.com>
References: <20261104-b4-include-mmu-defines-only-in-mmu-code-v3-0-f9925419b8bc@imgtec.com>
In-Reply-To: <20261104-b4-include-mmu-defines-only-in-mmu-code-v3-0-f9925419b8bc@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOCP265MB8661:EE_|LOFP265MB469462:EE_
x-ms-office365-filtering-correlation-id: c631555b-0346-4f8b-eb27-08df3e21280b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|366016|1800799024|38070700021|56012099006|261021121427099003|261021123027099003|261022115727099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: zxtNPbkakh0KvJEQFS7Y7fiGaU54PO2nFpDTGiqiWJ3YmpIbC1G3DOOaZkknibEMt6Krw42soaeKkyfoVBVu38YGZTNp9UX9KPQV+66J33EpglV2qp58VWgX7PJb8XktaZZaqQUOxiVmz7bRbzY/ar73SbuXFTqV4r+iFSUZN2SQRBvRYzmcl9EPC/bUem4nASroULGAjhtrrg8K0oCroa3J7mheLMM/Lsqp10G9SX8hN9qDOVusCY+mHVFdWCBxNNM5Pt7sDZBejUdzcAnxUb6HX6oNC0fVfQLnVpXn01TWfn8SfK/MIgeUuU/3dAIFZY2U+ZcWX0Co+rFp1j89v+EaC5f6nGfsVumLLmThwcr797Ne7x/prfA2UNHmgRsSG7bbjOJXuOxd2yupoh9j1p08QrWWWI4EaPEYU/VxS5kEw0PG6gDTrZ1O9Iqj0Ub2yvKl0BOibpgvzjMU0NMrhqD8wcYQUfSOcq7+1eD7Iz635pCkALYfmapIGzWZKYDd6f6j29DBjkKcv8sClQfNJIiWUsB9NTX89fwahYI/Pk7edmDEh2+3hz7BWFR3nqznwWvYTQIlsJF4zNQbneIhx4vDFXm1QNLPTs7Bhvgz8iePfWd/HNSlWIScc+OR7icjGXJw84DqSGt2q/w1CMM5m3ZUGpCRGHSdbAawGTSqf9s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(366016)(1800799024)(38070700021)(56012099006)(261021121427099003)(261021123027099003)(261022115727099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzR4SjJIamNRd1ZORytDR0lJYTNRbUhqZFRMaU5zdUxqdk5rQll0UTZ3cXlS?=
 =?utf-8?B?cWVuWURhS2xiNDVXUHRUVFZ2TlRDQ0xnWjB2a0V3MlUzSGJtYzNtRm0zYitR?=
 =?utf-8?B?OUNITWN4MlU5RTBHZTd0Z2dhbi9NS3RTUDc5bUMyaTMwQTJtdVhFdVAwSTRP?=
 =?utf-8?B?U3BRYjJMekx5Q1Zsc3ZqUUtGTnpYOVpTOGp3S1QzdjlSWXZPMzA3d1V1dXB0?=
 =?utf-8?B?L0JNTXZ4VXJSMXNNZEM1UkFZNmtkaXBDeGJtTGdXZzB4aG1lNGpQWnFpZUsz?=
 =?utf-8?B?L1RucXcvMExvdlhLUVZnSFYrT05sdTFNeGpidFo2VzlmYVN4RXp4dHdpZnkw?=
 =?utf-8?B?WU81RGllMjUzOXI5dGlwb3RMc3lQT3Jnbk5OK1hoWHFXNFg1V0hHTGNSS2tj?=
 =?utf-8?B?NzVNVkZ3WGYxSS95L1hDbzZjQkhTaHlETmlaS29SL21PYm5IY0ZkL0JoK0Jz?=
 =?utf-8?B?NlZKeVVnQ1RnUEltdnozK1A3TWU1QnZrbDV4TFFjLzBTd2pxZlV0Q0QwNmtk?=
 =?utf-8?B?K0dGZ01wZmhoYXhQeHRrTFd5YnZOTCt6UHh0OWtSUTBZbXZoZURtaUZQNGRz?=
 =?utf-8?B?aHo2QkpsRDJ3ZnUrMHVGMExLM0ZtYUdmUXFBOWY3akVYVEliK1FBYWx6Wmd6?=
 =?utf-8?B?NWVmeHFFQ3hXSmR6QXZKSWlXVmQzeXBWNFp6V3ZnaS9zVUtaVjFncm5GMWdR?=
 =?utf-8?B?c0ZhVTNWcHowZEM0ejZtTElzMzNBYzZ0cWhlN1pkcC9ERUI2Zjh2blptdFls?=
 =?utf-8?B?dE1zSGlzS2c4dkppYmVQci9LMGNrVTFWVk5yT0ZxYVdNekNmTmloS3N3U0Nk?=
 =?utf-8?B?L2UxVXAzOC9Da0lyRVdwYktXL1gySldsVWVHb3JKTE1oR0NtdU5UamNxeHFo?=
 =?utf-8?B?OUI3VUhkRUVCalp2ek5tYUlaVWwvMVc3bEVQeDZJYmswQmd5bTFjNkVHSWRR?=
 =?utf-8?B?TFJhWHNIak9PdXNHSkd3SDVCRXJObDFRT1BNVXk5d0N3aFJqUll2Q21ZZlRv?=
 =?utf-8?B?MjJmYXVOOTlHUXBEQ0lPeGV0L2duNVZleThkN3o2UWF5Q0djZFkxR2lMems2?=
 =?utf-8?B?eXpQZ1NLQ0hGeUVzeGEyWUtmRXlWZ3FyRDZTbDg5SGZBcVh3eUpYSnEya0My?=
 =?utf-8?B?VUNmQzcyZkFHYXlsZWNuUVN4QjBJODMwZk53OVVMcUJsanRkckhRUWp3WGQ0?=
 =?utf-8?B?R3ZleUVDajB6ZWRuQUE2eitZSFdnKy9ZVlkwbXNIRkFEdGFoeGVja2FuN0Z3?=
 =?utf-8?B?bWdKMUJtZUg5QUxUdHoxSHc2b2JNVFlLT0FIMHR2ZHFhR0d4RHZXdTNPeTRn?=
 =?utf-8?B?WlRBRTRrTGVXUGFrejY3bWNQT1J0eENLdUU0VGR5Rk9uRVd5dGhxTG9FVVpG?=
 =?utf-8?B?VFE1MHpuM29XcktGaUVHWjFVbk9vckg5TTdPQTBVY0JQRmZTRStQZzF6QTNw?=
 =?utf-8?B?SndnZHp0M0VHTVQraG9QNUhMS2ZyT2h4Y0tLS2ZVUkRGbk5HY0lMRjBtL0ti?=
 =?utf-8?B?OVk1ODVLdDdOcU1uN1IyZVhxQ1JvNUFoYnFCQ1dBU1p3NHQzVTBrYzFKdVQ2?=
 =?utf-8?B?Wk9vdklBV1hOZitJTHBvbTNPWUV6RWtOdzZIblhmNnNUVkdHNTViZnN3MWx0?=
 =?utf-8?B?emdqSllXZ2ZieUR5KzI5TmpvekhIcTBEM2czRER6cXFVdWhTUmxkY0F1bmd3?=
 =?utf-8?B?ZS9RRzBrZWQ5MU9pQUtoN2NmcDNwU3BhQmhKRGc5UzBlRWhqQlJxK01VczZO?=
 =?utf-8?B?R2Nhd3pUd1hsV1Q0dmFobWdma3ovQU00N1hYbTluRERYOFhEWFljeEo1WHRX?=
 =?utf-8?B?bmI4R24vbWg2TXhoa0p5cXFOaHB6ZU5TMzF4eWNNOFZuckduMUVjeVJGSXFi?=
 =?utf-8?B?M3JXUnprTk1RVlNuQUpBK3BocG52aVUzbURMSmZaSkh3WEV2WFFYK1lrT2E3?=
 =?utf-8?B?N2ZxZXR3MXMwcjNtakgwUWhzV2VUM3I0RTk5QmpuYkIrSjlrZ3JqNWVQaDQy?=
 =?utf-8?B?SVI2Qk1nbzlCYXlTRGkwdEFoNnZ6cTFVazhyalg3V2N3OFBXYzY3VEdiaVI1?=
 =?utf-8?B?cmJ0bDdNN1YrVXV2cGNmZVhhYjhKc0FFSitkamNoYWEwb1lVMnVFOFZrejlk?=
 =?utf-8?B?QmdWM2hieXZQSXF1Smk0UExweDVDVXhGTFQ3S20yK3hHSjE2YmNkN1ZiOHZh?=
 =?utf-8?B?cTNEcW5EUGlabm5SNEJlaTdKZ3VEeVJkczFmeVYwNUxOTkVBSnkwb1ptM3R5?=
 =?utf-8?B?bzEyeDEvdXNuOW5CYVNITkF0Tys3SGpaMGNlN0FJMkRZTmo3cE8wbUsrUkx6?=
 =?utf-8?B?ak1MN3haeFVFLzZVc1RQN3dTdGhESStpVnc2UXlhM2p4TTR5dzBVVnZMSy9L?=
 =?utf-8?Q?A9oq42dEbKL5T0DvWIQgditlIS0RUtk3OCktgYC13bPvU?=
x-ms-exchange-antispam-messagedata-1: VEktCWEgkuKiefYKAH8Sh2rMEMi+4HOhCVg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <274D220D9F880A4A82D85ED1A601CEFC@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 2lE9l+AWz1ELgJiZtxVFiCAgHwxoxA3Ljlg4s5vvFJNcTOjwg4dJfakN4dDHQW046peHJYSw89+cM6+LhjA0CmzOi9oP0/cOtBx2EvdX2M1JldniQlQqzXJyeYVr0hYfjSd7Nunuuo35LQokodP1WH7dNHJ1i4gZ0b792oeo67DvnsjPjSYxgYxJbqMdpjhnjBsF48ZvMMGde9zNlw/xjMHA7KeGLjofzZs6xb0/BTp8tVnYke0HBLwLXW99hEWiQIDvWamrANSdV44EDpwD0fIaI+xGVCMLiGma+cy1Fbf0YWqzaK3CvLb/MWakkweIrCQr76y1XCqG9/wf/hQBIA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOCP265MB8661.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c631555b-0346-4f8b-eb27-08df3e21280b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2026 05:20:23.6495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8wKJJBB6vNlN46pYixBFoEqrQpF3oCxHp6uc7ja3/nVAuwxMHtYExtqbCrBomMY2WF+iAEosBttNQ6TH7ByTzKCwEGwo26Of2RfyXWo0wZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOFP265MB469462
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAyMCBTYWx0ZWRfX0zse2E9py9uO
 NrvH2FQON3l9Jm7gsoaHv1xpkPSyUq+1+tB+vJbUGKCRCzzQdC9Ift7Ph8rtD/pBrzfqoSqp1jw
 0Omv0riXPvti7v8FPKa3dbZGe1ndBIA=
X-Proofpoint-ORIG-GUID: 8u_DgkFvnw3zPIn501tkIFLILJ5sfq7K
X-Authority-Analysis: v=2.4 cv=H+JOUOYi c=1 sm=1 tr=0 ts=6af15819 cx=c_pps
 a=ws6per4dOmzu1InHRpGdgA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=bC-a23v3AAAA:8
 a=r_1tXGB3AAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=e5mUnYsNAAAA:8 a=rMAujXl39Y9VgzihsJkA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAyMCBTYWx0ZWRfXwTGzbjaiuX0Z
 IHcC+6zY1z4i1oc24V+waZCk8wcIQicFte35Gjzt/9HAH5KfRqAWqUfXltPl8UYhmF5WAgTLcU1
 JIeEGAGZdyQI0VCbMTQGlnBLK6kSDE+NUSK6IWMIi49ui1+zx5Iw0AiYMz62u/5f0H7ZktI1hUQ
 e92jN+Lnh5vXb2n8xLYWTN4ge3fM9T0klfUHqmEP26AzY3veTWhsIQyHvNHnLl5rzz8PQTdprBg
 HaH7LCCtDqXmCQUAwrYnS7+aEI8gi1A57Mycqgy8WuZXZ9pvJ7Ln+X0gHywpXYFaZ/EKwleDcRG
 psNV3bCR8gZryoN1ykusMcvFLU56WB9FSeObWfS8s1/HlIvVCqtu2fHHkO/B/YYXjl+DxA+btdg
 wXkQzDJNacaC/rQOUg8fctx9uGfX3ds3gk1Ok0Q2P2Qo1TgoJZ9r2eRC/NskzEAInla+tN9HbYW
 PpkF6NmDwQP/29JwejA==
X-Proofpoint-GUID: 8u_DgkFvnw3zPIn501tkIFLILJ5sfq7K
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTExLTA0IGF0IDEzOjI0ICswMjAwLCBBbGV4YW5kcnUgRGFkdSB3cm90ZToN
CkhpIERhZHUsDQo+IC0gUmVzdHJpY3QgdGhlIGluY2x1c2lvbiBvZiBNTVUgZGVmaW5lcyB0byBN
TVUgY29kZS4NCj4gLSBSZWZhY3RvciBNTVUgZGVmaW5lcyB0byB1c2Uga2VybmVsIHN0eWxlIGFu
ZCBhY2Nlc3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgRGFkdSA8YWxleGFuZHJ1
LmRhZHVAaW1ndGVjLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEJyYWplc2ggR3VwdGEgPGJyYWplc2gu
Z3VwdGFAaW1ndGVjLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEd5ZXlvdW5nIEJhZWsgPGd5ZTk3NkBn
bWFpbC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIEFkZGVkIFJPR1VFX01NVUNU
UkxfVkFERFJfW1BDfFBEfFBUXV9JTkRFWF9TSElGVCBkZWZpbmVzLg0KPiAtIFVwZGF0ZWQgdGhl
IGNvdmVyIGxldHRlciB3aXRoIHRoZSAiUmV2aWV3ZWQtYnkiIHRhZ3MuDQo+IC0gUmViYXNlZCBv
bnRvIGEgbW9yZSByZWNlbnQgZHJtLW1pc2MtbmV4dC4NCj4gLSBMaW5rIHRvIHYyOiBodHRwczov
L3BhdGNoLm1zZ2lkLmxpbmsvMjAyNjEwMTItYjQtaW5jbHVkZS1tbXUtZGVmaW5lcy1vbmx5LWlu
LW1tdS1jb2RlLXYyLTAtOGFlYzU4Nzc3YWI2QGltZ3RlYy5jb20NCj4gDQo+IENoYW5nZXMgaW4g
djI6DQo+IC0gVXBkYXRlIHRoZSBwdnJfcGFnZV90YWJsZV9sMl9lbnRyeV9yYXdfc2V0KCkgZGVz
Y3JpcHRpb24gdG8gYmV0dGVyIHJlZmxlY3QgdGhlIGdlbmVyYWwgY2hhbmdlcy4NCj4gLSBMaW5r
IHRvIHYxOiBodHRwczovL3BhdGNoLm1zZ2lkLmxpbmsvMjAyNjA5MzAtYjQtaW5jbHVkZS1tbXUt
ZGVmaW5lcy1vbmx5LWluLW1tdS1jb2RlLXYxLTAtMjkxZWFkZmRlMjNiQGltZ3RlYy5jb20NCj4g
DQo+IFRvOiBBbGVzc2lvIEJlbGxlIDxhbGVzc2lvLmJlbGxlQGltZ3RlYy5jb20+DQo+IFRvOiBM
dWlnaSBTYW50aXZldHRpIDxsdWlnaS5zYW50aXZldHRpQGltZ3RlYy5jb20+DQo+IFRvOiBNYWFy
dGVuIExhbmtob3JzdCA8bWFhcnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tPg0KPiBUbzog
TWF4aW1lIFJpcGFyZCA8bXJpcGFyZEBrZXJuZWwub3JnPg0KPiBUbzogVGhvbWFzIFppbW1lcm1h
bm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+DQo+IFRvOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAZ21h
aWwuY29tPg0KPiBUbzogU2ltb25hIFZldHRlciA8c2ltb25hQGZmd2xsLmNoPg0KPiBDYzogaW1h
Z2luYXRpb25AbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IA0KPiAt
LS0NCj4gQWxlc3NpbyBCZWxsZSAoMik6DQo+ICAgICAgIGRybS9pbWFnaW5hdGlvbjogU3dpdGNo
IHRvIGtlcm5lbC1zdHlsZSBNTVUgZGVmaW5lcyBhbmQgYWNjZXNzDQo+ICAgICAgIGRybS9pbWFn
aW5hdGlvbjogRG9uJ3QgaW5jbHVkZSBNTVUgZGVmaW5lcyBvdXRzaWRlIG9mIE1NVSBjb2RlDQo+
IA0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9tbXUuYyAgICAgICAgICAgIHwg
IDkxICsrKystLS0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9yb2d1ZV9t
bXVfZGVmcy5oIHwgMjQ0ICsrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL2dwdS9k
cm0vaW1hZ2luYXRpb24vcHZyX3ZtLmggICAgICAgICAgICAgfCAgIDIgLQ0KPiAgMyBmaWxlcyBj
aGFuZ2VkLCAxNTYgaW5zZXJ0aW9ucygrKSwgMTgxIGRlbGV0aW9ucygtKQ0KPiAtLS0NCkZvciB0
aGUgd2hvbGUgc2VyaWVzLA0KUmV2aWV3ZWQtYnk6IEJyYWplc2ggR3VwdGEgPGJyYWplc2guZ3Vw
dGFAaW1ndGVjLmNvbT4NCg0KVGhhbmtzLA0KQnJhamVzaA0KPiBiYXNlLWNvbW1pdDogNDlmNDBm
MTVkMjBmNWI0MDczZDUxN2RhN2VmYmNlYTA3OWYxYjllMw0KPiBjaGFuZ2UtaWQ6IDIwMjYwOTMw
LWI0LWluY2x1ZGUtbW11LWRlZmluZXMtb25seS1pbi1tbXUtY29kZS1hMTM5ODgwZjdmY2UNCj4g
DQo+IEJlc3QgcmVnYXJkcywNCj4gLS0gIA0KPiBBbGV4YW5kcnUgRGFkdSA8YWxleGFuZHJ1LmRh
ZHVAaW1ndGVjLmNvbT4NCj4gDQoNCg==
