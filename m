Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B7B1098797
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8A810EB0E;
	Fri, 20 Mar 2026 15:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="MRTFQ2Ir";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="obOpZXdW";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00C1910EB0E
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 15:53:41 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K7uVm83787917; Fri, 20 Mar 2026 15:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=dk201812; bh=NOwM8u/drXcz9QS8GpCjszv9C
 +ZUPl/Bfljdrpx0yts=; b=MRTFQ2Irnd7sGoz2EVGHbm9jJVtO5TUHozDSx3diu
 5QeLoV4y0fBaIPyzaeH9PsnIcAVzxEkj6y6MgrDVW10N+W+P9sJOzlzIpWCA/OXk
 bPY45emNrLkdpbvFOD4n43cIChPya+cuF1V0QWarT8+sz3I0ITpdswrJwi9wtkHZ
 I1iRdNQtgGLkQ7JXAmg+ZA2U7v8wdJe3eCdzMaNmytjB/rjDUSFMTjFM9qXDAHKY
 KzK6VcFW+KPpMJ+5h2EO9sNGyaCLu1PsdZBTBE+UK1LREa1HZtTI2oVw/5JhS0H1
 669O3YRCOhvWp6NvDCoGoyv0+YgwhhtDB7OAwolwbwj8Q==
Received: from lo2p265cu024.outbound.protection.outlook.com
 (mail-uksouthazon11021073.outbound.protection.outlook.com [52.101.95.73])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4cvxtt545e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 15:53:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjYkyyDfPm2RkYXohiUU6MT3fTYp4a2iN5/1XWW3Uf7fLibbVDs6e+5zr66avhLg+k1hcJWCm9//TTZ/erkPds3m5Vfs4kJx+ADt7LCs+QoP3p1KnGLMw4btHWrTp4zBQNWpJLiEZ0OZFt9FWAbDLbNcjDGP4P9+7VSTAl6XNm6X2O0qnZPzcglJSksdGObhs/iD8s2Zq0niAd1xXTwbXSWh/VF2yI30cBhWVpw1Ke3ovFp4NpDBOpD0n6h29li33KY+AL00lrGcZwQli1WS85dMEfWj6ls91M7imB0sNoaR+dMCvU7lKboY58RyvICWcYlDnAKdC3lcQLG9tDRDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOwM8u/drXcz9QS8GpCjszv9C+ZUPl/Bfljdrpx0yts=;
 b=VouSnP1YBaRVVGPKwVvt21vMxT0fxMvQUuP0mQo4LLbxCnPIzal+Oo/tD1gIT5MSyP4LJeTUOS+Z7eiHWuKumMqrSHwlQ1lNxDjQLBW0F4Yz2vdbPbd3v1AU+GX/4VPNxfkW5xg/GaUpjgpcMurhJZqjpxLOm7NWtvNgAC6AXOPMj6nFXEXFhNjQqj7yRA3oDyxRi/e+t+8BiNWxqMfBtoF9cWgbWYr8bbNjZoP1yU08qyhp7EtbDLe8b679Shkh+jjEZXCIiLLb4ty05KA2YE7FfptSF1pZbhZaKjRnZgX6B1zV6vN4SDFbbcnSosUnZILmaPcwSIIFUpSW+xDYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOwM8u/drXcz9QS8GpCjszv9C+ZUPl/Bfljdrpx0yts=;
 b=obOpZXdWEKpRdskE9AZ+EUpJB4KwUDp+rAgo3MNqrm0ycXmdoCB4ojPM7wcuVOmNg19bjVKgReWNDPWvXayOqBcqO6sUQpuOPCFpTus9GE2H/q4sVt2sB17s2kku/kasrUCVCmPbDdbAxKEOuynIMTY20zqVfsSMHTt0/8UTsok=
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e2::14)
 by LO6P265MB6331.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 15:53:19 +0000
Received: from CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6]) by CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f32f:ed34:4f98:6cd6%6]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 15:53:19 +0000
From: Matt Coster <Matt.Coster@imgtec.com>
To: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Frank Binns
 <Frank.Binns@imgtec.com>, Alessio Belle <Alessio.Belle@imgtec.com>,
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] drm/imagination: Improve power off sequence
Thread-Topic: [PATCH v2 0/2] drm/imagination: Improve power off sequence
Thread-Index: AQHcsrQmw1/QAuuh+kaKv4pXH3g1/bW3ne+A
Date: Fri, 20 Mar 2026 15:53:19 +0000
Message-ID: <d8b3f09e-d55b-4343-ae1d-39e9fe73c555@imgtec.com>
References: <20260313-b4-staging-layout_mars_base-v2-0-9e3c251d278e@imgtec.com>
In-Reply-To: <20260313-b4-staging-layout_mars_base-v2-0-9e3c251d278e@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB3393:EE_|LO6P265MB6331:EE_
x-ms-office365-filtering-correlation-id: 94c5c9f4-9333-46e5-c3d7-08de8698cec7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|6049299003|4053099003|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: l7hwEgcM6WDdl1E7ZhH60BmpC3KILZPtcWdmJIouGXllS0A6lLY6KX7CLXdQZCDP5ueERm7GtRR8TMrLxo2dvdvOeXnrDRBCSlY9lF9trfaqFiY8WTN/nTYyF1PZD6rOfbua2M/IAjw8btHZWqbTncn/U2LlvxP0MBUwQvYUN/JVNsZ1YP+53A/gGBBtFnJ+N0Vb+0oSMs51UfmslpfMNCvGR6atHafLnoN0Y3/enhJM/dsxPMnl3jEQ2NVk6QsK07dQroOUnPGIlo+zc9+zwjPOeJXdYze0GycGKRdamV3TDGGULl3i4cCpoIkj1D6LGyrtAoENLaxp3mmuU40V1+TnuwE0C6x9L/ynW168UGjO6HgypP9FgrfeGxt9pcIlK8kgiV14cInixHxQx+MP6PnDU7DP6j1hpO9AojHyYjKofnzqcUWvxbeNPC1kccsl3HB6oiV+i9VUCXbyat4l62YJ8L3Qmn7YWODBVx89qK/t57yrtvN69Sjbzfnu30kRJL4RF1+lZJnwtOBCjCpnmA7qWNZK/WcQWfOQyRec8At26rujHqbcjuBPG62nwMvENbZvCYlGGqzLQvzXqM3axok83ACmPH7muyBCHeotpABdzm0aXkSdseqkTcyjuEY5eoaQDPXBnSZv+SSWLa7uE/Z4sXbB0aHiVsCU+HaBAebFENzfNXQWCp8XBe4ZqAB1jxKzxOW0srnKMc3crLkk2Z5imnXJmQ2QD1Tp42I8os7016HkLc9ZrMWXr7SxbDgQs0AJkdeZ0Sp55Ed5If0Sd8wHI51iNt7KEtXia9K8Vpw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(6049299003)(4053099003)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjhTWFZuTTY3RHBEbFUwS1JHWXZ6RWFreFd5V1JITDNJUGMxYk82QXRxTzhh?=
 =?utf-8?B?ak9ESE5jSWxyQTh0R3c0WEpZc0pTMUJtNFQ5cGtjcExVaHRvRW5WQUZDeFor?=
 =?utf-8?B?aTFnejdhMEoxSUQ0VG84Q29yYyt6Zks1UkxvcCs2VW96bi9Ca2J3TW4xanhn?=
 =?utf-8?B?dDY3LzBsUjJUd1NYYk56L2d5YnpWNXpYaTQ5QllHS0VBM0xYTlRWTkJOUlFk?=
 =?utf-8?B?VTFaQ290ZmhmWGtQeEJWOWYwc09yN0xiV2xCMFM5NFN3TGRYWEVrOEQyUm5Z?=
 =?utf-8?B?cUJrdURsNUdzdlhDbkNOdjFaOTJ5eVBFaDhGSEJGRFNTZDJ6ekx0Q0ptQWdi?=
 =?utf-8?B?MnFpcHc0RDA2eCtQNXpqNGNVN1l2Y3lLaXhiRjZwWHNIVmcwUVVGZXdDWGQz?=
 =?utf-8?B?WmRpZTNsM3Bhak11azlBcmJ4ZkRUWDJYVlJQdGtEVGFuRWtPQkpabzMvNUJi?=
 =?utf-8?B?M09veERqeE95MkZVTTZrV055MWRqNnVMYWtoVVBNdlBSOHBJS0hGTjlSZFpv?=
 =?utf-8?B?aWMvMk1laExteG9uQit0cUpEaDBWaGJ2NUowYnQ1NVhRZUVHblROeDA5M0cy?=
 =?utf-8?B?NkdjcG9DNHpTZlNOK1MrdnRkZitIYzhMRyt6bUZZc0pTU1Vaak94YXdpalp6?=
 =?utf-8?B?TDc2QkxZRkNNWHVscnphMEM5VUlvTiswVUxEVnQxbUVzWWhVcDhhZHlESnFl?=
 =?utf-8?B?K0ZaTGVxMzdqT1Q1YUtjQ2ZSU2hyS0E1QzVlVUtEME1YRDh6ci92QUV6NVpY?=
 =?utf-8?B?bjAzREFRV01nLzNWWEozSytkWmN3RDEwcEovWXJrQVNSOTN1RGZGdklvR1Ax?=
 =?utf-8?B?WjlGREI5Sjkvb0dGbWdRSVpNcFdqWXVhd21iU0dYeFNxY052bWhyWTR0VUxk?=
 =?utf-8?B?NEsrR01oVnpuZkJWTFk0N2hZZnZKRFp4T29rK0orSUFkVlkvMDdBUmtPeWM2?=
 =?utf-8?B?RmFhdjZGZ2JHT3g0aTVIZ1lRZE1LS0xNUWVyRm9RVjUyOHg3V3l4c2tGM3Jn?=
 =?utf-8?B?eXdoRWVxNzVYSmxvem1wRmdkZGZyazNTY0tDSDAxbTJ6cGdGeGlYc1c4L1RV?=
 =?utf-8?B?VVNnY05hTUlzbFN4a2piU3VoKzRGUTUrNWEyNjJmaGVIYS9wU3o4blh1VCtI?=
 =?utf-8?B?cExxNTNIU1piVHlVYlI5M2JKTzE2STBEbW1FTWN2UjNhbE5na3pWLzJRMU1S?=
 =?utf-8?B?a2h6ZlZhMjJHR1pWV2IwWHlJVWxEMHhMZS9pb3BjbEJJeUM3ZHVTZmVJRith?=
 =?utf-8?B?bTZ4bkR5VmhwMWRzKzUvT1F4cTc5eTdBUGJ3NlVrYU9ESFpXajB4eTR5K0JF?=
 =?utf-8?B?MEVqYklOT2JNdGNGYTJrcnRvU2VsZWlwK1JPYWMwV0I2TXlDV1pMRDI5RTU5?=
 =?utf-8?B?L3RFMEtNekxoQzk0QnJDUTJjZk5KNjNMQ1hKbHVkNGlqTEFhZ0hEQVZ2cWhX?=
 =?utf-8?B?MFJFZDdMS2o5Z09XWDJYSW5FeEJuRXdwQ0RLSFkxVW9Yamxjc21tRWZKdi9z?=
 =?utf-8?B?SHBVbTRkY0hMOElMYWx0Y2Q0TVBjK0dUT1V2VVU0WHBoNkxjT2pJdE5oNU5N?=
 =?utf-8?B?dVFkdmkwWEtrRXN5VTZyamJCTW1lNEdlalJmOStKZElJNDVXU1BIelVTUVhk?=
 =?utf-8?B?VkJDU0x4L0dOWURRUWY5YjJZWTJPQUlVMkdiNy9WVHUvdzd6NHd0bHlFcURp?=
 =?utf-8?B?Ung5U3kzeW5aeWtPN3B4T1FObWZycHNxYTE5ZG44S2sxT1h1Y0lUTlppTEt2?=
 =?utf-8?B?SjBJbUU3VGRzNkZCZjFjV01mM2lPNDBCNnNpejNzeTYxN2s0N1FHOHFhRWpX?=
 =?utf-8?B?TlVXZjdrWG8yQkFoVzRUS3lhUFhjaFUrWXhRQWJWU0xpYW1SamhpYXd2cURS?=
 =?utf-8?B?Zk1RQkRtVzBVQzcyTTNqQTFpY1Z6Q2xIempRZlozY1o0a2w5djFHRlRRc1Ba?=
 =?utf-8?B?RmRpbzZiY1NwSnFDSXdJaHFWenNtMjllOVhCd2JCNDlLVGVvTkhzbGVJYlcz?=
 =?utf-8?B?eGNXZWpNWGViY3d5R1ZnSVRUQnMxcXN3WlpLb2JDc2c4VnZBMzdhQU1ROFB6?=
 =?utf-8?B?WW9TZldPK3JuMUtib2NCZWpTSEthd3hMTVByNldDUkh5TTYrMWlDalgxd25H?=
 =?utf-8?B?c0UxcENsdDN0WHZydG4vd2dWY09QWm9xcUdMeEd6NVhkd0doSHVsVWRjc2JE?=
 =?utf-8?B?QVd3dncybVZXZFZCVTVvMThLbWlyeEpiVHZrVXZuZUQyVjdNUUdDOTI4NzlZ?=
 =?utf-8?B?b2liclpoWnpOdjFEYjBsRys5RDA2d1BpMWFreEMrbTJkaWYyaEtxYzYzNWtv?=
 =?utf-8?B?MmE4Z211SGVlZDIwaWlnRGNheEk0NGkwb1NETlc3Y0V5NjEyQ3g0SjJtbE9N?=
 =?utf-8?Q?8Xjko1KggLULcCFs=3D?=
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vJ5DhC9K60uinNdSA3flcThH"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Wlw8FjjGm+AXNsUDj68Os5u46O6E5jnYZXx/Os8WViISRUMVfdpeHeztMxwuj7JTza190ky0j+QAKV92/94ysblEVjeVRVI57q3UEz3TAJJHVY8xMZ0pr0+L4/U4UvCQYMmNCUbhg1Lly0vqQqaICXvYew/GIe2C1QW1t/z/Jqbl4jn00BqP9tWcryfmgfkMN0bTgSTpz/Qh6YMUA8z8MJJi/B6r0SOEjy4I0X4hQmyMtqgvuUlozzTXESGH0VkIxi5S8z3C8/4bXnrn7C83MBySQfV/y4kYaxHSo1JA5KjaUwgqBJo8D+BYMYjGJ6ukhDSN/Pw431zTxtpmDMWusQ==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB3393.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c5c9f4-9333-46e5-c3d7-08de8698cec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 15:53:19.5459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZsc7teB1BYsCgqg4kG71otwxXJROzL0ZDGbJqVkZnmEedCW4OxRmDsBqrxb3B6M35s19wsPDHA/6Mf/ljjc9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6331
X-Authority-Analysis: v=2.4 cv=L9YQguT8 c=1 sm=1 tr=0 ts=69bd6d75 cx=c_pps
 a=kh/0dvM411OyymgifXooKw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22
 a=qZQ2PDNLMSdLoqI-hfl9:22 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8
 a=rKb2RcOeiMbys3XQs1wA:9 a=QEXdDO2ut3YA:10 a=82Ohz2zFT7s77SuyCnEA:9
 a=FfaGCDsud1wA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: 4uH7SuJuTknRzrUlA5uPiQyA91ZfTYTw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEyNyBTYWx0ZWRfXz3KS9dWUAFDA
 8wC0dsENXzeXY2/rLutweMvoKreMGHvgKrnnMHQCbh+zszXVkWwpDLtQlvZj0czZP6nrzBhDlvL
 Ej2KamF94DYMcRltJZQ57CL+8ocG1yy7OYkdeGg9lB9JFcNFZi/Kn8ymJurxcqjWfco6FZdcYnz
 cjejA6K7oND76JUpK+I+Y0iEm7pXx0YywQS+jACGwJPBRHQGqkhhAyid26k9MtoY8FIuSBbB4J5
 e8BL34sUuxU6vbWNtza6sFtrWnVbc5+beP5tnQnkG00/gbPTyo0uMFsyjDsQQEb6XeoraLfuheN
 DFfVjTj28/nL7S+TWHNBET/43l0q+mRJ1bM6ioA7ePIzQRzRSMhyR+AlVNUl4I9EKoD3T2CjHYt
 D4ETNtUGNBXsuhH3ZMRV4/RtUWT9AVcW/h6deS3cDpP2SCrtfdGDR2niTN3CzsoX9NfKTloXSKH
 HFBYGJf4al3R8xHsWqg==
X-Proofpoint-GUID: 4uH7SuJuTknRzrUlA5uPiQyA91ZfTYTw
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

--------------vJ5DhC9K60uinNdSA3flcThH
Content-Type: multipart/mixed; boundary="------------WmJ0vOZc0VlVca6Q05HrKJFz";
 protected-headers="v1"
Message-ID: <d8b3f09e-d55b-4343-ae1d-39e9fe73c555@imgtec.com>
Date: Fri, 20 Mar 2026 15:53:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] drm/imagination: Improve power off sequence
To: Brajesh Gupta <brajesh.gupta@imgtec.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Binns <frank.binns@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260313-b4-staging-layout_mars_base-v2-0-9e3c251d278e@imgtec.com>
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
In-Reply-To: <20260313-b4-staging-layout_mars_base-v2-0-9e3c251d278e@imgtec.com>

--------------WmJ0vOZc0VlVca6Q05HrKJFz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 13/03/2026 06:38, Brajesh Gupta wrote:
> Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>

For the series,

Reviewed-by: Matt Coster <matt.coster@imgtec.com>

I'll apply this to drm-misc-next shortly, unless you (or anyone) thinks
it should go to -fixes instead.

Cheers,
Matt

> ---
> Changes in v2:
> - Patch updates as per feedback
> - Link to v1: https://lore.kernel.org/r/20260305-b4-staging-layout_mars=
_base-v1-0-09831fa17cef@imgtec.com
>=20
> ---
> Brajesh Gupta (2):
>       drm/imagination: Improve firmware power off for layout_mars confi=
g
>       drm/imagination: Skip 2nd thread DM association for non META Firm=
ware
>=20
>  drivers/gpu/drm/imagination/pvr_fw_startstop.c | 100 ++++++++++++++++-=
--------
>  1 file changed, 66 insertions(+), 34 deletions(-)
> ---
> base-commit: 68b271a3a94cfd6c7695a96b6398b52feb89e2c2
> change-id: 20260304-b4-staging-layout_mars_base-dfbbf1a53b3c
>=20
> Best regards,
> --
> Brajesh Gupta <brajesh.gupta@imgtec.com>
>=20


--=20
Matt Coster
E: matt.coster@imgtec.com

--------------WmJ0vOZc0VlVca6Q05HrKJFz--

--------------vJ5DhC9K60uinNdSA3flcThH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQS4qDmoJvwmKhjY+nN5vBnz2d5qsAUCab1tbwUDAAAAAAAKCRB5vBnz2d5qsN+J
AQDeabdXcTYKiDtJJR08ZZn4nTZL/32+qBSsknMxmT2buwD7Bbr+97Rdk6WCLcNNWg3hI2lHVukF
ViQU7+brNiotEgQ=
=sQj/
-----END PGP SIGNATURE-----

--------------vJ5DhC9K60uinNdSA3flcThH--
