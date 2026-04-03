Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566F7E7E358
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 09:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B783710F47F;
	Fri,  3 Apr 2026 09:27:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="aFRzQLeg";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013016.outbound.protection.outlook.com
 [40.107.162.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C2B10F47F
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 09:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7HQctrz2NWbeIOoSMEG/TxSGDL6bWWH2s8NLxP/1R6f4+9qcfX+ZOAduV7eWBTE/2EtUqkoSsLmH7YOrSoQ9EjINPE20ZwnOXu8zKtqQwY2ZxuRI2HHbgk+0KuNDjg6M/fwq2WlqmS2k71qu1d4a5GogF7LNRPpyU5OgOq1x4Nox+8fmtgqdVFy+tctdDmb6C44OZFyc7i/VG0EyPTZGiyPLthmw6SByh0yZ8JBx4NrwnOwsQTPvIVFiliHj0JwLD9bS/UIP5mOC1YgrPMGTkAGr7j674uoBqMqRP+xPovqLLVbPOtYieskpwoYoySEHMejLd+Ppb9RwOM/bsn6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+OB3SaS+jDhqQnXU6FHvLzUhcznczO7c5Ll9cqHcF8=;
 b=TksGtzulP4OoAnwwCkM3LE9TI4K9wgV0dmFcqm6JJdfuunuPvbF7ba5Q/qvIVLtFT+LKwV2WVB5YI+S9CbWixctneVOHRMmFV+rat8tKb7ywfsK61wubWcCtEW4VtvwrBWWXHyLtRw601w0JlikZTJBtLm0OYTLA9LiuaRc9YbIb/KbwUVvKz0Q/GTcVAVgfeD6aAOAgKnR7JRGZh5m0g7pAjPeDFlAvN3QPEP8CcFGkpfega4kEBr9chVEgWL9Btp5bHS7w5AxF56kTo8Z7P5+WdFxIINhX2H4qrQop0r3f4yRxTTPaoBJ5P3w0BtM2Rr7KcTbAGUd8h/njqRIz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+OB3SaS+jDhqQnXU6FHvLzUhcznczO7c5Ll9cqHcF8=;
 b=aFRzQLeg5rkUblBcRwmcMa/5YuOuVUGOjo0ZZB6LiGQjp1WTwaBG/D097YEM1l1y7Hz1m/wB9a7OPvnAcut6b5F2XCnkPs1oMGLLtInSDoknS7AJwxc08705vKy7OVH9Qom/YLEBiijXF35gBT/k9Gwwwuotd7S5sNbVx3LjuxrePOa3VDawI4PM6une0GYGPt0bp6uR+RQGZSezgxBDBoD1K7fB8ptgig0wMQDBcl54liuHsPr8Q3xkDwPSGHj4Pjxna0dM5AvAvzgEE+fXO5BDwZs1560PVtxcJWEh6UCgd7EIiZ8ZdLX1+FThbrTHNAYllGLXbmxeyj3ApJ8mqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB9PR04MB8284.eurprd04.prod.outlook.com (2603:10a6:10:25e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 09:27:49 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 09:27:48 +0000
Message-ID: <88cf4526-ca8f-4b25-acea-347d92539a2b@nxp.com>
Date: Fri, 3 Apr 2026 17:28:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] drm/bridge: imx8mp-hdmi-tx-connector-fixup: add
 an hdmi-connector when missing using a DT overlay at boot time
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>
Cc: Damon Ding <damon.ding@rock-chips.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 =?UTF-8?B?R29yYW4gUmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>,
 Heiko Schocher <hs@denx.de>, Josua Mayer <josua@solid-run.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
 Richard Hu <richard.hu@technexion.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>
References: <20260402-drm-lcdif-dbanc-v3-0-27cd247a0847@bootlin.com>
 <20260402-drm-lcdif-dbanc-v3-8-27cd247a0847@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260402-drm-lcdif-dbanc-v3-8-27cd247a0847@bootlin.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MA5PR01CA0199.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::11) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DB9PR04MB8284:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2c59ce-764f-4a9a-10f5-08de9163457e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|7416014|376014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iZtsDU1KkU1zCY2tc5sEpA9uFHZDj4N7MzFGmUcEykRj7/uCC0JePQDPXFccUhehgnIbJP35fg5YNDSB6KCzdUQi9oQAR7Eyf4v9Tk0I3WLp+qreoXoDW41w/FwBgsLc6IwFFt4aW2Ap1MTxgfLS/FTZ289FOd/LgkFoDu2EYIbSscHIXfPD+HqASMFVtmmPL39o7oGGdE34IFxkbsATJdhd3l9GC02lohGe7aeQW5Or7QHbIJ32WkQI7bU1McPGJ3yAwdxjCD4EHLDT6RTaZ8UoTJrKOUVFORVsph6dfp0nMWE+shtgWsabe1yFsptr9BKWiyp3AKrSy9UXXmm6u6fsNJyYDMm2GOZhb4vky5v1bygASBc/TZ5oXRiMFcIRtDn7VmaG64eWDPpOhiy4Cbv3VPyQJic0hVW6eYacwxbO9pxKQuO9BsLWrQH7ZoXhRlHyC6mNMTlUoU7j/MrAYTriBG6Z70n5h4ar7UnoAx/Jzn/aPdpm+JryFzT7RVimdw6XZrvPW0LXhDsPW8KrJdOjKH3xHitDc1Z4C8bHWjG3XrcwkoFIIiLwzzkO34zrGA0B/U4z31gbwRFjW/28g7Qt1zUW6Tp0pjO+P56WKRvVM7ZN3DJd+9NbNQwrfhyD/EhnoICswPSq35JuPN/LNWvczg66igYHCgi/8Kf8EvqpcVOglDAny/3UHrYkkR77hmTBxCMZikzE7s7SWM+w0DC0tg55pOBWdcdOnSHZMiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVdhK3E5L2lpUS9JMUFKNmp1Z0FaWnhVNkc3V0xJNnRGWjdyLzNBUnl1QnlT?=
 =?utf-8?B?RHk3SGlzOUdZNWxENVBYSVZaUkQrK2hyOUgwOUJ6RElQR1BKd3lBaDVyYmRR?=
 =?utf-8?B?bUpYZE5UalVkZ1YvdnVyRy96SXVwWm9XM0RvUFBYQXl5TWQ5dnBod0pyYmwy?=
 =?utf-8?B?bmNmdUV4UXNQbVBQdFl4MW5IMG1BNTJoZ2lESXo2NXRkMDJ2TmltaFJyMis3?=
 =?utf-8?B?TGU0RGR1K3c0QmNQeXVVQUNFRkNUYm9OaXF2eTA5UjBHdmxZWmNtN0pDWDFv?=
 =?utf-8?B?R05ZYzdYYnM0ZEFQWXhWNnFlcDg1bmdjaFU1LzUrRjBlUDVBWmdITkEwTjNE?=
 =?utf-8?B?S1YvRUZCQTVIMk9vQ2hMbDcwbGRheEFESUxNTGREZExRRU9iU1h6a1o0akRZ?=
 =?utf-8?B?SHNzbUthb2ZJZlgzbUxWQW8vSFhJYWU1L0ptWE1TV3lpRFhncHV6NE1aUHVD?=
 =?utf-8?B?d2VTVzkyMUdLMDVuM1J6QS9acWNHaVRrZElvRGVNZ3BDNW9yVTM2V3lkbUV6?=
 =?utf-8?B?WklwVDFOWFJ4ckZYVTdlUFZlYjVNenhzWEpCK3AzVHA1b204YVpLakdEOU1D?=
 =?utf-8?B?V1FvOTB3dUFwMkw2c2xMZ1prcjFySi91OGlRcis2bllEVi9nMWRuaFZrSWpN?=
 =?utf-8?B?Yk1pZXNCUjVPY3d0ZWMxdHN0QVMwMy9MVnRkbXkzZG1SUTNMNGtnakxGRUR2?=
 =?utf-8?B?Q0IxV1VzbUJuRXJ2TDBkakJRWWtnVFpvT2t1cno3MU0zcTNRRlZrVk1rWHlj?=
 =?utf-8?B?c0FCZ01QNFVrVGxxNEcyejUwSkllcXZNZjJpZ3k2ejV3MG1CWGQ0RndSV1Jz?=
 =?utf-8?B?NnVNcU50L0pQSkpCeVFTcFVMYksya1hMSWNjNWlyS09XeUxreFFYeUFqbHI0?=
 =?utf-8?B?YWtaV3NKR1B0U0lzMWtmQjRzWjZyVlZncGthQUp2K0E0QzhQUHg1NVFJMzln?=
 =?utf-8?B?RkwzcWc1RzBWb1l6WEtVd2VPVTdOUHY5aytSR2dFUHhiVUw0QWxOZU5QanB6?=
 =?utf-8?B?TFNSNk43Unc0Q2szZEYrWitaaXNWRW9hQ2p0OEFMd1o1Ni9YOWZOUXZzVjh0?=
 =?utf-8?B?c2YxSytjL2dBWEQzc3FWRmtKTHNvUFhYN2xKVWlTMjFDNjk5cUk4Q25vZ0pa?=
 =?utf-8?B?ZGVwTFZSb3V5N3lTNCtTSFlJVHVlQzFPNXhPN29TOTNGbndhcFpPS09FWWRF?=
 =?utf-8?B?ZG1jVFQ0R3BHUzJCUURkcHJTcHhaQjRLUjlVdC9HMEV4SzZjdzRCbUZEN3li?=
 =?utf-8?B?MDh4dlkxZnVVZlQ5MEY5azhyNjZ3ZkQ2NldyVFgzblhvOEdtb3kydTBRK0lp?=
 =?utf-8?B?LzZyVnU1dUtWOGtvb1htVnN3ZWMrQ1RjNTdsSHJ2d1JPeDhQZm5McUFXVmxV?=
 =?utf-8?B?OVJzUGt2OVIzZXI5RkxkOU5iWnBwcEc5WG9oTzdnWW9jNWp4U3ZISEllMG52?=
 =?utf-8?B?cVI5dEtJWkI4YjRWYzdVWFBiTm1SS0loMC9aM3lkNitEc2tpdG8zUkJUQnJo?=
 =?utf-8?B?bk1wU1dHRGY3VlIvU0kyU0lKK2I0RERhUXdyOS9NaEtzQUN5NjZTT1UxSG9C?=
 =?utf-8?B?OGtTaktIcTlPQ1pLZEM3V1FMdDVHSHlvRERkSzBQU0lhOERUdEVBeFk0MGxX?=
 =?utf-8?B?Q2EwQ0JqbWllWnFpYVJjeEt4OTRNWDdJSy96NnJSSUcwbHRwZnpSWXJMY1pj?=
 =?utf-8?B?aG0vSi9ITjVXMFJ4K3djbE12TXkwUGQ5WTcwNEZXNmJjR2tITWRLd0Q1N25h?=
 =?utf-8?B?ZzVmR1NYcEpmZXVXS0FNbitZZnc1NFpNV3gwaXhWWm96dGo5c2dWdHRCaG04?=
 =?utf-8?B?dEs2aHRSQ0hOeld4K0o3M1I3NGFEVWhWdnB6NlZjeEhORkRRNjVtZlpROGNi?=
 =?utf-8?B?b3NQRld4OWFkWkVYNGpZY0dtNjN0SnhKbkVuNXJvZ3l6djdHNUVMSm5WOFll?=
 =?utf-8?B?UXpPbC81aHE1cE4rSm16cDQwZExWdjhnWW9sdHNZVjNKYXV0SGR6emRJV2Ux?=
 =?utf-8?B?UUw0cTNoM0hsa3FlamtGcHh3eDluenhMTmN3Yk1CQXR2UlFpVDc5M2cyOXJ2?=
 =?utf-8?B?bHhCaGFSYnlLcW9qUDNpaXo4QTNjbm0yNm1DOGcrMVFDRXdFbTBDZHpBeUgy?=
 =?utf-8?B?eU9ESmdzU2M2SlgrdkV1VDZXdDNSVEZ5RFZ0UkFpa0tUMC9nVmx0V3JoYVpE?=
 =?utf-8?B?LzJpOGxGWURoU1ZBYWhpSEFEdFFsV3dURHlTdU1EM2tTTXV6RCtFdTBoTUNQ?=
 =?utf-8?B?bmJuRGZDakNLQTdIZmNCK0tsNk14dEYwSXY3bDF4U1JZTUFnV1AwOUVrQmp4?=
 =?utf-8?B?ZHdvSkNhZ0VXZm1MbXowd3B4QnIzaTg4TFMwSTUyUVNDejJGOFlOQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2c59ce-764f-4a9a-10f5-08de9163457e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:27:48.8785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUhFS9tWZZxPY6OYeG06D1aAUVJlibASGJDiMi1rUJK9q4R48bkW1YdrRTr7UvSjZAm3uiJ6iWgOotQdx0tm4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8284
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

Hi Luca,

On Thu, Apr 02, 2026 at 11:26:03AM +0200, Luca Ceresoli wrote:
> The imx8mp-hdmi-tx is one of many drivers based on dw-hdmi. dw-hdmi in turn
> can operate in two different modes, depending on the platform data as set
> by the driver:
> 
>  A. hdmi->plat_data->output_port = 0:
>     the HDMI output (port@1) in device tree is not used [0]
> 
>  B. hdmi->plat_data->output_port = 1:
>     the HDMI output (port@1) is parsed to find the next bridge
> 
> The imx8mp-hdmi-tx driver falls in case A. This implies next_bridge will
> always be NULL, and so dw_hdmi_bridge_attach() [1] will always fail if
> called with the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.
> 
> In fact case A assumes that DRM_BRIDGE_ATTACH_NO_CONNECTOR is not set and
> in that case it adds an HDMI Type A connector programmatically at bridge
> attach time.
> 
> Support for DRM_BRIDGE_ATTACH_NO_CONNECTOR is implemented by dw-hdmi.c in
> case B. However switching to base B requires that port@1 is connected to a
> "next bridge" DT node, typically the HDMI connector, because dw-hdmi won't
> add the connector when using DRM_BRIDGE_ATTACH_NO_CONNECTOR.
> 
> Many dts files for imx8mp-based boards in the kernel have such a connector
> described and linked to port@1, so the pipeline will be fully attached up
> to a display-connector and a drm_connector added by the
> bridge-connector. Sadly some of those dts files don't have the connector
> described. Adding it would solve the problem easily, but this would break
> existing devices which do not update the dtb when upgrading to a newer
> kernel.
> 
> In preparation for switching to case B while preserving backward
> compatibility for such devices, introduce a module adding the
> hdmi-connector node to the live device tree at init time. This will allow
> the dw-hdmi code to find the next bridge (the one wrapping the
> hdmi-connector) and let the pipeline work as before.
> 
> The module is inserted only if there is no endpoint in port@1. So boards
> whose device tree describe the connector will not have the device tre
> modified, and will start isntantiating the correct HDMI connector type as
> described in the device tree.
> 
> For boards lacking a connector description in DT the overlay will be added,
> abd the HDMI connector will be Type A, which is a reasonable fallback and
> is what the driver is currently doing.
> 
> [0] https://elixir.bootlin.com/linux/v7.0-rc1/source/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c#L3310
> [1] https://elixir.bootlin.com/linux/v7.0-rc1/source/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c#L2907
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changes in v3:
> - removed unused variable
> - simplified overlay using full path to port@1
> - handle of_overlay_fdt_apply() errors
> - use of_graph_get_endpoint_by_regs() for more robust endpoint lookup
> - improve subject line
> 
> Changes in v2:
> - don't apply the overlay if the SoC is not i.MX8MP
> - build unconditionally, but depend on DRM_IMX_LCDIF
> - remove useless error check
> - add missing cleanup.h and init.h includes, remove unneeded includes
> - avoid dtc warnings on overlay
> - fix typo in Kconfig help text
> - not added the Tested-bys because the code has changed
> - split the 'plat_data->output_port = 1' line to a separate patch
> - improve commit message
> 
> This patch is inspired by commit 0ff223d99147 ("drm/tilcdc: Convert legacy
> panel binding via DT overlay at boot time")
> ---
>  drivers/gpu/drm/bridge/imx/Kconfig                 | 18 +++++++
>  drivers/gpu/drm/bridge/imx/Makefile                |  2 +
>  .../bridge/imx/imx8mp-hdmi-tx-connector-fixup.c    | 58 ++++++++++++++++++++++
>  .../bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso | 33 ++++++++++++
>  4 files changed, 111 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/imx/Kconfig b/drivers/gpu/drm/bridge/imx/Kconfig
> index b9028a5e5a06..49f074559b00 100644
> --- a/drivers/gpu/drm/bridge/imx/Kconfig
> +++ b/drivers/gpu/drm/bridge/imx/Kconfig
> @@ -18,6 +18,8 @@ config DRM_IMX8MP_DW_HDMI_BRIDGE
>  	depends on OF
>  	depends on COMMON_CLK
>  	select DRM_DW_HDMI
> +	select OF_OVERLAY
> +	select DRM_DISPLAY_CONNECTOR
>  	imply DRM_IMX8MP_HDMI_PAI
>  	imply DRM_IMX8MP_HDMI_PVI
>  	imply PHY_FSL_SAMSUNG_HDMI_PHY
> @@ -25,6 +27,22 @@ config DRM_IMX8MP_DW_HDMI_BRIDGE
>  	  Choose this to enable support for the internal HDMI encoder found
>  	  on the i.MX8MP SoC.
>  
> +config DRM_IMX8MP_DW_HDMI_BRIDGE_CONNECTOR_FIXUP
> +	bool
> +	default y
> +	depends on DRM_IMX_LCDIF
> +	depends on DRM_IMX8MP_DW_HDMI_BRIDGE
> +	depends on OF
> +	help
> +	  Modifies at early boot the live device tree of boards using the
> +	  i.MX8MP fsl,imx8mp-hdmi-tx adding a hdmi-connector node linked to
> +	  the hdmi-tx. This is needed to support bridge-connector usage in
> +	  the i.MX8MP LCDIF driver.
> +
> +	  You need this if you use the i.MX8MP HDMI output and your board
> +	  device tree file does not have an hdmi-connector node connected
> +	  to it.
> +
>  config DRM_IMX8MP_HDMI_PAI
>  	tristate "Freescale i.MX8MP HDMI PAI bridge support"
>  	depends on OF
> diff --git a/drivers/gpu/drm/bridge/imx/Makefile b/drivers/gpu/drm/bridge/imx/Makefile
> index 8d01fda25451..84499fe2e444 100644
> --- a/drivers/gpu/drm/bridge/imx/Makefile
> +++ b/drivers/gpu/drm/bridge/imx/Makefile
> @@ -1,6 +1,8 @@
>  obj-$(CONFIG_DRM_IMX_LDB_HELPER) += imx-ldb-helper.o
>  obj-$(CONFIG_DRM_IMX_LEGACY_BRIDGE) += imx-legacy-bridge.o
>  obj-$(CONFIG_DRM_IMX8MP_DW_HDMI_BRIDGE) += imx8mp-hdmi-tx.o
> +obj-$(CONFIG_DRM_IMX8MP_DW_HDMI_BRIDGE_CONNECTOR_FIXUP) += imx8mp-hdmi-tx-connector-fixup.o \
> +							   imx8mp-hdmi-tx-connector-fixup.dtbo.o
>  obj-$(CONFIG_DRM_IMX8MP_HDMI_PAI) += imx8mp-hdmi-pai.o
>  obj-$(CONFIG_DRM_IMX8MP_HDMI_PVI) += imx8mp-hdmi-pvi.o
>  obj-$(CONFIG_DRM_IMX8QM_LDB) += imx8qm-ldb.o
> diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c
> new file mode 100644
> index 000000000000..dc1736bfc3ac
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Add an hdmi-connector node to boards using the imx8mp hdmi_tx which
> + * don't have one. This is needed for the i.MX LCDIF to work with
> + * DRM_BRIDGE_ATTACH_NO_CONNECTOR.
> + *
> + * Copyright (C) 2026 GE HealthCare
> + * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/of_graph.h>
> +
> +/* Embedded dtbo symbols created by cmd_wrap_S_dtb in scripts/Makefile.dtbs */
> +extern char __dtbo_imx8mp_hdmi_tx_connector_fixup_begin[];
> +extern char __dtbo_imx8mp_hdmi_tx_connector_fixup_end[];
> +
> +static int __init imx8mp_hdmi_tx_connector_fixup_init(void)
> +{
> +	struct device_node *soc      __free(device_node) = NULL;
> +	struct device_node *hdmi_tx  __free(device_node) = NULL;
> +	struct device_node *endpoint __free(device_node) = NULL;
> +	void *dtbo_start;
> +	u32 dtbo_size;
> +	int ovcs_id;
> +	int err;
> +
> +	soc = of_find_node_by_path("/soc@0");
> +	if (!soc)
> +		return 0;
> +
> +	/* This applies to i.MX8MP only, do nothing on other systems */
> +	if (!of_device_is_compatible(soc, "fsl,imx8mp-soc"))
> +		return 0;
> +
> +	hdmi_tx = of_find_node_by_path("/soc@0/bus@32c00000/hdmi@32fd8000");
> +	if (!of_device_is_available(hdmi_tx))
> +		return 0;
> +
> +	/* If endpoint exists, assume an hdmi-connector exists already */
> +	endpoint = of_graph_get_endpoint_by_regs(hdmi_tx, 1, -1);
> +	if (endpoint)
> +		return 0;
> +
> +	dtbo_start = __dtbo_imx8mp_hdmi_tx_connector_fixup_begin;
> +	dtbo_size = __dtbo_imx8mp_hdmi_tx_connector_fixup_end -
> +		    __dtbo_imx8mp_hdmi_tx_connector_fixup_begin;
> +
> +	err = of_overlay_fdt_apply(dtbo_start, dtbo_size, &ovcs_id, NULL);
> +	if (err)
> +		err = of_overlay_remove(&ovcs_id);
> +
> +	return err;
> +}
> +
> +subsys_initcall(imx8mp_hdmi_tx_connector_fixup_init);
> diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso
> new file mode 100644
> index 000000000000..070be24fed3e
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * DTS overlay adding an hdmi-connector node to boards using the imx8mp hdmi_tx
> + *
> + * Copyright (C) 2026 GE HealthCare
> + * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&{/} {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	fixup-hdmi-connector {
> +		compatible = "hdmi-connector";
> +		label = "HDMI";
> +		type = "a";
> +
> +		port {
> +			fixup_hdmi_connector_in: endpoint {
> +				remote-endpoint = <&hdmi_tx_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&{/soc@0/bus@32c00000/hdmi@32fd8000/ports/port@1} {
> +	hdmi_tx_out: endpoint {
> +		remote-endpoint = <&fixup_hdmi_connector_in>;
> +	};
> +};
> 

There is a build warning(W=1):

  DTC     drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtbo
drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso:12.6-27.3: Warning (avoid_unnecessary_addr_size): /fragment@0/__overlay__: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" or "ranges" property

-- 
Regards,
Liu Ying
