Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EC5C531D2
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C54E910F107;
	Thu, 23 Jul 2026 13:26:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="nr/IJbdK";
	dkim-atps=neutral
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11013032.outbound.protection.outlook.com
 [40.107.44.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D119010E594
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 13:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkkXEF8eGI7+lPBBiTowxNR0ZbZ7PPgjl2qvSUCi/T1MNJWuMB7ENoT5dbQs3pnXP9vC4M5uRqJ8PD12cFpeZJEtButxeVnW5d2i1/Lfsfo359RVuefv+uAOB9PkOhUJjd1hBxSmokJQB5EQfa9N3XL5J5GYcW5zZYmzCOGxjYwU9oncWKNmP9xalMt0dY3ld7bGgjar65AhsdvjTnzN+CtzzRjH6v0JYtnNSqhGYrZTjINmQ4rjRSG+GwUiKBs5aZQ3HOvF+9YCTVZE4a+bvCqw9CHPM6O11xcH4dTnob04k/LIKSDmvDvsxelIGXRwxL+/Zpah66P5CIKSf1sZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXQ+RSsDt+DL96syQxQmZATtm4kygBOoaKykDsbM6g0=;
 b=Q6u0SxlakLzz265ZyfJ1Z/OdxdlliBILFq103b2uN6QF50x8wCpU98wKK2yaTBQcNsJUJ6W1bufeBWBbnLYsyG/oVFsXr5W4kI99/aekfW6fZ9WOE1v0mA2p/xb+7ryn81QDzjJaksbZDS3OEvLn/4gI3XI/v2ONsQ4S3Z1I/t3x3P8F08fOfNmP39dDbdQI+Kv3MtiozSTvzrjvft934PKz1AaKoOJSpeQTyP5VA6H8pI9FHS0XCPfn46oycUgbUUq7Ecn2Ed4TgyFX7Qmztcow3qutAwvlUXVLnJE5u1l3q8lBiRGWCf1dRKu3BW2NGv7jptPp77/6NyY2yUflUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXQ+RSsDt+DL96syQxQmZATtm4kygBOoaKykDsbM6g0=;
 b=nr/IJbdKvxd05T5JdO6SO9KsqPKk1duze+75nEoyInKEeHJtdBouA1KcYEVDkHHwJopiAEQjRpwYIfs/u8b5qPe/tpARCX3n/RMP/nWPrJoobIRk+DhASdahiYwIjVkl8ccO9MjrzGTeKxA2MLCCU52FAwnZsv3x2Qlz0ByJmLOStqMe7uJ5i0LLIFEsbcOoR7qb+PaTDjTMZ1VRpFqwYiBSk3d6YZ8Ij0eBGawgzNlvnnGOsSGrXbl5/177dX9ESuhALeEg3jgbQXqXdWcOaayIRmRLrotc8TjrzlxaBtBtMm5cXB9gv3+29Ne4W3lCFs1W9TvIqgqpkXPoaTH3Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KUYPR06MB8724.apcprd06.prod.outlook.com (2603:1096:d10:91::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 13:17:07 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 13:17:07 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 01/10] drm/bridge: analogix_dp: Remove redundant dev_err()
Date: Thu, 23 Jul 2026 21:16:33 +0800
Message-Id: <20260723131649.134127-2-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723131649.134127-1-panchuang@vivo.com>
References: <20260723131649.134127-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0084.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KUYPR06MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf28a0b-e21f-4826-f3e9-08dee8bcb1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|38350700014|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0BAmO5zblwz8HEmghvY0WhfzxO0CQ681ax0NDNJFDSPCUDL5XomiwVgq0R1MbOTOgLjqkXUZJS2cZq048jLqZ3KB2I95eIT3yP3+ayGgkcGDsQDgBIag7O9OU4SrNLUGNq+xqy7+o4Rq0IdH7gw2qp/QkPSsUA2aBXR1XjQ5cGTdnANC52J/wp4P2/YdV//cCH18zBwewYZQYrXbJxw1Wr6TNl6sjmUItK+dGc+ZM7o/ZLfiNsya3HOxfulwpCCFBsz8xCzjOne5AN6DZDNjZRNmNqrTmP/MQmRzqHM/HGvAGHcVhOXAhOhO/2e3A7Hjfj9kxbmQjU14iPrQA0arLYrJiX5Zlrdx4zgQO+em/haW7lUMtrfqv0kePewB3YJbANHYSTGj6sB0gR5aewGukJwnA4WwrycAt2Jpws0OVBViW6qjFkh1Gn4UpkOima+WTGmXvy1FYuZ6qs+9fECrky40Z0gi6fSeal1qpZ9adihOiMdUIDZDQV8f5ZZOmTx1gHgjxR68EMlwP5t/QbB7FwrRbMwpzPhiZA7HZ7LxX8bxmgz8jvxGTjc2vviPC2pE8uRDxkIfG59B4mHItsdT8BBjdXEzFz238c9hLLObL8Y+Kx3FGvTTxxNCJT6LhFVjFomU6X3dAiT/kVOrEjLuY4QZSf0Crshj/51N5RkgmbsprvRF+E+28U/Mo+gtkPqxJHmyJqqUrGuRXRAN+yoCCGXEdDS+O+Bw0FuNVK0L7IOG1w8CQYrvtw+1F47s6hiu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u4A9a32KRt0uQ1Qpx0CkKRuKf1frWWcdNmAGXWJ5eligR2mXQJYbubkW+PZ6?=
 =?us-ascii?Q?mUYxt84gSkQku0cRUAUIYpuja3DMNbKpwzEx83gcQvZ/VuTuA37Gbe3K08Er?=
 =?us-ascii?Q?7PHOFPB/UKKsVZ+6VYVXL+MAs45dX+GkqYqsupQnWb2skATKlFHT3+Zy1wVT?=
 =?us-ascii?Q?6qsQ4KFSawOh1mq21iWZQVu5vmoyha2LeWByFVuuQfXVDHHkYPviCXi7yMOi?=
 =?us-ascii?Q?iFNRlChNEujbjNVKGCzzw0AfhcD4p9q437tLQT8882/IVPw1coLhsZU+pB55?=
 =?us-ascii?Q?hGPqxbue9ZVJjcT2NO1l5h2dcl1XY7g26aPl3JnH45rN2PVcJchItZk2Fdfw?=
 =?us-ascii?Q?7XejSL9dXUCOvNqjtk5HYwNeGuJK+7ARjPUinPJvNdCTmcy6tiSm5twH/BdS?=
 =?us-ascii?Q?iCE4nJa7SGvdvSq92q3SMjj9x2cN/sH42glQ1OreFeOERsb7f70lVUbp5v2v?=
 =?us-ascii?Q?Ob6O8jAJKlRoO+wRr/j8ii1/BYR137zTEjilFpaZAg0qC0wrx1xM0kjYbSeW?=
 =?us-ascii?Q?uChu47qzX2W1COQ/uqHIe//yMnoTEmbjg12DlUk0rMJ1XH+B72/DYTIBTjrb?=
 =?us-ascii?Q?mRPPkgd4FZjZG+hpCh1pXrPOALXkxjJdIDd+vaax0jnb0sFCnmZWeMnEXebL?=
 =?us-ascii?Q?Q94UofSLbLeA/r8DIoJZJSBQDk/4V+T0sGwScwTzxfIcZKOSwMI5K1H0BjPR?=
 =?us-ascii?Q?Dtbu/717QHocX4aJXabZ5iIaKi1z8UAAxyFLPyqPJj0e0IsFQJ7FbJYtoCn2?=
 =?us-ascii?Q?xc+GXrCtcBpogg6/F7WQdSorurwgFo1mBQp0RtXa+g3JBFGZ3Jyueg3yH4nl?=
 =?us-ascii?Q?nqZMvo0devzFSRNPcSRTj2jM2sgOuqznYpw421vocG4+skSj45hQ2sF4IPxu?=
 =?us-ascii?Q?7ik1k6oEqrdX37lVG2MmE2r5p+Tgpip2cdDPs2U+LaPj7dXlM0h4UEBz+cxx?=
 =?us-ascii?Q?al6pr/GcSsadnmOKi0q+iZnRVxT1yooQZgerYAc2x2ShjMLgosZzZxq/Jb2p?=
 =?us-ascii?Q?9iQTQ/0DksoVtcsqQdDwn9jARb4FieDoVZzi/kreP8mBWozbign/maDLBNB3?=
 =?us-ascii?Q?iQRB4topbiR2rEnx8hekxA/UYF5JJqhaac+a5EoF8RH3pYAmJTfwhPEzOfLH?=
 =?us-ascii?Q?dxgh2l0k3sXHWRxgIfVxH6W0QzENMfqcTWcWCOpohTPVr3e+pCct0crDNOk0?=
 =?us-ascii?Q?aYWu+vLRHJSnF07Bz0po0BZVz2PHRwHdJ1u4Cwy6k6dlwZvc4RKgi500XwyE?=
 =?us-ascii?Q?rV1hkLhtlIiyf4CM7F85lwjSs0dYF6s7KIwMOPyy1kCDcONeB4Jkbr+ZPFpY?=
 =?us-ascii?Q?lSP8tQ0iHSnt6F5h9URuCmQGr617Tf34ygXwOl30ymijZKZQWNu5bjp0rDqX?=
 =?us-ascii?Q?1K5RzyxcEYk78Z0dNxXDiqNkwixGIr/bKdOvI2VKUuuwlB3I9nnQH/W/HL+0?=
 =?us-ascii?Q?8nYY5EvIwxlw2mhVyMPTHxanpQGDIIArA7AncX6SuDHQze3RFyx1jRHUZL/b?=
 =?us-ascii?Q?vWCDyb9xmKJ/oQ5LRX6gcM57c6srRSUPrXPeP+WO1tqdyZiHoegO7V97kvwO?=
 =?us-ascii?Q?+avMRKm5QRaVEpD9BfLW9zGEhzHEdMazvZc5hJxu3Utlf/XMHQF6c+2YKDzk?=
 =?us-ascii?Q?kI8N2epEhjsjMcNm7+vkHpqQDwg/a0BGYzgjJ0VAoLFUV94VujcZm4IDrxkZ?=
 =?us-ascii?Q?1RYKYM8KeTGCAfwLV5gRQnNNAriijygKue1vEemFwHe2G0pRblJJJTIZrOC5?=
 =?us-ascii?Q?DUK7U4GbNw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf28a0b-e21f-4826-f3e9-08dee8bcb1ca
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:17:06.9519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmkxbGey0gbezk7xfA1cGUUamcyTdnUP2ZfCK1LAz6m0Nh3BohSpyxS8/O6oSeBUcqk8AXyTEhblCTstFVgvtA==
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

Since commit
55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
devm_request_threaded_irq() automatically logs detailed error messages on
failure. Remove the now-redundant driver-specific dev_err() call.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 30c0c0b41d5a..566f1e5eb8cd 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1414,10 +1414,8 @@ analogix_dp_probe(struct device *dev, struct analogix_dp_plat_data *plat_data)
 					analogix_dp_hardirq,
 					analogix_dp_irq_thread,
 					irq_flags, "analogix-dp", dp);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to request irq\n");
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	dp->aux.name = "DP-AUX";
 	dp->aux.transfer = analogix_dpaux_transfer;
-- 
2.34.1

