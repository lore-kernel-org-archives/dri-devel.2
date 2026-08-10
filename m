Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335EEC5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6155B10E851;
	Mon, 10 Aug 2026 13:13:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Atap1mCT";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013048.outbound.protection.outlook.com
 [52.101.83.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B4210E846;
 Mon, 10 Aug 2026 13:13:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBlx5RpUdUvadi4GeElP+9XkRFdi54p6o3GDRLWaYsmHgtm1srQ59hK/0npdNmT8jPpzZC4Ikxzwe16V+hfq+WnKElssKdOU5wsLIz44A+3bEfBm5vuWrwpOnNy27INeT0EM8XXYrZDhBp/yufEdkYtl7XYfLST54CfZuvLrFiQMAz08qi79StGbh2fOwC1KU/4ypTiMYhJX3qYDF57/d01/IJgQ0VfPinZ6Km0uVcLvfgk2Xp5l5pB3KzfbXs9yaj3SRUP1DxB8PVu/bjQ3giT3397K3kXorQnHj5JPqAu9bLgrjBAMNzgtuyQvCUoWjaZ0lfG8Do9aGLcmtc2LYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIm9i/n4/MawsIKyeBW/Myrsat80673OQuhJVyN7N8w=;
 b=l2kiI2VK8qwDtgaWni5nCXwFUmtt0hiOo7hhtm4AP6wk2f6tYwhIjnTf7Kq8UOn2FgX5LnFTmZs+D+mog0n+1EB6wERmWK2sujfGAwjfZnYBjVMsJdv0rVNTrmPUpUjb94oZb8ugeCAOgHFv0ozSqZmbokiPhDqWprByv7gflh8wjzgSTkFex0BrRQxNG5IYP7rTornCyiBg5KKMJKA/jK+PRCrOmj6Imf4MMZBiZbsuV1gtam83CTIEIRnwqX4FB4rHOejRef8z1K9CtTZv2eC6BilPLDlReneTpMPltVAqHz/t2P7LalBgJDjscDHG3rok+A6dMeDdJQS9+S0DLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIm9i/n4/MawsIKyeBW/Myrsat80673OQuhJVyN7N8w=;
 b=Atap1mCTfQektXCFI1zumhpQCM0QYZ0Pt3DJCHaeanVX+FAKZbofDCQWqvS8q4v+XByF6aCE5mmSdhYwOkcRSI8HwLCtTFJWzAr1Em/SQLA1owx1Vbl/MYShWeU9SXgTzS3X0yaAfoCbCgH+ND4ohKF3KEbt9el55QzarqCkbl/xdSl7+byaEBltYaL6ZnQmLoOVd/IJb/xkvnjgoklTpfXHIt38DwLV61ybCZYiZQaJGCUQ9j2wHSNKqO4xbfXUOZGsPEiGPECMrMiYcGLncpaFzLTVn5Icg+/Il4+VYaj/3soe1veOzx/V52xCB54gsiPNjOV0tPQzr9GonGYUOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AM7PR04MB6773.eurprd04.prod.outlook.com (2603:10a6:20b:dc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:13:20 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:13:20 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v9 2/2] drm: bridge: cdns-mhdp8546: use consumer API for
 getting PHY bus width
Date: Mon, 10 Aug 2026 16:13:14 +0300
Message-Id: <20260810131314.452865-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260810131314.452865-1-vladimir.oltean@nxp.com>
References: <20260810131314.452865-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0436.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::8) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AM7PR04MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 10937e8f-f0b6-4295-911d-08def6e12676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|7416014|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info: o5By70ow9loVms7+XH6s9yuphVLj78DjrFHHKlIc8MVbmgZjtRg804puyWMhDr/nSZ8RSgDbUmll/B45oKVlxVHkwSeWCMJfIYADNjLGsiR3/TdCHGJTuEhK6onNpN9JJm2iGY5RKGfEGYDkTIm4X4jX16RW5zY99vX4w14WJ9G9rqsKrvFibGbZt9nbGYY9+dHXSSDGPmO6wGS3+hzlWFe0fGGg35Zp2AL/9cuK5E88rAZAfeRV6yd7ZuP1yw1Kpjv8AM3UEMGm/c2OqDeLSJeutXtNSdOB8z3szRycFoS07HNkrHdmxiVZ4oFkanj6l967K/pbelQ/b1Rz4/8be0VMoj/4CVwk0TSupOpn9yUsi0TLps71w9sWeFENi1dbk3P7bHDuTsEtRpNWdNLSIBRHLRDSiSO2Q5d73Zh03BvsE6LPtKw+kL77RpcZ0WLp8dO1IDpmC5jvU/RMuQ7Aew8qGBEdwGvsRIwCvPmPLVdfmDAPV/fe9kGNFs8Tk1AfCvy6ujyM6kY5V9FLLrAfLj8DFErj7MIQyauTCt0x16kb8wB77onw4JpbWlMEt9+jGueF7rqSqxJPAbBjK3/XvWvCsXATxBOisoZhmEzhLhlpt/jvWbyCkhItwk/qD/IqpQIJK+3xGJqQcUQ9pPRfp4KAok73UoKOjZdCtnTkVKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7416014)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(5023799004)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tVdvjSlAK5yPlJ7OHyFihWpvlN2wgEPYUrpkSXMzAf6sdDIcVRdKIZvSfEyN?=
 =?us-ascii?Q?KCbWC4ThpDT3dW8I8y6GnkyLF5SbpLGbk/VIpBz3vVEQ3aIkKIqdY+RCqn9a?=
 =?us-ascii?Q?QHzSY1XnnE0zRITv++iBFFpA6lWk+BL4teNyilu2B4/sjJG9oOQg0oaVSDVe?=
 =?us-ascii?Q?3yFvE1dNRwdl1HJO9CF6mb54/faaKTZEHSrf7hRdOeVLVFfd4kgVEThgbQjh?=
 =?us-ascii?Q?NQ+v4y19QyjGg+kq9qpKHfaYjAkNYy9+/jskfIb11b+iO6ZMHHhdBdgPys4U?=
 =?us-ascii?Q?llurUe8TAyW1uAd0wlAP7nS2e2NnB29QKS4GHR8UVKF139Z5O9KsIrYHuO5t?=
 =?us-ascii?Q?JQho5GXjHIw3zNsYh+vdxH6sA9YnZr8f25AKiO/clyrEWJnDgJdec8tVFLGj?=
 =?us-ascii?Q?TDYHhvQrqi0Ga5UelH2TdvafOAloT7cE/r47drzBuYbcVaxaKiHY1cZDd/Zk?=
 =?us-ascii?Q?6ebLXvIzp9oHusjIfLHVV/ryXNj7cCYbLtwLRQcL09IhtGwQQ2/Cx1WjEBDj?=
 =?us-ascii?Q?wBYAsSXxUtZ4NaWlynhhHVDOnSMfHLWok+qPgIf1gfTdRiVNaxMvwNQukEBW?=
 =?us-ascii?Q?w04BnKty9XvDjyJYqMwcC0Shqf5kffnmcETdA3s1ELYkTLzB8Rw+WL5Pm0Lb?=
 =?us-ascii?Q?bNp68hesliBCMrvzOayouLoRf8wBvz41sdj4p1oiP8V1zYm7jtnF6bhZf+lr?=
 =?us-ascii?Q?D0+qB9S9ZNJOKgzJCgDAeXQ+72A6KIiG2G1HmIg1ku4AiWGxXBrKSx5uRp1r?=
 =?us-ascii?Q?FO5vlLK3JbobdEOHPsxg2nRg8rrEKNXYn5+KefOe/w6+KydH6nRgXB3DDG2r?=
 =?us-ascii?Q?CijmQ1ez06r10SrOdJmX9NMW4I6YCQz8r3nHJt9DnOgwfTEjT+Dh9PgGS9av?=
 =?us-ascii?Q?0wvMiI+u3Q8slrQKIk9/O4TRmK3hycfftegY5m49/ZhfSWpWSpGtsM/sppMx?=
 =?us-ascii?Q?jtGVuguD/5mVCo4CJWA0NxwPg/ZkVMh8QDrJ23EK2frVZrp+C1idzymnFn8A?=
 =?us-ascii?Q?v0MR7CDdQO8ALv4A++Glie6uv724fiKeDLDkFzcR0tyoH/9ok+0Y6d53NWVt?=
 =?us-ascii?Q?PA46LrtUaD1L9LsD6/4+Uh+YVK0KLcx55jT6AwyCXICrFEHqsRMjfOIJi/cq?=
 =?us-ascii?Q?yRLD/4RqehAYOa8asB9GUkMRQroNWVcpPl0kXJf0+unLt91gggnu4w1xL4ei?=
 =?us-ascii?Q?j1NfWkYw4ajyIIj7AeJqcOTSRWX8p7D16KwI6J2MJfQFov+IlUW59UocDIOe?=
 =?us-ascii?Q?6aTuxtO1iewMCGS8jWjj63jbglIg/swUy0mpQvVtM+PhEd9W6KrwCse8RPXU?=
 =?us-ascii?Q?WDWMV6QVDuTC0K21v7A+18kkh8lcqOcAq9q7yY6rTRC4650/rfNyx8Vi3nrH?=
 =?us-ascii?Q?9eXVIvFj9t8I6CnAvlHGP9hYPL600k3KZ9UV3rO52tamcCVcJP+QFaD5tZ+o?=
 =?us-ascii?Q?1zCdmOUNzaDw95OLmJU3SI6Y0j9sKMHAXosSSGYV3Ly4G5L79YooW58XLirN?=
 =?us-ascii?Q?vfgFGg2tWrvHp/v0DVxXvHuS8zcxm/cxWudvXESXH56Dj1X+iJKzZc0RmrYF?=
 =?us-ascii?Q?WGQd17pE+2ixvnHPBzoxkIc7gVQXGaX5jiNzVjFjJIe+Ye/v78L05zaiZuq1?=
 =?us-ascii?Q?/VlKT9uWwFcTJE18cr0DkjCu+LJGC67nq9t5yBJVek/Ija5nj7bjAxWemd3u?=
 =?us-ascii?Q?1I2joLaMyK47wBAdIrpCFiIZh/bLnowKwqOxCVeTG7gikh8qF4s/GP7z8/GJ?=
 =?us-ascii?Q?T6Sf5fZfCQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10937e8f-f0b6-4295-911d-08def6e12676
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:13:20.7402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nrm/rb4EzbQ2kVcG+zLOQbsVp6XU2AETrTgIGFJPCoXssYSCu6uEsTVnVcwcJs6YzGzXozH1WeV3kll8pTEIpQ==
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

The Cadence MHDP8546 DP bridge driver gets the PHY bus_width attribute
(holding number of lanes) directly, but doing this will no longer be
possible after the definition of struct phy is hidden from consumers.

Use the phy_get_bus_width() API function designed specifically for
consumers.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>

v1->v9: none
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index c99151fdaf03..796c64cb18e7 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -1300,7 +1300,7 @@ static void cdns_mhdp_fill_host_caps(struct cdns_mhdp_device *mhdp)
 
 	/* Get source capabilities based on PHY attributes */
 
-	mhdp->host.lanes_cnt = mhdp->phy->attrs.bus_width;
+	mhdp->host.lanes_cnt = phy_get_bus_width(mhdp->phy);
 	if (!mhdp->host.lanes_cnt)
 		mhdp->host.lanes_cnt = 4;
 
-- 
2.34.1

