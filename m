Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388A6C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9316A10E063;
	Mon, 29 Jun 2026 11:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="dSsJZ4UD";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="TIkJwKRw";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DFE210E063
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 11:05:43 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAXR6j2985572; Mon, 29 Jun 2026 12:05:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=Qh0sFVtfGftondrZ0dIg8PowylRCzkOzs/i596/4msc=; b=dSs
 JZ4UD/cTGXpBMMjnx5AM5J8r5MR4Au/wLxK4jqreKLO1DYg/9O5LLQNIc8opsqZ3
 m6oRqSeiSg2+uJvl+dalNDRGfobo32wZZ4zo0JH2GYQas5Er73OcVpgnrmTGgmfu
 wppRchUJ/4/brayhcTgwgFufEuycvDCDXds0jdlrahLYRfYoKbVesMr2FbTOTzGD
 6DuUP0G9IV+7vvLmvQb3+JyPLANx+wU25JiRp/nCyBbDqz/lAwA4idtLUGpxoXxP
 YDv4PhAdTQ+uexQxadr6bVA7q/0hiOKNe8kgHSdbx258gyjR+K2eQYMAat+w3A3d
 fDWW+NrYLCdTd58yJ0g==
Received: from cwxp265cu008.outbound.protection.outlook.com
 (mail-ukwestazon11020122.outbound.protection.outlook.com [52.101.195.122])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4f24snsn2x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 12:05:29 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFZaSN5tq8zn7Dk/wM7Uc/5pGDLoG7G+EWfM3lJ/TJaPJLs/02tidkMuz9twx+CifeiYi2aU813hytcdJ4x6SE7pKwrf2BkVl3Wo4YgzaJuJtHPf31NMq2b0PwBlfVjNefgzkryxxymK8eUoJ+9oNNjBl4D2Rv1FS0Mw8XgwfnOJ1K1SbfexhS9uPTEKplY6pKQ+emfentUF8AOFR/aWU1hPsTxkgVslRaZOiGBk9RyIV8IiiZVAMkrpNJI3mJ4MgM3gQcC1XcSOHRwuXcc1eUS7VvKGghVUdZWHVFnTyonuv3fFhy6+RvYI47oNyerFYfQPrWFpDm4Qc/0pZcaSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qh0sFVtfGftondrZ0dIg8PowylRCzkOzs/i596/4msc=;
 b=Q3EK+mX7KTJ0i7F+lD32lFLm69ZB09h6Nib+KCl8DJE5/nvnBnBe4K4ISp9oXRDklf+ZyRmGseFWn8sZ844JqCXVpMU0WMQDfftibvSqhQNlIolOX0aNJh4qIOQcxabmSji2VgmDLT7VzK7D4fYPEG5gMTDNK+y4W691NH96KP58KbUSsGFp0EjSDNIeosvXK5aL6PXRlu+rOhfWZcg7zjuCGJNzdQOqZpMp+iJnv8LnW5e9mAk/xNAYltJx6H22iRkYCxJd4eA8G0o3cfNAROO+ho5gKm7hpj/8eNNixdOu+ZpLcuuG9I7Ci6ZpSObBA/EKVwCFwOdBDJNr6jQsUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qh0sFVtfGftondrZ0dIg8PowylRCzkOzs/i596/4msc=;
 b=TIkJwKRw3BA+S8VptjuFi3JJ+s7O2G4RMwhGhU66chSfKyj9SzALFsLmLVb8F9hNV8tnUWrZ6aPin1226O536B02ccLKJ9mXz33ZjYZITVJwicRlxEfw3zuKL4XkkJSAIagcY8bXb3+r0Vj23Edum6nHaY5oFvWW/E66XJ6+Y9k=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO0P302MB1196.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:407::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 11:05:26 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 11:05:25 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>
CC: "tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
 <simona@ffwll.ch>, Matt Coster <Matt.Coster@imgtec.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>, Frank Binns
 <Frank.Binns@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/imagination: make pvr_fw_trace_init_mask_ops static
Thread-Topic: [PATCH] drm/imagination: make pvr_fw_trace_init_mask_ops static
Thread-Index: AQHdAv6cDuELNuAwok2enfCCyEYJ8bZVaGGA
Date: Mon, 29 Jun 2026 11:05:25 +0000
Message-ID: <055465207ab6f86f0d12b73a592bbecd9768c8f6.camel@imgtec.com>
References: <20260623105341.775693-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20260623105341.775693-1-ben.dooks@codethink.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO0P302MB1196:EE_
x-ms-office365-filtering-correlation-id: 1a72d39c-4c23-4b02-0f89-08ded5ce5299
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|38070700021|56012099006;
x-microsoft-antispam-message-info: JfKWHbO2NEqEpjfgsPE2CPmi4ytf2RZBYt8rl/wHlgUcjLgxiz5BEub2bjzXDz1/k8aLSiGImSfMsjn76pOyKQgpBlGnkCTmXFhNngHnpcAA7KaX5gTW+N4wqEkvUAekUzgBPxy/TnTrGLUHYmVLFSXAvhvR+EbLYz28rTRMuLPTaD8dEzqqlG2dfFJMFzpR8KFYzsJGa1Id6le6Tdqf6fmT4TJE/a0hzO+7wcmk41Do/FDvYLPUYryoU7x1dnOz5U3kmwAg/Fta24Zj46Ljnfzynk1IB7E50sLnXQkC0cwXgnBGDpY9npFC9e03J1rFNZMZiOKdEyfr2EFAvl0uU+hTV6dNj2/m1XfTZ7ASMVHtv9GztkODNPlcqR4kYgTC+Lz3M4Ua+t/bBud7caHRjVd8+VGejfewUEUizkaPdjmRKXOefIrAlxZTIXOUGJh9XabrFE1vjUPkwIlr38ONL+hGsXIwEmBBbG/2mowOsdJchzCjXEajV/02whWOfqrr3qpZpReqcErwPsQpbhcMzWigyXO5WCB3d8UpaA0hiNf+3ZRHMYD9cFDXnIW8a980znFcO45CyJqx2XEpPj/p0sbYMvjz1nHA5oh7AXA+E6HRnX5rZ4ooIkNCRrcl9d5Qtl2qcxVq/ifbao5UXCGt5BIG+YrgIe1jJJbCauGB+NIamIHhFbzfT38XHE4mnfflB9P1L8D504q4nVUHPvFEXlDudDgddVko9QKHwepYvxk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2IvNzRiQ0tVYnZmK0ZKU1NleFlDM0toUjU1ak9jRmFxbjRnTVVrcGJuNy9X?=
 =?utf-8?B?NFNOeVh3ZTRjRkltN1QzKzJoQ05vNXlnS3VJQVNoa0Y2K1I1TTFBaWJQaGNW?=
 =?utf-8?B?a21oUWlBbms4cFpKR1dnN0xhZU5qdHU0YXA1RWN6NWxjMnVqVHVOaVBKQ1g4?=
 =?utf-8?B?eGVHci9ac05kYzh5U25WZ2ZYZXJzVU9rZmN2aEFOMVhnbGxKWi9aR1hrMjlC?=
 =?utf-8?B?Z0swSEFyZFRNazBMK0thQ0dRNWFtZmFrdTloMnh2YnVrdXRnMlhYK09RYk1F?=
 =?utf-8?B?dE8yMS9FRm1OdEhzUHVVRlg5VEZXdU9zVmtZV2krYTdEOVBBMHhqaFN1aGZX?=
 =?utf-8?B?a2ZvTSt4alhFejk1YXJnai9zMDA3cDgva2ZSTHZzajdSQkU4a2Z0bERGSUN2?=
 =?utf-8?B?WHMxeStCdndxdys1VU5EdGIxRHV4RFpoTzRDSVhqTWpZWXN3LzdLNzV0TmZI?=
 =?utf-8?B?dHkzSjRMSnNQZDdpamkrYWQyVG13eG4vdW5DZWpaemJhVzhSVElGQlc5RGxa?=
 =?utf-8?B?elJRQjFkSWltQ01zQmNGWXFtUUZPWXNIMVFkODUxZ29FTFcyMUZHS0NvRU5W?=
 =?utf-8?B?aVhmeWtxOTdVVVpMRVh6NDZocndnN2VYaFhZQlVXWDVudE1kaEtsUnNidkdI?=
 =?utf-8?B?akROOVdidk9XeWpndDVEWnNwQmY5dlE2NGFEUmxpemhrMXJMQXF1WSt4WU9z?=
 =?utf-8?B?SFdPNFNET2J0SDV2ZDRyYWJEQVVRa0xKMDBoSy9MRklYMVQwZDFJVGt2eC92?=
 =?utf-8?B?b3JtdUJ4Y1o1eTc4NC9oT1VkcnN2S0VBTG9HTUo4NG5mdlhnYVFNZ3V1K1dP?=
 =?utf-8?B?S3BGU0ptc3NVZnhJYjRtNVNlMndUelZMZHVTOWdEWVNDMHJuaUkzYzV0aXhk?=
 =?utf-8?B?Vk5iNUhCM3lLb3pXUDFOVFJQM255WFEwQUNBek94U3ludzY3Mkp4Y3U4VXo1?=
 =?utf-8?B?Z3NrR3A4OHVpcS9CTTdWZDFlTlJqcmtaVFFBWXpIanZaWkVqbXNxdGc3OWh2?=
 =?utf-8?B?UUhmS2wwMERLYytxTFgwcWwweHRnb1kzSSt6MTV5cm5mUmdKaGxCS2pCM2xh?=
 =?utf-8?B?S2tGQmFjRUFSS2pjNXhZZzVJQUJBOEhDMXI3T1RUN3FsSVZ6ekJDMUNsUFNs?=
 =?utf-8?B?Rk80Q1Q0VnlzSEwvRi9lTGE1SVhyRkoxYUw4eThUcVpjdnBIUUJPVksxQ0pj?=
 =?utf-8?B?WUl3MEpnYUl3ZjZEVmlON3l0NnIzT2xHaWNmbEk4K3ZJYU8rTDJ1UWtOQjlu?=
 =?utf-8?B?c085bW5hY1ZoL3k2N2JCR2FmVFlpVlRQYjVGNVo0OXV2bU5mbXgwVnJ3L0ZS?=
 =?utf-8?B?SFR4VkRxdUt0QTRMc25LRnU4YWswcElzQjdBblhRMjNLaUdLT2F4SjU4UTJV?=
 =?utf-8?B?V2l0VXJUZE5XazU0QUpwWnRvVlBTTGRtR29UaEZ2aHUwbUFEVDRJbUxteitv?=
 =?utf-8?B?SG1FZzR6clk3NXhOSUFmNDVhN1FHMW5QVUlBKzRjRUxPTVYraUNrWGtjQmVk?=
 =?utf-8?B?a1BLd2ZxZWJKUkYyZkZnZzZ3YTVBd3FGT2dqYnlnRFlwOGxaWkJoUWdyYmRW?=
 =?utf-8?B?dnFkWno1ZUZ1SHVpNWdJazRVVEp5L1UzTzVoVkFrZkErTnBzWXpKQkVTT0F1?=
 =?utf-8?B?WXJOQ0Vyek5GNjVDV1M3RkVsWFdIVndIc3pqdzNUbkhJUHVpcmF3UERHUlRF?=
 =?utf-8?B?QmhDeHVFNHQwZ05XWDdJME5XT280dzd2OTQ4TGliTmZTSXpyWDVsUnlsL3pF?=
 =?utf-8?B?dDFUOVhLQ0VWVkh6MUs3L3lsMnl0VGV5clNUeEVJbXlJWkVsOXplTkZoY0Nr?=
 =?utf-8?B?MnhCaG9VNHpHQUgza3A0VGI3NFkxYnd6d3lmWTU0cTdiaklMVXcwYi8zaHFG?=
 =?utf-8?B?Ym1KVnlLZEVsMmExK1NLbG9nZmMrLzZWemhVSkNETFVZRVk2RWNZRmlaa2th?=
 =?utf-8?B?TFZ1V3g0RVNHS2lEaytiTHBZREsrOEtxR2QvSmdQRGw1aTVpRDB6eXlwczRO?=
 =?utf-8?B?VVV1UDlZZlpSQ0lGeVpUWWxOWExtZWRFV2VTUlBXZExuMGN6MklENGRZQlpN?=
 =?utf-8?B?ZVBHTWdERTUxZzdwM3lkdXZ0Ym9WbVp3cW91enVscGZNb1pIRjFRNnlzRWxw?=
 =?utf-8?B?SE9MbllyVlRwclltNU9Wa3RIeUc3Y1p5ZlNMY1A2K2tVS3ptZ1prbHFWZmYw?=
 =?utf-8?B?bFhoSWk3aWRYckxpUHpuUzlKQWt4cnhobG0yT294SVM4bkprYUJwN0JGZ1Fx?=
 =?utf-8?B?ekNCUE1ydTJ0Z2FtaTZ4SytqQmxkYmFOaWxwVzdKRGZBYUM1MXE2aW51Z0V6?=
 =?utf-8?B?SUpFR1FRR1ZKS2pNWHBYbDJhWTFQS0htSTd5ZmZPejZ5dmNBMEV5ZnZvOVEy?=
 =?utf-8?Q?TnVzSplg5rj/wUpU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFAAE876EE206B43B51E84A1B284B87D@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iB4OYgOOj4rXyPPO3q7EZsiYRZRtjcZGkEuwO3kgEM6cOloV9iZwFVN80ejZfcxteGbzYUPFjnyg/tDDDR/1iHyfqZ3DpaDB+OvPgEB7fl4jax43NtxL9GqPFUNKcXJ6lTXIJMDDZ/51SW9QG4CRfadX4ai5N0V8FY/nVl9nnASDy41PT64Ex/alaniadcfypaybvPoE+B7HifAwGDqTUvmRtq7BrTpyzKtvts3AQrd32Sq3r0/6diYVDnRj/+HN/kAF/BuLnsxJSVBYBp843L4Vb9UJAYBEgFzIZxApoGeR2Bd0ZRVOitmIULp2lYieyf5MSjsm+70Hm7YVDalT2Q==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a72d39c-4c23-4b02-0f89-08ded5ce5299
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 11:05:25.8893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x2+MXUodLkD7bizmNs/BWz3Fy8oGQJNfbYMxR7cJIZOyty9apdVFFvCtc/jIzozhjLWcyCX3xjvX2MK12IhbIczCByMSn/79OegCzpHp3+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P302MB1196
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA5MCBTYWx0ZWRfXzNOdZKbgbnCc
 H2JMcPbk1IQHLwxoUkaMo+xKfbAl1ktomjSIuemxtrwl1idM/EZOupoybTWwmMoZ6YOWxHo/P6p
 Ah/RccF0Gg+IyexkS/vwY7ICTHGBsVQ=
X-Authority-Analysis: v=2.4 cv=We48rUhX c=1 sm=1 tr=0 ts=6a425179 cx=c_pps
 a=AAXxRdAQmdgPLU7KzgPeYQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22 a=1EsaE_6oAAAA:8
 a=r_1tXGB3AAAA:8 a=zs9F8P-ln-FCdrcqSUQA:9 a=QEXdDO2ut3YA:10
 a=3ZumFrijQQ-2J9H5h8ct:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: qiwrz7qpyCz-QZIc6VTkq2njxtgoidRC
X-Proofpoint-GUID: qiwrz7qpyCz-QZIc6VTkq2njxtgoidRC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA5MCBTYWx0ZWRfX3hoG1wZ5/4ek
 LQPUh3n5HA+GRUhtrMcEypPqFSzF6mowBN3O6tNVjB5IX40m6pzzXQQEk+bC2o14mhpbjUkEt2z
 R5xlhqQsb4IvpXTEMcwSbffx5SuId6BdmRar/zsllhcKla3mxjGgKEr2Mf/wB3rGiNhuIF9ENQ1
 tAbu/CSZD297BXgtbuiOqEiX0DomXbTqiYL/TDgpOxGR5jNs9IDjW8W/ZrCCGD8zO3ZXosELYBm
 qPuPLhkiOJ4CdlMzrboGRfDx3d/5kMdJ5dRXJpT8zKRE35uPFkZjpPfWZj2LFlgvcpbuE5tJrID
 SzKrO0ZE8KJVokurhp9oePZI72VTz4RMm14mKYLR2yDEUj3J/IBiJ+xgX6LxgXuZN/Qm1HzKK1n
 B9y6fzTJ8rC1KD1eNPiyg2HNqkjjSau8tLacJKT5ifdhKfVPi4mxFMfnKMVOOm0qYOCuH/K1dNN
 weov6RKwTaq4hSA+sFw==
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

T24gVHVlLCAyMDI2LTA2LTIzIGF0IDExOjUzICswMTAwLCBCZW4gRG9va3Mgd3JvdGU6DQo+IFRo
ZSBwdnJfZndfdHJhY2VfaW5pdF9tYXNrX29wcyBpcyBub3QgdXNlZCBvdXRzaWRlIHB2cl9md190
cmFjZS5jDQo+IHNvIG1ha2UgaXQgc3RhdGljIHRvIGF2b2lkIHRoZSBmb2xsb3dpbmcgc3BhcnNl
IHdhcm5pbmc6DQo+IA0KPiBkcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Z3X3RyYWNl
LmM6NzQ6MzE6IHdhcm5pbmc6IHN5bWJvbCAncHZyX2Z3X3RyYWNlX2luaXRfbWFza19vcHMnIHdh
cyBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/DQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBCZW4gRG9va3MgPGJlbi5kb29rc0Bjb2RldGhpbmsuY28udWs+DQoNClJldmlld2VkLWJ5OiBB
bGVzc2lvIEJlbGxlIDxhbGVzc2lvLmJlbGxlQGltZ3RlYy5jb20+DQoNClRoYW5rcywNCkFsZXNz
aW8NCg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZndfdHJhY2Uu
YyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZndf
dHJhY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZndfdHJhY2UuYw0KPiBp
bmRleCA2YmI1YmFhNmM0MWIuLjgwNWQ5ZjliYzFkZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9md190cmFjZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9pbWFnaW5hdGlvbi9wdnJfZndfdHJhY2UuYw0KPiBAQCAtNzEsNyArNzEsNyBAQCBwdnJfZndf
dHJhY2VfaW5pdF9tYXNrX3NldChjb25zdCBjaGFyICp2YWwsIGNvbnN0IHN0cnVjdCBrZXJuZWxf
cGFyYW0gKmtwKQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IC1jb25zdCBzdHJ1Y3Qga2Vy
bmVsX3BhcmFtX29wcyBwdnJfZndfdHJhY2VfaW5pdF9tYXNrX29wcyA9IHsNCj4gK3N0YXRpYyBj
b25zdCBzdHJ1Y3Qga2VybmVsX3BhcmFtX29wcyBwdnJfZndfdHJhY2VfaW5pdF9tYXNrX29wcyA9
IHsNCj4gIAkuc2V0ID0gcHZyX2Z3X3RyYWNlX2luaXRfbWFza19zZXQsDQo+ICAJLmdldCA9IHBh
cmFtX2dldF9oZXhpbnQsDQo+ICB9Ow0KDQo=
