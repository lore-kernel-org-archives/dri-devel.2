Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7DBCD4846
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 02:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F0610E231;
	Tue, 12 May 2026 02:23:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Cf5RorbF";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013039.outbound.protection.outlook.com
 [40.107.162.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E39F610E231
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 02:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdHBMX3RrhbgcZgbl7NXR+D8L1QEKBcL5BRodeTJDisVzUQGgt4HZdkh8hZE5heXGMH5TG6IItmwRk/Ttlk6IfaJvBlZiGyESLzulkUNiIkwNS8xFDEc8L2UeIW61qTsuoZAzT7W6xj7GCnpKCFWu1TFZtLTGFhExZnt4o0J8R9FSFZNmlPbdBkn0ekTAe2i2I54+rvTr45R//y7Lq3S8dXWS5+uO3Wzka9VUqoy8PewImDoreobVlzFYjx+9bWraYPPVIS8ha41L76GVXQeCyQQrnIMYEtiiPnmFtS4ciHPe/y/GyRb61CNPCoLVkGxOk5x0ctoh9nv7q1B6yM1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EW86ct5F352Em66veZJK9pXx2mHmypqLnNco3cEf8Dc=;
 b=IKh3+QHgltZcMsKvGe4zjxh3zDzePX1PUQweXjdSrBD+vSbw+BKNzZXsQhpRUdGmC0Qm4AnVe/nlqrozgNktLcrwC45645qvNff26DsmyAM1imZjho4ViGcWdzymHxJ95LxeXN7PgxrF3hpQqifxBjJ+fumGhMt2W8EVoZ3c8QDy0gARAEML9SK6FemsLB768nbICTy4MP+H3ImlPaJAvbi1zeb1H3jPvSKc4goP6OXDQs4ZkegzmWdqwQZtulxT2j7P1HMRRQVPd6hOfyz/l9uEL9ij6T7ttqB00HK11Bu7wMRI5MRd8x1cVd0zybMIFLUpG1x1AySEP8lVghVVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EW86ct5F352Em66veZJK9pXx2mHmypqLnNco3cEf8Dc=;
 b=Cf5RorbFYmVW+4VgfGpkwZTdP2OP29p5wj/1nFfYk+jjX/WMgUKn5I2B4lMhAMJ+YuCV1VyoIkX1Ift9l8ruy78sL6FLvFHuFbFu0XYHiptu4SCcwZ4PvLqh1/9T2ypclxit13kZgUMC9MzCXkEIbkX7BpnyuNS8e2VUmIvL0qKtLKCCwJ5JNCW+L41JdBV5R+wlBeSP+u7hAKhBKs82zYYLzaH2eZsko9JcxtZgr+NzrGjzmBAZ1VqtdwOjdiNIiNaH3VlQ2QJ6kV1WrhMnSdIKnXUAddUmFmdiXanxwro8xSzB+xICjj7/qQp7AkPpJyyyLbLqclpJgnl1ow8y6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by PAXPR04MB8095.eurprd04.prod.outlook.com (2603:10a6:102:1c6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 02:23:04 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 02:23:04 +0000
Date: Tue, 12 May 2026 10:24:28 +0800
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
Subject: Re: [PATCH v7] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
Message-ID: <agKPXPKGOklTSFJQ@raspi>
References: <20260507100604.667731-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507100604.667731-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: SG2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:4:188::14) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|PAXPR04MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: e83f31b4-194e-47dc-e886-08deafcd656c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|376014|1800799024|366016|3023799003|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eG2zaN5/5TSKuLYe3pAupphf13qyGnCd/9heKJjK2P4utEBLEUOqNNA1dK10mr06SByJ54NmNbsZm4x48RxUiGFjLYtsIZjnewta/aJuEKey50/yFp/YOOePgn/t99y9UL+oytg0s5P3hXUvhIrWVdczNrp+xGVyvvQ7paU3Xf/eWqwaTO0LsvEFGxmIErfVX5ERNXYZIkdkxukRE8+BUHAZelEm9ley3YuXcg3UkX6mHwYSDrPJXNxvw/J1hErascVf0UBTtuFA7iE5gqkrsEBE+/IxmKrT/39Rr0rglP1/98qN2l952FaOxNza+Ykj7FWQCiMDyArfSXO6Xjjm3Edt3vOv/3FZSwDVmc4UhuJHMIvCwb9SL9SEMmWsI0mjECkH+Zk1I14mQoyew0fCzIxmv/iCWxpNPpsJcmqGGt/227e9adVhRvGwZSZOv7qNEg+eToQyicwqOJvmjZk0GE1GKVQNYrMUnZRzJzkz/Nqma6EHMJu/T91rDaWY2bdBbAx2Xf3akfOFgnn+a6Jjj83ITXziC/cjanme6fLvKA/mnJ90VW3eBTLVFnlPd5MeyXDzy1fUw8+hdR+BlgYEXbKISZgFr3xziOupWbM5ed8Ek/3yTNGOchioTP8QaY+bbR7z8whmrLgDshQQHJNlfmnYDS61LhKsM7CJCaqb9y17KvFoKFkwmBPw+juOvqym
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(366016)(3023799003)(11063799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VfmO+GO5GrwVsR5vqL9DlTASBhE/FZKfUc0J8stV3FmsGl83w81tPucHSDqa?=
 =?us-ascii?Q?H4IRmMxCsHFqFKz8LOyB5WJONdcMhbKNEW8hJ3Y8PydE4FhzTqqOFwtI+KtV?=
 =?us-ascii?Q?9NEC1bhpzzRzLepHFx+QTiLKYMxOFd4gRxtLP7Mm5O5MECd2AKeDcYlWCmQF?=
 =?us-ascii?Q?jrYCHG35Nfi285lzhRsrCwQlJ6veKpRbm3RZHlFQYHvMMdlYshtwBnHxIiTO?=
 =?us-ascii?Q?VipLenQb+A5nW83nUwNxmFHnXTcoDY2+w2z+Zo+pqqrMIlkEbOkMYZD3X9o2?=
 =?us-ascii?Q?cS/UCR4dMDU+AXCV6JDsg1iFYvbOksN5yvxHdDG1Ccm8NMAqLOqLacvB0aaj?=
 =?us-ascii?Q?dULSobgg6o9btNWOLtO2OMV/LHdEz1s6mzhWU/ZOIFhka9jYd9IeaBWpqxYM?=
 =?us-ascii?Q?OacbQ7r3XU9o0MMcEomX2y9yMHUvAlCsl3tQLXsM6jRESuZPWeg63Q9ur3Fu?=
 =?us-ascii?Q?jSvFzOIcmWPhkfbbnba1EEAhzaT2J5SrNG9/y58caGW35j+GSoTM6lU7iEOG?=
 =?us-ascii?Q?nwiz+nqthydS48vCxReSIT2aSfn+E/8aNaMC3X+mq4ShtT9dy0cYaWImQB4W?=
 =?us-ascii?Q?1OZKRgmRL97KdWFL4u+6g72oED6S7F1yE7rN+7zCjSVHwiT1lHlVrs0ZzEI7?=
 =?us-ascii?Q?qjJEk8Iia+8W76cUiFECOYFUOZn0keBE9UBI8QHXIAQM0UdlTBXiXOqt9fj+?=
 =?us-ascii?Q?uW3FAAqO+PIyq8w4i4trFDOYssR0zE5QAze17sXiBNMx5SGpvYycDQ1jYW8x?=
 =?us-ascii?Q?g+g3S96piARWTPV7FIe47V9jc21EP1e8gaO2OxVyQEO4oqn/hhDlLLPiUots?=
 =?us-ascii?Q?lwvCGGXXBcTcj0u6sQVWsiw7k1pbPEdZxKuZxGts9W3Z7KnNjgkOp5kWpD7b?=
 =?us-ascii?Q?kyFs5gPHSHsEro654ECX7FxNI2vzWRE4O7QimawGPp8sD0N7uN6NKZNspOdF?=
 =?us-ascii?Q?scSjQulqx3IJXVpMfubWQcY7UZaXnosRJXivloHx79Irxkv2EFWNjR3tGzER?=
 =?us-ascii?Q?ke5VShYKjt75UYWOad+Zp3NY0FsZ4l74Sj93JyvL6RbyxFBqwD3eJVWCMRTp?=
 =?us-ascii?Q?54t1w4h1qtjQRocZMaZas+7QKNmqTDje+xvGJg7Q2g1alogwhgMVS/VsDIzC?=
 =?us-ascii?Q?I4UPo7GmM5+qUIs25v5thsFQ/Ldq1wegh1jgcZ9nB9ic9VuTDi+QaFW2Cvna?=
 =?us-ascii?Q?HbguEbxFEutGmfZBcaKeASJvAEslFyT8+Tn1WBFuhgB1qSbSyA47qU/RSyke?=
 =?us-ascii?Q?1/stDueTpwBbp9XSmvdV8GR0KEnF9cY1dBK0dHAn8JyQVrddLGB8txii2afN?=
 =?us-ascii?Q?c/PhAiS2ISUfGvVgsHv8jxVR4s/yfKjh/07a2M0MlRuFXw+TAtvtBC1jZ7Lv?=
 =?us-ascii?Q?4Fe1TrpjcdyM1xgwbsFeD/dMG/qZ1JamvaKxtWXffAIrNfJFYAu+ErUPWROq?=
 =?us-ascii?Q?BD1c3XVvNazq2y+cYJFFD2AcMo0WxFLGnvFfDA1N9OqwKyZgMu4IL6+M9kbT?=
 =?us-ascii?Q?Y+0aVj65PacLo9S0RWdaPv1go8usXfxcI02eIOYeIngc3ODN/uujE5dZILjq?=
 =?us-ascii?Q?jppR9WV4RUvQ033itXF2nM1iExZANx7fxJhW7ZuQg6ZwGkwlgYXL8MnRTY/Q?=
 =?us-ascii?Q?jAaczqX/AltrXkjF8C/L1l22fox6XSR9xgSAr1/QDLgNOXeony8W4dVglGZM?=
 =?us-ascii?Q?ZV5p8uqp6A+x3NWmVAXhBA98UD9CZBLHHXUiO5z6VL0jK6iN6q1uMEwho6rm?=
 =?us-ascii?Q?ZNfWM+gg4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83f31b4-194e-47dc-e886-08deafcd656c
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 02:23:04.1574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIzAm26C5R4xim7boYUrdPE2GSgTjylzbG/uYLvryNkiMwm25pxt1YI3fxzJUkQs0wQZECwZE3NBEHQ7n4ojLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8095
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

On Thu, May 07, 2026 at 06:06:03PM +0800, Guangshuo Li wrote:
> imx8qxp_pxl2dpi_get_available_ep_from_port() returns ERR_PTR()
> on errors. imx8qxp_pxl2dpi_find_next_bridge() stores its return
> value in a __free(device_node) variable before checking IS_ERR().
> When the function returns on the error path, the cleanup action calls
> of_node_put() on the ERR_PTR() value.
> 
> Do not let a device_node cleanup variable hold error pointers. Change
> imx8qxp_pxl2dpi_get_available_ep_from_port() to return an int and pass
> the endpoint node through an output argument. Initialize the output
> argument to NULL so callers hold either NULL on error paths or a valid
> device_node pointer on successful path.
> 
> Fixes: ceea3f7806a10 ("drm/bridge: imx8qxp-pxl2dpi: simplify put of device_node pointers")
> Cc: stable@vger.kernel.org
> Reviewed-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v7:
>   - Rephrase the commit message sentence about output argument
>     initialization as suggested by Liu Ying.
>   - Drop the unnecessary sentence about keeping explicit of_node_put()
>     usage.
>   - Add Liu Ying's Reviewed-by tag.
>   - No code changes.
> 
> v6:
>   - Change imx8qxp_pxl2dpi_get_available_ep_from_port() to return int
>     and pass the endpoint through an output argument.
>   - Keep using __free(device_node) in imx8qxp_pxl2dpi_find_next_bridge().
>   - Keep ep initialized to NULL in imx8qxp_pxl2dpi_find_next_bridge()
>     to satisfy the __free pointer initialization requirement.
>   - Do not add cleanup action usage in
>     imx8qxp_pxl2dpi_get_available_ep_from_port() or
>     imx8qxp_pxl2dpi_set_pixel_link_sel().
> 
> v5:
>   - Make the fix minimal for stable by avoiding __free(device_node)
>     for the endpoint node in imx8qxp_pxl2dpi_find_next_bridge().
>   - Keep imx8qxp_pxl2dpi_get_available_ep_from_port() unchanged.
>   - Do not change imx8qxp_pxl2dpi_set_pixel_link_sel().
>   - Drop Frank's Reviewed-by tag due to the implementation change.
> 
> v4:
>   - Drop the sentence mentioning the custom static analysis tool.
>   - Add Frank's Reviewed-by tag.
>   - No functional code changes.
> 
> v3:
>   - Do not change DEFINE_FREE(device_node, ...).
>   - Fix the driver pattern by making
>     imx8qxp_pxl2dpi_get_available_ep_from_port() return an int and
>     pass the endpoint via an output argument.
>   - Update both callers so __free(device_node) never holds ERR_PTR().
> 
> v2:
>   - Fix DEFINE_FREE(device_node, ...) directly.
> 
>  drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c | 40 +++++++++++---------
>  1 file changed, 23 insertions(+), 17 deletions(-)

Applied to misc/kernel.git (drm-misc-fixes), thanks!

-- 
Regards,
Liu Ying
