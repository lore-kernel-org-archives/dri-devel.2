Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C077FCDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F80110E52F;
	Mon, 22 Jun 2026 08:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bqtst3uM";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010010.outbound.protection.outlook.com
 [40.93.198.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C1510E531
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hkg/M0NNIbHFZtkH41ck8clBYvG7pw5pNlRxxNyEDC84/9KEjUwnR4iUxK8ZgTNqqFfffVT3eT/GKcDWd2cV4OKBS1nJkkE409Kabw/RLu1U1veAhKPX/zgnVfynAiredvcaFvh0t1b5fjbxKu8GraFKxF1QVcK0ZYboj/ayZWFoFlBpGMT99KV6r2ZB6SISeEB9BPPveNTAZ7FTPI1zBAvGqLSUJDtuj4416dqf7bNIQXc+IeJIu7K83O9kXKuvyq9VWrTsQ+UAYhQHCdPQHXnzb9EaxLtAGjzdciqj1I/TyzZX4GyWTXHbunterCmRZn6WoqwNb12G5+TrK6PV2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dI5phd1ffIxhmpoWBWeRm4x0U2DA3h19VoWpWmUxyfs=;
 b=l/SbIzJTzs3Q35ELhKHkNmIfVR1RdvqIYFFkIQoy3jsga2AieW7dV1org9M8N+v59+MGx/aIoxOWYZNogNgrrbZlG7VaX6DwoZf0NqqCFh/vkP/MHtsXQoBUkElUQepicglPtm9aiXePL7qeDdQgSnxq/Kk0t9b2TpDOJjuevVnSGxmFVKLIPUrn9FnH0B5em8Zv+3lxUn6iOBgieU00XhEbWiZpGEEq60oCh8qxL1YuizL12DPkz84dfJq0DvwQ/0liDUBi7v27yLl3lIicKWd8MK4OhEPukvkWhoU9WA1QDZSHz/61X+V0tBb3k+pO7HJqy3UnkAnGKlR5I8waiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dI5phd1ffIxhmpoWBWeRm4x0U2DA3h19VoWpWmUxyfs=;
 b=Bqtst3uMTFAedz0i8HGomY7BdNNp5QGDLTPNQENm3PkRKxhcKw2eHxQgKccLlCNTldAfH49joM5UYMICP89qjemzY7u5FNE+fN2btwIRzESe0vmBSQzG3mnxCrx5cBbb2PxuWoVwnqIprkAWwO+BEY34SqHtNfUT1x5cLEcLG1b8msE7yY6MyS5X0DCgh73uH84C4DB9q8G0yEeE6R+ACL4HhUqJdMGtXWf66xFkm/V4zNwRHjYRvnbVj4uwwXj6X0GbgWHkOA+CaYZRoHyMOuUl73Eey0tCTAL2bflUfeESedVx9W05wrVoEwdPWKQjqKBgj71LGfRGkMx+UtrFbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::623) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 08:23:10 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 08:23:10 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 22 Jun 2026 17:22:52 +0900
Subject: [PATCH 3/4] gpu: host1x: Support running without hv/common registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-host1x-nohv-v1-3-65bc682a617f@nvidia.com>
References: <20260622-host1x-nohv-v1-0-65bc682a617f@nvidia.com>
In-Reply-To: <20260622-host1x-nohv-v1-0-65bc682a617f@nvidia.com>
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
X-ClientProxiedBy: OS7P286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26c::7) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: adb20cee-44ff-4260-9acd-08ded0377e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|10070799003|921020|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: CO67y24mjiTe5yGOVLjRoBNFqrD/0mjtQgxnjiw3cAopHFQv45pFV62Ok/vic6Y9yIBECwYN3Q0yF7ukX/Ck76RKl7EOSOmQnLam5/2kEM0tRP2vkPJXtGEciA5mLM1PL21LJtcZYRYTj9R2ZzUtoiwEZKyFYjA26vAB8uEGJetVMEO7dRI3KTowl8kFVTsGp/2uTuEDEa+wfwVEGjIyepyeo7CHUodE5roJFEym916BveDmQepOqKzbjPTnzexfP+pi6R6Z+FW6udeu8uf5qxeZ9gNGjqjHPnKKCefYhC2RMnqB5zAK+s4jDxq12MULLY+TDlt+QNNxDMnM9A572VEjeD5L9MNyx/BXdrNHlO9Ni4Nh/VYGMCWfBlENTFwUChl1FjxyIaahQvXG6z88OfCCnWCFdYDRHomM1yRF7TEiW5rSryjeU6PDe6Br1L1IB4bUukjTducNOaJGoJiUInRfwDMTDv5YvrdJxS2+luNaEwTjlrP3oTFc2QtaQqC9ne2mcmWC57eNLVUJ+9QeWzAVvDGmipH/veBiGXqpGFvrqIH+MCcp/sBPp8rhi3FGlg1V1KjNz57XoCmAyNrvNHHOilpCao6t+yB460p9vrlY6sFANGayRJuO2U0eySTdoBXJBNHfmbMyU8UblS5A5JgiiPpdOnvutBX4B2tf6FT8h/5n3aFJQT943uqYUklxiS6hUV67J9PtOG0GP8Tu2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10070799003)(921020)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGZLOEU2K2E5bzBhTHBmMlR6ejhQRTVBVDMybnROZlJRT1dtZUZnTjZySXBw?=
 =?utf-8?B?eUJPc1c1U2Q0dWtRam1YMEhLS1V2UUJEMEQ4WEJoNFcweEtzajdUQlVXdHN5?=
 =?utf-8?B?SHdNYWpuQWk1b1lwSloydDlFTlRuWTFPQmhiMnJhVjNyb1I1d2M1dWpPWDBl?=
 =?utf-8?B?UndtNWUzRmZEMm5rMlZ3c1BtaW8xT0lEUDUyM1VMcWE5NnBXVmsxTHorQllx?=
 =?utf-8?B?WW00dTVuS09wRHNnSkE4YXNxMG5BckNWTHdSUFZFQm02dmZsa0ZTWDl2UG5M?=
 =?utf-8?B?UkZJMi9EU0ZvWlRkVzVyZXVHOVVjaWJVWEg0L3BnT3BaY3VMak5pRjY1eG10?=
 =?utf-8?B?c2piSDJ2em5LdmxLSjhuaHFvcStxSTZTcklQSVo3Q2lyQ2NlOHUxTU1nWEpl?=
 =?utf-8?B?OFBzMEFIRzRROWUyNzFjbDc1eXQ4R2F6czUrY29lRU52UUJBcnJNckNDZHdG?=
 =?utf-8?B?TGlGMXFZTm8vK09GYVd3RHlLR29GWURIaFIyVXVYZVpXb0JsOTdDUGJmckZv?=
 =?utf-8?B?MUdIUmRIRlpBQnRUMTRtWG5LRnlPejlCaXZMVzZFN2pyWTF0N09kTWc4NkhM?=
 =?utf-8?B?WGRhcDVuK1ZJdk9aSWZmNldxZ2plbSt0QXdiS0tlS05EU1l3aXhvZmNnTk1t?=
 =?utf-8?B?TXFvVlo3RmFzcUtPcTFyOE9QVmhNZUEvYUs0SHJyT2VzTWxvU3lkaVptVEFU?=
 =?utf-8?B?YjRIbUh3ZEgxT2VDSjRWdGI0Y29UWDNzYXZSYlcvd2NYTUJ3Z1lkdHdia3Vo?=
 =?utf-8?B?QjFydk5CU0Z6LzFBODY4RStzbnN6WWFZU3VRWTBvUzVvam1zODZmTE84Wk8v?=
 =?utf-8?B?Y0krMkFxU2U3cWt1SFlRK1BPaWE4dHlCZ1lFS2JMNnlJN3FvRUdSSE9Ua0V4?=
 =?utf-8?B?U1VMQ1E2cUNZVmRYdEVkeTZka3JhWVpIQlF1cHo5dVNYSXVVWjJXdEloZW1N?=
 =?utf-8?B?ZWZtUnBnQ0pNc0JBblR3aWtSa0pTRFBPNk1IQTlFZXR3OGJJZElic20zTE9D?=
 =?utf-8?B?UlZIUlRESUgydGliYytpY2tPUENOOG1pQTVtMUQ0aFBzRHhOcHAvNTRWQU12?=
 =?utf-8?B?cGxyOVMrb2NOR3hkUUx0VXd2ajBhVVNTZzliSC9UczlLQXUyRG9GeDl1KzNC?=
 =?utf-8?B?ZlA2TG5GMWVWQlRPWkRRMWNFTVk3R1VsNXhYNHN4Z254NlFJOFFFRENpZnk3?=
 =?utf-8?B?dE5qcS9uM1pkaWRkY2tkTE1DUGtvSUJCQXpDYWFtQUZWSUFReE5wQ2JQaFc3?=
 =?utf-8?B?eFBla1hrZXhlK1F1OEg5S0hDajkvVTA2UFRmRks0UVZEelBsMVFQdUdrZDA1?=
 =?utf-8?B?QVZtUTBaYzRHZE04SGhJK2Y2OFU1Z3lkKzJYajc4b3o1U3hqbkd2Y1lsdW5v?=
 =?utf-8?B?ZVI2Um5wWFZXOGh6aURrcnVHOVB0MFVEUGdLTWtmUTNlOS9HTGgzK0Uvek1U?=
 =?utf-8?B?aG5WWGpZTW03MkIxZkU5MG1iVUFRNksrOE9SdlVvT2VsVEJDcnh1VUJwb3Zx?=
 =?utf-8?B?b01QbVZTSjBKeHZJTTJ2Q05nazcreVhVNng3eWdFZ3JGaE9LSnplcUZFVzFm?=
 =?utf-8?B?OStrRWcxNG9pQ3U1UzZQcS82MWUrNU9TYVZlN2hUU2JITDBHUm9xY2FGUnd2?=
 =?utf-8?B?dGIvdnZQMHdzeWVadWlCOG5KdEw5VGdxVDZlWktJQ0cyL1JteWZxenNRT1BC?=
 =?utf-8?B?dHZJT3g0bGt4cklIQVJvZ1VLeksvNktXRFhqU09CVFhkYWRWQmQ0eDlqOE5u?=
 =?utf-8?B?MDlYeVNKd0dNZUpXMkpXd2twRnJsL05PbXJvREpLeHZpUmdlYWhzcWNuZ3Zy?=
 =?utf-8?B?RXB0SXdnd2xEREtyMFZWY0tMR3pPa0hJZVFJbnRRODV0K0p6U2dTS1dRbTVj?=
 =?utf-8?B?cTdsQUM4UnduODhabWNGWWpzeGdocVM5eUdiN0lSRWFNNEhJcWJGbUx5eWJz?=
 =?utf-8?B?T0lkUW9nQjhOMTlreitOMkNOR2dDT2RCUkx4cHJTL2JUWDBKYVc3cSsxMzRR?=
 =?utf-8?B?ZVdqM2J1ZEdwbDNGVzFRVk5CTWM0akFxbERHc05SeHJ5OWR6Y05vcFRIY3p0?=
 =?utf-8?B?RVhnOWg2VlRUVUkvc29GdldmbHVsWnIwK1p3VXdVMWRyR0tDdzlnN1FlUGp6?=
 =?utf-8?B?VWlzWlk1WTE1QUtYZitZQmpEYklNZUI4RXJXOUNVcWRsOEpEN21DeEV4alZM?=
 =?utf-8?B?dE16S2hkbGh2UmlJUyttcWt0S211VEN3NVlWQ2xUWXdPdEFhd2tqUVRNSUs3?=
 =?utf-8?B?SEdHQWw4NDdSU3EzNklQVldWMnN3QndvMGRwdWFCdi9aZW93SFlUNHNXZ3Fm?=
 =?utf-8?B?dm9uRHFmYXIrUkJjcE55LzVseitQZnViQTQzSVcvWjJUdHNQcFdGdkdEREVx?=
 =?utf-8?Q?8/Zd3GKhDVcSMwhzSPPMvmiL9EVeLW2ZTH5UHwbaciLiT?=
X-MS-Exchange-AntiSpam-MessageData-1: 0t9s7+dwzA6h4A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb20cee-44ff-4260-9acd-08ded0377e88
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:23:09.9716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rl7T1sGGndEnHCgy9/gxrBM2koOmoTgvHqmql7pM2pwrH9dNtBd+v/jJUfMoX/NM+3aocqKAe2Son5yG9LEGKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1
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

