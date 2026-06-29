Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24CBC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A93110E910;
	Mon, 29 Jun 2026 14:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="V5RSNoDG";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A209410E910
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:10:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cskeBL0+ahmhT2ouiR7a7J7jcsnx6rjcEkYdQhoNs44DHVYVY8I6bc34u8XOs3cfGaym7bxkRN6MmbjwmsXO7CZeiYerhVpgLcUrmcsY92m8OkE7vgDV2Fzg1gvV265iXbOhpNdqYrhjG3g0bkkXe8GIjq24bpn88fDyE8N5EKtA/TaE7K7LiIUW31irDmgsSGKIp8mSOd4Lt4BU3KPqZ8gTFdOXazF1ZfoPJGo5Ri1/B/al3f/uAYS6Sn/W+F2a3VZtyB3K79XXWimmX8rGQLYItpHJcSsGrmPzRgfp4STh5+WhcQJaklpU7vsdBByKhhcj9PTIxGSHoSKJM6Yu+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhncTaq8wFcOCSqyJVp9vJFn6JwpAH2W4yE47tkWNhs=;
 b=CQAt2swY0vUyhVpq3QeVFY6RQ0IdEi5dgt94gqlClu4i7joDT/htH6JeIS5JqJoeJOYze0LJ2Rj1qWyy6S9/2wMt6SkQTB4uCW6AVGk9xZzsuf289yRXgOLmlfVA65kwRr+0FMmomM3klpPmUq0mQeS8aMX4YnAtqXOJU0MY9l+ee506JLdyt/zGIkVO32/w2zvsCqfJLaa1FiPWTqy0PP5DYWMsQwG+lTtPL1upNvRDN/Cy4glVUHupIKE/awPZLT0wuELiPH3HHeeLlH571CkwnpJlVt2TB4i/dc/f34vq3NlsUklgkJkirN76A6KY4dbloMs2xdudeQ5hpRUgog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhncTaq8wFcOCSqyJVp9vJFn6JwpAH2W4yE47tkWNhs=;
 b=V5RSNoDG00nv+bmo8a+wltGUF6gsOhXz/vyzqk1Q2Piekz7CVhCGKCzbvTIUCmmiSJqTU1zpx8CrKQCl17jEfyp0JlF30Rngmys3ewwJ9zbRjdxTHLR6Jb3XIdN6OoenRziEVwVug6eKZzBXZmrvEo2FUt45+IyofNei6yQDIcx0sq4dswT9tnpzRa/qxKHw1xESv+P98UYoBrse1THmOFkAmjwu9EpNDhpa1803dcOyx9NpBlr973BgREzN7ik8iiFf83t/x/uoBMSUfViGMv6cOJ/8DN1ZRFLG585iVE6wWuNcUuIW8mn3ClWhHDota4n+aApyVxl+pozkViJ0qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8404.namprd12.prod.outlook.com (2603:10b6:610:12d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:10:39 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:10:39 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 23:09:45 +0900
Subject: [PATCH v4 13/13] gpu: nova-core: store Fsp instance in Gpu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v4-13-5539d8469590@nvidia.com>
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0258.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d96b74-e909-42da-1795-08ded5e83266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|23010399003|3023799007|11063799006|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: tL0IyD8emiwDcTn6xEDeRRoXmUeTfgYHloxXImpDRjPJO7WXOiXpev8JJWpZsDuLOLh7qH3sgrGQHJzUp9txnsjrnO9QYGGqSbO9Hxx+uCWzpTR3saJfjb8q437oHFmOckXd8uuob3EPYguV7VC1LoYaeEFegLoL9cmaVBAnorizJcUecwzdJLn2wwfHTjM5lcOqmvSsYgqroEBypKcQFrEzjW8w0iKGacM0V02YW/sTZ54fqzn/fbRB116I+UgcEn6C+XmmACLJH7991KPWYPgvRGu6DwmXwMK4/5AXWvNeqgEVedsUP51xzgScXVjKjzOdt44u66g4bUnkyvZH1Lzn7UlMd9Opv4UOux6zRo1XYKYSMrOMbS+LZCrOk3e4z5GQ65Ovje4CckaF4+UZBI59aVMUxGMmk9GRAjun8L/HNDu12e5jDfMgRLDtfxkKagSXi1Ro+KK9XAiuwKgexHdOz7iUw3sS45y+JIHC2BxV37S91XQXIwqK5sVmCYf312WqFk0E6yh9fedIiBQ8BnMDzEAlAibpno7HrqPBFC7RE5KX5+8V0WO1kpp9/9zEAODSrAaGGstCQu5l+5m6R2o4lCmY+sNqBBP355jPUFcAOKagB26kqsRKABX7Mp0BzV695BAPks6df1wsJdvIBEJJO5QndjEF0KdYrUv4bOhLLj+x931tU+lhTJUkovUTGLwVVmGsvFN8wCa8AIEj2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(23010399003)(3023799007)(11063799006)(22082099003)(18002099003)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVgwQUp1Z3VFQmkxb3NyMWhKUGpjL3U3bWlYMDlxYUg1UUxqS0luclBvR1Q2?=
 =?utf-8?B?MFFaRWdQd3ZrZ2RJZy8vT1h6TlBRa3gwYXJoenAzcExZYmVYem1ILzRVRHNC?=
 =?utf-8?B?R3JKZVYrd09GdUdGUDhLZDZkWFVPdlRoM2xlTkozZDNvMkFjZUc5c2t4Tlll?=
 =?utf-8?B?SkZncDJJM3Z4a2o3S3NObWxoWWtIeWc4Y0kxR1MyWGZISnIvM2I2RS9vYmMv?=
 =?utf-8?B?T2JNQkIrN0JIaGh0YTY2THNWL2hmR1plVi85SlphNnJRSHdsYUc5Z2hkbzRQ?=
 =?utf-8?B?eUszTnJrd0w5UndTbXpBSlFONjk0ZnFGR0RacWtndmNHK0JjWXFEWHc0RUFh?=
 =?utf-8?B?eXBXY2I4a1FBVU9kQlhvYXVCSGFtcmdmSFcxYk1haG1YdmFvVHJwYU9xcXpR?=
 =?utf-8?B?WjNBNVJ6aVFyM1MrMkdsUExHUTNnVTdNTUJiZjFmOGtRcmJ2WjlHWkVzMzFJ?=
 =?utf-8?B?NGp6L0FoQmxHb3oyYXdzOXJQTHNKdi80WXFWV1djUEN6LytVMW8xU3YzcU5S?=
 =?utf-8?B?NytwaUEyTi9vKzlXK0pNbm8yTE1GNU1rZHYxQUpQMTdYSm1wNXVqTlVCUHNr?=
 =?utf-8?B?ckVNNWJaVndtUTM4Z1lHUmM2MWhvVGNyeEJuSER1Vmg0NW9scTNPcmNia1hx?=
 =?utf-8?B?M25NaTVZelVsVnF6MjRMMjJFZjVESU53NW1VQmJqRytGUTlDVUVOS2ZBSFRn?=
 =?utf-8?B?US9LQTVKZFFjd29MRUQ2MGtSZGJOYys2S3RpeUY0UWEwOUgzK2tlM0R6VmxP?=
 =?utf-8?B?emg3NWdSYThoQ0hYQm1XaFhRT0VBYWdUbG9NV0FtOVJidGlveElhNWdPOHF4?=
 =?utf-8?B?WVZybk1nVURQeko2VVdwS0xJQjhXTC9aN0UzVEM3Rkd3MHFUd1ZwTGR3ZEk3?=
 =?utf-8?B?SGFZWEhzTFo4cDBYb01rYlhwWFpRZXlITUhBS1dKYzBQdFh3VkdWTDdWcStj?=
 =?utf-8?B?NmZmb0gwdkM5WmdmODJ3NGFpS0RQUzNyS3o5cENqWVNWZkQxYUo0N3o5VUFY?=
 =?utf-8?B?R0xFdFlXWUNyYWpWUmhqMlFQZVRkaDJzU0V6MlJtamRyYmsyTW1leGpiTDZt?=
 =?utf-8?B?cEJDS2FDTVBxOG1nb2dubWo1YTFjbUVRSE5TMG40eHFpMGpibE5kUFhhOWxD?=
 =?utf-8?B?S1l4eEQ0SkJNWW5Nbk9RWExQM3FPN2FWRnVCNktkU0RWSDlXYzdJUWR1VVJQ?=
 =?utf-8?B?RUJiT3dKU0FTRms0WkJCQzhZenFOdHR1aHhocFVtMC95VkNiK3NMaDIxb3VV?=
 =?utf-8?B?TXpyT3k4SUVLbHJLRklFTStQOCtEck9GZTRudGpHcUVsaUdiSk04K0xrN3F4?=
 =?utf-8?B?UFhmVWd4SUxKU2NHQytIWmY2UUdhUmRSbFpFcW0xdzJHK1J1clhDTXpDcEV4?=
 =?utf-8?B?UzJHSnpsdndGdDNveUFEdnZrYlB1WEc3ak5KS1RFZkxPeEVySEdCMGVmVDJG?=
 =?utf-8?B?dVhpcTVMY0JmMVNFdjdzYjZTTjlkQXkxTnJnZDZLK05ldlpyc2dCQ0JUcXNq?=
 =?utf-8?B?RlBxdldNbjZoMHBLRy8rZCsvTjhtQWRYWG9RQ2hKWDJHWHIzSkFFRVVPL1d3?=
 =?utf-8?B?T1h1NU5iZ1pGbkFrekhaeWtRenZCdGp0MGxEVzFXdVNxa0syc1BSZGM2WlAz?=
 =?utf-8?B?N2crNHBSTlFMcDFHdFlMTmZNNlRHZFpXZ2YzSjE0K09pcEt6S1FpZ1R4VUZt?=
 =?utf-8?B?S2t2U2NXa1djUGI0blUyRzh6WFhtcU4zZmhCSFl2YmU2VmJVYlU5a2hVM2U0?=
 =?utf-8?B?T2xRNHlSOW54Rm5BcXhuRVlzQ2FkLzNIY3NKT2VZcTFLVG5pQk5uK1l4RStx?=
 =?utf-8?B?NXcxMFZrUDJCOWR1aFVKZGtTR2wyU2ZDcmNnVVowcFBNRDhYUm9IazVFVzZk?=
 =?utf-8?B?QkVyZi8zd202SkQwd3BDVTY0ZmVHTkpvYU8ydC84R1FVTThIUkRpaENIcG9q?=
 =?utf-8?B?NGRwVDluUWpSUjk1MXJycHV2TGdaN1cvS1U4alI5SGxha1NRc1Fiek1ab2R1?=
 =?utf-8?B?RDYvKytuNEZ6TnFwcGZzdlYrRUtGVFdURzVzYnd6MS9PNzhweTZhcWd0OFNx?=
 =?utf-8?B?QWNPZlhXVm85Y2dhcnZvRDhDMU8rMG5paWJJdzJvYllMclArb2lCSkFhQnBO?=
 =?utf-8?B?Q0xzMEJxd1g2VlBxWGhKUEcyNDZRV0dWOXQ0S3Y1dkxkRE8xWTYybC82NXV5?=
 =?utf-8?B?WE1KNkpCUys4ZTV4RmFFUndQd0lDZitNYTRULzZRbnF6aHlSWHowR3JhemhY?=
 =?utf-8?B?K1RlVFJoUC8ybzVVSXBOa3UrOHZhRHVSVTM3eThtTnFBVllpK2ZleWlLSWRU?=
 =?utf-8?B?cExqeTFzSkdZNmNnL2c2OFo4dWNxbDlMUFJRbWxyZkFtS1d6ZnN3NldMT0Nr?=
 =?utf-8?Q?au+D+1kNOqV9O0udYz7nKQL2Hx5YeiwTZASpQOkPNFrML?=
X-MS-Exchange-AntiSpam-MessageData-1: pE4Y8mk35Z5z2w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d96b74-e909-42da-1795-08ded5e83266
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:10:39.0650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fy72O5w9fog8NEeCNxNnxTU+mdUmKqFRDRNql1yKdz/27sPla1k9Y0mhV0m7qJ/biKUyhjNT0SzPP7Vj/OTh/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8404
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

The `Fsp` instance was only used in the Hopper+ boot path, and
consequently built locally (and immediately dropped) in it.

This worked well as a temporary measure, but the FSP is a GPU
sub-device, so its lifetime should match the GPU rather than a single
boot invocation.

It will also be needed in other parts of the driver, for instance vGPU.

Thus, create the `Fsp` instance in the `Gpu` constructor and store it
there, passing it to the GSP boot as a mutable reference using
`GspBootContext`. This makes the `Fsp` available even after the GSP is
booted.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs           | 15 ++++++++++++++-
 drivers/gpu/nova-core/gsp.rs           |  2 ++
 drivers/gpu/nova-core/gsp/hal/gh100.rs |  8 ++------
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 663e61d0c023..c0c0c82e3e39 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -22,11 +22,13 @@
         Falcon, //
     },
     fb::SysmemFlush,
+    fsp::Fsp,
     gsp::{
         self,
         commands::GetGspStaticInfoReply,
         Gsp,
-        GspBootContext, //
+        GspBootContext,
+        GspBootMethod, //
     },
     regs,
 };
@@ -262,6 +264,10 @@ struct GspResources<'gpu> {
     gsp_falcon: Falcon<'gpu, GspFalcon>,
     /// SEC2 falcon instance, used for GSP boot up and cleanup.
     sec2_falcon: Falcon<'gpu, Sec2Falcon>,
+    /// FSP instance, if on an arch that supports it.
+    // TODO: use different resource types for each boot method, and make the relevant Gsp methods
+    // generic against them.
+    fsp: Option<Fsp<'gpu>>,
     /// GSP runtime data.
     #[pin]
     gsp: Gsp,
@@ -305,6 +311,7 @@ fn drop(self: Pin<&mut Self>) {
                     chipset: this.spec.chipset,
                     gsp_falcon: &*this.gsp_falcon,
                     sec2_falcon: &*this.sec2_falcon,
+                    fsp: this.fsp.as_mut(),
                 },
                 bundle,
             )
@@ -356,6 +363,11 @@ pub(crate) fn new(
 
                 sec2_falcon: Falcon::new(dev, spec.chipset, bar)?,
 
+                fsp: match spec.chipset.gsp_boot_method() {
+                    GspBootMethod::Sec2 { .. } => None,
+                    GspBootMethod::Fsp => Some(Fsp::wait_secure_boot(dev, bar, spec.chipset)?),
+                },
+
                 gsp <- Gsp::new(pdev),
 
                 // This member must be initialized last, so the `UnloadBundle` can never be dropped
@@ -367,6 +379,7 @@ pub(crate) fn new(
                     chipset: spec.chipset,
                     gsp_falcon,
                     sec2_falcon,
+                    fsp: fsp.as_mut(),
                 })?,
             }),
 
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index c2d7a557310a..e89366b425fb 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -38,6 +38,7 @@
         sec2::Sec2 as Sec2Falcon,
         Falcon, //
     },
+    fsp::Fsp,
     gpu::{
         Architecture,
         Chipset, //
@@ -67,6 +68,7 @@ pub(crate) struct GspBootContext<'ctx, 'gpu> {
     pub(crate) chipset: Chipset,
     pub(crate) gsp_falcon: &'ctx Falcon<'gpu, GspFalcon>,
     pub(crate) sec2_falcon: &'ctx Falcon<'gpu, Sec2Falcon>,
+    pub(crate) fsp: Option<&'ctx mut Fsp<'gpu>>,
 }
 
 impl<'ctx, 'gpu> GspBootContext<'ctx, 'gpu> {
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 2805a35abb79..de786871c8ec 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -16,10 +16,7 @@
         Falcon, //
     },
     fb::FbLayout,
-    fsp::{
-        FmcBootArgs,
-        Fsp, //
-    },
+    fsp::FmcBootArgs,
     gsp::{
         hal::{
             GspHal,
@@ -142,7 +139,6 @@ fn boot(
         wpr_meta: &Coherent<GspFwWprMeta>,
     ) -> Result<Option<crate::gsp::UnloadBundle>> {
         let dev = ctx.dev();
-        let bar = ctx.bar;
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
 
@@ -150,7 +146,7 @@ fn boot(
             KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
         );
 
-        let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset)?;
+        let fsp = ctx.fsp.as_mut().ok_or(ENODEV)?;
 
         let args = FmcBootArgs::new(
             dev,

-- 
2.54.0

