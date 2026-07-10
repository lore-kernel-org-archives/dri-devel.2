Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916C3C44508
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D86F510E7DA;
	Mon, 13 Jul 2026 07:10:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="CCjtC8Kt";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011025.outbound.protection.outlook.com [52.101.70.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9056A10F804
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 08:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHTzZ3+8t3ZR/W/TK8gJRI4A6OG9p3Rr8wd1A2gpLbpXKsLaaVCxjlxHn7mSMEmvbNgG6riLgRoiqr/R7crliiWa0kz/tr0QOjtkfNT7EwOrVPTJaAjAwlE0sbp0ELBiqKA2Q0+Z5tWG3oFnKUP3sLsyxZg3keO30MQZC45l7owbeUhtJq4tKE+eo91pu44ETiy1qgviduzoPOTclGc34Q+Uj8+24T0AjNiAtZBVHZGu8pINX7o4WqWH1kSl3sZvsLfb2oMznVw+5INgCGB0i7MGuGWsfCNgRjev+eI7Q0uPLq7pywVdbh+tLMvDgj7QvXJ5T9DkNM2p0XhDn0Ns/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2we1oEC+s9dhs758UVpc+RZ74buhljkVCxDaeBGmNw=;
 b=Xnt5MbAmXkpZysT9iQYF6sI527hgmy4JCRsNMSxk3TS0iO4JY7beQz0EqYOAiHtcsqF26Cave22D1jMbc/dyACTnoPTWJHEVL79H6Z5dbvOhlNH9kpdwcXJDp2IfsWJ2fQM102h9ACrtbYyig4qQzK7w13dV7VzlYZZzKRPGxB8ZY/cP68XDzg7oFAo4KM8FK6EWNPyz7NyURoyrW+ShKaaROtH6s6eE/4AmEcZH2Ewa00rJ2S7R0IbAwyBMC5Aiy6wn31Bl77cwvXdtHJSOQM/n/rthRvzEkfat4cQmjLn0FMY2G5K6vCAb5cTDjUs8RKgT52++S6BXsOA69NpVwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2we1oEC+s9dhs758UVpc+RZ74buhljkVCxDaeBGmNw=;
 b=CCjtC8Kt+cvXVmlKxlSFkyOVM2vKQe/zY4s7AL9LzQrVwCo0+A386GQOziG2JB+lhN8B7JCESbMcYwRs7z0Xrt+I3U8/Ib4MkvU5W2DOblJS8jnzbwf9hjkwoQPmaQDmKakmNoOm/DfMMYP/lLzNz4Y9netAZ3gf3P1yBm8qu/z3Pc4h1qmo6CWT5tU/1akzmnJREvMMeWFDqJotbif2+RZlTsAg0LsiEocrkJEQNuGf3c4FiYh9qQ4GZ0uPAo1XR0Nhdh4ioNDdA8AeDR5lICuueBcsu7TZY6reRU9YLgRaqCaLMHygoM1BdoBL0umO7Dc7lBjic11j1MdFlkUMOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GV1PR03MB8839.eurprd03.prod.outlook.com (2603:10a6:150:a4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:01:59 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 08:01:59 +0000
Date: Fri, 10 Jul 2026 10:01:51 +0200
From: Wojciech Dubowik <wojciech.dubowik@mt.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/bridge: ti-sn65dsi83: Add reversed lvds lanes
 support
Message-ID: <alCm706kwgyONL9t@mt.com>
References: <20260709125810.340612-1-wojciech.dubowik@mt.com>
 <20260709132944.GB1007225@killaraus.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709132944.GB1007225@killaraus.ideasonboard.com>
X-ClientProxiedBy: ZR2P278CA0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::12) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|GV1PR03MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ce8d25-519e-470e-e133-08dede598497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|23010399003|7416014|52116014|376014|3023799007|18002099003|22082099003|56012099006|4143699003|38350700014;
X-Microsoft-Antispam-Message-Info: ecDXLBh0tAknZzas9Vur49VXyfFjM7vrF8AJJY2QkOqEiTs19JgmGZhLm4AmCA0qNFpbdmokSSw5ptvcNBAOAaAKzSyB/sSOcK/8440MDTwI8XTo1bCw0GbKD66QJTc60aFI/HtY8zFNaQUrzJGaXFzoLbp4viUI+G+mxxZILhiv1srpovIXi5tcMLRfbbNE2CMSm6rO7fppxIWfKX+A5F97INhC+xyWu0l8IacUbNyKA+GzFNB5NsKSfF2DKocGXv2oxztTC3STf98nkEGlQOd2DPQ6Ei1CcyAoiw3D/6RGccbqz1sxPVMelXfeUvFZ0ZVPvaG13ngVMTY7UN2dMH3cWleqssGOxhe+Qa+K5trhXaGqngcTpIfWAcRgVuOPaTvev/HkWhdLYOS3hWRsWrNCApy2PNKfi7rUI+ESKJqWRP5byONU+d2AIBjYmO1ZQSfD8S5dqu89jyuUkK3xvcRKFrXjb/nOCBfZNOEXQYo67suufQHkYEkd/ZlivFJT7PezJfpSWI4hEPjEWYeZ0dV10iIX+Ecw5A2AKC28XkLLwLp3wktlmaXoFksFy7d58Ic9uFdOsYq0ISrCtAdUA/iaVIP+Cftj5L8vZATEmx6+HFPHOXuTkMmsFO9GBbEvhD5kb6kl2Ior0cjFuonlADjorvsw/urpELGA6/vbgC2CEUYEKouPPTdpvej5pyejW0L6xwfbPb7FhoAtQc3fdAD/rvB4opEIn3/DsVmRuIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(23010399003)(7416014)(52116014)(376014)(3023799007)(18002099003)(22082099003)(56012099006)(4143699003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1A/mU8pA0ygfckY2sCN2I04DgZn2ILnf0jC/p/oJ7aElMQn+FN5zc4N9+3Za?=
 =?us-ascii?Q?txEDroiSOVKoBwT7sQmMTuHJX0rO+p4AjviJ9zc/eAdAiKbT8lc7702Q5wF6?=
 =?us-ascii?Q?cmWCjzUEeGhFnzJX0ISqddwy8DjtCV0lqUVmJ3DdP5tWfkCNcVfA+aLTIdF4?=
 =?us-ascii?Q?DPKsmRQb1GQLU2lhsO1Vury7q+AAOUS2tVZJDUYq4vbges0iBU5S6IMGEGhS?=
 =?us-ascii?Q?JLqD2z0SDaMNSBgtad762zXdXaph5Kb9be/W7f943bkuDeb6n1lw4hN77Zvh?=
 =?us-ascii?Q?RHyqQ6QDm2RyacjIMIMuOnAd9gucq+leP3/h9pxT3wFTlbF5jM8fa9IF7O31?=
 =?us-ascii?Q?+3LCzT8rtLQqz+mhdYyg+/pTDedbSbcPdSA85kzHn7phaAYZUr4xhWqTMtmo?=
 =?us-ascii?Q?u7c0fn5HtucRC+HMbNHZv6La4jltJH+tQMohgNAVXsadrBiAKShe0QLnJ45G?=
 =?us-ascii?Q?R6Bzb9qobqWjOY6pGWgMeW2aUuYjG7hnXz53G3EXstZgaRwgBy/5BgtVB1In?=
 =?us-ascii?Q?v30HGyAW7upVSaCm4fTAWsu45Wm729SW+tIU+Hf4Z3laqCmBdmmsmxEsShtI?=
 =?us-ascii?Q?u55sTOX0eZQKjtEsU6AT1FSTZ6OIozH+CFZcdx96FZUrx+4aKIAaGU1gA1w6?=
 =?us-ascii?Q?di/RsBhWwp+7J2DkuqGmCz2gr/fGaqfkOTjk+3zEv0eBonOYstlHB5H3+EuU?=
 =?us-ascii?Q?YFFcV9uewyLyMLkJ+WlXxHUTFptxS1Vlv++PGrkMvQqwhbTvok7/ykPCXI//?=
 =?us-ascii?Q?Hotu0Llkoy8Fwib6UMzq2FVG7mMKDfdEMhXJROMZx+DaZzmoPpbIj3Qe0Vxc?=
 =?us-ascii?Q?ebssoupCBr5qxtUqDmwNxDd807UsmevX5mbP6Ve3HwswK1Zztjcy3Cn3owgn?=
 =?us-ascii?Q?EQG63ehRc5ZM0fKxTI6cLnI0kaw+2PBHtTE1wjGpKi+w+F/1BwQuA3Q8Dlcx?=
 =?us-ascii?Q?VxiLCZwd71OfJRFwCQFYJwajBn/27uMOdPaMaE6JnJDi8y4SDeYPmka+jJ1k?=
 =?us-ascii?Q?OIagXPg5DErnTpDY8lkTgEwQkVchKFIf0WsD2Yc0I51IXY+4pqqSeLL+H1bn?=
 =?us-ascii?Q?f4X9A34ro/WJp8WOxGeKTja2ZSofVHdBqqDnGd91Jhgp5Ev+Ve3041VJoh0Q?=
 =?us-ascii?Q?jKTMtpF66Cd35EHuRAP+1Q9wWrQYtvhye4VFLpcWTW0d9KmjvNdbN39d2ElY?=
 =?us-ascii?Q?w4Gb5vVfagt5D1vFHEb7mrEA2C8U8DtnxOVysgk5YzLRHc8kJ1FNzV8LEsv0?=
 =?us-ascii?Q?V7+y3tpCoYq6/0PgPAfv2/xp+7Uv/ZojxE4V+bR1KaLkEIXFeh4m/OnMdmCN?=
 =?us-ascii?Q?w/yV4xbpHuesuBpvoNo2F1gq2OYGuwhD1IKpPFIqdEP4cfrr0umYj50XjfN6?=
 =?us-ascii?Q?U06yaIoUHEDYY2YjbEpfXZDkwA+8dc10yhW09P8uU8LDV0kg75XL8N1++toj?=
 =?us-ascii?Q?G0EMqH/N5v0fqbCQ0MNCpR3IYGx+J7++RxDfFmBvB6FGMyWlHqEcbprF6iHr?=
 =?us-ascii?Q?TfjA8yR3vUEKEf81YVp3otgcP1yKxeJdOz2rA2Q7uFJGd+zukeBdO3OYzqFJ?=
 =?us-ascii?Q?4jJV8GEo31U0Y/pBfZ01FpuC3qsfWWoyXEpurZbRZqzFynnHjJObj4GP/NFk?=
 =?us-ascii?Q?6sdom38Toda82Fh5kWuAX8NvpjwwCtPXdi4CC4JQRdHwR45MVMmhgpzAne2V?=
 =?us-ascii?Q?bKnHxvVOEDv/Y/RBTE/NDpluNECzchRmeSm6ksP6LtFWKN6j0SP+tkyApZx2?=
 =?us-ascii?Q?+e+SXbwn4Q=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ce8d25-519e-470e-e133-08dede598497
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:01:59.3000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecXbngNDcL0nIKxB1Edrs1wyP/wSkSTnLTD8hsF9cQCMDW6kKuQx8afzbrpm8hVFq7E2VrvAewDx1z3Q26Fiqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8839
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

On Thu, Jul 09, 2026 at 04:29:44PM +0300, Laurent Pinchart wrote:

Hi Laurent,

> On Thu, Jul 09, 2026 at 02:58:09PM +0200, Wojciech Dubowik wrote:
> > From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > 
> > The chip supports output lvds lanes in two orders, default <1 2 3 4>
> > and <4 3 2 1>. Add parsing of an optional output lvds data-lanes
> > property so we can inform chip that the lanes have been reversed.
> > 
> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > ---
> > Changes in v2:
> > - Parse existing data-lanes property instead of ading new DT
> >   bindings
> 
> You still need to update the bindings to relax the ordering requirement
> of the data-lanes property.

The data-lanes have been defined for input nodes only. I will add an optinal
binding for output nodes which are handled here.

> 
> Does the device support less than 4 data lanes ? If not, the bindings
> will also need to be updated to reflect that.

There are 4 output lanes only,

Regards,
Wojtek

> 
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 50 +++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > index 42b451432bbb..4945d4c960c4 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > @@ -148,6 +148,18 @@ enum sn65dsi83_lvds_term {
> >  	OHM_200
> >  };
> >  
> > +enum {
> > +	NORMAL_LANE_MAPPING,
> > +	REVERSE_LANE_MAPPING,
> > +};
> > +
> > +#define DATA_LANES_COUNT	4
> > +
> > +static const int supported_data_lane_mapping[][DATA_LANES_COUNT] = {
> > +	[NORMAL_LANE_MAPPING] = { 1, 2, 3, 4 },
> > +	[REVERSE_LANE_MAPPING] = { 4, 3, 2, 1},
> > +};
> > +
> >  enum sn65dsi83_model {
> >  	MODEL_SN65DSI83,
> >  	MODEL_SN65DSI84,
> > @@ -163,6 +175,7 @@ struct sn65dsi83 {
> >  	struct regulator		*vcc;
> >  	bool				lvds_dual_link;
> >  	bool				lvds_dual_link_even_odd_swap;
> > +	bool				lvds_reverse_lanes_conf[2];
> >  	int				lvds_vod_swing_conf[2];
> >  	int				lvds_term_conf[2];
> >  	int				irq;
> > @@ -644,6 +657,10 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
> >  	regmap_write(ctx->regmap, REG_LVDS_LANE,
> >  		     (ctx->lvds_dual_link_even_odd_swap ?
> >  		      REG_LVDS_LANE_EVEN_ODD_SWAP : 0) |
> > +		     (ctx->lvds_reverse_lanes_conf[CHANNEL_A] ?
> > +		      REG_LVDS_LANE_CHA_REVERSE_LVDS : 0) |
> > +		     (ctx->lvds_reverse_lanes_conf[CHANNEL_B] ?
> > +		      REG_LVDS_LANE_CHB_REVERSE_LVDS : 0) |
> >  		     (ctx->lvds_term_conf[CHANNEL_A] ?
> >  			  REG_LVDS_LANE_CHA_LVDS_TERM : 0) |
> >  		     (ctx->lvds_term_conf[CHANNEL_B] ?
> > @@ -832,10 +849,12 @@ static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int channel)
> >  	u32 lvds_vod_swing_clk[2] = { 0, 1000000 };
> >  	/* Set default near end terminataion to 200 Ohm */
> >  	u32 lvds_term = 200;
> > +	u32 data_lanes[DATA_LANES_COUNT];
> >  	int lvds_vod_swing_conf;
> >  	int ret = 0;
> >  	int ret_data;
> >  	int ret_clock;
> > +	int i, j;
> >  
> >  	if (channel == CHANNEL_A)
> >  		endpoint_reg = 2;
> > @@ -854,6 +873,37 @@ static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int channel)
> >  		goto exit;
> >  	}
> >  
> > +	ret_data = of_property_read_u32_array(endpoint, "data-lanes", data_lanes,
> > +			ARRAY_SIZE(data_lanes));
> > +	if (ret_data != 0 && ret_data != -EINVAL) {
> > +		ret = ret_data;
> > +		goto exit;
> > +	}
> > +
> > +	if (!ret_data) {
> 
> I wish we could drop this check, but as the data-lanes property is not
> documented as mandatory, I suppose not all device trees use it :-(
> 
> Could you, while at it, make the property mandatory in the bindings, to
> ensure it gets specified in all future device trees (and fix in-tree
> offenders, if any) ?
> 
> > +		for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
> > +			for (j = 0; j < DATA_LANES_COUNT; j++) {
> > +				if (data_lanes[j] != supported_data_lane_mapping[i][j])
> > +					break;
> > +			}
> > +
> > +			if (j == DATA_LANES_COUNT)
> > +				break;
> > +		}
> > +
> > +		switch (i) {
> > +		case NORMAL_LANE_MAPPING:
> > +			break;
> > +		case REVERSE_LANE_MAPPING:
> > +			ctx->lvds_reverse_lanes_conf[channel] = true;
> > +			break;
> > +		default:
> > +			dev_err(dev, "invalid data lanes mapping\n");
> > +			ret = -EINVAL;
> > +			goto exit;
> > +		}
> > +	}
> > +
> >  	ret_data = of_property_read_u32_array(endpoint, "ti,lvds-vod-swing-data-microvolt",
> >  					lvds_vod_swing_data, ARRAY_SIZE(lvds_vod_swing_data));
> >  	if (ret_data != 0 && ret_data != -EINVAL) {
> 
> -- 
> Regards,
> 
> Laurent Pinchart
