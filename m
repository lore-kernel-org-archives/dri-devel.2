Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01CCC44507
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82CC010F7C4;
	Fri, 10 Jul 2026 07:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="ZekVPzrH";
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011046.outbound.protection.outlook.com [52.101.70.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D8A010E095
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLeYoDty5W1EvcZNG8IPoki2cT3z89QiHLdfS7KVlPzTIvQpmEzHivJA+veWlPHcooalSaE+WJxHQqvL4GVESGkybNWlLQk9bYaZ9vPyc3EqwQ6bXq+oshD1a0bHVLYT1ONpTnfiSWjWu5BjyZ+dLfk2cYCJDjeDbB/RTZ+TukKpfnl7XKfzN08NjSFs4rTyllUTdFFrGjsfaEnNiSw7/AFBGTgemTJ43ZUZcz6Nic4qI5DAn7A37bnnPgi0/LExJNAQZ7UayOLFnlHAux6uQLt+TxSaQsV58Gy1hCfAYHtGFJIUTScJmgF6TalhmowUp9+Et48OoEzjYcVRybDyUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtVQD2ZCGzBMK33vl2kEu4mMJ3kDmySXYwgDoYMl8JE=;
 b=IK8+Bx1BkhOw5ZboxrwWaQBZh3ZWCBjyMwIvcFEyPpe0sUbMLH3rcfCR6Ce9wUo6bMi75ptBDaObz0aaIYAaZ8TmpQCexjZgyJxzX09FdpXcxPQR7lGCrC9jy3+LnHVWOK6UxqNxNbV6NZlgQzG1yYMLw4FmVPXRQYCcr93JDtPOHBwME2dRCGjgrorOLddyvuJ/qmrbCRWZzaEXV32WHZrrU56M1leIqSwD6/HDZmYl2qLW7weMmaV81dYa3EMeqtzyFZJ1MMibR/va3Oc5pg1lAvNlkGg9didNGQ0ZBwD1t/yoBTR/6ICQYbSCoFurI5NkZzzNYjCMn6eObQEd8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtVQD2ZCGzBMK33vl2kEu4mMJ3kDmySXYwgDoYMl8JE=;
 b=ZekVPzrHHaI71KhAKcPHmjDeAANHcSnlojYzV4NHQyyOY/w+3SlIYRlPePX9wXdt0gx98PVNkcAAJd+5MqvY1jIoJTQ+8e3S3KdPG9GbZTPIg9xxvkGxYDUj3aeSiP0CSQFcdirjG6/p4uPN5ef8F8y+O48+vVJzBAttDHkG1mpsYfvDDqRBI14pwgPWCiP4q5IZ+0k2B2asVtHE7MGSC2zi8fKuEEKhytGEQtxhpxWbfTMEZL+dPJuuVKVgYeIcpXpgg6xJRPnEE+H0Hwki9bZ5w0GcFkjF9iC5CsFXEomNnTpFqnvHg7u+bYlbGFDvS/+q7IsdStUDk23spVCOPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by PAVPR03MB9044.eurprd03.prod.outlook.com (2603:10a6:102:324::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 12:57:27 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 12:57:27 +0000
Date: Thu, 9 Jul 2026 14:57:19 +0200
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: sn65dsi83: Add reverse lanes
 property
Message-ID: <ak-ar-4hTQYgCrZT@mt.com>
References: <20260707070244.230546-1-wojciech.dubowik@mt.com>
 <20260707070244.230546-2-wojciech.dubowik@mt.com>
 <8332433.DvuYhMxLoT@steina-w>
 <20260709091705.GA547298@killaraus.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709091705.GA547298@killaraus.ideasonboard.com>
X-ClientProxiedBy: ZR1PEPF000077DC.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::41a) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|PAVPR03MB9044:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b1674b-7774-4bed-e4ea-08deddb9a0dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|19092799006|376014|366016|52116014|7416014|3023799007|6133799003|18002099003|22082099003|4143699003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: jaDkAxo6eBUW4m7S/BfjER/3pXEfMPMjkctBS7bSHN+4yzfMb9F3LxlmzAyv/uesTZsW12AokInp1HSEUM9FOZw2rlIHGBy1PweDOE8EZIZHXty8i+nqqSjg1fiUaCCM2qKMtAigPKgfd6c96LRVha6CI8LwYY1+/91W8B1wMko+rNZGFJjbZMpP+N6rXL92gh+MxjDmUjGH/sJa/oQYlHXLvr5kQf4RwnW4IgrPe5c9kP42MrHBOgJfiJNeq6RX1SXMyY48DoPJ+5um8xOWOD6tZZMrJq351jm4iTb1kq7LT1p+8EQKhxGiG5TAPQHyJDhG7hVQ0ekT/v+V6FmcP6BXzL3yDicXYwrZmGgHvw4CTK9vYW2su2N8xSS7WsUSrnHO+/+q7nkg1OpVsrM8IBlim9Pfo/EFdAkLQtg3BaPnPlqoD9z1w/NZ15Uj0MkxtgrKCsh3u26RdVEKPaa6jPlhQfAf1u0gkv3+870HL0yWErRdkGBXl5QIIKHq4xHBvGZbZ2I1nIIPPVa4pXpMhpeIDjPVpW98u1PgdXlBkYKmEeAhqbMX7TZCrxY7k2w910HOllA/2gqahgLj2cpBl9k/Z5PfYG+znG3UoMEGD+SZbCIm8MkijcHhuObNUu4VRWMioyODDWr+a7cz8M/UjvaGY3MdjjmAyUqX7N00UH4o5DVXD8rK4hy9Bwt/+hBC4fPYtorVH3B5b3v4FJztcjRiyiTbYRsoqBWmXU2wWp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(19092799006)(376014)(366016)(52116014)(7416014)(3023799007)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?teZQUCmRE7Tq46bNjW2rIajtdgXbOlSBSsH/jjqGcltU5NI483y/vkpeQh1q?=
 =?us-ascii?Q?kmYHlzJvUXukeaBJ3SuHiufqteCLxhf9fT7VruJXgsk5zAFWC2o3updFOuct?=
 =?us-ascii?Q?VZZgJSFAN49f3uit4te5PuuqbgWref5SB6zRK2VGcGSjUnm7sPOwnQmWAM0K?=
 =?us-ascii?Q?YMRwiqoKho2PPDh9H2FOjQJkK+VwlHmpYPesT3LKAv00Icph1OtkHW79Y9BQ?=
 =?us-ascii?Q?XL3tcdAomE4355spMGrgbtm4N/S0vfTFg2fu+y4NKMzkRZV528MYXXEuQ03i?=
 =?us-ascii?Q?pYQ15MqOj6zPtmAKxsbV8BGuQKqoO+Lwa1zVkXmBb0c4IVuXHeIMZrEiHvfy?=
 =?us-ascii?Q?KQ7SwCWNsT7WdlwVjkajmVeHjMJP3xdLRUkhf8lN4p67Wj2PE7HiBHPwNfIm?=
 =?us-ascii?Q?suQrb3W1lnZwlLNjGmztgUhHt6VwmUz0HRzgkKmsJ9JZyjYt+P+saNqYtURl?=
 =?us-ascii?Q?UrxVbRMCkqheQ32eGBmCU9SS93MzcB7lUgDZybdwIxoNJyDZGGx2bPy5a63N?=
 =?us-ascii?Q?xkFT5r8kBzZrIDGd6oGfQczPz3pLq3ihNKK2X7xBvBOoLlEoe+gUyN71F9Gj?=
 =?us-ascii?Q?I1jtZ2GpWO0T8Kd+KUmkgUI/XgriZZ0Bi9xr9mrQoB/I8k/ogLhS2WXn9Tjc?=
 =?us-ascii?Q?xbG9ejcrpvu5WZ4mDkw2PeFH2dbXb6BTo029nSyrRj3tF5PTCwrVs1Y6D/zB?=
 =?us-ascii?Q?0Vs4Hz1UtRxDFEEgHATuTbM23g2UwJRCilwBw3EpLVwLj5E0Haf4gsi/2zkZ?=
 =?us-ascii?Q?m9Gj4aoUoS6KhA6i720VtEXD5MzwzN+gxjaocwkswYmsLv7EZJuDKjL2uxMS?=
 =?us-ascii?Q?2LKpQIZObwaYhVOHyY5K4cXouY+pA5n8BtGEzFFYTHZt1FrrT0ly3ZHQd760?=
 =?us-ascii?Q?Qfzdw0qtENzbg+XmR52DIeHXiGa1HbI8ek5J57r+XwZ7S8tqTgIrncbbagsF?=
 =?us-ascii?Q?xJDIWDMt23Vv0GXGKWEFdmMWZH9fnxkL8pDlrt+zkD2t9oR+cWoW4/Vai1eg?=
 =?us-ascii?Q?jCLqHaJ0ZSZgNc5dmCqmzgForVhh5nnZvcYthh6DnOsHkCCxiVa+y1sNpeqO?=
 =?us-ascii?Q?jw03q2EIbtUnEGyYJsnZuKjIgc6BGtXxE4YTdt1X5Vh6MpA4//p3ccIiLLrq?=
 =?us-ascii?Q?hss7vEMTLBwN4sYBKA20AfuM763A/RuuD4vwXeNk0fSVecWHCV/CcAU/AnYq?=
 =?us-ascii?Q?/z4X/xzttlvw1aXLifDWopvMkhIhP5oCR2ALTZ1Wq2HZlpuQn9W/MdZh0GG9?=
 =?us-ascii?Q?ZQPxIeMoy1rQtJu4Az/5nmrE1H0/kq3M6qCpPnX/VUf8aYrFHHhXorZmqYyA?=
 =?us-ascii?Q?ShhAryW4gz2Y76Q7wXJaAm24DESBAEas11OoYN5bKFJoROXM/KopfND8nWw0?=
 =?us-ascii?Q?APvCln1RIcKT1hgt7kK6TRNT736RKwPNobizvu67J8ruQLgEiM2QNQlFY2DM?=
 =?us-ascii?Q?ImnkWIV7lf63wUsXjrxosqvAEKgpkaO/G65p83R8HsGA0eEBWw1ja1sVi784?=
 =?us-ascii?Q?rPAvzBV1rBTyZ6su8yWsvz5zoUS+8IaiORPONeVk33JsHGiiil8VM2yc0Y+Y?=
 =?us-ascii?Q?nmx0m4FoTTDAoXPhCgLDPtEQb4Qd8QSbZeF2ycSQqw3lt+QHtAR4Dy5uitGy?=
 =?us-ascii?Q?VVBxrXn3PuD0+2GxNh+s088Y0ekh9TbS01Qp8baN6Qu8VghNyoU4RtuNkTtI?=
 =?us-ascii?Q?XR/dm6+pf1UxIwuQlXmmQx+Mbo9Z2DtrxYB7cwrFBuN/OvUJUfxpENr30vNK?=
 =?us-ascii?Q?kwSHgfT+9A=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b1674b-7774-4bed-e4ea-08deddb9a0dc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 12:57:27.2605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0FJp3dkF3hfimZ5p9ou2AqOZoyAO3wyv7WwROvtzcAHv5nG1rgAad/61j+/Vih7l4fUZP/q+8P7FXSoeQa74w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9044
X-Mailman-Approved-At: Fri, 10 Jul 2026 07:06:09 +0000
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

On Thu, Jul 09, 2026 at 12:17:05PM +0300, Laurent Pinchart wrote:
> On Thu, Jul 09, 2026 at 10:33:36AM +0200, Alexander Stein wrote:
> > Am Dienstag, 7. Juli 2026, 09:02:42 CEST schrieb Wojciech Dubowik:
> > > From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > > 
> > > Add reverse lvds lanes property for endpoints. It reverses
> > > the data-lanes order i.e. <4 3 2 1> instead of default
> > > <1 2 3 4>.
> > 
> > Wouldn't it be more reasonable to parse the data-lanes property and check
> > for the order instead of introducing a new property?
> 
> I think so. That's the intended usage of data-lanes, the property is
> meant to convey the order of lanes in addition to the count. Otherwise
> we would have used a data-lanes-count property instead.

I will send v2 with data-lanes parsing instead of adding new dt property.
Regards,
Wojtek

> 
> > > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > > ---
> > >  .../devicetree/bindings/display/bridge/ti,sn65dsi83.yaml      | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> > > index e69b6343a8eb..44483e808af9 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> > > @@ -115,6 +115,10 @@ $defs:
> > >              enum: [100, 200]
> > >              default: 200
> > >  
> > > +          ti,lvds-reverse-lanes:
> > > +            description: Reverse the order of LVDS lanes.
> > > +            type: boolean
> > > +
> > >            ti,lvds-vod-swing-clock-microvolt:
> > >              description: LVDS diferential output voltage <min max> for clock
> > >                lanes in microvolts.
> 
> -- 
> Regards,
> 
> Laurent Pinchart
