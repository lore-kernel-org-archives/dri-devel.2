Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FEAC55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F5E10ECCB;
	Wed,  5 Aug 2026 05:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="p8/Rr5/u";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010071.outbound.protection.outlook.com
 [52.101.193.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C38D10ECD3
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:45:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d91dGSD67gDFC23ZNg/u/fM+CpZmckLWTzFKlwIGVmzq96s8BFoVXvzZJ9h+E2khWNJ+TCAN8zUve769B6vOvTP+9pceFC+uIc3ggTr9CgG79xEpDES20tgQ6ClEG7PftiISFDmG3kV8rtOzc/uo0VZEuK3oFYyyE2AQ3n9m6djbU9oKKP2B4VOW6Op62EN+1Nxehdik2k+1gid5IEiWQMUr5AQmnzAD7VUYToYI4kg5WAKIcBDY1pyHlJiokkcWVpyQVs7DQrVf0SqWpykcbkwwe5BMEPHQwxgz7SCb4n7N/zGy+0KI9JEA0ShdZHXy1qUJh2k2/UhwXkD2PitDZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGOBl5a/xNWCXmOTaWTF7DxH9KJC5yYDPccNRx+MRTQ=;
 b=IroTPuZfiYxqit4LH5aXXIKRI84RwMzJmHQ/W38hw0j6vSi/SWuqa77p42kZGD2G9yeLFzWW5YBXrEIM40tLRmIO+ZCQA2fQhoVHYvpk3uDogwrKbF8CCprkFdwTt9r7HVyD9FKC/NLgBOyqcrYy4Nwm+ShbU1sjPG3S3+JHj+jEEOnlmVJnJjC00f8qT38mhZ0//JwhZfBSq/L84odd8NTpIRmhh2ClKwqSe2WYOKnAPFTt7gn6i+06KhlnMYm++0jh0uyI+zhR/uiu8j28EDYljlrXOXvHaa30K6MYhoiaC1tLD2wtlsVOmfD/GVmzOHVXMN2IrqgNmwg++ChmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGOBl5a/xNWCXmOTaWTF7DxH9KJC5yYDPccNRx+MRTQ=;
 b=p8/Rr5/uVV/P5JOmJDX4OXi2nFi6xBQa1ZP7L9kZyOHUXqXrRDgwSmKYycWnAPW19aUwPaDcL0yjBIGz6Av/TX0u3BBblBx6EokaWTlzXpZRjD/ts/ORZ2c9cUSwp5DVOEdmuhK5UeFfv4/dVWHFIKXY8A1xgMf58WugUsCTcB1zP/hZCKlYnpG/hysGEcE+o0UJ9vhQpkByhcW9JsZ118ziHiSuFEKF2sMo5MvfQCFftU2CgIsgbwIfSwBqI/69U7gThGwIwqLW80ZS8y/6Y6u+DVKpI9Ftubi1D6kwL7kQvXACM859QltGDyZC2QEwDW2R6dCfA7A6pjwGRdaY/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 05:45:31 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 05:45:31 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 05 Aug 2026 14:44:52 +0900
Subject: [PATCH 05/12] gpu: nova-core: mm: Implement Alignable and Debug
 for VramAddress
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pramin-split-v1-5-ff3e84a75dac@nvidia.com>
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
In-Reply-To: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Yury Norov <yury.norov@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f9665d-3e27-4398-14bb-08def2b4c315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|10070799003|3023799007|10067099003|11063799006|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: R6GpjzkhoyGDPVKtIkXG6JdG8s1Nq0J0oWri9+C5gRWBqVHXt3BRrdX/RN0GLDgqoi9VLxm0T1ACcytMISkd6iUoE+Nx+TAawRwOJZTVWKPaeMco6bAvEZZeWHAIl++g+wO7tGCODaMoS8gID6vZxn5a4aqGMhKL1zzKuZXN26QbBtT2r3Wq7TrHTosm/aCp5SxbUD6e49Ss8/GOoyrOfLvjBrhvFO8RfGv7Rs3WrwxTRMw/lXj6I09p5EigVxzooAo6pbgwQZAb8ExnYBSdt7BKOHgssNHvIjPprJvJdrXQavb5QSuiX1SQUWtW/AF6KqVjdv+Cl1tACux1XMhbQMYH8Qb+t2KjuuxJY8418B3I56NoCzWCUu3vtVImVAPBsydaafQFWIaD+W+4Ww/kfFY7twwUFYuXDaziQCSf6q26Bjan3ZEXJmtaYlmpnntqCaSFCbhn3vD2V950GQqGmYF5VjqbhYPboNC3QG17hS7P1onUzRUhQh120tD93Izofat6LTlxmvyAB//Vv+GY+laFdU++k/bFpWyMfBm0rQx1Nv35vdKxYVQh0GNB+Gt3XVwmI9wSn2RN8NIy9OjNCqXOlrRSN96/NOtNpirvEPs/pVfXxV+zFs+ulwljU+5QsGrbHMqVYPjgrqCENAUI8eN6R42F/2L2qkn284nw2/qM01bDMDHqjteOSVBdPFKWzhgFYViLvZAol+a3VtfISg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10070799003)(3023799007)(10067099003)(11063799006)(56012099006)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3krUFlZR1ZLeTY3aXBocFRRQm9tbTFZdVljYXpHR0UwTEFtNGtSOTByT2o5?=
 =?utf-8?B?dE5TZHRkY3JYT1dDUktDRVNYMmYrQmtqT25sK3ZnV2hrcEVPWU8wbU1abWNM?=
 =?utf-8?B?ZXdwZHlQVy8rSnB2eGpHeFVyMzliMVA3VUVKWmFnSWhNN2Fja3U2MlZxQ2U2?=
 =?utf-8?B?YUozNXNIazhzM3hkMGc1MEIvRW14bVg1a0VFNTJlY3A2eHVGY0pSOHdvOGsy?=
 =?utf-8?B?ZkhaV3dheTd0bE5vc1J6OWFRaDdMSHRqKytxQmI1YjNiVW1KSElwMHFYVno0?=
 =?utf-8?B?cnNVa3l2b1NId3FjclVadXpzeUEvSTczbU9iMVVlVmpXRGY0bHJpYlVJdjFR?=
 =?utf-8?B?TUlkZ3NCUjI4QmF5TGpWTjlseGhhS3E0Njc0SGV5SjRNb2NqSHMzM0s4bG0v?=
 =?utf-8?B?YjQ5WXVrNHgzdnBZZ2t6cVQ1Q0pTUkxMdXpBczIwTGZ1V1RKak1MdWFjN1A1?=
 =?utf-8?B?cDRsM1lxREl5cnVHNlVyK0FzcnVESzFmTXk0KzFIU2IxemlWcXhnVm1wWEh4?=
 =?utf-8?B?S1VsZUNCeXZ5dU1xQnN5K2htR0RkNXAwVXZaTWtGYzJyTWNvNGRTaFprREdR?=
 =?utf-8?B?Y0hGTFBnNHlZUk9YN2d1NkY1djhBb3gwMHZzUzVWNjZLU3FNK1NuZmxBMUR1?=
 =?utf-8?B?WHBZcmpRVmlvdVZIVWgvK2JTejZKbWlZSUM4VS9tU1J0WGUxV09qZFgwODVy?=
 =?utf-8?B?SWFiYzFtUVptOEh4ekxCVGQ3TVA4Zk0rZVFGenZCdm82QkszVml4dDNGcWR5?=
 =?utf-8?B?aXNObndaTXlHYk1ER21YZzZXY0NEUjdFNHlaaCtVcldmQ2xMWDMxOXhFVGdC?=
 =?utf-8?B?aGZTRFFjRnl2Z0ZubVRuWlhBNDZMOW1VSTZ6SXpoRVVkV0pLWjUxSjVBOER5?=
 =?utf-8?B?YTBhVHQ3ZmhlbHE1TGdmYmx4LzBoT3F0c2lXR1h2U0NWL3BPSElNMkd0ZTNo?=
 =?utf-8?B?S0s0emUxVGEyS2YwT1ZNWWlSMVNnWkhMMXVjbDlaWnNUbktqQjRUZ25vUUZN?=
 =?utf-8?B?anhxNmdjcUMzaDFqNzAxb0lwRkx5Zy84TW9hSUFnUGdoUmQwVy8rYW1jczk4?=
 =?utf-8?B?UUNVTXF5TVNIZzJIaTBtWFUzcWdKaHNJeHNVWTAxakkxNkxWdWY1eFRpVFVE?=
 =?utf-8?B?OUZWZWQwZGttUXU1QWZHTTlOaXJxL2tzbVFFbSs3SDZEVE5CR1hjc1g5Zytj?=
 =?utf-8?B?b1RHWC9CVFQxZzRreXplUzR2ekR6ZnFGaG5xbVlKTk9XbzJoRFlnM1UwbGpG?=
 =?utf-8?B?OEE1ZzZoV2lFWnhRTnpvR2VIOXp6bWVOTFd2M3d4UGtlVVdvbXBTdDJKc3hr?=
 =?utf-8?B?RnJCZjlxdEFGeDF5eFpCTHJyRUpad3FuNFhtMkwzQ2t0VXd0bVdTWStYcHF0?=
 =?utf-8?B?YkIyeHJUSWNQWmdVQ2RYOHNENkROVDZqWEVUWDQ4V2s4R3JsOEdGRWJTZUJX?=
 =?utf-8?B?NmNpcjNZVWxEVVM5NDhhOFA5aE90RTU0LzRYS0xMdUpWMXNaVlQyckFFeW15?=
 =?utf-8?B?Y2Y4Sk9ZZXFZMjdrRUR6ZkNkY1NZTVkvWGNxRklBM000QkhxRlFDMTYxNEhJ?=
 =?utf-8?B?MGk0WmdsOGltSGJLdCtiUTE1bG94NWg5SVd6S2xUc1E0Zkt2NFB2QXpJMGh2?=
 =?utf-8?B?d29HV2tEZXdGSGZzY1BYZmdjdGx4elB0anBYYmVnckJXQ3pjNnViTHNsRGFv?=
 =?utf-8?B?cStoZVFVRUpFYWl3YmRWbXhpSS9lNkIrUExQZHJXT0FkeFFDckhjK0FLOGlh?=
 =?utf-8?B?U3NVdWVVQzhCV2ZwSjNlRVY0NlhVcU9weHhDK2NyY1VnQUlkVzZjeU1Wakt4?=
 =?utf-8?B?UGpheUpDMGJDcUNneStleGxBYTEwYjNKRUk2QVFTTHFRUWlxTStHTE9NY1pN?=
 =?utf-8?B?TTRHbXhMVVJOdlhsRzdWdEhJY0xIWGo0NGN3V2JHa09IUVEvR1NiQVNGYndU?=
 =?utf-8?B?VjdqeUlPMnpZQjVFdUIxejdRQUNPQUd1d2lxTWVJWlhFWXNFV2VKbjA1MTVR?=
 =?utf-8?B?ZExMYTF5K21Ua2RqWCtpRC9ZYzdLaExkbjZlYVZWT21jSk5rdk1PeXkzVWNh?=
 =?utf-8?B?UGxwWDd6eFJ5SnphRnR0ejhhSVI2a2wwcnlyb0RqZ0hmdDh6STd1SFZMWTg2?=
 =?utf-8?B?RWlkd1lCRjdDZThOcEt0ay9VRUh0NFJmMHNlaHJzZHpsdVhQSERVQXI1cXNz?=
 =?utf-8?B?cU80d2FjUUxOdUg5SGFrd0xnTEdBSjMyWjhCRFc1QlRYU2d1RHE4Qkxhd1Zk?=
 =?utf-8?B?Q1JxTWxTdnhmaHloeE10bEtkeHRTVTF3K0dMb2h5dUlueXVGR1Eyc25vbDd3?=
 =?utf-8?B?SlRHRFJSSTh0QWhmN2V2Rzk0d3NialdJdHFkMjJOTG0zU2xoVEpIOVBWRUZZ?=
 =?utf-8?Q?RcCQBvHOUsz5qeIc8uik/uRI07j0OhXcEfJo8o84k1wg0?=
X-MS-Exchange-AntiSpam-MessageData-1: bSmAE0RxgI980Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f9665d-3e27-4398-14bb-08def2b4c315
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:45:31.5028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzWoc6jLNNB5EbKeioDCGs67nfCkIwuW6KtBQzOLDL3TVqj8HuTIqZ1E2mwbeb1bwSKu32fzttkgxSe+nz6fbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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

Later patches align VRAM addresses down to the PRAMIN window. Implement
`Alignable` trait for `VramAddress` and plus add a `ZERO` constant.

Also print the address in hex under `{:?}`, so it reads well in debug
output.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index dcd5e5e919bf..f9d80ffbe01d 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -10,7 +10,14 @@
     ops, //
 };
 
-use kernel::fmt;
+use kernel::{
+    fmt,
+    prelude::*,
+    ptr::{
+        Alignable,
+        Alignment, //
+    },
+};
 
 /// Physical VRAM address in GPU video memory.
 #[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
@@ -18,6 +25,9 @@
 pub(crate) struct VramAddress(u64);
 
 impl VramAddress {
+    /// The zero address.
+    pub(crate) const ZERO: Self = Self::from_raw(0);
+
     /// Creates an address from a raw value.
     pub(crate) const fn from_raw(addr: u64) -> Self {
         Self(addr)
@@ -37,12 +47,28 @@ pub(crate) const fn checked_add(self, rhs: u64) -> Option<Self> {
     }
 }
 
+impl Alignable for VramAddress {
+    fn align_down(self, alignment: Alignment) -> Self {
+        Self::from_raw(self.into_raw().align_down(alignment))
+    }
+
+    fn align_up(self, alignment: Alignment) -> Option<Self> {
+        self.into_raw().align_up(alignment).map(Self::from_raw)
+    }
+}
+
 impl LowerHex for VramAddress {
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         LowerHex::fmt(&self.into_raw(), f)
     }
 }
 
+impl fmt::Debug for VramAddress {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        f.write_fmt(fmt!("{:#x}", self))
+    }
+}
+
 impl ops::Add<u64> for VramAddress {
     type Output = Self;
 

-- 
2.55.0

