Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209A9CD4F50
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 15:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B22E10E8DF;
	Mon, 18 May 2026 15:02:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="NjUAnYNb";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="DyUWLMFM";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAA2310E8DD
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 15:02:08 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IEFc8O2119320; Mon, 18 May 2026 16:01:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=dk201812; bh=sQvmiZWHW4J2jYtvaYba6MyBV
 y+wxYbPs0CO56zh3z4=; b=NjUAnYNbUjPF/TeckNGAMSU349UGAJyiEFYiaGd19
 kx3IoOGbzRstxMr0aQp6NUvpporPLjPjB9o+uwoMurHP3clg8fqNsaJhXz7rjBWf
 9ZeCM03JpXCQX38ljTzrGRgHOrfKQh4dZJNFO/OzrBrp27ejyQvdC+Mm9lkXVXjd
 y9zhX0t48b6ruzeZ/xLXc5er0gWavj8TP1JKV5jhH/fd4rKDuv0AstnJJH3fgzUO
 85uPjM88LW8UDeikokEjBVSv0I+ea0IlCk/TulwTWHWKNjHLju4M61koB0Krj3Vf
 gqkx3NvJ8JkGKSAW2kr0vaPZdTHHnCw4OJiT39yvpLh0w==
Received: from cwxp265cu008.outbound.protection.outlook.com
 (mail-ukwestazon11020085.outbound.protection.outlook.com [52.101.195.85])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4e6eup1kpd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 18 May 2026 16:01:53 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M98G9xXQTCoHyFc9nI+lEXqmSfE53C0f+7Ys8P/YEQTjYPnhe0fGZ/5YSs7clZCqSP60HbG5oUdl81vgpoVomLq09/f0+AAbczr50G/c3ZFr0ZqaoUlqsRwC8ih7iqca1akNYrc3zgoy+gh9n6YfHIQZJD9/W62u/EMnfUVieBMKhgaVEiWH8g8L0dfHHdTjfLGwqHau+8BLHUbxBq+RCjLFMtGdmpDtnna5iOaoKEbx2SKYKhnAo8eKKNGxMvhj6BlB+nL2R8Vlj7Lpqe6wC8xUwComtApaKtpQuD7wnpTG9CJyPMnTrrEq301oBV1hNc/WnJWeYI2gm09uKbMHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQvmiZWHW4J2jYtvaYba6MyBVy+wxYbPs0CO56zh3z4=;
 b=nIJSNosnB5xeDzOo37ZBA/6Ax0Tw7hIbweBh4tv6m4aWsWRERrYN9W0sR7HmDnUtWv/Fd6BB6kuI9h8T0eMGYJy5pIukwix5iXcUGwz2MeBiLt5SKWc9qZgq50DIDWTHKDZ6Kj44DvTLOjm0iGJukdapM6hN+myLjuphI/UAMz+DT1CJ4yIeiZGqFzV3RRvTrBcjKGnBMtpT/FyBs4KioR3uYwtmLCgQgm35xJrR3/5iwgLxFwngPIBT9mX7EHf1PZbVvcfeHHuyn9ey8eHFt1diTekW0ZduT3KWCsZ9tsdEwNTpKIS2EXAb5K3wCYiFdRYMWHrhtg8O0VCL37XkAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQvmiZWHW4J2jYtvaYba6MyBVy+wxYbPs0CO56zh3z4=;
 b=DyUWLMFMDTRvX1LqB9FWhCOF8NO1afQnQ/lC0gz/8K9vIh2Df6XO0ZTCoOb67ufE/0xgn2QiiPGWbVpolJRm3rh1tTSZeeAuGfliEmoIu6MIACKNydH3HO/11UFEAkgnKVs1O329cQoJoTAexLp5XQqmd6MfP+3C/dSXENT/eEg=
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e2::14)
 by LOBP265MB8899.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:48f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 15:01:52 +0000
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6]) by CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6%3]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 15:01:52 +0000
From: Matt Coster <Matt.Coster@imgtec.com>
To: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Frank Binns
 <Frank.Binns@imgtec.com>, Alessio Belle <Alessio.Belle@imgtec.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] drm/imagination: Don't timeout job if its fence has
 been signaled
Thread-Topic: [PATCH 2/4] drm/imagination: Don't timeout job if its fence has
 been signaled
Thread-Index: AQHc4ds39dHt/DK1bUGHs81w2URif7YT6s4A
Date: Mon, 18 May 2026 15:01:52 +0000
Message-ID: <1d579aba-af9a-4d31-889e-9582a362468f@imgtec.com>
References: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
 <20260512-b4-context_reset-v1-2-439bee96ed83@imgtec.com>
In-Reply-To: <20260512-b4-context_reset-v1-2-439bee96ed83@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB3393:EE_|LOBP265MB8899:EE_
x-ms-office365-filtering-correlation-id: 7a342063-ef97-4328-8c58-08deb4ee653d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|6049299003|366016|376014|38070700021|4053099003|22082099003|18002099003|56012099003|4143699003;
x-microsoft-antispam-message-info: hD7saoUMsnnScOukHXhD7EoF+25C9YGznmIZL4C7LJ2O5Gt5R825KTj614s2mwfleofoxPOoSxkLtqWs6PzgPgF/BKt8GPFqT4Oe6QmiGh0rMNJuirUF67QMtvqsNMBaOKrq5HF3jXzqabL5cF8aAX0yjHDmCi0IIb2KLGsqtNLyfik+tt0f4oe9xsdlJgRlzsCrTfHgfkSkAThjZ3WrwydL8+Hc2nFXjyWAJXLVZG3mZTHl8/PXyXaKb05pbBaZ1qLW+5m/1WyIj9IVZJXw19sVR9gTrZAXCPpJap6h4mpUSVFjeqmnLy6ALwuwHCE8EwPTL16q1QoeBPvbkEJ25WiWwj3JXTqe/fp20XHpbt4YM/IH2WlEcy2B5jJTtIUPh8Vx//t7pOeVlW8uoH/uDvpRmzS+7OW0A+xyUKY/R7IvkQsmTNJ76hgQvcr6Uz3DHm3idDZMD9u1vleTNUhkd4IuqCqC7OYNO1c9CNOfy95fGmzHTiOjh096o0IMVXXiWkBW3drkFAFyA2yZp1lbuxVF8C1GUCdn9eTZxmtfjSmXKiRurrjaOH5wJJ98C+WH6yYfaOB6I7nTubdGS87u6w4BM5nlIPP4h4pSFMo/MXOXMpKCkuaQhKVxSo0sl0gmxHbP2TnCe2fN1UwCb6uPNquiwVY1/H/sLPtoWokLNfNz2pcrWUG5rtfigwK244DmHz3XZ7MOiUiU5xux3+RApapEft5juzlWKwTL5y1lM8HvpPNb+9SETLtC6nT0egh+hCpS33x+ZuaH1UAJf1bagA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(6049299003)(366016)(376014)(38070700021)(4053099003)(22082099003)(18002099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXRuK3NEWUJlRWtjTUhiQnhGNlFuRVpGc1daSGRUeERSLzBjVzg1T2VzRWpM?=
 =?utf-8?B?bDRUMTFCNWdEYVo2YnB6TVBaN2VtVTRZcGp1SGRReFlRKzU3cE1YeG5XQVFo?=
 =?utf-8?B?aURsZVlaUHd1SCtxQmtnMDFwS3NNY2x2WTNKTnduTkc1bzVmL0x3QVRtVW0x?=
 =?utf-8?B?d3FaMjRxN08vQU80d2tMc0VRN0xGVVZkS25BYmFmVnpaTk9iQ3B6VkxoNUlC?=
 =?utf-8?B?amZxaTN3bTFsVWZxbjg0M2xOb2ZpSGtFVGtCYzZoSkFhYW5iSndqVHpMUWFq?=
 =?utf-8?B?cC9NY3JMRDVyaDI0d1pwWFVuU3lQcml4Nzd5TVptMjY5L3FlTXN3UW1wRXNz?=
 =?utf-8?B?NkhzMWlkay9CeFp4SnhqZENKM2pRcFhRWXJhMnlBTHhMU3IrbmRPQjRiUTNz?=
 =?utf-8?B?ZDY1VG1TaDNseThjekVBTFN1VWdEanZwNjl2SUUzYWN6Y2tTdmdQRWZwTmFD?=
 =?utf-8?B?QnRrNHFqQXpGK25HVGtUaGtSRnJCMGN1RSticnZRSHdpOFFHRkdaSDJGbDEw?=
 =?utf-8?B?dkdIajRDNUNlYzlBZ1BBa0tiQ1pxTks2Q2tIVTZ3SzZSNHh4bVNvWHFRbnpx?=
 =?utf-8?B?UGlSenluMVVBYjRwSitPS2tJY3dEQ0ZIZEtKWmxRRG12Rnl4S3BIZ1loUW93?=
 =?utf-8?B?NjN4cWJaQUdsb1l1Zmh0Wjc0OXpYb3FvTnRRQ083N0FEcVZLcDR4a3ExaFVK?=
 =?utf-8?B?NzRwSC9hRXVveFVVTFZaZnBUeHQ5czNLa3JONmgrVTdOREFURHBmSFJVSXBB?=
 =?utf-8?B?QWV2VCtGTVJ3ekVyMDgyTDBEd0RMLysxbnJxZmtuNTh1MDRCSWtBRG9aZzUx?=
 =?utf-8?B?ZnNmYVZaUkh6cFNvMDJHVjA2Y2lwWGphUXVKZVFhaVhEUlQ0dTRLRUlWenlL?=
 =?utf-8?B?TFN5bmJHRFM5Z0hOZldkSDBZUllHWGlGUDdBWmNRc2ZSZVhvRVVXK0UyVU91?=
 =?utf-8?B?M01scXQwaEhlQnVvRGpLTDdNeDArNEhFMmJLZS9FWldtNnZyUDkrMUsycFBW?=
 =?utf-8?B?ZkVLb0tKNmpPNFBmTEVVS3liQktFVHpSZmM0QngvbFZsc0RiK3ZDR3ZoMno1?=
 =?utf-8?B?UVR4NmlhbjI2d3gveHNicDlsYisyRWhpSHFwQ3Juck1JRXhhK3FsZVlsQUls?=
 =?utf-8?B?WmwrK1JKTXdBQ3l0SUhMUngzek4razIxeXl3WnJDQWxEWi8wdEJLb2RSLzVm?=
 =?utf-8?B?eDFKb2lIVzlyUDZxdmpNT2VTbnkvSWxEVHc5QW5IUTZFYVlpMjZRaUtGVzVj?=
 =?utf-8?B?Si8xaVZXMXJ6cG04djNTN1M1MDYySGFGK3pGOCtHbzV5SWo5YzNGZHhCT1ds?=
 =?utf-8?B?WVd4eDJ2bzJ5eDBnSFJtQTZ1cFZDQWtoSHZKVllOTHl6My9kYWU1RDdkYTZh?=
 =?utf-8?B?clE0Z0lvdzNER1JKaUVNaDV3QkpVK0o5SVFpc2tBSHRhUmVFT0FIU0hCeVdX?=
 =?utf-8?B?MDEwZ092Qm5CcHNrejVaTzNSS1ZFd0ZJdHJSU2cvUEZURDFLVTdJd1U0N3pL?=
 =?utf-8?B?bmtQK1FRMmhxQXlRNk9FZzBxNit2SDNqajYxeVFOU0VGRy9zc29uRHQ3ZVYw?=
 =?utf-8?B?TkNLYk15MUhKS1JCWVp1VC92VHBaVnFGbytPSkNTK2JrMHpQcEFnUnUwK21r?=
 =?utf-8?B?WmxYQkx3WjJVVGM0RjJtOVR6R3lKZ2dheWNZZm4zS2RrUHhYQStQcVZ6VTZP?=
 =?utf-8?B?WVpPcEwxMnBXb01Mdk1KS2hleFBjRTNZc3FsNkhLazRVUkRtYWtKQVIydTZE?=
 =?utf-8?B?KzVlTkcyZk8vaGVvTVJIMlBIZ003MUUzZllFNGVQQVl3NWhJMzBRVTQxWm1F?=
 =?utf-8?B?WXJvaXF6eWRheEtSaTU4NlBnbW50OTdyTXBRYlkrR2hTZWpIVGxhVTdsNDRh?=
 =?utf-8?B?VldGR2VTcXgxZHkvMld5bml1YW43T05KcUM2MytOdDhtejJnWmVaVUZTRWdO?=
 =?utf-8?B?STFCc2I1SHlRYmN6WWdKL2dwUm1zRkNyUXp4a1BDb3VyOGtqZGZ5Qk9hT3NL?=
 =?utf-8?B?a0pKdWRsQUp5UXF0LzBCdEhsUld0SzdmNzZkR2pFbUVrWEFIS3dsUjRpR1lI?=
 =?utf-8?B?dVNDd2xoUWRNYkZIaTEyUHMyb011dHNuYSs0bllsd1ZTdkMyOWpMaEtFMnpo?=
 =?utf-8?B?TkREY0c0N3JjdmNlV1FLcmxYaGRPUVVuVGcyYnpmS2N2YitlUW96aDZ1SkNk?=
 =?utf-8?B?Z2MyS0hpS0Z6ZjZQSTRXL2tXRTYvMWw0dk9hTzNsK1VwY21zdU5sVTYrTUtK?=
 =?utf-8?B?U3hjejZ0NXBxaUo4WlhoVlFhWXpUV2NqcTNtMnZqMVRnOHUyQnp4UnRyYUpt?=
 =?utf-8?B?SVZyejhsaW5SMmVkWWYwUmNoRXphM0pVaEhRYVRORnpzb01pT0t4elJyK2VO?=
 =?utf-8?Q?YeLqVV9e2wwbwWbM=3D?=
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FnlQZ8pXYZcS8ck1cJaAhySO"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CbZAjfR3bma4VnWnhm9+GrudCpGmHLfULvIRTsAUx5csFTJ3PLX9caZHVgBypDHcgIrmb1mbK1ZoJnWBpoawUSmoh/8iviBRr5CESdsksyhMi82r1TxNknscy6vuYE3fDSLF++Xv3inWxD7FGT5DXBYozDATx2gex8vM5GMAbNWZrMuQiScwCjLFfSFv1SxtWQMqyEtW3hsY4f7jvZ3BKfYnZSk6+jPA3+1Z6PSREvGgTa3YOKU0hS661r+JuNNv1/vioJqsARKhfN8DobsoxpR78blHOrI5SM9erAY/k02bn8Rfk4blIdqwiGeZWsEqmADd1MKqgqgVQnQ0L3dIpA==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a342063-ef97-4328-8c58-08deb4ee653d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 15:01:52.6619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Poo762l+WSPKq47ptzHAQA5aLkqfBM8NCGtrqDbpRuVEdi0hNWxsXK9+kMnOqnNQfFrsTfDzsRu5QBYjit1AAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB8899
X-Proofpoint-GUID: 0LM3Gr2ZqwJQ6DI34wQev2GggiP3aLMW
X-Proofpoint-ORIG-GUID: 0LM3Gr2ZqwJQ6DI34wQev2GggiP3aLMW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE0NyBTYWx0ZWRfX+Dcn+F4lZPM9
 92mzPWfcwDH85o6oeWHH/gNOtfo39YocucgqpbmGqznUlgbDp10WIuCUlZw1Qy4+STLPFpSkKic
 f6N8Ivt82USeC0WabuEi4rr5rKNnxpBcqkns0VIyunvimKK90txb7GqT+xxGVmVtPo61X+/cqOg
 0ZU3NTvonfaZQAD91FZJQZlyhoCouhKCEXlk311hFnieR6s14gh+hzvUgsH8KgTDrQFgYVbh4bv
 KoW/ahwDtwQfY4KOXq6ED4sDlzlJHEouW6A6CfyQrvr9uu9sjVE5cWI1j17+VKb/tV4D4xc/0aW
 VYjSRQGDXoxKZ8k8K5Z1ZJjTid4dACnZtzxZyY25MBtCcPp68EZKoQ8/UTqtUpvS43XgAdhA26j
 BeLQKOGuMjnJPAUBRss/3TXRFYLyIoT5dtNUXLAb3Ooi7WOJ6a8z615wxq+LHwOhzkKOZzfLj/L
 a3FZ2UrwIp7hXGUzg6Q==
X-Authority-Analysis: v=2.4 cv=BIiDalQG c=1 sm=1 tr=0 ts=6a0b29e1 cx=c_pps
 a=RWxytQFfVy3xqte4PtalWQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22
 a=qZQ2PDNLMSdLoqI-hfl9:22 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8
 a=-WrxoVgqgZsfErY1UdEA:9 a=QEXdDO2ut3YA:10 a=73aYtda-SQ2aIu59UMAA:9
 a=FfaGCDsud1wA:10 a=t8nPyN_e6usw4ciXM-Pk:22
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

--------------FnlQZ8pXYZcS8ck1cJaAhySO
Content-Type: multipart/mixed; boundary="------------6t11bo4JSfpyXqjTryH2MJvt";
 protected-headers="v1"; hp="clear"
Message-ID: <1d579aba-af9a-4d31-889e-9582a362468f@imgtec.com>
Date: Mon, 18 May 2026 16:01:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/imagination: Don't timeout job if its fence has
 been signaled
To: Brajesh Gupta <brajesh.gupta@imgtec.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Binns <frank.binns@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
 <20260512-b4-context_reset-v1-2-439bee96ed83@imgtec.com>
Content-Language: en-GB
From: Matt Coster <matt.coster@imgtec.com>
Autocrypt: addr=matt.coster@imgtec.com; keydata=
 xjMEYl2lchYJKwYBBAHaRw8BAQdAOYlooFfHTXzAQ9aGoSnT9JS9wq8xprG+KVLbkxJDF5DN
 JE1hdHQgQ29zdGVyIDxtYXR0LmNvc3RlckBpbWd0ZWMuY29tPsKWBBMWCAA+AhsDBQsJCAcC
 BhUKCQgLAgQWAgMBAh4BAheAFiEEBaQM/OcmnWHZcQChdH8KkDb5DfoFAmgHpowFCQlsaBoA
 CgkQdH8KkDb5DfqxDgEA81pbVLJDmpFyFZLRhAGig9rgoDY6l774yhTzRVm/SvkBAJLzpSlm
 wyQaQuB668TKOX9XvRLKFGjSq5kkdQcxqjkCzjgEYl2lchIKKwYBBAGXVQEFAQEHQCaVC8X5
 7NOv2jNbeXqjP9ekY7rzy7auiEZ5PxaDWUQVAwEIB8J+BBgWCAAmAhsMFiEEBaQM/OcmnWHZ
 cQChdH8KkDb5DfoFAmgHpowFCQlsaBoACgkQdH8KkDb5DfoK+AD/Q4aN/zUvP72RRE4cNWpM
 MXeRXg+LTN+OJ24U10LltxIA/2w3kDqMC/0t1oqO8TM+c2LMWO/x2IBkG7oRZ/hVw1QI
In-Reply-To: <20260512-b4-context_reset-v1-2-439bee96ed83@imgtec.com>

--------------6t11bo4JSfpyXqjTryH2MJvt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Brajesh,

On 12/05/2026 07:47, Brajesh Gupta wrote:
> Check for job's fence in timedout handler and report NO HANG if its

Nit: s/its/it/

> is signaled

This could use more explanation: _why_ is returning NO_HANG in this
instance the correct behaviour? See the kernel docs section "Describe
your changes"[1] for inspiration.

>=20
> Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
> ---
>  drivers/gpu/drm/imagination/pvr_queue.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/=
imagination/pvr_queue.c
> index d10a13173f0f..073478919b22 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
> @@ -851,7 +851,8 @@ static void pvr_queue_start(struct pvr_queue *queue=
)
>   * the scheduler, and re-assign parent fences in the middle.
>   *
>   * Return:
> - *  * DRM_GPU_SCHED_STAT_RESET.
> + *  * Fence signaled : DRM_GPU_SCHED_STAT_NO_HANG
> + *  * otherwise      : DRM_GPU_SCHED_STAT_RESET

The formatting here is off (and won't render nicely in the docs). I
believe it should be something like:

   * Return:
   *  * %DRM_GPU_SCHED_STAT_NO_HANG if the job fence has already been
   *    signaled, or
   *  * %DRM_gPU_SCHED_STAT_RESET otherwise.

>   */
>  static enum drm_gpu_sched_stat
>  pvr_queue_timedout_job(struct drm_sched_job *s_job)
> @@ -862,6 +863,10 @@ pvr_queue_timedout_job(struct drm_sched_job *s_job=
)
>         struct pvr_job *job;
>         u32 job_count =3D 0;
>=20
> +       /* If fence is already signaled then return no hang */

I don't think this comment really adds anything, the function name and
return value are fairly descriptive already.

Cheers,
Matt

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.ht=
ml#describe-your-changes

> +       if (dma_fence_is_signaled(s_job->s_fence->parent))
> +               return DRM_GPU_SCHED_STAT_NO_HANG;
> +
>         dev_err(sched->dev, "Job timeout\n");
>=20
>         /* Before we stop the scheduler, make sure the queue is out of =
any list, so
>=20
> --
> 2.43.0
>=20


--=20
Matt Coster
E: matt.coster@imgtec.com

--------------6t11bo4JSfpyXqjTryH2MJvt--

--------------FnlQZ8pXYZcS8ck1cJaAhySO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQS4qDmoJvwmKhjY+nN5vBnz2d5qsAUCagsp4AUDAAAAAAAKCRB5vBnz2d5qsNKB
AP4hcXUDu/xSLqWUK/NvYNwA8pg7Qlrh/dhR17BSU71QegEAlwEBbQDu3sModqwAS2zpJMpJpLU/
PT8r+LLQPsCaNgs=
=Wajg
-----END PGP SIGNATURE-----

--------------FnlQZ8pXYZcS8ck1cJaAhySO--
