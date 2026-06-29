Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83499C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C266F10E637;
	Mon, 29 Jun 2026 11:23:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dKovW1ZK";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EBCF10E76B
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:28:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JW60UZDxaXiatvxgBuGYfcNV+R10+HYKiIM3vwpv1AeHQtChiDsiakKTZAtB+0Cr2NEpTvKAA8wMmygN22r6uDYYx+DSTw8nKriJ27PXsceaauPZUMNSg2cipyHfqiFZB3+jwxL0Kf1ElrVO0HY5ekYb5ajyBOi9yeFbtVD8qj5TWPSyNKm3X78UWPcWNkAJJZNlFj3eHdjEZLJogpBtrbqhG4YkbLkm/o07WyFCC7NKjqQWIMWGVH4HKAg+DPp/E9yQsDyURC8LYzQTwzssX2KQSwmdtMpxgg6qArbM/dc68fBRVeymXFnkDdGrdBYBLnF9XUGhYPGTOP6PTiZxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNEqPyZr0SoYzYr1LXdRL6klSeRWrXueUloBM72etzI=;
 b=CAmMKaVjZSF3FzxOBCA+Uow1IS67IEV2pXsDb+BhJQG5X+77t74+DARvIQvu63ex7g4inMKtrpkPqnQ84qRDLoAns+OKU/Q28ZIJiy4dsFe5jimkQDpAUtYYG/SmdLpRguDh+rWn0Jv8FvPhsLUQxFyDrxfknCC8WJJMhJ25DkVlB5I1T2MVq/zbioK8aLZpYeG7uV24bEg2q3gBeedUw8ebRRb49GikDyMYS/8oMg6DN/8USj81fvjNObeso8aZ7SbZ9zDSjLG7NxRb2Kdi0h5LYjv5UMpsNdjewU1vERmzHrNY3wYe7XZcYY2xr9m94wAjGa13IHRRJr86rLEkVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNEqPyZr0SoYzYr1LXdRL6klSeRWrXueUloBM72etzI=;
 b=dKovW1ZKN+PUPfr1M+HBiJ7RYUqUrEQ6c0zVd3MEnjf0z8M1FZhXqHmG8CDhdG0IhhTpfnJ/UIDE4PeigrlKL8ZP5eddjOawJK/CmksPkh4Ma0qxIyjz+sUeLMnYcCekb0TY/wAAyD+N8qY+MSEPyAzInGznar6rpZStjENRgW2WojomcvJNoRNOHpb+KkLcTfHiD9WSvubPg5Rs8RSpvTvCBaMRk4pga7/EN6ErNlnM4/sVqDbjNGn2736vSdVRqSlal+rEcZR8Q8o7x4P5qxSPz6AgpRwxBOBNmA4nPz0okuq/EMDgGDhUbYg6gxLhiFwxw4Ot0Kr5nqRbnMN0xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by AMDPR04MB11555.eurprd04.prod.outlook.com (2603:10a6:20b:71d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 08:27:58 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 08:27:57 +0000
Date: Mon, 29 Jun 2026 16:26:32 +0800
From: Xu Yang <xu.yang_2@oss.nxp.com>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Chaoyi Chen <kernel@airkyi.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Peter Chen <hzpeterchen@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>, 
 Andy Yan <andy.yan@rock-chips.com>, Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Amit Sunil Dhamne <amitsd@google.com>, Dragan Simic <dsimic@manjaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Diederik de Haas <didi.debian@cknow.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Hugh Cole-Baker <sigmaris@gmail.com>,
 linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v15 1/9] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
Message-ID: <k53t2soc3nxhwugncatksektig6agxfgdkogkdwbhrhu2fn2g7@auvsfrv76wxy>
References: <20260304094152.92-1-kernel@airkyi.com>
 <20260304094152.92-2-kernel@airkyi.com>
 <erx73m2ueuvbzjteadjli6aki5by4pr3hyertkkqqoqwhaa4v3@5cstmshcercx>
 <56c6abb8-c127-449f-9368-12f94620c2bc@rock-chips.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56c6abb8-c127-449f-9368-12f94620c2bc@rock-chips.com>
X-ClientProxiedBy: SI3PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::6) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|AMDPR04MB11555:EE_
X-MS-Office365-Filtering-Correlation-Id: f5305d0b-3a9e-4c44-5ca9-08ded5b852ab
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|19092799006|366016|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: WEAYDRX9M4Cqh+zmF67SmUsU435qfb5fvhxevYQJWqkz93Uq0qc2+WMOwIcHo/UxlD2jmP94D04ir6Xi9y7r3FigE6wu14944Rtm2JTBS4O1Nbn2Z9h8M2DphY/L03v3UiL+EgkFpDUGuU/IfhGzNgOwH19qK2jA4OK3vXuO6FR5ORRsddemRGcNCUhniKdQT9CFjAl9v2BzGevYgyhckfoylEM2CVagR3rL9wBXgqX2yhIV6KLlHBjwLt9ZJCAxEWBTWfIz4BtadGJcxbXWBL1ZBwjmPVVI5agASSK3wX8iMQ4LA7virZ5F18tYCAtOn4MgDwtVj+Y6Yo3oXo4F0jQBlAR+jANc9AsE9Il5Exe62/IhICtiz4en7kQk6C/8IRaCNMwwWly/RRzMbP5FRsKk4guR8pyAWtT4An1iTJPfqWJ2tx1py0yTTtuZGxHlOALcCe4BoA5w9Coz1jgH5l8miItwKAJ148F1kgTjWTwAuoWo78MiDrMCW7UNUSojouFRTjMgVZ9ELu8NqjDp0lyHvGHYaVlGd2VqztUxsrEIFrjY7olNzGoQNpfn/tejMKeE9rEYQeLbBJaudw4fkGpX4dpn3B/DK/bOYK16qLwzt0g27kWgN2gjmkbdasRcoeWk54gaKvOzoOh2MtBL4I3kEH2DO6sgUkS6ZJkVCno=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9422.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(19092799006)(366016)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gsTkS+0Di68y5Q1piqQ18BwEkP/IfsmODRGTPm/FxcXoCx9N3qfY60BWYyVo?=
 =?us-ascii?Q?ndXtwNZAbGPqMYnZSShszMJ8LUjXKYGAaNcGjcZhGCUOTpT6/dmlvjaJYd1V?=
 =?us-ascii?Q?QKp/x2azcmnyOCCRr8ZpgiL/KxxGLLiIekLu7g5Qlo06sUFzbtYawkAzdzVb?=
 =?us-ascii?Q?1G9BaR7IvJwsoqB5RXbya5KwHN8Mp9T4h+KO/pHfjJX5C4KEhpnufu/fo91t?=
 =?us-ascii?Q?gjI7ZQvHKFye5kMSEBAfIb7cseWCH3s+0WZTSqi8wTNfgtp0nckE1QNN4rnq?=
 =?us-ascii?Q?Mv8DERWqb7nFaPzYP5HOdhQK3OxQVjkmcWizyq9w96loekIrPNjtozGDxWkR?=
 =?us-ascii?Q?ur1ouKJDniTGFM8ub96sFR7rJ0OgyhK7HKyw/+P2g97z9TWvvtwDGXlFyWSW?=
 =?us-ascii?Q?oDLGE3U/UWqm3dSBVPcXmv/i8u+UiSlqg1PUobdu0YrSrgJ2riAIHjVSCahx?=
 =?us-ascii?Q?6Jq0D3N7jeKHZ0quvC/UqFeLq6D/h9l1b1x9ui+yCWUY5XFGSvjss3JVn7+M?=
 =?us-ascii?Q?twuv2aOhr/KY20a9HT1Fdpz9Vpuml5RzmjHUZd7f21X7KbDv2eCn2LN3BmBm?=
 =?us-ascii?Q?7aqzFvq7FUFfJ7jUPcoMlrvO3huckpTCjlY+pKmv2ZAeSaxD7ECdYpkeaHRz?=
 =?us-ascii?Q?OsgLvGxWB5PLJrdNtRftr0PEC1KQCma8Y5NX0ODP0GDGq1D6QdxY6J0nlwtZ?=
 =?us-ascii?Q?bxitZCJwdpARTPcImO6QHA+DQHO+0El7MjrxyhqFpXMDdcWhzbqnWJt/5N5P?=
 =?us-ascii?Q?kUIlKt8/d4vXer/EiyunOw0auMzUvy72/dfLArLQoOvuAIQbtCvyvduQ1yoc?=
 =?us-ascii?Q?xeNQLKGXTiXa/wDzQ5lFvqYi7b7S8y2tTPxZSxt2AGpsDtuXma44DunwKqhH?=
 =?us-ascii?Q?p4YIXqVBWiM1JSi5CAcdHjsagAkPTg1PUSFfl0WuB4kyH47gzj1mLlE/yZfD?=
 =?us-ascii?Q?dIfQr6YmQgOhLsSPbWb4pJj2rky8djkiWa1jCgx/j8PaoqNsNWV3q7YtsDzd?=
 =?us-ascii?Q?96LR/kWvbC4YOTGFCrEwxO9p3mYpOAeuGtqZYj/TPl9QztVz+en9ZeVExuYW?=
 =?us-ascii?Q?CBo/IOh2YS80PS2s3jmP31xQT1NC/seb6g62kV+WR6j/mPjLCE7am7of2MK9?=
 =?us-ascii?Q?hnB4zMzy73YrWlMTG0yiJYEpfDQTLIRs2WlsCvXdYq94b6S4zKBmOCykaBqU?=
 =?us-ascii?Q?Py4OzvavKG9XJ1iJAEMW0WY066EIkkM6mjvwdzLlJdrX+nH5HKoQMJTaO/qV?=
 =?us-ascii?Q?z+S00YgKxd6JThcXQSl5sKOaUMyuDSkRK3mn9f6ENT1sH6cFG9ihjn5XuGk6?=
 =?us-ascii?Q?xjsqX9wCKunOeSvg385hPkVszhKgxZYN4gg9P916z1N3xf1qyy3L4rDMfTWi?=
 =?us-ascii?Q?iN9cwojD6rNP/b7mYUn99EPFxkQfN1ALhnyODwR9JiUZkO2EjErMH8Wg5So1?=
 =?us-ascii?Q?gOTkFK+ftoILdZ46mH5vsLprBJT3DJBGUz5jdF1vYm/nlANHwWrSHf97kRc/?=
 =?us-ascii?Q?/6y/v8RIDEHK/FaUEmJZyIYqHb+AALhHyWjhhyFa9N8WEQ0vaHxl8+xjGg2A?=
 =?us-ascii?Q?kVclzsGoS8i3uzL9TUCg+6e1M2RfMnHpSLUNCVjwlG62uEP15JxXgf/DtCY8?=
 =?us-ascii?Q?RHkM2EERa3WxPSRlHnazfTI0RzfkR+YDEE62aeGJQ0TuedOWqP+6YejKPRyn?=
 =?us-ascii?Q?gUVjJP+fPAONs9P3F/zNyZgeNJhgZhHgQ30IXDU0G661HHhalDtoekVjDy8j?=
 =?us-ascii?Q?z2RCk8bYcap9O563Gf/w44EQ/Ho+ND+bjXHH7aIhIUJQXCHIUkUI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5305d0b-3a9e-4c44-5ca9-08ded5b852ab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 08:27:57.5896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCvQgZstkF7npR5g4ojWVi75soPfGVpUq1uN0j7PtOIqd3qhkoFp674Ws/rwzXkb6V0EKWhqtClxrxe5IoWcY4aZMNX5b1ej7saM0u7c+m47NMqQaVEAOHZQZ4M+88k7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11555
X-Mailman-Approved-At: Mon, 29 Jun 2026 11:23:45 +0000
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

On Mon, Jun 29, 2026 at 09:29:08AM +0800, Chaoyi Chen wrote:
> Hello Xu Yang,
> 
> On 6/26/2026 7:15 PM, Xu Yang wrote:
> > On Wed, Mar 04, 2026 at 05:41:44PM +0800, Chaoyi Chen wrote:
> >> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> >>
> >> The HPD function of Type-C DP is implemented through
> >> drm_connector_oob_hotplug_event(). For embedded DP, it is required
> >> that the DRM connector fwnode corresponds to the Type-C port fwnode.
> >>
> >> To describe the relationship between the DP controller and the Type-C
> >> port device, we usually using drm_bridge to build a bridge chain.
> >>
> >> Now several USB-C controller drivers have already implemented the DP
> >> HPD bridge function provided by aux-hpd-bridge.c, it will build a DP
> >> HPD bridge on USB-C connector port device.
> >>
> >> But this requires the USB-C controller driver to manually register the
> >> HPD bridge. If the driver does not implement this feature, the bridge
> >> will not be create.
> >>
> >> So this patch implements a generic DP HPD bridge based on
> >> aux-hpd-bridge.c. It will monitor Type-C bus events, and when a
> >> Type-C port device containing the DP svid is registered, it will
> >> create an HPD bridge for it without the need for the USB-C controller
> >> driver to implement it.
> >>
> >> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> >> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >> ---
> >>
> >> (no changes since v14)
> >>
> >> Changes in v13:
> >> - Only register drm dp hpd bridge for typec port altmode device.
> >>
> >> (no changes since v12)
> >>
> >> Changes in v11:
> >> - Switch to using typec bus notifiers.
> >>
> >> (no changes since v10)
> >>
> >> Changes in v9:
> >> - Remove the exposed DRM_AUX_HPD_BRIDGE option, and select
> >> DRM_AUX_HPD_TYPEC_BRIDGE when it is available.
> >> - Add more commit comment about problem background.
> >>
> >> Changes in v8:
> >> - Merge generic DP HPD bridge into one module.
> >> ---
> >>
> >>  drivers/gpu/drm/bridge/Kconfig                | 10 ++++
> >>  drivers/gpu/drm/bridge/Makefile               |  1 +
> >>  .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  | 49 +++++++++++++++++++
> >>  3 files changed, 60 insertions(+)
> >>  create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> >>
> >> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> >> index a250afd8d662..559487aa09a9 100644
> >> --- a/drivers/gpu/drm/bridge/Kconfig
> >> +++ b/drivers/gpu/drm/bridge/Kconfig
> >> @@ -30,6 +30,16 @@ config DRM_AUX_HPD_BRIDGE
> >>  	  Simple bridge that terminates the bridge chain and provides HPD
> >>  	  support.
> >>  
> >> +if DRM_AUX_HPD_BRIDGE
> >> +config DRM_AUX_HPD_TYPEC_BRIDGE
> >> +	tristate
> >> +	depends on TYPEC || !TYPEC
> >> +	default TYPEC
> >> +	help
> >> +	  Simple bridge that terminates the bridge chain and provides HPD
> >> +	  support. It build bridge on each USB-C connector device node.
> >> +endif
> >> +
> > 
> > Should CONFIG_TYPEC_DP_ALTMODE select this one? Otherwise, we need to do it
> > manually.
> > 
> > $ grep -nr --include=Kconfig "select DRM_AUX_HPD_BRIDGE" .
> > ./drivers/soc/qcom/Kconfig:118: select DRM_AUX_HPD_BRIDGE
> > ./drivers/usb/typec/ucsi/Kconfig:88:    select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
> > ./drivers/usb/typec/ucsi/Kconfig:99:    select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
> > ./drivers/usb/typec/tcpm/Kconfig:62:    select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
> > ./drivers/usb/typec/tcpm/Kconfig:85:    select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
> > 
> 
> That's a fair point. But based on the previous discussion, Heikki
> point out that configurations in the TYPEC subsystem should not
> select configurations from DRM.

I have just reviewed your previous patchsets but I did't find such opinion from
Heikki. Otherwise, why are tcpm.c/ucsi.c already allowed to add the above select
condition in their configs?

I think Heikki means that the DRM_AUX_HPD_BRIDGE shouldn't been selected at the
top level of Type-C subsystem. Because not all Type-C devices support the DP function.

As a generic Type-C DP HPD bridge, displayport.c will likely need to use it in
the future. Therefore, allowing displayport.c to select DRM_AUX_HPD_BRIDGE makes sense.

According to my testing, it's impossible to build this driver in unless TYPEC_FUSB302
or a relevant CONFIG is built in to select DRM_AUX_HPD_BRIDGE, or the defconfig is modified.

Thanks,
Xu Yang
