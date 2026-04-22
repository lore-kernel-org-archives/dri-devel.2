Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3159BF9EDCD
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E32E10E2BB;
	Wed, 22 Apr 2026 13:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="bEsRIF43";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010056.outbound.protection.outlook.com [52.101.228.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9040C10E2BB
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1XrE2k+ULc9FvUwkh5muwJnjEf7otuJkWX0+k8rUNEBLEwe9AC/f1qPGYY/PzhXwxzvGT3UL+wdfwJuFXVjNK/+5wjwZfsVBsTzgmE9eafUJkYjAEfpyug3C7nJaMa+oNnoUlTGLc5ED4q8bNgv+noVaOm4V+vnRutaHM98zMR1/U269FnI6n0pJx+a0q8PyI/fWGOuBejnhQKTIoHjFAT2cwdvMFZrA3/3xAZ3QF4XMaGEzlCTfAv7IGPqmsN0xTrmmUsu2ATtx+sv/nRHZRq0Mev1EZLRcgWTvHG83w4gl5wV0C7RlJQbb3P2yDiI3SIqSN1ZySX943X2QZRjlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcT+7Gx9JIj7wseVOz3pXlr0bPozW4e+Bzy6qyzIKFY=;
 b=HTKClQBySOsaP3QN4UWxKRaaIHoAw6xZ9Pjxakt9eOsrHkOvYIVrxh1Itpk+PqfOWVYZwfVPUwJ7XvnyAuBFmn9EiuypNoOXcJhYzYPrISFl3yjqbffNRTWsTBLNxJ+JsVJk2jMVm4s9tdEHVRO3+DeJXExyeezXJYhiXu+1dTHKDLhyVdNUbPphWUtzshtmuHkaJm5NrneuZM8a4iSizP1aOcGR+IyiGfZUzafUO3g84MvRHDn1zlTBFP8tAocG2rq+rcGYVdNWePhdI3vC15nWFDWFrxa2N4QQ7DtMuAUq+ab+4YnZBr21mBZHPFUmH+2GEa2XAez6hLT6SVVNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcT+7Gx9JIj7wseVOz3pXlr0bPozW4e+Bzy6qyzIKFY=;
 b=bEsRIF43e67Ga1sFCFL8ySZGvJTME8mucv6ch/LuXtL0hjidl2LiYqxjYWUimMSDw874kTi8QNxcErWWGeOjPMNIdjBp4815tTZesxGbbz4IPw+Omyj5QJMikONMCnzn5dPMyNLsYac6oOZg7AyErK7S9NE9eVREFsgSkp7N/bY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8279.jpnprd01.prod.outlook.com (2603:1096:400:15b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Wed, 22 Apr
 2026 13:34:48 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9846.017; Wed, 22 Apr 2026
 13:34:48 +0000
Date: Wed, 22 Apr 2026 15:34:28 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju <biju.das.au@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: adv7511: Clear HPD IRQ during
 atomic_enable()
Message-ID: <aejOZBNWwo5yjZDD@tom-desktop>
References: <20260422121457.166780-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422121457.166780-1-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0357.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYCPR01MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: ff280a0e-479e-484f-e091-08dea073ec58
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|52116014|366016|56012099003|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5ROEuTvl0Tw0GVxaAy1+uf+vpcu/EZbPy1KkRV8qcMjtYEsLkH99Ltlg9FfrhnMVsL37RXlfaIW+30M84wUOTF+F/CmDQoj9Li5d8IZfUEP9h4zcamVwOB7GMZGZgnOwzJ/1IneqaFriqJMjYJlxG74MdgojU7Uv+Rs5Wcid+0zY2hvnKa5P3FKEBkJ8eMuJjGyZZ22kVNbMGcxUenPPHP8eESnrBnYmtaJ25H6UeKv3W6i47IgARkgdXruLSn13XWLV73vgdo8nfJnK/zaXf1ISQHDPfNLaf/jtDCh/nHHTQNR1Wcp6Y3EF3Owbv9OV+HFbolN4aRN4yqVTaUcNckvArHyvBAop7betm94fkwzFFsAT/lwhl5B0KIQ6yaUrzmCrID15NuJHFT6DjBWLDSH1GOXITgcZ2Ei4K8vYCfiaAFbQqnAUCzrFEhOplmJl9wYPjwS1+t29CRuizgU4Eu3xX5XvmKs/V2zG8hO29SaGqFFuWhSUKrxS469OvoVSck8MdX5+PGYzQGbBUYelLIM5v1kmmMI6AVvXZ202rSYSn9jhw+7RUPoWdHYg6JZ9Q+D6BPTyNUzS9Zx8O9hVYNctcJIblcpZZRfCT3WuMyKtSMJ/UJXQf4a0sEEjJH/ZBqWEjacvEJGDBN/UHjxU5qCimUkCwrjfwVnq33xGdR6zyUk2i2QquPMBN9COarfnGER6uCVflYezBCt6IYJdfHB+j6NWkhZE3jktBRyxdlPUV0uONqqW5IGLgfL0kyzrRLKqbi30SxJ5ueDGRfj0rJDhusyD58aNOeRKJGEBzfg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(52116014)(366016)(56012099003)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IjFb7FMdqY9weQ1jsNw3LLKQ+w2aqhql3GrujHAYkLBXoy8kmke0OFO+Nkgn?=
 =?us-ascii?Q?EpOsLx2SsRn93wp6n7GqXI+iJ9IesuldSHUhH8hjeyJfuEVMa4m3oy2p8w9H?=
 =?us-ascii?Q?Mn8YWe55Od3ST3dA8EI2MzR4zxlmaLhOrULQX7Nry//WXWKKD0+LtNgD7+ur?=
 =?us-ascii?Q?HcGKr57NFsu6VihDgZYJkIteYKudEyzvqkxhEcpcB2rvk9SK9l9a1Uhh4Fvw?=
 =?us-ascii?Q?3RSanoCnDDMeoHSBEUFXGTgRwqcMTsalWN96D1HLmJS54RyH0l6pahv7t1KU?=
 =?us-ascii?Q?zIm+ixDXkGfPDHQRviD0Clumn/b+Lm37mgbIOGOChkh9kiEItLR7hHBZ78Tx?=
 =?us-ascii?Q?Ln3x0ZkICj3QjOu6kswI5GGoJ8h1vqVVSny4ntBGsAktjX4DBIUnI2KdqXCk?=
 =?us-ascii?Q?1DHxiKGMh7AmH/qEZmRPBz1ZlHQLsiKEazB0LXz5vf5trsAXfgnrJvNQfcUO?=
 =?us-ascii?Q?BIKLiQS8rXb4ZOY4I3nBvPpuKOIkXxsU/iYUAufQOrN2IUFzjuJfOyzJx05O?=
 =?us-ascii?Q?P2RBMoJFc7vOOtj3qqMUHrkOpF+P8Dkszr5YAlG5xwx6PXiJ5mZKwh3tQ8v9?=
 =?us-ascii?Q?dJyT/h9BaXjvEkX0kFdmkHmBSx8+DCSb9upBRscqPGNGRD0xq/sM8/8FalEC?=
 =?us-ascii?Q?55VJvtk6eMP3ZDcms7IkNcgl91weYmnXlJTLas0MYQubhFKzO+dZiNXMTaMI?=
 =?us-ascii?Q?edAgYG8P4BQYjhBg8bdCTOTYMFklrEHkCdywex/2JwlBKF4cbjvNEYdJOXgB?=
 =?us-ascii?Q?s951BBiAIWiKJuPuQJ8N6BrfQbvzx5k7rG/1SbTAQI2QvbuIzfF/aO+GUWmp?=
 =?us-ascii?Q?DN42XAwN5m/eBp5mQayZIWqXvm+7W3UY460Js2wd4cyAf8irPatLp+DuWUZ2?=
 =?us-ascii?Q?xnXTWYhsTKWehI4SXU6f+08pCoDxRGsRUVy9W4b9g8LlhLEtcSKoYGIZaP32?=
 =?us-ascii?Q?wqPWZoYRCVZuwk6b4J/WyFGSH28N5ljbQ9HQqSqw+reVjSNYzyJvG/0Yds3X?=
 =?us-ascii?Q?DYcrIhtCDb+Eq2/fg9FeqyGIWdehgJfGdR4P1+eCvcFmdbKrptZHfTD5v+XE?=
 =?us-ascii?Q?E4qD2JFXJ5AC/AFvMyUrh7o102NpdmhPRs4r3TrfLqzb3kTUMDJaJS/cArd2?=
 =?us-ascii?Q?lJ5Ocx46uZrqENCNrHZR/UAKEp8H48OjP2av+gpyUCfYRE/Y7tzLaRmsswBq?=
 =?us-ascii?Q?Pdgfl3j8uz2VFPzzCAC+fHN1UJ0hP9ckjduK8fUXX/w64gOtFbXZj9pTE3So?=
 =?us-ascii?Q?E/JV+wWpJ85jJb6paQkyFMlU+KQgdRsbXusVMc2aX6HU1Klf8zuv4I5wpCjk?=
 =?us-ascii?Q?L96GAw6QUvrsauTMdvvcPBNxG577M2gCrHkEbjf37oVoISI33Pa7iNePTVIc?=
 =?us-ascii?Q?tzTN2Wtuzl1LrcK04RrFZCzC+shmgsjQzkwMBWxIpyuvts/CMbhG3Y388LqP?=
 =?us-ascii?Q?scYo+rM3IvkDOr0SbiH94a5vAbRSahfal2dRLUMFyf8c1ilwVayLMqM3pkqr?=
 =?us-ascii?Q?79an+YYbRoFcrc/Um7crTjZ5J0n4JHnig1esPN1iW4n3WAaYm3E1u5zP/DdQ?=
 =?us-ascii?Q?LX3dhDKch3MH3PMPqy1EaZ8kq1GA17X7Q4INsV9tKmvJOtijc9nytiGTcmr+?=
 =?us-ascii?Q?2sAmAUiBUbDP50ffuSTiEv1IwAND02ICmaogrmYVyB6hU6nLrsHdl5UBWrqf?=
 =?us-ascii?Q?bDaavW+wPCocxzIbNhtkvnxNOn2hO6GwAWi0CACPYF+NU/CIMz18ZjdhWKnw?=
 =?us-ascii?Q?kMkal5yQIrzVDe6rn7CpFTuUsDmXLi5dgnXFoxur45TeYyB8GDz8?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff280a0e-479e-484f-e091-08dea073ec58
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 13:34:48.1851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXa+Bax7v3pDSdon7+4QXSYPeIwhlCVinBHo8AooHhxqhZI6l/YKmbjWmbjDZwQrrCraq7MA91nWY8adStF6CKonwKLgjNlbpe4DkQKQErLC2V1KuzdigdaULUO6oIxJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8279
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

Hi Biju,
Thank you for your patch.

On Wed, Apr 22, 2026 at 01:14:54PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> On RZ/G3E SMARC EVK, suspend-to-RAM via PSCI powers down the ADV7535
> chip entirely, causing the HPD status bit to be in a stale state on
> resume. When the display controller driver's system PM resume callback
> invokes drm_mode_config_helper_resume(), it calls the bridge's
> atomic_enable(), but the stale HPD IRQ is never cleared, leading to
> incorrect behaviour.
> 
> Clear the HPD status bit in adv7511_bridge_atomic_enable() after
> powering on, so that any HPD interrupt latched before or during
> power-loss is dismissed before normal operation resumes.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Patch LGTM.

Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Kind Regards,
Tommaso


> ---
> Tested HPD, s2idle and s2ram on RZ/G3L SMARC EVK connected to ADV7535
> on both polling and IRQ mode.
> v1->v2:
>  * Dropped PM support instead clearing latched HPD status bit in
>    adv7511_bridge_atomic_enable()
>  * Dropped suspended variable from struct adv7511.
>  * Updated comment in adv7511_bridge_atomic_enable().
>  * Clearing the HPD status bit unconditionally as there is no harm.
>  * Updated commit header and description.
>  * Dropped the tags.
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index 6bd76c1fb007..7663814b4032 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -792,6 +792,13 @@ static void adv7511_bridge_atomic_enable(struct drm_bridge *bridge,
>  
>  	adv7511_power_on(adv);
>  
> +	/*
> +	 * Clear the HPD status bit (ADV7511_INT0_HPD), so that any HPD
> +	 * interrupt latched before or during power loss is dismissed before
> +	 * normal operation resumes.
> +	 */
> +	regmap_write(adv->regmap, ADV7511_REG_INT(0), ADV7511_INT0_HPD);
> +
>  	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
>  	if (WARN_ON(!connector))
>  		return;
> -- 
> 2.43.0
> 
