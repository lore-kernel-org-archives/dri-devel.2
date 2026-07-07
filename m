Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E2BC44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B131B10F40E;
	Thu,  9 Jul 2026 07:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="EN2SJbhL";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011012.outbound.protection.outlook.com
 [40.107.130.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD69D10E45E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:02:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxrGfA18fAygmQkL0rsya9mpgtxKpvv/4ziDzJZ7H4Q4NNaP3NXCupr05STxQzCoWYH7R5YOe+MVRWzNvrV/WQdHYGGidsrccbcGbLb4JQdw+VifdqLnLz4ez+LeBJT5SYCeRHZ5dEhA8o4HxpjNPhLtqdXZFZJ6sig6L4d5jM6l2Aqtux0Z1pB5viFb1jMVGjlteHOxQroa1KxW4QSGteZtilG5YhvHvTB6r906Nrhr4otDMkVc+c0w1LB/DruKv+1OTvIwGrJ05V6BD09uCTsgaYxgpHsPK00PJQzwxTynzGRAHgzkLgEYkA6Lta66BA+jVDHYDrO2eyNOfW8tpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCRrq9bttojL928ghLDPKaSCPJ5MP7s1D0gFMPA7Nl0=;
 b=FVhPyWcfezHt/m/o9tZ6i6rH6Dx9bbjfiQbB7+dqwFpiu81cTPhkdVQbAJkhKmfged8uOs9KTgrEJZ+Ze0G1g8Y+KipuZBbhdr/o9dPNIdKS588lpaN93FVKaXj2qUACflsHrzXAE82AMZH9IdmEXu4um/pDuOTfiCxxqWD4pEoFKqeQ0U/16K1Qyw5FjZwgRl/kZ3nMZ0tkq9ku93DI0mt17bjEjqgVnknh0a1bSeH+pN+9QP2FNS3lHx/8pW8WWrqKl3fvUpsTRq7FadDODEYd//7Tvd9MRcBocQ3iyeYHS8yIknZYvrnDisyJNMGe1k24Rs4BhlG+TPnGftxl+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCRrq9bttojL928ghLDPKaSCPJ5MP7s1D0gFMPA7Nl0=;
 b=EN2SJbhLgeo6g6O1+2Juq/4e3bHaZmx2PktX0yifdH8BmkTJcPXZUwZcINRtig07SBMMYQNl+vAPH9yGxYmXn0Orea6Jl9JtuBnssWrHIFFWv0/joqULD4WMnd/yueeGWLrhvNXLduz8p/UtO96CS4ZeaF8WVAZPmRtZANnt0kQ8kOh0VePWw+gXeoV5rwBdacCEHzhA7uZdQt8JxDdb63zFqh7CutTGG5oIWa/t0b85px1EPe6kaYEsfSdTLYS0joLgeTE8hP+PuMaHkLwulDB65CHFxglwrqGtUy0sKW5qECGkn0WE2yHaQgmJtulgOvNMklAjgIJpCTXUhV4VIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by PA6PR03MB10450.eurprd03.prod.outlook.com (2603:10a6:102:3d4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 07:02:51 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:02:50 +0000
From: Wojciech Dubowik <wojciech.dubowik@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] drm/bridge: ti-sn65dsi83: Add reverse lvds lanes DT
 property
Date: Tue,  7 Jul 2026 09:02:41 +0200
Message-ID: <20260707070244.230546-1-wojciech.dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0053.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::11) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|PA6PR03MB10450:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fcd37e-e3a3-477a-8e9a-08dedbf5c1e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|19092799006|366016|376014|7416014|23010399003|1800799024|38350700014|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: nVPsR66JqSGM5NY/O6i+BE7R7PxZ+eK3CbV/zsfIMfFesu8WaMESVW/SdLOgcrrkzBbyvRRNCHqzb5CJDD/JdWtHCsyZBdXLg/B8PfQGXixKW/HAWhzaYCTHl64o8nylucHCJex81sNq6uwf+ga/LL2Gm1+2NWdb1Oa/i9XP9nL7utoZth7iYS1QrgDuQsns4MgCu9Y1KNwLngFtgVboEEaCtuFHsySYhQsWahizdCxvdUWR1Sy+wM+RrSzV8I6IBrLBPtrX5/7ooh3+k4s9lonPK6coPMkS+belJA9tyUu71WG2utCNU6EtXaxSMdd8xeC4I/voCBFLyEuPdfxgQu2c/sBYCGCOVb+0+Svlg8eIsupTZi5K2o/sVOVFeB7OqZeeFrwWxmE+VbvCucYwFWlTD7eW7g4s10YhX0/shGLqnL4giELUdl7bRr6GLToJzrijitGPbIkAC/6SWcwzYmP8J1ruOyfr+lKZcB1PcprCyx9pGwOXwNG2kI7S/KOThTe06UIn5YpAdCPUk7ZrBzdD9w3IUwQdBEjuyllAjyZocSAVrbRHqcE0jVbAQSPhRQNmre1ffkx/auUheV3CZrAo8OnLdNeSFfFT7Ztl5IxU6Xvw0JFrJhVqzDu9/xQxY9Aylu5TocAUpIb/6gppT/XcoLsR3mpe3Kcr3rUpb2e1vXuj9KXGgbsXs+GaNz0EZYm6ioPwsMecOsqN88F+9GMgiB46Q8G3C+GYX0cuKfQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(19092799006)(366016)(376014)(7416014)(23010399003)(1800799024)(38350700014)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8977efnWZSUx+OgPdsnfEFfJPGbFGC4L47mFDfNVRvBvLzlGCZyBtxaAn1Gu?=
 =?us-ascii?Q?I0gLq7UWRb/uHN894bR6pvpQ6wfQf759bZtW18FSBm/CaoT0JxfIp42TmfmZ?=
 =?us-ascii?Q?U5Em477geKAcBmyEZ3uaUZpFQIUq2G7qiiGL04g3bok8hu7Ce0cMRugfzpBq?=
 =?us-ascii?Q?74UtdAbM0AYp1Sy4oDoebDY4Xuw2ZsUPSdHyzB7T87gQl4iWy2m6dyvikBiY?=
 =?us-ascii?Q?lJsn6MkwpcQcG3/D8FhWsC7x2gSVw+GL1IHWPs+HCLQjDTlEq86MFyD6W5kE?=
 =?us-ascii?Q?cMijTuvd1a7y/67oa3oWy6XVdnBj75wV0Y5DtrOfXDZNOuLangtF0ihnzMY5?=
 =?us-ascii?Q?61G/a0e3QV4A3Nof2s+G4fNyI0TZN49CiXz5TvnFTwD4qk78veMWMEtvVvjA?=
 =?us-ascii?Q?c5qmUOLofpy32a1TPDp0j0kLbOc1ZLbiiWstZCqhOUFaapfZnto1JnCN1Flk?=
 =?us-ascii?Q?tHjSOJdenRRkNo53C3md7kX3uGu4w5fodVEiiplrqpT7mBGiV9TPmzZU9e4j?=
 =?us-ascii?Q?IbNT7Wa/Q5LpOSKsQZ7BFDiivSGr4fqHW4nRARcu/TtxJbYWVeXqEu16T3J8?=
 =?us-ascii?Q?bagHTs2Lch8xrT2DuANmF8guEzVMR79C3vq+pjntNq1Spzy/wcutzpPOGhDy?=
 =?us-ascii?Q?bKo/VRn26dc11JudZ2w8ITGtjyMpIZlthqadzIsdEjiaEQLszAhPWbLXvg2+?=
 =?us-ascii?Q?iqm0JwH0vvlHf4m9epFMJ8jkLEAQZvVunU1vt90RifazX4URQQ/tix9e4hMW?=
 =?us-ascii?Q?cc8CoNUYlrIBTOfxyrbMW5OnKbPBkuuZYcBNy2bczw8SccbIrwH5x+Hvv52O?=
 =?us-ascii?Q?UW25syB6HLGvkAtne+Bg1uo+wJ8cCRywp+1LzFthWN37+wu7mnUvp+lse63d?=
 =?us-ascii?Q?k6KaQs8YuhOFWR0TJxu7bhoI9BHVQwSutdKuM9KCup17kdPHuN+zLk8yLZuj?=
 =?us-ascii?Q?QAl/B/nt8/otNtr3d7AqXA8vSNcypZWbT/AH1Qn8IC+NpFqlPHLWSr/Sdim+?=
 =?us-ascii?Q?Jk0FvEZCWPRFgDNYm6da9URjzGj8Tqx+z4Zjob4w9rEpX6qmypNGu9C00ETQ?=
 =?us-ascii?Q?RHyRh0tJihIyE02QRJJc7O7qcQ3EYiDHGnGqJsK/ztzvF/ODZ31stEte+g59?=
 =?us-ascii?Q?P/icwZmC1sU5vPfIyz7OfTb40aoyZX3pxEvFJ6H4RK2TZ+CAuHUD01onCLJ+?=
 =?us-ascii?Q?GqO4ONCHuDQrHZ08gv6lVUvkOXiPo+Xv4qwNkOYp2AjSIPtzbBCyLk/qBOsI?=
 =?us-ascii?Q?ioGSD2o36LDAbqDIqJOU6vY4hniyJVK4VSrWlpfOJr3wZeta414jm1yrZY86?=
 =?us-ascii?Q?RNKcbvB1v7P79RSNRMejc/5ztsjU4Kq16goa14ozibLCtkjLO2lA5U3InCHB?=
 =?us-ascii?Q?LKe5ByOJ36ogo9THUaJV8cMns/VbJHn4Bd7SpY6+lveUAJdwHFKtASz7GkEG?=
 =?us-ascii?Q?TX/F8EmGyAFNaZLPxKdAuDWZygi3QvUj9XGLl1FczdNbOlAeNWDxWJ1dEDPJ?=
 =?us-ascii?Q?9o3UuR9jSKWLq9nq6JttjOBrqRYM6/mSKxUCF3FCyKWe503Ow0KAPc5GpiZs?=
 =?us-ascii?Q?05udQZ4yiL1fgDwwENgejhYAd7YSps2SPgC+f8R3GZuSJ/9RBAHfoQzM9yz+?=
 =?us-ascii?Q?54LG4cnFNtfpX9GzmpJ/NkzMbHyrwiVheAjnKqevSQ34StdGCe5H2tsTXdAo?=
 =?us-ascii?Q?5LR5fr6vLT7ZxULCzXAFOwgDdK0ZqcU3HLOzoDftZuZ/rKc1BVIS2LEz11Vf?=
 =?us-ascii?Q?GnbethOBNw=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fcd37e-e3a3-477a-8e9a-08dedbf5c1e4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:02:50.2307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tOU4tT+fDtUsF0We1tX6yDdMDiAXlEIbC0Tj0pTKInYWG41nY18Zg98+KQ1bh8Ol0yAuu39xwFdWQBoPsMw7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR03MB10450
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

Add lvds reverse lanes device tree property. When set, the
endpoint lvds data lanes are configured in <4 3 2 1>
order instead of default <1 2 3 4>. This is needed for layouts
where lanes have been swapped.

Wojciech Dubowik (2):
  dt-bindings: display: sn65dsi83: Add reverse lanes property
  drm/bridge: ti-sn65dsi83: Add reverse lvds lanes property

 .../devicetree/bindings/display/bridge/ti,sn65dsi83.yaml  | 4 ++++
 drivers/gpu/drm/bridge/ti-sn65dsi83.c                     | 8 ++++++++
 2 files changed, 12 insertions(+)

-- 
2.47.3

