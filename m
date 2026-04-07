Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C05FB519B
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 06:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCC3810E32D;
	Tue,  7 Apr 2026 06:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="egSJlnCH";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50BAC10E32D
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 06:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njxzMskurJJnFs2oqxzExm52tsGeYzcNenE2w7uAhuX7tdSpijfw/OVBNTimnjKc6bRSuW3Gu/ZYBJJQOrD8WpeBLzbvEZvsQ264wawt3k1H0hdvsGKT/ePTxJQaCTZElGDtd1JXuoggxUl9c28IY4F5Tu66oq4Id1l+PTMSreWLlCU6WAvlg6e5O0UkqRV6kOFwQCk93QFbEPrs9uP+IfjgIyHO/m7xWjDjIb7+ROlX0TM1Cr+vO2vK7XlOi+fYacD8dAsEOwPc1R7UvRVKh7k4l6kamO/XS0nsQ+h6+OXeMA046qHXUx2qOZjYX0b09INstT5YihxA3LqnBytBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1RIFue3tOxRIWmbA0AlCG8okArVMZO8hH22Nj/muv8=;
 b=WsXL3V2Zi2eH9h5302Vh8RgfBehzcJCZMwtcMv63ofvghcJbLI/W6er7GN2KhOZlhla37U5wX5I/4h8H3kxjcAB5sT3/tlDrEaZO+T36qXPhq64u5MlTBkkMMTSZEDMSDP5j3OMcH2O7Jdi5XoNcvqjZ4pH7ADPcj7GxsB5pN30ZAI4NhJrh9JYtFD0CweySW+8ApZALUuBijl+lgOPoH4iDwxgnyau2jdpx8LMw+srus8nQWCbx9t8uAF7uwOx+T9dNpGjI+9Xbpj6c+yWOtgKayhA+amiu+Y/uRTaMSxVghLrf93IkxWxW05SzgB3zgCqT5JgH6HBAT50gxpyocg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1RIFue3tOxRIWmbA0AlCG8okArVMZO8hH22Nj/muv8=;
 b=egSJlnCHSC+UnxPjBK2QOOYcKt1Ojfbn2FslSpbI6ArlpV87pI8giTohfJKelTKyNCvPcxuCHzlCIUG3fcXA+PCqVjpLJO05sQDHPkeytsx/poIpuoNjcOqqIjweUIqQsXfLgV6fb62TO4137xy8SiazMo7rus3Ta60tpICXUU9rcvMxT04xl9B+P3yVAOnVYITLvd+JCZAth1R9QgTV4CW5fR1Xm5n7A2JcDGtOWH+asptL7YToHiy3qQ+JeOv3Y5BGvUPV6/KwbcQ1M3/vnllbfrJ4m6sF6at+qoh8khtPYPFdlDmeB49NRp7iNEGtlt85F5fzu2pVJ4AkLQV8ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS1PR04MB9682.eurprd04.prod.outlook.com (2603:10a6:20b:472::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 06:33:00 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 06:33:00 +0000
Message-ID: <e626098e-3a77-4a59-a93b-f212a472ff8a@nxp.com>
Date: Tue, 7 Apr 2026 14:34:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm: lcdif: Wait for vblank before disabling DMA
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
 <20260402183351.3281123-3-paulk@sys-base.io>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260402183351.3281123-3-paulk@sys-base.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0149.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::19) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS1PR04MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: f160ce8c-10ca-460e-cd4b-08de946f837c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|19092799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: BGcd8ALVo6d5LRCB+FlIlMiAUKACIkncM9bCP+gVFb9/0ORPablfy4AwwLw2zMWx/VJ3DxWUaNTRB7G3TNf88ykkZjwQnGzdd+nOAoF0DM/2uQmxtlMAQF/FjCGXQ0LqWNqABvd7GSZaB6cvtSPWCEPFY4fBzrVMUsgs1pZYXDGiSMX49A1/ID12mGO9ytSPy+yCorMmn3IejC3quK1OmfcedEZYM6nXwSTHkrq1pod2vKUDr1wWZorehdJQI/VUffz9gEkcuvxoYe8Xtnl3YKdgX7eV1lYYSQL93bFFEgB4FP8iicrj7lWgbKEn7HMZF+SHFzkCXI9jxxpW4TzZvvD93CNY9LqsYTIdR7efAZb/zN+dZiiLVQN0aj19YtSSdJt/8oILf4BYGUsfW8lBCTov9V6Vjntmp6M7SXQ/5wQ8CUSDpCXklL9P5z6ovq47bJDJ2j2n1odlB6PVYbwhMtLcQuA075xSB2R0KLxyoBvzXtleMiVod5COCDQzpqDVXHs1tlTILf0Z1JBye8MVG7EX3Z4zEriET//ji3HDd+ieV6mq9zFaBW9Ssq0Lk4RqvltKP4K7tUDDEADjWasSYBT0Z2M1Js+yB7FRa89DMyna7arwM+kA+SDuPVkAWkZsJijJi51Z+RrUwfivDQCcxtWFwUCx2xYIL9qclzF+Wy6ixaqn/oJAJFgCI+nMe/vQKUlXAsro9Y56qaEoWYwPkvA2FCXbXbhSv+pbJdanZwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(19092799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG1TV1Nnc0RjRVBWS2VJU1Q5Qy9YTTF1ejhSNXlOSEwxeWw1d21sL1VISzgx?=
 =?utf-8?B?Tmd2cjR6SEpFdDhrMklyWE9jMGJvS1l5c25mS2xPcENOajhEY00zSWtGL0FP?=
 =?utf-8?B?VnJLY0wwZ3dUY0xMNUNtdXhXSnZYRUExY0thS09Edzd0Y0JhN0NvVXp6cDBn?=
 =?utf-8?B?ZmZkaWM3SncyNm1uZFJxT2p2b0toMXJ0TndnU0ljUElyTHNGQkovdWFMWE9K?=
 =?utf-8?B?d2k3eW1lSVZhSzNkM3l6MzhnenlYS2NINVcrRlplSUcvSVRZWW5qZTg5UWho?=
 =?utf-8?B?TU52Z0lycm1zRHRPeUdNa3ptM3pPQ00yZU83VmlZRmkrNysvU2tmd08zdWts?=
 =?utf-8?B?UzVya2hOQU1HNFJaTlNoS2NnM0RpOEIyNWVVQms2ZnVSYWljcHhMYXdwN2Rp?=
 =?utf-8?B?Vkg0SitDMTQzQ05kQmRmcDUweFdEblpZdERkVm04NU9WZ2ZwMlNhZEU2cWVH?=
 =?utf-8?B?MUc2a2w1elU5RzMxbWQwMkhhbTR4MzBvRHlidHRnUUpNSWVRampvT0pyRjJm?=
 =?utf-8?B?K1hka1QrTzZCY0pqSnhQaUtabGppZEI4U2Y2TmM5c2dPSmQzaWFlZVRCdjZp?=
 =?utf-8?B?YmZWcEoyZW1FRmoxUUtjZHZKbGFWUW1EME9udzkzNXVWUE5vWVcraC9MRTFD?=
 =?utf-8?B?aTRUbWlPOWNIOVZmeTI0d09CL1lmNWlHNmNnY1Ria0c5ZEtPVklBcnRKTVZU?=
 =?utf-8?B?UGNVODkxMURxVE50TE1ESml0RDdoOUtkU3Y4UWJVZnZmUEx2T0FQcGZnWVY5?=
 =?utf-8?B?bFlaalVlcURXVzJrTXNIZGJGU0UzdzZLK2hZeW5kaE43UXNYNnZ3YjNZRVFp?=
 =?utf-8?B?VC9lNDBBOU1TUkZ1bVFVZGtoSXJMakVTU2E3aFhROElpVlBFL3UzS0k4ZDBw?=
 =?utf-8?B?VGlXV0Rsays3dlNlbndmNTFWZ2g4dDhFUHo2M1lHcEIzN1gwYVdkN2lZWHF4?=
 =?utf-8?B?aWNsc3ovZHJMZlpmcDVReWp6UW03MzcvNzdzVnlBYTdIdTdJZjQ2Z2pkV3pF?=
 =?utf-8?B?aDRUdHNvQjUyMlZuNkdSRm03UVA3bXlad0xlVkdZMVVpa3diYXJXMStQV0dq?=
 =?utf-8?B?QzIyMG9JTGx4WTBjZkJRZFRwNFlVdGttNG5NSnZMeHJvY2o0bFpLNGZPVnAv?=
 =?utf-8?B?TG5jeVM2YVFjVkVrc2VEYk9Rb0h2TFlyMm1aMUswci96Mm1nTUFUeTdTTGxz?=
 =?utf-8?B?dmxteEI4T0IwRytXOFNaV21JTTFhVXNNRFZlcnF1RFNrYTZ6eldxL2tmN3pk?=
 =?utf-8?B?UkRFRWlFMUlCUjZXTktLRTFQaEt2VlA0WFBtUXRYckVRaTNJL3RmaFJRU28w?=
 =?utf-8?B?cXB3bkJVY1Ayd3gxZm50N1JCa2dnTUZPL3dmMTlPSXBZekFzSEdDa3E1YVVZ?=
 =?utf-8?B?MEVYQUJ4NGwrZHl3VW9NZkpJRElmdloyeHBRL3NsTkZVWHBqeHR6TG4zRjZt?=
 =?utf-8?B?WlNSUFhMZklKMWhMMHFhc1F0MTRnRUtweHQ3QkRTY3dRZUFmYWVkRUl3OENX?=
 =?utf-8?B?WmlpUGVhc29FN3JHU1hGalpRbnFzdWVaTkJHV0g0NUlIVEFFQi9wYkVzdEIw?=
 =?utf-8?B?SFp6T2p1Rm0rRWoxcXp4Q2pLVHdjL3UrYlNsdEZva3RTTmIwWjZma0tWQkE2?=
 =?utf-8?B?NFN6UUlUV0hTWVVOdUl2QmtEdEM2dkhHZmxPNlkvR3BGUGVKekNZQkY5LzdH?=
 =?utf-8?B?aWQ0SFdoNnFnKzg1VW5Fd1hSc05WR2JqTWhQV09iVHNDUmJkVENpQkhwYTJJ?=
 =?utf-8?B?TlMzbU9rZUExVjhGbmZyTmZLUEptTHVIcHV1dzVWRys5VnpDNW90LzkrV0I4?=
 =?utf-8?B?RWplQ2h4b3FHemlvOWl6RkEreExhSkFkWHFyR29hakxUK1l1RVc3R0JSbHRP?=
 =?utf-8?B?UjAvQjYvaFdUaVJKSUE4MjJ5U09KeDdwdWUxa0ZUcVNucXVyZm1CKzZZUUVs?=
 =?utf-8?B?VXFZT0IxajJsVldnUlFQVFk3TnhjK1ViZTRUanZoUzU2N2hlMmdMNEMzR0F3?=
 =?utf-8?B?aldtNE5BQUpRTVdRODVmTWdPMDZUL0tBQ0d4S3NRamxVeXRUQ2h4TU5CR2I1?=
 =?utf-8?B?QWEvNTF2akxzdHA0amN0d1U2UzhLSlVnbEZFZHRnU2hRYjhxTmNQNUgrQk1N?=
 =?utf-8?B?aTY0YnVFOFZ0WTBxUGczcWh0VDlLbjFnK0ZBWGpjb3h6bURjN2c1K2tQZ3NL?=
 =?utf-8?B?RHpETkZ5UFVoYnpPQ1ZRZGY0WXFyNVdEL1FpRFBGaDVyY216dkdKcXQ3V3Rn?=
 =?utf-8?B?MVdNQTJtM2pJLzZYZFI0MmFJWTJVOG1lanZBN0RwTmE1MmxHNEs3R1Joamhy?=
 =?utf-8?B?aG9iVW5MbzRsa2dqZTR2OE1IbHpSblNrSTRPQTlnUnk2RndtdHgrUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f160ce8c-10ca-460e-cd4b-08de946f837c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 06:33:00.3603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5SIIR5yE/aaqcR9WD8hPzpgDWlGhqVXVjZXqtD5SNUV90vsa20yw5o3DXSFsTf9rybXCOe9iC+ubUeMQYfx1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9682
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

Hi Paul,

On Thu, Apr 02, 2026 at 08:33:51PM +0200, Paul Kocialkowski wrote:
> It is necessary to wait for the full frame to finish streaming
> through the DMA engine before we can safely disable it by removing
> the DISP_PARA_DISP_ON bit. Disabling it in-flight can leave the
> hardware confused and unable to resume streaming for the next frame.
> 
> This causes the FIFO underrun and empty status bits to be set and
> a single solid color to be shown on the display, coming from one of
> the pixels of the previous frame. The issue occurs sporadically when
> a new mode is set, which triggers the crtc disable and enable paths.
> 
> Setting the shadow load bit and waiting for it to be cleared by the
> DMA engine allows waiting for completion.
> 
> The NXP BSP driver addresses this issue with a hardcoded 25 ms sleep.
> 
> Fixes: 9db35bb349a0 ("drm: lcdif: Add support for i.MX8MP LCDIF variant")
> Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
> Co-developed-by: Lucas Stach <l.stach@pengutronix.de>

There is a warning reported by checkpatch.pl:
WARNING: Co-developed-by: must be immediately followed by Signed-off-by:
#23: 
Co-developed-by: Lucas Stach <l.stach@pengutronix.de>

With this fixed:
Acked-by: Liu Ying <victor.liu@nxp.com>
Thanks!

-- 
Regards,
Liu Ying
