Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08D606A321
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ZsvmYIY6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 516C910ED9A;
	Mon, 26 Oct 2026 10:05:07 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76ECA10ED91
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=roSCS0fOM+V98a1Pq1exLRiWKMDio71xTusWdR0kS+Ki0ZaiJKs1FgXVz8XWUUnUr5FucMtdsxTy5ezIhv5ciU+gjrAd7auOPG3a/VMugMQ6pEt80QSrc1dtnxE7Ub+Bgeqjq+EIcDIRJDN5cesQ0DF5Eng+0p1f2FFX91ZsptiIrOSGFtnKbq/J9elTamcnCP96xnm0s5B3beWGScomJufCuuzq7cHM8Mg5IL5VsHg66g6TOx58Wn2+F5E/fCSHaWZ/KWB/o9p2ybG05SyMxkxOcKPbdH44zmPrH8DsMSlSRL+aq+ZzDw0zWU8Vlpz02T4e4Mtq8eOtcC6TX0oQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZWYhz8UBVxbfz3eY2rIqI2/WPETFHEx60/NAmF4410=;
 b=RaqJm8ohlkDLbl6nuaGPdEJbeWhQ0OIVaC2VpB0ZpJh6j5OH5ZwtRkXm/DoPwp9SKwIqrA+BOziGAco1+St5SdmWoUV5/jlo3D8n+2oafacHnMYfgSR/xsBx9IJeEBDr4hD9VlRONhkN0GTvY5rU2oKI8rc0q9A3K+QQsbbz7QBh5ZQKZT9pjv7NuL9oVCUE0nsc12b+77+PfWNw55soxJKhEh1CBHZkg7Y98vTMxm+Be7zS71BWKhiYeTsUMNZ39GnTIRMRPQOBAhmBq8WZ40mcP18DxfO17NrKkx4lxNio23vyAiDeX13PNeIULudGSsLqzZyOdwf2JvlnAtmGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZWYhz8UBVxbfz3eY2rIqI2/WPETFHEx60/NAmF4410=;
 b=ZsvmYIY6TBJOYj/q6Wa2o96krSLr7ozXKHkgGuCrgJxffbTP31JjgwCFWNtdnJD626Z+eW8Sh1xair1d/KGPuSWSjKn5r4lPw76g3VxO17s/M3zY0de5SkUTnw5nnx0Ua3jN5w+EF5DBVMHzr5++txHeqTUZ/HqLqlPQ+8iMyr7cWJK7B1HhkKTD6IWfIBrDlsshDLjcTkNgXiaeV0t3Pn+g+DTTry3S+r/jHvi/f/C1JiCpX+4WXPEDzhXixskW7AsdECJgL/7t80qDHiUyqSASQ4w8PubB1ggOG9Bx5lQ9yQP1X/IXueT1rBM+bECgqJoLRJY4nGG9wztaQDZYvA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by GVXPR04MB11500.eurprd04.prod.outlook.com (2603:10a6:150:288::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 10:04:28 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:04:28 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Mon, 26 Oct 2026 18:05:14 +0800
Subject: [PATCH v7 09/15] drm/imx: dc: Use TCON operation mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-imx8-dc-prefetch-v7-9-a0b50cc4fc65@nxp.com>
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
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|GVXPR04MB11500:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4d552e-0dac-4be5-241b-08df334885a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|921020|11063799006|56012099006|261021121427099003|261022105027099003|261022075727099003|261021123027099003|261009223027099003|10067099003|18002099003|22082099003|18092099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: DgpkH++/GtILoL211D8jE3K6vmrg0+na7hkRaT8SrWAfSu6yerHPILeJI1Ahw9u6gQlfvaO5aHfRg+vs6B4ypr6oveLCsW6wMEbhL1mJeLql/EuzoUIMNFv7YggpqDlRODa6eoYo0TQFFmFcfWXrXE1pLPEVBAbu5ZHen/tLsTsGooJbODu+98eKVUupXkJL7Pw9URHywrLxwxycjQyajmTbmR+o8Ct8+lV5+PaN5tJ55g4Nz0d03I38+OCHuMHJJsE436J4ssQw0OUWi3KyNMZfXdaVihTrwemCcySViOdW7kDGq6A1QEv2mmfiv/8SNtLidrxaKnghfCIep2m+cCjkLhCZky2pVvPz3+8bmMC19T6ZkoIxjtwie2Sf0OSNziYNXMsGiCriibSAUfJijrzsycektoj9UL0VJlslOlIGN8tKbAj1CEfe8JX/2F6neRF8S52Q8zsC9iqmeL0r4uGpXZ3DwwWAtYFJOSOMoh8j8TDlHF2F4ysAByg8on/iuHOPLYthy2HYfi7HQyHmiwsuSnt+b9HKECaTE0tkhWA0VjTyrBbqunouZ2Ur+QP+ag5ijlbpktzbuc/GbR/3GQyXn72YJwsiVewDxu92N4GDZ7zkWcAoKe9mkekjzgth3fF2COES/KHLeEE16gIDXfD78pXeadEE4tzwJpmg0/Dk7MrkKsO8wixn/34VYyKw/98bUFR/sYcMqZ3joZ8mzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(921020)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261021123027099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(18092099006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ellSUjRTRkt4RVBHYnd0R3IzWUdFaE5iczFNMUxjNnFiNnFadmhTYkg5alZH?=
 =?utf-8?B?dmFVb0NHQndFamVZRHI3ZmdNWVpVYkFNWG1OUVI4ZzduYVBkdSsrN2ZrWWNt?=
 =?utf-8?B?cVpQbXFWRGQ5dnR5QUtxRjN3VWhKMlA2eXBGU1NnNUxYLzhCTzJ2UjB0TDNa?=
 =?utf-8?B?MHZMNU1TWUYzdll1N3loZjl6b081eHpsZmdLS3g5QXZocU9Dc2ZyWG9LTkRq?=
 =?utf-8?B?VzNMMjBrRWM0Z01CRWJySDlzd1Yrd0U0b1lmbVIwMisvQ2YrWUFKUkRsL3BZ?=
 =?utf-8?B?cXNHYU1NRXcvQUVVdUF4NVo5SUxRZERpUXVzUEUxRDRieFIwVXhIZlJmczlv?=
 =?utf-8?B?MGdRRmRqd0RNSnhmZHhXRUlYS3d0OHJuMU9aSHN5MnZQYVhlc1hrSUlhWTVu?=
 =?utf-8?B?ak1PYmJhSG9vNU1TSlpGUlNpaTVLZ0M2ZS9mUzNOVUdOWmtMbzJKVlhPY0or?=
 =?utf-8?B?UEVPQjR3MHlHMFZUNGNKeUR4Z1M0YWl1Y3RSM1AyaTk3cFRJNkl2TVFiUzhW?=
 =?utf-8?B?YWlzK1pnb3NQOXoxRkJ5ZjlSalJxb2VBVno3aXZoenhyWVcySEFMYkwzZHBs?=
 =?utf-8?B?Z1hzWGRVWXJyYmRoRTdUYTRadERaY0pxWVJGQUxNMkd6Z0V1MGErcUNwbmxo?=
 =?utf-8?B?TVJNOEpjZWpucWNkR0syTlhFVjltbWJYekw3bk05clY1M05HNURydFIveVNH?=
 =?utf-8?B?cmhiMmY1SFJja3BoL0tvQXpmd1k5eitnMklKNVNDT3o0Q3NGUVp4TzdseFVN?=
 =?utf-8?B?WEtVZjVsSEZXd1FZcmpLc2tnSCs2R3dVMEpaUGpBNnJGTmg1TmI3MldBNkI0?=
 =?utf-8?B?d2VrR0ZLeUJ1c3V3clFxNm01T3daYkxVK0t6cU82b3ZvQWRhRnhmSGdzMnZs?=
 =?utf-8?B?c290NU00enBpQThnTVpNQ01wUzR6M2dmZ052OENLMmJLemZEOUMweHRQYncv?=
 =?utf-8?B?K0RHSHlRaE14R0hxcnlBMmpnTENBc01qUEhFSzdzVVVpdEtKRWtOckdGTlVN?=
 =?utf-8?B?VU5xUytrdEhkaUJsbEE0Y2hER2g5UVJNd1lIdytqeDlvb3l6K0VjV2xqMDVm?=
 =?utf-8?B?MU1kWndnVmhYaDF3aCtWczNFYUk2QmtYWnIvODJXbmx6Ym5ISkJFOGZXa3lN?=
 =?utf-8?B?bjkvS0lNSUhES1hiODlBMlo0c0tNbFBDb3JzMm52eGNqeVQxTkRYTm1uOWVa?=
 =?utf-8?B?TzhuTDBtSlBUWCtZQ3N5WElGVlRTOEJjbTJSTFBuTjBCYVdNR0lTUks1NVJk?=
 =?utf-8?B?RC9GRlJiNVd2cFlhS2ZVa2pNc0RZNm83RHI0bDVkemJlU3FTZWRMbnRsK05j?=
 =?utf-8?B?YmdVTk5telFmaFJmWm5aM2JqN0FETkR5eXcwYVhaQXI0MC9tVklEK3pzNnpz?=
 =?utf-8?B?b3gvaXBtZ1V0QmJ1bkE3Q3p2VWlEUUZzSUtNVFo2cktXMEhWaXBvUWV5ZURM?=
 =?utf-8?B?clJYZFo5SVN6WFZ4b283YlhBNDF3b1h0SWcvQXE3NUU4SFRTaU1Tb21QT0dM?=
 =?utf-8?B?U3hLTFU3N1hwRTJvdUtLYjc1TFZiWVJTa3QxSzVwaUg2ZmtvbGJ0VFNsTW5I?=
 =?utf-8?B?MVNGWEFDQm9tUlN0bGF2Yml2eDVzYW03dm4waEpSV2R3b0tkQkxrcUFkWGR6?=
 =?utf-8?B?VDBXNFU3QW5oN28rcTh4RHo1eHZ5V1dBR3VqdlI2Y1BqeGhXMmhtaURUUEVB?=
 =?utf-8?B?SEFkUVJuaWVrZVJuQTdCcWJjcVZJUVU2RHJVRERBSmZORVNtQjNoc3hmMGxT?=
 =?utf-8?B?WDE0L0NOR1F0Z21YY2xoMmNFaUV3MzJMUFh4NDY4WnBGcEZ4TUc4YitXRmFo?=
 =?utf-8?B?T3hMc0RwTk9YSTB6TU4xb0JqR24wWTdHUVhWTWdCdHFpRHZZSW1HR2pwajZi?=
 =?utf-8?B?dG5OZnVaMWI0Mlo3TklpNTZURG5ybEFjUXVIc0R6azI2WlhWd1RwRTFBWFQ5?=
 =?utf-8?B?NXl6eWd4RGdscWJHeWJYcGZ0a1FaKzQ0ell3ZkJQL2hkK0NaZXVPYzVCTU05?=
 =?utf-8?B?K1NySG5zdXRNMU9xUmx5Y0ljSjcxbjhFZUJqRWFYVzV2ZlQvcm5IL0tIOTRw?=
 =?utf-8?B?S3F1WVVpR2Z0UUNoaTk3enRnSDhVWlNpRXQxamtoK0IxN2ZiWGVYQ0dNQUhh?=
 =?utf-8?B?b0NQSURiRjArak1kb2pjTDhLdmVaWEN6Y1A5SUl3VjBTQ1dDam0vRGM5b0pY?=
 =?utf-8?B?VmVrYTdFekhYNEZQcUpnaUVrS2N0NGZSL2JzME9UYUIvNmtDVno5WUhxVjlQ?=
 =?utf-8?B?dmlVVENVRlAvRllhWlE5bFhqRlBoS0xBZVBjUDhhbnc0aHZibnFOQXovcGFp?=
 =?utf-8?B?eEpJanN3RVRSVnRQQXVjOVpQTjBrZStPTEdGelBlUTFhUzRsR1J1dz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4d552e-0dac-4be5-241b-08df334885a6
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:04:28.4023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2B+7REq8UzfYryiGKpgL0M3WTw9zo/6Eb/Xag3O5RH3GU21pl8cr92PzduW4U6213GiICGwAURpZO6bQSmRelQ==
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

In TCON operation mode, sync signals from FrameGen are ignored, but
a much more customized output timing can be generated by the TCON
module.  By using TCON operaton mode, generate KACHUNK signal along
with HSYNC/VSYNC/data enable signals.  The KACHUNK signal is used as
a synchronization signal inside the prefetch engine(DPRC + PRG(s),
attached to FetchUnit(s)).  Carefully switch TCON bypass mode to TCON
operation mode when CRTC is being enabled so that the prefetch engine
may evade the first dumb frame generated by the display controller.
The switching is done with local irq and preempt disabled to ensure
it is done right after FrameGen frame counter moves as instructed by
design team.  Set use_raw_spinlock flag in flag in FrameGen and Tcon
regmap configurations to avoid sleeping on PREEMPT_RT when switching.
Also, replace jiffies with timekeeping API ktime_add_ms(), ktime_get()
and ktime_before() in dc_fg_wait_for_frame_index_moving() to avoid a
potential hard lockup when switching.

Since TCON BYPASS bit is controlled by KMS driver when doing atomic
commits, drop the bit setting when initializing TCON.  This also
avoids accidentally initializing TCON BYPASS bit to 1 when driver
module removing and re-installing where an upcoming patch would
disable a CRTC at boot in TCON operation mode if needed.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
v7:
- Set use_raw_spinlock flag in FrameGen and Tcon regmap configurations to
  avoid sleeping on PREEMPT_RT.  (Sashiko AI bot)
- Replace jiffies with timekeeping API ktime_add_ms(), ktime_get() and
  ktime_before() in dc_fg_wait_for_frame_index_moving() to avoid a
  potential hard lockup.  (Sashiko AI bot)
- Use adjusted timings(e.g., m->crtc_hdisplay) in dc_tc_cfg_videomode()
  instead of logical mode timings (e.g., m->hdisplay).  (Sashiko AI bot)
- Update commit message.

v6:
- Rebase onto the latest drm-misc-next and resolve conflicts.

v3:
- Collect Frank's R-b tag.
---
 drivers/gpu/drm/imx/dc/dc-crtc.c |  28 +++++++++
 drivers/gpu/drm/imx/dc/dc-de.h   |   2 +
 drivers/gpu/drm/imx/dc/dc-fg.c   |  11 +++-
 drivers/gpu/drm/imx/dc/dc-kms.h  |   2 +
 drivers/gpu/drm/imx/dc/dc-tc.c   | 119 +++++++++++++++++++++++++++++++++++++--
 5 files changed, 155 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc-crtc.c
index c7dbe5f500b4..1ca1c9229e94 100644
--- a/drivers/gpu/drm/imx/dc/dc-crtc.c
+++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
@@ -6,8 +6,10 @@
 #include <linux/completion.h>
 #include <linux/container_of.h>
 #include <linux/interrupt.h>
+#include <linux/irqflags.h>
 #include <linux/irqreturn.h>
 #include <linux/pm_runtime.h>
+#include <linux/preempt.h>
 #include <linux/spinlock.h>
 
 #include <drm/drm_atomic.h>
@@ -68,6 +70,14 @@ do {									\
 							__func__);	\
 } while (0)
 
+#define DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(fg)		\
+do {									\
+	if (!dc_fg_wait_for_frame_index_moving(fg))			\
+		dc_crtc_err(crtc,					\
+			"%s: FrameGen frame index isn't moving\n",	\
+							__func__);	\
+} while (0)
+
 static inline struct dc_crtc *to_dc_crtc(struct drm_crtc *crtc)
 {
 	return container_of(crtc, struct dc_crtc, base);
@@ -230,6 +240,7 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	struct dc_drm_device *dc_drm = to_dc_drm_device(crtc->dev);
 	struct dc_crtc *dc_crtc = to_dc_crtc(crtc);
 	enum dc_link_id cf_link;
+	unsigned long flags;
 	int idx, ret;
 
 	dc_crtc_dbg(crtc, "mode " DRM_MODE_FMT "\n", DRM_MODE_ARG(adj));
@@ -250,6 +261,7 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	enable_irq(dc_crtc->irq_ed_safe_shdload);
 
 	dc_fg_cfg_videomode(dc_crtc->fg, adj);
+	dc_tc_cfg_videomode(dc_crtc->tc, adj);
 
 	dc_cf_framedimensions(dc_crtc->cf_cont,
 			      adj->crtc_hdisplay, adj->crtc_vdisplay);
@@ -274,7 +286,22 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 	dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
 	dc_ed_pec_sync_trigger(dc_crtc->ed_safe);
 	dc_fg_shdtokgen(dc_crtc->fg);
+
+	/* Don't relinquish CPU until TCON is set to operation mode. */
+	local_irq_save(flags);
+	preempt_disable();
+
 	dc_fg_enable(dc_crtc->fg);
+	/*
+	 * Turn TCON into operation mode as soon as the first dumb
+	 * frame is generated by DC(we don't relinquish CPU to ensure
+	 * this).  This makes DPR/PRG be able to evade the frame.
+	 */
+	DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
+	dc_tc_set_operation_mode(dc_crtc->tc);
+
+	local_irq_restore(flags);
+	preempt_enable();
 
 	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(ed_safe_shdload_done);
 	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(ed_cont_shdload_done);
@@ -562,6 +589,7 @@ int dc_crtc_init(struct dc_drm_device *dc_drm, int crtc_index)
 	dc_crtc->ed_cont = pe->ed_cont[crtc_index];
 	dc_crtc->ed_safe = pe->ed_safe[crtc_index];
 	dc_crtc->fg = de->fg;
+	dc_crtc->tc = de->tc;
 
 	dc_crtc->irq_dec_framecomplete = de->irq_framecomplete;
 	dc_crtc->irq_dec_seqcomplete = de->irq_seqcomplete;
diff --git a/drivers/gpu/drm/imx/dc/dc-de.h b/drivers/gpu/drm/imx/dc/dc-de.h
index 211f3fcc1a9a..c39f2ef5eea9 100644
--- a/drivers/gpu/drm/imx/dc/dc-de.h
+++ b/drivers/gpu/drm/imx/dc/dc-de.h
@@ -54,6 +54,8 @@ enum drm_mode_status dc_fg_check_clock(struct dc_fg *fg, int clk_khz);
 void dc_fg_init(struct dc_fg *fg);
 
 /* Timing Controller Unit */
+void dc_tc_set_operation_mode(struct dc_tc *tc);
+void dc_tc_cfg_videomode(struct dc_tc *tc, struct drm_display_mode *m);
 void dc_tc_init(struct dc_tc *tc);
 
 #endif /* __DC_DISPLAY_ENGINE_H__ */
diff --git a/drivers/gpu/drm/imx/dc/dc-fg.c b/drivers/gpu/drm/imx/dc/dc-fg.c
index 3741dc66c0d9..26b786e146d4 100644
--- a/drivers/gpu/drm/imx/dc/dc-fg.c
+++ b/drivers/gpu/drm/imx/dc/dc-fg.c
@@ -8,7 +8,7 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/device.h>
-#include <linux/jiffies.h>
+#include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -122,6 +122,11 @@ static const struct regmap_config dc_fg_regmap_config = {
 	.reg_stride = 4,
 	.val_bits = 32,
 	.fast_io = true,
+	/*
+	 * Registers could be accessed with local irq and preempt disabled,
+	 * so use a raw spinlock to avoid sleeping on PREEMPT_RT.
+	 */
+	.use_raw_spinlock = true,
 	.wr_table = &dc_fg_regmap_write_table,
 	.rd_table = &dc_fg_regmap_read_table,
 	.max_register = FGCHSTATCLR,
@@ -230,7 +235,7 @@ u32 dc_fg_get_line_index(struct dc_fg *fg)
 
 bool dc_fg_wait_for_frame_index_moving(struct dc_fg *fg)
 {
-	unsigned long timeout = jiffies + msecs_to_jiffies(100);
+	ktime_t timeout = ktime_add_ms(ktime_get(), 100);
 	u32 frame_index, last_frame_index;
 
 	frame_index = dc_fg_get_frame_index(fg);
@@ -238,7 +243,7 @@ bool dc_fg_wait_for_frame_index_moving(struct dc_fg *fg)
 		last_frame_index = frame_index;
 		frame_index = dc_fg_get_frame_index(fg);
 	} while (last_frame_index == frame_index &&
-		 time_before(jiffies, timeout));
+		 ktime_before(ktime_get(), timeout));
 
 	return last_frame_index != frame_index;
 }
diff --git a/drivers/gpu/drm/imx/dc/dc-kms.h b/drivers/gpu/drm/imx/dc/dc-kms.h
index cd7860eff986..a25d47eebd28 100644
--- a/drivers/gpu/drm/imx/dc/dc-kms.h
+++ b/drivers/gpu/drm/imx/dc/dc-kms.h
@@ -50,6 +50,8 @@ struct dc_crtc {
 	struct dc_ed *ed_safe;
 	/** @fg: framegen */
 	struct dc_fg *fg;
+	/** @tc: tcon */
+	struct dc_tc *tc;
 	/**
 	 * @irq_dec_framecomplete:
 	 *
diff --git a/drivers/gpu/drm/imx/dc/dc-tc.c b/drivers/gpu/drm/imx/dc/dc-tc.c
index d0d4faba790e..626758904f77 100644
--- a/drivers/gpu/drm/imx/dc/dc-tc.c
+++ b/drivers/gpu/drm/imx/dc/dc-tc.c
@@ -8,11 +8,30 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include <drm/drm_modes.h>
+
 #include "dc-drv.h"
 #include "dc-de.h"
 
 #define TCON_CTRL	0x410
-#define  CTRL_RST_VAL	0x01401408
+#define  SPLITPOSITION_MASK	GENMASK(29, 16)
+#define  SPLITPOSITION(n)	FIELD_PREP(SPLITPOSITION_MASK, (n))
+#define  DUAL_SWAP	BIT(15)
+#define  MINILVDS_OPCODE_MASK	GENMASK(14, 12)
+#define  MODE_4PAIRS	FIELD_PREP(MINILVDS_OPCODE_MASK, 0x1)
+#define  LVDS_CLOCK_INV	BIT(11)
+#define  LVDS_BALANCE	BIT(10)
+#define  LVDSMODE	BIT(9)
+#define  ENLVDS		BIT(8)
+#define  INV_CTRL_MASK	GENMASK(7, 4)
+#define  BYPASS		BIT(3)
+#define  TCON_SYNC	BIT(2)
+#define  CHANNELMODE_MASK	GENMASK(1, 0)
+#define  CTRL_RST_MASK	\
+		(SPLITPOSITION_MASK | DUAL_SWAP | MINILVDS_OPCODE_MASK | \
+		 LVDS_CLOCK_INV | LVDS_BALANCE | LVDSMODE | ENLVDS | \
+		 INV_CTRL_MASK | TCON_SYNC | CHANNELMODE_MASK)
+#define  CTRL_RST_VAL  (SPLITPOSITION(0x140) | MODE_4PAIRS | LVDS_BALANCE)
 
 /* red: MAPBIT 29-20, green: MAPBIT 19-10, blue: MAPBIT 9-0 */
 #define MAPBIT3_0	0x418
@@ -24,6 +43,16 @@
 #define MAPBIT27_24	0x430
 #define MAPBIT31_28	0x434
 
+#define SPGPOSON(n)	(0x460 + (n) * 16)
+#define SPGMASKON(n)	(0x464 + (n) * 16)
+#define SPGPOSOFF(n)	(0x468 + (n) * 16)
+#define SPGMASKOFF(n)	(0x46c + (n) * 16)
+#define  X(n)		FIELD_PREP(GENMASK(30, 16), (n))
+#define  Y(n)		FIELD_PREP(GENMASK(14, 0), (n))
+
+#define SMXSIGS(n)	(0x520 + (n) * 8)
+#define SMXFCTTABLE(n)	(0x524 + (n) * 8)
+
 static const struct dc_subdev_info dc_tc_info[] = {
 	{ .reg_start = 0x5618c800, .id = 0, },
 	{ .reg_start = 0x5618e400, .id = 1, },
@@ -32,6 +61,8 @@ static const struct dc_subdev_info dc_tc_info[] = {
 static const struct regmap_range dc_tc_regmap_ranges[] = {
 	regmap_reg_range(TCON_CTRL, TCON_CTRL),
 	regmap_reg_range(MAPBIT3_0, MAPBIT31_28),
+	regmap_reg_range(SPGPOSON(0), SPGMASKOFF(4)),
+	regmap_reg_range(SMXSIGS(0), SMXFCTTABLE(3)),
 };
 
 static const struct regmap_access_table dc_tc_regmap_access_table = {
@@ -44,9 +75,14 @@ static const struct regmap_config dc_tc_regmap_config = {
 	.reg_stride = 4,
 	.val_bits = 32,
 	.fast_io = true,
+	/*
+	 * Registers could be accessed with local irq and preempt disabled,
+	 * so use a raw spinlock to avoid sleeping on PREEMPT_RT.
+	 */
+	.use_raw_spinlock = true,
 	.wr_table = &dc_tc_regmap_access_table,
 	.rd_table = &dc_tc_regmap_access_table,
-	.max_register = MAPBIT31_28,
+	.max_register = SMXFCTTABLE(3),
 };
 
 /*
@@ -59,10 +95,85 @@ static const u32 dc_tc_mapbit[] = {
 	0x13121110, 0x03020100, 0x07060504, 0x00000908,
 };
 
+void dc_tc_set_operation_mode(struct dc_tc *tc)
+{
+	regmap_write_bits(tc->reg, TCON_CTRL, BYPASS, 0);
+}
+
+void dc_tc_cfg_videomode(struct dc_tc *tc, struct drm_display_mode *m)
+{
+	int hdisplay, hsync_start, hsync_end;
+	int vdisplay, vsync_start, vsync_end;
+	int y;
+
+	hdisplay = m->crtc_hdisplay;
+	vdisplay = m->crtc_vdisplay;
+	hsync_start = m->crtc_hsync_start;
+	vsync_start = m->crtc_vsync_start;
+	hsync_end = m->crtc_hsync_end;
+	vsync_end = m->crtc_vsync_end;
+
+	/*
+	 * Turn TCON into operation mode later after the first dumb frame is
+	 * generated by DC.  This makes DPR/PRG be able to evade the frame.
+	 */
+	regmap_write_bits(tc->reg, TCON_CTRL, BYPASS, BYPASS);
+
+	/* dsp_control[0]: HSYNC */
+	regmap_write(tc->reg, SPGPOSON(0), X(hsync_start));
+	regmap_write(tc->reg, SPGMASKON(0), 0xffff);
+
+	regmap_write(tc->reg, SPGPOSOFF(0), X(hsync_end));
+	regmap_write(tc->reg, SPGMASKOFF(0), 0xffff);
+
+	regmap_write(tc->reg, SMXSIGS(0), 0x2);
+	regmap_write(tc->reg, SMXFCTTABLE(0), 0x1);
+
+	/* dsp_control[1]: VSYNC */
+	regmap_write(tc->reg, SPGPOSON(1), X(hsync_start) | Y(vsync_start - 1));
+	regmap_write(tc->reg, SPGMASKON(1), 0x0);
+
+	regmap_write(tc->reg, SPGPOSOFF(1), X(hsync_start) | Y(vsync_end - 1));
+	regmap_write(tc->reg, SPGMASKOFF(1), 0x0);
+
+	regmap_write(tc->reg, SMXSIGS(1), 0x3);
+	regmap_write(tc->reg, SMXFCTTABLE(1), 0x1);
+
+	/* dsp_control[2]: data enable */
+	/* horizontal */
+	regmap_write(tc->reg, SPGPOSON(2), 0x0);
+	regmap_write(tc->reg, SPGMASKON(2), 0xffff);
+
+	regmap_write(tc->reg, SPGPOSOFF(2), X(hdisplay));
+	regmap_write(tc->reg, SPGMASKOFF(2), 0xffff);
+
+	/* vertical */
+	regmap_write(tc->reg, SPGPOSON(3), 0x0);
+	regmap_write(tc->reg, SPGMASKON(3), 0x7fff0000);
+
+	regmap_write(tc->reg, SPGPOSOFF(3), Y(vdisplay));
+	regmap_write(tc->reg, SPGMASKOFF(3), 0x7fff0000);
+
+	regmap_write(tc->reg, SMXSIGS(2), 0x2c);
+	regmap_write(tc->reg, SMXFCTTABLE(2), 0x8);
+
+	/* dsp_control[3]: KACHUNK */
+	y = vdisplay + 1;
+
+	regmap_write(tc->reg, SPGPOSON(4), X(0x0) | Y(y));
+	regmap_write(tc->reg, SPGMASKON(4), 0x0);
+
+	regmap_write(tc->reg, SPGPOSOFF(4), X(0x20) | Y(y));
+	regmap_write(tc->reg, SPGMASKOFF(4), 0x0);
+
+	regmap_write(tc->reg, SMXSIGS(3), 0x6);
+	regmap_write(tc->reg, SMXFCTTABLE(3), 0x2);
+}
+
 void dc_tc_init(struct dc_tc *tc)
 {
-	/* reset TCON_CTRL to POR default so that TCON works in bypass mode */
-	regmap_write(tc->reg, TCON_CTRL, CTRL_RST_VAL);
+	/* reset TCON_CTRL to POR default except for touching BYPASS bit */
+	regmap_write_bits(tc->reg, TCON_CTRL, CTRL_RST_MASK, CTRL_RST_VAL);
 
 	/* set format */
 	regmap_bulk_write(tc->reg, MAPBIT3_0, dc_tc_mapbit,

-- 
2.43.0

