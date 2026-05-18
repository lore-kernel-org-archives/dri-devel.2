Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F78BCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69BA110E980;
	Mon, 18 May 2026 18:04:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jskjRJSw";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1955510E981
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOYxzeAbsUrpL2mXiMRa9JrWNbyFM9pR2bkej4wKGZD8ZasMlshsGUPVbTrYScNy3nyTIgUu6pJSr5oG699mRalg9JSQeO1RSE7UO4gteYdz9Mrq2H6LLFo5aI8OZhH+juhcmhWYxspwFBI5hgGxZUjjE4ohUjEG2uZmTXY5K9SdG+PXwcgKZI5bDPLCY/CkwHcqbr0p4Lrns2K4og33MvlhYrqIHa6jnTbXdYf/plAdqDjkhN2z6+f5I9+4KO3w6yc+xuRTS5u3BXbORy8kUxGcG6h+InjLqa6OSqTLeYYk9/iJ5ZjAh+EhIkX/nV9eIWv3p/4sbSzRzJh53PnvSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtzXTouGDn64f5wLnkUN92vhgASiGX53CGS0IDBQ8zc=;
 b=F7w4F169Qenu/qM2d0d+4UxRQLIdhRzFpQrO4jlf25AsiOA+0Ch9iWOUsmVM5LrfRuuFoiLGwy4gKO0dqMWjmivB6n6IqshsatdUkyifooZWbDW5TGb2JdDwMvNoC9eqyzobnNXB3w1JpDppJPh+zDUXpVNwliCHVTNkd5Yf8Zn6YVFbd6d7Zk2AQ6AUBmAimzZ1J+SAdMNQNzvRkqgDHsdozyJv7dRPPfED46iSbYr4mOHPc7UyhzyrKl/vTjNSj6ehkAovmVBEC5lVl5wQg9Y5q3JIZvlAOfdxShxHRcC1FaD6ZLUDDKCRBeo5eCDS/msF0cNhPpnz7J8eAoRrhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtzXTouGDn64f5wLnkUN92vhgASiGX53CGS0IDBQ8zc=;
 b=jskjRJSwDoDe8feimjebShNL5m1KBpPftWFqLj6IUhP808NHpsexBTg3bOYmNr+UkQS042nmfnW//WVgMbMP/VH5x6MgkTK/FJO0DY325RHpyj1yPkQEZl4xHICaBYpebC+x7Lz0RrRQq05HE8rAWjYB6MnH7y6A207jzpYLJ8iE27maRlYTvtyJ7iY2JlDipTYpgAVFeSNBDez5Dw+kwBO2HKBztG3hOuBhHBTKXOYhcdhdRkmkc53/GZoaYfdXdAZG0f0+V+hGCs+CyOCipJXfT/hjPtI0cg51njiQOaK3nybneVYlUwh7zBb+bfGzAqjyceu/rdj7VzI4GKJCUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DSSPR12MB999212.namprd12.prod.outlook.com (2603:10b6:8:376::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 18:03:53 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:03:53 +0000
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
Subject: [PATCH v1 05/12] gpu: nova-core: gsp: Expose total physical VRAM end
 from FB region info
Date: Mon, 18 May 2026 14:03:35 -0400
Message-Id: <20260518180342.2387845-6-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518180342.2387845-1-joelagnelf@nvidia.com>
References: <20260518180342.2387845-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:52f::34) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DSSPR12MB999212:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c4ef08f-9ec6-467c-5928-08deb507d20c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|3023799003|56012099003|22082099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: ggFsHvfBHDTgC822hfUByq9rYiQYDLiCgTjpBgsrLqb0smPe73X8fU+ebBQ54auF27GOAdtQ20NfuORuzX/RxotRBEWqAdMXyjaP9pIttvm6bAf+wlDWwAP8pjttV5wCXFD3bxECD1WXzRfu5Brl+rnlv2ljyrQBsUS7ZIuRSV35yvwKlfc7F80Vedhkfw9ZxU0V1E+ZMA6yMoaqUeUucwCeofRRGg1++q9pdFUWoJUlWU8nbdKCDfJpGJN+WwaC7TBdyOLfWRM8H27H0LX7UfWGD90uHnDCC+as9GpQBpwGJwheAsKQdpOtsUtPmjlxW61oxjWgVm2mxy2dvbNW1YtelIB71tI+Ho7WLFfjgN6zF+Yj6QaIPcP11WH85M765FV8yPqIxIxDkioZ7YCOfA2at26OXoc0rB5Hm4bJ7NQH+sxVsZX7WDBaqSdphUaoMTwRvCVY7BcvCPB3W0fKQZlsfymNjPu/6XFQjTvCAN5/r7l3xaZYNvTJZGMCFKxg4VuKN3h4TgktlrOZ4o3LEQFezizFFn5zRNCO+jMF8XF6Jxfcln9SBIisLnu/iFNscoYTghce11FCSik69t2myIw2D0ubGF1AES+WmK31cF0IJUsymQoXkVMm0tL6KP4dUNixR/ZrKP+byDfayCg7HIdh5Xrr19skkpmXKD5p39iSQL9nC/fg09SBucq2tFv3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(3023799003)(56012099003)(22082099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xXPmjnh1U3oEU46cOay9smCBWz8rKVCt8GUzJ6+C2RgrJdJuqnddk2GQ1axC?=
 =?us-ascii?Q?wdera6jVPty26mcsPnPMpLhsVfrWAz2EQEmeqOmGAnjnORr9bd4vl6+9oyty?=
 =?us-ascii?Q?qPzZgN3p3LcLYrLqjl37jFP2q2AA0ZEoFa5wTH308RIPakmKXqESNu1rDDEm?=
 =?us-ascii?Q?KSVx1x8fakLBueibWvg6r5dkIB5mRwvLaJbM6JKO3zZDlRouDWaO77CK2WiY?=
 =?us-ascii?Q?o+/mXsKw8zFByJGY2VD0EI7hz9UyFs2FBL/edzh1de9U2bREdCLJ11FS2IyG?=
 =?us-ascii?Q?puwjfAFobH9AGy7j5Pt+gU332w0/PKOVHwaUmyWk9kPedRS5QRy/PXxXLocG?=
 =?us-ascii?Q?umPSLvaUns8enTTR/Ucd5Hquq2DreVwuCG2mHB8XCrMS9jU3pcxFK+I1+FXG?=
 =?us-ascii?Q?TydIkgZCiLWy7gL3j7v5uNBUfO3uqqc9kH6PEYS8PBLotiS1+vOZeNAMdawD?=
 =?us-ascii?Q?53OIx5yP2RcJKZQ1xAgSNBRgGAXCxa8Fk4iCfaKSyWsOehwNC7jgcFTDAAlT?=
 =?us-ascii?Q?8o+k54oyF+tY+TH/V4BMqQbfXUMgVlKGTncjGkpvKZGpw6h7+iXSBd4pxzhW?=
 =?us-ascii?Q?8Rd/Qcle2WAnmTXdgVONMeDqdOrgkwVm66habbqV1JuPIlnBu783S0dfjwtR?=
 =?us-ascii?Q?mcIdNaTYmbawZroqkypWB6ipEfh8MmCz0ifMMfE+dbVB7IT44PgcdQ4P9B7a?=
 =?us-ascii?Q?pkFjPHChIK6+wzSAh7jmlUBWEesXI2ao3Gs51JrhfK9oWVTk4ZgyzRSTcP4S?=
 =?us-ascii?Q?Wm8//p8kDWKY8/m1rMZxA0Q15cHRvdHQbfV44TAheA0ZUvlUEfA16WHtc590?=
 =?us-ascii?Q?TFm5+wQzPHX5gXRFbeJ++AKew3nQuZzqoI5boVo8E5WOiH+BUaBGeCG4YFDR?=
 =?us-ascii?Q?KMmYHpYjPgcwvhauCi1N7BWiPiS/0FhM5JgcNUfGoyKOAoYWKedanEoKy4/I?=
 =?us-ascii?Q?0vPzKhN4ZV1BDLuJfql7opwQJbs+Sr6OUDZvWVwZeAmiKhaP/ZhjMj5YyYVt?=
 =?us-ascii?Q?tN/31EiaBDRGvXdSLS7lVy4/q4ggEC4jU5Ij10jj5ZzaTGdOiThjeEcBOUJY?=
 =?us-ascii?Q?OxkFLkwz20VV6IBZCCwPQAeSp1/R72ndX+Hc7tLfPQ3AKOoUAzD8iMGRb7oi?=
 =?us-ascii?Q?aLkHJD3sI6FdLYIA90OvIA6yEyD2Yjw+/HNizvNML/7BFRyRzZv4avhJs8DA?=
 =?us-ascii?Q?rfkDQG2W1G5jo3D2pDbLSDOwrqVJrKFJscEj/munFs6Rb9P6LBq7vXrFJ5r+?=
 =?us-ascii?Q?MVhHXIDOK/Imdf+b17J60w7lfILyoW6N5BDFHet1yxN28Ypal5HI+1pvAbJJ?=
 =?us-ascii?Q?foeSU2g5cNqgTlex6Bw4ZoGQInAm1PDCYNNyaKBbfVrTDuGTIwIPIWhLI8BD?=
 =?us-ascii?Q?VZeIF06Wo0xiGiBlyNIDStJWhVSwN98WstDZr10DKlrTpueI7BRxwRv3Ov+S?=
 =?us-ascii?Q?kuzKVbLZuwZ/yjBLUDj9ReoCBY1j8d2g00HJAkeQO3vLjjuEKT6ErxvFp9q4?=
 =?us-ascii?Q?LFW0XFeevULH3hQ2jNObGowqkbVWZ78eE6ruQ0Z+/lK+aC3S5h8VR9u8Ede8?=
 =?us-ascii?Q?C4vkWfHRNSRUuBeyxhJnTyFKPJn6DaLmZ/51RwBu7I1bsUNsj9YWL8RimIo2?=
 =?us-ascii?Q?5qvQ7fj5vA4qmjCI1eA4OtsAG7vMC0f09o2RoR36t9Xtqkt2ZguVYxVOjMSV?=
 =?us-ascii?Q?MQvc2wva7Iup7sO1qfBXr1lhvK+439TJopp+F+HuRWZUgWrIKg0epbPGsHhG?=
 =?us-ascii?Q?SWE1z3pIwQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4ef08f-9ec6-467c-5928-08deb507d20c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:03:52.8898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92S0xccvbZfVuEM/TLYCBdQVhvkzc+Pb5PieVv88wt5/V8Jg36r20e4uz255c+AMU3VuY3PIxmOPGxg0oxCz4A==
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

Add `total_fb_end()` to `GspStaticConfigInfo` that computes the
exclusive end address of the highest valid FB region covering both
usable and GSP-reserved areas.

This allows callers to know the full physical VRAM extent, not just
the allocatable portion.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs             | 11 ++++++++++-
 drivers/gpu/nova-core/gsp/commands.rs    |  5 +++++
 drivers/gpu/nova-core/gsp/fw/commands.rs |  7 +++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 775cdb653830..d9d1a7417a2e 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -8,6 +8,7 @@
     num::Bounded,
     pci,
     prelude::*,
+    sizes::SizeConstants,
     sync::Arc, //
 };
 
@@ -295,7 +296,15 @@ pub(crate) fn new<'a>(
 
             gsp <- Gsp::new(pdev),
 
-            gsp_static_info: { gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)? },
+            gsp_static_info: gsp
+                .boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)
+                .inspect(|info| {
+                    dev_info!(
+                        pdev.as_ref(),
+                        "Total physical VRAM: {} MiB\n",
+                        info.total_fb_end / u64::SZ_1M
+                    );
+                })?,
 
             bar: devres_bar,
         })
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 049fff337611..172411d7b475 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -196,6 +196,8 @@ pub(crate) struct GetGspStaticInfoReply {
     /// Usable FB (VRAM) region for driver memory allocation.
     #[expect(dead_code)]
     pub(crate) usable_fb_region: Range<u64>,
+    /// End of VRAM.
+    pub(crate) total_fb_end: u64,
 }
 
 impl MessageFromGsp for GetGspStaticInfoReply {
@@ -207,9 +209,12 @@ fn read(
         msg: &Self::Message,
         _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
     ) -> Result<Self, Self::InitError> {
+        let total_fb_end = msg.total_fb_end().ok_or(ENODEV)?;
+
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
             usable_fb_region: msg.usable_fb_regions_iter().next().ok_or(ENODEV)?,
+            total_fb_end,
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 50b9c205566f..ea663079d95c 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -161,6 +161,13 @@ pub(crate) fn usable_fb_regions_iter(&self) -> impl Iterator<Item = Range<u64>>
             }
         })
     }
+
+    /// Compute the end of physical VRAM from all FB regions.
+    pub(crate) fn total_fb_end(&self) -> Option<u64> {
+        self.fb_regions()
+            .filter_map(|reg| reg.limit.checked_add(1))
+            .max()
+    }
 }
 
 // SAFETY: Padding is explicit and will not contain uninitialized data.
-- 
2.34.1

