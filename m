Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574A4CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B62A110EE67;
	Mon,  8 Jun 2026 07:46:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="lKewfL7J";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010024.outbound.protection.outlook.com [52.101.69.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6445C10EE67
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:46:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTNyqqWkkM4Pi1iY9w+/PtxeR1E+arx2rkMCcJHeFybMiKs8GeWKmghmCVPCsmW+SsfItn9dgQ85w24TqixdPeLvy0ekomuKIe7Vu2lTeJRunptayJP0SaIQhnCViQOwSzTTYOiQ4ShHaX/WKVRv42jsjQBHnxsILEaJ4DPia61sSAkj0Uqq4O0SJXtGawv9Oo7y9UJ1NTs8GHpBliBshdusDfuF1vZ+DSRiQHUTHDYEjBPeiFzUBTJv5CQqY0t433GkY5Lsbt2+0w2iyhe1zZqBk6SmY9NFOsB5r4BWtILKlfnMH1v3M1h84qrqmvpn9TbgE7dzYpjF3EJkb5mycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQ6mPfcbdWHiwGZuUcE7ajMn3ERZw0VSdcFVG5P3GN4=;
 b=ugCdvOp4A7cOU9bM90othCZw86Z3QTHhwwP7Z/fSDxKMtuoEArUCzVnpkN2qQyFQy7cgxSFMAJ0pzRD+pvvaiVKxq/RJ2D2FlOK+6AftaUMjis4YxCZJOzKpqve1Vd+W5hDxwFx3JICFUOEsc7+DzLZHhd2Wc1wztRd6v+IoU4c62kWncgPgNPaLyM2WmxdEFTMXP3DcB/HPy7j3/3hLzR5DjKxu5YUyPuI+7vpSuYsBT81LxYzEkprTxyFbYqWrRxbmkRbfPWnEuYgQzswLGKCsO99KmbeHYYXLL0KmXLbHPOo+cvRMmy5OzZ7/NizTCn9R1PPt1uhDyl2rHg8gtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQ6mPfcbdWHiwGZuUcE7ajMn3ERZw0VSdcFVG5P3GN4=;
 b=lKewfL7JsFAotBH/UwkDXlgPE4E3xQixUtBs1mbgRLBuYYqgmDpRZJl0FKRYX1xcEIqbQ5wsYn5aicn8vClymuQNmvOo+4ArLvaqygsKaa0EGDvCAyi8J6ohCUORtW+IxKsvHvouTDVsk43ydqdVxLN0LKBfaxxfFGgLcjpwTfaFeiwmfuRAd6OXPVnXBXV/cI1pE7wCdlq8KZYgqMIyl9Hi12vglAvcjZ2lB/WSIp9GWCaHL6ByDvV7Ia4t7AB/9Ki91N9lVgTeDELJI03aTJSLpC6az8dhuETW1vFSJqaopV+8KGHheC2lkbnxS3GTZC/xKkLbZ5hlkWVRjB6J5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by AS1PR04MB9699.eurprd04.prod.outlook.com (2603:10a6:20b:482::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 07:46:53 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 07:46:52 +0000
Date: Mon, 8 Jun 2026 15:48:22 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Abel Vesa <abelvesa@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 00/39] Add i.MX95 DPU/DSI/LVDS support
Message-ID: <aiZzxhljfyYQ68Gl@raspi>
References: <20251011170213.128907-1-marek.vasut@mailbox.org>
 <20260605121112.27866-1-piyushpatle228@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605121112.27866-1-piyushpatle228@gmail.com>
X-ClientProxiedBy: SG2PR01CA0181.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::13) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|AS1PR04MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: efcb25bf-12b8-4189-39d1-08dec5321b0f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|7416014|376014|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dh302ZyQYqZ+8OePzC5016l2fCij5YGDwr2M/eQmGKxPy1vPOSI7M+y/ZSg9pIe9I5OKGInk21XT8le092Rhj9t2DAS3rSNfEHN3mmz+3DwgcBL4jROB7YdF5iEvw+rC6de7hdXzdW3nz4uqDRcCSrl3lnIvq3Kd8g9uIsq/j8Mr/Sg/oxqVg6kkcmN6bLQDJOX+4Ha+lxownnSiNp8ZxtshFvEVJJ/ScU1WHzcD+ASICwNNKbH3FMhJb9xqtUtlDQHAZ7mqW/ukks92fyZdSaZvP9h5AEJXYk5ZSrnrQajhukpfDpwGMzS4qnUN+v4kFSYXslS24TOpyhJFCVh/lQqPOUc94s4AHM1k6SKRaLa47YtRm9YG6Gswptku+1YJQRNa0siRoxp3+5iCWU5B//CksBLGqVBYL5A5FZ6ojjWYInBnIZyxoH7hxziBRG66fh9/fvREebN5NMKOblJa9OjVCtfKVzbXCMdt+u6MSEo5aAKlJ7TSV2dJXK5ykvxfeBJNM5zsigfUPd+EQdUXkqjqarYu4ZdsgslLbLA0AMKyixYNzAmsXmMwlqWSTX9Ee3THAdASHwPeodOzVk4CF0OykRhLUr6jhoC8GDANQ/kcOS1y3PlxTTgmHNC9qAaOdBc82PX7hn8TgzLQDImWhQlJFnIxXSW9TIXdc/b/G51GdN6K6NfqxzjNJLCmEULezfLfXKfYAhbgEZLW/H2OgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hKxmMz0FmPNgN6rzAoQ1BR2IXVvc6o4xxwAkJcH22aLU5b0FnCm/Z+qUvQUi?=
 =?us-ascii?Q?wgo6QoTtEoFfs7K/z9MB2idsOMfoFyvnZFueiq7aKnZicCsfn++PS55T7hh8?=
 =?us-ascii?Q?dsr4I5TXcHN+D41CnZ9vIsmxZ7pojIlDEoM5bRELdEbrRCqCcOpQgPhEH150?=
 =?us-ascii?Q?yMVPse/wjRKTzW85y4HQt3I4zJnwHypOX4foZRkdxXA6nDHilx3p4URQnL3/?=
 =?us-ascii?Q?QlKaN+9eDDv55qyW1NhZ0MXvQHOhXVkca6upruZahjDHLinCcRiGLixv6MJG?=
 =?us-ascii?Q?+zVDKc8gLInqSd5VHD2OiR+cvhOnh1opaYxpaggasXul1jaoxYZZ0zf4CT8d?=
 =?us-ascii?Q?WBSJ/StPoaJ+XPyP+4ML5KlF1AVQ66REYoMyJzFsujO7hAB4Nu1w8MWtONq0?=
 =?us-ascii?Q?iddXlOQKBsPYtkVmpQrx1OessJzDeGIzPiL6U11qlEDgU0Du8Io/vdvWT4sm?=
 =?us-ascii?Q?2TSo/EnPBAtDZXyRptxGjiSPG0+K8y8FWLmNzF7AWMjMJWV5daHEpccMW+0v?=
 =?us-ascii?Q?XcPBLX0VXsfmByXAs4J5daEJOweXyJ1y7+ltI+pwT3iAOwudnguYRdz2+TiY?=
 =?us-ascii?Q?H7epwfwebRc5CAR8XDCEt93LDNR5A6ByQVS3LBPWKca3yzW++tA7ZLsAODST?=
 =?us-ascii?Q?HLvFoVrNdr18mBxbtflpb7F33/g/pbhZvXguqPEd6Gp/dgqfNn/47TuNv/Kx?=
 =?us-ascii?Q?l+TwAF6R0+YtkYKP2lEFP2WhZiivcQFSp9KVu901YYvrRloxcyKuft+6D6CF?=
 =?us-ascii?Q?iNm/7V80x/3p7NVw7ScPKTfkHw0HhAu44E3ocDI6gWWwzIkTxBb7aGm7wsoO?=
 =?us-ascii?Q?1+fY5m29n+Nn31FK0DQGP4cP1FY4j4riIpEIzikAaKd+Rt6+kYO8cfmDEyLq?=
 =?us-ascii?Q?y/aHS5+cTTgX0DsUkpAPjuc1nmqru3V4ot20bmLxPMSBNyudg77i7i/gODc+?=
 =?us-ascii?Q?9T2FYRhQWk5zrQp4aA99pCyy6uYENfJm/wHSNUtMrn8S0JuixGnwa9lhQFB4?=
 =?us-ascii?Q?bJF3yTAYxo6ey1CBkc5ScMcV425Isi6WLCODczW6WScDFQ4CqkCLbQaJg7DY?=
 =?us-ascii?Q?MuFJkGG2JgnD/doevZUkZQsQ65Sg1/8xKL+cGdpHjgM+l+meq+ox7ttxeSoD?=
 =?us-ascii?Q?WfQe3bBPEc81oh8q93Ef38hx7JLMO4EaWr4GPPywfvN7GEwOSM2c5GxfTZqg?=
 =?us-ascii?Q?7O5fm9kIgPkE+z6dfzRa3QzACW6PfT/xhfqKCvtQK5ftGWwXWYwsxkzZ4ijy?=
 =?us-ascii?Q?vygCt+yXbvAcJ8YeW5IttEZfqRFYQ4qosvEFL8o/ORIzHVvyjuHxSGMz3dh4?=
 =?us-ascii?Q?eu/0U0cw1kL8qb6XjJiLltR501bsIYSf/9lTlw3e6bTMlBqd2ciqp5LIvYEe?=
 =?us-ascii?Q?QXUV8UVH8J2d3fWkFRl7ET0agIxgbo0dO9wA/lyhjTxj+v8Kah37zxj5WjsU?=
 =?us-ascii?Q?KywDVL9RNOUF8xJh8EighCIRza8kYPb0qG8qpl8ZEc6jA6OZiDtWe67/2kLx?=
 =?us-ascii?Q?Nzekbde8EIcT6KjEJbXgFdfls+NKf6GljagKGtiMDq0HnDmoIJo5FLiK+0ct?=
 =?us-ascii?Q?0jP8a3wxivErj3szEl80rmS1adlfJLfZKZlEH6Nt8/tFpNP0MGshd3MAxDa+?=
 =?us-ascii?Q?n/JSBhxM7JRYdSLO/SLOMvWNYnTI2Fj0YfJb2NelVROKvWYUTw0drgiruVhI?=
 =?us-ascii?Q?IreikOsI+WC7BQjZCYj63sVqqAe71b8nodfRdFCALGpuGQqYx0FlSE2BQYS2?=
 =?us-ascii?Q?rQilABCkMg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcb25bf-12b8-4189-39d1-08dec5321b0f
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 07:46:52.8241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmdnFYWF/dgbqvJyt3khy4OQwqCnfxhnwF3OQkghHv2jueTw6IYzXhl91Oc1OAZaP2LcQ3q+TRlcaQVMKjbi7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9699
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

On Fri, Jun 05, 2026 at 05:41:05PM +0530, Piyush Patle wrote:
> Hi Marek, Liu Ying,

Hi,

> 
> I brought this series up on the i.MX95 15x15 FRDM (IT6263 LVDS-to-HDMI on
> LVDS ch1). It mostly works, but I ran into a few issues around DI routing,
> LVDS format handling, and DC enable sequencing which needed rework before
> HDMI would come up reliably on the board.
> 
> I don't see a v2 of the series and things seem to have been quiet since
> November. Are you planning to post an updated version?

My plan was to enable prefetch engine support[1] for i.MX8QXP display
controller and add device tree for a whole i.MX8QXP LVDS display pipeline,
before adding i.MX95 display controller support.

Unfortunately, it seems that Marek is not a big fan of [1] and I'm busy
with downstream development so the plan doesn't move forward well.  I still
think [1] makes sense(maybe I need to rebase it on latest drm-misc-next),
so I'd like to see review comments on [1] and hopefully people think that
the overall idea of [1] is ok.

> 
> I've accumulated a fair amount of rework while getting this running on the
> FRDM. If you're not planning a v2, I can clean things up and send one based
> on the current series.

I still think that i.MX95 display controller driver should be in a separate
driver, rather than sharing the same driver with i.MX8QXP display controller
like this patch series does, because the two display controllers are quite
different as I mentioned in comments on this patch series and in discussion
in [1].  Also, the common part between the two display controllers should
be extracted to a common helper library as I mentioned there too.

> 
> Thanks,
> Piyush

[1] lore.kernel.org/all/20251027-imx8-dc-prefetch-v5-0-4ecb6c6d4941@nxp.com/

-- 
Regards,
Liu Ying
