Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7ADB106F313
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00F1410EA52;
	Thu, 26 Mar 2026 09:35:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="dka8fnzB";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB5E10EA52
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:35:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6rADiDT2W8HsDjj5DSeO79GqF6qVrvFflvjlru2gzyIf4NXmOn9j5yqlDByRIJhoUY9TdbZY3v5H2lU4M5SdVx6qZ086JkJi2V1dny0Ct8Ng6Rj0vaPHNKUAgGsDaR0W2YkvGH668LQUirv4rE8Sjn8Uqjb5w1HtBcaFppBa6yhrDyKteQVXe7g16B9aBkRIx+D2hmtE4s+N6e/FC0bIslmj2GqsgfMSNpXYFa3lkRkBnu4aXmTSJ2veCiDhIGgo2NDfMguOmjUgNHpZ+OrUeDmKYZbvvYBAfmiLhwwydq6s5dY+s2XyTLuYceMIrI8SE8tc/p/z0kGGHMLUcfo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XskJa8tRgknfDa9n00l52jlXufp16XSiRN/6i/Xx2vQ=;
 b=aElZDlTgwHjp8/E/BLc5B5Rcns/GdTZ3S4MVAW0dCIukYiIUISOVQUqO2sw1wOTzsbGsSlec5eOAjqP50RacJ+HHgIQNXAeEGSZgvMnAjXcNAUOHhCYhkNfQqVc5voTRmBqVKtA7T0pdWN5mDlwKIGKk8nqTdDkmVVyQI2uDZtrnG2Ems6xAFyuSnL03mwRB+mi2Qb0Sgor9Kb+wV8zLmuW/Rq74S+TwJj63qtaivgq5wAr1XDEgB5rNzep85PEhSxKZ+MkUMeF64E47AyLBSvA9HI5AZ40r/SK8BOpV+rrxX4f+yKZp9Tu6ZYih6yteGQ0hXhSwHQ0BVXmpgfjcIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XskJa8tRgknfDa9n00l52jlXufp16XSiRN/6i/Xx2vQ=;
 b=dka8fnzBj+X6QBQMwuPmnZ5ro2TX+GYw8mpZmNJE0CuPHUl5+kmDH8WjrxCtVwA9RIS1v/zdwI+6wgNmENUy5xYNvBYU6kscw2PyGj+y1b1yaBZtmgM40MCbmdBhh48dz5q2XfNM8Kr8F8U2+ZbaPf1/R1mRalYonWk6ABIBDk8rCjkUtVMsCrGGcVSj5WflcD0w33tozcwLHY4iKXgFPWc18UWQA+JlPMHdE5JVl2fSf7ogNYgFbMJTI4hVa4TzpBJWw8BfFg7IW2EimqK2p10Rsb+GV7UeN2W0Vq+u36y78xqQg4lcTReuf+whiNG9YvkEw/47I7vUEia4P9G1Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB7526.eurprd04.prod.outlook.com (2603:10a6:20b:299::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 09:35:19 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 09:35:19 +0000
Message-ID: <6d2e9c83-8652-427f-869a-20f7353f126a@nxp.com>
Date: Thu, 26 Mar 2026 17:36:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/bridge: drm_bridge_get/put(): document NULL
 pointer behaviour
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260324-drm-bridge-alloc-getput-document-null-check-v1-1-fb0877c49d7e@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260324-drm-bridge-alloc-getput-document-null-check-v1-1-fb0877c49d7e@bootlin.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MA5P287CA0273.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f2::15) To DB8PR04MB7051.eurprd04.prod.outlook.com
 (2603:10a6:10:fd::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|AS8PR04MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e2bb5b-b225-4fb7-b116-08de8b1afe7b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|19092799006|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: uQddI2gjIoBPF+6sIydUBykWKU/tXe9OGD3lHfKlieiMZ2yRTtNhsXIylhvG2ySIZDmO2/+KicxE2TsOpexTeC2wUHWxVzLXXJpQPAH++zcUWBTsFSkx+llP5s38XoTo2bNujCCSwDLDG805vUYJJOuDHCWrVduFZ+LYsaSJV/6o8wc4v8odSD2GAa58qUA62Xmz7WJfhK1XmbmLbH1sT/dEYVsN7bh5/HSJ04ndfMit9yn2b+9yr6yjBmsAdRmp42hdbnChH2qHAIH4S/vRuhhxS0AVwHZ9qtWRX8Qw+p2w98jCGBw7wPkf8osS+peh+aWKlKXG4HFgDJxhFpClx90yeRNdvgbOoO/FVHTtTCtx+HtlSWEVnPCl+6NMFyUU6i4gu04g05uy+aHtnapsuiH1Y7qwprDdoYUcuXNamftAg9yCLPyvNqp9lEWrfJ67Nii5SGDdmUP1Bi+FBLmBbgaJ1WT0o41iE+GXNk1E59rmN7V5ZG/xu/9rjUWgazdDvF5hEEYXh2xb2zaZh1BchyQ5lrcrhExGFuit8Tz07ZCD71e6PHeKATuhTXSlXJWY/XIhBZ4BK80oe/otpzrcLIazOJyh/PPce7ouxUjNHRLxy30gs57d0F0cpe4kFxx29H+UkhEj0A9Mk185I3ALGTdLrt1kRdWhVxvsq6gtt81Smw00jNlIibYHfTJhN9v/kwaaKZiZEwJy/2eFDaeEysF70JzN/xuTlGc1C5e5Z0FmqdmjmWzg7i1WwMxJoed+pb9O4cubypwxBAp0pqGK8eK+UyE2lyk0UNRPbxeJOec=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anZDSW91TXpQRDVLTWM0LzFLWVAvc1pEYUVVZjBCZVQ4bDRZd0ZTMjJiVkFX?=
 =?utf-8?B?R0pKTHBQbmpKQ0hramtkYXg2U3hsc2R3WnZPcC9zMjJqRHpzeVh3Zmx2NzlN?=
 =?utf-8?B?MGk2eG9zRmJIL25JMUJiL3NVbFlTbU1uRlVyVGdBbXZ6YjlwdXNuem1paXVr?=
 =?utf-8?B?Zm91dVdNRnBqNHF0QVZnKzhVNCtHS2NHeXlSWU1SUHVRbGVyYXJjK3FYVnhy?=
 =?utf-8?B?Y3A1YTVlR25VR1RKWS9hRWd3RFlSMldEOWJZamMrVmxwRkNjNVhVUHB3eVNl?=
 =?utf-8?B?YS9kc0hJMEYwVWdLQkphdFpGZm54dithR0VYYlpTNzUwUVcybS9zZktPOFhz?=
 =?utf-8?B?V0x1eFpjN0JTcXVsb09lTFdtQ1ZuV0lUY1lOQzNmeXYwK3NydndIZndkMk1R?=
 =?utf-8?B?OFY1eWtZY3ZaNEtmRE1Jay9sZktzZU5mUDNZWndiY0dkU3FPbXozU0Z3Rlg3?=
 =?utf-8?B?T0RFanAvcldla3FER0ZEMTdsWEhFN0UvL0l2cW1lSnllOFJRNjNvVkVuVlhT?=
 =?utf-8?B?OUg0WUJUZnFSSElvUmhNZGI4QzZKSDlsZkhNbURLbExQWC8yQlc1WjdTeG05?=
 =?utf-8?B?SEJkRFBpbVZaSVBuRkFVNVdQUWFVWFQ1bDM5QkZ2L1cyeGcrcU1CamRSeUpH?=
 =?utf-8?B?MW9uMEhPaHl3MElVN0d2bmNSTnlaQ2JaYThiNmp2ekxSclB4Z05ZRUVOSnhs?=
 =?utf-8?B?bTkwQjJNZTFnSEl2ZUFJQ2xuQXlKNE12ZGFJMHdzVG5FMmdtQ1dYZWx6L05j?=
 =?utf-8?B?TFRQT0ZBREs0K2JnM0ZOWDNmSmhNV05FTkxNZEYzbEZxQnI0WXlZL1FIQU94?=
 =?utf-8?B?ZkljUFhWVUkrN0I4SHFuUm4wa0ZONUk1dkd6eVdkWVdvQjNHeWtsdEdUeU1o?=
 =?utf-8?B?WE9ubnRmYmM1RDhnSkJ0VXdPTzRYeldFVzhRSzB4Q0VZVjNlS2pRcThLR1By?=
 =?utf-8?B?diswWjFqdlUrOEZwNmdoc0hhNGJKQWhnaVBHOFg2cFRhTjlMYUZvUHN0b0E3?=
 =?utf-8?B?Z2VudEN2bkQ5ZE15SjlpdlNPdG5rWkdueXVZcy9UWEhhaE1KVFBOZjFwWTA4?=
 =?utf-8?B?VWIvU085QTNyTGZQOWxOMTIvYVA2eGppUWhVWFp1TUtpQ1lYelh1RlpjMU0w?=
 =?utf-8?B?MTlYY202VmJKR00vbjRqV0t1TCsybGQ2TWhEQkhnRStzQjV0S0dqOGZWaDdz?=
 =?utf-8?B?VXh6RUdrODFjcTFTYm90b1VYZnFhOTB2ZFJObXRTQXZ2cDNTYThteUtLZkRl?=
 =?utf-8?B?L3VTemNRYUEvdTZXcEw3NE9ZclhhZnYxVW1ZbFhqNHh1YUtWMUFBVnZKMm9a?=
 =?utf-8?B?d0hHbk1TR1Y0c0FrcWtKSVBZSCtKZ3BuTkRjY1FDdWVUL3RhUXhZTmRBS0dJ?=
 =?utf-8?B?ampMTG5NSlpwcHd5OTBhNFo2d2dFYW1nd2w4VG41TU9xbHVTZHpLWHpWZEpn?=
 =?utf-8?B?alJBTmFVbE9KWjkwUERFY0VoTmtIL3dMZnFjQUc5cXJqYnp2U3JMS0pZWG5M?=
 =?utf-8?B?RkxZMXJ3M1p5bHB2RjRCVENqZGg2V1dqY3hkMElLdW9CSWxNSk5zTGppWjI5?=
 =?utf-8?B?Rm5PSnZHRlBtL1UyLzdKa3JPcmZ0SE8yU29WY0dLQ1NzWC9SUGxHbW1kM0lU?=
 =?utf-8?B?UGVISE5MeEV5eGxMQzRpeXo0K3lCTlh2VTlyK0NzenJnRk5IOUJ4Um5hTnNp?=
 =?utf-8?B?VWFVaHIzZmRjZWpmUzgxNGI4VGVlQkV6RlNCSEtJaXBaQWlma1VjSGVSN1oz?=
 =?utf-8?B?VG5EUjN1dHNzWkYrRXdGZzZod2JHZTg1MzdycUdJRXI4Q1p2ZGJRY2hWdlpS?=
 =?utf-8?B?eEJzK3FCNEppWmdZWkxudkFEVWZUTGFZTDRPV3Y0RFpjRDZnZmN4WVVCdTc4?=
 =?utf-8?B?YUsxcEwrZ2d2TG5BalRtYW9EMkEvR2dKUndOMGp5TUdFYk5YcjdENTZMWEsw?=
 =?utf-8?B?NWtaMzVnM1cwVVd6cVZSWE15VVdIbUFzWGpQdjUwd20yN09PQzlXS0tLR0E1?=
 =?utf-8?B?b1pkYVloRlUvZm9RTVlwM085MnREMjJLVFppcFIyVm9nQUxTTm9KSGVjTDdS?=
 =?utf-8?B?L09yVVJTSXFxR2V5SnhzSWp5UGlpSGdwRVJKVDFONGdyRURyN0VkUVdlK3pE?=
 =?utf-8?B?M0RaOGU1VnNsSXFkbERnOGh2K0NSSWthUDB5cUxnZTR2QXBVeVBmTGcrZlRR?=
 =?utf-8?B?c3IzVzhuL0NRanlkazYvWkFRQk5hdUU5dGROMnJKL2YzcGcyUG5YTTl1SUli?=
 =?utf-8?B?QVVOMCtjcm82TzN4ZUdNWHgzV1NmMjJmcVlZR21FVXNBdnIwV1FEVlpEaDFO?=
 =?utf-8?B?Z1hUdENsamJuUFhKSEFtZTFMM2ttYnQvaGpkeHJKWW1IUEpBMkg5dz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e2bb5b-b225-4fb7-b116-08de8b1afe7b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 09:35:19.2247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9J6EzQvrEZ2uvuT9rkgIqb+mmlb5EfmdYeXxwGR5X8f5Rq+2llZLntmCG02rU1HhencTpAG4A2eRxP1Wc4q+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7526
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

Hi Luca,

On Tue, Mar 24, 2026 at 10:08:49AM +0100, Luca Ceresoli wrote:
> drm_bridge_get and drm_bridge_put() do nothing when they are passed a NULL
> pointer, and they do so since their initial addition in commit 30d1b37d4c02
> ("drm/bridge: add support for refcounting").
> 
> This allows simpler code in various places when using these
> functions. However it's not documented, so it's not clear whether it is
> part of the API "contract" or just a current implementation detail that
> might change in the future.
> 
> There is no visible reason to remove this NULL check, so document it,
> making it part of the contract, letting users count on it.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> Historical note: I thought this was documented from the beginning and
> realized it's not the case when someone proposed adding a 'if (bridge)
> drm_bridge_put(bridge)' to a driver [0]. Let's fix it now.
> 
> [0] https://lore.kernel.org/lkml/DG0CHD0TAH9A.27UW4KKY2O9V7@bootlin.com/
> ---
>  drivers/gpu/drm/drm_bridge.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 3b165a0d1e77..3108249a63cd 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -282,7 +282,7 @@ static void __drm_bridge_free(struct kref *kref)
>  
>  /**
>   * drm_bridge_get - Acquire a bridge reference
> - * @bridge: DRM bridge
> + * @bridge: DRM bridge; if NULL this function does nothing
>   *
>   * This function increments the bridge's refcount.
>   *
> @@ -300,7 +300,7 @@ EXPORT_SYMBOL(drm_bridge_get);
>  
>  /**
>   * drm_bridge_put - Release a bridge reference
> - * @bridge: DRM bridge
> + * @bridge: DRM bridge; if NULL this function does nothing

So, we can drop the if(_T) check for cleanup action, right?

DEFINE_FREE(drm_bridge_put, struct drm_bridge *, if (_T) drm_bridge_put(_T))

Reviewed-by: Liu Ying <victor.liu@nxp.com>

>   *
>   * This function decrements the bridge's reference count and frees the
>   * object if the reference count drops to zero.
> 
> ---
> base-commit: a50007089e078a1b7a826559a02277b1601ee189
> change-id: 20260129-drm-bridge-alloc-getput-document-null-check-a551e64b8fc1
> 
> Best regards,

-- 
Regards,
Liu Ying
