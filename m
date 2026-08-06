Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A325EC55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 07:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A16910F105;
	Thu,  6 Aug 2026 07:36:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="RV2nYT9n";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AACD510F105
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 07:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMzF4k3LFGAmNF3sfYV78VaHFDW2e7+AHKRG6tgXk9iVclj+DFUsETYcEqjbk09IIii1XC6yxoPVotdHhoC0uaq8jlQjl0L9D7bOfcLFwob3iqAVZOcs3fhR5p9fBAf2z99IWAEhTwJj9xK+xKNdm073FhdfmfNJ+nzGJK5Il2W2loU++rPaSyGkI/fs5bmKi5trPLEfE1qIsdiKjpieHqqDeEmPGmFngfnVjuH9Cl37YpIs1F+imMq+x7AfNs9dkOBK83WyCaBT1NnLzdsXqkxmOD7hYdhhuYNBpcDUV6kV4CQIU3Z/gUdaSF8IaijHc0qCUqfxkjpCAst6z6K/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAYpAy8/2R8bDfnL6Bdl/75karKxdg5K3s6wbTei5Qs=;
 b=wQld0cqOloBhlMN8r1n4d9kI29JgdaBIj4cv5x7++3jWuy6Sqs979joOvmS0gS5mNYizvlGjuD5RmF9++DH2KwR3k6HKXdj40sV65KmKiG8u0jm4zwyGEMDA8uHnqaoIBe96XC6GSHKJ8IU02J9OCFy2/6x69QfwnDOIFYHiPxCiyfA9PlAqPUt+jdrPo4BPRZpB3IUxMpMs9fDl7hoJ8za4SPR4BoKjPwshfL2YEKEMVQN8JfZT1VeF+1EeVp5XuuV5Da1q4ajywl+rasAn8fe1quDYbpAOib7ZWIxOwNyXK3A8HRwb1bXNw77UYwoXiYUKbpc5ijqqHd12VXp4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAYpAy8/2R8bDfnL6Bdl/75karKxdg5K3s6wbTei5Qs=;
 b=RV2nYT9nO4Q7K5KN2SbzDYvPIYWxUS/w+X3F5l9udHp3hGSQre9OnZ1Z84VyySTK8VA0Xm1SxXO2H4krxVZ93YTLCeeJb8AsoVB4lA70vxyyisV/5kNROAkzE0QWhKOk4Ki06fMKtxWwjb9Kq7OcNuqyxljRJfv9SiVwrEtCiJkWlRujfnoQTBiwIs0eVcyPWL1P0yJyOAH7cqB3QmDDzoOaw+Rbbft+Rm8EIW/hJTwWnBMs7TH3IS9VgeuwBPQx+n089g6HpmTMMv1UdxWBP5MrJbzjsEN7P9J8Icy9q4BSVMYqMoyixa8qXqLfTKONzFaVmWHXuUeTY2SwENUNjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8878.namprd12.prod.outlook.com (2603:10b6:610:17e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 07:36:31 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 07:36:31 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 06 Aug 2026 16:35:53 +0900
Subject: [PATCH v2 1/2] rust: add functions and traits for lossless integer
 conversions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-as_casts-v2-1-cb76a4d3a6ef@nvidia.com>
References: <20260806-as_casts-v2-0-cb76a4d3a6ef@nvidia.com>
In-Reply-To: <20260806-as_casts-v2-0-cb76a4d3a6ef@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0147.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8878:EE_
X-MS-Office365-Filtering-Correlation-Id: 731de16a-452d-4087-dc70-08def38d6ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|10070799003|366016|1800799024|921020|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: f2aa50bOpe6ZlTCWm2Vvs84sBkbhnDIOu5Y2N1qWPzPRCSlRdhv5+M8jE4T4zEoVMzGLE5fa0DImePXr9liGOwExRXDq4v31xDWmY7yNhz9cS+qtz1CqbdM/tcCamaM6XCTXcNCAcUEdnW9Ry722rzweoTFGO/PumPgXpJ+m0fhOjRqfVkY7JWoCAL3tMxbh0wXByuvRbael9H57NrHBSRyyp0oGvHbdlwzvDJSAwPzN2yrF5VHapPQUiFThrZF3aMxy9a1H7Pta1JrBu8bxbLPJN3i9xvKkcgaay5khKlOmxwwIv4MGIzssuWji49hS9lKcN3O/W2zudZcUWLrilyR+UjJ8uRZtlkT6GdCWnp+GP25y5/wHeMbnsHcDd8QHyBTjLbhRm3k0kP3pF7gb/HhqWBON2UhHwmP+7jw3cauNQS50JTmWXPmcQbD1+mpKfzx+cMHbVlybwHtg1g0uDJ5sUOXnCmkykNz03JpHVwlYce8pmWdo4mTVjvdwfWgvX32wzWl1uCjXquLpqCuWnxLHHP4ZtEA7eMmflvuWu7YIYJkYPByJpEPfRHXzUd9d25ADMYTvJQqR+1J+/dKQp01fQWGhmd3fD8I05kWrQ4Z9NZhko8Fi5ZVcGUKQ0mdGEAkk9Ahpzkku4O+0urxSs2PkiUSaqdAaBxFwDq1sMwgyypalGOpA0PPu9FUXuUrS/r8PBpY8+yvcwwKcnV949A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(366016)(1800799024)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVEzdSthZUQ0djY2QW41ei9rSW5RMk51ZXRkVnd6ODJHVWM0T3pQOHRxOEJ4?=
 =?utf-8?B?bjFTaW41ZkNVcm94dlFqbzE3VmxNdjYvZnhNWGRyOEw0bDUzS2p4Nm9aSG8y?=
 =?utf-8?B?VHRDTHR6ajRHaGVXdFlyQjlJZnl6ODA3bVB0Q1NJanZTQnNNcDN6UGFDb0Ry?=
 =?utf-8?B?T0c0VVhuVFAvR3BTTGQ5ZmkwT2ZvdTExb1lDS0hETEl0KzBBSnhUd3UzUStO?=
 =?utf-8?B?eWFKeUNEa2VubEViRDBuTGFWZDN3WnJtUE5CWG9xLzJnQmVqaktuREJuL3Yz?=
 =?utf-8?B?OEVMMEI1OU1yNWhrOEtMdVpEb2FGcnEyUTJ4U01HOUs1ZVdHcHFaS2RZZmJ2?=
 =?utf-8?B?Vk5OK2d0VXBOZ2dRSXhnVEVieVFBZkx3RnNMdVRUa3BnSHo4aW1qSllpdlNU?=
 =?utf-8?B?WGs5QmlzMDlhdXpTN3JBYm1ZUmdRSXhrbkhORHRteXFFc3Z4ZnJINHVhQUhF?=
 =?utf-8?B?STRKR0ttM3JJVncwRjdMNHdmL2h1RS9LbS84TXQ2UEZYbU91M25PeFJZTWJu?=
 =?utf-8?B?V2tNL2d5TFBXaGVWU3h4WDBOZlFvZTRSdXRuZFhEc2k3NzNNMVU3dUxBRmZH?=
 =?utf-8?B?Q1ZyZm5teXQybDRrZ0wzY3lFNExxVU9GUzdLK2Y3d2JhS3lJeXZrOHJJeGZo?=
 =?utf-8?B?UDhEQkdCVnkwalR5ZW1vQVNkSStKUm5QUjVQSFg4SkdrbzZ6c2dLT1gycTEy?=
 =?utf-8?B?d1R2Z0h0T2lsWVdKN2oyN3RPUkZVb285WWQ5Q1VrTDVlN1NGaWFDMWkwMDZo?=
 =?utf-8?B?TlhzQmtyVWpUb0Y3U2VnSDB3bG9wdEc5dWhiWExuZm1XZkpxSS9Mckp3a256?=
 =?utf-8?B?WlQxbWVHQjJtcUJWVlJvenQ2N1hQcHVFdGxnaEFCOGcwNDdoVTJzdHduSkJE?=
 =?utf-8?B?T3ZMVjRMWGM3UlN0VVp4UWdCMlFkc2I4WFl2VDIvdVZEMEZLRVJqUFN6Z1k1?=
 =?utf-8?B?dTgrQzlpKzhyNW10Z21kMkNnSWdLMVZSR3R2MjY1RGRRSlRmRXRoNG0vbXRq?=
 =?utf-8?B?aUtHRUYrdnBSVXo5VzZDMzVxcCthOXQrMzBta0luVDRUdG9UNGZKYjhFcExl?=
 =?utf-8?B?L3o5blF1MGZjU3dhRWxXZjhrUFFlRnR2aFpKbGt5dUtDbzVaQis2VjBVRm5I?=
 =?utf-8?B?Wk1WSjJjR00zcXhlckEzTGdJUXdUOHZxRkozMVRlQksyemNsOFlmSDFFWTEx?=
 =?utf-8?B?RFQ4SGYwNnZWT0R6RkwwelFMeEExWmw3cFVmMktQUUNzUk0vUVRzLzEvVGtW?=
 =?utf-8?B?QW1taExJc3hEWDBsZjhmeWk0Q0dZaCtCZnZVaDI0TldHRnU5YzdtQ0RxK2lU?=
 =?utf-8?B?cGNUU1FEc0QrODYrZ0tmK3VtMWpLZ09WR0hIVFR5VVBFS3VmKzJIeHB2QmlX?=
 =?utf-8?B?dkJ2U2ZTV3JPY2V5VDJxQ3duVU1LblNhZkVjeWpobWFFeVdjMkRZbWo3ZGVL?=
 =?utf-8?B?b3ZtYmpabHZLcnBuVlJ5TlZDb29hZGpabzZUSGZaNk5YWEdqUWtETVN4NldT?=
 =?utf-8?B?WDc2NFNBK1BHYjlrendaTGJoMXYrSFdzakRLUUpSemdUNkxZSTB5SlF2Q1pS?=
 =?utf-8?B?RzVRSjhveUJRZ2gvejRzOUJLK2hpSExLcEt5OU1jU01iTHVPYURIUHcycVJx?=
 =?utf-8?B?UFFjc045RnE3azkrems4Y1dPY01OVndRRm40Rmd3Y2RmcmZWbkNnR3Z5dWxp?=
 =?utf-8?B?enFWUDhQNDVuWC9wZkRhUkFnUFE1RjhFV0VhQlJqN1pjWFlJTTN4YXZXdHdo?=
 =?utf-8?B?bWZ3YjRmVnNMcnFwT0dsU3VOZ3JUeXVVSWJKM2t5ZzNHR2ZyQ1dmL0VJcVFC?=
 =?utf-8?B?YUxHRTJjUHZtZzhkUGtmMXROcUxpU2svQ2VKQm5QZzVRQUF5akNMZ0t1cW52?=
 =?utf-8?B?ZzFZSys0cUpQTytCQytDaUlET1JzYmlYV2FnVFlHYWNXSzJ5bTc2TXcvMEN3?=
 =?utf-8?B?RDVOWi9Tajg3Z2lITDlvU3B2SzN3RC91cGM2SXBPU3h2YWxoYzNMbnhTZzhu?=
 =?utf-8?B?VlhGb0FoOUxGZWZvK3pGVGxzbFY3eDJMUUFyQkFwYjhnREdKaXJnNHgyN2Vr?=
 =?utf-8?B?UVB6cHBwWkhLRVpYN25CTHY2RDNhOUlHOVRNUHlKQXVpRWFWWm9qbkQrbWpv?=
 =?utf-8?B?bkZENXBBTjZGNlFra1NOQzNhRkNRK2Y4ZWlSM0FxOHdlTXM1RmVRd2gwVUs3?=
 =?utf-8?B?dnlTekhZNm5zcmRkOFJzOTlNQys2a2dadm1EeHlpOUp0L2NJT2srSzRSK1I0?=
 =?utf-8?B?OGhhaG9xS0M5RG5Fd3BPMnBFOUFuMzdMWnh5SEF3UFg5UURXcUJlUEwxY0ZF?=
 =?utf-8?B?Y215NXA4WUxlZHVEczIwcWRBdElkRitzMG12ZzdQVlVwYmp0T3VCYTFiOFp4?=
 =?utf-8?Q?PWbc01fSQZZOn/25heb+ajAuth+ymkIIhXz1Tf94aYsBQ?=
X-MS-Exchange-AntiSpam-MessageData-1: 2W9PwPqU3Je0Jg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731de16a-452d-4087-dc70-08def38d6ee1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 07:36:31.1075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQkGmWiyuoN3BIAVUa+V78pVh9CPEHz092REHVhJCzcVBMYlPCjAy+2umhhG0YHxTIi5ZfcbnJAMIrA7GFSHJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8878
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

The core library's `From` implementations do not cover conversions that
are not portable or future-proof. For instance, even though it is safe
today, `From<usize>` is not implemented for `u64` because of the
possibility of supporting larger-than-64bit architectures in the future.

However, the kernel supports a narrower set of architectures, with a
considerable amount of code that is architecture-specific. This makes it
helpful and desirable to provide more infallible conversions, lest we
rely on the `as` keyword and carry the risk of silently losing data.

Thus, introduce a new module `num::casts` that provides safe const
functions performing more conversions allowed by the build target, as
well as `FromSafeCast` and `IntoSafeCast` traits that are just
extensions of `From` and `Into` to conversions that are known to be
lossless.

Some conversions are architecture-specific: for instance, converting a
`u64` to a `usize` is only lossless on 64-bit platforms. These
conversions are made available via a dedicated `arch` sub-module.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Link: https://lore.kernel.org/rust-for-linux/DDK4KADWJHMG.1FUPL3SDR26XF@kernel.org/
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/num.rs       |   2 +
 rust/kernel/num/casts.rs | 298 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 300 insertions(+)

diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
index 8532b511384c..dbe848e30efe 100644
--- a/rust/kernel/num.rs
+++ b/rust/kernel/num.rs
@@ -5,6 +5,8 @@
 use core::ops;
 
 pub mod bounded;
+pub mod casts;
+
 pub use bounded::*;
 
 /// Designates unsigned primitive types.
diff --git a/rust/kernel/num/casts.rs b/rust/kernel/num/casts.rs
new file mode 100644
index 000000000000..a44397541cfe
--- /dev/null
+++ b/rust/kernel/num/casts.rs
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Helpers for performing lossless integer casts.
+//!
+//! The `as` keyword can be used to perform casts between integer types, but it unfortunately makes
+//! no distinction between casts that are lossless, and casts from a larger type into a smaller one
+//! that might silently strip data away. Thus, its use in the kernel is discouraged in favor of
+//! [`From`] implementations.
+//!
+//! Conversely, there are casts that are lossless depending on the build architecture (such as
+//! casting [`usize`] to [`u64`] on 32 or 64 bit archs), but not supported by [`From`]
+//! implementations in the standard library because they are not portable. It does however make
+//! sense for the kernel to support these, if only for code that is architecture-specific.
+//!
+//! This module provides ways to perform such conversions safely:
+//!
+//! - A series of const functions (e.g. [`usize_as_u64`]) supporting safe conversions in const
+//!   context. Conversions supported by [`From`] implementations in the standard library are also
+//!   covered as the [`From`] trait cannot be used in const context.
+//! - Two extension traits, [`FromSafeCast`] and [`IntoSafeCast`], providing conversion methods
+//!   similar to [`From`] and [`Into`] for conversions that are safe to perform in the kernel, but
+//!   not supported by the standard library.
+//! - Another series of const functions (e.g. [`u64_into_u8`]) supporting the conversion of a const
+//!   value from a larger type into a smaller one, provided the value fits into the destination
+//!   type. This is useful if a constant is defined as a larger type, but needs to be used as a
+//!   smaller one.
+//! - An [`arch`] sub-module, defining more conversion functions that are only guaranteed to be
+//!   lossless for a given pointer size. These can only be used in code that is specific to a
+//!   given pointer size.
+//!
+//! # Examples
+//!
+//! ```
+//! use kernel::num::casts::{self, FromSafeCast, IntoSafeCast};
+//!
+//! // Conversion from const context.
+//! const USIZED_CONST: usize = casts::u8_as_usize(255u8);
+//!
+//! // Non-const conversions.
+//! let a = u64::from_safe_cast(4096usize);
+//! let b: u64 = 4096usize.into_safe_cast();
+//! ```
+
+use crate::prelude::*;
+
+/// Implements safe `as` conversion functions from a given type into a series of target types.
+///
+/// These functions can be used in place of `as`, with the guarantee that they will be lossless.
+macro_rules! impl_safe_as {
+    ($from:ty as { $($into:ty),* }) => {
+        $(
+        $crate::macros::paste! {
+            #[doc = ::core::concat!(
+                "Losslessly converts a [`",
+                ::core::stringify!($from),
+                "`] into a [`",
+                ::core::stringify!($into),
+                "`].")]
+            ///
+            /// This conversion is allowed as it is always lossless. Prefer this over the `as`
+            /// keyword to ensure no lossy casts are performed.
+            ///
+            /// This is for use from a `const` context. For non `const` use, prefer the
+            /// [`FromSafeCast`] and [`IntoSafeCast`] traits.
+            ///
+            /// # Examples
+            ///
+            /// ```
+            /// use kernel::num::casts;
+            ///
+            #[doc = ::core::concat!(
+                "assert_eq!(casts::",
+                ::core::stringify!($from),
+                "_as_",
+                ::core::stringify!($into),
+                "(1",
+                ::core::stringify!($from),
+                "), 1",
+                ::core::stringify!($into),
+                ");")]
+            /// ```
+            #[inline]
+            pub const fn [<$from _as_ $into>](value: $from) -> $into {
+                $crate::static_assert!(size_of::<$into>() >= size_of::<$from>());
+
+                value as $into
+            }
+        }
+        )*
+    };
+}
+
+// Valid `Into` transformations.
+impl_safe_as!(u8 as { u16, u32, u64, usize });
+impl_safe_as!(u16 as { u32, u64, usize });
+impl_safe_as!(u32 as { u64 });
+// A `usize` fits into a `u64` on all supported platforms.
+impl_safe_as!(usize as { u64 });
+// A `u32` fits into a `usize` on all supported platforms.
+impl_safe_as!(u32 as { usize });
+
+/// Extension trait providing guaranteed lossless cast to `Self` from `T`.
+///
+/// The standard library's `From` implementations do not cover conversions that are not portable or
+/// future-proof. For instance, even though it is safe today, `From<usize>` is not implemented for
+/// [`u64`] because of the possibility of needing to support larger-than-64bit architectures in the
+/// future.
+///
+/// The workaround is to either deal with the error handling of [`TryFrom`] for an operation that
+/// technically cannot fail, or to use the `as` keyword, which can silently strip data if the
+/// destination type is smaller than the source.
+///
+/// Both options are hardly acceptable for the kernel. It is also a much more architecture
+/// dependent environment, supporting only 32 and 64 bit architectures, with some modules
+/// explicitly depending on a specific bus width that could greatly benefit from infallible
+/// conversion operations.
+///
+/// Thus this extension trait that provides, for all architectures supported by the kernel,
+/// conversion methods between types for which such a cast is lossless.
+///
+/// In other words, this trait is implemented if, for all supported targets and with `t: T`, the
+/// `t as Self` operation is completely lossless.
+///
+/// Prefer this over the `as` keyword to guarantee that no lossy casts are performed.
+///
+/// If you need to perform a conversion in `const` context, use [`u32_as_usize`], [`usize_as_u64`],
+/// etc.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::casts::FromSafeCast;
+///
+/// assert_eq!(usize::from_safe_cast(0xf00u32), 0xf00usize);
+/// ```
+pub trait FromSafeCast<T> {
+    /// Create a `Self` from `value`. This operation is guaranteed to be lossless.
+    fn from_safe_cast(value: T) -> Self;
+}
+
+// A `usize` fits into a `u64` on all supported platforms.
+impl FromSafeCast<usize> for u64 {
+    #[inline]
+    fn from_safe_cast(value: usize) -> Self {
+        usize_as_u64(value)
+    }
+}
+
+// A `u32` fits into a `usize` on all supported platforms.
+impl FromSafeCast<u32> for usize {
+    #[inline]
+    fn from_safe_cast(value: u32) -> Self {
+        u32_as_usize(value)
+    }
+}
+
+/// Counterpart to the [`FromSafeCast`] trait, i.e. this trait is to [`FromSafeCast`] what [`Into`]
+/// is to [`From`].
+///
+/// See the documentation of [`FromSafeCast`] for the motivation.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::num::casts::IntoSafeCast;
+///
+/// assert_eq!(0xf00usize, 0xf00u32.into_safe_cast());
+/// ```
+pub trait IntoSafeCast<T> {
+    /// Convert `self` into a `T`. This operation is guaranteed to be lossless.
+    fn into_safe_cast(self) -> T;
+}
+
+/// Reverse operation for types implementing [`FromSafeCast`].
+impl<S, T> IntoSafeCast<T> for S
+where
+    T: FromSafeCast<S>,
+{
+    #[inline]
+    fn into_safe_cast(self) -> T {
+        T::from_safe_cast(self)
+    }
+}
+
+/// Implements lossless conversion of a constant from a larger type into a smaller one.
+macro_rules! impl_const_into {
+    ($from:ty => { $($into:ty),* }) => {
+        $(
+        $crate::macros::paste! {
+            #[doc = ::core::concat!(
+                "Performs a build-time safe conversion of a [`",
+                ::core::stringify!($from),
+                "`] constant value into a [`",
+                ::core::stringify!($into),
+                "`].")]
+            ///
+            /// This checks at compile-time that the conversion is lossless, and triggers a build
+            /// error if it isn't.
+            ///
+            /// # Examples
+            ///
+            /// ```
+            /// use kernel::num::casts;
+            ///
+            /// // Succeeds because the value of the source fits into the destination's type.
+            #[doc = ::core::concat!(
+                "assert_eq!(casts::",
+                ::core::stringify!($from),
+                "_into_",
+                ::core::stringify!($into),
+                "::<1",
+                ::core::stringify!($from),
+                ">(), 1",
+                ::core::stringify!($into),
+                ");")]
+            /// ```
+            #[inline]
+            pub const fn [<$from _into_ $into>]<const N: $from>() -> $into {
+                // Make sure that the target type is smaller than the source one.
+                $crate::static_assert!($from::BITS >= $into::BITS);
+                // CAST: we statically enforced above that `$from` is larger than `$into`, so the
+                // `as` conversion will be lossless.
+                $crate::const_assert!(N >= $into::MIN as $from && N <= $into::MAX as $from);
+
+                N as $into
+            }
+        }
+        )*
+    };
+}
+
+impl_const_into!(usize => { u8, u16, u32 });
+impl_const_into!(u64 => { u8, u16, u32 });
+impl_const_into!(u32 => { u8, u16 });
+impl_const_into!(u16 => { u8 });
+
+/// Conversions that are only lossless for the current architecture.
+///
+/// # Portability
+///
+/// Callers of this module become dependent on the setting of `CONFIG_64BIT`. Use with caution, and
+/// never in code that is portable across pointer sizes.
+pub mod arch {
+    /// Trait identical to [`FromSafeCast`](super::FromSafeCast), but for conversions that are not
+    /// available on all architectures.
+    pub trait FromSafeCastArch<T> {
+        /// Create a `Self` from `value`. This operation is guaranteed to be lossless.
+        fn from_safe_cast_arch(value: T) -> Self;
+    }
+
+    /// Trait identical to [`IntoSafeCast`](super::IntoSafeCast), but for conversions that are not
+    /// available on all architectures.
+    pub trait IntoSafeCastArch<T> {
+        /// Convert `self` into a `T`. This operation is guaranteed to be lossless.
+        fn into_safe_cast_arch(self) -> T;
+    }
+
+    /// Reverse operation for types implementing [`FromSafeCastArch`].
+    impl<S, T> IntoSafeCastArch<T> for S
+    where
+        T: FromSafeCastArch<S>,
+    {
+        #[inline]
+        fn into_safe_cast_arch(self) -> T {
+            T::from_safe_cast_arch(self)
+        }
+    }
+
+    /// A `u64` fits into a `usize` on 64-bit platforms.
+    #[cfg(CONFIG_64BIT)]
+    #[inline]
+    pub const fn u64_as_usize(value: u64) -> usize {
+        value as usize
+    }
+
+    #[cfg(CONFIG_64BIT)]
+    impl FromSafeCastArch<u64> for usize {
+        #[inline]
+        fn from_safe_cast_arch(value: u64) -> Self {
+            u64_as_usize(value)
+        }
+    }
+
+    /// A `usize` fits into a `u32` on 32-bit platforms.
+    #[cfg(not(CONFIG_64BIT))]
+    #[inline]
+    pub const fn usize_as_u32(value: usize) -> u32 {
+        value as u32
+    }
+
+    #[cfg(not(CONFIG_64BIT))]
+    impl FromSafeCastArch<usize> for u32 {
+        #[inline]
+        fn from_safe_cast_arch(value: usize) -> Self {
+            usize_as_u32(value)
+        }
+    }
+}

-- 
2.55.0

