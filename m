Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CCDCD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 09:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DC51892F8;
	Wed,  6 May 2026 09:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="PEUl9OkI";
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E723810E54B
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 09:49:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBrFDlcGroBPV5Pd9OlmU4LlD70/BZI18BAIOkK7XNMu2azDI93JukBmERYfr7tskcBawhU6x05Cd4T32j3yxnRWQSdFhtUN8VPLwrrVsHLQunDg6DNkYA8k3eY/ZGSddeM6moY3jHG7B8sxsW8FQPKAFOSuLasfWdMvXwlB27Q6S1VmpO3t3jXOSA83T2ZHGnoiaw9QJpOwrdljniOGu1QENJ+yvT8nZJ9Q2uFcrOkBypsk4Ejv7Lqka26gcqWfyn4g4WoZyCN4/FPeshEto4jQuyhzUx+RwtwH0JpteRkkVnu8aPg9Dz3NQcgyh1dAj/mt1NGSBdAQDkrniipGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbT7eYbrTDkqK9kwna8h+8xmULvqe7kKh4+/p/UJgQw=;
 b=TCEDm19ctBr5dV3YvX8KdAnuB9UQ7qxNJKiG+mvKznE4Vj4gDE0KQfIFYilr1v3ZvLIr6J86DFJoFKkVh8cIShjajqcveSnyS9s2wZENIYWybvspzL7AMEbfJ9ZrRU4FVXjpXIeCo+OB/kA3UPX60+BGpGG7W6WOGWjBMfDqCszQzJlyfWmUyPpyKavXd85C4GwHPSzVx0u9ACxCZThoRLMHqC7htDWfmSj14rhDzrihPBrteNrLPbG2rBhT1Iz1KX7vj9AaQc3QWqkesBRyiuNwNUNRLgVlTMEgzehd2KMMF+9suKU3Hk00pIZOUZcJHc8VTN/SOVs7Jwu4WcOTzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbT7eYbrTDkqK9kwna8h+8xmULvqe7kKh4+/p/UJgQw=;
 b=PEUl9OkIt6bR05bUC0eYbaDOALYTv8s0SKIPu/nKsyu5bGHzS+klIckpmHiaCD/Vi0GlzrTv719nOG25f59SiRVKYK7OSPApHZ2nY/mQiRa0rnClyiZyeeRZ6Tdmtb6J1y4472x/1EfaQBk+EzDoFN/rKx0ToEA0Pv/RI2q3Myvdq8JDkSLde7IY3yWBrUMMJY970rWHJjbuy4pIR7lQlBO/bfxPkfVq47teO6vRrIYEMPnKd7fUqmoy8UulXZlYRABtH8OEWrNV0e2FcelZvGjtUNSz6ehoTr2/ZhelsYzMNeIMxh89j43u1jaU3E7GtZLNJSdQ6XiJShwPrMTu9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by DU4PR04MB11815.eurprd04.prod.outlook.com (2603:10a6:10:622::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 09:49:23 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 09:49:23 +0000
Date: Wed, 6 May 2026 17:50:45 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v5] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
Message-ID: <afsO9TxVuz79FFQ0@raspi>
References: <20260506092324.635014-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506092324.635014-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|DU4PR04MB11815:EE_
X-MS-Office365-Filtering-Correlation-Id: 63204cf3-1fba-4d8d-3890-08deab54c07e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: IGOgOCA5+G2jn9CQptqTkpAneC28Llnr+D4yJxsfIvxZdtmX0XKPdxhXHTrvZ5aK+glsUdlYTY7oBFRr60FzBn5yDU0SzqHLZxTavH4gjv638GetS2AHYexIt+G0o8suAcN5dAES500uFQrKi2FvOrhedumfxpcorGbk7lDi1P9vEiYV3G/AC23lSO24HU7rBpVI0zYxlw1B1xLe3lp5SD9+n7A1NscHB2dh1X7NmeQHH4XYV4wTOlRROvOrlkdBypzv1EUDqEEDg8TdMT84cnhBeVsVGSfLY7r777PRBFdP/AnEBKHdlcGAlVY5hazR0luSf3HPM8bfffv17ovKyALvAoKLqreys2AfSG5f12MA/Dkrx6e3l7WO8+3FhA6QypJOVF3bDj5UGNOnAK6zkkze6soYjXEv0tFGfkCj/8bvGaOyUHJ2Eb8E1soQaLHS4flQfDxeubxMpR/NpUcLRLQWQxP8utmIWc2gSbFh5nm75rUCzSlnjTQTUJJ10Hmo30wxxHEo+WD/8iGr84vauJaQoo88lmNq0t9dHmRzHU4cTsLYXuxiGEsd88RxUHpDQCDyUDTFhI3LKR8j40ytGtBj/MpuCRfObO/PgwNF1DDAfgNUzl0xqajwdXG2yfXRqqLhwqLuKGlQgqiBIlpWYgvlTQAD928NvKpOr9tuPIi2ylBYaiOc5d3LnOLKpBfq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h/rDrF/2EFkaT/kQWfQEL05gWmp3LaEbrukUmvvYFodny7Z3I1kBd4yugWAE?=
 =?us-ascii?Q?+mrRPuzIl0fe+HJxEWg75IiUAH9h0azuXrtXgflF9tkWRE8SMnEZYnrIa9tm?=
 =?us-ascii?Q?4Oh6XWLrsJB9D9hq/OBMTYop5v46OxlSixHGP5HDfeLenIiu+ZJVs88ENfzd?=
 =?us-ascii?Q?HYoMRXH3VCP1auk4/ZOoSFzx4CTvI7oM8CSDwZWhlxnENGm/ad3JkARzkQYY?=
 =?us-ascii?Q?hvNTmNrh2MMSd9Tri/ONrFwdztyavFKh02JTqo6vlPfq/x+ozHrGsHfEG460?=
 =?us-ascii?Q?R3oOgSDo+RwT+3o59HQQ3RVmW89PqhQZt+XrZpDMPfRgQ8DjflbF25Mrf7/J?=
 =?us-ascii?Q?SOlRwdQuSdrfxhgMQxnr/KoPJ48wB0OYNW/XBmtvAXgWOoEIuGYrIngGMZ2N?=
 =?us-ascii?Q?TIXR5s14JvsA4W6CM5MQqTtC1aaZJQ/sobVOzz2dkJXiAntH9GAY3qyafs2r?=
 =?us-ascii?Q?zhQY+ohtfuHsdGH6w7s19OvpacSyAyVwN5RTAaLQrP5hcojl1RbLHjZnKD0w?=
 =?us-ascii?Q?KWPMFc0tj3yqtg+9/OP7C3cYfK/oDLf7s5sEoQ1IKq0mtTc35zm7nEZrYRD8?=
 =?us-ascii?Q?wyZljbMWLp4PqCRyFe9G87FlV6pFguJX48j16Z+6RzfVGv1ToY80+T1X26y1?=
 =?us-ascii?Q?9deY6yPOAd/wmceFqoJ5cEQ8Yqy7itz+oSzOw45Yma/T1FQekdFGdP+sgts7?=
 =?us-ascii?Q?1aaIUTy0WFzEHGW4l3lAcCUXIsWe88upjgET0GaKxR2RUq+FhgT5+2w4tAvk?=
 =?us-ascii?Q?mmWCpN90/DnOeoer4tPvv5qx8mMHnMUF6brt2y12p+O9KZTcWK6s/ht+/zVq?=
 =?us-ascii?Q?60IIFlDZkvrBqoNwopeQaYFVt/sUkmZFs204cCavO3hzunzIuIoJeoBo0XOH?=
 =?us-ascii?Q?ch4oal8PO3JcsbVOBH1gllPNtBD4E7+8w4rbRdf4JmFOFU/P6U1xRK4POGJL?=
 =?us-ascii?Q?ezLNDYuP0CXzd0Usgf9gnBrDv/0vfEBl1Dvz3K/fC07ctk8U6CFtQA97gm8G?=
 =?us-ascii?Q?6dpZs5lgnQF1gLDf1WQP1qbLSGWZQFnrPmWjQlUb8Cv0+oYypphvzLKPZS2W?=
 =?us-ascii?Q?5n036idHn9pE0mM2W3C0gFGkdIXiRfiY3AZct1GFmiTpMPqJe+pKI23EcXF6?=
 =?us-ascii?Q?A+s7aDDy2S96kdHRuzVxXggAdgjrE1k3EGye2ab9uA3xAGaXzV0eMbjsbPOx?=
 =?us-ascii?Q?N6tVZPrLs2ORE3FBw7onsBmY/XYLGdXdFTllornnvOT0hDn/SqYb7qOmZ+AU?=
 =?us-ascii?Q?47QrFd0YhgU16OuRWdLukptbDx4T4YpVrRf9VH3WsUEo/HGralUOqmwdp2nh?=
 =?us-ascii?Q?3MYQIm/ks9+8nrXJnlRdg3EKGDb9VD136rAzIbiC9aKhUF/0H+qZv6uPXIxj?=
 =?us-ascii?Q?r1j9Lku28zSwn0L1KPYC7hoqrZAvOEZtKaX2oSUuHHO+5sCdDsIv/+xXCG1e?=
 =?us-ascii?Q?4xadFkUhanLPQYcVbYIpFn7N5IKkyY5jI622qa7nPSPj0JdrMRF11KBIt5he?=
 =?us-ascii?Q?Dp901aCxtDoZ2cyWjabiQWWNf3cSJYp3Dy2fjwxVcFabWAJ7ap7e8cJH29M4?=
 =?us-ascii?Q?11xK/5z0Rdpv9JivV8JmY7sbNj2gn2ZI+Y9f41g3GNh4AI2IHxrajXnP0tc2?=
 =?us-ascii?Q?hteQ2i4T4oK3IlsAOu0gKvenS86flZ2aR7XvQmoF00myErS7tNXg6F7Ys4R0?=
 =?us-ascii?Q?8UoW1nBHKVTxWiS5PKTXZoMD66LjiMzvOAoJYx1/hdFIbTL/h4MU9dImZWz4?=
 =?us-ascii?Q?rBOhiCLGbg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63204cf3-1fba-4d8d-3890-08deab54c07e
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 09:49:23.1334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48pWGZ9glEPe37aDJVbY+s3U5mbV/xTxuzko5vqEEJNWnfmJfshLGyZcqGyKBN+u+vsmahK33tQYPgRlfBl5Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11815
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

On Wed, May 06, 2026 at 05:23:24PM +0800, Guangshuo Li wrote:
> imx8qxp_pxl2dpi_get_available_ep_from_port() returns ERR_PTR()
> on errors. imx8qxp_pxl2dpi_find_next_bridge() stores its return
> value in a __free(device_node) variable before checking IS_ERR().
> When the function returns on the error path, the cleanup action calls
> of_node_put() on the ERR_PTR() value.
> 
> Do not store the endpoint node in a cleanup variable before checking
> whether it is an error pointer. Use a regular device_node pointer for
> the endpoint node, check it with IS_ERR() first, and release it
> explicitly with of_node_put() after getting the remote port parent.
> 
> This keeps the fix minimal and avoids changing
> imx8qxp_pxl2dpi_get_available_ep_from_port().
> 
> Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v5:
>   - Make the fix minimal for stable by avoiding __free(device_node)
>     for the endpoint node in imx8qxp_pxl2dpi_find_next_bridge().

By "minimal" in v4 comment, I meant not to use __free(device_node)
in imx8qxp_pxl2dpi_get_available_ep_from_port() and
imx8qxp_pxl2dpi_set_pixel_link_sel() - please keep using
__free(device_node) in imx8qxp_pxl2dpi_find_next_bridge().


>   - Keep imx8qxp_pxl2dpi_get_available_ep_from_port() unchanged.

No, please fix imx8qxp_pxl2dpi_get_available_ep_from_port() to make it
return int.

>   - Do not change imx8qxp_pxl2dpi_set_pixel_link_sel().

No, you need to change it.

-- 
Regards,
Liu Ying
