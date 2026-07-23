Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F351DC531CF
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:26:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA1810E0C2;
	Thu, 23 Jul 2026 13:26:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="eaqIVKZi";
	dkim-atps=neutral
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11012015.outbound.protection.outlook.com [40.107.75.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD51A10E594
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 13:17:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccpPr0yHiwgkiU3v0kwzdpV/ibOsrdunwnl/bAFVNS3UkXagfosPCEiPP3DJYvNk5z3UEpLO+Di37cbGXC289pzo2Ug05wQk657FDNwzZ3ZMIVn5bs1t3QSIAVrLFFHenKQfmyLp36joBVNHiuNQQeu7Ha4RrfiQxmdT+SB/2p9iQy/Scf5kFPK3OLioM9w+GFyglGSO/9ifc/AkQIHtYETdXw4PV7iG1W1LPZJqaBt6X9N+497AG8D+V2Gqn9axN+mPf1I1Utx1COMlXIxtrVYktaYWvPGmBrGU7QmBau0CsY9Du1/GZfclLV0tgAszdFdENl+j43lMqqBqUSynpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1NAlZ5+vISef4GWqYUPyUrI300sOQxCUhdpVfPfdZw=;
 b=jRsQiQqBQCH5veavzZWNjKbqj2AkTAzgWeK9xUp5z3Ju+r02iHdfb6ShkRaERCK6HSJq8L6j17/fIuHww2Aks5bwqulBEk6G7QPIxIU0NUdshK4n4Y8MZW8Pd5ApJNitlvPn3PVGtnU9e4PBmzxgy5DklVWxM8fVKoWk+7323ibYCosto6Q2aRluiBPRQl8q/ZWgFG2f/7562wXa2Qgexy6oVfQETWcLGTxiVecWn1Mt7imGaJadCNFEx1p9uzO5GGbpV0K9PZ4yJUzxqjjiKgUQteYJYkQrgZM8t1wAy+kQxisvvVCq63Y8lX9Lqg5K2jNxR0koxhw54kqBGQevfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1NAlZ5+vISef4GWqYUPyUrI300sOQxCUhdpVfPfdZw=;
 b=eaqIVKZitR3IFI/htFuf+cJi7Oxmo7AftzsdxID0dra1vUkaj5E1oW6CUto9c+ydVZz87Q148EedtKG56WO5Dlc+yCd4lKHiawgG+sgva6BSODx4LsHn0Gw01bv/OqjTg25aRCfqg1UjyKSVaHgxX17OZAIj1D3bbcp3uM2dG8ge5V4+EkAb/hRSim5MWU+A80p39vv0c9UxDRmomEXMqjMXnTQ0Xe1Luhd51d9JnWElNRhvIFJLMJhGw1HbhU0acaVNQTtOSHFfHtUfEccbiznAv+stocE4r3zedXJwe4jBB/rZTzMV8tYfE7aDnULhhvIWrBeASyoosJEOrGMPSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8724.apcprd06.prod.outlook.com (2603:1096:d10:91::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 13:17:02 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:17:02 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Inki Dae <inki.dae@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Douglas Anderson <dianders@chromium.org>,
 Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Harikrishna Shenoy <h-shenoy@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Kees Cook <kees@kernel.org>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 00/10] drm/bridge: Remove redundant error messages on IRQ
 request failure
Date: Thu, 23 Jul 2026 21:16:32 +0800
Message-Id: <20260723131649.134127-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0084.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KUYPR06MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0245ff-9fe6-4eea-18f2-08dee8bcaec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|38350700014|921020|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: JhtJgdy8LqbyMuO8NHkVX3glrNgw9mMAErDl8CJPFvY5VwFJX/JPlLvkurBHKNJ6yUPWx3Slsh9/0zqBcbfaG0yz3UyxlT7XjlD9IJHs93Xq9efil9/TcyZDEiLoRq5d0U5X2FKq82J16Ll1vYS+0XWFSG3iVLSaDem2Af7AWC6B4tuyZ1/wKkR9ZpTlg+qKosSl2fNmMdg5Efu6timiAtwc4iYaoEK9bjQQmHr9QoaG7f1wvzYKSE24It7E3Pp7POC/PrWilhwRKVG1ZaSFAHVBi3K5MHpfI371KuKwoWWf7bG2Pr/NeB/tW2V3eDy0XgA36xvNsyN5xlGxo1AR0EaXurX4V7RKQccgfyvHRdOVwx0/a7XmpUjHz1TmucPeHleHPTZ/vDiN8Af/H1w3a+PQZuah0pf4eJBJtIdrn/bayxFpi7TvzECVScBNbsNY52pxNvioWtuSEFMcP2fDt6JXy1fMKo+arjnvLYI48XHxXHUq5QkPTZ8ItDeUvx4oh280MMfIjrm2RDnOftKxsFzioJ57A0hPtx2wau2c6WBrDCvC1qjdryB9Jr+iQuk4EivHF2rXDURjw4PtwuKucoSEmuxOHijmmYGqyVoa8Ibc7MNcMAQ6XPo6YYdnATMkJPXBGFzLQusMBo+UwEArL2WnRg7a2hjwEmpIRpa0/cif56EnRhRFlBfXtlqR7RTIBU7u55vQJtTzU7tHtzZzSk6rgBUgQACCW1PwDBARUyVck9LZXDvAhWwc8vLgOYuT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X5xeWkLBtssWQjBsd94B38qsSs2/mw3eC7vko+xkiKMcDz3/Cay+IgAmFWzB?=
 =?us-ascii?Q?qXa+d4CdNkTzibIA67H1DPtuTk1/TagF7AbKKjUQqzFAa5GSbKHqFgzdLiFL?=
 =?us-ascii?Q?JRlqA5YRKRqcRPqu87rX5KhtA+xfJYk2AgKCdze2yDJZOBCCbl0IoGvQjpc2?=
 =?us-ascii?Q?GjfzMOksW1tMKBzcsYx++BIc7On1Hu9z6mtpbp4YNG4F92nkkMNOgxJ4fVxn?=
 =?us-ascii?Q?KLrYhyHKfyFf4/nJz9r+bLvr5eC+nbFbkN6iDmZAwup5C9QWCgAqqYhrIPON?=
 =?us-ascii?Q?kwcFiVcFG8Uih+0T3EzHf1BQf5cHUh1y0GJZ/SIWAVQDyIx/aqTzydQb30CP?=
 =?us-ascii?Q?TZqzIcd+UlwWEV1+upisXceyu/iRI8q7lav55Mdd1KF1lwsUzQliEOHaDogR?=
 =?us-ascii?Q?ghaUo4uMXgJes6A5KRtLh+8kZBKWFgqIsddy6PjvHAFpPmwn2NEDnZToZ9N8?=
 =?us-ascii?Q?zpog5HOgSd9hDE9meU7vLgHv8Umxk+dyC/G4os1AZZ9LN8+xv+KN/+LzQOQv?=
 =?us-ascii?Q?GtLVvWDhn836+V0tivY69ob0ldlIRfL9BqjMmx4pIjhN0VlndibdtpkaAx0e?=
 =?us-ascii?Q?8XnXVTShuYrfgnF/i1N2OTvl96hMvRJ5/ZyLe3JEH/FqAeV+7sjedECQM/ZR?=
 =?us-ascii?Q?i7NlgUlCNIUv5zLsZi0SmULZul8dukMB4HoY6VJNevPi4MpzzU+BstYJz8Ms?=
 =?us-ascii?Q?wDOoYeO/GP8EWgee9Wru5YezTOohP+3CO5eWdGfTSJs5a7Hg+Uew7SuRCIQU?=
 =?us-ascii?Q?cllJvIl8WliRwhTslOme5jmdGk3SYZcwZKQv5/6C7aHnajvaxg8zA403ddBf?=
 =?us-ascii?Q?/81FQXgTmwiyYZd/C2uDatIGVDKUw504IOB5k7dM+gjzmQk85gw5TbiRKwdv?=
 =?us-ascii?Q?6F5JV/GRhcTMCtT2wWVSZNN3c7zh2fjbKWMI3PUTGOKj6eXThgMrcdHTnlhY?=
 =?us-ascii?Q?9Vx1ylLSpZqSb07/SvH5g3CtW1/FFm0i7hUcTgw6LdVNQMUTnzZSdKLDUynO?=
 =?us-ascii?Q?/cP/kXZWzgTm2i6zN/DJNr+dZ4WVGbYO2GWumpqkAT35h/OoWtWEXlsaixoI?=
 =?us-ascii?Q?mY+eLrMp9rlvw9UKTG5zWcNHycfwM/6e7J3vQK/lh8QsRWSWkbExUUw7BHwW?=
 =?us-ascii?Q?sHkrwBbRXn/XomOHPyZAXFQKADjVC5uwGH2hJ0FyAhd502nCznZIeil3rhER?=
 =?us-ascii?Q?XCDz3djcXnQ2f7Rj2lOekQ29QYDsJwzGrmbrVld+iwVf/jmr4MWU1J8YMU8C?=
 =?us-ascii?Q?gyYVYR/dUzvgFaMysUEdzBK+8B/eRFZlf8QbBw0sW4PzNWTa1/O13UnhIpCz?=
 =?us-ascii?Q?/QCQ4k84Q20ocC+WqUeT7ooLhXWneGvxxXJSI1aReXIByVYl1/P99eDufaid?=
 =?us-ascii?Q?BGPrAEs5/cVvJ8ZG2hOpLJ7QEZIy2mPLgn9kvKYjS2FQwfyl2aHALrk1Qglj?=
 =?us-ascii?Q?HcLRqsHG+eczQAgK5jO5EA/j2KLDs6aQr604PBe3t6q16jwBOfZjBq+r8XHt?=
 =?us-ascii?Q?dJzICGGW+109JT4JaUb2s4VtRk18yz0lQSJjdD0SBJLZZGC94EYajXo8LwyO?=
 =?us-ascii?Q?Dvc4OfGFHjqZsRqYED9oyL7xoU6gqSfAsixjraNon/PJbvLxjAZB05uF1BgA?=
 =?us-ascii?Q?gb9CXvCJSYernWRYLu4sJ3uZ/nRMNp3pqk1Z7xMC6pQZqLeOXKF0fMZevu0P?=
 =?us-ascii?Q?8FDSls6Bu1CTMVsbzV/OQ9ktcrmIznOsRt1MNQZniPJYbY9CihdGiTsz3uBc?=
 =?us-ascii?Q?XIzB6286VA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0245ff-9fe6-4eea-18f2-08dee8bcaec1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:17:01.9353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEg8aHJrL9fpQga+QHPoB9zRMXyLZ9g+/lD2uCe6q8+suNWEfMSAT9JLDowEWFRriuMyFQ8uu06kJXPjJb/HEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8724
X-Mailman-Approved-At: Thu, 23 Jul 2026 13:26:48 +0000
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

Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()") added automatic error logging to
devm_request_threaded_irq() and devm_request_any_context_irq()
via the new devm_request_result() helper, which prints device
name, IRQ number, handler functions, and error code on failure.

Since devm_request_irq() is a static inline wrapper around
devm_request_threaded_irq(), it also benefits from this
automatic logging.

Remove the now-redundant dev_err() and dev_err_probe() calls
in drm/bridge drivers that follow these devm_request_*_irq()
functions, as the core now provides more detailed diagnostic
information on failure.

Pan Chuang (10):
  drm/bridge: analogix_dp: Remove redundant dev_err()
  drm/bridge: cdns-mhdp8546: Remove redundant dev_err()
  drm/bridge: lt9611: Remove redundant dev_err()
  drm/bridge: samsung-dsim: Remove redundant dev_err()
  drm/bridge: synopsys: dw-dp: Remove redundant dev_err_probe()
  drm/bridge: tc358767: Remove redundant dev_err()
  drm/bridge: it6505: Remove redundant dev_err()
  drm/bridge/sii8620: Remove redundant dev_err_probe()
  drm/bridge: ti-sn65dsi83: Remove redundant dev_err_probe()
  drm/bridge: ti-sn65dsi86: Remove redundant dev_err_probe()

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c  | 4 +---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 1 -
 drivers/gpu/drm/bridge/ite-it6505.c                 | 4 +---
 drivers/gpu/drm/bridge/lontium-lt9611.c             | 4 +---
 drivers/gpu/drm/bridge/samsung-dsim.c               | 4 +---
 drivers/gpu/drm/bridge/sil-sii8620.c                | 3 +--
 drivers/gpu/drm/bridge/synopsys/dw-dp.c             | 4 +---
 drivers/gpu/drm/bridge/tc358767.c                   | 4 +---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c               | 2 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c               | 2 +-
 10 files changed, 9 insertions(+), 23 deletions(-)

-- 
2.34.1

