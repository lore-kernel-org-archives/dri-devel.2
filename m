Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A5CC5AD55
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 05:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 837D510E27C;
	Tue, 11 Aug 2026 05:07:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RX923bsC";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B58310E27C
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 05:07:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cq2MVy2OZKHNKets4/f/wUS+AGxHLPS1c1cYdnbjkX4Sm2azZ52fy+Jh0cwdVfm+ru9QSoKupesekqcobLzAtTfNPSE4pwmqKCYNnsd04HD1x3o/k2Y7AuAEAH9EdIwAwPydlOtBSzt/q6w3Bn4/jtIYUCIk4/k0a5+MiKvU28KONpf5J0lQ9e6/NayuClvJ8qwIU0cZzDuHetiK2T1odSpl+qmM+6Mw+uMGL/p66jDBEYevweqJcHmWkS5KYp7kMlZVSqU/IH1/H6BcX3Cfk8dCL2VxfYmBLlMmzqFQyIT6RvuMenMsBKa9o69/VR4BwYWhqDuWKGFdQaZcwP5Cjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tCkZn3VnqXFXlgIhUr8k/rMkkBpCNTvKgv2fd4sgW0=;
 b=yZW5D3IR5uzbhykY/FSHYtLzzZapNEVhhkUSW0V/BePcX5L2FR29GXtkBB+N8Hee4UjW5f+iVcj6jHVK8M5yZAMi9puRbHdXNkiWLPBR3B5CPAE1MF/2jie0VQsyoHVFJtLF5TWQSK8vYc/iFu0jTQ5CTDruYjw1viHDSnLjotXhYwQmOQ35L4vZAGPfMrMhZATXIrztUvnvT/rfHb6wJtiZl/FnYeIbcJnlnXzkd6VnsePoBdD4ZT3l2lSBD4+LBGm5kkaEN42YGG1vAEu8lWgZN1AGN4+lFULZO2DPpLc/GyyCxDtcWlNbbYv8HqtFH2TyD6vZ/M7+MS1fwaWIxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tCkZn3VnqXFXlgIhUr8k/rMkkBpCNTvKgv2fd4sgW0=;
 b=RX923bsCFGaTYwB0LYxI6e1RpDW+ozvKeOFT5svOsSWAqgs/F148yxVmeNXcI0Cm8dBKoUNwhWdWMM4fC0yNwac+6C16OKCRvh93vfV818bS1gzqdx8NOiM1NMIHmS6NtNUKHu5bmjCKrYD3gm4YvNrW9vWOHhyWO7vQcdCZv3/ypSg0MP6rq8DcRER2an130hp+e81VMiJ254Sc3kG+fino45xBh9Mqi79Re3odEqOuKgMuzzzk3QSH5y2Mabha9cTgVJFGayr40Tmw+X5GYNF7f3leCJuB6HWq4JkbvSLqjAcNRNl8uYKusV5KBB64G7+mSDnz02ydDSIKBlA/OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 05:07:06 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 05:07:06 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v4 0/7] gpu: nova: Export parameters from nova-core to nova-drm
Date: Tue, 11 Aug 2026 15:06:50 +1000
Message-ID: <20260811050657.646799-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0126.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::29) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af88a1f-a72e-40e4-2fe4-08def7666338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|56012099006|11063799006|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: cgiGAEf3oEUbKn8KjRo/oj/lElF8jqtwyrDrFt5xjCIFu5Zf/gRTLrqjvlXPtacYTlQEct8MMCCcDZ9a0q8WpRtiwaaqRiOS1FSOYSk3cAu5pUwJtl3qd+EkGPAEPbeClnExfC4RnxYWQCTHsVHeVD5Aor0dR/NIGOU5GjGSVsWSTBkP3kdQ6CKy//Un/rW0Yx1U+reVMJoiHgikd6Qp0l625DuDTWEgUMHoWby81E2XpUIzbkKfEryAoK22a6myu9yUnQO5usKcOLLhFUVOCLKxQrqN7L4Gyi1n+0V/RQaXuhCyqSnW6r81ANHUTWf7a3xJHhpsLY0AA+oiS3DY1CMndS042NULD3oPyR/GZG82h8BGAEE/c9WwtDD5DRO2K3OT0hqcSzuWkA0Ik7B3WsTYjooGoYhBqyqxphdcE9CXwIlPxk8p5otVltP7gy8APS7j4l89+AXhWX49EXPmO6DHj3dbRRpV7qayXUVt/ijesECeO2mCN7exlU4abjmBFOqsNZCETGsX449QdxGw6fKySYjXrEVLDHsCm5YXyYK8OT99tUYdpZcI1HGUH7+QuNnAR/rP81SKNMQEL9j37E2O1tkZsHlEdZaPinpaIQwWEf5uelQ8FeRTj8CtFxS1efBQYqLyvox/1vc6nvzhC3Ct+4yWf5lif8TeLk1+P34=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(10067099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4M7c2mHS1Zg+IdzBt8FmyZiROg/ZJqtKz3/n8jaXvRDnKAp18lmuVIGXDGux?=
 =?us-ascii?Q?api/Lt9dXBUoSFXdj0zvQCU1y2KB/XIxI4+3QEdKmOD8SO1CnO4YqUtJRPAS?=
 =?us-ascii?Q?W/RTI1WsZ4QhP0QFJgOmeTLsjLXulmpXH2VOdezCp8KJyQyF0PMf9bFGXSnz?=
 =?us-ascii?Q?CmbF+b53MDQIIDlQ+J7xwfSv3+FHxwE7zU8nOHKfuEnNwPlQyuiW/LF/Anxb?=
 =?us-ascii?Q?ByuQ7tNPjGx4AqyIwbz1DQg2w7dnXmYIabk7KrU9TslgaZdFF8N6/5eAqmrP?=
 =?us-ascii?Q?bus4nJ4Hr9r2FtK350PAo2A0qSkow21I7NXSLCeSH4zSTfQErTX1cugc4wQO?=
 =?us-ascii?Q?Mf47tTOXyON7arzVSIU260p6OI0GCDG8OU4eXH28Vj5MGRXQdA4VRI6fI0aP?=
 =?us-ascii?Q?TW/Ylz7ONeBmOjmd3dTCxAD7tMfJD5vnrnm1Hyxadqnzi4nBX0MU1xGytVaJ?=
 =?us-ascii?Q?985Y1STM7N8fJDVX/7kiMHbCA+lri6b+OGNHHw+FfnSs0dhPS6UA7VaYTUg5?=
 =?us-ascii?Q?TYvoiHxLYi5dUCflOwbiaj4/jrjvftl1iwcji+N6+qO6LJDbXc/QnKEo6Cbf?=
 =?us-ascii?Q?aK6h84emWclTLuJJuSa7lT961AaYi5R+2ctGA/w3rTO+F5Vj6myx0mt0WhVU?=
 =?us-ascii?Q?qFjOWFagCKdzmpCHnrA9N/+sYVBnHqZ1T46ChR55c+nWO5GMQSyyVYmRco6Z?=
 =?us-ascii?Q?oqDFrFX2Gm/8jydEf5DPfLEqcObYvUlzBgD2L8JVBc9SPSYEUfZWyqyzWFMY?=
 =?us-ascii?Q?TQEOD2eLysFAZk9IkKKeL2UerX2XdZjrUTuXmre98K9d3sl2OaleMsBF5I9L?=
 =?us-ascii?Q?Ud3RnYwQkQX45R3w82ZRBECN56F8R5nAAQ4N3+qsJ/3C/NVs+PIJ5GOrlHS0?=
 =?us-ascii?Q?w1zAwJlQPzccLuo3/8NLN/3G4NVqtTYXUD42ztPeAm02lG/FWvy6Hc3uIj67?=
 =?us-ascii?Q?QMNJ3aNhQuWzbcXgg5UEfT4ZGZNe3Wx7n18hSQ+WSSKbYBCoJBhMY8zsp1kW?=
 =?us-ascii?Q?9PZmMkSE/wJauFpXWOHFzE6BcVnKLs09NL1eR7p8KpGQmp1kIw+LDGQWHfVq?=
 =?us-ascii?Q?h9FMDKl/xVoy2HaxZ1+qbe26uRNIZ+uXrY8+6WFS469wmJwfRJzhMApAHNzt?=
 =?us-ascii?Q?72adXvanaswK2Vxji6dhS1+V3GUG0Po+c/WUuuNv4WKEks7qbWSemL30MtHF?=
 =?us-ascii?Q?Mfxqj3BS5SCXNj1kx0WAJspLit9d72RQCmJbDl2VjDtht2YLUC9qxBcaLHQO?=
 =?us-ascii?Q?2y5uqks4zQbGBVmxe6JSrWIrTxbp6W7a9WCKXTSr49jMYYG1VMDcOGfTzDUg?=
 =?us-ascii?Q?8RRJvnrKJ7aPx/Zy0i/Go/gVTqborAMFAO+R/VSUlZ3/62IDBeOweo91f5ID?=
 =?us-ascii?Q?qHsASJta4RYNhb5hAmzzwNHzO9uoHVdDfP9MG2//21hMAxXK9fAeR9IJWLMw?=
 =?us-ascii?Q?1QEiFSvmQlanLKoiObfxg7BS2r63DONOO9Yn7Dj69JGA+DcvPCMCDhQSd/Qb?=
 =?us-ascii?Q?BMXsTp8cf+wfV1Bf3Lb/Tk1kacF4z6PKN8dbs01pnDgvlNdkJlcg9CT3JS29?=
 =?us-ascii?Q?nmFqddpoopO6ldiP78CGWYucqPl0R49ehJdIROVcr8ikf45aIL7UGJIgev0h?=
 =?us-ascii?Q?4HBJV5bwF1eBtgJ2Vp/sG8lsShoRhanmPHcS4z4xsuE4f8w0kpKiGbP/VVpl?=
 =?us-ascii?Q?ypfXUvHLqWXb8rgk9vMyGNSlxQaql98Li3j2eSojn6Pt47ZC35FqX5kpEQEF?=
 =?us-ascii?Q?ZTR06HNdzA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af88a1f-a72e-40e4-2fe4-08def7666338
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 05:07:05.8765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziwHDGSOzkHyo1kEpzcBrUTMqD2KpUlocf406Z8Bd6agBxvqeR3TGjKH/OBOPEW3qdFmlOjO/pXFpVlkyQwh8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088
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

This patch series adds some basic GPU properties via a new GPU info ioctl. It
builds on top of the "drm: Higher-Ranked Lifetime private data" series[1] to
correctly manage lifetimes of registration data shared between DRM, auxbus and
nova-core. It's also based on top of "ForLt/CovariantForLt split, auxiliary
closure API and DevresLt"[2] although the functionality of that series isn't
actually required.

A tree with this series applied on top of all pre-requisites is available at
[3].

Properties are exported via a new NovaCoreApi type which implements methods to
read data from the GPU. This has been implemented in a separate module to make
the public API implementations obvious and to keep them in one place. Auxiliary
bus drivers can obtain a handle to this type using NovaCoreApi::of().

This handle can then be stored as part of the DRM registration data and used to
interact with the GPU via the nova-core driver.

Changes since v3:

 - Use an ioctl to return all parameters rather than multiple key/value queries

Changes since v2:

 - Addressed review Danilo and Alex
 - Minor renames to better align with HW based on internal feedback

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

Alistair Popple (7):
  gpu: nova-core: Add public driver API to nova-core
  drm: nova: Add DRM registration data
  drm: nova: Add chipid enum to nova-drm UAPI
  drm: nova: Add a GPU info ioctl
  drm: nova: Add usable VRAM size to GPU info ioctl
  drm: nova: Use nova-core to read VRAM_BAR_SIZE parameter
  drm: nova: Expose a render node

 drivers/gpu/drm/nova/driver.rs        | 18 ++++++-
 drivers/gpu/drm/nova/file.rs          | 40 +++++++++-----
 drivers/gpu/nova-core/api.rs          | 49 +++++++++++++++++
 drivers/gpu/nova-core/driver.rs       | 44 +++++++++++----
 drivers/gpu/nova-core/gpu.rs          | 78 ++++++++++++++-------------
 drivers/gpu/nova-core/gsp/commands.rs |  8 +++
 drivers/gpu/nova-core/gsp/hal.rs      |  2 +-
 drivers/gpu/nova-core/nova_core.rs    |  1 +
 include/uapi/drm/nova_drm.h           | 71 ++++++++++++++++++++++++
 9 files changed, 247 insertions(+), 64 deletions(-)
 create mode 100644 drivers/gpu/nova-core/api.rs

-- 
2.54.0

