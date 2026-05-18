Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B08ECD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A58210E97D;
	Mon, 18 May 2026 18:03:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="kKkdwkKO";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07EA810E978
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGu6cAEmHGdkan+QDaDEvLzKgKg0YE27XQjblatQytD4hDYlzodLuQgitRnCyLlS3gb06cfn1Me/4eZ/eAUsivT++EASJMHrXnG3i/dbqCJiXIL6OvTn6LgU8bBuq97tj1eOLGApgSMBq8K1gsSVhZfN/oybiQXeIw6U55/c5BTTmtPj1FdJbZmTDqhqfQwh6IsLrDazR80HE+ean6XeFdhb+ArfP/fi0V42WUvXlLVDg9eXULnHvXLTOphhDs7qykJMWVD4vEoIBVJF2cavXx9gQIaAiCz2b4xfD9HZcWlKJZJ9q5kQbz/58Y1PwfVn+Rpt+O2ce8HOWP4j/mQZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MB5cqp0BbG0vPpl+RsAq+hf4ZZJwVTffKHqN9/J3kfA=;
 b=TxvPgHHNuUKKcSRXpyOE0U2UiM/dqe4gnOB4IVQ5pCFQAx1Ti37vwvIlTBYG27zasXxPCJGt1FhbDL0oCxQimJFxCLrg4D5jzTrR103TSy2a+3iQ4VUtRY+GwOtG8k3164KpEMhEptcsNT538AiuNMGRMkCS1f0lugdb4TFwYTkEvdV7hikZLr1SSSpK27D43Mr6G5MwLCUCb2DQaUSw44BJQqN4eyzHSnxgZ8g5X0a1V2hGyg5bZpz9yVf9SlJZUlLCq5wq0xWjJk7b5eQzS9REAiStDLmu/HxAi29RAdz8b92pHzvm0NwAbhKpE8u5sBAW4QlEmmnji+wmRNROLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MB5cqp0BbG0vPpl+RsAq+hf4ZZJwVTffKHqN9/J3kfA=;
 b=kKkdwkKOQRYQ5yP5B9kevSaJSNoIQ9KBSfLSzlj6xJy0kkyzsM7tFVaPy/QTVsWgzftbvLeQ5NBzCkQgH+VkxmpEleQfR5KtT0QrIOt01P3Hrq7RmQJJdEvW27j8bC/tudlYTlxL2k78f2jJ3CEOf9U4iep4I99xqM+iy50ax2dacaVQqA2SlsABx2OY/Pbe2HPSWiTRVfran8xiUAFP/0CQGgIP0nxVK01nkLzcKQmNTV0m8vCbYPGAj1l+cEOJrug51khz6lWCw21vGje/wQUpnhlOsDrcj6jDxLuh5f3z6dBi22dyYtUB3IUfMsDJgqN4BT+DbhzVUl3A+gTmmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 18:03:49 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.21.0025.012; Mon, 18 May 2026
 18:03:49 +0000
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
Subject: [PATCH v1 02/12] rust: bitfield: support cast+shift accessor syntax
Date: Mon, 18 May 2026 14:03:32 -0400
Message-Id: <20260518180342.2387845-3-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518180342.2387845-1-joelagnelf@nvidia.com>
References: <20260518180342.2387845-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::29) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: e464f98b-0079-41d0-6794-08deb507cfcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: YjV8PPQV+J4oecZToTQLxEpd7bMV91a43TzQucIdR9wYeuyEybC5ygEHeogFL/doxUcu5UYxb4y6fAc8AKHhrDBlpFUvY7Jm6yPQS1fujl4BTHV8DJ1sClnKtq+fZvpzsErDKg6ArMoaj8W45UkOjy5IdTtS+5gLWj5Be4tpEUIOsf3vjk2qThFEqb3tD9E2/oh9tqbusZ6EwgaCp1dh7fam3W3j/YjST6+sbGnb9HxgqBj0nwmG1ikmkXE4emn83J/TTop6WkExsuU3fbSzU2zy2qhLA2qw3Njmz8rtbmr6njBQak9cAG6QMKJlgn7urvHn9etwaBjOLuunzG+Dei7I+pFmhDgoFT3/GN/INoGa6rLPWJP0bPsEPfg7scxIg66LaOVPqa3APCp6/kO6eJYFqb7criRoyTADbJtMaa6yzFPqx9HlP0ghZPK5jfR5aWSddS9WGEeLROkKi6/jaVvOG3Jq1WEA7Dq7L2cSrsHwakw6xLZ9RaYu7zFrcZztjX+Fa/k6LoaKcVlDTpt8yfHl7g578DstqLqkJvtj+xVs3O+9x3qQmV1KlbfqHdvQdlGI83bj6J7HxxwHbbfMKNpspI8klJJanWJZ8QI8krFNcXz8fA78M5pJsbzUSCeViv5rKL+T2V/9Mdbahs9GqZD/C5QebS9JfvZaNopGxmaLkimjb6UUrM+yd7dFdEzZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(22082099003)(56012099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?re8wvH1BJZtK9BSf8das5r6YGSkelI2jPtGraOO8ysz8+uxUYwmGMxERUmf+?=
 =?us-ascii?Q?VyvEaxuo7I5ju3g9hZAT1NSYPpq7WncgLJlSv3t8yE5OAu9bLVnSM+yzt318?=
 =?us-ascii?Q?M5AP+++OQRG4nt/2Nq9K0FfOC74FV0L/igsc8Mib6TyxzZK1DHvajjreuXkC?=
 =?us-ascii?Q?7PIQEKvvJtYUA530DFrjyBjp7h9QJkhtnJs+T08ZIwrwADKb/3KwBamBmabp?=
 =?us-ascii?Q?kPwVU0Y47i23lb6KPr6cNd3rR5qhweB+p0rR9pMeIVoGisYNZu74mA7JW42j?=
 =?us-ascii?Q?YCYWVKbkiIl0F04ajLkKndtwU+v8AkW0AzjD3H4BcFpfvfLXDFPywckGcam5?=
 =?us-ascii?Q?2f74TqBoRo4H5RLEztCklWPNWCPvteNcBwRqdSIx/fNdToIrvBkuCj51TiSb?=
 =?us-ascii?Q?yX3YVUGyoMNfUuJVjc3d4h5xJF0YnEG1LEeJcEOvLL++VY0VRh04N1X+GUEF?=
 =?us-ascii?Q?1aHJX5Cz/7TPoXk0v8wTwkGSn/NE+lKp0r7twitigK5V/vtT/rLOd0Pt6mZL?=
 =?us-ascii?Q?5fed4Ci0OU3TVf/iFbEamr4jlSdNxCKw5eN1Qb+qUzMKvjtnJib+cSY8rQKr?=
 =?us-ascii?Q?5+/aNRYJhr2WPs3/t9xXv7BUzDRPfKFhX2dI7YG6Xubskoi8PCNslSR9l0eD?=
 =?us-ascii?Q?qmzZ1IVOv8E6/N0GmWxVMw7bsGdYzhPknValqgt4pLQdfzpQ8chLB+zc43Ti?=
 =?us-ascii?Q?0LQt+Xj6CTp+yXejBSMMRIA6Ve0Ki9l2CzpMtAXx2Ndy5BwtLhLarVPQdtZR?=
 =?us-ascii?Q?cEpLgp5+Lb115ACMR+qr+HhWveDxENkWfLKOPcH4WHOHz+dWYvpUPi9CgpXU?=
 =?us-ascii?Q?KPNxjboHJDEf24ByjFfzvOoUaHjCvaMYu9RPQiBP9SwRAz+SvnvN1qx60eDZ?=
 =?us-ascii?Q?eNzzmwoNs9i+MSUoaFrFUgT4Z1nbmUKvlmSMt9GKaD81CgnFgINNa69UrhE/?=
 =?us-ascii?Q?WJfXQLk0J2Ki4hf5TfVU36L9Y46jJGmNOHBDLg8W7ZGGruGDoMfW2ZiyjexX?=
 =?us-ascii?Q?slolAJH1upXGzIRxns2hwNN9Hh1ej6FCEnzi40LtzpJPF9KM/7t+yDxhZIWy?=
 =?us-ascii?Q?CiyrEwo7b0jku0Jcsw0NoQdneDsfSgTXD5B9/lDjCTp0l7nN++nAhSdBmdJF?=
 =?us-ascii?Q?F0SxSP3Pee7RkpH/rp79pIak/VDXWcptGGW53fJtcGKU+BRea2hJPtK5sicL?=
 =?us-ascii?Q?Ke1xrlFwgO3uBwyX+Yo3SNEXpbZGBV04x9hXB/K0kryEgco/Ndd3jH1D02D0?=
 =?us-ascii?Q?Ahl9qH999tQIo7wz356hpZx1xRNnZC+ZEUIPNEi3+73UEems10Tnh+kVHsJs?=
 =?us-ascii?Q?kTPzb0joedo1ay0jW9pDddqGh87jMR/RFY/WD+orCXtHeXfySmYrqdTAeVwt?=
 =?us-ascii?Q?w/r0rM3/6yTIE4h6rp5DsnfZixXiaafG3KG9w9P6crYeE6T+zB8ReOvNx1gi?=
 =?us-ascii?Q?mHmN3JLMeZ4vMca8IN2eZInMoH+4lSKbN6ewgkBtnbSDZnT+QkB1wZJELcdT?=
 =?us-ascii?Q?8NFSPOVYcVOIHuh3viCFknLckgTdHondHFyuJ7m9S4b8r5IcRcezLMw2kD52?=
 =?us-ascii?Q?ZVbIGTRSZllLq9+sKjxSneZxh3tIN6loBKt5XrYzdN+ZXo//JSQ+sp9To7yH?=
 =?us-ascii?Q?kdIw8zIqEFAGwshshw3jGCL2zOV+m+ik2jwHz1imsPPBijtcpNFnjClu9Bp8?=
 =?us-ascii?Q?i0qzYukZf2kr9xIF22BXczLRIaKVJfh5wwWEXguHStsWcACM5jc44GJeAnqg?=
 =?us-ascii?Q?6Nmv79Lylw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e464f98b-0079-41d0-6794-08deb507cfcc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:03:49.0351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMWdTCKTFT0I+eFgiz3IfNPIcM5FuVAgeISx1wUzMG7FlGLJDr2nPHbJfsV41qShNSXAkjFNWwHHhuHoSPwGDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114
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

The `bitfield!` macro previously generated accessors that returned the
field's value as a `Bounded<$storage, N>` for its raw N-bit width. For
fields whose logical interpretation is a wider value built by widening
the storage type and shifting left (e.g., a 24-bit register field that
stores bits 16..40 of a 40-bit address), callers had to chain
`cast::<TargetType>()` and `shl::<SHIFT, RES>()` (or worse, raw shift
operators) at every read site, and the inverse for writes.

Add a new field declaration shape:

  $hi:$lo $field as Bounded<$target, $res> shl $shift;

The macro generates:

  - A getter `$field(self) -> Bounded<$target, $res>` that extracts the
    raw N-bit field, widens it to $target, and shifts left by $shift.
  - A setter `with_$field(self, value: Bounded<$target, $res>) -> Self`
    that shifts right by $shift, narrows to the storage type, and writes.

Add a KUnit test mirroring nova-core driver's PRAMIN window register
pattern as well which is the usecase for it.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 rust/kernel/bitfield.rs | 67 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
index 9ab8dafff36c..1c1fc86441f2 100644
--- a/rust/kernel/bitfield.rs
+++ b/rust/kernel/bitfield.rs
@@ -57,6 +57,8 @@
 //!         hi:lo field_2 => ConvertedType;
 //!         // `field_3` documentation.
 //!         hi:lo field_3 ?=> ConvertedType;
+//!         // `field_4` documentation.
+//!         hi:lo field_4 as Bounded<TargetType, RES> shl SHIFT;
 //!         ...
 //!     }
 //! }
@@ -66,6 +68,8 @@
 //! - `hi:lo`: Bit range (inclusive), where `hi >= lo`.
 //! - `=> Type`: Optional infallible conversion (see [below](#infallible-conversion-)).
 //! - `?=> Type`: Optional fallible conversion (see [below](#fallible-conversion-)).
+//! - `as Bounded<T, RES> shl SHIFT`: Optional cast-and-shift accessor (see
+//!   [below](#cast-and-shift-accessors-as-bounded-t-res-shl-shift)).
 //! - Documentation strings and attributes are optional.
 //!
 //! # Generated code
@@ -299,6 +303,7 @@ fn from(val: $storage) -> $name {
         $($(#[doc = $doc:expr])* $hi:literal:$lo:literal $field:ident
             $(?=> $try_into_type:ty)?
             $(=> $into_type:ty)?
+            $(as Bounded<$target:ty, $res:literal> shl $shift:literal)?
         ;
         )*
     }
@@ -311,6 +316,7 @@ impl $name {
             @public_field_accessors $(#[doc = $doc])* $vis $name $storage : $hi:$lo $field
             $(?=> $try_into_type)?
             $(=> $into_type)?
+            $(as Bounded<$target, $res> shl $shift)?
         );
         )*
         }
@@ -475,6 +481,43 @@ const fn [<__with_ $field>](
         );
     };
 
+    // Public accessors for fields cast to a wider type and left-shifted, exposing them as
+    // `Bounded<$target, $res>` where `$res == ($hi + 1 - $lo) + $shift`.
+    (
+        @public_field_accessors $(#[doc = $doc:expr])* $vis:vis $name:ident $storage:ty :
+            $hi:literal:$lo:literal $field:ident
+            as Bounded<$target:ty, $res:literal> shl $shift:literal
+    ) => {
+        ::kernel::macros::paste!(
+
+        $(#[doc = $doc])*
+        #[doc = "Returns the value of this field, cast to the target type and shifted left."]
+        #[inline(always)]
+        $vis fn $field(self) -> ::kernel::num::Bounded<$target, $res> {
+            $crate::const_assert!($res == ($hi + 1 - $lo) + $shift);
+
+            self.[<__ $field>]()
+                .cast::<$target>()
+                .shl::<$shift, $res>()
+        }
+
+        $(#[doc = $doc])*
+        #[doc = "Sets this field from a target-typed, pre-shifted `Bounded` value."]
+        #[inline(always)]
+        $vis fn [<with_ $field>](
+            self,
+            value: ::kernel::num::Bounded<$target, $res>,
+        ) -> Self {
+            $crate::const_assert!($res == ($hi + 1 - $lo) + $shift);
+
+            self.[<__with_ $field>](
+                value.shr::<$shift, { $hi + 1 - $lo }>().cast::<$storage>()
+            )
+        }
+
+        );
+    };
+
     // `Debug` implementation.
     (@debug $name:ident { $($field:ident;)* }) => {
         impl ::kernel::fmt::Debug for $name {
@@ -582,6 +625,15 @@ struct TestStatusRegister(u8) {
         }
     }
 
+    // Mirrors the PRAMIN window register pattern: a 24-bit field in a `u32` storage that
+    // represents bits 16..40 of a 40-bit address. The accessor exposes it as the full
+    // 40-bit `Bounded<u64, 40>`.
+    bitfield! {
+        struct TestWindowReg(u32) {
+            23:0      window_base as Bounded<u64, 40> shl 16;
+        }
+    }
+
     #[test]
     fn test_single_bits() {
         let mut pte = TestPageTableEntry::zeroed();
@@ -806,4 +858,19 @@ fn test_u8_bitfield() {
         assert_eq!(status4.reserved(), 0xF);
         assert_eq!(status4.full_byte(), 0xFF);
     }
+
+    #[test]
+    fn test_cast_shift_accessor() {
+        // Set a value via the pre-shifted setter and read it back via the getter.
+        let addr = Bounded::<u64, 40>::new::<0x12_3456_0000>();
+        let reg = TestWindowReg::zeroed().with_window_base(addr);
+        assert_eq!(reg.window_base().get(), 0x12_3456_0000u64);
+        assert_eq!(u32::from(reg), 0x0012_3456u32);
+
+        // Setting and reading the largest 40-bit aligned value.
+        let max_addr = Bounded::<u64, 40>::new::<0xFF_FFFF_0000>();
+        let reg = TestWindowReg::zeroed().with_window_base(max_addr);
+        assert_eq!(reg.window_base().get(), 0xFF_FFFF_0000u64);
+        assert_eq!(u32::from(reg), 0x00FF_FFFFu32);
+    }
 }
-- 
2.34.1

