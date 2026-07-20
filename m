Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C7AC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 029DF10E7C9;
	Mon, 20 Jul 2026 07:17:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="MRaGlqAS";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013003.outbound.protection.outlook.com
 [52.101.83.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FDB610E6B1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zI/Jw+nHVWN0+3Vt4VR2HvswM5w1GuoPTEuV7Xgu0Ko2J8u2RPMF9lNpAO0IpF/+1MSbg/TNhceyq1nsQGisVzIgeqjoJ4JHFVwdd6akgWBmy5RptJ4kfEbtudJxFZCxLIC/4Y03K6n67fnQqJjHhSZEprYcItCfomIhg+uIGr5PbYARs8w2IrFfRZUha/RpG3PQTRvPKEHTOd2fXxbvh6UVGxoNx/zX64XR0xMVYb49dEKVbSm+vd3eB5gemF4UlUubRGWHAX7ePK0uwhYZVN/w4Ik5AKbUtuvpvEusCa/5fYeMAdbwQ9lmDKIa3VPbUITODCifBnrs+YT6syp9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etE78zVh+atILNGaMszs7d90nTFsmdc8WwUTw3wpek8=;
 b=eKQPBzXbk39O2ezmEwvTP37JwdefXJWD/AbFaXpyzU3fN4OnqMsumR8Qfu8MtBuLAmjIfs2YrWK6uINzfSo5y7o5OP9Z2zROPpfIr/s0c5YWdMJOHEoSuQIPPIAlghNLmltwGKjoIKCYCyTC3/wf+GAjDokKN12oCa2dfI2lesBesOan5p9vEpVGPOkBdcP9D4xXsQ2zwhylopwzk/Cr8qfY3QWkAK7vQ2fUzFWji7Do4MnSyQDvIKeZ2c0wIzMFkjAE21NRC+eN9RTjrUUT/gcsfoSNCbMzzNvc3FzqB0rcTAj9E0j5KtHg9WBBaShiX4h52rhJbmQevWwwBwZGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etE78zVh+atILNGaMszs7d90nTFsmdc8WwUTw3wpek8=;
 b=MRaGlqAS9ZPYieobaSvgfnaJQsB3enLRtYRGId+lo2WrcoF5a2DDWDRGBAHzc2lpq1sJjff6TBOlP4Aj7KleYT97WlZRcitClsWLM7R6ST0U3L/VhWchMbSYosDGI6WNP/aA82g851dU7MizCBeicW46/ZA+d9Tp0JV0zlA9wgi3ReaCse/273a5uLJDy+Cu8aLzF2lCy7Znje2Q1yob5C2qn4pMpaUm2WvWDs9N9BZeOnzTCFO3FT8n7uXLp0d/V6yGcVw18yb9K84UVcOGI1g/44X76Z2qvpHh081I8zg4BLXFIMDM5R+AdXdlZuj2bbnvubON2Qq40y4DR0CIIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DB9PR03MB7404.eurprd03.prod.outlook.com (2603:10a6:10:222::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 06:39:40 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 06:39:40 +0000
Date: Mon, 20 Jul 2026 08:39:32 +0200
From: Wojciech Dubowik <wojciech.dubowik@mt.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/3] drm/bridge: ti-sn65dsi83: Add reversed lvds lanes
 support
Message-ID: <al3CpOXMCzgxil0G@mt.com>
References: <20260717115002.308035-1-wojciech.dubowik@mt.com>
 <20260717115002.308035-4-wojciech.dubowik@mt.com>
 <178432135989.269908.12890193389587995172.b4-review@b4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178432135989.269908.12890193389587995172.b4-review@b4>
X-ClientProxiedBy: MI2PEPF00000B7D.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::410) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DB9PR03MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: ff24fce7-3676-4eef-345d-08dee629ad30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|52116014|376014|7416014|366016|1800799024|19092799006|4143699003|10067099003|56012099006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EXg7Rkq4W7aL/rMX51Fr8JLHSCKWsWNJLZ1YJ+lRhTpfcsI10UAiaTUe8QxhcPPYSgR1JEhMAM35yXiweL4wpTn3TycYnuhoJswqKjAPJIVZTUFcCmdfffpKwe6ancdHkEz9H+Ce76NTYeY6mek5dTeNNnu3vkGwFVlIvH5dBfrNfaRaigB+BP6cR7+fcAvLavJK9jhLJYUo66MMi6+awf8U5DFyfkJ4OGFoYq/W+iIHcMYVknCOugK1RbKNMaRwUFahMiZtqoXUNWTIK9/sFdMagkDnFWJ+wzKAT3MPBtJSYc4fJ3I/V5Zx6Uhni7yorL/KUNHUIL9mZ1e8Nj/JD8NqqShZi7413Fw2K86hcugKoLgr713KzjARPeF9GDADb9w6cTO6PbCZ+Au9jS/Wk0ELgXCmBV+kFUyMQKA5lYyG0yAQxILb5rPQwa2Mp90OVGmRxyqH/jXtSvmFOcpbWYh/yA8hjmR1W8NLDO9J9UQ5VOIDO6FvZX9VG+xYCcgv4k7hp97XenwGlzxA6eQIDju4L4mwStgOndtJQc5oUq2Gxbp01qruRNvf6zJGTd6L5K42Xx/bOOgTfkIuolf27FKocneIPuVDPZLQ18/Fc/skxEk06P3RfGY8bF9y4c/GGEkSBWxlUjWLvIvWqseiWCBjAo+QRfLNxsJDk9jOVtc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(4143699003)(10067099003)(56012099006)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/JWlZqr4FPITWlVMoX7/cnimgrpy9cQDCRgqhYOCc+SuMT25IUwUhY6MZplb?=
 =?us-ascii?Q?oEm1bgSV874JKWidfEiX5qIvM+wzsRq4ILhY1IubEqaYxtkMitNNMrPzN2p/?=
 =?us-ascii?Q?jf8lPRN/1Vx+30ldNNN+I9KiDbzO71vfqZ7hw3CucbSvyTbKG6a2p0biyTpN?=
 =?us-ascii?Q?g5uB2agepMYfWhYxbRwIsi9XkkCYDd9gZwm5uMU4RoJdnnSx2Rh2bPgisvBC?=
 =?us-ascii?Q?09cx7fB6Y7Yuuw8ucrLFaRPuaQY03O0X96YzZBOZYu+a0uvZZR5cqD8fZg10?=
 =?us-ascii?Q?inxAF5Uql85Gc8i1vn+AusDkyCQMbeT/uHS2liFGnkmpOKqvgpgXrsdP/QD9?=
 =?us-ascii?Q?KbC62YzUGYZsqQSxFN3Nu811KgwwHEQUZ4fYQlj7cvJ5OY8djVgl0ffMn4OX?=
 =?us-ascii?Q?eWgdvr5624xlScXTSZFNxnduJOVR/GKO5RHmhllUM9Ovf+Cr4jsOdbC3epJ+?=
 =?us-ascii?Q?AVgZ/xhdFt78k3yhDauuDsnzrBDgvylojw/2Owb/JQrVoKndZgtMK6KHyJvR?=
 =?us-ascii?Q?jBE7JQk5sUiHoV26JrYbgYYtdxf44xZ0TANyIFooJlUqJIU4Plfy3JmBxtHf?=
 =?us-ascii?Q?/EqNgAy0VJJXMm+PqlFjQmh5dkvQW5SjsIkpOQVnby3dMwlid7Th/jUhwXFn?=
 =?us-ascii?Q?53Y9OMDyr682y70zd4yvXVlLrR82BVXisjh235KYSUUh354lBxBii4ItMgrj?=
 =?us-ascii?Q?0N/fVSsemx4dC9+o9VK0etkW9kFnSFbtnRW2ghQ5cd/hpThM15vZ87pa47rH?=
 =?us-ascii?Q?IPaJewXTTRdP1SSeEoFtN7IF6XkUwKdzilms3AQDf6w4peeFAcKU8JfQTtGf?=
 =?us-ascii?Q?pCklF5Jy6Z8X1lESGGxtYC6uuq1DzvKcTmAgelrFAIoBsNfDgZBFJL82Fary?=
 =?us-ascii?Q?fT5x+9nZh4BZ/WNx6dyIE+hCeZn7Pzs5As+0xyzgoDyTVQy0wSGjPI5PAlhd?=
 =?us-ascii?Q?QUjBa2EpovG8lzEAcykL1gLBJyRuzf6LowVBLyyvvGs64tmVF2COVLLAxh5q?=
 =?us-ascii?Q?Slv2sKjZpj/615SIj9LARXgxHk5/jw0loyxdhtjnFdqcAcYUjj3xpqjz+Xkm?=
 =?us-ascii?Q?mPGAHg9WgtEK2kTTOXDYcENVCWX3i3BuctYS9lIUnGLGsm1absObKgfGODTE?=
 =?us-ascii?Q?uvANJANjaZ20+TmWVW+lirkxOujCBQhqDpAH1OSb5pGt3PsqiVVyPBRY3TlK?=
 =?us-ascii?Q?GxmZFZvNLiKRNs13VCkrAVIXaAsHi5FCKqqnvCwTvZcneJak4bUvL85B1qEy?=
 =?us-ascii?Q?WVR6KjSGyd2HiHmurbrjG7tWUehsctLriEIxAmBXVDtbmLIrmIb9XLTELK34?=
 =?us-ascii?Q?50n8QCi09HN2Ql/RytTP5oL7gh5IpbDdXyCG+R/0BlFmUirgQSXa7k76pfom?=
 =?us-ascii?Q?CcNGylonFzuV8la0QaN4onbQ1oBSu7HQPRcpV3kXNgUqqtdgLTtiKH7HMf9G?=
 =?us-ascii?Q?Nv3PF8FWd9udupvbAdZHDjLC/tHZo932R8OWl547kPRFo/dd1/RYQBKCwq0q?=
 =?us-ascii?Q?oSLKkYs189oqm9okJCCsIgpDJifh1GBGfyixdpwgRLUHvT0Q6jj12bnSYxfu?=
 =?us-ascii?Q?94ER6gBi4Gc6IGFB4eQxIlJ8fQTSUlV8wdn9iMP/fNm/3E/dUh0MvSZaMKOw?=
 =?us-ascii?Q?SJg05w8iYtIRkAGj/5lhHmQdCAYPxqf/7gq1fyr8VYCcMcjQqu2JfHPRujSe?=
 =?us-ascii?Q?X3qcfys2RAAutKDnRJ1vVvVqgSTtMKLBu7o4nORWLh8r8wAAPFGuR4YQpc1S?=
 =?us-ascii?Q?cEtTlrvgqQ=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff24fce7-3676-4eef-345d-08dee629ad30
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 06:39:40.8237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97kZOMQZdaF+B2FcyfFyHPkbI+/BLyIn5Xlay1cWn2NsAiBaqy22Rm7umz1l4zfCxbN4gRrGunLqMvE67f/O2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7404
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:04 +0000
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

On Fri, Jul 17, 2026 at 10:49:19PM +0200, Luca Ceresoli wrote:
> On Fri, 17 Jul 2026 13:50:01 +0200, Wojciech Dubowik <wojciech.dubowik@mt.com> wrote:

Hello Luca,

> 
> Hello,
> 
> >
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > index f8a786953526..df44df2e872a 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > @@ -845,6 +863,19 @@ static int sn65dsi83_parse_lvds_endpoint(struct sn65dsi83 *ctx, int channel)
> >  	else
> >  		return -EINVAL;
> >  
> > +	ret_data = of_property_read_u32_array(endpoint, "data-lanes", data_lanes,
> > +			ARRAY_SIZE(data_lanes));
> > +	if (!ret_data) {
> > +		if (memcmp(data_lanes,
> > +				supported_data_lane_mapping[LANE_MAPPING_REVERSE],
> > +				ARRAY_SIZE(data_lanes)) == 0)
> 
> Did you have a look at this sashiko report? It seems valid:
>  | sashiko-bot@kernel.org <sashiko-bot@kernel.org>:
>  |
>  | [Severity: Medium]
>  | Does this code compare the entire array? memcmp() expects the length in
>  | bytes, but ARRAY_SIZE(data_lanes) evaluates to 4 (the number of elements).
>  |
>  | Because data_lanes is an array of u32, checking only 4 bytes means only
>  | the first element is compared. Should this be using sizeof(data_lanes)
>  | instead?
>  |
>  | via: https://patch.msgid.link/20260717115630.C58A61F000E9@smtp.kernel.org
> 
> > +			ctx->lvds_reverse_lanes_conf[channel] = true;
> > +		else if (memcmp(data_lanes,
> > +			   supported_data_lane_mapping[LANE_MAPPING_NORMAL],
> > +			   ARRAY_SIZE(data_lanes)) != 0)
> 

My stupid copy/paste error. I don't know how I have missed it. It has passed
my basic testing as it compares only firs lane. I will fix it in v6.

Regards,
Wojtek


> Same here.
> 
> Otherwise looks good.
> 
> Luca
> 
> -- 
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
