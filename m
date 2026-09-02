Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884ABC624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 18:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D902B10F302;
	Wed,  2 Sep 2026 18:07:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="V9K7ov3H";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="k7fLG7xr";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F64210E3FC;
 Wed,  2 Sep 2026 18:07:21 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682HpuLL345763; Wed, 2 Sep 2026 19:07:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=9oA+sgXzWPqcj1VbNA1Lax9OgMxXeMw2pH0gJm1l9pg=; b=V9K
 7ov3Hf3doBYtW3CTd0UKOhD0LJIKID09KIHeefG8gOB9nAQYd1UfOpXBaJP6gaTB
 j1HZsuiEMLfa0440JEmfJKIZstgkRBaBBdoURMsaFJm5Lf+cN0y9XzaLZMEgwGkk
 iC9Yy4zogYmK5Z00P1BY7g24hLwSJSebYQquOgoFaRYRGHNXUfelnESdgBEJ7luc
 gpKq6QjSstWaBlb4GkFK4ONfsEzBIKQ6nCLURK2yrQy6kMTb/s5Mfp95QitCDd6k
 VCTrO1ZgraDBk1vr5ZMo8qvweegry3IpVkl5/KYFe1Psmr4sL+1jdWnhWKaA3A90
 JiJfVAxkBB3JPjWiM7w==
Received: from lo0p265cu003.outbound.protection.outlook.com
 (mail-uksouthazon11022110.outbound.protection.outlook.com [52.101.96.110])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gbnppu7vn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 19:07:11 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfF3jAXQlAa+PSJv0xkhk3RqL49XSicSw5NLDZqE3DnJHBtgxFveS4/1Pvf57eC6HmPW4StzVN4sK7j20w8qwE1H+JoRC618wJpABElnHQQoI/e4d/k+NjtSwLcvOvO0g8Z7DslUTpcrG6uMhe2bJm46SsdX0Fdo6CjQw8WY3KduQ4jn91fLaeJ+0fuunPmNYtGQSa3QCWvhzmNqnqmjq1sRMrw7gk68VfnDAMYq8Hd+a8eDpSDnnTyus9FTSDG5kk9/qCI93ofTLOI+9TlZSHROlVf9yd4n2SI3yS08zCcXswWPzayVpUx9kFAotd0O25ojfY8hJpEmOGaarZHj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oA+sgXzWPqcj1VbNA1Lax9OgMxXeMw2pH0gJm1l9pg=;
 b=M6Ed0hWCvvpuV+mSC2xNQYrcfBmxZKM6efDa6+iarl+sPtF+xE04mTurS/qMLQuBX37P5oEPAElfGFKXA28SBSJApkBq1uQgv/YkTBG2DGGUiILDL7M6okhQ5a7kprzPOp+24z9rVHsCwcFksec1MvJdOMyzst4KyMYaYyAZhNIepw9HoIBKfg6IPrMV2f/Ji5WiO3h1DY2QUa9BO0Khbuj8/fr4qXjWw/IDpxuYDD2yNI809wXp5HwdmgXa5kgCvN/H0SnUr6V02b7DcloHueRcWlMacwdgEiPfVMU82dEp3WVmFK5nLWdyduYqwCX9Nne4iFFOFRNM/gk7joJ3bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oA+sgXzWPqcj1VbNA1Lax9OgMxXeMw2pH0gJm1l9pg=;
 b=k7fLG7xr1diV30j+kMc7exSsx2waPuPUCnBTINVL653fyXZ/shkUwsfGwmu8sfJKGiMeTRc7nOultRthCySaknjONlnkaL2CaE0/3t9oXoAU0oXm/3QJYFG50Ef62Vq3Re9X3xm2aiyQzrzSfjhgnb4boQExXO2IQfhNSEMbddw=
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ee::7)
 by CWLP265MB3636.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:f6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 18:07:08 +0000
Received: from LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237]) by LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
 ([fe80::3ee9:8c49:ba94:4237%7]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 18:07:08 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "zhanxusheng1024@gmail.com" <zhanxusheng1024@gmail.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "zhanxusheng@xiaomi.com" <zhanxusheng@xiaomi.com>
Subject: Re: [PATCH] drm/imagination: Propagate all errors from KCCB command
 submission code
Thread-Topic: [PATCH] drm/imagination: Propagate all errors from KCCB command
 submission code
Thread-Index: AQHdOwXeGm/1u5r6s0KGB4n86gNxGQ==
Date: Wed, 2 Sep 2026 18:07:08 +0000
Message-ID: <f9df89258a449c3bd64d6b7e3cfaf4da2174e953.camel@imgtec.com>
References: <20260811-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v1-1-ffd55254d6d2@imgtec.com>
 <20260811063044.4035829-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260811063044.4035829-1-zhanxusheng@xiaomi.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO0P265MB7076:EE_|CWLP265MB3636:EE_
x-ms-office365-filtering-correlation-id: 4064e3a2-b1fe-4c68-96fa-08df091d00fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|4143699003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: uZEfcdgaSCNn7d3Sl2VGUbiQ+6PDSI1TCCTKIMzvfhTdhK412cAYsJlviUXC3KAIZHQgifuZDb/D/9ZJqEWTCMKrWd5jon+NTJEYXSRCKXpdUpaxS8pfuWo8O4Ac6VKFAvbF/AAXFYZ11w1hUkvkhlYm+mUcGgejZ9Wk67JfWE3vwZqvQT3umMd2TgFezH5QyGLG77qkNgliInthZmGm9Q+p1kECXCuOi7d/e10aSQ3Dt3QDYUrbeMq01URr7eKZAbiGtIcI+rN5C3FcFWqbn3Y3Mkc8OfOaoJn+sD3kcBte8J4fpCkFBvSl2YZBi1UBk5F9GfCH8wSyvrTiQRxsnCnRzhezClVbVVjkoHKvZ9S9d/E03tomi1fdDnIG+Ncp6Xg1t5FGoUyB7EixUnlnuT8YCEWPoPhBwTaMIMfhnS4Xr3xv3nbQRD/mT50bz/uUZjAz6wPNlo5TxL1gtT9JyNZmOtWX5I50xaF1fk4woiE1SVoqA/zlI0ZrLGdtwzk1X8g2Ut8IRg9m+1muspfpmtnFtMph7PElE2IhXWOP+OKqdhuwAXAwPogI/IjoxJ1qzUw4xIebpQJi+IyUA9i4McMp7dHAxu/irIZhn/W0ruFqMnGQyAZUPG4AoKdvRpfm2AEL8IBybaecVERTeIP3BfzPMcyibeGdU4zdSFi+9TcRPkvqS2BLsrQ6iqPv7r9mrg8mKbxokKKSb/L+4ljOKA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkdnOFd2a0daT0RSK00vcGZsbzV1alVTbWhDY0plQWxRR0dsQ3ZqbUlFMHhI?=
 =?utf-8?B?dE4xYVJvajZ3REw3WEFrcWVkY05tYmtzK29zbkl0TTFnbWVmbG5yNnJJTGUw?=
 =?utf-8?B?RTd4RDljTmlISGd2V3Y3UjQwdjdyZUZ3Q0xTa0R1UlZETWg3NkZmYzd1bmht?=
 =?utf-8?B?dUZKQ3RXUk8xQWsrZjkyNE1Vd1FZd3hIL29PenBXYnJSa3kva2RFUGU1UElq?=
 =?utf-8?B?cS9NQ1h2MEdTeDRMZUxzVUwzczJBUU56WUEySnlZdnlNTDRBTDdOWWVkOC9L?=
 =?utf-8?B?ZHNDRmllRmlUL1pmMDZ4K0QvWkpLYzVRSGVYTld0cTRqNTJiVFJTWjN5RmRS?=
 =?utf-8?B?OVhMcTFEdkw4eWVNVHRobHNCcU9EZDcyNzhmOVFkbmtPbmN2OWZXTy9IZy9j?=
 =?utf-8?B?U1JtVkNETDQ2QTJ6ZFE3UjVRWXk1S1VFb1FaVmQ1a1BFZ1pZWG1LMVE0ZTVV?=
 =?utf-8?B?a3p4UVFFdEhQNVIzM2FYTEMvY1hub3RyMS80U1QvRWRkZk9uenpkQkJmcnZn?=
 =?utf-8?B?MCtBTEswbWc2blhCSFRWN1U1SkZCeG5wVFBKcCtBaUszTHBBdWNEc2tsVXVS?=
 =?utf-8?B?VC9nbEMyUzRnZUZwaEhQU3k2MHpxZWlvTXNrb0NYS25iNFU1cVYxUWFxRDJy?=
 =?utf-8?B?OFRTNnJzYW9YYXIwcTJjRVpQNDlRZk56ci9KZ0ExeExXTFM5dTEvMG9ZYSs3?=
 =?utf-8?B?V2x1WGorZ3BFYVFFWHg0TzlyUlZqWmxYSGc4NEhodUxRZnNTTmFoUE9MU2VE?=
 =?utf-8?B?L0xMWEVwTWI4Tyt1SWFJTzdsSlNMQzRvQWtKaGRLRmFEQ0VXUU5GUGxNOG1V?=
 =?utf-8?B?NHM3MjdpbmN0Qk9PQ2dBWjJYL0dMZjcxZGxnWWxVTTJHSEEyV3RTTlV1Njcw?=
 =?utf-8?B?V2R3V0VtelJvLzhzMlBWYUpOZHJreDBhM2gyR2lob09heGdvY3pINHRxTnBC?=
 =?utf-8?B?MFg5UG9tZEZKbXdmbFdhMUFkWmRxaHN1ay8vVVFTbkhpVjVtWUZrd2hESDJw?=
 =?utf-8?B?WjluQnNoN0VTN0xQb3BzR1p5OGw4UnNGdUVzYUJLNUxwdWtBV3Arc1NCR1Vh?=
 =?utf-8?B?V2xhbWk3NHJIWXFrZU5QZ29jcVhxRWtMWmwzcW93THpnQkxheG4rL3RRTlNl?=
 =?utf-8?B?TzZGUzZJcStkQm9TSUZKV2swb1pEb0lKQnhVV0FiN0VHbGdvNGJMTGRqVlJz?=
 =?utf-8?B?RFNFQm1ORXVhbklFd1psT1hMRHRRUzFzS0RJRTNkUlMzZjhkL1ZoUFA3QVBp?=
 =?utf-8?B?R0lnb2xwbjc5WDMxZDFxbm5vZDVtbEdMeFp0UEZlTW5PbjRPYlBmY2tGY2tC?=
 =?utf-8?B?VVh1U0RNZ3VXYmN3YXYydEpEbVh2NGdweTNpaUJXdFdtcmRFTEtUNjJ5VXAr?=
 =?utf-8?B?V2FuOVdUSktIT2REQ0M4T2NsK3puMmE4MytKMkIwd0E4VHpGYkx2clBSNnZF?=
 =?utf-8?B?NzlQb0MrU0oxMFU2cFl1dkN5dzR0ZzNCaEUzem1Fb3ZhbFNJMmdLTGVxTmd3?=
 =?utf-8?B?aWZiK3pNZUJXaFpFRzVkRFJESUNlaGFlcUxtWEgvSTNxd0V2dzBLaVd0YmE5?=
 =?utf-8?B?SHdBTytFc09DV0FiYy9mWm9lQ1BhMTgvTDNEUnRZRWZKdHNvRU0zL0ZwVkNF?=
 =?utf-8?B?MEUzazFYdWg3TXozWXRhNDFVTWtQOGd0SWFkc0JINzFab2d0dWVlalFhWWVT?=
 =?utf-8?B?eGEyRGNpdWVBdXZWNU5RS2RDdkdVU2pzb2FoNWhkdXlRQ0pQVEI1TzU4b0Rn?=
 =?utf-8?B?SnB4TFpzV3ZSMzZEbUprWEx3L0haVDloaDZiU01SQ2ZNMGJFbzI1bkdZL2hq?=
 =?utf-8?B?VjZOb3VXRGxPU1VldmUwUmdoWCtadTIvcjVzbmNFZkp0ckpmckNRTW4zb0oy?=
 =?utf-8?B?U2ZxNzN1VUZtUTlJU0liRXFELzhCaDM0L3p4R1A2bUxqMFI0N01Qc29BL2tt?=
 =?utf-8?B?TytUM3BKdDlQUGt6ZEEyRFBnY1dkb1hUem5Yb1dvbzVNQ3d6STR0NkZLWXFh?=
 =?utf-8?B?RUk3ZFBUdTZLWFR2K0Jjcmk1UStuUmRjd0MwaENyaEwxSlJjdnUxU21reE9R?=
 =?utf-8?B?ZzRuV3p6QVl3WG1iWUpQSUJrVXpKeFVwdDYxc3NEUmJuM3h2dkQ0NDlubVNP?=
 =?utf-8?B?ZkJSNFE4V29XUzlOK0RTaEg2TTIreFB2SnUramxaaXdIczlGKzFGSmpIWGl2?=
 =?utf-8?B?Ynh1M3p2SDRIbW4rNVJvZWg3Y1gza2ZqcWZqVFcreGlWMG16ZEhmY2JJS3hB?=
 =?utf-8?B?TU5LbUVLZ3I1Q3dXNWpBeWk1YjB0SDRnU3p0NjBBWlNoZGdrZHBWYlNEV1li?=
 =?utf-8?B?Q0Q2WWdjb2pLaFZXK1g2WmlPQXdiWXM1L2xUVEVNSHU4Ynd5aHBPRWFjVFpt?=
 =?utf-8?Q?f+pxTGHCb2nWvTjc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8A198B12828E743B8BDD114277936FE@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vjQS0q40+dM5zlfv5jvMcaJYTDqGaqRXJbqzZoWUmFSl4OnprBYzAuKkxOOxD7pl5Ge2S3AVcTk5MmGqDyiGfCOBr/zTAGJAM7a/fpnlbGXsTEJF8uphdK8kN3vkOMhzynl9BX18AiSAFw/C/WX4NjADT/wmE7wfL6UoR+ZenvjxsmHJR6l4bKjVzo472ZuShHHzcp2El2CZsWEQQcbCBppthpjJ7zI5s6HT/Rkzx+1AsnRNa1tp4Fqxpu0DCYWLd27hmG5odZin8XTZ87f8rfp1Mt8k1Wp2JfCa6Up54Xt2LmPOrrQqd7G44u8wWA3BWfeVaCGWJMDCbpId7lgfGg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB7076.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4064e3a2-b1fe-4c68-96fa-08df091d00fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 18:07:08.5023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TI9/5sCWgywZGjQGE3NOE6qUK1fpSfKwr/5YsesvcPpGbB0p/+6WgjIooJZoBwoO0KEHy1WjpG09oba8uIF7DAyCWpIp375aqQvTYEeYE3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3636
X-Authority-Analysis: v=2.4 cv=CagAdrrl c=1 sm=1 tr=0 ts=6a9865cf cx=c_pps
 a=MIvDDvqsVNCIihL80LubzQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=_FBrE_bxLNdYWu9s6T4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: IXGmncqS3CoeHXajQwgwNxlBKBvQiklc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE2MCBTYWx0ZWRfX13IvOwYucGfm
 w3j+30JKB9sjwAssBNw5QxxXutu58253a/sKevreOrNzJ3r7ysHBn62ymdQDQ3K1d5SRgU5DeSv
 7sh/SujA40vdbDUhSBxbJkd0LS6JzCT9Nir5668IoDCXfYROYaqdAkWLT2J2rxm32MD3KPOuDz2
 PGOU9DUHiVOQ3VJCcPvhpD3FdLU58FEBGAhroJDhBcqD8/4W5ffL3O1ql/9k7yjaWaouIKZntA3
 SamWrSTQgHjlSrrJc/1j2CgVyxGqY7qnTUacu7L++NBaciIO1E80I06vil8+yxKf2Agkg598Bad
 nZz+kvODvJKHEQl+Dbt1yeEkJcWP6l99Ie8h0gJtO71Evinswr+ELtzYMUnDnd6qivYVku0SFrm
 L4NM9T6SDTczHrUsUBWp6YLgHkcVJwlVA3mty2BCJ6DR3ApSBV9L6GC/MRxl+5Uj9QMmMJ+C+4P
 8LVoq69Z9WYZLNkRlag==
X-Proofpoint-GUID: IXGmncqS3CoeHXajQwgwNxlBKBvQiklc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE2MCBTYWx0ZWRfX2YAXWUoFKwaw
 569uEQQrKEfnylFJruv01xB/tTqPW+N3gWiViD230iY/2gEAqlDAIVSWNUVS3QLs2b4BC2qkBfV
 LtgSCmx8GnrF1pOC226qvdT7xLRh2gs=
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

SGkgWmhhbiwNCg0KT24gVHVlLCAyMDI2LTA4LTExIGF0IDE0OjMwICswODAwLCBaaGFuIFh1c2hl
bmcgd3JvdGU6DQo+IE9uIFR1ZSwgMTEgQXVnIDIwMjYgMDk6MTE6NTQgKzAzMDAsIEFsZXhhbmRy
dSBEYWR1IHdyb3RlOg0KPiA+IC0JV0FSTl9PTihwdnJfZGV2LT5sb3N0KTsNCj4gPiArCWlmIChw
dnJfZGV2LT5sb3N0KQ0KPiA+ICsJCXJldHVybiAtRUlPOw0KPiANCj4ga2NjYi5yZXNlcnZlZF9j
b3VudCBpcyBvbmx5IGRlY3JlbWVudGVkIGZ1cnRoZXIgZG93biwgcGFzdCBib3RoIFdBUk5fT04o
KXMsDQo+IHNvIHRoaXMgcmV0dXJucyB3aXRoIHRoZSBzbG90IHB2cl9xdWV1ZV9wcmVwYXJlX2pv
YigpIHJlc2VydmVkIHN0aWxsIGhlbGQuDQo+IA0KPiBUaGF0IHBhdGgga2VlcHMgYmVpbmcgdGFr
ZW46IHB2cl9wb3dlcl9yZXNldCgpJ3MgZXJyX2RldmljZV9sb3N0IHN0aWxsIGNhbGxzDQo+IHB2
cl9xdWV1ZV9kZXZpY2VfcG9zdF9yZXNldCgpLCB3aGljaCBzdGFydHMgZXZlcnkgcXVldWUgYWdh
aW4sIHNvIGpvYnMgZ28gb24NCg0KVGhpcyBiZWhhdmlvdXIgcG9zdCBkZXZpY2UgbG9zdCBzb3Vu
ZHMgbGlrZSBzb21ldGhpbmcgd2Ugc2hvdWxkIGludmVzdGlnYXRlLiANClRoYW5rcyBmb3IgcG9p
bnRpbmcgdGhpcyAoYW5kIHRoZSByZXN0KSBvdXQhDQoNCkFsZXNzaW8NCg0KPiByZWFjaGluZyBy
dW5fam9iKCkgYWZ0ZXIgdGhlIGRldmljZSBpcyBsb3N0LiAgRWFjaCBvbmUgdGhlbiBsZWFrcyBh
DQo+IHJlc2VydmF0aW9uLCBhbmQgcHZyX2tjY2JfZmluaSgpIGVuZHMgb24NCj4gDQo+IAlXQVJO
X09OKHB2cl9kZXYtPmtjY2IucmVzZXJ2ZWRfY291bnQpOw0KPiANCj4gcHZyX2tjY2JfcmVsZWFz
ZV9zbG90KCkgaXMgbWVhbnQgZm9yIHRoaXMgKCJTaG91bGQgb25seSBiZSBjYWxsZWQgaWYNCj4g
c29tZXRoaW5nIGZhaWxlZCBhZnRlciB0aGUgcHZyX2tjY2JfcmVzZXJ2ZV9zbG90KCkgY2FsbCIp
LCBidXQgaXQgaGFzIG5vDQo+IGNhbGxlcnMgeWV0LCBzbyB0aGUgRVJSX1BUUiByZXR1cm5zIGFs
cmVhZHkgaW4gcHZyX3F1ZXVlX3J1bl9qb2IoKSBsb3NlIHRoZQ0KPiByZXNlcnZhdGlvbiB0aGUg
c2FtZSB3YXkuICBNaWdodCBiZSB3b3J0aCBoYW5kbGluZyBpbiBvbmUgcGxhY2UuDQo+IA0KPiBU
aGFua3MsDQo+IFpoYW4gWHVzaGVuZw0KDQo=
