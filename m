Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F255AC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:00:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 547AB10EE74;
	Wed,  9 Sep 2026 04:00:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="utCkomOB";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AE1710EE74
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:00:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phgji0G9jTC+DezsAen9qNDmm1U7GdgtZL0/LYo1MtzGebF/2m0+mw0JlMfQTAY2AuYDeVs1HAd3jEUH9eWjkAy2jd5pDuhOo9K0dOQc1PbcEFwCu03IyguGnKQecxMsc6Fw9NeC6MpyB9wvu1nq1jOrRCI2WcLhYccMzTmhT21Uy4yW6Te3GKLA3AFBjYEphz1EhlUDIHajlOHjHrjbxha9vMu8Iky5MJjrk6XHjNXZ+RwsTTaLYIUFhK06AF+tD31bOYM0ZpDN0+blOXsT8Z4HOl7PyOe9bUgHmmK1hGp9zdSMGQqU472Cg6ZKMzM8Cd4FA1oLisV+eBE0TyaZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SvUjPA8yU+ZMwmFYnNYcsRElXwkoEXowwonemw1s6Y=;
 b=THVysiggPXh7Te/qiu3CYzWhb4eczT9zJlzgWfE9pVrW9JcGCL2hn6SHlkocm98LD7JR7FIXZZX5XszPpEX3jqrjxZ3/Mmtxm+VAoY1JaPJbDUJfNpRmQrInWARRkkHNevspVW4NrQRZIDL7HeVxk9e/1YWguy8BTzFt1x6hYOgnHymYYVrwrJXgtvsvTEnlsjdJJcBmrOgusS8JVK+ISt9RXJ2N5tQKTFss2en1Mu/5dXC70sU4PvDjhgXkif7qRAcnhvbOQvy8WZQHyDw7OJzJ15072zVGYtedkFFlldQPeLqzoxNx7CxDr/VGMCEW7GbyWh3ylB0u5EfrqZ/ckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SvUjPA8yU+ZMwmFYnNYcsRElXwkoEXowwonemw1s6Y=;
 b=utCkomOBYgHUyzRCc7BZ6r4lxFDV+uboxGjosYEboJJtGqb3weoyI0T1opLI+wGwoHz4oF0oizyQzzAlytSX5VDXohP4ow3xCVZo1GnfJhxO3D1XJELY8G1eIpeXemj18CTlCHgVVU+CYsn1hVUwPnMrhFMNg2viVqKqXQ6Sc/hgRx6vyHkuazShfIYqxGpwJwmonv/q5EvKGZ7k/U503W2n7e5VJhezUFTWFJL1d3cTdUvqvJ17DlOSkF4h/ungGzuDlkF3VE99h6pnOlcozGrPukgaghZ/hd2iV/2i0jXfHg1AY6q7F/mB2ZWDzrwFb3GNxUZ0He4Sahy7754o+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 SA3PR12MB699018.namprd12.prod.outlook.com (2603:10b6:806:510::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 03:59:59 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 03:59:59 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 09 Sep 2026 12:59:39 +0900
Subject: [PATCH 01/16] gpu: nova-core: mm: Add common types for virtual
 memory management
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-mmrebase-v1-1-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
In-Reply-To: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0107.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::7) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|SA3PR12MB699018:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dfd9330-981d-449f-7c48-08df0e26d101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10070799003|6133799003|3023799007|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1CvOB9D3r93+tzRkqEhZy7L8ndAZIZVs8/E2ZhDVQ9A6xNId+Iwilht/1itguyXsxKMXa19LtrWBMSGuEjBbV3kUFDxfq8NA2LIAjui29BnLmpesEPsks5a58CpXYUgKFOU00zRGY53I2Rdihj3o1rCo9dZuTyPlaz941CwALOJU+Xi6nsxF1EAatENlQjrZJqNbNRJgaD8tfT0jokxLjcpcUQ6Ns7DL1hu1a5Yhk2wbdgOc/J65h+V3LV71sjsUrv23lgcggmCAVrmFChIxz0T1C1GWruM4+o0vSpSQWrn0xKuldAjkgq0o6STnWFx306ZbEu1XzxqZJH5/EFtSKjDme4tvMkAShpl+xjZsRWEYKn8b9aVg7Q4pzCfdE1Mgs6Vi/feVHtHR9kazGHedvjXFSeCu+juGG4FwnR9DgRJRSeDjrRLRA8iIk3f4TFRHEU5WU3XkpRXGguLcZyZHy/Ngy+Rsr8RnXUBYH1jFUq7qanHHqP2CqnyJ16DD+VYlQCyFj5K5ZnHUqFrERwZ4Y4cpA5GXIjkFp159D/SQIJc38KYPNVrzO4rMUNsNhEfCH+0filXS1Bz7Z4qvl3D3WAAVVy4sUHgSxmvupMcuN/b55wKq8DvhQ8vKz+pB6tIs4mrAoWT801SO6jh5ngjRG8xi+W+W09DYQbgfOWQYrfE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(6133799003)(3023799007)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWdzTURKdzdhd1kzdnk3Q0ZaNWxZcnoxV0hUc3h4TVY0Qnd0RXFVM0JvOVI1?=
 =?utf-8?B?ZEZSYVhQREswTDFFM3JZV1NFYVB2ZnFodWpvZGhJeld3SzQ0QS9MU0crRDlD?=
 =?utf-8?B?Z2FiUXREQjFLTVRWQUFRanBZT0hVN0k0em9nTGxWdkpUQ1Z1dGd2TEpKRG9j?=
 =?utf-8?B?SjRzRlBNeFowSDR5aGhOYUVhMnRzL20rdHBocW5rVDZXQkNxVUt5NFVPQVhT?=
 =?utf-8?B?RWt4aXBIbCtjVlJNVmpRTXRMS3FyNmpDSjNjcE5nSmMxTTJKTm9MRXc5Um45?=
 =?utf-8?B?NlJwUjdxcUJwMlBLNDF2ck1SN1pNZW5jNWZPK3VTa3JISXhkQzF3akk5M2ho?=
 =?utf-8?B?cGJLV3VYdXZzQ1JPM01HbHlnbFFYK1l0TDB0U1daVG1XYVJBZ2ttVDVRZ0pl?=
 =?utf-8?B?V3F4Y0dwUUhFSUZkU0xhdDRoVUZ1cFB1NzVYWTg4Z09wTGZSUm1YOFlKRGFh?=
 =?utf-8?B?RTBYVFJhbUlTazFHVWdDRGNVNWIzVUVHU3djQ2tTMVFCd2h6WUlPblpTTzZT?=
 =?utf-8?B?dHBKVUljUUJOMGxRVkhsSDdadHhxS00yK2FHSDVEVFhoOW9YM21mZW9yQi9Z?=
 =?utf-8?B?RWh4bitOV2hlbXJMZmNrVjBIM0dmdGZWcnl2TUhSTFFOVktDaEIrVHFDeDRH?=
 =?utf-8?B?UHFQalFkaTU4TFRmSk9mMGphOU1KNEpucmo2VE1rTUpIdm5nZTBhV1psZ2hY?=
 =?utf-8?B?QXc3Sk9WdjlRRGlGZUF1NkQzVVQyRllHdS84d0QzUzl1WmNhKzdpUlBKYjVQ?=
 =?utf-8?B?Ly9zaUk1U1NjV1EyMlN5d3ZTVXR5ZkJJamsxajQ3K1pZdi9Bdk9VTHhlc1Nr?=
 =?utf-8?B?LzJmZDBtY3gySFNrQmdYOUxORGtIVHJYREV4T1YyaGVmK2lIaE1TdXJvSVkv?=
 =?utf-8?B?dmU2WGtoUkV6UnJiQXpUYmlHajR5c01KNytzbjBCUmZrMWE1anlrd3MwWVJr?=
 =?utf-8?B?ZERlODlpd1NCUmtGUlRWK2k0bTBLdE8xSlBOOU05Uy9sNnVyL1hvUE5vOGZG?=
 =?utf-8?B?QVE5cDBaT1NOYUJXTnRjV0p0RGFzOTV6NVkrMjJUSlFOZTA1SC9KbGZJRFVZ?=
 =?utf-8?B?REs0ei9Eb0hGenhuR0F1N2JKcHlZck1jUHFCYTNxeXB2OSt1VldFR2Z3MWRW?=
 =?utf-8?B?d2IvTnQwaUJ4dXo2Ti9zdWZaOFZwajVGQWxhMzZmNDBCdE9OY3YrZ3pUNHJX?=
 =?utf-8?B?VzBXazlmalNaVlFuRWJsQU1CL1N0RjdySDBacTd0ZDQxL2EzVlFrdGtrM1ha?=
 =?utf-8?B?ckFBUTNaaDdSd0F0T0dKV3Y1NjI5MXVHRDd1ditLMGlRVjdYRlljTStkLysr?=
 =?utf-8?B?QlRna0MyWkprSm9pV29NUWFtbmZmaEx0QTFSMFZkWVB4SGt1N0lPOGw5OEJC?=
 =?utf-8?B?RkJMWXFpUUlMa0FmWWw5NjJFWVNMM282cTIrUTRUYWgyRnJ6ODhFMWtWK08y?=
 =?utf-8?B?akJ1N0ttNkQxOHNGYTBxcnJ3MnEydGxXeTQrRzEvWWFvUGtCMHhPTjFybUFT?=
 =?utf-8?B?ZStqVVdIOVRHc3cwM0ptSFZzbVRJRDBMcjYwT0l3UDVaaVhQZWU2T20yN1Y1?=
 =?utf-8?B?czYwa1AyVHBOYXZNQUJzTVFTVXZFdmpxV1BhRHhRMXdHVkozeTRUa1RvUXlM?=
 =?utf-8?B?aU5Ta3JIbnMvUkltNWpuRjlRMDloNmxxLzJyMll5dG8xczdhampYcXZVVndn?=
 =?utf-8?B?eXI0bk8xdEdITkE5WkJtL0lCbURIMUFXc3poeVZKbm1uYk1qU0ZFZGNPN1hv?=
 =?utf-8?B?SEI2U2MzcWJ4SUlCK3NDSFRjN2pTRkQ0RGdYTVZ1b2J1ZDErcTVhMUFHN25J?=
 =?utf-8?B?NjhqSmwxTmkwaUVsT0tZZERZVmc3dWJGQVE0ZmxEVVhINXNMdm1ULytJZzdD?=
 =?utf-8?B?a0pRR2FBSEdHbzI0TGY5SFY0VzNDRUZVNlRQYVRxWG9mN3IyZ0NaWTd0U3lr?=
 =?utf-8?B?UFJPT2hWeFNkcVVCZTJoUWJySHNOdFJmT3Q1T3F1eGFsWHBUWTd6MXNrSy9u?=
 =?utf-8?B?bkxSU01JVTA5VGFuVVNqS21rZVZ4M0o5UFZmcUJYcllVMk13NG5zbXZjdWlI?=
 =?utf-8?B?OGlsQzFvRmNYSFVIeHJnNk1aNVlUcGRMTUlYUjBZbTdDdkZvRVZCeWIrNXkw?=
 =?utf-8?B?U0VxY3VWcy9pTWdlelJjbUs3NWxiR1Buem96THJqVkU4bnNOd28zM1NiWlhj?=
 =?utf-8?B?NGxKaFRyaE1WclJNNnR1OHNydWlCRU1EdU54aUtCcGc0Z0prRnZBa05scUtT?=
 =?utf-8?B?ZXVoV1I1TlUvL3dOZEowRW1nVlkwZ3ZFZXRvZmlSMWRmNHFaSlRERUt2L25I?=
 =?utf-8?B?RnMwS21rWC9IakNnTVAvdVJReS80MVA3WVNreWVwWWp3QzdLS0FSUkRwVFJy?=
 =?utf-8?Q?TpFw0HILwCidCn7ri35YtcW5BRK1zn8oWyajc/674+l8O?=
X-MS-Exchange-AntiSpam-MessageData-1: uT2mi4cAVO+qwA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfd9330-981d-449f-7c48-08df0e26d101
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 03:59:58.9035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuqZB9GqzdjFyZgeeMERafRHelMjYajTKFpp1CBPKb2nhscS5OfN4/d7YW3ky4sIVe+rKkr/bXJEFnDnUWXK2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB699018
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

From: Joel Fernandes <joelagnelf@nvidia.com>

Add common virtual memory memory management types: `PAGE_SIZE` constant,
`VirtualAddress` bitfield type, `Vfn` (Virtual Frame Number) type, `Pfn`
(Physical Frame Number) type.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: restore Pfn and its VramAddress conversions on the raw API]
[ecourtney: make dead_code expect unconditional until the self-tests patch]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs | 142 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 9e4338c7c393..4234ba4d596a 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -3,7 +3,34 @@
 
 //! Memory management subsystems.
 
-#![cfg_attr(not(CONFIG_NOVA_CORE_SELFTESTS), expect(dead_code))]
+#![expect(dead_code)]
+
+/// Implements `From` conversions between a frame-number type and `Bounded<u64, N>`.
+///
+/// Each MMU version module should invoke this for the specific bit widths used by that version's
+/// PTE/PDE bitfield definitions.
+macro_rules! impl_frame_number_bounded {
+    ($type:ty, $bits:literal) => {
+        impl From<Bounded<u64, $bits>> for $type {
+            fn from(val: Bounded<u64, $bits>) -> Self {
+                Self::new(val.get())
+            }
+        }
+
+        impl From<$type> for Bounded<u64, $bits> {
+            fn from(v: $type) -> Self {
+                Bounded::from_expr(v.raw() & ::kernel::bits::genmask_u64(0..=($bits - 1)))
+            }
+        }
+    };
+}
+
+/// Implements `From` conversions between [`Pfn`] and `Bounded<u64, N>` for bitfield interop.
+macro_rules! impl_pfn_bounded {
+    ($bits:literal) => {
+        impl_frame_number_bounded!(Pfn, $bits);
+    };
+}
 
 use core::{
     fmt::LowerHex,
@@ -11,12 +38,15 @@
 };
 
 use kernel::{
+    bitfield,
     fmt,
+    num::Bounded,
     prelude::*,
     ptr::{
         Alignable,
         Alignment, //
     },
+    sizes::SZ_4K, //
 };
 
 use crate::{
@@ -58,6 +88,9 @@ fn pramin_mut(&mut self) -> &mut pramin::Pramin<'gpu> {
     }
 }
 
+/// Page size in bytes (4 KiB).
+pub(crate) const PAGE_SIZE: usize = SZ_4K;
+
 /// Physical VRAM address in GPU video memory.
 #[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
 #[repr(transparent)]
@@ -124,6 +157,113 @@ fn sub(self, rhs: Self) -> Self::Output {
     }
 }
 
+impl From<Pfn> for VramAddress {
+    fn from(pfn: Pfn) -> Self {
+        Self::from_raw(pfn.raw() << 12)
+    }
+}
+
+bitfield! {
+    /// Virtual address in GPU address space.
+    pub(crate) struct VirtualAddress(u64) {
+        /// Offset within 4KB page.
+        11:0    offset;
+        /// Virtual frame number.
+        63:12   frame_number => Vfn;
+    }
+}
+
+impl VirtualAddress {
+    /// Create a new virtual address from a raw value.
+    pub(crate) const fn new(addr: u64) -> Self {
+        Self::from_raw(addr)
+    }
+}
+
+impl From<Vfn> for VirtualAddress {
+    fn from(vfn: Vfn) -> Self {
+        Self::zeroed().with_frame_number(vfn)
+    }
+}
+
+/// Physical Frame Number.
+///
+/// Represents a physical page in VRAM.
+#[repr(transparent)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
+pub(crate) struct Pfn(u64);
+
+impl Pfn {
+    /// Create a new PFN from a frame number.
+    pub(crate) const fn new(frame_number: u64) -> Self {
+        Self(frame_number)
+    }
+
+    /// Get the raw frame number.
+    pub(crate) const fn raw(self) -> u64 {
+        self.0
+    }
+}
+
+impl From<VramAddress> for Pfn {
+    fn from(addr: VramAddress) -> Self {
+        Self::new(addr.into_raw() >> 12)
+    }
+}
+
+impl From<u64> for Pfn {
+    fn from(val: u64) -> Self {
+        Self(val)
+    }
+}
+
+impl From<Pfn> for u64 {
+    fn from(pfn: Pfn) -> Self {
+        pfn.0
+    }
+}
+
+impl_pfn_bounded!(52);
+
+/// Virtual Frame Number.
+///
+/// Represents a virtual page in GPU address space.
+#[repr(transparent)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
+pub(crate) struct Vfn(u64);
+
+impl Vfn {
+    /// Create a new VFN from a frame number.
+    pub(crate) const fn new(frame_number: u64) -> Self {
+        Self(frame_number)
+    }
+
+    /// Get the raw frame number.
+    pub(crate) const fn raw(self) -> u64 {
+        self.0
+    }
+}
+
+impl From<VirtualAddress> for Vfn {
+    fn from(addr: VirtualAddress) -> Self {
+        addr.frame_number()
+    }
+}
+
+impl From<u64> for Vfn {
+    fn from(val: u64) -> Self {
+        Self(val)
+    }
+}
+
+impl From<Vfn> for u64 {
+    fn from(vfn: Vfn) -> Self {
+        vfn.0
+    }
+}
+
+impl_frame_number_bounded!(Vfn, 52);
+
 #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
 pub(crate) mod selftest {
     use core::ops::Range;

-- 
2.55.0

