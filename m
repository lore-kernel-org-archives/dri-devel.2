Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDDF606A335
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=HVCXmNH+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B805710F395;
	Tue,  3 Nov 2026 06:21:36 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A20710F396
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4zuJ0dFRC23dseMXZN8OxZQ7p7uc9AzBgzssFEXCS0CXlc+9KERuiko3ZOubiIy5rbyCn2/e3JMiHuURB3Ln+cVnkavzi+4/9GYnHJXjv65DylTsSqaImIujI2QIS+zHCeHq3SYz8qJoE9dgLJ+sf0qcgFUVABkd2QlFshx9RdFql6V9goG/uUwktH0/4Rh4cl8kdzEef32yRk+rCOzy/acmjB3ZIsvf9twmNDJEUquf+v+AQyaDKA/jucXuhuanJntpujUjb17Jvslau20qBYv8G2QeSEfylAbDc7nd0Rpv0HcjoubG4ort/jagyPLUs5gZi4d7a1bCvMDhcfEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9KYcujEuNYpQcJRvedFCKkWToV+X8VwQK8BL6pfp5I=;
 b=QmE8r5ZYKrRyRpeMgwGElZRWMVVB5P0L45PHNTFHwX3qreSArIIG4o0bqTBSiG9hJFd+Np/ejT5BZhiKnNuumW9dmYnm1Z13CrFK4CTKJdEFzYIlY7sfuJuyFHspuOYKO4vxM3MDjLPZgQjaJMb1Di+oyiUc0DGNx0Z0Srq7IIm4O5zj6Lheh+/KaiOovGNpfEe0FUp0mHwB9OpUd92Zfuyi5tptcxTChBAVXcjX9D6A7SaavkEFtL+EXM3vqQ/sXiPO81P4PE1AJFNJoHca0PEUJ4Xs/lCAgH98BlfHd5Z5xeYnEVwdlc1AEIBwXdlTHUdm+BCD2lgM7Ke77jX/iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9KYcujEuNYpQcJRvedFCKkWToV+X8VwQK8BL6pfp5I=;
 b=HVCXmNH+cSiikwLNoAVzbRvyLWDylE1pBfWz2gyVLIrh1IAMoHL1svqBtiRd23ArRak7q9F5SHuEZQtgvYn4w9uG8pdFosKAuxQ0XbIxzqdMA8a4OZ47JmCAGXyFfDHVeSLh45mEIAO1UqeT9ZnuDrgGHNpkmrQqN/NvVo4Ub+ptdms2PP8OTTAl5JRvlFrWbWNFPEyaDFAP+5Qcjt9W4cihygMPGlIEsm8Vc1suVtsqRR1iV7hV9Yk0T94qjgnsPuZ8QZ3lK18p2PRNK46euEemLyHieaRc2pBoA9pEVHPIDZdv6T6/4bjXXS3zDLDxhZRyEtm/yW25gA0VVXRolw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com (2603:10a6:290:c0::7)
 by PR3PR04MB7353.eurprd04.prod.outlook.com (2603:10a6:102:82::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 06:21:26 +0000
Received: from MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151]) by MI9PR04MB350878.eurprd04.prod.outlook.com
 ([fe80::8537:1cdd:6c49:6151%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:21:26 +0000
From: Liu Ying <victor.liu@nxp.com>
Date: Tue, 03 Nov 2026 14:22:06 +0800
Subject: [PATCH v9 10/16] drm/imx: dc: Use TCON operation mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-imx8-dc-prefetch-v9-10-3b985e7636e2@nxp.com>
References: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
In-Reply-To: <20261103-imx8-dc-prefetch-v9-0-3b985e7636e2@nxp.com>
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
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To MI9PR04MB350878.eurprd04.prod.outlook.com
 (2603:10a6:290:c0::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB350878:EE_|PR3PR04MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e41865-6a28-4eb8-b2d4-08df3972b0c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|7416014|376014|1800799024|6133799003|10067099003|18092099006|22082099003|261102123227099003|18002099003|3023799007|921020|56012099006|11063799006|261022105027099003|261021121427099003|261021123027099003|261026121527099003|261022075727099003|261009223027099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: OcgMlB3vKW+UYqGnrTL/LwNZItnuYqXTaVHvUiOGcrae9YCUq33NgoHBwnB7gaMOa4uqa7RPxxAGMy/n4ImkF7gf2aNesRvhyzSQqy9TLEC4rvHvdz2MXptcS0+lsf+0df8OIUo6wUOxLXNchs4jbkDhp51VBDZud8IIud6ah+PLUhjZWFuBg/uKtTIbcWvBae9TdPIePlvszgs4lUXSAznmmbmQK5wY+9W4k4EVdRUMZoFq1rifs74TIXZUKiVbkxiLMrGfdeIzRjrTB3kFfvegfT5/vxfnak+iL8fSjF0EmgczLw4h4nvstA/ZF6KK2xSLmzgSjKtYmCqSisUC9EEkSCjA11BSGOiDFPgKJT/NxDpbvBMLybVQaUFKYi1WRxJJIvaHcSRmTcX4znQ+pxvp6CS7oWyggBMEYuCzM+Km1MAWlxnQ3rqn0AExnz5WlssRQfZvEt8AgHrm0LpSAwi++IZaprHMPcXsBtU/kwzc0IorMR9AKUSv7EsLmvZQgZFJgtTCxAfUSyc6i2ICqoOakW9VFg/5Tuqz5Ddr7xfiEuUFmQXeZoe1LCbaPgBaKPcJIPFN82QeFwbf59Hly4TDG3B3QC5eO8rfbjroiwjqvdUZM6trzmUPG42O+2hXsfHxBTcQcHC1ICveZMSdE+xDcEvAO0a6EImT1O1+WNGLUIA8lzOjk8PfcBIczgm2lPstHAmv34dDmPwH+ETrWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MI9PR04MB350878.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(7416014)(376014)(1800799024)(6133799003)(10067099003)(18092099006)(22082099003)(261102123227099003)(18002099003)(3023799007)(921020)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(261021123027099003)(261026121527099003)(261022075727099003)(261009223027099003)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0JZM0IyV3l0dzBteHZrbkN3TmNjV0dWRC9Odks4eENJZ1lYRU8yQVRGbWwx?=
 =?utf-8?B?T3pPQ3Q4Y0E0anpJYnNuVUcvK3c3cTRrMS9aKzIwSjhCTVlLWStlZm1sV3RW?=
 =?utf-8?B?SGVGSkJuRFhMdUFRY2VFallUTzl5OGVLZ2dUd3dXZWx2c3dGc200VGM1SmxN?=
 =?utf-8?B?V3hmTitGQ2t6eFE2NExpc1RNN2ZvS09DVkdRaStmVVZxUVZmMkZlSXcvVGVV?=
 =?utf-8?B?alV2TmVIcnhLREdzT1JqTGpPWEFXcld1R0NrTmN1enVKcmxKQ3RaWHA2THJn?=
 =?utf-8?B?cmJHZ0M0dVFrMjllMEZOQkxtU0w1b0JnMlpYNXB5UDRTN1h6dUZXMHdnUVJn?=
 =?utf-8?B?WlpMWks4Ulh4S2ZoVjF4eXU4YmZwc0Vpd2IxeWlsdEM0OGY0WWdsNlBWL1ho?=
 =?utf-8?B?Qk95VmorazB5aEoxSEttU3J6bFlQN1llSTFrVlgyTXhUeFllL2FqckxicXYy?=
 =?utf-8?B?cGxvRG14Y1hvVE9TY2dhQnRsdk5xeDdWUC9RTzcvTTNCK1UyNkVESFBjMitr?=
 =?utf-8?B?Y3o0NkFjaEI4bm5JVGRKd0lZS3E3VnZPM3E2OWtOMVFtZDNFMkpmeUhsUjZN?=
 =?utf-8?B?alRpQ1lrYTEzU0ZRVGxzb1VWZG5waElGclRNV25vcTRBVVJhTmNGM0xWcmlo?=
 =?utf-8?B?TmJpRC8rRnAzQm15STRxMUt6U1pZTUNUdFh2WTh6MU40Nkhmc3Byak8wRWx0?=
 =?utf-8?B?Nmxpd3d5dTE4M3FzSHJ6Vzc0NHd2V0llcEZ4YXViYytXanZWS3ZkbGpBZHh4?=
 =?utf-8?B?Y1N4SDZ6VXNlUkhxMXAwSEZXa1JOSzVRQ0Qwem92ZjhMWFhLNjI2Z28rY2pS?=
 =?utf-8?B?Y0ZYcFowNGJzK2hqeXFEREFBemNCUklHVlk0UzJlYjdCQ1BsalJCR2F3ZjNG?=
 =?utf-8?B?ZzN0cWxpL0ZYT3BuOE5GQWtsSXQwbnkwTHk1citPZnVjandhSVB1NHpvMito?=
 =?utf-8?B?TVB6MHEycUxoL0JlbCtmK2MzOGFFVDJpMnVDeVFzaXlNU2N4NWVhb1p5Mzc0?=
 =?utf-8?B?b2RBSDdKV3NtMXJ2VXZLVUczWldjcmFvZnlTbG90UytPcnRYeVczOFFqRWhJ?=
 =?utf-8?B?NndhVkdmb1Eyek9TQ3hrdUp6UFhJZVBnaGJHWHRXYlU4V3FBUUppTXFqWGxm?=
 =?utf-8?B?Yi9XTDE0eHFRMUlldHBscmtBcU8vRlF6S2hRZVc0bCs0aUcvK0hRMDNDZVhE?=
 =?utf-8?B?NktzbkRNeHFoM0RHSDJkdENXU0lZQjQwbXFZbHJPS2FZMlpjQm1PME9HWmd0?=
 =?utf-8?B?TU1QTjdyVTl5WXprNGVNSDZoME5UTWFqdUIvRkFjY01lMnJWWkpDQkNsSFhu?=
 =?utf-8?B?R0JyL1UrUk1vRkx2dk43dlBYc0RXYjErNDdhd3BiMVJ6Q1BzMkROdXU5K01o?=
 =?utf-8?B?VmExdEtsb3llMUR2WnJaQ0J2RVFVbmJXRVNiOFVvc2RkZTAyazNnY3FqcWZY?=
 =?utf-8?B?QWZWTEtwRDNqTjNWeHVTYlFyTGNuRldSNWY3WGZuc2FWcjR4bWtaVVJURTdI?=
 =?utf-8?B?RlJ5NFpsT3dxUEV1OWJDOVpCbGdyRnYrTWdLWWVONWFvQVlHUjdGcHc3Uyt4?=
 =?utf-8?B?bkZiTEpCS1pMQjFkU1Axc3MyMGNpUWRtaW1RdWlqSXBZY29CdDBKMnBuQ2c0?=
 =?utf-8?B?ZzRwNDF5MWN4UkhoVmNUcTlnYmE2QW5DUzdlS1gwUGNISXpNSUR1bmdVaHps?=
 =?utf-8?B?ZFF3YTdGTXFhZFhOY1hNZG1aRG90SWlQclQzZ0ZtUjJxUnhMVWtmbTluRkVh?=
 =?utf-8?B?b3dCemR5UkVDWXhSUTNaVUJRYUFmV1JEaUVzdHRGNjhOb3g2UGFGMXMzTlVP?=
 =?utf-8?B?YmUyeHhUaytEYkRZMTd0QkppNVlTNzh3d2xNeCtMNWxMeWdUajZleXN2NXN6?=
 =?utf-8?B?THFIT09FVjZGd1BaeUNyODk3WUFCZkhaSU85R2N2S0xOYXpuaUE5V2YrUm9N?=
 =?utf-8?B?M3BUODZlVEdQZ1RUR00zb1dranc0Y251QzJnRFpuMHVxM1UvWHpnb3RLOEwx?=
 =?utf-8?B?YTBNMXpwdFc2M3hESmJueW5QYTBUZTJSSXN1b21Ub0ZNUlU3Vm5LUHZydGph?=
 =?utf-8?B?S3JoMjRuNWl3d1FTSklJdWNsaVNZMWRLOG5MeHBKMUtTNVlpUWp2eUlpUEk1?=
 =?utf-8?B?M0M3MUtsSEZTcHZRS3ZzZGVqOWx2ZXBkMkdYNmMwQ1g0a3VTK3g4MktTRjRy?=
 =?utf-8?B?Nk9BZkNrc3VUSk9hV29Ra0FKMUo5Znd1Vjkvc0M0U0FzTXVpVi9TbmJmMDFW?=
 =?utf-8?B?bzJPZFFKTXAzT3MvQUpVWUlOZnBKSFd5MTBOSEZPVklWSnBGQ3I1SzhCbGIw?=
 =?utf-8?B?bUZxQXBoMDJqMzJMYnUzcSs2RTYxdHFEcnBnSUY2NGpPMHhKNmtZZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e41865-6a28-4eb8-b2d4-08df3972b0c9
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB350878.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:21:26.6119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxdm/a00j33c+9IKxvNF6qzAM/F+UOO0uU8jZQRTtk1wdvaZxovJRqQt6FlB4liFRNOsyg20IiK7tAQDVGw3cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7353
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
index 5bc952d6883e..d03246036d4a 100644
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
@@ -567,6 +594,7 @@ int dc_crtc_init(struct dc_drm_device *dc_drm, int crtc_index)
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

