Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E57F31E25
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C84FD10E80F;
	Thu,  9 Apr 2026 14:59:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="toHYT8bW";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013037.outbound.protection.outlook.com
 [40.107.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E1EF10E80F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 14:59:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGzh/QvSHQRHXGzZKkPNDXVWSLVjXRKTX0rlQsymYQTP1zC7Z5hbTJuLIa63+nhVsoh/5yK6DgPzXl7mlFrdb7N+Hvo2tU7LYdrpWHUR4qT/IJ4X6gPn9UKfxjV3YzWax1/U3GaCbb1raV/WIJ9h3saC6IPw3XqBPRNio1tyUXJ5epAT1AtOwbwh3gp0HnSKn+J2Tm3rw7veObyseCEHqO1BSq337/Tmlc4sO7x9YhAfD3DQix1P/B++OgOqft725+1iHzW2lMivs9HFvMjRxF/7mZkLx2O1aC1fLdkrxF8arFzb11MGIFQROMgjbaQaqrhuPo69DloMSqX90tvrTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jygwyyr08fEpxB/IytZuL9/d1afhsV8aDsPc1NQd53k=;
 b=Rc2EDeWrZwJQpdMdD5vhF16ez1tJqD1+PiBknJQ65lGNljF7f0Nn3opjyRb4jllDbtBzXm0aDRvYHyy6YU4SDjBbf0wuvHKysZ2uwHxnDYqopSMwgQ0WpzCOp/NP1ftMPzQkfXrTUh+srp1R7qfQ39o8S3z4Tlar+Qn8IHiAtcXFb/ZBzmuvN3c3q67uRxvNmeDK45dZhhcKu8oz062gqr2qM1gyO4dHcMGAlZP2FZ9939SEbcppJ1JSWfif/pnnk4UWr2tDxLCGo4JbznH/7lZrdt4D1wGgRPHOPw8ECRQOGgGAr1T84mmWq+3+J9CUni+oTO1hDv6vgqMjrwYciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jygwyyr08fEpxB/IytZuL9/d1afhsV8aDsPc1NQd53k=;
 b=toHYT8bWu71quCDS9H/MxspRp6NGUFKMO8bACfOVQcOLcOPm2l7JhkHBsF2qmDhGsnU/Cjz0arkSwMfsyUshtO04WTTwGvm0JfY5sGRERQUZJFdlbGYiv1jlkrPrkjW/K/iWtRYeakdOSGVIVDxOuvMC++5wf4yYgD17LuB08nJFLFJqerhS67ozLf9YE5Q9Lny6b1TnlM0B509zU/KjcZgsJxTLMHhAiL/+AGcbeypY6GgoIkNPewjLjOAOHqkz7k3JOvQssYV3vtXsr1tLLRSf/rOVm9xTPMaaA+zrUVoioEPL7QP7geWJjdKkhgwwbPUe9e2OSJHge1Z8t7ruww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 14:59:13 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 14:59:13 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 09 Apr 2026 23:58:49 +0900
Subject: [PATCH v2 3/3] gpu: nova-core: switch to kernel bitfield macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-bitfield-v2-3-23ac400071cb@nvidia.com>
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
X-ClientProxiedBy: TYCPR01CA0190.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: 4785e0c9-54b9-4f94-ebbd-08de96488fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|10070799003|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: unqtSo3ImyVL5Y0OoON0I8rMOvu3h72G4CoqR76J9YRFuUtb9YsBGpiHsnDu88QJ5yV4IpEHOaUmwit5pmXHhBbWMZQWKXiiYfabzYfz7ScWDW7MWshsBJ+Dp7QVI/PNImBvo/oI6Y+tL/AJgm4No4ejop+IITPjI/34sNkP87bUFaT+GQul2ySNpevZ7+9Gf/mNuu7R4W4GTg5rlnNKWl4ijPUqgmxt62DFCpftMbVLRYV7MZIfv6MgTxUWEGxWrQ8UsY/JsGvaGLLVQw9hv+iJAtldyt+Zhp1BOcYCVk9zlPr5leCvNoc6/nLxgL7gMLfXNPbixV4yI5z2i+d5BTc1xBZQmQgG0qWgEP5w390bZxYOcYnHRyeZD+a+TwlIa9V3wcAjsVIKY+1NmJ3eUKCL+6tVNkFHdh8cBntzrDtn3qD4zUg7bRF4XJ1gjIr/dScmzRTS/TW7DK5tkuMfLeoDAfOUHOgdnFV4jtHp6R40xZisjyjUrky6VN3+0JK20Zm9BhdF7IfEU/lzIvGd4KW5vSaWHHlfHWwGd62W8TO+7ZW9hcTmjTnu2EQ6YJTCA+uWscYI9qhP7Y47V/tO1NH4pjSqOUydHaaAu+Pmyzs3v5tzexWlLwWAjCiBG/zKKYfJRrUGNG7BidwJF46AJCdaUoP7rUfMU/GHa29KEvxl/sRtTXCezkKo2lSbcBHsir5cavC4dTf5Mi6EsHU3kmVHPUFlCfLJ1FvOJ4p/sgqMg/lnfsmESKj8kqjFbzM7ArcSRXEioYsoxrsqYVG5Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzJVZ3lQa0VETTNoZTZXMkF6NFBmdnlqUTlkTVZRanhzSTdxYkFYUzNja1gy?=
 =?utf-8?B?cTIzRjlzVFhPV3hMOTExVEhHY3lkMVpaaFlGVVZ4dXpCQmVrZVRvcFpWay9w?=
 =?utf-8?B?T0hkQ2E1czY2Zy9vRGVNYWZuc0N3VmhIRG10OGNXWlV1alZ5ZDlCM01NRndJ?=
 =?utf-8?B?Ui8zUUtWOG9qc1IxTlkvSkJrVXJHUTZvcjJPYkRZQU8yanNMQUlMMzJ2QjBJ?=
 =?utf-8?B?cUNzZ2tyQjdtSXNZVHE1eE4xOUg0Yit4Umg5ZUl3Z2lKS2FOVncwZUlrdGUy?=
 =?utf-8?B?clZVMlBlL2VMTlVXemhKUXJMTHpnbmw1citwc2J3SUs1Q0ZzYzMvQkNRbmN5?=
 =?utf-8?B?L2Z2T01jdTl4YkdsVi9BY01tMGxqWTVkelRZMUxJeDc4WmRUOWp5em9odzNK?=
 =?utf-8?B?TXFiMGhuZTZRaXpvb01DVjhaR1dBZWtoa29aaTNLQnFManVVUDh2WkljYkd5?=
 =?utf-8?B?SmhHNVNTOVFwTEV3OWhWUWI1elV5ZnZKbTd6d1RGNU9ySVBoWHhxUnZJZ3Fm?=
 =?utf-8?B?S0I2V0tBWWtHbGkya3RMSkx3a1ZaZmF1TTNUVk9DaWU5dFd3TzFpcjliY2s5?=
 =?utf-8?B?NmIwcE1HemExRFRUT1B1QXlNb0NlM3Y4T29YZWZSWTFxVTdNYzlKcUVtck11?=
 =?utf-8?B?Q0FKUHlaVVZiS2lpSkNpMUE4WGR1TFlScVIzb3p4QjdXcnc2aHk2TnlxSXh6?=
 =?utf-8?B?WUpjY3JGK3YrZjVodXY1WHdoTko1bUdpNDdNcFNpNU5HdTc5RVVRcko1MWUw?=
 =?utf-8?B?SnFmenRlaTVUdUlRcEQ2eDZDdWVNSExLZVlkTXYwTHFsczJoTzNQNU5XeFgv?=
 =?utf-8?B?YVZINTd1ZC9NbkZ2TEN3ZExWUUR0dTc1RGZ5R3F2Y1ppb2FFMUhZR0FBb3pt?=
 =?utf-8?B?SC9OUzljY2o3MGFZcVVleWJ4Q3hzZ2w3R0dobXU3RFJGQVl3cDhTaWhjK2Fn?=
 =?utf-8?B?dm1QN0cvcDRIbmhQMDh6T3ZaVklON2N1ZU0yM1lSbGZpT2ZLUmVYa0ducVFL?=
 =?utf-8?B?OTFXS3hGRFNQYUtvSFVUaW9BaUdYV1R1SVlCb2ZjL1BDRWl4RCs5SnBvS2xD?=
 =?utf-8?B?Q3BGYXZEam83N0g3TndtTVdUaFk3MWVncjhKSnZwdDVKY3dSQW93RitMazhu?=
 =?utf-8?B?THhmcXp2WXFIOFExV1pXaXlrTUF2S3VNQ1VFbXZDMmd6Y1NPTG9QOUtqSGJN?=
 =?utf-8?B?R1duNFRyS25QbTdiUm9qMWwwZlRtUFFJdUx5U21xemdhcTZHQzlhczZIc2pD?=
 =?utf-8?B?cEZmYVp2YnprWVFsVkxubWFIelNnQ2Fob29GMUFNelBaeEhkdFZJVkVxUWZG?=
 =?utf-8?B?QWthSWI4MEZIZmMvRlVENjdGL2ZhWHRySENrakhNdEFkUUNQYTVSanRKd2Q1?=
 =?utf-8?B?ZVdnTC9XaWVjejMwR2puUjBqaUdCSlRnZGxDS29DWGFqWFV1Y2dPSWQ1bUI5?=
 =?utf-8?B?UDVpT1g3RWpTT2lJZGpjZTZzdmx5TzhLSHc5N1I0QzNHVnphekgrdU53WHFE?=
 =?utf-8?B?dHltZFRFR3BJeWJvOENndHNvM1NneEhsT20rNnRoRVRiejdaNHRJTWlwdVMw?=
 =?utf-8?B?d0swNDFwb2xpb2hid0tXMVMxeG9kUS9yTjhlTkxoZGhXK1I3Z1J1TlZFOENZ?=
 =?utf-8?B?WkFNNk5BdUcrS3RVbzdWL2tuUzQ0V3hxT0ovTUFFYmFraDFGWFAwWXkyc0t2?=
 =?utf-8?B?bWhVWVVEZ29XZ05aSlByVkZpdmo3em55ekR1dTdjZUhlYkNSQ2ZWOThna3h0?=
 =?utf-8?B?VVNkRE81aGxXZk8wcEdZUG9JaC8xeVlvVlM1NE1hOUMxQ0NiekFqd29uYkFa?=
 =?utf-8?B?RjNocDIzVGNucmYrclYxTHFCRUdIVng5MDN1VHlyRTZmOFhmb1hveXBtR3Zh?=
 =?utf-8?B?MnJZekVSQjQxbExGekljVlBJRnFZeEd2L1lERkRKcVVNY2wvZUNkYkVwSEJH?=
 =?utf-8?B?YzNTeExPRTc1Q2srMW5yWVEyYURBZ3hINUZML1J6M21vWmQzcGN3UG9JbzlC?=
 =?utf-8?B?Q3gxb3dKS0k1bDhaQXpCdnhFbEdXdEhSUURTYTFQc3dOOGc3UzRxN3dMY1Bp?=
 =?utf-8?B?RHA2NFBacE54dERHTlJJT05Fc1pYd0N3QmdnclhnZGpqOHVVQTA3VVEvUW1p?=
 =?utf-8?B?VCttMzN0ckpGUmcyNXZBb2J4bi9ua1BIMXhjQXpGQ29uZFNvNjAyTGMwMDRz?=
 =?utf-8?B?R2lKNmVNVERPZzB4QmhYcDhRSnlUVkVNYnorVzlPMGNzdERGVlBqUWovWVlL?=
 =?utf-8?B?VEhiUXNpOHdnSjN4MnB1ZUs3NGYzQ2I3bXlkUlZ5QVRTN2tzZEdCR1JMMGI5?=
 =?utf-8?B?RzRUa2ZLS3R4aFZub2EvZWdIY0VwZm5wSElJeTRLb2RHZDhOL21HaEpFQU11?=
 =?utf-8?Q?KkWGWOurejxadX39cxwW+SYFLLnVT/jUosaOdGbzcsAyl?=
X-MS-Exchange-AntiSpam-MessageData-1: 4Tk8288SXyruRA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4785e0c9-54b9-4f94-ebbd-08de96488fee
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 14:59:13.1081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6KiChJqbMSm38GkQnhtGpgyxRBFsPbMZd1ewcJ1iNZvgm5v4DjSVCL/aIuqOxBQY04gi/4gJ5OfFnbFSB5z9Q==
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

Replace uses of the Nova-internal `bitfield!` macro by the kernel one,
and remove the now-unneeded local macro.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/bitfield.rs  | 329 -------------------------------------
 drivers/gpu/nova-core/gsp/fw.rs    |  15 +-
 drivers/gpu/nova-core/nova_core.rs |   3 -
 3 files changed, 8 insertions(+), 339 deletions(-)

diff --git a/drivers/gpu/nova-core/bitfield.rs b/drivers/gpu/nova-core/bitfield.rs
deleted file mode 100644
index 02efdcf78d89..000000000000
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
-            ::kernel::build_assert!(
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
-            ::kernel::build_assert!(
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
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 0c8a74f0e8ac..a7f75368c90e 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -9,6 +9,7 @@
 use core::ops::Range;
 
 use kernel::{
+    bitfield,
     dma::Coherent,
     prelude::*,
     ptr::{
@@ -17,8 +18,8 @@
         KnownSize, //
     },
     sizes::{
-        SZ_128K,
-        SZ_1M, //
+        SZ_128K, //
+        SZ_1M,
     },
     transmute::{
         AsBytes,
@@ -728,8 +729,8 @@ unsafe impl AsBytes for MsgqRxHeader {}
 
 bitfield! {
     struct MsgHeaderVersion(u32) {
-        31:24 major as u8;
-        23:16 minor as u8;
+        31:24 major;
+        23:16 minor;
     }
 }
 
@@ -738,9 +739,9 @@ impl MsgHeaderVersion {
     const MINOR_TOT: u8 = 0;
 
     fn new() -> Self {
-        Self::default()
-            .set_major(Self::MAJOR_TOT)
-            .set_minor(Self::MINOR_TOT)
+        Self::zeroed()
+            .with_major(Self::MAJOR_TOT)
+            .with_minor(Self::MINOR_TOT)
     }
 }
 
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 04a1fa6b25f8..3a0c45481a92 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -10,9 +10,6 @@
     InPlaceModule, //
 };
 
-#[macro_use]
-mod bitfield;
-
 mod driver;
 mod falcon;
 mod fb;

-- 
2.53.0

