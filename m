Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD4EC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:52:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD4610E03C;
	Thu,  9 Jul 2026 08:52:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XR++IWia";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010017.outbound.protection.outlook.com
 [40.93.198.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FE3A10E03C
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 08:52:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWevoDXHlkw2Fg1CPnPtenU3R18AGi9xoFQdMXo6teX95h49wOOPKbqQCG7wbTGTag56LODFkOsG9kPnLmT/aQ/HpvcKWsztxuicqC26GOgSBwPje37i5Nxjt1q/tPyv0fbqBvWfCaro3E2l/84o0Ttv9PzjPqGceVWuAKEkZB7c2mCqxtAJTgwAKYunSDeAmw7HF2aeH4rE10pw3qhePiLQibnjbVfcYylU8Hw2dEX8EFk/aiInCFt/O+90ruLoxSOUFqVXDD1kfvBge35VM5sAXqOQf8x36q+sgbjZsD/hX43QjYfszhzCpnh9sQ51RjJ43FH0IgvtoATworjAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ql3J5I/F6nL9U8ytZHVoW8rQfAam3zBfT05WCa2rfpU=;
 b=iNP/2+YPucLuenRxGF884qvEoil0WoVYyQZoiB4oW7y4A3wmpcfyQacm9Pr7o47az2gLneBUH6fpOOpp86NTRZTf2pVBLivBrYkhKPFK+aoZuQnnjUI/+mUuM/Y+nsvMJDXLq+KM+Xex66EuI9s3pqNGnTH1HVwTqWPEOCNnGx1bug2j4ktqOqwKnCTOA82W35G3t0dMQTHStvNOhVPSzd8sqfa3jcjB9bKznMtuzx26wwuhOiLXD1reB6h4b5Y8T5T3NeBhv7CwL6d6eikK3+zPwAjDF8U/oup+Kb7JA2+ILM/upeO0E8/wgt8uZ1NLxZIhUO8XWRisy+rvBI3eaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ql3J5I/F6nL9U8ytZHVoW8rQfAam3zBfT05WCa2rfpU=;
 b=XR++IWiasSNa0zu7CtBjfav/94ALiw751RY2J4ZFMAPd4aX4mAkfj5yFWCXFioeBq7EKvpUKjfy/VRPFX2vsXU0kB2C3jqXue5hL7HroHTS/6owAWdOqgDfCFhWmhIiOeCvrvdiBQQKC75zzFYlp9Kk02IGfsveXImWhZ+Heim7i8teTJncaps+q4huxRWFzYrvMFnDl1bGlrD1Qlz8YKWxdE40g5M5VeVUgFn7Y2F9zl8imZ7tOYvdeLHUnvwq4qyfCMJaQUtJUj8Do5jXFnI3IkFHqqY5UxFbuqprvwi6+bRk+CXNoYKO3Z+aKrqsp23AOArwCBEOfx65xQFpZTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DSVPR12MB999283.namprd12.prod.outlook.com (2603:10b6:8:41c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.15; Thu, 9 Jul 2026 08:52:12 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 08:52:12 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v2 0/5] gpu: nova: Export parameters from nova-core to nova-drm
Date: Thu,  9 Jul 2026 18:51:59 +1000
Message-ID: <20260709085204.565159-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0151.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::21) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DSVPR12MB999283:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d8af54-8b99-4fcf-fa6e-08dedd975e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: FVPbWIB6Eh0fhA+PDYLzN4hbE+gc4SdDBW7bGzb7jdAaL9Vo0mteMgZZyMB5kSnGSXmuXBT0jimrF7UVaD52bgA9s+5R3Tm99/OECQTHwMiboacIBDj3b6iNYm2nV4EldioG5VPC08IyLSe6mQlC22SUgCrlSj4JajjolgabkICrB4MMni2W7ua1Fq0nL4USNiRdqdEi8HXipptUoIdtd59FqCRv1IeIBHPrTwURarwM6JvpWiyupr8wbRAgegztpCyGzNc1qkwhHtImCPtW7XcKK/iyfaKn8AfAbBcyyJskyjvhh4Qt9xp5Vl22EzcS07pNgASwY+a7gq98EtmxdYe63IEZRamm6sHXyY08zSHjrz6Lj/jK8Z4rfGUJzcgc3A9WezATPk4N5ucMHA6JoVG55DE+NFe5Wt8Su90na/hUWevGkV7XFPcjHe0lk0MuFFpaSOWuSEjZFI0Ky5G50qeVSf9SMge1AZ7ZqhtushOGDPBF1ev2Do95LeFkeZ3WMdcUIR9qQlH2iAEex4D8dH8qRmdE5WdKQoCsLK45rA80I7U0HIYbYSStuAfCdbiD7pa0InCOEjzM2KJU2mAnZrnZhIWofeNaoscNlZifu0JZgpjFWZ0XUWHAJ0d5hdxEVVsRrd/zhg+aY1ZsjsZt8qkDD43xciwU++nSKFUvhk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(56012099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JmUIQ5DtDqCljojQuP3E0I57+RyDEIx15w/Z3AA0cwCJU4BBFjyZHnvNdMGi?=
 =?us-ascii?Q?3iduSQVua7/+kSS13/L2VP6PSc83RXIpSj5Vrk/74Roorr0Oh6u566xLjpuX?=
 =?us-ascii?Q?pA4OKHUaKK1NKV6JUb0pW6OnxbmtmDsTbKKZAF7ga4ZzL6BSxCCn7CaxElBe?=
 =?us-ascii?Q?aElh+mg+4pyu6QBQoHnq2ABIouhfci/Khk89pa2psE504Ml+zcdHb7QC+lDS?=
 =?us-ascii?Q?34b+cmdVtmDqDZqzKZ22hizCId4g4ZaUxZ//jVcAU97T5G0IrhykTIsVBOHq?=
 =?us-ascii?Q?+XUaMAe4udCvVuLKOQfJsZQSefCC+AkbCoaarzcweg0X0gWPWvAvDM6AlIGv?=
 =?us-ascii?Q?DV2lDGeSi7dQ7LPT4ojekh/ZjhuSo/zgIS4itkst69mOYxmJ8qFh15W1AXPD?=
 =?us-ascii?Q?i2Udxzd2k0YEj3k7xRo64FRP8/ClXYoWE4DdSOtu7qLJ0RtwR7hlWdsHRy8j?=
 =?us-ascii?Q?YCNqvFT1SDQYlDRMHnMuSIyMnJhmWPs2Hgtde9aaYNnlUKGlPUrzbEOZb9VC?=
 =?us-ascii?Q?AV72AtN4vDxK4ig04Rn0K6Xz31e8VMhdsQrql/oKItyonegq1D8WjTTt6XVG?=
 =?us-ascii?Q?D2ZIZ4yPN/2bwpkmXpRADPslO28/a7EaeIVD4ou+CGJBGcQdqxwipMpAfaEC?=
 =?us-ascii?Q?s+WiQ7WTlY8BWyiDdAuK3GFMbQcjKD5BhhKP1uVZM5/McFjd5nfgYQXNU55N?=
 =?us-ascii?Q?6n8/H/x8JOK3aupMkKaokB1MkuHgRS4G2t5d4ZPdWufD3h9Sf4YHNlbleLkB?=
 =?us-ascii?Q?HQl/HMlqmbqlh4f3Eo/orPNe5L868W5kpT/dPCYalYef1Qiyr3RxB5e+/QeJ?=
 =?us-ascii?Q?bd1m38VWlhzNmsbNYZtdIpOxJnK/UjqrL31BOl/2etgcgN/hsfRm0GUoPMpQ?=
 =?us-ascii?Q?bAetmHT2kixY+c8advIiQXGaOHTiEkDZItwkLShV2QIiLJGOqadRCH8Xdj+1?=
 =?us-ascii?Q?RqX0Qq2Mxmo90wRetDLnKyS6uaIGQPVMfV3siGjvnWZLu/8zcJKG5o8EYTwR?=
 =?us-ascii?Q?r59owyXhyJO5SZv0lB603ZX4egz9Aa8Ql6hzWCZofPsWaYC5Sbn5zzYScseV?=
 =?us-ascii?Q?99fBtWQnkwN6YqK6EK9+dvhl1Wy32utkbjP2G37ZowZaU3V8rRNbio+bQu3K?=
 =?us-ascii?Q?nP6XuLyOxcrYL7jcsK7LyEcWR86fO6FdV284n7fZbSDSBeZFfFX68M/KC9RW?=
 =?us-ascii?Q?12glciIZLCoqwKjnT5Zrd7M5PzFli36uMeZWSBbbc8PRxHycR7EnK35tbJF+?=
 =?us-ascii?Q?AhR6veczipZA9W4o0E/aLeQQPbZl6Z9YqeEgBwCuY0K+e+Tv+t9G8GcrEg0C?=
 =?us-ascii?Q?DVUiHPwTHQa3FLDHYscMlf1H21siEQ1KDiRnpV/w7MA4AlLet0WHwmDktDP9?=
 =?us-ascii?Q?woPQsXx6cpVzJUsjYt1aGgy8ce1PSCkOWCdbnFD+bs942/4SEnx2I567KsKz?=
 =?us-ascii?Q?3i/WcdPciVlkUQef4AZBzwj+sIQNIIofeWVOC8SesOcuuD+g8kbio07pvjET?=
 =?us-ascii?Q?MCqg6RFGKvvATtBU01iqaJOMl60UILfY3aiFI98024+w1sS5abCI3A+AS/bp?=
 =?us-ascii?Q?L5UHSHtdM3HYF4J0JUXi59K/ktaSIj6t4ITmgrO1sltBPJlwZZuBokAQe7tj?=
 =?us-ascii?Q?itc3SWja5nPUgev/Pr08N0sylY4Ur3J/9yzueiTrdkOqY6m8tRK8ljKRV/7Y?=
 =?us-ascii?Q?LUcVAGCOnQPeJ2Uq9EeAU+B3x23kPNsH0lPoId1KSeJrflT7WDbOOug/3VdV?=
 =?us-ascii?Q?ksYdyPMxOg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d8af54-8b99-4fcf-fa6e-08dedd975e25
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 08:52:12.4400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNTimJfhkO76sp8rpDmYx8BB0vPlkfUOTsljAEiHItThUVrNm4muokjpetGcdlabIr2JV4PVxMqZkBO2I7BqEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999283
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

This patch series adds some basic GPU properties to the existing nova-drm
GETPARAM ioctl. It builds on top of the "drm: Higher-Ranked Lifetime
private data" series[1] to correctly manage lifetimes of registration
data shared between DRM, auxbus and nova-core. It's also based on top of
"ForLt/CovariantForLt split, auxiliary closure API and DevresLt"[2] although the
functionality of that series isn't actually required.

A tree with this series applied on top of all pre-requisites is available at
[3].

Properties are exported via a new NovaCoreApi type which implements methods to
read data from the GPU. This has been implemented in a separate module to make
the public API implementations obvious and to keep them in one place. Auxiliary
bus drivers can obtain a handle to this type using NovaCoreApi::of().

This handle can then be stored as part of the DRM registration data and used to
interact with the GPU via the nova-core driver.

Changes since v1:

 - Address review comments from Danilo
 - Add an API call to read VRAM PCI BAR size using nova-core

[1] - https://lore.kernel.org/rust-for-linux/20260628145406.2107056-1-dakr@kernel.org/
[2] - https://lore.kernel.org/driver-core/20260626183630.2585057-1-dakr@kernel.org/
[3] - https://github.com/apopple-nvidia/linux/tree/nova-drm

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Benno Lossin <lossin@kernel.org>
Cc: Gary Guo <gary@garyguo.net>
Cc: Eliot Courtney <ecourtney@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Cc: nova-gpu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Cc: rust-for-linux@vger.kernel.org

Alistair Popple (5):
  gpu: nova-core: Add public driver API to nova-core
  gpu: nova: Add DRM registration data
  drm: nova: Add GETPARAM parameter to read the GPU chipset
  drm: nova: Add a GETPARAM parameter to read usable VRAM size
  drm: nova: Use nova-core to read VRAM_BAR_SIZE parameter

 drivers/gpu/drm/nova/driver.rs        | 15 +++++-
 drivers/gpu/drm/nova/file.rs          | 24 ++++-----
 drivers/gpu/nova-core/api.rs          | 49 ++++++++++++++++++
 drivers/gpu/nova-core/driver.rs       | 42 +++++++++++-----
 drivers/gpu/nova-core/gpu.rs          | 71 +++++++++++++--------------
 drivers/gpu/nova-core/gsp/commands.rs |  8 +++
 drivers/gpu/nova-core/gsp/hal.rs      |  2 +-
 drivers/gpu/nova-core/nova_core.rs    |  1 +
 include/uapi/drm/nova_drm.h           | 47 ++++++++++++++++++
 9 files changed, 197 insertions(+), 62 deletions(-)
 create mode 100644 drivers/gpu/nova-core/api.rs

-- 
2.54.0

