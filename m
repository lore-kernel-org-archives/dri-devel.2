Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE3EE8537A
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 17:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBD6610F45D;
	Fri,  3 Apr 2026 17:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="NLZvq7bc";
	dkim-atps=neutral
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazon11010061.outbound.protection.outlook.com [52.101.228.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B78F10F3E3
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 17:45:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctiCwZQcphSuyWn8m4ocQeahzhOkbdwHkCsajWsYcsfsUgb1xI7Ru7G1AP4oCZciHeKWPufGm2TY98/Vz3YJQnxK7h2PIQwGq54zj7rTRny9mFeykQpvQzjdJE//Bt6+CD0TET4NhBlFUUgnQlmktry89UOPSH4nZWQQPbbsMsd/o8gyHloUD4ALCFGcrz80yq/Lyr3YhOCTbbrdeLCDx0UkbDweGLko9MA5kyIovvqSBvs5VtABpqUPzRA952AjpGf9tr31v6euVVMarkUHwpR2pIWo/+twNGtZrZavAHDnoqDRyKpP1EBVwdy5/LM/07Xrnl8Le2INt3w3YMxe8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUkF7LPThEPcdgpNmMsKsT6NXMZIMND25kh3cL/KMv8=;
 b=I3+F75KjBHF6WoOCJmPUgU5RQkv0iJubCycWxXcoHtR8uo1pla+ydd7VC4KoR+1+B6i6s7t2BbJUhxN4QU5y79sj4sSCsAn1VCYGMplS6jMKK0LYKnW04Sx36MTlCLsxVFhxHWEQ6b2qWOKMrO19BmaYZext8sBpz7jxaxzrauHZIfvYsh71l2jBaZ8fP5IR5Ai5klbket9b2kR7ovsR/6UbnGRfxU+DxWcdvoQ7b3QTBGpAKvbI9XyLXVygv+u2hstuf86ebqricT7Hpm5O7QPCO59GYOPMXwJK8+tGMkmcRPVk9rmc8rd8wkPgTdGke+6Xyg+NMVlMilfvghuIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUkF7LPThEPcdgpNmMsKsT6NXMZIMND25kh3cL/KMv8=;
 b=NLZvq7bcj0cDeeR3MEGWb/uBvvziT8ONmlvzV5kmlEpecjPCfMXo2J+lF2QiUYRq7cXu2dbTdSAblsBuKU3/+HlJZJBdHzHUkLmyJDmYrFROuA6+ay5hUEtphTSx2tyqDrz2Pt/eK2wgv5gqqOkPX/pA0LDWvffMBcuBFe96ZSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB13850.jpnprd01.prod.outlook.com (2603:1096:405:219::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 17:45:49 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9769.017; Fri, 3 Apr 2026
 17:45:49 +0000
Date: Fri, 3 Apr 2026 19:45:36 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chris Brandt <chris.brandt@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] drm: renesas: rzg2l_mipi_dsi: Move
 rzg2l_mipi_dsi_set_display_timing()
Message-ID: <ac_8wHMw06eg9w1L@tom-desktop>
References: <20260330104450.128512-1-biju.das.jz@bp.renesas.com>
 <20260330104450.128512-2-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330104450.128512-2-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FR3P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::13) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB13850:EE_
X-MS-Office365-Filtering-Correlation-Id: 8389cdd5-7319-426f-1353-08de91a8d7aa
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|7416014|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: MtFEkbEvIMLY7y+DTs2MjyTv9sBRRG8r1CFW4zNY9ijX4fAXZ+DRZwpJFSodIxspPiWX2tz63KownhKCDdzd4VTZedcKaBIeD9ZxHAjB9zz+w3u4XNLsduULCX7EGwzm2V0KOAA/Tq45ZL9DuGGvLyC4x13qcY4jtgztvAixEI4eOtnEelHMWXJhct9QVDVCqwX+tQtOUZ8d79Ojzfei/YFStod7ClWRshTphLhyHsSqaioxGzVl+tWJ62JqPm4cLzntbiI0HcL5xqQAI0txkLI+3XxILD9drYFW8kfXgAeSmDppYzY63LaMDAXu10QNl88LddlqHdp/V1tAY8RWwDdP8U3puYrWwF9wR2jzMLCKHUFxm5L1SS3LbZYR47sn6TNqIxuVHvdMQuF38SCNfSk/NuraeF5f3yqps1DazGXcJvaf/C8zNNCqjbLY+VlgyhiZbbZUjGlc/SrhTgXrmVKsqBjffmuacnqj5Rt0P/PfUrlsxxIU8Hqc4Q38Gro2X0IIIJ6l6czjZNuw57D/X/6PuovLBNwP8gRb8O1QzD+zkBe5uo1Ylj5JEl0WAhNT04mRoECLLQQSn4Sh36C+r9kQ5Lpoz+inHh+Ovb3wZhs6zNCkUwZrLDe17HlLlgMoS8Nq3v1AFt8t8pAiLtqndjU4pSs0ho6sZbsZ1v+ZC4iGUgdoV3JaRb6BAwtp/T9+BrMvjYxO7vpB4AsHgEdsczj9gBqvX5fDdg8Rkxr1VROnSGv+/0g8m495bi7UpPPEkcrIzrsItKaqG1a/8N8RbYh99cjFyGumLeho2Y1AaRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(18002099003)(22082099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5xstyVc4jYalDVkzZx1ySDT66hTx68hBd8t3WWjwUeIochXT2ZhcYG+4NkbK?=
 =?us-ascii?Q?gmLzxe/SzmDg4sPA7eg/BF18RSKn0OkQlNn+8hLJlBlbJ2+iGYPMzGyTjOdk?=
 =?us-ascii?Q?jt5Xuitp/GQLZYEpltzNAJ6zcCTT+e1bP36wEmIYMi9eOzSgn2BHzmLE/Ko3?=
 =?us-ascii?Q?ZARz4G/WvCQk3RxnV3E3brX5cXWu3OLtZLTWoTOsDjgTIhtw09ds36e4Dlj/?=
 =?us-ascii?Q?QmQDl8DDqJL1Tb3kRO4lnncvDt22ZGkBn7tricFcHOlqOucbhACOAZ04WzYK?=
 =?us-ascii?Q?Ih2nJXWMP0FnLa3UJl46YMP/tK7pRZqfNlmErgMGkyTU1K1DbkWe79/gjmpu?=
 =?us-ascii?Q?CSKs6gJWP2LxZT2Eks/5BrLm7bsJOuAuaapVBm9o0odmjv0UoB5MARULR+VS?=
 =?us-ascii?Q?vww0ct+GWzKCciesPFDlq+y1N79cXUTx2Lb4TprCBN6sOocS3np64m6ygMX9?=
 =?us-ascii?Q?Erd3yPD62RVZnmbwyuD0vLPD/i3ESPTtBbrkBhCW9FQ54WPx26JpgFv/I3nr?=
 =?us-ascii?Q?GV/FE9JBfDlcck87fIy24BdDKNBFBRBfh+2tNwj5WkDB483emAH3+u+4pqWa?=
 =?us-ascii?Q?RD32+0wJDte5FUCaNE+TVONVz3dlP09EnvWuYFMZMoRg+lKOnYWrlXSr/S2T?=
 =?us-ascii?Q?de1NuL3zQIcWQeSWg5/RUA/XaJndQ7AHBmGLP66qaA18DgefyWL5J4iKFRJE?=
 =?us-ascii?Q?OIPzkTo8gaqzdYRHFAZX8OB3viVq75n8boqQleD/XG2QXwvnBupfveiQWwdm?=
 =?us-ascii?Q?s5zHMLR2S94sCZaPCzRfpgaw7pHLxRViGWGwfSPrGiNgcCh/aiRJPKtl4M5C?=
 =?us-ascii?Q?f0lmzi7Ra2hg/97o72duMKVddTtJpaIG2h8fcwWgopNte3Rpuliy4vB6BUZ1?=
 =?us-ascii?Q?9XUPeJeVM6UQEWaa4TAXrxW0CZUfqvXxL2G1mykP80z+8QkEzjWzjQ968O4G?=
 =?us-ascii?Q?0C9jp/mFk4oVLfUVBVuegm34VJWsV9T848X9TW/yxlRGz/Ka+DQks1J7JMqf?=
 =?us-ascii?Q?7ThtB+ZNW10qPxrGb7fQEeO+d9D/DOAbaW3upxEPloZ3YZoKVv0nRzZc3vl2?=
 =?us-ascii?Q?nVSc4xqEO4VnrBD79MhA91m5pqzxw/eGH2FY5MkNEP4JuKiazQ4w57Hp5Sij?=
 =?us-ascii?Q?eRjSrKlcBUqUP4IhHKoEnEPjmVMxeaKs+O3xgJk4o9+qyrLVNZGyFYiiYQGu?=
 =?us-ascii?Q?/c4EDp21aLcI3SZGYmgCpJicNNizrSvdM/sbQwqzabWjc7Wd/V3x4cOfudcG?=
 =?us-ascii?Q?nyL/GqWNJXQR6awo4kPodM0WD9fjdLjZPf24iLcPJzMo3KFNnSB9BoN+mXjE?=
 =?us-ascii?Q?WGLQOrEGGiLZAuCb3hinz7ctOJYgnEGgY37xmdSvxnUnGQzFW6bc0PeE49u+?=
 =?us-ascii?Q?fOhlo8StsYQRoVom1RbYxNdQOxYKRT2xkBYtkjxlvjL7Sh3wqo5Lq7mp6ejW?=
 =?us-ascii?Q?7KN7GZkC/iDN+q8fUyY9qtDI0aabQ1yHbaBJMnKlRwO6ldjfGuk75RloglBy?=
 =?us-ascii?Q?iFz3jTVdfR1reiyzT+UTSMQHS6SVMxfsQBu6gwUFEH3AGO/uAHVxRi81SrtM?=
 =?us-ascii?Q?tX9tGprXzg3Eo5SHARjRPxtYgOVXX4TCg+L3Jz0oDATRLc9L3h1SoNvu/4Jc?=
 =?us-ascii?Q?BRtiXqBme5OcALBezgmmaLktxsVEPwjA+jhqLegrs45cLpgP3vkuNLAbNYmo?=
 =?us-ascii?Q?OteSvZr1m0+FCQsFVQlNyPo40s4tsyVpFM7roLgAil2tCbfC1EgAL+FGt23b?=
 =?us-ascii?Q?ZEULXm0DtV5OUHmR+Nb/lbz9B5ExMyw78hM1FS+mQ5Fw2XrHpwa2?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8389cdd5-7319-426f-1353-08de91a8d7aa
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 17:45:49.5466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1C51eC+/lkZQVL4+jQJc8zTV7OARxFDHRziCnBBFHrsah6NPHl3CAyH8vuss4i24VFupD9h4hYKXmHQENY5F+eJ6fuEhpsLw8s1O21ewnZCZ2uZGMZqmOQR0wxLmN/Af
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13850
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
Thanks for your patch.

On Mon, Mar 30, 2026 at 11:44:44AM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> The RZ/G2L hardware manual (Rev. 1.50, May 2025), Section 34.4.2.1,
> requires display timings to be set after the HS clock is started. Move
> rzg2l_mipi_dsi_set_display_timing() from
> rzg2l_mipi_dsi_atomic_pre_enable() to rzg2l_mipi_dsi_atomic_enable(),
> placing it after rzg2l_mipi_dsi_start_hs_clock(). Drop the unused ret
> variable from rzg2l_mipi_dsi_atomic_pre_enable().
>


Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

Kind Regards,
Tommaso

> Fixes: 5ce16c169a4c ("drm: renesas: rz-du: Add atomic_pre_enable")
> Fixes: 7a043f978ed1 ("drm: rcar-du: Add RZ/G2L DSI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * No change.
> v2:
>  * New patch
> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> index a87a301326c7..ff95cb9a7de5 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -1025,29 +1025,33 @@ static void rzg2l_mipi_dsi_atomic_pre_enable(struct drm_bridge *bridge,
>  	const struct drm_display_mode *mode;
>  	struct drm_connector *connector;
>  	struct drm_crtc *crtc;
> -	int ret;
>  
>  	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
>  	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
>  	mode = &drm_atomic_get_new_crtc_state(state, crtc)->adjusted_mode;
>  
> -	ret = rzg2l_mipi_dsi_startup(dsi, mode);
> -	if (ret < 0)
> -		return;
> -
> -	rzg2l_mipi_dsi_set_display_timing(dsi, mode);
> +	rzg2l_mipi_dsi_startup(dsi, mode);
>  }
>  
>  static void rzg2l_mipi_dsi_atomic_enable(struct drm_bridge *bridge,
>  					 struct drm_atomic_state *state)
>  {
>  	struct rzg2l_mipi_dsi *dsi = bridge_to_rzg2l_mipi_dsi(bridge);
> +	const struct drm_display_mode *mode;
> +	struct drm_connector *connector;
> +	struct drm_crtc *crtc;
>  	int ret;
>  
>  	ret = rzg2l_mipi_dsi_start_hs_clock(dsi);
>  	if (ret < 0)
>  		goto err_stop;
>  
> +	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
> +	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
> +	mode = &drm_atomic_get_new_crtc_state(state, crtc)->adjusted_mode;
> +
> +	rzg2l_mipi_dsi_set_display_timing(dsi, mode);
> +
>  	ret = rzg2l_mipi_dsi_start_video(dsi);
>  	if (ret < 0)
>  		goto err_stop_clock;
> -- 
> 2.43.0
> 
