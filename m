Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AC9CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 06:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7724210E965;
	Fri, 12 Jun 2026 06:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="N06r0mzh";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010028.outbound.protection.outlook.com [52.101.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B87510E965
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 06:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTh02Q0uN4CwqFqxI1OBC2OWtzoIrO2/zE9a8gZOqYbQ1VllRfZU+u7rrwGLjHItuLs+4ZTveuiA23oR9HqavrEtkRBV0spBK74zUUe4sB8cUGEDt5Jm//8IPWto/2ryY/Lp47eiZ5qiW26yI2lkmnVKdov8MNdxLBrxn1XMorzctgWQGEh9IspEBKSuHrRLqiI7BhqlEUIbZ7PGvaUHDR5Tbbe5Ducod4PPtOkX44FIYmIOZwvbL4yncHnjGZQeMGWkq7+eIOCQ6aaA2V6cESs3ge9LItKSOv9vl6NLHxEnU9qn1jnQN731+Ly3C40OP5ROqnN00arB5Kkh2EzXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljt7vpZ3Quqe+P1qzg7zRuShK69IwM8JCXrxQvrP1tw=;
 b=T9Z6sl64Ez7mCu56gxL1T6SGHSWs7Wt/YyyS7qNp9Zb8ZiG0OHHdaofMUyK9omzT+35H7G8z3Nd+wJ7FkOspAsXiDk7UdQjvjMl+g5XiBz67YYElDWhMbOucGtVebqHlOhBdZuWdLcOO1MGfRHMGcj3d3bMZ7LrkNjjs0NQW9FjTI0Za4x6KRdT3cvLIZ6PSb9Hg3qTs9lstcT6b3vB4awMMyJPnx/SpaWGcNHFuIEwpQDdwyLVaH27Sdo1Nz5eGREYUTVilHAgBxEtk/jydEf80eK05zaYKgqcP1JN7lsHmG2lIsXkobOLkBjzQUnqvUXozHY6X27Ed3gdIcGUwiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljt7vpZ3Quqe+P1qzg7zRuShK69IwM8JCXrxQvrP1tw=;
 b=N06r0mzhtjGwln2GPaGiAhqAhOquP0GOdvusA9TqYzGlcAqUo+jOHE4RyHsqUd1VnIdWn8FyCwWJ7SHGRweOv5cvP0QwdIkEh9ZEsrfhfd6jqKt3yHdAOp4E2+svVVIXZADqCkXACfeV2hiA1UGtigJtuy5XW9k2NWEQ2TBAK9DlbTnpyuV5k5r+7Pd3pLeWySq/mApPvbK8Do93p6wa/FfFc6UW6KXy8YxME/hSQPsyLOGkAl4M1u35sopgTJYceoRwbEQL+jr5xPzdDI5HRXs9Hn6OfBqrO3ghYP8A93Rjbr4lAYw6sv1JL0MRPCgI6O3Sgl9s+Y2K/GrRfow57A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 06:33:38 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 06:33:38 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 0/7] Host1x/VIC support on Tegra264
Date: Fri, 12 Jun 2026 15:32:28 +0900
Message-Id: <20260612-t264-host1x-v1-0-8d934987de67@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Nj3RIjMxPdjPziEsMK3WRLc0Nzw7SUlFRzcyWgjoKi1LTMCrBp0bG
 1tQC15YHiXQAAAA==
X-Change-ID: 20260313-t264-host1x-c97171fdde77
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>, Santosh BS <santoshb@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCP286CA0228.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::7) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: 776a6f9d-e8c2-4189-fd00-08dec84c8945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|10070799003|376014|366016|11063799006|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info: Kc2mP9WoOJOQQHxLant8jHezzW0E0gltZW3tmD9LlAJuUr+L7uHBMAUT7O6/9bqklc66Udhhk/Btu/bHpR7rLbAewlQt9wCa0VklADQaW+IO4u3/1r/p/YJ/DeeMx9V6yZDrrs4g6xPGFiEq9MxR08sIJD7YVnCPmko9at3Tcmyz1LdwlInCfIvQ8PpXl9dmN6AoFEQeEfITE/TWHTNBGnhDU7mz7q1S2HovAb4KCWbZ7wOzUAeXeFcXw3Zjr/zppmXPkwo+vGVDAnMW1H7ys/jdlXRKxTTy0mAqD3zf1t76Mpb5+Syow/5zlStIBffAfAGWgXV1yJE81pvpcY3hTcTvUGmQfL3R6Jfc21nkn6qlh2J/G6omoo5fQ+6Rntqvgj1nQZWbkwcjz1ZzBduvm4xpy/uTYyjbwQ05n6BCaMdT7vx9G0b36DVQkBcZnzaUezWCJlpMl2Hufm6ZfsAQ4EJbKeBHCUAfkCi2wlMQ1t5aL9G+f0GOuoNewjY1fm2g2RCtyQsUG0uF1ga8fG4U//l25AgTRquCYEsH+c+GtiUbfYkWwBI/VpnaxYGC230daARtK/deSS0CnXNukag3ONvD6y+8M1Q01K0WM30LVVnV7e7GOOYXjk5/ht77oO23FLI+aluH5sTcAehFRVKWZpOxxV5RTHkyJCPAOMcRpzkX4vq42em5cBgQtfXIZ7KymDh8+7uyc5uWoK3+t59c4ZGp6vRWiLnx3V41EqBKeSEWKKyaaF+IyHSVmXqq8u43
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(10070799003)(376014)(366016)(11063799006)(56012099006)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEhjS0FiekloYytEaStEa1NGSGhVcHVQZEUrZC9qQVNpZFdqS2lIaTVuUUJN?=
 =?utf-8?B?bjJZeThnK3JYOEtRUnRqaDc1WE95cXBhU0s3SjlGRFFFaUdwTzNBb01xWEVo?=
 =?utf-8?B?NW43ZU5icFFQbGRwUWdzZmFmeEo4dWdiMExaNkdtN1dtUVNscnBrU1N3MjJj?=
 =?utf-8?B?SWdXa2c3WHdLeUQ3c1c2dEFIYjB5amFqRms5U3pXYUtTQW5VMmlMWUo3NDAw?=
 =?utf-8?B?STFWN0E2clFEc3ZNcWFvYndKaGZ4bTY3NjQvdGlNYVVpbEJ5UzBMN2REMGRC?=
 =?utf-8?B?bVptY0Q2SVFkcE9HazlHdFFhcUIvM1RkWUJuSk0xbkowa1JwUnpZVzRWajNU?=
 =?utf-8?B?Tk1IZjFhOFZjOWxLM0tLZ3BPT292dEZJQm1WZEtpRjR6OTc2Qy90Z3ovTTVD?=
 =?utf-8?B?SGkweXA5aG1NZldHY2ovNm44MGNoWHNCVk1tRFpiK04rUXlEeUxlMmFtK2ZJ?=
 =?utf-8?B?YW5CYXFWN2lVYzNEMFloM2RWdlM5cDdNQnduNFdmMHByMmI4QzlXSU5FczBk?=
 =?utf-8?B?dytrWjhXS1J1RzhsbHlTM09qOC91bGlxaUM5ZXRWMXlyd2ZPR0pidzByMyti?=
 =?utf-8?B?dWxkUW5qbjllRDZoY1ltaGIxcHNWaU1FcUN6SnVjVXRGVVh1TitmL1BhdUtm?=
 =?utf-8?B?ZWdEa3lGemFuY2lGNkNRZVVqM2J4ZnQvQUh0cUhXWDZBb0wraTJpSEhrZW45?=
 =?utf-8?B?em9pQ21lMWlkZ1kvaW9vVzRCalkzQmRRQjZEc1dHMnVaWVZKRCtkU2NzazdS?=
 =?utf-8?B?YXgyV3B3TG5udnowNGluZ1JOUWZmQW9ySjdTc25DNlhEdE15Mk11K3ZJNEc0?=
 =?utf-8?B?UmdHUytQT0FjR1doZ1N6VThNQ3gzaGc5S1R0SldhTElNOXlGUDZxMmt4Wnla?=
 =?utf-8?B?ZFVlSlhtTUV0RmlvS09kR2Iva09ITXlHK3dSVzFyb2JTMmdlL0VGMmVXUTZz?=
 =?utf-8?B?bzNLbld1K2Z2Ym5CMndYaTVnekZIUGE5dHBtd1lDdVVXVzFXRld1MTFwMUxJ?=
 =?utf-8?B?S3VCOExHUHZSU3ZIdHRuSFAxQ2hienY0cHB4RVBheGNaK1hVZ0w2dUxobUs0?=
 =?utf-8?B?dnBKVUVlR0M0cWZreW0xUzFZUnNTdG1YOHNpdjZ6VHVpamsrUVR0RkdLL1hR?=
 =?utf-8?B?K0FLWEtjZWdjY04xSVh6dzlqcDJ2L3UwRDNoV05RTHh1b1lJTkwxVHlTSGg1?=
 =?utf-8?B?Q1VHa0k5RDhhNEpnK0ZtTmwycHhRcmcvTTUzNHdBN2s3bnVxOS9XSmVqMmk4?=
 =?utf-8?B?T0hQaWJDRUZpbkthS0NHZW1PeU1rM0RKalFxSWZFMCs4bXJ3amE2MmZ0c1Br?=
 =?utf-8?B?VUxUeVhGZFIyQzF1MUxlaDN0dGxtL0lTRzUrZVJtUUVyWmtEc0ttT2toTEpL?=
 =?utf-8?B?dzlVcm84Qm9DYnprYThMTXArb2lYUTFxNUxMVUh0cnEvRXhybFR3R1ZJTndP?=
 =?utf-8?B?aXlSMFhTVkFQREZwTVpYUDlLVXdGbnN0UGo2WkRSU3BqRTUyWlNTUkVTRElI?=
 =?utf-8?B?b0hDa0RWeHpTWHZNUVlSNmpoWXFIMUg5RGg2R3R2eFJJdXp4TWJkVVgzN1dS?=
 =?utf-8?B?dzlxdDhENkFzUDEraVVaelZ4T3VtTEJYYWlnQnMxSnZ1bklOS1grSENaSjly?=
 =?utf-8?B?Z29JNU9va0pkSGU0MmE2SlI1aXhvU3Q4UEtpWUp2WWpPYUxTdG1DSnhkc25F?=
 =?utf-8?B?K0V3dGNqUkpMWnRTdkNQZ080b3RrUDNNUENNWWpwSFJZbWdURkE0bWRxQU9G?=
 =?utf-8?B?blJ4ODNZNEhFSGdvVmVSQXQ4L0ZmejlLUnB5TEVoeEJWZUZpUTE5YThWTlJ6?=
 =?utf-8?B?ZllQWWw1c0VJekhGa1RxbDlxVlU5MU5tdHZJNk5iZHZBOUkvODVnUFFmRTJH?=
 =?utf-8?B?QXlPdHpDRUNWVXdSUGJQK3Y2VmcyQ0oxZTRqRUNwYVl0cG5yQlM1aGRXMDl0?=
 =?utf-8?B?bFBoaUlDQUwwRW1KS1U1K2tieVR0RzYxQkRiR0hENklEd0hOWDlzTG8rR1BK?=
 =?utf-8?B?OGplMmRuanVIa2xGY0U5SnM1N1paWHZVMnAvNXB2WFZjNkdGSWNMeFVRTzVo?=
 =?utf-8?B?TEQvK0xxQmREWlJ4aWluQUE4RmhOK2tidldMckFvb2NhcDVZczh6TEk0bkZs?=
 =?utf-8?B?SnlKRGp0Q2FYVGVFeGE1eWM1c1grS0VQR0xYc1pxc2F5Ri9KK2U5MElObFZS?=
 =?utf-8?B?UFRWaE9hZldQczlFN1JVU2trWkJqWWtpbjZ6czVDTmRqQTM1Y2dFMXUxd0tG?=
 =?utf-8?B?V3RJZHVaUVp5RU9uNkMrOUNBSmp2cU92Z1BVMmpBWFJDR0JFOVJFSExPQ2RG?=
 =?utf-8?B?UVhwblJaT0QxYkJUNFU1MjMyYVhtWE5pclRJeVQ4L3VINllFWXcwczdzQmlE?=
 =?utf-8?Q?1ExAuQ749GmbpV9oH/oe7xcGWanXKrLOYFtzjPdNe+faO?=
X-MS-Exchange-AntiSpam-MessageData-1: idIm1QYCkgI7ow==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776a6f9d-e8c2-4189-fd00-08dec84c8945
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 06:33:38.2099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCoAMdjCHE5p10vMPeWuh3g9W5zYwr/HBt4ErcGSjWCeW+a0Ldg3i9VH/xPeIvc9Z99fzinNHBaAsAir0e3KVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628
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

Hello everyone,

this series adds support for Host1x and VIC on Tegra264 SoCs.
The Host1x side is not very interesting, just adding the usual register
definitions and other information. One thing of note is that multimedia
engines apart from VIC have moved away from Host1x on this generation.

On the VIC side, there is a bit more of a change, as the VIC Falcon is
now RISC-V based. Unlike NVDEC, VIC is still "externally booted", so
the boot sequence is very similar to before.

host1x uapi-test[1] has been updated for Tegra264. Necessary headers for 
constructing VIC jobs have been added to open-gpu-doc[2].

Patches 1 and 2 add new compatible strings to Host1x and VIC device tree
bindings.

Patch 3 fixes the context device device tree parsing code to handle
iommu-map entries with length more than 1.

Patch 4 adds Tegra264 support to the Host1x driver.

Patches 5 and 6 add Tegra264 support to the VIC driver.

Patch 7 adds Host1x and VIC nodes to the Tegra264 device tree.

Thank you,
Mikko

[1] https://github.com/cyndis/uapi-test
[2] https://github.com/NVIDIA/open-gpu-doc/blob/master/classes/video/clceb6.h
    https://github.com/NVIDIA/open-gpu-doc/blob/master/classes/video/vic_ceb6_types.h

---
Mikko Perttunen (6):
      dt-bindings: display: tegra: Changes to support Tegra264
      dt-bindings: display: tegra: Add Tegra264 compatible for VIC
      gpu: host1x: Correctly parse linear ranges of context devices
      drm/tegra: falcon: Add support for RISC-V external boot
      drm/tegra: vic: Add Tegra264 support
      arm64: tegra: Add Host1x and VIC on Tegra264

Santosh BS (1):
      gpu: host1x: Add Tegra264 support

 .../display/tegra/nvidia,tegra124-vic.yaml         |   1 +
 .../display/tegra/nvidia,tegra20-host1x.yaml       |   5 +-
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           |  63 +++++++
 drivers/gpu/drm/tegra/drm.c                        |   1 +
 drivers/gpu/drm/tegra/falcon.c                     |  66 ++++++--
 drivers/gpu/drm/tegra/falcon.h                     |  23 +++
 drivers/gpu/drm/tegra/vic.c                        |  95 ++++++++---
 drivers/gpu/drm/tegra/vic.h                        |   9 +-
 drivers/gpu/host1x/Makefile                        |   3 +-
 drivers/gpu/host1x/context.c                       |  13 +-
 drivers/gpu/host1x/dev.c                           |  41 +++++
 drivers/gpu/host1x/hw/cdma_hw.c                    |  12 +-
 drivers/gpu/host1x/hw/host1x10.c                   |  33 ++++
 drivers/gpu/host1x/hw/host1x10.h                   |  15 ++
 drivers/gpu/host1x/hw/host1x10_hardware.h          |  21 +++
 drivers/gpu/host1x/hw/hw_host1x10_common.h         |   6 +
 drivers/gpu/host1x/hw/hw_host1x10_hypervisor.h     |  10 ++
 drivers/gpu/host1x/hw/hw_host1x10_uclass.h         | 181 +++++++++++++++++++++
 drivers/gpu/host1x/hw/hw_host1x10_vm.h             |  36 ++++
 19 files changed, 586 insertions(+), 48 deletions(-)
---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260313-t264-host1x-c97171fdde77

