Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9EF606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=EPprA3/u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47DED10E058;
	Fri, 20 Nov 2026 10:48:46 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40CB310E30B
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 10:48:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRgHz2fz7mMQQuVvTgYZ2zD5NcYEH4JUrBD0LvFjHPeCoxbfzCxiwziiX6gXnZKl0Upq/1pf777SMpQVEgLkPp4V5ExwXfTEMA1yiOsu2wc3cvbYA4c1fDigAkusxbV9EfSp6Mk5uXSKDRysCHxLPtROV9VDyr9m13yeGJlKMqp3sEaZwqySfk1P7lb3MpI8HAQZqT2x63B7HyTbfUyuURE5pjQAFKParzfFjSQE6nAF/0f52PJ9KGr/lYzN+xogT/h9AVTpuWNwUv6qn+huArDaPRhjGIKEIcWguBo9ZqXFW/kiKrH60vmG1fgReZXAc+MOQuDSnlv09StvscyIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpIkpj45PnSBFFJR7sWSdwgY/ddfffz58HANlT3Ibbw=;
 b=v5372+UtNNQq1QjL20cm+ArJqW0q/mf+NkIJzkfsnh4GKrxOEJc7bd7fjaZRVw0soEKhyDxZ5soALRsFBreL6D1Zv2OmoxSXUWF/BfZX9sInLBqZnWDjp21agxtvUHQ5Q8xub4/s3TtnCX4gicdu3GuZyOPGTiWYxf4FjHtWWJuuJKkOJq/0lx2HG9FDjvEhcVZ5i4qtgZBkEzfPvncX7IbFyDhrNZK4CLVxoGFo8a4eabQoFJhx5oPy38JPmUORuzryBYR3xAMp+nT+gm7v/hIUyeB4xUinr1P7dlITJyvB1jkAt1AydkkCFLHzln7MFRBHkO0EPXpnpUcbdxHbYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpIkpj45PnSBFFJR7sWSdwgY/ddfffz58HANlT3Ibbw=;
 b=EPprA3/ui3m0JNTP466msx4xDYED9backaSzI++NN6IDIFWe0ibSsGGdsHMua976QTsjYSicJjGDh9nVjmCtwla9h1h75JUU/87zqBY2repeE3+qqe6cO8jaUh50uk9rV7l/qf+0U34c/DH98iZ8OgWdMC423IXgvnyBwrsk86R1KVRa0bsxetqltPYpCuYCMy7mCJHAedCvwp6kcONiUv9+6968r1AdMCBC4NVG5A1xf1zJew8nejiSAsVfJFBrdG300t2qAKrKEJN1SuVmXnCat1c5cDUnBit1NGRU917jZm+ByrbUCFN3ztwp2f40bCA+7JnZM4jmRk93Y+sP0A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by AS8PR04MB7638.eurprd04.prod.outlook.com
 (2603:10a6:20b:291::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 10:48:34 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 10:48:34 +0000
Date: Fri, 20 Nov 2026 12:48:30 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org, 
 conor+dt@kernel.org, Frank.Li@kernel.org
Subject: Re: [PATCH v12 2/5] drm/imx: Add support for i.MX94 DCIF
Message-ID: <awAgaVs4LLwqVA57@vm>
References: <20261118-dcif-upstreaming-v12-0-29b35e27a1cc@oss.nxp.com>
 <20261118-dcif-upstreaming-v12-2-29b35e27a1cc@oss.nxp.com>
 <sashiko-outbox-221406@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-221406@kernel.org>
X-ClientProxiedBy: AM8P191CA0027.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::32) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|AS8PR04MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: b03cec65-aac4-4241-afea-08df46f3d2be
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|19092799006|6133799003|261009223027099003|18092099006|22082099003|18002099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261102123227099003|261021135927099003|56012099006|4143699003|10067099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: LThyzbVjH5Z0K8+8JifSDWch4ObxXkAzqyDd75eTw2tBJToBwG3XK3CBHPBWezzA9UV7n8sYg943fGhHfh5cuqMCO7Hr/RU5JiEweDkWDaVKe9mAp93LjS+ruUHhc5TK167s4YLIzm82q8sZZdhigifznZv2k/qgN3Ho2HFbThIcoMHBIuUA1mEzAQBf918UzSeWphv9YUtQPLNUuZdnpG7dHTdyu6K/PDCzUUztKP6nmYSatqLp9VCcYZEOSwCVw4O+OwEyL86kEcaIiOW0iHbYP6bDx968zCPIAZYLdUUAkq9fWe28pVMPxHa23oY1hr5zNHEoObTembvCXIwJ2Utyf4GjHwpMcC8rFPjoYolij753+AL7vsw5LKm8FXMlbOXQvQcge8G5ECRRifBC5xqe74lM/02na18dQaEjBLvGfHrAJnP0eKdSd8/CJseweu86YCosSrv+IaoSgMfZvZW56IVIVjh6jDCJSyrDnjLeykttqaTNYBlN7krKIzMJQe61PuVFpouYKzrLWRScf/o7Bf1Og7c/iYKQEvGCFZJbua6zSYDMpFvc9fcyCvnO4cuBpYutRyy12EbFrTKwzvvFMccrVyV68Jk+GQMjsUGN0eJAzFkgFxncTg5eTXxP3n6L33y1f1QS+979iWd51kHAR2d03TlAwB2lVm8nMeA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(19092799006)(6133799003)(261009223027099003)(18092099006)(22082099003)(18002099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261102123227099003)(261021135927099003)(56012099006)(4143699003)(10067099003)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xwe7LpzWc1pXfBpEERjemn0UftsTCeiM/NfxxgsIfgbN/hCLMF82XQJUoINJ?=
 =?us-ascii?Q?IDubnkalGjUX139ldEX8/WAmomQkbUqWrFaPZ/iPKobvbdFE3rd02M0jXrsz?=
 =?us-ascii?Q?ogqMlrsoyjU/b1dWMa2zGYK/3aT+/09PTEWNBgEEsZmOgFf7l0xke+wMZ4EN?=
 =?us-ascii?Q?u5ud/YtpWkdV8hnT3Gk5/5C4JH1EGsn8c2+fxqsFp4UkBUPaw8jw2xc66EZd?=
 =?us-ascii?Q?Z9lwtN2DOiyYkbH+KOJ9nMnUHFqIZlZInGv39BtGMSueif4rIVkVwGs6Qu0P?=
 =?us-ascii?Q?p+ImCFiOn+tqWZdDnUgKv650EpTjYgnSv213tzCS/eD61CkRuIMfe7PeclwE?=
 =?us-ascii?Q?2u3SVbjMBwYJZ8GYTw6I4j1IGphN26cgFAWEXSl1N7SjQChNVb6T+cEg/5fw?=
 =?us-ascii?Q?2cymzy0YtPLpA1E+zgjg5vMeD3AsoNn7AmvMiU6HnWDxPQ9CjhHY5gvZY7jU?=
 =?us-ascii?Q?L/3iI1rfpeaqnL0gnvKWKAkQdjMQN6/leK7PyHjUtAY8RiTpnUYZrzYuD84o?=
 =?us-ascii?Q?VbiLCXqf+lMvlmwGD9BNGfh+4Evh+25/XkN6YHNYp9jqiY0ZfyHPv3iVKw9G?=
 =?us-ascii?Q?TbB6me/6GytqUQO3tqpKnAJ+4HAh9UHzMV4jiNGRrH8gpJkejEIQNKaO7UsK?=
 =?us-ascii?Q?CFjpLJCwSocje2c+AZaN+lc2kqn8sPO5QDkX24vmO9vQKEsMNg50z7hQ6+DF?=
 =?us-ascii?Q?LTIEGtEifuDLv7aNSA32RtOnfbYJZsTX8ozTVMuxi4gCZBkZsocwqePtoa1F?=
 =?us-ascii?Q?ysV7dmCQJjvkvSp4p10m/KSIb7Uzp1Wykk1V1UoBLLobcrFCO/PqZRqhl2PT?=
 =?us-ascii?Q?oAxvSvaIAI9RNt0++NOGKdUwcZSnH9CnJVGQQjgTW7XVh3kN/uDgKxyKFUrd?=
 =?us-ascii?Q?eE+KlHSgyTRlQZR3tdIHgWAIZ0wzR8Z6clFKGl9T0YFYiGKuzRX4bcwlYCwq?=
 =?us-ascii?Q?9K58TR5Jx/EXUXxzCt0j/SAADOdHjM4VyDz5P/yLcuGv8EDvRSqLyIANgCwF?=
 =?us-ascii?Q?+nu8zZpwl8ZmxUsPkZyIPFmOCE65REktJCgjStOcJI15pGleqFkg4ZoHRuwz?=
 =?us-ascii?Q?9iKwyRVim/2dKw++1pvUsJhzBqDM4jCTMc+uGhndXj08TZ5/xxI2uvVi8T8o?=
 =?us-ascii?Q?NoduJHfqMup8w4iSKxyaNyv22YmQDfKfuMdUE6yWnt4Tzatu0ObeOX01Gwem?=
 =?us-ascii?Q?whkEo8Sez0l7RtQbUOJSI0ReFFG93lsWl1lInHzzOlkOqPM8mo0OzpxHSazs?=
 =?us-ascii?Q?VCGY2lLsEpn9ViV23IWUsZI1p/26kBZJr3bJfjYFOjPRIt4fb5oC/UiYhaUQ?=
 =?us-ascii?Q?9WzXTuZBwaIm3/s77V3RVYCXkov6PJ/z8dQ1PVgJFcFn8KQ1V8745uhRfYmj?=
 =?us-ascii?Q?/K9RkJIq3Gn41m6V2E3pLjayjRkaX6YGmfU2g1YJ845ybmXXVe6v/TovUBOS?=
 =?us-ascii?Q?w6OG4yRZuGuiZ3RMWyXAz+7+WJbl+FU3y61OoFL7J06YJGZ37qxE6jx7aOrT?=
 =?us-ascii?Q?zEWDqLP4cLUR8UyaHdgsZLmCWft2kctAlitn8xitnPa8G2oLPdbQ4S0a4Inc?=
 =?us-ascii?Q?G4TwZIX8w6wuUj/2UUlkcXazW84gbX3undSKP/UUxOl9EjMuS/RvDeQnslcE?=
 =?us-ascii?Q?s4v9j2J9P49SuP856vuWjNagri/tDaEz8nZGRj8aYctm9KTFYcFVUzauNw7h?=
 =?us-ascii?Q?251bhxw6KucvNmQqyu/Te1fHh51XWEOo2nKMURob2zXA8zSLLa28v1stjm8K?=
 =?us-ascii?Q?19tv5TNR9Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03cec65-aac4-4241-afea-08df46f3d2be
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 10:48:33.8643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83X6a7mbucdwMNwOMzeo0hFIZgmChg6dpV2JYFtSKdg2BnYQJ8GhJj0DqTCxCQblX+FCu6cgrYDifXA+/iT/aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7638
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 04:02:40PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [Medium] drm/imx/dcif: unclocked MMIO access when runtime PM resume
>   fails
> - [Medium] drm/imx: dcif: unbalanced clock disable if
>   dcif_runtime_resume() fails
> - [Low] drm/imx/dcif: missing shadow load and trigger clear in
>   dcif_crc_source_disable()
> --
> 
> commit 373caa0eccbfd7fa4334093ea8869b540640e7ab
> Author: Sandor Yu <sandor.yu@nxp.com>
> 
> drm/imx: Add support for i.MX94 DCIF
> 
> This commit adds a DRM/KMS driver for the NXP i.MX94 Display Control
> Interface (DCIF), supporting primary and overlay planes, YCbCr-to-RGB CSC
> on layer 0, and frame/ROI CRC generation.
> 
> > diff --git a/drivers/gpu/drm/imx/dcif/dcif-crc.c b/drivers/gpu/drm/imx/dcif/dcif-crc.c
> > new file mode 100644
> > index 0000000000000..ad94b458a6c59
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcif/dcif-crc.c
> [ ... ]
> > +void dcif_crc_source_enable(struct dcif_dev *dcif, enum dcif_crc_source source,
> > +			    struct drm_rect *roi, int ncrc)
> > +{
> > +	int ret;
> > +
> > +	if (ncrc >= MAX_DCIF_CRC_NUM)
> > +		return;
> > +
> > +	if (source == DCIF_CRC_SRC_NONE)
> > +		return;
> > +
> > +	if (dcif->crc_is_enabled)
> > +		return;
> > +
> > +	ret = drm_crtc_vblank_get(&dcif->crtc);
> > +	if (ret) {
> > +		drm_err(&dcif->drm, "Could not get vblank reference: %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	dcif_crc_config(dcif, roi, ncrc);
> > +
> > +	regmap_set_bits(dcif->regmap, DCIF_CRC_CTRL,
> > +			DCIF_CRC_CTRL_CRC_MODE | DCIF_CRC_CTRL_CRC_SHADOW_LOAD_EN |
> > +			DCIF_CRC_CTRL_CRC_TRIG);
> > +
> > +	scoped_guard(spinlock_irqsave, &dcif->drm.event_lock)
> > +		dcif->crc_is_enabled = true;
> > +}
> > +
> > +void dcif_crc_source_disable(struct dcif_dev *dcif, int ncrc)
> > +{
> > +	if (!dcif->crc_is_enabled)
> > +		return;
> > +
> > +	if (ncrc >= MAX_DCIF_CRC_NUM)
> > +		return;
> > +
> > +	regmap_clear_bits(dcif->regmap, DCIF_CRC_CTRL, DCIF_CRC_CTRL_CRC_EN(ncrc));
> 
> [Severity: Low]
> Should dcif_crc_source_disable() also clear DCIF_CRC_CTRL_CRC_TRIG and set
> DCIF_CRC_CTRL_CRC_SHADOW_LOAD_EN when disabling CRC on an active CRTC?
> 
> Clearing only DCIF_CRC_CTRL_CRC_EN(ncrc) leaves the disabled state
> unlatched, and if DCIF_CRC_CTRL_CRC_MODE, DCIF_CRC_CTRL_CRC_SHADOW_LOAD_EN
> and DCIF_CRC_CTRL_CRC_TRIG stay set in DCIF_CRC_CTRL, a later
> dcif_crc_source_enable() call via regmap_set_bits() will see no bit changes
> and skip writing the register.

It appears this one is correct. The CRC_EN(n) is shadowed and CRC_TRIG
is not self-clearing in continuous mode. Will fix in v13.

> 
> [ ... ]
> 
> > diff --git a/drivers/gpu/drm/imx/dcif/dcif-crtc.c b/drivers/gpu/drm/imx/dcif/dcif-crtc.c
> > new file mode 100644
> > index 0000000000000..233e149929964
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcif/dcif-crtc.c
> [ ... ]
> > +static void dcif_crtc_atomic_enable(struct drm_crtc *crtc,
> > +				    struct drm_atomic_commit *state)
> > +{
> > +	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> > +	struct dcif_crtc_state *dcif_crtc_state = to_dcif_crtc_state(crtc_state);
> > +	struct drm_display_mode *adj = &crtc_state->adjusted_mode;
> > +	struct dcif_dev *dcif = crtc_to_dcif_dev(crtc);
> > +	struct drm_device *drm = crtc->dev;
> > +	int ret;
> > +
> > +	dev_dbg(drm->dev, "mode " DRM_MODE_FMT "\n", DRM_MODE_ARG(adj));
> > +
> > +	/* enable power when we start to set mode for CRTC */
> > +	ret = pm_runtime_resume_and_get(drm->dev);
> > +	if (ret < 0) {
> > +		drm_err(drm, "failed to resume DCIF, ret = %d\n", ret);
> > +		return;
> > +	}
> > +	dcif->crtc_pm_enabled = true;
> [ ... ]
> > +static void dcif_crtc_atomic_disable(struct drm_crtc *crtc,
> > +				     struct drm_atomic_commit *state)
> > +{
> > +	struct dcif_dev *dcif = crtc_to_dcif_dev(crtc);
> > +	struct drm_device *drm = crtc->dev;
> > +
> > +	if (dcif->has_crc)
> > +		dcif_crc_source_disable(dcif, 0);
> > +
> > +	dcif_disable_controller(dcif);
> > +	dcif_disable_plane_panic(dcif);
> > +
> > +	drm_crtc_vblank_off(crtc);
> > +
> > +	if (dcif->crtc_pm_enabled) {
> > +		dcif->crtc_pm_enabled = false;
> > +		pm_runtime_put_sync(drm->dev);
> > +	}
> 
> [Severity: Medium]
> Can a failure in pm_runtime_resume_and_get() lead to MMIO register accesses
> while the DCIF clocks are disabled?
> 
> If pm_runtime_resume_and_get() fails in dcif_crtc_atomic_enable(),
> dcif->crtc_pm_enabled remains false, but crtc_state->active is still true.
> In the same commit tail, drm_atomic_helper_commit_planes() still calls
> dcif_plane_atomic_update() and dcif_crtc_atomic_flush(), and a later
> dcif_crtc_atomic_disable() calls dcif_crc_source_disable(),
> dcif_disable_controller(), and dcif_disable_plane_panic() before checking
> dcif->crtc_pm_enabled.  Accessing DCIF registers while the block is
> unclocked can cause an external abort or bus hang on i.MX94.

This one is not worth fixing. First, the only thing that can fail in the
runtime resume is clk_bulk_prepare_enable(). If that fails, the platform
is already broken since the clocks are managed by the SCMI firmware. Second,
adding checks dor crtc_pm_enabled in every commit path (flush, plane
update, etc) would add a lot of unnecessary noise for something that
will probably never happen in practice.

> 
> [ ... ]
> 
> > diff --git a/drivers/gpu/drm/imx/dcif/dcif-drv.c b/drivers/gpu/drm/imx/dcif/dcif-drv.c
> > new file mode 100644
> > index 0000000000000..80b554f1b6843
> > --- /dev/null
> > +++ b/drivers/gpu/drm/imx/dcif/dcif-drv.c
> [ ... ]
> > +static int dcif_suspend(struct device *dev)
> > +{
> > +	struct dcif_dev *dcif = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = drm_mode_config_helper_suspend(&dcif->drm);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (pm_runtime_suspended(dev))
> > +		return 0;
> > +
> > +	return dcif_runtime_suspend(dev);
> > +}
> > +
> > +static int dcif_resume(struct device *dev)
> > +{
> > +	struct dcif_dev *dcif = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	if (!pm_runtime_suspended(dev)) {
> > +		ret = dcif_runtime_resume(dev);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	return drm_mode_config_helper_resume(&dcif->drm);
> > +}
> 
> [Severity: Medium]
> Can a failure in dcif_runtime_resume() during system resume cause an
> unbalanced clk_bulk_disable_unprepare()?
> 
> When the CRTC is active entering system suspend, the PM core's
> device_prepare() holds a runtime PM reference, so the pm_runtime_put_sync()
> in dcif_crtc_atomic_disable() leaves the device's runtime PM status as
> RPM_ACTIVE.  dcif_suspend() then calls dcif_runtime_suspend() directly,
> disabling clocks without updating runtime_status.  If dcif_runtime_resume()
> fails in dcif_resume(), clocks remain disabled while runtime_status is
> still RPM_ACTIVE, and device_complete() -> pm_runtime_put() will invoke
> dcif_runtime_suspend() a second time.  Using pm_runtime_force_suspend() and
> pm_runtime_force_resume() would keep runtime_status aligned with the clock
> state.

This is related to the previous issue and also not worth fixing since
the resume is unlikely to fail, as I explained above.

-- 
Thanks,
Laurentiu
