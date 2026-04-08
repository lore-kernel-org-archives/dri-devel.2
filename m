Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23B7105D996
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 03:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A6AA10E506;
	Wed,  8 Apr 2026 03:00:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="gBbnCgFJ";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013030.outbound.protection.outlook.com
 [40.107.162.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85C1910E506
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 03:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a441UnrxhMag2u2Hovm1AFjyDZrcmiVGLkFcOvp5feAOy3mKomI6cEl51gJyumNg26B12/625jGj8JtnOj9rXEcoq7PUrhoristaFSyqitkdzngzGibCdgmLcE3lxUS0p/q6lI6UZ67KhRdp/Lv+MO+DDB6vEii2/50psMgWE90yFUWIRM1G7leG0l5dKhJP8TjoCcRMeVGZL8OHRVvMPnGzE1K1+NIAZEawHLCkOUmMmTen+wItvfapMv2WQw0yYNPjYxJMx/C+N43zXoMKabbyhuDTVSQEwKcdnvQbLZ0Y8tpI1Tu7xHwkqXOvnftjgZe6iAcvDjTErNH7OpuIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ES/XsuOVIuselhNviVnNDEN11iMyuR8LMgvecTY0/sc=;
 b=xkewWaNySHaBYAwWukcRBcwgcGQ53ga0hpJm8J73QzdrPruN+gGSvSJrXYaYCh5kvzuEZ8V3zyeVk8+swWmhCOxjgQgtlCTUOn/QVJDc9gkDH5jYwVkJHSi+B4fSgvQqvLiPrgTtrRx/uWsPZcOulJ5QkySnnvg634QQHEH5Dzh93nOGpbaMNkndqmMShTdASmQs6mvxXOr0F1kCkGd4fwiOvi6RhPKbzhy1gnvWhFqW30ncdTJG+neEOILE3MG93wm/6CTDACQM6snEywxqZD4hHXiJUCzZzA0Kt71y7TW7DmVxrjN8HR4DkXkgH+vqdBLwj701Yu1yehzgsLHGdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES/XsuOVIuselhNviVnNDEN11iMyuR8LMgvecTY0/sc=;
 b=gBbnCgFJ8PMgP1TOi13AE+8VlshNCLOujf+YkMv+4Va/p1hGaLSiu1nLb7Qbom9Ap31rXw1PEEjub5cDP9zK9LY3zbI4fQ6vGeW0GpD5KVH9gb5sKQwkit43TRUurBIJ3EeHGG9Ik9o/e1D8xJnNPc0KMqeaQ6lRiuPYRtIdhr6vpiOW8DyU/ZJvPY/R9iiG8Sdaptp/C1dBFwZkXhDxTsJX5XAPadiXu7zetz5WKe7Y+IpLGU9WERrRHtnwBDz7awI6LTO1MWfrnRJ30pST9uT3KLhHQC1YHCgOf6AlYIOJvAuSloNF39EmaswnWaKeuX8QX/KDqY1pJxFX5SCuHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB9PR04MB9356.eurprd04.prod.outlook.com (2603:10a6:10:36a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 03:00:23 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::4609:64af:8a4b:fd64%3]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 03:00:23 +0000
Message-ID: <f467c021-268e-48b2-9c62-8998759c4a74@nxp.com>
Date: Wed, 8 Apr 2026 11:01:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] drm/mxsfb/lcdif: use
 DRM_BRIDGE_ATTACH_NO_CONNECTOR and the bridge-connector
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
References: <20260407-drm-lcdif-dbanc-v4-0-247a16e61ef9@bootlin.com>
 <20260407-drm-lcdif-dbanc-v4-11-247a16e61ef9@bootlin.com>
From: Liu Ying <victor.liu@nxp.com>
Content-Language: en-US
In-Reply-To: <20260407-drm-lcdif-dbanc-v4-11-247a16e61ef9@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0207.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::6) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|DB9PR04MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: 38f673dd-1ada-43c9-ed1c-08de951afa2f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|19092799006|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: +o++tXAHXLF0+qvDJFGT3E8Hd84WEUiyPB01Nc9jmSOI3V6zYlCqmwAcfiYZewbQtv+6xcO7NV9iITAlGAsY5lhEK/d5b0gZPu0FXmWzfyWbhd7Bf7fQmxodGeP+z1LpeZae5uz61GwxwUgLMdjcZej7VKU6pExrLN2mZc35cm1QDl9vGWgd3KJ/tm4Wo6Zjz3Zmgm5wAVVlZxEeYEMwBTplez1Mkx6+0PW/vpMrJLkvVVlfP6c3vE632hyFrWbtNoLc4KSv67cqHEqdDAvxbq0dwjWl/vlbpCjNRcsSLyxpMUi9lczW7viMmhRT6wl0TVYvkNI0fU4k7DjWgtfq1X7oGf0w31QWu1q3aD1F/FwAnR7skaDWF+9lw7QNF8ANKew66HwXiLFtWTJYZyDv5EBPDtVmj6EBsaBIiAfM+yMqO8NuJeS+Vdk5K0JIKomfvmGUA5UxesLSw5/5+TXFCa4xSPcuTM5NtuqZsj5c6ZWaLHyUeji4+dtdz6oIcUD8T6g2M+aWDXx3HHwXZZ9lqfy5DW2UDm3Rby1k5A7QcXF4EFMoxwdRVbnBwVM6Ft5r5PjDu13XIz0A9ncZprVQ7bBs2jgi/k/xUbN2VkGeSNuaAbcirFKxi3nVhmnsomw3letEknjqNopZeg6QnVVSxq7PzQO7XjUGLJYySWqc2Tw9ftWFrcGFv1+QjoGHb8g94CJZcgdoRx1UE6SSuL74Tye0984OpMxNClhoxJXMIjmjAKwGRBx4gksogeNqcY8vaXFsea/F2YR95v1GGrz5aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB7046.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(19092799006)(22082099003)(18002099003)(56012099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXEzTGhiaCtkaVhPdTFBdnVLdURNUXJKUXpReGczN0U2K3N3MnAvL1pJYk1r?=
 =?utf-8?B?RVpoUjM3U1FKUEdjL084ZHBOVnRxZFpqTjNWVk5oalNFWUNsSUx2SEJ3Qksx?=
 =?utf-8?B?OVRIL1NxWUl3WkplQUI5bGpIUmJnN2YrcWU3SUM5dWxTS0taMWZ0OExLVlI4?=
 =?utf-8?B?WUh0czdaTXJGZXhuSldoMUU3TkhwOEhqN0ExWVZ1Mm51ZVAxT1NsZHYvOVhN?=
 =?utf-8?B?T3ltTERBNWVmQWtDQ2V5RjNCajVXS1NZeG1pMEV3OWpvZjB6RDFkRXV5aUJk?=
 =?utf-8?B?eG11cEY1N3BiS2w0VkdVOW9FbU5kNGFmcExEekRKRXBMWWtnelQ4OVc3dXZi?=
 =?utf-8?B?VU9vQzhkOHhuV2pXdkRYWVJsRmJEaWVram03Nno4R2x2bFJLd3FWcGp3em5s?=
 =?utf-8?B?NUh3TTh3TVdObmNqdWl4Njl2WVJJb2lOajROV0doeFNTaVBvQUtsZDlxU01D?=
 =?utf-8?B?elRPMzU5bnQyL002czFCYXl2Tk9aTmY3OGVRUVV3c0hxTmVmOFFnb0kvcmZJ?=
 =?utf-8?B?Z2NHMVJTZFhjWkZiYnNHZEx3NUhYclBQb3c1c1Nua2hvWkNQb3BEUks1eVpu?=
 =?utf-8?B?L29FclVCN2U4dFBJckZDUjlMbUNBaXZqVXhDMWdjZEJaQUk1UXF0N2JmS0tx?=
 =?utf-8?B?d1RudDNVeS83UXgrajBkTC9HOE5kekVnbjJYcGVrVm90QjhCRi9BeU1nd2xi?=
 =?utf-8?B?blBaZU1Gclp2RUE4QzdKa3hlbVNubzhzSHJxWUJwMHA3ellpc1pDTnlSSlFU?=
 =?utf-8?B?bDR5K0Q2cVluMzB1U2lvcysybWQ4ZFJSNm9jWnpydFVQTVhyUGZXb1lnSWZo?=
 =?utf-8?B?Tkh4VEp4cWpkVEtHcnVWeEVtTWNIelFPYmkva2hMOEF1NUhmekFmTjdldWo4?=
 =?utf-8?B?emJGWE1XRnE3aEZvd1lPSTY5Y2wvc1VHT2cvTldJZWlVWEdZRkVxNHd0dWRB?=
 =?utf-8?B?RDVqUEtnU0V6MDA3bGlvQUlOZFN2YzkvYi9KQWdFWDR1TUcwcmZsYzh3anJN?=
 =?utf-8?B?elBtQXBwaDRXVDByMGJSZWt3WTNpcU5ZOFRqRVZTditMYkczZnFTRkRuczZL?=
 =?utf-8?B?OTQ1Tm5JWmJYTXRuRUgxN2hzYkgxamZac0R0QXFQYUZITDliU1hlajFzbDJn?=
 =?utf-8?B?ZHJwaW84amY4NnRrYXNYTUYvejdQTmFSdWorWlhHM2lvbDdYTUlHMUdwbjE0?=
 =?utf-8?B?SWpMb3ZMTzdKZFF4U21WdHZNSXRBdFZrR0ZFdlBDazVxRVY3NUtHWjludngx?=
 =?utf-8?B?MUxQclhqZUowV3hzVGNZRkNFb1NSTXUrUSs3RXZ4Q2ZIL2pRb2kwSlBHQms1?=
 =?utf-8?B?SGJQanVtcHRmTFJzVUVZVFNWYVNDajZyUGxhdlB0dWxpRzUxZkNyeWxKVVdp?=
 =?utf-8?B?UjJvMlZvMW11eEtJc2JuK1VRSk1mTTJoNExKRVgxcVZMS1VOYm51OFhLSDVk?=
 =?utf-8?B?cjBqbTVDcWdpdFJGRW1IWDBNTmcxRVdyS1hWbFBYNXlaQzFMbmg5UzgvZy9h?=
 =?utf-8?B?Q0gwNFg1d2NqcnlOaktJcGRWVitwTjcyQnltejdqMWVQcVFldTY1MkhTQVJq?=
 =?utf-8?B?UEVLbzN0T3d3d1I5TXVOenB5Umtscno0ZW5Tam5XTEJLWmRPdFZ4Mk0xSTFB?=
 =?utf-8?B?U0w3d1FyK2E1THozcW0zTkFaZWoyWFpHOS9RVHVSR1hxbmRZZkVSMk8ySmtR?=
 =?utf-8?B?ck1pR09sWjcwZmxrMVJ3QlZWOWtSYVdsQWtBZzJDMS9zazI5clFrMDBOeVpk?=
 =?utf-8?B?YkE2NllVbGhSNWkwMXZ0Y2pyUkpydXFPYnMyR0NSRkU1Mkx4VjB5NkZzb1dQ?=
 =?utf-8?B?TlUyVW1mampuUWRUMDVWenh2WStZeVlqcVEzK09lci9nWkVyblEzWkVLQ0ZN?=
 =?utf-8?B?aVQzZnVsRkw0c2hNZUg4SWE0bnVYZURGS2V6a2N6Tk95a1RWOVZnVWs3dUli?=
 =?utf-8?B?a0c4OGptTkxwSjZ2NGdlU3dMb2hHTmw4T0lGNlFlZzhENE9mck80NVRCa1JX?=
 =?utf-8?B?WmViQjlZY0k0aVhmb2J5N1B5aS8rWlJJenAxR1cyUk4vK0c1d0ZKc2VGVGxa?=
 =?utf-8?B?UlR2bWZvTXFWdmE3N21WYjF0SkExWXg2Q2JuQzRLbFRqS1NrMlgzVGdEc2ZJ?=
 =?utf-8?B?czUrUW9NSlpSV0FUbVM2T014TTdhUVorNlhPTVhPQSt3R3MvVnovRWZDNEkz?=
 =?utf-8?B?b2hiTTFyMkVOdXFsQTdpQWZBMUpDUkRGMlN1QjJZV2txb0YvVk5QQVg0QTdq?=
 =?utf-8?B?SXFBYjNVOGZYQ2FjTU80VzlaNHNUUXBwRktWL0FMWTBaUlhoZDROaEtDSUJV?=
 =?utf-8?B?RUV5NndueEVGYWdMeCtnekRXbDRsQlJFendjM2NzTDhCZktMQzVVZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f673dd-1ada-43c9-ed1c-08de951afa2f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 03:00:23.4205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/0WcG3xGy18HBy9MV2lPGiCrFsogps9D3AoxSQzGHqMCa70l5rLXgergckaTr0vnS6AdLBqbUWLFqsPGfAMbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9356
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

On Tue, Apr 07, 2026 at 02:24:25PM +0200, Luca Ceresoli wrote:

[...]

>    (even though only the pane-bridge is surrently supported), amd all these

s/surrently/currently/
s/amd/and/

With these fixed:
Reviewed-by: Liu Ying <victor.liu@nxp.com>

-- 
Regards,
Liu Ying
