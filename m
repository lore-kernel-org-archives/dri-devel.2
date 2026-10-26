Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE5C60A261E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=dxH36pin
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50D7210EDA0;
	Mon, 26 Oct 2026 10:05:32 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA2A10EDA0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:05:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ea6SAAWS1l652XlbY0kwEBoA/uIRIh9K4Akun1dyYkrmDN7TvfG56871hhwfg1a/pAB7flV9+R8jUN1fgA+VJ6mEZb4Bnybo8UAur5Z3T8C0GF7bWZC+EkhGdDv9CsB+zDFPBH7j9Je7ypQEcnhPNZTw3XkSk1CDEMSZzqHw6n/xMhg0drQfqUGnvUKLfeqEhrq9tKJoqxBVvzS03IWeuu9Auvmmn5Kb4xcYSVdeJPoE8CfO2w5JFkDfjLHBA9YDL86U36EgUo6Q/UMSCZFgGHT+DLboudeldD1Nm+jbH6IUB8Xbx0cK+Q9h7XcTkGma1E7EsPsAzpref7Re2ApkDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rv2ivJDX5JXvCMZt4DxXD1EUMzIlqN8mgyXojYDuDmI=;
 b=Fr3hbYgbzH2HPrR3XEt4h2vQR/2XpEKy0ZU/5LOirKX56s7y+vJF/Sy+akdlW15xJv4v8IbYCFG3sMnUu3bmuDBjfW5qzz1gAuoLaRiy1fUIYBPK1kpmgOyA/xuqRiKg9Zzqb7byeh4LReKCd7SoZfeUISgzvgb+oeYaRMQBiY8BWMcoJi0L52vri01MfTQrQHT3r92YWMIbZKLzup1ByMj3YIuMoOGy/2eWChCpwOkdzAyM6jaHied2mGhYnVYafcIiMe4LaXL6n6EKj6bWSVb1ZkwjOVVt9bc9qjrDZXShClYYb2mkXLHvdSDjTLfmcbbAJy0YjBaD66raLoVzCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv2ivJDX5JXvCMZt4DxXD1EUMzIlqN8mgyXojYDuDmI=;
 b=dxH36pin47sspU4Dw4Z2KFHnB53S9AjUvQCs3WZuJsPa3IQL48pIBJqaM4IWVpUt7/6tWv1pqcT+L0t+rUHkmgs0C18eujuuH4s1VWf9CBow4+i07yHBHYvlHOqOgVT/ppaf6Eypq9qeA30fNpbR0/vz5oOX7C1tBMjQJ5jKv8ryEQ9JtBQQ7rnyKO98RMTBr9mCowpe41WsqH/2++mJ+kXui6QcGSkabioUj6XMKvf2Sm7PpFQ4jLXMtWryu512GmuJZ8I8182JZ4LMwX7m0coImt7mk7Dw3CaR+C2wSXYS6bVrD4RlL6kQr0BeSyl9yBTUk3sehc9smfoHm2yRHw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by GVXPR04MB11500.eurprd04.prod.outlook.com (2603:10a6:150:288::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:05:08 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:05:07 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Mon, 26 Oct 2026 18:05:20 +0800
Subject: [PATCH v7 15/15] drm/imx: dc: Use prefetch engine
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-imx8-dc-prefetch-v7-15-a0b50cc4fc65@nxp.com>
References: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
In-Reply-To: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@mailbox.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|GVXPR04MB11500:EE_
X-MS-Office365-Filtering-Correlation-Id: e00e997d-c81f-4ea8-dc3d-08df33489c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|921020|11063799006|56012099006|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261009223327099003|260925021311599003|260925021911599003|260925022911599003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: c/jPAd12hE1Fwt1wMOiaRjwho3lSbgvQT15QLCoa8tgfkhfKyLMv9VbmCc/S4CUFpeuvaR6J4aSPlwRREs2qqDjgdLbHqODv0YOr16qF5Eu08WoZisizrElK5w0abwCghsG0RFEQ16eLZMCWfGJ1RMk2+ITbSi2ui16sAvgI3Z3gJN7ktCNUUW7u4weAhrYephqqER/ukE/duN1b4hf6dqCwellv+TIl8h+dQe3oMsOUEYm/KA+wgRi00nvy2wzfMlcSw6raxr/hqtpp0NxNysNawxCiCZCZCXpCcWrKEeZUaJiXzpfwhFDbWyWvq5F6SaCY7npsvAsYRNFhWkzhrqL6/0hhM5l20+FEYNm7OYQ2nXqarSlGpbR3xnvQ2ZvZxGNmCz0kPkbRzNVwaVlk/T02fhI0WQ1DGmMnaSflm3URu7duL/K9854mF2Al479ybbV34H8vemfcCUeZY5uIxmn/IyP86ESlMtdrlE/HKohqKFjg3iJ7IxFezsAmdjBl1xedV0sHWqVZwwKt4e/DQDDjOZ4FxFnzeRGNad3XAVK6DIrsziG6meXGsWpvTVQYKbg1SzOE5yHm0SA5IOqKFvW4cTOzHgrvYoYgHyxpq7qQyWRrVFYSntIP/OhLfGzy1LS6Cn3jugiZAdQME34WFPX9qb14jd0/N4mEVKSLu2eFz50ZZq9EapwpDgCx3IuGrEadjppejAXukvYRgQhCug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(921020)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223327099003)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3VMOG9EdytLeUlTVm9jOFlyRHMxRVZ0R0dka20waXpkSXNjRjE0WE9JNUhZ?=
 =?utf-8?B?ZmUydUFzdm8rRGJzbnRna0taZUFyaDhHNmo1WSs3cEFraFh5ZlNxWVdXMTFl?=
 =?utf-8?B?TUpFc01iWE5iR3k0cE1EWmVwWjAzWXNqdm1JTEdoYlBYR05vVzZ2TFk4ZmV5?=
 =?utf-8?B?UDZ6UVRMdTk1SVBFdkNCQzJqWUEvOUkzVUtRbFZzdC9XMTRaSzIyQ29IV3FC?=
 =?utf-8?B?dGtpMWlhU0pWUHZuYnZSVWxmY1dlcC8xL2VzZVhLb3luamlTdE9DNGhRZDMw?=
 =?utf-8?B?V2t0VmRpN3RkclZlWEZXakdqamc5aGR6ZjA0K3FkZ2hNSjFEa0g0bGNtVFBC?=
 =?utf-8?B?SmZyaWZTcWxqTGRTSDh3NXhHMGtiZFlsQzNhV01FaXQxUGZabSttOStHaTIw?=
 =?utf-8?B?cHlGVUFJd0FUUXNyNEpMUEU1TTVwU0JJS0lJdXhoaDVzU3phdnhOUnFvRFJP?=
 =?utf-8?B?MTVVTlpGN2ZTcVBUam1HQ1oyTm1HemNIRHExb2NUVXNJZzFsb25UV01FdHJQ?=
 =?utf-8?B?UGNUWmNUa1pERkdQT09uKythT0hkTFFwbE5yRlNiTTQvbytMOHljTUtzOWJw?=
 =?utf-8?B?M2ljS0VLOWtseDlURUFIYVhTK3FjSWVscEM5cE1yUmc0MzhTMlN0VVIramJR?=
 =?utf-8?B?SU94VDRHV3VEZTJucGx2Y29vTU1Tem9leWtWdHF0eHlkZmVGU3E3VlkyZGJD?=
 =?utf-8?B?T0F1b3NYUnU4UjVuZHh0eFZsTERYci9OYnd0UjUwSXdScE9hQWM1dXNxVlA3?=
 =?utf-8?B?SW1LOFdKVkcyZmZkVVVILzFLTUhHR00xbTBvKzc1ckJEcTYvV0Q1NDNuQWkx?=
 =?utf-8?B?Sm1ld1NtVWM1MGJ3SzBFVE5yb3UyOGt3KzdYOVJiZUtWZ1M0dTZVSERSZ0JX?=
 =?utf-8?B?WjZqU0kvY0IrVTRwQXo5VXZCbEN1VmdRQjE3MkgzdUZrbmNHblRoOXUvcjBU?=
 =?utf-8?B?WnNmc3BzeW45YWJyakhHbWFWMXlyK2M0dWF1R1J3Ri9BZTYrMG1FN3BvdTFY?=
 =?utf-8?B?VU5yOWFidThzcGg5SHp6a1lXcHc2WHVidDlrVlZMMHIvc2VyUE1mZ2RNek14?=
 =?utf-8?B?dzV4UnUrcUhhU0JVL2JpL24yTVliTm9kS1hBa01wS3p6aDBzWDNyd1RtaTJ2?=
 =?utf-8?B?UmVhZVNBSXlpbkRsNkZhWUhUVWp1UExvUCtwbVZDM0J4bWt0bGNmS3RLUEYw?=
 =?utf-8?B?U1hVVFdxazgvcGhrUkxSQitaK1pNYjNJRXBSMjRSbXpXU1ZHcExjdk9abi9C?=
 =?utf-8?B?K0k2VFdvRHRLQ0ZadjdTTms1dkpkNXA2RnNlenBLZC9CU3NXeWYrS2tDalFv?=
 =?utf-8?B?S0VHZGRMVE9HYkZpWTRhWUFqOXZqTGRyQUFNN2o5UXRqblkwTjhrOXNmbjhh?=
 =?utf-8?B?MXRKRWhpYlRtenNrbm9JZFJXZlluVGMvYk1XTTVsOGl1VjVDa210c1NOeUZy?=
 =?utf-8?B?aWdTNHpGbUNyaTlLcnZIVmpTNGZSajBkU1JqN1hiQm5nSXlPSlhPZTg2aGo2?=
 =?utf-8?B?SS9aMktNK21ydUo5cWRtYStYejdyOFNVMmRGNk1nTDRrT2ozYnhJQVJhZXN2?=
 =?utf-8?B?RVVrV3NGK2tVeDF4aDRNUlZ5RDFrbUlhRzZ3MVozNmVwaFhlMlVHdVV1dVNa?=
 =?utf-8?B?cGRiWWwvL01BeXFiN1d0VGh1UlJUcERTSTNYTEJsbGNFSERCcjVsK0pPcXVS?=
 =?utf-8?B?RDZoQXRjc21rVGRBbXRRVmpib1ZtMjltWkRpZW5aZVBYcXBYYU5pdldBbXo3?=
 =?utf-8?B?STUweEZPRXdvMzRNYUd4R3ZYRDNaNEU5MW4rNlVyU2ZZbUhVNkRRcmRabnZP?=
 =?utf-8?B?SjROYUhCTGRzakFLRlNEdSt2YTIvQUZSaWNGSlVta3VzQmlFRFB3aTMxbUZF?=
 =?utf-8?B?M2pjSXRBNlhiaEFncURjc1dSQmxPMUVpcE01N01BdW1oWDlyd0xrcEVBU1p2?=
 =?utf-8?B?WU9QN1UrVUUwcmNoeTFzRndtRFMzN3JWR1FuZW5hK01PcnR3ZkFqS1VYRUgz?=
 =?utf-8?B?VTVqMW1zVU9aTnY3bWp1cExEVmJzS1k2UjQ5NWFGU0tPdXEvVDRiSzU0ZEZv?=
 =?utf-8?B?a3ZQdVJvUFNXSUhVUW9KbUFKRFVMMU95akQwV3c5SGYwVG10MFV2emF1M1RN?=
 =?utf-8?B?c2R3cUx2bE0xRFkrK0NZdFZXQ05xbmxyeHZMWmJRcHlWZDNVaHNKa2ZKWm03?=
 =?utf-8?B?OERSZ3AwWDc0RWtDNTJIVHUwMExSSWg5eTcyQTlKUW5MNkdEN3N0MTMyeWo0?=
 =?utf-8?B?RjF1RGdoTnp0Y3FIMExPalZJYUxZUVlvR2JyUnh0ZGFzdjBwbjhLcDJOcmUy?=
 =?utf-8?B?OS9BYTJRcjJkZXl0cEw1d0llcTl2YWVWZ1o3bWdxRHZKeloweVN0dz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00e997d-c81f-4ea8-dc3d-08df33489c8c
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:05:06.9741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVa1w7LUn25tzIpOYStNhtoKFVEHzQxtnLUIlGOIF5lRzsQV9jgaPE+tV4wTbmI9278Gu/bqjFU+LkoMRGjtXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11500
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

One prefetch engine consists of one DPR channel and one or two PRGs.
Each PRG handles one planar in a pixel format.  Every FetchUnit used
by KMS may attach to a PRG and hence use a prefetch engine.  So, to
simplify driver code, always use prefetch engines for FetchUnits in
KMS driver and avoid supporting bypassing them.  Aside from configuring
and disabling a prefetch engine along with a FetchUnit for atomic
commits, adapt burst size/stride fixup requirements from PRG in
FetchUnit driver and set use_raw_spinlock flag in ExtDst PIXENGCFG
regmap configuration to avoid sleeping on PREEMPT_RT because
dc_ed_pec_sync_trigger() can be called with local irq and preempt
disabled.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v7:
- Check {old,new}_plane_state against NULL in dc_crtc_atomic_flush().
  (Sashiko AI bot)
- Return 128B burst size from dc_fu_burst_size_fixup() when baddr == 0.
  This avoids undefined behavior of __ffs(0).  (Sashiko AI bot)
- Set use_raw_spinlock flag in ExtDst PIXENGCFG regmap configuration to
  avoid sleeping on PREEMPT_RT because dc_ed_pec_sync_trigger() is can be
  called with local irq and preempt disabled.
- Modify debug message in dc_crtc_disable_at_boot().
- Adapt dc_drv_crtc_was_enabled() in dc_crtc_disable_at_boot().
- Rename __dc_crtc_disable_fg_along_with_dprc_repeat_en() to
  dc_crtc_disable_fg_along_with_dprc_repeat_en().
- Update commit message.

v6:
- Rebase onto the latest drm-misc-next and resolve conflicts.

v3:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-crtc.c  | 139 ++++++++++++++++++++++++++++++++++----
 drivers/gpu/drm/imx/dc/dc-ed.c    |   5 ++
 drivers/gpu/drm/imx/dc/dc-fu.c    |  30 +++++++-
 drivers/gpu/drm/imx/dc/dc-fu.h    |   2 +-
 drivers/gpu/drm/imx/dc/dc-kms.h   |   5 ++
 drivers/gpu/drm/imx/dc/dc-plane.c |  46 +++++++++++--
 6 files changed, 204 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc-crtc.c
index 1ca1c9229e94..2d17afcae8f2 100644
--- a/drivers/gpu/drm/imx/dc/dc-crtc.c
+++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
@@ -25,6 +25,7 @@
 #include <drm/drm_vblank.h>
 
 #include "dc-de.h"
+#include "dc-dprc.h"
 #include "dc-drv.h"
 #include "dc-kms.h"
 #include "dc-pe.h"
@@ -204,7 +205,13 @@ dc_crtc_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 				drm_atomic_get_old_crtc_state(state, crtc);
 	struct drm_crtc_state *new_crtc_state =
 				drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_plane_state *old_plane_state =
+			drm_atomic_get_old_plane_state(state, crtc->primary);
+	struct drm_plane_state *new_plane_state =
+			drm_atomic_get_new_plane_state(state, crtc->primary);
+	struct dc_plane *dc_plane = to_dc_plane(crtc->primary);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
+	bool disabling_plane = false;
 	int idx;
 
 	if (drm_atomic_crtc_needs_modeset(new_crtc_state) ||
@@ -216,13 +223,41 @@ dc_crtc_atomic_flush(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 
 	enable_irq(dc_crtc->irq_ed_cont_shdload);
 
-	/* flush plane update out to display */
-	dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
+	if (old_plane_state && new_plane_state)
+		disabling_plane = drm_atomic_plane_disabling(old_plane_state,
+							     new_plane_state);
+
+	if (disabling_plane) {
+		unsigned long flags;
+
+		dc_crtc_dbg(crtc, "disabling plane\n");
+
+		/*
+		 * Don't relinquish CPU until DPRC REPEAT_EN is disabled and
+		 * sync is triggered.
+		 */
+		local_irq_save(flags);
+		preempt_disable();
+
+		DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
+		dc_dprc_disable_repeat_en(dc_plane->fu->dprc);
+		/* flush plane update out to display */
+		dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
+
+		local_irq_restore(flags);
+		preempt_enable();
+	} else {
+		/* flush plane update out to display */
+		dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
+	}
 
 	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(ed_cont_shdload_done);
 
 	disable_irq(dc_crtc->irq_ed_cont_shdload);
 
+	if (disabling_plane)
+		dc_dprc_disable(dc_plane->fu->dprc);
+
 	DC_CRTC_CHECK_FRAMEGEN_FIFO(dc_crtc->fg);
 
 	drm_dev_exit(idx);
@@ -323,14 +358,33 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	dc_crtc_queue_state_event(new_crtc_state);
 }
 
-static inline void __dc_crtc_disable_fg(struct drm_crtc *crtc)
+static inline void
+dc_crtc_disable_fg_along_with_dprc_repeat_en(struct drm_crtc *crtc)
 {
+	struct dc_plane *dc_plane = to_dc_plane(crtc->primary);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
+	unsigned long flags;
 
-	enable_irq(dc_crtc->irq_dec_seqcomplete);
+	/* Don't relinquish CPU until DPRC REPEAT_EN is disabled. */
+	local_irq_save(flags);
+	preempt_disable();
+
+	/*
+	 * Sync to FrameGen frame index moving so that
+	 * FrameGen can be disabled in the next frame.
+	 */
+	DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
 	dc_fg_disable(dc_crtc->fg);
-	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
-	disable_irq(dc_crtc->irq_dec_seqcomplete);
+	/*
+	 * There is one frame leftover after FrameGen disablement.
+	 * Sync to FrameGen frame index moving so that DPRC REPEAT_EN
+	 * can be disabled in the next frame.
+	 */
+	DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
+	dc_dprc_disable_repeat_en(dc_plane->fu->dprc);
+
+	local_irq_restore(flags);
+	preempt_enable();
 }
 
 static void
@@ -338,14 +392,29 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 {
 	struct drm_crtc_state *new_crtc_state =
 				drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_crtc_state *old_crtc_state =
+				drm_atomic_get_old_crtc_state(state, crtc);
 	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
+	struct dc_plane *dc_plane = to_dc_plane(crtc->primary);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
 	int idx;
 
 	if (!drm_dev_enter(crtc->dev, &idx))
 		goto out;
 
-	__dc_crtc_disable_fg(crtc);
+	enable_irq(dc_crtc->irq_dec_seqcomplete);
+
+	if (old_crtc_state->plane_mask)
+		dc_crtc_disable_fg_along_with_dprc_repeat_en(crtc);
+	else
+		dc_fg_disable(dc_crtc->fg);
+
+	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
+	disable_irq(dc_crtc->irq_dec_seqcomplete);
+
+	if (old_crtc_state->plane_mask)
+		dc_dprc_disable(dc_plane->fu->dprc);
+
 	dc_fg_disable_clock(dc_crtc->fg);
 
 	/* request pixel engine power-off as plane is off too */
@@ -371,7 +440,10 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 void dc_crtc_disable_at_boot(struct drm_crtc *crtc)
 {
 	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
+	struct dc_plane *dc_plane = to_dc_plane(crtc->primary);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
+	enum dc_link_id ed_src, lb_sec;
+	bool disable_dprc = false;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(dc_crtc->de->dev);
@@ -381,16 +453,57 @@ void dc_crtc_disable_at_boot(struct drm_crtc *crtc)
 		return;
 	}
 
+	ret = pm_runtime_resume_and_get(dc_drm->pe->dev);
+	if (ret) {
+		dc_crtc_err(crtc, "failed to get DC pixel engine RPM: %d\n",
+			    ret);
+		goto out1;
+	}
+
 	if (!dc_fg_wait_for_frame_index_moving(dc_crtc->fg)) {
 		dc_crtc_dbg(crtc, "FrameGen frame index isn't moving\n");
-		goto out;
+		goto out2;
 	}
 
-	dc_crtc_dbg(crtc, "disabling FrameGen at boot\n");
-	__dc_crtc_disable_fg(crtc);
+	ret = dc_ed_pec_src_sel_get(dc_crtc->ed_cont, &ed_src);
+	if (ret) {
+		dc_crtc_err(crtc, "failed to get content ExtDst's source\n");
+		goto out2;
+	}
+
+	if (ed_src == LINK_ID_CONSTFRAME0 || ed_src == LINK_ID_CONSTFRAME1)
+		goto disable;
+
+	ret = dc_lb_pec_dynamic_sec_sel_get(dc_plane->lb, &lb_sec);
+	if (ret) {
+		dc_crtc_err(crtc,
+			    "failed to get primary plane LayerBlend secondary source\n");
+		goto out2;
+	}
+
+	disable_dprc = true;
+
+disable:
+	enable_irq(dc_crtc->irq_dec_seqcomplete);
+
+	if (disable_dprc) {
+		dc_crtc_dbg(crtc, "disabling FrameGen along with DPRC REPEAT_EN at boot\n");
+		dc_crtc_disable_fg_along_with_dprc_repeat_en(crtc);
+	} else {
+		dc_crtc_dbg(crtc, "disabling FrameGen at boot\n");
+		dc_fg_disable(dc_crtc->fg);
+	}
+
+	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
+	disable_irq(dc_crtc->irq_dec_seqcomplete);
 
 	if (!dc_drv_crtc_was_enabled(dc_drm, drm_crtc_index(crtc)))
-		goto out;
+		goto out2;
+
+	if (disable_dprc) {
+		dc_crtc_dbg(crtc, "disabling DPRC at boot\n");
+		dc_dprc_disable_at_boot(dc_plane->fu->dprc);
+	}
 
 	dc_crtc_dbg(crtc, "disabling clocks at boot\n");
 
@@ -401,7 +514,9 @@ void dc_crtc_disable_at_boot(struct drm_crtc *crtc)
 		dc_drm->pe_clk_axi_disabled = true;
 	}
 
-out:
+out2:
+	pm_runtime_put(dc_drm->pe->dev);
+out1:
 	pm_runtime_put(dc_crtc->de->dev);
 }
 
diff --git a/drivers/gpu/drm/imx/dc/dc-ed.c b/drivers/gpu/drm/imx/dc/dc-ed.c
index 2f8d8c94e2d9..c90644623904 100644
--- a/drivers/gpu/drm/imx/dc/dc-ed.c
+++ b/drivers/gpu/drm/imx/dc/dc-ed.c
@@ -77,6 +77,11 @@ static const struct regmap_config dc_ed_pec_regmap_config = {
 	.reg_stride = 4,
 	.val_bits = 32,
 	.fast_io = true,
+	/*
+	 * Registers could be accessed with local irq and preempt disabled,
+	 * so use a raw spinlock to avoid sleeping on PREEMPT_RT.
+	 */
+	.use_raw_spinlock = true,
 	.wr_table = &dc_ed_pec_regmap_write_table,
 	.rd_table = &dc_ed_pec_regmap_read_table,
 	.volatile_table = &dc_ed_pec_regmap_volatile_table,
diff --git a/drivers/gpu/drm/imx/dc/dc-fu.c b/drivers/gpu/drm/imx/dc/dc-fu.c
index d9933218069c..fd98d02e4d6b 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.c
+++ b/drivers/gpu/drm/imx/dc/dc-fu.c
@@ -125,13 +125,31 @@ static inline void dc_fu_set_numbuffers(struct dc_fu *fu, unsigned int num)
 			  SETNUMBUFFERS_MASK, SETNUMBUFFERS(num));
 }
 
-static void dc_fu_set_burstlength(struct dc_fu *fu, dma_addr_t baddr)
+static unsigned int dc_fu_burst_size_fixup(dma_addr_t baddr)
 {
-	unsigned int burst_size, burst_length;
+	unsigned int burst_size;
+
+	if (baddr == 0)
+		return 128U;
 
 	burst_size = 1 << __ffs(baddr);
 	burst_size = round_up(burst_size, 8);
 	burst_size = min(burst_size, 128U);
+
+	return burst_size;
+}
+
+static unsigned int
+dc_fu_stride_fixup(unsigned int stride, unsigned int burst_size)
+{
+	return round_up(stride, burst_size);
+}
+
+static void dc_fu_set_burstlength(struct dc_fu *fu, dma_addr_t baddr)
+{
+	unsigned int burst_size, burst_length;
+
+	burst_size = dc_fu_burst_size_fixup(baddr);
 	burst_length = burst_size / 8;
 
 	regmap_write_bits(fu->reg_cfg, BURSTBUFFERMANAGEMENT,
@@ -151,8 +169,14 @@ void dc_fu_set_src_bpp(struct dc_fu *fu, enum dc_fu_frac frac, unsigned int bpp)
 }
 
 static void dc_fu_set_src_stride(struct dc_fu *fu, enum dc_fu_frac frac,
-				 unsigned int stride)
+				 unsigned int width, int bpp, dma_addr_t baddr)
 {
+	unsigned int burst_size = dc_fu_burst_size_fixup(baddr);
+	unsigned int stride;
+
+	stride = width * (bpp / 8);
+	stride = dc_fu_stride_fixup(stride, burst_size);
+
 	regmap_write_bits(fu->reg_cfg, fu->reg_sourcebufferattributes[frac],
 			  STRIDE_MASK, STRIDE(stride));
 }
diff --git a/drivers/gpu/drm/imx/dc/dc-fu.h b/drivers/gpu/drm/imx/dc/dc-fu.h
index 9fbd7aadd264..0527a7b2221d 100644
--- a/drivers/gpu/drm/imx/dc/dc-fu.h
+++ b/drivers/gpu/drm/imx/dc/dc-fu.h
@@ -87,7 +87,7 @@ struct dc_fu_ops {
 	void (*set_baseaddress)(struct dc_fu *fu, enum dc_fu_frac frac,
 				dma_addr_t baddr);
 	void (*set_src_stride)(struct dc_fu *fu, enum dc_fu_frac frac,
-			       unsigned int stride);
+			       unsigned int width, int bpp, dma_addr_t baddr);
 	void (*set_src_buf_dimensions)(struct dc_fu *fu, enum dc_fu_frac frac,
 				       int w, int h);
 	void (*set_fmt)(struct dc_fu *fu, enum dc_fu_frac frac,
diff --git a/drivers/gpu/drm/imx/dc/dc-kms.h b/drivers/gpu/drm/imx/dc/dc-kms.h
index a25d47eebd28..8b45b21a6f8a 100644
--- a/drivers/gpu/drm/imx/dc/dc-kms.h
+++ b/drivers/gpu/drm/imx/dc/dc-kms.h
@@ -130,4 +130,9 @@ struct dc_plane {
 	struct dc_ed *ed;
 };
 
+static inline struct dc_plane *to_dc_plane(struct drm_plane *plane)
+{
+	return container_of(plane, struct dc_plane, base);
+}
+
 #endif /* __DC_KMS_H__ */
diff --git a/drivers/gpu/drm/imx/dc/dc-plane.c b/drivers/gpu/drm/imx/dc/dc-plane.c
index 42c0a46281cb..3a9c7548f827 100644
--- a/drivers/gpu/drm/imx/dc/dc-plane.c
+++ b/drivers/gpu/drm/imx/dc/dc-plane.c
@@ -17,6 +17,7 @@
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_print.h>
 
+#include "dc-dprc.h"
 #include "dc-drv.h"
 #include "dc-fu.h"
 #include "dc-kms.h"
@@ -44,11 +45,6 @@ static const struct drm_plane_funcs dc_plane_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
 };
 
-static inline struct dc_plane *to_dc_plane(struct drm_plane *plane)
-{
-	return container_of(plane, struct dc_plane, base);
-}
-
 static int dc_plane_check_max_source_resolution(struct drm_plane_state *state)
 {
 	int src_h = drm_rect_height(&state->src) >> 16;
@@ -88,6 +84,28 @@ static int dc_plane_check_fb(struct drm_plane_state *state)
 	return 0;
 }
 
+static int dc_plane_check_dprc(struct drm_plane_state *state)
+{
+	struct dc_plane *dplane = to_dc_plane(state->plane);
+	struct drm_framebuffer *fb = state->fb;
+	dma_addr_t baseaddr = drm_fb_dma_get_gem_addr(fb, state, 0);
+	struct dc_dprc *dprc = dplane->fu->dprc;
+	u32 src_w = drm_rect_width(&state->src) >> 16;
+
+	if (!dc_dprc_rtram_width_supported(dprc, src_w)) {
+		dc_plane_dbg(state->plane, "bad RTRAM width for DPRC\n");
+		return -EINVAL;
+	}
+
+	if (!dc_dprc_stride_supported(dprc, fb->pitches[0], src_w, fb->format,
+				      baseaddr)) {
+		dc_plane_dbg(state->plane, "fb bad pitches[0] for DPRC\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int
 dc_plane_atomic_check(struct drm_plane *plane, struct drm_atomic_commit *state)
 {
@@ -123,7 +141,11 @@ dc_plane_atomic_check(struct drm_plane *plane, struct drm_atomic_commit *state)
 	if (ret)
 		return ret;
 
-	return dc_plane_check_fb(plane_state);
+	ret = dc_plane_check_fb(plane_state);
+	if (ret)
+		return ret;
+
+	return dc_plane_check_dprc(plane_state);
 }
 
 /* A prerequisite is that drm_dev_enter() has been called beforehand. */
@@ -158,6 +180,12 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *new_state =
 				drm_atomic_get_new_plane_state(state, plane);
+	struct drm_plane_state *old_state =
+				drm_atomic_get_old_plane_state(state, plane);
+	struct drm_crtc_state *new_crtc_state =
+				drm_atomic_get_new_crtc_state(state, new_state->crtc);
+	bool needs_modeset = drm_atomic_crtc_needs_modeset(new_crtc_state);
+	bool prefetch_start = needs_modeset || !old_state->fb;
 	struct dc_plane *dplane = to_dc_plane(plane);
 	struct drm_framebuffer *fb = new_state->fb;
 	const struct dc_fu_ops *fu_ops;
@@ -184,7 +212,8 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 
 	fu_ops->set_layerblend(fu, lb);
 	fu_ops->set_burstlength(fu, baseaddr);
-	fu_ops->set_src_stride(fu, DC_FETCHUNIT_FRAC0, fb->pitches[0]);
+	fu_ops->set_src_stride(fu, DC_FETCHUNIT_FRAC0, src_w,
+			       fb->format->cpp[0] * 8, baseaddr);
 	fu_ops->set_src_buf_dimensions(fu, DC_FETCHUNIT_FRAC0, src_w, src_h);
 	fu_ops->set_fmt(fu, DC_FETCHUNIT_FRAC0, fb->format);
 	fu_ops->set_framedimensions(fu, src_w, src_h);
@@ -193,6 +222,9 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 
 	dc_plane_dbg(plane, "uses %s\n", fu_ops->get_name(fu));
 
+	dc_dprc_configure(fu->dprc, new_state->crtc->index, src_w, src_h,
+			  fb->pitches[0], fb->format, baseaddr, prefetch_start);
+
 	dc_lb_pec_dynamic_prim_sel(lb, dc_cf_get_link_id(dplane->cf));
 	dc_lb_pec_dynamic_sec_sel(lb, fu_ops->get_link_id(fu));
 	dc_lb_mode(lb, LB_BLEND);

-- 
2.43.0

