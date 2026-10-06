Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E565CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A776510F204;
	Tue,  6 Oct 2026 07:24:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="kQSNJ2qq";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="Sgw24m9a";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 090FB10F215;
 Tue,  6 Oct 2026 07:24:53 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966e3iI2627652; Tue, 6 Oct 2026 08:24:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=+1LmlGlQxhkQsKFe9fJdMSWXFEqDNVdw8F6DW1kvnpc=; b=kQS
 NJ2qqL6CapMOa5wLC/K+ubXI7CVeyQxOKhkWWqzGzuvi4/TPkRyFBlbC+m87HObT
 V8OnPKrNm3LnpTrPrvaPjifXOS1o9t/zN9y3pxF/LgbH0BuQ1v7G2GA9zhQ2Myf3
 Ntb2yuU+E1r9PYV/W9mfX059cO5n23krztuEWP29D7p/93e3AxL5c6XUUCcOpz2A
 0ZpaHai5jjL/6UklkGzQSR1xM2Ddo85UkC+tUXMOxzevr8wpgGZ8hQ9I+TGXQZes
 g/4CwX6pF5KtYTEuEI9qRhLblm7TqkG0tQRBPFByNykeqbe26YqwafzM2zrm56eC
 x68zZnsFXmBL6Dxglyg==
Received: from cwxp265cu008.outbound.protection.outlook.com
 (mail-ukwestazon11020143.outbound.protection.outlook.com [52.101.195.143])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4h3fnt1d58-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 08:24:45 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jk2wNWVQiJjx8Uda1p2r/V4Gat9rsB3fpE9GwkwGwxAStPQqHlQPuRVMQayPaFJHziN7AyTgeF1+d8UaorTXY1mkHlc9jHIbW8vyGgsz3WUhedCx1/UyJkg8VD047XIORGGd0aNSjZep4QIrjn4QJAyh+zpDkKVORLKpTuJ0UPEhayljKB5oVzT/e+tcXpeKxbB/zJ9xPfs08VMaplNsTPuVgSUZCPPcRrSieiZx3gMemI1sS7/693mBWPEkZIIrO6CWSurM5kta0WyJWez2HPeyjR1OzYQVcza9Izng2VnErXhl5D1lyNdDJZYrT3PRP9N5yHHEzRAfDz/M6d8Z9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1LmlGlQxhkQsKFe9fJdMSWXFEqDNVdw8F6DW1kvnpc=;
 b=ApOOeyyIaYChUzR232fc3FIdWWL6lWFIImpLMgZXYT162XgtPUIfI/EgcHNbpotd0zt9VecmOCgZDAHHUtvn9mrlIrgBUTcx4Bf7pxa30ym9BcHBpxaNpgFUt3qaKv1VEEUzbOEDUw3bviQ3ovlsgOUYqR/jadrf99c4LNWcsUDkBSRF9kttwAO3U2+t2v94rQSkrqRnkdoei2n6Umz0gUv2kW/YrzG9PpKJqQPrDGNWigjwGPiD0xZAad7yzck+FfY8+u4dgkvO/eLF7dRSD6AS34wEKwppyI72GlPDNcC+ZI9mB8M7Fpz30zLwNFBU/klhSro0lyqqAkQcv7Z6bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1LmlGlQxhkQsKFe9fJdMSWXFEqDNVdw8F6DW1kvnpc=;
 b=Sgw24m9aixKgJ1Nsf13d0PT8nZ05lz8SAMakCW+eGQPlq9doOOJnFmzjmZ6OjFYC3kTIVIilLltSiLB2PDRZ6UnFznGPwKU6viqG4xC/9K8ESV6vwFOFmnrc2bY4w+A46i4qCjUDNVIW378P2K/bIStZjzuWiuCqoZ1aaPyyjOs=
Received: from CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d2::14)
 by LO2P265MB3181.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:161::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 07:24:41 +0000
Received: from CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
 ([fe80::9d56:bc31:7b9f:2f7b]) by CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
 ([fe80::9d56:bc31:7b9f:2f7b%6]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 07:24:41 +0000
From: Alexandru Dadu <Alexandru.Dadu@imgtec.com>
To: "gye976@gmail.com" <gye976@gmail.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>,
 "imagination@lists.freedesktop.org" <imagination@lists.freedesktop.org>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
 Alessio Belle <Alessio.Belle@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH 1/2] drm/imagination: Switch to
 kernel-style MMU defines and access
Thread-Topic: [EXTERNAL] Re: [PATCH 1/2] drm/imagination: Switch to
 kernel-style MMU defines and access
Thread-Index: AQHdUND8J85/MdyCCkascF971JADc7brqc4AgAR8DwA=
Date: Tue, 6 Oct 2026 07:24:40 +0000
Message-ID: <e392fbc385bf5db80287c1a82892648cbd57978b.camel@imgtec.com>
References: <20260930-b4-include-mmu-defines-only-in-mmu-code-v1-0-291eadfde23b@imgtec.com>
 <20260930-b4-include-mmu-defines-only-in-mmu-code-v1-1-291eadfde23b@imgtec.com>
 <CAKbEznsnKevHokY-ip6g7+TG+NQLJcKxaYEbqsKa47dM26s6QA@mail.gmail.com>
In-Reply-To: <CAKbEznsnKevHokY-ip6g7+TG+NQLJcKxaYEbqsKa47dM26s6QA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=imgtec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB2913:EE_|LO2P265MB3181:EE_
x-ms-office365-filtering-correlation-id: 682867bc-d23f-4949-f2c9-08df237ae2e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: dU9t2t04Q3YKGrLJonB9dTZzamVgCXNDmPryaqDG8m+yxl+37X60D+Wjxg9ItfibPbRUiDftPXyx0GnRjk9c2lxe9uv5suUKip86FLCg5EoxqlLR8t8W4esfj/JK3kYdwroY1vf8oLyVtfk4IgOPQ7Zlz0xAeqFNo9vYvSL/WWtU+YTeg3ffjxsvBp6i01JeDx12AanfAeu0iyjca4F8JbQie6xaK+AaRiLJtZo/wTqjHkyokc9tMWxKExrOXjZlF6dgrsyodx6jQegOJTNOa4mvHZrov8R+y/gwNlpl/aZ6kOWt1jbbIA5XVkgEvsnaig9bKtBeaAu3OBhcMN9AL9i0aAt0nyybtFoN0JVag0PMtHFYJKZ8aDmmN110IdN7GPbANTmOp3lzJEsw0whFp8964lBDP9LPmJd2M9lKwJOUy7q17joDxiLjVQ0oogcRX/Eh0hO/Ysk+dAarmoumBOFFKsrSsyI06AO9a6vWSrsi1yUp+mHh8xH+qwzPWGFwqLMSkCWd4hTg+HvcrI5vBZwjyaOhZ+AVvaYOeTxOzdo2migR7QxG/pnRdPKUR6PkKzwDIl3PL9P2Tazgd9PErGEh5uZsV0+hMS8s8kVk0+dnCvC9ITHTypVfJTUX7r7ChtvqLshdRmz7JvEZ6zEdgT/jsEzxdlvEPJ4FpufMkznSdSQ2UtkyozjYjnej4Jz/pDmVpuDalH8N9XVgd1dI6g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzM0T0dXdTRpN3dSTDNBYjdNOEc1WVR4azYwMHZyYnhqMTFCcEtqRmtLd1p6?=
 =?utf-8?B?emR4MWZ2dVFXcWFKL0ZNb05saEt3L2ZpbnBuVm9IdXpuaGFvV1ZiVFpMSWpL?=
 =?utf-8?B?N1JyR3ZIb2pnOUQwTVNxaDY5UlUyckhvSFhScXRtMGU3YWUxWmdER013dlNX?=
 =?utf-8?B?cjFWcGlqejhSRktDOE5qUDJxVXlycXdHZDI2WWdZVS90QmQyTnZFU3Eyb2hO?=
 =?utf-8?B?RVVmQjNiN2xOTDk2QlRMR2plNm5PQk9tSmxEUmdCK21kQzUxZWZkS0JJRm0r?=
 =?utf-8?B?dGU0R0hFeDJ0cjNpZURjMklWUmp0VjNoN1pRbWhXanU5NTFvWmM2OVNITE5I?=
 =?utf-8?B?WnMrRmRKWWJYMzhXZlR5NzlCT0hJc3VrT1k0aXFJaVVQeERyVmdLbjdQaEhx?=
 =?utf-8?B?d3krT2hTWXpZQ1hiMEV0d1lUOWFhTENUc3JQTW01KzNWMDZsdmc3MjJJUDZ2?=
 =?utf-8?B?TWVsOXBHNVdaMi8ramgxRGNIb0RzZVpqN3lCaHFveXc4WThna004blBMOHp2?=
 =?utf-8?B?ejVOUGpkK2kzcCtWV0krR3lIUXgzMkZad05mdmNsOVBzL3dydDdJM29VOXkz?=
 =?utf-8?B?MGpzUjNsbVRUd1dhNjQxekI0Rk1FOS9Edy9LaW03QmZBemhoOEZXZWZrWi9N?=
 =?utf-8?B?S3pPWVlDZ2NoR3o2UUVOK0dZK1dlQXRTZmwrcDVnNWdlZUdlcXhoNzFZV01X?=
 =?utf-8?B?TWdjc0E5Umw1U3A4NS9WM3NOT2dNdWZKaUhmdkJUMGQxY1BFQ1ZvZzFETGll?=
 =?utf-8?B?THNMK3NOZzJXRzZGMm96SWFTQ08yTHZmVmpyOHNYNnpYR1JPYzhFQlBrbzVT?=
 =?utf-8?B?K20vdVVBaHdCWGVOSkZuL3JNYW1rN1dyREt0eFZKc0dlNHlEb3dPZVhzZDVC?=
 =?utf-8?B?blVyQzNMRDJaQ3ExOE94aG1sZlRsR01YL2huOW5Od3JiNng1ZUZrSWYxWklF?=
 =?utf-8?B?SjB0d0FmK0RHR1czWnlONFBzOXlKWVZIc3Zpc3N5SkJsNUpSaGZUSWptdVJj?=
 =?utf-8?B?d1JCeGl3WENlc3lZTHFTWnJIYlU3TE5tVEZkdGJQZmZXMkJUY0ZmdDlxQ2xC?=
 =?utf-8?B?Z1RjcFhoZlpZek0wODRHNUdNdWFWUGFSc3JvaDBXaXN2MjE4dG5rcjlYVTho?=
 =?utf-8?B?TnIrZzJMcmpIc3BOZjJiZ0hnRWpSUWJqWFc0ZWNnME8wNjhBTmFTYjFsU3ZN?=
 =?utf-8?B?cTdhNHlQUnBrVWplTldmVTZiejczd1c0QnZLZm1TcUpYVmJHS1F6SHl5ckxa?=
 =?utf-8?B?U2U4VURyaHBBU21xTG12QlQ0VFBlS2p5V0ZhOUZ1NUU4T2IzelZ1MDJnSlk5?=
 =?utf-8?B?eFE0UHp1cVM0R1VqRTM0N0oxS2U1aGEydGhjZVR5VSt6MGZCRy9JUUxieUdj?=
 =?utf-8?B?UVdHVEJJOHBmbTVsMlFVb1FERXRWZnU2bmE4QWcvMjNNL29SRUwwMVU2SlZ6?=
 =?utf-8?B?aFA5QmtjTTEyZHpWc1NneGE0Z3FMTllhTXBMcFZTMGdMQ0xicElEUUgwUk9u?=
 =?utf-8?B?MGxSN0RkL1puOEdhRXA3TjA0eVBXNE1oNUpZVDFRT05vSW5GbGh4T1VmMW9y?=
 =?utf-8?B?Y0ZQNjk0N00rOWpuMHA0V0FjWGFKT3FCVEplRGxaR2VZdkhrSXVtUnhlWEcw?=
 =?utf-8?B?SlNFZUg2R2pkd2Y5TFZ6Qk9idFNsUDVQUnFWZlNHLzlaRHlPT2JyMS9lMXFJ?=
 =?utf-8?B?cURTa1RLSFVjbS9LMnZVWi82MCtqZ1lPbGF3MFJ1VWRHSHgrNDJFNm1EUmg1?=
 =?utf-8?B?ZXJvQkhyeXVaSDFLTzdySHJDMEFtMlNUU2JHZDRVczhmUU9JSURWblp6YlBi?=
 =?utf-8?B?bkp1Q2lVOXJLMkNrMHdHbzBicjgxZitQTitFRlM5UDJxUER5SXBzZlBOQVRv?=
 =?utf-8?B?dnRCZm9aYzMvQ2tNTTNFQ25FOWVEMnM3dUhDUVRPWldUNzhRUVk2S2VsKzd0?=
 =?utf-8?B?UHhHUzcwbm9hb2N6MXBEZFhXS2RGYk85cktobEdCVlEwVTRGM0xJRHg3VkZx?=
 =?utf-8?B?NUN1ZWFjczhxbXRoTkh6RFBDTkJMSCt4VkZjRDNoZkVXMXJRNVFvVFNaUHpp?=
 =?utf-8?B?bStGOVdhcDN2Mi8xWnlnWmpTbmdzRzQ1TFZnMXJRSTdxR1NxMkhSUUl4U01k?=
 =?utf-8?B?eEtkc3laZ3dpRVQzM1BGQmR1R3RmSU5NMFJ0K280cTNOWE9UOTVGbFM4SkR3?=
 =?utf-8?B?K1VaR2h4QXBISjBOL1hKL29nM0pvNDQwU2JHREg4MzllVXRNRXVXWm85clhW?=
 =?utf-8?B?R2J4bHpNMG1WZVZjL3J5UC9SSmM2U0k4cGVhZDhKN2dzZ0N5QkhKQ0FSQjdZ?=
 =?utf-8?B?YVk1VWErelhraHVML01XT291a0RKbWxuUXVkK3M4RkpIK09oRWhvdTl1TDdy?=
 =?utf-8?Q?RiVRILmWy/WYVwHI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F8CBE5386EF114C9E3DEE5A99B498F3@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PomAhXvPh9gXJD4wEzRhFGJA8QaXX9GmwlmqH7WclhMhrTZYDjBIE7TxUqTN6qtSbKPREZVEZbHsjFzoAMtodQhRBq+bYXyPpjTFExi8t+/9Q6MdUHTNGiU9MQKBgTNFCcnSyThvCler9ZRa7A0EKu1MiM6ti61kfbkuCkg1CEa/6Rnh8nMwaDpTtB43gBtIN7KvDCluxvPO29xEyqg0AVU8WvYNFSvueWA2ksFgCWB8S2KsvvSuvODyMAdbF7EUCo6gJ4eMleNqkYv3vFxG0RPY4xflUkcNFy6M57/eZK4Zvj86VaiwvCexcdKC5KX+TxkTN/Pwx0tlP55AppIYaw==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB2913.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 682867bc-d23f-4949-f2c9-08df237ae2e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 07:24:40.9242 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5yRoosX47RfRv7gwVYiTgiyTC2Kb+S0aZFbEy8tj5sONUr0/dNcLGqoVTl+1QobJOLJhnw05wKqCsisvYdCt2/qLspIp2Y0Jxa5DmRSu7zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3181
X-Proofpoint-GUID: 9qW6SAodc2KjaVPoZD9r9rV-kInMbvmX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAyOSBTYWx0ZWRfX6I/QWFgCXQBE
 lGX34eLpUyiXbdXTXJfBrH90TtwMZ6BUQjREee8x/B5ES/mPcgql5eIZxb2UZ4D6tryuiBOKKzc
 9XqECEd2/sZbz6Xb0gtUcp6EU1IrzrRC/cwJf/jcQZE53LZtke5i0f7h2C6uK1CJFR1+yB21P8G
 65lq3kwcP8z5e/Wq//n2l8GsM/cvFp8arcjpYIfnFP0t3YWuYgJFqGExdsw6l0foNi8Pjo7UIJv
 1ls007xNxe/iINo4TRU6h3FEJcCgf1KynFHX4Rp3eJw5faHk8oMubhgGxbv+jCJ+JfGej/6pO/w
 RhDsYM6ewLO2jjeJxzcnPoxj4QE6oA5+6sKLJjl/GPc/8TwyEEmGPwBIxlm3Z7N3hSMsx5eZQi+
 0bDLkfvuhdhLGBQzbrR8BeyNSNM9OFE4KYn/DDvagNgSvub9BD5nP32YzzDicUaceUV1KXmtbwc
 4jE7MmGumqzicAyIgEA==
X-Authority-Analysis: v=2.4 cv=TplzFzXh c=1 sm=1 tr=0 ts=6ac4a23d cx=c_pps
 a=o1j4euy/CfFVJZZtfdKMQQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=pGLkceISAAAA:8
 a=6h-PyHn9T5_YeZKCFDEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9qW6SAodc2KjaVPoZD9r9rV-kInMbvmX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAyOSBTYWx0ZWRfXwNudi3S1MUSY
 wlYpoYoUoKG0Sk9bHDS/JKLF3+mcY2jG2F9F2YTGw7Md2Vxkrq8G9ODnJ/ymHfwaIt+e6SPzHM8
 qP/yK2bP31DaMfZ27FsjA7p5zj+44/M=
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

T24gU2F0LCAyMDI2LTEwLTAzIGF0IDE5OjU1ICswOTAwLCBHeWV5b3VuZyBCYWVrIHdyb3RlOg0K
PiAqKiogQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVzIGZyb20gYSBzb3VyY2Ugbm90IGtu
b3duIHRvDQo+IEltYWdpbmF0aW9uIFRlY2hub2xvZ2llcy4gVGhpbmsgYmVmb3JlIHlvdSBjbGlj
ayBhIGxpbmsgb3Igb3BlbiBhbg0KPiBhdHRhY2htZW50ICoqKg0KPiANCj4gSGkgQWxleGFuZHJ1
LA0KPiANCj4gPiANCj4gPiDCoC8qKg0KPiA+IEBAIC00NDIsMTggKzQyNCwxOCBAQCBwdnJfcGFn
ZV90YWJsZV9sMl9lbnRyeV9yYXdfaXNfdmFsaWQoc3RydWN0DQo+ID4gcHZyX3BhZ2VfdGFibGVf
bDJfZW50cnlfcmF3IGVudHJ5KQ0KPiA+IMKgICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGFzc29jaWF0ZWQgd2l0aCBAZW50cnkuDQo+ID4gwqAgKg0KPiA+
IMKgICogV2hlbiBjYWxsaW5nIHRoaXMgZnVuY3Rpb24sIEBjaGlsZF90YWJsZV9kbWFfYWRkciBt
dXN0IGJlIGENCj4gPiB2YWxpZCBETUENCj4gPiAtICogYWRkcmVzcyBhbmQgYSBtdWx0aXBsZSBv
Zg0KPiA+ICVST0dVRV9NTVVDVFJMX1BDX0RBVEFfUERfQkFTRV9BTElHTlNJWkUuDQo+ID4gKyAq
IGFkZHJlc3MgYW5kIGEgbXVsdGlwbGUgb2YgJVJPR1VFX01NVUNUUkxfUENfREFUQV9QRF9CQVNF
X0FMSUdOLg0KPiA+IMKgICovDQo+IA0KPiBuaXQ6IEFMSUdOIGlzIG5vdyBhIHNoaWZ0LCBzbyAi
YSBtdWx0aXBsZSBvZiIgaW4gdGhpcyBjb21tZW50IG5vDQo+IGxvbmdlciBmaXRzLg0KDQpIaSBH
eWV5b3VuZywNCg0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3IQ0KUmVnYXJkaW5nIHRoZSBuaXQg
cmVtYXJrLCBBTElHTlNJWkUgd2FzIGFsc28gYSBzaGlmdCBiZWZvcmUgY2hhbmdpbmcgaXQNCnRv
IEFMSUdOLg0KDQo+IA0KPiBSZXZpZXdlZC1ieTogR3lleW91bmcgQmFlayA8Z3llOTc2QGdtYWls
LmNvbT4NCj4gDQpUaGFua3MsDQpBbGV4YW5kcnUgRGFkdQ0KDQo=
