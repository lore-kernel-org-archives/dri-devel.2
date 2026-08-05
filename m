Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB03C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB99B10ECAD;
	Wed,  5 Aug 2026 05:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fkDN4DAq";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD7810ECBD
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7Tovocey6dHPXSXLXLXA0bH2ZyrHsMgDEnAJscDXc1Nq0Fu30WG+HcNDqhYw6fFa2IAbNrqFXfJy92K5LKBDQM8PN7a2d5e7JBBcJb+fTu8U6vKpfS8CnIvTIuuJe8/NbyMecr4TtcDmbVd8d4jCy7wYWwuVQh7RJ5J4Oe/Mv7WOvk0OOs54y8D2wVd/PCRshK5ooXlxc6AdO7vpPLCTcZtHumjv/eAyXbw5YQfuE+rXZjRncEqqKMH338X8yk/MpU7ATwSiZxdm6kpk9uKNHgbmHVfvLigrZABQIiurgrE/JTB/NjbeaettADls6G8arpq999lxNUMmT3UZ2e7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fICGqll4hY+tn62o94uWyukNEn/vaxq9yVa0pu7K4xk=;
 b=I0KgMuoVNKysnOxFb9nSBcjylmM3tfFCeW0uYu3AMrxZCn7BgOQeocvWtf3rWJucVQ0hoNSWraG8IVe2Gu3tHUaMZ0Gu74olIsOGHOmP9qkV7x+aP2PO4UJjwF5UZXYzjILNzeDPg2XTe3rli6yfcdQ9dmzjT8t+LJ1hOqWJle+6yPjQbc+xvr7trt8Awylb+aREa5WP0/YCNzh0LoI7kqxd+qB7/G8kcjGyLC/Iyijm07cEfe3afVCNbJrFgZcFX8NrcgfAGzi4J3mOflqRiKDeQpGt6FbstUnWoejStL0JAZzJZDbCZ8Iz9kmpHaduPl+H5RYjbvlG1o+BH4ZS1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fICGqll4hY+tn62o94uWyukNEn/vaxq9yVa0pu7K4xk=;
 b=fkDN4DAqIcrBFMc2Uo1Sze5McnPVzSQ1LATZr+3skEcn9GAhFhw4zEmzFDJ0qHy4qc51fopp6K3n1XELm5I++QBnq+CRLsMoL+RLkhFAVL6WWWHGXqAho63p9ayivUtzug6Uumh7YkD5OY36DStzZkzphCfZY1D8lTRoq/82kaz2gBcVGfotCEPBuprFa70iiNS1x/dZI2K3qGDE+C03dvaum5p4vTNKQYWHAvKshMILQD0eobjPZm3rqbMJQ4qt9Tde0j7igUd7OCJbsYF21bNRFejADoDZ7bEraPp64NaffXka7wbObbr2TD0hfTryL5bpzrwxNiYRhZfvTMs01Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 05:45:12 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 05:45:12 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 05 Aug 2026 14:44:48 +0900
Subject: [PATCH 01/12] rust: io: add Region::try_subregion
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pramin-split-v1-1-ff3e84a75dac@nvidia.com>
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
X-ClientProxiedBy: DU2PR04CA0249.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d618b6-ef14-4c88-139f-08def2b4b7cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|10070799003|6133799003|10067099003|11063799006|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lq3nJ1Zl7NSn9LkxdgwI3Bt/UoUSCE+YwwkGxQMIx2mp1GC1gmhKP0joaN2+SEZY/++Hd10i3uGR6trf+fqLQ5djsKIGVrtHgJMyHKpaQsUhbQi5fNTyfOYxx4VeN8fjE2Tdj3wgbzCbiFethHSn8NqMUFxd7lmhj6t2q4BwcCBDZ65wHfwAvxozRNtCj6qplBuMtoCIf6kLTPoTOapGUZ5KARdtasuoC6D4aunvm38Hd/rsyt22rYuk2lBvuYvbDS8TR1vvdJWWaRwCgjHeZ+aKQb+BJMlGAYK+VJA+a29fCKh5PbYxG/deGhZSm/Nz93ksdnl6qzuMuqWE6Lg/jcrwVtkdbgCMqdGWAW7s7Jsj3yUfVQOAMvRwLpgiOvTx8YVto9WoREn5FCddqx5u+uNWPSjzZaO2GazFYs8k5QNZSahHZxSt62y0JwMaIGLIL9TU0vsjMpSnUdWK9+Fz03sdtFVb4hgaZRmj0Ytf34BPoxKCAJuHjz918KmvBavT6x2sxW0zJ9rlDtg1Qf3UnsXIxZpljfMuPdwIqMsYZAmhzikVTAyPYEP/L737RKJOE2I6TWgMjSZlvNgtyWeY6Pgz3jlVxierSX+1ExCaZgiQqDCW7GBU4KQXvckHxdDp6hi+nUbUAFglrJ+gBo7GPX8Ap1PYpiGaqMtIw9pq7qge3Q3xbSMvN97a16idu9sKrho9hROL1LR14MOlNJdgOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10070799003)(6133799003)(10067099003)(11063799006)(56012099006)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2FNS1pIL2Q5U3ZOdS9mTTBSMkFYTEZYQWhNZDFpemlacUlMRmY4ZFBiNUs0?=
 =?utf-8?B?Y2QxcS9ZeXh1VjF3MGRVY2cvSkEyaE03RXV1OWpOemVERzB5UmFUU1ppdjRX?=
 =?utf-8?B?OG02c1ZnZm5ZMm5oemJoUldoc0JTbFZmcGdUMzdFY291NlNNNXhkOEJyRTFv?=
 =?utf-8?B?cHF1T2J0RTdwVVhkM05rVE9hRXRRam1rVTExWElURWI0b1UwTG56SnhBL0xX?=
 =?utf-8?B?YmtUaUdUczRCb0tNek9UdUNQdG4vVnhVWjljMlNHOHlmRWJ2TUljUThIR2p4?=
 =?utf-8?B?am5uVnFmaFQ5RTZiOEp4ejB6QjJjL0hFTitlRlgzQ0tQVCtZS3hUNEZtZWhm?=
 =?utf-8?B?VDZUOUhzeFhXOVpBTWU3MUZOYjZUTjJNS1didmxNRkhDTTlMYmttNUk3QkZL?=
 =?utf-8?B?d1B5aVllT0JCNm16aVVZNjN1K0dURVNUR25BWWx3TEV1cy9iNDNTVFpqU2sr?=
 =?utf-8?B?WGI0d1lMQ2lpcHNVN0M2bUYxZk9lTExGVVBtOUlPZVkvYVNWa2dFUlU1SFh1?=
 =?utf-8?B?TUYva1NKVm1VdTd1aE1IWU9STjNsK0NYVlNCaFB1U1RZY2ZIcXBZbG5BQWxz?=
 =?utf-8?B?MS9MMFdzYkNZaTUvamtsdWtDejAzQUpBQStuc0dkUWRYQ3ZFOVYzYjU1d2FO?=
 =?utf-8?B?dlliMmRrQ2orUFNIZ3dXbnFaVm5oMTE3ZUtUM3ZxZjJxeFYzT2E0bEpJaDIr?=
 =?utf-8?B?clVaRlU4a2NtTnRNWUR5QXUvWUwrbkNKUlBhZVFYbXVuMGgyZHdpbmxlcjJ0?=
 =?utf-8?B?WENHS09HbHJFSXBMNVhGU1F6QzlmWldVVTZwajBYdFNFaGJ1dTZ4REo4b2ph?=
 =?utf-8?B?aUFDRUJRMHVzeXhhbjhwYXNrNnBKMWNldzNBS1R1Y05nY09STzNsVm41ZHJv?=
 =?utf-8?B?YkFXRTRVR2d1WUR6ZVZKVVpmcWl1VHZCMEp2R2djMllxN2RWcmJocWNFNG9y?=
 =?utf-8?B?eXBJMFpVdStFR2hQU2FSTjNoamtIVWErdmJ3cmk2VXFXQW1qU1dESGsyWUhL?=
 =?utf-8?B?SEJERTZrTDVWVnZDZXZ6b2dxZnIydEhRL1hHRVNTMjRtUjEvSnZQNmdJVi9l?=
 =?utf-8?B?L1ArbHlERlZ4RGtqOUVjenFhMFpvQVhsWEpUUnVSVVhCUDFWdWhsaW1RY3J1?=
 =?utf-8?B?c1lKS1RYdSs2K29PVTJwOHhEY09hWm9ZMGhKVEhERHJPM2JpK0hXYzh1eTBw?=
 =?utf-8?B?QzhkOU12OVdScEoyckZSTzF3c2VXTHM2RHFnc05vN1E1RTdTWkdLSTVUVnVq?=
 =?utf-8?B?MmNibDJXYWh6d2dhL3crR0g4a0hkcUtLWVNLNVJMUzVkR09sT1RvRm41a1Q3?=
 =?utf-8?B?bHd2WkcwU3ZWMGZGSlBlSTFSalE0NGF1MkFTRmladm1Jc3pqZEdMQ0djdzZy?=
 =?utf-8?B?SmtZOTdhRzUwRHhFQzBvTHlxUXZuOWs2alBmSmgybWpVSGRLVVBDeWdsbXhh?=
 =?utf-8?B?cElqZlZ1Yk9LTVJEUkVZZ21VUkU1a3MwYTNSVDNHUEZvMHgvN0tyWVdOTUtx?=
 =?utf-8?B?TnZoakJqNk1JSzVsWFdhVzVEaEFlUmRPMjZPTENkeEt3VUMyT1d1d2oxMFRM?=
 =?utf-8?B?Qk1vSzhPbzBoUURJa2doRUw1U3ZYQWpoTjQ4Y0J1MTNibzZlRXc1clJ3TGY0?=
 =?utf-8?B?SEw4aU1hbEs1SjN5cjZEaGhvVHdJaDJYemU5NVRvTjJnSmlIVCtoTnRIOVZM?=
 =?utf-8?B?UkErRFpIZko5ZStvNnFWL3lQWnBHM1VkQTFhZUlkbW1QMFo1ZHZLK01BN2xn?=
 =?utf-8?B?RmpjVzhIZ2FhOTFhL09iNm94QWhFWVJaaVBQeXArK1J0NVNQNVFIZVJhYzlD?=
 =?utf-8?B?bUVQZHNucWtXVzNNUm9yUzE2bitoT3JlOW5EQkFDcXBnQVkxVGRhazBKNzZq?=
 =?utf-8?B?RlhkTVVYS2xQL2NNN2RMekJuN2Y1azhUL0x5RXNscjNMTzdDc0JnMUlvQjB5?=
 =?utf-8?B?WTBFc0RKUGt3ckRjYzB3YnhNbUFYVWVxY0l5RDVQUm50US9MM3BROUxiS3dn?=
 =?utf-8?B?OEZPelE0cnlPNURqZjZEQzliZTlzQjZNa1V0YXZORFJFVkZ1cHlZQTFIaXF1?=
 =?utf-8?B?ZFVwaEEza0FHaE5zdWZCRllXSzZMU0pzZkNISGNDU3VKcE5LUjg2QlljTEFN?=
 =?utf-8?B?UHFZbUQ0bmhTczhPNUsyMjJpc1g0Z3FhUDZwTVdUd2cvSk9UTzhjc1BocHNE?=
 =?utf-8?B?c2dQb1NIb200bDR1RTd4VnNiRnAvcWpFUWxOSFNMREhnWXkzK3hGOWdYOWcy?=
 =?utf-8?B?VnpFZzU2eVEzZmttdzNJc0JMOW5KYlliS1hjVzBMQXNhdWhDanlsd0dlVzZ5?=
 =?utf-8?B?QVh3VmN3UDJXd2N5c0I0eEVmaWcrd1lsMGxZejFodWZkZERsVXNPaHdLbUx2?=
 =?utf-8?Q?xIABT4EhCE0OQpsTf4vzslnFy9fYP7g9KnTvs3rPLrfMp?=
X-MS-Exchange-AntiSpam-MessageData-1: DR/sahGu5yt8JA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d618b6-ef14-4c88-139f-08def2b4b7cb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:45:12.5788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTTd5kWwuws+qCvyk55Rzn6p4506CIR1IbnyLhas5tYqSlNIjgO3wIQgZTBGmlmMYimXRlful95EB26s83yVhw==
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

Add a helper to get a subregion of an IO view fallibly.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/io.rs | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 95f46bb75f9e..85fbdcc50c8f 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -6,7 +6,8 @@
 
 use core::{
     marker::PhantomData,
-    mem::MaybeUninit, //
+    mem::MaybeUninit,
+    ops::Range, //
 };
 
 use crate::{
@@ -80,6 +81,34 @@ pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size: usize) -> Result<*mut Sel
 
         Ok(Self::ptr_from_raw_parts_mut(base, size))
     }
+
+    /// Try to create a subregion of `io` at the given range.
+    ///
+    /// Runtime checks that `range` is within this region, is at least as large as the given new
+    /// minimum size `NEW_SIZE`, and that [`Region`]'s alignment requirements are satisfied.
+    #[inline]
+    pub fn try_subregion<'a, const NEW_SIZE: usize, IO>(
+        io: IO,
+        range: Range<usize>,
+    ) -> Result<<IO::Backend as IoBackend>::View<'a, Region<NEW_SIZE>>>
+    where
+        IO: IoBase<'a, Target = Self>,
+    {
+        let view = io.as_view();
+        let ptr = IO::Backend::as_ptr(view);
+
+        let size = KnownSize::size(ptr);
+        if range.start > size || range.end > size {
+            return Err(EINVAL);
+        }
+        let region = Region::ptr_try_from_raw_parts_mut(
+            ptr.cast::<u8>().wrapping_add(range.start),
+            range.len(),
+        )?;
+
+        // SAFETY: We have checked bounds and alignment, so this is a valid projection.
+        Ok(unsafe { IO::Backend::project_view(view, region) })
+    }
 }
 
 impl<const SIZE: usize> KnownSize for Region<SIZE> {

-- 
2.55.0

