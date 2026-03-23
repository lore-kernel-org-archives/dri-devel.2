Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42706EC01C9
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F78B10E3E2;
	Mon, 23 Mar 2026 11:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iveWuQhR";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0D7D10E444
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 11:08:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhPnTQVVpW6Qw+emSkX81lgFGHnbcs/yr7r6R84zqmtojQ6vOG2oKZVtIDaGENWC4RxyyJIDesZY1h9XjPA1KryfMn02jlD4ljrFeXyAUt/IRFp/718O2GCPAZoZO6Dv6Qq46h4L3BCmgMEkXQEm8E24ffdF0ToU1gSr0tL2VkRMN96YOB3uZePzI95VqddJhWC/PUYKpOnHnEBPCLDprzIKnTCNOtay48NHY4TcipUdsC7C5Qb94H672gO6AJVtdMc3paZMTigMwlu0aO4LvQDdDzI7TbdeBc41D2WkjfqFr7fy+9aE6FpmCSa4Y+zuWqdHyclSHYGf8WiACjyOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaSIr2nT1OeLfpctS0/hOfTUQ1AYTjWXBNbumI6w+LU=;
 b=nalW8XThi0E3QxxWVxyC6IL3KZGscL4CMuOszC/jlSjjQseI3NRD1nBbIunCBRYQNIZGRXFr6bW5XQaOB5gv4ZSImoveWKxec0FyDb/N3EAlA5yfDmub8OMsavjqJVgyzwtsbNKJoG1PfTJqQobgGJ7koN4D5UNsJD/kKqom+Q8Ws0iNwNx/ATpLk+XOxsV8OPMwFNVZr5vbYWDp6H9kuFc/xTh6AlIt9mUHkLgZWGn17Z+s+/cL/4WKTER1kKNqtLXM/hnyZVhACZ2Cd/6p/YWH4+mL+34cxHiBmikgsysMYQwOhMtLRAmAS2fLIL8quwFamzycPJOmXqkWQMP4Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaSIr2nT1OeLfpctS0/hOfTUQ1AYTjWXBNbumI6w+LU=;
 b=iveWuQhRLBCBDTCb4JOIYM/donZLU1DEmWt1dG4+nuB+Fp+A3drYUDgLIZGSN3pNdYcKQ2bUF8zQ1MS+AT2cXDLhXX97Sw8ksqhj4xs9TDYd5KMkv+KcCMa32i8VSxzDW70wvIcjEVDfSD4ukzOJKunLte5cehdMUTO9QyRdWY3dofOUnzbfuAnzZ80fdjgZWSQrkXB8RpP/9+8zsa8YZ22MuMv7byQtZFtPnefiEkw/eotKA4ItMbn5J0yBvoR1iKFGL/qg2CbDKLEeJk3EL1jFPV2QI483pbJeZMQTW3pEmvF7qiuiMPBkkKvGxN0HdAb2n6gHu3T8Jh2NjIOA5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 11:08:14 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 11:08:14 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 23 Mar 2026 20:07:42 +0900
Subject: [PATCH v3 07/10] gpu: nova-core: falcon: introduce `bounded_enum`
 macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-nova-register-v3-7-ae2486ecef1b@nvidia.com>
References: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
In-Reply-To: <20260323-b4-nova-register-v3-0-ae2486ecef1b@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: a502bda3-fbc8-49fd-45b4-08de88cc7a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|1800799024|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 3YpgT8KJvgx9cd5eyKmBBJWM1JuGXxQG4kogbYPaPEhTys2Baonw1YMrGoIRU1lEVdNnIv+DwZKjVHlleC/64KP/UcyAvyOAl2vLK8LghbO/BGuEqlCqisKs5n5HfrSgfzV3QOLnQwHspk4AyvARtw2pYRdLNoJNRgnQCHZtW5whEojClwaQJBfrSAzvumIf/6i3TzWdz5cGyRPNNKCGVMz6zyTan9cYCe6fPKCBemPKX1Caf3cd4Yy7a5fOdfJzpVeJ5BU4lsYakf37EWmkJ/Zb/5SwXjRumr0uf8Ju4dassyj5jefh9pVN+YM2yBTtIeZg5ZqUdYH328dEqrgY85A6aVO/AK19nBAJaimEHL0QLZFtKWR9KD0Zo8B5okahuN+IVyA0BfBIRjXmevQGwstX0Jnzvqo0LLTKljlv40rSBTBj567iAy1eQyCfy45EcYob+aXUL2wlVA3qVZhCUpETmSm0XOKl6vHZxb02bLOQy+nhoBFdb8MnaIK5KpE4P7agC4Ji7yYUYAgtMBfBpaMCdqgHv7r46Cz9kSKX772RAANKCGSzhejyqfW6uWihVJib89IEX0GxpuGndkeDKxTDuReLX5N5LheOU5s19UZrim8QcIaCvwZTN9jMGt7+seB4VanzWBeNkVNPdtFScfDbG9qGqHvRSs1TEZt9zHu7m+PIwHSoHyuge2nLg0WriDDzOIUYEWz0yeMV0cPQBUip15kLSVrSUxJDcONMb+CODNTL+ItJw6PulwXU9uyD/xDx2eN+UG8coJdh4AFjvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU1RRmJla1QyeENPNjVxMXN4MHJqUjdHbkZBL0FTZ3RyZVhGTnVDU2JXdkNU?=
 =?utf-8?B?WXdpK0RrS3JJTDBnTTRnTnNkWmZEWnkxNmRNVmNKVWpzeGNjaG1vUUtub0h4?=
 =?utf-8?B?d2dRcDk3M01sVkRYOHJhTWF6V1Y4RVVjMGpTY0N1bjl3b2VrQldjT3MrMjVN?=
 =?utf-8?B?SHVsdmgyc3lnZVNEMGJJVDJsUmIrekNDQ0Jhb3FpSlFsbWh5T21CZEdCQjRN?=
 =?utf-8?B?RzJhZ2RZTHYxWUVBUzBTT01lb1grUjZLNFpVVmlZQUZHUklwU1JVeHhtWGNs?=
 =?utf-8?B?Zm9pVHN3TUlWUVU4Zjg3MDhjRnI4M1hwZTdxcy9lRVVmcHYyT3lwcDhUaWxO?=
 =?utf-8?B?czFMUkZpUHl3SkhiM1pBSDdFY1JSSGZBSmN3VEp5bWUvaEg5b2Z0NFNjaWZO?=
 =?utf-8?B?Y3dMUnZEYWxuN2ptb2d4eTFqWm5TSkJUekNXWW1acGU1MmJOMUo5MDdRc1VU?=
 =?utf-8?B?ajN0c202VGkvVVgrWGg1K2oySTc2Unl0VUt0dzJrcnBMM0VsVFI2enNtamJi?=
 =?utf-8?B?dkpzMmh1ckt0ZHdIczhYWDJPQmUxOEV4cFhHSktsbU9qU2NUUTcyVXFSZEc0?=
 =?utf-8?B?UnBQRENlYUplMWJJUkJ1T0dpZ01yWW1RVFhXVkk2aGZnR1JNL3NERkFVaDUw?=
 =?utf-8?B?dm9vUUJGQ25hK2dYa2FCSHRhWHVGRGE3RTQ3V3lPL0tnb1oxdFFERC91YWVx?=
 =?utf-8?B?OGx0aE93dzMyU05Ec1FYbHpOQS82dytZZ0l6WWNoZEEwVUVZRzY0bzN0NEVY?=
 =?utf-8?B?Mi9ITHl5WG8yOEJQSEw0aGxPa3l6UDNQWEFhdmh0dFNqVkxWdzBnT3BpZkJ6?=
 =?utf-8?B?TWNuSFZ5ZC9KU0x2TkFpVXlZeFkyMDRrYmJzOVR5T2RMdzJ6U0pKZ3RKNEd1?=
 =?utf-8?B?N1Flb0kvRStGZW9pV0kybUFxY1lqQkQyQ1pBWFcrc0h2aTRJUTdXRFFXdEV1?=
 =?utf-8?B?dmpxUnRrTWxQd21rcEtpZkFRTzFVZExMYitPWENhVXdWcFZXK1h3NmJzUjdE?=
 =?utf-8?B?MkRLZG5CZkdVbGlxUVU4bG5Cb3lPR0J5akp6K1FzMWpqQi9CdXVybUJYVVpZ?=
 =?utf-8?B?N0NCbitFZEtsa2I3QjBxUGFuQkFEQXdERjhyNnBEdUVhQlhIN053MHVyR25o?=
 =?utf-8?B?WWR4anNkTW9tMzRsSDM2M1JvMG5lVkhIOStEQmVtazNrc1gwRXMyTEhMYng0?=
 =?utf-8?B?b1YzZWdwcVYycVg0OEMrK21WMVl2Q1dxZmZ2SGhaWFZyMnl1SW03Qjc5NUw2?=
 =?utf-8?B?cVRFY0F6ZlJsd3Q4Q0hzTjFmbUVSamtJQWhiZ1RkMDhyYlA2bHI2RW1FbHNQ?=
 =?utf-8?B?TVk2cW1HK1QwLzZSSmd3MjVmRnI4N0tmQnNkRkhLT09NeVYxRUNWLzkraE5Y?=
 =?utf-8?B?aStkaS9xcEEwVk1qVytUdmc3M0pHWTlrL3FwZ09iQ24rSmtmd1ZwSUlJVVNn?=
 =?utf-8?B?aTNSL09YTkhzSVVrOGtzNkhCZkIzK3pvMEVaT3lSSHh0T1loRm94bWl3Rkwz?=
 =?utf-8?B?eWl2YlBEU1BLT3VZc3E4Zll2UXYvSlE3K0U4bGtCcVRHdXVXd1BHK1VoLzE1?=
 =?utf-8?B?ZzM5c3JTcWprdyswVnVGYkRuYWRHWkNlQVVJaEpPNVlDZmVsMWdXSm1MMDN5?=
 =?utf-8?B?VTU3Q0JTZmp6WUFxc3BnWDV0VFhkallDN0QzYXZGbEhxRys1Z2JBbzdiSVNo?=
 =?utf-8?B?TVVWNWsrKzJwc1VqQWt6OTdGMVV1ekl1cGRiTUJtcTk5SmwxcXRFL0lBTVIx?=
 =?utf-8?B?ZHVHeXNKVkJmRUZGcjZLcFVoZW5JSStVelpmUXBjUkRDRUN0K3ZxVzNvSXN3?=
 =?utf-8?B?ZXpHZ0Jabkl5L1dUbnFLRDl6K3l2ZHZtU0hPK01CWVFyS2hBMlJOdkZvUDQ2?=
 =?utf-8?B?NHVNK0pKWXVkZ2gybGhsb3FUTDJXSzI0SHNaaXJ3SDZTeEduMmROK3hzOTJv?=
 =?utf-8?B?dFgvcHowWXNxam5RTDRDUmpaTG5nN2xZV2F1TTViU1lBNDBySFMxR3p0cmlR?=
 =?utf-8?B?Mm81NTdvVTJIYUVHNUswNy9MUjRjNWdaaEtjNHU1d3FycmpjN1JWb1RzYnF6?=
 =?utf-8?B?TmVmQjUwMS8rSWhwaW54dGFucWsxNGsvMkRkazhMUVk4b0p6T0I4aGFrR0xw?=
 =?utf-8?B?TXVldWlidzNiUk4rNS9NVUVlTDhQUk5kOUcvNitOMzFMNzczQzlkN3BEQ0dK?=
 =?utf-8?B?dWppNE4yOGY1THJjRitFcVd2UzdFOWVxMHBRQUZoWXdoK1lSalQ5V2VwWm1k?=
 =?utf-8?B?dWxwd1NFMFh3SHAwSUlkNjJjN0krUEZjWDFSRzVoUkVoWWUvdUcvYzhEajll?=
 =?utf-8?B?ZDMrQlE3NlZEV3o3bnB2TGJuOFRubkw0dEwrVXQ3OEJ1QTUrWkdnN0ZoODE4?=
 =?utf-8?Q?TmOBH2M9J7Lm3oxb4ttKcUuKDZWhP1kT3Pgv30Livqi9k?=
X-MS-Exchange-AntiSpam-MessageData-1: HlNt8c5PgKb8OQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a502bda3-fbc8-49fd-45b4-08de88cc7a37
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:08:13.9433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymBpcVvZKD778iIhxRoPaEli5AmxIKwIOTpqp1ouzgqu6p/iKcvJDOjc0pfyLyG41ga7vIhB7fRzTpq/JoGrmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458
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

Reviewed-by: Gary Guo <gary@garyguo.net>
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

