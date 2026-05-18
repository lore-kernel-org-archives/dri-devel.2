Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9BCCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15A7F10E984;
	Mon, 18 May 2026 18:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="OPwwpZQx";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010063.outbound.protection.outlook.com
 [40.93.198.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 424AC10E983
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nb9jbM3at9QQtO7djDIK3QxZEgxE8Z2kH396hCq2Q0KTCBo542j9EqP26USlgXcyKjNlZbPF700iuHCxvizCk2vk2iL8M1MsGNlLyawMkV6iqVOzVDA/uqTw7VV72oN8F7dQZhSoHsBD1xE3KNwC1qWCLDKmta9tixvRXpJ7V72KQSCePYNUix4vUKy1szqLjNV2E8Bmfwfk/zSzjIrNQg017nG9rW6RtdUSTT07s5qjAvyDbMZEbg8LyMP3OxtwSS+fXPvXkP0gvARllIAiFR2irl9us/Xko2CsZADzgjYXjKaTl2uWa26AE5z1LA6vcQhBKawWVKiAvzglPVQ24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwCHbp+0uKPWJFkOaa/Ao4EUQ51A8/4vlYqPLO+Hcz4=;
 b=wCuQ8Y681wfUCblhnetpmLY4YoGehA3U6LAF2Ed1HmJeSij1PvTQpSDeRaAgpzKzNZIOhUkkJ3PGurLnTaSM2iLQ6JNTpW11YgYxMAvLbxHXNqe0Mm4f6e8fRLmkvxITi6t99HwuYJcfNCCcRSoXE7F9pFqwoUJkK0H3oK9ixuzVremH0es6ytQsUKtuIZnW5+kUBSJs+PoVQUkBrFzofvYimPo5YYih5y22y+122nVxx5MEzb+piyYk6auP6QmxkYjgOWbDIhchloPi9+8F9TT+zbJ5no8lww1XFU+d7M/2LxAj59Mmt2Hqb5H45ZUT5LH/0JHabuS6flVbLxu14Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwCHbp+0uKPWJFkOaa/Ao4EUQ51A8/4vlYqPLO+Hcz4=;
 b=OPwwpZQx+9OKJp556al3h6afm1QdcTz3Pl5MWV/ifSmwe3hcsRTXqHZBx3nq7uFWF+85BI61sqxliGtFtOikUIzX/YQkfF+v71qd4lUt1nR3Tw2mOFtqeRMJ4iv0ydcEIJRNCDA+sEYt7q+4XZXlvG1F5donCFGAYx6SVPs8cxKQt/pFRnqvSMZ6yFBeWoPd7cFvvYwACBwoF9JnAaYZyGSjwkJm1Q1UGeQPggq60Ofc494gf5/CtDN0jUWDQZcrgYLkPUT+dp8VCDUZFC/Pa8SXCGXWJDN/ApTtN5pb7d9MgWf6mR/zPYuEe7MgpdpFoOVaVJjCXvuz9Qk7nGKfFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DSSPR12MB999212.namprd12.prod.outlook.com (2603:10b6:8:376::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 18:03:57 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:03:57 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 alexeyi@nvidia.com, Eliot Courtney <ecourtney@nvidia.com>,
 joel@joelfernandes.org, linux-doc@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v1 08/12] gpu: nova-core: mm: Add VramAddress arithmetic and
 ordering
Date: Mon, 18 May 2026 14:03:38 -0400
Message-Id: <20260518180342.2387845-9-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518180342.2387845-1-joelagnelf@nvidia.com>
References: <20260518180342.2387845-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA4P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::17) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DSSPR12MB999212:EE_
X-MS-Office365-Filtering-Correlation-Id: 9625cab9-67af-4373-a516-08deb507d4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|3023799003|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: QqGOWeKvfWGvW9XFymPmCzZzlvBU0zgy3T23O/WxI4jqGd8WsDsmBJWxdZx3QXprpAHH71rqHj1CbbvwGZfEJ6zqtGwBaTTOFfEP1A57VGfnSxhmeGd5l5r4tNJO37Q1nvPFGIBHr8ww9qbbNHaSdOjpZuKjp8YlXEKcF6rFEFSHAfbuVuad73ciQQKpkz1yc+X0e4At+KmW1k7QCbdABTyuy3ZfGaTcE0Rtgf+qvPDYEeugh87Lf3YgYbp7aheG+sfuQvndM6IJva7MzeZkLy9QOs3FkByzaxxQl9b7ewkzxg1sh3sILyg35W0v/iP8IhwA2cUcKq1OyNmvTVlGNkUDi4q71Ccw+Wz3oHl0HYTjlNxVs+7XTVGaS18mz69zSPaVqOcU9y9l7hxZGAOHJNfgDaZd3PkfgW1yA/WhxnzOEpN00Zo+kmbnz4z2COgz76Dwrj7POuaYAyDMF9m9FAvjmbg3hhNNLhr/lpSvVITWqqtTjFWZjIaTkBnmTuMkGFIaubkW+xwcZTOy0sxLLW7waMqDBa3TcGduvgnCJCG78hLX+62CrYpIA1YVcVW8dh05lgX8kzhALtbn71kHnNsS/uLT8QD/rUTUv1PPb404sOWstkgnwT9xQMquYGBuE5RFvwJLJTZjTLHlHCMTno30N9YGdGTpVXEDIV0MnRR+0rAzywgdKWuJi7v66TkM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(3023799003)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fXj+uDalyhHhdOYa7/Mr2K2/aXiO6NwDj2TOcpY+d5o9924rPlIyoFJdNiMM?=
 =?us-ascii?Q?qd8Q5Us6NG2S/Wcu8khNPLSUlctXb2d1Raw0gBzVk0BZLHntPzzR983ULdFR?=
 =?us-ascii?Q?qfRcrlf+zprOoBBiIaDSR67FVWrcA9iGkjNlJAV2smCIv6IVUJOEMbMNuiS/?=
 =?us-ascii?Q?aqle9wm9v9dYiXQ8P2HgzfZBxB3uA3vII7xxLdYZhdFzNvJHmB4gXWIG6y19?=
 =?us-ascii?Q?vGhADeFNzybxpO6xZ2E9SgrC2pNywq48TooyopdHLeEhq5SbIR4D8GT1bWlz?=
 =?us-ascii?Q?EJdHMuAEqnpQo6NJbREamOeQGIgD3I9dIJHF/u+DdpnrSIaQLxw5A5EyfUqV?=
 =?us-ascii?Q?XXzpkNCjUdXjOEKLevrCKPqBiwujrD5gIGDq7OBQifIuGs7F9WWQU7BWeaIR?=
 =?us-ascii?Q?RP4aerZKjU7A0upfC71EzNAuBwxXLlItKeSW/58W9YsTJnuXiyz4loBCIkGp?=
 =?us-ascii?Q?M5JcGYYpWRCapELpg72n5qZrRso5DqqyvTDMryNU9uR9XhhYpDOD7GxSS0zE?=
 =?us-ascii?Q?6tOm+jA6nresDuiGxl9sjFMOqy9Eah2meqTecgJRscy3hSbkfhL8YqpUEpLn?=
 =?us-ascii?Q?HywBVw0cEXOKSUqEB1G6ZmkMJfNETQ4I76HBGFIx1xquhb8DzxS1sIdtqug5?=
 =?us-ascii?Q?rbImI5wXdprZoym33Kcm0FAa7mlrcrirDIQFcZFwft8SQbdYlMQhEAREvUN6?=
 =?us-ascii?Q?cHnbVo4AvXI/eJXXjtGhujBX80uWWWhYnVJEFfJvfRxYWXoI8Q66cDI5AtTI?=
 =?us-ascii?Q?Bpp7XLRNLRMOWWEYIc89hI/3lOzBy7QFJ7F+D0+dzXl0rnGd2mktb4AUwgFm?=
 =?us-ascii?Q?ZXM951m7Ljr3he9dlpTN3U6pZAiMeyRqivaFdGSVNi3SC7H3zWCGFiJtime7?=
 =?us-ascii?Q?+yUK5DxyRpYutuI7AJlk1xGbvBE0JJWfJ0TIdMXUJARWBi15LuWhozn3R3Au?=
 =?us-ascii?Q?Lcg+LDIyIRnhquG6GyxPXXwJcA3D4HRMv31xIDGLrL+XuMCbkGxlbOy0vCcq?=
 =?us-ascii?Q?rHj1zsm3LzWKUQCldIg3Oj6pJlXOASwXEAauL7+n5spN01C6DA+HqihzmLd/?=
 =?us-ascii?Q?3GbzZne9sqWQ26+1Hrq7lKgeL4oqISTiEbS61vCNyHtkrvkkGOQVUmX0E5NJ?=
 =?us-ascii?Q?BQ5fyR+CKmYuMNkeKhJqVXvYR8TsCTz1/aAlAEDLY+ovhnRfDJu/a5lR/6cx?=
 =?us-ascii?Q?CuWOGxOg6ANUhHtkWop1sz7X+yu/gdJ3Y36iloEiEjRaLg6dxiwMRKRoi+tq?=
 =?us-ascii?Q?2CGKQB5nKmQtvkGMTtnTqaF2bLwn9RxoVW+Sw9iz9nwKaAzLyh7cBbz+nsLz?=
 =?us-ascii?Q?0A5KbhTwNCiU6FvF1d7thfbqcfJfgNlCAr6T84UmSkhS/V+NT3PO3WTzcP4e?=
 =?us-ascii?Q?ooR6iXDy+JXZc06v7PEsaVFcgX1FC5yyBbKz0xRPUQYMQ3nDjfWy5SroBjG2?=
 =?us-ascii?Q?ki+V3lAgouHNVyRUcEXyec27snbVMBK24q/wV1U6NAwib+UqR2igomsCmTqk?=
 =?us-ascii?Q?brJv4niu9QmFbQXWdx1e0LA7GgJYt1mKYOYZ+4ZnTYLvge5fwxd4cx7qsRIA?=
 =?us-ascii?Q?P0T9zzH/2OyHP+YgL1sxjsY8FUd/HkfTJNek1aLZ6byCHFShlG8Sa46OA99+?=
 =?us-ascii?Q?Ma3Ae2wIYwYbfmirjcYweGgXFb4ugi1LKkir0JiGuYFQpukCWAsLfCmZQjlf?=
 =?us-ascii?Q?6ANQjdvXWr9snxc2lkYXlXcB/57o8ixmkNXYSLMtm+ZugfZWlzujdZ3o6KVy?=
 =?us-ascii?Q?M1EWuvcNkA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9625cab9-67af-4373-a516-08deb507d4c2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:03:57.4426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4p9jQ9yzsy7/kVrJ7ljYCcWp662oIfiSeWKiSjphjroqQQOhuP22t++EUhd+iyzmR1a/6/RYfhjwA43UUxgw9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999212
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

Add arithmetic helpers, comparison, and operator overloads for
`VramAddress` which are required in later patches for address
arithmetic.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs | 60 +++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index f8a70f93bc03..3bc9befab397 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -59,6 +59,38 @@ pub(crate) const fn new(addr: u64) -> Self {
     pub(crate) const fn raw(&self) -> u64 {
         self.into_raw()
     }
+
+    /// Align the address down to the given power-of-two `alignment`.
+    pub(crate) const fn align_down(self, alignment: u64) -> Self {
+        Self::new(self.raw() & !(alignment - 1))
+    }
+
+    /// Add `rhs` to this address, returning `None` on overflow.
+    pub(crate) fn checked_add<O: IntoVramOffset>(self, rhs: O) -> Option<Self> {
+        self.raw()
+            .checked_add(rhs.into_vram_offset())
+            .map(Self::new)
+    }
+}
+
+/// Lossless conversion into a `u64` byte offset, for use as a [`VramAddress`] `checked_add()`
+/// operand which can be either a `u64` or a `usize`.
+pub(crate) trait IntoVramOffset {
+    /// Convert `self` into a `u64` byte offset.
+    fn into_vram_offset(self) -> u64;
+}
+
+impl IntoVramOffset for u64 {
+    fn into_vram_offset(self) -> u64 {
+        self
+    }
+}
+
+impl IntoVramOffset for usize {
+    fn into_vram_offset(self) -> u64 {
+        use crate::num::IntoSafeCast;
+        self.into_safe_cast()
+    }
 }
 
 // Allow VRAM addresses to be printed with the `{:#x}` format specifier.
@@ -68,12 +100,40 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
     }
 }
 
+impl PartialOrd for VramAddress {
+    fn partial_cmp(&self, other: &Self) -> Option<core::cmp::Ordering> {
+        Some(self.cmp(other))
+    }
+}
+
+impl Ord for VramAddress {
+    fn cmp(&self, other: &Self) -> core::cmp::Ordering {
+        self.into_raw().cmp(&other.into_raw())
+    }
+}
+
 impl From<Pfn> for VramAddress {
     fn from(pfn: Pfn) -> Self {
         Self::zeroed().with_frame_number(pfn)
     }
 }
 
+impl core::ops::Add<u64> for VramAddress {
+    type Output = Self;
+
+    fn add(self, rhs: u64) -> Self {
+        Self::new(self.raw() + rhs)
+    }
+}
+
+impl core::ops::Sub<VramAddress> for VramAddress {
+    type Output = u64;
+
+    fn sub(self, rhs: VramAddress) -> u64 {
+        self.raw() - rhs.raw()
+    }
+}
+
 /// Extension trait to convert a `Range<u64>` of byte addresses into a
 /// `Range<VramAddress>`.
 pub(crate) trait IntoVramRange {
-- 
2.34.1

