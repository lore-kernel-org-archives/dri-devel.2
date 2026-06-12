Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F16CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C292810E9D9;
	Fri, 12 Jun 2026 11:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iQxmqOgd";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011025.outbound.protection.outlook.com
 [40.107.130.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E5D510E9D9
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 11:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SD+c3ySM4nUgDXueInrQ01RLc8v91EPbHTIWQ50OHqtSvVyukKdEOkvMa6jJ6evV+8sgGdDIOCkyKATRRdocnBeNSjcblHPkMaP6i5sua/zvXQwDDmvb1l6tkWbyd81l3SiVIO8YCARYi3B/eXtTQ85hWOANZLXJtC3aOhrbtMmJa9RVke+8TtNBGXyUXoA4jayl0NN9AmCc7d8k59saZ8JaMVagjW5F6fEQUGZVKfaDovQoEbc2sr7PZdcV+yPTgDbYMwFDCLXoQNVMzxGPQH5DeKJ1Mu3sxq9Ve52IL7516KQKcUj4m5Up2AiuRZPmlUFKzqV4f/TC4bFKjvlkuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQ7z+DTg6jrF/Yo4L0FaUA0R4Jh+ACg0xapvq6S9ZIY=;
 b=b5Gr+rpMV2f64UVzqjKr+9fS7ox38gDPwJM7KnRgZzacz5WWVY6yjXTnYY18i+R/BJ/FYVym0FtKSSkqmdsWVVh/++Y0zTYgvJzMHTWSvgBoZx+EyOyJEuazX6iwR3yLEve8CkfK6+/awLWPzL/ehgERHPGHnjK5ggBMyjNgMOizXwCH0pHGP2IP5SkvyAjNrScm1ijRVjROaL9QlKpr8fNjy7nDMdOFxeuJ1CsUV//Daai1tZW5ngO5z/lyqvLrlKZs9f3PRXJwJCmH/NR7JZvbQ0LT3fhTUSRUfnTkhCPC+zIgU6aKjL76VFDLQc/kycTa257dOVNb3x53aQlIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQ7z+DTg6jrF/Yo4L0FaUA0R4Jh+ACg0xapvq6S9ZIY=;
 b=iQxmqOgdM1dJIFn33l2dwsg5UAm7i5GAUfJGrTFuMObX9qkoxoO8Src0V5kJ6UNgZ3Yh792f5AvhMRgpQEFPmzK70+qXiA+Hwu9dS4oYYCdhrmFX5c+1ON+RAu3NkKPtErXeS3krAO7o3S2Li0id0IQU9NPSOjADXnoyPxpOB+iJz/nrGmhA7VMQqNRgl6vHms6UsqcFwnw35Gr6cqCK7MQmuSd23XuZqs/tNJ9L3niL05jQaMu5fjjxA/pjUh++lyw9P3q/qI5ujLBklgkCoqkd2DvwOf6Nc+aomDwp1+0YqCcibudm2T/iEYtisUsCTdthdvD/SSjpTbb10VpKIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by GV2PR04MB11710.eurprd04.prod.outlook.com
 (2603:10a6:150:2d5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 11:58:48 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%5]) with mapi id 15.21.0092.010; Fri, 12 Jun 2026
 11:58:48 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Ying Liu <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Philipp Zabel <p.zabel@pengutronix.de>, Marek Vasut <marex@denx.de>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v9 0/9] Add support for i.MX94 DCIF
Date: Fri, 12 Jun 2026 14:58:31 +0300
Message-Id: <20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260602-dcif-upstreaming-fb177f3c9351
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::29) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|GV2PR04MB11710:EE_
X-MS-Office365-Filtering-Correlation-Id: b7db216e-e8bf-406b-b9fb-08dec879f5fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|7416014|1800799024|376014|921020|6133799003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: HUEcSpqL8xEAjZ1nWZW0oTiP6npeVO+hRIoyguKE2X2+eaE0e//eNDLD0d7P0XevkcW0YOZNkZ83kD1W5elTqBglZzWzlZso+mHunc+6U8p85s7PnsrAPNfi6btCT3d9tdJTfI+9KKzTMDd6egxUYgRgon99/9aAolyx/TL3+86HyBJKmM9CynWaZ0qZP1yvy0Whix7+1eXTnniRZyFiegj3oQ7k+7mi1Em1KlUgEIW/45oCw5X/w67XcVPXdoZ1NyQEwmuLJl/sIzjVNzfX4n/QQIm47CtRhb6XNbPKF4IYim0YV28r2kcAU/1FAXLhp0LPGvWq4SSxbuujIRzTEDklECfwZSHwCA75sKlNzTTrpFoz1wBlcfdAH+S/8xCYq2jWvxFdynOQ0a0/DnwSoC/f//Ll1iKPAHuYLE3bX9DH0rBNF0kjrvycYKqKo7CEU1xtrWftKEROWebqwClewFUJgUvY1n4iC27BrodEAV5pNErv0bGvecGNbAyq+p4tKZhLbaDabwbhTq3wkDzvRlNKWnDakNHOHLxepuS8zhaB+2dtNWRgp9r5llFGYc6HBbJRJ+rJnlzdcCWtHvzfawOG2UDFnnyEg5VhXpEfk7/nFt0RB0Ot9L94/Dii929iAEWOHXJ6kPTXc070C4CvWGkiCRVd4/80l1b3IVy9b5+23z0oUQnAAODaDxkLP7o5gt8W+H3jJ/UJ3gsf3eXtS2VlAoeevz3xDdR/VwQiay71vPcXiUPnP8N5O+5kRTk5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(7416014)(1800799024)(376014)(921020)(6133799003)(18002099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDBmZk5HbTBlSUZqTW5EeU9Nb1pvVWxWY3dLMXhsc0w5NkFYQ2tObDNvL0Vs?=
 =?utf-8?B?L3NHa0tXbE11a28zQjR1c2lZV0lqbmo1Q0JocklHd2pESmZpT1B4aEhQV1Y4?=
 =?utf-8?B?UVhxbFVlTXAxbExwdC9SM2Eva1BITmh3eWhXOGJXS2g0SExUbVNzbk1venFi?=
 =?utf-8?B?YVJhOXBGclp0WER0WXVORTRiWmlmMk5lUFc2UkdEY3JLWkR5amIvbzNFZVE0?=
 =?utf-8?B?K2hTcitOcExZbmdsd3lWN1RQblFmUUtpbVEvaDE2SGdqLzIvK2UvN0VDU1Z4?=
 =?utf-8?B?SlhnU2pqQjRSL2FoR0ZUeFgyLys3Sk5FTlNkNHI1OHFGN2t0a0czdVBjSndF?=
 =?utf-8?B?RFR5eGZTS1RaRHdkOHJqTjBDWENzRjY2M1AveFhZV0xNUUd2YktqUzljUzE5?=
 =?utf-8?B?VVhRaGxlTnJacVdVcm5VY0w2ZUt0MkdJSzJyOFZIVVZZNlJSYmlKQzlPRUYz?=
 =?utf-8?B?eFp0ZGF1SnZLRkJ5dXFoSWtMa1lESzF5V0dyVUoyN1Rlb0U2aGV0eUJPZUp4?=
 =?utf-8?B?b0RWTXJpMGxUWWhtVHN0TzhHamxSTU1ERUhpdm9GR1RFMEpHcTlXa28xeTVL?=
 =?utf-8?B?dmZyUWZlVVBNNlMzMGtGM1VFdTdhUDQ4b2pITWJodzJIdTJ4ODErQWtJMXMx?=
 =?utf-8?B?L2xsN052dU8waHE2cHhQaFc0Q0VBcUpqQjJwY3c4RzFMOUJZQUE2UVkvS0dw?=
 =?utf-8?B?dXRVcTdyL2dQTUxzUEl6UjdzczlPQXFpeCtvREFCRUV4TTlOeHlzSndranRk?=
 =?utf-8?B?eHM1UkhhWGVqQzFHMkFGRXd3R1J0UEozemUxRjJnNGVJMTVCeHcyR3Z2VXZW?=
 =?utf-8?B?eTgyMnQxY2UyWnVpUWZnUHlJNCtFR0tjaGZ0ejhESjQ4RFhDb2U0eDgvM0I2?=
 =?utf-8?B?aHR1NmJQWmdlL0xMV3NiR2tOSXVham96VkxFMitYZm5ZY1V6WWgrRm54ZFhj?=
 =?utf-8?B?eGI5d1J1MmZURjZYTWUxcFV4cy9WOG5SY0x4T2RudUh1VWFnSGF4QjFqa2VD?=
 =?utf-8?B?aG52aVFRMHFTR010SkQrd2JnYTdhcTc1WERzNWdTaWVaUWxiaHJsQWl6U2hh?=
 =?utf-8?B?RDNlNkh0L1pTaHR2RXplejhkazVtZFdOTGdxcnk2eWpiQm1rR1FGbGd6UTQy?=
 =?utf-8?B?aHVoblZ3Q3J0SExHZWRrTUlDZ3lIazFLdE5Ua05RaXN2WHJyRHVIL1F6NTQ2?=
 =?utf-8?B?U3FRVEVwaFc0L0N5c1gwSHpIaGRud3NTNjVWK09YcmpFNW9xOWN5amdMYmls?=
 =?utf-8?B?aVIwTEtYaXhqZVcvRng3bHBZOTdrMDF6RFFLVEkrRlhhSXFoY0JVamh4RWxy?=
 =?utf-8?B?aDE4MFZCZk9lSTM0UzNicEZKU0h3OUUrV09kcVRLb2N1a3lzcUpUbER3TGNX?=
 =?utf-8?B?ejFIeFFiZ2JtYjl1bHN3eFhZdnNwYXlVa2JmUnlHUFlXUEdjWk9rVnRCYm9Y?=
 =?utf-8?B?LzhkSzNyYmc2MjQ0NFoxQlZJUVNIcVN2MUVCSGV4em83REVRUVI4YmkvNis5?=
 =?utf-8?B?YXF2RCszUXY3Rzduam9KZG51SHlkTDRCQVdyRElGN3QyQUU5WkpaOWVuVmgw?=
 =?utf-8?B?NUdOM1VLMTRqc3BhWnYxTWk5SDBzaVRXUmNNRjhBRmtwZUppZXNPdGhIV2d2?=
 =?utf-8?B?NGszV0NkY21keGJlaWZHa0ZocHM3MTlBRzJyM1VjaUVkRFc4MWFwV3RnRklH?=
 =?utf-8?B?Ti9uMmw5S21MbUdjejhwTW9SREJIL3FweEZlMjlCRkhHbjVmM3VaMUJ1bzhO?=
 =?utf-8?B?cWxDM0NyaUhtWjByaTY4d3J4OEk5bVNVanBGdnVkaEdHZ3lNOGo1RDNDTURi?=
 =?utf-8?B?L1V6U3gwY1JwRlBxbStyNENFSXlrd0tyelJLTGIrZ1huWnNHRnJQOTNKbmVU?=
 =?utf-8?B?aVkxNVVubDFZMWJoa1AwUFZMQ09sVkJPUkROQ01TRld2dFhSTjRabWpEMmRu?=
 =?utf-8?B?Zy8yK2RIUmxOTGxBVmNOMFAyQnQ1WFZDTnVHd0dVMDBDVFRkbDd3ZnNkaUcx?=
 =?utf-8?B?cFJod2hHb1NMNUtmUDFKTU40NGx3elhCMFA4NlV0dHJTdEJjK1lkVTlDakRT?=
 =?utf-8?B?TGg0Ymc2TG83MjRsVXhyaXFscTZ1eEtjZ0VWcjRmZi9mVWtxNDhyY3ZmU3Zx?=
 =?utf-8?B?WllmL2xWbnBqTFJIb2NKbnoxM1FzMmRBWlNDRHM4U1RVYmM0WC9XNUxXb0xn?=
 =?utf-8?B?VmdMTEJKM1BnNW5FM0NrNkpJRS90WWJlejNwLzlTRVB1Nnp0T0N6Q1Z3Z2hj?=
 =?utf-8?B?WmRCSmpEMjhQL245N3pPMmJGNkZVSDRFNDN2SHhhbzBmdmpIT1RWd2tKOS9R?=
 =?utf-8?B?U1ZqZEdCdjNCWXFhSU4zMFhibituWGRDUkZ0MjFmemg1VFJ6a2puL3FyUEJr?=
 =?utf-8?Q?lmbacxu1nG7Q+Z0I=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7db216e-e8bf-406b-b9fb-08dec879f5fc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:58:47.9390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyEwk+0zoNoSsS8MZjWODgHaXoOU1mDHFB274GrhUHI3SxgS+iPE8HBaGekJEpctyNdQiRHgPhI3NrDCeRdYYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11710
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

Hi,

This patch-set adds support for the i.MX94 Display Control Interface.

Also, included in the patch-set is patch that the DCIF driver depends on
for functioning properly:
 * 1/9 - 3/9 : add support for i.MX94 to fsl-ldb driver. It also
               contains a patch (2/9) from Liu Ying that was already reviewed
               and was part of another patch-set ([1]), but was never merged;

Thanks,
Laurentiu

[1] https://lkml.org/lkml/2024/11/14/262

---
Changes in v9:
- Rebased to latest linux-next (next-20260611);
- 2/9: Reworked to store the next bridge in fsl_ldb->bridge.next_bridge
  (taking a reference with drm_bridge_get()) instead of adding a new
  dedicated field. Removed the r-b tags for this patch since it needs a
  fresh review;
- 3/9: Fixed the i.MX94 LDB max_clk_khz limit (165 MHz -> 148.5 MHz) to
  match the actual hardware limit. Removed the r-b tags for this patch
  since it needs a fresh review;
- 4/9: Added a 'required:' properties list to the binding. Removed
  Krzysztof's r-b tag for this patch since it needs a fresh review;
- 5/9: Renamed the CRC source helpers (dcif_crc_source_*) and made them
  unconditionally available, dropping the CONFIG_DEBUG_FS stubs;
  improved CRC source parsing (auto ROI for the full-frame source,
  unsigned params, safer string handling); rebased onto the
  drm_atomic_state -> drm_atomic_commit rename in linux-next; reworked
  CRC/modeset gating with new has_crc and crtc_pm_enabled flags and
  proper PM error handling; switched event_lock to spinlock_irq; removed
  a redundant connector-attach call and fixed an error format string;
  added new pixel formats and full alpha/blend-mode support;
- 6/9: YAML quoting style fix only, no functional change;
- 7/9: Combined the former "arm64: dts: imx943: Add LVDS/DISPLAY CSR
  nodes" prerequisite and the "arm64: dts: imx943: Add display pipeline
  nodes" patch into a single new patch targeting the shared imx94.dtsi
  instead of imx943.dtsi, removing the dependency on Peng Fan's
  not-yet-merged patch;
- 8/9: Renamed the IT6263 bridge node to 'hdmi@4c' and fixed its
  reset-gpios polarity to GPIO_ACTIVE_LOW;
- Link to v8: https://lore.kernel.org/r/20260304-dcif-upstreaming-v8-0-bec5c047edd4@oss.nxp.com

Changes in v8:
- Rebased to latest linux-next (next-20260303). Patch 2/9 had a minor
  conflict bacause of a patch introduced recently;
- 8/9: Fixed CHECK_DTBS errors reported by Rob's bot due to missing
  regulators. Removed the r-b tag for this patch because it needs a
  fresh review;
- Link to v7: https://lore.kernel.org/r/20260122-dcif-upstreaming-v7-0-19ea17eb046f@oss.nxp.com

Changes in v7:
- Rebased to latest linux-next;
- Addressed some new checkpatch warnings: kzalloc -> kzalloc_obj;
- Fixed a couple of static check warnings in probe();
- Added Luca's r-b tag for bridge refcounting;
- Link to v6: https://lore.kernel.org/r/20251103-dcif-upstreaming-v6-0-76fcecfda919@oss.nxp.com

Changes in v6:
- 2/9: Collected r-b tag from Francesco;
- 3/9: Removed ch_max_clk_khz variable as suggested by Luca and added
  his r-b tag;
- 4/9: Collected r-b tag;
- 5/9: Call drm_bridge_put() automatically in
  dcif_crtc_query_output_bus_format() by using a cleanup action (Luca);
- 6/9: Moved allOf: block after required: block (Krzysztof). Collected
  r-b tag;
- Link to v5: https://lore.kernel.org/r/20250911-dcif-upstreaming-v5-0-a1e8dab8ae40@oss.nxp.com

Changes in v5:
- 4/9: Removed "bindings for" from the title, changed the port
  definition and simplified the example;
- 6/9: Fixed the way 'ldb' child node is declared: declare the
  'ldb' child node out of if:then: block and set the property
  to false for compatibles other than nxp,imx94-lvds-csr;
- Link to v4: https://lore.kernel.org/r/20250903123332.2569241-1-laurentiu.palcu@oss.nxp.com

Changes in v4:
- Addressed remaining DCIF driver comments from Frank;
- Limit the 'ldb' child node only to CSRs compatible with 'nxp,imx94-lvds-csr'
  in the binding file. Since LVDS CSRs are a minority, I chose to
  use the if:then: construct instead of if:not:then:;
- Remove the '#address-cells' and '#size-cells' from the ldb node, in
  imx94.dtsi, as they're not needed;
- Link to v3: https://lore.kernel.org/r/20250806150521.2174797-1-laurentiu.palcu@oss.nxp.com

Changes in v3:
- Removed the BLK CTL patches and created a separate patch set [2] for them;
- Collected r-b tags for 1/9, 2/9, 3/9 and 9/9;
- Removed the DCIF QoS functionality until I find a better way to
  implement it through syscon. QoS functionality will be added in
  subsequent patches. Also, used devm_clk_bulk_get_all() and used
  dev_err_probe() as suggested;
- Addressed Frank's and Krzysztof's comments on the DCIF bindings;
- Addressed Frank's comments on dtsi and dts files;
- Added a new binding patch, 6/9, for adding 'ldb' optional property to
  nxp,imx95-blk-ctl.yaml;
- Link to v2: https://lore.kernel.org/r/20250716081519.3400158-1-laurentiu.palcu@oss.nxp.com

Changes in v2:
- reworked the BLK_CTL patch and split in 2 to make it easier for
  review;
- split the dts and dtsi patch in 2 separate ones;
- addressed Frank's comments in DCIF driver;
- addressed Rob's comments for the bindings files;
- addressed a couple of checkpatch issues;
- Link to v1: https://lore.kernel.org/r/20250709122332.2874632-1-laurentiu.palcu@oss.nxp.com

---
Laurentiu Palcu (7):
      dt-bindings: display: fsl,ldb: Add i.MX94 LDB
      drm/bridge: fsl-ldb: Add support for i.MX94
      dt-bindings: display: imx: Add i.MX94 DCIF
      dt-bindings: clock: nxp,imx95-blk-ctl: Add ldb child node
      arm64: dts: imx94: Add display pipeline nodes
      arm64: dts: imx943-evk: Add display support using IT6263
      MAINTAINERS: Add entry for i.MX94 DCIF driver

Liu Ying (1):
      drm/bridge: fsl-ldb: Get the next non-panel bridge

Sandor Yu (1):
      drm/imx: Add support for i.MX94 DCIF

 .../bindings/clock/nxp,imx95-blk-ctl.yaml          |  26 +
 .../bindings/display/bridge/fsl,ldb.yaml           |   2 +
 .../bindings/display/imx/nxp,imx94-dcif.yaml       |  90 +++
 MAINTAINERS                                        |   9 +
 arch/arm64/boot/dts/freescale/imx94.dtsi           |  82 +++
 arch/arm64/boot/dts/freescale/imx943-evk.dts       |  86 +++
 drivers/gpu/drm/bridge/fsl-ldb.c                   |  46 +-
 drivers/gpu/drm/imx/Kconfig                        |   1 +
 drivers/gpu/drm/imx/Makefile                       |   1 +
 drivers/gpu/drm/imx/dcif/Kconfig                   |  15 +
 drivers/gpu/drm/imx/dcif/Makefile                  |   5 +
 drivers/gpu/drm/imx/dcif/dcif-crc.c                | 215 +++++++
 drivers/gpu/drm/imx/dcif/dcif-crc.h                |  43 ++
 drivers/gpu/drm/imx/dcif/dcif-crtc.c               | 705 +++++++++++++++++++++
 drivers/gpu/drm/imx/dcif/dcif-drv.c                | 233 +++++++
 drivers/gpu/drm/imx/dcif/dcif-drv.h                |  89 +++
 drivers/gpu/drm/imx/dcif/dcif-kms.c                |  96 +++
 drivers/gpu/drm/imx/dcif/dcif-plane.c              | 308 +++++++++
 drivers/gpu/drm/imx/dcif/dcif-reg.h                | 267 ++++++++
 19 files changed, 2299 insertions(+), 20 deletions(-)
---
base-commit: e7b907ffb2cd66314df92360e41f7bd5fdaa8182
change-id: 20260602-dcif-upstreaming-fb177f3c9351

Best regards,
-- 
Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
