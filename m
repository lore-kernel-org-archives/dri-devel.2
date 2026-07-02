Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAA5C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 04:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01A4D10E41F;
	Thu,  2 Jul 2026 04:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rSm2Odtn";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010062.outbound.protection.outlook.com
 [52.101.193.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A935F10E41E
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 04:11:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goW+IJLzUc1QbWHyfUsoQCa1+J6HWxomCmsHCciArZIjwywtm264uRypkGtOQGWTUJqAh1fkiKmMT05ownm7p04VUAcO+41+jpjotGBE/8O948+FlPPS/2x7YxSmWWXFRroigoyiQDda3XifnJ5R8OYFnMCo+qGrf9a222BSuSXABWqDdiFJ2UdITZgU/lNZGbP7jOy1twQqLDs6gplM8XvFF3Yzco4UasnKJOX5cX/zPCwYWI+rUvnMQz2d05L795uiNKGgCRYclxM4uNHLlO5xKSOBCos2TcUyiNr5n0MLNwZwkJWCNHwg4N5DE8IOLKue9w7q3RN5kxgJ3qq86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaVNVCiVRNi/gzjkgcOpm5KsI4e+f/VBVbspJ5wO8a0=;
 b=exaeU0d0hYI9roEBXip+E38NrCEzWVxEl86osIIWjNRTRfATej4wlKiXDTvyeg3eJc+pS37eX0pBdcP9tYLFM9AdVhcR2x9AB6zk2+HqghTSPmTKpycAQ72sRsFaS4flFEeE/sH6HRpAIaD4AI1yzhlMb7IGWAornH39mF6Lh+onV5sUe3i1PRvl7iID6mS4vAdIVLzCtkaxFfYE9FJjgj5uWF2YLGy5EXQbI0MhU6RlrMgB3JQTyp0fb21acTmbbiUQi38U2nuzX4NOB2IEyzRXeTUNb+DpqgRH60mAh7ro9CmIsGFkEYz75FffPcI4F/LxZoIYSzMtAeyumotuIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaVNVCiVRNi/gzjkgcOpm5KsI4e+f/VBVbspJ5wO8a0=;
 b=rSm2OdtnsvwM7gdIOBNzurYxDP4zGA5UhRztFYOrn5ntUgeNnm4wjHEPrXKya//nBTMv+vIpuLboYCCFhgmSogfcliTDAerHb2hlestPUbj+wkn6SxVlrdEX8t1Tsdjalx6IBfP6291RpDkbyfnRDwvTF1tteXF3N4Zy6fXHcNee+9yqF4QfR9ENDXR/IYAGmaqcdkUmEDQBpxqHxusHQM264VC3KMBGUzrPPfa9t3WlecjxirynSvUrYONIRomH8MDa4RBRlPGcLYMqY0BummyanF5O9gusfAAiqBVgnNPO8aBFpJvptP9V7YVwYgYrs5AKull3tZKX4CNqnHj+8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 04:11:10 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 04:11:10 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Thu, 02 Jul 2026 13:10:29 +0900
Subject: [PATCH v2 4/4] gpu: host1x: Allow limiting usable channel and
 syncpoint ranges
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-host1x-nohv-v2-4-e6d88bac0af6@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0089.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7b9343-109d-44b2-6149-08ded7eff295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: llFRVzYdTWBa2sexMvCOBw5e0SZEc936RQzpsOJTg4IHyg0o0GvNmTNY7OStGOSc9bGQ9Roks8KiRNuiL2JL6Ot3TZWwbAzH3ElCJ9q6UMG6lqVBziTPExcAxSCEdKuij78gzl+o2b2bLltgJ2/i/lQILXenagd6xrlBJ72Gb/hBenwmoTD7FAOHzGvXs4KrkLlwHet3RmkkDZjbnd6W/UFaIeLatnkI8msrlOhg2fbRCorHAU8ohqGjdSyfXjL9dUrnpxmywfSum6o6pqXOnUJ+q2NPSRV9Iw79FpNciwfMCefHdIGEwUokpt+VxhOhgAnNi5R5XYxe8VjoM9v4DCkbrD6PDr5dkcTfOrolfJmdG1C5/Vi69Dn5OGx+8/CwX0YCWu0g6kCWbTY4ux20Nf0zTEPkfZxbRvDHwrctlNVH39b39l/Dfj6LwpKfCiWyccrOVTzBCuEDVVMpz7yFLXWZerOLdNxt0IVdrNj3GfahzMi0z/Q2k7UlbDMlcF8CEi+9XZOFwk6FaEWB6iqZPhMrL/9Rsxrruypo2PknBMsaIg2hdPYx8ww4uF+wGpLwLYxy8TWgfy2d38rK0fATkKAfCiR2DkC37dlw8EIQClU/JDGKCmSdRwNdlN9CJSMeB9O+uR/rb7Cihd87a7lOU+IFRgwth3qqlrD7WE5pgXCZ4CsNz0bynvVmGJFvPO57VDRRX0IXeErUwRGkXbWjYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R29wYVM4Qy91cG9XTmZLbC9YWUNpOU04SFNNRWRzV0R6VlV1NnovU3RlUnEz?=
 =?utf-8?B?RnBBZ1RrcXplNnUrUXJNQmVUSHZ1M3VHQXNiTkN2MC9mL0k3a2RRTlo5Vjd1?=
 =?utf-8?B?SDd1TXBvVXkvOE5zRmYvb2kyQ05ySjhPNGh5SWtWMlg4VG1VYnFGQmVWOEVX?=
 =?utf-8?B?NXVCdGlqZnJrRWZoSnR4elY5bWVMOWs3VmlUUWdqMlNjUUFjQWVZUjVMb0Fw?=
 =?utf-8?B?dzRKYWM5Njdhem9TZlpXRFRTRER3M0FsU0NHakxqK3VUVFV4RWpaZ3hOU3I4?=
 =?utf-8?B?ZlRSL21DaWZUTXdhempldEUxa0lTejkzNnB0RjlCV0VwS2xLbEIxaVZ5Nm1i?=
 =?utf-8?B?L2Z4OWVnSkhreit2eDdOTEw2UEJSRlgraU1xUk53SzVUcU0vaVlZa3FYVGtk?=
 =?utf-8?B?Q0h0MnZaQ0NydkNkdk92bUNYeExUSGtsWlJiSHZGbzcrMFRTcTFvT0daQ3BL?=
 =?utf-8?B?MEZMcnRkKzU3MTlFdW1PcDNMTExNakxVTVgvYjkyODU4MzZyc0FCSlZuVjla?=
 =?utf-8?B?MGRNME95bmRKc2syc3FlWjkzYVpJNzJHUkdxRWgwTE9meElUUTJEd1BpRWRw?=
 =?utf-8?B?Wmt2aDgyeFFMTll0ajlRMjBnLzhxcjJzVXZoNzM3TWdaK1l6dFV6VFYrN2FL?=
 =?utf-8?B?MUl1b1V2bFFHRmJPWHd0eGErYkdsY0cwZDcrVkc1S3F6anhWb21vUWROdU4r?=
 =?utf-8?B?NkZveTFMUHlHaHFDNXFrUUFTa1IyVGJzdzhHd1VyOSt4N29aaTZ3S0ljbHp4?=
 =?utf-8?B?UmdtODlEOEV6d1Bmb1EyWEtmS2hORzRyYjUvSTRYeFl0RmdEcmt4TjZtQ2lH?=
 =?utf-8?B?ZTk0dE41aWFoSEh3YmlLVmtUQmdkT3ROY1l2Q0VQdlNBaXFJeWVXbnY0UUFQ?=
 =?utf-8?B?SzQ3K21yVWIyajN1dlNNeHFIelEvQmVTZlVGYm5QZi8yTnpOUHkwSEFzUE9m?=
 =?utf-8?B?blgxU2F6eHJySEEya3JTYmhxb3JIVmlLdUlPVW5Ta2o4S0ZLMHJiSktvQUZ2?=
 =?utf-8?B?OThlY3VObk5uOTJrcVZiaGJhbmVDQnJtaFVvVTUycmNOSm5nL1JXb2RJK2RT?=
 =?utf-8?B?K1k0c2Y4TnBRTmVyR2ZNS09HaGo5dlJqQ01TbWp5QmhWSGRTQkRwS0RHQ0Y5?=
 =?utf-8?B?bkU3VzJEeXpWVXFjR3VDbVdSZ29QWTRaRTRqOVJXZUZqeFZ5cGV5S1dlZWMw?=
 =?utf-8?B?TmFzRHdzU1QxT2VXNSt1aWpuZFFhYTh5WlBoU3NPTlZEU1pmanEraXRBWkYw?=
 =?utf-8?B?T1dEQU9Ib25mQ29sN2JhWSsycGo5N25rNU5NRmxXYmd0SVJvKzVkTis2ZEVM?=
 =?utf-8?B?K2dxd1VJWXdSNlUzVTVBZjQwY2NnM0JuRStrNFhvVmYvcFhSQjhRVytaSDh6?=
 =?utf-8?B?SG9FQmFwUHhWUlo0YnpZb3lhYTlxV2ZHaTd1YTY1eXZCbWpPdUlCb2NRS2Y1?=
 =?utf-8?B?REhrTmI0TEJkenpHYjdHYkJPUjdtRmlDY1M3SFArSWQybXdwck1hVzJhNmIy?=
 =?utf-8?B?b2tDOGxMTUNURW5CRnhlT3N4Q2NwMmJWa05PQ3pzMWRucnVqNmliaEF2L0dP?=
 =?utf-8?B?c1F3bHJyVkpJTmU4dlZMU091ajRKSU5CM0RSclpRd3NjOFhXdUwzd0RhV2lI?=
 =?utf-8?B?aTZRVjEvazh6SDdldzNPM2VXT01MWGRNWHJ4VUdGRWFQbnNxRUNyNCtwM1hz?=
 =?utf-8?B?WnoxaGRIWU5GQ2xkQUFRZExpVzBveUZSNVcrRitGdFF4QmRLY0ZGRU9KNUMy?=
 =?utf-8?B?dFY0aHBpM0lTZXFnK0sxSHcyVWFnaU45YVZ0UUFyekEyWDBLV29TVEhYTGow?=
 =?utf-8?B?NTZxQzl4YjRDOGM1Zktqa0pZVHVOVzh2aUZ5LzlpUU0rRUhTTEk2ODZkQVlI?=
 =?utf-8?B?YWplNFIvd1ZDaXk5VjJvM1BiUFNPQzR5eWFVMXA4OFluL2JDd1ZrTjMwdksy?=
 =?utf-8?B?N09oU3NtN3RMQk1tV2pBV2tNWTJ2ajdVelFjd1ErQTNuck9vemcwVTF6WHN6?=
 =?utf-8?B?SkdXVVFWdWhGU3lvN0R1bW5nejBPVVVHNGFSeUx1OFB2Nm1NaDJYckIzWThX?=
 =?utf-8?B?Y1lkUGhMalVOOVhDcFV4WGtKTGUxNHVYN3Z5S2NJamIya0dXbUIxYUt4K0NS?=
 =?utf-8?B?MjlFSUF0bnl2YUpYNERObHd1OWY5cEVleE1iUWg3Smg3NmtXN01wSWtnZytL?=
 =?utf-8?B?NXFBazViN2p5UVJ0SlNnOEg2SmVJbVNsQWNFQzlxS0d5ckd0c1JNWXZOR05k?=
 =?utf-8?B?Y21OUGpoQzAyaXpVeStRY0dSQmtsVVprM3dTNWRoOVdEejJ5cWF6MkZWM0do?=
 =?utf-8?B?dWFnWkFSWE1nTWYrS3FCbTZwTnoxb081SWF6aDcrUTgrUFZZT05DQnlYL001?=
 =?utf-8?Q?PvZ4TbiJzW/TawxTRWO0Y504CRunKJowsEEtlFFisAJKD?=
X-MS-Exchange-AntiSpam-MessageData-1: NpnNgYtLvdZ4HQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7b9343-109d-44b2-6149-08ded7eff295
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 04:11:10.3528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDFMieeAJ0r3d1TcNqS4rWgKjh/n6vhVN0X+aPe3KSeVs7d104XGGUuLDdXPQosbZhsi813lvRTs6I3xJhPQmQ==
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

Allow specifying usable channel, and allocatable syncpoint ranges
through the device tree. This is necessary when Host1x resources
are shared between multiple operating systems or independent hardware
units and Linux has limited access to them.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/channel.c |  6 +++---
 drivers/gpu/host1x/dev.c     | 37 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/host1x/dev.h     |  3 +++
 drivers/gpu/host1x/syncpt.c  | 21 +++++++++++++--------
 4 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/host1x/channel.c b/drivers/gpu/host1x/channel.c
index ca5d0f51cf7d..38fcdda8388a 100644
--- a/drivers/gpu/host1x/channel.c
+++ b/drivers/gpu/host1x/channel.c
@@ -121,13 +121,13 @@ EXPORT_SYMBOL(host1x_channel_put);
 static struct host1x_channel *acquire_unused_channel(struct host1x *host)
 {
 	struct host1x_channel_list *chlist = &host->channel_list;
-	unsigned int max_channels = host->info->nb_channels;
 	unsigned int index;
 
 	mutex_lock(&chlist->lock);
 
-	index = find_first_zero_bit(chlist->allocated_channels, max_channels);
-	if (index >= max_channels) {
+	index = find_next_zero_bit(chlist->allocated_channels,
+				   host->channel_end, host->channel_base);
+	if (index >= host->channel_end) {
 		mutex_unlock(&chlist->lock);
 		dev_err(host->dev, "failed to find free channel\n");
 		return NULL;
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 545fa2e3f180..7103f018cb1b 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -331,6 +331,39 @@ static void host1x_setup_virtualization_tables(struct host1x *host)
 	}
 }
 
+static int host1x_get_assigned_resources(struct host1x *host)
+{
+	struct device_node *np = host->dev->of_node;
+	u32 vals[2];
+	int err;
+
+	err = of_property_read_u32_array(np, "nvidia,channels", vals, 2);
+	if (err == 0) {
+		host->channel_base = vals[0];
+		host->channel_end = vals[0] + vals[1];
+	} else if (err == -EINVAL) {
+		host->channel_base = 0;
+		host->channel_end = host->info->nb_channels;
+	} else {
+		dev_err(host->dev, "invalid nvidia,channels property: %d\n", err);
+		return err;
+	}
+
+	err = of_property_read_u32_array(np, "nvidia,syncpoints", vals, 2);
+	if (err == 0) {
+		host->syncpt_base = vals[0];
+		host->syncpt_end = vals[0] + vals[1];
+	} else if (err == -EINVAL) {
+		host->syncpt_base = 0;
+		host->syncpt_end = host->info->nb_pts;
+	} else {
+		dev_err(host->dev, "invalid nvidia,syncpoints property: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
 static bool host1x_wants_iommu(struct host1x *host1x)
 {
 	/* Our IOMMU usage policy doesn't currently play well with GART */
@@ -602,6 +635,10 @@ static int host1x_probe(struct platform_device *pdev)
 	if (IS_ERR(host->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(host->clk), "failed to get clock\n");
 
+	err = host1x_get_assigned_resources(host);
+	if (err)
+		return err;
+
 	err = host1x_get_resets(host);
 	if (err)
 		return err;
diff --git a/drivers/gpu/host1x/dev.h b/drivers/gpu/host1x/dev.h
index ef44618ed88a..89f1fc838a1c 100644
--- a/drivers/gpu/host1x/dev.h
+++ b/drivers/gpu/host1x/dev.h
@@ -141,6 +141,9 @@ struct host1x {
 	struct reset_control_bulk_data resets[2];
 	unsigned int nresets;
 
+	unsigned int syncpt_base, syncpt_end;
+	unsigned int channel_base, channel_end;
+
 	struct iommu_group *group;
 	struct iommu_domain *domain;
 	struct iova_domain iova;
diff --git a/drivers/gpu/host1x/syncpt.c b/drivers/gpu/host1x/syncpt.c
index 807c74fc6a0a..7760252b3394 100644
--- a/drivers/gpu/host1x/syncpt.c
+++ b/drivers/gpu/host1x/syncpt.c
@@ -59,7 +59,7 @@ struct host1x_syncpt *host1x_syncpt_alloc(struct host1x *host,
 					  unsigned long flags,
 					  const char *name)
 {
-	struct host1x_syncpt *sp = host->syncpt;
+	struct host1x_syncpt *sp = host->syncpt + host->syncpt_base;
 	char *full_name;
 	unsigned int i;
 
@@ -68,10 +68,10 @@ struct host1x_syncpt *host1x_syncpt_alloc(struct host1x *host,
 
 	mutex_lock(&host->syncpt_mutex);
 
-	for (i = 0; i < host->info->nb_pts && kref_read(&sp->ref); i++, sp++)
+	for (i = host->syncpt_base; i < host->syncpt_end && kref_read(&sp->ref); i++, sp++)
 		;
 
-	if (i >= host->info->nb_pts)
+	if (i >= host->syncpt_end)
 		goto unlock;
 
 	if (flags & HOST1X_SYNCPT_HAS_BASE) {
@@ -138,7 +138,7 @@ void host1x_syncpt_restore(struct host1x *host)
 	struct host1x_syncpt *sp_base = host->syncpt;
 	unsigned int i;
 
-	for (i = 0; i < host1x_syncpt_nb_pts(host); i++) {
+	for (i = host->syncpt_base; i < host->syncpt_end; i++) {
 		/*
 		 * Unassign syncpt from channels for purposes of Tegra186
 		 * syncpoint protection. This prevents any channel from
@@ -301,6 +301,9 @@ int host1x_syncpt_init(struct host1x *host)
 	for (i = 0; i < host->info->nb_pts; i++) {
 		syncpt[i].id = i;
 		syncpt[i].host = host;
+
+		/* Default to client managed for syncpoints not owned by us */
+		syncpt[i].client_managed = true;
 	}
 
 	for (i = 0; i < host->info->nb_bases; i++)
@@ -310,10 +313,12 @@ int host1x_syncpt_init(struct host1x *host)
 	host->syncpt = syncpt;
 	host->bases = bases;
 
-	/* Allocate sync point to use for clearing waits for expired fences */
-	host->nop_sp = host1x_syncpt_alloc(host, 0, "reserved-nop");
-	if (!host->nop_sp)
-		return -ENOMEM;
+	/* Prevent syncpoint 0 from being allocated by users */
+	if (host->syncpt_base == 0) {
+		host->nop_sp = host1x_syncpt_alloc(host, 0, "reserved-nop");
+		if (!host->nop_sp)
+			return -ENOMEM;
+	}
 
 	if (host->info->reserve_vblank_syncpts) {
 		kref_init(&host->syncpt[26].ref);

-- 
2.53.0

