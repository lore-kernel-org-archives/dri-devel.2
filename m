Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6712FB519B
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 06:30:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFFA810E07D;
	Tue,  7 Apr 2026 06:30:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="kz+ilfDR";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010020.outbound.protection.outlook.com [52.101.84.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82E4910E07D
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 06:30:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2/yTMsl0vSiL2h5t+Zx9k7IW116BsDaRZyRvET5JdFtR17VbttqjnWTGZbxBkaQBay/GuLShy7SHln3PoCBxmckzkOACYrGUJOhP4twZJzERrgmRLWbvKYnZezijs4YT6dtCaYFv5adxlAlZBIxh2XlojlVEkoEaFV013Sf7hodOGWqhJzHZ69WrbVo5q/JJx/XnGgHElDfwNFQyD3iKRSd0maKbu0dPu8k1xEsU38iGv6BxNVhWXyKfW/BPSIM+/iIS4n2b8mUe3N0hVAV7plT48aXeUf3FfDoSaUcZyUuE5Bagp5bWWSlGaxJZIkoqNSUsLeouTNx6BPBgREPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CJl+xnAgfrwVb/jIMqrjcG9LR0nOStaKXz2bt8iVkg=;
 b=a1OXD5/ivJJhmXjZxji/JwbgN2Sh8OgFm9x94sPuX6TjDI2gIj8NaNKJsBJYWcevUNLSbWrfrIn5qaPl91yDibq5Np6OQciuGPldgGnacLPQc+P144ZRGH+6Y4DjJZC5IyZvgr7P5ozjAMN2hAB7zVLXeSElxMk0mC18BVHDDmr0/xI6Jpfk6UZ3msImyyQntPE0eRNn0muXWs2SBNUNz0sHay9nqBYw3WTXeb8t0SfqYiLSlHh3b8cvqliw+OgpflE6kP02vlx+UjNMMIaC7puNeCSsGKJ4uqjEDzq9RAiDJLcRsdrspAJ9kWZkJPx3mb69XJv/z49NvtLNczz2Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CJl+xnAgfrwVb/jIMqrjcG9LR0nOStaKXz2bt8iVkg=;
 b=kz+ilfDRl+7u/YJyChrpv4xEyXjXBQdpbia+iv/jSeT67tFhjFY1NtsmqBleQta8mUFhdXCYcPazZKGtH2GCkAo94qtgpWL7WqB3yT+7dCnJIBPE4WlFQXPsGtMXlckYR054nJ00iZFLtgSw2Pw2NGzazn/c37HmcZPvHAFIL0879rEkE/v+7lD8Lwh5PYcaA/drt91F5bFZtQ0bnpFsjEZbjrlEoPmtsN10U8Sjy5R6DTNvDQPZkin1+GmswbBcwhjH7eGeJE7jdo1m+hEXaa2tAuyHhzrGkNn/90qdLAo/uq1b5E9WSHIkZG2BHGg41AhXZS1VDnHxWxx0Qbuyyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA4PR04MB7887.eurprd04.prod.outlook.com (2603:10a6:102:c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 06:30:01 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 06:30:01 +0000
Message-ID: <1d010c70-d2d3-4217-a55b-47edab815c6d@nxp.com>
Date: Tue, 7 Apr 2026 14:31:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm: lcdif: Set undocumented bit to clear FIFO at
 vsync
To: Paul Kocialkowski <paulk@sys-base.io>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
 =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
 Marco Felsch <m.felsch@pengutronix.de>
References: <20260402183351.3281123-1-paulk@sys-base.io>
 <20260402183351.3281123-2-paulk@sys-base.io>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260402183351.3281123-2-paulk@sys-base.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PA4PR04MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: e576b585-9d41-4432-1a8d-08de946f1857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|19092799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 959yF0l678+iwDPtxe475IsSHai3TTMH6d1pjoDR/0bss6Kb/PU2Mi1uiR0hybTAGoA+PqoUzBGgjbH5IbO1IhEVD+Ml02F7qJPJw7/D2KtfKxJPXiw5q5ib6a55/FoFZGyBrGKG1VEiVkTHb0QYl4UsUwxarmu6RUJnTIxN6NL6E+sOX28hJ85WBSqmPFJW/XRWmbtRUkhdcB2CcNWSFOL3IsaazzAK+dxcAd0feS7Km+XaFDETmky4tFxIsYwSn8KhNEL3mrNDWbj82XO7fNpZPuqlBkua0exwLnSFy/MRdZBRJXABA0i60+X/m4w8Oan6TQRvWFxWBLdsfSfFteulTe/SiIGCEsQbkdndXwwBN8gNocvhaOPoneIqx2zqdHObOc0noWRyfWdvZmPAq6RrSoTNwlnienExVdcR5ts6hfrfG3LHm/ujg60jyXXwhJC1qbEQCTvL7/d7CNYpZW997FaWPbmJVFNd+DPVEHl1jj13leu+QsdACHokeV4z3P9zBIPqVpGLMnDob3R2aaGxDPgNs1dfUekN4dARHCKvVKmf4jma3bq4uRKolpp4MvFpIK/BrtRVqFzpVmqBIbm3NfXsr2GjtDJAaAaiNtvYzohJJx4gtj5zX/x03P+9vdmyNRshAHXMiwvkUHP9qLEtcgbth1W8nOBmJ51dGBJDfyWWvCIer8Rw2VTF2pa5bw4EZw0BxxSz626ysfOKpUFugMLBHX2deqMAVC/ZNN4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(19092799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjRKSTlzWGYrVC9LT2l4aHJ0Z3dpY0wyTW5yb2tlN3BEa1hMNkV6VVp0M0dr?=
 =?utf-8?B?TmxPSGlvWjUvbTVrY21qTkx2L1RGaUk5QllnR09tV2o1ODlObDZ1a043QndY?=
 =?utf-8?B?S2traVlVaGNlcTRSclRGUkhrcEV2MUlUOTN3NHQ4QWhvNXBvOHh3eUx5SWlS?=
 =?utf-8?B?aDRsSW9GTC9EK095RDFqTnRORjZaOHhDWU0vL0hGL0g4dVJJN3hhVk4zVkpJ?=
 =?utf-8?B?RHpHa0ZlY29XTWUxcVZmaTZNaHkzUjhEOFBmLzhpMzhHbkN1N3RrSnYrL1dn?=
 =?utf-8?B?dnJLdDhYWVVoNXA5SFNra2pSR2o0ZzM4U0F5SlduZEZIaFZJRXRralZnMFJB?=
 =?utf-8?B?bkFxdVZJd1FOY1o4RWxaVG9QOXJlTjZOUlBwclA2NDRBNWkrQnhSSnlUNmUr?=
 =?utf-8?B?YTBTZDl1RzVmeDBSUlNNSmxKN000UHAyYmZDMFRJenl4TG1STGdoNFJ3M0hJ?=
 =?utf-8?B?Q0dKSm93RVpZeU1uK2lwTGtxeG8yZlB2OUhQc01IYVFlUVBlcmdhazdUUzhs?=
 =?utf-8?B?RCtTTG52OHl0cXlGQ3Y2NVRMT1NrSDM2a0M5cnpTU0pUcXNpT2w1YkYwdjU2?=
 =?utf-8?B?b0I2Q2VNM3FOSUpxU3VPNERtN25LZXBpRHZ5TzVzdUlRQ2hJZGJSenZ1SHpU?=
 =?utf-8?B?dGxOUzByQ2pNWEZKTjJRRW5adi9zRUpXdE9CVG9ScUZQdkZNMlFZbjV4L0hn?=
 =?utf-8?B?YjZkM3czRVFrSWsvdUQ0WTJPQVlXUkx0ZEc1Kyt0TFB4QWxGZHo3VVMxYlJq?=
 =?utf-8?B?TEpNdis5YXlyR0J2bm93bmpmWHVQWkRkVEZBK1hmd05ySnZXbjVnUHF5ZzJu?=
 =?utf-8?B?WmVySnlpbjhRTWxSQlR1OHRvR05qUG5TUzNuclVwaExzU082V2NjZ0s1b292?=
 =?utf-8?B?ZS9kUlhmYXhFMi85b1Nkdlp3b3NNMit2SUNyK1lIVWRQK0lLWDJNMmd0dDBx?=
 =?utf-8?B?QkhpQURPQlN3dW1IUWxJcFdzakJzUmREbzNmbC8zZ3VESUJBV0hSOEw1VG4y?=
 =?utf-8?B?VEp0YWRxbjBTKzZORW5SeTA1bG9tUUM0RVRSR2lRbWZpODQwSHhzNzN4YVpw?=
 =?utf-8?B?dkdUb3FRdjNpRGlhUXkzUzZmTVdOclNHblFpb3p1Ty9YbXZ5OHVBS21VdGgy?=
 =?utf-8?B?VHdLWDJEZ3NhekdiL1VMK1NKNVhtVFd4Z3ZBY1U3RTFjZzloam5tQkQwWld5?=
 =?utf-8?B?WVFjUzc2QkZkaTgxcWU1NDhsOGM0MTdzQ1FQbVZCcE81NGdMN3l5R1paS0RK?=
 =?utf-8?B?ZEJVK1RBWEZiQXNaZGZTYzNIQWJvUzQwWUthcTVUblBqSUlHallySEYyM1VC?=
 =?utf-8?B?Szc3OUdRYWlwdUJEQTJOVHJnTUo5dXQxZm90eElDV2tZdCtHTHlyQjdCdGo1?=
 =?utf-8?B?T0lqQStLdzhyYTN2UnV0MEdZdnhQM2RrVVNqTkU1cUZCQjZxazVGS1lqL0N5?=
 =?utf-8?B?VUcwb0FJenUrb2lrR0Robm1DNHhEV1JER3pXOHNqelRDdGtqUjZBWmR0MWJL?=
 =?utf-8?B?dDFmT1JxOGJPWUtrcVdpdEU1Z1FRMXVvSHFnK3pSNHRVRzVSRndsb2loWmo2?=
 =?utf-8?B?Q2ZxM0xDSlROMkNVQ1o2TS9sKzNma0k4aEdQQVBXQ3hsUUxDcVZXY05EODRS?=
 =?utf-8?B?VlpkVVFaM2VIc0pkaFhFNTdyaFpSS3NmZkNDaEVYUVpzc3QwRHdjZGd0WEI4?=
 =?utf-8?B?QjdMd3dRcVcxR0taT3lwYXRvdWxZc3Avc0hTajVNRUxpQld4VnZjM0M5bFg5?=
 =?utf-8?B?V2k3c2VLejJ0b05FNG5RNmQ4M3ViMHhYNTZLU040MktQa0drNXVUNWxkSU10?=
 =?utf-8?B?cDkwMlVyRlkwNjNFS21nNXBtWkI0VGo4bXpMbys3VGFnMkVtY1p3Wlh5WDBJ?=
 =?utf-8?B?Y09wLzFWVUdPY0VoRmhiT0FBTkE0YVo5SnZpajg1YXlGWHhKSHJSSmkwRGFx?=
 =?utf-8?B?U2cwVmFXZnI1b3dkVjVGZVh2VXlFVDRQMDBEbW5rZnBYd3FlelY2NVVycWFP?=
 =?utf-8?B?MnFZc3RuQmJEN1I1elc2TXdJWStrRWV4ZGhVVHBaM3Z0QUQweE9xVTJlam5q?=
 =?utf-8?B?a1oyY2RuM2tMNUlGbGdzelJSUndzVWF3NWdxSmFYRGw2NXVVOE1EV1czSWRw?=
 =?utf-8?B?YVhaUWwrdjAwcXBsVjUwYVVRVkU0cXBSWlRHQ25PWjhWcTVuQndLQ2dldGRI?=
 =?utf-8?B?bFFPVDJZQVYyaXlLbmM0dUgveVYxNjdnQnJYdUovV0JoTXVqQTFFRjA2bG1j?=
 =?utf-8?B?dFQxR2tQT1BLbU5HQ0IwQ3RPUm5XOGpOYmlpMFNqM0o2SnR4Q0VTOUd6VVRa?=
 =?utf-8?B?b1NUWFhUQVljOThONWtjYWErMzF2c25sR2ZlMFJKMnpzcncvTUpUZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e576b585-9d41-4432-1a8d-08de946f1857
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 06:30:00.9375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zN0UWD70hJV1FTjZlwHdHeYL5Y5UVUljXa09eUChJGdwafHXFllwv2+79/9dLoVVazZyDk7RzcpVM1ocleslYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7887
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

On Thu, Apr 02, 2026 at 08:33:50PM +0200, Paul Kocialkowski wrote:
> There is an undocumented bit used in the NXP BSP to clear the FIFO
> systematically at vsync. In normal operation, the FIFO should already
> be empty but it doesn't hurt to add it as an extra safety measure.
> 
> Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/gpu/drm/mxsfb/lcdif_kms.c  | 3 ++-
>  drivers/gpu/drm/mxsfb/lcdif_regs.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Liu Ying <victor.liu@nxp.com>
Thanks!

-- 
Regards,
Liu Ying
