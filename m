Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAC3CDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF78210E50A;
	Mon, 22 Jun 2026 07:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JfDagm79";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F6F10E50A;
 Mon, 22 Jun 2026 07:57:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9R8huKokngOOLt7r9LGGn+EIe1S0xje/xmDkVhIXMT5e2QE5acyJXMgqiLtzTzdNexwUGlJz/oa0r10iJhxnevQofFufn3IabtaSPLMRMUTQPmIJcAGICYg8DpVm2f9E+Oinq7HvTkf45kUIAbX7kVBFon7sHMxR9fLS6j5cxE6+nw0sNlBSneFn7iO6bnB47nq3Uw/1GUH7Hm1yK/6bksur0Kr145sV+z/XfB6mlz7BtEfxrKodjqE80NvPmUHbrtbgMJGdw6LnwiPaUPXJEUXDLH921qVjiuxxXNhjKER1qoBNc0BaKh/YN/P3kOofSGEcJgQN5d5Dnh/ehRSNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPyfOa0IcFNBBO0mmy/kAj/xnUYbduMaVMV4a0ERCes=;
 b=XvhEndmYPQDX3QprI3tXT0nAd6QvZK0rdAmZhOA9QY7hyT1YpCodQMywPllba3ewmKcE6oAzpryM143BLuq3sp+KNyPXCUVuY5jB/WLrULklwbn5LtLePXv5ALGmUnRNDfnICGXsU/77jupwFnxRaSaZp4vpEsg8Ai7ewUT98iZJHO4mxtp9ZrfG+HZvwLXZ6mTYX9DoRV8Nf5E4trG2DyT+vsuS4pIoDlkGWfP6y7TTerWaic3bfZbVoU2uOd88fgIiRt1g0H5DcWCg0Sc4NQi6naZgVH4VZiJnOPou4o5ccYpI0eSnQSilvSEQL+qERLlnDuIJVfT9mIpuHJvXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPyfOa0IcFNBBO0mmy/kAj/xnUYbduMaVMV4a0ERCes=;
 b=JfDagm79TsgMsjzeHMqL+IQbGHevC0XIwdr5FJC5PzzpxwQHxzOwG3eGcfh9m9MoxWFOO/o0la0lltJ3cVethP2RXyMjTksAYArWSAyQq8ZxkXKQB5rjUeAcAi0vmJ+/K+5af0VLwuG7yqHfVTYtVIp7lxh8HdIUttEcOQwp1STqkxPXxHXHyyiVrc5x7Z8NlmSTmL8MGsi9gRYMwoHv3SikbzdktU4uVg5SvLEX5UNCT5TIW+rDK0PczlNw/VyDeM8eNJbzBlPFG5DqWinu/J1jm6IEQPR5ZwPxzhU4is3jxVBDJbocuPEYcS5oUwd7O25H+WCBQIXmZqpzcVNF1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 07:57:10 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:57:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 16:57:04 +0900
Message-Id: <DJFF1W6VGY4Q.2PV5MEPMFXIDB@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 3/6] gpu: nova-core: gsp: move boot code into local closure
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com>
 <20260619-nova-bootcontext-v1-3-45193cd0a2e5@nvidia.com>
In-Reply-To: <20260619-nova-bootcontext-v1-3-45193cd0a2e5@nvidia.com>
X-ClientProxiedBy: TY6P286CA0036.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::10) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6a48b4-2da8-4290-4b23-08ded033dc06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|10070799003|366016|3023799007|6133799003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EX7dyHCwAxL1ZkTSqvOVbkpv3762nRVfbVE3ty5nZh0X4+UEM3PvIxd57qnnM48rhsq4voJfA9/7c1X/nnTSq/1aOagbdMxWrWrym1gHuxyRw2pnPyrAaaD8db/caKqm3w3qHU387aAZJYzNzLpCOXOOl43xhI5VW2mm+Aq6VV4YMIdzwf44pqf9kVEDSy+oCSMu3XDrt2jx84Oh4qehXeAFC1+wlWk3Ctjpk9YeuY8DPrYhcbRC7+cswQP3U/raNpEDr9qtQckhT2lSTOloKnMRVfPtMy7OoVCsex1QSbEih4LS6A/Z5j5Fz4shGftp/2mjhLZMXaQcpchsskzvjM7Sx6Xhr7ie5kefmdeeeD0o+J8OpYmyoKPUXb6tyIh4Gaj+cJyBals/jXS0lo8SXjsVdrRhdZRdd7LEJiqXbJe2Ua7J7DNchTav/sg6OM9J1PlSd+iKkCk4BhQrRi3yLFNkfUyDntkGGotO4aSYUI81wtkg8TWM6rpi7oUoV1mXACK5s7+FOLUVcYy+9pDxXMbhwn/J3tBsB+6yeogSgY1gMI4E16w5ceTTkNTH1JD/OgebqbkCwzCD9QcuJrh12opd52w2QaqaFZkn5sz/1xZX1whNVWq4yFhx3zV+8m57sBE1j1jyyOt4u2NIxg7jz4cCtt7MjQcm5TWie9ROF0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(10070799003)(366016)(3023799007)(6133799003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUhXQTdFYnRDQXBzVWdzTTE5NFR1TnVLM212U3RiTm1QK3M0ME00WkZoRzBX?=
 =?utf-8?B?QVhYUXc5b2NxK3ZFQllheGNORmkwZGc0MjNqNTJQQ2RwNFpBYzkzaFFUZ29a?=
 =?utf-8?B?ZkpXWkFhZ1pCeE5rbnRQcFhrMmFDTWttbTZoK0lPOGNTN1Naa0RjbXRSK0xn?=
 =?utf-8?B?aVliUkNQK1o1TFJ1RmtWUzJKdkU5RllKb2xhMWhta05pOVBDMGVVTDlIRDBQ?=
 =?utf-8?B?ekVuUXg5VDI0NUN4bVZwb1h4TnoyUENRQ0cycmxSZGN5SlRkUlhJVU1zNEE5?=
 =?utf-8?B?MVRRbXFkNWgvc2lhNWYwclA3K0FZUzJyM0ZTMnNhSUZRMUY5Q1JLQjQxMFpw?=
 =?utf-8?B?c0toUjdURmZGbFh5UkRyVTlRTlROZEpWZUlhNlhoWFgzZEoyN1UrOXM1UmxG?=
 =?utf-8?B?b1hYajBqbFhOeFJqN3A5cUhIZktjVTl5UGsyNE1KckdGZEVHMStJanZLeVg5?=
 =?utf-8?B?SUhXMVZoaU5jMGQ5QzR4dmtBMUx1WFZrWmorOENzUENqclcwM2pXTFp0VkJ5?=
 =?utf-8?B?YlFkRVBIUUVReUlJWUY3RnZCcFVER3djektRekNJcUV0cXh0dkF6ci9vV3lZ?=
 =?utf-8?B?YjJjb2tVaHBMQzdUcTE5MUI5dmdmaHorVTJKTG5EK0dUblhidXk5SGxaekxE?=
 =?utf-8?B?RzAwcUltSlNpQUV6bHcyUktnY05YVGY3MERBUFkxVFZEYTIvM2IxQXJYWkdE?=
 =?utf-8?B?NXl1VTlhd21KWVg3bXVQRmR0ZHJORHJ2VnJJRms2MW1KUzdubWxUVS9CZmh0?=
 =?utf-8?B?YWJ2OUtSdENOeURpVnFSVlNXeFlBdDNrbEFIajRmdTVvejN3RUJqeGpnTlR6?=
 =?utf-8?B?cll4NlpwKzNkcTJnOUhvWVgwZVM0T2ZjcTZ6elpVQnlWbk9rdjE3blU3Q3Qv?=
 =?utf-8?B?RUV2UTB6Z2JhOFAxVmlodGRiQXlEQWFhb0VadEl2dG5IRG5CRFgzVXR6RTNI?=
 =?utf-8?B?ZDFWQWRpelVmZjhjZFM0VEdKdmZlVG1lUmVETFU4d0NaaWIrb0dNcUpNVDNB?=
 =?utf-8?B?aUxrdVQ4QzJyMC9sNXB2WncwOVVzWS8vajJGemRsZ1o5VEJsMjlLU21tNHJU?=
 =?utf-8?B?NGJ3S0pCWUlJRXZDeGNzdVhSR2R6MkdWMlhTVjcvU25HYjFaVjZDc0VPSlZw?=
 =?utf-8?B?d0pBalpNR09vRVBuZWdpdVAybnNYcndKYXY4YXlIdnBUdk9VVmF1NUhWUHJZ?=
 =?utf-8?B?bFp6ZXRrbjBBTzdxQzM5VlZaYUQ0bnZFWGZnZmk1Y0F4UGtKMTJ5NS9MbFBK?=
 =?utf-8?B?QXRXNG8xYnpMa2ZuWm11YVN6dWplc1hnM2prTmZieDhYTHpyeWQ4SWRhK1E1?=
 =?utf-8?B?ajU2cFpVeG0rVFdlYWNJUUhxZ0pvTmNHTmNYMnY0RjIzZ1VsVUw5UjZVS2M1?=
 =?utf-8?B?bGxUbUJQaVpaWU9sN1ZFbVhzMEpLZFdtdy90R3FwRTI4TlpVaHB5bjhvMzFm?=
 =?utf-8?B?am9wVHk4S3pmYkJEU3ZSR3JUQzI4ZzExRGhpdm5pOWwyREhudGFHa201WHA0?=
 =?utf-8?B?R0llQlV1dXlHWWo2eDl6VDExM1lvUDR6d2VNMi9sTUt4UC9wTFRyMENMSjBC?=
 =?utf-8?B?UUljZDRWM0ZmenlKYktETnZId3h2UlpkOHA0cGpEdkg3WWowQ1FwbkR5MHdz?=
 =?utf-8?B?MzA2Q0Z6Y1JrUkl5SUxNTkdyL0hWU2xqQmx5TGlMdGM0Z1BRaFljdVRVbTd4?=
 =?utf-8?B?UVpER1VvQ1FBdlhtUVYwa1pqb3FCV2RPdjN5NmtmQUFsMnlkeGRPTnpYc1VJ?=
 =?utf-8?B?NnBmQWtnRWliandScncreTR6UE5Faml1cUhyYVVqdWd2UTNiN3JCbnJONjMy?=
 =?utf-8?B?elZQNGlmZjFEelFxZDRVN1AzMkZoRzJZUkhXeTlwS0VqbHVrZk9WcHhQd0ND?=
 =?utf-8?B?clhMVUhXSC83Z0FBZ0pKK0RvTC93NUQyK2wyQWh6N0FFNThkc2NZR0Z6M2Iz?=
 =?utf-8?B?RWRiZTh5VWRxcGcvZW1kS2FEY2lvODBnUDJvK2E2clZCT3NabHlaSWN6YkYy?=
 =?utf-8?B?T3lTTVhpVkFWeHlrM2ZxR2Fqc25kUDd3Zlo4REJCZ2hRQS9CcXZoaklDM3FJ?=
 =?utf-8?B?a1gwVnF1Nk9Cd2JlOXhycE9oVXR0RE1DK3NVbTVHQno0Mk9QVDhJQy9OQmFk?=
 =?utf-8?B?U2UzNk9GemNWNVZhbnE5b3lXL3RZL3NrR1p2TkFhd2tOU2NGQ0FQTUo5Z0Za?=
 =?utf-8?B?elV2enRodW1LQytKNzgzSTRzeW1yemI2THlCQVcwL2U5YkJ0bXd0L2gwVmo3?=
 =?utf-8?B?UEFGUXRZZTRwU3lEUXB4M2RxOVlvdmRWUjl6aDJnell3RHFkc2pnVVlVK0JT?=
 =?utf-8?B?RDNXcVYxMjFqYXZ5dU5XM1cweG9IMCtORFhNOTBjdG1vY29hZGhZYzI0cHRL?=
 =?utf-8?Q?zvU6J+4K3r5lv42vErCqKBjX5cyA2FRwSl0OpopJ9+lnR?=
X-MS-Exchange-AntiSpam-MessageData-1: MMHZr9WWy5nx+Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6a48b4-2da8-4290-4b23-08ded033dc06
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:57:08.9384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwzBEQzPFz6cNrGhyzXaTGl71RCG3V49Kfhvp0mAFmrHWS6JFYV2+y5IrroV2XXhOWTZ2jItljgbcXsh0GyE/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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

On Fri Jun 19, 2026 at 10:42 PM JST, Alexandre Courbot wrote:
> The next patch aims at replacing the cumbersome `BootUnloadGuard` with a
> more local and less intrusive mechanism to run the GSP unload sequence
> upon GSP boot failure. Doing so requires running the boot code in a
> local closure, which changes its indentation and would make other
> changes difficult to track in the diff. Thus, this preparatory patch
> moves said boot code into a local closure that is run upon construction,
> so the next patch does not need to re-indent code that changes.
>
> This is a mechanical preparatory patch to make the next patch easier to
> read. No functional change intended.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

I agree with removing BootUnloadGuard, but I think it's not great to do
a bunch of lifting into closures then manually handling the result. It's
error prone imo (we already had several bugs relating to this kind of
thing). Instead, what about just using ScopeGuard directly? This lets us
avoid lifting into closures (which is a bit noisy) and avoids manual
result handling for failures (which is a bit error prone). With the
`GspBootContext` it's fairly easy to do now:

```
let unload_guard =3D ScopeGuard::new_with_data(unload_bundle, |unload_bundl=
e| {
    let _ =3D gsp.unload(ctx, unload_bundle);
});
```

I confirmed that it's also compatible with the v2 of this series that
has the mutable Fsp - you can stash the context inside the ScopeGuard
data (then making a &mut reference to the stashed context for brevity)
or have a separate unload context type that doesn't use FSP or something
(could later be type parametrized along with Gsp, for example).

For example here is a rough diff on top of this patch series (you can
change the Result<Option<UnloadBundle>> returns to like
Result<Result<UnloadBundle>> if you want to centralise teh error
handling of a failed unloadbundle although currently it can only fail in
one location):

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 7918ebb508f9..f6454b106293 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -314,7 +314,7 @@ fn drop(self: Pin<&mut Self>) {
             .as_ref()
             .get_ref()
             .unload(
-                GspBootContext {
+                &GspBootContext {
                     pdev: device,
                     bar,
                     chipset: this.spec.chipset,
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/=
boot.rs
index 336ad23c96f9..cfe10a8313c8 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -6,7 +6,8 @@
     dma::Coherent,
     io::poll::read_poll_timeout,
     prelude::*,
-    time::Delta, //
+    time::Delta,
+    types::ScopeGuard, //
 };
=20
 use crate::{
@@ -55,57 +56,35 @@ pub(crate) fn boot(
         let wpr_meta =3D Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new=
(&gsp_fw, &fb_layout))?;
=20
         // Perform the chipset-specific boot sequence, and retrieve the un=
load bundle.
-        let (res, unload_bundle) =3D hal.boot(&self, &ctx, &fb_layout, &wp=
r_meta);
+        let unload_bundle =3D hal.boot(&self, &ctx, &fb_layout, &wpr_meta)=
?;
=20
-        // Display error for unload bundle if any, and convert to `Option`=
.
-        let unload_bundle =3D unload_bundle
-            .inspect_err(|e| {
-                dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n"=
, e);
-                dev_warn!(dev, "The GSP won't be able to unload properly o=
n unbind.\n");
-                dev_warn!(
-                    dev,
-                    "The GPU will need to be reset before the driver can b=
ind again.\n"
-                );
-            })
-            .ok();
-
-        // Run from a closure so we can retrieve the result, and run the u=
nload sequence of the GSP
-        // in case of error.
-        let res =3D res.and_then(|()| {
-            gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version=
);
-
-            // Poll for RISC-V to become active before continuing.
-            read_poll_timeout(
-                || Ok(gsp_falcon.is_riscv_active(bar)),
-                |val: &bool| *val,
-                Delta::from_millis(10),
-                Delta::from_secs(5),
-            )?;
-
-            dev_dbg!(pdev, "RISC-V active? {}\n", gsp_falcon.is_riscv_acti=
ve(bar),);
-
-            self.cmdq
-                .send_command_no_wait(bar, commands::SetSystemInfo::new(pd=
ev, chipset))?;
-            self.cmdq
-                .send_command_no_wait(bar, commands::SetRegistry::new())?;
-
-            hal.post_boot(&self, &ctx, &gsp_fw)?;
-
-            // Wait until GSP is fully initialized.
-            commands::wait_gsp_init_done(&self.cmdq)
+        let unload_guard =3D ScopeGuard::new_with_data(unload_bundle, |unl=
oad_bundle| {
+            let _ =3D self.unload(&ctx, unload_bundle);
         });
=20
-        match res {
-            Err(e) =3D> {
-                dev_err!(dev, "GSP boot failed with error {:?}\n", e);
+        gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
=20
-                // Ignore errors during unload; we will return the error t=
hat happened during boot.
-                let _ =3D self.unload(ctx, unload_bundle);
+        // Poll for RISC-V to become active before continuing.
+        read_poll_timeout(
+            || Ok(gsp_falcon.is_riscv_active(bar)),
+            |val: &bool| *val,
+            Delta::from_millis(10),
+            Delta::from_secs(5),
+        )?;
=20
-                Err(e)
-            }
-            Ok(()) =3D> Ok(unload_bundle),
-        }
+        dev_dbg!(pdev, "RISC-V active? {}\n", gsp_falcon.is_riscv_active(b=
ar),);
+
+        self.cmdq
+            .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev, =
chipset))?;
+        self.cmdq
+            .send_command_no_wait(bar, commands::SetRegistry::new())?;
+
+        hal.post_boot(&self, &ctx, &gsp_fw)?;
+
+        // Wait until GSP is fully initialized.
+        commands::wait_gsp_init_done(&self.cmdq)?;
+
+        Ok(unload_guard.dismiss())
     }
=20
     /// Shut down the GSP and wait until it is offline.
@@ -134,7 +113,7 @@ fn shutdown_gsp(
     /// This stops all activity on the GSP.
     pub(crate) fn unload(
         &self,
-        ctx: super::GspBootContext<'_>,
+        ctx: &super::GspBootContext<'_>,
         unload_bundle: Option<super::UnloadBundle>,
     ) -> Result {
         let dev =3D ctx.dev();
@@ -153,7 +132,7 @@ pub(crate) fn unload(
             res =3D res.and(
                 unload_bundle
                     .0
-                    .run(&ctx)
+                    .run(ctx)
                     .inspect_err(|e| dev_err!(dev, "Unload bundle failed: =
{:?}\n", e)),
             );
         } else {
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/h=
al.rs
index 113d445239b9..849ca224085b 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -37,22 +37,15 @@ pub(super) trait UnloadBundle: Send {
 pub(super) trait GspHal: Send {
     /// Performs the GSP boot process, loading and running the required fi=
rmwares as needed.
     ///
-    /// Returns two things:
-    ///
-    /// - The `Result` of the boot process itself,
-    /// - The `UnloadBundle` to use with [`Gsp::unload`], or `Err` if the =
bundle could not be
-    ///   created.
-    ///
-    /// Note that the two returned values are independent: it is possible =
for the boot process to
-    /// succeed while the unload bundle couldn't be created. In this case,=
 the GSP won't be able to
-    /// unload properly and a full GPU reset is required before the GSP ca=
n be booted again.
+    /// Upon success, returns the [`crate::gsp::UnloadBundle`] to use with=
 [`Gsp::unload`], if one
+    /// could be created.
     fn boot(
         &self,
         gsp: &Gsp,
         ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> (Result, Result<crate::gsp::UnloadBundle>);
+    ) -> Result<Option<crate::gsp::UnloadBundle>>;
=20
     /// Performs HAL-specific post-GSP boot tasks.
     ///
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core=
/gsp/hal/gh100.rs
index c6ff2fb216ea..04c27afc650a 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -7,7 +7,8 @@
     device,
     dma::Coherent,
     io::poll::read_poll_timeout,
-    time::Delta, //
+    time::Delta,
+    types::ScopeGuard, //
 };
=20
 use crate::{
@@ -143,35 +144,35 @@ fn boot(
         ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> (Result, Result<crate::gsp::UnloadBundle>) {
+    ) -> Result<Option<crate::gsp::UnloadBundle>> {
         let dev =3D ctx.dev();
         let bar =3D ctx.bar;
         let chipset =3D ctx.chipset;
         let gsp_falcon =3D ctx.gsp_falcon;
=20
-        let mut unload_bundle =3D Err(ENODATA);
+        let unload_bundle =3D crate::gsp::UnloadBundle(
+            KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBund=
le>
+        );
=20
-        let res =3D (|| {
-            unload_bundle =3D Ok(crate::gsp::UnloadBundle(
-                KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn Unload=
Bundle>,
-            ));
+        let unload_guard =3D ScopeGuard::new_with_data(Some(unload_bundle)=
, |unload_bundle| {
+            let _ =3D gsp.unload(ctx, unload_bundle);
+        });
=20
-            let mut fsp =3D Fsp::wait_secure_boot(dev, bar, chipset)?;
+        let mut fsp =3D Fsp::wait_secure_boot(dev, bar, chipset)?;
=20
-            let args =3D FmcBootArgs::new(
-                dev,
-                chipset,
-                wpr_meta.dma_handle(),
-                gsp.libos.dma_handle(),
-                false,
-            )?;
+        let args =3D FmcBootArgs::new(
+            dev,
+            chipset,
+            wpr_meta.dma_handle(),
+            gsp.libos.dma_handle(),
+            false,
+        )?;
=20
-            fsp.boot_fmc(dev, bar, fb_layout, &args)?;
+        fsp.boot_fmc(dev, bar, fb_layout, &args)?;
=20
-            wait_for_gsp_lockdown_release(dev, bar, gsp_falcon, args.boot_=
params_dma_handle())
-        })();
+        wait_for_gsp_lockdown_release(dev, bar, gsp_falcon, args.boot_para=
ms_dma_handle())?;
=20
-        (res, unload_bundle)
+        Ok(unload_guard.dismiss())
     }
 }
=20
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core=
/gsp/hal/tu102.rs
index 93ff8a154100..fb1d233ac7db 100644
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
=20
 use crate::{
@@ -267,57 +268,66 @@ fn boot(
         ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> (Result, Result<crate::gsp::UnloadBundle>) {
+    ) -> Result<Option<crate::gsp::UnloadBundle>> {
         let dev =3D ctx.dev();
         let bar =3D ctx.bar;
         let chipset =3D ctx.chipset;
         let gsp_falcon =3D ctx.gsp_falcon;
         let sec2_falcon =3D ctx.sec2_falcon;
=20
-        let mut unload_bundle =3D Err(ENODATA);
+        let bios =3D Vbios::new(dev, bar)?;
=20
-        let res =3D (|| {
-            let bios =3D Vbios::new(dev, bar)?;
+        // Try and prepare the unload bundle.
+        //
+        // If the unload bundle creation fails, the GPU will need to be re=
set before the driver can
+        // be probed again.
+        let unload_bundle =3D
+            Sec2UnloadBundle::build(dev, bar, chipset, &bios, gsp_falcon, =
sec2_falcon)
+                .inspect_err(|e| {
+                    dev_warn!(dev, "Failed to prepare unload firmware: {:?=
}\n", e);
+                    dev_warn!(dev, "The GSP won't be able to unload proper=
ly on unbind.\n");
+                    dev_warn!(
+                        dev,
+                        "The GPU will need to be reset before the driver c=
an bind again.\n"
+                    );
+                })
+                .ok()
+                .map(crate::gsp::UnloadBundle);
=20
-            // Try and prepare the unload bundle.
-            //
-            // If the unload bundle creation fails, the GPU will need to b=
e reset before the driver
-            // can be probed again.
-            unload_bundle =3D
-                Sec2UnloadBundle::build(dev, bar, chipset, &bios, gsp_falc=
on, sec2_falcon)
-                    .map(crate::gsp::UnloadBundle);
+        let unload_guard =3D ScopeGuard::new_with_data(unload_bundle, |unl=
oad_bundle| {
+            let _ =3D gsp.unload(ctx, unload_bundle);
+        });
=20
-            // FWSEC-FRTS is not executed on chips where the FRTS region s=
ize is 0 (e.g. GA100).
-            if !fb_layout.frts.is_empty() {
-                run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_la=
yout)?;
-            }
+        // FWSEC-FRTS is not executed on chips where the FRTS region size =
is 0 (e.g. GA100).
+        if !fb_layout.frts.is_empty() {
+            run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout=
)?;
+        }
=20
-            gsp_falcon.reset(bar)?;
-            let libos_handle =3D gsp.libos.dma_handle();
-            let (mbox0, mbox1) =3D gsp_falcon.boot(
-                bar,
-                Some(libos_handle as u32),
-                Some((libos_handle >> 32) as u32),
-            )?;
-            dev_dbg!(dev, "GSP MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1=
);
+        gsp_falcon.reset(bar)?;
+        let libos_handle =3D gsp.libos.dma_handle();
+        let (mbox0, mbox1) =3D gsp_falcon.boot(
+            bar,
+            Some(libos_handle as u32),
+            Some((libos_handle >> 32) as u32),
+        )?;
+        dev_dbg!(dev, "GSP MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
=20
-            dev_dbg!(
-                dev,
-                "Using SEC2 to load and run the booter_load firmware...\n"
-            );
+        dev_dbg!(
+            dev,
+            "Using SEC2 to load and run the booter_load firmware...\n"
+        );
=20
-            BooterFirmware::new(
-                dev,
-                BooterKind::Loader,
-                chipset,
-                FIRMWARE_VERSION,
-                sec2_falcon,
-                bar,
-            )?
-            .run(dev, bar, sec2_falcon, wpr_meta)
-        })();
+        BooterFirmware::new(
+            dev,
+            BooterKind::Loader,
+            chipset,
+            FIRMWARE_VERSION,
+            sec2_falcon,
+            bar,
+        )?
+        .run(dev, bar, sec2_falcon, wpr_meta)?;
=20
-        (res, unload_bundle)
+        Ok(unload_guard.dismiss())
     }
=20
     fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &GspF=
irmware) -> Result {

