Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B538106F2E0
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 07:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0750E10E26B;
	Thu, 26 Mar 2026 07:49:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="mHxRLma8";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013031.outbound.protection.outlook.com [52.101.72.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F2BC10E26B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 07:49:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1G7DYBDPTXshgvZbWwKmk31VF4YV5wxRFYR4sWfPVIwEtjw5g3RQo+Nh1RCfGCnbRwVTQ9lQ5EXPrYXnD+rsLxS6X3d9w9Z5t2oVf2wmZWv0mcYzFNtPayH/ngvPEk+pKzCXvIaNVrQ/gpYGnP+Uq72shbWgKdXBq3mC8TBxVVF1miYUnh/ZSnQISRm5wO2q5VRRlewLsp79u8tdGlDRobaRYsZCBA5MZvk2rBBObmCAZXG9k8Y1S/Szehrw59oCN4Wt9K/3mMSr2NFvyaS1z60c9tVN1mUU6pucCwv7D370vDWSNb+l1PUhkiBJVfa5BF4riM4Dm+15Jaylu36cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O58MTs4vKdOQpHRPieBHhrQmZ12+mg4C5q3Mpk1Aibw=;
 b=Tro9/jH9XcDHsAiMmPdINcpZiidDaUKkAmV7gMRF5SnRDV1nOedgUehx7L/jZra9Nn8Uw7hYSlP4lf9MkPy5XyfumIUHX2JK2dCzS4tNjLRViaqb4pHkgNKDYZKmAECVani64zTdk2iuyLOO3pXgNYCzgJFijSOXeddipvWIPy4dY3foJn1xx9ib18ikdk2K7hocOGLHT23ZVfKeK3PpQqsCTxRgteTORjaZB5iWpNWJ03XJHYgilTIWTNAXfFUBbo0oaR4gKVlaWWVFuM3LjKBGrsRHMIbpkITFuQLRWIOu4W/lH64PiX0SEWsgMuDYVkf31kQUyprn+PzWuzkhDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O58MTs4vKdOQpHRPieBHhrQmZ12+mg4C5q3Mpk1Aibw=;
 b=mHxRLma8xEhXoIjfscc9PcX6cwYhOtEYFMFjHUk7JsVcloMFhvRnvWIJAupdVC12FRyxLtqBTTlgvZZhYjVsFUjaCdNDU2t9P+Mz08cvyxYnYg5MeYrxaw1B6JSxgGAgQevyN/ckGQjmn+LE0KWoBiC8PILklix24CrJXxsoxjUAPuG30ZcWvQLBzww4LBVBlElLdv1MqQIXqhKhVeIeLNx+Jp9pHDAhABoJ8vU78kCOPvGmpAYbUr0wVlNdF12lM5vGN1CsSRUYCpMMWvhWkoG6o2MuqfQY6/qcx9FfxKCJfDrbHdptKr8WqL/3VFcWvl9hE5s+UxYbSeFOE49Jzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PAXPR04MB9187.eurprd04.prod.outlook.com (2603:10a6:102:221::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 07:49:01 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 07:49:01 +0000
Message-ID: <4477ada1-571f-4aec-9054-496e45c15ec0@nxp.com>
Date: Thu, 26 Mar 2026 15:50:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] drm/bridge: dw-hdmi: move next_bridge lookup to
 attach time
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
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Anson Huang <Anson.Huang@nxp.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 =?UTF-8?B?R29yYW4gUmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>,
 Heiko Schocher <hs@denx.de>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Josua Mayer <josua@solid-run.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Richard Hu <richard.hu@technexion.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>
References: <20260320-drm-lcdif-dbanc-v1-0-479a04133e70@bootlin.com>
 <20260320-drm-lcdif-dbanc-v1-6-479a04133e70@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260320-drm-lcdif-dbanc-v1-6-479a04133e70@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PAXPR04MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0ac424-465f-4902-caf3-08de8b0c24fa
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|19092799006|376014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yMpNRwqw1xgh8Srd+64kt91fAnHv5t7P/zsduE1hRDVylA3FHvUB2l+6TZeyjnaiFZ4CBo87ildpXpV6NrLqLNaGzUSPZAppf7tQqpezTSWsvcqaj+tc+R2cSo3vWNvJWMOKmrw+8s75pB3zbEtvMK+3qu38pf/obawesmm3PJc4RkNgUldQHj7vcB2tmJIMW/7U/qs2Z37UcQXObtAC5+CC/C6iDmHWoIGzF4MySWyzEl/7/mo1pFbv8XCPRp6cE1pROJnPG3PdS7ijVK+OmrtdeaNh5ZJ1e8zkNaepSptaI9GxfbY/tVzm62hUu6t9UlZzsveU32TkKimiwKN+2wK4rQLyZAzGz+A6cz/vO47hfvu9jUdoP88Q77HwbckF7RLaLN0fEHPdJYKcrt95Xi/xe4wf3UDgwM2BWsgaBPTumOJPTgAtG+BPji43IH9VN85QFCYOl4YUngXr3lgPUuoLtL23MiWlgVg2ox5ha8LMHi97dHo/xnCrAJAuyF5cT40qOYx6kVA9CRW2hVr/WTO7NmBCjnJzIlGJJMPZlJhoZz1XeWPsTzuBfrYnOJq7oejOAnIkbFVIY5h3bhL2UGxk/qt69WTmhFpl04xqI6TsBMVxOC/LpIiyteDj8V626GKA2z4NNaml9UencGiKTAWMB+/ONds7pQoKEJjgj9tRYerGIZcJ55iFrytAn/Cd57mClIfKh8s1nSS0h+29fQawUmbOZfD6XR0fof55GCO0NbJsG3uCvaNlFnNhg1vDs1SJydZjk9/yfvsna+aWjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(19092799006)(376014)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THpxK3BrTG41K3BCcW1abmgrMzRNQXFxdzM5ZmtMV09zYkR4NEVlREtpUUVP?=
 =?utf-8?B?RGZCWExlb2FSR21PY3lPNXVUVnJWRXpkZHEvem12TWJTeXBuY1Zndm9vcVNt?=
 =?utf-8?B?VmlRN3pEUVhxVGxFWSsraGVPSnNZYlgrazUyMVFoejlSU2JtWnphTFA3R0lr?=
 =?utf-8?B?OHd0S0VSTk9zcHhFUy9YeWQvY055Z1NrTm5tckZwaU1QSFQ4aW5GQmZQWmhu?=
 =?utf-8?B?QWMveCtKUlRPaDVKWXJidnp3UDJWcjhBcFhiNVNCblArTWpUaExKdkpiSFk2?=
 =?utf-8?B?aTFIc3BHTUFwZ0RuVTZGS1JTUzM4ZUYyemdvcFhoVWdWSjRDRHpXdHdRM2RF?=
 =?utf-8?B?WW15RENrOW5odmhvcTJGaU5MMVFkQ3VVNk42djFTWjI2eU1uN0lPNFRlUTFF?=
 =?utf-8?B?bjBkTkY5WTFldHdsb2pGc09PU0Rubms3YnB0eENmUUE5alFwL2k0QURGbzNZ?=
 =?utf-8?B?UE5DNGRFTlNSdEI2RWJ2a3lxbmU0UWlBMUtLcmRPbHl1Q2J2RXZRUFprZG5a?=
 =?utf-8?B?ZEZ1MlAyeE1udmFiMEJyQ00zZ3JiWmNxbXU3VjVvM05ENXhjRFZzaHJlSUNP?=
 =?utf-8?B?bG1QUFFJYW5nbjc0Y1NnVjByczFScURoVWhWTS9TaE9zUVg2TFVvckwzc25r?=
 =?utf-8?B?RzBnN1lNTm9NWlhjejhRZXZHalkzZWRQazIzWXpJOVI3Z0pnK3dLd0xPV01a?=
 =?utf-8?B?T3hVMDVIWnh5TnZaazZYWFZlMlI0NmdZaXBPSWpjYWpIbUplbHh2R0VOTTU3?=
 =?utf-8?B?QXNDMktINld4NzY2QlpYQUFNaUNYTzlYRHJXakdJUU51dmtaUUpsa1djUWpU?=
 =?utf-8?B?UEtRTFdabnk3ajlUK1N2OGdOMlJyUDM4N1VIMEkrNGVXdUdMbngvK0xUNUEx?=
 =?utf-8?B?V3ltcmFtL3I3N3Z5bnE0QTBLK0ovM1p2c3hYbE1xaFZ4UjZVYXF4MkFQcFlh?=
 =?utf-8?B?bTZ5Vm9UT2M3OHg3OFpiYXAwYlJJVXArS1pRUG9rTk9Wdk1tQytndDVpTkt2?=
 =?utf-8?B?YVJWbXNYc3ZFbGszQ2tqb0l3eXJMNzhUeFBEeU1mUnFWT1lMQkpkQTd0dlRC?=
 =?utf-8?B?bkNzMHNpcmhGUUR1N2drdFh0dG9RU2xsWkx0OVdmWk1zMGFvaUhRa3hSNFB1?=
 =?utf-8?B?NTdmejZwL2ZIbnVDV25RdHQxQnp1QWFwZEhYUmdISWZmWnRQcGRtb3hPZm9W?=
 =?utf-8?B?dnZycE1EdmZlZ05vd1NtbWJENjc2ZCtCOXdqZ21PSUxEaWN2UkR1K0lrODAr?=
 =?utf-8?B?UWFSdEJkTlBhMm5MblE4YTEvaGQ4cVI5N1Z3Z1NFa2RBRWZ0VjJhSHZmODBs?=
 =?utf-8?B?dm1remdLc1hTQTIvc1A1dmlZc082aXBYdmNTZFZKMVM0VUVMZkFSSVl4SHBn?=
 =?utf-8?B?WFpqc04wbXR3UFFIa003c0svbUxoaDUzVk95N3krbDZqUENMTHh0R1NUYW5z?=
 =?utf-8?B?ZCt0c0xENU1obVdkdTJ2czRycFdOd2FrczZRS2lrYmVvemhBRTZIUjNENVZO?=
 =?utf-8?B?SnVnaXFZeUxidDJOMGYvTng2aXFxaUwvclp5bXNLMGlRaUhnR0tVc2ZsZ1pM?=
 =?utf-8?B?eERrNUhQMHZCNlg2NFFvUGUrUGcwdi92S1R4Ry81V0pwbURNZm1LWUtNTW03?=
 =?utf-8?B?YUpObXhleDhrWGtDK2dmMXZtSWphMlVXSGo5cEVvRlU2dnNSdVB2cTlpQ1Fa?=
 =?utf-8?B?SVJpNFQ2Qm5DbGdoTkFyVVNYRzk5OGlDU0RPaWxXaUhmRHI1OVp2bWpBZ28y?=
 =?utf-8?B?UlgrcDBWZmZlZXRLOGZQTUhiTHlxUWZoSkdYaWwxaWdKTEs5MGtRcVdyWGxL?=
 =?utf-8?B?S3g1SVlDN1hWQWExZUQwaDR5ZUxpd0tPcGQ1UmlCNHZUbVc5dGFTOUpKeldk?=
 =?utf-8?B?djcrRUliY0xTYjNtQ1czZWU3bFp2ZFJZOTVCZkoweTk4NnJ4QmZuWlFwMjJs?=
 =?utf-8?B?anRSaCtzR2pCNllOV1hpQ2pTWTJoY0U3Qi9ndjRPMWxkQko4TlovTDdwVkdV?=
 =?utf-8?B?MkRzOUNRemdHbjhzWDVDb2NUNlBUd1RmZUhNSmVpQ3lPYi9DMEFYUlEzakx5?=
 =?utf-8?B?bzFjRUVwcUF0TDlsUy8rcGtHMmhGZzNLenRCTkc0ZWZ0V1dYd0ptMC93THg5?=
 =?utf-8?B?WHVvR0hNbWdtcWxVb3BLa2JkSmVuK1JydGU3b0F4RnJIWmo1YmRpSXk0N0Z3?=
 =?utf-8?B?Y1NzSERNTFNQOCtVMHg2QWFCeTd4SXF5MlNaWktkV09uVFJrcFFiakR3T1l1?=
 =?utf-8?B?NmgwZVdxQzZ6alR3ZUJ2VHpiVzlKRmwva0s4bXlFRThEbTRxa0NnbmNYMHlr?=
 =?utf-8?B?MHkvcDYxYUg1Uk4rVDVFVjllaURZdUlPTkFCVVRodDZIUUtNNkZEZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0ac424-465f-4902-caf3-08de8b0c24fa
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:49:01.0830 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJ0a+d9o4i8qg5wvs5AliT16AvbrkdjQFBY1G3Ezr4a/TfI/lVs5P2dXPuv0F8MQkMHHLT7zIF+8x23+wqT7Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9187
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

On Fri, Mar 20, 2026 at 11:46:17AM +0100, Luca Ceresoli wrote:
> This driver looks up the next_bridge at probe time and stores it in
> hdmi->bridge.next_bridge, but only uses the stored value when attaching,
> and only in the DRM_BRIDGE_ATTACH_NO_CONNECTOR case.
> 
> This will be problematic with an upcoming change, adding an hdmi-connector
> using a device tree overlay when not present. That change is in turn
> necessary to migrate the i.MX LCDIF driver to the bridge-connector.
> 
> The problem is that, adding the hdmi-connector via an overlay, devlink
> considers hdmi-connector a consumer of the dw-hdmi device, generating a
> chicken-egg problem:
> 
>  * hdmi-connector probe won't be tried until dw-hdmi is probed (devlink)
>  * dw-hdmi probe will defer until it finds the next_bridge (the
>    hdmi-connector wrapper bridge)
> 
> In preparation for those changes, move the next_bridge lookup from probe to
> attach, when it is actually used. This allows dw-hdmi to probe, so that the
> hdmi-connector can probe as well.
> 
> Also avoid storing the pointer in hdmi->bridge.next_bridge: the value is
> computed when needed, thus a local variable is enough.
> 
> Finally, this also allows to slightly improve the code by not doing any DT
> lookup in the !DRM_BRIDGE_ATTACH_NO_CONNECTOR case.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 41 +++++++++----------------------
>  1 file changed, 12 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index a668d66aeece..4ee865a1a6c8 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2914,9 +2914,18 @@ static int dw_hdmi_bridge_attach(struct drm_bridge *bridge,
>  	if (WARN_ON((flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) && !hdmi->plat_data->output_port))
>  		return -EINVAL;
>  
> -	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
> -		return drm_bridge_attach(encoder, hdmi->bridge.next_bridge,
> -					 bridge, flags);
> +	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR) {
> +		struct device_node *remote __free(device_node) =

Include linux/cleanup.h as __free() is used.

> +			of_graph_get_remote_node(hdmi->dev->of_node,
> +						 hdmi->plat_data->output_port, -1);
> +		if (!remote)
> +			return -EPROBE_DEFER;

Should return -ENODEV instead?

> +
> +		struct drm_bridge *next_bridge __free(drm_bridge_put) =
> +			of_drm_find_and_get_bridge(remote);
> +
> +		return drm_bridge_attach(encoder, next_bridge, bridge, flags);
> +	}
>  
>  	return dw_hdmi_connector_create(hdmi);
>  }

-- 
Regards,
Liu Ying
