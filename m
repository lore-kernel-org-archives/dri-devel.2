Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57AA103A9A1
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47A3510E6B4;
	Wed, 25 Mar 2026 02:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="E2fDeKR8";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010050.outbound.protection.outlook.com [52.101.46.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C4210E6B1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:46:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vm1icg9IFiomjGSJg1j2/aixL5TfgvBN/UTRm+PRXE6W3P5lv4QL8gmCVFbiSpeZcNtWJKGIjzY8D/3aM9IBjdfWJl9RLHL17Q97u5FINvJRGCvo1dhVDLD61TakhO1XhM0Rq05FBDcwjsV9g67GHI4IlLr0oexc3OdWFqOmjrp1+sO+iYKhJm5auWzoJpMW8i4fvDHJr4mz3HodRoXCQA8/ebGPpGA0yJzx2wh4O0SOmdJ4hPmD3jKrAw2DwhgdwollClfJK+hw+uhFsaCiEVHmSWHQFfKRsR6LiEqsoICmKGdCzyRAWULpbAPewPTWlcPkMxsazgz8+MebZZ9ZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpS1zF3N7n/ctsWwsee//HAZe95DSB4PbCBUQUBRzdw=;
 b=liFN2IxtluX/cgtZf0HoqKdiMjcMW/UEnrqA3UALBMosTV9tw9M5hT9ubIq99V32W174gSf6wy0Z9gkfOfDPJRDXtKU45uGjHkAFp/r0bfjmvMsZxK8vpfDb8/VaQBngg+znNLAj8WAfInitxtN192jdWEJioF8MkD2PWfHeTcm0CwlDP/r6yV8IIvkgAbyeoz2yDwLmkj3kVlBvbdn91FFE/VcTQhSo/jMnR0a2AKlFb0oDuiAibFoUkvfqd9x8Rw8UTms55ehWtJshG1A9ZcFFvuxewF/5cA5WERkIKQCm1uIZEiGskruku8pYffJVw/1nhG0vD9DbtL3X8TjeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpS1zF3N7n/ctsWwsee//HAZe95DSB4PbCBUQUBRzdw=;
 b=E2fDeKR8LAd/Bq81taT9ro+caaJfKw4H1UVgcCJfNiBNuZIoUvHkmYfYavZ23SX4Lg2KA3Ykr36Dlntg9111JMfpIronQInyNUVGLhh3C42piWDuK4VijBDip4e3HtdkOjo3Fu4y1QFi8wh3Gf75+bCeiFWl7sYKqSfaRtUBFmfhfnv7/OCswe/ObwgpuhBoKAeo6M1M5Qn9sON9Yo0s2XWhAkbe5j1FwkMdQVhp+Xsn9cIfaVjC3pLRAmORKAwC74WUZnGfEwM4y2Uqb1B4r9xvaY5ceIeqAMa5NA41I0w0Gw+GJVdfn6ToFV1hprC3QP38ACNY5tRdtV798wHRew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7448.namprd12.prod.outlook.com (2603:10b6:510:214::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 02:46:40 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 25 Mar 2026
 02:46:39 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 25 Mar 2026 11:46:14 +0900
Subject: [PATCH v4 01/10] gpu: nova-core: introduce `bounded_enum` macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-b4-nova-register-v4-1-bdf172f0f6ca@nvidia.com>
References: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
In-Reply-To: <20260325-b4-nova-register-v4-0-bdf172f0f6ca@nvidia.com>
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
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TY4PR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:405:370::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: abc6d62c-a5c0-4200-95b5-08de8a18bd8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|10070799003|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: LjbodwI4fStL7EtOrd9JxBO48kkz8vVG0rRa6GKyxk+khcReJ+sZ8MjT+TfXaKQdY1YobKPYXSzsotcfdLywJ1PGmZpGtZn+ZPRvOL9PymJKEQH/fUrBoYJKQI8EvUzdFBUGJhNMX4BDXpOJBLIOJcMqtlyq4UCROQGdOpSdvhtVA7sj+muWigkM4j0uCKZNBKtxwSEMFu/M8pqLyJ1vint1A3Qtku4vx0WFOQX32bGhpE/hj1swmDv+X64EB6QhG+gxnQw7PNY8RLNi6avrMKuIiUFg519QQhSi5M2BRzF/UwupXkJAuAuKvt7DAkQTmQpu7Xw49Tuc0EVZ0t2Psp6UC3nwMwE1e27styHc3mrJGyn5CfBDf4YUj6RsGkMHWND6glL6V+BApCIFNt9DBEUawNW5AVkiPSk56YXzJggjq4lCy5/P+r1R0FVtIN93K127OBYcDXRCOiBOEflLDLxAlSIL5hXayTEaS6CLWic0tomPGOFxiHJgPR9j/R/Qd+w3WBEfoRDoBX3k/Hx/53SXKKNPh1i4IFPMBKUMsDJ7BrSrN5TQWEt8O5XO6tZUxSb9FjalU0uCwVLR/7K62XT2u366qs7O4qkjN7qto6KFJVj4FZzmDhfXaK30yTRikqowx34MuCFC3Z3oEhhH7sIzdsZgsykZIr0N4G0d5cWCXZS3jdAIryMoQDdhkISwwqtQd4XC3TpscugG8BFkdjbzXgpaYEnjZj8U4VKlrcYdUak+iNCYTqNe4dGyhToL2l18IGVz5k/KKuygkkowGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2xZMVIrWDUxclNIL3pKdy9kWXVYamw2ZlBmKy8wWFJBOGVpa1F4bmNzaE4x?=
 =?utf-8?B?WlU2RkZHQ0Voa0pkWjk2cVdsQVVxa0liNlFqdnFpMlVEaFA4RHpOYkZxTytW?=
 =?utf-8?B?VU03VlNlWEE3ZkNRTGxnekdjT3NxSzE2bE44aG5GUSsycUNZZVA2dGlaKzhk?=
 =?utf-8?B?ZE1rQXQzWUpPZ3M4bk95R1FMRS93N3l3TGtoa2l1K3F5YWpoK0xBTWxQNzNT?=
 =?utf-8?B?TkF0WlBmdldiOWJLeFI1R0FkUEo1dnd2bW5xYndObHYyK2UxZ0NwWGdqQjND?=
 =?utf-8?B?RENIeEJRVjlzNW9LWGFqeGNtZFRrY01qSm1MUUR3K0gyWUptb01kb2dhZG5X?=
 =?utf-8?B?UFVVaXh6RW5YYy8vMjBROUI2ZjZDVXB5dG5NOEtrRUR1WDkwZnFSaHZjeGwx?=
 =?utf-8?B?ZjFuUUt1YmRRaWx1QUk5cTh0eHpEa2hhU3R2czB2RmczU1k5MHlDUWRpT3NV?=
 =?utf-8?B?NUF1STM1YTE4eEdSdE9lb2xDUlFTclBCbFpKZkVGZlN4Y0xCTkdKN3VUdkZT?=
 =?utf-8?B?Z3MzYUJLWFdLV1lLVGZUZEVNTmtDZHVHcXFpRDBCei9pRk44T2hpQVh5WG4z?=
 =?utf-8?B?UStyL2gwelF5OXhxUStwdWhCVEFRNEZZMENDTDBhUm1nc1BGMWpGZHdjbUZr?=
 =?utf-8?B?bHB2WFE5UWd5Q0N0UzlTT3c1SmdIR28zRmFDSVRuNUJRVnNzNG0ySm55SERq?=
 =?utf-8?B?QUVIRDUzRVBpSlNGVFQzeFdZWGp4dWJMOEdZNUM3YTFkZkdsQ3FPTnhadHRS?=
 =?utf-8?B?ZzJrcERKMkJNV01ZQlpGRGtpeWYyVnBuRUZ0KzhRc0FjREwwWHFTbnBtN0ZY?=
 =?utf-8?B?QWZEZGxlY01HNWlTbi9nWTdzSDBUOXdJNkVrRndOaEhFTnI0cy9DMmltY2x4?=
 =?utf-8?B?cDJ6R3lnb2RpMUdCQnRPUHFsRktudjFBdXRRc2N1aElNYWZpY05JRDYwNWNj?=
 =?utf-8?B?cW5OVjdqQ0Ryc0lHU21vcHhuSFFqN0dRNGdJaW95VndFZEpvZDVCQ3NROHJT?=
 =?utf-8?B?U2k0bkNYTjZGQlBxaHBUSy9ISys0eWVlUWtmOXVwZ0IyQjNEVHhzWjdSSWxH?=
 =?utf-8?B?eGhSbFlNUXpDWDF2MkNEVzJlWWxJUlhSZHBDVDUraURSeklBb09GUHB2ODNj?=
 =?utf-8?B?M0NYMUp3MXhWRE5ueXlmNUdDN0MvRG43UVRvR3pWY3JLa3h5dzNrTFhnS0Js?=
 =?utf-8?B?Q1JZT2RxTjNuU0hxRzl4NlZGYUZKdXJkVlhNSWdsTUQwTTFaOXNtZmppQjBy?=
 =?utf-8?B?TnBmZVFhZTVvcGl2VHNpUlNJY0RHZ2Y0OG5JWktad1paMWtVNit4Y3pURDJ3?=
 =?utf-8?B?R0g1L3pNdFJPWEkwTG9wREN1Q1pkWkJFSU13dDcvMTVadk1Cem1ONHhoY2pX?=
 =?utf-8?B?cHhPMzBxaDhNV1BZdDBaU0hYcG5MVkVmdU5QQ1ZFaHV1NHlrSzRKMDc1NUdM?=
 =?utf-8?B?ejU0d1E1ajN4SWlIOEl0M3U2aWhRM1crbHZwNlp3R3VQRmFNdXozOHFFNldX?=
 =?utf-8?B?OVNSL3gzRnF5bWplaWNVbE9reFhkT1I1OG4zZnZBTzFaM0NJUGFkUWZCbFBR?=
 =?utf-8?B?dis2dmhzdVQ3ZjBIQ1BjVHFmL0E2R2FvNVBvd05vSzhaWVlaSUZuaTNqbWcr?=
 =?utf-8?B?Nmd6VmdRZW5NWG02RFpBVy9IekJuQVFsMmxNUXUrYVJMVzErNHRFcEE3a0FT?=
 =?utf-8?B?dnF6WmtWYVhGZGxUNitYYi9WaVhabHdLMjhwZmF3eW5XbnRlTkhPeWVTWE91?=
 =?utf-8?B?Z0JGemJsaFhQbkZ5cWNMQWNiRVMwLzM2OWxvVmtWZXVqMk5nSzZhWFRnMEFT?=
 =?utf-8?B?aU9qVXRHblNLTXAyNFhOcUYxYURMMjVqL2V2OE5raUxiMDNEUWhpWjFOdEU1?=
 =?utf-8?B?OEhqQlJpUWtRTmsyOTlCQVc3QitUOFhKbTZncTBpWE9jcytUakdTQkhFNG9R?=
 =?utf-8?B?a2tJdG5UTEw2bW5XaG1ITXd5cFh3TXYycVRjdU52U0RMNjRrTG5mUDRFamVv?=
 =?utf-8?B?K3dORGI5SitrYVpCRTlhQjYxNElhZVZQQTA4WHBxa0ZMZzVvMTNzTkYzQzQx?=
 =?utf-8?B?TUZLRGZuanV1c2VQd3k1Q0pPelN0TnZuQ2hXLzg3YlBIU1Q4NzRsZG0rVDR4?=
 =?utf-8?B?YVJKWlBDNnVIeHVtN2phZm9DMFQvRGJYRm9PQTN6bXhlVFpqM0psOVAvdVVx?=
 =?utf-8?B?bUx3QUMwMWd6SzM1dTYvekxubi9VMFZDVk0zbzZaUkFVK3BVaEdXTmQ3cVo0?=
 =?utf-8?B?R2dwUWtSdUZoajdMR3Z6Q0RLV0dUc01RUFdZbFBxbVpZa0pGZ0JWYXhTbjhv?=
 =?utf-8?B?VGp5aHZzNTNLS09zNnFBR2Jjd0pUV3p3Y2Z6cDdiSVh5Wk1BN1hwN3pZVy9k?=
 =?utf-8?Q?27Ul17cdT4s5xhl9lIyd8bVvG6dlhb9dog9r7q/8wicEQ?=
X-MS-Exchange-AntiSpam-MessageData-1: gj/U6HUdkdHxKw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc6d62c-a5c0-4200-95b5-08de8a18bd8a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:46:39.8342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeMOQSqsI+F+BIjFWi/inDM45Cwk6HrgzvMApOvvSeCwlA1r6xA8Qr8w6yj/zMAPgN8GDWdLorIb6yhbe8htxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7448
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

Introduce a powered-up version of our ad-hoc `impl_from_enum_to_u8`
macro that allows the definition of an enum type associated to a
`Bounded` of a given width, and provides the `From` and `TryFrom`
implementations required to use that enum as a register field member.

This allows us to generate the required conversion implementations for
using the kernel register macro and skip some tedious boilerplate.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/nova_core.rs |  1 +
 drivers/gpu/nova-core/num.rs       | 80 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index ccd14b757b49..98675c69d2b7 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -21,6 +21,7 @@
 mod gfw;
 mod gpu;
 mod gsp;
+#[macro_use]
 mod num;
 mod regs;
 mod sbuffer;
diff --git a/drivers/gpu/nova-core/num.rs b/drivers/gpu/nova-core/num.rs
index c952a834e662..6c824b8d7b97 100644
--- a/drivers/gpu/nova-core/num.rs
+++ b/drivers/gpu/nova-core/num.rs
@@ -215,3 +215,83 @@ pub(crate) const fn [<$from _into_ $into>]<const N: $from>() -> $into {
 impl_const_into!(u64 => { u8, u16, u32 });
 impl_const_into!(u32 => { u8, u16 });
 impl_const_into!(u16 => { u8 });
+
+/// Creates an enum type associated to a [`Bounded`](kernel::num::Bounded), with a [`From`]
+/// conversion to the associated `Bounded` and either a [`TryFrom`] or `From` conversion from the
+/// associated `Bounded`.
+// TODO[FPRI]: This is a temporary solution to be replaced with the corresponding derive macros
+// once they land.
+#[macro_export]
+macro_rules! bounded_enum {
+    (
+        $(#[$enum_meta:meta])*
+        $vis:vis enum $enum_type:ident with $from_impl:ident<Bounded<$width:ty, $length:literal>> {
+            $( $(#[doc = $variant_doc:expr])* $variant:ident = $value:expr),* $(,)*
+        }
+    ) => {
+        $(#[$enum_meta])*
+        $vis enum $enum_type {
+            $(
+                $(#[doc = $variant_doc])*
+                $variant = $value
+            ),*
+        }
+
+        impl core::convert::From<$enum_type> for kernel::num::Bounded<$width, $length> {
+            fn from(value: $enum_type) -> Self {
+                match value {
+                    $($enum_type::$variant =>
+                        kernel::num::Bounded::<$width, _>::new::<{ $value }>()),*
+                }
+            }
+        }
+
+        bounded_enum!(@impl_from $enum_type with $from_impl<Bounded<$width, $length>> {
+            $($variant = $value),*
+        });
+    };
+
+    // `TryFrom` implementation from associated `Bounded` to enum type.
+    (@impl_from $enum_type:ident with TryFrom<Bounded<$width:ty, $length:literal>> {
+        $($variant:ident = $value:expr),* $(,)*
+    }) => {
+        impl core::convert::TryFrom<kernel::num::Bounded<$width, $length>> for $enum_type {
+            type Error = kernel::error::Error;
+
+            fn try_from(
+                value: kernel::num::Bounded<$width, $length>
+            ) -> kernel::error::Result<Self> {
+                match value.get() {
+                    $(
+                        $value => Ok($enum_type::$variant),
+                    )*
+                    _ => Err(kernel::error::code::EINVAL),
+                }
+            }
+        }
+    };
+
+    // `From` implementation from associated `Bounded` to enum type. Triggers a build-time error if
+    // all possible values of the `Bounded` are not covered by the enum type.
+    (@impl_from $enum_type:ident with From<Bounded<$width:ty, $length:literal>> {
+        $($variant:ident = $value:expr),* $(,)*
+    }) => {
+        impl core::convert::From<kernel::num::Bounded<$width, $length>> for $enum_type {
+            fn from(value: kernel::num::Bounded<$width, $length>) -> Self {
+                const MAX: $width = 1 << $length;
+
+                // Makes the compiler optimizer aware of the possible range of values.
+                let value = value.get() & ((1 << $length) - 1);
+                match value {
+                    $(
+                        $value => $enum_type::$variant,
+                    )*
+                    // PANIC: we cannot reach this arm as all possible variants are handled by the
+                    // match arms above. It is here to make the compiler complain if `$enum_type`
+                    // does not cover all values of the `0..MAX` range.
+                    MAX.. => unreachable!(),
+                }
+            }
+        }
+    }
+}

-- 
2.53.0

