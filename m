Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854D7108B915
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB86E10E566;
	Fri, 20 Mar 2026 12:20:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FtNaX4Vt";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E86A510E566
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:20:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzO/HXyPInHK6JUE6CYOc933DeV5omeaBOAIq/ZW4QLmbIlSj5oCjhk0TAoUOeurTp5FIfIUl43tK6DcPfh7KIu12jJGZi5FVeome55yB9mOLk3KzgAwCBetdG9ALA879LpL9zJnoYHVtDJ9dPWmPI/rbDUyK+krO9j8/lZt+Niyb3sQMi6tELn8vhlU8kjIzwN/hzKlhBB+7xuJRcsBHvfoqNLZ40Z3OnL9AfgaZtJzX0Vh35JLkHsVNc+X5eJp/tyfKyMZTc/IJgbWqR9LyWotcYaGoa/IXCdjzVgOX0iG8+OEsqn9qxGqoR430dqBGZV0j9YgIgdEgU6DpKaYyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMkpfNefJD9dqWJ4Ipo78ow4fot5LzFKXe4IIK733Fo=;
 b=soFr+TE3U8pp3egffNEVZpAzQXwuY5gpcvdo3gMFQkUIfsyDWioYPVhe9Pf0O40t5Jo+5a8INrwpGdYUtyyYG8z/9eef1LQV/e4Zcb6RjNHDlI/WFl+VfWqxd6R9lLErjP7m/mUWOOSl6yCUwFpE+NL9/XAZ6A8TkL1158vGCsTlo/bmPqsvbccS4ISNfmO2uZY9ONfwRVS6m94aYJoPw1UXIuH68vIPiZXmvpnmRaxXB9/O47Uql8xe6BGLpb6Znjr+JL1bczw+Y+wAWDqjbXwcvUEclFm3488UanEmajk8K525vTQPzDtLT1EurOXm8YFXKfcJw73O9o22kbk8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMkpfNefJD9dqWJ4Ipo78ow4fot5LzFKXe4IIK733Fo=;
 b=FtNaX4VtG9VvnBd7P54hfBqEzl7LMoUnQZSuNbligdTdpESxvwLL3yZ9E5H/2OD498BQVYMFouBj6aP4atp0GJqUhBHjAi5shniP33WkfrNCSFHDZr1C4f6p+wyEvw1ds6x54E3vJ22mFTBrXCABmCE8LfStz1J457Zr9WgEFl1FrmonnUwur5h8cEjY3FGTNy2+UqgpvDmzxgYyLVyEoYLCGclqrJMMG54A8PhZXfYWdUtQ/GmMopF7HGkzMeWejgmqx52g/qO9XmjKjqyvOcmoU1EJzT3SgyUUhozlpp5zW+cxbQV3SSGKiXE4vl32UlZ2AcdnAh0RgkNj5VSI3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 12:20:28 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 12:20:28 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 20 Mar 2026 21:19:57 +0900
Subject: [PATCH v2 08/10] gpu: nova-core: convert falcon registers to
 kernel register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-nova-register-v2-8-88fcf103e8d4@nvidia.com>
References: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
In-Reply-To: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TY4P286CA0124.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 2abc31b0-245a-47c6-8ba1-08de867b1214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Q1aS4a/DB00qMoHSQM5+9icscJF5K2dh3c9eDCqkxZsx64x/LFrEun4wuhMLdyicV43YTsDvE9C46DkDUfFpuUPjrg18OEUrxKDkYb1BRv3jlMBJW/9Fu/MAQZL7bi0Mbf4H4K/OnYgXkjGSgMgVb9CR9E1X/fY55MF5GU7wxLYfaZcz9hZ462q3t8W91tNGEGF68U6QLEWNwnNzI+SvQVQz2vOj6fzGMBcDyZ7/yyvfE22cMhczPhGospsxi2Wok1yFyC08VxbtSNo/KkqGRqm6lIF7vFLscqMpiuUU32EiNPt4v3UeaBXkRsiTH1rwMmlGx2Lz+dTZ/gswz82/TiJ4RJU7QUjbV+mzrgZGTGiMrodMcAba0yXgGAAlw9oVBUQ2q2/LpvQu6H5bky6ky99NqsG1Bl1Ux6w03BTnNgQq7IFOxGPcSlEtGUEa5M+Q+B5O3OAx9VyIvbcfFXDMSHCLJJyeWo0LSxhnXEEpYWX2Wx7S4aNn+i4Ou/FkMok2sy5co3QfaWO7rAyoaICcJ6NMk7Ho2k/opkst9QZrGg79E2jM7KYfCXgv/g76r+2sZMNetXPTKVyWdLzxEG29cYNWtxhhoN2QRHkuwPslYXo4ZKcWUOjK9JegsAVzCwoHE4VLjLfVMePc7QLRMdwCY7WOe9MZ/ZST34RDopqGNsxXhdtsQuDW+5eNHp6/FCUrrdycrcrw3ExKivjzjiA2AsTAbf/eFAFcbSbymB7xN1n7OMs6byGbDc5efTu9hm/gsF9/QIbx5uZqXlEf9iG1Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b05HeTlLZzdCcEI2REY3STllMzZZbzRrcTNNczh1V2hZUDFma0haelljWTBr?=
 =?utf-8?B?MXVaMzl4NVZyWkw4RGdKMjJ1dFFhSy80Z2lSZG8zSjhOdFdGR1k5cWFCSFlJ?=
 =?utf-8?B?OWpTOHlhc2NndkMwZDdqcVhTRlR5NWdoYVROZmNidVV3T2pDV1JSYTYvVmxX?=
 =?utf-8?B?cXZ6UFFGT1FDQTRwaVBaeW45QUttZldxbWdtcDE1akdXNGNVVHpEWWRCYWp4?=
 =?utf-8?B?SG4reWNLWXowUmo1SmQvemIxVUI1OFpyeS8yZ1Vac2VQWmdpNkU2azBrQjdm?=
 =?utf-8?B?aGtlQzJkaXk5WlJKQ0p6WG1wOXBpL3o1WGlFRnlYN3hxNi83Sm5lRXZheEU1?=
 =?utf-8?B?eC9mVHZzbXJXMFlzdmJVdVdyOEZ2dkN0bnltZkZ2NU54Z2hKdnFEd3p2V2E5?=
 =?utf-8?B?VWZ6MnJ5QTh3SENOUmtaZHNnaXp1QmJpM1dhVUVPalJ1M1JuYldIVEpwYlht?=
 =?utf-8?B?NlFaODNWUi9TYjQvN09nMUlDQUlNWXduV1JwaHQ5OTViQm5HdGJja1Zkclov?=
 =?utf-8?B?ZFVUOU9NaW9RbDVPd0ZVcnlhQWNtb2pkSUdUVlpsQ2srS3ZWMkx0eVNGSEg2?=
 =?utf-8?B?L1ZtdDNhLzJ3akxPQ2EvNmwvMHkwaFZjN2VBcWhRRS9rVzgxQmJ3ZUV0VElP?=
 =?utf-8?B?ZStsL3RveUMzK01iQmFmVWhhRWYyeFNkN1FVakhJNG4xNlVSQzJRcTBScnNz?=
 =?utf-8?B?UDMwMFNvQ01GVmhSR3JYdmcxYzkrbm5yZW9UYXNpOEh0c0MvZmZxSVZuazB3?=
 =?utf-8?B?a0Qwb2hmUGFVUlNGNy9NMzFXSUFhbVlCeDBpUDRxVjRENTVLUS9WRWhmdjhN?=
 =?utf-8?B?UmpuRCtVUFFRc3NMejR0Qk9peDdXQTB3VjBEYnAxRm0rSElzaHJqckJOZ2Js?=
 =?utf-8?B?c3l3ZldqYkNTUmk3NklaVVBDS1JZbWF3QThOZU5MaVFTRlp2SWFYU29GeXQw?=
 =?utf-8?B?NHhBRFhjdVkrcFFnVlZaMERCY2ZPaWpNZ0NiSVUzdzVvcUNYV0d2VkV5bDda?=
 =?utf-8?B?L20wc25IY2lHY2hCcTd1S0d6WUhzcHNCcEF5RncvQzVDajFOVmdTdlZ2MDV1?=
 =?utf-8?B?SkhtQUVEZVBNWXNxUTBPV294VnkyZnc2emh1eUNXT211YVVLbzFmVE1Xbjd2?=
 =?utf-8?B?aG9FQTZmcG5Pdjl4cXE4TzJmUzdpQkVQdHdRN2NaeGdMYkR4WE11T1FUam81?=
 =?utf-8?B?TmhTMjI0aTE2L29hYmxYRzdOTzZIZ3ZGRXpHNUNCZEs3VUYyQWthV2tRK05q?=
 =?utf-8?B?czVJb0NlZ3ozUHlBMG5kN2lOMlZoRnBNRm1OREZua3VzS2J5dVRKditJamd1?=
 =?utf-8?B?SUo2b0xvWW1oR3hteG41YVVtaERQNFFYSUVNMHBFMktxTFpVd204bHQ0RjVE?=
 =?utf-8?B?cmhVbURvYmYxY1NJYXZEcjRpdG5XU0VaSEZDdHVzVlZsb1lzd0phYkZJVUJh?=
 =?utf-8?B?dWtpSkk0dGdVdkNxODB1aTliNjBuRUJYbGhXZ3lEUEhMTWhmZkpaVTdxQmM4?=
 =?utf-8?B?SE14QUc0dWpxT3pTSmxXVHNMSysxRG1kVGhBaFg0N2hhNmQ0d2FtTGhVOFlH?=
 =?utf-8?B?dXNoZTZQbGp6aGk4WnpvaWg1SlZIUDJha2pucC9YMU5RRGJHektRN0lCak44?=
 =?utf-8?B?dVVlSU5JZEZpMjhWbUNjYi9JYm8yWFMrdkNoeFoyTTFoV1drRmtnb3ZGcE5x?=
 =?utf-8?B?TmhnRktnS29meTVLUFhMNW1MNk1XWlZEMXFTdmxJNis4b3FmMTlKcXlqZ3h6?=
 =?utf-8?B?NUdVVEhTVC9FWERyL3p5QkdZakYzSDFFaXFOYzdvZFFTWWROT0F6bHdhcG9N?=
 =?utf-8?B?MnZkSWcvN0N2SncxT1Z4VzI3cXpPa2xvd3NqNzJyYUcrQ0pKK2huRTJjSmta?=
 =?utf-8?B?cUVOUkoxSndDOVRxUWJ2cTU5VE5iVGZZTDNCQ0hob3FiMnFnS0l2ZHZROVBN?=
 =?utf-8?B?Vm11RGNrOUNIZFZlU2VrMVA2Z2RMT3Y3WDFDYlhyLzRQemJTZGJkWnY5dDJw?=
 =?utf-8?B?UGFOcVR3a0RPSnlWUW9mbllkY1RZcVJZa08yYnVRUlVOSmNWM25pN2JSOXNG?=
 =?utf-8?B?SWpDV1JpaW00dmkxR2VnZEZPYmVLZHFiUXpyV1k3OHlia0RZV0g5dmRXYnN2?=
 =?utf-8?B?eDdtaUd5THdyUVdrQ3NjcTJzTGNqbGhic3RNcytiVXdEdm9MMGllTTZwS3B6?=
 =?utf-8?B?YklqeWExQ1daOG8wT1F5QVVQeTZ4UE5PTlFXWlFlWkxxMnZmaVMxNjMwRjVT?=
 =?utf-8?B?N0JLU3NqTEc1cG1BRG5JaCtBWkhMVi9lUklsVG1sdUlxZ2FhU1VJUWJPQVo1?=
 =?utf-8?B?NmhBVXR2Wm5VV0FYY0hhdWltTzJrYlVORVBJOWVTVzVBSUhuVFozZHI2NDE0?=
 =?utf-8?Q?RkSq6IuiT2FqtA0cZQROH3zwnkzxBE4WbkFPCnoeIaWjz?=
X-MS-Exchange-AntiSpam-MessageData-1: kw9fpttaH7BaNw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abc31b0-245a-47c6-8ba1-08de867b1214
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 12:20:27.9759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ao57GKFmuq/zZoWTUohieL6wlYG90TN21ynGbZ2G5l10fYO20rYm9KdUKWDJt/neyt6N4edr3/K4T566eoCE6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519
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

Convert all PFALCON, PFALCON2 and PRISCV registers to use the kernel's
register macro and update the code accordingly.

Because they rely on the same types to implement relative registers,
they need to be updated in lockstep.

nova-core's local register macro is now unused, so remove it.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs                    | 511 ++++++--------
 drivers/gpu/nova-core/falcon/gsp.rs                |  22 +-
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |  55 +-
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |  12 +-
 drivers/gpu/nova-core/falcon/sec2.rs               |  17 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  19 +-
 drivers/gpu/nova-core/regs.rs                      | 353 +++++-----
 drivers/gpu/nova-core/regs/macros.rs               | 739 ---------------------
 8 files changed, 447 insertions(+), 1281 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 5221e4476f90..8af2bec47721 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -15,8 +15,13 @@
     },
     io::{
         poll::read_poll_timeout,
-        Io, //
+        register::{
+            RegisterBase,
+            WithBase, //
+        },
+        Io,
     },
+    num::Bounded,
     prelude::*,
     sync::aref::ARef,
     time::Delta,
@@ -33,7 +38,6 @@
         IntoSafeCast, //
     },
     regs,
-    regs::macros::RegisterBase, //
 };
 
 pub(crate) mod gsp;
@@ -43,22 +47,10 @@
 /// Alignment (in bytes) of falcon memory blocks.
 pub(crate) const MEM_BLOCK_ALIGNMENT: usize = 256;
 
-// TODO[FPRI]: Replace with `ToPrimitive`.
-macro_rules! impl_from_enum_to_u8 {
-    ($enum_type:ty) => {
-        impl From<$enum_type> for u8 {
-            fn from(value: $enum_type) -> Self {
-                value as u8
-            }
-        }
-    };
-}
-
 /// Creates an enum type associated to a `Bounded`, with a `From` conversion to the associated
 /// `Bounded` and either a `TryFrom` or `From` converting from the associated `Bounded`.
 // TODO[FPRI]: This is a temporary solution to be replaced with the corresponding derive macros
 // once they land.
-#[expect(unused)]
 macro_rules! bounded_enum {
     (
         $(#[doc = $enum_doc:expr])*
@@ -136,192 +128,80 @@ fn from(value: Bounded<$width, $length>) -> Self {
     }
 }
 
-/// Revision number of a falcon core, used in the [`crate::regs::NV_PFALCON_FALCON_HWCFG1`]
-/// register.
-#[repr(u8)]
-#[derive(Debug, Default, Copy, Clone, PartialEq, Eq, PartialOrd, Ord)]
-pub(crate) enum FalconCoreRev {
-    #[default]
-    Rev1 = 1,
-    Rev2 = 2,
-    Rev3 = 3,
-    Rev4 = 4,
-    Rev5 = 5,
-    Rev6 = 6,
-    Rev7 = 7,
-}
-impl_from_enum_to_u8!(FalconCoreRev);
-
-// TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconCoreRev {
-    type Error = Error;
-
-    fn try_from(value: u8) -> Result<Self> {
-        use FalconCoreRev::*;
-
-        let rev = match value {
-            1 => Rev1,
-            2 => Rev2,
-            3 => Rev3,
-            4 => Rev4,
-            5 => Rev5,
-            6 => Rev6,
-            7 => Rev7,
-            _ => return Err(EINVAL),
-        };
-
-        Ok(rev)
+bounded_enum! {
+    /// Revision number of a falcon core, used in the [`crate::regs::NV_PFALCON_FALCON_HWCFG1`]
+    /// register.
+    enum FalconCoreRev with TryFrom<Bounded<u32, 4>> {
+        Rev1 = 1,
+        Rev2 = 2,
+        Rev3 = 3,
+        Rev4 = 4,
+        Rev5 = 5,
+        Rev6 = 6,
+        Rev7 = 7,
     }
 }
 
-/// Revision subversion number of a falcon core, used in the
-/// [`crate::regs::NV_PFALCON_FALCON_HWCFG1`] register.
-#[repr(u8)]
-#[derive(Debug, Default, Copy, Clone, PartialEq, Eq, PartialOrd, Ord)]
-pub(crate) enum FalconCoreRevSubversion {
-    #[default]
-    Subversion0 = 0,
-    Subversion1 = 1,
-    Subversion2 = 2,
-    Subversion3 = 3,
-}
-impl_from_enum_to_u8!(FalconCoreRevSubversion);
-
-// TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconCoreRevSubversion {
-    type Error = Error;
-
-    fn try_from(value: u8) -> Result<Self> {
-        use FalconCoreRevSubversion::*;
-
-        let sub_version = match value & 0b11 {
-            0 => Subversion0,
-            1 => Subversion1,
-            2 => Subversion2,
-            3 => Subversion3,
-            _ => return Err(EINVAL),
-        };
-
-        Ok(sub_version)
+bounded_enum! {
+    /// Revision subversion number of a falcon core, used in the
+    /// [`crate::regs::NV_PFALCON_FALCON_HWCFG1`] register.
+    enum FalconCoreRevSubversion with From<Bounded<u32, 2>> {
+        Subversion0 = 0,
+        Subversion1 = 1,
+        Subversion2 = 2,
+        Subversion3 = 3,
     }
 }
 
-/// Security model of a falcon core, used in the [`crate::regs::NV_PFALCON_FALCON_HWCFG1`]
-/// register.
-#[repr(u8)]
-#[derive(Debug, Default, Copy, Clone)]
-/// Security mode of the Falcon microprocessor.
-///
-/// See `falcon.rst` for more details.
-pub(crate) enum FalconSecurityModel {
-    /// Non-Secure: runs unsigned code without privileges.
-    #[default]
-    None = 0,
-    /// Light-Secured (LS): Runs signed code with some privileges.
-    /// Entry into this mode is only possible from 'Heavy-secure' mode, which verifies the code's
-    /// signature.
+bounded_enum! {
+    /// Security mode of the Falcon microprocessor.
     ///
-    /// Also known as Low-Secure, Privilege Level 2 or PL2.
-    Light = 2,
-    /// Heavy-Secured (HS): Runs signed code with full privileges.
-    /// The code's signature is verified by the Falcon Boot ROM (BROM).
-    ///
-    /// Also known as High-Secure, Privilege Level 3 or PL3.
-    Heavy = 3,
-}
-impl_from_enum_to_u8!(FalconSecurityModel);
-
-// TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconSecurityModel {
-    type Error = Error;
-
-    fn try_from(value: u8) -> Result<Self> {
-        use FalconSecurityModel::*;
-
-        let sec_model = match value {
-            0 => None,
-            2 => Light,
-            3 => Heavy,
-            _ => return Err(EINVAL),
-        };
-
-        Ok(sec_model)
+    /// See `falcon.rst` for more details.
+    enum FalconSecurityModel with TryFrom<Bounded<u32, 2>> {
+        /// Non-Secure: runs unsigned code without privileges.
+        None = 0,
+        /// Light-Secured (LS): Runs signed code with some privileges.
+        /// Entry into this mode is only possible from 'Heavy-secure' mode, which verifies the
+        /// code's signature.
+        ///
+        /// Also known as Low-Secure, Privilege Level 2 or PL2.
+        Light = 2,
+        /// Heavy-Secured (HS): Runs signed code with full privileges.
+        /// The code's signature is verified by the Falcon Boot ROM (BROM).
+        ///
+        /// Also known as High-Secure, Privilege Level 3 or PL3.
+        Heavy = 3,
     }
 }
 
-/// Signing algorithm for a given firmware, used in the [`crate::regs::NV_PFALCON2_FALCON_MOD_SEL`]
-/// register. It is passed to the Falcon Boot ROM (BROM) as a parameter.
-#[repr(u8)]
-#[derive(Debug, Default, Copy, Clone, PartialEq, Eq)]
-pub(crate) enum FalconModSelAlgo {
-    /// AES.
-    #[expect(dead_code)]
-    Aes = 0,
-    /// RSA3K.
-    #[default]
-    Rsa3k = 1,
-}
-impl_from_enum_to_u8!(FalconModSelAlgo);
-
-// TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconModSelAlgo {
-    type Error = Error;
-
-    fn try_from(value: u8) -> Result<Self> {
-        match value {
-            1 => Ok(FalconModSelAlgo::Rsa3k),
-            _ => Err(EINVAL),
-        }
+bounded_enum! {
+    /// Signing algorithm for a given firmware, used in the
+    /// [`crate::regs::NV_PFALCON2_FALCON_MOD_SEL`] register. It is passed to the Falcon Boot ROM
+    /// (BROM) as a parameter.
+    enum FalconModSelAlgo with TryFrom<Bounded<u32, 8>> {
+        /// AES.
+        Aes = 0,
+        /// RSA3K.
+        Rsa3k = 1,
     }
 }
 
-/// Valid values for the `size` field of the [`crate::regs::NV_PFALCON_FALCON_DMATRFCMD`] register.
-#[repr(u8)]
-#[derive(Debug, Default, Copy, Clone, PartialEq, Eq)]
-pub(crate) enum DmaTrfCmdSize {
-    /// 256 bytes transfer.
-    #[default]
-    Size256B = 0x6,
-}
-impl_from_enum_to_u8!(DmaTrfCmdSize);
-
-// TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for DmaTrfCmdSize {
-    type Error = Error;
-
-    fn try_from(value: u8) -> Result<Self> {
-        match value {
-            0x6 => Ok(Self::Size256B),
-            _ => Err(EINVAL),
-        }
+bounded_enum! {
+    /// Valid values for the `size` field of the [`crate::regs::NV_PFALCON_FALCON_DMATRFCMD`]
+    /// register.
+    enum DmaTrfCmdSize with TryFrom<Bounded<u32, 3>> {
+        /// 256 bytes transfer.
+        Size256B = 0x6,
     }
 }
 
-/// Currently active core on a dual falcon/riscv (Peregrine) controller.
-#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
-pub(crate) enum PeregrineCoreSelect {
-    /// Falcon core is active.
-    #[default]
-    Falcon = 0,
-    /// RISC-V core is active.
-    Riscv = 1,
-}
-
-impl From<bool> for PeregrineCoreSelect {
-    fn from(value: bool) -> Self {
-        match value {
-            false => PeregrineCoreSelect::Falcon,
-            true => PeregrineCoreSelect::Riscv,
-        }
-    }
-}
-
-impl From<PeregrineCoreSelect> for bool {
-    fn from(value: PeregrineCoreSelect) -> Self {
-        match value {
-            PeregrineCoreSelect::Falcon => false,
-            PeregrineCoreSelect::Riscv => true,
-        }
+bounded_enum! {
+    /// Currently active core on a dual falcon/riscv (Peregrine) controller.
+    enum PeregrineCoreSelect with From<Bounded<u32, 1>> {
+        /// Falcon core is active.
+        Falcon = 0,
+        /// RISC-V core is active.
+        Riscv = 1,
     }
 }
 
@@ -337,64 +217,27 @@ pub(crate) enum FalconMem {
     Dmem,
 }
 
-/// Defines the Framebuffer Interface (FBIF) aperture type.
-/// This determines the memory type for external memory access during a DMA transfer, which is
-/// performed by the Falcon's Framebuffer DMA (FBDMA) engine. See falcon.rst for more details.
-#[derive(Debug, Clone, Default)]
-pub(crate) enum FalconFbifTarget {
-    /// VRAM.
-    #[default]
-    /// Local Framebuffer (GPU's VRAM memory).
-    LocalFb = 0,
-    /// Coherent system memory (System DRAM).
-    CoherentSysmem = 1,
-    /// Non-coherent system memory (System DRAM).
-    NoncoherentSysmem = 2,
-}
-impl_from_enum_to_u8!(FalconFbifTarget);
-
-// TODO[FPRI]: replace with `FromPrimitive`.
-impl TryFrom<u8> for FalconFbifTarget {
-    type Error = Error;
-
-    fn try_from(value: u8) -> Result<Self> {
-        let res = match value {
-            0 => Self::LocalFb,
-            1 => Self::CoherentSysmem,
-            2 => Self::NoncoherentSysmem,
-            _ => return Err(EINVAL),
-        };
-
-        Ok(res)
+bounded_enum! {
+    /// Defines the Framebuffer Interface (FBIF) aperture type.
+    /// This determines the memory type for external memory access during a DMA transfer, which is
+    /// performed by the Falcon's Framebuffer DMA (FBDMA) engine. See falcon.rst for more details.
+    enum FalconFbifTarget with TryFrom<Bounded<u32, 2>> {
+        /// Local Framebuffer (GPU's VRAM memory).
+        LocalFb = 0,
+        /// Coherent system memory (System DRAM).
+        CoherentSysmem = 1,
+        /// Non-coherent system memory (System DRAM).
+        NoncoherentSysmem = 2,
     }
 }
 
-/// Type of memory addresses to use.
-#[derive(Debug, Clone, Default)]
-pub(crate) enum FalconFbifMemType {
-    /// Virtual memory addresses.
-    #[default]
-    Virtual = 0,
-    /// Physical memory addresses.
-    Physical = 1,
-}
-
-/// Conversion from a single-bit register field.
-impl From<bool> for FalconFbifMemType {
-    fn from(value: bool) -> Self {
-        match value {
-            false => Self::Virtual,
-            true => Self::Physical,
-        }
-    }
-}
-
-impl From<FalconFbifMemType> for bool {
-    fn from(value: FalconFbifMemType) -> Self {
-        match value {
-            FalconFbifMemType::Virtual => false,
-            FalconFbifMemType::Physical => true,
-        }
+bounded_enum! {
+    /// Type of memory addresses to use.
+    enum FalconFbifMemType with From<Bounded<u32, 1>> {
+        /// Virtual memory addresses.
+        Virtual = 0,
+        /// Physical memory addresses.
+        Physical = 1,
     }
 }
 
@@ -406,13 +249,10 @@ fn from(value: FalconFbifMemType) -> Self {
 
 /// Trait defining the parameters of a given Falcon engine.
 ///
-/// Each engine provides one base for `PFALCON` and `PFALCON2` registers. The `ID` constant is used
-/// to identify a given Falcon instance with register I/O methods.
+/// Each engine provides one base for `PFALCON` and `PFALCON2` registers.
 pub(crate) trait FalconEngine:
     Send + Sync + RegisterBase<PFalconBase> + RegisterBase<PFalcon2Base> + Sized
 {
-    /// Singleton of the engine, used to identify it with register I/O methods.
-    const ID: Self;
 }
 
 /// Represents a portion of the firmware to be loaded into a particular memory (e.g. IMEM or DMEM)
@@ -606,8 +446,14 @@ pub(crate) fn new(dev: &device::Device, chipset: Chipset) -> Result<Self> {
 
     /// Resets DMA-related registers.
     pub(crate) fn dma_reset(&self, bar: &Bar0) {
-        regs::NV_PFALCON_FBIF_CTL::update(bar, &E::ID, |v| v.set_allow_phys_no_ctx(true));
-        regs::NV_PFALCON_FALCON_DMACTL::default().write(bar, &E::ID);
+        bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
+            v.with_allow_phys_no_ctx(true)
+        });
+
+        bar.write(
+            WithBase::of::<E>(),
+            regs::NV_PFALCON_FALCON_DMACTL::zeroed(),
+        );
     }
 
     /// Reset the controller, select the falcon core, and wait for memory scrubbing to complete.
@@ -616,9 +462,10 @@ pub(crate) fn reset(&self, bar: &Bar0) -> Result {
         self.hal.select_core(self, bar)?;
         self.hal.reset_wait_mem_scrubbing(bar)?;
 
-        regs::NV_PFALCON_FALCON_RM::default()
-            .set_value(bar.read(regs::NV_PMC_BOOT_0).into())
-            .write(bar, &E::ID);
+        bar.write(
+            WithBase::of::<E>(),
+            regs::NV_PFALCON_FALCON_RM::from(bar.read(regs::NV_PMC_BOOT_0).into_raw()),
+        );
 
         Ok(())
     }
@@ -636,25 +483,27 @@ fn pio_wr_imem_slice(&self, bar: &Bar0, load_offsets: FalconPioImemLoadTarget<'_
             return Err(EINVAL);
         }
 
-        regs::NV_PFALCON_FALCON_IMEMC::default()
-            .set_secure(load_offsets.secure)
-            .set_aincw(true)
-            .set_offs(load_offsets.dst_start)
-            .write(bar, &E::ID, Self::PIO_PORT);
+        bar.write(
+            WithBase::of::<E>().at(Self::PIO_PORT),
+            regs::NV_PFALCON_FALCON_IMEMC::zeroed()
+                .with_secure(load_offsets.secure)
+                .with_aincw(true)
+                .with_offs(load_offsets.dst_start),
+        );
 
         for (n, block) in load_offsets.data.chunks(MEM_BLOCK_ALIGNMENT).enumerate() {
             let n = u16::try_from(n)?;
             let tag: u16 = load_offsets.start_tag.checked_add(n).ok_or(ERANGE)?;
-            regs::NV_PFALCON_FALCON_IMEMT::default().set_tag(tag).write(
-                bar,
-                &E::ID,
-                Self::PIO_PORT,
+            bar.write(
+                WithBase::of::<E>().at(Self::PIO_PORT),
+                regs::NV_PFALCON_FALCON_IMEMT::zeroed().with_tag(tag),
             );
             for word in block.chunks_exact(4) {
                 let w = [word[0], word[1], word[2], word[3]];
-                regs::NV_PFALCON_FALCON_IMEMD::default()
-                    .set_data(u32::from_le_bytes(w))
-                    .write(bar, &E::ID, Self::PIO_PORT);
+                bar.write(
+                    WithBase::of::<E>().at(Self::PIO_PORT),
+                    regs::NV_PFALCON_FALCON_IMEMD::zeroed().with_data(u32::from_le_bytes(w)),
+                );
             }
         }
 
@@ -671,16 +520,19 @@ fn pio_wr_dmem_slice(&self, bar: &Bar0, load_offsets: FalconPioDmemLoadTarget<'_
             return Err(EINVAL);
         }
 
-        regs::NV_PFALCON_FALCON_DMEMC::default()
-            .set_aincw(true)
-            .set_offs(load_offsets.dst_start)
-            .write(bar, &E::ID, Self::PIO_PORT);
+        bar.write(
+            WithBase::of::<E>().at(Self::PIO_PORT),
+            regs::NV_PFALCON_FALCON_DMEMC::zeroed()
+                .with_aincw(true)
+                .with_offs(load_offsets.dst_start),
+        );
 
         for word in load_offsets.data.chunks_exact(4) {
             let w = [word[0], word[1], word[2], word[3]];
-            regs::NV_PFALCON_FALCON_DMEMD::default()
-                .set_data(u32::from_le_bytes(w))
-                .write(bar, &E::ID, Self::PIO_PORT);
+            bar.write(
+                WithBase::of::<E>().at(Self::PIO_PORT),
+                regs::NV_PFALCON_FALCON_DMEMD::zeroed().with_data(u32::from_le_bytes(w)),
+            );
         }
 
         Ok(())
@@ -692,11 +544,14 @@ pub(crate) fn pio_load<F: FalconFirmware<Target = E> + FalconPioLoadable>(
         bar: &Bar0,
         fw: &F,
     ) -> Result {
-        regs::NV_PFALCON_FBIF_CTL::read(bar, &E::ID)
-            .set_allow_phys_no_ctx(true)
-            .write(bar, &E::ID);
+        bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
+            v.with_allow_phys_no_ctx(true)
+        });
 
-        regs::NV_PFALCON_FALCON_DMACTL::default().write(bar, &E::ID);
+        bar.write(
+            WithBase::of::<E>(),
+            regs::NV_PFALCON_FALCON_DMACTL::zeroed(),
+        );
 
         if let Some(imem_ns) = fw.imem_ns_load_params() {
             self.pio_wr_imem_slice(bar, imem_ns)?;
@@ -708,9 +563,10 @@ pub(crate) fn pio_load<F: FalconFirmware<Target = E> + FalconPioLoadable>(
 
         self.hal.program_brom(self, bar, &fw.brom_params())?;
 
-        regs::NV_PFALCON_FALCON_BOOTVEC::default()
-            .set_value(fw.boot_addr())
-            .write(bar, &E::ID);
+        bar.write(
+            WithBase::of::<E>(),
+            regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()),
+        );
 
         Ok(())
     }
@@ -779,36 +635,42 @@ fn dma_wr(
 
         // Set up the base source DMA address.
 
-        regs::NV_PFALCON_FALCON_DMATRFBASE::default()
-            // CAST: `as u32` is used on purpose since we do want to strip the upper bits, which
-            // will be written to `NV_PFALCON_FALCON_DMATRFBASE1`.
-            .set_base((dma_start >> 8) as u32)
-            .write(bar, &E::ID);
-        regs::NV_PFALCON_FALCON_DMATRFBASE1::default()
-            // CAST: `as u16` is used on purpose since the remaining bits are guaranteed to fit
-            // within a `u16`.
-            .set_base((dma_start >> 40) as u16)
-            .write(bar, &E::ID);
+        bar.write(
+            WithBase::of::<E>(),
+            regs::NV_PFALCON_FALCON_DMATRFBASE::zeroed().with_base(
+                // CAST: `as u32` is used on purpose since we do want to strip the upper bits,
+                // which will be written to `NV_PFALCON_FALCON_DMATRFBASE1`.
+                (dma_start >> 8) as u32,
+            ),
+        );
+        bar.write(
+            WithBase::of::<E>(),
+            regs::NV_PFALCON_FALCON_DMATRFBASE1::zeroed().try_with_base(dma_start >> 40)?,
+        );
 
-        let cmd = regs::NV_PFALCON_FALCON_DMATRFCMD::default()
-            .set_size(DmaTrfCmdSize::Size256B)
+        let cmd = regs::NV_PFALCON_FALCON_DMATRFCMD::zeroed()
+            .with_size(DmaTrfCmdSize::Size256B)
             .with_falcon_mem(target_mem);
 
         for pos in (0..num_transfers).map(|i| i * DMA_LEN) {
             // Perform a transfer of size `DMA_LEN`.
-            regs::NV_PFALCON_FALCON_DMATRFMOFFS::default()
-                .set_offs(load_offsets.dst_start + pos)
-                .write(bar, &E::ID);
-            regs::NV_PFALCON_FALCON_DMATRFFBOFFS::default()
-                .set_offs(src_start + pos)
-                .write(bar, &E::ID);
-            cmd.write(bar, &E::ID);
+            bar.write(
+                WithBase::of::<E>(),
+                regs::NV_PFALCON_FALCON_DMATRFMOFFS::zeroed()
+                    .try_with_offs(load_offsets.dst_start + pos)?,
+            );
+            bar.write(
+                WithBase::of::<E>(),
+                regs::NV_PFALCON_FALCON_DMATRFFBOFFS::zeroed().with_offs(src_start + pos),
+            );
+
+            bar.write(WithBase::of::<E>(), cmd);
 
             // Wait for the transfer to complete.
             // TIMEOUT: arbitrarily large value, no DMA transfer to the falcon's small memories
             // should ever take that long.
             read_poll_timeout(
-                || Ok(regs::NV_PFALCON_FALCON_DMATRFCMD::read(bar, &E::ID)),
+                || Ok(bar.read(regs::NV_PFALCON_FALCON_DMATRFCMD::of::<E>())),
                 |r| r.idle(),
                 Delta::ZERO,
                 Delta::from_secs(2),
@@ -829,9 +691,9 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(
         let dma_obj = DmaObject::from_data(dev, fw.as_slice())?;
 
         self.dma_reset(bar);
-        regs::NV_PFALCON_FBIF_TRANSCFG::update(bar, &E::ID, 0, |v| {
-            v.set_target(FalconFbifTarget::CoherentSysmem)
-                .set_mem_type(FalconFbifMemType::Physical)
+        bar.update(regs::NV_PFALCON_FBIF_TRANSCFG::of::<E>().at(0), |v| {
+            v.with_target(FalconFbifTarget::CoherentSysmem)
+                .with_mem_type(FalconFbifMemType::Physical)
         });
 
         self.dma_wr(
@@ -845,9 +707,10 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(
         self.hal.program_brom(self, bar, &fw.brom_params())?;
 
         // Set `BootVec` to start of non-secure code.
-        regs::NV_PFALCON_FALCON_BOOTVEC::default()
-            .set_value(fw.boot_addr())
-            .write(bar, &E::ID);
+        bar.write(
+            WithBase::of::<E>(),
+            regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_addr()),
+        );
 
         Ok(())
     }
@@ -856,7 +719,7 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(
     pub(crate) fn wait_till_halted(&self, bar: &Bar0) -> Result<()> {
         // TIMEOUT: arbitrarily large value, firmwares should complete in less than 2 seconds.
         read_poll_timeout(
-            || Ok(regs::NV_PFALCON_FALCON_CPUCTL::read(bar, &E::ID)),
+            || Ok(bar.read(regs::NV_PFALCON_FALCON_CPUCTL::of::<E>())),
             |r| r.halted(),
             Delta::ZERO,
             Delta::from_secs(2),
@@ -867,13 +730,18 @@ pub(crate) fn wait_till_halted(&self, bar: &Bar0) -> Result<()> {
 
     /// Start the falcon CPU.
     pub(crate) fn start(&self, bar: &Bar0) -> Result<()> {
-        match regs::NV_PFALCON_FALCON_CPUCTL::read(bar, &E::ID).alias_en() {
-            true => regs::NV_PFALCON_FALCON_CPUCTL_ALIAS::default()
-                .set_startcpu(true)
-                .write(bar, &E::ID),
-            false => regs::NV_PFALCON_FALCON_CPUCTL::default()
-                .set_startcpu(true)
-                .write(bar, &E::ID),
+        match bar
+            .read(regs::NV_PFALCON_FALCON_CPUCTL::of::<E>())
+            .alias_en()
+        {
+            true => bar.write(
+                WithBase::of::<E>(),
+                regs::NV_PFALCON_FALCON_CPUCTL_ALIAS::zeroed().with_startcpu(true),
+            ),
+            false => bar.write(
+                WithBase::of::<E>(),
+                regs::NV_PFALCON_FALCON_CPUCTL::zeroed().with_startcpu(true),
+            ),
         }
 
         Ok(())
@@ -882,26 +750,30 @@ pub(crate) fn start(&self, bar: &Bar0) -> Result<()> {
     /// Writes values to the mailbox registers if provided.
     pub(crate) fn write_mailboxes(&self, bar: &Bar0, mbox0: Option<u32>, mbox1: Option<u32>) {
         if let Some(mbox0) = mbox0 {
-            regs::NV_PFALCON_FALCON_MAILBOX0::default()
-                .set_value(mbox0)
-                .write(bar, &E::ID);
+            bar.write(
+                WithBase::of::<E>(),
+                regs::NV_PFALCON_FALCON_MAILBOX0::zeroed().with_value(mbox0),
+            );
         }
 
         if let Some(mbox1) = mbox1 {
-            regs::NV_PFALCON_FALCON_MAILBOX1::default()
-                .set_value(mbox1)
-                .write(bar, &E::ID);
+            bar.write(
+                WithBase::of::<E>(),
+                regs::NV_PFALCON_FALCON_MAILBOX1::zeroed().with_value(mbox1),
+            );
         }
     }
 
     /// Reads the value from `mbox0` register.
     pub(crate) fn read_mailbox0(&self, bar: &Bar0) -> u32 {
-        regs::NV_PFALCON_FALCON_MAILBOX0::read(bar, &E::ID).value()
+        bar.read(regs::NV_PFALCON_FALCON_MAILBOX0::of::<E>())
+            .value()
     }
 
     /// Reads the value from `mbox1` register.
     pub(crate) fn read_mailbox1(&self, bar: &Bar0) -> u32 {
-        regs::NV_PFALCON_FALCON_MAILBOX1::read(bar, &E::ID).value()
+        bar.read(regs::NV_PFALCON_FALCON_MAILBOX1::of::<E>())
+            .value()
     }
 
     /// Reads values from both mailbox registers.
@@ -966,8 +838,9 @@ pub(crate) fn load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(
 
     /// Write the application version to the OS register.
     pub(crate) fn write_os_version(&self, bar: &Bar0, app_version: u32) {
-        regs::NV_PFALCON_FALCON_OS::default()
-            .set_value(app_version)
-            .write(bar, &E::ID);
+        bar.write(
+            WithBase::of::<E>(),
+            regs::NV_PFALCON_FALCON_OS::zeroed().with_value(app_version),
+        );
     }
 }
diff --git a/drivers/gpu/nova-core/falcon/gsp.rs b/drivers/gpu/nova-core/falcon/gsp.rs
index e52f57abc223..df6d5a382c7a 100644
--- a/drivers/gpu/nova-core/falcon/gsp.rs
+++ b/drivers/gpu/nova-core/falcon/gsp.rs
@@ -3,7 +3,11 @@
 use kernel::{
     io::{
         poll::read_poll_timeout,
-        Io, //
+        register::{
+            RegisterBase,
+            WithBase, //
+        },
+        Io,
     },
     prelude::*,
     time::Delta, //
@@ -17,10 +21,7 @@
         PFalcon2Base,
         PFalconBase, //
     },
-    regs::{
-        self,
-        macros::RegisterBase, //
-    },
+    regs,
 };
 
 /// Type specifying the `Gsp` falcon engine. Cannot be instantiated.
@@ -34,17 +35,16 @@ impl RegisterBase<PFalcon2Base> for Gsp {
     const BASE: usize = 0x00111000;
 }
 
-impl FalconEngine for Gsp {
-    const ID: Self = Gsp(());
-}
+impl FalconEngine for Gsp {}
 
 impl Falcon<Gsp> {
     /// Clears the SWGEN0 bit in the Falcon's IRQ status clear register to
     /// allow GSP to signal CPU for processing new messages in message queue.
     pub(crate) fn clear_swgen0_intr(&self, bar: &Bar0) {
-        regs::NV_PFALCON_FALCON_IRQSCLR::default()
-            .set_swgen0(true)
-            .write(bar, &Gsp::ID);
+        bar.write(
+            WithBase::of::<Gsp>(),
+            regs::NV_PFALCON_FALCON_IRQSCLR::zeroed().with_swgen0(true),
+        );
     }
 
     /// Checks if GSP reload/resume has completed during the boot process.
diff --git a/drivers/gpu/nova-core/falcon/hal/ga102.rs b/drivers/gpu/nova-core/falcon/hal/ga102.rs
index cbdf36bad633..8368a61ddeef 100644
--- a/drivers/gpu/nova-core/falcon/hal/ga102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/ga102.rs
@@ -6,7 +6,10 @@
     device,
     io::{
         poll::read_poll_timeout,
-        register::Array,
+        register::{
+            Array,
+            WithBase, //
+        },
         Io, //
     },
     prelude::*,
@@ -29,15 +32,16 @@
 use super::FalconHal;
 
 fn select_core_ga102<E: FalconEngine>(bar: &Bar0) -> Result {
-    let bcr_ctrl = regs::NV_PRISCV_RISCV_BCR_CTRL::read(bar, &E::ID);
+    let bcr_ctrl = bar.read(regs::NV_PRISCV_RISCV_BCR_CTRL::of::<E>());
     if bcr_ctrl.core_select() != PeregrineCoreSelect::Falcon {
-        regs::NV_PRISCV_RISCV_BCR_CTRL::default()
-            .set_core_select(PeregrineCoreSelect::Falcon)
-            .write(bar, &E::ID);
+        bar.write(
+            WithBase::of::<E>(),
+            regs::NV_PRISCV_RISCV_BCR_CTRL::zeroed().with_core_select(PeregrineCoreSelect::Falcon),
+        );
 
         // TIMEOUT: falcon core should take less than 10ms to report being enabled.
         read_poll_timeout(
-            || Ok(regs::NV_PRISCV_RISCV_BCR_CTRL::read(bar, &E::ID)),
+            || Ok(bar.read(regs::NV_PRISCV_RISCV_BCR_CTRL::of::<E>())),
             |r| r.valid(),
             Delta::ZERO,
             Delta::from_millis(10),
@@ -83,18 +87,23 @@ fn signature_reg_fuse_version_ga102(
 }
 
 fn program_brom_ga102<E: FalconEngine>(bar: &Bar0, params: &FalconBromParams) -> Result {
-    regs::NV_PFALCON2_FALCON_BROM_PARAADDR::default()
-        .set_value(params.pkc_data_offset)
-        .write(bar, &E::ID, 0);
-    regs::NV_PFALCON2_FALCON_BROM_ENGIDMASK::default()
-        .set_value(u32::from(params.engine_id_mask))
-        .write(bar, &E::ID);
-    regs::NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID::default()
-        .set_ucode_id(params.ucode_id)
-        .write(bar, &E::ID);
-    regs::NV_PFALCON2_FALCON_MOD_SEL::default()
-        .set_algo(FalconModSelAlgo::Rsa3k)
-        .write(bar, &E::ID);
+    bar.write(
+        WithBase::of::<E>().at(0),
+        regs::NV_PFALCON2_FALCON_BROM_PARAADDR::zeroed().with_value(params.pkc_data_offset),
+    );
+    bar.write(
+        WithBase::of::<E>(),
+        regs::NV_PFALCON2_FALCON_BROM_ENGIDMASK::zeroed()
+            .with_value(u32::from(params.engine_id_mask)),
+    );
+    bar.write(
+        WithBase::of::<E>(),
+        regs::NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID::zeroed().with_ucode_id(params.ucode_id),
+    );
+    bar.write(
+        WithBase::of::<E>(),
+        regs::NV_PFALCON2_FALCON_MOD_SEL::zeroed().with_algo(FalconModSelAlgo::Rsa3k),
+    );
 
     Ok(())
 }
@@ -127,14 +136,14 @@ fn program_brom(&self, _falcon: &Falcon<E>, bar: &Bar0, params: &FalconBromParam
     }
 
     fn is_riscv_active(&self, bar: &Bar0) -> bool {
-        let cpuctl = regs::NV_PRISCV_RISCV_CPUCTL::read(bar, &E::ID);
-        cpuctl.active_stat()
+        bar.read(regs::NV_PRISCV_RISCV_CPUCTL::of::<E>())
+            .active_stat()
     }
 
     fn reset_wait_mem_scrubbing(&self, bar: &Bar0) -> Result {
         // TIMEOUT: memory scrubbing should complete in less than 20ms.
         read_poll_timeout(
-            || Ok(regs::NV_PFALCON_FALCON_HWCFG2::read(bar, &E::ID)),
+            || Ok(bar.read(regs::NV_PFALCON_FALCON_HWCFG2::of::<E>())),
             |r| r.mem_scrubbing_done(),
             Delta::ZERO,
             Delta::from_millis(20),
@@ -143,12 +152,12 @@ fn reset_wait_mem_scrubbing(&self, bar: &Bar0) -> Result {
     }
 
     fn reset_eng(&self, bar: &Bar0) -> Result {
-        let _ = regs::NV_PFALCON_FALCON_HWCFG2::read(bar, &E::ID);
+        let _ = bar.read(regs::NV_PFALCON_FALCON_HWCFG2::of::<E>());
 
         // According to OpenRM's `kflcnPreResetWait_GA102` documentation, HW sometimes does not set
         // RESET_READY so a non-failing timeout is used.
         let _ = read_poll_timeout(
-            || Ok(regs::NV_PFALCON_FALCON_HWCFG2::read(bar, &E::ID)),
+            || Ok(bar.read(regs::NV_PFALCON_FALCON_HWCFG2::of::<E>())),
             |r| r.reset_ready(),
             Delta::ZERO,
             Delta::from_micros(150),
diff --git a/drivers/gpu/nova-core/falcon/hal/tu102.rs b/drivers/gpu/nova-core/falcon/hal/tu102.rs
index 7de6f24cc0a0..c7a90266cb44 100644
--- a/drivers/gpu/nova-core/falcon/hal/tu102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/tu102.rs
@@ -3,7 +3,11 @@
 use core::marker::PhantomData;
 
 use kernel::{
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        register::WithBase,
+        Io, //
+    },
     prelude::*,
     time::Delta, //
 };
@@ -49,14 +53,14 @@ fn program_brom(&self, _falcon: &Falcon<E>, _bar: &Bar0, _params: &FalconBromPar
     }
 
     fn is_riscv_active(&self, bar: &Bar0) -> bool {
-        let cpuctl = regs::NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS::read(bar, &E::ID);
-        cpuctl.active_stat()
+        bar.read(regs::NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS::of::<E>())
+            .active_stat()
     }
 
     fn reset_wait_mem_scrubbing(&self, bar: &Bar0) -> Result {
         // TIMEOUT: memory scrubbing should complete in less than 10ms.
         read_poll_timeout(
-            || Ok(regs::NV_PFALCON_FALCON_DMACTL::read(bar, &E::ID)),
+            || Ok(bar.read(regs::NV_PFALCON_FALCON_DMACTL::of::<E>())),
             |r| r.mem_scrubbing_done(),
             Delta::ZERO,
             Delta::from_millis(10),
diff --git a/drivers/gpu/nova-core/falcon/sec2.rs b/drivers/gpu/nova-core/falcon/sec2.rs
index b57d362e576a..91ec7d49c1f5 100644
--- a/drivers/gpu/nova-core/falcon/sec2.rs
+++ b/drivers/gpu/nova-core/falcon/sec2.rs
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use crate::{
-    falcon::{
-        FalconEngine,
-        PFalcon2Base,
-        PFalconBase, //
-    },
-    regs::macros::RegisterBase,
+use kernel::io::register::RegisterBase;
+
+use crate::falcon::{
+    FalconEngine,
+    PFalcon2Base,
+    PFalconBase, //
 };
 
 /// Type specifying the `Sec2` falcon engine. Cannot be instantiated.
@@ -20,6 +19,4 @@ impl RegisterBase<PFalcon2Base> for Sec2 {
     const BASE: usize = 0x00841000;
 }
 
-impl FalconEngine for Sec2 {
-    const ID: Self = Sec2(());
-}
+impl FalconEngine for Sec2 {}
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index 342dba59b2f9..3b12d90d9412 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -12,6 +12,10 @@
         self,
         Device, //
     },
+    io::{
+        register::WithBase, //
+        Io,
+    },
     prelude::*,
     ptr::{
         Alignable,
@@ -33,7 +37,6 @@
         Falcon,
         FalconBromParams,
         FalconDmaLoadable,
-        FalconEngine,
         FalconFbifMemType,
         FalconFbifTarget,
         FalconFirmware,
@@ -288,15 +291,15 @@ pub(crate) fn run(
             .inspect_err(|e| dev_err!(dev, "Failed to load FWSEC firmware: {:?}\n", e))?;
 
         // Configure DMA index for the bootloader to fetch the FWSEC firmware from system memory.
-        regs::NV_PFALCON_FBIF_TRANSCFG::try_update(
-            bar,
-            &Gsp::ID,
-            usize::from_safe_cast(self.dmem_desc.ctx_dma),
+        bar.update(
+            regs::NV_PFALCON_FBIF_TRANSCFG::of::<Gsp>()
+                .try_at(usize::from_safe_cast(self.dmem_desc.ctx_dma))
+                .ok_or(EINVAL)?,
             |v| {
-                v.set_target(FalconFbifTarget::CoherentSysmem)
-                    .set_mem_type(FalconFbifMemType::Physical)
+                v.with_target(FalconFbifTarget::CoherentSysmem)
+                    .with_mem_type(FalconFbifMemType::Physical)
             },
-        )?;
+        );
 
         let (mbox0, _) = falcon
             .boot(bar, Some(0), None)
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index b051d5568cd8..87c2977ba6e4 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -1,14 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
-// Required to retain the original register names used by OpenRM, which are all capital snake case
-// but are mapped to types.
-#![allow(non_camel_case_types)]
-
-#[macro_use]
-pub(crate) mod macros;
-
 use kernel::{
-    io,
+    io::{
+        self,
+        register::WithBase,
+        Io, //
+    },
     prelude::*,
     time, //
 };
@@ -290,60 +287,147 @@ pub(crate) fn vga_workspace_addr(self) -> Option<u64> {
 
 // PFALCON
 
-register!(NV_PFALCON_FALCON_IRQSCLR @ PFalconBase[0x00000004] {
-    4:4     halt as bool;
-    6:6     swgen0 as bool;
-});
+io::register! {
+    pub(crate) NV_PFALCON_FALCON_IRQSCLR(u32) @ PFalconBase + 0x00000004 {
+        6:6     swgen0 => bool;
+        4:4     halt => bool;
+    }
 
-register!(NV_PFALCON_FALCON_MAILBOX0 @ PFalconBase[0x00000040] {
-    31:0    value as u32;
-});
+    pub(crate) NV_PFALCON_FALCON_MAILBOX0(u32) @ PFalconBase + 0x00000040 {
+        31:0    value => u32;
+    }
 
-register!(NV_PFALCON_FALCON_MAILBOX1 @ PFalconBase[0x00000044] {
-    31:0    value as u32;
-});
+    pub(crate) NV_PFALCON_FALCON_MAILBOX1(u32) @ PFalconBase + 0x00000044 {
+        31:0    value => u32;
+    }
 
-// Used to store version information about the firmware running
-// on the Falcon processor.
-register!(NV_PFALCON_FALCON_OS @ PFalconBase[0x00000080] {
-    31:0    value as u32;
-});
+    /// Used to store version information about the firmware running
+    /// on the Falcon processor.
+    pub(crate) NV_PFALCON_FALCON_OS(u32) @ PFalconBase + 0x00000080 {
+        31:0    value => u32;
+    }
 
-register!(NV_PFALCON_FALCON_RM @ PFalconBase[0x00000084] {
-    31:0    value as u32;
-});
+    pub(crate) NV_PFALCON_FALCON_RM(u32) @ PFalconBase + 0x00000084 {
+        31:0    value => u32;
+    }
 
-register!(NV_PFALCON_FALCON_HWCFG2 @ PFalconBase[0x000000f4] {
-    10:10   riscv as bool;
-    12:12   mem_scrubbing as bool, "Set to 0 after memory scrubbing is completed";
-    31:31   reset_ready as bool, "Signal indicating that reset is completed (GA102+)";
-});
+    pub(crate) NV_PFALCON_FALCON_HWCFG2(u32) @ PFalconBase + 0x000000f4 {
+        /// Signal indicating that reset is completed (GA102+).
+        31:31   reset_ready => bool;
+        /// Set to 0 after memory scrubbing is completed.
+        12:12   mem_scrubbing => bool;
+        10:10   riscv => bool;
+    }
 
-impl NV_PFALCON_FALCON_HWCFG2 {
-    /// Returns `true` if memory scrubbing is completed.
-    pub(crate) fn mem_scrubbing_done(self) -> bool {
-        !self.mem_scrubbing()
+    pub(crate) NV_PFALCON_FALCON_CPUCTL(u32) @ PFalconBase + 0x00000100 {
+        6:6     alias_en => bool;
+        4:4     halted => bool;
+        1:1     startcpu => bool;
+    }
+
+    pub(crate) NV_PFALCON_FALCON_BOOTVEC(u32) @ PFalconBase + 0x00000104 {
+        31:0    value => u32;
+    }
+
+    pub(crate) NV_PFALCON_FALCON_DMACTL(u32) @ PFalconBase + 0x0000010c {
+        7:7     secure_stat => bool;
+        6:3     dmaq_num;
+        2:2     imem_scrubbing => bool;
+        1:1     dmem_scrubbing => bool;
+        0:0     require_ctx => bool;
+    }
+
+    pub(crate) NV_PFALCON_FALCON_DMATRFBASE(u32) @ PFalconBase + 0x00000110 {
+        31:0    base => u32;
+    }
+
+    pub(crate) NV_PFALCON_FALCON_DMATRFMOFFS(u32) @ PFalconBase + 0x00000114 {
+        23:0    offs;
+    }
+
+    pub(crate) NV_PFALCON_FALCON_DMATRFCMD(u32) @ PFalconBase + 0x00000118 {
+        16:16   set_dmtag;
+        14:12   ctxdma;
+        10:8    size ?=> DmaTrfCmdSize;
+        5:5     is_write => bool;
+        4:4     imem => bool;
+        3:2     sec;
+        1:1     idle => bool;
+        0:0     full => bool;
+    }
+
+    pub(crate) NV_PFALCON_FALCON_DMATRFFBOFFS(u32) @ PFalconBase + 0x0000011c {
+        31:0    offs => u32;
+    }
+
+    pub(crate) NV_PFALCON_FALCON_DMATRFBASE1(u32) @ PFalconBase + 0x00000128 {
+        8:0     base;
+    }
+
+    pub(crate) NV_PFALCON_FALCON_HWCFG1(u32) @ PFalconBase + 0x0000012c {
+        /// Core revision subversion.
+        7:6     core_rev_subversion => FalconCoreRevSubversion;
+        /// Security model.
+        5:4     security_model ?=> FalconSecurityModel;
+        /// Core revision.
+        3:0     core_rev ?=> FalconCoreRev;
+    }
+
+    pub(crate) NV_PFALCON_FALCON_CPUCTL_ALIAS(u32) @ PFalconBase + 0x00000130 {
+        1:1     startcpu => bool;
+    }
+
+    /// IMEM access control register. Up to 4 ports are available for IMEM access.
+    pub(crate) NV_PFALCON_FALCON_IMEMC(u32)[4, stride = 16] @ PFalconBase + 0x00000180 {
+        /// Access secure IMEM.
+        28:28     secure => bool;
+        /// Auto-increment on write.
+        24:24     aincw => bool;
+        /// IMEM block and word offset.
+        15:0      offs;
+    }
+
+    /// IMEM data register. Reading/writing this register accesses IMEM at the address
+    /// specified by the corresponding IMEMC register.
+    pub(crate) NV_PFALCON_FALCON_IMEMD(u32)[4, stride = 16] @ PFalconBase + 0x00000184 {
+        31:0      data;
+    }
+
+    /// IMEM tag register. Used to set the tag for the current IMEM block.
+    pub(crate) NV_PFALCON_FALCON_IMEMT(u32)[4, stride = 16] @ PFalconBase + 0x00000188 {
+        15:0      tag;
+    }
+
+    /// DMEM access control register. Up to 8 ports are available for DMEM access.
+    pub(crate) NV_PFALCON_FALCON_DMEMC(u32)[8, stride = 8] @ PFalconBase + 0x000001c0 {
+        /// Auto-increment on write.
+        24:24     aincw => bool;
+        /// DMEM block and word offset.
+        15:0      offs;
+    }
+
+    /// DMEM data register. Reading/writing this register accesses DMEM at the address
+    /// specified by the corresponding DMEMC register.
+    pub(crate) NV_PFALCON_FALCON_DMEMD(u32)[8, stride = 8] @ PFalconBase + 0x000001c4 {
+        31:0      data;
+    }
+
+    /// Actually known as `NV_PSEC_FALCON_ENGINE` and `NV_PGSP_FALCON_ENGINE` depending on the
+    /// falcon instance.
+    pub(crate) NV_PFALCON_FALCON_ENGINE(u32) @ PFalconBase + 0x000003c0 {
+        0:0     reset => bool;
+    }
+
+    pub(crate) NV_PFALCON_FBIF_TRANSCFG(u32)[8] @ PFalconBase + 0x00000600 {
+        2:2     mem_type => FalconFbifMemType;
+        1:0     target ?=> FalconFbifTarget;
+    }
+
+    pub(crate) NV_PFALCON_FBIF_CTL(u32) @ PFalconBase + 0x00000624 {
+        7:7     allow_phys_no_ctx => bool;
     }
 }
 
-register!(NV_PFALCON_FALCON_CPUCTL @ PFalconBase[0x00000100] {
-    1:1     startcpu as bool;
-    4:4     halted as bool;
-    6:6     alias_en as bool;
-});
-
-register!(NV_PFALCON_FALCON_BOOTVEC @ PFalconBase[0x00000104] {
-    31:0    value as u32;
-});
-
-register!(NV_PFALCON_FALCON_DMACTL @ PFalconBase[0x0000010c] {
-    0:0     require_ctx as bool;
-    1:1     dmem_scrubbing as bool;
-    2:2     imem_scrubbing as bool;
-    6:3     dmaq_num as u8;
-    7:7     secure_stat as bool;
-});
-
 impl NV_PFALCON_FALCON_DMACTL {
     /// Returns `true` if memory scrubbing is completed.
     pub(crate) fn mem_scrubbing_done(self) -> bool {
@@ -351,147 +435,82 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
     }
 }
 
-register!(NV_PFALCON_FALCON_DMATRFBASE @ PFalconBase[0x00000110] {
-    31:0    base as u32;
-});
-
-register!(NV_PFALCON_FALCON_DMATRFMOFFS @ PFalconBase[0x00000114] {
-    23:0    offs as u32;
-});
-
-register!(NV_PFALCON_FALCON_DMATRFCMD @ PFalconBase[0x00000118] {
-    0:0     full as bool;
-    1:1     idle as bool;
-    3:2     sec as u8;
-    4:4     imem as bool;
-    5:5     is_write as bool;
-    10:8    size as u8 ?=> DmaTrfCmdSize;
-    14:12   ctxdma as u8;
-    16:16   set_dmtag as u8;
-});
-
 impl NV_PFALCON_FALCON_DMATRFCMD {
     /// Programs the `imem` and `sec` fields for the given FalconMem
     pub(crate) fn with_falcon_mem(self, mem: FalconMem) -> Self {
-        self.set_imem(mem != FalconMem::Dmem)
-            .set_sec(if mem == FalconMem::ImemSecure { 1 } else { 0 })
+        let this = self.with_imem(mem != FalconMem::Dmem);
+
+        match mem {
+            FalconMem::ImemSecure => this.with_const_sec::<1>(),
+            _ => this.with_const_sec::<0>(),
+        }
     }
 }
 
-register!(NV_PFALCON_FALCON_DMATRFFBOFFS @ PFalconBase[0x0000011c] {
-    31:0    offs as u32;
-});
-
-register!(NV_PFALCON_FALCON_DMATRFBASE1 @ PFalconBase[0x00000128] {
-    8:0     base as u16;
-});
-
-register!(NV_PFALCON_FALCON_HWCFG1 @ PFalconBase[0x0000012c] {
-    3:0     core_rev as u8 ?=> FalconCoreRev, "Core revision";
-    5:4     security_model as u8 ?=> FalconSecurityModel, "Security model";
-    7:6     core_rev_subversion as u8 ?=> FalconCoreRevSubversion, "Core revision subversion";
-});
-
-register!(NV_PFALCON_FALCON_CPUCTL_ALIAS @ PFalconBase[0x00000130] {
-    1:1     startcpu as bool;
-});
-
-// IMEM access control register. Up to 4 ports are available for IMEM access.
-register!(NV_PFALCON_FALCON_IMEMC @ PFalconBase[0x00000180[4; 16]] {
-    15:0      offs as u16, "IMEM block and word offset";
-    24:24     aincw as bool, "Auto-increment on write";
-    28:28     secure as bool, "Access secure IMEM";
-});
-
-// IMEM data register. Reading/writing this register accesses IMEM at the address
-// specified by the corresponding IMEMC register.
-register!(NV_PFALCON_FALCON_IMEMD @ PFalconBase[0x00000184[4; 16]] {
-    31:0      data as u32;
-});
-
-// IMEM tag register. Used to set the tag for the current IMEM block.
-register!(NV_PFALCON_FALCON_IMEMT @ PFalconBase[0x00000188[4; 16]] {
-    15:0      tag as u16;
-});
-
-// DMEM access control register. Up to 8 ports are available for DMEM access.
-register!(NV_PFALCON_FALCON_DMEMC @ PFalconBase[0x000001c0[8; 8]] {
-    15:0      offs as u16, "DMEM block and word offset";
-    24:24     aincw as bool, "Auto-increment on write";
-});
-
-// DMEM data register. Reading/writing this register accesses DMEM at the address
-// specified by the corresponding DMEMC register.
-register!(NV_PFALCON_FALCON_DMEMD @ PFalconBase[0x000001c4[8; 8]] {
-    31:0      data as u32;
-});
-
-// Actually known as `NV_PSEC_FALCON_ENGINE` and `NV_PGSP_FALCON_ENGINE` depending on the falcon
-// instance.
-register!(NV_PFALCON_FALCON_ENGINE @ PFalconBase[0x000003c0] {
-    0:0     reset as bool;
-});
-
 impl NV_PFALCON_FALCON_ENGINE {
     /// Resets the falcon
     pub(crate) fn reset_engine<E: FalconEngine>(bar: &Bar0) {
-        Self::read(bar, &E::ID).set_reset(true).write(bar, &E::ID);
+        bar.update(Self::of::<E>(), |r| r.with_reset(true));
 
         // TIMEOUT: falcon engine should not take more than 10us to reset.
         time::delay::fsleep(time::Delta::from_micros(10));
 
-        Self::read(bar, &E::ID).set_reset(false).write(bar, &E::ID);
+        bar.update(Self::of::<E>(), |r| r.with_reset(false));
     }
 }
 
-register!(NV_PFALCON_FBIF_TRANSCFG @ PFalconBase[0x00000600[8]] {
-    1:0     target as u8 ?=> FalconFbifTarget;
-    2:2     mem_type as bool => FalconFbifMemType;
-});
-
-register!(NV_PFALCON_FBIF_CTL @ PFalconBase[0x00000624] {
-    7:7     allow_phys_no_ctx as bool;
-});
+impl NV_PFALCON_FALCON_HWCFG2 {
+    /// Returns `true` if memory scrubbing is completed.
+    pub(crate) fn mem_scrubbing_done(self) -> bool {
+        !self.mem_scrubbing()
+    }
+}
 
 /* PFALCON2 */
 
-register!(NV_PFALCON2_FALCON_MOD_SEL @ PFalcon2Base[0x00000180] {
-    7:0     algo as u8 ?=> FalconModSelAlgo;
-});
+io::register! {
+    pub(crate) NV_PFALCON2_FALCON_MOD_SEL(u32) @ PFalcon2Base + 0x00000180 {
+        7:0     algo ?=> FalconModSelAlgo;
+    }
 
-register!(NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID @ PFalcon2Base[0x00000198] {
-    7:0    ucode_id as u8;
-});
+    pub(crate) NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID(u32) @ PFalcon2Base + 0x00000198 {
+        7:0    ucode_id => u8;
+    }
 
-register!(NV_PFALCON2_FALCON_BROM_ENGIDMASK @ PFalcon2Base[0x0000019c] {
-    31:0    value as u32;
-});
+    pub(crate) NV_PFALCON2_FALCON_BROM_ENGIDMASK(u32) @ PFalcon2Base + 0x0000019c {
+        31:0    value => u32;
+    }
 
-// OpenRM defines this as a register array, but doesn't specify its size and only uses its first
-// element. Be conservative until we know the actual size or need to use more registers.
-register!(NV_PFALCON2_FALCON_BROM_PARAADDR @ PFalcon2Base[0x00000210[1]] {
-    31:0    value as u32;
-});
+    /// OpenRM defines this as a register array, but doesn't specify its size and only uses its
+    /// first element. Be conservative until we know the actual size or need to use more registers.
+    pub(crate) NV_PFALCON2_FALCON_BROM_PARAADDR(u32)[1] @ PFalcon2Base + 0x00000210 {
+        31:0    value => u32;
+    }
+}
 
 // PRISCV
 
-// RISC-V status register for debug (Turing and GA100 only).
-// Reflects current RISC-V core status.
-register!(NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS @ PFalcon2Base[0x00000240] {
-    0:0     active_stat as bool, "RISC-V core active/inactive status";
-});
+io::register! {
+    /// RISC-V status register for debug (Turing and GA100 only).
+    /// Reflects current RISC-V core status.
+    pub(crate) NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS(u32) @ PFalcon2Base + 0x00000240 {
+        /// RISC-V core active/inactive status.
+        0:0     active_stat => bool;
+    }
 
-// GA102 and later
-register!(NV_PRISCV_RISCV_CPUCTL @ PFalcon2Base[0x00000388] {
-    0:0     halted as bool;
-    7:7     active_stat as bool;
-});
+    /// GA102 and later.
+    pub(crate) NV_PRISCV_RISCV_CPUCTL(u32) @ PFalcon2Base + 0x00000388 {
+        7:7     active_stat => bool;
+        0:0     halted => bool;
+    }
 
-register!(NV_PRISCV_RISCV_BCR_CTRL @ PFalcon2Base[0x00000668] {
-    0:0     valid as bool;
-    4:4     core_select as bool => PeregrineCoreSelect;
-    8:8     br_fetch as bool;
-});
+    /// GA102 and later.
+    pub(crate) NV_PRISCV_RISCV_BCR_CTRL(u32) @ PFalcon2Base + 0x00000668 {
+        8:8     br_fetch => bool;
+        4:4     core_select => PeregrineCoreSelect;
+        0:0     valid => bool;
+    }
+}
 
 // The modules below provide registers that are not identical on all supported chips. They should
 // only be used in HAL modules.
diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core/regs/macros.rs
deleted file mode 100644
index ed624be1f39b..000000000000
--- a/drivers/gpu/nova-core/regs/macros.rs
+++ /dev/null
@@ -1,739 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-//! `register!` macro to define register layout and accessors.
-//!
-//! A single register typically includes several fields, which are accessed through a combination
-//! of bit-shift and mask operations that introduce a class of potential mistakes, notably because
-//! not all possible field values are necessarily valid.
-//!
-//! The `register!` macro in this module provides an intuitive and readable syntax for defining a
-//! dedicated type for each register. Each such type comes with its own field accessors that can
-//! return an error if a field's value is invalid. Please look at the [`bitfield`] macro for the
-//! complete syntax of fields definitions.
-
-/// Trait providing a base address to be added to the offset of a relative register to obtain
-/// its actual offset.
-///
-/// The `T` generic argument is used to distinguish which base to use, in case a type provides
-/// several bases. It is given to the `register!` macro to restrict the use of the register to
-/// implementors of this particular variant.
-pub(crate) trait RegisterBase<T> {
-    const BASE: usize;
-}
-
-/// Defines a dedicated type for a register with an absolute offset, including getter and setter
-/// methods for its fields and methods to read and write it from an `Io` region.
-///
-/// Example:
-///
-/// ```no_run
-/// register!(BOOT_0 @ 0x00000100, "Basic revision information about the GPU" {
-///    3:0     minor_revision as u8, "Minor revision of the chip";
-///    7:4     major_revision as u8, "Major revision of the chip";
-///    28:20   chipset as u32 ?=> Chipset, "Chipset model";
-/// });
-/// ```
-///
-/// This defines a `BOOT_0` type which can be read or written from offset `0x100` of an `Io`
-/// region. It is composed of 3 fields, for instance `minor_revision` is made of the 4 least
-/// significant bits of the register. Each field can be accessed and modified using accessor
-/// methods:
-///
-/// ```no_run
-/// // Read from the register's defined offset (0x100).
-/// let boot0 = BOOT_0::read(&bar);
-/// pr_info!("chip revision: {}.{}", boot0.major_revision(), boot0.minor_revision());
-///
-/// // `Chipset::try_from` is called with the value of the `chipset` field and returns an
-/// // error if it is invalid.
-/// let chipset = boot0.chipset()?;
-///
-/// // Update some fields and write the value back.
-/// boot0.set_major_revision(3).set_minor_revision(10).write(&bar);
-///
-/// // Or, just read and update the register in a single step:
-/// BOOT_0::update(&bar, |r| r.set_major_revision(3).set_minor_revision(10));
-/// ```
-///
-/// The documentation strings are optional. If present, they will be added to the type's
-/// definition, or the field getter and setter methods they are attached to.
-///
-/// It is also possible to create a alias register by using the `=> ALIAS` syntax. This is useful
-/// for cases where a register's interpretation depends on the context:
-///
-/// ```no_run
-/// register!(SCRATCH @ 0x00000200, "Scratch register" {
-///    31:0     value as u32, "Raw value";
-/// });
-///
-/// register!(SCRATCH_BOOT_STATUS => SCRATCH, "Boot status of the firmware" {
-///     0:0     completed as bool, "Whether the firmware has completed booting";
-/// });
-/// ```
-///
-/// In this example, `SCRATCH_0_BOOT_STATUS` uses the same I/O address as `SCRATCH`, while also
-/// providing its own `completed` field.
-///
-/// ## Relative registers
-///
-/// A register can be defined as being accessible from a fixed offset of a provided base. For
-/// instance, imagine the following I/O space:
-///
-/// ```text
-///           +-----------------------------+
-///           |             ...             |
-///           |                             |
-///  0x100--->+------------CPU0-------------+
-///           |                             |
-///  0x110--->+-----------------------------+
-///           |           CPU_CTL           |
-///           +-----------------------------+
-///           |             ...             |
-///           |                             |
-///           |                             |
-///  0x200--->+------------CPU1-------------+
-///           |                             |
-///  0x210--->+-----------------------------+
-///           |           CPU_CTL           |
-///           +-----------------------------+
-///           |             ...             |
-///           +-----------------------------+
-/// ```
-///
-/// `CPU0` and `CPU1` both have a `CPU_CTL` register that starts at offset `0x10` of their I/O
-/// space segment. Since both instances of `CPU_CTL` share the same layout, we don't want to define
-/// them twice and would prefer a way to select which one to use from a single definition
-///
-/// This can be done using the `Base[Offset]` syntax when specifying the register's address.
-///
-/// `Base` is an arbitrary type (typically a ZST) to be used as a generic parameter of the
-/// [`RegisterBase`] trait to provide the base as a constant, i.e. each type providing a base for
-/// this register needs to implement `RegisterBase<Base>`. Here is the above example translated
-/// into code:
-///
-/// ```no_run
-/// // Type used to identify the base.
-/// pub(crate) struct CpuCtlBase;
-///
-/// // ZST describing `CPU0`.
-/// struct Cpu0;
-/// impl RegisterBase<CpuCtlBase> for Cpu0 {
-///     const BASE: usize = 0x100;
-/// }
-/// // Singleton of `CPU0` used to identify it.
-/// const CPU0: Cpu0 = Cpu0;
-///
-/// // ZST describing `CPU1`.
-/// struct Cpu1;
-/// impl RegisterBase<CpuCtlBase> for Cpu1 {
-///     const BASE: usize = 0x200;
-/// }
-/// // Singleton of `CPU1` used to identify it.
-/// const CPU1: Cpu1 = Cpu1;
-///
-/// // This makes `CPU_CTL` accessible from all implementors of `RegisterBase<CpuCtlBase>`.
-/// register!(CPU_CTL @ CpuCtlBase[0x10], "CPU core control" {
-///     0:0     start as bool, "Start the CPU core";
-/// });
-///
-/// // The `read`, `write` and `update` methods of relative registers take an extra `base` argument
-/// // that is used to resolve its final address by adding its `BASE` to the offset of the
-/// // register.
-///
-/// // Start `CPU0`.
-/// CPU_CTL::update(bar, &CPU0, |r| r.set_start(true));
-///
-/// // Start `CPU1`.
-/// CPU_CTL::update(bar, &CPU1, |r| r.set_start(true));
-///
-/// // Aliases can also be defined for relative register.
-/// register!(CPU_CTL_ALIAS => CpuCtlBase[CPU_CTL], "Alias to CPU core control" {
-///     1:1     alias_start as bool, "Start the aliased CPU core";
-/// });
-///
-/// // Start the aliased `CPU0`.
-/// CPU_CTL_ALIAS::update(bar, &CPU0, |r| r.set_alias_start(true));
-/// ```
-///
-/// ## Arrays of registers
-///
-/// Some I/O areas contain consecutive values that can be interpreted in the same way. These areas
-/// can be defined as an array of identical registers, allowing them to be accessed by index with
-/// compile-time or runtime bound checking. Simply define their address as `Address[Size]`, and add
-/// an `idx` parameter to their `read`, `write` and `update` methods:
-///
-/// ```no_run
-/// # fn no_run() -> Result<(), Error> {
-/// # fn get_scratch_idx() -> usize {
-/// #   0x15
-/// # }
-/// // Array of 64 consecutive registers with the same layout starting at offset `0x80`.
-/// register!(SCRATCH @ 0x00000080[64], "Scratch registers" {
-///     31:0    value as u32;
-/// });
-///
-/// // Read scratch register 0, i.e. I/O address `0x80`.
-/// let scratch_0 = SCRATCH::read(bar, 0).value();
-/// // Read scratch register 15, i.e. I/O address `0x80 + (15 * 4)`.
-/// let scratch_15 = SCRATCH::read(bar, 15).value();
-///
-/// // This is out of bounds and won't build.
-/// // let scratch_128 = SCRATCH::read(bar, 128).value();
-///
-/// // Runtime-obtained array index.
-/// let scratch_idx = get_scratch_idx();
-/// // Access on a runtime index returns an error if it is out-of-bounds.
-/// let some_scratch = SCRATCH::try_read(bar, scratch_idx)?.value();
-///
-/// // Alias to a particular register in an array.
-/// // Here `SCRATCH[8]` is used to convey the firmware exit code.
-/// register!(FIRMWARE_STATUS => SCRATCH[8], "Firmware exit status code" {
-///     7:0     status as u8;
-/// });
-///
-/// let status = FIRMWARE_STATUS::read(bar).status();
-///
-/// // Non-contiguous register arrays can be defined by adding a stride parameter.
-/// // Here, each of the 16 registers of the array are separated by 8 bytes, meaning that the
-/// // registers of the two declarations below are interleaved.
-/// register!(SCRATCH_INTERLEAVED_0 @ 0x000000c0[16 ; 8], "Scratch registers bank 0" {
-///     31:0    value as u32;
-/// });
-/// register!(SCRATCH_INTERLEAVED_1 @ 0x000000c4[16 ; 8], "Scratch registers bank 1" {
-///     31:0    value as u32;
-/// });
-/// # Ok(())
-/// # }
-/// ```
-///
-/// ## Relative arrays of registers
-///
-/// Combining the two features described in the sections above, arrays of registers accessible from
-/// a base can also be defined:
-///
-/// ```no_run
-/// # fn no_run() -> Result<(), Error> {
-/// # fn get_scratch_idx() -> usize {
-/// #   0x15
-/// # }
-/// // Type used as parameter of `RegisterBase` to specify the base.
-/// pub(crate) struct CpuCtlBase;
-///
-/// // ZST describing `CPU0`.
-/// struct Cpu0;
-/// impl RegisterBase<CpuCtlBase> for Cpu0 {
-///     const BASE: usize = 0x100;
-/// }
-/// // Singleton of `CPU0` used to identify it.
-/// const CPU0: Cpu0 = Cpu0;
-///
-/// // ZST describing `CPU1`.
-/// struct Cpu1;
-/// impl RegisterBase<CpuCtlBase> for Cpu1 {
-///     const BASE: usize = 0x200;
-/// }
-/// // Singleton of `CPU1` used to identify it.
-/// const CPU1: Cpu1 = Cpu1;
-///
-/// // 64 per-cpu scratch registers, arranged as an contiguous array.
-/// register!(CPU_SCRATCH @ CpuCtlBase[0x00000080[64]], "Per-CPU scratch registers" {
-///     31:0    value as u32;
-/// });
-///
-/// let cpu0_scratch_0 = CPU_SCRATCH::read(bar, &Cpu0, 0).value();
-/// let cpu1_scratch_15 = CPU_SCRATCH::read(bar, &Cpu1, 15).value();
-///
-/// // This won't build.
-/// // let cpu0_scratch_128 = CPU_SCRATCH::read(bar, &Cpu0, 128).value();
-///
-/// // Runtime-obtained array index.
-/// let scratch_idx = get_scratch_idx();
-/// // Access on a runtime value returns an error if it is out-of-bounds.
-/// let cpu0_some_scratch = CPU_SCRATCH::try_read(bar, &Cpu0, scratch_idx)?.value();
-///
-/// // `SCRATCH[8]` is used to convey the firmware exit code.
-/// register!(CPU_FIRMWARE_STATUS => CpuCtlBase[CPU_SCRATCH[8]],
-///     "Per-CPU firmware exit status code" {
-///     7:0     status as u8;
-/// });
-///
-/// let cpu0_status = CPU_FIRMWARE_STATUS::read(bar, &Cpu0).status();
-///
-/// // Non-contiguous register arrays can be defined by adding a stride parameter.
-/// // Here, each of the 16 registers of the array are separated by 8 bytes, meaning that the
-/// // registers of the two declarations below are interleaved.
-/// register!(CPU_SCRATCH_INTERLEAVED_0 @ CpuCtlBase[0x00000d00[16 ; 8]],
-///           "Scratch registers bank 0" {
-///     31:0    value as u32;
-/// });
-/// register!(CPU_SCRATCH_INTERLEAVED_1 @ CpuCtlBase[0x00000d04[16 ; 8]],
-///           "Scratch registers bank 1" {
-///     31:0    value as u32;
-/// });
-/// # Ok(())
-/// # }
-/// ```
-macro_rules! register {
-    // Creates a register at a fixed offset of the MMIO space.
-    ($name:ident @ $offset:literal $(, $comment:literal)? { $($fields:tt)* } ) => {
-        bitfield!(pub(crate) struct $name(u32) $(, $comment)? { $($fields)* } );
-        register!(@io_fixed $name @ $offset);
-    };
-
-    // Creates an alias register of fixed offset register `alias` with its own fields.
-    ($name:ident => $alias:ident $(, $comment:literal)? { $($fields:tt)* } ) => {
-        bitfield!(pub(crate) struct $name(u32) $(, $comment)? { $($fields)* } );
-        register!(@io_fixed $name @ $alias::OFFSET);
-    };
-
-    // Creates a register at a relative offset from a base address provider.
-    ($name:ident @ $base:ty [ $offset:literal ] $(, $comment:literal)? { $($fields:tt)* } ) => {
-        bitfield!(pub(crate) struct $name(u32) $(, $comment)? { $($fields)* } );
-        register!(@io_relative $name @ $base [ $offset ]);
-    };
-
-    // Creates an alias register of relative offset register `alias` with its own fields.
-    ($name:ident => $base:ty [ $alias:ident ] $(, $comment:literal)? { $($fields:tt)* }) => {
-        bitfield!(pub(crate) struct $name(u32) $(, $comment)? { $($fields)* } );
-        register!(@io_relative $name @ $base [ $alias::OFFSET ]);
-    };
-
-    // Creates an array of registers at a fixed offset of the MMIO space.
-    (
-        $name:ident @ $offset:literal [ $size:expr ; $stride:expr ] $(, $comment:literal)? {
-            $($fields:tt)*
-        }
-    ) => {
-        static_assert!(::core::mem::size_of::<u32>() <= $stride);
-        bitfield!(pub(crate) struct $name(u32) $(, $comment)? { $($fields)* } );
-        register!(@io_array $name @ $offset [ $size ; $stride ]);
-    };
-
-    // Shortcut for contiguous array of registers (stride == size of element).
-    (
-        $name:ident @ $offset:literal [ $size:expr ] $(, $comment:literal)? {
-            $($fields:tt)*
-        }
-    ) => {
-        register!($name @ $offset [ $size ; ::core::mem::size_of::<u32>() ] $(, $comment)? {
-            $($fields)*
-        } );
-    };
-
-    // Creates an array of registers at a relative offset from a base address provider.
-    (
-        $name:ident @ $base:ty [ $offset:literal [ $size:expr ; $stride:expr ] ]
-            $(, $comment:literal)? { $($fields:tt)* }
-    ) => {
-        static_assert!(::core::mem::size_of::<u32>() <= $stride);
-        bitfield!(pub(crate) struct $name(u32) $(, $comment)? { $($fields)* } );
-        register!(@io_relative_array $name @ $base [ $offset [ $size ; $stride ] ]);
-    };
-
-    // Shortcut for contiguous array of relative registers (stride == size of element).
-    (
-        $name:ident @ $base:ty [ $offset:literal [ $size:expr ] ] $(, $comment:literal)? {
-            $($fields:tt)*
-        }
-    ) => {
-        register!($name @ $base [ $offset [ $size ; ::core::mem::size_of::<u32>() ] ]
-            $(, $comment)? { $($fields)* } );
-    };
-
-    // Creates an alias of register `idx` of relative array of registers `alias` with its own
-    // fields.
-    (
-        $name:ident => $base:ty [ $alias:ident [ $idx:expr ] ] $(, $comment:literal)? {
-            $($fields:tt)*
-        }
-    ) => {
-        static_assert!($idx < $alias::SIZE);
-        bitfield!(pub(crate) struct $name(u32) $(, $comment)? { $($fields)* } );
-        register!(@io_relative $name @ $base [ $alias::OFFSET + $idx * $alias::STRIDE ] );
-    };
-
-    // Creates an alias of register `idx` of array of registers `alias` with its own fields.
-    // This rule belongs to the (non-relative) register arrays set, but needs to be put last
-    // to avoid it being interpreted in place of the relative register array alias rule.
-    ($name:ident => $alias:ident [ $idx:expr ] $(, $comment:literal)? { $($fields:tt)* }) => {
-        static_assert!($idx < $alias::SIZE);
-        bitfield!(pub(crate) struct $name(u32) $(, $comment)? { $($fields)* } );
-        register!(@io_fixed $name @ $alias::OFFSET + $idx * $alias::STRIDE );
-    };
-
-    // Generates the IO accessors for a fixed offset register.
-    (@io_fixed $name:ident @ $offset:expr) => {
-        #[allow(dead_code)]
-        impl $name {
-            pub(crate) const OFFSET: usize = $offset;
-
-            /// Read the register from its address in `io`.
-            #[inline(always)]
-            pub(crate) fn read<T, I>(io: &T) -> Self where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-            {
-                Self(io.read32($offset))
-            }
-
-            /// Write the value contained in `self` to the register address in `io`.
-            #[inline(always)]
-            pub(crate) fn write<T, I>(self, io: &T) where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-            {
-                io.write32(self.0, $offset)
-            }
-
-            /// Read the register from its address in `io` and run `f` on its value to obtain a new
-            /// value to write back.
-            #[inline(always)]
-            pub(crate) fn update<T, I, F>(
-                io: &T,
-                f: F,
-            ) where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                F: ::core::ops::FnOnce(Self) -> Self,
-            {
-                let reg = f(Self::read(io));
-                reg.write(io);
-            }
-        }
-    };
-
-    // Generates the IO accessors for a relative offset register.
-    (@io_relative $name:ident @ $base:ty [ $offset:expr ]) => {
-        #[allow(dead_code)]
-        impl $name {
-            pub(crate) const OFFSET: usize = $offset;
-
-            /// Read the register from `io`, using the base address provided by `base` and adding
-            /// the register's offset to it.
-            #[inline(always)]
-            pub(crate) fn read<T, I, B>(
-                io: &T,
-                #[allow(unused_variables)]
-                base: &B,
-            ) -> Self where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                B: crate::regs::macros::RegisterBase<$base>,
-            {
-                const OFFSET: usize = $name::OFFSET;
-
-                let value = io.read32(
-                    <B as crate::regs::macros::RegisterBase<$base>>::BASE + OFFSET
-                );
-
-                Self(value)
-            }
-
-            /// Write the value contained in `self` to `io`, using the base address provided by
-            /// `base` and adding the register's offset to it.
-            #[inline(always)]
-            pub(crate) fn write<T, I, B>(
-                self,
-                io: &T,
-                #[allow(unused_variables)]
-                base: &B,
-            ) where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                B: crate::regs::macros::RegisterBase<$base>,
-            {
-                const OFFSET: usize = $name::OFFSET;
-
-                io.write32(
-                    self.0,
-                    <B as crate::regs::macros::RegisterBase<$base>>::BASE + OFFSET
-                );
-            }
-
-            /// Read the register from `io`, using the base address provided by `base` and adding
-            /// the register's offset to it, then run `f` on its value to obtain a new value to
-            /// write back.
-            #[inline(always)]
-            pub(crate) fn update<T, I, B, F>(
-                io: &T,
-                base: &B,
-                f: F,
-            ) where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                B: crate::regs::macros::RegisterBase<$base>,
-                F: ::core::ops::FnOnce(Self) -> Self,
-            {
-                let reg = f(Self::read(io, base));
-                reg.write(io, base);
-            }
-        }
-    };
-
-    // Generates the IO accessors for an array of registers.
-    (@io_array $name:ident @ $offset:literal [ $size:expr ; $stride:expr ]) => {
-        #[allow(dead_code)]
-        impl $name {
-            pub(crate) const OFFSET: usize = $offset;
-            pub(crate) const SIZE: usize = $size;
-            pub(crate) const STRIDE: usize = $stride;
-
-            /// Read the array register at index `idx` from its address in `io`.
-            #[inline(always)]
-            pub(crate) fn read<T, I>(
-                io: &T,
-                idx: usize,
-            ) -> Self where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-            {
-                build_assert!(idx < Self::SIZE);
-
-                let offset = Self::OFFSET + (idx * Self::STRIDE);
-                let value = io.read32(offset);
-
-                Self(value)
-            }
-
-            /// Write the value contained in `self` to the array register with index `idx` in `io`.
-            #[inline(always)]
-            pub(crate) fn write<T, I>(
-                self,
-                io: &T,
-                idx: usize
-            ) where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-            {
-                build_assert!(idx < Self::SIZE);
-
-                let offset = Self::OFFSET + (idx * Self::STRIDE);
-
-                io.write32(self.0, offset);
-            }
-
-            /// Read the array register at index `idx` in `io` and run `f` on its value to obtain a
-            /// new value to write back.
-            #[inline(always)]
-            pub(crate) fn update<T, I, F>(
-                io: &T,
-                idx: usize,
-                f: F,
-            ) where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                F: ::core::ops::FnOnce(Self) -> Self,
-            {
-                let reg = f(Self::read(io, idx));
-                reg.write(io, idx);
-            }
-
-            /// Read the array register at index `idx` from its address in `io`.
-            ///
-            /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
-            /// access was out-of-bounds.
-            #[inline(always)]
-            pub(crate) fn try_read<T, I>(
-                io: &T,
-                idx: usize,
-            ) -> ::kernel::error::Result<Self> where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-            {
-                if idx < Self::SIZE {
-                    Ok(Self::read(io, idx))
-                } else {
-                    Err(EINVAL)
-                }
-            }
-
-            /// Write the value contained in `self` to the array register with index `idx` in `io`.
-            ///
-            /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
-            /// access was out-of-bounds.
-            #[inline(always)]
-            pub(crate) fn try_write<T, I>(
-                self,
-                io: &T,
-                idx: usize,
-            ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-            {
-                if idx < Self::SIZE {
-                    Ok(self.write(io, idx))
-                } else {
-                    Err(EINVAL)
-                }
-            }
-
-            /// Read the array register at index `idx` in `io` and run `f` on its value to obtain a
-            /// new value to write back.
-            ///
-            /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
-            /// access was out-of-bounds.
-            #[inline(always)]
-            pub(crate) fn try_update<T, I, F>(
-                io: &T,
-                idx: usize,
-                f: F,
-            ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                F: ::core::ops::FnOnce(Self) -> Self,
-            {
-                if idx < Self::SIZE {
-                    Ok(Self::update(io, idx, f))
-                } else {
-                    Err(EINVAL)
-                }
-            }
-        }
-    };
-
-    // Generates the IO accessors for an array of relative registers.
-    (
-        @io_relative_array $name:ident @ $base:ty
-            [ $offset:literal [ $size:expr ; $stride:expr ] ]
-    ) => {
-        #[allow(dead_code)]
-        impl $name {
-            pub(crate) const OFFSET: usize = $offset;
-            pub(crate) const SIZE: usize = $size;
-            pub(crate) const STRIDE: usize = $stride;
-
-            /// Read the array register at index `idx` from `io`, using the base address provided
-            /// by `base` and adding the register's offset to it.
-            #[inline(always)]
-            pub(crate) fn read<T, I, B>(
-                io: &T,
-                #[allow(unused_variables)]
-                base: &B,
-                idx: usize,
-            ) -> Self where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                B: crate::regs::macros::RegisterBase<$base>,
-            {
-                build_assert!(idx < Self::SIZE);
-
-                let offset = <B as crate::regs::macros::RegisterBase<$base>>::BASE +
-                    Self::OFFSET + (idx * Self::STRIDE);
-                let value = io.read32(offset);
-
-                Self(value)
-            }
-
-            /// Write the value contained in `self` to `io`, using the base address provided by
-            /// `base` and adding the offset of array register `idx` to it.
-            #[inline(always)]
-            pub(crate) fn write<T, I, B>(
-                self,
-                io: &T,
-                #[allow(unused_variables)]
-                base: &B,
-                idx: usize
-            ) where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                B: crate::regs::macros::RegisterBase<$base>,
-            {
-                build_assert!(idx < Self::SIZE);
-
-                let offset = <B as crate::regs::macros::RegisterBase<$base>>::BASE +
-                    Self::OFFSET + (idx * Self::STRIDE);
-
-                io.write32(self.0, offset);
-            }
-
-            /// Read the array register at index `idx` from `io`, using the base address provided
-            /// by `base` and adding the register's offset to it, then run `f` on its value to
-            /// obtain a new value to write back.
-            #[inline(always)]
-            pub(crate) fn update<T, I, B, F>(
-                io: &T,
-                base: &B,
-                idx: usize,
-                f: F,
-            ) where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                B: crate::regs::macros::RegisterBase<$base>,
-                F: ::core::ops::FnOnce(Self) -> Self,
-            {
-                let reg = f(Self::read(io, base, idx));
-                reg.write(io, base, idx);
-            }
-
-            /// Read the array register at index `idx` from `io`, using the base address provided
-            /// by `base` and adding the register's offset to it.
-            ///
-            /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
-            /// access was out-of-bounds.
-            #[inline(always)]
-            pub(crate) fn try_read<T, I, B>(
-                io: &T,
-                base: &B,
-                idx: usize,
-            ) -> ::kernel::error::Result<Self> where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                B: crate::regs::macros::RegisterBase<$base>,
-            {
-                if idx < Self::SIZE {
-                    Ok(Self::read(io, base, idx))
-                } else {
-                    Err(EINVAL)
-                }
-            }
-
-            /// Write the value contained in `self` to `io`, using the base address provided by
-            /// `base` and adding the offset of array register `idx` to it.
-            ///
-            /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
-            /// access was out-of-bounds.
-            #[inline(always)]
-            pub(crate) fn try_write<T, I, B>(
-                self,
-                io: &T,
-                base: &B,
-                idx: usize,
-            ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                B: crate::regs::macros::RegisterBase<$base>,
-            {
-                if idx < Self::SIZE {
-                    Ok(self.write(io, base, idx))
-                } else {
-                    Err(EINVAL)
-                }
-            }
-
-            /// Read the array register at index `idx` from `io`, using the base address provided
-            /// by `base` and adding the register's offset to it, then run `f` on its value to
-            /// obtain a new value to write back.
-            ///
-            /// The validity of `idx` is checked at run-time, and `EINVAL` is returned is the
-            /// access was out-of-bounds.
-            #[inline(always)]
-            pub(crate) fn try_update<T, I, B, F>(
-                io: &T,
-                base: &B,
-                idx: usize,
-                f: F,
-            ) -> ::kernel::error::Result where
-                T: ::core::ops::Deref<Target = I>,
-                I: ::kernel::io::IoKnownSize + ::kernel::io::IoCapable<u32>,
-                B: crate::regs::macros::RegisterBase<$base>,
-                F: ::core::ops::FnOnce(Self) -> Self,
-            {
-                if idx < Self::SIZE {
-                    Ok(Self::update(io, base, idx, f))
-                } else {
-                    Err(EINVAL)
-                }
-            }
-        }
-    };
-}

-- 
2.53.0

