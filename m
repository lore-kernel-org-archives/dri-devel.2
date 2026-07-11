Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA491C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 01:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C33310E284;
	Sat, 11 Jul 2026 01:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HLsEV8Zk";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC31610E284
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 01:39:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxar3xk/rIXYg+La+7OJXmU9wZY8B17wNuODkJxQOVZ93hU6f8ADKuWMNmJUpJts3lSxd26iF6eimOlMAAOL1MyEXLj3RxNtbuxi8YSRK1cjHctC1WIv2XAUwJYmQpPqjkb9FndqL2NdzBblwXbhJ0aG0oKI7pUGoMnCbvfMw13d5hHifSp+xlm7DjEQOJot9SNaIWAa7evPzHjmIvwjcNa9feJa/9HnHjHXzNNIEawbq6vrAP95sK8cqZy+liUhy8+sTIpklzkQHE9Jeyn7EMUmkINJyIajw/QxXuhoHke+hJ9bILsKoGchV5g3aZT+2aj+JgarWWp2a4bS1QP5hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ISDs70cOekheRiXH0EQq8A1pM+Sy5evbpkgaq3foOo=;
 b=GoPt2fpf8c/Yf0kcv+M1OmIm43aT0CX59ywDXOkuzbQa0U+7XRfCyVx1FuaNM+msoJH4u5MXmoJIqBu1u1UFOHjB/EiM1/eNn/kA28QyAh1H8zt4Uni3Fexz7pr2ME952eRhRDCMdKzNrx6eo7VnUeB0Ms6uihrzo+fHsJO4wx+CPiEkgezvI9+S9fdwJX9/i7AVbXKaI98NJg22mj6PycmF261Vh2rXS5IKtDSSD/1BoZ+jHJX2LlJs519zgh5WZcBIJYXWJ2lnj64yzHHmoXjsrRlCbsSGa+flGyNdolbGZAyow2nNhglCNanbpAol1FUEMxE5YcEmYgb+D/U3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ISDs70cOekheRiXH0EQq8A1pM+Sy5evbpkgaq3foOo=;
 b=HLsEV8ZkYCWQrepLlQrGO3DRizAMue6DNV78nYMXjv+VTSJ9ONwBOvzr6cRe4qskJNCLLrJPz3zkwffw8gCWWEKUd4sR1JfoXskfcc+/iQmNlfp/H327nbO4v8SbRTSXJ/+98ZmqlbuWxmUGBJB2RHhf7HsHK8kFEsc1ivUkAys834oVqbVmfK/iRMQ9oo/JVX8QjFXiifnnyZYRpVrp0zUD5Ho7Z5+FELU+NE4ZzBPPopnNGJpVRWHhQoVjpLo6i85oLjRkxRjncVgtCCIgPwrtTKrWDk8yVXj/XF6AQYdTvjTf3zZJrWD/ePxXPEvvdT/NZAmPoIp54swAIY8hhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Sat, 11 Jul
 2026 01:39:14 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.016; Sat, 11 Jul 2026
 01:39:14 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>, Burak Emir <bqe@google.com>,
 John Hubbard <jhubbard@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 "Liam R . Howlett" <liam@infradead.org>,
 Andrew Ballance <andrewjballance@gmail.com>
Cc: Yury Norov <ynorov@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Boqun Feng <boqun@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Simona Vetter <simona@ffwll.ch>, Tamir Duberstein <tamird@kernel.org>,
 Timur Tabi <ttabi@nvidia.com>, Trevor Gross <tmgross@umich.edu>,
 Yury Norov <yury.norov@gmail.com>, Zhi Wang <zhiw@nvidia.com>,
 maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH] lib: test bitmap vs Maple Tree performance for region
 allocations
Date: Fri, 10 Jul 2026 21:39:09 -0400
Message-ID: <20260711013910.349586-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::29) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0fb5b5-8920-43da-4b68-08dedeed36d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|23010399003|376014|18002099003|11063799006|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: z0Ro/8zYzMP4rnzc0SX/niGTu8zHbSqSj5oWKfcNIchq/vD9ExmhYgDGIbsIHwMCCJJDieSKqRceab7JnEJB6vjhT1pn1qTHU+oVUASnfMymwa8baw+DFdEu/8H6oMLuCrkb7RJlQxE62yZd7wUN/zyE7EbwNB1mAHkHji+AMw0Qbxqgg3+FFnUY6K0L7CE5mKpaRMT0zYUn/SyaPJga3ak23V3nFHJyGGEHhfwGNA4WMayb9KXRLyyFZdWp6ewhNPHGFy9VsU18J71h2j/jFJcpUxblYYBc5Ud9PkIipZ2Yc5dpOhXCSWHm949f/gbNaYqilU4EhnK3z1NHoQ8zyKSzJX8+3+kEyyhlxj+n8kYaT7TDh5s3l3RtRGL4KVJ7X3ZhpmAFEpUq4sf6/SHu2X7XUP1NXHF6+dGWcF/cr7J2KEn1kXRya1ppz0lKfGAMTKJAnqeqcRP1xRgYeulPw986oqS7Lj6ZhTQrOnOvTNsGAadFYII96tuRFRqAgJhhNddLd4LVP6OGoT5QfVNFPlAAImqcwdBj5pAEYu/W5CjZ/zwmWf9/5Twd5KmSzD0d4AjbMnO+aoG4Hvl6rZHQz6WyvQ0MbJ+rSRLzcoDiT8FF+4IPHwPzww/NCl0gqpu2eis5JaxFjxLiVHezvOof3NYxLMRlR5n2Yp+YP+Ki0n8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(23010399003)(376014)(18002099003)(11063799006)(56012099006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a9rdEr4tw8QtQ3FS+YTKh4R+d1s3jbsvq0eBDrSVnnJbPlJgHiOsCMGVM/MV?=
 =?us-ascii?Q?bTAvKNyAmO+OgAewPKEKmhTZLv+Xuj2ywMDOyMnuC1CIga9Ux3GJa7Ag/1L0?=
 =?us-ascii?Q?PcNf++A+GsoWqVaSlz7W6X60clAgQraGDcyvT7/JeXGamYIcCTI4my5+f6tZ?=
 =?us-ascii?Q?BOTiN2szAGjRUpHHWppiQjeFjNq47HWLOpbvKXEQQYFSX4Td0Scch8npAiij?=
 =?us-ascii?Q?lyjsJ8VhJZ1mWPKUn+Bxgu67O3T39BHQlCzPJfB9/w39UJqT3wvBa0wKoMud?=
 =?us-ascii?Q?ycB/e8qv3Z081RvcN0sk0mmWd5uBIlDJsWUk/qy5A+Tk9McWx9ZI+oFIuU6d?=
 =?us-ascii?Q?znjwDlYn/XmA5IFydF/Rapa3jMUgMNUyIxjDAfpmwR1EppDFS760twsvYA8R?=
 =?us-ascii?Q?v5kCk2O06cItjSd95NAvCICWBZg3k7jxTAac1bIjiO9BPdSsW/iovjbwD6q+?=
 =?us-ascii?Q?B+XNphJr2ivmvMhype/FiSWBUTVmDVDc1Nlg7sPrXzyhQ91BnOaIrsUpHIwm?=
 =?us-ascii?Q?hWDMb/G/s4aJlHGSyYhz5EETWpA1HnuWO3tnsZ9+KwZP2z2zPA4hXtcW6GLb?=
 =?us-ascii?Q?TIlboFl6ZSNOrlFt6l6W7sYQ/QveXVTXf0ZQq9HchPWJxNFNPrsMuPz8OCXN?=
 =?us-ascii?Q?J7LrAu/1QBJfiwFAvZIIRKP1RMWFJvZ+TVugN5EVcwHkMp493Z7vNmuiFM4Z?=
 =?us-ascii?Q?kItQkc5YhLhZsgQTLugTPwI6uP0iFt/p8/Q8irxtrIhrV6t7Ke+FL8KgI5u6?=
 =?us-ascii?Q?b3+jVViwGaxwYaZWixRqzhqI0eVpMMrxw/Yk9173WC1u86cD6FEx/VYtuldZ?=
 =?us-ascii?Q?ZoofSz4oZIG6cFE4/Ac0YP4iLk5HLNplpbRvozucDpDfzQs4CA8rk5AIivG5?=
 =?us-ascii?Q?4mrexp6f2FXJEHkrx8SCOQHQ5bx6xfrtJQWgjWyYUpSPwxswTgrhpwm1ceoX?=
 =?us-ascii?Q?DBL4D5dhz3CNsLA2k68WQmi/ld26zzpV0Pb9Ob+5uJk6sWR5hYMEFycv1I7W?=
 =?us-ascii?Q?fgo/m50+CEKuvCZt7bGotLQhEhP4GpiXxxe29iI75wJrHZNng6YVy1qpYOJQ?=
 =?us-ascii?Q?cCDT3CGpJfVAKwIe9DP/asQVNLEJjGGeC1T/RxM2QNjQj+6+XwGe2II8rlmb?=
 =?us-ascii?Q?N0WeG5CJp9a9jw7xtCe6jYSZ2rT0vWAIHaIK4wK2Y4D0wu1qSHDq0/xUsEVk?=
 =?us-ascii?Q?f++ZCBT1Zho4AMY1/GiMn3CxcU3NOvhjIxE0dREj9WBXM8Zj4pUoJzY+z9zv?=
 =?us-ascii?Q?R1NmuKTx5dH9sF6taTLPMhZjy51uNxNy/Gi+ylq9WdbYD6w5yyDvv6o/yT7S?=
 =?us-ascii?Q?kL5uGkuYZP0fUiK/QrA1Yf/fyxzOgO7FC6/XmcX4s3D0+YYQOk+2Zh/iBvPn?=
 =?us-ascii?Q?AiLWeyx2k4Avm9GfQR4Gsel9vewQD9CTk22Jpd/dPS9YOcbY9E0cogn3v4QX?=
 =?us-ascii?Q?JxUErKWQwDr9o5FXkKnPds8y9acyzuEGkG/fST2LEcx2ep1aVlP40NrNyiT5?=
 =?us-ascii?Q?EEninv4/gFq0W/oWi7Duc2WJS+tf6ohdqJoh5O1qYuqFAty8YDlzsbctaPoW?=
 =?us-ascii?Q?17tRgtmF9wZLTLEsJhTiJCh0sB9s5bGC/+VeJ6ANE4n566Ycr8LG+5BR+vQ+?=
 =?us-ascii?Q?2ZL04XlWRzJ3fMQ6rVtXwNC1z+mmH6wydg8b/BYF2cWK+OAnC9Uj+dVmgbM7?=
 =?us-ascii?Q?0S53nZuZjzQ//M5u9qUTXHR0sLsL3n6lyi2X7VdAV8T2xanxHEZQuE5o62rH?=
 =?us-ascii?Q?+efiKaODLQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0fb5b5-8920-43da-4b68-08dedeed36d1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 01:39:14.4293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mybvSg13jjyOyHvLejGJz0sr3a7iDyM4r6fDwvvvp1F+8O8pEQnLJPJazXbU8KqNTWHwSBw6wtCWtU4p5aHn2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104
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

Compare the cost of allocating and freeing variable-sized regions using
a bitmap and a Maple Tree. Both implementations process the same randomly
generated sequence of region sizes, ranging from 1 to 32 entries, until
the configured capacity is exhausted.

Run the benchmark at several capacities to show how the two approaches
scale. Report allocation and free times separately because bitmap
clearing and Maple Tree removal have substantially different costs.

On x86/kvm, the output example is:

Start testing bitmap vs Maple Tree region allocation
type       alloc (ns)      free (ns)   capacity   memory (B)
bitmap      100191761         187248    1000000       125000
maple        12256712       12665044    1000000      1555472
bitmap        1094833          22182     100000        12504
maple         1348996        1120168     100000       157456
bitmap          19566           2230      10000         1256
maple          109854         111542      10000        16144
bitmap            918            222       1000          128
maple            8993           7986       1000         1552

Maple Tree memory consumption is a lower-bound estimate because it
does not account for internal nodes, partially occupied nodes, slab
overhead, and transient allocations.

The benchmark is motivated by the discussion at the link below about
choosing the best data structure for the channel ID pool with the
capacity of 2048 IDs for the nova GPU driver.

Specifically for 2048 IDs the result is:

bitmap           2261            472       2048          256
maple           21743          24055       2048         3344

Link: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvidia.com/
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---

The numbers are collected on top of bitmap_find_next_zero_area_off()
optimization:

https://lore.kernel.org/all/tencent_FBA5367F4AA8C57DE2198975767E416FC90A@qq.com/

It's in -next and scheduled for the next merge window.

 MAINTAINERS                  |   2 +
 lib/Kconfig.debug            |   9 +++
 lib/Makefile                 |   1 +
 lib/region_alloc_benchmark.c | 112 +++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+)
 create mode 100644 lib/region_alloc_benchmark.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7cc4bca5a2c5..9fc60489a0f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4615,6 +4615,7 @@ F:	lib/bitmap.c
 F:	lib/cpumask.c
 F:	lib/find_bit.c
 F:	lib/find_bit_benchmark.c
+F:	lib/region_alloc_benchmark.c
 F:	lib/test_bitmap.c
 F:	lib/tests/cpumask_kunit.c
 F:	tools/include/linux/bitfield.h
@@ -15581,6 +15582,7 @@ F:	Documentation/core-api/maple_tree.rst
 F:	include/linux/maple_tree.h
 F:	include/trace/events/maple_tree.h
 F:	lib/maple_tree.c
+F:	lib/region_alloc_benchmark.c
 F:	lib/test_maple_tree.c
 F:	rust/helpers/maple_tree.c
 F:	rust/kernel/maple_tree.rs
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1244dcac2294..40872263cff1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2683,6 +2683,15 @@ config FIND_BIT_BENCHMARK
 
 	  If unsure, say N.
 
+config REGION_ALLOC_BENCHMARK
+	tristate "Benchmark bitmap and Maple Tree region allocation"
+	help
+	  This builds a microbenchmark comparing variable-sized region
+	  allocation using bitmaps and Maple Trees. The benchmark runs at
+	  module load time.
+
+	  If unsure, say N.
+
 config FIND_BIT_BENCHMARK_RUST
 	tristate "Test find_bit functions in Rust"
 	depends on RUST
diff --git a/lib/Makefile b/lib/Makefile
index 7f75cc6edf94..adb18810e3f7 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -64,6 +64,7 @@ obj-y += hexdump.o
 obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
 obj-y += kstrtox.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
+obj-$(CONFIG_REGION_ALLOC_BENCHMARK) += region_alloc_benchmark.o
 obj-$(CONFIG_FIND_BIT_BENCHMARK_RUST) += find_bit_benchmark_rust.o
 obj-$(CONFIG_TEST_BPF) += test_bpf.o
 test_dhry-objs := dhry_1.o dhry_2.o dhry_run.o
diff --git a/lib/region_alloc_benchmark.c b/lib/region_alloc_benchmark.c
new file mode 100644
index 000000000000..7459e37608bc
--- /dev/null
+++ b/lib/region_alloc_benchmark.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Benchmark bitmap and Maple Tree allocation of variable-sized regions. */
+
+#include <linux/bitmap.h>
+#include <linux/kernel.h>
+#include <linux/maple_tree.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/random.h>
+#include <linux/xarray.h>
+
+#define MAP_SIZE	(1000000UL)
+#define REGION_MAX_SIZE	32
+
+static DECLARE_BITMAP(alloc_bitmap, MAP_SIZE) __initdata;
+/* One more request guarantees that even an all-ones trace reaches ENOSPC. */
+static u8 region_sizes[MAP_SIZE + 1] __initdata;
+static unsigned long region_indexes[MAP_SIZE] __initdata;
+
+static unsigned long __init benchmark_bitmap(unsigned long capacity)
+{
+	unsigned long count, index;
+	ktime_t alloc_time, free_time;
+	size_t memory;
+
+	bitmap_zero(alloc_bitmap, MAP_SIZE);
+	alloc_time = ktime_get();
+	for (count = 0; count < ARRAY_SIZE(region_sizes); count++) {
+		index = bitmap_find_next_zero_area(alloc_bitmap, capacity, 0,
+						   region_sizes[count], 0);
+		if (index >= capacity)
+			break;
+
+		region_indexes[count] = index;
+		bitmap_set(alloc_bitmap, index, region_sizes[count]);
+	}
+	alloc_time = ktime_get() - alloc_time;
+
+	index = count;
+	free_time = ktime_get();
+	while (index--)
+		bitmap_clear(alloc_bitmap, region_indexes[index],
+			     region_sizes[index]);
+	free_time = ktime_get() - free_time;
+	memory = BITS_TO_LONGS(capacity) * sizeof(unsigned long);
+	pr_err("%-6s   %12llu   %12llu   %8lu   %10zu\n", "bitmap", alloc_time,
+		free_time, capacity, memory);
+
+	return count;
+}
+
+static unsigned long __init benchmark_maple_tree(unsigned long capacity)
+{
+	struct maple_tree mt = MTREE_INIT(mt, MT_FLAGS_ALLOC_RANGE);
+	unsigned long count, index;
+	ktime_t alloc_time, free_time;
+	size_t memory;
+	int ret;
+
+	alloc_time = ktime_get();
+	for (count = 0; count < ARRAY_SIZE(region_sizes); count++) {
+		ret = mtree_alloc_range(&mt, &index, xa_mk_value(count + 1),
+					region_sizes[count], 0, capacity - 1,
+					GFP_KERNEL);
+		if (ret)
+			break;
+
+		region_indexes[count] = index;
+	}
+	alloc_time = ktime_get() - alloc_time;
+	WARN_ON(ret != -EBUSY);
+
+	index = count;
+	free_time = ktime_get();
+	while (index--)
+		mtree_erase(&mt, region_indexes[index]);
+	free_time = ktime_get() - free_time;
+	/* Minimum storage assuming fully occupied allocation-range leaf nodes. */
+	memory = sizeof(mt) + DIV_ROUND_UP(count, MAPLE_ARANGE64_SLOTS) *
+		 sizeof(struct maple_node);
+	pr_err("%-6s   %12llu   %12llu   %8lu   %10zu\n", "maple", alloc_time,
+		free_time, capacity, memory);
+	mtree_destroy(&mt);
+
+	return count;
+}
+
+static int __init region_alloc_benchmark(void)
+{
+	static const unsigned long capacities[] = { 1000000, 100000, 10000, 1000 };
+	unsigned long bitmap_count, maple_count;
+	unsigned long i;
+
+	for (i = 0; i < ARRAY_SIZE(region_sizes); i++)
+		region_sizes[i] = get_random_u32_below(REGION_MAX_SIZE) + 1;
+
+	pr_err("\nStart testing bitmap vs Maple Tree region allocation\n");
+	pr_err("%-6s   %12s   %12s   %8s   %10s\n", "type", "alloc (ns)", "free (ns)",
+		"capacity", "memory (B)");
+	for (i = 0; i < ARRAY_SIZE(capacities); i++) {
+		bitmap_count = benchmark_bitmap(capacities[i]);
+		maple_count = benchmark_maple_tree(capacities[i]);
+		WARN_ON(bitmap_count != maple_count);
+	}
+
+	/* Let the benchmark be loaded and run repeatedly without rmmod. */
+	return -EINVAL;
+}
+module_init(region_alloc_benchmark);
+
+MODULE_DESCRIPTION("Benchmark bitmap and Maple Tree region allocation");
+MODULE_LICENSE("GPL");
-- 
2.53.0

