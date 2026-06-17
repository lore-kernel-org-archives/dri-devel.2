Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD88CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F84010EA2A;
	Wed, 17 Jun 2026 14:03:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="r3zPR6Cm";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012044.outbound.protection.outlook.com
 [40.93.195.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0B6610EA2A
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 14:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXahZ0BM0ZHXkiVys5283lWnT29mwrXwCFlA2D0PbZG9dHZYagHpcvkKmtOtqJIfxwz8tX+5pyAPBrAZmfWiFUN+oBPBujMqDFeEYBnXdiy55NdInbF0ywxS0CxyLKVzjd1ic20fwQzicP5SI1zAtnisZ+szfUXrtPLRqEYf+zXAN3LYPjg/aFJzbhPNsglKrH63QzgWOiEsX51NTnzAjP+29bGmR2HBX940RAbbuTbPZSSt6tYz6hy1RVcDHunSBcPDcAx3isGmE6TklJIVpR8O8tVl3igwxj4wscv23ZmYQ+B6d9YRSXy5ofIzDNSZ/cceZT9LMDSaA+FFQtNZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZS80wOQ70xdXL8BiQxtYE8GAsm1DWVR4Hg4S3zOx6g=;
 b=Ynzik4NOZ/+y0g4JpawTOhEutaPvJFVYrKV7XeH8eBnNcFT2jEkmeGlm+CKfAEyKbXxdOQOgAqMUZONSV9ds8Hmz476+eFRsT3hKaJw9UaFCzYos+2V0xvEVBzObcHkl18WkoMQeK/pqVuuu73BcZwQxqEfMlH+0yiL3ryKb+8KtMA+yobFxF3Dm3xznRZUoH2FYC7CrC/yLFijb+LOyHInjTQ75B6nOHFikz5ENip0mXyASkipWGS7l4ZhqFSgdCIZXSh2H7LYnxT5t2BsiYu+SMWpovIl6jQEwljR560V6PnncvxRqB6B4SW95k0gt1D7TtDr5Ivac+SLER5f0Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZS80wOQ70xdXL8BiQxtYE8GAsm1DWVR4Hg4S3zOx6g=;
 b=r3zPR6Cm9HM4kZKPAgj7bN2tAILULpvLi3dxcHh0aPa3KrtOtJFxX07Vz+DGEwlQudfocD8WOO9Q0M6wvtr41c0clHchOGqT4oBi7jIX4+FQ+5C4AZEsb2WE8vw3BArnusssyWMX8duDlvBq1mLlqL5kXjU8lzN1TCkE36D40XoswYXweJMZsTEHR2vaCIwn5AJGuxi3bP/FsU+Wu9H57W77Da+T5DuKIkKNmWlbsGRpRZk2Y3OxgzYa6x/OZ7Ozbigc2k2gqP+h7NZMLhmJ5XoQ8xs0/qwh0gDGeayaW16CyztsKNYI391KQ+6ohAmQIXLAjD4A0N8Q6os2MqaGFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA5PPFCAFD069B8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 14:03:09 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 14:03:09 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 17 Jun 2026 23:02:34 +0900
Subject: [PATCH 2/2] gpu: nova-core: remove local bitfield macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-nova-bitfield-v1-2-ec10c6772666@nvidia.com>
References: <20260617-nova-bitfield-v1-0-ec10c6772666@nvidia.com>
In-Reply-To: <20260617-nova-bitfield-v1-0-ec10c6772666@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYWP286CA0009.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA5PPFCAFD069B8:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6df4f8-e145-485d-d261-08decc79297f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|10070799003|1800799024|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ekWTEG/+KPWiNAgDqdtveDSSDahlAw8DOj2FWtN1mu7XkAMYdwZWQTgeG6E4EhxPLGViwWpla6ByWtD1USljwidQ9MX0oYT70Qy5SIPf9NIWT6WfmQaPaNlv0LT1M5iPrPtPuBYfevTFMV/ECm9TvPTowLcDsPty+ofy9m1BfqvFDg2ohgokicrGPAHZ7gxgkeq1t+6/zPf4F1Wl5QIdnZ7M+2tW8ZXms0OEUNnh96EQiYBL7QnQN7Tb5uT0SQsqGwW6Um287GZri3uW8d9Hc16lvE6PVMQyA/AqTcT98lW2UsD1y0SlFPD8adtQ95DOiRvwlG2ZGm1xPD/B7J9Po/R1lGCYvqaUg+7VoXlFYsyZbQq81E4DcTxrkt7lV1sNAPkM74Sn3/Hc7dy7BBPle7TkFosxvdXX+tctcniHbU64fcRAEQESgKeFuATT5RIpc8HheXN4h8se24S0MNG/d01vBNLXbieJoh5scEtdag15pkBLNW0nZ8LeuGD7O/8sCKiCoUgZfyE243OM0SJvzAcaxv+//vprPfDmylDc8y3AWHUGTUd3Dn/SfJ6kSXoqqPs8ta4LHeBwpP0g86Lw7FW03wsybT4UG8TrhNG/RiEFatHCsI8xsSIP2l5UCbXByb6eoEGqOwjlhRE0jEPm1LSWLk9JLmYjnGhrqHEL9o5z8z69440J4Bx+AIDzh78TfsiOli9PnsIKA1V3V3dqKu8kSqh0sUtZRTGJ/uxc3mw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(10070799003)(1800799024)(921020)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGh2UG1PTkk1NEVDOHFOUGZUZnRlS1VqV21rSjk2Wk8xV0dBcTVNSTF3aWF0?=
 =?utf-8?B?ODJCMGt4WTk5MHc1NUx4bkdzQStVVnBYYnZSeFNPNXFRYzVCbGFBWjdFOGJo?=
 =?utf-8?B?SlNwRVdkcy9wV0o1Z3hMQ29ObldwYTVwSi91SkFQd2IrVTM5TzJiYkFPemp3?=
 =?utf-8?B?Zzh1S2U1enVNb0RsNSs5cWVlNFkrRkRsRCtLMkt4Z2RyVU8rUEoxS2xjU1Va?=
 =?utf-8?B?Uzl6T0N2eXFRU2lJeVowYStmL0hKeWN4VndDUFB2a0pTY0t0VXNNWEx3TnJ1?=
 =?utf-8?B?bmpTWWRaUll0TEZ1R1lLYmF6cEFnSW9pYkRORnFjU1VoaEtHRm5QaElaNmV5?=
 =?utf-8?B?ZEtld0FMMFdIaUpaL3d3Y2lHeXZjMFBzMDhEZkFlbGs2TytWOFVuUjk1TFpk?=
 =?utf-8?B?V203dWZBNkdobkJuRGdmZzh1NTNWazZCYWhsclB5OUdxNHNhczI2Mm5SVlgz?=
 =?utf-8?B?eWhQaTMxMTNxcnF0MUpOaC9DNjNTQWEyODlsazZaSGR5cWczWkJFdTU0Tko1?=
 =?utf-8?B?Y3M0M3lCMDZKOEJPUk9GMEdrdTRXOWZwYjFXL1o2T3UvUVFxMzNJQTBFTEpm?=
 =?utf-8?B?My9mNFZ3ZDk1WG4wdjVNY3JtUm5YTXRETFJUZTM1Y0puQjRqQ1NDQWFudW1T?=
 =?utf-8?B?L3FvNzdOOEVQeUxDMGF3dy84RkZYMzdra2dleXlVUXYzQ0hYcWZ2SW1wQmQ0?=
 =?utf-8?B?eDI3RHpOM3Z0QVFLTjZzMmIwZjVjMGNIcFJKa1NnMWFpdm01MDhiOEZGRzBS?=
 =?utf-8?B?SHRORVZoaUJyN2M2c240WS9GeGxSN3RLbjRhSVB6ZlQyaDA1UUM2RS9Fd3l3?=
 =?utf-8?B?ckVGa24ramxXWjk2ZVBrcUhRb2FyTGlIN0FLMGc4Vmk1MWFwWE5POG8vWTBj?=
 =?utf-8?B?K01yZlYvV1NkS21HclR6V0NsVEZjU3IrOG9TVC9ic05LNHdRVStTYmJwQ3JV?=
 =?utf-8?B?cXB5ZmFKREtMVmZYWFpndGdvZCt2dE12Wk1weWhPTnN2NGRpM1RWRHQ3Q1Vq?=
 =?utf-8?B?ZWRSZG5WRG5UUGVNVkhKYkc4RFpCZ3JQaC91RTFpQURVTWJlQVA1bWd0all6?=
 =?utf-8?B?anJYOWVLQzNEZWV3dnRRQmZkUnZWMjRwUVlRTGtwd0lzUzRBV2pqNU5VNjVF?=
 =?utf-8?B?TjNyNFFHQWpORmhob1NxWGk1djVFNkpYbDVCRmZ3NE1XdnlOR1lsUnlIRkcy?=
 =?utf-8?B?cFFOWjNvOW0zMnNra1UzQ0RFQXhuUmxFSTRLNFdudjlZUitObzNYanNGZ2N3?=
 =?utf-8?B?MElWY3d2Snl0czFaN0hiVzQxV2J1UVJ3ajMvemNXWTl2NnM4U3JNcFdtemNH?=
 =?utf-8?B?QmpEcHJ1Rjh3N1c1RUxJSEZBc25BcXVIU1Bndk1tTzRFSlJlVEVIVG1Ddzlo?=
 =?utf-8?B?aFk0b2VCTytESmJEdE84RU1oT1NWTHZUV0JxMGtxV25Lb1RkM216TmNzd3hV?=
 =?utf-8?B?Tko3ZlU2VC9hNjFiZ25jdFZkOXVCdkxRUmVKODdZZUZVcmg2ajJXdkhiOUQv?=
 =?utf-8?B?WnNrUUFFREc2aFpxcDhwNFN4QUVDQVZ1NDdrakNMWThsR01TS1pudDV5UlBK?=
 =?utf-8?B?Um01bU9VaXRYdTc5YU54ZG1rb2ZFVnFTNXFhWlZza1pBQUFoSHdXNnVmYjlP?=
 =?utf-8?B?eUZjVSt6VHorZ1Z4dXJva2FpSlJMS21keWxzK05oc3hTTVFKOWl6aWZEdy9t?=
 =?utf-8?B?Ukt5ZEJ2TzBsK2VORGhSM0FzRmNjUmZnbWpKc3lNWUhZVUIzTm85ZVRSYjR6?=
 =?utf-8?B?a2JwSis4TE9HNStQVkd4WHFRQXJEbFlaY3FuazVQNlJITU9FYlpydGh4TzRL?=
 =?utf-8?B?bHZvOG9rOTNTRVV5RjFzMHNTQnpyNDdRcm8xbG42VzV3bDVQeXpHQXcyMVFz?=
 =?utf-8?B?VkJyT2VHNUZXcERseDRXNVlKanVOTy9wRTE4NnZXVEpOamp2cnNncVVMYnhq?=
 =?utf-8?B?OW1XeU11QUd6NlRISlhuUFZ1a3R5RHR6eUtjaEQvRnkraEtQT2tWVGhHOTVB?=
 =?utf-8?B?dFdPNE5LNXJUQmtEOUhQYTNtM0JCK09WeDBrSnRRSThZNmpDRmRBVXNJY2ds?=
 =?utf-8?B?VkFkcFBkWUJucEd3clNwYTJmRVFTNlV1UnVESU9wR0k4VGVnUE16RHdLT1U1?=
 =?utf-8?B?SFJncUNxR29TZHN0NGF5YnhYY2k0WE5rUnJGc2VndUJORnFCcjVJeEJZWlhE?=
 =?utf-8?B?MG1UWWx5djc5bEFqQ1BEeTYzVml5Z1NFaEk1b3R1cWZKZDFBa1NJdmwyV1dI?=
 =?utf-8?B?alQ4bUNWYjJKYU8rc3BSemlhcXBDOVpVY29xenJlakI0aGJTU0EzNmo3dnNV?=
 =?utf-8?B?MVlqakcwOG5hL0NWU1VlM1BmWjN4U2NRZGJCWFhqc2FURXdVcTNSN3F2NU1W?=
 =?utf-8?Q?r2wllcpm+67RkJFYzzSMXE8Bv9Y25rUOPjVb1k6ELNXsB?=
X-MS-Exchange-AntiSpam-MessageData-1: s+s8JcSgau32LA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6df4f8-e145-485d-d261-08decc79297f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 14:03:09.5946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCuRGq1jk7c3rh2vN1qhlGNTNtPjBSI4rktX7HEAQ5BVLla49mkFzQyZndoPV3PakKqzEkG7hm8FS3jxvonRCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCAFD069B8
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

This module is now orphaned code, superseded by a kernel-global
implementation, so remove it.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/bitfield.rs | 329 --------------------------------------
 1 file changed, 329 deletions(-)

diff --git a/drivers/gpu/nova-core/bitfield.rs b/drivers/gpu/nova-core/bitfield.rs
deleted file mode 100644
index 660c3911402d..000000000000
--- a/drivers/gpu/nova-core/bitfield.rs
+++ /dev/null
@@ -1,329 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-//! Bitfield library for Rust structures
-//!
-//! Support for defining bitfields in Rust structures. Also used by the [`register!`] macro.
-
-/// Defines a struct with accessors to access bits within an inner unsigned integer.
-///
-/// # Syntax
-///
-/// ```rust
-/// use nova_core::bitfield;
-///
-/// #[derive(Debug, Clone, Copy, Default)]
-/// enum Mode {
-///     #[default]
-///     Low = 0,
-///     High = 1,
-///     Auto = 2,
-/// }
-///
-/// impl TryFrom<u8> for Mode {
-///     type Error = u8;
-///     fn try_from(value: u8) -> Result<Self, Self::Error> {
-///         match value {
-///             0 => Ok(Mode::Low),
-///             1 => Ok(Mode::High),
-///             2 => Ok(Mode::Auto),
-///             _ => Err(value),
-///         }
-///     }
-/// }
-///
-/// impl From<Mode> for u8 {
-///     fn from(mode: Mode) -> u8 {
-///         mode as u8
-///     }
-/// }
-///
-/// #[derive(Debug, Clone, Copy, Default)]
-/// enum State {
-///     #[default]
-///     Inactive = 0,
-///     Active = 1,
-/// }
-///
-/// impl From<bool> for State {
-///     fn from(value: bool) -> Self {
-///         if value { State::Active } else { State::Inactive }
-///     }
-/// }
-///
-/// impl From<State> for bool {
-///     fn from(state: State) -> bool {
-///         match state {
-///             State::Inactive => false,
-///             State::Active => true,
-///         }
-///     }
-/// }
-///
-/// bitfield! {
-///     pub struct ControlReg(u32) {
-///         7:7 state as bool => State;
-///         3:0 mode as u8 ?=> Mode;
-///     }
-/// }
-/// ```
-///
-/// This generates a struct with:
-/// - Field accessors: `mode()`, `state()`, etc.
-/// - Field setters: `set_mode()`, `set_state()`, etc. (supports chaining with builder pattern).
-///   Note that the compiler will error out if the size of the setter's arg exceeds the
-///   struct's storage size.
-/// - Debug and Default implementations.
-///
-/// Note: Field accessors and setters inherit the same visibility as the struct itself.
-/// In the example above, both `mode()` and `set_mode()` methods will be `pub`.
-///
-/// Fields are defined as follows:
-///
-/// - `as <type>` simply returns the field value casted to <type>, typically `u32`, `u16`, `u8` or
-///   `bool`. Note that `bool` fields must have a range of 1 bit.
-/// - `as <type> => <into_type>` calls `<into_type>`'s `From::<<type>>` implementation and returns
-///   the result.
-/// - `as <type> ?=> <try_into_type>` calls `<try_into_type>`'s `TryFrom::<<type>>` implementation
-///   and returns the result. This is useful with fields for which not all values are valid.
-macro_rules! bitfield {
-    // Main entry point - defines the bitfield struct with fields
-    ($vis:vis struct $name:ident($storage:ty) $(, $comment:literal)? { $($fields:tt)* }) => {
-        bitfield!(@core $vis $name $storage $(, $comment)? { $($fields)* });
-    };
-
-    // All rules below are helpers.
-
-    // Defines the wrapper `$name` type, as well as its relevant implementations (`Debug`,
-    // `Default`, and conversion to the value type) and field accessor methods.
-    (@core $vis:vis $name:ident $storage:ty $(, $comment:literal)? { $($fields:tt)* }) => {
-        $(
-        #[doc=$comment]
-        )?
-        #[repr(transparent)]
-        #[derive(Clone, Copy)]
-        $vis struct $name($storage);
-
-        impl ::core::convert::From<$name> for $storage {
-            fn from(val: $name) -> $storage {
-                val.0
-            }
-        }
-
-        bitfield!(@fields_dispatcher $vis $name $storage { $($fields)* });
-    };
-
-    // Captures the fields and passes them to all the implementers that require field information.
-    //
-    // Used to simplify the matching rules for implementers, so they don't need to match the entire
-    // complex fields rule even though they only make use of part of it.
-    (@fields_dispatcher $vis:vis $name:ident $storage:ty {
-        $($hi:tt:$lo:tt $field:ident as $type:tt
-            $(?=> $try_into_type:ty)?
-            $(=> $into_type:ty)?
-            $(, $comment:literal)?
-        ;
-        )*
-    }
-    ) => {
-        bitfield!(@field_accessors $vis $name $storage {
-            $(
-                $hi:$lo $field as $type
-                $(?=> $try_into_type)?
-                $(=> $into_type)?
-                $(, $comment)?
-            ;
-            )*
-        });
-        bitfield!(@debug $name { $($field;)* });
-        bitfield!(@default $name { $($field;)* });
-    };
-
-    // Defines all the field getter/setter methods for `$name`.
-    (
-        @field_accessors $vis:vis $name:ident $storage:ty {
-        $($hi:tt:$lo:tt $field:ident as $type:tt
-            $(?=> $try_into_type:ty)?
-            $(=> $into_type:ty)?
-            $(, $comment:literal)?
-        ;
-        )*
-        }
-    ) => {
-        $(
-            bitfield!(@check_field_bounds $hi:$lo $field as $type);
-        )*
-
-        #[allow(dead_code)]
-        impl $name {
-            $(
-            bitfield!(@field_accessor $vis $name $storage, $hi:$lo $field as $type
-                $(?=> $try_into_type)?
-                $(=> $into_type)?
-                $(, $comment)?
-                ;
-            );
-            )*
-        }
-    };
-
-    // Boolean fields must have `$hi == $lo`.
-    (@check_field_bounds $hi:tt:$lo:tt $field:ident as bool) => {
-        #[allow(clippy::eq_op)]
-        const _: () = {
-            ::kernel::build_assert::build_assert!(
-                $hi == $lo,
-                concat!("boolean field `", stringify!($field), "` covers more than one bit")
-            );
-        };
-    };
-
-    // Non-boolean fields must have `$hi >= $lo`.
-    (@check_field_bounds $hi:tt:$lo:tt $field:ident as $type:tt) => {
-        #[allow(clippy::eq_op)]
-        const _: () = {
-            ::kernel::build_assert::build_assert!(
-                $hi >= $lo,
-                concat!("field `", stringify!($field), "`'s MSB is smaller than its LSB")
-            );
-        };
-    };
-
-    // Catches fields defined as `bool` and convert them into a boolean value.
-    (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as bool
-            => $into_type:ty $(, $comment:literal)?;
-    ) => {
-        bitfield!(
-            @leaf_accessor $vis $name $storage, $hi:$lo $field
-            { |f| <$into_type>::from(f != 0) }
-            bool $into_type => $into_type $(, $comment)?;
-        );
-    };
-
-    // Shortcut for fields defined as `bool` without the `=>` syntax.
-    (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as bool
-            $(, $comment:literal)?;
-    ) => {
-        bitfield!(
-            @field_accessor $vis $name $storage, $hi:$lo $field as bool => bool $(, $comment)?;
-        );
-    };
-
-    // Catches the `?=>` syntax for non-boolean fields.
-    (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as $type:tt
-            ?=> $try_into_type:ty $(, $comment:literal)?;
-    ) => {
-        bitfield!(@leaf_accessor $vis $name $storage, $hi:$lo $field
-            { |f| <$try_into_type>::try_from(f as $type) } $type $try_into_type =>
-            ::core::result::Result<
-                $try_into_type,
-                <$try_into_type as ::core::convert::TryFrom<$type>>::Error
-            >
-            $(, $comment)?;);
-    };
-
-    // Catches the `=>` syntax for non-boolean fields.
-    (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as $type:tt
-            => $into_type:ty $(, $comment:literal)?;
-    ) => {
-        bitfield!(@leaf_accessor $vis $name $storage, $hi:$lo $field
-            { |f| <$into_type>::from(f as $type) } $type $into_type => $into_type $(, $comment)?;);
-    };
-
-    // Shortcut for non-boolean fields defined without the `=>` or `?=>` syntax.
-    (
-        @field_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident as $type:tt
-            $(, $comment:literal)?;
-    ) => {
-        bitfield!(
-            @field_accessor $vis $name $storage, $hi:$lo $field as $type => $type $(, $comment)?;
-        );
-    };
-
-    // Generates the accessor methods for a single field.
-    (
-        @leaf_accessor $vis:vis $name:ident $storage:ty, $hi:tt:$lo:tt $field:ident
-            { $process:expr } $prim_type:tt $to_type:ty => $res_type:ty $(, $comment:literal)?;
-    ) => {
-        ::kernel::macros::paste!(
-        const [<$field:upper _RANGE>]: ::core::ops::RangeInclusive<u8> = $lo..=$hi;
-        const [<$field:upper _MASK>]: $storage = {
-            // Generate mask for shifting
-            match ::core::mem::size_of::<$storage>() {
-                1 => ::kernel::bits::genmask_u8($lo..=$hi) as $storage,
-                2 => ::kernel::bits::genmask_u16($lo..=$hi) as $storage,
-                4 => ::kernel::bits::genmask_u32($lo..=$hi) as $storage,
-                8 => ::kernel::bits::genmask_u64($lo..=$hi) as $storage,
-                _ => ::kernel::build_error!("Unsupported storage type size")
-            }
-        };
-        const [<$field:upper _SHIFT>]: u32 = $lo;
-        );
-
-        $(
-        #[doc="Returns the value of this field:"]
-        #[doc=$comment]
-        )?
-        #[inline(always)]
-        $vis fn $field(self) -> $res_type {
-            ::kernel::macros::paste!(
-            const MASK: $storage = $name::[<$field:upper _MASK>];
-            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
-            );
-            let field = ((self.0 & MASK) >> SHIFT);
-
-            $process(field)
-        }
-
-        ::kernel::macros::paste!(
-        $(
-        #[doc="Sets the value of this field:"]
-        #[doc=$comment]
-        )?
-        #[inline(always)]
-        $vis fn [<set_ $field>](mut self, value: $to_type) -> Self {
-            const MASK: $storage = $name::[<$field:upper _MASK>];
-            const SHIFT: u32 = $name::[<$field:upper _SHIFT>];
-            let value = ($storage::from($prim_type::from(value)) << SHIFT) & MASK;
-            self.0 = (self.0 & !MASK) | value;
-
-            self
-        }
-        );
-    };
-
-    // Generates the `Debug` implementation for `$name`.
-    (@debug $name:ident { $($field:ident;)* }) => {
-        impl ::kernel::fmt::Debug for $name {
-            fn fmt(&self, f: &mut ::kernel::fmt::Formatter<'_>) -> ::kernel::fmt::Result {
-                f.debug_struct(stringify!($name))
-                    .field("<raw>", &::kernel::prelude::fmt!("{:#x}", &self.0))
-                $(
-                    .field(stringify!($field), &self.$field())
-                )*
-                    .finish()
-            }
-        }
-    };
-
-    // Generates the `Default` implementation for `$name`.
-    (@default $name:ident { $($field:ident;)* }) => {
-        /// Returns a value for the bitfield where all fields are set to their default value.
-        impl ::core::default::Default for $name {
-            fn default() -> Self {
-                let value = Self(Default::default());
-
-                ::kernel::macros::paste!(
-                $(
-                let value = value.[<set_ $field>](Default::default());
-                )*
-                );
-
-                value
-            }
-        }
-    };
-}

-- 
2.54.0

