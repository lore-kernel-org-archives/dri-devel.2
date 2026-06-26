Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C34CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6443910E352;
	Fri, 26 Jun 2026 11:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cSk7RQ/n";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB0ED10E34E
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 11:17:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fx0GksYXDOy0LiAuIDq151I5dFaPsorNoznJqo+tPNTr9+Mwkfql2YfA9NvtAQ9wb/XgBtH82T8mU7sPqVK8qfdSCzZRInBK6EcYoLlfhl6qgCNMwA68lNeUubMwoFtv8tKcVK07Iy/Vws9ePUUJMx6GFjxotG2UaMzHk/yBzPrBEBV1z63RKjTuZbYUIf3zFWvfR4zyGHwBTw0BOZZ9NcFRUipaB4fULankIrHfCkDBV5Xe/WvWZBPNFq9/GbxQ7BxVaTjqIlimdlfODJuD6Oqgpd75IO0hf14L4Ek6Ig047almdcZgwksZYS6r708udXfynm6zQw2TmqsonbSmSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjzML74ejIpR6zLzlBjC6mSv6q/FdQD31kOWB3KqJnQ=;
 b=Jb94uce2abKb6F43pHbHl44/R1PaybCH6AhdiZjZsqJfJNVVEU+TAP+rzL41bUqOf5uBIaPAkCXX4nD/aEsAbaITWOsbbbsrsXrCiax3t7HvrHPSpd4TpbyfQOeANv3sCJY/zhYrY1kxYlzy5N78HEqViUDpE+4zDp/aANQYBpneck3LQvPEVcwZ86ekZsmpcEZ72MtHOP8AM3PYjZJs2Wka5gIPGaNZYUCShoU8I+tFwIvjMlFJBoS6hmqGRQTI9+jWfl+ElTK65diujUkQagwh3hP2JFJu+TJLpS7TlVXWFhN6NNFc4bbetQ9K6pqzKSQEvYq1lsEVhQlBec2sPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjzML74ejIpR6zLzlBjC6mSv6q/FdQD31kOWB3KqJnQ=;
 b=cSk7RQ/nvSM1YiY/BQgKxikTlHh6PzwEKXPk1mZ6aL0mK645EMjShIeKYZO7JsZ+P8j/6VCjTL3r64pmIb68GzvRsJSh+K6zH+nuam5x6h29AFwYHvtkg6LfsZ2in5y5ev1jR03SuZpCpDxFear+V6Y6xf3HsWJH35uf6k13Z67uTphQecFLcirlnICs3/p+5rwwnhU7WYHnsYSBKtmbiy+A8fIXJnlW2Q3y50TCns424H8XqtCBHVQPQ3bBXiG8Y4Bs3uAYnj4300Qjt9ixkELZ90VPhZy5MD/A5WaTaqareXC5z5J9AXbIGGtoFCCpdluB3Wsr6gP9OEGbrjnpTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by DBBPR04MB8026.eurprd04.prod.outlook.com (2603:10a6:10:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Fri, 26 Jun
 2026 11:17:05 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 11:17:04 +0000
Date: Fri, 26 Jun 2026 19:15:42 +0800
From: Xu Yang <xu.yang_2@oss.nxp.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Peter Chen <hzpeterchen@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Amit Sunil Dhamne <amitsd@google.com>, 
 Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>, 
 Diederik de Haas <didi.debian@cknow.org>, Peter Robinson <pbrobinson@gmail.com>,
 Hugh Cole-Baker <sigmaris@gmail.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: Re: [PATCH v15 1/9] drm/bridge: Implement generic USB Type-C DP HPD
 bridge
Message-ID: <erx73m2ueuvbzjteadjli6aki5by4pr3hyertkkqqoqwhaa4v3@5cstmshcercx>
References: <20260304094152.92-1-kernel@airkyi.com>
 <20260304094152.92-2-kernel@airkyi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304094152.92-2-kernel@airkyi.com>
X-ClientProxiedBy: MA0PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::14) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|DBBPR04MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a6c04e-9085-4344-f3e8-08ded37473b9
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|23010399003|366016|1800799024|6133799003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zUIh3be/D51eNGJ/NsLSKWvUOGlGyI698KD3goEQVj8+ww516sApvZ7ZiO9l6ZBgskjqpXv3z91BsMyAoHzBWsjFAOitR6qKfBSMQfycKE5B3QHPxz3XEgCqBelFIRKAjTY1pLMDz+EXMH3OUdKN19nldtYSZXmcoG+ASjUmHYmdEuWZjJSm4DpQsZIpXexxnRy4QoAZYnu6WcUVJDVEEK9GdG67ORhDt2Ctf6Lm73I5kqk1zKwbiLuXAOxLEJkWiduJQHa8js6sSThhjT9FLbxDWRltWYd9zZMTtQ/UxntX3eGaHioDu8LGMwW5dJUK7TowhESrrLJVBDplyytJDxzCCAaWM5UAMZd/IYRPCUZDG/LNKYdd+dF6iU3imDpzw6Gfi5u22c3tgAJ2fQLngCdCJ1UtCMuCiS8nkt+wF2CX3iy+LYfFGWBJHCUjegXq5/7Bm+Kbnaip98S7z2xFgGR1d1f+GhMd2sWndyNAukL1T6ZPUYfFTuuabnzsLVyMOgsxpcX2/zXWOmj3v8acKskTcE9NL1mq4dXoP3TSEwEENSN0jG7Bdu1w9ukhNlKtP9SO7KWTLlmYcqHaPw/aOx5+oc1AVaRjCjrCe1fPVfTjzUZDs7Bvsn/5uU5VR7V2opfseSnkWGrjCFDw3fK/xPC5dgSOk574LBkHzfazB2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9422.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ooeGY7oY34UOvc4nBl1WPcaeKeACkry2olwhNzkFfvQfthS+iHdJ7ZqGfSc9?=
 =?us-ascii?Q?OKT7s8pvq5NsUA0lbPsHBpKSMZTHWLvO2zraz+8avxNCVeMln4kBmoq2Kqx3?=
 =?us-ascii?Q?Fc8n4gEgFqx0Mplpa8VtSxVHpGQ0Olqxu+7fXbAE4T/8B+XMYmpsO295B5gH?=
 =?us-ascii?Q?L2hYDzFZca8XBTMrusK2iiL7TTu+YphyJQSs8rscNbWRliholCnMDQ+TGRHT?=
 =?us-ascii?Q?DAsRu8lM5p6lUus8a7P6NAwLR5KaMXt+rrXtf/tpD4HRLCdz17phgd+dTDEB?=
 =?us-ascii?Q?SxXsxkdw1vMEdunMo0RZugNxbby2PqodbyDT0+HubQoR4v4LwHNwTtQ0anOM?=
 =?us-ascii?Q?X9nN6YdIc/QZceDn79wiaCcAh1Vh4XzDtoJqrpbFP8/L7Z3t6RVHTws3XAzF?=
 =?us-ascii?Q?zLcw0O9YbZl8VAqknes7NRTZGoHyojLVHqti2m1u3PgcT4zAX7bYyTkWpbTN?=
 =?us-ascii?Q?H9P8NF/EdUdFsRBrgBqZNjaqsSRRKbUHTppZuVr8DkJIY0yTvM2aJ1mKBdq6?=
 =?us-ascii?Q?RC6IW9L1eKzHwAgVD9fs2sBtemetLopYr1tnooaMTXeA4v0Cu7haN9og9Kfk?=
 =?us-ascii?Q?s7tyjDmz2Wp98N+dph7oG7uaoxFJaKaSBAbOEKU8e61GHQUCUjP11F9zK/RS?=
 =?us-ascii?Q?Tt9d39JUvQ7m8bG2lSmgsSlo/zjL/TUoohc2NUW3mL1kdQ3qx4lSMyjIK/0g?=
 =?us-ascii?Q?NgQ/qsCyoax4OFnblL0npvMvd/AGB4zSxyuDCOIg5XLZml/pFDPEktHDi0ll?=
 =?us-ascii?Q?rdoITUmiuPSOWTGdtYp5HQX5hnI0fh09CG07to8Avis88L3GzSYVeSwms6mX?=
 =?us-ascii?Q?IcjwGijIgsXows8LiLoEru1vDUbw/l8B+UqlYFw6NU/uBjO9ITJjB/wOUPJL?=
 =?us-ascii?Q?07EAtVktet5zBZZrAIZdGxHs1izN1BrOf1KmEj+JECHznrHJz4BFIOkhCxbi?=
 =?us-ascii?Q?KawvyAyP+4n1BLruRny6nvO/DYwRVT71fU0EBRByLjYp0YS76anxsCoiGGjM?=
 =?us-ascii?Q?PtSZnesx6cIKG7JNensUO24VgjS77LiBAD8h6iLtwXvPl5D5aGJpP4Y8GJPl?=
 =?us-ascii?Q?MOaO2seRTLZIw7QCAZOL5C0lm1vzDBaDhh5qQ9zZhigT3Wolyy1ZsCH9mZ4t?=
 =?us-ascii?Q?VIDHBr8jvfFYVU6AP0AKXfbJ9FFLdw4x/xaPgqF9hNR5Yu+ZjTSH9DOkVh+l?=
 =?us-ascii?Q?W+3MLTg4o6jRnANnjx2ARWi4Vk8MT/zesRInbmWbDZMaf66KAsgOHMjAh5/6?=
 =?us-ascii?Q?Tb4Y9luAulCE8RPQT0+4ZBZ0m72vudQ44ILYfQqrmTmr+WEv1617DNexQH16?=
 =?us-ascii?Q?3fgzSQqSajDRTwtUkILDD4y9aEIyQ7mgG68ZjUHBR50OS09uSIBOLy59JBNs?=
 =?us-ascii?Q?VrtQ4emtyi77NedjC3bsAPzGWfjKVm6xgBNW1k5cdDna4N5qhXtEkPpHAQSz?=
 =?us-ascii?Q?8xDBYG1zRTzRXDCZICQ+cgaZ3fKXCd8FM3ROW91sXfciC56EcqhA9ra4j4Na?=
 =?us-ascii?Q?jT4DuxkJAvu70N1Ykb3huDGDdwbsP81OCMPjyU4MNVXGSQTs8X4UYlbzOcnE?=
 =?us-ascii?Q?3gyLDut8GwfNsmL9T9J8XPi8ptYnJx3ClMRtpT6ZP1HXiGPzVS4QR6o0JRG/?=
 =?us-ascii?Q?jKRgj5digspJm9YjRkv7neeyQ8DZfeiC5HTpb8P/OQAS4xSaj5egP0IsNoj6?=
 =?us-ascii?Q?bLn3QaaPq6cmbmfsMq17G7ayxNcKgFv3ZJ9FxkkqSYVEee3MOKFFbhvrBA+8?=
 =?us-ascii?Q?W8UBHr1EhsIhHRBzDRaDDSUuPeSlhW2CzUZjiHP4L4hi4Fg7LnaC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a6c04e-9085-4344-f3e8-08ded37473b9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:17:04.8307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IG396oaH562jMvnEFh7iKacdFcbMY3R6C7lDOmNTFEjKpFgPOdQORlrhM0ONQPr5TSs6AZ6zgRwpNRz0Cpgt3WtGddZMm0C88sd0B6umJ7gxJQdi3Bjmhqzqtxd+BqK9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8026
X-Mailman-Approved-At: Fri, 26 Jun 2026 11:59:44 +0000
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

On Wed, Mar 04, 2026 at 05:41:44PM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> The HPD function of Type-C DP is implemented through
> drm_connector_oob_hotplug_event(). For embedded DP, it is required
> that the DRM connector fwnode corresponds to the Type-C port fwnode.
> 
> To describe the relationship between the DP controller and the Type-C
> port device, we usually using drm_bridge to build a bridge chain.
> 
> Now several USB-C controller drivers have already implemented the DP
> HPD bridge function provided by aux-hpd-bridge.c, it will build a DP
> HPD bridge on USB-C connector port device.
> 
> But this requires the USB-C controller driver to manually register the
> HPD bridge. If the driver does not implement this feature, the bridge
> will not be create.
> 
> So this patch implements a generic DP HPD bridge based on
> aux-hpd-bridge.c. It will monitor Type-C bus events, and when a
> Type-C port device containing the DP svid is registered, it will
> create an HPD bridge for it without the need for the USB-C controller
> driver to implement it.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> 
> (no changes since v14)
> 
> Changes in v13:
> - Only register drm dp hpd bridge for typec port altmode device.
> 
> (no changes since v12)
> 
> Changes in v11:
> - Switch to using typec bus notifiers.
> 
> (no changes since v10)
> 
> Changes in v9:
> - Remove the exposed DRM_AUX_HPD_BRIDGE option, and select
> DRM_AUX_HPD_TYPEC_BRIDGE when it is available.
> - Add more commit comment about problem background.
> 
> Changes in v8:
> - Merge generic DP HPD bridge into one module.
> ---
> 
>  drivers/gpu/drm/bridge/Kconfig                | 10 ++++
>  drivers/gpu/drm/bridge/Makefile               |  1 +
>  .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  | 49 +++++++++++++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index a250afd8d662..559487aa09a9 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -30,6 +30,16 @@ config DRM_AUX_HPD_BRIDGE
>  	  Simple bridge that terminates the bridge chain and provides HPD
>  	  support.
>  
> +if DRM_AUX_HPD_BRIDGE
> +config DRM_AUX_HPD_TYPEC_BRIDGE
> +	tristate
> +	depends on TYPEC || !TYPEC
> +	default TYPEC
> +	help
> +	  Simple bridge that terminates the bridge chain and provides HPD
> +	  support. It build bridge on each USB-C connector device node.
> +endif
> +

Should CONFIG_TYPEC_DP_ALTMODE select this one? Otherwise, we need to do it
manually.

$ grep -nr --include=Kconfig "select DRM_AUX_HPD_BRIDGE" .
./drivers/soc/qcom/Kconfig:118: select DRM_AUX_HPD_BRIDGE
./drivers/usb/typec/ucsi/Kconfig:88:    select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
./drivers/usb/typec/ucsi/Kconfig:99:    select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
./drivers/usb/typec/tcpm/Kconfig:62:    select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF
./drivers/usb/typec/tcpm/Kconfig:85:    select DRM_AUX_HPD_BRIDGE if DRM_BRIDGE && OF

Thanks,
Xu Yang
