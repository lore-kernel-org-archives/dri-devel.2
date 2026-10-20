Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF7C606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=amGcF+yR;
	dkim=pass (1024-bit key, unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-IMGTecCRM-onmicrosoft-com header.b=K80zYs8d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2BA010E027;
	Tue, 20 Oct 2026 18:16:19 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 091C310E027;
 Tue, 20 Oct 2026 18:16:07 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KHSdLj888029; Tue, 20 Oct 2026 19:15:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=sGp6QpMBknre3WJm2w3/F2pTzxauPxxr3PpV3QBYC1A=; b=amG
 cF+yROgBZNesQ0MnI3LTnjgQiM5T2RYVvTH621Ozjo4HybB9BbNVuww7haBoYaoQ
 0qz7yMJGK/rFqswNRoaGuhSgcQdIT1W/l39VyJxFu6o89dECMoO9UK1K7lFYpA/S
 Tl2+1I/hBue4DPh1tjXJ+pTJq4NQHdOUIXZbkEhrhwB3xSTSjwIJ12XlJlqC7f01
 TRPu/wE0++0T21s/CW/Kj3Fb3dAOgrQ/8s+BNbJk8s9FUqsP0Sp3TKmi0nKhSEVW
 CPMvCgpp2xLP+VMZwfZl/Th5/iPERyJT/y0md4eyW8721xrKOot7oT1SwB/T/Fa1
 9QVmvMDNEXDKziHOm2g==
Received: from lo3p265cu004.outbound.protection.outlook.com
 (mail-uksouthazon11020108.outbound.protection.outlook.com [52.101.196.108])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hdvkagsr9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 20 Oct 2026 19:15:52 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSPPdLd9zQ1gNxseNtbTx4bF5B+GrJ4PDZXm5PRPx3sB3tCbIbxI5xTC0w/nXsVc9D2Dlr5ZEh+nX7ZBxHocLnZx4ORjwHMMIwYGHAQp5/TyPjb79njTNHI1ULL2AK+uMATFWnKEiPBts4vkWNC7Xc4lMw+NcUIcAhpljutwprmuo6twjXxlvfMXEA+ocW/6gNM77CKnXEvwgu5Q3JPU2HFskfMERLXGeReND7L5cwTz2d18tPb4XYB2uIXjQDKrhpqA8Gs5c9gDr7Yy5vqJGjD1tejjRg194OwYk6LEvgmWfvPP9VfIG8PP9wE1wQvzf48qvVAKUKmDbL6nkVGhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGp6QpMBknre3WJm2w3/F2pTzxauPxxr3PpV3QBYC1A=;
 b=v/j6TcZm8TT7lk0w8rLdYSQDBGOrUAgNDXhK1NJaph8jaehzXutmgmbuNigMtlBGmTTr7psPJ5ZX8RBFE1+13ePrxsTA8VjN/FpPJ+0RutrhEP7kXth7UrlKa+MpCQwmqWHS2Rt+cEaovLQrgTg0Bwuyhvf3mmldDjcLjTkSc+9+n95wIrAJvvvRkm2Gw9YLnqfAXLw+QS/Xeh5JbUyHFzTQzZ3G1bOOIW/fs/jA1S+5a3bFlB59RlyDevAFUjiOxDVaAy1fXQFcCFmW3SJnKexUMeiNcsHwTTK7x30Kk3E7KIKCDbJbBOmb6Zr+o9mBSmItjIPUdLI12MmK3Sq/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGp6QpMBknre3WJm2w3/F2pTzxauPxxr3PpV3QBYC1A=;
 b=K80zYs8dS496ThEPRCoFYEwhtVnw2QyD5xle1lxlOR/Mg7k+h95aD/G938VcOLX+7DvU+b7Z0sBwK630MYWh2EyUPY/M4yeJS3esxFdq8fKxQ0FE1NMLrZkhQDDM3LudYnwzaPf+3If6ffx+Hs879IxLBqNzWVueEM2cB1BLWfM=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by LOVP265MB8822.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:48b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 18:15:51 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 18:15:50 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "opensource@mtcoster.net"
 <opensource@mtcoster.net>, "imagination@lists.freedesktop.org"
 <imagination@lists.freedesktop.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH 3/4] drm/imagination: Improve some logging in error paths
Thread-Topic: [PATCH 3/4] drm/imagination: Improve some logging in error paths
Thread-Index: AQHdW7P19S29+9ZS90WPqnR+kaahTLcGxqoA
Date: Tue, 20 Oct 2026 18:15:50 +0000
Message-ID: <443d310865c4589f5b2e8955384a840f31931de9.camel@imgtec.com>
References: <20261014-b4-simplify-mips-pte-defs-v1-0-b4ad7bb68e22@imgtec.com>
 <20261014-b4-simplify-mips-pte-defs-v1-3-b4ad7bb68e22@imgtec.com>
In-Reply-To: <20261014-b4-simplify-mips-pte-defs-v1-3-b4ad7bb68e22@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|LOVP265MB8822:EE_
x-ms-office365-filtering-correlation-id: 05dfc4ad-0f74-43c5-06b2-08df2ed62c2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|261009223027099003|10067099003|56012099006|18002099003|22082099003|38070700021|4143699003;
x-microsoft-antispam-message-info: e204CfR8CoHrTvKNLkxn08egeYmzTE4pG3za3mMmOllGdXCs2D0fRfLmzMSyB7UViAjwcTRKMoB2l/fbNL/esUrjmakRzC/qSRCvX982lOHmspAMIOKozIVDz1VCA1abyywGNbCSH9HnNhxk26q5wL1qDYFhT6DgwuezyPdfhhYCJoq32pPdmnewKacUodOCTBJoizcKDYtAmH93YzAbaZQJvkA+nXvEeswu7X9Zjzpif8DQm5U5veWisYzx+Uln9YvCVz92pEdKvndoyhEkE3XEuZWfc9uTmAfp6BVQmma0wxoVVxy8W6zr4YvkzPx/4RRxTBIt3l7NvwWwS2AZEY8dD9bJERg5GfiJ/PIhwbjOI3W8pXIpBGf3izPQmDn9fd1Cls1LecjexNiE8Bp3akESrLfXu0d0ljz3GeWMzT7j1UqZw4vQcngZU77uBMtqCjP7UHJ9/UDmsUsU0329RtUldO9hemSYNKtx9fMXLvSLuEd1z3Tw4Z92X9XOaSYPcl7RbzgqiqzB1ZRgfJ5zBFeAR2ZahQ0emJa93UBN5ThaisFNadzT4g9m7AJ1iT0qGhUl9E04q7HWxfuM1MnYB+B+jLjvnGsTtU6ujY0NKkmyCPV31MvQzSABf/qOPtrUBZGvq6bi9MXHcsPDizo8fSjOMs9kwHjq//BeTyK/MWpJDK4RmlP8nmdpgl38PSz7QD+z+py1ga1WLOPuHwRPNnn0BwmudeK9BVSJPbuHwoA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(18002099003)(22082099003)(38070700021)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjhXM1pjTWxwK0xSTU5LVmhtYzAvODNNRk55UW9mT1RxK1Z0Z2t2VHpvTmJP?=
 =?utf-8?B?VDF0alZtdFVFS3VZWTB6cVpjbURiRm5pdEgzOUdKejdGVzNRdkFldGZsK2d5?=
 =?utf-8?B?Z05kVm1RSTZWYzIrbEZ2ZUYxRkNBL0VlNUkxZ0ZZU1pRVGYwTUROOU9ZL1lM?=
 =?utf-8?B?cVVGZ3ViL1hDVzhaUkU3MEJ5WkhOcGJsQ3NTZEFXdmRUcDNNT2lhcDBTK1Ix?=
 =?utf-8?B?WlA5OGVPT0RQY2dsM3RNbjFCdWVHNE00a2xFbkJrZHl3a1J4L1dIczQrT1JU?=
 =?utf-8?B?WkNGeTk3Snl5VGg3VUNUNkNxZ1lNOG53OXJMQngwR0VmK0V4NjVBZ1EyVFo0?=
 =?utf-8?B?Rm5jMnZ4Rm9oWkwzcnowdDZCVFUyWGlycFZmcDJEZHNyNjdJZEtiRVhBbmpS?=
 =?utf-8?B?c3lLem40OU5Lc0JYZDBzNXEzTDkzTlU3WTRsTTUvSTlmVGdGeHBRa0s5c2Qw?=
 =?utf-8?B?S1orVGwrbFl4aW9MMHpOQm5KWmR3Z3RiUFBhSWVYYldSd1NSbzdKYlUvbU96?=
 =?utf-8?B?QzhUakVZbTdiZmdTb0JybXVwSmc2OHpDQjNRN0p0SUpTbDlYS016LzErZ2JQ?=
 =?utf-8?B?YW81SUJCc1VKeW10ZWZvVFNQOFVBOUpYT3NxbkFaMDlUK21Rb0NaWURxSVFt?=
 =?utf-8?B?cWVROWRPV3IxNnczanloMk1oK21UWEs3ckRIL0NzODBXTUtaOHFXT0pnbDU3?=
 =?utf-8?B?VFBNeGIvSjdMK3J5WHYvbis0T1FRQW04TGlqOExibVJOWUlHYlVoTHRYa0pG?=
 =?utf-8?B?VkpTZlFmckR3VE9rengzMGxkUXhTczlnTjJ6bEUvcllHMC9FYXZNdis4U0Iw?=
 =?utf-8?B?Y0QwMWdoN29UMkJBaVFkaTF0SmU0czd3VFdoUjJFcWVIN000Q0JEYk9BNExQ?=
 =?utf-8?B?SkptVk1UREtpUlg5TnhycytVTVBOaS9uNG01WUpQY1I0M3hBU1dqTkZVSytu?=
 =?utf-8?B?QVRBWGFQdlUzcnh3N0l6d2xRdmg3Si9HVGE5YTRMakNCRUJlMjlPOEYwUGJK?=
 =?utf-8?B?MzZMc3RHbFhkN1lyVlFLTWFzY3duOXd6Ui81c3JoeE1KeXNxU2NzWHh3MnBS?=
 =?utf-8?B?S3RTN3FCekZJbjZqaXNIWGcrbnJ0NG5WMmdjUlhCOGtWRUJqcHU0UFRSZkFl?=
 =?utf-8?B?UzZoNG00K1FDN0dmR24vaUlXQ1VyckNXS0lmT094OUxZNHNzRzdSbUJIQzVN?=
 =?utf-8?B?NDA4bUlqMGdDS3BzazNHc2FDWlVCRTFOeFo4bXFkU3pCR3hiNTdSdVphVm00?=
 =?utf-8?B?ZzhuZUxLbUVERkNBWDBaSDl6dS9pc3RJVExOMG9KcWdzVWgwdGNDd0h1ZWhr?=
 =?utf-8?B?UmNPNi9rWWVHYlU0ZFQxTjhHbE1XWG5MNU1SSXQ2ZVJTa0Jyc3EwdDVIMFhU?=
 =?utf-8?B?NlJKU2FKSWt4RWlpeGVON0thQzI4eTBGeGx2NnZ2ZWo4VnN6OTY4RDdRYSt4?=
 =?utf-8?B?cXpvNHdWSDFXMURQRkYrTDFxWFo4WTBtWXZ2Vm03WHhiV3JOdlVWT1dMMGhQ?=
 =?utf-8?B?dzN2citMNmc1dnRnKzJnVWF4dEpCazBuWlJBZ09YSEFqa0hhMW93eUw5MTRv?=
 =?utf-8?B?a3JSLzkxSHhuSzZTRW5jUjZSbC9semxDY05UU2xzMk1yczJia3kxZkkvOXp6?=
 =?utf-8?B?NVlvWkhEdU1CL1h2dTlaejR3MWQwQlZRaGtJN1FoVy90eFVWWGQrdUFxZlYv?=
 =?utf-8?B?cHZlL1JpNVllSDA5UWtTQnVObU14VFIwSFVCSEMzbVBLdE5QRUhJbmRtNG5R?=
 =?utf-8?B?Sk53dnZlNTZGVnFlSW5EL2EwQmRwQVpzK25yN0tDelE5TGNxd3NNT2lHNk9V?=
 =?utf-8?B?YlJic1ZDbmUzejdIRmhhd1BaczRmS2dyaG56RnUvUXVJdXhLY25lOXFHRUVv?=
 =?utf-8?B?aUFXeVYrOThkK0hkdWVkU3N1Y1EzK1BYd0VmK3pTSmsyaks0QXpXc1RhdVRY?=
 =?utf-8?B?NlNTSTVPMWJQV1B3VCtva21hZzBLUlVnWGJScXZvcCtpay9lbzY2WldIZFdM?=
 =?utf-8?B?N2FzVlZXODdPSzlWeU0xQ21iQlduRHhlRVZTV3I4dTgrSWwyL1ZzM25MWEJP?=
 =?utf-8?B?OG5VY2IzbmZFZDVJUi9YeGt2VElUcHZkSmZqMFpMMklLYzNKV2hDdTBvQmVH?=
 =?utf-8?B?ZUFlejhUamtVcW9zOFdaZTNWNjdyR1ZmOE1Zb211YS81a0FpajlxZzloa2ht?=
 =?utf-8?B?N1BPUXgwOFE3SVcvNk40dFJTVG4zSXJHdnU2VUhHUnpNTjlwL1JnTk1NYzRL?=
 =?utf-8?B?emJONGZzTUNxYjZzMEVsNzlGdDlsUVYrb3Y4NzV2bFpOaWd3ZlRlbjR6UDVh?=
 =?utf-8?B?MllMZUhSQkhPZXBFbSs5NFVGRmRHSlVrS045T0Y1VWVCbC9HT3d4WHA3YWM1?=
 =?utf-8?Q?qBEa2NoXCXsU3Fcs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C19DFAA96F0D0488822C7DE9464A576@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f4Ruh3aaEHA5z2Pd3ZuUmhKFAV/w8kpgLXEqrhOHAKw3ndzHh1M8ZM1DsGeb31zeHq4GBzdOlxzxM8B0fOHDq4mLOXDUSP/fMLiA+ujipz6a7M5KT9/OB2DkID86H15vfrI1Z1vwNbdCn0QTSUDtFL1TNBBmhAvlnyyymjZFhg9ZMhks1DnGhnNRNM7JHRqPMFMbT6fTxr009fHpCjXAQB+yqb4XsqNkLGa6s1zrObgU76e/zgla85552BMuaPWT3WKDPw4jrVj5h1os0v9Jc58r2f+tvnCPyuLBo8Bk/UCoxXursyYuxd0LsEg1emuCClcheQFO0CnULKaKP9w0jQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dfc4ad-0f74-43c5-06b2-08df2ed62c2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 18:15:50.8487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wx3AY1ORrC/RIIQH4sBEohgF6Znsr3lz9XUDu576ymoLqOv/uL3WzLzFFuReyn2tPRBGLVBPcJcl50VEPyOqk/rb1QGUnM5twkn8r8h5qrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP265MB8822
X-Proofpoint-GUID: sJuwc7EWSQgH28DOkHTOpmJppIQEI-gg
X-Proofpoint-ORIG-GUID: sJuwc7EWSQgH28DOkHTOpmJppIQEI-gg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3MiBTYWx0ZWRfXxNOSim4OoIUu
 xICaCnac+AWBd9AKBXAJ4Nn+Eact3yHSzpSHAgMqWSemIB5gXPI/ktYBg7eS/67vbW2RGxaDijj
 ldM3mf7EtsVuemscRc8LnXpwE+Q8ok6p/HhF4KqREclm97nerNLASxzqv8ppJ4hmjl/l/uHrqM4
 4xqr2aSYD8eXZgEePOGTLuK+VF2sjC2slSWvuoinzdpiEcXDMtySWXtAfcvakyVbJ41tv8wHV+S
 LWEBc6O5QgEQVf+FDukrmxTZMok4YdxN1bWYQTJWsrHyjk1WmK0Al7irgQ+kD4xFh8kQDO7DCy8
 p4jYDKRMh+exfsBc28q+D+5HjiBvKW+dPiC7+qsHwHBJBlZQLzHevk/WnbP2GI1t3/JoKBivIdn
 lbOrtkVyy6BeZO1tHaNZtZ+knTx8gt4wOvH7E/PifyTcmhVFOrloSs6XOwakkqmiwakEY+RW3j5
 MtMYUBrDoN9OeMmlVSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3MiBTYWx0ZWRfX4aDMXNwCSKdq
 +6R3ai3nN19kGXNtNhXzrtWFyBdEdvb1Ut/zn48PMlhekWW4b6M3+j+JE0N6gJ8NdzWNJYUHVbA
 Twj9D85ufC0SMcVtZGECtr1AI91Hljo=
X-Authority-Analysis: v=2.4 cv=eO+GH3p1 c=1 sm=1 tr=0 ts=6ad7afd8 cx=c_pps
 a=fkit1wG95cxeVtk0Cy4uiA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=0KerVSl3bu9IuEGnA-UA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTEwLTE0IGF0IDExOjEzICswMzAwLCBBbGV4YW5kcnUgRGFkdSB3cm90ZToN
Cj4gRnJvbTogTWF0dCBDb3N0ZXIgPG1hdHQuY29zdGVyQGltZ3RlYy5jb20+DQo+IA0KPiBBZGQg
ZXJyb3IgbWVzc2FnZXMgZm9yIGF0dGVtcHRzIHRvIG1hcCBhbiBhbHJlYWR5IG1hcHBlZCBmaXJt
d2FyZQ0KPiBvYmplY3QsIHVubWFwIGFuIGFscmVhZHkgdW5tYXBwZWQgZmlybXdhcmUgb2JqZWN0
LCBhbmQgcHJvdmlkZSB0b28gZmV3DQo+IERNQSBhZGRyZXNzIHNsb3RzIGZvciB0aGUgZmlybXdh
cmUgcGFnZSB0YWJsZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdHQgQ29zdGVyIDxtYXR0LmNv
c3RlckBpbWd0ZWMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kcnUgRGFkdSA8YWxleGFu
ZHJ1LmRhZHVAaW1ndGVjLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsZXNzaW8gQmVsbGUgPGFsZXNz
aW8uYmVsbGVAaW1ndGVjLmNvbT4NCg0KVGhhbmtzLA0KQWxlc3Npbw0KDQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9mdy5jICAgICAgfCA2ICsrKystLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl92bV9taXBzLmMgfCA3ICsrKysrKy0NCj4gIDIg
ZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmMgYi9kcml2ZXJz
L2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmMNCj4gaW5kZXggYzZjNzdiMTUyMzQyLi40ZjJi
NWM0ZGY2MDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJf
ZncuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3LmMNCj4gQEAg
LTExNjUsOCArMTE2NSw5IEBAIHB2cl9md19vYmplY3RfZndfbWFwKHN0cnVjdCBwdnJfZGV2aWNl
ICpwdnJfZGV2LCBzdHJ1Y3QgcHZyX2Z3X29iamVjdCAqZndfb2JqLCB1DQo+ICAJc3Bpbl9sb2Nr
KCZmd19kZXYtPmZ3X21tX2xvY2spOw0KPiAgDQo+ICAJaWYgKGRybV9tbV9ub2RlX2FsbG9jYXRl
ZCgmZndfb2JqLT5md19tbV9ub2RlKSkgew0KPiAtCQllcnIgPSAtRUlOVkFMOw0KPiAtCQlnb3Rv
IGVycl91bmxvY2s7DQo+ICsJCXNwaW5fdW5sb2NrKCZmd19kZXYtPmZ3X21tX2xvY2spOw0KPiAr
CQlkcm1fZXJyKGZyb21fcHZyX2RldmljZShwdnJfZGV2KSwgIkZXIG9iamVjdCBpcyBhbHJlYWR5
IG1hcHBlZCFcbiIpOw0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gIAl9DQo+ICANCj4gIAlpZiAo
IWRldl9hZGRyKSB7DQo+IEBAIC0xMjMyLDYgKzEyMzMsNyBAQCBwdnJfZndfb2JqZWN0X2Z3X3Vu
bWFwKHN0cnVjdCBwdnJfZndfb2JqZWN0ICpmd19vYmopDQo+ICANCj4gIAlpZiAoIWRybV9tbV9u
b2RlX2FsbG9jYXRlZCgmZndfb2JqLT5md19tbV9ub2RlKSkgew0KPiAgCQlzcGluX3VubG9jaygm
ZndfZGV2LT5md19tbV9sb2NrKTsNCj4gKwkJZHJtX2Vycihmcm9tX3B2cl9kZXZpY2UocHZyX2Rl
diksICJGVyBvYmplY3QgaXMgYWxyZWFkeSB1bm1hcHBlZCFcbiIpOw0KPiAgCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gIAl9DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5h
dGlvbi9wdnJfdm1fbWlwcy5jIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl92bV9t
aXBzLmMNCj4gaW5kZXggODRlMDIzZmZmZTVhLi40MDQ5NWIxNDg2YTIgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm1fbWlwcy5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfdm1fbWlwcy5jDQo+IEBAIC0xMSw2ICsxMSw3IEBA
DQo+ICAjaW5jbHVkZSAicHZyX3ZtX21pcHMuaCINCj4gIA0KPiAgI2luY2x1ZGUgPGRybS9kcm1f
bWFuYWdlZC5oPg0KPiArI2luY2x1ZGUgPGRybS9kcm1fcHJpbnQuaD4NCj4gICNpbmNsdWRlIDxs
aW51eC9kbWEtbWFwcGluZy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2Vyci5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L3NsYWIuaD4NCj4gQEAgLTI3OCw4ICsyNzksMTIgQEAgcHZyX3ZtX2dldF9wdF9w
aHlzX2FkZHJzKHN0cnVjdCBwdnJfZGV2aWNlICpwdnJfZGV2LCB1NjQgKnBoeXNfYWRkcnMsIGlu
dCBtYXhfbnUNCj4gIAlzdHJ1Y3QgcHZyX2Z3X2RldmljZSAqZndfZGV2ID0gJnB2cl9kZXYtPmZ3
X2RldjsNCj4gIAlzdHJ1Y3QgcHZyX3ZtX21pcHNfZGF0YSAqdm1fZGF0YSA9IGZ3X2Rldi0+cHJv
Y2Vzc29yX2RhdGEubWlwc19kYXRhLnZtX2RhdGE7DQo+ICANCj4gLQlpZiAoQVJSQVlfU0laRSh2
bV9kYXRhLT5wdF9wYWdlcykgPiBtYXhfbnVtX2FkZHJzKQ0KPiArCWlmIChBUlJBWV9TSVpFKHZt
X2RhdGEtPnB0X3BhZ2VzKSA+IG1heF9udW1fYWRkcnMpIHsNCj4gKwkJZHJtX2Vycihmcm9tX3B2
cl9kZXZpY2UocHZyX2RldiksDQo+ICsJCQkiTWluaW11bSAlenUgcGFnZXMgcmVxdWlyZWQgZm9y
IEZXIFBULCBidXQgb25seSAlZCBETUEgYWRkcmVzcyBzbG90cyB3ZXJlIHByb3ZpZGVkXG4iLA0K
PiArCQkJQVJSQVlfU0laRSh2bV9kYXRhLT5wdF9wYWdlcyksIG1heF9udW1fYWRkcnMpOw0KPiAg
CQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICANCj4gIAlmb3IgKHUzMiBwYWdlX25yID0gMDsg
cGFnZV9uciA8IG1heF9udW1fYWRkcnM7IHBhZ2VfbnIrKykgew0KPiAgCQkvKiBGaXJtd2FyZSBl
eHBlY3RzIDRrIHBhZ2VzLCBidXQgaG9zdCBwYWdlIHNpemUgbWlnaHQgYmUgZGlmZmVyZW50LiAq
Lw0KPiANCg0K
