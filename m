Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6FFF31E22
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C31F210E0B6;
	Thu,  9 Apr 2026 14:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="O7sMHnRh";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011045.outbound.protection.outlook.com
 [40.93.194.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD1DE10E80F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 14:59:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVlrwKyrAWtHPhLlqNzVyEPG9hYGLxNvw95ZwcOmpcJLJL/JYUvDjdhqGGrdliB5w4wsqVWF0+NNAAvVgoOos06jT6n8B/Ty9co7mj/jd/8lH7gd/rVtEPtE2EAp2maw/oqt6wirvLhYCs2wmOcpp16xz3yKkPYmg6GaQZlXAQW9BOHSDtpB1FUKMV9DYu0qqiEvf4dAHhK6RT/7LfvhBkszQZEQ8RWDAD1Tw9OCpGYxUTrZp0vmjBS9og16XjF51RM5vXMP9/z/dFdm88bvjEeMqn22tk/13EmoCKyizOFpf1gO/5JRAieqZkIPEcRpxOYfhMylkBrGJRRiL8ooKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7z2YsToT91058w/5l9DEp07viQW9hZspBoLY9bPR790=;
 b=GwmSdPx0LO8vN7AVerrJjat4B/P8ogBiv4P60WaQlh/jbaduEgFENqgcXy5YkDPoHAgYnsm/4rLdpdOjWTDR94Ta7h3UN6yHRxw5EmAIe672eWFlmho8hMFRLetMyDkYqYgzAShQsy/nncUyGcvKeKkYN1jfl5NyinnWROtiZX1Al51/X5Aysod+WiLf7NJzXiC4UwiMNvX34zXcTe4UHOTDMFZ59gl3Km8Ynwb5r7bj6KykfW4xPH89XhAJPS0WP4Bp1gfzVTfFeIcZQ9eEXjVCXKD9d6Sgju4GrptMIa3uZhBlkHApACBho2gOIQy82yk9TjsdTknupIqzdoE6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7z2YsToT91058w/5l9DEp07viQW9hZspBoLY9bPR790=;
 b=O7sMHnRhy5yzG4LiTWVnH/vsRcwakzzNae38ocMivoZgjQxRG0jyC85s0wFNjv3GLgIB49YC90s6DdVBmhtoprMFkfZ0c17X8M0rPXBJR+VzC0DeZBbuj9IMayLKNAFjufO4fZo5ODTICyzoO1wHqFumFks2zwHCogAgJIRCqfGymxrTF5bg6NP04VPSPe+YtaYsdNd8fQFSUhUjfD7OHhG2TMtYFpdSQQjWw6oDs6bY9Q1E8X1JE+7MkyIJ26P2YkQMGnis4AIGt0Ll4MMcycCZ3IpfqDzDD/c2Dt9lIP/UgvD7C7s3aFIHtcRcOrpvysOZ+DIzB/wmKEpXHotJoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 14:59:05 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 14:59:04 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 09 Apr 2026 23:58:47 +0900
Subject: [PATCH v2 1/3] rust: extract `bitfield!` macro from `register!`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260409-bitfield-v2-1-23ac400071cb@nvidia.com>
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
X-ClientProxiedBy: TYCPR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:2::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f878d5-0d52-4216-a722-08de96488adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|10070799003|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2n3wsLD5sfrEkHIuU6ZPDTRLqnHZAtS0JeVrdzq7LAisteSf1l6mpM6VO1G/Jn0/4dYsx9FVSGQ3Wr01ydxxlGhblbOKjpl4q9zGBX9GU/oL4C8dLt3lUs+MV7uMQopv2K97dVuc3CsFvgy8YXoXU4c3FSAJxVrSTJLe3KQbNWqoxpOgrKkaEPIATEheQnmoPplrnfxqZuaAoxd0Ez4SxOuDUThDJBeof1uXkoI9xixZFCtxL8d9fcXDZUoAYGXoF4p5FH4GoQf4RgISl/l0cmu209B5ScRCGAynGP41kIJ8f2V8zYyL7kFI4m2tUGpfonrpWgRLg7zXj3ppu+Lj1gcYL9ADnAOH2vnI0QlDbHQiPVkYcVeNsu9X0CEHiwC0U2y4e+BS0HEANGLrM902V+6/2f/P7mx8EXNjjk4usDRfooW2TXmNe3pRMKtPhAkg3qZBR/s/hluZ7GODLo2Gs3FnrdJgGCwwcC0gRW43JVhoSPAX1zL7UvUOaMhrkFg2TPTUemcf0mVNP1Oc8S8nhag51TbIIIixkLV2PMiM4stSO1sAvGZCGEAAw/HnU+0GX9Zwr/lqDCUGt/m8v8BsxJ2ZJ8VPKA/r1TgBjc5yk1Vdl0emJca22dSsHbLQxpXpLO5LfhWPS8hlBinjLZ+h4SR2CoRNZn1H+UT/HMFqYriz1GnDg6HL9r+jFHQKmQNodAUuQo215OkA2li4CbmmDXasn4wxQs6xlH0P3ebD1jsAm5it4z92iSViJifzkEGeVu+P76fruNA9LkKyRXA47A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlZEZlhteFNjRm1MdWpPZktTdTQ0OGF5RnZsT3J0RWwrdUR0UCsxeUZ6VDU4?=
 =?utf-8?B?MjRhcnE2aVc4azQvYUVJc2t4My8yTmZacjVSOTVBTUVGL1NwaEtEemZJOG5j?=
 =?utf-8?B?RVE4WnBKaVdGb2N4dUtiTG96bVBLVHppTHg3c2VSeFZIY1lncXh2SXJPRWJo?=
 =?utf-8?B?N0VyU25oSnNYYlhmclpCdnJzQVJhOXNMZ0NtbFBzSSsvb1Z0ck0zREQvK0Ru?=
 =?utf-8?B?OURMWFRPUmlSOXVYODVYSTBLL3hYWDVuTnJFYmpNdWN4dHVKRDNscC80TTFl?=
 =?utf-8?B?T3ZLRVNLMUhuNUcrZDkrRWJacERXQ0dKMy9KdGFNL3RJaDVzdUhpZ1A2aDZF?=
 =?utf-8?B?ekhKL2l5TmJGS2M4T0pmRWMzZFN1N1RMTE5FN0x1VUlFNzZGaEhEQjNqNjVZ?=
 =?utf-8?B?ZjhEZUFnaWkrSlp5cHUzWjdtV0p2c0d2NlhCL3JSRS80MDhWQ21kaDJ4RHdn?=
 =?utf-8?B?M0phbmZGSHBEZkxsNjdVQ1ZIK005WVk0YjNkTlZpRGdaKzUwU0QyWllZUnR2?=
 =?utf-8?B?TE1ES0pQcVMyQlE4ZHhtQXJBdlhnaGp0SFFWbVFhZkkreVY5Um9yQW94bUl4?=
 =?utf-8?B?a2NmTTA4bnhOZUJJdklucXZLdXR0VFdTK2V2ZTB2WHJFbnR6ZkJNcFQ4M3Vn?=
 =?utf-8?B?RjNjcURlMDVKU2RzMVFTb0ZudW8xT0hzQSsxclZlR0V0MHRGb0lWL1cvRGtM?=
 =?utf-8?B?S0lkRk50dEpVM1NhM2FZTWRwV1hreFZDeVFYQkhXUkJxY2lmZlZqRExtRHNr?=
 =?utf-8?B?M0pVZ2J2bjdtMzhGSU1JVnBGeitNVldxVkxVM2YvYjV3ZDI1dFA4QlBCWENQ?=
 =?utf-8?B?dWFaRml2ME9iYTdpUkxzN0ZscmRyOHhidWYwdmRYWjR3TVJLbmJhc3NnZXRp?=
 =?utf-8?B?MTB3OWc5Q3c5anFLVmZleWdsa1duL1AycHhCb3pMWTFIam9RcHMzZHBKN2Rn?=
 =?utf-8?B?ZXdaZGQ1aktMY2Qza0hSUnZDWHAxUU5CMElJSnpqb1haRy9tcjY3ZGR5cUJR?=
 =?utf-8?B?LzdadWVZTW5kQnNrWVl2Q0FuOEFhbXArRFluaDJ0NmtkSzV5VVpnZWFTYldl?=
 =?utf-8?B?cDFXaFRqdmZLQ2VMTVRQdXJqakpML3pTeGR3YUtzYnNjUmRVL2pjWGFtbkJt?=
 =?utf-8?B?NFJ3WmRqbEhlUkJPM0ZkZW5BeEJPSEE4MWN1ak84bVRQWlpzQkZBVk5KZUVZ?=
 =?utf-8?B?citNZGlSQ3pLL2FqNFQ2TTZ2RFRhYnNFaEFyMFA0akVadm14WFc1RVliQjkz?=
 =?utf-8?B?Y2dSYzVFNVV5QUg4NXFhZXgyVmtFWnlyRkRyeVM3d2R3a2R2MU1WcUF3QktV?=
 =?utf-8?B?KzI0dFNOam5IaUUzVmJsamtoRkxyYVFFYUhTMWVmVU44Sm1MZlFiZUJNUFQ1?=
 =?utf-8?B?MmFqUk44SHl2SzgxeXYwaXFYZzlTYUU3UXl2TXpvQlZOM1RPd0pZQW5iNzAw?=
 =?utf-8?B?SnluckIrQTA2TzlvUU4xbVJRQTAzVjNnTlM5WEkxUXFOM0NIZlQxL1hmV0F1?=
 =?utf-8?B?dWs4eHRpUENnYXhEc09rVmxaZXFJTDJ5Y0FMaUQybEJwU3pzRkJrMUlLeVBj?=
 =?utf-8?B?bDg5cnYybk1aOUd3SDdoQVNVTWUrQi9HTzREZ3kyWFM3Wkk5YUJ1VTNJdTNY?=
 =?utf-8?B?N2l4cUJEdWp5WFVxUWwrUEpQMXZ3cXFyUXdMUHdYTDNsZU9Sb2xtMVJTM3BL?=
 =?utf-8?B?czNzU1lEcGtEOEdmaGlwVEx6ak4rZWREYmF3WHdDNTR1aytRbjdFcFlBSG9r?=
 =?utf-8?B?UHIySnh2RkVCYzFHWldNY0dzenp5MEhwdnRjR1ptRGl5MjBJeWNPU2hXV0JX?=
 =?utf-8?B?R21CcWIwMm1UUHVjQ2lVYlR5QmExdkhxZmplN3JxT1ZFaHNTb2x0di9uNmkx?=
 =?utf-8?B?VWlJK1F4UnU0SUdYanpBaE9Ud1RZaDRWWTIyNENBZk5rOG9ROTVWc3g4RURC?=
 =?utf-8?B?Q2JNaURweEcyWHV2Rk5EOEM4c0hXb0JjbEJpWnZSZWV3bk1sNmpPbFZ2NnBS?=
 =?utf-8?B?OHFERTJOQXlRZ1dGYVB0cHNZaGNvaVJ3cHJKSFVKQUZ3UDRsNmhIY1B1cFZi?=
 =?utf-8?B?QTF2R3RqVW1wMnNzT0h2SFpGUjhCMDJJZ2I1SnBtMXpiVTNsS0x0M0M2Vlpn?=
 =?utf-8?B?bCtVVTJXTEVlZVpkRHF0ZHBKMUora0F4UmlMZWlGK2JOc0NlS0FyRmk2Ykd4?=
 =?utf-8?B?R0NhaU0yWTNoTFFSdThDMjJFZFF6dlBLSE5HVnpNeVp5NUxrV3VEV2hzaDRx?=
 =?utf-8?B?c0pQdUxtUXhzNmFCQnJmOUFlQXNYdDgyV2tIQTAvNzFPbVQzMGVnc3FWeC90?=
 =?utf-8?B?ek5aZXVTanl0U0JmeVVMVjRKSTRVdE8rUXROd3hhZVoya3NmeVBiNmV4M0JL?=
 =?utf-8?Q?a+P8QgsreOXinAIHyhY1LQRltMsycrOdAjLvmbbM3jeqf?=
X-MS-Exchange-AntiSpam-MessageData-1: HWi2pdxIn8rzFw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f878d5-0d52-4216-a722-08de96488adc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:59:04.8104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQNU+6flCi8aA1R3hIgmET1zk26TJjAruieuVVCOkClpM8B8RIe2niEokJyUWjen3OXHdxHcbRADfcpDY8z3rQ==
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

Extract the bitfield-defining part of the `register!` macro into an
independent macro used to define bitfield types with bounds-checked
accessors.

Each field is represented as a `Bounded` of the appropriate bit width,
ensuring field values are never silently truncated.

Fields can optionally be converted to/from custom types, either fallibly
or infallibly.

Appropriate documentation is also added, and a MAINTAINERS entry created
for the new module.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 MAINTAINERS                |   8 +
 rust/kernel/bitfield.rs    | 491 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/io/register.rs | 246 +----------------------
 rust/kernel/lib.rs         |   1 +
 4 files changed, 502 insertions(+), 244 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b01791963e25..77f2617ade5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23186,6 +23186,14 @@ F:	scripts/*rust*
 F:	tools/testing/selftests/rust/
 K:	\b(?i:rust)\b
 
+RUST [BITFIELD]
+M:	Alexandre Courbot <acourbot@nvidia.com>
+M:	Joel Fernandes <joelagnelf@nvidia.com>
+R:	Yury Norov <yury.norov@gmail.com>
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	rust/kernel/bitfield.rs
+
 RUST [ALLOC]
 M:	Danilo Krummrich <dakr@kernel.org>
 R:	Lorenzo Stoakes <ljs@kernel.org>
diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
new file mode 100644
index 000000000000..f5948eec8a76
--- /dev/null
+++ b/rust/kernel/bitfield.rs
@@ -0,0 +1,491 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Support for defining bitfields as Rust structures.
+//!
+//! The [`bitfield!`](kernel::bitfield!) macro declares integer types that are split into distinct
+//! bit fields of arbitrary length. Each field is typed using [`Bounded`](kernel::num::Bounded) to
+//! ensure values are properly validated and to avoid implicit data loss.
+//!
+//! # Example
+//!
+//! ```rust
+//! use kernel::bitfield;
+//! use kernel::num::Bounded;
+//!
+//! bitfield! {
+//!     pub struct Rgb(u16) {
+//!         15:11 blue;
+//!         10:5 green;
+//!         4:0 red;
+//!     }
+//! }
+//!
+//! // Valid value for the `blue` field.
+//! let blue = Bounded::<u16, 5>::new::<0x18>();
+//!
+//! // Setters can be chained. Values ranges are checked at compile-time.
+//! let color = Rgb::zeroed()
+//!     // Compile-time bounds check of constant value.
+//!     .with_const_red::<0x10>()
+//!     .with_const_green::<0x1f>()
+//!     // A `Bounded` can also be passed.
+//!     .with_blue(blue);
+//!
+//! assert_eq!(color.red(), 0x10);
+//! assert_eq!(color.green(), 0x1f);
+//! assert_eq!(color.blue(), 0x18);
+//! assert_eq!(
+//!     color.into_raw(),
+//!     (0x18 << Rgb::BLUE_SHIFT) + (0x1f << Rgb::GREEN_SHIFT) + 0x10,
+//! );
+//!
+//! // Convert to/from the backing storage type.
+//! let raw: u16 = color.into();
+//! assert_eq!(Rgb::from(raw), color);
+//! ```
+//!
+//! # Syntax
+//!
+//! ```text
+//! bitfield! {
+//!     #[attributes]
+//!     // Documentation for `Name`.
+//!     pub struct Name(storage_type) {
+//!         // `field_1` documentation.
+//!         hi:lo field_1;
+//!         // `field_2` documentation.
+//!         hi:lo field_2 => ConvertedType;
+//!         // `field_3` documentation.
+//!         hi:lo field_3 ?=> ConvertedType;
+//!         ...
+//!     }
+//! }
+//! ```
+//!
+//! - `storage_type`: The underlying integer type (`u8`, `u16`, `u32`, `u64`).
+//! - `hi:lo`: Bit range (inclusive), where `hi >= lo`.
+//! - `=> Type`: Optional infallible conversion (see [below](#infallible-conversion-)).
+//! - `?=> Type`: Optional fallible conversion (see [below](#fallible-conversion-)).
+//! - Documentation strings and attributes are optional.
+//!
+//! # Generated code
+//!
+//! Each field is internally represented as a [`Bounded`] parameterized by its bit width. Field
+//! values can either be set/retrieved directly, or converted from/to another type.
+//!
+//! The use of `Bounded` for each field enforces bounds-checking (at build time or runtime) of every
+//! value assigned to a field. This ensures that data is never accidentally truncated.
+//!
+//! The macro generates the bitfield type, [`From`] and [`Into`] implementations for its storage
+//! type, as well as [`Debug`] and [`Zeroable`](pin_init::Zeroable) implementations.
+//!
+//! For each field, it also generates:
+//!
+//! - `with_field(value)` — infallible setter; the argument type must be statically known to fit
+//!   the field width.
+//! - `with_const_field::<VALUE>()` — const setter; the value is validated at compile time.
+//!   Usually shorter to use than `with_field` for constant values as it doesn't require
+//!   constructing a `Bounded`.
+//! - `try_with_field(value)` — fallible setter. Returns an error if the value is out of range.
+//! - `FIELD_MASK`, `FIELD_SHIFT`, `FIELD_RANGE` - constants for manual bit manipulation.
+//!
+//! # Implicit conversions
+//!
+//! Types that fit entirely within a field's bit width can be used directly with setters. For
+//! example, `bool` works with single-bit fields, and `u8` works with 8-bit fields:
+//!
+//! ```rust
+//! use kernel::bitfield;
+//!
+//! bitfield! {
+//!     pub struct Flags(u32) {
+//!         15:8 byte_field;
+//!         0:0 flag;
+//!     }
+//! }
+//!
+//! let flags = Flags::zeroed()
+//!     .with_byte_field(0x42_u8)
+//!     .with_flag(true);
+//!
+//! assert_eq!(flags.into_raw(), (0x42 << Flags::BYTE_FIELD_SHIFT) | 1);
+//! ```
+//!
+//! # Runtime bounds checking
+//!
+//! When a value is not known at compile time, use `try_with_field()` to check bounds at runtime:
+//!
+//! ```rust
+//! use kernel::bitfield;
+//!
+//! bitfield! {
+//!     pub struct Config(u8) {
+//!         3:0 nibble;
+//!     }
+//! }
+//!
+//! fn set_nibble(config: Config, value: u8) -> Result<Config, Error> {
+//!     // Returns `EOVERFLOW` if `value > 0xf`.
+//!     config.try_with_nibble(value)
+//! }
+//! # Ok::<(), Error>(())
+//! ```
+//!
+//! # Type conversion
+//!
+//! Fields can be automatically converted to/from a custom type using `=>` (infallible) or `?=>`
+//! (fallible). The custom type must implement the appropriate `From` or `TryFrom` traits with
+//! `Bounded`.
+//!
+//! ## Infallible conversion (`=>`)
+//!
+//! Use this when all possible bit patterns of a field map to valid values:
+//!
+//! ```rust
+//! use kernel::bitfield;
+//! use kernel::num::Bounded;
+//!
+//! #[derive(Debug, Clone, Copy, PartialEq)]
+//! enum Power {
+//!     Off,
+//!     On,
+//! }
+//!
+//! impl From<Bounded<u32, 1>> for Power {
+//!     fn from(v: Bounded<u32, 1>) -> Self {
+//!         match *v {
+//!             0 => Power::Off,
+//!             _ => Power::On,
+//!         }
+//!     }
+//! }
+//!
+//! impl From<Power> for Bounded<u32, 1> {
+//!     fn from(p: Power) -> Self {
+//!         (p as u32 != 0).into()
+//!     }
+//! }
+//!
+//! bitfield! {
+//!     pub struct Control(u32) {
+//!         0:0 power => Power;
+//!     }
+//! }
+//!
+//! let ctrl = Control::zeroed().with_power(Power::On);
+//! assert_eq!(ctrl.power(), Power::On);
+//! ```
+//!
+//! ## Fallible conversion (`?=>`)
+//!
+//! Use this when some bit patterns of a field are invalid. The getter returns a [`Result`]:
+//!
+//! ```rust
+//! use kernel::bitfield;
+//! use kernel::num::Bounded;
+//!
+//! #[derive(Debug, Clone, Copy, PartialEq)]
+//! enum Mode {
+//!     Low = 0,
+//!     High = 1,
+//!     Auto = 2,
+//!     // 3 is invalid
+//! }
+//!
+//! impl TryFrom<Bounded<u32, 2>> for Mode {
+//!     type Error = u32;
+//!
+//!     fn try_from(v: Bounded<u32, 2>) -> Result<Self, u32> {
+//!         match *v {
+//!             0 => Ok(Mode::Low),
+//!             1 => Ok(Mode::High),
+//!             2 => Ok(Mode::Auto),
+//!             n => Err(n),
+//!         }
+//!     }
+//! }
+//!
+//! impl From<Mode> for Bounded<u32, 2> {
+//!     fn from(m: Mode) -> Self {
+//!         match m {
+//!             Mode::Low => Bounded::<u32, _>::new::<0>(),
+//!             Mode::High => Bounded::<u32, _>::new::<1>(),
+//!             Mode::Auto => Bounded::<u32, _>::new::<2>(),
+//!         }
+//!     }
+//! }
+//!
+//! bitfield! {
+//!     pub struct Config(u32) {
+//!         1:0 mode ?=> Mode;
+//!     }
+//! }
+//!
+//! let cfg = Config::zeroed().with_mode(Mode::Auto);
+//! assert_eq!(cfg.mode(), Ok(Mode::Auto));
+//!
+//! // Invalid bit pattern returns an error.
+//! assert_eq!(Config::from(0b11).mode(), Err(3));
+//! ```
+//!
+//! [`Bounded`]: kernel::num::Bounded
+
+/// Defines a bitfield struct with bounds-checked accessors for individual bit ranges.
+///
+/// See the [`mod@kernel::bitfield`] module for full documentation and examples.
+#[macro_export]
+macro_rules! bitfield {
+    // Entry point defining the bitfield struct, its implementations and its field accessors.
+    (
+        $(#[$attr:meta])* $vis:vis struct $name:ident($storage:ty) { $($fields:tt)* }
+    ) => {
+        $crate::bitfield!(@core
+            #[allow(non_camel_case_types)]
+            $(#[$attr])* $vis $name $storage
+        );
+        $crate::bitfield!(@fields $vis $name $storage { $($fields)* });
+    };
+
+    // All rules below are helpers.
+
+    // Defines the wrapper `$name` type and its conversions from/to the storage type.
+    (@core $(#[$attr:meta])* $vis:vis $name:ident $storage:ty) => {
+        $(#[$attr])*
+        #[repr(transparent)]
+        #[derive(Clone, Copy, PartialEq, Eq)]
+        $vis struct $name {
+            inner: $storage,
+        }
+
+        #[allow(dead_code)]
+        impl $name {
+            /// Creates a bitfield from a raw value.
+            #[inline(always)]
+            $vis const fn from_raw(value: $storage) -> Self {
+                Self{ inner: value }
+            }
+
+            /// Turns this bitfield into its raw value.
+            ///
+            /// This is similar to the [`From`] implementation, but is shorter to invoke in
+            /// most cases.
+            #[inline(always)]
+            $vis const fn into_raw(self) -> $storage {
+                self.inner
+            }
+        }
+
+        // SAFETY: `$storage` is `Zeroable` and `$name` is transparent.
+        unsafe impl ::pin_init::Zeroable for $name {}
+
+        impl ::core::convert::From<$name> for $storage {
+            #[inline(always)]
+            fn from(val: $name) -> $storage {
+                val.into_raw()
+            }
+        }
+
+        impl ::core::convert::From<$storage> for $name {
+            #[inline(always)]
+            fn from(val: $storage) -> $name {
+                Self::from_raw(val)
+            }
+        }
+    };
+
+    // Definitions requiring knowledge of individual fields: private and public field accessors,
+    // and `Debug` implementation.
+    (@fields $vis:vis $name:ident $storage:ty {
+        $($(#[doc = $doc:expr])* $hi:literal:$lo:literal $field:ident
+            $(?=> $try_into_type:ty)?
+            $(=> $into_type:ty)?
+        ;
+        )*
+    }
+    ) => {
+        #[allow(dead_code)]
+        impl $name {
+        $(
+        $crate::bitfield!(@private_field_accessors $vis $name $storage : $hi:$lo $field);
+        $crate::bitfield!(
+            @public_field_accessors $(#[doc = $doc])* $vis $name $storage : $hi:$lo $field
+            $(?=> $try_into_type)?
+            $(=> $into_type)?
+        );
+        )*
+        }
+
+        $crate::bitfield!(@debug $name { $($field;)* });
+    };
+
+    // Private field accessors working with the exact `Bounded` type for the field.
+    (
+        @private_field_accessors $vis:vis $name:ident $storage:ty : $hi:tt:$lo:tt $field:ident
+    ) => {
+        ::kernel::macros::paste!(
+        $vis const [<$field:upper _RANGE>]: ::core::ops::RangeInclusive<u8> = $lo..=$hi;
+        $vis const [<$field:upper _MASK>]: $storage =
+            ((((1 << $hi) - 1) << 1) + 1) - ((1 << $lo) - 1);
+        $vis const [<$field:upper _SHIFT>]: u32 = $lo;
+        );
+
+        ::kernel::macros::paste!(
+        fn [<__ $field>](self) ->
+            ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }> {
+            // Left shift to align the field's MSB with the storage MSB.
+            const ALIGN_TOP: u32 = $storage::BITS - ($hi + 1);
+            // Right shift to move the top-aligned field to bit 0 of the storage.
+            const ALIGN_BOTTOM: u32 = ALIGN_TOP + $lo;
+
+            // Extract the field using two shifts. `Bounded::shr` produces the correctly-sized
+            // output type.
+            let val = ::kernel::num::Bounded::<$storage, { $storage::BITS }>::from(
+                self.inner << ALIGN_TOP
+            );
+            val.shr::<ALIGN_BOTTOM, { $hi + 1 - $lo } >()
+        }
+
+        const fn [<__with_ $field>](
+            mut self,
+            value: ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>,
+        ) -> Self
+        {
+            const MASK: $storage = <$name>::[<$field:upper _MASK>];
+            const SHIFT: u32 = <$name>::[<$field:upper _SHIFT>];
+
+            let value = value.get() << SHIFT;
+            self.inner = (self.inner & !MASK) | value;
+
+            self
+        }
+        );
+    };
+
+    // Public accessors for fields infallibly (`=>`) converted to a type.
+    (
+        @public_field_accessors $(#[doc = $doc:expr])* $vis:vis $name:ident $storage:ty :
+            $hi:literal:$lo:literal $field:ident => $into_type:ty
+    ) => {
+        ::kernel::macros::paste!(
+
+        $(#[doc = $doc])*
+        #[doc = "Returns the value of this field."]
+        #[inline(always)]
+        $vis fn $field(self) -> $into_type
+        {
+            self.[<__ $field>]().into()
+        }
+
+        $(#[doc = $doc])*
+        #[doc = "Sets this field to the given `value`."]
+        #[inline(always)]
+        $vis fn [<with_ $field>](self, value: $into_type) -> Self
+        {
+            self.[<__with_ $field>](value.into())
+        }
+
+        );
+    };
+
+    // Public accessors for fields fallibly (`?=>`) converted to a type.
+    (
+        @public_field_accessors $(#[doc = $doc:expr])* $vis:vis $name:ident $storage:ty :
+            $hi:tt:$lo:tt $field:ident ?=> $try_into_type:ty
+    ) => {
+        ::kernel::macros::paste!(
+
+        $(#[doc = $doc])*
+        #[doc = "Returns the value of this field."]
+        #[inline(always)]
+        $vis fn $field(self) ->
+            Result<
+                $try_into_type,
+                <$try_into_type as ::core::convert::TryFrom<
+                    ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>
+                >>::Error
+            >
+        {
+            self.[<__ $field>]().try_into()
+        }
+
+        $(#[doc = $doc])*
+        #[doc = "Sets this field to the given `value`."]
+        #[inline(always)]
+        $vis fn [<with_ $field>](self, value: $try_into_type) -> Self
+        {
+            self.[<__with_ $field>](value.into())
+        }
+
+        );
+    };
+
+    // Public accessors for fields not converted to a type.
+    (
+        @public_field_accessors $(#[doc = $doc:expr])* $vis:vis $name:ident $storage:ty :
+            $hi:tt:$lo:tt $field:ident
+    ) => {
+        ::kernel::macros::paste!(
+
+        $(#[doc = $doc])*
+        #[doc = "Returns the value of this field."]
+        #[inline(always)]
+        $vis fn $field(self) ->
+            ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>
+        {
+            self.[<__ $field>]()
+        }
+
+        $(#[doc = $doc])*
+        #[doc = "Sets this field to the compile-time constant `VALUE`."]
+        #[inline(always)]
+        $vis const fn [<with_const_ $field>]<const VALUE: $storage>(self) -> Self {
+            self.[<__with_ $field>](
+                ::kernel::num::Bounded::<$storage, { $hi + 1 - $lo }>::new::<VALUE>()
+            )
+        }
+
+        $(#[doc = $doc])*
+        #[doc = "Sets this field to the given `value`."]
+        #[inline(always)]
+        $vis fn [<with_ $field>]<T>(
+            self,
+            value: T,
+        ) -> Self
+            where T: Into<::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>>,
+        {
+            self.[<__with_ $field>](value.into())
+        }
+
+        $(#[doc = $doc])*
+        #[doc = "Tries to set this field to `value`, returning an error if it is out of range."]
+        #[inline(always)]
+        $vis fn [<try_with_ $field>]<T>(
+            self,
+            value: T,
+        ) -> ::kernel::error::Result<Self>
+            where T: ::kernel::num::TryIntoBounded<$storage, { $hi + 1 - $lo }>,
+        {
+            Ok(
+                self.[<__with_ $field>](
+                    value.try_into_bounded().ok_or(::kernel::error::code::EOVERFLOW)?
+                )
+            )
+        }
+
+        );
+    };
+
+    // `Debug` implementation.
+    (@debug $name:ident { $($field:ident;)* }) => {
+        impl ::kernel::fmt::Debug for $name {
+            fn fmt(&self, f: &mut ::kernel::fmt::Formatter<'_>) -> ::kernel::fmt::Result {
+                f.debug_struct(stringify!($name))
+                    .field("<raw>", &::kernel::prelude::fmt!("{:#x}", self.inner))
+                $(
+                    .field(stringify!($field), &self.$field())
+                )*
+                    .finish()
+            }
+        }
+    };
+}
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index abc49926abfe..388647f28292 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -956,11 +956,10 @@ macro_rules! register {
     (
         @bitfield $(#[$attr:meta])* $vis:vis struct $name:ident($storage:ty) { $($fields:tt)* }
     ) => {
-        $crate::register!(@bitfield_core
+        $crate::bitfield!(
             #[allow(non_camel_case_types)]
-            $(#[$attr])* $vis $name $storage
+            $(#[$attr])* $vis struct $name($storage) { $($fields)* }
         );
-        $crate::register!(@bitfield_fields $vis $name $storage { $($fields)* });
     };
 
     // Implementations shared by all registers types.
@@ -1016,245 +1015,4 @@ impl $crate::io::register::RegisterArray for $name {
 
         impl $crate::io::register::RelativeRegisterArray for $name {}
     };
-
-    // Defines the wrapper `$name` type and its conversions from/to the storage type.
-    (@bitfield_core $(#[$attr:meta])* $vis:vis $name:ident $storage:ty) => {
-        $(#[$attr])*
-        #[repr(transparent)]
-        #[derive(Clone, Copy, PartialEq, Eq)]
-        $vis struct $name {
-            inner: $storage,
-        }
-
-        #[allow(dead_code)]
-        impl $name {
-            /// Creates a bitfield from a raw value.
-            #[inline(always)]
-            $vis const fn from_raw(value: $storage) -> Self {
-                Self{ inner: value }
-            }
-
-            /// Turns this bitfield into its raw value.
-            ///
-            /// This is similar to the [`From`] implementation, but is shorter to invoke in
-            /// most cases.
-            #[inline(always)]
-            $vis const fn into_raw(self) -> $storage {
-                self.inner
-            }
-        }
-
-        // SAFETY: `$storage` is `Zeroable` and `$name` is transparent.
-        unsafe impl ::pin_init::Zeroable for $name {}
-
-        impl ::core::convert::From<$name> for $storage {
-            #[inline(always)]
-            fn from(val: $name) -> $storage {
-                val.into_raw()
-            }
-        }
-
-        impl ::core::convert::From<$storage> for $name {
-            #[inline(always)]
-            fn from(val: $storage) -> $name {
-                Self::from_raw(val)
-            }
-        }
-    };
-
-    // Definitions requiring knowledge of individual fields: private and public field accessors,
-    // and `Debug` implementation.
-    (@bitfield_fields $vis:vis $name:ident $storage:ty {
-        $($(#[doc = $doc:expr])* $hi:literal:$lo:literal $field:ident
-            $(?=> $try_into_type:ty)?
-            $(=> $into_type:ty)?
-        ;
-        )*
-    }
-    ) => {
-        #[allow(dead_code)]
-        impl $name {
-        $(
-        $crate::register!(@private_field_accessors $vis $name $storage : $hi:$lo $field);
-        $crate::register!(
-            @public_field_accessors $(#[doc = $doc])* $vis $name $storage : $hi:$lo $field
-            $(?=> $try_into_type)?
-            $(=> $into_type)?
-        );
-        )*
-        }
-
-        $crate::register!(@debug $name { $($field;)* });
-    };
-
-    // Private field accessors working with the exact `Bounded` type for the field.
-    (
-        @private_field_accessors $vis:vis $name:ident $storage:ty : $hi:tt:$lo:tt $field:ident
-    ) => {
-        ::kernel::macros::paste!(
-        $vis const [<$field:upper _RANGE>]: ::core::ops::RangeInclusive<u8> = $lo..=$hi;
-        $vis const [<$field:upper _MASK>]: $storage =
-            ((((1 << $hi) - 1) << 1) + 1) - ((1 << $lo) - 1);
-        $vis const [<$field:upper _SHIFT>]: u32 = $lo;
-        );
-
-        ::kernel::macros::paste!(
-        fn [<__ $field>](self) ->
-            ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }> {
-            // Left shift to align the field's MSB with the storage MSB.
-            const ALIGN_TOP: u32 = $storage::BITS - ($hi + 1);
-            // Right shift to move the top-aligned field to bit 0 of the storage.
-            const ALIGN_BOTTOM: u32 = ALIGN_TOP + $lo;
-
-            // Extract the field using two shifts. `Bounded::shr` produces the correctly-sized
-            // output type.
-            let val = ::kernel::num::Bounded::<$storage, { $storage::BITS }>::from(
-                self.inner << ALIGN_TOP
-            );
-            val.shr::<ALIGN_BOTTOM, { $hi + 1 - $lo } >()
-        }
-
-        const fn [<__with_ $field>](
-            mut self,
-            value: ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>,
-        ) -> Self
-        {
-            const MASK: $storage = <$name>::[<$field:upper _MASK>];
-            const SHIFT: u32 = <$name>::[<$field:upper _SHIFT>];
-
-            let value = value.get() << SHIFT;
-            self.inner = (self.inner & !MASK) | value;
-
-            self
-        }
-        );
-    };
-
-    // Public accessors for fields infallibly (`=>`) converted to a type.
-    (
-        @public_field_accessors $(#[doc = $doc:expr])* $vis:vis $name:ident $storage:ty :
-            $hi:literal:$lo:literal $field:ident => $into_type:ty
-    ) => {
-        ::kernel::macros::paste!(
-
-        $(#[doc = $doc])*
-        #[doc = "Returns the value of this field."]
-        #[inline(always)]
-        $vis fn $field(self) -> $into_type
-        {
-            self.[<__ $field>]().into()
-        }
-
-        $(#[doc = $doc])*
-        #[doc = "Sets this field to the given `value`."]
-        #[inline(always)]
-        $vis fn [<with_ $field>](self, value: $into_type) -> Self
-        {
-            self.[<__with_ $field>](value.into())
-        }
-
-        );
-    };
-
-    // Public accessors for fields fallibly (`?=>`) converted to a type.
-    (
-        @public_field_accessors $(#[doc = $doc:expr])* $vis:vis $name:ident $storage:ty :
-            $hi:tt:$lo:tt $field:ident ?=> $try_into_type:ty
-    ) => {
-        ::kernel::macros::paste!(
-
-        $(#[doc = $doc])*
-        #[doc = "Returns the value of this field."]
-        #[inline(always)]
-        $vis fn $field(self) ->
-            Result<
-                $try_into_type,
-                <$try_into_type as ::core::convert::TryFrom<
-                    ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>
-                >>::Error
-            >
-        {
-            self.[<__ $field>]().try_into()
-        }
-
-        $(#[doc = $doc])*
-        #[doc = "Sets this field to the given `value`."]
-        #[inline(always)]
-        $vis fn [<with_ $field>](self, value: $try_into_type) -> Self
-        {
-            self.[<__with_ $field>](value.into())
-        }
-
-        );
-    };
-
-    // Public accessors for fields not converted to a type.
-    (
-        @public_field_accessors $(#[doc = $doc:expr])* $vis:vis $name:ident $storage:ty :
-            $hi:tt:$lo:tt $field:ident
-    ) => {
-        ::kernel::macros::paste!(
-
-        $(#[doc = $doc])*
-        #[doc = "Returns the value of this field."]
-        #[inline(always)]
-        $vis fn $field(self) ->
-            ::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>
-        {
-            self.[<__ $field>]()
-        }
-
-        $(#[doc = $doc])*
-        #[doc = "Sets this field to the compile-time constant `VALUE`."]
-        #[inline(always)]
-        $vis const fn [<with_const_ $field>]<const VALUE: $storage>(self) -> Self {
-            self.[<__with_ $field>](
-                ::kernel::num::Bounded::<$storage, { $hi + 1 - $lo }>::new::<VALUE>()
-            )
-        }
-
-        $(#[doc = $doc])*
-        #[doc = "Sets this field to the given `value`."]
-        #[inline(always)]
-        $vis fn [<with_ $field>]<T>(
-            self,
-            value: T,
-        ) -> Self
-            where T: Into<::kernel::num::Bounded<$storage, { $hi + 1 - $lo }>>,
-        {
-            self.[<__with_ $field>](value.into())
-        }
-
-        $(#[doc = $doc])*
-        #[doc = "Tries to set this field to `value`, returning an error if it is out of range."]
-        #[inline(always)]
-        $vis fn [<try_with_ $field>]<T>(
-            self,
-            value: T,
-        ) -> ::kernel::error::Result<Self>
-            where T: ::kernel::num::TryIntoBounded<$storage, { $hi + 1 - $lo }>,
-        {
-            Ok(
-                self.[<__with_ $field>](
-                    value.try_into_bounded().ok_or(::kernel::error::code::EOVERFLOW)?
-                )
-            )
-        }
-
-        );
-    };
-
-    // `Debug` implementation.
-    (@debug $name:ident { $($field:ident;)* }) => {
-        impl ::kernel::fmt::Debug for $name {
-            fn fmt(&self, f: &mut ::kernel::fmt::Formatter<'_>) -> ::kernel::fmt::Result {
-                f.debug_struct(stringify!($name))
-                    .field("<raw>", &::kernel::prelude::fmt!("{:#x}", self.inner))
-                $(
-                    .field(stringify!($field), &self.$field())
-                )*
-                    .finish()
-            }
-        }
-    };
 }
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 40de00ce4f97..31e5f5908dfc 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -77,6 +77,7 @@
 pub mod alloc;
 #[cfg(CONFIG_AUXILIARY_BUS)]
 pub mod auxiliary;
+pub mod bitfield;
 pub mod bitmap;
 pub mod bits;
 #[cfg(CONFIG_BLOCK)]

-- 
2.53.0

