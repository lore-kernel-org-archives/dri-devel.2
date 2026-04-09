Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6467DF31E21
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A918B10E811;
	Thu,  9 Apr 2026 14:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="TszL+uNc";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013037.outbound.protection.outlook.com
 [40.107.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1583410E80F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 14:59:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFgX+2mBsV+ClL0Zg/LO6lOaDkqBw1Wn7NU0Dn5fTA9CGDJn/9/KMo5dQc1CZ3dPi1wSGSVISojvTIxcpacmgA9kbpj/al51BjzJLCZHH/TkE2XthZiMBcvHFgnx5iybA4069X/7uzDMnaTdYWdUCvFCTrlUQ7KQy56f0WqVAwlq0O9luPmCA1532Q+Xw2lyucprIajgU13byHeaXnk+l2LU6q9mEIqpLKRKOxvHGw9h3rjc/S0xl2ptEAetKIb2WQ7nzEBfPoYcGb673+FpcVIDr2JGRYAEHn8PefAj3CakwxRQiktdJm/xWOwkTJa7/+OaJK2FbYn0W1I2AoObWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMW82PgnOuw8cqsgd3HfZdhi0gk6oumGOSUOanzHi5I=;
 b=Uy31/GeTOGci1TBc9vw7IhNzB5UerWlz8kO6W42VaubvIChLKwiVnqhAMKZHh2zhUSB993IASw2kIBqCj8itEEQqxYNErIcY8XT6szd8FsbDxYOFTyH3iILpIvJ/DCKPtUD6T1TD/VZrkAXj8jSWXK7hhSPpd0yvQ//HPRbiTL9ASXI4MJ+n1ymsOSzdV1/d2wkE4a14R9eQiTfy5X1prpH6W9jVd8I/GOWKnvo9l8q90fCnSddrzvQ/i17Hm8XQD7f9VXZmP5odSz1u8prWJd1StJuOmKReRG5jgGE4dyg958JYbWjdIecaKyUCcdZz7UIlmZOG83lNkl1yJlq2tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMW82PgnOuw8cqsgd3HfZdhi0gk6oumGOSUOanzHi5I=;
 b=TszL+uNcKg7SCZz2QEfq54O1YL+D9E+UyJTuAiW6kAXYVR1wxEuL9RVaOkJYnyYGzEAScroiSC/UD9VQJD+NPZ2HIv90EyPEW3VJpDmC1o3bVqr/wQaY/K1jIiexsZjb+48qrmF/rxrzsznYLhJSfxtYjpaSZ3vRovC39aQkKv5o1Td/2G/wPgN0AdNYqbXT/zIxi6RPkj33taoUuK3j5YSgcxgfJubwXAlG4q1WjXx+s8v8oRxC4okOBSrfSp428nitCtcMmP/JtfVt/Z97gQIXo4xvKFvSsNiZLhz/kDsVwb2db49tGjpYr8DCfktEZ00GEcLlY0AUaBN98vXFfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 14:59:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 14:59:09 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 09 Apr 2026 23:58:48 +0900
Subject: [PATCH v2 2/3] rust: bitfield: Add KUNIT tests for bitfield
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-bitfield-v2-2-23ac400071cb@nvidia.com>
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
In-Reply-To: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: TYCP286CA0064.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: d2fb1dbc-2137-4572-5d63-08de96488d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|10070799003|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: aNTDEIhECp8pjDLhZBcObWfqk3RY+8KVD4AU48VUA5zuUptDuwGiEZQDZ9muEgps/nX3ycvHNLr7UFV8LRGiIYJ3w1dxRQ0dBkwOnMZkibov1e6Xq/OYqd9n89T9KSSskgcFqMNkjYnUOJl+9uhaxiZcjsnUnlQARlLPz9pKN1NB45nXzJOc2pJyy37Lnd70vpFE1z4mUmQYlwIz6cV5+UkH+rdVXZDL58jekgUrS4hW2Fp/FlgsSFSvLbzovs8AytEAcr1sS0qUXN7smmZsj+0ckiRr+E+J5hEK2WPUDXoNIIeIgEGJaUnDPigrbqBwRKUeoHYOIOLvv4pZLjufMQAG9DVF3jdmo4TozK1/M1zEaTEasv3D+BRBrZalOTvdPaIb34MfSe0CcXGTyI1NWGxofoB4bV8+mmS4L67aJg//Pmsb38d5c3HSQMlCyHYm1A/2jRMpY5gq7xpvSTpS5OZ7pSkMSxD5l5xIQ7DKQwfkgzc2D7RC6qkU4AD/iVaZlytOqcmCShcizow6hBydr0Gn7s8o8Ta++oldCnRmEo+0xJFunsbufwaJkFkGd4jHYjJj9uQm7tJSOkyRyc1eJogYuF9omdrFU//ZeCjcCQN3fjYaGApLANFwEIu3/toHSa/oZkFsAxo63sQfLvO+GHgiBlw9UmcoPKQH9FfkB6LgoPjzDh4zFbPRCIwaRo7vyxbiogggv9rk22TfjgLIagLpPJiMdLZVsNvevRLJzPaQEudRv0vJwaTGKBv6leUXd84fGtX6Wzjo43OOxDDqfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tm1VZEhzV2ZuVVZOc1B3QjMxVHhjZXVzWlZBU2liekxRdEJFVDNpWmQvSXdR?=
 =?utf-8?B?N3U0cWJYOWU2VnF1WTV2QkdLbkxiUDg3UG5ONUZLcm41TWdySzB1SU1vL1Ax?=
 =?utf-8?B?dFA4OFNZTXI4MXdaT21ycTBvMFUvZXlXZ2hPWUR4SzhiYXY3N0lRb2JlSTBa?=
 =?utf-8?B?T3duSFJLOTlBd25FVFF2a2dSNGlDMWpxVVJ0Qk1TRlhFdW85ZDZWNUl2d2ZS?=
 =?utf-8?B?Z3ltVHFhN1JHT2JkVlRmTEJvOWJNOHFOWTlETE5WeXUrN2hnNENtbjhUOWlO?=
 =?utf-8?B?Y1NiNmNHTUhFV1c5dUxBSHkzMlZnUS9HNGRrM2hsMlNZU0lmd2Z4eEltQmxY?=
 =?utf-8?B?REo0a2ZGY0gvQkJ0UitQbXoweUdmbi9zdHFXMEIwQzVmcEhiNmNVVnZZU21I?=
 =?utf-8?B?R01zdnhyWlBMbWM0eXhrYWc4dDFxT0tEUmpvTUxSVkdNVjBOOXJESVd6SkZH?=
 =?utf-8?B?WXIxak00MU05WVlsWnlMODFCTGMweUQyOGtkZ0E4aUZFTVQ3TUNES2RZU0JI?=
 =?utf-8?B?VTdsQ2V4VkVRbkZlUGUyRzVDZEc5RGJLdUdwNys3VnI4UmV1RDZCR1NFeG94?=
 =?utf-8?B?UjdXNjNrdk12c3h2OXVGbVZBT1dqalZSZFhzSlI4a2xtSG1WTE5PWHI3VHNt?=
 =?utf-8?B?UzJwNmgwOVV2L08zM1ZZTEIyKzVuVDI5eGY0bjMwVHFGZWFURzNSSmpGM09D?=
 =?utf-8?B?WEF1WnhkNEhXRUdiU25mWUZ4VjYrOEVjTS83Nm1iUTJaRFpRYXVOM0NJSGZ3?=
 =?utf-8?B?V1BJRjlNRDExdUswZGo5OWUzWlNGckZKRW5yQStDM0N3cFJqR3dSZmZJWHRy?=
 =?utf-8?B?MmJVNnIwZjBCSzdlNnpOdWxoZGFCNGlYNm05TzBLZXhYNTJKU2VYS2tldUI5?=
 =?utf-8?B?V0p1dTlIL2QwM3JsRWR4UDExK2I0dzczbjRzeGFIdVgxSXlmQ0lrbmE5NmVT?=
 =?utf-8?B?UURvc3E2TEdUTUZQUmduZFNPY2c2eDh1Qm4yWWpGbVVwZTF2SnIrQ1dPRStY?=
 =?utf-8?B?VHZvN2JCd1JVZlEwZUdyM2gweVROckZ3OWY1OWFrdWw4OFFGcUZNdG5DR3ph?=
 =?utf-8?B?aGpDNTBWSkpDaWVQazdEbHlTNWtHUVRWejBZQStDSXNnZk55WUlndVVzdGdM?=
 =?utf-8?B?R2t6T09EM3RFck43cUFxWUw4dllNOFNwZFNBVG1xR2RRbEYrLzRPeU9Pb3R1?=
 =?utf-8?B?ZnQxQUJDdWllQUR3eDFHdWF0bHd4dXY2QnN0RTdxdWZXRk8rL3dLNFd5MGds?=
 =?utf-8?B?RTNucnpkN1J5UWdCRkEyNHFoVlladWdnVGJUUDZQQjBqWkIyT3JOeDM5L1Uv?=
 =?utf-8?B?MmZuN0FKdm5WSkpiUHpjZGphdElhdW5xQWJFVVBqTXRiYXBBSy83MHdMNGVu?=
 =?utf-8?B?MjM3c2R0UkgrNitLZ3I5OHpDZ2RCLzJEaFNXNXJTUWZXNkhUNkFvN3pBVHdD?=
 =?utf-8?B?bC80b1VSSEpCVWY5VnUzUm56MG02ZnRaRVh4bVd2S2QwZnJpQmx4S2cwQW9Q?=
 =?utf-8?B?VU5hNEVXRDAyRk9oM2lJc0VjMWJnY1I3L09XcmI0T1dJWmtkQ0hhUG1VV3ll?=
 =?utf-8?B?TitXckFETzArOVNlTzZyb1ptTlprR1FFR3ZxenE1bGFKVTk3VkVGRUxGMmRM?=
 =?utf-8?B?WFhkYnpmT2NpeUlmblhkQkdEQlhxZ09oclhjSDAxdXNjVXhkbnhPb0k0WVBX?=
 =?utf-8?B?SG1DY2w4MlpRTzl0QXh4clFsMzhnZjJuRWI1aVkrOFl6bVZqMTJ5TmZOS3VY?=
 =?utf-8?B?VG8zbkVtNnNudEl3RHJxaXJpd2FwUjJVbHZzQkhnc1ZIcWhmTldjeExzRFhK?=
 =?utf-8?B?TW9XajhZR3dRT0hOUWkxcU44SU1MSHBteWlnampPK2FEaDhtUDFzbU0vVERB?=
 =?utf-8?B?YkFSRjQwY2licGgzV2ZMcnc3WlZ5Z2NkcE93MmxHelcxd3dVczdrYktNaElw?=
 =?utf-8?B?Q2QxVVdRK2x1MFZmRnF0dzVvNk9tSlRjVlpVc09KeEh1M2xYVjkwdlFTbUs0?=
 =?utf-8?B?QWF1TjBTeXpBTGJYbUwyK0hvZ20yclpoVEZhQnJwTDFKYk10OURIWFA1S0xj?=
 =?utf-8?B?M3hqOHM4U0RsZG9GNkwvWnlOdjd4Vk9GRmpjM0ExdlZoS3FXbW5Ta2xTK1hj?=
 =?utf-8?B?b3ovbjVVWWNhclVveWhpVDJKazB5NkdLUmJpdGcvb3doeE9mV1lady9DbVJl?=
 =?utf-8?B?N1JvN0o4Z3FLb3Jkelpyb3ZScTc1ZXdOazJCQ1htODZjempaL3hJNUZwUnVO?=
 =?utf-8?B?STIwdE8rckVJbVFlVzNIbDdYMzVzNEpFaUZORVR1WG8zYTdhdW12Y2pCOXk4?=
 =?utf-8?B?ZCtQTG5JNmhFR0c2RDQ5N2QrRVFSOFVGVlNTY0l4eGlEbmpzYnZ0MEU3Rzhy?=
 =?utf-8?Q?mmAYOjmyzk3tudLw5V6vdDhteTAeqRV/MjSlXGzL4RuG7?=
X-MS-Exchange-AntiSpam-MessageData-1: JcVHVA1XCafy1Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fb1dbc-2137-4572-5d63-08de96488d98
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:59:09.2090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5A89WWTLJJQp22nAZuD6A7yiHyQrPFDHeOUtdS9/4WjoNg7ZNxMtWImPXJwJ9rhXvTODNxkGyIxXm1hcvabIEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847
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

Add KUNIT tests to make sure the macro is working correctly.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[acourbot: update code to latest bitfield! macro.]
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/bitfield.rs | 318 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 318 insertions(+)

diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
index f5948eec8a76..9ab8dafff36c 100644
--- a/rust/kernel/bitfield.rs
+++ b/rust/kernel/bitfield.rs
@@ -489,3 +489,321 @@ fn fmt(&self, f: &mut ::kernel::fmt::Formatter<'_>) -> ::kernel::fmt::Result {
         }
     };
 }
+
+#[::kernel::macros::kunit_tests(kernel_bitfield)]
+mod tests {
+    use core::convert::TryFrom;
+
+    use pin_init::Zeroable;
+
+    use kernel::num::Bounded;
+
+    // Enum types for testing => and ?=> conversions
+    #[derive(Debug, Clone, Copy, PartialEq)]
+    enum MemoryType {
+        Unmapped = 0,
+        Normal = 1,
+        Device = 2,
+        Reserved = 3,
+    }
+
+    impl TryFrom<Bounded<u64, 4>> for MemoryType {
+        type Error = u64;
+        fn try_from(value: Bounded<u64, 4>) -> Result<Self, Self::Error> {
+            match value.get() {
+                0 => Ok(MemoryType::Unmapped),
+                1 => Ok(MemoryType::Normal),
+                2 => Ok(MemoryType::Device),
+                3 => Ok(MemoryType::Reserved),
+                _ => Err(value.get()),
+            }
+        }
+    }
+
+    impl From<MemoryType> for Bounded<u64, 4> {
+        fn from(mt: MemoryType) -> Bounded<u64, 4> {
+            Bounded::from_expr(mt as u64)
+        }
+    }
+
+    #[derive(Debug, Clone, Copy, PartialEq)]
+    enum Priority {
+        Low = 0,
+        Medium = 1,
+        High = 2,
+        Critical = 3,
+    }
+
+    impl From<Bounded<u16, 2>> for Priority {
+        fn from(value: Bounded<u16, 2>) -> Self {
+            match value & 0x3 {
+                0 => Priority::Low,
+                1 => Priority::Medium,
+                2 => Priority::High,
+                _ => Priority::Critical,
+            }
+        }
+    }
+
+    impl From<Priority> for Bounded<u16, 2> {
+        fn from(p: Priority) -> Bounded<u16, 2> {
+            Bounded::from_expr(p as u16)
+        }
+    }
+
+    bitfield! {
+        struct TestPageTableEntry(u64) {
+            0:0       present;
+            1:1       writable;
+            11:9      available;
+            15:12     mem_type ?=> MemoryType;
+            51:16     pfn;
+            61:52     available2;
+        }
+    }
+
+    bitfield! {
+        struct TestControlRegister(u16) {
+            0:0       enable;
+            3:1       mode;
+            5:4       priority => Priority;
+            7:4       priority_nibble;
+            15:8      channel;
+        }
+    }
+
+    bitfield! {
+        struct TestStatusRegister(u8) {
+            0:0       ready;
+            1:1       error;
+            3:2       state;
+            7:4       reserved;
+            7:0       full_byte;  // For entire register
+        }
+    }
+
+    #[test]
+    fn test_single_bits() {
+        let mut pte = TestPageTableEntry::zeroed();
+
+        assert!(!pte.present().into_bool());
+        assert!(!pte.writable().into_bool());
+        assert_eq!(u64::from(pte), 0x0);
+
+        pte = pte.with_present(true);
+        assert!(pte.present().into_bool());
+        assert_eq!(u64::from(pte), 0x1);
+
+        pte = pte.with_writable(true);
+        assert!(pte.writable().into_bool());
+        assert_eq!(u64::from(pte), 0x3);
+
+        pte = pte.with_writable(false);
+        assert!(!pte.writable().into_bool());
+        assert_eq!(u64::from(pte), 0x1);
+
+        assert_eq!(pte.available(), 0);
+        pte = pte.with_const_available::<0x5>();
+        assert_eq!(pte.available(), 0x5);
+        assert_eq!(u64::from(pte), 0xA01);
+    }
+
+    #[test]
+    fn test_range_fields() {
+        let mut pte = TestPageTableEntry::zeroed();
+        assert_eq!(u64::from(pte), 0x0);
+
+        pte = pte.with_const_pfn::<0x123456>();
+        assert_eq!(pte.pfn(), 0x123456);
+        assert_eq!(u64::from(pte), 0x1234560000);
+
+        pte = pte.with_const_available::<0x7>();
+        assert_eq!(pte.available(), 0x7);
+        assert_eq!(u64::from(pte), 0x1234560E00);
+
+        pte = pte.with_const_available2::<0x3FF>();
+        assert_eq!(pte.available2(), 0x3FF);
+        assert_eq!(u64::from(pte), 0x3FF0_0012_3456_0E00u64);
+
+        // Test TryFrom with ?=> for MemoryType
+        pte = pte.with_mem_type(MemoryType::Device);
+        assert_eq!(pte.mem_type(), Ok(MemoryType::Device));
+        assert_eq!(u64::from(pte), 0x3FF0_0012_3456_2E00u64);
+
+        pte = pte.with_mem_type(MemoryType::Normal);
+        assert_eq!(pte.mem_type(), Ok(MemoryType::Normal));
+        assert_eq!(u64::from(pte), 0x3FF0_0012_3456_1E00u64);
+
+        // Test all valid values for mem_type
+        pte = pte.with_mem_type(MemoryType::Reserved);
+        assert_eq!(pte.mem_type(), Ok(MemoryType::Reserved));
+        assert_eq!(u64::from(pte), 0x3FF0_0012_3456_3E00u64);
+
+        // Test failure case using mem_type field which has 4 bits (0-15)
+        // MemoryType only handles 0-3, so values 4-15 should return Err
+        let mut raw = pte.into_raw();
+        // Set bits 15:12 to 7 (invalid for MemoryType)
+        raw = (raw & !::kernel::bits::genmask_u64(12..=15)) | (0x7 << 12);
+        let invalid_pte = TestPageTableEntry::from_raw(raw);
+        // Should return Err with the invalid value
+        assert_eq!(invalid_pte.mem_type(), Err(0x7));
+
+        // Test a valid value after testing invalid to ensure both cases work
+        // Set bits 15:12 to 2 (valid: Device)
+        raw = (raw & !::kernel::bits::genmask_u64(12..=15)) | (0x2 << 12);
+        let valid_pte = TestPageTableEntry::from_raw(raw);
+        assert_eq!(valid_pte.mem_type(), Ok(MemoryType::Device));
+
+        const MAX_PFN: u64 = ::kernel::bits::genmask_u64(0..=35);
+        pte = pte.with_const_pfn::<{ MAX_PFN }>();
+        assert_eq!(pte.pfn(), MAX_PFN);
+    }
+
+    #[test]
+    fn test_builder_pattern() {
+        let pte = TestPageTableEntry::zeroed()
+            .with_present(true)
+            .with_writable(true)
+            .with_const_available::<0x7>()
+            .with_const_pfn::<0xABCDEF>()
+            .with_mem_type(MemoryType::Reserved)
+            .with_const_available2::<0x3FF>();
+
+        assert!(pte.present().into_bool());
+        assert!(pte.writable().into_bool());
+        assert_eq!(pte.available(), 0x7);
+        assert_eq!(pte.pfn(), 0xABCDEF);
+        assert_eq!(pte.mem_type(), Ok(MemoryType::Reserved));
+        assert_eq!(pte.available2(), 0x3FF);
+    }
+
+    #[test]
+    fn test_raw_operations() {
+        let raw_value = 0x3FF0000031233E03u64;
+
+        let pte = TestPageTableEntry::from_raw(raw_value);
+        assert_eq!(u64::from(pte), raw_value);
+
+        assert!(pte.present().into_bool());
+        assert!(pte.writable().into_bool());
+        assert_eq!(pte.available(), 0x7);
+        assert_eq!(pte.pfn(), 0x3123);
+        assert_eq!(pte.mem_type(), Ok(MemoryType::Reserved));
+        assert_eq!(pte.available2(), 0x3FF);
+
+        // Test using direct constructor syntax TestStruct(value)
+        let pte2 = TestPageTableEntry::from_raw(raw_value);
+        assert_eq!(u64::from(pte2), raw_value);
+    }
+
+    #[test]
+    fn test_u16_bitfield() {
+        let mut ctrl = TestControlRegister::zeroed();
+
+        assert!(!ctrl.enable().into_bool());
+        assert_eq!(ctrl.mode(), 0);
+        assert_eq!(ctrl.priority(), Priority::Low);
+        assert_eq!(ctrl.priority_nibble(), 0);
+        assert_eq!(ctrl.channel(), 0);
+
+        ctrl = ctrl.with_enable(true);
+        assert!(ctrl.enable().into_bool());
+
+        ctrl = ctrl.with_const_mode::<0x5>();
+        assert_eq!(ctrl.mode(), 0x5);
+
+        // Test From conversion with =>
+        ctrl = ctrl.with_priority(Priority::High);
+        assert_eq!(ctrl.priority(), Priority::High);
+        assert_eq!(ctrl.priority_nibble(), 0x2); // High = 2 in bits 5:4
+
+        ctrl = ctrl.with_channel(0xAB);
+        assert_eq!(ctrl.channel(), 0xAB);
+
+        // Test overlapping fields
+        ctrl = ctrl.with_const_priority_nibble::<0xF>();
+        assert_eq!(ctrl.priority_nibble(), 0xF);
+        assert_eq!(ctrl.priority(), Priority::Critical); // bits 5:4 = 0x3
+
+        let ctrl2 = TestControlRegister::zeroed()
+            .with_enable(true)
+            .with_const_mode::<0x3>()
+            .with_priority(Priority::Medium)
+            .with_channel(0x42);
+
+        assert!(ctrl2.enable().into_bool());
+        assert_eq!(ctrl2.mode(), 0x3);
+        assert_eq!(ctrl2.priority(), Priority::Medium);
+        assert_eq!(ctrl2.channel(), 0x42);
+
+        let raw_value: u16 = 0x4217;
+        let ctrl3 = TestControlRegister::from_raw(raw_value);
+        assert_eq!(u16::from(ctrl3), raw_value);
+        assert!(ctrl3.enable().into_bool());
+        assert_eq!(ctrl3.priority(), Priority::Medium);
+        assert_eq!(ctrl3.priority_nibble(), 0x1);
+        assert_eq!(ctrl3.channel(), 0x42);
+    }
+
+    #[test]
+    fn test_u8_bitfield() {
+        let mut status = TestStatusRegister::zeroed();
+
+        assert!(!status.ready().into_bool());
+        assert!(!status.error().into_bool());
+        assert_eq!(status.state(), 0);
+        assert_eq!(status.reserved(), 0);
+        assert_eq!(status.full_byte(), 0);
+
+        status = status.with_ready(true);
+        assert!(status.ready().into_bool());
+        assert_eq!(status.full_byte(), 0x01);
+
+        status = status.with_error(true);
+        assert!(status.error().into_bool());
+        assert_eq!(status.full_byte(), 0x03);
+
+        status = status.with_const_state::<0x3>();
+        assert_eq!(status.state(), 0x3);
+        assert_eq!(status.full_byte(), 0x0F);
+
+        status = status.with_const_reserved::<0xA>();
+        assert_eq!(status.reserved(), 0xA);
+        assert_eq!(status.full_byte(), 0xAF);
+
+        // Test overlapping field
+        status = status.with_full_byte(0x55);
+        assert_eq!(status.full_byte(), 0x55);
+        assert!(status.ready().into_bool());
+        assert!(!status.error().into_bool());
+        assert_eq!(status.state(), 0x1);
+        assert_eq!(status.reserved(), 0x5);
+
+        let status2 = TestStatusRegister::zeroed()
+            .with_ready(true)
+            .with_const_state::<0x2>()
+            .with_const_reserved::<0x5>();
+
+        assert!(status2.ready().into_bool());
+        assert!(!status2.error().into_bool());
+        assert_eq!(status2.state(), 0x2);
+        assert_eq!(status2.reserved(), 0x5);
+        assert_eq!(status2.full_byte(), 0x59);
+
+        let raw_value: u8 = 0x59;
+        let status3 = TestStatusRegister::from_raw(raw_value);
+        assert_eq!(u8::from(status3), raw_value);
+        assert!(status3.ready().into_bool());
+        assert!(!status3.error().into_bool());
+        assert_eq!(status3.state(), 0x2);
+        assert_eq!(status3.reserved(), 0x5);
+        assert_eq!(status3.full_byte(), 0x59);
+
+        let status4 = TestStatusRegister::from_raw(0xFF);
+        assert!(status4.ready().into_bool());
+        assert!(status4.error().into_bool());
+        assert_eq!(status4.state(), 0x3);
+        assert_eq!(status4.reserved(), 0xF);
+        assert_eq!(status4.full_byte(), 0xFF);
+    }
+}

-- 
2.53.0

