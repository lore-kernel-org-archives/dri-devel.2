Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A7CCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 14:18:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B360A113A59;
	Tue,  2 Jun 2026 14:18:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="F/WGxHPP";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020076.outbound.protection.outlook.com [52.101.196.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AFF8113A55
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 14:18:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxfPPYV9wX0C40drTnBUpaSjhPYuZ4AQPaEF1uOv6/T6+8fe6rQ+VG0kCpPh/PSoiBQEZm/5bgpXq2YyB6nMU+QRLL3q+2mtX0743S6BcH6dxv6DmAwtRIydFZAnqM4nDU7J9clZVGz+xqBn22I21Oo3thkUhMGDvy3oSwiNoynihgAEbdCfShYJRt4j/EaKPxdw688+bETeFLWHAVb2Jt0TbApUPFbpookeUjjFGLcvFA8k9YP/rHJoBdDWLRYcniGz6U7KtAevgCQ5i9eP2B8dAACzvxfJpZsOUYp2iDuPilmRwz3jxxAISEtHacr8bn9FNTB5lMajR0U2ucPbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/9OJSQmC538YiQWyHWAepxZMctulom/DGqoo7YlVVE=;
 b=Ox9uVy3ICZil3B5r1EWKa1z+KwZywoTFUvXvlkKp9pfBDKFkC/847r7Df/qsMzv2qpu0Av2qm4QREu7YiBmoG/f2Vg7QuqGjrs6QfPqH5aOMxJ2+nbB2leo38i23Afy1mIpKxaB/FudQQBT4Wisl2N+7npw+WBuixV5cciT4OV1QIO+AYLoPYWBiuANPw6vIOLRW08w1Prl1V7hK7waEocXcOy1jt+OEj5pm2o/CjMJe0cZ+RVOrF7CEcUKiBLCiMALKuKJCuO+gNDE5nAvZSIdv6ilPhnLHK8Hvzzj/MptyAF6qBP53fJlN6B4UT0KjTEe0nIer9fHQ7kxn06ms5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/9OJSQmC538YiQWyHWAepxZMctulom/DGqoo7YlVVE=;
 b=F/WGxHPPsO+8xrRWCX5sxyn4Ec2yW0tSlziY+zNoXfwqTVg8n8OoJ6Z5Qllu8fdepJSLX470MMJMO6VXpJVH6kb73j/ejshqFM7eDav3jet0w4a8K6q26E+JAf0u1rZCFFWUu0hXjHqmetUZ1hkbuLWDiszuxTcZIAMwk18VptQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3626.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1b5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 14:18:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 14:18:02 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 02 Jun 2026 15:17:54 +0100
Subject: [PATCH v2 3/6] rust: ptr: add panicking index projection variant
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-projection-syntax-rework-v2-3-6989470f5440@garyguo.net>
References: <20260602-projection-syntax-rework-v2-0-6989470f5440@garyguo.net>
In-Reply-To: <20260602-projection-syntax-rework-v2-0-6989470f5440@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780409881; l=11093;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=aj3FeKvKcEc1vGR+Niu8f/ESQZCTUXhY9uiOqqrE1UA=;
 b=3kGhrx1x43fdMWlorEifAyGjw9r3F37oGIgiFlrXWyf2pXAXwdf4KX8IM/bt9wPSSH9gxbXpa
 kHzwWn68HExBRRsXI+ZXZfVRLnCdKwqs90DHc6VOK4dpWMbzrROBUap
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0539.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3626:EE_
X-MS-Office365-Filtering-Correlation-Id: 4223d8a9-deeb-49f4-704b-08dec0b1c1df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|7416014|1800799024|22082099003|18002099003|921020|6133799003|5023799004|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: 8tWhrurZkpi5OQtgFO1xJ0al0A5xbsiuhz14Oow9RrUYCttWCkQz8DzJ+t7BUquMRalCbs6D7NWcwgbH2Op+9z3EoO3Zfav4biD2EcX1VOhGCPe/XUoiGqaD5fHX/E8GAGMpTSeEY2EsJC1S48d1KwPiWDjtEMkm3yUem3seeWScBXerEbG7MfggdxPXtkhGH1gSf45BsDKbXdcVdG/LDHOQuxekAJTGhrNDBWO9gxOb0ykK1aE1yiBR4y1kYiVnic8yqnCjX+qSLaKGJv54SdcOso6Au5YHvk/Kv6B/HZ8TCo+Pvi31XPdLxtmk1TZz7Bk/csYq9bPk1P9ZsiaWf7J/XRwvGEukHZSKIQTXuBE0Z7KuUT5ei02MYLNnPT5Ivsj2jcpqIQ81tbODtClVY5+nziyv19m9hkQ50pbKatgPmoZfg+ocn+4JAi49dgiJtCLt2NQzhnsuAjhQYBJpep7QpFcA45WMZVdee51vpqI+pT8vKG/10rd23BMpvrFr5xw/o1CHZ0QrITQ1X5ukH3kQJiKpJ0FcsYm+YiTQs0c2dvIW4sJD2Xo6yaGP+UzwQ+loHEzlIg5T9MVCP1ZcphaIlpFMYTxgP/2I9GAtvTXPzFPS4gky928pC43SpATnQ8Gnrzs3NM7/RjX75I/p9dg2k7hulfhCUovJs8cTpirxXk5XOhkfdRwQsZDU1qiB1fdl2bqRMgnBBFMe/3croI+p6UZx4rLCbC1TVIKDa5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(921020)(6133799003)(5023799004)(56012099006)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTFsNzJLZVNIZnp0Vmh0ZlBlZVlZMFRsdzg4UzRkMFF1MmQrS1ptUDV4Z1Vi?=
 =?utf-8?B?QmwvOFJDMXIyTGhSZ3lLZDRLT3Y5bmw0eG1UK1dhSzVBaXN5cVA4Zm5yMmln?=
 =?utf-8?B?d3hxcjBhazBIZXNhUzF0MmlWN1B1TFlVZkVvaEcwMm01elpLMmdTQmhYOCtG?=
 =?utf-8?B?aHNsVkJ0MW9qQXU5S0I4MEJBeVdoTzMrMGNaRzd0d3hqbkVyT2srWThWeUlN?=
 =?utf-8?B?Qk15N054Y1pURllLWG14UzBjVUdOZ1BVVUcyOWpoZDNHRjdQd3pwQTEzYmFq?=
 =?utf-8?B?T0tMMWZpRVFHRkd1bi9vaE5xd0hBeXdRNlNyRlRJQ1BoL1JkcUM4RzV6R1lD?=
 =?utf-8?B?VTFEREFHcC9CQkFZZFNtM2V4TnRsSC9LNC9YK1FMemI3Z0ljWWt4NWpFTDFr?=
 =?utf-8?B?THJoaUhoNW5Bb3hNa1ZGQjV1aHBBVjQrNkxlNUw5UWU4U3F2dVNyM0UyVlVi?=
 =?utf-8?B?RFFRUnJGcWpqT0p2QWN6em1hNWozelBwdGR6UUxFVEoyQ0owU1JWRDRTd0I4?=
 =?utf-8?B?ZzMxcHZjQ1JGdHZlcmtqTWx6ZjcrUkxWbU0rQWZJMFdONDRpYkpUZ2lzcWY0?=
 =?utf-8?B?YjJuOXNNaEoxa0E1NWNEVWlqMEtwMGxhN3pJZ2lqWFdjbE8yNW1vcjRYYlZo?=
 =?utf-8?B?c1YrZnJMZDgvRWY0akJZc1FqVVYrNFZyS3VmU3ViM21JaE5Ea0VOS2dPNWY5?=
 =?utf-8?B?V0JYSjYxdTdwQmg5cUdUVlcxTDJDaTdhanJ3SExCdXJVekNEbEg5Y0p5Rm9F?=
 =?utf-8?B?R3Y1YlB6N1ZxZ0Z3c2luSFRrbllqa0wvbjM4ZzRMTWl1dGluN3ZVT1hwNzdn?=
 =?utf-8?B?RE05RUw0ZGN3VWswN0p4THRBeldBTk9JS280MkVGeWV1VE5zRXJsWm0rUWdZ?=
 =?utf-8?B?ZUYwUmxmdUJhZVRjMWorOE5Yak8rZmh3dklwUGR1QU9vWnRGcnJ0THJSZEpB?=
 =?utf-8?B?WDA1UXZwY28xQUU4bkNJMk1EUU5NNXJ1SGZsT0tXcHc2cVVrVnh6d04wZG1T?=
 =?utf-8?B?b2QzTWkyM1pLZkd6TzFES0ZVdGk5Q1JVaUtBVjBidXA2L1R1cWxCNW5YZjNN?=
 =?utf-8?B?UUtESWJiQ3QwRGZQa2ZmaDBYeWdYZXg0N2cxQllERFJPWlpQTjVUUDFCSWJ6?=
 =?utf-8?B?WFJ3dkxvbUg1WnBDeTJTMmVmTWd2OTZRdmpJN20yMC9aaVd1Zm42S3RLN3g4?=
 =?utf-8?B?VG1hQTF6SUpVTWFaOFhleGUxcWx6YVljWGlyVXNkQ2dzejc4eU0vdGNlTWdl?=
 =?utf-8?B?REdqQVM3OTRMZkxhb0k1KzVuSkw3NlIxM2kxakY3VkNIQjZ2ckhYY2pqcm5H?=
 =?utf-8?B?MVVGb3pKdlJLTUgzMDNVWXRIN1VKT3FPQ0xJaEg5UUF2L2FYQTU2S0RPTVRD?=
 =?utf-8?B?SXRCWGQ1amF3NEg5SnVMUVhtbmhCWDNOTXdwU2tnb2crTjU1U0RRYkFFTXpV?=
 =?utf-8?B?K1VHemxmaEZkYUt5UENnMG56dzFEN3o5cjB6VWpkK2JwUnhxWFh5WFNnQ1Rq?=
 =?utf-8?B?bWpEcFB0aFh5N2pzbTVEY0J0WkdvQVZGT3ZKc292S0M4OFNXVDk4bkxmckVJ?=
 =?utf-8?B?VWs1Q2phNHZyZlhuNXhvOVV3QnZiejlMeXBCTHB5UDhwVEZIeitXczlYTmty?=
 =?utf-8?B?QVp0UTUxNmE0VTQ3eXIxZmk0b1Jjam92ZlNuYTJ0cjVsRFNKMEo2c2ZJODFh?=
 =?utf-8?B?eWRrYjRZSWFtRGwvNkxuNUpZbnRTc0wzYTZRRUgxUHJ0dVBxK2R1TmlFWkx6?=
 =?utf-8?B?cFRIaVRoY3ptVmJNVTF0cTRXUWdNdXVyY0lKYWtjRHRSWUVWbG5RcmV1Sy9Q?=
 =?utf-8?B?cXo0M01ldFdFMDlrYkFWVXlzK0JDRnBtTnlxenp5VmpWQWtRc1d0TEJkYjFI?=
 =?utf-8?B?QWJiZk5taHNhMEFNa3hBTnk1cEJqWkxtakZvV3N1Z1NHMkJvYXdKL3hLSGZT?=
 =?utf-8?B?QjFxcHdBRFBsZGpMeFZpZ1lhRnhIK3JCcXdNMkR5L0RlbnEvNlVWU1FOd3ZV?=
 =?utf-8?B?TGNqeE45V1FoL0hxUTN4M0NySFlTMHF0NjBROGJOMHJPay84ajVSN2J0L2ZZ?=
 =?utf-8?B?SEhsblZWZVFZbTJKTHhNK21qeTBpaEdGL1RqZzZkNG1QTlJVNWl6U0s4OTFE?=
 =?utf-8?B?UlZKNUNDajYwWFhnZkQzQVpVR2NBRStTOCtUOVJ0UDJiZzV0YktqaGp0SGdn?=
 =?utf-8?B?OHM4eUpDMjhEWFFnZGt3OFNTUS9tRVVobXJjU1pwRjNiY3FETW12bEM5enFQ?=
 =?utf-8?B?VmpEL1FzLzc0Q2ZiZnpOTHRZbTVMRnhGVU5ZZGxrbDF1ZzBjZ2hnVmkvNUJu?=
 =?utf-8?B?N0ZQR09mekViWXhjLzdXeEdiaGtvcUZqWlpsdDA3ci8ydEQvYWlhUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4223d8a9-deeb-49f4-704b-08dec0b1c1df
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 14:18:02.8180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DryRsQPPr30X/H/Kh+M3Caq53eQuUAMrEIjNmvk6sB4PQFDnmCoRRfzN0f8YR/NFSQDtj2IwJafOit7qA1SGXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3626
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

There have been a few cases where the programmer knows that the indices are
in bounds but the compiler cannot deduce that. This is also
compiler-version-dependent, so using build indexing here can be
problematic. On the other hand, it is also not ideal to use the fallible
variant, as it adds an error handling path that is never hit.

Add a new panicking index projection for this scenario. Like all panicking
operations, this should be used carefully only in cases where the user
knows the index is going to be in bounds, and panicking would indicate
something is catastrophically wrong.

To signify this, require users to explicitly denote the type of index being
used. The existing two types of index projections also gain the keyworded
version, which will be the recommended way going forward.

The keyworded syntax also paves the way of perhaps adding more flavors in
the future, e.g. `unsafe` index projection. However, unless the code is
extremely performance sensitive and bounds checking cannot be tolerated,
the panicking variant is safer and should be preferred, so it will be left
to the future when demand arises.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/dma.rs            |  3 ++
 rust/kernel/ptr/projection.rs | 96 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 84 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 8f97916e0688..ff69739eae35 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -1207,6 +1207,9 @@ macro_rules! dma_write {
     (@parse [$dma:expr] [$($proj:tt)*] [.$field:tt $($rest:tt)*]) => {
         $crate::dma_write!(@parse [$dma] [$($proj)* .$field] [$($rest)*])
     };
+    (@parse [$dma:expr] [$($proj:tt)*] [[$flavor:ident: $index:expr] $($rest:tt)*]) => {
+        $crate::dma_write!(@parse [$dma] [$($proj)* [$flavor: $index]] [$($rest)*])
+    };
     (@parse [$dma:expr] [$($proj:tt)*] [[$index:expr]? $($rest:tt)*]) => {
         $crate::dma_write!(@parse [$dma] [$($proj)* [$index]?] [$($rest)*])
     };
diff --git a/rust/kernel/ptr/projection.rs b/rust/kernel/ptr/projection.rs
index 1b54616c6cbb..e46877a208d9 100644
--- a/rust/kernel/ptr/projection.rs
+++ b/rust/kernel/ptr/projection.rs
@@ -26,14 +26,14 @@ fn from(_: OutOfBound) -> Self {
 ///
 /// # Safety
 ///
-/// For given input pointer `slice` and return value `output`, the implementation of `build_index`
-/// and `get` (if [`Some`] is returned) must ensure that:
+/// For given input pointer `slice` and return value `output`, the implementation of `index`,
+/// `build_index` and `get` (if [`Some`] is returned) must ensure that:
 /// - `output` has the same provenance as `slice`;
 /// - `output.byte_offset_from(slice)` is between 0 to
 ///   `KnownSize::size(slice) - KnownSize::size(output)`.
 ///
-/// This means that if the input pointer is valid, then pointer returned by `get` or `build_index`
-/// is also valid.
+/// This means that if the input pointer is valid, then pointer returned by `get`, `index` or
+/// `build_index` is also valid.
 #[diagnostic::on_unimplemented(message = "`{Self}` cannot be used to index `{T}`")]
 #[doc(hidden)]
 pub unsafe trait ProjectIndex<T: ?Sized>: Sized {
@@ -42,6 +42,9 @@ pub unsafe trait ProjectIndex<T: ?Sized>: Sized {
     /// Returns an index-projected pointer, if in bounds.
     fn get(self, slice: *mut T) -> Option<*mut Self::Output>;
 
+    /// Returns an index-projected pointer; panic if out of bounds.
+    fn index(self, slice: *mut T) -> *mut Self::Output;
+
     /// Returns an index-projected pointer; fail the build if it cannot be proved to be in bounds.
     #[inline(always)]
     fn build_index(self, slice: *mut T) -> *mut Self::Output {
@@ -66,6 +69,11 @@ fn build_index(self, slice: *mut T) -> *mut Self::Output {
         <I as ProjectIndex<[T]>>::get(self, slice)
     }
 
+    #[inline(always)]
+    fn index(self, slice: *mut [T; N]) -> *mut Self::Output {
+        <I as ProjectIndex<[T]>>::index(self, slice)
+    }
+
     #[inline(always)]
     fn build_index(self, slice: *mut [T; N]) -> *mut Self::Output {
         <I as ProjectIndex<[T]>>::build_index(self, slice)
@@ -85,6 +93,16 @@ fn get(self, slice: *mut [T]) -> Option<*mut T> {
             Some(slice.cast::<T>().wrapping_add(self))
         }
     }
+
+    #[inline(always)]
+    fn index(self, slice: *mut [T]) -> *mut T {
+        // Leverage Rust built-in operators for bounds checking.
+        // SAFETY: All non-null and aligned pointers are valid for ZST read.
+        let zst_slice =
+            unsafe { core::slice::from_raw_parts::<()>(core::ptr::dangling(), slice.len()) };
+        let () = zst_slice[self];
+        slice.cast::<T>().wrapping_add(self)
+    }
 }
 
 // SAFETY: `get`-returned pointer has the same provenance as `slice` and the offset is checked to
@@ -103,6 +121,18 @@ fn get(self, slice: *mut [T]) -> Option<*mut [T]> {
             new_len,
         ))
     }
+
+    #[inline(always)]
+    fn index(self, slice: *mut [T]) -> *mut [T] {
+        // Leverage Rust built-in operators for bounds checking.
+        // SAFETY: All non-null and aligned pointers are valid for ZST read.
+        let zst_slice =
+            unsafe { core::slice::from_raw_parts::<()>(core::ptr::dangling(), slice.len()) };
+        _ = zst_slice[self.clone()];
+
+        // SAFETY: bounds checked.
+        unsafe { self.get(slice).unwrap_unchecked() }
+    }
 }
 
 // SAFETY: Safety requirement guaranteed by the forwarded impl.
@@ -113,6 +143,11 @@ unsafe impl<T> ProjectIndex<[T]> for core::ops::RangeTo<usize> {
     fn get(self, slice: *mut [T]) -> Option<*mut [T]> {
         (0..self.end).get(slice)
     }
+
+    #[inline(always)]
+    fn index(self, slice: *mut [T]) -> *mut [T] {
+        (0..self.end).index(slice)
+    }
 }
 
 // SAFETY: Safety requirement guaranteed by the forwarded impl.
@@ -123,6 +158,11 @@ unsafe impl<T> ProjectIndex<[T]> for core::ops::RangeFrom<usize> {
     fn get(self, slice: *mut [T]) -> Option<*mut [T]> {
         (self.start..slice.len()).get(slice)
     }
+
+    #[inline(always)]
+    fn index(self, slice: *mut [T]) -> *mut [T] {
+        (self.start..slice.len()).index(slice)
+    }
 }
 
 // SAFETY: `get` returned the pointer as is, so it always has the same provenance and offset of 0.
@@ -133,6 +173,11 @@ unsafe impl<T> ProjectIndex<[T]> for core::ops::RangeFull {
     fn get(self, slice: *mut [T]) -> Option<*mut [T]> {
         Some(slice)
     }
+
+    #[inline(always)]
+    fn index(self, slice: *mut [T]) -> *mut [T] {
+        slice
+    }
 }
 
 /// A helper trait to perform field projection.
@@ -211,9 +256,12 @@ unsafe fn proj<F>(_: *mut Self, _: impl FnOnce(*mut Self) -> *mut F) -> *mut F {
 /// `kernel::ptr::project!(mut ptr, projection)`. By default, a const pointer is created.
 ///
 /// `ptr::project!` macro can perform both fallible indexing and build-time checked indexing.
-/// `[index]` form performs build-time bounds checking; if compiler fails to prove `[index]` is in
-/// bounds, compilation will fail. `[index]?` can be used to perform runtime bounds checking;
-/// `OutOfBound` error is raised via `?` if the index is out of bounds.
+/// The syntax is of form `[<flavor>: index]` where `flavor` indicates the way of handling index
+/// out-of-bound errors.
+/// - `try` will raise an `OutOfBound` error (which is convertible to `ERANGE`).
+/// - `build` will use [`build_assert!`](kernel::build_assert::build_assert) mechanism to have
+///   compiler validate the index is in bounds.
+/// - `panic` will cause a Rust [`panic!`] if index goes out of bound.
 ///
 /// # Examples
 ///
@@ -231,17 +279,21 @@ unsafe fn proj<F>(_: *mut Self, _: impl FnOnce(*mut Self) -> *mut F) -> *mut F {
 /// }
 /// ```
 ///
-/// Index projections are performed with `[index]`:
+/// Index projections are performed with `[<flavor>: index]`, where `flavor` is `try`, `build` or
+/// `panic`:
 ///
 /// ```
 /// fn proj(ptr: *const [u8; 32]) -> Result {
-///     let field_ptr: *const u8 = kernel::ptr::project!(ptr, [1]);
+///     let field_ptr: *const u8 = kernel::ptr::project!(ptr, [build: 1]);
 ///     // The following invocation, if uncommented, would fail the build.
 ///     //
-///     // kernel::ptr::project!(ptr, [128]);
+///     // kernel::ptr::project!(ptr, [build: 128]);
 ///
 ///     // This will raise an `OutOfBound` error (which is convertible to `ERANGE`).
-///     kernel::ptr::project!(ptr, [128]?);
+///     kernel::ptr::project!(ptr, [try: 128]);
+///
+///     // This will panic in runtime if executed.
+///     kernel::ptr::project!(ptr, [panic: 128]);
 ///     Ok(())
 /// }
 /// ```
@@ -251,7 +303,7 @@ unsafe fn proj<F>(_: *mut Self, _: impl FnOnce(*mut Self) -> *mut F) -> *mut F {
 /// ```
 /// let ptr: *const [u8; 32] = core::ptr::dangling();
 /// let field_ptr: Result<*const u8> = (|| -> Result<_> {
-///     Ok(kernel::ptr::project!(ptr, [128]?))
+///     Ok(kernel::ptr::project!(ptr, [try: 128]))
 /// })();
 /// assert!(field_ptr.is_err());
 /// ```
@@ -260,7 +312,7 @@ unsafe fn proj<F>(_: *mut Self, _: impl FnOnce(*mut Self) -> *mut F) -> *mut F {
 ///
 /// ```
 /// let ptr: *mut [(u8, u16); 32] = core::ptr::dangling_mut();
-/// let field_ptr: *mut u16 = kernel::ptr::project!(mut ptr, [1].1);
+/// let field_ptr: *mut u16 = kernel::ptr::project!(mut ptr, [build: 1].1);
 /// ```
 #[macro_export]
 macro_rules! project_pointer {
@@ -283,16 +335,30 @@ macro_rules! project_pointer {
         $crate::ptr::project!(@gen $ptr, $($rest)*)
     };
     // Fallible index projection.
-    (@gen $ptr:ident, [$index:expr]? $($rest:tt)*) => {
+    (@gen $ptr:ident, [try: $index:expr] $($rest:tt)*) => {
         let $ptr = $crate::ptr::projection::ProjectIndex::get($index, $ptr)
             .ok_or($crate::ptr::projection::OutOfBound)?;
         $crate::ptr::project!(@gen $ptr, $($rest)*)
     };
+    // Panicking index projection.
+    (@gen $ptr:ident, [panic: $index:expr] $($rest:tt)*) => {
+        let $ptr = $crate::ptr::projection::ProjectIndex::index($index, $ptr);
+        $crate::ptr::project!(@gen $ptr, $($rest)*)
+    };
     // Build-time checked index projection.
-    (@gen $ptr:ident, [$index:expr] $($rest:tt)*) => {
+    (@gen $ptr:ident, [build: $index:expr] $($rest:tt)*) => {
         let $ptr = $crate::ptr::projection::ProjectIndex::build_index($index, $ptr);
         $crate::ptr::project!(@gen $ptr, $($rest)*)
     };
+
+    // For compatibility
+    (@gen $ptr:ident, [$index:expr]? $($rest:tt)*) => {
+        $crate::ptr::project!(@gen $ptr, [try: $index] $($rest)*)
+    };
+    (@gen $ptr:ident, [$index:expr] $($rest:tt)*) => {
+        $crate::ptr::project!(@gen $ptr, [build: $index] $($rest)*)
+    };
+
     (mut $ptr:expr, $($proj:tt)*) => {{
         let ptr: *mut _ = $ptr;
         $crate::ptr::project!(@gen ptr, $($proj)*);

-- 
2.54.0

