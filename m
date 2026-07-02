Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3CDC43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 04:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90B2610E41E;
	Thu,  2 Jul 2026 04:11:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="NPTXD5Mi";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010062.outbound.protection.outlook.com
 [52.101.193.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D98D10E41E
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 04:11:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0+1hCMdcTer4d4ZX711fMSGLWMKECAm3QjznLID6iWNpp+WhxFSK3QEoXs3CsqhseZuxYFa8aqfmbOl/4P/LzbQsQJo8ld3fnr3J1XUihb94qo4vuHVBRLhc4RF2rj4p6IZkeQZPoMyrV8Bv0Td2OOXfZdu1xxGkrfjB1w1+sGbwyWF/S+1+0PYgeRa99NfjxE6zAaVstSEpenieOBTKp30tODFjLjR+ekbacuYZQJ+ZNAPBxlxpqKhLtrgmfBne2nltGggaH3gGnG36WKAs9SF7JA+oEclNlpMErdBJetDB0SZ9JaVAu9lHCALUtRPfrXLNAHKtfL+Tf8BHnAp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dI5phd1ffIxhmpoWBWeRm4x0U2DA3h19VoWpWmUxyfs=;
 b=G90Tc8KI2K74oURajJg1svuMzTE1ckpABp+9W5mJG79qw49Oy9JmQjM2ReYZAhpAXCcVOTcORIo9mxT7Fsy1OhSPZW5M11yO7rI2DyRqstarzT27v/dUIMTd18NWLDEx3KdHo5t+XnSBLuvHMyRQLTa2F88JM0NMHu45V+AJE2Qd7F/kPgk35eMpm/WfbTJKs0A9eNoLdB32TcA3f2ZCr6GX072iJ2yT/buS45p6+DiA6KBcRZNeed+9CZBW2YREBDbGCi032R332iibpY65aGESpMYSh3UQOAh7u1cwfXgdSlvPYjnxV0JQIe1cs5tNdNg/I0waBOWqLa5Sli7KdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dI5phd1ffIxhmpoWBWeRm4x0U2DA3h19VoWpWmUxyfs=;
 b=NPTXD5MipbRkvQO/X0corkcJeyv9KRqozcaYVF4Y5hWPi8KctL4McTmPXmx6gZQPsYZndMYYdRXJChAhUwOToJ8pTZ/Q806mzwuLKzAdkrZK1AcwWLJw9E7mubkkMpocIkcYK2YUuzfhkXXFbhnyjDrcX4ZfVCiUqImBrKQrLCyIEwT8VtikQ90DBJje39V0c1bibhkFkvE68FgxKTvHMPnf4kUW8mtakGezpq2tp8qPBoiA3ZUGzJck7cXJseW/c64ZjTRyCBeNflM0Syau7wCcC9gCnlcJK0EDOD8e5916hgxJYkbnv+ryI7GvMOy6wNkksz1QdP/cEt6DDGXc4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 04:11:07 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 04:11:07 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Thu, 02 Jul 2026 13:10:28 +0900
Subject: [PATCH v2 3/4] gpu: host1x: Support running without hv/common
 registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-host1x-nohv-v2-3-e6d88bac0af6@nvidia.com>
References: <20260702-host1x-nohv-v2-0-e6d88bac0af6@nvidia.com>
In-Reply-To: <20260702-host1x-nohv-v2-0-e6d88bac0af6@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TY4PR01CA0101.jpnprd01.prod.outlook.com
 (2603:1096:405:378::11) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a98f7c4-1bcd-4542-c50c-08ded7eff105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|921020|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: VBMQl5GBS/a55iUpTS99NVIXRnFjS1YGQtKlDH/LzXxmWkyrLIC6z4CBhP0uuhd6vuowYBgBt4kUVppIo8muODuG4ICzNKnYqqUoh8bJKkwk4LL2kiP3nPOw50bgN0eoNG7XSwSQsdF8HzH7PCBRHgoIjbBRUNktGCXBoTXhM+S9MLWEG9gO2vocEP0kEQCAJ9+H2Red/2q1+7b2GNeWdyiKtVe5cjK+1ueg01uFgkhRcc+yY+7pUQRhzMXRDDvxxUcx9KBhJ6Rp3J6buF2/2X5DjNiXw0RWx+Kvfh+Tkz0AwoYIjNaAshuT5YgqDVadZcbi3Rznsn3yh+GR+wN/0/Dxe7fBfPqLhTCU4pfdx7sBt7snEhwK79CNstTHhbtMaSsPuJV2HWDTc7sJkhcMGlBLpBU8cD7GexzXv+PFtVYgIYs+FMEwmZ/tNjJOovrHh0z9LF+NyzIYcwSpa3KrAPWKA5JBl9MnIyePpjObUKC5CG0c8aH9yPngjUxYF9VJFWnmvSfbGlD4D94DqqlKOHWMYoM0MyMKppghWAOiClIZ4dOY76VhrgHS3JWMZtXxiVDAaNwQ1iW9BV93n0s9Z7dt0aZ1RzbrIdH6rJLkDKZ2VxBxZCm9MwOn4MMOm4mRct64Ux2bIazjwOQE5ni9OGD3M/b4PhwMqLOW1N82451fBtJ5ChdfimhWi+Z0t5nuMtZz6UGj7Bk/4N1jWf8b2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amphVjllL1ZyakdNWms0RjY4cDdhWjlhOTVsM2E2dWEzc05uM2QrekV5d2R3?=
 =?utf-8?B?SzBzSEpYZjhXWFoxMk5CQWk2d1ppbHlUZGd0Ulh4cjd6aXJtT2ozanRrODVr?=
 =?utf-8?B?cTFUa0FrQUswaFRFbUozMmNKbXhVN3QxNWw5d21ETHdRQ1dKak1SQnFNRDFB?=
 =?utf-8?B?VlNsSXZWbG5RNk9UK3kyVGErSFZKMDdmYVJKWXB1ZFR5YVFEZTE2REpXL1Zu?=
 =?utf-8?B?VDFZQlBLNCsrQlZ1bzAvYmF3UkROVHMyTE90Y1owTGd0MjZ6UEMyY2REWHVW?=
 =?utf-8?B?T0NHWnkxTVRtbWZWNGljOHY1bmpxbGVFdXFQLy9OZGJkTzNzNThiRGc5UmJT?=
 =?utf-8?B?WUJMYndXZjBJNFYvSlBMakt2eG9qTVpualZHZUNIQTcwRksvUTluaEVycjlB?=
 =?utf-8?B?OVQwVWc4WlJUa3BLclNjTGJlQ21adUFXMnpwUmloTVlBN2hOZzgvYUoyZ0lt?=
 =?utf-8?B?TEp3aTNsMkJkN1pBZ3F0aFE4TXJwR0l2clhnV2l4TTlRNXZIMXk0SnJoVEFi?=
 =?utf-8?B?dURUQkRIN20wVThOZi82TlJCeE9VeWExMlFsT1NtQWRRbm9rUHNKZUxkQVlE?=
 =?utf-8?B?bFN2VjNIZFFFY1YyQjMzV1NrVHl3cWNkWFVMbHMwdm0zZGFyVHVwalkyTnBO?=
 =?utf-8?B?eFJQdkpzWEdVU3JKTFdjTWV0cmZ1QXBNRTRid2tGV3lxYWR1VSsydkU3WU1v?=
 =?utf-8?B?UVZvYitNV0RSOFdqbEFOOVBOeE4vK1RTNnhJVmxQMzN3V3VubUJDa1JvVFp1?=
 =?utf-8?B?MzRkNUtJZng0ZTYzUWxhK0o0WEtBbnhrTk5EOTl6d1EySXlOYysyc3hqODF3?=
 =?utf-8?B?T2J5amFUSVdtWjZ3MklqVXE0b0J0ZjBZSU5QS3ZDM1Z6Sk95K1UrL1JGV2RZ?=
 =?utf-8?B?ZzFpTStZaXNhSWhQNUhnLzFtVnJuckNhTVB0ek5yR2VUclFVN0xlWGJOaWJ0?=
 =?utf-8?B?OHFDdVg1UW9lVzlyWENhdmNMVC9vSXZQZGV6YXJjNDVoa04zZ0lVY29tdXVj?=
 =?utf-8?B?aklDS1czbjVKY200Q3lrN3lEQldKMThUWUZ5QnVVSWlnZFRpWmh3R0lDeUx3?=
 =?utf-8?B?elpFSVNlUWJVZm14ck9LZnlDUkIyR01BZWZzcTA0UjlSV1VJYlZxdW5yN0NP?=
 =?utf-8?B?ZW5hN3IwblIwRTVyQ2VHdVVxRGRKaXFmOWl4VCtHeWJjeStlbmZTZ3pmMGdW?=
 =?utf-8?B?MlRCNEY0NjdaNDhuTk9oYWFKaDRwZG4xaUVsbEZXSDBxU1RzSjQzSlFUSDMv?=
 =?utf-8?B?dVkxOWhXVWlXbHMwa1ZVRkxtYXdYZ2s4c2h6OVBhT0Jhd0kwWjhLOHVpVERj?=
 =?utf-8?B?WmEzYy9JOFJWWVJvQTYzOEdrNVRYZWVZa1AxVG9TakF2ZTA3U3R5KzlsV2lt?=
 =?utf-8?B?Rjl6L3Y1RFhaMTdCOERJYjhmSXdiMHZNRkhudDBWV0J0Tkl2b1FxYkRUekxm?=
 =?utf-8?B?ekYzU0Nrb3VuU3gwbnNKUVRpL3FtVkJ4TVgvVkJxSzRvNGM3cFJpNDFxWnhV?=
 =?utf-8?B?ZUpCU2QxcnNFMFdtOU9VYVcyRTNUV1pHeDl0dWZiRlI3N0RJclF2RmgrQW0y?=
 =?utf-8?B?bUd3QkhQMFZDTWMxTmQ3UGd5TG9qSkgxQTAwVXU2enFieTY2NTNHUWlta1BO?=
 =?utf-8?B?YzZSVkpGelJ4VXNPa3h6bkJRdWFob0JXcld5emZEYUNIeEV6SngrZFhMbUhU?=
 =?utf-8?B?eEJFWlI5NjEyakdsS08wSFEwcVAzaDhveWtGQUY5QldNT1E1OWJGWGtvd3pE?=
 =?utf-8?B?QlN0TTlpS2Z5aXhYQWRSeDZzMDRzS3ZhSk1qRzhMVVVvazhad1FWRVIzTkRr?=
 =?utf-8?B?cXZyNGs2QmsrVEh5WEhPQzdOY0ZQNWYwQVVUYzEvRzFlYXoraUo1ZTZRb2Uw?=
 =?utf-8?B?UXp1TVpXanZEREYwVmplaG9mbWtKWVBtWFN4MmxjcWlEeUEvMll0VllzYS9q?=
 =?utf-8?B?U2xOM1VjNTM1cHF6R2dTK0dIYkk0SlFHQkh5a3BneERmTytOd1VlYzBacC85?=
 =?utf-8?B?SW5TSkszR1RKRE13eTV3a0hONk1DQVEwV2RaV0JqdldrQTN0TXVlU1ZBcHQv?=
 =?utf-8?B?Q0dwK2NOV1JkSEtKcXZPam1jMGs1bWdlSG90VGFvcncyVjdSRG5abUxjUkFY?=
 =?utf-8?B?WU1kb1lSN3FSalNCYmlrT21ueTdDRnd6SEhYalh1NzFnM1QrUEtVVG9HVWxH?=
 =?utf-8?B?SjIrd2pJZm5Edjk3cFFWOW84eWxuTVV2OGZiMVBtRjVWWU4yZ1o3QnpLM2Ji?=
 =?utf-8?B?aFRpNUIzRncwQ1NmbjlUV3BFZXp6cHkzK2hjNGQyVjJTR3dKT3dVamVEeFdZ?=
 =?utf-8?B?dC9Wc1p5aHFxL2tHK0Mrbng4cjBlZ1pWTFFoWkRNNUdkMmxHb1RkejhXOEJK?=
 =?utf-8?Q?JAKtcjrx6TK1vRYVBVKlBcH+cwlzL+H56NeQ0hs6H4UyS?=
X-MS-Exchange-AntiSpam-MessageData-1: L0qreV/1TZJ8KQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a98f7c4-1bcd-4542-c50c-08ded7eff105
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 04:11:07.6050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUGL0Rq1hfGYHjbo9tDwdeQR4wCWGgH1cZr1yf/1y2bLMO5TgjHmBolOc9O504J84GecB+IbqtUBEkpvbdQcKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
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

Host1x can be used without access to the hypervisor or common regions
when they are configured by other components in the system. Add support
for running without access to them.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/dev.c              | 15 ++++++++++-----
 drivers/gpu/host1x/hw/cdma_hw.c       |  3 +++
 drivers/gpu/host1x/hw/debug_hw_1x06.c |  3 +++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 3f475f0e6545..545fa2e3f180 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -305,7 +305,7 @@ static void host1x_setup_virtualization_tables(struct host1x *host)
 	const struct host1x_info *info = host->info;
 	unsigned int i;
 
-	if (!info->has_hypervisor)
+	if (!host->hv_regs)
 		return;
 
 	for (i = 0; i < info->num_sid_entries; i++) {
@@ -532,15 +532,20 @@ static int host1x_probe(struct platform_device *pdev)
 	host->info = of_device_get_match_data(&pdev->dev);
 
 	if (host->info->has_hypervisor) {
+		struct resource *res;
+
 		host->regs = devm_platform_ioremap_resource_byname(pdev, "vm");
 		if (IS_ERR(host->regs))
 			return PTR_ERR(host->regs);
 
-		host->hv_regs = devm_platform_ioremap_resource_byname(pdev, "hypervisor");
-		if (IS_ERR(host->hv_regs))
-			return PTR_ERR(host->hv_regs);
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hypervisor");
+		if (res) {
+			host->hv_regs = devm_ioremap_resource(&pdev->dev, res);
+			if (IS_ERR(host->hv_regs))
+				return PTR_ERR(host->hv_regs);
+		}
 
-		if (host->info->has_common) {
+		if (res && host->info->has_common) {
 			host->common_regs = devm_platform_ioremap_resource_byname(pdev, "common");
 			if (IS_ERR(host->common_regs))
 				return PTR_ERR(host->common_regs);
diff --git a/drivers/gpu/host1x/hw/cdma_hw.c b/drivers/gpu/host1x/hw/cdma_hw.c
index 3f3f0018eee0..85f7e5633555 100644
--- a/drivers/gpu/host1x/hw/cdma_hw.c
+++ b/drivers/gpu/host1x/hw/cdma_hw.c
@@ -253,6 +253,9 @@ static void timeout_release_mlock(struct host1x_cdma *cdma)
 	struct host1x *host1x = cdma_to_host1x(cdma);
 	u32 offset;
 
+	if (!host1x->common_regs)
+		return;
+
 	switch (ch->client->class) {
 	case HOST1X_CLASS_NVJPG1:
 		offset = HOST1X_COMMON_NVJPG1_MLOCK;
diff --git a/drivers/gpu/host1x/hw/debug_hw_1x06.c b/drivers/gpu/host1x/hw/debug_hw_1x06.c
index 9d0667879a19..324e76436f7b 100644
--- a/drivers/gpu/host1x/hw/debug_hw_1x06.c
+++ b/drivers/gpu/host1x/hw/debug_hw_1x06.c
@@ -87,6 +87,9 @@ static void host1x_debug_show_channel_fifo(struct host1x *host,
 	host1x_debug_output(o, "CMDFIFO_RDATA %08x\n", val);
 
 #if HOST1X_HW <= 6
+	if (!host->hv_regs)
+		return;
+
 	/* Peek pointer values are invalid during SLCG, so disable it */
 	host1x_hypervisor_writel(host, 0x1, HOST1X_HV_ICG_EN_OVERRIDE);
 

-- 
2.53.0

