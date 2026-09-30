Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E04C9830E
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 04:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E88B10E578;
	Wed, 30 Sep 2026 04:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VObW+FSj";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78E3110E578
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 04:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6fKlc/irOqCzQ4uNOSMKPPQcEKVqY1VbJQQ4pFPA8qn0zBCaKgUlWWLmmQUDBebKh2XTewvQ0fkR6kWg+HT6uQ3/cRMiF4TM7DIRwrtynASCXBZy9ITM+QxJ616VYws8OQCeQfegaxFxxdRyZID+dZdtQrOjfBAUeeq2GMon29u14ti0x2QzZ7tZox3tklKDhhwcltzz2tAltE5TeXTOjncfLjwceWy5tBCf9o6eF0SNnT7IXR9pERLf5h1YUZOYqwjkTtbpgcHnEqIcO6JLrH6HnTWTzt7cpr7xKbDYezHBPmLZ5kPEw7WpYZYQ5X4M/7W3NuS5o1JdPVXDbwtlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5aa+nAS2Ob7YBT7h+PLOX6l4tuZcP9SmshkFgiaCjg=;
 b=T+7QAhqbq+PFXyapGf9WN9gkpwcRcvKXjTyjEdUAsg8AfytMzMy2MBk97mcfjz7N8uQ/y5xHpYd2bOL8+UEY3pP0D145BnJ3/da7Ainy1M0x0qx7qEyEFg0u0FjVKRbmJBwhgoAr9PMMcqv+4snPUKhczUoR2OqfwE5HAJugFf9Ei+dDCsAm2HPwVFqyiBAj7/tHpQb7wPDJHvw62Ah1XkKUL8qrnJ2gDveya0rywmq2YrZ7GPpv8vEKJZBEXCme08akIBWumOoZuNogdFC4io6sBxwiQEs1l1Zyr6jR97BOdhsgvahNK3lqBbqI/Cp8+AMgVtxhQZdzdR/kQhhX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5aa+nAS2Ob7YBT7h+PLOX6l4tuZcP9SmshkFgiaCjg=;
 b=VObW+FSjJSlmG6FTfZF1ddDXrrZtWDsn33Znr46/YtGOg0DGlBtHPV2oxAD/AqgzjKbgFN068vXqpJ9vyhkx0NA6pG3ZXo9BRMbga6zbiBpZrkayHRU7BJ+vhFwVGWRA63pXxMhRLznvK0/5oiXXGXs1jotL7bKaf/pCJVed6YtjXyOwNratQRfkoQsTrc1m/IvMuZnOWNR8mmbNHl9EVfB1Wy9tXJ/k/+Tt1PjRcy+XutsuSz2uIvUxmNW0XIyG1M6FTpeQg+wySWdv4WLFzcsYFVlMw8IsGbft2m5QXgHW/qaQFVkMBh1cRt96a3yCgTz5ZDsZErvLxB8BFZvRDQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 04:55:10 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 04:55:10 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 30 Sep 2026 13:54:55 +0900
Subject: [PATCH] drm/tegra: dsi: Unconditionally manage reset line
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-dalmore-fixes-dsi-reset-v1-1-58c9d12f5ebd@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QqCQBCF4VeRuW5gV0O0V4kutt2jjpjGjEYgv
 ntbXX5w/rOTQQVGl2InxUtMljnDnwqKQ5h7sKRsKl1Zu7ZynML0WBTcyRvGyYQVhpXPXeVbn2J
 omppy/VT8Jjm+3v627T4irt87Oo4PedzLpXsAAAA=
X-Change-ID: 20260930-dalmore-fixes-dsi-reset-4f3191dca886
To: Thierry Reding <thierry.reding@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCPR01CA0208.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::16) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|BL4PR12MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 3245811f-79b8-4687-1dd6-08df1eaf0157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|23010399003|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: ayOCT1fG2T03x/lAAdp2qOlsoh+JqZqUiTX95B41wWTTWWYwaCKua2Zs22mP7nZKqOQEsKPcXYCSUhZLstJADzV55ZQu/J1DUJN79oswv+/3nRPs4P64qj+cSQCFRqrr42rups2BtLVK4SSnEhmqQp66CBByBPz1MnvT8ZJx2kAhRRUjY0uANtFVIyC+tCNAPJ7FwgtN2NLwk/+i0zzXNk0DR2Y3Gl3/CwchVF+iksgXrxCyqPDp0u54Mvq5QdoIKxPOjhWySeXpd6+Gwam+cMRwqrtuvQbdJkBb1gGhxc1vHPMu/tmANapOmIxfkCjykJ8vqfLGdCJP7HgGn+ujr96m/FDC5F65TFj4tZ01k7672eUDryP6ff1HgjAvdfG6EpGaDHGml0mPoMfCch35X2kdvEd74OKnwHfz1A50XxZGMiVml88Nn4n+GyGD8Qaf+2pLu5/Z25I5Qp75B8qGhMbBYq+8BS1h/Rqd5zSBNmh0hFIR84rpD2kYc+7CXbqK+XSu5KyJ7HEKub2NWneHjdQIO5SF8ztQ4Noe53/PDpYIAIMmfgqnR/9KdruYf9gqW6gyjC8aC+f7LYzox7x61Au0QAw6Dz+2DIwb3vwdb5181fN/EV7mq0JYcqicNgmAz5UWqw6XLznbU7dZot86kCSJzoA8VhVzPwCWwre6tvg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFRIS2VXNFprQVBMSW1JZ3UydFNiai9kSWt0dGNwV0hBcjBVNkJCN1dTOW1z?=
 =?utf-8?B?NU1STWN5bGlTZis1N2tWMDk2dmhpQndpZHpTNmEwWXRvMldCalRIdm90eFVq?=
 =?utf-8?B?anhsekhEZXoyVnBrS3dUNUloblBVQXRSZ2RaT1Z1cU9GU0FHTTE0bXlGVVN1?=
 =?utf-8?B?SW8wM2ZvSlRrQVpRUFlSakRGMjVzNzhLWFZQd0VlS3pzd2N6aHQrb1BkMVZW?=
 =?utf-8?B?ZGZJMHVPazhQMko3emdiakFMcjM5VEM0QmhTczBFOS9KYTVRR3RFblVFWDh2?=
 =?utf-8?B?Rmpxaldud1BOSnI3ZW5nTkVNYWRuS255TjNHb3ZUUmpjeW9oVzlhSG1GbCtO?=
 =?utf-8?B?ZVZoanpFalJrMERMbHFuRFdnYmh4NHZSejFnYjVGbkI5VlVIUUJLSHB6Q2JH?=
 =?utf-8?B?MVpld3BtUUtycW91bjdBbTF2N2Z4WjNUNEZaSEV4RUNDbk1TNTJPY3Y5ME1w?=
 =?utf-8?B?OTJ6ZnZDQXQ1c0o1TytnTk9KVkZycm01dy8vQUk4TWdlZGQ5NkZGTDQxcysy?=
 =?utf-8?B?WmdsQmhDWWtKS29nc0NQVzBIdytZTDNMSkR5ZldmcGV2TXZqT21BUFl4STNy?=
 =?utf-8?B?clhDSVVKMXlqTWQvcTg0OVlkVk5uaXVkMFE1NlNoZGd2a0JoNEtRSjNvVWQ3?=
 =?utf-8?B?Nmg3SU9SK3JjZmxiY1VMUnkza1lOTTVCbFo5UndjdTRnYlFNVTdFTENLU0pN?=
 =?utf-8?B?VmRxRkpkVUlBdkM1M1YxVXRlek1vdEpSQm9xRi9abDVHM1UvdWI5UFJkNlRo?=
 =?utf-8?B?UDE2OE9kSjR1Q2wzdDY3ZllnZE1VcDEyOXozb1REQm5wSEtXb29RNUpsYVNG?=
 =?utf-8?B?YTZOMStkYUZpeEUydDBTZTFtV0JWSi9rRjhFVklZQWJ2UWx1bVlpMy9TejUr?=
 =?utf-8?B?Y3R6eE13Y0NiNndqdkpDUVJPR1NEdndabi9hSUlHL3RJK0dmYVpkOFFnVlI4?=
 =?utf-8?B?VGwwTCs3UXk5bUl6K0kyenBiTDZDbTc0NWJhblhQSEpxME01QXhvenl3cE8z?=
 =?utf-8?B?UG5ORjRJd2F5V05QMVhXcTVtai9ZbTJHUC95aUdCalZvaW1IaUFpWlRPdGFl?=
 =?utf-8?B?L3FkOUVNdzdSVEs1ZXU2dlVGeEFhUzZDTkRMTER6VEtuSmRDYnE1enVrdmxn?=
 =?utf-8?B?SU5tNkFYYy8wSm9uRGsydlFnOEhzQXFhWHdZdW1TbXV5S1kzRVZ3SHhQbkFu?=
 =?utf-8?B?dWVBUzMzYXg3eTlFMGxpMkRmOGJJRTNnRjBWbjI2OUFjcTREUmZxdzlrcmlw?=
 =?utf-8?B?Z0JqMlVtWFhkT0ljMFF2U3g3WDJjS3dXUUprS0tyTHNoZklwYUpBNlYzUXZl?=
 =?utf-8?B?SjlYZXBDSndiQ3Vkd01LOVoremhNaE9ibmNHVHlmT1hOaGdkUHNCUGZITStI?=
 =?utf-8?B?R1pLQjcvUVJ1RURiVXpORXNzTWQ1RFo2bGVFRndjR0NVRW5UcUlBMFdXMXUy?=
 =?utf-8?B?K2hhZWVuRXE4L2gyTk01RmNNd1IvRUIxK2p2NnZmL1dtaUtTeXZtK1J0MGFE?=
 =?utf-8?B?K1ljMnJsSWJOL29uK1B3NXZvT3dtRkZnODhrOXNvTVREdmRPV2xwZzBGd0s3?=
 =?utf-8?B?b0Z0Ylk3aXVtUlFiRzQwSzZ6VW5xSUszSlRmMHpET0tHZ3NINC8zTEVRM1RQ?=
 =?utf-8?B?Q2ViUENHb1ZrZ3NjM0VrdFFXc2czdXVtWk9kbm5aSXZjaEJLaFRuYitJV3Vy?=
 =?utf-8?B?S0Z0eFZ0ZUsvdjEzdloyTXhJRmJCQUVyR09HUGxzQmYxaTJEVHhVL2lCV2tx?=
 =?utf-8?B?UlkvTUlMMGlISU0welBtblpGYjdndGZpVEdOV2cxMS9lWWtVeWNheit2NlJG?=
 =?utf-8?B?VW1oSTNRbENyZEVZaHNKc3laZ3FiTGp0U0ZaUGEreHN2Yk9mbnc4KzN6MEpx?=
 =?utf-8?B?aFNlRnprTWpxRFhFRUdQM1M1WG5yUC94alZ3NkJQSFRsMXNHWTBoSHQyMTdT?=
 =?utf-8?B?NmcvTDNJeWhrZEw3VWVFYUdvcENHNnVhV3kvc0c2UWNsakZBbitlNkE3SXB0?=
 =?utf-8?B?dmk0K2tGQVNkai9ndWxqMERadDF6ZUhCcFNJMEY2VUY2TDhaaExXbGs4S2Ft?=
 =?utf-8?B?N3A4YnhyY0pONldydDljN09wOGVDd2J5SS9jd21Sd0UyeW9nVmJzS3M0aFIx?=
 =?utf-8?B?c3F1KzBoK2hrYlc2RWFLUGhGZjhPeE5KNytOYUJWR1VWWUkvSXdxc2grQXBU?=
 =?utf-8?B?aDYrdUxSR3h6cktpN2JhMjdnN2ZTajRIYU1LUUlNYk0wbzZqYXlhMlVUSnRz?=
 =?utf-8?B?UlgydmlmN2xLZ1B5QUpvQ0VZalR1VkNIemZod2ZIc05ZNzN2b3J4TG1hYUxX?=
 =?utf-8?B?K2FUdGEvN2NieEcwZVFDRFZwWE1hbmVnNUhLMDM3N0owYTVlL2pMWmwvUFMw?=
 =?utf-8?Q?DuUdDqBKER/ZXnj76J+2r1Ln120iQjaoIyL/P08HjNqRR?=
X-MS-Exchange-AntiSpam-MessageData-1: m+6sC0ZkxdF5Uw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3245811f-79b8-4687-1dd6-08df1eaf0157
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 04:55:10.3045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aB1jrY3AfGCuM13nsvS051+ENCrKS8LTpnBRGOkmjWWK7R7ILUIsC8sBF2ZcciVBxSb3IALtQ6orXYDGdC4PRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505
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

The DSI driver ignores the reset line if a power domain is configured.
This was originally added to support Tegra210, where the power domain
provider has to control the reset line -- at that time, older SoCs
didn't have a power domain for DSI. Now, however, they do with the core
power domain.

This happens to work on most systems due to DSI already being out of
reset when booting the kernel, but on Tegra114 Dalmore, this is not the
case and causes the system to hang during boot.

Ownership of the reset line is no longer a problem with reset
acquire/release semantics, so control the DSI reset unconditionally
from the DSI driver (possibly in addition to the power domain driver).
The device tree bindings already require the reset and it is present
on all platforms, so this is safe to do.

Fixes: 4cc90d4c043e ("ARM: tegra: Configure Tegra114 power domains")
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/dsi.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index cb88aafbd36f..7124cf648a1a 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1113,14 +1113,14 @@ static int tegra_dsi_runtime_suspend(struct host1x_client *client)
 	struct device *dev = client->dev;
 	int err;
 
-	if (dsi->rst) {
-		err = reset_control_assert(dsi->rst);
-		if (err < 0) {
-			dev_err(dev, "failed to assert reset: %d\n", err);
-			return err;
-		}
+	err = reset_control_assert(dsi->rst);
+	if (err < 0) {
+		dev_err(dev, "failed to assert reset: %d\n", err);
+		return err;
 	}
 
+	reset_control_release(dsi->rst);
+
 	usleep_range(1000, 2000);
 
 	clk_disable_unprepare(dsi->clk_lp);
@@ -1164,16 +1164,22 @@ static int tegra_dsi_runtime_resume(struct host1x_client *client)
 
 	usleep_range(1000, 2000);
 
-	if (dsi->rst) {
-		err = reset_control_deassert(dsi->rst);
-		if (err < 0) {
-			dev_err(dev, "cannot assert reset: %d\n", err);
-			goto disable_clk_lp;
-		}
+	err = reset_control_acquire(dsi->rst);
+	if (err < 0) {
+		dev_err(dev, "failed to acquire reset: %d\n", err);
+		goto disable_clk_lp;
+	}
+
+	err = reset_control_deassert(dsi->rst);
+	if (err < 0) {
+		dev_err(dev, "cannot deassert reset: %d\n", err);
+		goto release_reset;
 	}
 
 	return 0;
 
+release_reset:
+	reset_control_release(dsi->rst);
 disable_clk_lp:
 	clk_disable_unprepare(dsi->clk_lp);
 disable_clk:
@@ -1623,12 +1629,10 @@ static int tegra_dsi_probe(struct platform_device *pdev)
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->lanes = 4;
 
-	if (!pdev->dev.pm_domain) {
-		dsi->rst = devm_reset_control_get(&pdev->dev, "dsi");
-		if (IS_ERR(dsi->rst)) {
-			err = PTR_ERR(dsi->rst);
-			goto remove;
-		}
+	dsi->rst = devm_reset_control_get_exclusive_released(&pdev->dev, "dsi");
+	if (IS_ERR(dsi->rst)) {
+		err = PTR_ERR(dsi->rst);
+		goto remove;
 	}
 
 	dsi->clk = devm_clk_get(&pdev->dev, NULL);

---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20260930-dalmore-fixes-dsi-reset-4f3191dca886

