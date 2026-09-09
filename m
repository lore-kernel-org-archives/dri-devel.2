Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31702C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4856810E112;
	Wed,  9 Sep 2026 06:45:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="i6/OwVg8";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011009.outbound.protection.outlook.com [52.101.57.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FDC410E112
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqAg0S+Pk0HDPjeZQd2q82zElqKXMyLU8nN1pEbodfMu1Tofx76P1fxVSQ4K4SEj3HJk+GnPQ8F9uyI7lI1Cfu2DlzviSEOpTnVsLPq+LXTl2rlHGmtyde7pIM+2A9CogC9Q1l1WLdSMbzPLCpz5SOpulkVt8xhN7ylR+vChhXhinavoQwhvhnMx0JQfiJU5x8iH0BzlVXSbxLx3UclwwS4FTltvRq0UBDI8TFSUOgTLw50LUZq3X7GYn5V7wYBt/4F1mF8EVUNm/B/hXxJ0quXplqOPUWVcExOZw97Wgj6m0CiGIAqz4IrqvbaMVg74r7YDXmIMeqvp27IV5HrdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6A6D6jkA2VAmDeL7qleMr/9R+wAFIsmHypn7zIKpeQ=;
 b=kt0nL0f5u9f0SuYtlWbTm7/pFeMJwgXPHrnk7Tnhc1e8jcGp6tVhmC45SABs9i24cLNjEzaZrmhDJY9Vf7n76/07vAAHdJ1l0xT67H56pA4wxjBkXsqEQnjkKg2QCdGbWrECvRRlSOKc6xFHuz/xivWq4lpMkYHfVjuWeBy/sBE3ov9AysqJRWtv6fY/2HOaK0iciUYyyW6wD335mLXCeqIHUM50hPZ8bqeyF16SzVOwrLNiQVI0KSk16LA4pUqDjtVt4wbiaGSI8MJxdLk6Skgwyk9WcyiWXid1lxjrfSx1ao71hIas0z3XkcpQBwABwB9m93tekVoCyHokYHAydA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6A6D6jkA2VAmDeL7qleMr/9R+wAFIsmHypn7zIKpeQ=;
 b=i6/OwVg8tpxmEMvJry1WfT5gi17TJ++bS38fpOUoL4PU2wwOY+ievCphGdkc3UujMSqYqnVOAcVgoF4yqsOhyuGtedYKo1A9piUPCAfpXJRUr1WmttlloyJiPFEeAmSJKNgg4kD7BimOEmjJg2XY+YckLEA3tcJo+Pa9Y6YQbVRZFvmyGmPWCIW5p/vwqOlG15dRhpNgGHzXC8ii3oHDAwYzATZAk/FKG1bOIPnXADJNcU6A7qQxDSWxDZYVO4QglElGL2zFcc+6MorYh7qLt4Z9ycGfQLYni5NwSG6ZgMl9qlAin8/8jMDiNpJsT0ff+6VmkndpDkYleHP7mXpvqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 06:45:14 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:45:14 +0000
From: Alistair Popple <apopple@nvidia.com>
To: rust-for-linux@vger.kernel.org,
	nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>,
 M Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v6 00/13] gpu: nova: Export parameters from nova-core to
 nova-drm
Date: Wed,  9 Sep 2026 16:44:53 +1000
Message-ID: <20260909064506.910162-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0174.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:24a::10) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 070765e0-ba23-4a47-49fb-08df0e3de74c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|56012099006|10067099003|5023799004|11063799006|6133799003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: gE2yhE9TxDvOwfPuEVNaKnpNtSAFeoW/TybacXic2iR0dAPJbxxBL3QnOMkkDUoOoSh9bWJLlyw94AvJZ5CwkLzPtDsWZ89cUDPoyX0xwp3bw+XhUiRbaOtQ9ermEZog2PLS9eWyGSgafHLxNqL8xXdIfZD52GU/NYU6m3+wfpR+duHe7JOzb3XdOXtk0KR7Ckl9PyqBbLOtdVz+fjg8hhax1fRbXqMcTqFbS3Hu781fAqozrsduQjHRK08OkTMqHfdHQHTvGOh2SnjITdIEOW5fYlFV4fSQDT8rcU328cbKVtK6HP6nSZzm5cc22LN5E2iG16mmjSeRh1pZmDoixOPFPW361Vm7E/dmKiW0aSjpSdqp7iLSQ9YUEN6zEu/TYrfTO77LG5h3vkBsQjeeRWjAE2NpKV8qBZem/XPVrWEmMMrUrJ9MZswAChRfme3+bFnXMhR3MHQnwrbJAFaoepqN/HVXBc2u2HzM0GormStSgjRKgh3eNB36mV1b3oBAMPWNc8F6mxFHXFC/c6Viiq1GPsoobPVgDTVAyubbPeishgOSGmE+Cf/pHTSZGIjoA5YWdS2B+AYlCA/bMolSSeC4AdYIj51yyvJ5aFaEdgZn/tpYpTUgX0BX1wJkXxo4euLK3JKTozjQRMr4bUaVK308OInYbZZgVlcqSBS3Z/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(5023799004)(11063799006)(6133799003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q0EHpCcL4IvssspBAW7DDiamnVsP5bBMuQla3kxj44+bJxFPls1LEK4t+CVR?=
 =?us-ascii?Q?lq6ElcZO5JG1FI0WibKecMgeaLiZIcleWNIxfZR/i+SSi1vawIYMOv5y0z+V?=
 =?us-ascii?Q?C/AugLfS9ROyhdQZkJxyuAQxGO2kgPTMlggHUd9nVfQEk1XYnXIlnJeIb0J2?=
 =?us-ascii?Q?KNij30YGE39PiHuqh5/Q67d4to22qF/A3095cC93r9EWn8VIgQDRyBsqBspZ?=
 =?us-ascii?Q?gok3GVZZbw5xu8d0Z1szIVJf7up6v8g+doSOvlPytJ2GhTVszFoHkJz8PtAU?=
 =?us-ascii?Q?ovAkI0NjXu9MCPSNXQnnAO3/Vt6jhXorTavx1EBgveHRy4p4+2FQUJPKa47m?=
 =?us-ascii?Q?8ipG8238+WrQHs4pLXtDQt25xwRbCJczMwu0XPczlHx6scSl9qkvm+xJj94/?=
 =?us-ascii?Q?R0bFtt9oWsmcyUqjwc/whRbHXTD5kZqCteSo90g080A3QyK8w1UjXjFqIlIO?=
 =?us-ascii?Q?fi4SHZoF1YCND1l6nV4BOrd80zuj6aDbBsKTeuXOVH3jqn7M8FdHCZSPlV9w?=
 =?us-ascii?Q?iHpdTg/6SYt8BomPOT7Hhj8tWkf97UkVyanDG8c/rQOecuw3ukfzMVUfIN7n?=
 =?us-ascii?Q?XoVX9em4dWSPZR16da8M9P2X70ogtb4G3k8iQNiD9O8ie/faru1zo+oWzk2M?=
 =?us-ascii?Q?MoKTUbjVGBGo+Qe1WbVdjo0Odad7dqXY9/FBmEQ8jNG0Q6Yu/N4ctPnnyokN?=
 =?us-ascii?Q?6NO3d9aXNE+0G0+zSw6cAbXwHiOzXwKhfbSy9kT8+BYfH6j1FDchQlP3JVma?=
 =?us-ascii?Q?ngznZQC/hgO8bPll2UutbK9ByvSViSuXPudfjk6CFMV4m7bmnq4IMXSJyRXu?=
 =?us-ascii?Q?/JZCrJjCgA9Ex9TiKjZ3mTOzV9ooCUsG7rrzU4mkTcHqvG2E3Fd2r1LWKT6p?=
 =?us-ascii?Q?hn9RodF5L3YKpafjEi+rPvi75ZTkfGEZlXQh2Gf07QMgKtUTIU7Cqs8FVJPi?=
 =?us-ascii?Q?+Zrifv8sHAdby6ru33+89pXE2cO8QiJRa9ONru6e1QhF7Jl4R/ZPi30i/CqT?=
 =?us-ascii?Q?TolVgYV6m8W52p2Qf181PvIp5o66QLwKzHmoh+o3rKwcX6PB6BLXxmeBTPsc?=
 =?us-ascii?Q?lnu2lU7MVXn5FkP2W2ggNWAp2IEY2cwy0DjG45VxBAIU+9dMtZHVdn8OK+6S?=
 =?us-ascii?Q?F3+BcgeTk4JSZoGdCm7BOFEV/uEDedkbFsFxBIETDOR+ZxFt/aiXruGM7q6i?=
 =?us-ascii?Q?ZFWxcNQWOqbfDGUhPKAoZKGOwOyEDnUDAhSFIQ/S+lW0dyTHvkdV/RtpyfHD?=
 =?us-ascii?Q?c9LEAdDd6zdjptBsGwLIzHlftmL5/7zNHJkGKGd2MC26O3fMG5VldRjoiuXd?=
 =?us-ascii?Q?f8McQabsf3bkPYtmuuBVDCquh6bwSNekfUHHZViw9pBnBlvMdbueRgsV1RkU?=
 =?us-ascii?Q?SYg5Ry0gYBfaLVbRfWmynPYsgb/tQqx5reUKfRO0xDzx8QTW+64P2+jj/1lE?=
 =?us-ascii?Q?+ckKv5+BWuBjGY3jZb1Qy/HPWXV0sLhGjtFn4DtSsoN6mrGtO7K7bnyrzCjz?=
 =?us-ascii?Q?7oOfTcTb1B35lKGDl7SOKpdn3j3x1lYKL319d+Ksfz7NtlaQ0fCJTbL1EmxG?=
 =?us-ascii?Q?LARmQ4xF8iPTTNF33WfU+qjSdbeHJmFGvR7bCUYAo9lagaS5WNYLIUfZGBUz?=
 =?us-ascii?Q?hFv3M11k+Ra8g/UP5QWBf8QSmroYNb7EiI0gRJoql2TxXJ+VEl0zK2Wok97q?=
 =?us-ascii?Q?CLIGNtrYxGeVQbsYHRowNm9zBYM4G6wXybjerywmWPR76bISplWuBiSxgc8V?=
 =?us-ascii?Q?lbvpUAM6qg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070765e0-ba23-4a47-49fb-08df0e3de74c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:45:14.7611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4heOjfaOfO9qpIcTLup3S9GrC6d1tNXh2qK0x2DmqnHZdcizrGZMk0fAYsp/49vXll9mGzPTWQlppx0whCJwQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
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

This patch series adds some basic GPU properties via a new GPU info
ioctl. The goal is to provide enough information for a basic CUDA
deviceQuery sample, and the equivalent Mesa device properties, to be
populated from nova-drm.

It builds on the "drm: Higher-Ranked Lifetime private data" series[1] to
correctly manage lifetimes of registration data shared between DRM,
auxbus and nova-core, and on "ForLt/CovariantForLt split, auxiliary
closure API and DevresLt"[2]. Both are now in drm-rust-next.

This series exposes a latent build breakage with
CONFIG_RUST_DEBUG_ASSERTIONS=y, as nothing from the uapi crate is exported
to modules. The fix for this has been posted as a standalone patch at [3].

Properties are exported via a new NovaCoreApi type which implements
methods to read data from the GPU. This has been implemented in a separate
module to make the public API implementations obvious and to keep them in
one place. Auxiliary bus drivers obtain a NovaCoreApiHandle using
NovaCoreApi::of() and access the NovaCoreApi through a closure. This avoids
assuming registration data is covariant. This required a small change to
the auxiliary bus registration_data_with() closure signature, which is the
first patch.

The handle is stored as part of the DRM registration data and used to
interact with the GPU via the nova-core driver.

A new info ioctl is introduced which provides an info type field and a
method for reading extendable structs containing GPU information. The GPU
info reports the architecture and an opaque chip identifier along with
the usable VRAM size, the GPU names and the GID.

This series can be tested using drm-test[4]. The merge request adding the
tests[5] will be updated once this has been posted. A pull request for Mesa
has also been raised but is out of date. That will be updated once this
series has been merged.

Changes since v5:

 - Export an opaque chipid alongside the architecture instead of the
   implementation.
 - Access NovaCoreApi through a closure based NovaCoreApiHandle using
   ForLt as it will not remain covariant, based on a diff from Danilo.
   Add the auxiliary bus change suggested by Gary that lets the closure
   return covariant sub-fields directly
 - Expose Spec and the GSP static info via accessors rather than
   forwarding methods, and use the validated GPU name accessors
 - Rename struct drm_nova_gpu_info to drm_nova_info_gpu for consistency
   and document the NULL data pointer size query
 - Handle the size query in write_info()
 - Address further review comments

Changes since v4:

 - No longer export chip-id, instead export architecture and implementation
 - Add a separate info ioctl with types to read GPU info as suggested by
   Danilo

Changes since v3:

 - Use an ioctl to return all parameters rather than multiple key/value
   queries

Changes since v2:

 - Addressed review Danilo and Alex
 - Minor renames to better align with HW based on internal feedback

Changes since v1:

 - Address review comments from Danilo
 - Add an API call to read VRAM PCI BAR size using nova-core

[1] - https://lore.kernel.org/rust-for-linux/20260628145406.2107056-1-dakr@kernel.org/
[2] - https://lore.kernel.org/driver-core/20260626183630.2585057-1-dakr@kernel.org/
[3] - https://lore.kernel.org/rust-for-linux/20260909060623.888777-1-apopple@nvidia.com/
[4] - https://gitlab.freedesktop.org/dakr/drm-test
[5] - https://gitlab.freedesktop.org/dakr/drm-test/-/merge_requests/1

Cc: M Henning <mhenning@darkrefraction.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Benno Lossin <lossin@kernel.org>
Cc: Gary Guo <gary@garyguo.net>
Cc: Eliot Courtney <ecourtney@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: nova-gpu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Cc: rust-for-linux@vger.kernel.org

Alistair Popple (13):
  rust: auxiliary: let registration_data_with() closures return
    covariant sub-fields
  gpu: nova-core: Add public driver API to nova-core
  drm: nova: Add DRM registration data
  drm: nova: Add GPU architecture enum to nova-drm UAPI
  drm: nova: Add chipid enum to nova-drm UAPI
  rust: uaccess: add UserSliceWriter::write_truncated()
  drm: nova: Add an info ioctl
  drm: nova: Add usable VRAM size to GPU info
  drm: nova: Use nova-core to read VRAM_BAR_SIZE parameter
  drm: nova: Expose a render node
  drm: nova: Report GPU name in GPU info
  drm: nova: Report GPU short name in GPU info
  drm: nova: Report GPU GID in GPU info

 drivers/gpu/drm/nova/driver.rs           |  19 +++-
 drivers/gpu/drm/nova/file.rs             | 109 +++++++++++++++++---
 drivers/gpu/nova-core/api.rs             |  68 ++++++++++++
 drivers/gpu/nova-core/driver.rs          |  48 ++++++---
 drivers/gpu/nova-core/gpu.rs             | 111 +++++++++++---------
 drivers/gpu/nova-core/gsp/commands.rs    |  31 +++++-
 drivers/gpu/nova-core/gsp/fw/commands.rs |  15 +++
 drivers/gpu/nova-core/gsp/hal.rs         |   2 +-
 drivers/gpu/nova-core/nova_core.rs       |   1 +
 drivers/gpu/nova-core/num.rs             |   2 +-
 include/uapi/drm/nova_drm.h              | 126 +++++++++++++++++++++++
 rust/kernel/auxiliary.rs                 |  17 +--
 rust/kernel/uaccess.rs                   |  14 +++
 13 files changed, 476 insertions(+), 87 deletions(-)
 create mode 100644 drivers/gpu/nova-core/api.rs


base-commit: b705c185105762676aa6ec16cf976101df87cc35
prerequisite-patch-id: 76f69e9677d66758b273f8415cc7785347544655
-- 
2.54.0
