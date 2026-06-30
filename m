Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78FFC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 16:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF37E10ECC2;
	Tue, 30 Jun 2026 16:02:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="pLGW1Gkj";
	dkim=pass (1024-bit key; unprotected) header.d=IMGTecCRM.onmicrosoft.com header.i=@IMGTecCRM.onmicrosoft.com header.b="r/kwTm7j";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E9B810ECC0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 16:02:34 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEGi4S1808940; Tue, 30 Jun 2026 17:02:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 dk201812; bh=9mzVwtHcTR10E2KTpIKMeU08HBcTV04QabfYrMkR44A=; b=pLG
 W1GkjTY4AD54de6zj3LYgyis1hBMZ4HoYawuqZfbM3HOTARu3gzhtOPS7em5P9Ex
 dyPg5yutu5yMaGxka+BRLS/+iL/XBQzNjNtt0v7HZeh2sbBqN5S+q3yFTz24SCP1
 gXhG2MYAKg64l0i9vr8eLSDq1jCctAtzEv3HBQgHjRNC0xfSWjLOGZKOlgAxRaq8
 H7eVqrK+7rU1XafCl+Z46aCTJSmB+9fcE0AK82UJmXG9O0uIFln9sxM1l5nJjskZ
 ohgn3WQtXY2ipJV8fA+L4j8rVs/I9WLeABYquLl70N6nFbRpZuLbA9D8VM2Mtxrj
 zipINMclnY8gm8QW6aA==
Received: from cwxp265cu010.outbound.protection.outlook.com
 (mail-ukwestazon11022087.outbound.protection.outlook.com [52.101.101.87])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4f26kukeq9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 17:02:23 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwGYPURcRrT/5zQVKcMPZeNaF2UPL93jKHZVTV04kr2LpW97GjUzZ6HFM1GA27qpaAoVI4CCCK1eOGOzohbx2VbufUawcQM+xrmpL1X/c09x7L/y8f8dEzmeFoQEP9Qpi16rXbQ1h8FhrNQOIFjPZt89cGFUbnYY3HE2FFT3nEMDgBUHm2Fp6r8/Yps1KHHthzhKFMkVLdj5DtPGbJ7njif1M0IdsSXQjcg7AME58hJT68SAmVOUnqexwpxhwjskSviijKRNGvwEriwvV2qfjzO0/f8qLtQ/115xV80hmVupmNc0+FYTXNQ6ldxqH8bAGry8sNny/q0dAJafJUgWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mzVwtHcTR10E2KTpIKMeU08HBcTV04QabfYrMkR44A=;
 b=Syuc8TSw3A1k+Ap2QKcuMxWP7AAYlqVutgvosFDLCQp756ruI4d4D6zR+r/MJQ8ZtXa2i77M5ucXfareEsGbGI34E+76zoEUJpIKgignFE2v9nqDd6yHLy5TZcuZel8oFtIVa56+rFwDjlJeZA6GcIu+yyj8B6DHRRxd/XGZdwdlB2yxckktJTLl4Jy0GtOo0lVMXerVYKRDOI81Rb99/DiiiUijj3T1q0vjDFlv9yLLK4L8SXliIHNgNdMZnnVsQIVQt3BN3ETmzUWaCIBVV475ckO3usNjjdvP3wKMEsO6E0X8YNb91lFzLLwNyP+VMGZMUDM9aM1yK3Yl2I8RIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mzVwtHcTR10E2KTpIKMeU08HBcTV04QabfYrMkR44A=;
 b=r/kwTm7jo3aO21fb3ZP254KLpysgEBmLCBY/rJnR03Ut2O6l73uC9UCLjip1vqU1T4TXds3uoUF6UuQOc/7afB42xZlQke+i3vA9LndnNPLJ8KC8BkKOSN+vm6Kh0lg+72GXIqevJUEH2TFdxWVSy/yyzk2/fUSbGyPtb8zuFqs=
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:449::15)
 by LO7P302MB2173.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:44c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 16:02:20 +0000
Received: from LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e]) by LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
 ([fe80::3585:13b4:3133:1e3e%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 16:02:20 +0000
From: Alessio Belle <Alessio.Belle@imgtec.com>
To: Brajesh Gupta <Brajesh.Gupta@imgtec.com>
CC: Luigi Santivetti <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Frank Binns
 <Frank.Binns@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, Alexandru Dadu
 <Alexandru.Dadu@imgtec.com>, "mripard@kernel.org" <mripard@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>
Subject: Re: [PATCH] drm/imagination: Fix returned size for
 DRM_IOCTL_PVR_DEV_QUERY
Thread-Topic: [PATCH] drm/imagination: Fix returned size for
 DRM_IOCTL_PVR_DEV_QUERY
Thread-Index: AQHdB8/NXepZBwjcV02VWH45lG+DfLZXRAiA
Date: Tue, 30 Jun 2026 16:02:20 +0000
Message-ID: <4c801de86657965d35180271b2b11075748aa7af.camel@imgtec.com>
References: <20260629-b4-b4-query-v1-1-d17fe10b32c4@imgtec.com>
In-Reply-To: <20260629-b4-b4-query-v1-1-d17fe10b32c4@imgtec.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LO7P302MB2107:EE_|LO7P302MB2173:EE_
x-ms-office365-filtering-correlation-id: e8b25077-27c5-4938-a5b7-08ded6c0f728
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: F/tN+fLiJaIUXwt9ADAalbcCTFlRd/yHGBQUB6y8Kf9Na28qKyUJ70pSBvU06jSSmK/S6KVOxtmPaqMmJNOXlCueJbCJ7x09wCow7kmo6Nl9Kn0+/QJd+jBZHbheLVL6968qTKbiIDKf8Q80Sqct5YICYjAmM6SxY0LRKFqR4sNNZW2qa9UQe64YeqwQNGkFhTvuNuQh4wp3KMQyZCpXSDTuabOagnTPvhdLBdpzReifSnZM0BPEmVUAT4qSivo0DguvF+PqYxT0m9DRmdV8a9hqiCuPna0Gog44iSoIwc4DiLxZUImiCIpEr/ewlthkKbaRvKQDsJXEdxbGzTd8SJnaebHDTKlnyHZ82hF0icf/RNWgIeHh4KNT4H7gwn48dau/C0AHvLVv031N7QKQxu1/CO7T2tU8Qt+l3tah3aB+yJ2aSmZ3svGQ/rcnSXEqYEBi8HwDJN2r03gmjv8bw/eIpfZDXTtkWRuFasPAc9qw+JhUp71y3wK/3UB0qY1RKKEAYtufW1JuS7opGohKFNfkb88GtDStA/OIFK7M+YVvmnAZmwB2u9Qt3q2FagumjuonBbjO8YbcAzOIua0qUpEC6pHdR2tGIk7j/3nUVc/+1PH7WBgrkUZd7xLDL9qLG0ieoNgoF2/GwSJBv/pb0dOpn07434/g+rME2SIpNIJYVTwa+uVsNnWkNvBQMhqk9jNFYmV6hy9Ds9HK8Z6DCQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlA0V1hyZ2ExYktCYWZwYmZjNW1QUlVHem9wc2U0VXJMSjI5U2VUakpsSHpY?=
 =?utf-8?B?YlhmNVlmKzdhWlArWUZVSUZGSHJESDdRSE9RdlR3dkRCNFp0d2hYcnBQOW9m?=
 =?utf-8?B?alAwUW81djY5S0tvSVNHSzJ5Si8vajE4cDBDUThLN3F3VUN4V1ZCbHd3ZlRk?=
 =?utf-8?B?c2YzSjFicVUzVDhXa1MwWUN5S0Vha1oxYnhJQ2dBd3V4QjBjT1lMd1E3dk15?=
 =?utf-8?B?ZklOSmNqcWJ1dnVVZHA2SGJYdm9KZDllOWxhbThoT3NaaDlOdE5uVzJwbzdm?=
 =?utf-8?B?aE5mNlFMT2lIV0Y1ODZDVnljeEVURml0VVF1N2doOW80a2lqUlpyNmMrejJM?=
 =?utf-8?B?cVlhdERNUkhkUDhvd21SYWNvMW5uZC9UTDRaempKd0FobnpzSmM4UUZ6eDRS?=
 =?utf-8?B?dFJYL3AybEh4UkE5Wit5UWNZS283TW5wbEVPa2lZekNDNlZ6MEV6VnZwTGc1?=
 =?utf-8?B?NGU3c2xaaDBjY29jK2NVSlVmV3dUSEl1K2tjYm9VRnZOVklORzZsWTlyMkZp?=
 =?utf-8?B?aEZwUFYwUHhQQ2lrRzJkM2J2Q1BWWGE5WS8rTmNIQTkvclRwYzN5bEJGNDF4?=
 =?utf-8?B?U2ZHSHo2bnE4RUZGRWlVd1c2Skl4bTFrUWY4RXhRa3NOaE13QmNqS1Y4S3hQ?=
 =?utf-8?B?WFZlcm9rbEM4dmMxNXcrclQ5bHdaTThFTEY3UFZQRTNucUNrK0VVbmFReURO?=
 =?utf-8?B?OU5xSjRsYlNzWWFtSkJ1UjFrRVNqZ2IyMmhTYitndHRJTThZWm5wRzNIMnFt?=
 =?utf-8?B?LzZjNXI4ejN6bVptS2pXQjVKM3hiZXN3NWQ0WFc1UjFOUmF0UE9IM29nZXU3?=
 =?utf-8?B?aUE5RHYzYkk4YXl4Nk1JTWxIbUZLR2pldVNnNThDSzdyZ3o0UENURzU3dG1i?=
 =?utf-8?B?VHE5VVlZQnNvT2FWdFlRNGF1b1JkVW5DUk95ZDBrL3hJN0xSZFp5QXIraTZD?=
 =?utf-8?B?TjA4N2UzVWM1YmR1enhNMU9pZ3lqa0lkUmdjM09tYUNvOGVtaFYxUnR4T05M?=
 =?utf-8?B?RWowc3Q1T1BYNGZMdTRoOVFFL0JxZk5pdC9pa0h6bWh6d3Nuc1RNdmZjTnNz?=
 =?utf-8?B?UWtiVStUNlF5a1M4ZE0wUmtPSHFiUVpBeXROWEtHQ2ZneXE3bmpQSEZzTm1V?=
 =?utf-8?B?ZTBSbklFamptQVY3NXBlNVJoeXhrOTU1UWE5T2p3Mi82NHZhSmNmL25lbHFX?=
 =?utf-8?B?K2Q0RHRmU2t3eURTMndZVlptZDFqdE9qaEhkaW5Md29aMW9jTUl4N2pYMzR4?=
 =?utf-8?B?UEFwcndLTVpZQ0haQStaWU5kVWdWY0Zka0pkMkFQN28xT1d3dWtZa0xLSldH?=
 =?utf-8?B?MDdRcWIzdDlmUXRjS0JiZzUxak81Z0pHTDlZeGlOd1UxS2ZHNWJ2NTQyOTZ4?=
 =?utf-8?B?eVdHU2tYb3BuNXloWVhVVlBWOEhEekpMNWRLWWcrWUpDRmRPemwrTjkzV21i?=
 =?utf-8?B?NzVQTW05RlRianN3KytXeFIwSGU0eS91MUxjNm9nQU5wZWxESWxsWXdpRmZH?=
 =?utf-8?B?clJPMEdBTEY4Ny91VHE3YXBwdGRxWFo1d2EzbDlwMDNBQlI1TVYzL0JIOGh3?=
 =?utf-8?B?UC9icXA2Rm1qMTMxMDdZazZFcVhUV3pCZ2NESmZ5YmpRWWdobitWTmJDSkU5?=
 =?utf-8?B?ZWwvWlovcGR4cG1PQzJzTy9GS2hnb2t6UThqTGFHNDc2MVBHV0dlYUE1ZDJu?=
 =?utf-8?B?N0FRcmIxMnJwZTZreDVxOURjYkJTWDFYdFJxTjVNR0pwTUMyUEttR1FYSGF3?=
 =?utf-8?B?UUdmTE5EMlowUXdpcXBnUDkxbytjTUg2LzZKeTc4WXBlSjNkMVUwVzhaV2RW?=
 =?utf-8?B?LzZKQXFwWExyRE80NU5qZ2czcmU1ekQ4ZmdNTU9PcUhqQmxmYlovT25pYXRB?=
 =?utf-8?B?S0NNQXdtVFU1RWUzM2JlT0l3SUxYUm1sY1NsblQvQ2QvRWp2anZSNDZWQ1Rh?=
 =?utf-8?B?NDJQbDNOUmhrUWdDNlhLeGx2U1RYNU96c01OQll0TG9aQkFFTEV2aHVkK2hn?=
 =?utf-8?B?M0l2dlEzOXdUeFZNMTFMWXdlQnhCSmZyenl0bWpENGl5WU5yeVBRVUJYTUxr?=
 =?utf-8?B?cU9wVkFQMmVvVElnTHd0blpaVDFUYldIbHVZandCTjZtNm1BT0NYOWRFcmJ3?=
 =?utf-8?B?aUdUWDhXQmJ4MktOZnFIUE1zZzlHZHN5dzl6bXNuVkdFSWlKUExMMDAxQW5u?=
 =?utf-8?B?VExoQWxkOGlaSEVkSnZReUlvVWJtdmdJZDBjcGZVRWJsMWp2TXREV2xWMkdE?=
 =?utf-8?B?SW10WHIwWkRGajM2ZWVKVGd6ek1ub1pOeWdMby9aNmFkWlJ6SDJRS2gxNUZO?=
 =?utf-8?B?RVIwYzN6UUduQ2czb2hIY25WbnE5am5BUG54d0RHZGxGbHBvUHV4QzJ6SkVQ?=
 =?utf-8?Q?APikTHFVtLaWYSrE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A02008FB251E04CB2F49102C032A237@GBRP302.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XEIteTvX+6j+aySxn+aKTe3fsJNklNg8kXIs+D9rZEFd/HCIHIxYnSg7ryKbXB+9GzXZFd9o59XjSalq6VQr0YRSKSSvwv0BFe5mQBbA4zcDqXTww4FcIgPSswNdgCMvd1Jxc2MBzbEHSEyI5nLM7l1ebqZLXoEt3W71OCf2gInPBzUi89t86XgnMUzSuooLydlW1Git/TcrBrLZ+VPITjpYrpm0SHXGp+paFM6pgDZ3WmdaInbrMAfqN+KoMOFMZzCPoo2XBT8G0yS7t9gDJ7rqeYgHB8SGPR55gIsoLhTWKvCQn/RdvePjJ9Y+pEFm+eECgCRlp3Z2xcHdAEcgjg==
X-OriginatorOrg: imgtec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LO7P302MB2107.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b25077-27c5-4938-a5b7-08ded6c0f728
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 16:02:20.1519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dJsCcVd9tOhqwjgTzwN6rCZozV2WkEQ7saszo0whaLeztSvCJALgErnaE/BL+1CJgMpQDTZwAPfGb6JBN7PHeW+EbUa+yfMOOeiNudw2qaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P302MB2173
X-Authority-Analysis: v=2.4 cv=epXvCIpX c=1 sm=1 tr=0 ts=6a43e88f cx=c_pps
 a=5hPqcOsJug9WD/dtoxD81w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=NgoYpvdbvlAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22 a=r_1tXGB3AAAA:8
 a=XByEYnlmZdS-AOJI35UA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: nnxIj7u29aQ9shJXy_O_tH5KnsyzBBg-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE1MiBTYWx0ZWRfX4/Vv7oQsrapg
 whD8aSzOJXZvbq64uAHMtfh9Ei7L4jPrIf/3Gs+sVvTxO/eJ8/GSdZhEiybRn6UPcgL8IIH7eUO
 8UQW+iU1pvVKI9cXR+X5EKqeVuaelOIomG52AbFoFkvetFCRKDcwAGPoNAkF4opm/ZnLBEoTGy4
 9KOoUO4mN/pwb94cr/mJHcN+QIx0sXQB9Dhs7vKa9UmX1EeD89eIdNH5OaacTewJTibSTNa+rsM
 dABC1leb5ZFXkix0IkOVYhQch41/QFM9I9K7jNao9zUqc8YelDWhdNByV59j34zDPZzoc4q63/4
 8WM0fetj3aIIOKlcauoi/WvoldCx2aQVbP6QqgzepwRUNzjojrpF3u6N89pesKeba7hzFM6bgyo
 UxulUHEuyUJSWff7Ty2Bhcc+wmL0MHMaDBaOWBjidbbmV6V7RpHISTew9IvPAzbMQafAX0Q3byS
 yEm+pUonyiur6qPrLBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE1MiBTYWx0ZWRfX+UlciIbCDlCw
 DPONLhlaNIPd/T+SUOHP169gsqd8mHNvwlCNWnIVpz83YOXa9ZKCm3iJKZiVEIlG8zRpGu0ku9N
 y9rEEB47ouSSrEfpILP9xuyGBcZiuqQ=
X-Proofpoint-GUID: nnxIj7u29aQ9shJXy_O_tH5KnsyzBBg-
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

SGkgQnJhamVzaCwNCg0KT24gTW9uLCAyMDI2LTA2LTI5IGF0IDE5OjMxICswNTMwLCBCcmFqZXNo
IEd1cHRhIHdyb3RlOg0KPiBGb3IgYSBmZXcgc3VidHlwZXMgb2YgRFJNX0lPQ1RMX1BWUl9ERVZf
UVVFUlksIGRyaXZlciB3YXMgb3ZlcnJpZGluZw0KPiB0aGUgcmV0dXJuZWQgc2l6ZSB1bmNvbmRp
dGlvbmFsbHkuIFRoaXMgd291bGQgaGF2ZSByZXN1bHRlZCBpbg0KPiBpbmNyZWFzZSBvZiByZXBv
cnRlZCBzaXplIGJleW9uZCB0aGUgYW1vdW50IG9mIGRhdGEgcmV0dXJuZWQgdG8NCj4gdXNlcnNw
YWNlIHdoZW4gYXJncy0+c2l6ZSA8IHNpemUgb2YgcXVlcnkgc3RydWN0dXJlLg0KDQpuaXQ6IEVt
cHR5IGxpbmUgbWlnaHQgaGVscCBoZXJlIChwcm9ibGVtIGFib3ZlLCBmaXggYmVsb3cpDQoNCj4g
VXBkYXRlZCBiZWhhdmlvdXIgbWF0Y2hlcyB3aXRoIHRoZSBkZXNjcmlwdGlvbiBvZg0KPiBkcm1f
cHZyX2lvY3RsX2Rldl9xdWVyeV9hcmdzLnNpemUgYW5kIHdyaXR0ZW4gYnl0ZSBsZW5ndGguDQo+
IE5vbmUgb2YgdGhlIHN0cnVjdHVlcyBvZiBEUk1fSU9DVExfUFZSX0RFVl9RVUVSWSBjaGFuZ2Vk
IGFmdGVyIGFkZGl0aW9uLA0KDQpuaXQ6IFR5cG8gc3RydWN0dWVzIC0+IHN0cnVjdHVyZXMNCg0K
PiBzbyBjaGFuZ2Ugd2lsbCBub3QgYnJlYWsgYW55IGNvbXBhdGliaWxpdHkgd2l0aCBlYXJsaWVy
IHZlcnNpb24uDQo+IA0KPiBGaXhlczogZjk5ZjVmM2VhN2VmICgiZHJtL2ltYWdpbmF0aW9uOiBB
ZGQgR1BVIElEIHBhcnNpbmcgYW5kIGZpcm13YXJlIGxvYWRpbmciKQ0KPiBGaXhlczogZmY1ZjY0
M2RlMGJmICgiZHJtL2ltYWdpbmF0aW9uOiBBZGQgR0VNIGFuZCBWTSByZWxhdGVkIGNvZGUiKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBCcmFqZXNoIEd1cHRhIDxicmFqZXNoLmd1cHRhQGltZ3RlYy5jb20+
DQoNCldpdGggdGhlIGFib3ZlIHNvcnRlZCwNCg0KUmV2aWV3ZWQtYnk6IEFsZXNzaW8gQmVsbGUg
PGFsZXNzaW8uYmVsbGVAaW1ndGVjLmNvbT4NCg0KVGhhbmtzLA0KQWxlc3Npbw0KDQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl9kcnYuYyB8IDYgKysrKy0tDQo+ICBk
cml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3ZtLmMgIHwgNiArKysrLS0NCj4gIDIgZmls
ZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZHJ2LmMgYi9kcml2ZXJzL2dw
dS9kcm0vaW1hZ2luYXRpb24vcHZyX2Rydi5jDQo+IGluZGV4IGNhMzA0MmQxNDI1My4uZWU4NmM3
NGRmMGQ3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX2Ry
di5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pbWFnaW5hdGlvbi9wdnJfZHJ2LmMNCj4gQEAg
LTUxNSw3ICs1MTUsOCBAQCBwdnJfZGV2X3F1ZXJ5X3F1aXJrc19nZXQoc3RydWN0IHB2cl9kZXZp
Y2UgKnB2cl9kZXYsDQo+ICAJaWYgKGVyciA8IDApDQo+ICAJCXJldHVybiBlcnI7DQo+ICANCj4g
LQlhcmdzLT5zaXplID0gc2l6ZW9mKHF1ZXJ5KTsNCj4gKwlpZiAoYXJncy0+c2l6ZSA+IHNpemVv
ZihxdWVyeSkpDQo+ICsJCWFyZ3MtPnNpemUgPSBzaXplb2YocXVlcnkpOw0KPiAgCXJldHVybiAw
Ow0KPiAgfQ0KPiAgDQo+IEBAIC01OTYsNyArNTk3LDggQEAgcHZyX2Rldl9xdWVyeV9lbmhhbmNl
bWVudHNfZ2V0KHN0cnVjdCBwdnJfZGV2aWNlICpwdnJfZGV2LA0KPiAgCWlmIChlcnIgPCAwKQ0K
PiAgCQlyZXR1cm4gZXJyOw0KPiAgDQo+IC0JYXJncy0+c2l6ZSA9IHNpemVvZihxdWVyeSk7DQo+
ICsJaWYgKGFyZ3MtPnNpemUgPiBzaXplb2YocXVlcnkpKQ0KPiArCQlhcmdzLT5zaXplID0gc2l6
ZW9mKHF1ZXJ5KTsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2ltYWdp
bmF0aW9uL3B2cl92bS5jDQo+IGluZGV4IGUxZWM2MGYzNGI2ZS4uMzk2ZDM0OWZiNmNlIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaW1hZ2luYXRpb24vcHZyX3ZtLmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2ltYWdpbmF0aW9uL3B2cl92bS5jDQo+IEBAIC0xMDE5LDcgKzEwMTks
OCBAQCBwdnJfc3RhdGljX2RhdGFfYXJlYXNfZ2V0KGNvbnN0IHN0cnVjdCBwdnJfZGV2aWNlICpw
dnJfZGV2LA0KPiAgCWlmIChlcnIgPCAwKQ0KPiAgCQlyZXR1cm4gZXJyOw0KPiAgDQo+IC0JYXJn
cy0+c2l6ZSA9IHNpemVvZihxdWVyeSk7DQo+ICsJaWYgKGFyZ3MtPnNpemUgPiBzaXplb2YocXVl
cnkpKQ0KPiArCQlhcmdzLT5zaXplID0gc2l6ZW9mKHF1ZXJ5KTsNCj4gIAlyZXR1cm4gMDsNCj4g
IH0NCj4gIA0KPiBAQCAtMTA2OSw3ICsxMDcwLDggQEAgcHZyX2hlYXBfaW5mb19nZXQoY29uc3Qg
c3RydWN0IHB2cl9kZXZpY2UgKnB2cl9kZXYsDQo+ICAJaWYgKGVyciA8IDApDQo+ICAJCXJldHVy
biBlcnI7DQo+ICANCj4gLQlhcmdzLT5zaXplID0gc2l6ZW9mKHF1ZXJ5KTsNCj4gKwlpZiAoYXJn
cy0+c2l6ZSA+IHNpemVvZihxdWVyeSkpDQo+ICsJCWFyZ3MtPnNpemUgPSBzaXplb2YocXVlcnkp
Ow0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDYw
ZGMwOTQ2YmJhZDNlZWY4YmM2NmE1YThiMDliOThkYmM2ZTA5YzANCj4gY2hhbmdlLWlkOiAyMDI2
MDYyOS1iNC1iNC1xdWVyeS1iZmM2OGMyYzVjZWYNCj4gDQo+IEJlc3QgcmVnYXJkcywNCg0K
