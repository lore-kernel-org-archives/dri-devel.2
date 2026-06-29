Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64C2C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B20EB10E895;
	Mon, 29 Jun 2026 12:32:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bs1U2+Nr";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D198710E894
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtQMncDOaNv+MecQE1GKsbSfF6XJrSL9TtF9ewL0EV/UaRnF2MOow/QmjpZVbUvOjFksfWeOS4mCpYVLMEM8L1+cqoMDY/zEBIVC0bQM2xoarUOabZzhdHze9XjXqbys0kaCt19ldXPmAwKRqOmhQZwD8V12deIFGnaofEuMbylNFiYhNJjolx6f6jC/ncJojZXPwp7MRPvh0/cSEnV+iyD42GwlhWFst2ooSVguBAnYJgneds0uyTmDHyjh5CD3kocG7Wr3zuw34N7l2HRHG1RIM8Jxbe+Y6mhClLWYjvijFEzL5eCVRuM3lwcu5ttANlauANsDPk8C8ufkxsWdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeL4SFqkrn9BaIfuGJL6CfLI0uWCEU9FNBdky8KrsPY=;
 b=YVimFqUmfbkN0b7TkakiBLcLewKRBcfykuikhdNJu0hOdlFB+l/mIBwfLsJiE+dUxdZ4Loa/2LKezqA8c5cjTiFDyub4QSYcFDQ73ouBlclLEjT6zZ5lbEGyHEtZVCvnLEX4tngZKTws3rnrV2bUQqSnmlRVREMdOjDKlL2kopMFFM0sd/uj+ZlZ1jA18Qc1P+cdLaLJNIPnZ1WdWFYrJYqSgRwrdVd+Y8fbCB/tmt4q4sxTX3Jl695r4b/Iwwxy1gnAin+ib+uvGVGwxZqPZkpFMfbq9BTa1Pcr9KfOWELLTyKHQGFFCKeSEjGGpNJ9MpVMQOpZTcKrONrOOvbdCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeL4SFqkrn9BaIfuGJL6CfLI0uWCEU9FNBdky8KrsPY=;
 b=Bs1U2+Nr/e36x7myxCKFQlVMZdgM8HIIjWcOpHmVPLN0JZ4/zSvs32b7A7+wAkx4YakGE/DZ740jqEt4ho3kiZxoP3CNg+RK2Wi/E0h1xAmLW/JRy6LEv0q48b8Um0iGNCJzC6LIZaafJrT9gNH6z/U3rralFf9gJu4gDAsW9OKvA5/4AYP2vTiqjXDOUiF7sT4y/Xwk6q/D5DxU9Rhz54TF6qULiCpteSfglKPuahbpgw6hYKivHIFJMKQ5WQCR9C4rCtVr+cq/tArP7jFJKML8oHXQfH9cPKfDD14QyEJQVoyvrTfI/fcICy4w/yCidq5Vj58SRcL0kkZsM++HxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:32:06 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:32:06 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 21:31:46 +0900
Subject: [PATCH v3 03/12] gpu: nova-core: gsp: replace BootUnloadGuard with
 local handlers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v3-3-26cb29ee8dee@nvidia.com>
References: <20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0364.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c155ce6-91f1-4d23-24f5-08ded5da6e54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10070799003|921020|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: tbkultZK3pk2D5Jj1Tyn5ykjo2MiZuqYETZw3GYpl3d5flWL2f+84zB7jacePkcFInGlh+tZ/8Q0URNUA/FtpBStQuJQe4JQWGIW8vyc1Wm505ovBRo7lekOXdedhR0t134DBVDH97G+t85U9/zf4RxtHgSp1GM7+4bik3og+IE+MOEv9QFfCEOGwa9jWwxCbluM4H57W5o4yIYKyTcHtei2jY4g7jyUPF+yzDDfVdNPIRXFvxvlrxsxVQYgVdjTArP3DTnyLTafOkLkWV4RpP2jxYhYmEIOmYJQMbuvcuRLKuKtJRPRGtra/0bd8q8IbbSgK4XQbObaofUfGdVW1BW3LkQpClpRkK5lROb7zv9TR3ANCrao0IZ13NEi8bx6CaURDtCgeSBAx+t1BVhh2txfascRgdyiG+paoiLgnupwj8SljNn0OJ4/hoSblqEMWsB8Zk/dnSSB0Rtki3Gr84MjLSVp+8shgnR3t3KkJn/uu1H5MH82ZMaNT1FXL64HhHb0BI+ktkZHgH7BkLkJhXNh5HwvKkfwrBPkFNIjtmOdvq+dpEqBYuWQPP0aS0mPpsHBhCFzyg2BaSuj8uisYH5szMnSs9jcRnRmsnGCWNIvR1f1rSr2P2VUhpZu3jqS8qaxFcqBuWrjo2mDMxQ8/RHqj2TmyLNxSsNBxQnMcBHruXxLg+nv1C0pqkuviwK0IeduaCckJDTr70xe9Uoeyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10070799003)(921020)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDQ1V1NoRWZPdUp2RHFJcTM1Y00zRVFnUXJSLzVJQXpPWDlTcU5nWEFCM3Nn?=
 =?utf-8?B?RkVYdXZlRVZvVk83UW4yaWJjSmdsVTBINEtpSVBaNTE1UGo1ZktUUUoyL0pZ?=
 =?utf-8?B?WERGTkwwZFYzNE50bmNvWStZSFFkQzEyN3J4MXVtK3B3ajFETmpOZzFVNmwr?=
 =?utf-8?B?aEptWWRrV25BMHlNYnBqVmk2YUxZZmcycXBzdUcwUzI1c0U4cXBtZXBEUzhW?=
 =?utf-8?B?WnNzTXladUtSckN5aGpGb3pKeVlmNG1CczljZ094cStURzRMQVdhdlhiTVZw?=
 =?utf-8?B?WjZkbW9BaGNHdFJvbDhJVmg0d29DREpVMU5vN0FQZHFqWXNLcmZYamRpekZM?=
 =?utf-8?B?NVNtZkNVMkt1MUN4eXdVcnJ4N2orQUNWSTJvSXpoSU1iT3QxK1pGOU9OeEtj?=
 =?utf-8?B?dVFXTFNYbmc1U3FaOEpzU1p5RFJ0UTd0R3RJdzdKb0ExR1RGdy9tY2UzQTd1?=
 =?utf-8?B?MFhXS2wrMzBoUWY1VXlBUkp3dm9LUmt1SUZuQmNTVnV4Y3dVbm84bTY4SWZS?=
 =?utf-8?B?bVdlS0t4SWt5M0JXN1JweVovOWIvVHUzYkFBcFRVNUlnNmtDLy9PenlRYWVl?=
 =?utf-8?B?TU1sVEN1SlJRanZ6bjNvd3NsS0NvQUpiRTFINkdIeHZhQnpXTFBSOVVOWmhL?=
 =?utf-8?B?bmg1UE4xRWpiaEJvNk4xWmNKeU9EelA3eUl6YWRTZVQxNVhvbmpCbWZKbzcv?=
 =?utf-8?B?Zm91ZHhzTi94Rk9WQWZKR3RXWWp1eEFzZkFLVVphMlFCSTd5bzNoZnBDMSt5?=
 =?utf-8?B?c0hSV3hNN3JmQW9KVGdJQU1keUQ2Zk1aL3lZdVBWK09hU28valVXTDRQelRB?=
 =?utf-8?B?bzNtVnJ0S2RSRXdHbzR5VWFPMWtWMXNkUEpmWjVXUG93SzIzbFdmaHNFaE0r?=
 =?utf-8?B?b1U4eFVPR1FKMnpSZ0JyRUxuQS9jWENUdDhoY2NOQW13anRkdXA2NXQrUERr?=
 =?utf-8?B?ZmgydnoySjVQK3k1VEF2c2xEeXVaRzQ4QVZGdzNzdFN4Rk91RDFJMytlTjJV?=
 =?utf-8?B?ZVY4OEhxWHBUcFRlYlZPcFo3UUtKc1VvUkdCek5BMGJtMTE3Q1UvYjVReHZF?=
 =?utf-8?B?QlYvUFh2Zm41a2hITkhub3hUZUZhVldXdlB0K3NkMkdRWjl1RFMxK1EyNG4y?=
 =?utf-8?B?dG5hQk10ZzNtdDZWL2NDQ1p4dXp5TkgzSlRwR25RK2xseHdHMFJRTXZFQVd5?=
 =?utf-8?B?Y1lMNHdUdXcrRmdZalkzTkM5Z2NOZmJMVzlLU3k5S055UEtOUGM4c29JcStQ?=
 =?utf-8?B?S1hkVHhQNlJhajI2Yy81ZVVBM3pHNWJhNmlLT2Z0MktXUG5rWHFILzh1akxJ?=
 =?utf-8?B?TjFBUVBaY01JZDVOVURDYmc0YjNFTHhnZGtRaFVwK3BrUUV3Q1ZoV0VDdExP?=
 =?utf-8?B?MWtSTUdnc0dYRWhiNm5jN2RVNTI5UEZrOVFTRThIWjR5amhLUnZMU1VZM2Rp?=
 =?utf-8?B?WXpuYldaeit0ajFZMXlNeFY3ZXpMOEVvSDRIV0FWdmpJT3FCckNXOXpLTVpJ?=
 =?utf-8?B?OTFhNHg2eXI0ZjlmNHZPRHhlTjlVcGpIckhYT21NZnRXT2FlRXh3NWxYVFFp?=
 =?utf-8?B?R0pwQ0tjVDFxQ1VlMXNoS3lTS3NLRkJ3SDM2V0Z2eVV2OUtZMUdOWUVNT3RN?=
 =?utf-8?B?eWhIeENzUlFzbWMxdWJ1cGJXVGxNZjRFdDZRY25lclhDREs1RHNVSkxiMWJ0?=
 =?utf-8?B?cFhFb3R0VzMyVkdxUkphY1JRc3VNWmwrWVJwM1FIOXJOdTB3djZoQ2V1dE83?=
 =?utf-8?B?dUhTU0VUbWFMQlFKdmdTL2QraHJEQkI3UTBTcWptMDhkSVBoaVZQSFZreGN2?=
 =?utf-8?B?bDdUTXdvMDl3OEZTditOYkpDSjd3LzQ4ZzlSUkFQbFI3ZUJuY1k3R1hkcnhk?=
 =?utf-8?B?SWJZOXRNeUpNZjJSbDcvcDFuOHRzL0hvU2pheHZxV3Rzai9va0dvYzVmazIz?=
 =?utf-8?B?dFhCdGVqaFVKdy9QNFYvVzNBSmJqNitxekZKT2c2dWpaaEEwbmNJMVM3R1JX?=
 =?utf-8?B?bkZ6VXhOTytpeDNaWmNocU9Ubll6OVI3Znh6ZHUzekcvc2ZhenlhaW1IbENG?=
 =?utf-8?B?UzcrNjRPKytsa09YOGNlcU0xM3UvS2xVcE5FNDNEQWlIa056aERKTldGTXFE?=
 =?utf-8?B?b3hRczdEVWxYSUlLUzFBQmpuZTZzNm9tdXM0RDdONEgvWUJTRlRMdldjcWVK?=
 =?utf-8?B?b0Erak1iWUlucUNGTE0vN2tyMkwyQ2d1Uzc2RXpKNi92Q0krSC93ditnT2lq?=
 =?utf-8?B?TmNyMEp2L0pLSGhiUEg4QVMrRXVnWDl4SHZnS3FoUmZTVUlneTlBcVF0Vm82?=
 =?utf-8?B?aG5ZVkJwSWRLT2gxWWg3ODI0Tk95aExORkEwdEFQT0xYZGRvNjUydEM5RGFs?=
 =?utf-8?Q?CPPdSnpaAvbN9I4YHI9MVMTCMYBGOgDsWyhC+VLCppsNo?=
X-MS-Exchange-AntiSpam-MessageData-1: BFDDXmat3cQKIw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c155ce6-91f1-4d23-24f5-08ded5da6e54
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:32:06.5531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIBOrAoRs8jJILJET3FfrwKekhBrFpiEUiWhqN8MQVWF4gCgZ5gY6tHleNPzvYAKA3RUSUihUl8Zhu0bEfb9KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311
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

When adding the GSP unload capability, we introduced `BootUnloadGuard`
to automatically call `Gsp::unload` whenever an error occurred during
the boot process, in order to try to reset the GSP to a valid state.

This approach is not well-suited to the errors that may occur in HALs:
by definition, an error occurring in the HAL means that the GSP is not
booted; yet the first thing that `Gsp::unload` does is queue a shutdown
message to the GSP, which will inevitably result in a timeout when done
from a HAL.

Furthermore, `BootUnloadGuard` is problematic because it holds
additional references to the boot context, notably the `Falcon`s. These
extra references stand in the way of making some of the `Falcon`'s
methods mutable, since those methods would require exclusive access. As
this behavior is only needed in one place, introducing dedicated types
for it is distracting and unnecessary.

Thus, remove `BootUnloadGuard` and adopt a two-level error handling
strategy:

- HALs are free to handle their errors as they see fit (most likely, by
  running their unload bundle if it is ready by the time of the error),
- `Gsp::boot` uses a `ScopeGuard` that runs `Gsp::unload`, since the
  GSP should be up and running by the time `GspHal::boot` has returned.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs      | 67 +++-------------------------------
 drivers/gpu/nova-core/gsp/hal.rs       | 13 +++----
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 20 ++++------
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 23 +++++++-----
 4 files changed, 33 insertions(+), 90 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index bb2000b7a78b..0d2213fb1569 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -30,66 +30,6 @@
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
@@ -107,6 +47,7 @@ pub(crate) fn boot(
         let bar = ctx.bar;
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
+        let sec2_falcon = ctx.sec2_falcon;
         let dev = pdev.as_ref();
         let hal = super::hal::gsp_hal(chipset);
 
@@ -118,7 +59,11 @@ pub(crate) fn boot(
         let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
-        let unload_guard = hal.boot(&self, &ctx, &fb_layout, &wpr_meta)?;
+        let unload_bundle = hal.boot(&self, &ctx, &fb_layout, &wpr_meta)?;
+
+        let unload_guard = ScopeGuard::new_with_data(unload_bundle, |unload_bundle| {
+            let _ = self.unload(dev, bar, gsp_falcon, sec2_falcon, unload_bundle);
+        });
 
         gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
 
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 51a277fe97bb..0d65a32f9949 100644
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
@@ -51,15 +50,15 @@ fn run(
 pub(super) trait GspHal: Send {
     /// Performs the GSP boot process, loading and running the required firmwares as needed.
     ///
-    /// Upon success, returns a guard that runs the GSP unload sequence if GSP boot does not
-    /// complete.
-    fn boot<'a>(
+    /// Upon success, returns the [`crate::gsp::UnloadBundle`] to use with [`Gsp::unload`], if one
+    /// could be created.
+    fn boot(
         &self,
-        gsp: &'a Gsp,
-        ctx: &GspBootContext<'a>,
+        gsp: &Gsp,
+        ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> Result<BootUnloadGuard<'a>>;
+    ) -> Result<Option<crate::gsp::UnloadBundle>>;
 
     /// Performs HAL-specific post-GSP boot tasks.
     ///
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 2187e11168b2..bd15a3067ffe 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -23,7 +23,6 @@
         Fsp, //
     },
     gsp::{
-        boot::BootUnloadGuard,
         hal::{
             GspHal,
             UnloadBundle, //
@@ -145,27 +144,22 @@ impl GspHal for Gh100 {
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
+    ) -> Result<Option<crate::gsp::UnloadBundle>> {
         let dev = ctx.dev();
         let bar = ctx.bar;
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
-        let sec2_falcon = ctx.sec2_falcon;
 
         let unload_bundle = crate::gsp::UnloadBundle(
             KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
         );
 
-        // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
-        let unload_guard =
-            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, Some(unload_bundle));
-
         let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset)?;
 
         let args = FmcBootArgs::new(
@@ -176,11 +170,13 @@ fn boot<'a>(
             false,
         )?;
 
-        fsp.boot_fmc(dev, bar, fb_layout, &args)?;
+        // Keep the result as we want to wait for lockdown release even in case of error, to make
+        // sure `args` is not accessed by the GSP anymore.
+        let res = fsp.boot_fmc(dev, bar, fb_layout, &args);
 
         wait_for_gsp_lockdown_release(dev, bar, gsp_falcon, args.boot_params_dma_handle())?;
 
-        Ok(unload_guard)
+        res.map(|()| Some(unload_bundle))
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 6ed4ee268086..8511cc647596 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -6,7 +6,8 @@
 use kernel::{
     device,
     dma::Coherent,
-    io::Io, //
+    io::Io,
+    types::ScopeGuard, //
 };
 
 use crate::{
@@ -32,7 +33,6 @@
     },
     gpu::Chipset,
     gsp::{
-        boot::BootUnloadGuard,
         hal::{
             GspHal,
             UnloadBundle, //
@@ -264,13 +264,13 @@ fn run_fwsec_frts(
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
+    ) -> Result<Option<crate::gsp::UnloadBundle>> {
         let dev = ctx.dev();
         let bar = ctx.bar;
         let chipset = ctx.chipset;
@@ -296,9 +296,12 @@ fn boot<'a>(
                 .ok()
                 .map(crate::gsp::UnloadBundle);
 
-        // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
-        let unload_guard =
-            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, unload_bundle);
+        // Run the unload bundle to try and recover the GSP if an error occurs.
+        let unload_guard = ScopeGuard::new_with_data(unload_bundle, |unload_bundle| {
+            if let Some(unload_bundle) = unload_bundle {
+                let _ = unload_bundle.0.run(dev, bar, gsp_falcon, sec2_falcon);
+            }
+        });
 
         // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
         if !fb_layout.frts.is_empty() {
@@ -329,7 +332,7 @@ fn boot<'a>(
         )?
         .run(dev, bar, sec2_falcon, wpr_meta)?;
 
-        Ok(unload_guard)
+        Ok(unload_guard.dismiss())
     }
 
     fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {

-- 
2.54.0

