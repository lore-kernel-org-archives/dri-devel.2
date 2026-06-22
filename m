Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B38CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED00410E2C9;
	Mon, 22 Jun 2026 08:23:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="A1KJH9gH";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA8110E528
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:23:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iv9qWxwxuIW/OlkOwlpehVmIgUiitNZ8P+OTfLTIoFe34H22WNPnk3LLvWtO5mwYkPf6bOp28Qc2pwWH6k9kFCw6t/N4QpaKnY1erVfgCdFH4PRzixFLXrwYCX4XKQnur75kKj4M4ymIWFd2Bkx5yuFnh6GgNd1UnGSn2YwgiVT2SVzJWZuBYMnwWZJZig72PMReJA3kwWfVKNIYnF6JCH3nOVWPWsKsGIc5JtR8xkLJlevvlIDqUWT7bgNW0LkqFqJF3Fnr1KxjMBfNdWwOMwsB8sqjRkeT4oQ8nMv8ftThJIttU6qPvumznS5QB5DNxiqKhzrBS9rO8rWYRN+vvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNdPpNUeNHZtnjgcp207flR6Yg2t8FHvULsQbRVoMHM=;
 b=LFpe12oXmQFw8FPZEZc1tGxnS6Lo6qHuTe2It83bJfzzjuIxg6HjJ0IIhAXE88w9CwSS93/QNW3C6BWZe0AvCIM9KfzeXgwkPu/gCMGDDcA7kTc1keyL6WWP7dFCqIQvOHGpLlNuRn0a2JiHX7FcVBq1mcMAXvECWtup4bYerf0tdv+1WN6/5xXb/MxegX23QpWv+2P8Sa/220N8GyZ/2zJ1U33KGhkyw9SFkeibMFWc7jlpQG5hHiakJ4k8vRWD0P1V8yeRaZedgllUzNi5lDnsNInUbrMnCJyRsHZ1dt31G/U4hIo/0ChYur5vrssmVntVVumBAO47SVwJoe7K+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNdPpNUeNHZtnjgcp207flR6Yg2t8FHvULsQbRVoMHM=;
 b=A1KJH9gHjqCgo9naLWv9+9u1DHDwAjRFSYAfBgDf0Foq+zyupQMaAdvfdp7iAczIV6sh46694Fz1LgMhIwEnDfmp6rqanb5vYR5sODbVD62W7NVewwLQCeXaE+TTNqVLbgkQDgYQqiKNnDVQWdA+JXH5dvLLtwjvd5zPG/shROlucBFr7D2P0Ks7njVtKBBo3LvFJMpHlXUdDmtgkaOV0akkzE9B61n1lKEOiW4mJVfUC0LK5u/MaDndPnE0M9jycfnrm40whAz/xlYZIDv+KRx/k3N3Q8w9H12vrNcTlJ9myh3zGwvfKqyupWEN0it7NLaADsVIoJ8oIq9yopCg9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::623) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 08:22:59 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 08:22:58 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 0/4] Support partitioned Host1x
Date: Mon, 22 Jun 2026 17:22:49 +0900
Message-Id: <20260622-host1x-nohv-v1-0-65bc682a617f@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0NL3Yz84hLDCt28/IwyXQNzw9QU82SzxGSTNCWgjoKi1LTMCrBp0bG
 1tQBIgylTXQAAAA==
X-Change-ID: 20250919-host1x-nohv-071ed7c6ac4f
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
X-ClientProxiedBy: OS7PR01CA0147.jpnprd01.prod.outlook.com
 (2603:1096:604:25c::12) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e55c16d-f331-4736-9dd7-08ded03777dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|10070799003|921020|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: TxAJfVQQJXtW9iIzRhukX9pjryKqItPRfE9mTwQD119GGS4aFoEyiwS9pX1NVUMvoyeba3YhyIvPdr0XwhIuvCevQAkWcsEUiNKh67aN5fsr/IHIpgZ3lHGhBqvTfX92TUVZHeuwOr5jHVG11zo1zgxIlT7Jh97HrAsJr0movM3RdXRb67Gz3uaJDeX7xMG+tPyICOL1Y+wJ7UUUpV4Msd9CW6CsXy0lXeDJtjbCNR6slmMs8iE/Gad6yQD5Zs3Se9rs/5u+VImu2eTcCDbVIA4f1bxbUIkKmc7sJ7sqZGBDaXFaoBtCH3Di0rw95kD1A68PwSfhLWmfU2SRoncmdjWQqD2+FE620BBNpEeBjUiWPgtwnlTeDTxn/8z0ZidS7V5kyQPZjPVAcQcU7/0adtQI5UbF7FQX9lCUvAZChy7PAWUhYdSUsm26FMKAsuYKfc+vfAFgUENOQWronKo3z8AM2U119uY+Lo4inQsuqkXPXDzwrxF11h+jVcx5tiE1GZ8/feMGN3xKn+AI48eNdBnQ5ENsz35gGVp3ff3tSoFEEBayfsOrpZIRfhPiYcn0qH8bYS3hcx1Mw0ifihBhEeXeYXJE09DSqBbfQYte3fjpN6aS5eAam4dgJ4Xq/M/CP+QvRy4fzWwsxid2eSPjJXRLFh2vsyAjKpIMuV1MMECDa4c7byMewLQg7gfQwqmKMYyr10SEaQnliF5ZBgrRng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(10070799003)(921020)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHVPZUpnY3RoNmo2c0g1Wk9ERWNNRytYdHFxS2FFOGdJaXhmeFgxa0s0azRm?=
 =?utf-8?B?eERHZFhXYXNMaFlVVWZDa2JObFlybDFrdWhYVXpucDFFTCtNNUhWZWJLMHcx?=
 =?utf-8?B?NDVZZEFBOU0xTmtxVkEyYktyaVo5aDBObThHUFozeFpYZDRRMFVhL2Yxd3RW?=
 =?utf-8?B?bE9TcWpyamRVYTdrbGt1OURHL0hFS21IbExxbmtJZzVMM25tTUlRM1Erd1VN?=
 =?utf-8?B?Skc1eFd5TDlSRlpxOHNiK1VGZXgvOXRlVG1wbWF3di83N0dzU2RQeGh3Lzh1?=
 =?utf-8?B?SDl4akx3ZnlnaHh4OVVlZGszMVJhcm1VNnRQMldBNWRlU3NlS2lTeiswb054?=
 =?utf-8?B?OGlzRVNmZkg4cGd6Sm9pSERzbGxKNEFTVmtraS9NQXZXYlFvOFpxQWpIcmJ3?=
 =?utf-8?B?a0RIUHFxZEh2bDBSemxsd1F1aXZoNXdUMUF3aDhoYnVqRmNCb0cvNWd5ek5x?=
 =?utf-8?B?MjZ1T1RyYm10S3dSS29oVjhoWjhuRXZQY3ZVU0g1RnZ1VDU0VU91Vi81Tmlz?=
 =?utf-8?B?aGhZSTRHbDN6c1JONnR2NytsbkdNRENvOEdDQ2RBQ1RReC90T04zMXRMOXp1?=
 =?utf-8?B?OHR0ZnpFZE5DaFJkd29VV2QvZnVRR0xhZklXT0EyYTYwNWlsaU81S2ZLaVBC?=
 =?utf-8?B?ekEvTDRPOGdDT1YyQVV5REgwMFY5bE51SzRBTDB3YkkxOWNyS3I1Sm43cXBy?=
 =?utf-8?B?QXRTbE1CZzNFUkw1WFV1YU9zZnBRVzBxdDlvVklJd0JVYnd2MmxuR1o1RFhv?=
 =?utf-8?B?SnJ2SEQ4YjVTVXgvQjU2b3FoN1hCUGhaengxdDhaWEQwekNGSUJrclFLMUoy?=
 =?utf-8?B?TXNnQk1MZi9ZM0ZYOU8xS1MzSC9qck9FazdGQjdCTExiRktudEdDQmVHK3Jt?=
 =?utf-8?B?dnppbGxuV3B3SXNPZ2pXS3JmamRET3hxMVVIV0hGa2krZ3FNNXBpUDZKcDBk?=
 =?utf-8?B?dEtGbkVyUzk4L0xiRVgzbjlURE5FOWhsV3NtWUV0SVV3cEd1R2lSSjdBRHgv?=
 =?utf-8?B?eVpnM3E3V1A1enJBUjU5STlDSkxvWmd4Y1FCRkMzQ1VJS0FrQ1IvUmJXdTV6?=
 =?utf-8?B?SE16cEpEMmFJVTJvQmZrWFZwZlo2WGxnZlFkZmsxRDFhVU5rVURnS3ZJRjl2?=
 =?utf-8?B?Q0E0Z251RTlIQ3hEUHdoTlF5UlNtQ1k2NkprWUFYamdzcjJnejhidG1sSDJk?=
 =?utf-8?B?Y1BnOVBveHBOakZQZDBIMVB3Y09xUDkvc0hFUXFPcDE3a0haZUllWHRvZXcw?=
 =?utf-8?B?OXNKYlJjSlFDK1p3K21GZjhOMzJDT3NXSlZOeXZScVVMaGEwUTBwKzV1VEQx?=
 =?utf-8?B?MGNhWFRsR0t6M2hkVTJNMEU3R3dzNUJZRmJ5WkZheS91VWxyV2dYS01laElS?=
 =?utf-8?B?Mjc2cXNOVERhUmlVMUlFN1BLQXVPaElQR3k0UjFZQWlDZy8vTGlTcFBJTTVa?=
 =?utf-8?B?bzFuOFBOMjZWYnhhc2J4ME9sMkJKdVFpNVJPWkxlV2VaU2k5SnhCUVcvYUo3?=
 =?utf-8?B?TytrVnc4dEZCai94Q05BSEg3VS9kcVc2RWF1UC9aMUp6WVl6bGtxMVQzRkQr?=
 =?utf-8?B?NUdtVFBFYU1DaVlLUVZSWHBzbzZOenJQcjdSbG0za3JlZEdiZ05uT1dvMXZv?=
 =?utf-8?B?Z29adzlyc3k5WDFiV2lPWDJKbGEvOEZjRUtXMjZVeHEyb2hzcVlqYnc2Y0Za?=
 =?utf-8?B?RUsrQVZrUUJycCtmSmdjL1pycXRFVWFYSlduVE5vU3JDVjBaQ25JdTlwUmg0?=
 =?utf-8?B?WktNN0FnRVNNVDB0b2FBcG9veWZTKzlzTTB1bzV6Z3JxN2lPN0htSDU0OUY0?=
 =?utf-8?B?RlRhTkh1QzJwbTVEeC9CREJsd2tVdk9hMGFBT3lscm5pQmtUdmFhd2dnVFJQ?=
 =?utf-8?B?VTE4UG1UR1pNV3dJMXMvU05oQXNyNFAreHNNNEVxaDcxYjZFN2pDdE9KalJW?=
 =?utf-8?B?bmVZQlZRM1QzN3NjQVhxQUE5VUZ4M1EvcWhvRzUrclMxanN0NjNmSkt1cWNJ?=
 =?utf-8?B?R0pmcjlQZldsTFlrTXpKbjBGNVZXRlp5S0wzUjNxZnhENU04Ujc5ME9LM1ph?=
 =?utf-8?B?V0VvbTVQOUpxalFiMCt2eE5YWGYvdC9Ib3BrMmNIQXY2Z25IYmhIME9pMW1k?=
 =?utf-8?B?Ykc0ZzNjM1BZWHlFVmVRZXg1L0pUVWtWTmlBVnVEWndHSTd1M0J3TnJTdVFN?=
 =?utf-8?B?RW90K01Wc2l6RGc2b0xTKzlSOEV0b29QRGZSZnoweDJDZ0Y4MVdLa080ODhj?=
 =?utf-8?B?ZzBQUjNUKzgrRzVDZVFnSXRoK2FXWU0yQjFaWXU3UlhrNlU5cUNVd1F1Nmpy?=
 =?utf-8?B?b2N4dVdNM2JJU2FINEVoK29qNWpWa09FTHFvY2c2UUdYZlMvN1FxUU9yWld6?=
 =?utf-8?Q?MnsGZNUAkkUbfDThI1MM2C/kMfEr8N4CXU88w3b75Ryw0?=
X-MS-Exchange-AntiSpam-MessageData-1: 4l+t1Dch5SSAXA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e55c16d-f331-4736-9dd7-08ded03777dc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:22:58.7047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FkEFa8/JQsHUwlWjbJYw+ElVLz3DRmPEoY0B7bbiEjvDZ/AuWRZgiV8m1HZbgv9eop2osw61dS9Un9LzbFIpQ==
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

The resources (channels, syncpoints) provided by Host1x can be split 
into multiple independent partitions similar to e.g. PCIe VFs, which can 
be assigned to virtual machines, non-CPU embedded controllers, or other 
bus masters.

Each partition has its own MMIO register region and interrupts through 
which the set of channels and syncpoints assigned to it can be accessed. 
This set is configured via the hypervisor MMIO region earlier during 
boot.

This series adds device tree bindings and support in the driver to 
function when Host1x has been partitioned in this way, by making the 
driver work without access to the hypervisor region and with a limited 
set of channels and syncpoints.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
Mikko Perttunen (4):
      dt-bindings: display: tegra: Make non-vm registers optional
      dt-bindings: display: tegra: Add channel/syncpoint range properties
      gpu: host1x: Support running without hv/common registers
      gpu: host1x: Allow limiting usable channel and syncpoint ranges

 .../display/tegra/nvidia,tegra20-host1x.yaml       | 52 ++++++++++++++++------
 drivers/gpu/host1x/channel.c                       |  6 +--
 drivers/gpu/host1x/dev.c                           | 52 +++++++++++++++++++---
 drivers/gpu/host1x/dev.h                           |  3 ++
 drivers/gpu/host1x/hw/cdma_hw.c                    |  3 ++
 drivers/gpu/host1x/hw/debug_hw_1x06.c              |  3 ++
 drivers/gpu/host1x/syncpt.c                        | 21 +++++----
 7 files changed, 110 insertions(+), 30 deletions(-)
---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20250919-host1x-nohv-071ed7c6ac4f

