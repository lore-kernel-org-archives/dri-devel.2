Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD827C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0446810E55A;
	Fri,  3 Jul 2026 06:45:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TLjjxWxQ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011035.outbound.protection.outlook.com [52.101.57.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF8FB10E55A
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 06:45:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrbACNXYhWnsF/xSgPjwvZTEjfrzgkGRkC4S6y4eDS2oQ95dX01ZfisnDdApuEEf5J6O3YiyUN593NpbyGcY1fdR82+/WU+rmZBTxH6Ua5txrilTdICRjbHy74ty/R3HYbPjjKsg8SV6UTwSxU8HCDDp9phtJdU6tIAAouLnA4JtDD+2u/RReYFP33Czo9CaZVdrNwTIPd2JrtDtlfs9FY0ltj4OKvdiouuXQl3NYuZgCutNlniqhm+KYirij2ubiBCM3zVbw+fETmg5YTh/eFs5CWKYB8dSdozb1vgSLkK1Yw6wq2cnFgitrxqgYvEDDHPfArgsM6VjUdSn0KLnzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNbNAiuzbMxK4pYloK60TOIjE8rMlAR2UK/tZ5xb52I=;
 b=bzd1UiaVz66u2WLzbE6z5IeAo8DlE2qOx/Yjg7J6ky76rbv8b7+rfG1OSEyeSANF+dB1CNFa6VOc53XPoyjCQXTGWkA74XgypRw/8KvP80CwsMNVX8cFN1gacQs2iD25JLdxojSAOMNUrbE9VEQ5keLIJgjaxRAD4mc+DB78OWtbOsnzhFqn9p3X1Fg6AV4L/qNSjdO03pXUYq/Vc+/ChGlHbmT4CORDIhSwL8a/uQPAO0cbKljNwm+xfH1cYS7E8CrwSSXZEiKrz9+ba6VYMUr9prNCsovysM8jhidrOTb7Ey3vbuaulzUIvLQJfHRmz141yYLgZrTt6jrY0j8aXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNbNAiuzbMxK4pYloK60TOIjE8rMlAR2UK/tZ5xb52I=;
 b=TLjjxWxQljCFrKSg5t16ybJQa+/ZeY0IEYOJuNE2lVJRd/VYAlRcALk+HMcr+HoEK7R7LaEmhuof8XcHEnshwHKBTn1TT3RfNBJOCEWwBp2vicMkv0m3JW9h2VsqtjrpmKqBkqul9LFEZ2cHe1EvZEhwIv+JBRrMw8ePCkkY7lqe75rB4uwLYuLCbRhQpdHKGV/zRzAUaLuKt/oDOImhkEFnhf+edQlSkpkNzFW7I+AhJ8WOub7qx41wI//isi6B+tPVIxoyw/cg3NZdnLUOXJfytOHWHjwY30LjaUeSlyj49fLW8zPRh+OhWYA1+henwIpH9tlo+0JF0FUoOXOEyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 06:45:36 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 06:45:36 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu@lists.linux.dev
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Benno Lossin <lossin@kernel.org>,
 Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [RFC 0/3] gpu: nova: Export parameters from nova-core to nova-drm
Date: Fri,  3 Jul 2026 16:45:23 +1000
Message-ID: <20260703064526.3630668-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0091.ausprd01.prod.outlook.com
 (2603:10c6:10:111::6) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: e463fa71-e9d6-4d4c-44fe-08ded8ceafb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|18002099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: LifRJ6P9AKdNXFCrl+NOB6bTG244N7LmF/txlewxsE2KqBI2n0z764cbz8oHVkxZZrPjp2+Aj+nMFnQ0QAMUz4l385zlr4OpaCR66ezpmg4JMMsHk4P/w2VanMlw9ocAOeHfto/4YFDpz8QAtNZT01STzPNAC/Ye44qd63JJY4KzypcqD0OZ8iODGPNZatHLwZCUgwJK+3XZhWYXZvezps+rmPND51ZIsOyWPQfFqW9IVXg55ziNKugalMuTcEVWvqq2+WnGY5oD0bJVHCycSEaiJbeCNYj7VsShGjUEQbQgiovCI8UzTdwqE54pA5b+0TwytbtCF1mYT099lkWfsWCsbZToc6mw9HoSD1V2EG3VUsrVTgBMf6DExLSEZBMkcj2O9kEgqKk90wdiGwgydG32UKWbGqx6zxoXe8M7F3tMvxVvlg006fwdoV1c3JSiFZtL4oJ0CIljz76osY4oumasFMjtSfn8FjSnSymrZcJIpXq5dY39JonEBuDMdz72tAmS/0qI9kEbhH4ngiGH46R0mgG7hK3MADcOq2xUZiHJEPC/wYoAnT2g7jhkL5QOylkIO4otVif9viAPCsky+Jiv8HctUOcp7EcxDOTwzuOkwsT6rdgs7CAaUuAJRONkOUs2NOZsX4ZK9UAgLCv0RDWpacOnzwanSbvrymsJyFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mcreizLcTpajWItInKVzHPigOpEQUEmTLaUY+pG521kIbdMQXGgWdK6o9a4l?=
 =?us-ascii?Q?HiHNS9+jpLyGM5ipg3zmHw1bCqwZeL8PNV9YdH9bKRiPSSlZQHPTHZJUEG4+?=
 =?us-ascii?Q?LPcPcsilWY1VOk0RCmBhxNMTD5r2hAtT6qAZQDd8CKdUQQz1HAqbuVUbsmKk?=
 =?us-ascii?Q?LijvWrQYem6w839rlLQmoBEpgSkVUy74Km1ACexX3SuvkFCdULx3UVWYUWaZ?=
 =?us-ascii?Q?mxHa8w3gqBfQoLpgzMbp3VXAKX3yNR2xrbfB9b5T5efteYRfTIVRGyFsXij0?=
 =?us-ascii?Q?QwLuriW9wi3RDw0bsn3uNEB5hi1eKykXFU1o2w8DmDLO3rVouGW2jK0yBN6X?=
 =?us-ascii?Q?aAErFUy+XEdKpKV0XRUdlZWvBue4L8ULArv5vXx8G8CtL6pSYsrrYTpBrAtj?=
 =?us-ascii?Q?X5fCHEmHAwMZXdz7HZtAACO5A8RHgQNcPXdP/5NYjQwIQ+Omhx2aD8oXVUi9?=
 =?us-ascii?Q?k71UbnVDqwR2NKLnnqii4Re+Axd1eQjMuzXD1ioolv7JhVatL+wD8V7Frkay?=
 =?us-ascii?Q?KdziDd2oG5Oe6ZG7REvnFvGWuuQZrvJWP4iKIWOTZroopATAgdEZyxjbPVLz?=
 =?us-ascii?Q?JKjpzDIgEbnhfJJhsQ9s0HPEJbWiC3MN6KqhaVQaoWgmQTHa/uHqk5RKGa5D?=
 =?us-ascii?Q?rtojRLlJVHdHMFimPOEdvPquAdn23H3nWEmsScjx2PcEn9A4lwSvbwTsDFc9?=
 =?us-ascii?Q?aQwxS5whJgFOFTA+qlMaSYVVrVxQ1uuf4B+aYWmN0OcQPtxHr30Imz4jEibC?=
 =?us-ascii?Q?a8EGmmQac6p4Jq3YFfDBz9P0gHyy8b6hq40BS6WfMeGzqHsriJFS+ZCaJp9M?=
 =?us-ascii?Q?WthhBa/dEk8nWwk1Wa7QIKc6Jsrx4mg1ULKYhBvFGi0U2As0xI08L2Zl42r0?=
 =?us-ascii?Q?JWinE/76YwDFBMz3nEtzdEK3nr1IQMOoSL9HU1ITGpw28Mpl1bJWxUIRiygO?=
 =?us-ascii?Q?wngRmlAITe8WwOvpnioxS/VUKlRYFcBAnkr21iqyR5b9afLUH54Tpkl5EmZL?=
 =?us-ascii?Q?+2HkNmxnKKmGY6UKWCrmRRph23BQv0xw9K6RFfhniyhqghoANoHYLqGinF+n?=
 =?us-ascii?Q?bt5XenjsU1ForzsjMLR92APYbR+IWBBgJlxlHN2O1ras2KymLs3Dr6d7Dskn?=
 =?us-ascii?Q?vY88TI8+ihcEsFCB1ksTfBN8xBJURZVbHFiVXzPbeRMYhITBVB9H78mgdUnX?=
 =?us-ascii?Q?ZuGX6sHTQPKQdGPDraxilEUpw7SNNWbMticslFrEQs+kE4Q64i59HBNPzfvu?=
 =?us-ascii?Q?/7u5GJXz6aVcL8wF7GeHYQadU5THXZ9QLjqejdtXlnvk4k1MVaLoHVMbUGu0?=
 =?us-ascii?Q?HKGBhDh/3+Nimc+N7XZmCdT1MD6ZkNWGO80XeSpXZ0R5zewKPeDLUbbhvV9f?=
 =?us-ascii?Q?LLZNOw7FJtXQ5A19bBMGPMOFK1nqKlv6525NH7nZbASd2Y6VSSjXvhC4e+9K?=
 =?us-ascii?Q?9H/ku00haKSmudyJDdmGzDmy4LbBQccfSb6HCClXNBRuEpt1vmPmMl0kDncy?=
 =?us-ascii?Q?8wb0Q8X1wFD8shl1hLmDrXVapJAuHzfkL6rXmst1q7pHKn7euCgoZ38xRGvx?=
 =?us-ascii?Q?c4b3nPA3I076gzEsIYmz4obdxhXv75uc0jckC4BGOPydTra/XsZvBm9CCuNa?=
 =?us-ascii?Q?q9xar71xRSodG48ltYGwWH/YT2K2cZKRV+a7VSqCDgjfzkFc99LB6USXFMlZ?=
 =?us-ascii?Q?cSTz321pvJrocr+7KEp1jp7ceeXKTEhBikGnv2Q97yaLbOylXvyMsdWyZgl1?=
 =?us-ascii?Q?cDVdQDm4Qw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e463fa71-e9d6-4d4c-44fe-08ded8ceafb8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 06:45:35.8481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fI8HwN49CsDJuJcxB4MpkBohON6gxV2IoFc8vy3mSUYGDiXKp9KU/YU8DfWO3HeiWoIsl9SGt+hXivaOeHqUGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
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
GETPARAM ioctl. It builds on top of the "drm: Higher-Ranked Lifetime private
data" series[1] to correctly manage lifetimes of registration data shared
between DRM, auxbus and nova-core.

Properties are exported via a new AuxData type which implements methods to read
data from the GPU. This has been implemented in a separate module to make the
public API implementations obvious and to keep them in one place.

[1] - https://lore.kernel.org/rust-for-linux/20260628145406.2107056-1-dakr@kernel.org/

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

Alistair Popple (3):
  gpu: nova-core: Add auxiliary bus registration data to nova-core
  drm: nova: Add GETPARAM parameter to read the GPU chipset
  drm: nova: Add a GETPARAM parameter to read usable VRAM size

 drivers/gpu/drm/nova/file.rs          |  6 ++++
 drivers/gpu/nova-core/auxdata.rs      | 25 +++++++++++++++
 drivers/gpu/nova-core/driver.rs       | 45 ++++++++++++++++++++-------
 drivers/gpu/nova-core/gpu.rs          | 16 +++++-----
 drivers/gpu/nova-core/gsp/commands.rs |  8 +++++
 drivers/gpu/nova-core/gsp/hal.rs      |  2 +-
 drivers/gpu/nova-core/nova_core.rs    |  1 +
 include/uapi/drm/nova_drm.h           | 14 +++++++++
 8 files changed, 95 insertions(+), 22 deletions(-)
 create mode 100644 drivers/gpu/nova-core/auxdata.rs

-- 
2.54.0

