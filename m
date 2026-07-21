Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63360C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B42AA10E76D;
	Tue, 21 Jul 2026 11:01:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z9hbI1nm";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A60A310E76D
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhGEwsxX/yOCzKdfL4keHwrILqlIzdRigqem24zYUZFlIkggnxOdozvmCl9uHbX/XF/H/ca5guG2SfWxaOZ8/+MAKwbetMs4T2sQZgyB785SQS4/HP51YleRyxec/+YTnENE4MdF8uvmf8Kb7oPg+/ZSgzdD4z/YTCYkWx7b4YR8j9el5XVMZSIfZrpwQ23KXVHI45K0VNFjuq3UhEeOyYDH8xbrlCoc+zll/io7L9S07cU+HiANOuWP/Bla3Pxoc9auPu4euCbeXA0R1i251uc7KZR5Hz+eCtKb8n52HL8tJ5CCpFQtHLZzw+Smg+dPSP8iUmNWR9oKx8gsI3aFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s64U2lacdai+bDPET/mJpx6CwUcyH/DYr4RdHth2T3U=;
 b=iuqiFvqp885cHJX+KcIFg1DN1EWdIBoZr1xTieAhmyhg7XnnX59DEPwUS1DooXi19hcTOQaDhIP4tC+hn4GyBOmosxAydfB4nKyi8bcI5S82w5gTrGBWUfIzVYq12zFsCmkrQaiBEHQq3CSpdMdL18DUzhh3o5g1XR74LI4unqb0xXh7nLrqOKgVrXfgTyweBWI7bXxioi1caxDgwm4c4XbFTy5qmeqCK8SsZXLiJrfzyF/RLKAo6e2yHoUvlySg3wUJyEn/dxJqpUUSGB8cgchbnEOxeU58TuC/rBqg6Qu4n0SCCZ8TWje5ECgXHYUYrs/Jy9mdHQpsp/gS327EHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s64U2lacdai+bDPET/mJpx6CwUcyH/DYr4RdHth2T3U=;
 b=Z9hbI1nmdBemSrV0/WeJlwhcMkEcD8Hls3npF8Y9PvPqT/yTHUxjtNKtiF3E5kpqOJtjFDxjl1mtYd81C2R6FhsFkkJluYwT/dRFbvSEuYRKFVpI84TjZwgTgN6uB+1dYG6bzDzzDyZakrjQkS0khQoFhIlIsiE2DjXnM1Q7B4Cv1qDPfwj4WGgbbpMuFgX0fbLuOLnPqWMAGYfrSqfjT152fpvPAabpNEUIgd3b4+ZdH+P+k3mNq3+dLQRnYtw/8bB/1Zdj+jnEh8n0BaqzZAD2OzyNLFhwnBuSVbw580Z2cD6frkrsMAPxcqAd2ISmSaarc5m9NGhFT+a47Y8gWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 11:00:55 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 11:00:53 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 21 Jul 2026 04:00:12 -0700
Subject: [PATCH 3/8] rust: io: register: use path fragment for alias
 destination
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-registers_fix-v1-3-3711b2317e1f@nvidia.com>
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
X-ClientProxiedBy: KU2P306CA0028.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3b::18) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 20629ba3-b57c-4cef-fc91-08dee71754bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|11063799006|10067099003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jciw+O5+aWW4J8lYda3wB/r+zdicOLZBzcjDQpAsNB/ZK3c1H+TlRNghdCHaWE35h2eikpyqypeW76Zj+iX46AeZCdkPxxT0XS68O5K7XO0mS1jU7TnC/6XIUmC0X3nd23BLEGhR0zTVhTXnciVdQyRy09kyt5Mvbg6BeFytf2Th0jkShdpWvuQNkOMcEfRA6JdKVUuZcMgSdxG6ypeQE7Oe5I07VkREqbwAvmPg6HfYNTSjvVUUfpCcj0iIIGY3zBrbpkL8iChWm8OMMX/1B8FaIO8uCMYzJXRTklCRA+A5vUdVJ9rt8XWUK1TQZv2aqp6FI1+Bxc4deRutK8AEn8HM2uIpHRJy2IiFYb5FNzIh/xrZIDEQ2ulbzfXlGyL5cI/iU5GMkBR6a5NF/NbZEM5S0jYBCywbYAPk6IADkcesOEt9UBwMQgRR8o4jfE6XTkAVwpopmZeIpUCyG6AlfE0AjTTxz+IGCCWb5SDRjSATwyD/OwRED62dJlVMHmWo1DbwGA7uOu6+QTuEOniS9mLHBGEV+s0lEHMgGH4yZ72BqxPhw8MD2nF/bg6QcxYzeofBPKq9lKUJLyGW2q+6qw8IhSXGmUojVHAiy29zcSrxJqYiOaV3MZ2El/5yh4MXGqVC9nF55Pfp3suXNcHsEyL9DkwdgJHxmX/lXaPhz7RSy5nUASVBdgr34bFa3NpRY8MjukJ57HTjdUWyyz2UfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzZjdy8wRUpTNm9SSjBtTXZ4eCtjVFFVUmlyNTEwZUVTSXNLanEwTEpSTk05?=
 =?utf-8?B?SjVvaWlYTk1aaUtEL1h5b2o1aWpoZDdTVGtrZnJUdEJFSGtaTnZkLzJobTRr?=
 =?utf-8?B?UzVuRitCWGdPbUxJT0ZRTlRkNi9lejRNNUJYeEFtaWtwYTBMRU5pRGJIc0px?=
 =?utf-8?B?RzlVRk1nbTBOOG1zNVNqM2tQQU1zelQrNUtaUURTLzZtTDFpcTJsU2F0dXBD?=
 =?utf-8?B?SVdoa2xpanhiSWJNM3NtVVh4VEZjOXdocXJOQ3QwRWsvMDJpNGEvSnovTHFh?=
 =?utf-8?B?UGlvTnlQbDhpV0s5RnFXSEZwOXN4WTFmeGFTeGlqNWhTd3lGVVNYNVphVWN2?=
 =?utf-8?B?dmZlMHhLMWkyNjNMaTBjcXFwbFRnaUlaaEY5QWMwSVRvZ1c0a21rLzhqcitR?=
 =?utf-8?B?dmFmeW44ajJKK2huRFR6TGppRTlvU2c5dERjT3lQTUR4VFc1VnhOQzFLeHN3?=
 =?utf-8?B?NTZHcWg0cE52UmJTUzRud1hORnAvOVNOWUwvanZ1QnpvZ1VvaWNPVVRWTkpo?=
 =?utf-8?B?WnZKazVYUHFCNWpTSlhCbjBvZGhraDBXRllGWGw0WUV6OE9wR1k5SnUvNkt5?=
 =?utf-8?B?Um01bW9YRHd6bVI2MlJZVGVXcmx6OTJlTEpObWxlZDhxdXRobkVDRlNaTlU5?=
 =?utf-8?B?UzU2dVJhL0FSU3NuUldVVE1jTlhmNXQrUUh5dUNpQXpGQkxBR0NtNUxGRy9n?=
 =?utf-8?B?K1VnN1FvVzE3TFdvRWcvNFh2aEg4R0FFMmloakFDa2czYm9pVFd5NUtRTFRM?=
 =?utf-8?B?amxlNlVNT2VHNUNzRXQyZHplYmhaR2ZHd3hWUGdvVTlFRERjT0gyOHpCamQ0?=
 =?utf-8?B?Z0FDbzFFSmtPcTZaQUhHL0NaTzRrY1g3UW56VEFmQjRGa1pwb00wMzFkRTNQ?=
 =?utf-8?B?bmFRRUVDTW9Jd1dWMCtNdWJXTWpWd3kyNU9NNFRiRWZvRngrRzFvNWZ1cnVQ?=
 =?utf-8?B?VTVNNGcwUGl5MDRsL2N1WjdMb3M5UXI4WDFhbUpFRUw3MEZRVG10MzJsVjZq?=
 =?utf-8?B?U0s5VS9MVHNSY2RiRk12TEtYUXVGY3M1SHIzeno4RElXdHhFUXNkdUpheU5N?=
 =?utf-8?B?UFZUL1RZMDNwVDV6ZmtlYldOTlZaWFhJSVI1NE1iSitkSGg4R3ZOZkcrV0Js?=
 =?utf-8?B?dk9TeDRrYk9DWkY0MDZEZXdFYktGTWdNdEdCWFFvNi9tLzR4QlQ2bU5oL0RK?=
 =?utf-8?B?ekRkK2hBQnpvUlA3clZnYWZKdDRZdDhHaVFzN2FhbHNCVkhUZGdncUM3Z1pn?=
 =?utf-8?B?MzBwcHVZNWZXb2V5NG5sQjRQaXQ3K3ZMSjltcHU1NlpiSFhSbTZBa1RnN0E0?=
 =?utf-8?B?OGRiNEk0ZG1NNE1UTTN2RW1VVHVJQVlmaUNnYXZ3VVYwRGZBc2Z4V2daRXR0?=
 =?utf-8?B?WkkzNXJTM2k4b3pLbVdGWkE1ZWo1WERpY3cwelpVT2NRRkNjRXovYzBiR1RR?=
 =?utf-8?B?c0MxRlBYcHVEYU9LQkdraU9SUWVoSHNEczlaaHZyYTNQRytBKzVDU0I1UzRI?=
 =?utf-8?B?dURNZ0xCUXdTalRTMG56UGpCSjJvQ0FKQU1QdCtOdjNpU1VUQmRBVkdXTEVr?=
 =?utf-8?B?Q0sxVWIrdEE3dDk2eWtSeEkxSStCNWt0TWt1Tzg2SGVkakFuQnh1clFCQUZI?=
 =?utf-8?B?NEgzUitkSzRvUEFjN1RFUXlhK0pLcFcrN3BBOTV0VXlxVkpaVEFWZkFqblZH?=
 =?utf-8?B?MlVCQjJ4RnRtUkd4Qm1BaXNnM0h5SXVxbTZ1aFFlalIzVzJtRzIxSmwrZW91?=
 =?utf-8?B?ZWlmU1hGUThEYTFQaGFjT0FEczRnTW04REl4K1pjdzcraWNESm5PZysyQnF4?=
 =?utf-8?B?K3A0TmZrSUp4Q1BiSVIxbnpBb0duSzUrT2VkKy8yRFB6MmFJZWJEOWs2Q3dK?=
 =?utf-8?B?cFZXZys2dkR0bk9tZUJtb0NIekNNeUE2ZGdMbEluTEhHWnp6RVFyeVM1QzlC?=
 =?utf-8?B?dTMyNVE1NjRkYzRiS2U2ZTJjZXpvNk0wanFSVzBvU1ZnQ0EzN0dpMWlaajR3?=
 =?utf-8?B?MituUXJUTlQwZko4L0lhcjZTRUlEcU1zSzBMZnB5NmhnZXQrajFXZzQ0R2k0?=
 =?utf-8?B?STFqVkRZMnZ6UHN4b1ZINVFiV0ttbmt6YnQxYzNhbmtsWVExNmtuODBjL2JF?=
 =?utf-8?B?R3FWYmlBTDFvY01NaDJwOHVlQ2plaUhxdUhidDJlc3hTbTBzSThoNHkxU2Jz?=
 =?utf-8?B?OEVURTBYS0ZZL0g0Z2FmZkIyS2ZzcThRUEtobnRGMFVpa0JUMk83dWJDRDJH?=
 =?utf-8?B?amFFNEdpYjk4ZndJL1FRZ0N4TythZjRqckRPZkhDMSt4RjgrdEM4dmhtVUhM?=
 =?utf-8?B?NHZTb1pwdGtKZzk0MldhTGhlN3lMemNSNng4QldpaTJDWVNBbjBWdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20629ba3-b57c-4cef-fc91-08dee71754bb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:00:53.4356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqAs6avd/hXnDk9G3oCZS+HWuLq43bwYJRZXGIkJsilBaKrc6NSwmROAyznlRYSZJRZ8SNYOAbr3a1bjIyQiVw==
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

The destination of an alias, whether it is fixed, relative, or indexed,
is always another register, i.e. a `struct` type. Replace the `ident`
fragment with a `path` one which is more accurate, and allows
referencing registers using a qualified path instead of only identifiers
visible from the current module.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io/register.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index 82f674aea45a..1e0e23e4233f 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -809,7 +809,7 @@ macro_rules! register {
             $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
                 $([ $size:expr $(, stride = $stride:expr)? ])?
                 $(@ $($base:ident +)? $offset:literal)?
-                $(=> $alias:ident $(+ $alias_offset:ident)? $([$alias_idx:expr])? )?
+                $(=> $alias:ident $(+ $alias_offset:path)? $([$alias_idx:expr])? )?
             { $($fields:tt)* }
         )*
     ) => {
@@ -837,7 +837,7 @@ macro_rules! register {
 
     // Creates an alias register of fixed offset register `alias` with its own fields.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:ident
+        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:path
             { $($fields:tt)* }
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
@@ -860,7 +860,7 @@ macro_rules! register {
 
     // Creates an alias register of relative offset register `alias` with its own fields.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $base:ident + $alias:ident
+        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $base:ident + $alias:path
             { $($fields:tt)* }
     ) => {
         $crate::register!(@bitfield $(#[$attr])* $vis struct $name($storage) { $($fields)* });
@@ -896,7 +896,7 @@ macro_rules! register {
 
     // Creates an alias of register `idx` of array of registers `alias` with its own fields.
     (
-        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:ident [ $idx:expr ]
+        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) => $alias:path [ $idx:expr ]
             { $($fields:tt)* }
     ) => {
         $crate::build_assert::static_assert!(
@@ -940,7 +940,7 @@ macro_rules! register {
     // fields.
     (
         @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
-            => $base:ident + $alias:ident [ $idx:expr ] { $($fields:tt)* }
+            => $base:ident + $alias:path [ $idx:expr ] { $($fields:tt)* }
     ) => {
         $crate::build_assert::static_assert!(
             $idx < <$alias as $crate::io::register::RegisterArray>::SIZE

-- 
2.55.0

