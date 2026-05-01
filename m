Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90541CD3423
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 20:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4ABA10F614;
	Fri,  1 May 2026 20:58:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="olRgb7Hz";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010054.outbound.protection.outlook.com [52.101.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F2E910F5FB
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 20:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yy4M1DnEnxVDDmoSWKhQjtrMbiq7Pm3NExmT2yvNMGqoyISbmRKbxoSuFo7fes+9G3NvjeGDPa+G+ztZUiZq8gIijnTZYClqxgEn4LdSbvLE+4Ga9RpbxrlslQv44/rq0Vu03ZiIev0pXKFUgxoWIyrwpdYNGVh6YNXzX/sreiJ3X5BQTX3gzLl9IyZV2sf3/uACv72mSKXHwbYyJ6IvVWMmCHK+6kRi/FqwbXUXF5Q5bS/78ZDHJT6N3iHSarDGLmlb/cnWYAutl0wXIBkTNF+lN8NSMOSlBYrH7xo7GnKcrTvZi7cA9USdcSy3NpK1fUAt4siTQH4t+KC7p5CBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPjTRKUT9xr6k+KDGimAr0H+Zh6xSIiK4RvFCx4rI3E=;
 b=p6M9UqIA/wEq3QRXKc/PadfH2YAdb6DZTMSoDeu7NhrKwVtDgaXOQ43T/CUp5/IGJ0XSKGBQgvU4ex17rAYQKjrznfSOwHlvMLz8tjjcqiQr+RNcdrZscF2iiNLtDKzb8q5JxBvwveOdEE3VdaqzKJzRDAd5XtmLeSqXl55FiaAth8ie31zWGz7NH9jePSZVH4voaynBNd+CN2aG6jYIUpfpjxPFgEsG0PF/jljSY9itFaAluh6HXXmY6ZTvpYyADsSGdcUNcG58sxToMjFinhNTJkGZxFmMUA53IVaG+Sk9G33z2ZNKvsXT2BmI9yatyqcDAjoaEsPeaYxrf5IGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPjTRKUT9xr6k+KDGimAr0H+Zh6xSIiK4RvFCx4rI3E=;
 b=olRgb7HzK/wDbkiT4rG4YVbGCnKmj2c8l+z3xaAZO5cGnw9o3K0Vhdrr59Hf+DGeX43u6Ipk0vAND8ON6gGYXz3WvGSjYgWjzjV61wewwSkJ/fN0piW3nnIgLKci/thmioDB9cu+vB4TquNiZRAN8Kkkt5LRwE8shPqzQfGq/MCzeeo7gW4yLmevvmzwd89qweg8i4kEEqgI5i1qZ1+hRjbBJ45AvIp1eZeOkOCYsT+wG2Dbk3m1Nn2v3ScnYSiEiNdSLmWYBY+bRAEgY781OJ8/6jKpoW5RtFJDELWCDkfkVOZFSdWVUCs7eMAeeHCqi0kUavq5a0RxoTTkaY1P4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 20:58:34 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 20:58:34 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v1 1/7] rust: sync: completion: add
 wait_for_completion_timeout()
Date: Fri,  1 May 2026 16:58:19 -0400
Message-Id: <20260501205825.73614-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260501205825.73614-1-joelagnelf@nvidia.com>
References: <20260501205825.73614-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:208:36e::23) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 42dc112c-66a2-44c5-9962-08dea7c4686c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: v3n0QL2W8DsfV12IUMSs0Cg0rhZbHRnm2RYifk4JfbvZyrpik3MJ9P6qUqh6+dNz6Lfl6sDXgYeWAoQSKQCKhsK3HfZ9Gke4OwPCJrTZuyXCB55iQ0nsaNsHai11Vbt+P1KuO0OPBRDIAsYlf9LFS5MmBAT0uX0/Jk6xdTUyzMySse1/YwscM0teN/ExkmJIwdhz8WuiuC0g6P5CKd1yyg38B7Sj/wIQ521EueVQEJrYQaY92fho030QEqA3NPjH/Hu9jpjcUCNzSJply/QLvJDcnppPgAqxNcB4+6ZQDnsviJKjEed6Sp/SlnjSZGXAHgY3VNudwL8RZIvhzVebdVVtyEWx5hB1bqGg9kialq9J1PJx31IHj6BRh1JFtT+sNCbWyXpm8h7MSxVlP+3YQYNzZQMYu0tX+Zcb9Nko5yMMJQvZ13hNcnWRcI8GAlt4n+4K2ZjwR0rX6vRHSEdF9DdbQIhgCuVLVvAV+VWqrwFBoPVTkvhoehP/emH+Uwk4nfnPy6gQ4pc0DMY6hG/6gAC1lWw6ZnaJ/FLZ8mytlmoaoIrd/DDySByX8EnE7OWCe2/upgxHffViaAmYmkRLo/KDlbBIAwJEchnxjVmvhckkLNQnPrt8Ar9a8MrOhWE2yrsCrLyXcq9AkFT2oO9QK1LZdnjuU9Yai3Ro7Iy5/uRUBsVXUUJTzCW6rhRNhfxt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uozuYAX/toqXOeGEqciuU+z3mb3f3sG6YZPr/vkt7tcAi5kSUnPXRWXe0arJ?=
 =?us-ascii?Q?LdBt0X55glTIcONmCUdaTbMwjCwqZ9wiRUb8ngK0v7OBQDBaBSMCRaUtRPck?=
 =?us-ascii?Q?9Xb2ysbVDJAaGxq+gITUG7JrQ1y0fj2yO8dMp2as4NeMZ6uVj7sfxwDpgECs?=
 =?us-ascii?Q?2CQ8zOpPvGnYd2PqMBgb0NwH2RWAprUjidZCXmLybPV8a02huF4bURX0Tx/H?=
 =?us-ascii?Q?OcvmpWmUB3C4Xn4EXPT2GEwKEieanABj9gaG5GPUrHRrINxqed3UqyLk0glV?=
 =?us-ascii?Q?4CphMiBoj4LXHEnxCgrEQdTrTuc93BCfpxaumlxo29Jjdz6vY3OhczdZ9Bwy?=
 =?us-ascii?Q?V+nOpmXzIkDyhbOuQjfwr3/72lqtUSOdnd3muIvyUD3SrZKKtVkZZtRvF+8t?=
 =?us-ascii?Q?JxDyCURCKBQRXPtXD51T1LmdglD2YpA8pxaigfYHCCQUnGO78bvwgjirt//X?=
 =?us-ascii?Q?dA9s9yCTw0VQn/f8HKmz5mxflPX/Es6JDsjldhfbP7PDEgHDzxaqlqamHFgL?=
 =?us-ascii?Q?1jUXL2Qyt36eJwUuSV8p1f1X96UjTRZD55EcgWvQeAuJ/qRJyEgy8O3VyPFr?=
 =?us-ascii?Q?dKEB5mGgQ67NJokT8jpm+txq/JlEWPRoX/0FHsIP+gLqFQe5E8MRzxGgLAzj?=
 =?us-ascii?Q?TdSjX3koyxyuuqtj6tgf8K+iPjF9djU4u4fqZOpB5m0FBqwI/2Q53Tg+0Nx5?=
 =?us-ascii?Q?fTjbzknhdCdq5EdEbXjE85hekAL8FnoIqfKtLevpEtjmbbfxGm2fk8i2WPth?=
 =?us-ascii?Q?YZm+OIe5jZ5dX1G68vkJb7GiOxgIjj9hP8DC5yj1SuUE8M4ZKm3PtDHeLOqr?=
 =?us-ascii?Q?FWYe1jxP2hMUPRW6zFSNJ5DdvdvoTPHJWYQOU/G2zJSiM4jIEeqBwZoQiYkn?=
 =?us-ascii?Q?3DUDZ2Hv6bJQvD5WrdbZ1g2bAc94iSfSNDJd+B028FJI6tE1chtG2Ibbb8FJ?=
 =?us-ascii?Q?ikuDvb/uGol2tMWLvDItdXCG/J9VpoDMFZPHTjlQQUX+E8RV+geNLFKVVPP1?=
 =?us-ascii?Q?Jw9g9LSny0pK9dzxyeHXGUKLeua8gtQl2SJRd1gxGYCbWV3S4Esdn8+ZmkAH?=
 =?us-ascii?Q?oWId16XDfFX1celT4pfvPcSg8Iu03A73iO3libWMkktUI8B0HB06LzoR7jCz?=
 =?us-ascii?Q?TZY7REdd60Po4iBCO8UfR2SIZ+GFpXvFWcZkxknZz6NRf/8Rz7IK3J36p8CJ?=
 =?us-ascii?Q?VDbZWsyfgptenvnnY5V0oxOPDTCp39RdA+gCdEkGzyzcYHt6iuRJV55xqJCM?=
 =?us-ascii?Q?GADTv02RDSzjCG3Zc2hdetBYgF5ocusdMbGIW1Cn/BkUD2VVcPy53/PCSmLy?=
 =?us-ascii?Q?DLlPUNZZGN3Robo93cg7rzw7OeRZUcuSEvD6tQeg4nswCu2X5SLuXoysWmz9?=
 =?us-ascii?Q?ScsmeuwaZmxCcBCXJ74S1WDSqrQnMhSpG+suTY03GlnS43PNtlMl/agFBp6H?=
 =?us-ascii?Q?rRJn+mrdp5osGGtaMEUxZOEigBtyMWYu0bDwhnzhUwCeCYN/NFDX81eLPPwH?=
 =?us-ascii?Q?LRVr+NFa+lJydMhiRcmTgSFdfQV3m/tR/XoW5SX5okycIzcF1Fei97eOTAMN?=
 =?us-ascii?Q?iYLLCGiVSJ10v0BH4od2Afmz+3jEYXVbJHwn1bMNv5wzxrc6VJ6AXnjUt/Nh?=
 =?us-ascii?Q?i9SEgUQnMLSAdAvrvJNwZyrrksz252+j0QuEqNRcV4RyoHFj6Mzn3IMpqmqs?=
 =?us-ascii?Q?/XNslL9YZuXsGJpHh7O96G8lGLa5KinZBvOI7dFYPmgPMnGom3IDgvuMU1la?=
 =?us-ascii?Q?prTt5244dA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dc112c-66a2-44c5-9962-08dea7c4686c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 20:58:34.2251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dyxb1H1bYEO6aFm+SC6UNOLLFUF80kMxFLm8FGy8a8wSd/wMEgFRVMGgLXx2cm0L0q9NqKDuk/0Cl/1SUGnd2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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

Add a timeout variant of wait_for_completion() that wraps the C
function wait_for_completion_timeout(). Returns true if the task
completed before the timeout, else false.

The timeout is specified in jiffies. This is needed by drivers
that perform interrupt self-tests during probe, where an indefinite
wait would hang the system if the interrupt path is broken.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 rust/kernel/sync/completion.rs | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/completion.rs b/rust/kernel/sync/completion.rs
index c50012a940a3..a2f46862365e 100644
--- a/rust/kernel/sync/completion.rs
+++ b/rust/kernel/sync/completion.rs
@@ -6,7 +6,12 @@
 //!
 //! C header: [`include/linux/completion.h`](srctree/include/linux/completion.h)
 
-use crate::{bindings, prelude::*, types::Opaque};
+use crate::{
+    bindings,
+    prelude::*,
+    time::Jiffies,
+    types::Opaque, //
+};
 
 /// Synchronization primitive to signal when a certain task has been completed.
 ///
@@ -109,4 +114,15 @@ pub fn wait_for_completion(&self) {
         // SAFETY: `self.as_raw()` is a pointer to a valid `struct completion`.
         unsafe { bindings::wait_for_completion(self.as_raw()) };
     }
+
+    /// Wait for completion of a task with a timeout.
+    ///
+    /// This method waits for the completion of a task; it is not interruptible but has a timeout.
+    /// Returns `true` if the task completed before the timeout, `false` if the timeout elapsed.
+    ///
+    /// The timeout is specified in jiffies. See also [`Completion::complete_all`].
+    pub fn wait_for_completion_timeout(&self, timeout: Jiffies) -> bool {
+        // SAFETY: `self.as_raw()` is a pointer to a valid `struct completion`.
+        unsafe { bindings::wait_for_completion_timeout(self.as_raw(), timeout) != 0 }
+    }
 }

base-commit: 610e892bdb57043c7769982c2bff0260b6007b75
-- 
2.34.1

