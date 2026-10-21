Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDD4606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=Ga7LDSmS;
	dkim=pass (1024-bit key, unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=LKhxSlt6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD05C10E899;
	Wed, 21 Oct 2026 10:02:52 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C43DB10E899;
 Wed, 21 Oct 2026 10:02:40 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5jOBP3374900; Wed, 21 Oct 2026 11:02:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=OmxIhaZAQJOMLgL7e6cf2U4xV8Z23zJLh4dc67Neqlw=; b=Ga7
 LDSmSoYGCB4EiGiTU4IBzH11p8Q7VsPNnb90zLdVeG1v9tr+vT8jY457XIxKOSOQ
 Xoj2tgwGzaknY2j3IJjyggITRobcsco8LQAgbqwkm38pjbsmlmwG4xQY/kh0ZsKx
 pJFNCB4avtz3kuUMpc21KoaR6UGHISFfYgrdT79KFuxmY94/Zvwhrk5CrNYUU914
 L/wFckJ0uAucK9QvOjBmQ0Pf1SJCeXniRyCmgxWBq4XNMwv2H+pEaZA8bNKUch/w
 sTR9ZfXB4ESuc/kZp8/RQYqURonp/kxdtgSG1xizdUo2Ar9hK8nRlm/r5hpT2rLu
 4ddIxLPLG/4YsxcDEGQ==
Received: from lo0p265cu003.outbound.protection.outlook.com
 (mail-uksouthazon11022081.outbound.protection.outlook.com [52.101.96.81])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hdvkd1723-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2026 11:02:28 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PH5VPowQ0Ns9wwNti25fz8jBZnS7YW9jEbsYop1lfO6EwEw7fi6M+5gvEHmkYhEBZtWmNS7qWxJJVhqz5OTNrezOfG6n5PjmWPKsZL3rx2TdU/c0dUkHdQRRX877xXmFvm/LWTqBcJnRAy0J0OAckxU2eNrxT57duzshw4m1meqvpgdMfD8ybM9Wy4Y30JZ0PezVe0xN/13YSJcEwzonq4RAn73dssqoQkim5aNzzXPC+eSOraA7Jnm0x4ubVq+jzaZfMKVrVr0m8v99pACZR9LPnATipabtU5CvSCtgHKzUxKJ4mZW9zhip+AmJ+Pzck3L9zmUVXu3e3XLwiTILNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmxIhaZAQJOMLgL7e6cf2U4xV8Z23zJLh4dc67Neqlw=;
 b=LOVmVrAO1sfz9BcM2Wc2TPPMtnlP85ZTPNoAq1UnxJ+XcOQgwxSDn6zHc7dJw0yxNmsWt+RozxFfbDuqMwjFw7RqHvwlO5IClhSWVtHTm6MB/kCLaNtgKPhhW9dvcwEyLp3PrBpTp8gJ1iCx3RyHOEbto1jB5M0APeFXgkj6NwFBEj1YbDaM71AvX7/KpEC3Yq4+xrXiYsu+AdTcFBz6/TEUBLPEoldLIeq6F5BKCPQLvfE5r0mThaplgGH/B21ahRhamQXPP/qFmEwgEGxb4EZsTL/0ioO/xF+icgvfYQEW55wXuCPsssHWV01HAVoV3ppDuCb/1rhN7HTfJX2hNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmxIhaZAQJOMLgL7e6cf2U4xV8Z23zJLh4dc67Neqlw=;
 b=LKhxSlt6djzLTStbKnRhWFdNVT0fmPOjpxCTeYCVWSx3laaDysdCVgnj8BN3hCXlvv+UAtL4TO5z6Dwpwx+0iX1/2hzO+jyUvSF3Z+dcVS1TxpCDBj3vZdwWinJQKcHltwX7vvONdqUQ9E11CJd3z8daaZvc4+dMjLuwadbrh/s=
Received: from CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d2::14)
 by LOYP265MB2368.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 10:02:25 +0000
Received: from CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
 ([fe80::9d56:bc31:7b9f:2f7b]) by CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
 ([fe80::9d56:bc31:7b9f:2f7b%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 10:02:25 +0000
From: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "rosenp@gmail.com" <rosenp@gmail.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
 Alessio Belle <Alessio.Belle@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/imagination: simplify pvr_fw_trace_seq_data
Thread-Topic: [PATCH v2] drm/imagination: simplify pvr_fw_trace_seq_data
Thread-Index: AQHdVTM1dvnqeCL9a0eevpWAwVa0sLcH3CMA
Date: Wed, 21 Oct 2026 10:02:25 +0000
Message-ID: <9aeac8004ff8b360b7ab8261ca2d849ac25b53aa.camel@imgtec.com>
References: <20261005194127.151181-1-rosenp@gmail.com>
In-Reply-To: <20261005194127.151181-1-rosenp@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB2913:EE_|LOYP265MB2368:EE_
x-ms-office365-filtering-correlation-id: f5a5ce71-fb03-4040-8f19-08df2f5a6835
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|18002099003|10067099003|22082099003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info: tZnlrTVbzHVL1CJYv+ep9vo6xLG5zllBs8BSlYFMH/iOVhoQws6CqLQXp2hxcD/MxvLFSEmMPKntwafbAAj43k64bmk3BMpxygrYiCRrLhPGDgTcVpKPSgBEvcDFSk8D4x+IE00OJCfNXXXeNdTPkgfrgR+m3VWW4kj3LksP8idJ7cHgqwabTUpjRsTbnH97DsQiirTRpbjUFgH5KyNsQscC4OUPqmrGcXa49J4Vz0i8878mFRbJXw0RJHZOTfDO4IhbJ3e/Gz+RkqZ1LldsE8gC041T+NWjERC4Fe/3vNisULio8ODO7s9/UJb+mp9ySN2R58xyBn3DO9W+CmUJOxWtZUPhf/rNBNq1OyTbKNg3QCJEYyfM63+iHPIOhMERJRLu9sMakCoGsHe2+2A11JyK0oDfs5j3OOwVGySW7t2e5u+PyxLLbNaFJPvvyhRIM+OW4cGUfKQHWV6ANFQ8NfD+YfMDliwgmFVf+pA7gYjKbDCO68Xm6F7gglSI0VeTT4JRprBEOdwTPrkgg8NUqEotnX9u+ife7ku0WIiGk9kDO9WfRXRPAQtW9SsPZyxLtyvqQsueX04dnuVdcU1zDdypvlRKylVFs2B+31IDc3sc/9N4FrIx+TJOD/hLfR0biJ7A2V71nsmfoorK1bqWq1oLZ2Bd94o30FjJxzrLvFnBAM2iVJM+aGy7OcSvk4Ay5H/fzgClWDSuE58Bs3nY1j2OHHb4zLhzEOhTfONLX7k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(18002099003)(10067099003)(22082099003)(261009223027099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTJvdFRVQmNaV1o3WEtubEZndmcwWG4zNU1ONkdjZHkzaFZla09vb3RLS1Qw?=
 =?utf-8?B?Y1NMd1NiZEQyTFN0L0pNWFpsY3o1VSsrQzNFY0E2NHZuM2FlZUFsbGxCeXlw?=
 =?utf-8?B?eWhYSFhKUWJJOUdvQlRsaXpLaGZYdkFsMHFUb2RzNWxJREc4SDRyU1ZZY05u?=
 =?utf-8?B?NytXR1M5c1lid2lWUU93K3lBL1VhaTM1bm1CK2I2Yk8zYm9UY203NEZVRGtE?=
 =?utf-8?B?SUtBQmpUei9jZk9QcmI2TmV6alMrU1NpUG9RblU2aFo1Z0tWNGpORG1UdlB1?=
 =?utf-8?B?NUswWG8ydnB2K25ZU1FZcERwMGVwK1ZoMFVhZ01oNStwMGNzaVpSNFF4YmhQ?=
 =?utf-8?B?MnA5cWsxOW5DaUJBVmVaT3MySTVkeENvcUl3RmJGRFVBSTltQUFIYmpEK2p3?=
 =?utf-8?B?bnpWck9EVXYwdDdYb25VeWI0UmtBRVdkZlh4bmV6WllUR1plQnFHRzk1SS9K?=
 =?utf-8?B?YytuVDZoQ3BMWnNXcmFHSVhCSmhQWkNDdjBDS052WWp1cjZMbDNVejJZWDFo?=
 =?utf-8?B?ZkJWclNwc09kQTlyZ01tSU5FdU9YaUJXcmI5TkpKWVhFQjhzTkdJY0V4aHF3?=
 =?utf-8?B?TVl5THpuM2xTbHRWOENaVkpZRWpiN2xDS0hJZ2FTcGEvNWpXNlY0UGdKMHZk?=
 =?utf-8?B?cHVSazMwK3haOFh6d05iaGZMWmxUWUtjTTB3N0tJckVtbVJGZ244Mnh5REZa?=
 =?utf-8?B?M2NKRzZKa2crNk1sRTdWb0RBb01SdkNzancyUFRIREhnbGdUWjh4KzFoSWd0?=
 =?utf-8?B?MzJTUHNjc2U2Z1BNanMxUVh5bEI2bzFoY1E2cmlqc0Q0ajVwT256MUNFTWZi?=
 =?utf-8?B?bEFBVTZ2Y3VqY2dOQlJlamZxK0NuRlBzdGdiRXd2TC9xYUNsZkVSdHlFWG1W?=
 =?utf-8?B?RnFkemFlemlFOWtCRVhkK0NodG45N1I0dGhrWE9GRUFWK05nNUdPUG9nZHlo?=
 =?utf-8?B?T0J3b0licWlZNFhrajlvMFYvWjducE1hemdCMi9mTDBGeVQvTWY4MHpVVzZZ?=
 =?utf-8?B?eU5ZS09UVUh2QWdhNDZ1d2I0TmNqdWdXSjlQZWJhUGtvZmlHY2lHYkZMMUhM?=
 =?utf-8?B?ZllDVVUvWm9pblROakg4V2hjeXUvSVVNNGQ2dTF2RjZoWWhRb2R0MnFrZ3pF?=
 =?utf-8?B?VlJVUkZ2VEdwb09PTENkQm5tblJjVmlPbk9NaVN5OHVmUzFzQVRlL0NjMUFQ?=
 =?utf-8?B?c3l0N0I4R0cvU2lEOE91VERYazlrQXVKK1UzZ3ZGbWNjcWR5YlJZVjdYcXZK?=
 =?utf-8?B?ZzhEQk1yVUFUN2JSOFRYcTFVV012T2NXNmVxT0t4S1dxb0REYzBzN2Vabjg5?=
 =?utf-8?B?RHdNMThvWDVuUld3RS9tazNIMGRPT1NicFJZY2RDYy9zU1JhSE1GNktTU3JC?=
 =?utf-8?B?d3g1R3hpYmVoUXo3NTNMaUR6alZtNmg1TlpNNCtYdWYrWDNabWN6WE93ZWdY?=
 =?utf-8?B?c2hVSnN1dHlKMG1qZ09hOVdCOFdVemRJTDZLNkcvdGtDQzk1RVp0NTFLTjZ6?=
 =?utf-8?B?MEpQVm9JL25sZ1h2SEoxbE1hbGxaV2lLMlI2VHkvRkg2Rkl1Rnp2cmdLUnVt?=
 =?utf-8?B?TjIzQjRqVTVYM1NXbnZMaG13blpzWTgvV2xuS1BUdncrN3N3WWlrczRSVlRV?=
 =?utf-8?B?eTVtbDZZL3IwVk5SNjROb2NNbCtHcWNxbEhLMjc5cTl2SUVNZWtwd2NvZUl2?=
 =?utf-8?B?N2pFMnIzWkZiR3F5RkN4TVBlNCtjaFgwUjg0cTdHUHlQdXZiODBQNDNnRHdv?=
 =?utf-8?B?Wm1RUjBlMW9pa2ZSWVFPZWtxN2g5eUhiQmFkNnZ3aUNHMjFXa1N4a2Vvbkly?=
 =?utf-8?B?VGx0QzR4M2MwdUhxdGlhTDREL2lFU1dhQVpPVHE4WEs2MXB1ZmpUSHZUdW8w?=
 =?utf-8?B?YUNoWnB5VU9WbUhBUnQvL0ZVMVhrSUJUNWNyb3crMm40U3AvUCtBQmEwZHQw?=
 =?utf-8?B?YkVvOWo5cXZvR21GQ09CY3JjbzBXbjV3ckViMEhUQk9rcmdIWGtFaG5sUTBS?=
 =?utf-8?B?SFZBd3ROeHRNNXBNbXg1Y3J1OWpER0ovWEJhMXRQWmxhU29zYjQxeDU4VCs4?=
 =?utf-8?B?UWlqaTFzb2xONVRzYXM3RUp0dXFEZmdYYkNIbHRnY3NYZ3FIRDlHSlgrK0RT?=
 =?utf-8?B?amJMNENIV2pIZCtwZFNsb0ZRM01KV3J6M2gzam5VUmZ0K0ovK1VRY1g1aDFC?=
 =?utf-8?B?Sm01bXhxRTJHTHFzTkpXMGdYeXRodHNnOXlvUG1KdnVneEhKcEhOMFJIZVcx?=
 =?utf-8?B?L0lVWUtEVkJKU0xNZTlFb1pUQ0RIZVRyTklPUVF1d1QxTUlyMHhnNUdaZXJR?=
 =?utf-8?B?ZUMyNG9EcTFjWUQ0RXlaWHk0TGgxaUNSeXRLSUxWSnIyblNsMk9sTUJNQ0h2?=
 =?utf-8?Q?grKpt6tZgdPjr1UY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC3AFFA757F1E341BFC6C3247E117ADF@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yo5kl53HtBScWZoiN+pBw+6IyLIja60QAetokq2OkjoAgMSxYUM/woBbSRY2Fq1X3fbcW9DaWITQ1dYY9EQXQ4+k3u+u2t51uYYV5MR/6h/zyosRlgl8SDkzgjuYS5bCyYRJm8X4xP+ZiyhOhco8yxtghenajfrlehDtM0YtwfmfZsBQ19H14/lx9RxRRwE06kxZF94mkzTaNesxxr0nWGpabqKxY7dPazWCbR8U4zbvtZBA23u666IoiNnAGQibRZCz3/flKnnF34lV7pICmm+wxJAcVNEBWjVJmmoKUeqXBoCKOVWHb/nn0UejGSGkBWarKU2XZOHAL4LeU7dJHA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a5ce71-fb03-4040-8f19-08df2f5a6835
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 10:02:25.1714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WnE8b6kz28I/xWt02RfW3CDd7rBdNxkav0derAVMVtPQiKhrFCq7G+tt1WbDBTcJBwzsVQvEs9EQwXLkPVoRuVEOs+dApGFwINWE874pgec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2368
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzOSBTYWx0ZWRfX8EfAlQvPLTfy
 aUjtD/Zau0g5hjqebZbS2l7pwovFd8OTPuYMQAKFF8rrzRHJI0/soC0yf6gKGmD2gAMBbwrr3gN
 2Pmaw0F/MWL19lOLQXxRPBOLYL+nnx8=
X-Authority-Analysis: v=2.4 cv=arUnmiZV c=1 sm=1 tr=0 ts=6ad88db4 cx=c_pps
 a=qNN8Pqk4kVBllGMyGt3nCw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=pGLkceISAAAA:8
 a=r_1tXGB3AAAA:8 a=6nWy4qqdIOXBjM6_DugA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzOSBTYWx0ZWRfX8eAAenxKpOzG
 0MqLlVRjp8e7nWojhd80u8BO2TVPGJjEhtZhITB9nguvaJj8ij84DASAqrg06ivzx0WBALNSDsq
 tLvH3HHA19cjPuFfpu/9XUhmGinshL/FI/gmwm5PUiZapyJItveUzBuoKYyca8XJLpXjYcw79dh
 NsAw4cHou36l0TeymVmCRqIK0KTVfaojiBGkmqV/Fo8x0dZ0Y/KSF4uILn84ok9swiQiMjGgPsm
 hQKgpQlSOZY2KmdJZf582aPNxUI7z4tfXPrdyky+u3R6pMqT2Qha0aAt5lUQSNJOLuadnSj52Ol
 fBpvupiQOpLcOE/uk3zL4c25ECReFvK71LmnVQyMCUshTmjb5NzS8Tvw82dmoNIyt45saemuTD7
 nyK4l0mYHcpRBiAHZqPsFZFW8X9WznYg0loegSSvtbVrD8Fv5A0hF4SSuyEYWmCydlCIGQ5Z86h
 r12HSj4cgaCrGeffezA==
X-Proofpoint-ORIG-GUID: 1EUhGK18fx3r-0CUNfzZ3mcg7Y30sGxx
X-Proofpoint-GUID: 1EUhGK18fx3r-0CUNfzZ3mcg7Y30sGxx
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

SGkgUm9zZW4sDQoNCk9uIE1vbiwgMjAyNi0xMC0wNSBhdCAxMjo0MSAtMDcwMCwgUm9zZW4gUGVu
ZXYgd3JvdGU6DQo+IFRoZSB0cmFjZSBidWZmZXIgY29weSBhbHdheXMgaGFzDQo+IFJPR1VFX0ZX
X1RSQUNFX0JVRl9ERUZBVUxUX1NJWkVfSU5fRFdPUkRTDQo+IGVudHJpZXMsIHNvIGVtYmVkIGl0
IGluIHN0cnVjdCBwdnJfZndfdHJhY2Vfc2VxX2RhdGEgYXMgYSBmaXhlZC1zaXplDQo+IGFycmF5
IGluc3RlYWQgb2YgYWxsb2NhdGluZyBpdCBzZXBhcmF0ZWx5LiBUaGlzIHJlbW92ZXMgb25lDQo+
IGFsbG9jYXRpb24NCj4gYW5kIGl0cyBlcnJvciBoYW5kbGluZywgYW5kIGxldHMgRk9SVElGWV9T
T1VSQ0UgYW5kIFVCU0FOX0JPVU5EUyBzZWUNCj4gdGhlDQo+IHJlYWwgc2l6ZSBvZiB0aGUgYnVm
ZmVyLg0KPiANCj4gQXQgYWJvdXQgNDhLQiwgdGhlIHN0cnVjdCBuZWVkcyBhbiBvcmRlci00IHBh
Z2UgYWxsb2NhdGlvbiwgd2hpY2ggY2FuDQo+IGZhaWwgdW5kZXIgbWVtb3J5IGZyYWdtZW50YXRp
b24uIEFsbG9jYXRlIGl0IHdpdGgga3Z6YWxsb2Nfb2JqKCkgc28NCj4gaXQNCj4gZmFsbHMgYmFj
ayB0byB2bWFsbG9jIGluIHRoYXQgY2FzZSwgYW5kIGZyZWUgaXQgd2l0aCBrdmZyZWUoKS4NCj4g
DQo+IEFzc2lzdGVkLWJ5OiBMTE0NCj4gU2lnbmVkLW9mZi1ieTogUm9zZW4gUGVuZXYgPHJvc2Vu
cEBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBBbGV4YW5kcnUgRGFkdSA8YWxleGFuZHJ1LmRh
ZHVAaW1ndGVjLmNvbT4NCg0KVGhhbmtzLA0KQWxleGFuZHJ1IERhZHUNCj4gLS0tDQo+IMKgdjI6
IHVzZSBrdnphbGxvY19vYmooKQ0KPiDCoGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJf
ZndfdHJhY2UuYyB8IDI1ICsrKysrKy0tLS0tLS0tLS0tLS0tDQo+IC0tDQo+IMKgMSBmaWxlIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9md190cmFjZS5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9md190cmFjZS5jDQo+IGluZGV4IDZmZTQ3OGY2NGYw
Mi4uMjdiYmM2MjExNGIxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRp
b24vcHZyX2Z3X3RyYWNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2
cl9md190cmFjZS5jDQo+IEBAIC0yNDAsOSArMjQwLDYgQEAgdXBkYXRlX2xvZ3R5cGUoc3RydWN0
IHB2cl9kZXZpY2UgKnB2cl9kZXYsIHUzMg0KPiBncm91cF9tYXNrKQ0KPiDCoH0NCj4gwqANCj4g
wqBzdHJ1Y3QgcHZyX2Z3X3RyYWNlX3NlcV9kYXRhIHsNCj4gLQkvKiogQGJ1ZmZlcjogUG9pbnRl
ciB0byBjb3B5IG9mIHRyYWNlIGRhdGEuICovDQo+IC0JdTMyICpidWZmZXI7DQo+IC0NCj4gwqAJ
LyoqIEBzdGFydF9vZmZzZXQ6IFN0YXJ0aW5nIG9mZnNldCBpbiB0cmFjZSBkYXRhLCBhcw0KPiBy
ZXBvcnRlZCBieSBGVy4gKi8NCj4gwqAJdTMyIHN0YXJ0X29mZnNldDsNCj4gwqANCj4gQEAgLTI1
MSw2ICsyNDgsOSBAQCBzdHJ1Y3QgcHZyX2Z3X3RyYWNlX3NlcV9kYXRhIHsNCj4gwqANCj4gwqAJ
LyoqIEBhc3NlcnRfYnVmOiBUcmFjZSBhc3NlcnQgYnVmZmVyLCBhcyByZXBvcnRlZCBieSBGVy4g
Ki8NCj4gwqAJc3RydWN0IHJvZ3VlX2Z3aWZfZmlsZV9pbmZvX2J1ZiBhc3NlcnRfYnVmOw0KPiAr
DQo+ICsJLyoqIEBidWZmZXI6IENvcHkgb2YgdHJhY2UgZGF0YS4gKi8NCj4gKwl1MzIgYnVmZmVy
W1JPR1VFX0ZXX1RSQUNFX0JVRl9ERUZBVUxUX1NJWkVfSU5fRFdPUkRTXTsNCj4gwqB9Ow0KPiDC
oA0KPiDCoHN0YXRpYyB1MzIgZmluZF9zZmlkKHUzMiBpZCkNCj4gQEAgLTQ1NCwxNyArNDU0LDEw
IEBAIHN0YXRpYyBpbnQgZndfdHJhY2Vfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPiBzdHJ1
Y3QgZmlsZSAqZmlsZSkNCj4gwqAJc3RydWN0IHB2cl9md190cmFjZV9zZXFfZGF0YSAqdHJhY2Vf
c2VxX2RhdGE7DQo+IMKgCWludCBlcnI7DQo+IMKgDQo+IC0JdHJhY2Vfc2VxX2RhdGEgPSBremFs
bG9jX29iaigqdHJhY2Vfc2VxX2RhdGEpOw0KPiArCXRyYWNlX3NlcV9kYXRhID0ga3Z6YWxsb2Nf
b2JqKCp0cmFjZV9zZXFfZGF0YSk7DQo+IMKgCWlmICghdHJhY2Vfc2VxX2RhdGEpDQo+IMKgCQly
ZXR1cm4gLUVOT01FTTsNCj4gwqANCj4gLQl0cmFjZV9zZXFfZGF0YS0+YnVmZmVyID0NCj4ga2Nh
bGxvYyhST0dVRV9GV19UUkFDRV9CVUZfREVGQVVMVF9TSVpFX0lOX0RXT1JEUywNCj4gLQkJCQkJ
IHNpemVvZigqdHJhY2Vfc2VxX2RhdGEtDQo+ID5idWZmZXIpLCBHRlBfS0VSTkVMKTsNCj4gLQlp
ZiAoIXRyYWNlX3NlcV9kYXRhLT5idWZmZXIpIHsNCj4gLQkJZXJyID0gLUVOT01FTTsNCj4gLQkJ
Z290byBlcnJfZnJlZV9kYXRhOw0KPiAtCX0NCj4gLQ0KPiDCoAkvKg0KPiDCoAkgKiBUYWtlIGEg
bG9jYWwgY29weSBvZiB0aGUgdHJhY2UgYnVmZmVyLCBhcyBmaXJtd2FyZSBtYXkNCj4gc3RpbGwg
YmUNCj4gwqAJICogd3JpdGluZyB0byBpdC4gVGhpcyB3aWxsIGV4aXN0IGFzIGxvbmcgYXMgdGhp
cyBmaWxlIGlzDQo+IG9wZW4uDQo+IEBAIC00NzcsMTcgKzQ3MCwxNCBAQCBzdGF0aWMgaW50IGZ3
X3RyYWNlX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwNCj4gc3RydWN0IGZpbGUgKmZpbGUpDQo+
IMKgDQo+IMKgCWVyciA9IHNlcV9vcGVuKGZpbGUsICZwdnJfZndfdHJhY2Vfc2VxX29wcyk7DQo+
IMKgCWlmIChlcnIpDQo+IC0JCWdvdG8gZXJyX2ZyZWVfYnVmZmVyOw0KPiArCQlnb3RvIGVycl9m
cmVlX2RhdGE7DQo+IMKgDQo+IMKgCSgoc3RydWN0IHNlcV9maWxlICopZmlsZS0+cHJpdmF0ZV9k
YXRhKS0+cHJpdmF0ZSA9DQo+IHRyYWNlX3NlcV9kYXRhOw0KPiDCoA0KPiDCoAlyZXR1cm4gMDsN
Cj4gwqANCj4gLWVycl9mcmVlX2J1ZmZlcjoNCj4gLQlrZnJlZSh0cmFjZV9zZXFfZGF0YS0+YnVm
ZmVyKTsNCj4gLQ0KPiDCoGVycl9mcmVlX2RhdGE6DQo+IC0Ja2ZyZWUodHJhY2Vfc2VxX2RhdGEp
Ow0KPiArCWt2ZnJlZSh0cmFjZV9zZXFfZGF0YSk7DQo+IMKgDQo+IMKgCXJldHVybiBlcnI7DQo+
IMKgfQ0KPiBAQCAtNDk4LDggKzQ4OCw3IEBAIHN0YXRpYyBpbnQgZndfdHJhY2VfcmVsZWFzZShz
dHJ1Y3QgaW5vZGUgKmlub2RlLA0KPiBzdHJ1Y3QgZmlsZSAqZmlsZSkNCj4gwqAJCSgoc3RydWN0
IHNlcV9maWxlICopZmlsZS0+cHJpdmF0ZV9kYXRhKS0+cHJpdmF0ZTsNCj4gwqANCj4gwqAJc2Vx
X3JlbGVhc2UoaW5vZGUsIGZpbGUpOw0KPiAtCWtmcmVlKHRyYWNlX3NlcV9kYXRhLT5idWZmZXIp
Ow0KPiAtCWtmcmVlKHRyYWNlX3NlcV9kYXRhKTsNCj4gKwlrdmZyZWUodHJhY2Vfc2VxX2RhdGEp
Ow0KPiDCoA0KPiDCoAlyZXR1cm4gMDsNCj4gwqB9DQoNCg==
