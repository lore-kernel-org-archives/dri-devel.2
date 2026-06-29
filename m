Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8226CC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D327610E898;
	Mon, 29 Jun 2026 12:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BjDGKbFe";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A759E10E896
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:32:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGKaXmRs7rz7w82xchWnYOHMc6gtdUc2V8OIKhVhtEnlNeVHf4z00HJ9CjSg6BjrUgF+qVlpqAYFz4nBsOd+s62TjWlm2jdN/EuTlsqNUEiTN0cYD2GyoB8ur+CYVin8t/pqHPO5BvfCuXKdS8ECQ9WMnQH4skiX1YIAqJAF4u+r7b8XJgk4/z5CYiKepcf6LNFizd9adLPP0XsR3ZCVHcafKtPHvi2dUO7U9VAq9WQN1UCtlkAgFmN/vBozS6XExHYdeQHZFmmcwSkVotePRQZ+mTKIvGiyr4RayTl19WZcle+/N7tYboequs1aljmkZP2kwnXPLhAH7+4yA9FU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEO6He9wvQ+J6/c9Aikvhg1Rpjqq3IcpbxHnzrTU6+w=;
 b=DY5GokERl4p60RGNqMFJu3VDNTyAY3B3q7/TTbPyd+b3LHt2nakEy4T32QBfF2UBe2cCaAIhNIsI2ZulECgF8beajtclO8zGtTXaquY+l1NcycfbGRW/UPTqmhNtr4Fpfd5AMevv7DTbX7FxnN7S9GIxVXuBfRRHKek5CIgWFU5Az05XmGBAGcQZY2bGZrsLzX1Ds7aZbGNI3zE73K60l5OG/OuUge+5gKdFoTlp02NG2fY+EfOW6Pk4j952Q8xTlvxrCTfj5ZZkoQp8wQeLAbH87gMY5HOJmPqFGGzQIVgxilrP9qwDIniN3sHAt10/df3vKDmhtNPvRb6r9iVDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEO6He9wvQ+J6/c9Aikvhg1Rpjqq3IcpbxHnzrTU6+w=;
 b=BjDGKbFe0pUzd0ZN0X6eO28Sb01utoF1/SU770tnyDdwdP8QCrGfkdsC0CnCxGv/CbhIGEizELCAQnJp4S05zdmHXLCxEfFj818saerMr6ZznHio8Q9Rk5u+7v7PbVfxFi4vqDLHLrQofPvNxXtVhOgCmBLZ35zHdx1Er9c5k+juJ1njKARTA6LsE/0v2XXjxgaQr8ITq4KQaaRtDe3w02Bu3XMb6cUWbUrmh6qwPplpCI3JjB8JM4aOxVgw0WmQhRwvBmW8hlnlUM1QSYQSL0mVffiPkkZGOhUA2GJR86HEvYtNJgkBs+UKDDeYA0sV2JFZ7WViXW1SWNbR82WSTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Mon, 29 Jun
 2026 12:32:15 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:32:14 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 21:31:48 +0900
Subject: [PATCH v3 05/12] gpu: nova-core: gsp: centralize missing unload
 bundle warnings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v3-5-26cb29ee8dee@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0005.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 2033a138-1b68-4724-f74e-08ded5da730d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|23010399003|366016|1800799024|22082099003|11063799006|56012099006|18002099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info: CtaEvfU1pfoGDhLjhi7+i5Y4+UKHQwzpVavoMR/8AYtyn8n6BsYl8X8yvWAnqeg6Vf+lPG9fiTjUDyGa9XQK1LZ6Fa8ks0n3GKFA5tTl7HG7ZrSk1rAo9+lM45PhKyLwGDTauWQSSbPM9tM5U302lC0xEgrv0F/UrBEX9w8wboEyXnojfxyBYdHin/9iSzlyFdW7DyFCl8d2BBpDkZOSLiEt2rt4RzHgjzGMaGWaouF9y19xG4wtITyZ90soMqtt5dt2J7Juhmskpr/VCn1i0DwHYZkNzGVYIETbr94WSidyRG/Jfq8KWJeP0EC124ri996WW7GcdtcMcX7/YepRaBSaUNH4+hhLB4Wi17zMA4XyUz3Qe+NBQM5ZJhvbwXIapXuv73aNWBMdaaPoJaFt1zxcRKnLwM6pwLEkBDD/e+DeVPdm45+C8mOSxzNe69jaJsvUb6NFm5Te7opBeZB6nY5vCTESUmgfTSAwq0yqf/dADB3dd+ZmQ2Gzj4LSq/PYydTuDmZgDTFYfgkU6uFLfWcHthccbAddUhAFzEUVa8054ti3Dsrizgfqlep02t/YNxpavp+jSo+EONE5YFit/p/mXSrCaaou+aWqfhf6BM/wcHHIFmPuuxDcbXxvft1Al+TxdcFp9l+z/f2MscvElFUHkGTZWaLLGJRLI0OiYIom/i9YKN9BCXrwJTqruochbKAPYOkq59WR/vEH4heb1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(23010399003)(366016)(1800799024)(22082099003)(11063799006)(56012099006)(18002099003)(6133799003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d016UWU0djZ5TWlKVmRheHRUTmlCdGwrWTRraXZJdGNldzByUXBSQ3lYQ0pm?=
 =?utf-8?B?WnVEN3hadjZwZUlsVVRRVGYvQTdrVVV5cDY5RlZ4K0kwenZGTUNUNEE4TkZk?=
 =?utf-8?B?UVFKYmNFRGF2SEc1TURFLzVWb3YxRjBiQ0RHd0VtUHlkRFpNbFIydEhEYmFV?=
 =?utf-8?B?Z0xKanJxYXhUR0cyWGlZOENUc2wxZG9PcXJ4MGkvVjJSVFhvRSsyemwxV0li?=
 =?utf-8?B?c1laTjBDMFVETWNNMVp2UEk3T3NNVW9pMVFHLzFJL2U0U2wyYkZ3N2FzaDli?=
 =?utf-8?B?ZXBZeVdBUE0xUS96Mkd5RHlWRWdzZlc3YXJQcFVzOHNCSm9QRFduZVc1Mkp0?=
 =?utf-8?B?dGhpcG1oVFhGWk5mL3BzejF1emhFMEJjakpSU3NnNXJsU1ordFNMSXJWNEdS?=
 =?utf-8?B?a2tveWMvZmNqNlFIMTJteHlvWk42cmFacHlkcCtLaDN2VkhhQ0NVcjdTVFZV?=
 =?utf-8?B?eDlKWWY1UGNvTE9rSklzNEZPZ1VDT29Da0M2a09rbmdDcGlrUGVpWEdnMEZU?=
 =?utf-8?B?WVE0RER3TDYwaDEvVCtFTS9DYU82L3FTbjNHMGJjWWhySzhmdW9UZ3owb2F5?=
 =?utf-8?B?QW8zUHllWjV5VG5CRDY3a05SdmhCblM0SCtxV3RNSy9SREtHRVBldmo0ZnZy?=
 =?utf-8?B?TVhhcU45MTB1ZkJ5N0xSTGU0UjFick9WckZuVXFzZVBxZHdKazBKdzV1R2Fn?=
 =?utf-8?B?anIvdFJsNis1aDlaZWNyUWQwTm5nNGFvVU1zWngramFwak4rbkxDVDNZZzRv?=
 =?utf-8?B?ZEt1b3R5UE8wK2EyYTZwYVAyRHhyK2tHemp5UTNXM0tqeXcwUGphYXFYbUtL?=
 =?utf-8?B?U2Z6V20yRC9xem5mUDNZdVpINXFjUzdnMlAyalJGYTBCZ2lQS3cvOWtZVVc5?=
 =?utf-8?B?bU85ME51bnZJMU9iYkhnOXJpM0tqQnZqc2kvZU91STBSSVZPUThnMGFldWN5?=
 =?utf-8?B?WWh6cG9lTGE2MzhtbFlNQlRGbnRlVUNHS2lsRGVKcXJ5YW5mUWZ2K0Vlbk5q?=
 =?utf-8?B?ZC9nVk9JQ0hraWZZRzU4eXZRN0N6YndZNEVZUXlBUkRLbzVqZGdRODk0Rldw?=
 =?utf-8?B?Zk5IM0xXRVVCSzYzTlpXM2syenBBT21pSzBicUs1SVlxVmZORWF4d2hDTURZ?=
 =?utf-8?B?TlIyMFBKeElsWXNnSDI0alVMZE1wY3ZtME81NXBkTkRNZ3I1ZWpzNEdqV1R0?=
 =?utf-8?B?SmJuY2c2anIvYXo3ZmpzbTl2SmliZVYvQ0Ruby9NVjJLQWxidnNYOElWcTAy?=
 =?utf-8?B?NFZsRTIwSmRUQkdHbHU5SFZBOU9Oa3FVaXh4MC9qbEFaL1V3YjR5Z254bzVE?=
 =?utf-8?B?bFd6VFBkVkwxeGxVU1F6ZjQ5UUM0RGk5NUV4TU1SeHMvNGd4QXBRdHVuNHRk?=
 =?utf-8?B?N2VWTTZ2Uy9CM0ZuMjJ5a0lhV21LTXQ0QkNjODZNNHU5dWpRcnYyUHlQNkFG?=
 =?utf-8?B?eHgvTWdrQ25taEhVcnYvTytydDF1VEthV09pM2JLQmo1MkcrSVRlK1g2bXJ1?=
 =?utf-8?B?dWYyc1hCaGhIL09YU1pxUm1lY2xWY254Q3ovVTk2a1k3N2MwN3N0dlZLcUFr?=
 =?utf-8?B?clV6VXBIbkpsQkc2c0t0Y0xOaUhja2E4bEhMRzhIRTVEMHVVZ2I3cGRNa3k0?=
 =?utf-8?B?WUtpNTc0cmZROHQwbDZwak5RWFdyNUVIdkdCZ3hqVlVtQnhHeStMSDRyc2ZB?=
 =?utf-8?B?Mm9LSTZlUitLSlJiR1dncktnbnZLZXVJWW5RT1p2UVhiUUhCR09kc3JHTEtU?=
 =?utf-8?B?aS96NVpIMjFpUGxyZDBNcHFxU3FqN2FXdncva1pvVm5obWtQbUtqNU8vN0VF?=
 =?utf-8?B?UDFaSU92WDMzb0RRV3FMUjI5dVhRZys4VnUrbk1HVmIrclRic1VXQm9Cd3NW?=
 =?utf-8?B?THZXTThYVGhPYmRGV1RRcFBBbSt3MUxJRTh1ZWxPems5WjRndFVscUVCdGVD?=
 =?utf-8?B?ZkN0RnhiZG9Eb1hPLzh0TjJMc2NCTUVCMmJmL0hRVHlWa3drYkhjZm0rcEcx?=
 =?utf-8?B?dTAxOFhXRm8yMmZhNVhrTGlBRkhYOTROUGN6UVNOZE1lbkdSQ045U0dmOWlI?=
 =?utf-8?B?NUVsTDRNY2tMa1dvby81alVJYWs3RTBGalZtdWtER0JObDhpaVR3R0J1ZDRr?=
 =?utf-8?B?T2FrOWFkbVBSUXV4aHNMeUpJUEg0RjMyMmFMZENvc2lRcGZWUjRJT3N6dGhK?=
 =?utf-8?B?SWVvSW1aNzNibndDUEdQTDBMWjZ1NmZSSFpaOFR2aDZwYWFyQmRZb2tBVEJO?=
 =?utf-8?B?eEFXVGNma0RyalNsNjlId3Qvd0Z2UUYwWldUNVhQRSsvYWRMOVM0eG56bTh0?=
 =?utf-8?B?NUhGQXRodmxCNFhFMUt0QlNnbGhYZVVIYkNkRWUwRGk1ZElmTmkrZlhobkZF?=
 =?utf-8?Q?JboyFtX1soaxA9ofJ3feMWF601avkHJNl4wQIyfRkRmyE?=
X-MS-Exchange-AntiSpam-MessageData-1: Z+8kz9LDwUCMWQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2033a138-1b68-4724-f74e-08ded5da730d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:32:14.4757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UQ13mM28NDiDwYrp1jC2hOujek9DTibh6VHXvmYeFVVRc1TA9x91XQasr9S2oGHbFPTYAZIeHA7QsebI3GsAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
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

The warning emitted when the unload bundle cannot be constructed is
valid regardless of the boot method, but it was local to `Tu102`. Move
it to `Gsp::boot` so it applies to all boot methods.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs      | 10 +++++++++-
 drivers/gpu/nova-core/gsp/hal/tu102.rs |  9 +--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 033b2ee2e2a0..5f11c8e10a0a 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -56,7 +56,15 @@ pub(crate) fn boot(
         let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
-        let unload_bundle = hal.boot(&self, &ctx, &fb_layout, &wpr_meta)?;
+        let unload_bundle = hal.boot(&self, &ctx, &fb_layout, &wpr_meta)?.or_else(|| {
+            dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
+            dev_warn!(
+                dev,
+                "The GPU will need to be reset before the driver can bind again.\n"
+            );
+
+            None
+        });
 
         let unload_guard =
             ScopeGuard::new_with_data((ctx, unload_bundle), |(ctx, unload_bundle)| {
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index ed9a3d362090..d669ce7625a8 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -283,14 +283,7 @@ fn boot(
         // be probed again.
         let unload_bundle =
             Sec2UnloadBundle::build(dev, bar, chipset, &bios, gsp_falcon, sec2_falcon)
-                .inspect_err(|e| {
-                    dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e);
-                    dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
-                    dev_warn!(
-                        dev,
-                        "The GPU will need to be reset before the driver can bind again.\n"
-                    );
-                })
+                .inspect_err(|e| dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e))
                 .ok()
                 .map(crate::gsp::UnloadBundle);
 

-- 
2.54.0

