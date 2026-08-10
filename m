Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2205BC5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4990210E842;
	Mon, 10 Aug 2026 13:13:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="SHTZ9qMJ";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013066.outbound.protection.outlook.com [52.101.72.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F082A10E841;
 Mon, 10 Aug 2026 13:13:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HALKK7xz8BwPROg7hbXtr8ji10Dvjr+lu6vgtr2fJH5w5IzWiY0VJMq6SXpVDELEHDvRhUlb4XKox7X1owgx1AoeVJxAMTdKkRqExrOMGsanbTEoR5FICamSjhO44xv+8Z+tnQyfgRcfPqfugHHUIfq9SS4zauIlbaqiLYg10Atg9yNZGuO/+z++JO2MXBcufBFZAiPmSoZrbqvA0AqW+4+nLkQwKGzJB8OU4sQsh1Tq8R1QTphQGCoG7qLLi4rTXVUs0CCq9IFdn1EI3OAHcm6KNmrfTPqUjxQutx/dWTF/Jsd/0jHdOwCmE6fmHkagwCr/eeWVXOmD7h2YH6+AmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1I/R59UZgQuWT3LTtNWpTsNucBwE+iulXvB0Z1AcGAs=;
 b=RxliRILQGidaoxHlCUvgE3plyZ3x7pFA7ZYYm10yhOf1SdwXMbd6roL0iVn3NQONdGzI6jFuq7LTyEEnIj5VkIw61tHqG4XR6g+8bOietN0Z714Xrq3vceLUnRwuIvzFfhqYJvNKZGIdNO7b+fula1kOTK24uuFLfrZLUW/iRYVTb7RoAnf9v+fhCA5OWPOwzACf/i8Ng5RhXIS0XJ9LuaZDrByS4w4I+Cl3urdB73hp1+L00AvwX06lNPs2/zm50uQ0lo1QCOwr0FhlfWrrRUHQc1bQt9w7KcEBpvXOmy1grDO37cveFZamDtn0VNNDcfercl9ayxUScKVqx6iYPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1I/R59UZgQuWT3LTtNWpTsNucBwE+iulXvB0Z1AcGAs=;
 b=SHTZ9qMJRfqW8baOUgeykyGePvJIBn5WBADE41DFojsbXqk2fOnusYM1s4qRx8d28ZOzFmVA57V/IQWwB399ilkpr+SVehqYr8Oo4RPvkr7F+QtAAjkVMYBIP1sh+fahN99wIvuIKhmIgNLePbEqUqQANW+ru8Rbl0YV3+8aJsn+hy3TJaQlwj2GOiDVItwRgsYSAFDh4gRGVrolM6k//aVxJgQjV/Qu8xjPFHpfHEmHWGm6h8VL2977yAp0ALbKqR6PSZZQZnEYvmgxELlhRFB/ONZFsRjhDYvB+bBmhpFqPzrNW7t6mxqbu2hVpQBQeteldfYy7rNznuQu+T0yqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AM7PR04MB6773.eurprd04.prod.outlook.com (2603:10a6:20b:dc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:13:17 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:13:17 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 0/2] DRM prerequisites for PHY consumer/provider split
Date: Mon, 10 Aug 2026 16:13:12 +0300
Message-Id: <20260810131314.452865-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0347.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::15) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AM7PR04MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: b42f9746-b15b-4c53-28e2-08def6e1244b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|23010399003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 45zwpuPW8KbqF7ZdQ6ZahDLWqyvHMGovOwIMW35+0Mu01I3KOe/+cD0yiuDS6zdzSkamxD6Sxs3yrDopoAk7ACgEW1J90/uW8ije8vgfRKVtLvMvVCyZ+fukNUFEOvAwrqTjEl3UHGmHvQnQXnsaEnCEqAvO/4cXAXYwBFSd+sencCQ1cHuJ+gjbCgF5uGipPobltDY9Bil5fACbIhPUOsQwQwEw70gDPTCmcKdQAeEDqhxm50x82wCcGOjpLYaj1Yc2cmYNCKZveKLwRNZvy+C4gorZvX/KKqi8vE6/3CPIWa3je/f/Fd5Nz8LW7fqpDnwQnLU/SSenSBQFWD3zRuR9eNq46kfaAhYpszfoVPnlkILvhoHHwtXnr1Z+2zK2rJkvFz6IygIkhTAuWYntGv7pmh0cM01Yql8KJhtAGBnFeu8k8/XgJ9CFbVhoVpAfN6mIDnxmlPD+Olyyvt0l6ZkoDENrXVf6NFVkUdcHyfG0MjX+wL3pS2bO/SWGRHsO+r0YV3MQchKpT5aQW732qQrLGxsodpbObsMXmDXPzu6LPXVY2oS82MSEY5Qx+Vwe+bBA4O2O+lmPc95VKqJm0YUbWEHzJr73lrHvji//WCIMw1z/ymtflmEJfMucllVUFSiXA1dvYaxJDPOK/HR8qMQsbcOML+anbSgyRH7maD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(23010399003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VA0AWxNDnKdSTPQo9I3C06A6/ohXEKKT6pN/uapy8qgjLfm8gE+TfGCde2KS?=
 =?us-ascii?Q?kvabUD3wS2SZx5CsT37FxgmYEO+iRH/lKJs/VyKAuEGIqniCYjETsI9iZd6O?=
 =?us-ascii?Q?usTXZfocnLn8gBWDsXEReQ6O3Ij+UFuCiawYe9oPc92WlDTyYiJup0UZSwau?=
 =?us-ascii?Q?RHPJXvKPHf3OggjWTytOO3wRbiWoRbRjJ3/g4oTp/3mSHCXJvcy6a1udRApT?=
 =?us-ascii?Q?U/oGPZmA49Sa0d8R5Up7hRP5JQaV2X0vPASMLJ+yeftrBACprOCf8AanI2WF?=
 =?us-ascii?Q?p/IOdjWSf5HQgGb30zrM6L88CAWVezvwJrZ1VagvRjjCFX0+5OjOUOXpiREA?=
 =?us-ascii?Q?bJP9SZOW1SADj7bBZd1HkdhqxYmBjWgf4bhQ5k3letx7Dy8ndruAcADF/l1u?=
 =?us-ascii?Q?gN5U1EMR6JGntsBw/mclTzfbdyMn+JUbXqhZ+1hoabvNmQnQZAev71r36GpW?=
 =?us-ascii?Q?OLI0Bc6eeqb7FxJFx6/TeVXbhQ6lzYV0hj2suagNyOGVm+mEH9K1GEF2TdhP?=
 =?us-ascii?Q?YuxWo3PXHVNXL+UE/RAeec9drk8mrmUPAfnnjxDCf1duCHzY6Zmi991iE5Bj?=
 =?us-ascii?Q?JUh+Er52NbsgEXIT7jWGcUy5d/QdhnFuXrDwtO1eHi4/bOaDpK/zuZsjf2Aw?=
 =?us-ascii?Q?Cgb6QPfkTfNC5lUclXeMNB3aK2P3J7gUzj0qtIiJFs40bk7xMXIt7ZR2D5RP?=
 =?us-ascii?Q?QbJUp995FV0eeSu/ipiRE1cQIJRI2jK2eim//jmTM/F3BP73xgXiEWaZWS5D?=
 =?us-ascii?Q?dEkMgnj1sGE5zbUw0HvPHkeKZJejD2fzVhLDdLQVDmYnpdgPRvRnxXjI1b9K?=
 =?us-ascii?Q?EF3ilH8/oosxFcN/d0VeQg+5rdERR5cGnST6iWZr4389HQlVIGATDNIyCLaL?=
 =?us-ascii?Q?9yLM+LAnfesZlm+0vKhTjmF6Y3yG2tpgFcjN9mUgUrdpryCOB7Kf4wOy9iw3?=
 =?us-ascii?Q?TCixgsDZ6sIJ799cURY8VnCDPyG95FRMWfb1HREskTl4RFsIw6zXx181nEVJ?=
 =?us-ascii?Q?EaNIU+ilSoMD6ev6DJZMEvqFlPM2X2CV1jaWKiRAKm2jxI4+T6PQNYpYX275?=
 =?us-ascii?Q?UMnsLo5uwWai18vfH6G2GgtS+7KIZMsXPMMxkfoJfdrRh7JZuYhFEx8ZjR6R?=
 =?us-ascii?Q?KP0amN+2IlxsQ5ClrFrueyT3rUlH/sHXf1CEaQyqb8SUUqbacxmj7o3kPpuW?=
 =?us-ascii?Q?B2fvWbSWA8jOKipUrcWesSg6ke3s+Jhi2C5+z8UNWZLfoC7vCsQOyyBdxYWl?=
 =?us-ascii?Q?iwsdzBU4wk+qg4UDYlCSvD5FlL4hXNcumET5kIiQIQU9QGzZ+UI637lJXhWw?=
 =?us-ascii?Q?Op9S07414QED9WUGtv3lrqvGtJhNggFfWXvz85KJNAd0ITDEena4Abr4DRuN?=
 =?us-ascii?Q?bYiP52Psp/QH9bNlqu97K5rkBP9fZnJHqwI3aaTtjNfoTVjMz44t3zzkVaxc?=
 =?us-ascii?Q?ZwBazo0zI2ql4lBP2joScd1uLWOv9ZXQUw3CZd+TOdvKJ2Wxrq0yI7FrHqhi?=
 =?us-ascii?Q?TFzUZkdjdHa+YWEK+yD5X9GEMeQo9fRJuZ4t0aZRHoa+Q3eTqhO9VVn8pqwv?=
 =?us-ascii?Q?NRLjLmeDVXdck5T1C7Puw71XLfpXrZTc/J2yfHuUBBxwBnuXs1QFLEbIILsN?=
 =?us-ascii?Q?cpknbG/5AzLyUc4YUiNTK+gznnyrLlVcKn6DKQQAif0Ng3sUkDwEkjq6UdR7?=
 =?us-ascii?Q?2arrEbeKq8Ti6mz9LRBoc9rSPs/DoWmTBgW3m+uLpBBHuM8sImqf64mIiQ/C?=
 =?us-ascii?Q?3l/r6bhctw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42f9746-b15b-4c53-28e2-08def6e1244b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:13:17.1037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLENNLCfbHhccvCV0n6I5cQwRqzwTL5GWL1MNdssnbOgrQGqF5fHaIgCSkO+dDdX6RUR5XzrunBGQlLjzF3MTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6773
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

"[PATCH v8 phy-next 00/31] Split Generic PHY consumer and provider API"
https://lore.kernel.org/linux-phy/20260505100523.1922388-1-vladimir.oltean@nxp.com/
became unmanageably large for a single patch series and needs to be
split per subsystem.

Here are the patches pertaining to DRM extracted out of the larger
series.

Change log in individual patches.

Vladimir Oltean (2):
  drm: add <linux/pm_runtime.h> where missing
  drm: bridge: cdns-mhdp8546: use consumer API for getting PHY bus width

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c  | 1 +
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 3 ++-
 drivers/gpu/drm/bridge/nwl-dsi.c                    | 1 +
 drivers/gpu/drm/bridge/samsung-dsim.c               | 1 +
 drivers/gpu/drm/msm/dp/dp_aux.c                     | 1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c              | 1 +
 6 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.34.1

