Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EF2C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77B6610E2EF;
	Sat, 11 Jul 2026 06:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gsMRw6Y0";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012066.outbound.protection.outlook.com
 [40.107.200.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A1ED10E03D
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 06:36:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKexUjH+IWlILJeqzzxPC+mFP7WWGOGxuQmT6W7a8gk4gzr8vxzark+wERoQcUgmX7BWCSjJbvXWf5QMNgZyXcNSmiLc+WrXwltUQRz14Rqe6JhQ8/oe6qK2T8MOGS++0KPeb8xZkFqv8w5GZAkz+ajvy9QotwRJ5XXYUQq5Bhj/IBFVxUIsVNK0iBXSNlaIALqaA4K4Tdux79jCMWtUuyZSrn69FYG63PEJv9U+wrzllxxptDRRIQ5pJlSLQ1qO3b70eO3P0OMHHRi6LCJ8MTqjPCh6aPAM1xAa9XUcAWnru7FN5E3I8cnMXV3zKNLi0gBrI4NoMldJsI9mnHKqQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7k3wB94+F9wF4E4hxHJEzrhEAOCNMvcKqiIqSUWHb0=;
 b=L+vrOF47HQs4+gop7lPaX9j5LGaURU34t2qWHhO1y5hh8Ly3IEyohHw5lLZTK6YjdK8choVJ+bM3RihNONVBQSezg5XIlDfW4Gh/+srsjJjNLYDmeRhMwI9V7zJeP6jEVK2nsu1YfZyZQlceb7F+nLRwd/TGdm/+LEhjKybDlaR9TDSXhABbgHlOdlSsTTPfdecQLNV6d9OKAKkBfArjEeJ9pNlQw1D6VqQ1Aua95XAGYFC9FcLEt3Q+L6IJtxtsD7JZsLm3eLz9JO10C53bJ5FtgpiU0W1FRTk26t8NFv1Ak0IAMPSFrYEOhh/+zwj2lVZ7ClpxqRav+pABEK/9Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7k3wB94+F9wF4E4hxHJEzrhEAOCNMvcKqiIqSUWHb0=;
 b=gsMRw6Y0Il/f0i+oEy8bCvHJnPrqs9ArKWv2sXchQam+UJyT0YBl5Cc/lFV59rEXnKNamUeexRPLSncaZlC29E70ILNM45R0/CY8LxwZinRWErzDYIcd2T+2Vh/1D5V1rlJ4K5BBcY+kbC8pJo20E42Gsl1Hk3ePOlz4JW0LNCo4C6FP3QkhXrZ67pxZKQHNJ13t1Mg+yFyucPdit2STOFoYzAyPhLKMiClJ1ycmCv24TYifgZN7uAc7GhoE/x/25tIQAoTeNfMNPnf/iGEVhGGqAMqpu6HLemlNt3uzSfNp2EoA3iDU0B9SusvDjxUDHIih6a4kYobhKRibAMovug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Sat, 11 Jul
 2026 06:36:05 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.016; Sat, 11 Jul 2026
 06:36:05 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>, Burak Emir <bqe@google.com>,
 John Hubbard <jhubbard@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 "Liam R . Howlett" <liam@infradead.org>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
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
Subject: [PATCH v2] lib: test bitmap vs IDA vs Maple Tree performance for
 region allocations
Date: Sat, 11 Jul 2026 02:36:01 -0400
Message-ID: <20260711063602.426311-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA3PR12MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b27f25-2e3d-462b-1393-08dedf16aeef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|6133799003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 6uahubHnwAd/lg48k1egWIJeLm1c/73KCZwJ0rcbPE6q0fsmVDlnnphSxTEDOAYkKF/oaigkk7mzcbw1/rKbmNkO5JKVsnkAZulcZv+Qnfkyhg462u8vrQ4QmefBfW4u/Sv95UiBWjyQoFsiuC/W1kprJauOtzAL+6Utr4L4pOvBvsIw/aF2gY1lBz40vJqJxdLNmd+A4SPhfxg0DNrXEkLhaRmKz1TGsMBmdCAu2wLwnA9K9QMTTqneAYlhLqYtIuMpgAyX2J+G+6xvQjiw9OzMLdr+BHbqhP+83IL/e2tT/9FqbBra+rrzJeXWFQaYQet4UFOsfzMs6Z2pURhuU6F7/6ZmLA5OtffBjNUlW3QH9N9NQ/M3k0S267eaP+GcHhYlNuHFyQ8+S1O7B0I0kcdaxsbViAtLgqW//fLla+3yviW2Dy6fDVorD2mtRWzrrgtghgawWE0R+Le8rLLiPkc4P7u/Nnu74awBJJAKYFIcon3Ja1MlwsClyWAbXNma8Fz4FFvFrzCqmH4hm1MkC3A9ExnenSunYWuBkDrq6bO51PrwNnR02sYkGc0M0oGFy1nOxoMICFygCLtiRPWQlrgwde7r8/FnoPe8xpG5FMIP6DV3jG0qZ+iPvurGbFccTrRRolIC6/IHCKGX59Vf5VgXVIGNe6ZXksa3/MTab6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV3PR12MB9356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(6133799003)(18002099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bHgGoh05cpfuIx6fQ/fwuFAdMl2RvAv/AKWUCrqOLrBGZ10e8VE9MjGBQ6WL?=
 =?us-ascii?Q?lDsZpigrTcBz4LW5rfBohQZyDkIw9Bl19iddERx+qeHt5rOu2UV5SPsdXy39?=
 =?us-ascii?Q?fQ8ek/CyeP5GzB81KVJoPQ3nEo97ofaWjTtmsZc3hsoDli3v8ihF7eLmTQtp?=
 =?us-ascii?Q?ysFElrybUNUZDeavM+pYgwF4uyxnDGNu0uRNASeqfBdmORgck3hLD8qf84AC?=
 =?us-ascii?Q?FdSixv67TIJqpl4Brv7JFGAFuDjdjIUdUMZuqL1Qh3TirzIAO3MgMZjIT9Bu?=
 =?us-ascii?Q?d+uI2C9/vGMvAEqG1p+Pqd7TFplg38Qi9JUArcKsFEyp4rRbJkLV+jFWFCfu?=
 =?us-ascii?Q?fUL53h4ix5BKhHkh8UZvU0ftPaj5DLLwTeBxfBZlPmJ9EJSGScv5qH8g8Cdm?=
 =?us-ascii?Q?WiVsxjgGt9DZXITVjDCK5DyPLUXty7BuABZUmh0nUlVIClTf96a+5+u9KJcn?=
 =?us-ascii?Q?RHhJvPXzmTMhlpBZb2pCMx+olx/amWJN/PkOXcdcopFjYjn9XmlyccnUrAc3?=
 =?us-ascii?Q?WNmvyCI3oUl9EopMxRt+KTxMkvtPLyeJlUvVAf9iqjun5G+lY+Hjczr2sbUN?=
 =?us-ascii?Q?x+CW/qC9ENR4ElrPpk3PvFW70nquzM3o7HqG0L6jDBad3lRKXEexvhObgJRx?=
 =?us-ascii?Q?mXLEx3plOuCXDHk/Rpoff9bOz9gbIT8spE+dxV3Qv4SiGwU6EhPEzf4dgEBR?=
 =?us-ascii?Q?kuZkT35INnsl5qqG4ovYWod42jUVUS4bN/EEnSeuPRqv0D9Qse0HcqMuYRY2?=
 =?us-ascii?Q?Vi7axAnjX9gip7J+PFhshjGFt+Xd4ASmY2g9E7Pd7lPW28Jt2nPiGhtiEM8S?=
 =?us-ascii?Q?zmDe4GbJA9I05K4dZA9G06APSscrBeHlXxosy5JK9Dhx5xwHS+nf7hFL8q0u?=
 =?us-ascii?Q?eTa+B9nJf509YdGkbcQoOaSJPtGC42AE5e3m0aWBe10vYIAlEEU4L1ntUjxh?=
 =?us-ascii?Q?101x/3CJXMz5zGU37AZ0JXGYpDlJ1hfUsotBWjT+uyDnvGPYwO6Ziqkkre08?=
 =?us-ascii?Q?ODCQiojY+ouVUiuiABhMn9X+DH5Cx3LRE5hgWK0q16+7TaSqCSmNHBYP+z2b?=
 =?us-ascii?Q?DCggB71TCobPpqrBBVXm4KzL2bVXPoZMQq6VprF7YCprkb7jzKd+FP2xnm41?=
 =?us-ascii?Q?mYCzINFWqF2OJ0xvyIeET7PdlwlwBgpJljksZSAanVqaeGmnul4ClQatH17+?=
 =?us-ascii?Q?JtF7eDqIv9ED7HfFfXor/Bb6j3GmATJYMTfHG66RpW4EcO0fxshmFvJQo4mL?=
 =?us-ascii?Q?WvqdBghFCzb4au2NEG1u9gZW42Yh96daTZQoCDHHr6eZsbpz06H16QKgzomY?=
 =?us-ascii?Q?NSA4lfX95wSTeO3SY4Umlo7EgRIyQ3lLfWQwVoQmZprI3b8TH3KalQ/toL58?=
 =?us-ascii?Q?avcdZyZUTlEjed8UI7kfJQ2SqHdlzAKZ7aLqRA9DX6Owi4BTdg5mT8Ih+19a?=
 =?us-ascii?Q?cZZR5uOJ+ubOnX9p1dcKcjA+RvGTfpQKWsxr5UpK6s6W0EaB4qlu4aOrj0iI?=
 =?us-ascii?Q?aTbkX7k6vFQc484CqvRy/LrYp8AyCj5QwmomVeLzMelySDCvyYYq2/ZGebhG?=
 =?us-ascii?Q?XQgA8EJIuuSvKlg0Yg3DL8ZPBTKDc53sgcqnc1uubjmMDw75X3yfEVtnWF+J?=
 =?us-ascii?Q?Sa1vDw8uzvjFqlT6L5PnWW3uo4IQOZxwUb3nlQmNF+Y/qJh8eZmOxvv8xiGd?=
 =?us-ascii?Q?LWn6qBfw6KJ5bXfsFoI1rtTRdv9PyLHXpM3cnLrxeLWark6d2e2WhJtgNpb3?=
 =?us-ascii?Q?I1by7t4O3A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b27f25-2e3d-462b-1393-08dedf16aeef
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 06:36:05.3340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1B9Oz/sQztDw2bHhRKU54FjVgRDnWmpGJ+s95GaonfZWDvjPEy5JrZOvuMhsSE1vVsDAI3ov36Xk6E32StBVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781
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
a bitmap, IDA and a Maple Tree. All implementations process the same
randomly generated sequence of region sizes, ranging from 1 to 32 entries,
until the configured capacity is exhausted.

Run the benchmark at several capacities to show how the approaches
scale. Report allocation and free times separately because bitmap,
IDA and Maple Tree removal have substantially different costs.

On x86/kvm, the output example is:

type       alloc (ns)      free (ns)   capacity   memory (B)
bitmap      179573071         342105    1000000       125000
IDA          46555636       33931498    1000000       134864
maple        18629665       19741396    1000000      1548304
bitmap        1630912          30933     100000        12504
IDA           6144785        3354590     100000        14288
maple         1745026        1825032     100000       155408
bitmap          28448           3374      10000         1256
IDA            418978         333641      10000         1872
maple          185398         211138      10000        15632
bitmap           2253            610       1000          128
IDA             42755          36432       1000          144
maple           19728          23474       1000         1552

Reported IDA and Maple Tree memory figures exclude slab overhead
and transient allocations. The Maple Tree figure is additionally
a lower-bound estimate that assumes fully occupied leaf nodes and
excludes internal nodes.

IDA has no region-allocation API, so each region is implemented as
a sequence of single-ID allocations. The IDs remain contiguous
because this benchmark fills an initially empty IDA monotonically.

The benchmark is motivated by the discussion at the link below about
choosing the best data structure for the channel ID pool with the
capacity of 2048 IDs for the nova GPU driver.

Specifically for 2048 IDs the result is:

bitmap           3907            831       2048          256
IDA             83545          71007       2048          848
maple           34632          39710       2048         3600

Link: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvidia.com/
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
v2: add IDA benchmark (Matthew)
v1: https://lore.kernel.org/all/20260711013910.349586-1-ynorov@nvidia.com/

 MAINTAINERS                  |   3 +
 lib/Kconfig.debug            |   9 ++
 lib/Makefile                 |   1 +
 lib/region_alloc_benchmark.c | 174 +++++++++++++++++++++++++++++++++++
 4 files changed, 187 insertions(+)
 create mode 100644 lib/region_alloc_benchmark.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7cc4bca5a2c5..9e487a94aba4 100644
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
@@ -29323,6 +29325,7 @@ F:	Documentation/core-api/xarray.rst
 F:	include/linux/idr.h
 F:	include/linux/xarray.h
 F:	lib/idr.c
+F:	lib/region_alloc_benchmark.c
 F:	lib/test_xarray.c
 F:	lib/xarray.c
 F:	tools/testing/radix-tree
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1244dcac2294..40872263cff1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2683,6 +2683,15 @@ config FIND_BIT_BENCHMARK
 
 	  If unsure, say N.
 
+config REGION_ALLOC_BENCHMARK
+	tristate "Benchmark bitmap, IDA and Maple Tree region allocation"
+	help
+	  This builds a microbenchmark comparing variable-sized region
+	  allocation using bitmaps, IDA and Maple Tree. The benchmark
+	  runs at module load time.
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
index 000000000000..0e000c4f9926
--- /dev/null
+++ b/lib/region_alloc_benchmark.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Benchmark bitmap, IDA and Maple Tree allocation of variable-sized regions. */
+
+#include <linux/bitmap.h>
+#include <linux/idr.h>
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
+static size_t __init ida_memory(unsigned long nr_ids)
+{
+	unsigned long entries = DIV_ROUND_UP(nr_ids, IDA_BITMAP_BITS);
+	unsigned long bitmaps = nr_ids / IDA_BITMAP_BITS;
+	unsigned long nodes = 0;
+
+	if (nr_ids % IDA_BITMAP_BITS > BITS_PER_XA_VALUE)
+		bitmaps++;
+
+	while (entries > 1) {
+		entries = DIV_ROUND_UP(entries, XA_CHUNK_SIZE);
+		nodes += entries;
+	}
+
+	return sizeof(struct ida) + bitmaps * sizeof(struct ida_bitmap) +
+		nodes * sizeof(struct xa_node);
+}
+
+static unsigned long __init benchmark_ida(unsigned long capacity)
+{
+	struct ida ida = IDA_INIT(ida);
+	unsigned long count, index, offset, nr_ids = 0;
+	ktime_t alloc_time, free_time;
+	int id = -ENOSPC;
+
+	alloc_time = ktime_get();
+	for (count = 0; count < ARRAY_SIZE(region_sizes); count++) {
+		for (offset = 0; offset < region_sizes[count]; offset++) {
+			id = ida_alloc_max(&ida, capacity - 1, GFP_KERNEL);
+			if (id < 0)
+				break;
+			if (!offset)
+				region_indexes[count] = id;
+		}
+		if (id < 0) {
+			while (offset--)
+				ida_free(&ida, region_indexes[count] + offset);
+			break;
+		}
+		WARN_ON(id != region_indexes[count] + region_sizes[count] - 1);
+		nr_ids += region_sizes[count];
+	}
+	alloc_time = ktime_get() - alloc_time;
+	WARN_ON(id != -ENOSPC);
+
+	index = count;
+	free_time = ktime_get();
+	while (index--)
+		for (offset = 0; offset < region_sizes[index]; offset++)
+			ida_free(&ida, region_indexes[index] + offset);
+	free_time = ktime_get() - free_time;
+	pr_err("%-6s   %12llu   %12llu   %8lu   %10zu\n", "IDA", alloc_time,
+		free_time, capacity, ida_memory(nr_ids));
+	ida_destroy(&ida);
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
+	unsigned long bitmap_count, ida_count, maple_count;
+	unsigned long i;
+
+	for (i = 0; i < ARRAY_SIZE(region_sizes); i++)
+		region_sizes[i] = get_random_u32_below(REGION_MAX_SIZE) + 1;
+
+	pr_err("\nStart testing bitmap vs IDA vs Maple Tree region allocation\n");
+	pr_err("%-6s   %12s   %12s   %8s   %10s\n", "type", "alloc (ns)", "free (ns)",
+		"capacity", "memory (B)");
+	for (i = 0; i < ARRAY_SIZE(capacities); i++) {
+		bitmap_count = benchmark_bitmap(capacities[i]);
+		ida_count = benchmark_ida(capacities[i]);
+		maple_count = benchmark_maple_tree(capacities[i]);
+		WARN_ON(bitmap_count != ida_count);
+		WARN_ON(bitmap_count != maple_count);
+	}
+
+	/* Let the benchmark be loaded and run repeatedly without rmmod. */
+	return -EINVAL;
+}
+module_init(region_alloc_benchmark);
+
+MODULE_AUTHOR("Yury Norov <ynorov@nvidia.com>");
+MODULE_DESCRIPTION("Benchmark bitmap, IDA and Maple Tree region allocation");
+MODULE_LICENSE("GPL");
-- 
2.53.0

