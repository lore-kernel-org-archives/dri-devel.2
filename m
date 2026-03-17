Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEA0FED9EA
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7804210E6E7;
	Tue, 17 Mar 2026 16:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="KggmiKJc";
	dkim-atps=neutral
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazon11010040.outbound.protection.outlook.com [52.101.229.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A506F10E6E1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 16:05:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4TBwfdyYxjhUrwKqO8XXG7O3nmqQiuBCTwNMSx9G6R9CiuEuoAHNY7HXr+B/Jd1Cj96rSz9hcFWH/YOXbsyLdQuE1TSlScTWy1ScyQgVwLBYt+jpMNlUIjiU2j8otPh1f+xCGZ4wUYrCd0puuSBTKzCxD9r/b6desqR290E6YZzl8NidEMShNEgfOQwXKJRPy88KlpC8s1X/pJgaX0jGVj14JbLzjSqgnaszenYdWROg1fk4uHDUT0XcVhzdCT1PJTmOH/JcHE/5C3zKk2eDKNC+yYZpWqNnkkFQeiMJtuYI3VNC/lLQD/sM6+Ox5YofJ2gPse8SGWqI2rUPs3q0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FakKGO9ZAwJs9gFyBaFdy8JsAylH2qo+VSa0NFgXsI=;
 b=nB5+OnLorQ4Du599kEVaS/PjMJAiym22w399PxIsAjxnmJpKsnQwbGw7sTrQ21Dr5pzw4A7GS3QRvOLU7bc8dhvWpEkyhKCyzwbwWDPy3JGgqREbqBdHZ65WIZoigRlzaQ/vlUATJCVxCm7wDzYFL1gwGcXG910B4uO0nqRwrs8ZbxJlKQvXUL7soFRVm3fQf8gXafm43EfsImUAqIljly2Ji/C40HduytoBTDJTgMiDMi4YmbIyWQhnWaOSG+AMba/LQWGeAwZYwOj60oq4ihsecpgj7S7EZsNTEbBg5FEQ9SVxvB6gFT4gjXzbVgRFLgGbgOFeiUuhrkIIkNHtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FakKGO9ZAwJs9gFyBaFdy8JsAylH2qo+VSa0NFgXsI=;
 b=KggmiKJcqITirhnw5lCdcBOnzHRFes7h9pqSiS+d3wI0pDTS7Di/JYy4rcV2j1IVzB8QVA7+P5wm0ms+/5CYwsUj5Ht1jVbIhRa+0AsBZv6yvYyPBiaex60RalLdISOecHhho1udSCz3XJePW3qw/fdak39LDXlZoAmLkip4/9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB9485.jpnprd01.prod.outlook.com (2603:1096:604:1d1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 16:05:08 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 16:05:08 +0000
Date: Tue, 17 Mar 2026 17:04:50 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Chris Brandt <chris.brandt@renesas.com>,
 Hugo Villeneuve <hugo@hugovil.com>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 2/2] drm: renesas: rzg2l_mipi_dsi: Fix the power-on
 sequence
Message-ID: <abl7ovx8e7zToQfp@tom-desktop>
References: <20260317123610.329630-1-biju.das.jz@bp.renesas.com>
 <20260317123610.329630-3-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317123610.329630-3-biju.das.jz@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::13) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5dddf6-1263-4058-8f86-08de843ef5c9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|1800799024|376014|7416014|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: BLTWN70Jx0fRBV9K+cfivB0wi4BkHsp6YIFRZjOvd6EcpOZD+VWGunE0BK1pAntJTVfFw++gS2rG5qyXAme/N0pNGMIJWIvOTZ1Bwus/vUyLGpHNzAb3dn643erVojpIb0gy7fzrrObFOkUcVm+oAGAZiPPqDT5tzsmluk1532+Yt5yMGpQpa5NelZTGKMZRSroym2KBJkF+RipBMocGW//y5xsOIYqz+ac7k+2IYSMRbctoVSySedbu9QmWY5op4K2uOloScDwxXKnU5pukKEKHcdzs3iBCbkvaTogVJzbifUFcCUVOvmp5VBj9+OZ4+KMGoy70SdRA0UpEJ4GZOEKwyYRqg7Wg5Ec99vmA8hS/3jXzhTHMTV8msstK9YqUFfN0lC4UyZ2WEyUpk7xhrUuFvquaHoNl9b0mfIUXlqk7l22WMpnlDXIAGyYC5fp9ppFnF0NE3gq3sVK8nwS7JWJuU1pMI87reN1l6OBfbI1rpFRxAnFkvkPGApv2syALIQw1SU9ODrM9w7om9TMNRc1PvzRFvzi/Kj465g1+qhgxDJcx40bcx4Iia5QPuzQEI4uttEoyjrkFRRObrbq1Wflo8nO6Hqa1HM8CgS0Hv349En4yHr35n/1+GfF+tnsePNZy0P4I2EwIEOwDeIylVWfWcRxUGWIxtwyuLyBRNGyPXaOhbfIGHbwIQZuzfAlovxi90ezqtsWJF6erQBbJ2GJWDJejLq/ihxcZbMemapTlsSioimcVYP6s+gbE5ExDWr35NMxa0bNkl24l3+xEHnNFWew+d6G/AM9EXAPoYrw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB11947.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JWxoeq8nAQeliJEPnUEjG/9Br170eSHWO4nFEpd4oO0LrtDsP9772dKXN8qy?=
 =?us-ascii?Q?uC0ybGFMiyKlCvRmG0wr4opEDQCsg2kC738O547v+kl2fu/5VlnjBXacWDuP?=
 =?us-ascii?Q?mHvUDpB+XlZOlcCv/FnHsGE4FJcNOUNdkIMQDlgjk18nwaFGnYgfTrxLdeYp?=
 =?us-ascii?Q?cMpP7SlVfB1wfOUElSbIm9dvslGtxeRe5ZRUo/vzTBH1tItePZSYDEv6Bh33?=
 =?us-ascii?Q?+WNSYRzOX2xr0TlMBRl4f4Fvz2265gwjkemIPf1JYZXT+MMWODSi53sIR6gF?=
 =?us-ascii?Q?3z1YUEjZjiAMs6MSVmmhMPamWa7IyT7XT4I0/NfKQkbsCd2F/M4xPVkGykdC?=
 =?us-ascii?Q?Z8lf6+WWlb5FeHvnyOTzgM8dR94lu8NCTyj6y9hl31B6+jAOi77/FulORmt0?=
 =?us-ascii?Q?pyjhfbyVbjO3x5+6hFkbme3Jsfv5riHuRVgHXdneLQly3CmCScWb1mwpzFsE?=
 =?us-ascii?Q?XXNb1HXAoFoOokuHcUjYg91UKIVk+MezC5GlRxWPnCOeqPY6693atelJMHX3?=
 =?us-ascii?Q?i4oKgIyWVh/0rQxKbOXdup5+K8HQnbrZS1fvPEmuHniEzU3nc2udfAVLjdfB?=
 =?us-ascii?Q?Y9nKSPJWJqqNjh/UObeeUX+k7iyI8nwQe8PldNw1j7lE+4W8gy0Y+1fSO9eu?=
 =?us-ascii?Q?bW8P4vmv6vjwbaeukeYhO+av3aUhcdAy84OJHs3ifOvkSGHMJXDLih1RknLb?=
 =?us-ascii?Q?KAw2lsaR2ZOyB5GJzz13mMlxmBVgHJlUvFxEsg/SFOMA7Pxz8Jy4V/oY21hs?=
 =?us-ascii?Q?yoAn27YwSuAmgJ420pHcfkKc9N9kxPEUwrTKLKoAbcpCQlHf06dkTM/JDeyH?=
 =?us-ascii?Q?OmBTKv/DIJYU5RfPLuMhqK0tMUF5/ZRDdvN+e/6EgC425gst4Ecw3ttSlvBg?=
 =?us-ascii?Q?JfMafW+LjTregxqwx/OJC+oNZJkbST5jAcbGLWtoPCgAJKfsOy8zaMvV+cwh?=
 =?us-ascii?Q?6+iT6y39z1qN/mLIOjBiObMeyPWyCa+Ok4w237lBx5RXbLIN1L6nD7IYMaUX?=
 =?us-ascii?Q?FrtMvu6IA/yTxgfxcM5EYIhy1uUuBLkK+FiF0RYCwB2cxhB9VOEDT+dJHtXy?=
 =?us-ascii?Q?vp3qd9L2Hxy14fHjFORR8wlYnkzbLYBvTKlOde3z+pivSaUXklXTwysfT10x?=
 =?us-ascii?Q?aDNre3qM4Cu/Op5cMgcImTD/7clE9cESJfbrSWYx/aOSG29pOg5qJLOUOSDz?=
 =?us-ascii?Q?bozR/ZKhdUYFQst40xAxj3W0oJ5bj6xP7dVzY5pkS5HE3myVM76loEa9Oz7B?=
 =?us-ascii?Q?wwUukhiUAuNlPrL/hI/K6P0wF0Nu6Wv4aGyoWlTlD8sBgDMGutju0KfQygJ5?=
 =?us-ascii?Q?T1yfBpYWO8WyYPUs9RcdZonfeNqmZjo0OOf3rCzn+flDzXHgirlYHzliZSgL?=
 =?us-ascii?Q?gjL7rwc1JVZZZDW2iU9qfa/UONMU8yvyRyMWC8t6FI3T0DIPSrWBFlV3J1XQ?=
 =?us-ascii?Q?dkm/K6RvlF99VH/kiYClxRzZQ+IDR2lCddp+QmOrdd4yzJ74VyYDuGYmagNP?=
 =?us-ascii?Q?VuISYHMgWSGnEqDgqr0khEeBQxwgij0SLysXOt8oHmmE3BNa3dN1ycdvLdId?=
 =?us-ascii?Q?5z2RCN5ROMG8IGoou5E4UG/dVXnDU43mPxtWXYg05n13hX994WY/hT3n4NX4?=
 =?us-ascii?Q?wgpgli111X5qLvharzZXMOzjtp7fvwLND9852XXBQe+oEQeqr7avF5mzGxSm?=
 =?us-ascii?Q?NggEQRdv5m+teR0RgE17AEe6WOJx1g9Ey+yxhLeL3Hu9BlDbDah3A4d7ck/a?=
 =?us-ascii?Q?LJACiL6XbNZq9HyJFs7sTFhN9XGgGm+zoIBiYYDYZsCV/G3jnwua?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5dddf6-1263-4058-8f86-08de843ef5c9
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:05:08.3552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLIBnoLl3/h0mEcu1s0Lhfr08+VQPlxLAAKr1zibX6Ot8or4fiLRn8nyk1S+XpfVbviHFIZQQANS7de+yuDWk6RDTvm+za3MEka1XLlFqVcsGLHpfod4p05MIhM1Tk+d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9485
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

On Tue, Mar 17, 2026 at 12:36:01PM +0000, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Move reset_control_deassert() and reset_control_assert() from
> rzg2l_mipi_dsi_dphy_init()/rzg2l_mipi_dsi_dphy_exit() to
> atomic_pre_enable() and atomic_post_disable() respectively, and move
> rzg2l_mipi_dsi_set_display_timing() from atomic_pre_enable() to
> atomic_enable(), to align with the power-on sequence described in
> Figure 34.5 of section "34.4.2.1 Reset" of the RZ/G2L hardware manual
> Rev.1.50 May 2025.
> 
> According to the hardware manual, LINK registers must be written before
> deasserting CMN_RSTB, and the 1ms delay is retained in atomic_pre_enable()
> after the deassert.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 27 +++++++++++--------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> index e53b48e4de56..9053ce037b75 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> @@ -484,7 +484,6 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
>  	u32 dphytim1;
>  	u32 dphytim2;
>  	u32 dphytim3;
> -	int ret;
>  
>  	/* All DSI global operation timings are set with recommended setting */
>  	for (i = 0; i < ARRAY_SIZE(rzg2l_mipi_dsi_global_timings); ++i) {
> @@ -524,12 +523,6 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
>  	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYTIM2, dphytim2);
>  	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYTIM3, dphytim3);
>  
> -	ret = reset_control_deassert(dsi->rstc);
> -	if (ret < 0)
> -		return ret;
> -
> -	fsleep(1000);
> -
>  	return 0;
>  }
>  
> @@ -541,8 +534,6 @@ static void rzg2l_mipi_dsi_dphy_exit(struct rzg2l_mipi_dsi *dsi)
>  
>  	dphyctrl0 &= ~(DSIDPHYCTRL0_EN_LDO1200 | DSIDPHYCTRL0_EN_BGR);
>  	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYCTRL0, dphyctrl0);
> -
> -	reset_control_assert(dsi->rstc);
>  }
>  
>  static int rzg2l_dphy_conf_clks(struct rzg2l_mipi_dsi *dsi, unsigned long mode_freq,
> @@ -1030,24 +1021,37 @@ static void rzg2l_mipi_dsi_atomic_pre_enable(struct drm_bridge *bridge,
>  	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
>  	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
>  	mode = &drm_atomic_get_new_crtc_state(state, crtc)->adjusted_mode;
> -
>  	ret = rzg2l_mipi_dsi_startup(dsi, mode);
>  	if (ret < 0)
>  		return;
>  
> -	rzg2l_mipi_dsi_set_display_timing(dsi, mode);
> +	ret = reset_control_deassert(dsi->rstc);
> +	if (ret < 0)
> +		return;
> +
> +	if (dsi->rstc)
> +		fsleep(1000);

What about?

	if (dsi->rstc) {
	    ret = reset_control_deassert(dsi->rstc);
	    if (ret < 0)
		return;

	    fsleep(1000);
	}


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

Manual/Patch says that LINK registers must be written before
deasserting CMN_RSTB:

  atomic_pre_enable():
	  startup()                  (F) PHY timing regs + LINK
	  set_display_timing()       (F) writing VICH1* (LINK regs)
	  reset_control_deassert()   (G)
	  fsleep(1000)               (H)

Before this series we have:

  atomic_pre_enable():
    startup()
      dphy_init()
        write DSIDPHYTIMx         (F) PHY timing regs
        reset_control_deassert()  (G) deassert CMN_RSTB
        udelay(1)                 (H)
    set_display_timing()          (F) writing VICH1* (LINK regs)  


Moving set_display_timing() here you are setting LINK regs after
reset_control_deassert() and the sequence will be:

 atomic_pre_enable():
	 startup()		  (F) PHY timing regs + LINK
	 reset_control_deassert() (G) CMN_RSTB deassert
	 fsleep(1000)             (H) wait 1ms

 atomic_enable():
	 start_hs_clock()
	 set_display_timing()     (F) writing VICH1* (LINK regs)
	 start_video()

I think to provide the right sequence we need to just move

	reset_control_deassert(dsi->rstc);

From rzg2l_mipi_dsi_dphy_init() to rzg2l_mipi_dsi_atomic_pre_enable()
just after rzg2l_mipi_dsi_set_display_timing() call.


>  	ret = rzg2l_mipi_dsi_start_video(dsi);
>  	if (ret < 0)
>  		goto err_stop_clock;
> @@ -1074,6 +1078,7 @@ static void rzg2l_mipi_dsi_atomic_post_disable(struct drm_bridge *bridge,
>  {
>  	struct rzg2l_mipi_dsi *dsi = bridge_to_rzg2l_mipi_dsi(bridge);
>  
> +	reset_control_assert(dsi->rstc);
>  	rzg2l_mipi_dsii_stop(dsi);

rzg2l_mipi_dsi_stop() is writing DSIDPHYCTRL0 reg via dphy_exit().
I think the right order should be:

	rzg2l_mipi_dsii_stop(dsi);
	reset_control_assert(dsi->rstc);

What do you think?


Kind Regards,
Tommaso

>  }
>  
> -- 
> 2.43.0
> 
