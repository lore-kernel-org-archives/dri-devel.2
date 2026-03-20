Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BC4108B912
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A18A10E4B1;
	Fri, 20 Mar 2026 12:20:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DO9wmaUq";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AB1910E4B1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKaaO1Q8KnJ05mHKkkUTEMoH4ZGaOWcT6RXn/W0yO8AxyvSxZs0zhXLlWvvyb6lTdxlvqRwbSPuCH+dXTvxLU7YTYeTUT1ehOKSEp2JbggKeO4UCdrYSe2lM7PJlzJWlBuDFS5rY+EpHhDG+VshZCCbtzr4VLAvAPOWDVZlmMMndM0OtZgWU+mVVVz3AtKb/XF309IWRG4e2+B7HsW3txOhdWs+YIMD/9P9vqrULQER3/RlEWCgf7Ti7R82inlHB/FGAs9LPBUV2MXflPwn/39XVQPgAUS13Lqctx1n3AEIHl6mI+VdwFrp5A4WQIiUaMNlmxO+RLX7L4/7kiZuCiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTUpNz9Wo6WLn/X/gFf9lJEjVCTMApAELVlqrQH1nlc=;
 b=uXIWTWBUlmc6mlJ+qNCW2cKtYjPTEXayYe/mAaYdKCnqbFQ9o+x2kqBCq6CIX/UDhp3Ickdx5Hs5+1IZXghtrjmb6Rbp3py2W8xLw1xF4PNEz3cdDrp09Gdo1GTRrzUDicm6Y8A5ZhvbUTLtWe9YK8WtRZnJdOFMW4H6zv5JIxQvv4pMLO+54opuQqITQjsbgdO5C5Hs3RZorIrisbJ++v1nDh+YZe0OFD605QM2VFe5IEi20c+N7idi6P6KgcQVZdLbsmSWqOBiaaD3UPge3wUcGytX5rue89jh2Rjdd2YSCmOAHqMyjEI6Es7IAC81JmsDA9zLNqM7T2hjhWUj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTUpNz9Wo6WLn/X/gFf9lJEjVCTMApAELVlqrQH1nlc=;
 b=DO9wmaUqVxK09FDFONOIfvpWVf98Zg7lQwp+GcnUGH0rlr/t1QhLMN5M0IR8cu5CfuM0wngt8NaO8meG93mR+Z5DGf0MP2Wtp2fAeU0hYCCLOaAg645GtrIFH3qkvbGGs2+XZQTUHfoEhSkIyO4sg5YefecOMYFvCBAAauUbmOy8uQlK3d47O1ycf7ZBKSGA8vWApj32gR61+XK/nqrf3/Qfu3VX64cnv8oebHVb9GttYYckwHrg16AjsWn/+tygshfZrI8tq+mP9/yY2ug/ZpJP74mqOxAN7Ebjli5tArU8nXnySDW+nqugpToPbBdLnWKXRLHZTs1FTbAX2xLNAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 12:20:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 12:20:24 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 20 Mar 2026 21:19:56 +0900
Subject: [PATCH v2 07/10] gpu: nova-core: falcon: introduce `bounded_enum`
 macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-nova-register-v2-7-88fcf103e8d4@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0122.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 54946cd8-0a26-4012-bdd8-08de867b1014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: /qpPO/+UC1wJHpdd/P5acuTdo65exk87yN/S+D0N+wONuin3+zny1/frDJME1NpfnspDt6VDvCCvK1VJ9S0mOdta3gCaC9ntGsJNOFW2i9kan0L57gQcj1gT+uc946A9gsEb6rdKY8yYE2NbFzUosAxbRM3Lxaal0QWh1J+zhunaNBxZpHxjBWj2fnbtyK21+nHEquV0Vig3+HBjClnk0xvoOywJjWUzJaKG+vAqU9+C1USuopAeRUUpSTmXm4b6LyV6qzQkTqhsFXCmV2XkVbgZBZwe05tGvzZio3uMwEbEdjzn8pStlcVe7KN0N/upbAqNoZt5xM3+vdKPqEutu5/tu22iVyW2PuTdDMuy8g+XcVZgEArCn0xJ1YXaDH1Ey1WeEY7gEjkYLYwPScnxwcE5iYCeZmiJRK2/2PhGeLiSyz5kmMbO4Fd4QewgQF/Eln8mVZduL7R2DmT7kDvA9O06d2Yu5AEDQaYNoRc6tsFQMeQtyj1a3hlxhg0evCUMFWJDWApJ2mueRGZD0mkPULlGUtyEDVCiXVJZB6i5MW1OtbwVrB3pnrAHpsoSL2cYyYThox0vd+SOjaTOkMu2VhpEEBLR/Eb0LGOp+pmzFF/3eYRv79jlVvcKxHixH16Euxd0DS59a4rjFlJrFjS7usc9IofiGGzhOF/Sr5MwNGlmG82TmHOXcW2U5Cz6qbUL7sV+kM5+WOVZJ41KSId+GL9ab6zlzpvJxOore7PQHr4wIL2AVjl8oVDKvUFXbVlv24XSXbs1yJ41c9V+ff7y4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk5HUE45WWhWT1BOdVFaUzVSTythNHUveDNpUDVPZy9DSnNkdGhoUGNTczRx?=
 =?utf-8?B?aG0vNmROWDdkb2hVckZFeUs1Q0oxUFZQSmkyN0V4aGN4N1hQejFCa0ZMMVA5?=
 =?utf-8?B?N0hFMU5GL3oxTlBVTW5ZdSt0aFo5TEM0aDYyMHU5NzZsUDRvYkRsWitQMnZx?=
 =?utf-8?B?NWpMS3drWUxITk1RdVJLSHRvYVU5dVZ3M3k4dGJkbDc4cE42YWhRUkozaTBK?=
 =?utf-8?B?VHBsdGlZUlhKSFBKdnc4RWMyU3NQbitINmN3eW1MdnFaa2tIcDIzSG8rTFEx?=
 =?utf-8?B?bEFZNmJPQXdZS3ZYbzZFNzBMZEp4cEc1c0w1Nm5WVHI2VXZkNlhHY1FMaE56?=
 =?utf-8?B?UllocGhDSU5lZTVJL1lXcHM1YTNGTEQrTk12cTdGQU16OGVpcGUwRFpncTJ6?=
 =?utf-8?B?aHA2NG80c3I1SVVqais5UW9vclM3T0dDMzlCQmIvcVdrTCs3UTFGQXgrQ0d6?=
 =?utf-8?B?ZVVKRy9xSVVqVk9nS1AwbHBKQUwrak55Y1RiVUlxZW5lUGJrTVNkeG5aRmVt?=
 =?utf-8?B?c3NPMUZETDl5MFVQUWZwQnZLam9qUE56czlJTTZhUDVMZmVRdEtaZFcvMVJh?=
 =?utf-8?B?cGpXbUpmRjZzWVBZK0s2aHpNdHlsejROU05yV3FlQ25xN2tzdlkvaHRQYjk4?=
 =?utf-8?B?eUNJK08zd2JKaG95L3dPZ0wzSTVTYXo3ZThOUmZDQlNBV3FnL3BrL3pYZHFu?=
 =?utf-8?B?WU5LT0M1TnBoT25sWHB0dFRaN3ZMSVBubDBhRXQvVG42cmQva29LZWlmSEpa?=
 =?utf-8?B?c1VKaFlSSWsweTJKOGY5L1U5VDh1Z0RuZ2FhNGNoU0ZSTzFaZHh0ZzF2RVFD?=
 =?utf-8?B?M3VXdGlmWUFyWE00U0lUNDR3VFcycmt3ZEF3elB0TUF3MW41ckVWWEJHM0Z2?=
 =?utf-8?B?R2VkbHFuaHZOYi9Ec1FpbStSL2hnTGJlRC84Smo2eXFjQlZnaXo5THZ1NmdI?=
 =?utf-8?B?aTNYdkQ1MHlIcVVESjNHL0JtV3J4dVlVS2pXWG5PWURwS1hQT1JqZjdqSExl?=
 =?utf-8?B?UTRkY0I0MUJPZlZnbGIrVnRiZlN3V2ZOd010Zlo1N0kvUmNjVHpMb1M0TktS?=
 =?utf-8?B?SklTREE5dndRWlB6SlpialRrQk5XVDRPOVBIOVR1ZUcvZDFaVkh6TmhVYWpL?=
 =?utf-8?B?bzhyUHNvSDBURm9INlU5bVlIc3IzYTVQTXlWV09ia0pUQkt2MFBpZFp4MkZk?=
 =?utf-8?B?dHJCZFhtemorbWwyWGFKOWtZS3ZFTjg1dGtDY1ptSkYwbGkxckZ4ZUlSa25z?=
 =?utf-8?B?TEMzekZVekdNUVN3ejdOT2VFUUp2U0FMVitqMVgyc3FoYlk3bEY0QXozTnVV?=
 =?utf-8?B?SkxFQ0NYL0tkNVZjU3lieDhkWWkwUEtqZnViUUV6Q1R5RXpBOWNpd3g2REk1?=
 =?utf-8?B?UW9tZkFxeSt5bUoxZ1B6ZlFLNkFzanNqV0paOW5XdDRrU1I5bG5sVGNqVVhv?=
 =?utf-8?B?RVduTk0yL21McmI1ZVl5Qy9rOHl4QUVBUjF2T1B2UkUxbFhjR08vSDc1OXBF?=
 =?utf-8?B?TGFGVm9pSks4dTJHTEFrYlpBQjBLbTArMjEweGw3QUxkdlpheE9VdlBTaFk1?=
 =?utf-8?B?RGVRVWovbE1XdmVqZTUyMHEzU3pGSVV6UXpqOVFYWXpxT3MybTU0eXJJL3ZK?=
 =?utf-8?B?ekNsRDdKakUwRGlxV1EwVmdiVmV2MWZWa0FWRGkyVWVoUVljc3VHUlhISXVB?=
 =?utf-8?B?Mk8ySVpNM2xhYWdCTS9hS3h6OEE4TXIrNE0vcXJlc0dTdTYySzZSeExKTVJE?=
 =?utf-8?B?NWZtdFlUZ1I2TmpsS3pocXkyRjhXOVNLdFFPUUJBY25pZnNOR3Bsa0lqTG0r?=
 =?utf-8?B?NjZRWExUUGNJQ3BiZEwxaG9WOUJ6bkIxQmZZUU9QUVRPZUR1SUIzSkp1V2tm?=
 =?utf-8?B?SGZtenFXdHJDOEJpeHhGRUZzaCtQTk9ZRlVsUGs0WWRsSng2Qmt1aGJiKy9l?=
 =?utf-8?B?a0ZjM1NWcGtkc2k3SGsrdkxFS0owUllUSjNrckV1YnlqWGZFZGNUQVoydVVp?=
 =?utf-8?B?eHRZclhaTDhYT1o5YlowQzBiVGI1cHY1dUlEaitTL2UzdUo1VjgyQmFWdk02?=
 =?utf-8?B?L09HRWUwOFZ2T0xGaVVYUVMwMEFqcmhOalV4MmhEc01nSDh0SlJ0M0sycjdQ?=
 =?utf-8?B?TFd3anVvaVhOZS8vcWg3a1VWWDVMeWdaWnNlSytMOUVUSDcrVEUwRVptTThR?=
 =?utf-8?B?ZUQyNWJacFVmZ0c4cWhJeFVacGlGR1Y0cVhFUGJBdGJOMEdpcDI5eG5Ca25U?=
 =?utf-8?B?QXhSLy9iNkh5cUJncUlYRDBkRGpCS0pnUFFmSU8xVWs0bFBkeU40MFhpUTBE?=
 =?utf-8?B?QlJERHVjRkpzYXlCSXZJSEJmQk5HekEwZkFJeXF2aVNtMTdZdHhwSEZkR3FR?=
 =?utf-8?Q?6ZImTvsupOKtdtVGOy+eOHF/F6cYC830PjSxlcK1Bz+9y?=
X-MS-Exchange-AntiSpam-MessageData-1: Z5Fm5l2jJCokCw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54946cd8-0a26-4012-bdd8-08de867b1014
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 12:20:24.3435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cg9KNuPyscXF7/GgigAkQ5VAJKTmVD8exyjKgdBkxN/p6ONedSgR64clCzpvN6Q3q/NngxjpuvgWI7fIMfNOJA==
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

Introduce a powered-up version of our ad-hoc `impl_from_enum_to_u8`
macro that allows the definition of an enum type associated to a
`Bounded` of a given width, and provides the `From` and `TryFrom`
implementations required to use that enum as a register field member.

The next patch will make use of it to convert all falcon registers to
the kernel register macro.

The macro is unused in this patch: it is introduced ahead-of-time to
avoid diff mingling in the next patch that would make it difficult to
review.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs | 82 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 5a4f7fc85160..5221e4476f90 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -54,6 +54,88 @@ fn from(value: $enum_type) -> Self {
     };
 }
 
+/// Creates an enum type associated to a `Bounded`, with a `From` conversion to the associated
+/// `Bounded` and either a `TryFrom` or `From` converting from the associated `Bounded`.
+// TODO[FPRI]: This is a temporary solution to be replaced with the corresponding derive macros
+// once they land.
+#[expect(unused)]
+macro_rules! bounded_enum {
+    (
+        $(#[doc = $enum_doc:expr])*
+        enum $enum_type:ident with $from_impl:ident<Bounded<$width:ty, $length:literal>> {
+            $( $(#[doc = $variant_doc:expr])* $variant:ident = $value:expr),* $(,)*
+        }
+    ) => {
+        $(#[doc = $enum_doc])*
+        #[derive(Debug, Copy, Clone, PartialEq, Eq, PartialOrd, Ord)]
+        pub(crate) enum $enum_type {
+            $(
+                $(#[doc = $variant_doc])*
+                $variant = $value
+            ),*
+        }
+
+        impl From<$enum_type> for Bounded<$width, $length> {
+            fn from(value: $enum_type) -> Self {
+                match value {
+                    $($enum_type::$variant => Bounded::<$width, _>::new::<$value>()),*
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
+        impl TryFrom<Bounded<$width, $length>> for $enum_type {
+            type Error = Error;
+
+            fn try_from(value: Bounded<$width, $length>) -> Result<Self> {
+                match value.get() {
+                    $(
+                        $value => Ok($enum_type::$variant),
+                    )*
+                    _ => Err(EINVAL),
+                }
+            }
+        }
+    };
+
+    // `From` implementation from associated `Bounded` to enum type. Triggers a `build_error` if
+    // all possible values of the `Bounded` are not covered by the enum type.
+    (@impl_from $enum_type:ident with From<Bounded<$width:ty, $length:literal>> {
+        $($variant:ident = $value:expr),* $(,)*
+    }) => {
+        impl From<Bounded<$width, $length>> for $enum_type {
+            fn from(value: Bounded<$width, $length>) -> Self {
+                $(
+                    // Ensure all enum values fit into the `Bounded` type.
+                    const { assert!(
+                        $value < (1 << $length),
+                        "Enum variant doesn't fit into assigned `Bounded` type."
+                    ); }
+                )*
+
+                // Makes the compiler optimizer aware of the possible range of values.
+                let value = value.get() & ((1 << $length) - 1);
+                match value {
+                    $(
+                        $value => $enum_type::$variant,
+                    )*
+                    // We land here if the match didn't cover all possible values for the
+                    // `Bounded`.
+                    _ => build_error!("Enum doesn't cover all values of the `Bounded` type."),
+                }
+            }
+        }
+    }
+}
+
 /// Revision number of a falcon core, used in the [`crate::regs::NV_PFALCON_FALCON_HWCFG1`]
 /// register.
 #[repr(u8)]

-- 
2.53.0

