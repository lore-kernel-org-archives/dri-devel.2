Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E11CD8CA6
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC15110F011;
	Mon,  8 Jun 2026 09:13:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="L26QDNm6";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013003.outbound.protection.outlook.com
 [40.107.162.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B010E10F012
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 09:13:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pjaUhfe8r5p4Lb6uyPuiYr9nncztmpVA0XRNl3p9gr/amGPOXqKD4KInaXNUOFGO6hqbR7Xy96Fhch2Nt+eDboVUMmW8OCjvwSQpDYiWc9h6AvQncN6rsyYEnmY3+Mmj/bZtYsOFGRDJmk+/EEIXXTg/tnnI0fmWPoyCW7LdOjJo/PRY9hEDuuswfrYE86WFzrZpNCv8/HtEEqbrN/zsf1/eYWKCaLAvQA8vStaWcWuYxtPM1CeYCa54bTnKZ20O9X0Yx5WKDbcZlQfbHoE3eFyki03GrOgWv/OPDQVX81E03kKLbYQ7iKniDqU1bhQOANTymlv2Y0+grYw67wuQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61J5DCwDaCX/phkY6ZkufjRO8hhjS0y4z0LL83wORAY=;
 b=SgfiVUQ1Gby+FCk2sWQvb9K9XOVdwh0PylUmjxuEUnhZre9Y/N4Bboaxs1qGDwHKCi/WeZCPN4J/GRYMKdu3j78IOJuj+ZeLoREZb7VMq6PEpyNzQmvvItyUFMgrT6QWCI4IwHN2cE6oCi0G1EaWBJQXHlXiFPkbFnLjgHEo0vskNWS4Se1z0v9fFslssCGfygNpqjtciQUjrBuDyCo6A/XbpFjH2zdcs+SGbrtNTFh5OEtzb7S8xVESl/I2Jtl+0aWHxY0p+3672kmqdXnazYA+sLkf0oG/ELhTtOKkgkqjTbTJEXEtofueJUM0CtmXJB0MNO0OQ/w5/RoxEzU3cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61J5DCwDaCX/phkY6ZkufjRO8hhjS0y4z0LL83wORAY=;
 b=L26QDNm62C8JS922jVXHLyyUfkF4agrfecFjxWHHfWpYTq4PsqzFffmbINEw7eqTWUxa8bPMNE8+u7V2baRGAOqxLf7o4AmZAueCXjdUG8/xw1HzLDjfS5Sn5YnX/Sv/4f+KKSJOSxkL7c3XqQ8T73rOZ8sF9XlpC+B869b3cLG3JswQvBJFQaX7m/S3NcPR65owg2DRosV+vmEpZ91NikU/dpK7+bb8lGIgr+xn6/IEWgHCn4sBg+fZbYwrcWeYflX+1miwhen4DBaLUc+xM2josgcE15HKja4GE/yOHUqawSzQGbC7Mlz3g+Z2cyuZ9fv7s7tJIvgXWwai+17OyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by DB9PR04MB9990.eurprd04.prod.outlook.com (2603:10a6:10:4ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 09:13:34 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 09:13:33 +0000
Date: Mon, 8 Jun 2026 17:15:02 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/bridge: imx93-mipi-dsi: Fix mode validation
Message-ID: <aiaIFiQhrbRKgpUl@raspi>
References: <20260515-imx93-mipi-dsi-fix-mode-validation-v3-1-91f7d22b2fe4@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-imx93-mipi-dsi-fix-mode-validation-v3-1-91f7d22b2fe4@nxp.com>
X-ClientProxiedBy: SI3PR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:4:297::11) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|DB9PR04MB9990:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8e8fc6-2c3c-4c0e-62c8-08dec53e36f8
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|7416014|376014|22082099003|18002099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: RzvKTIjrAPVernH7KqW4Xdj6p+HryLh1Mz5zhRKE4r7kNUBBrvwSXqAP8gEoeTklm+FqpIty2DKeHxo1CfdDzBElRvNq67ANxlVN4kCrWpu63a7d6K2tCvJ3H8UnU2Ky88dSQqSYfXRIMUyORk2QraWuWtGkyH13RI/P7+B4rICGlARP1FSzykKkKZxT1UpcHAz45oUvA0XsxVzIJlTWhhrgbqeZ18QmOOuj3H7WH/ibqWr8Vl5xgEBJI4lHenyAqeUZ8spgBidImSA+R40UmYjmP0GvZdxYbjXDAt17k7/3ZZewblcaMwGL2vvlCipZkZXRA5I84RCVKxCS9uPDd5ygysdrmW7haErr2xyHoHJTNDlAhotjjBfFr/HjlQVYzQSzIrT3XbTOuKJ8y3MQQzmN+FlxyyVyntUlEDhQtk5/O+ees7LDjLtTCD9JWBULClDAv7UpHRIE2IiLY4XUjVBRmK2tZutC8fmRbn+1vLjrdBkyMvTzIo8IspUid2QsXg4QC5vWmie0t7nHpyQvC+jmpsbDf55AZPbdMmH8C3ZHHP55DOMr4z4v4uM8HV8Wb0+sN0hxfiimA7M7X/jDqmlnjF8ttb37msjf47JVD5AQbvbkGiJT7nvlyeX9uuSqZx6CeVEvtyk5CWWha49bpGiLps1rr1NQrvBhz4TWbK0hYjSpmbkaiZyVOe/dJGu2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(22082099003)(18002099003)(921020)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ohd4y8l0PL4oF9GR0loksVeJd4KouxDBVIW0GfDAZNnpK+ypxurOjZLJ56Qp?=
 =?us-ascii?Q?nhQaqenPdiB5fw9BRheJmEI+9PwIO5KnhLr0eYZ6Gxfqbm4avFtA/zqa1Y16?=
 =?us-ascii?Q?u0C/a0AYtS8XTLzajFCDuu3xha7EJNch6zkepQBSutiaGF2+eFzGqLT9UjvH?=
 =?us-ascii?Q?l2+RUkxiEob/6PUpCl2riOMGb625ldJYrM/z6SbhmlXD0SR7B/csWLjjhFbF?=
 =?us-ascii?Q?ag00bqC8M5CWw7VvPZY4cLhiSqx6IXfOMHwQMfCPvOn2WbZMNx8vQwKtBBcG?=
 =?us-ascii?Q?6M6XVbmxziMybYLWsmAl1Prl5V/VnyHFBdxUkLoMP15y79pG2+3txkAJ7LEN?=
 =?us-ascii?Q?oRLTQlT2qOreQT55oZES8HEWbADX5aiGnrpYNWVsqJA/ojpIaZ+/LLDRF7PY?=
 =?us-ascii?Q?j1Dxi4ymVAsTTOXuPpk9XlyjA18Lm7cZBp2123koyU8NSDbR3D0kEQswO02M?=
 =?us-ascii?Q?D5JHm3zkyLlKjUECu1ImmRgrSGRclwyMGaNH2m1JIN6n22BYVyEfdXyFvVtw?=
 =?us-ascii?Q?Lcg3YqUYa6QtdWVolT1E3Zu0Jb08uQxhv9Ky2z20YeMZCOvsil8j5cUB2bzN?=
 =?us-ascii?Q?aewoZ1g7VApwZ81Xu760KNwhK6MnI27u4CxGFXb4ASI7pNdxWqi18S06UKwn?=
 =?us-ascii?Q?QU/XMuw25j/UKP9LdqqYj1wHQZ2/egNaCOT0p83M69ReEaQw43+0qo7RW9eG?=
 =?us-ascii?Q?+boogQH5e4+QvyoSmEoAHHf2HaIGk50/MeEkFXBRPIzK011WiAVdQ2Oes2Qu?=
 =?us-ascii?Q?pqu4TBskedabThBEFjRJm0khUpVUEyBOo3gkFgEhuQdWi883aUm7yIZMiSLo?=
 =?us-ascii?Q?NjoFwijAbzwd82L8zre9rIZz1Y/f7LrgkPhFSJerfEEXMsiPa+FxnoonFtl/?=
 =?us-ascii?Q?8TdDBSWvKeHvhykKrCgp3nINGQvwzoWdqQWtJB4fIkoPIgTxhzJB7ePKOHb8?=
 =?us-ascii?Q?6bte2bsPwZYWXFESD2JH45XXh42ut7ZupHrjce+lv36M0hAimZRq57LJ2Ork?=
 =?us-ascii?Q?krjqmelVO9fqP/hxIkjfX6rYAgUTiXD7wkrTbtecDvsQbqx+0DQRLWrWlsnj?=
 =?us-ascii?Q?Sxvst7iYry2E/PfFm5KfQp2A02XSDv1ZHjkFhPXyd5jt++Y6bAYFJc1CQJ1t?=
 =?us-ascii?Q?WOQETOK+hB1noffHJTwLY1HPRZ2BXNwyxlJNdkkv4uqd2Vmo8FGVPb0+3kkc?=
 =?us-ascii?Q?UbgwX8/xfy1HSmYFADRYE3YByPueQSwRQ5GLzez2FSqs+C76LVM/JY3NDYcw?=
 =?us-ascii?Q?Wk4YmKtOW6AaOhbkVRIPLtns32TrqTp42OlqRrXLRM/td3RdNz2np/HlWVv9?=
 =?us-ascii?Q?M4/GqJq5SVN5tOXGV/QIP0lHNDHrNMvTZvmPVofHlewr+IXTjmT6uxgakfok?=
 =?us-ascii?Q?GFqQXDGQdFbMsG66PiKF94Jrog0s9GRuwrDHWX0FExb+TT3WHQPgijkiCSv+?=
 =?us-ascii?Q?3m5kN6zf6TbL1UIzvQ0Savedzy3mPlNBvcBWoBbLtbdiQv3l4c/KJQrwGeor?=
 =?us-ascii?Q?URTIv9Pgy2UeimsvLIjHW9HtGN3u/TAapaXwzKQYsHoG9qUwQJN0j1bE5pMN?=
 =?us-ascii?Q?x70OhLU5yPmUK6teBSw6jVaaRaVBwD0tIvLNTK2bEftjSQkpiuUOuuof03aq?=
 =?us-ascii?Q?Pw9FSlW+3ZOOyMLlLHDDATbbC+SsGBEPjk/Ufsb4JSv52N75D+FaCd8NYb/5?=
 =?us-ascii?Q?pbFi1ezLGX66DV1ALf+JrtkqFvsFmkn3MRhdrTOt6Jknh1An8R7OVe+6ZG9c?=
 =?us-ascii?Q?Mm8/dZG6OQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8e8fc6-2c3c-4c0e-62c8-08dec53e36f8
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 09:13:33.8886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TW1oedy3zaeVjFfbC1YXvfHtrcuCThSNcfo1k8fWQkwZkGCpwRSy8wSp6nta/JBjTKTyhszgxKVcHCvKm0vF5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9990
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

On Fri, May 15, 2026 at 02:54:16PM +0800, Liu Ying wrote:
> i.MX93 MIPI DPHY PLL has limitation for matching with some pixel clock
> rates, e.g., the best DPHY PLL frequency is 445.333333MHz for a typical
> 1920x1080p@60Hz CEA/DMT display mode with a pixel clock rate running
> at 148.5MHz with 4 data lanes + RGB888 pixel in MIPI DSI sync pulse mode,
> while the expected PLL frequency is (148.5 * 24) / 4 / 2 MHz = 445.5MHz.
> Fortunately, VESA Display Monitor Timing Standard allows +/-0.5% pixel
> clock rate deviation for timings.  So, for those display modes read
> from EDID through a bridge with DRM_BRIDGE_OP_DETECT and DRM_BRIDGE_OP_EDID
> operation bit masks set, pixel clock rate could be adjusted to match
> with the PLL frequency(for the above example, the pixel clock rate is
> adjusted to be 148.444444MHz with about -0.03% deviation from the 148.5MHz
> nominal rate so that the adjusted rate matches with the 445.333333MHz PLL
> frequency).
> 
> Instead of checking the last bridge's operation bit masks against
> DRM_BRIDGE_OP_DETECT and DRM_BRIDGE_OP_EDID to determine if allowing
> +/-0.5% pixel clock rate deviation, check any bridge after this bridge,
> because the last bridge is usually a display connector bridge without
> any operation bit mask when the clock rate deviation is allowed.
> 
> Fixes: ce62f8ea7e3f ("drm/bridge: imx: Add i.MX93 MIPI DSI support")
> Fixes: 5849eff7f067 ("drm/bridge: imx93-mipi-dsi: use drm_bridge_chain_get_last_bridge()")
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> Changes in v3:
> - Iterate over next bridges manually instead of calling
>   drm_for_each_bridge_in_chain_from() to avoid deadlock issue.  (sashiko bot)
> - Fix a typo in commit message - s/modes/mode/.
> - Link to v2: https://patch.msgid.link/20260512-imx93-mipi-dsi-fix-mode-validation-v2-1-7aec3be5da2c@nxp.com
> 
> Changes in v2:
> - Collect Frank's R-b tag.
> - Add an explanation to commit message about the reason why mode validation
>   checks bridge's operation bit masks.  (Dmitry)
> - Copy Dmitry.
> - Link to v1: https://lore.kernel.org/r/20260227-imx93-mipi-dsi-fix-mode-validation-v1-1-a9cd67991280@nxp.com
> 
> To: Liu Ying <victor.liu@nxp.com>
> To: Andrzej Hajda <andrzej.hajda@intel.com>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Robert Foss <rfoss@kernel.org>
> To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> To: Jonas Karlman <jonas@kwiboo.se>
> To: Jernej Skrabec <jernej.skrabec@gmail.com>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: Simona Vetter <simona@ffwll.ch>
> To: Frank Li <Frank.Li@nxp.com>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> To: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c | 44 ++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 13 deletions(-)

If possible, can I get a R-b or A-b tag from a drm/drm-misc maintainer/committer
so that this can be picked up with good review?

-- 
Regards,
Liu Ying
