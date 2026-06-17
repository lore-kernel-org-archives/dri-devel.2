Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CDACD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9675210EA1D;
	Wed, 17 Jun 2026 13:25:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QuC8ezX9";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013035.outbound.protection.outlook.com
 [40.93.196.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CBF510EA1F
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 13:25:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yO7p8c8zKpDod2fCmcTvQw88d8vXR+IHO7LF54YodfSH0V+XvgpYt42AGGSYt1iERbiePWt8gzhfh3dyfPjR6wAJQKxVv3uMCiyss/j/zWGwR98X+gQJD8/dBVAxN8hVqmOKhLXFaz+WfSAP1jHYBC8PqTsJJAb9oWrasaODmeljJRlh6NtCYPDI7Gwdd51N0DZby8yPbtaghIhKRi87X6VaoywBHAfx1/BaUh79lZ9gJJ9dS0LHevSDEt/FDZgvYOuuFUid7SXqEhJUA5qN5SjZzOXCtUtvB6SgeN7wM6nA3md3YdWaGPu+rZLFAU72qphNABasE3OJucysb85RWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJCTJqPbGwQeJKuWh9Pibu6ru/Gyd+IWyrsW9VO8Pes=;
 b=F9UgFA3cJUD9EEdy+fqj5SpNILOgYx/FyTK25YRbHM45U3qah84C4dhi5T7ymmhQG/Lc1MAEqYTQp8gTgUXH22VF9/u9gu/MJI7eYefxqEYXa6g9LvXuIZVLmcwnggvCINVZdq6rxIJL6GQ4qH4CUv/Tl26V1p20esXaCGLdymXG8yHiB9dVUqLhOmZ5hMKxdZMesdJnsW/v/oQYd+C7LawDWq/jfZJNJaT6Nm8uVnyjBt+kD5GMT2TxdBj6EMJhHmuaEGEwlIdHBXJLf5K/LZjeoTJf6p6vhGen4BVXSv6JgLH+LTNKK26kLCwqDFXSjgAmSDSuFEtuOAzLldFpYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJCTJqPbGwQeJKuWh9Pibu6ru/Gyd+IWyrsW9VO8Pes=;
 b=QuC8ezX95iC1D6jVNYoNnwFWwgX1ImGPSDIRdCZs7V6f4v3Re1CM5+RfwqOS8/msdLiGhI6njGJuaQmvA892XgVUDVZ7gV4g5KmPRFnN2dGZhydjsGB8eYnIhogcoz5QXFiEbjhY+pv9IuwgJhrBWGPlyTfT25loATtNP6wVahiWEPakuoyjZeXl0FGQ5Lm3f46eMEYqqChdRqGsosJViYKjVLN6gfwlxSo38vTWdwnE7Vozpb6HAkirtKaTRv6FiDNbyR25jnnYhBm8/1Ym58clbtA2YBRV8bSFjWhkJLgZHGps7OmuJF1laRHe7j86IF248+vASJ7TysCEWfvstg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 13:24:57 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 13:24:57 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 17 Jun 2026 22:24:44 +0900
Subject: [PATCH v3 2/3] gpu: nova-core: move GPU static information
 acquisition to a GSP method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-boot-vram-v3-2-20b9ec5fe9f2@nvidia.com>
References: <20260617-boot-vram-v3-0-20b9ec5fe9f2@nvidia.com>
In-Reply-To: <20260617-boot-vram-v3-0-20b9ec5fe9f2@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:405:2::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: e8eaa40f-7b1b-4f1b-bc46-08decc73d32f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10070799003|7416014|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: L99xV9dyvi8HRFVmAIzZauNbAvy+5pPvNoTfUYziaxDpbjqjzz2Kvpwm/8ctSoD66H0OEOpmlEVu9jxD8p5/1dTCvKJG4SGlhJXo2FXaD1wvPwBNJ4m8agrdqTTn88uFNro7ZTkmT3Nxwn4DA+6YxjMIMVDfKfdT3EJPUibv9Uifutx4V6QMvE7H6aHDehLNDcoOAwOFzsPv287lJq5+NkqNlaoWEuKwG23/3CjZgawe5UaxXOUPonon9TKAekx2Nb5ZFYm2EW1NdHPnW2klP9pbr8hPNawhAogmME3ShI5XhEtSQs488/E3FA13ejGIyE86BLmyHbQXGi/w3Ac0Clc/bSeVFC0vXBMybtGyMLrotx9gwp5W5DdS4yKZAbzcMJloS9EkjqINVYa6Js42ngOdKIESKiuKqSwMeZlhfOa3c3KTqtLDQLaC59aAcw7JC6lPWBRAIYbntVqvtdBe45rzIK6jxeBe0RTQxNfCdKfnCKoCMgiI/GkOOJqwg9oMSbEhh71sHWPma20t2YmSQ+btpAkfK9xZ11DPMIFzeyyVYi7drGU0cSr5ak0BSvRFw0L3FH9Lkq1DjViw61BIwqwwK/SURQ0mrDFxUzK1ObicIsBXWEoqhUlGg4HAHWSWrQXH4+fIm3dLIgDuxgKYzSfBTAx/PjuJjgpq14hVkFSVEKjZOgEskjHztEUOYS+x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10070799003)(7416014)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVg2eUFrejBoWllBZnFhcVhEOFE0WnFQNmFsckkwVDZ0anhhdjBkUHB6ZEtj?=
 =?utf-8?B?Z3pVdE9LcmxMbXhHM1IvMjVOY05KOTVIdjlUaU9RWk94Rk9IaE92TnNoQy9i?=
 =?utf-8?B?ZDc4Yi8xQ3VXUEpDdk91TXpZcGpIcHV4aEY4NjZaV3lLMkVOdDcxUktZZFZt?=
 =?utf-8?B?NEV4eVJuQTNJYk9mWnVsNHpVQXhyTlVIUHlnV2dMdUtocWZweTgwOVNlYVVD?=
 =?utf-8?B?Q1UveWk0bHRIS1JrejVvQ05Mbys0NU96c2I4S0M5MUFQVWVpcDBiazc2ZGVa?=
 =?utf-8?B?VVFMUnZ4bkgxb0Y2Z2lDTGtYZXBJWWpMQi9Ndjl3ZGwvWElNOWFvczZWZVZt?=
 =?utf-8?B?RXZ1N0pNbFZJVmpJbnVoSXdkNjFMZzZWNWpYbFJXTTFtcGk3SWkxaDVGRnhV?=
 =?utf-8?B?ekhhWDZsRnVzbnp6OUtXQXhYK2kwMVFKRFNOQ25qM3NzVVBGT204NDV6RFli?=
 =?utf-8?B?Y2E0R01ROUsrZ0kxOHBMOFNvcVZGZFBQWmlIZGl5ZHE3RTV4QjRYSTFrU1pi?=
 =?utf-8?B?WXNERkxvVC9RU2NpV2xYQzFJeXFPUmlISFd2bEkva1V0VlVjVXZicjdrZ1BV?=
 =?utf-8?B?NEsxUDdWZEtBY0JkTzg2ODF5VmRxWENST3lPRm90SXJLamlsZnBMODZ1bnRy?=
 =?utf-8?B?dG1XL3ArRmsyb0xraVZ4dzVab1hGN0dpSmxaVmg3VURUOElUc1J3OE04VUpi?=
 =?utf-8?B?S2RWbG1ZMSsvb1lxc0lUYkdRVnpmRVNxSE5VdWpadHd2aU8zblpXNktKUmpC?=
 =?utf-8?B?M0JINnB6bEJxSE5sVS9xdlBGcGRuR2tvdXM5dVo1Y1VDeEM0THFNcjdPSHda?=
 =?utf-8?B?Y0FIQnJrb0VIc1BpQXozMkxxVjloaXdwbHc1dHpUNEQ4YWpqQi83dU5rRmhz?=
 =?utf-8?B?ejdsRnRVZFM5bzFRaE5jUER5cVdTZGJPSkx0UERVT3Vyc2s4d2RWVXpqMjd0?=
 =?utf-8?B?cjIyVVg1N0QvbnI0S0MvWmQ4c0RuUTBZQmhUNXo1Y2dtNDUwbWVEZmRUaVZz?=
 =?utf-8?B?b2t5N3BlY2M0bUtrbW0vVS9IVXQwS2Jhd1FzWHR4Y1VEN2lVRlBTNC9FSXVE?=
 =?utf-8?B?Nm9EaVB1MFNlUzIxcXhSbEYvYW0xeWQ2VGxieE41U3Q5SmcxakFOQk5vbjkr?=
 =?utf-8?B?cURZbW9RQWhNWnFiNjVESk94c2c3R21ZSld5alVHWVI5bkIrUFhGTDJ6TGNU?=
 =?utf-8?B?cXB3SGt3QmU2TG40UGZNNjY3K1UrcjNPTm1ZcTdLRHBWVjBnSDNKQlJleGZQ?=
 =?utf-8?B?VmhYQlpEOTBOMVJrZldJZkNyN0g0dzl4SXpyNEZUUUg3VzdBQ1NMa1UxRFdE?=
 =?utf-8?B?SUlvamNCMTZUWXVHMDh4Ly9SKzlocUZIRTBMVUFRZHAxQUp6VnZ5dXo4elFD?=
 =?utf-8?B?Nzk3VUg4bUdhdTFPckFieUJwOW53UXhaVmVtMEltbEFtcXFhWGhPVEhMaGdZ?=
 =?utf-8?B?UTVVMTNVTW1Nb1ZtNy9CU2gzVWJLQ2JBeWErQXhpYlcvZ3liSmhPNElIU0Vl?=
 =?utf-8?B?R2ZTYlJmT2wvd3NXM29tZy8ySDN6SC9IK091WWEwbmdycFNwczZ6eVBJTmFV?=
 =?utf-8?B?c0xLM2RaQVdvVkVwbEF1S3hDUTRialM2djdaU250QzQ1UXVhZk1qaGIzc2ZV?=
 =?utf-8?B?eDZiR2QwOWtnUHgwNDhtR0N2QXpOeDZwQ1R3Z1k3cU5MWjRmUGthcEhIdXlZ?=
 =?utf-8?B?RldvLzFIeFRkZlZNK0NGQkRZT1N6Nk15NkhzRDRFVFJIQ1hkdjlkQjY4aU95?=
 =?utf-8?B?ZmwxVEFxNHpkc3VROHRCZEk1UWRlQVpkZXUwazBxT3ZGOWdBcDg5R2FlTXR3?=
 =?utf-8?B?MTduRVVWZHRvcEZFbWNtdEFlTGxHQU83NnFBc3NsTktqbVdEblZWVXg3WS9L?=
 =?utf-8?B?L2Myd3RxOTNnVGNXcnoxblpUeHE2elZIL21QaUlDcHZGeExuVHF0SzN4RXlE?=
 =?utf-8?B?VFVQKy9vcXkveWFWcjA3WFJNRzYzUk8wZlg2bVZ1MFNFMnZuL1JWRldtYWc4?=
 =?utf-8?B?SzUvNFAxV1hKL3RGUXpOUUc4SU9uMi9uR2cwK3BjN0hwN0dRQTFPRUlWVnN3?=
 =?utf-8?B?UTJ4aVY1S2diN1JLOTMxZXhvN1JFTHlZR0ZFVnJod3JYeTN5aGRQYXk2SXFk?=
 =?utf-8?B?ekpNSTlSR1IwckZ3OFYvWjJqMFIvOXZUSkpmdmdnamlwSzNKUHRBSWROWFhh?=
 =?utf-8?B?MmR6ditJY1dtTlh3aFduWERrMkVIQWZOckUza3M4V09ScFhQbVFmZUR3Sjlw?=
 =?utf-8?B?OUI2cHo2Tk03UVBuYXF4QWNDZk1SV2NqblVrVWFVV3FqUXV5ZUtNcWZJR3l3?=
 =?utf-8?B?eU9RMzlGZ2h1c0krRndDb0hlV0o1MU1lcDREU21CUk0yOEZhSnVTNFd0dnlu?=
 =?utf-8?Q?mKhB0WD2dabz18auOBEmFA3TR3b9dIUaApz9kfn1j+6Rt?=
X-MS-Exchange-AntiSpam-MessageData-1: 2RalFblXZ7BiEQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8eaa40f-7b1b-4f1b-bc46-08decc73d32f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 13:24:57.2359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VP4bTmMgK41SS1xNFPEzUuUHMB+aBjBB3TyLIeSegPiBFUzmgkALgpth5iXV5LXPAhe7uPGyoyYSvHXrIMzrxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
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

The GSP static information is useful during regular driver runtime;
however it is currently obtained from `Gsp::boot`, with no elegant way
to pass it back to the caller.

Solve this by moving the code acquiring it to a dedicated method of
`Gsp` that can be called as soon as the `Gsp` is booted. This allows us
to obtain and display the static information from the `Gpu` constructor,
and to store the static information for later use.

Its location at the end of `Gsp::boot` was a bit out-of-place anyway:
technically, the GSP is considered booted after we have received the
`GspInitDone` message, so anything that happens afterwards is not part
of the boot sequence anymore.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs      | 14 ++++++++++++++
 drivers/gpu/nova-core/gsp.rs      | 14 ++++++++++----
 drivers/gpu/nova-core/gsp/boot.rs |  7 -------
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index acee9a3ab37f..a34114d3afcb 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -23,6 +23,7 @@
     fb::SysmemFlush,
     gsp::{
         self,
+        commands::GetGspStaticInfoReply,
         Gsp,
         GspBootContext, //
     },
@@ -285,6 +286,8 @@ struct GspResources<'gpu> {
 #[pin_data]
 pub(crate) struct Gpu<'gpu> {
     spec: Spec,
+    /// Static GPU information as provided by the GSP.
+    gsp_static_info: GetGspStaticInfoReply,
     /// GSP and its resources.
     #[pin]
     gsp_resources: GspResources<'gpu>,
@@ -365,6 +368,17 @@ pub(crate) fn new(
                     sec2_falcon,
                 })?,
             }),
+
+            gsp_static_info: {
+                // Obtain and display basic GPU information.
+                let info = gsp_resources.gsp.get_static_info(bar)?;
+                match info.gpu_name() {
+                    Ok(name) => dev_info!(pdev, "GPU name: {}\n", name),
+                    Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
+                }
+
+                info
+            }
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 3876208779ad..fb8baf3eed71 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -39,10 +39,12 @@
         Falcon, //
     },
     gpu::Chipset,
-    gsp::cmdq::Cmdq,
-    gsp::fw::{
-        GspArgumentsPadded,
-        LibosMemoryRegionInitArgument, //
+    gsp::{
+        cmdq::Cmdq,
+        fw::{
+            GspArgumentsPadded,
+            LibosMemoryRegionInitArgument, //
+        },
     },
     num,
 };
@@ -208,6 +210,10 @@ pub(crate) fn new(pdev: &pci::Device<device::Bound>) -> impl PinInit<Self, Error
             }))
         })
     }
+
+    pub(crate) fn get_static_info(&self, bar: Bar0<'_>) -> Result<commands::GetGspStaticInfoReply> {
+        self.cmdq.send_command(bar, commands::GetGspStaticInfo)
+    }
 }
 
 /// Opaque bundle required to unload the GSP. Created by [`Gsp::boot`], consumed by [`Gsp::unload`].
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index e380334e937b..bb2000b7a78b 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -142,13 +142,6 @@ pub(crate) fn boot(
         // Wait until GSP is fully initialized.
         commands::wait_gsp_init_done(&self.cmdq)?;
 
-        // Obtain and display basic GPU information.
-        let info = self.cmdq.send_command(bar, commands::GetGspStaticInfo)?;
-        match info.gpu_name() {
-            Ok(name) => dev_info!(pdev, "GPU name: {}\n", name),
-            Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
-        }
-
         Ok(unload_guard.dismiss())
     }
 

-- 
2.54.0

