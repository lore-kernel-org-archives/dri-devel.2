Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D9FCA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 12:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0ECA10E153;
	Tue,  6 Oct 2026 12:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="H2N9jvG/";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013038.outbound.protection.outlook.com [52.101.72.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27EC510E153
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 12:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wi5qS11g13ctl5l6Lbil26otggyuHEUGWULFETofYbVpH2a7Q/eoLa/bxSzQZibuzRqujUxFpPp7GO1laQi5p86Xh+nvuamBfDqdupj3wJVCRPlT0PbMfwXmmStryktVR09ito2nhcLk+cU9CVCNwz0FnM//HLG9Vdnc1H4vTJwKDJ9m+XdA6QUnj0ULFzWK8sB0hAdPMO0cDb6dNQMY3+bF9E0DgOPnEULZ3eXt2st9K8yXkJ/BQHDEFK/omwTRQ6nHA8wYtcwUsUXcdwjN7isfWe3PQmgbW1/dFUg3k6mgdpdkURinKSIz9yf2xkfVllnVlr5st5AMx/niOCANoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUoNcyigMJhUE2QXdy8PajZf0ZY59hMxOjb5tFrFllM=;
 b=pXY9qXa1Bopp/a+FLTwNGSF1g5Pz20OdhPHSBGnbRqQh94JCtgCHcKGqJx8O2UNxc/8w2Xx137l5hiUtNEAWqEySidA0sKG0dmaUDrrSKvpozgzjePBqxeWxlUfW9rdR3ArdMzWxX1PXJe/HMAsPUgApdXDiPcE2zYEFuE/KrP7M2PNCvcShMCLryFHXnvx7NcMszA3yIgLXIs/1f2YY3H6LSaZdF+ZEwuW7guKfR+zSRPrrWJj8q3wpisPh0lWTa8Lk8evnt1eUG5M119+3ZJQcF3CD9l8Hd2gqBHCnVc/MbVr4+8Cfg66KFypRl6k+xFj+zoByFBvzv2qqAoeQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUoNcyigMJhUE2QXdy8PajZf0ZY59hMxOjb5tFrFllM=;
 b=H2N9jvG/pmHDo4N6J8k2mI6HMmLncrPOZHYMPj5FnHwvmLL7lBf2WQsACLh6apq8zBobOflk5tGEpBRrA/BSJDYcpZ6CmvGPTkjWSeXnEY65QEI3foZDd6lfIGVt+ysPQsAl7cSVhPqxMCIQKdIGzVPe6AK20kw6eHK9eM5FjtNvv9P94Tcpke/Z7vIrQfgoJy8m/M1dsri17wbHxLAjwVOcE6tTYdngEFgzGgwTLRCIcd0klRRByluSAqOpSGBqAeU3WffoPPbB8opruSlnebvKpriE1gJBjnBVTgbKdgstK5w3wR5XTBRJ4mxGkcTepE3ubAvvY1rgjM8+8aRi9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by DU4PR04MB10742.eurprd04.prod.outlook.com
 (2603:10a6:10:58c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 12:23:09 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 12:23:09 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Ying Liu <victor.liu@nxp.com>, Frank Li <frank.li@oss.nxp.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Abel Vesa <abelvesa@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Subject: [PATCH v10 0/9] Add support for i.MX94 DCIF
Date: Tue,  6 Oct 2026 12:21:55 +0000
Message-ID: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260602-dcif-upstreaming-fb177f3c9351
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::11) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|DU4PR04MB10742:EE_
X-MS-Office365-Filtering-Correlation-Id: a23b7fed-9ec3-4df6-bdd7-08df23a494cd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|19092799006|366016|7416014|376014|18002099003|921020|6133799003|10067099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ZmALVgCUNAE2qGFl4yKsXR4q26YMaaG91JTnQAN/p9QsVQhnlksvZamhnNqLC/6SQLuP4KAubrkHD4NBQml94T4/Onqx5VaI9Qzz4AoAOaXy6CtfYwj+yy3Gow0Hqc/vvjLkKxjhyYLhx8YSMKVOACQWoxAne43Q/Nz3F3oqAB5xVLMcgDttf15m9roO4RLG6UxI/X3EBOpJsPLhEi1QtwpG2CGwLreivYsrAl86R7mMOerrL9W7xz4TFRwvBqhpgVHMfiO1ozZgy81Xz07VWfs75iqJ/BwliFj0CMUk6B5ed346ar00smet7pMmVGGb5sRwejrC/rrHFYBXNwhTZllcPIFm1wtnZ4pMtnwUkM0d/vDdeq2tTT1Tr7ZZ8eQMJ8gDA8LcOsrg9c37OspzZz9TGYe++Yc1GWhudd14c32Yu8CMzoRhDgmosBgjEdXcoFN5KM7jiUm28e/V5pMp/vPcczzspWivzENW6l1l8og1vrCW1KJoBjz6wqMfXruqn0yv/jdGyHCfDJewWYnKN4pwqfXdjxq9KC5+0RZmvSCFxzzy9eOZmqrQcBwpLuKXu8X4BykNiPwaH3MFoUWhBNBwF7/ezlOMymOvFTrh+bIGGBXqBNfXezbyZvca6/DR7eu5ohJy2ygL7+1mF4WJm/20aTBzDhN6PXwqJPv98hU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB12318.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(19092799006)(366016)(7416014)(376014)(18002099003)(921020)(6133799003)(10067099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEd1QVVrNEx5UU5PUElOZHdIT0QxcjNaMXR3cWxmWjlWRHUxblptek1wbWpM?=
 =?utf-8?B?Sk1UREVTd0ZMNDRVQ0tiTUZicnNwWnJLclpSUXZUUXo5R3JIK2F1Wi9iOCsv?=
 =?utf-8?B?R1BjTVFUd05WMWw1bE5ySHdpU1ZYcE4wT01zZitQdWlYQjRTWSt2M1NRNEFC?=
 =?utf-8?B?REFMbDdPdUt5RndtZUkzMWNzc0psVFNKZzFqazg4aDRiM1dCbnlkZzJqUlZ3?=
 =?utf-8?B?VjZvRkN5d2xLSUtibWd1bHVtRGx1OU1WeU4yajNrRnhYYWgvMkVhNlFCSFRC?=
 =?utf-8?B?WXN1UFpjRmRzTndhR0FPb1BYYWVrRUhmdVNsd1p5SFN0dmhJbi9Ja0FtMTdt?=
 =?utf-8?B?MGd6bEZxQmRaQTdGNnpXQlF1WkYwSGJqSS9Xd1NZdjFIWTRxSSswU2Z4UGQr?=
 =?utf-8?B?K1JXci85SW5kYndMeGJSaVRMT1RrbDVTMXY3VG9ocHhWSExBbmJKSmxQbFZC?=
 =?utf-8?B?cXdPYnpYeTBFQS9mVkY5STRqeXNhMk1kV0l4Mm1WS3I0Qmg4VFQ1Y1QwclFs?=
 =?utf-8?B?VWJ3dXl0enBlcmt4Sk4wS3VWQWtVNFhnRzhXVzFodVhyOHo0akdRUytLTUV1?=
 =?utf-8?B?SGFVb2VVWEI1UW4vbGRSclAzWUF2Z3pRTXZ1bnJ0aExrb2NNd2ZOOFptWnp1?=
 =?utf-8?B?WTJHMzk4bHVtRE05UHVBS1kvK1M5aktLQ2NHZnRPc1RINzRZdk8xb1RMSE5H?=
 =?utf-8?B?bVpmVWM0aHRXem0zejFqb1k2UGY3VzQyUHpPWkZRTGM5QkxRQVBzNlQ5ejFW?=
 =?utf-8?B?N2hRUnpld3JPa3MvejZ0UzQydU4xWEUybFNSUHJPSGlvcHQxRE53ejZnVEF1?=
 =?utf-8?B?b09yZEZmN1duR203bFBCcnpDQWo1VFNoOHRMb2o1UGlueWJLck1UdDVTMFZP?=
 =?utf-8?B?c2xQMTZPRlc2czFhcWNNNFphNWo3NU9qUW1oSlV3M2s3N3Z0a0pmTDc5ZDJN?=
 =?utf-8?B?WnlONDYybndWNHN4L1lsbkdONHJDMDJMMk5zQm1DY0diMW9yajIzMHRwL0Q1?=
 =?utf-8?B?WlAyc3BBV25lTkFIbGF4SGRIY1VOZnlwTlltNnErSWM2OGh3ck0xa24rNkxo?=
 =?utf-8?B?ajg5Z2JGYmZ4Ri9OQTZTYitxYVJaTWQ3QnlqL3RxcEpDQTdnWEhvM3BPb3Bk?=
 =?utf-8?B?UVBBdXlKTitpenlYQ1RDT2Q5eWhLTEc4RVBDRVNPK2tDYzJuUWNkZkI1WUxn?=
 =?utf-8?B?ekF5ZXBHYjQrd0NrY0MrWHp1T0xRdmNYRmFRNGZ6L1czeWUrUkdDUmYzeE1E?=
 =?utf-8?B?MERXVlJvZUlTQnNIaTNLOGs0eVkrekUvVjlUY2FsZGdoV3hKMTNPMjVQczEy?=
 =?utf-8?B?MmI0UVVFSVhJU2VTaEptRGxJTFJ3L2hJdml1NERuaGVWdlRmTHpybTB5NDNw?=
 =?utf-8?B?Qk1GNUNKcFhYZ0V3cng3L21obVA0ckpZSVFRME5NYThGMVRrZmNTRGNkYlha?=
 =?utf-8?B?SkxBV29QelMxZUNMck1WRmwvUXpSbnFyM2xkMEJ0Tll6aW5lcnhqSkFWWG5B?=
 =?utf-8?B?citvc0JmYWNUbnU0WnZSeTN2TTV5Vkp1TFozekdiMkpzZ0xTQ05MS1Vmd3Az?=
 =?utf-8?B?aUVzWENUMERsUFMzKzZzMUl4WFdXcXFmZGw1REtTM0RoaGF3b1FXcXZ4VDJs?=
 =?utf-8?B?TXF6TXFab0pGUEVpeXRadEhaVzhlME9ib2ZYdUtwUzVKam41MG92anI0c1NT?=
 =?utf-8?B?VnZYem05WlAxS24wU210S1JLVHI0eWsvODlubHdvMElObEpicmhkc2lZYlBJ?=
 =?utf-8?B?UG9TeUIyZzdoZTFLNmNiOXhDUlRzbzNaWlRFcWFwR0NhRGJEV01rL3JQQ2RY?=
 =?utf-8?B?bzlmODZhOXJXQWYzSjNVeVdDVmNTSkVTZEdoUUhYcTNsWXJ3WFRCc3U1N3M0?=
 =?utf-8?B?TEJZcHhBRC9wa0NxalhySXBzQjNLVjdvWmltcVdvZ0hNVkdhQyt2eGR6RTYr?=
 =?utf-8?B?eWJRMTZrRnNBVDU4ZTBCRXZydlJ4blJpb1hQMkM5RmNyRHdwdDNicTlpZGhx?=
 =?utf-8?B?K0hIN1BRc2U4Yk52bE4vYW1JUlg0c3FvZUFpcGxvM2cvbk9vNlhoR0dzVVp1?=
 =?utf-8?B?S2VPU2QxY1hMcUt1dUtDdWhQdEtCbThrSkExbGpOTDVMMnF5RG9CSm1YdkpB?=
 =?utf-8?B?UDZSVGQremVtTmRBUGtzNllYdy90KzhaLzQySnU0aW0vMllUTmwzajhESDZF?=
 =?utf-8?B?U2p3TThnYm5RMGtmZTV0djFJbEo1UmZadzgvSm1Ld0xzWG5xSHNGTGZvTFZY?=
 =?utf-8?B?dGgraEpkbUVOQVNSekQ3bDlCUmxvUEtWYjhWZGNsMnFmWjl3UmlkYTJQWFZT?=
 =?utf-8?B?VGZqUzlHdldKQm1RNHlZU3plVDBSeE0ydlkxK0V4bmxEYzZSZi9NZHlxRTk1?=
 =?utf-8?Q?B4ZqmOrNKomj4Cgo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a23b7fed-9ec3-4df6-bdd7-08df23a494cd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:23:09.1476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyAcOXh/3QAK0j/44S+TgSlejVch3ESHQvfmmunKKqWJrag3SBjT+BHoaQLLib/JRhOaHqGdjHHyN9HyrQ3SIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10742
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
Changes in v10:
- Rebased to latest linux-next (next-20261005);
- 1/9: No functional change;
- 2/9: Switch to using of_drm_get_bridge_by_endpoint() helper for
  fetching the next bridge;
- 3/9: No functional change;
- 4/9: No functional change;
- 5/9: Fixed a pixel-clock unit mismatch bug, ROI now derived from mode
  at program time, CRC reprogrammed on ROI/source change, bus-format
  validated with a whitelist, forced modeset on CRTC activation
  (dcif_atomic_check), vblank event flushed on disable to avoid hangs,
  dropped PREMULTI blend support since PREMULTI is not mandatory anymore
  and the display controller does not support it, probe error paths
  checked, shared dcif_set_csc()/dcif_plane_disable_layer() helpers
  introduced;
- 6/9: restructured to reuse the existing conditional schema pattern for
  the new nxp,imx94-lvds-csr compatible, instead of unconditional
  properties. Dropped Krzysztof r-b tag as it needs reviewed;
- 7/9: No functional change (context shift);
- 8/9: regulator nodes relocated/renamed (reg_1v8_ext/reg_3v3_ext ->
  reg_1p8v_ext/reg_3p3v_ext) to match existing naming convention;
- 9/9: No functional change (context shift);
- Link to v9: https://patch.msgid.link/20260612-dcif-upstreaming-v9-0-8d0ff89aa3c5@oss.nxp.com

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

 .../bindings/clock/nxp,imx95-blk-ctl.yaml          |  24 +-
 .../bindings/display/bridge/fsl,ldb.yaml           |   2 +
 .../bindings/display/imx/nxp,imx94-dcif.yaml       |  90 +++
 MAINTAINERS                                        |   9 +
 arch/arm64/boot/dts/freescale/imx94.dtsi           |  82 +++
 arch/arm64/boot/dts/freescale/imx943-evk.dts       |  86 +++
 drivers/gpu/drm/bridge/fsl-ldb.c                   |  38 +-
 drivers/gpu/drm/imx/Kconfig                        |   1 +
 drivers/gpu/drm/imx/Makefile                       |   1 +
 drivers/gpu/drm/imx/dcif/Kconfig                   |  16 +
 drivers/gpu/drm/imx/dcif/Makefile                  |   5 +
 drivers/gpu/drm/imx/dcif/dcif-crc.c                | 221 ++++++
 drivers/gpu/drm/imx/dcif/dcif-crc.h                |  54 ++
 drivers/gpu/drm/imx/dcif/dcif-crtc.c               | 763 +++++++++++++++++++++
 drivers/gpu/drm/imx/dcif/dcif-drv.c                | 238 +++++++
 drivers/gpu/drm/imx/dcif/dcif-drv.h                |  91 +++
 drivers/gpu/drm/imx/dcif/dcif-kms.c                | 115 ++++
 drivers/gpu/drm/imx/dcif/dcif-plane.c              | 300 ++++++++
 drivers/gpu/drm/imx/dcif/dcif-reg.h                | 267 +++++++
 19 files changed, 2390 insertions(+), 13 deletions(-)
---
base-commit: 15551282e82db772bfc862f96a8abf14a60f4ea5
change-id: 20260602-dcif-upstreaming-fb177f3c9351

Best regards,
--  
Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
