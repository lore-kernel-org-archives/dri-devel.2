Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B571CD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50EBD10F5FD;
	Fri, 19 Jun 2026 13:42:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="axb7eyaY";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF09F10F5FB
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 13:42:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7MLWjelvRlQyq//bTOTlp8i4L9G+QbajGgW3XWB4Tgpu4m2f7Ggt6wi11pUg/WtBZziMDFonR3P3UFZLXwW707U+wT8RzwFOpAHw+9GYa0OA3cSDgWSPR/jZr3JEQ/gfHGfy444bQbwom3Kugv/TlnNvtaXPW3AuquPzTUUcdhaXWOiw19Ig48XX5J3J6S8S10MWfsrb0iZyb3nPhxhRKhHRl2B8rSI3b5fwaW5+FnAX3X6dlwxvyfw5dPPiKajU2haEivvxpUgFoakAerhYBixBNDezWG9HYvYcYyWTN5DLltP1Z5+4FUR3MkJn6WYYxEH6ow19a4H02LnTvZ6ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIjuxFn0upOk9CrgRzHFSxkHD8ZDGQU6GAYbteUxkEo=;
 b=mPwmF3CiJJg6EFaQIJZEuBc6nJanD8x4JcH2XoFdnoXwA4EWU8Ajkt/mpkEVjlNxMBokNURi3pw+aajmSGLnntQ7ocmFdPK/1yPdeQjS3nUfEtLL4N5T+8uR1auwbLgKtTtwJG2B95N/q122EqE5bsYk7NOwtsdK4UNKOWiokRmD6yTuEY30JJJUyVKMxSD6xcryN5nfC85EUH8brGchMRFXTH/uwc8JWuPXg8tihDc6EsUuuAaBYwuvqh21rruFspg0KQRavFUfiD2GO8J9YRA/csxy3eveYK2ugxIzqJdK0dvS/wME+OGfvzwlo9YQhBeI0/U0sLqDrW/RsT0u9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIjuxFn0upOk9CrgRzHFSxkHD8ZDGQU6GAYbteUxkEo=;
 b=axb7eyaYsx9Ryoch0jOnklV68hdEq1sPFhAP6nPc4eWTccaDooYh3INk6HBuzbo6p0W46zTp6zOPGdqVM3CplLiUhPe8e2G3IQjgUEwQ/CEeEHwdBPHvvrakCuh9cNJ6QlHPrJRXAbKeEcb5oNsbF36yvNDDLkMpJrxHrXf7GyV2B/qL1UgWpQFoKvF2dhXO1XUvx5PdDPKxr35u3EN/i2dmF8t1ZF/q1npsN2bTgVekm1PM9P5HdXgSZI8SI/7ocK6xxrsNNjKodTppvZV4VgJRF8ZYMhuNX3db6Ge/M9zDH6bXUO25+8aVp7lpsAHfSHzRAEwwGIn1LiGfDO5EbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Fri, 19 Jun
 2026 13:42:44 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 13:42:44 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 19 Jun 2026 22:42:19 +0900
Subject: [PATCH 4/6] gpu: nova-core: gsp: replace BootUnloadGuard with
 local handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-nova-bootcontext-v1-4-45193cd0a2e5@nvidia.com>
References: <20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com>
In-Reply-To: <20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0335.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c6bf11-463d-4b25-437f-08dece08a3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|23010399003|1800799024|376014|3023799007|22082099003|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: sanGDS5wMsX4VPITcCQkFaP8bogIh/jJCIwUrbAgvvXnQGqvCv9sAzUWy9300Oqqpd49bl8SMVHrrZPxXwhYdS2j+C/lAX4LgU4tm9U1TNPXxaMZYM7eRP3K2oMoKaCQgbOD2YWmeohZiWyHSe2/TL6d9sOJszcK0cdZwbHs2alnKanJjR/vojhZReS75BVksjcPiiaNJC7I0HkFNIbboanWh3XWtk51WVzG1qEFCRbmQh1NIZ0ArG+rX4vU9EIzarsA+KSdjsOTDXjgbhAo8SvawatEpLE4L6UD6MsjRU2HOnu4ljMTjtzyUv9xSqZy6Htq8dDHyY46SylE/2KwnvgGKqPS+E2XHIwB6xHXG+rawQyBpxL5A+7db+in5/toTA5I0vgbGgAKbHEBEiHvaJ8VNx5QvYmYR/WNmZLb4a00ThFmoqFoCwLtkQxnypAyoRppB8p7DtaRjpTqISBMLfIR4KBZIJ6RLFvVn0KbmdYGRFXBufKusrinGYLeGZnd5G2vBGYXS8+ddkKVqxrFVczbplN548ISONa0OG+xYMY52Iai5W8A5uz4F5De02/Qn48tVVKZ/xf/IX+BN06arNNF92/XXyJp+lWySIJ0gUTKt/4mScs5L1qst/QFB82+RXVYkPMlTjqLelx3URKNJtURXNH8ScmfeD0f0AEIQwM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(23010399003)(1800799024)(376014)(3023799007)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2ZlYmJwN2FlRnF3c3VKa2p5RlFJS1h2YWUxdXluQjcvVktURHhnOTVlYmND?=
 =?utf-8?B?L3RWNGM0b0pNYUJYZlpiTk5jdEQydDhoMHBVZ1JaQUYyMFJuVDFVTHNsZGpI?=
 =?utf-8?B?SHhOVXdTZTRvTUZOeDBDVmthV0RBd3ZGNDN5TFVTdGprSko2Zy82bTRpdmxa?=
 =?utf-8?B?QmdNei8yMGZPa0ZhYVpTd3ZDcFhYcjU3dm9PRVpNNFRXcytoQ3c0SlRySjJY?=
 =?utf-8?B?NGhUcmt3dTEyZWxhdG5xUTFUL0tRbm42dmJRRmw5ZjlicERIRmdCVHhWUE9i?=
 =?utf-8?B?Ky9aN3FhY29hbU5Ka01sSlBxWTd4R2FWVW96NDErWjlNN1pMUnljdncxck9m?=
 =?utf-8?B?aGVRYnNvSk5kcmptQkVZTzFxeE1wdUxhQ0thV3laRkZRK2FZVHdHTjhzeGh1?=
 =?utf-8?B?bGtEcVpxR1JtUnBCdDg0RmJjZUREWUhrdmU0VzQxOS9KTDdleDFnTXltYVhP?=
 =?utf-8?B?ejB6dE03UmlFSVVla1NhemhqVm0zZjgvU2lrR0tQeVBKbHZEWjliN21FTkM3?=
 =?utf-8?B?RjJ6eE0vblUyTUlkakNJOE92eXorUEtQdmRhVlNQRjErdktGc1ZiRFRWWDlv?=
 =?utf-8?B?VldRSXhRODJUcjNSR25SbmFuTnplQXJXWU8rMG9RSHkxbkpVQkNzRW1mdUsz?=
 =?utf-8?B?aFozOFBTTWRwdEtiREI0Z3gzLzdVYk94RW45YXRRSkVGV1pFZDZPSGtPaEs2?=
 =?utf-8?B?SU5KSnZJQkIvWHMrb3dDQy91ZXVDTFh6NjE5a1BGK1B4UVh2RWJKK2xMcEt6?=
 =?utf-8?B?VWlJYnZ5ZVV6Z1pZdi9BYnM2OEljZGVsREwyQUVZYU14UWlnR2cwM1BXV3dz?=
 =?utf-8?B?SWZhdlB3TStOeC9pQk5KaXp6cy9wMnVRa0ZaZHdPb1Z0c2RZSERJdmxzbERn?=
 =?utf-8?B?WTlaTXFqOVlGa3R0V1B5cTFLR2VzclRwZFBNOXVUSncxenh6dlpoaEFsQ2px?=
 =?utf-8?B?Ty9LQzJCOVNjV2tKT3VzaUQvVHYwQmx1OHJlMTZMckE0cW9tUXBLdUJaYjFh?=
 =?utf-8?B?UStzYlJVSVIyR1ZTcDduYTAwejFIWEh0eWpZaE91TTB0VDVKWWlPMkdzL1FN?=
 =?utf-8?B?WXplOG1Pd2xRMmcxeFdBdGdDbFE2RXQvYTJpa3phTlViSUw4N21jUmNKWVJK?=
 =?utf-8?B?dEFoZVdpUG43SWt4SHc4eDFGeUNHZFZiQmJ1aXJSWWhJc3piUHFkaVhkb0dU?=
 =?utf-8?B?Mmhwc0dBaXBtMUNrUkZiOW1ENUp3NGFlOXdZa2t1Nk9wNGdGZnFnWkI1ZmNu?=
 =?utf-8?B?d1pSczRnOE5DSWJqNnVhVHJJZUcwRTdiSmkvSlZjd1JPdGNidWhqOHR5TUhF?=
 =?utf-8?B?bjNTK1ptbkE1K0hjZHNRTTdMUXR6QW43QlRnYVlTcVl5MGJKTTMraERGWThG?=
 =?utf-8?B?U01ZSWlZUG1WY3k2SEk5bGJ2dVp4RUdxc21PekErak1MeGliZTVKeDlFYTZo?=
 =?utf-8?B?Q1dXUE1JdWVTN1R2dzhhN1luNmtNNm85bGNLWk5Qc0o1REdNam5ZajVxdFVV?=
 =?utf-8?B?N2pQcnBjVXQ2c29vamZ3M01NMVE1M2tkQ293d1NvZXVOOUFIUjN2S3lPdVJm?=
 =?utf-8?B?L1ZlRWcxUXFLaDBPNTM1M1l4WnZURmRTREFqR0NBU1NaVVZmSHkwTUR2QWZL?=
 =?utf-8?B?RVZMVHlBSDZ4ejJJamVIc3pKK2NxWGZpeFJzdHhTK0R6Z29wclFPamFMKzlM?=
 =?utf-8?B?aTNPbktkL2FKWDB3U1phVXRKY1JOT2QyM24xQkFCS2kzRzZqQ2k5U3IrRXls?=
 =?utf-8?B?N2RXbW53aUtHVlU2ei9TQmRTVTZaaUJ5Mm8vNmZsdnVWdmpkdUNYT2RhbkVt?=
 =?utf-8?B?MVkyRGtuTzE4OVhsVERkcnZQcmU1azBCMnFuYnBWaThhUER0VEFvSkRsWWsy?=
 =?utf-8?B?SWU0WDVBWFhJbVByeGZ2MWZoTTJHZGNPbWhURXlZWm1nRCtyVERxTGQ3dWN6?=
 =?utf-8?B?dmpkdEF2RDZCQktTNEJPWmRLL1lzL1BEcWJzUG92SHVrVEVmM0Joa3d2UDFP?=
 =?utf-8?B?VW9sRldHYk5XRWxGa3RhTmVEV2lsNTdqRmVnRlRFbkVYVHhGUnRiamJSUU1i?=
 =?utf-8?B?Q0kraWcvLy9obHZHejMrUThZeTVhcDVzV1E1ZmltdDZJMHUzN0xONDQ1dnhH?=
 =?utf-8?B?V2I0OW9RSDNKNHJlaS9CbUdPOWNtdW91ZHJFcVNSeTg5bzYrNndZQ1Vlby9D?=
 =?utf-8?B?VnhvYU1ZOHFZajBhVk5KTWxkbUQ5WnM2elNQNnBjeitkemFiYTRmY1IwT2w3?=
 =?utf-8?B?Y0ZqUTgyVlJMbjJBS0FNcHkrQ09TYzZ4VndpZXlZeEw1ajF3V25rSFhKQUZi?=
 =?utf-8?B?b3pKL3VvMUpBaXRmdHhFMGZuRGE3d3cyTXpWNHJXVkY4dDV6bk81ekNqbFJr?=
 =?utf-8?Q?g4mPR3U0JbVVmb5rmpOS32xbMZZwVUQZ6R4qzcrilDXxK?=
X-MS-Exchange-AntiSpam-MessageData-1: QxeAo6ee09o95A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c6bf11-463d-4b25-437f-08dece08a3f3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:42:44.1659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XYeCUnZo0lOxEGSgdKfI0tJxXZhhzred/i7RcKCoNdgZRtwXHAdxlNg3xO2eMw4hqXzKvI4gWuvP+AWPFndUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367
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

When adding the GSP unload capability, we introduced new types to
support what is effectively an ad-hoc behavior: that `Gsp::unload` must
be run if any error occurs during the boot sequence.

Furthermore, `BootUnloadGuard` is problematic because it holds
additional references to the boot context, notably the `Falcon`s. These
extra references stand in the way of making some of the `Falcon`'s
methods mutable, since those methods would require exclusive access. As
this behavior is only needed in one place, introducing dedicated types
for it is distracting and unnecessary.

Thus, take advantage of the local closures introduced in the preceding
patch to run the unload sequence in `Gsp::boot` if an error occurred at
any step of the boot process.

This slightly broadens the failure cleanup path, as `Gsp::boot` now
attempts a best-effort `Gsp::unload` even when the failure happened
before the unload bundle was prepared.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs      | 81 ++++++----------------------------
 drivers/gpu/nova-core/gsp/hal.rs       | 20 ++++++---
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 28 +++++-------
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 23 ++++------
 4 files changed, 47 insertions(+), 105 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 9eccfd634b61..3574f1a87344 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -7,8 +7,7 @@
     dma::Coherent,
     io::poll::read_poll_timeout,
     prelude::*,
-    time::Delta,
-    types::ScopeGuard, //
+    time::Delta, //
 };
 
 use crate::{
@@ -30,66 +29,6 @@
     },
 };
 
-/// Arguments required to call [`Gsp::unload`](super::Gsp::unload).
-///
-/// Stored as their own type to avoid repeating a long and tedious list in [`BootUnloadGuard`].
-pub(super) struct BootUnloadArgs<'a> {
-    gsp: &'a super::Gsp,
-    dev: &'a device::Device<device::Bound>,
-    bar: Bar0<'a>,
-    gsp_falcon: &'a Falcon<Gsp>,
-    sec2_falcon: &'a Falcon<Sec2>,
-    unload_bundle: Option<super::UnloadBundle>,
-}
-
-/// Guard that calls [`Gsp::unload`](super::Gsp::unload) with a
-/// [`UnloadBundle`](super::UnloadBundle) when dropped.
-///
-/// Used to ensure the `UnloadBundle` is run during failure paths.
-pub(super) struct BootUnloadGuard<'a> {
-    guard: ScopeGuard<BootUnloadArgs<'a>, fn(BootUnloadArgs<'a>)>,
-}
-
-impl<'a> BootUnloadGuard<'a> {
-    /// Wraps `unload_bundle` into a guard that executes it when dropped.
-    pub(super) fn new(
-        gsp: &'a super::Gsp,
-        dev: &'a device::Device<device::Bound>,
-        bar: Bar0<'a>,
-        gsp_falcon: &'a Falcon<Gsp>,
-        sec2_falcon: &'a Falcon<Sec2>,
-        unload_bundle: Option<super::UnloadBundle>,
-    ) -> Self {
-        Self {
-            guard: ScopeGuard::new_with_data(
-                BootUnloadArgs {
-                    gsp,
-                    dev,
-                    bar,
-                    gsp_falcon,
-                    sec2_falcon,
-                    unload_bundle,
-                },
-                |args| {
-                    let _ = super::Gsp::unload(
-                        args.gsp,
-                        args.dev,
-                        args.bar,
-                        args.gsp_falcon,
-                        args.sec2_falcon,
-                        args.unload_bundle,
-                    );
-                },
-            ),
-        }
-    }
-
-    /// Disarms the guard and returns the [`UnloadBundle`](super::UnloadBundle) it contains.
-    pub(super) fn dismiss(self) -> Option<super::UnloadBundle> {
-        self.guard.dismiss().unload_bundle
-    }
-}
-
 impl super::Gsp {
     /// Attempt to boot the GSP.
     ///
@@ -118,10 +57,11 @@ pub(crate) fn boot(
         let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
-        let unload_guard = hal.boot(&self, &ctx, &fb_layout, &wpr_meta)?;
+        let (res, unload_bundle) = hal.boot(&self, &ctx, &fb_layout, &wpr_meta);
+
         // Run from a closure so we can retrieve the result, and run the unload sequence of the GSP
         // in case of error.
-        let res = (|| {
+        let res = res.and_then(|()| {
             gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
 
             // Poll for RISC-V to become active before continuing.
@@ -143,11 +83,18 @@ pub(crate) fn boot(
 
             // Wait until GSP is fully initialized.
             commands::wait_gsp_init_done(&self.cmdq)
-        })();
+        });
 
         match res {
-            Err(e) => Err(e),
-            Ok(()) => Ok(unload_guard.dismiss()),
+            Err(e) => {
+                dev_err!(dev, "GSP boot failed with error {:?}\n", e);
+
+                // Ignore errors during unload; we will return the error that happened during boot.
+                let _ = self.unload(dev, bar, gsp_falcon, ctx.sec2_falcon, unload_bundle);
+
+                Err(e)
+            }
+            Ok(()) => Ok(unload_bundle),
         }
     }
 
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 51a277fe97bb..a76be4e43272 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -24,7 +24,6 @@
         Chipset, //
     },
     gsp::{
-        boot::BootUnloadGuard,
         Gsp,
         GspBootContext,
         GspFwWprMeta, //
@@ -51,15 +50,22 @@ fn run(
 pub(super) trait GspHal: Send {
     /// Performs the GSP boot process, loading and running the required firmwares as needed.
     ///
-    /// Upon success, returns a guard that runs the GSP unload sequence if GSP boot does not
-    /// complete.
-    fn boot<'a>(
+    /// Returns two things:
+    ///
+    /// - The `Result` of the boot process itself,
+    /// - The `UnloadBundle` to use with [`Gsp::unload`], or `None` if the bundle could not be
+    ///   created.
+    ///
+    /// Note that the two returned values are independent: it is possible for the boot process to
+    /// succeed while the unload bundle couldn't be created. In this case, the GSP won't be able to
+    /// unload properly and a full GPU reset is required before the GSP can be booted again.
+    fn boot(
         &self,
-        gsp: &'a Gsp,
-        ctx: &GspBootContext<'a>,
+        gsp: &Gsp,
+        ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> Result<BootUnloadGuard<'a>>;
+    ) -> (Result, Option<crate::gsp::UnloadBundle>);
 
     /// Performs HAL-specific post-GSP boot tasks.
     ///
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 46e03f34bc74..3ed2433feabd 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -27,7 +27,6 @@
         Fsp, //
     },
     gsp::{
-        boot::BootUnloadGuard,
         hal::{
             GspHal,
             UnloadBundle, //
@@ -149,29 +148,26 @@ impl GspHal for Gh100 {
     ///
     /// This path uses FSP to establish a chain of trust and boot GSP-FMC. FSP handles
     /// the GSP boot internally - no manual GSP reset/boot is needed.
-    fn boot<'a>(
+    fn boot(
         &self,
-        gsp: &'a Gsp,
-        ctx: &GspBootContext<'a>,
+        gsp: &Gsp,
+        ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> Result<BootUnloadGuard<'a>> {
+    ) -> (Result, Option<crate::gsp::UnloadBundle>) {
         let dev = ctx.dev();
         let bar = ctx.bar;
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
-        let sec2_falcon = ctx.sec2_falcon;
+
+        let mut unload_bundle = None;
 
         let res = (|| {
             let fsp_fw = FspFirmware::new(dev, chipset, FIRMWARE_VERSION)?;
 
-            let unload_bundle = crate::gsp::UnloadBundle(
-                KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
-            );
-
-            // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
-            let unload_guard =
-                BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, Some(unload_bundle));
+            unload_bundle = Some(crate::gsp::UnloadBundle(
+                KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>,
+            ));
 
             let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset, fsp_fw)?;
 
@@ -185,12 +181,10 @@ fn boot<'a>(
 
             fsp.boot_fmc(dev, bar, fb_layout, &args)?;
 
-            wait_for_gsp_lockdown_release(dev, bar, gsp_falcon, args.boot_params_dma_handle())?;
-
-            Ok(unload_guard)
+            wait_for_gsp_lockdown_release(dev, bar, gsp_falcon, args.boot_params_dma_handle())
         })();
 
-        res
+        (res, unload_bundle)
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 9b24361f924b..fca8da281e16 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -32,7 +32,6 @@
     },
     gpu::Chipset,
     gsp::{
-        boot::BootUnloadGuard,
         hal::{
             GspHal,
             UnloadBundle, //
@@ -264,19 +263,21 @@ fn run_fwsec_frts(
 struct Tu102;
 
 impl GspHal for Tu102 {
-    fn boot<'a>(
+    fn boot(
         &self,
-        gsp: &'a Gsp,
-        ctx: &GspBootContext<'a>,
+        gsp: &Gsp,
+        ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> Result<BootUnloadGuard<'a>> {
+    ) -> (Result, Option<crate::gsp::UnloadBundle>) {
         let dev = ctx.dev();
         let bar = ctx.bar;
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
         let sec2_falcon = ctx.sec2_falcon;
 
+        let mut unload_bundle = None;
+
         let res = (|| {
             let bios = Vbios::new(dev, bar)?;
 
@@ -284,7 +285,7 @@ fn boot<'a>(
             //
             // If the unload bundle creation fails, the GPU will need to be reset before the driver
             // can be probed again.
-            let unload_bundle =
+            unload_bundle =
                 Sec2UnloadBundle::build(dev, bar, chipset, &bios, gsp_falcon, sec2_falcon)
                     .inspect_err(|e| {
                         dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e);
@@ -297,10 +298,6 @@ fn boot<'a>(
                     .ok()
                     .map(crate::gsp::UnloadBundle);
 
-            // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
-            let unload_guard =
-                BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, unload_bundle);
-
             // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
             if !fb_layout.frts.is_empty() {
                 run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
@@ -328,12 +325,10 @@ fn boot<'a>(
                 sec2_falcon,
                 bar,
             )?
-            .run(dev, bar, sec2_falcon, wpr_meta)?;
-
-            Ok(unload_guard)
+            .run(dev, bar, sec2_falcon, wpr_meta)
         })();
 
-        res
+        (res, unload_bundle)
     }
 
     fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {

-- 
2.54.0

