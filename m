Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928F5C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 00:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A5110ED5A;
	Wed,  1 Jul 2026 00:15:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iMOQNtuO";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010025.outbound.protection.outlook.com
 [52.101.193.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8717110ED5A
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 00:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d743rXyQ7HwkpRBuM9meTXWuTijl95FFLxr+szHl568grrHfVdwcumCnnfcr132WzYTIOfbNJIvHl9/dtsych3cOG0iEhCMz8bnF9/tSMLd3rMnEwU8ikhseCiHlgWZHZaIHBCLPEl4dHoX2tQeqTPjWUahgIRieajAb5HoBdCr8pEzjCPMP2yzYZNzsSed2CTNngowPRGjXh6QU2atQQppPXmcarBTiJbDbqTYiQbkYhks2IiytErfVK9CqqrXYcqt3G7ls7yPpNdfM+uRA93KJbA6Lr0hXr2oX9frNtx6sWi+PZ383oa/JSq76phroGAcqldwvuD98VUWJsfosvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZS80wOQ70xdXL8BiQxtYE8GAsm1DWVR4Hg4S3zOx6g=;
 b=T3zurmfPMj+h7BCloKKWuNcxsxJgseGQgOA+JvGODLuaImCYQ+6DbzIscRVVi/fF3cCfZxuQX8ReDK4gCU+uipQcRKVFY8GjhTqHrsX9SMtHAzIAuW6fEj927RotycTp9PvQCQGUPiyq1LM1+pjeRn2zuusClHfp1BzFdqC+ZCUHK6UtKuzOfHkUdc4bWExMcBRiIobBNGS3MPI4/5h5E8YjsmnjzqH5ffsD5/0p/ucHdx3/LPLykVmp/vMKvvXW//FGgFIknlgeOXtJAvyALNMsAywpPXE/j8Ia9CDAntsZOdwp8lwxVlY5XOu78MwnsWPuyhMS8/CfwhBUzDYOHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZS80wOQ70xdXL8BiQxtYE8GAsm1DWVR4Hg4S3zOx6g=;
 b=iMOQNtuOCkMU7OsIgbVzddfWMt7kz6IdDgprH2DEwl5kS05hSFFjui8wW2Ujux6bbP42e1iQcJiiGwLWJ8ZQoqrpsrDVYdP3WXf8OJ2cI0PebvsCBuNJd4tgnHfYNYpv69aktagFo9EDB9bExZurDTyCVHmpWOJ5ogpgAbpvqOUewxi1/vK6FheGhxibhN9R2EQ1ulnWg+PkLweDG7zQMdUXoc2WRR3Zb8X0n1c2RgGNzzq3avK+8mGoYCFD2pmlrQK6VFLCCQJu3WnJT0b+olrSPQe5MckAuCj+dgtxVlle4tJ9l7TOkLQj1khC21bwXhI6ZmKIzBcj1BoJNTg/fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 00:15:47 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 00:15:46 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 01 Jul 2026 09:15:31 +0900
Subject: [PATCH v2 2/2] gpu: nova-core: remove local bitfield macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-nova-bitfield-v2-2-2e949bf1836c@nvidia.com>
References: <20260701-nova-bitfield-v2-0-2e949bf1836c@nvidia.com>
In-Reply-To: <20260701-nova-bitfield-v2-0-2e949bf1836c@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0190.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: c49895ad-0dd9-485f-0497-08ded705e5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|10070799003|1800799024|366016|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: +T/+JxDxHU42+7tBSTQqTpirA9wkQOOERCOBI7S3sqTzzlI5IcbVYHwFsyTH0Pj8K5l8Zi3VdH1Q9vbXDmrIYxcZbPVSvjF37z20HDNnkN2mhGOIgQej++IpgIX5ir39s4Vg47P5pWEag3u/c5oSWGT985e4JzYv8nxJGgcF5IkORiQ9b2Qe+mpPbcHaKSeyU4EnLhCI1dfrCDd12FKzG8HXB1RcME5BvrnnHiiiZ2Rp8IKUXVLvJmLgY1PbyMsLsiWUn0MRPg+8LoXuC9gPuNvwi39UWhM6fyTajfxrW51cqL04T+75610YbzKuSZ1Yr1tIMURc+c3uIqLeXP2x1ENHh9enA6yCfoomNwGTqGhZjEAf7Uqb8Y1+6uGUuF+ScsAKIiOIcFdC8e8R8N50MiNMvPXCkR6p6qOgrbhGoDuUREcmFuSymbJ8bw8cL0a/MKHUsEpk6K3HRCkiMCxAUHJ7Gs5EgQug9DHhcy0z5Hvg8rYkpOmck9LDRozQY9u3h6ZFf0cvWQhxRoCdKeGkXTyz3i92CoZTZsqYoIgemno6XAroapMlsWUKPPkl9x7/IrHHwm3HIej0mkY/ImjsiaH/K2k02IUPAxNsJJWkpXa8oN9QjAzhF84B7Ej+PC/LDtb0sZ0UeDDhlnMOJDZrLZswNKBtSHcV+Ptm91h0yvZINkOOz9SRBdp/y63W5tn/mnV51woyV2EOs7IsHWyKTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(1800799024)(366016)(921020)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnV2SmRzbm1HNy80YTVZaTRTUTVUdUNkUVFpem54RHk4c3NxeThFdnQrM3p4?=
 =?utf-8?B?U0JQclBiSnBYRms5WWx4RDJTZkdZcGlYZWw4d2g1bVJ6QWhPZE1SZ1pjRXZI?=
 =?utf-8?B?RjlhTjlpU1ppdFRRU2ltZTZwZHk4T2xyNzJ3eG0rdUJXQ0FJdW5wRmtTOVpD?=
 =?utf-8?B?a3kxYXBnZkdNSVlkazBGUmltc2ZVbFpqb2JmcnV3WGlSYWthdnJOY1JrNXhn?=
 =?utf-8?B?S0NxTW1OdHY4VTRIVzg0dHVRVE9LSFVnL3hxdXNlbXdVN0JjWDJPK2NVcENL?=
 =?utf-8?B?VGxOVVVjSTJEQ3NvRVRCL1o2OXpoVFhwYmhYbE9rWnBSd250dDdMaGxhTlQ5?=
 =?utf-8?B?WjI5TkVCTDF0cHdQVSs5Q05GMWxhZk9yMm94VVgzOXpWREFmQnFvWWJ0cVFR?=
 =?utf-8?B?UHIyUWlUdWVYVmVOWld6OEZmS2VoUWE4VzNnV0hXZTRzTXh1NGh4aU03aFM5?=
 =?utf-8?B?TURYQTlTVERQcXByc1RSbThqWkhEOERoblN3RzI0MnJLdk1LUUkxbGRrbTln?=
 =?utf-8?B?QUtqNnRtUTYwZEhRK3E1TGdxVm8vZnlvNDlKd2dFUHdEdTJLdFFSd28yRXZw?=
 =?utf-8?B?R3FkM3J4cHFtOHVzQTcvK1l1OVRwRVJaR29UemcyNjJocVNCY2w5WEIzMGQy?=
 =?utf-8?B?bXZGd0lXQ2kvUVM5NGxYaXhNdW1FRVlDQUdMb25zTWkxM1V2eFhvemNyQzZJ?=
 =?utf-8?B?UDJ2TTdGOGdrQlg0eFUwTzA5MGVjRFBSV05rcTdqZGZuYmN3bzhpa2s0NEdP?=
 =?utf-8?B?dVlrTldTTVdSUE9uQVRhUCt3MGh2czlVWndJeG5Idk9mQ2ZuYnRXdWNYVGVM?=
 =?utf-8?B?VHpBQWp3ZTBTbmRwUzRFcEtJbFFqQ2thRklMa2c1VGlkeDFoa2VOYlY3WUJF?=
 =?utf-8?B?T1pkeVJEQ1Y3aVR2U0F2K0VPVXhYdThZVktTaGpoaG9lSlFiNDllRFhXeG95?=
 =?utf-8?B?V3FVQ2d5SUJBZDhwZFlYOUJlZzk0YWUxUXdqcGlIaVFqekQ2b3AzdFl3ZVNa?=
 =?utf-8?B?NFVvbHkva3k5R3dycGVJV3ZSQURnam9rZkcwMUNFOXdtZUVYTEZ4SE5iYXpq?=
 =?utf-8?B?K1U4NThFbFdHcHRjUEZSclFFLzNrS2REVElVREJWNC9ENzZmU1BQWTZnazda?=
 =?utf-8?B?K1pNZG9pU3lTd0dHOU1aRExZc3lvUXYxSW11ZUVJQnorbGF0TjRPdG1ZVDhm?=
 =?utf-8?B?ZjJaT0xhNlpyZUZtWXhsdi9OZkoxMUJZTUxRTWE3c2poYTczWUIxZ1hFUjhL?=
 =?utf-8?B?YXMyamhyRTJaR2RUTGd4NEpiUlk1dC9qc3RacDlLaTE1OW1yMlJGZEVHT3hv?=
 =?utf-8?B?YUp2YlZ5ME16eTRYZCtYQmdsbU1QSFI2ZGxmNTJHS3ZNRWFBQ3JoK3Rwb0I3?=
 =?utf-8?B?dk5ZL0htR2F6K3IrZXE1VXFYbXpxS01VWVdoZ3JRYjN0cXNwZk9Mc0FPTmhk?=
 =?utf-8?B?QnFaUHJyOFpHamhMRm5vK0orcmtaVFcyU244Kzlmcm90VlRzQ2pudWc2WnVG?=
 =?utf-8?B?MUJ4WHUxaTRLTVFDR0JZRzBFRWV4MlQ3K0FvWHBVcWxMOUhvSmxHVGRzcFJT?=
 =?utf-8?B?dmhZbWdIbEpaUjY5akcySTJib1ZDUSt0NG5IK0xyUEkvUmRITEZ6OFlLQi9H?=
 =?utf-8?B?Yy9pMXUrZTl0YXZhZmIwai8wQnFaQVVmbU1kSlJCZSt4NDF1MkQ5QnNTWEJR?=
 =?utf-8?B?eDNxYnpZZHJpNmtFa25JQWIxUUxyTlFZS0JSd012N003M3g1UENYY1JoZmtV?=
 =?utf-8?B?U2luSjR0L2h0K1JFeXgxVE5QOUZEWHNwV2J4SURsSExCbEtmSHVZeDVkUzdP?=
 =?utf-8?B?U0VXaERUMWtDZERCYWU4Q0JpQnJjcVB4MTgzeE84SElDV0grZ2t4SWRhZjBz?=
 =?utf-8?B?ZkJ6Q1pFQURaREFwZ1VrWFpmMWVTcm15WEdrU1FocmhpVjQyRUt1Smt0U1lq?=
 =?utf-8?B?LzZTbDV4UFJlaWoyWW5YeW94b3MyZVFrSzlvRkY3K2tycVNpTGU4UWRNQ214?=
 =?utf-8?B?bTlBa3F4YVRJS1h3b1VqaWc5S094ZlhtQiswMEtYOVZkNVg1REJPc0padTB6?=
 =?utf-8?B?eVpEMkZHL0pYVlZ3QkpiU3hNNnJyajZjY3JCZ0tNRjUveXRpTW5zQTd3Q1Iw?=
 =?utf-8?B?OVVwZEYxTjNlSG5XODFFOU1TbVpxQzExRjlHQ29OWmtGWkNhVkNLTDNRZ0gy?=
 =?utf-8?B?NGxRTE1pby9TOHRqSGt6azhZbGI2WDEyYnA5MlBwaDJHQnBWSWYzSTU4ZUVw?=
 =?utf-8?B?NnB1MzM2UUx2N2Z6Z3U2R05sbE1ncWI3Y0RlQUIxOHZ6a3FFUSswUUlmTnU5?=
 =?utf-8?B?UzRWZURlU3RBWnJPR3E3WjMvYUdVaktMeis1Y3hTLzE4Z0Jqd1FWeTZYNmcz?=
 =?utf-8?Q?lQddw0vHIylD872TZTvXSeHMj6s0NHEMOyt6wOxxgEpxo?=
X-MS-Exchange-AntiSpam-MessageData-1: Odxg9NHw2ITyUA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49895ad-0dd9-485f-0497-08ded705e5f8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 00:15:46.8445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uo9iVj7/OXvrrKbSkH/Cf7VZcr8pMs5fAuHPS5ZOSscGOdxfUP4jdwxUUOB8XGsuaPZQb62j/vZ/sH4xebN8LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
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

