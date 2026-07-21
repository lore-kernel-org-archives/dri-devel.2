Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EC8C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 591BB10E90D;
	Tue, 21 Jul 2026 11:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ST93bLG2";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012018.outbound.protection.outlook.com
 [40.93.195.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F0B10E90E
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:01:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obGR8xw6mjkdlVrtgUKjShiayokoy7vd3+Pd8ohGrRsWZ5yAPFWexgDPKRtpqAcHrS6kXfsbVYGiXjcYj7lv3PXLJ6f2hJ4PAlcgVB2pjgZTixzVqL7dbWsFckDpdkqqoSP2aLrYCwX6/uJgFq/s+kTIGpEaPPjhsa/czW3VWxK83wSag2qYvFopEWTRNDnvT8g/28HL4sWnuAOIAUfjabF5OVbps8VwTBHq1oLN37TOChjDdls4MbRJjSZdHVrjP7+9SMHlXKzRh6tKgOl2ELE2ZwLQzjv9gPSBZmTkKH4qD3wk9dVxVx4bVNb8HmwP4d43tn7tLdj6CrV5syIa9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiIXc3wRV0bBy7/4f+ir2NnrA7JRfyv0NDCWqXY2CL0=;
 b=d0WH2wNy9QBrkS16Hu35Ptwclpi6xVcZ9K3F6qLUOQGjjAkSXVh3s37c0UIjb9Yaf5t1dgiBdbBZs7cttAIaVmM02vNX+SMk4/eK9AIO/CDTrg5DlM/nambqmsHJyOHLyhnrEw7dohGNxfd/XLWarOyEcO84+m3XPH6npOYyS1ORfDvHWKVfs8a1t7e2g3U4qSA3v3ZH9rufE20dXwwP7/L1e4kR2TnNIWK7vXFvckosaPopYfugXeeL48asadT8sD34WSlo/7AE/lGidbfrFn05a2SCKNeGzk76USDEY8UiWHNDVa9+HMYpZ8wqMuTDi8aXl+dtQECouH2zVbpsAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiIXc3wRV0bBy7/4f+ir2NnrA7JRfyv0NDCWqXY2CL0=;
 b=ST93bLG2HecX3tz75D/b0Stfr3j5ExQ+kRTgCBWYqB2b+wqdfM5LVOjlnCnH2QFYTBftoy9dJI/4dt5qe7bEbmhj3TQ77aTPxeiXFzUYRSLEh+8E7Z9srJwYcYcp4RRYbhI4ckrS0tJ2n4A+qL/O7K1U0rN/qhLlzMcNGGnST7Tmdbu34qeV3nuidkEESEMkAz04wsPbQnO9jQFjqyQoFcc1aBIGZLBihjgOBNn7sYgJ/+2tJd+28uKnu7hEi/ysmzPkiD52SlR5uFZETghtSPDE6CuF3VUwZtLM7JvEPgmrNvVzhhImEk5/oQcIZ+0IbMeUaNOPN23afhUZ+YnGKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 11:01:12 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 11:01:12 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 21 Jul 2026 04:00:15 -0700
Subject: [PATCH 6/8] rust: io: register: use new relative base syntax in
 doc and examples
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-registers_fix-v1-6-3711b2317e1f@nvidia.com>
References: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
In-Reply-To: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3cf7f3-e69e-43de-4c2e-08dee7176029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|11063799006|10067099003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 54KKaLRQPMRcfJTsPbdVGxw4imMAv5M3wGQQx3TvHK0S45mLT/JgujOJ4uNxdmavXBX47tmK73yd7Sbcb5OIbzBheuMm7AnKSbR5OFaurTHvyL3/JLHgh7fATtAROmFxItrXr2rECokzIuDEJgZA1uouMfGB/lz01Jr0HpuZInG7IWGt4FdFonQ3uz3tTStbIu4pzB6sqQmhOH1PVK2GqYo6HSoYp1kcxPP3dmKFZToOLN1hfN35R7znq0L+NlKYHEr2DcY8wREc3xT/6tc93N7Y0FECFKPmgIpjlD3N5pUvYpmq9WJ//woCo49hJ8HA8MeJ7E5iJiCnwnloeb6y9aOY0tbNNOnOf2mR8EQfFCFnuSgtr9Tzypw674okKJ7u4UGajGBhOq5RWwXeqzVufcn0Ua7yM12mbEj1FJ+FeUOJSuVOAgVFvFduotoLq51kBw8CVnEKm70yc62xwCwgk/UdZzO84X0YQ8L2iqUMW06Pnjuu8Aba7N0pclckOX/rL7QrO4RNLG0Vxu3/dYjziP2rKiVRQN/cE884VXAXvfFpOPw7DKJrGCM9kCLsjbi1wpR9uk0i9/ZNDnREu2lY8piiGLUUJ61o0+ouCgQUvtaW7KblW2kpfvA+N0Y5kKz4uaND2NwybsHTLMdhUAkc9jQtSN9aPUMMqOtZ/w7DCf0rUI42p82nMGFBtbrp6Yq278kn6/nbycHGP3m+FHVXcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3lGbDhCQTBmM1gvcVZkVGFTWDRxRXVLdnpheVRKNU5oUzlEalgvcm8wZ0RW?=
 =?utf-8?B?TXNjVElIcXlEVUZ1Qy8zNjI4Y0hMdE96Q2ptWTB2VHlWZmNrRDNiQkwwSkR2?=
 =?utf-8?B?TXJLVHFWQ2kzT2hWaTJKb2RnOEVYUVlzaVBCMUJCVXlLYW5VMlJrcG01Z1pO?=
 =?utf-8?B?WjhyRWdYYXpwQWxRTUdnRVkxRFV3ZXRTa3VLQktaMm5lMm5ON3d2cjM5WEtD?=
 =?utf-8?B?c1hXUHlwY2FVZGdzMkZ2NHhpVHVjVHIwbjlOd0NFcVEzdEw2MDlTM1l2WEo1?=
 =?utf-8?B?U2drVW1Cd0FJc25CYTBNN3dwaE1TWkhQNCtCVUhjcWhnZHlXenY0TjJDTXVW?=
 =?utf-8?B?bzlzU0QzaFlLWHdTeXNmYmlZTU5FSlliMERxUW9qMVhncEFnTXlYZVFEa09V?=
 =?utf-8?B?Nm5NWGxQS05DQzhwZ3ZCOFJpM2NSV3dCQXNsNjkrbTFZM2xaSFJCbGRJV0xZ?=
 =?utf-8?B?YnNLLzhXbUlFT3ZSdTJzWmxIOTZxbzZxUWgwQWdQZ3V4TlErakw3VCtLSWdi?=
 =?utf-8?B?dVJiVm9PTWdMUVlSWG1JTmZlcTdrWENyR0x2MERmdHhpazNwUFVJdFZtZC9C?=
 =?utf-8?B?Z0QzUWdBMWV3cEdQY2g4QmgwSXFtNVQxZkFTUkdWWU0xanZBUmlXeXczTjd5?=
 =?utf-8?B?UGQzdVk4Y2VqY3B6SXpIVFY1K2RPd3pkYjkyUzlGQVM1TUVXb2ZPcXhyUUI1?=
 =?utf-8?B?MlpCTThXQ25kem5peHVtK0lTV3V3ODZXaEU4S04wd2xjemhuWjc0YVoreFh5?=
 =?utf-8?B?YmNzYmpENEJrQ0FyOXJocHJrQktVZ3JjY0dEay9xb0pHam1waklFK1VyR2w2?=
 =?utf-8?B?YmRTWGQ2Z2ErQWthS3crSGxOWEgrZCsxcGVMUUR6TkpRVzRCUUtsemx3T0la?=
 =?utf-8?B?SExEZWlGS0h2aE4vVkdsT0l6bE1jMGZSQm5lWE9BQXpEdldBUEdkUnZwbFdW?=
 =?utf-8?B?UVZtdi9UYUVlWkIvdlBXTnplRUZBcWVNZW5rVzM1QWhFZXUzRElOYXZkd2o3?=
 =?utf-8?B?Y3RneENURjVKY0llbnlEQXk4ZW1wSUNpVVJBTEUweXJGNDV5ZXMwb3F5R21Q?=
 =?utf-8?B?b2RGQ0FYei9TcE4zaVlVOXNiWmZMdE9GOEVnNEtEZXA5eWkxRkZ0VkdQdlVH?=
 =?utf-8?B?aUt4K0ZHSmV4a3B5NWhkWUw3NTI2eXJYcWUwNXcxRFFwNzV5VWZGNkkzcWRz?=
 =?utf-8?B?R3lpL1orM0JVb0l5c08wZkR5dGNDY1JTdktvcGpCeDNCQjZkaFFyQ3J4UVY1?=
 =?utf-8?B?TU9Ybzl1SmRlbWVwNER5MTVFNzFKR3hJV291KzRGdUJ6VEpLVWNWaWdZZHYy?=
 =?utf-8?B?ZGhvTTN4Lzhmb081ekNhNk1BR0c1aFRGWVZJN2tlMzdpMUNCRGZhMVZQRW1i?=
 =?utf-8?B?OTVyOVhHcDdTQlo5SXc4QWl4TDF3TlJQNTRaS0orRXZDMm5vZVA4TVhPelEy?=
 =?utf-8?B?QXJncnc0cXNtYTBDTkRKeFhqcG9hNDhDazJXZDBKVmVBaEMrVVQ4NVY4Yi9v?=
 =?utf-8?B?aE1rQTFQOUpNcThKZG9KUnE1eUFFMUI2S2dyWVFvZm9kUFozRG9kaHl2R3pJ?=
 =?utf-8?B?Q0UvUzJSWjhkVnJuaGp4ejZUN3g4OXJ1U2hwTjRRSmF3ODBHRkFNZERJc0o5?=
 =?utf-8?B?VTZQcFNnc1p0V0N2YVJFL0ZMUzQ5U254RVYvbmZ3Y1ZwY3YrNU4rQmxxL1Uw?=
 =?utf-8?B?b2ozVzUvNkFYRzVaNXNDZkZEQlIzcDJjZWt1d0h1amZUQmFibWIwdWJ3dkdL?=
 =?utf-8?B?UVorUlppbXFMLzgzbi9WRXc1NG5wb0hqUDlZVFBHYXNOeWoxN3ZTbFlXcHNq?=
 =?utf-8?B?dnY1dkcwV2pVVFVzRTZoU1F2Tm1zZFJsTW5DOUVJVG1Fb1QydWw5THBYSlV3?=
 =?utf-8?B?WkdsdTlaRElUWDdJbksvODQzRko1UDU3ZXI5T0x1MndZZVpGZnNWL0hWVkdw?=
 =?utf-8?B?M1EyTGIyeExDRDJGZWtPZ1VhOHpTUjBocHNCcDhXbFRpT0xJYUdsOEJia3V0?=
 =?utf-8?B?WHdGNXFWbnJVVGVlMUpFaW9KRHoyYmlVYzAzZTFTdzRva01mS1dHcFQ4MTFH?=
 =?utf-8?B?elJQUU5LelhLY0hIRExTQlRNeTdxN1hXam1wSklRbmVZcE9Gc1E1aFpaenNo?=
 =?utf-8?B?aC9RdFR2ajJ0MW5uUmFybUs2ejV6VjVEeEV1SVUwOGlmY0JBdFNTZDhmYXFp?=
 =?utf-8?B?bEJqNTNmN3M4NzA3Sk9TL3drUkdlT2RudEp6S1ExdWxNcjFENzg5cHNOQTVY?=
 =?utf-8?B?c05IQ3IzdjhEcTlTcDZjZi94R25vb2ZCOGd6eWg1U0IvUzFEd3FHSlF4SnBJ?=
 =?utf-8?B?K0tlU0lUTitlSUtuTFd3TDdsRHAvUXFrbWtSQjRIaGJHU1Nha2VWZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3cf7f3-e69e-43de-4c2e-08dee7176029
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:01:12.0195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bLeUtJYvO+cWAQenVdwt9acBQw4dydrd58ITElYsORPCiChpheLmkSfhUbFOhVjvdcnznw7YB4rDznrx5W0Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
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

Convert the documentation and examples to use the new `Base:` syntax to
specify relative registers bases.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io/register.rs | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 4070fabb00f4..eeb7f859f8b9 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -527,11 +527,11 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// space segment. Since both instances of `CPU_CTL` share the same layout, we don't want to define
 /// them twice and would prefer a way to select which one to use from a single definition.
 ///
-/// This can be done using the `Base + Offset` syntax when specifying the register's address:
+/// This can be done using the `Base: Offset` syntax when specifying the register's address:
 ///
 /// ```ignore
 /// register! {
-///     pub RELATIVE_REG(u32) @ Base + 0x80 {
+///     pub RELATIVE_REG(u32) @ Base: 0x80 {
 ///         ...
 ///     }
 /// }
@@ -579,7 +579,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// // This makes `CPU_CTL` accessible from all implementors of `RegisterBase<CpuCtlBase>`.
 /// register! {
 ///     /// CPU core control.
-///     pub CPU_CTL(u32) @ CpuCtlBase + 0x10 {
+///     pub CPU_CTL(u32) @ CpuCtlBase: 0x10 {
 ///         0:0 start;
 ///     }
 /// }
@@ -595,7 +595,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// // Aliases can also be defined for relative register.
 /// register! {
 ///     /// Alias to CPU core control.
-///     pub CPU_CTL_ALIAS(u32) => CpuCtlBase + CPU_CTL {
+///     pub CPU_CTL_ALIAS(u32) => CpuCtlBase: CPU_CTL {
 ///         /// Start the aliased CPU core.
 ///         1:1 alias_start;
 ///     }
@@ -703,7 +703,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///
 /// ```ignore
 /// register! {
-///     pub RELATIVE_REGISTER_ARRAY(u8)[10, stride = 4] @ Base + 0x100 {
+///     pub RELATIVE_REGISTER_ARRAY(u8)[10, stride = 4] @ Base: 0x100 {
 ///         ...
 ///     }
 /// }
@@ -747,7 +747,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// // 64 per-cpu scratch registers, arranged as a contiguous array.
 /// register! {
 ///     /// Per-CPU scratch registers.
-///     pub CPU_SCRATCH(u32)[64] @ CpuCtlBase + 0x00000080 {
+///     pub CPU_SCRATCH(u32)[64] @ CpuCtlBase: 0x00000080 {
 ///         31:0 value;
 ///     }
 /// }
@@ -774,7 +774,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// // Alias to `SCRATCH[8]` used to convey the firmware exit code.
 /// register! {
 ///     /// Per-CPU firmware exit status code.
-///     pub CPU_FIRMWARE_STATUS(u32) => CpuCtlBase + CPU_SCRATCH[8] {
+///     pub CPU_FIRMWARE_STATUS(u32) => CpuCtlBase: CPU_SCRATCH[8] {
 ///         7:0 status;
 ///     }
 /// }
@@ -784,12 +784,12 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 /// // registers of the two declarations below are interleaved.
 /// register! {
 ///     /// Scratch registers bank 0.
-///     pub CPU_SCRATCH_INTERLEAVED_0(u32)[16, stride = 8] @ CpuCtlBase + 0x00000d00 {
+///     pub CPU_SCRATCH_INTERLEAVED_0(u32)[16, stride = 8] @ CpuCtlBase: 0x00000d00 {
 ///         31:0 value;
 ///     }
 ///
 ///     /// Scratch registers bank 1.
-///     pub CPU_SCRATCH_INTERLEAVED_1(u32)[16, stride = 8] @ CpuCtlBase + 0x00000d04 {
+///     pub CPU_SCRATCH_INTERLEAVED_1(u32)[16, stride = 8] @ CpuCtlBase: 0x00000d04 {
 ///         31:0 value;
 ///     }
 /// }

-- 
2.55.0

