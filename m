Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5114BCD98EE
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADCD010EE3E;
	Wed, 17 Jun 2026 06:43:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sq066QHP";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8641D10EE44
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 06:43:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3K9RSgDoz4VVjgSoU+FE4pQDNn92DQiX6bkHcEwTf+hDc8LrxfC+1CPRCET5imZKfY4ZXQ9sVaQEviHRTd1eYmyVEc7dvYH0a9LnHW+ykjA9SKODJC02wGoFuR52+nm558TzIEaWGdjOVGpsnniacirxMg4GKDms3NYbtzRT4SILbVMMsQD2Jk+BJk7duOsiOjgFdzBAi+/g64+IMI8dIHr5rGbQs8jtnKhQyvgaxoo7UrdeffoLJAKUzrF5/crUvsT+v6IWq9tPnU/Wg4ZdY/F7LBDOeEIX6Sb/FSLhJAhj1vow/b85VngJQf/PCiNW5rYIuVAM40l6t12/Oy3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CO0h7KzXhzVOIl3YOR0dumxJnPY9NtqsmX6d6r18bT4=;
 b=yMy8m0Vtsc7aGEF3+T3kxIVgvNnRnbQUUeWEdgEd8GjFhbi9qmeJ8VxdIK1l2AARO1cuK7Ssg8fwOBNuLHcCLcJ147fzF3cNwYfAFpKtuVaDFHPt2kSVZdBmCyPVoJnTGNSJDLcEXwytHcwD14Vrp93+cYUI/iC3DTNAJw3l+YBFvFvC2YcWeRQiJrUVMVMJ2vz2h0hXfjG1wRflS+vyCmwgLmExbHqMzrgAm0pYe4I91678q6vcBc60Obz/UQ7vogx2ja5WH/DL/qG0+VKdwjP89PmXYoSKKfn476pepOxv/5q/FXcZrzMhO2Laa090ugngufVqMYdMGgLrj5HaTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CO0h7KzXhzVOIl3YOR0dumxJnPY9NtqsmX6d6r18bT4=;
 b=Sq066QHPxlt+R0wSc0Gw4i948WhWlnS/5+lWEIetUE0gcXMKCAHWnv5oPzGaqxk6m/u1/k4D0HaB43iGSQe+3gS6UouuX3G1vz9eobXToaoY4LCfPm3ODKZzuci1yJ6JONaMUcsO8KVvGPJs05GkU2GbWCGQfwoWq409JyP8VSTp50Zh6vOLYLJOcv/tTE0BBHGX6xBKNjIlDlHQwnaZs5tkhVscPPG8AdgMuMbK+LvR+aOy761KrQo1L4snrvxVxLoalQbjGPCP8yBBjk/wdvG02xWlJkKma5Zm/OelP2U75+BnFbqpXWfh3IbyyWFlhNm1VeIyDudVVZcHei02lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Wed, 17 Jun 2026 06:43:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 06:43:24 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 17 Jun 2026 15:43:12 +0900
Subject: [PATCH v2 2/3] gpu: nova-core: move GPU static information
 acquisition to a GSP method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-boot-vram-v2-2-15c979001c70@nvidia.com>
References: <20260617-boot-vram-v2-0-15c979001c70@nvidia.com>
In-Reply-To: <20260617-boot-vram-v2-0-15c979001c70@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6PR01CA0020.jpnprd01.prod.outlook.com
 (2603:1096:405:3bb::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 76b4f3f0-e49a-4c9f-feb0-08decc3bbac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|10070799003|1800799024|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wDxBQoWsVM89hSdy4jfUBHDloriQU1D8TJuTzCMFDWjJwpgtwlPQFST+oT2IO63jD6srMx9Eu90cK2i+ANoXgewNNfd91yk7vxO6tcc1cDyw08rdeXzP/b6yS77sHgP0LBV+2CWt421om3nX6cEiYxvClUToTfdQTA/O/RVxz+29BBROZkY86YiiEuOAhMzLfElINQRzmI6hypiJZTVcd57jb5hgNFLBrC5myi010mT2bRVZCklH4NX6/Y6EjN5yr2e71NZ5egC2jl8VyuWfn12xOH4mcmevqqHADc+kQY8w3DdYr+mbgBj0mc7craj7uAVjWJYdHD9njBaIaBx5pj9INmul8p6wUMz5qRRFH5so9MBQSjKYxhzHwJPzYiQ9cvgyE3sPGWbrh/Ls7Cl5qu0WCRX/xxljRavKvRYpSGcs+JRbCSv84OXxoJqj9VkWh40QwWzeNJwQYb95GcAsiCY1Ab970YgEO7GKTPQgrCyRBm62x8OY9NGvYBZS7MwRSF9RK30Mqj73TlPco6rIgb9jfJiMi1R9eAFkUtDEN7RdJNx25HomDpng2sbnZhKgXqr2ZpQ58djIufNRDJMkoBnH8vmVdcd9TCnrAwMSOyExXSV/9iILee2Lxv/S7PYj2o+FF/OU5SXL6MM6CgwtWT6EdfSOEmwyoJ9R96D8I5Y4s4tyzI4DAP4zLAD0ceOC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(10070799003)(1800799024)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTZSZmV4aTRGNWcyUXE5WFJJTWg2bHloYUpiOXZpcVhKYUk4c0FXcytUSnBK?=
 =?utf-8?B?Z2lKMFVwZnZlN0htK3c4cGU3eVVvZmJFU0lMMlVFU05yMUNyWGE0MmpVREk1?=
 =?utf-8?B?bStzSkxEcUFvOC84bDlsTTRqc2dVeWJnYjhvdjRWT2t2VXU3YkxHanNzaUNt?=
 =?utf-8?B?L01tY0g1ZHBDZmRjcVpuV0x4aVlSTDJqTjhPUkNxNnJUYSs2ZHFDTUVZT2NM?=
 =?utf-8?B?RkxHR3JCdHptbjF3VVhva3I2eXg1cHlDNEIxeC84TEtDL21MTVIyZHJWSmJv?=
 =?utf-8?B?MXV0V3RPL0xSV2Z1MUN6M3JETEhYc2xFUDJUek95ZDdGNThsSDhLNUVYK1hU?=
 =?utf-8?B?ZWRVUFNoWUtFVnQ0cVZ6VXVjM0EzUk5jZzdaWW5XRXNQT29zVGpGWnY1SjBF?=
 =?utf-8?B?c00wNU5BZVpqTittZWx0b2hZQlNUeGJiTnRDTUNVRVhxS3dqNmRBbEpzcnBK?=
 =?utf-8?B?Z013ZnNwUk56MEJkMHpEaFA2SG1KR3JxRzhoU0JhYlFYbDlLWm9ITzRWK1JB?=
 =?utf-8?B?MitJa3dDRFFlcURubVRDZ3huNmVSWEhTcjg2Q1NiemZ6cHZYSVFXdTd3ZTRv?=
 =?utf-8?B?R1pUWU5Jb3pocDM5clViTDRRVlN6SU01aHVDVUwzakNmaDVWR3F3c2pZQlBu?=
 =?utf-8?B?UFBueFBTQWZYYk1vaWxyME93aEE0K3Y4Z2FXRkh5enZOQUxjRlpiM2djMlU2?=
 =?utf-8?B?Yk1LV2FuWE9iS0FCQ21wc1JTaEs1dGtQb1BIS0tWZE93SmFkNlJpMVdTdjZx?=
 =?utf-8?B?ZHhRaXVFeVZOZElmdTU4M2t0Yy94UURiZUM3cThyYzVYMWhreEhZbUZMUGR6?=
 =?utf-8?B?Z01zWDgxZFhNYVdOZkJUV0FqbXoxeHlPYUs5MnF0SkQwT0Z4UHJTMTcvbjlZ?=
 =?utf-8?B?a2dpSTR0RkZ5M2tscVlLekZVUFIvRUVZdWxNOHR4UDRRd2YzZXltVnROaWtv?=
 =?utf-8?B?akxBNTNrRFZidE44czZlR25vb096WXRHY0J6T1BZMUovREdvLzhsdmcyUGVW?=
 =?utf-8?B?ZEhmaE9uWHVSVXBBWnZjRzExckJQY0NRTkNwRHBmdEVpZUNEWURHOUgybmpL?=
 =?utf-8?B?WXdObDJVb2JqK0FEc2UvSEc4clJFcnU5ZUpQZ3FKaGdqSjhGNHZpaTJ0U0lo?=
 =?utf-8?B?cDBhSENWbXZVblI1YkFGam4xd0F5WlJEcjcvQWNUWWQ4Rlhqbzhlc2V0T1B0?=
 =?utf-8?B?QkgwSEZxYzRMQ1hGM0svMUIza210Rmt2UGRFVGUwU1hnUXpSaGRqWkJxYm1P?=
 =?utf-8?B?clp6ZXYwb2RncVVsdWc0M1BTaTZFVFhmb005cUVESDREMG5rSHN0VGo3VStG?=
 =?utf-8?B?OTVOejkvTXIwUFJuM2tsZURkUWc2S2RRL3c0ZlBGWUtMcXJFdVZ1UmxoWGJN?=
 =?utf-8?B?ZXlFbG80QmtUQ00wWlJxRVVxcno2N0RDa2pEaWZ1S1ZHRlJmeFhNZjJ2TEFx?=
 =?utf-8?B?S003Y0JMTHJQcFlmVEJnUHdzclZ0ZzROSzNuNDF0U1ZjM1ZobTNYd3FneDFl?=
 =?utf-8?B?Uy8rVkp2TVJWb25LL2xCbUhKNGE0SWhoWDhvaWhna3crWVRkOEVaRlhiS3VY?=
 =?utf-8?B?VFpxZllObVRLN2t4V3FBWFdUb3NGbm1QaStYNTI1Ty9RT0V4RGo2bFZEZFBp?=
 =?utf-8?B?V3NFbUE4NDRodlJJRFF1UzY0Z3ZRWFNmWXp2Z1Y4TDlVK2VyZ0dqUlZIYkRo?=
 =?utf-8?B?VUlLOTRTR1VLN05XY25wY2J4TnFkUXB6bmM3dWNhYmM1UzFoMUpjdjA3VEF1?=
 =?utf-8?B?djUybm54MnlreHd3NUJhRUErVTRiaHkvZHBmTG8xa0RURTE1bmJyb0xoM2cr?=
 =?utf-8?B?cldKQjcvNUt6MkJHR3NnM0cydTNiOEwxNTRJdGJvMm92OGF2ZWxCV1FGZmxu?=
 =?utf-8?B?ancxYnBjSHNIV2NyVlc0eEc5ck8xUEp3cDZsR3luNllrYzF4dFBjWnFZUkt0?=
 =?utf-8?B?N21lSTFKaU5wRTVzeXNZdmJ3NHNYS0dTRjB0K3U4ZGpCUWxtNEFpRWlTQXVa?=
 =?utf-8?B?UGJoVGtITlhmbzQ4dzg0Qi83cEtPZUNmeTNqRjdmRHBNYWx4OEFQQlhQQkhP?=
 =?utf-8?B?ZEl4MStCbFA4Nno1ejhYenFCeCszQlU5ZDZWV0V0R1puMUJOeE81T1Fnd3RE?=
 =?utf-8?B?ODJjM2dOd2h1WS9JbUVvRHUrR2lSWmlPajlPaUl3Z25ibnRvQ3pJRklhdXF2?=
 =?utf-8?B?L1RTSURXMlF0bHN1YUo1WEV6bVZPK2RuRzBybHhpbTU4bytMZzdYaklpN3cv?=
 =?utf-8?B?dm5wcFFwOW9GVWtpOEpnSEkrMm1DZEEwQisxck51MTR4MDd3blpBSVZBbEdV?=
 =?utf-8?B?WVd5TjJZZ2VWYjBqckhBdmhucXpjYVlNbUFidTcyT3hkc2cwR3gzbzU1bzhE?=
 =?utf-8?Q?jRv9ZVoUjxw44ZTFkNQIDy4OWlKGKKVvvtjV8EqkCvfpG?=
X-MS-Exchange-AntiSpam-MessageData-1: kR1Gsmb7FyDLDg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76b4f3f0-e49a-4c9f-feb0-08decc3bbac2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 06:43:24.3735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWp48Fdh/hVMCARZwzW0+mkHRda0D68MustCY2DngL0K1avaxjSghi/ZAJMchcX9FjkKmMM1tyH/kGK4tLe6nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
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
 drivers/gpu/nova-core/gsp.rs      | 15 +++++++++++----
 drivers/gpu/nova-core/gsp/boot.rs |  7 -------
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index b5cffcee9817..a02a86f556e7 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -23,6 +23,7 @@
     fb::SysmemFlush,
     gsp::{
         self,
+        commands::GetGspStaticInfoReply,
         Gsp, //
     },
     regs,
@@ -284,6 +285,8 @@ struct GspResources<'gpu> {
 #[pin_data]
 pub(crate) struct Gpu<'gpu> {
     spec: Spec,
+    /// Static GPU information as provided by the GSP.
+    gsp_static_info: GetGspStaticInfoReply,
     /// GSP and its resources.
     #[pin]
     gsp_resources: GspResources<'gpu>,
@@ -358,6 +361,17 @@ pub(crate) fn new(
                 // is properly run in case of failure.
                 unload_bundle: gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)?,
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
index 385b4c09582b..9ba4e0063159 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -32,10 +32,13 @@
 };
 
 use crate::{
-    gsp::cmdq::Cmdq,
-    gsp::fw::{
-        GspArgumentsPadded,
-        LibosMemoryRegionInitArgument, //
+    driver::Bar0,
+    gsp::{
+        cmdq::Cmdq,
+        fw::{
+            GspArgumentsPadded,
+            LibosMemoryRegionInitArgument, //
+        },
     },
     num,
 };
@@ -186,6 +189,10 @@ pub(crate) fn new(pdev: &pci::Device<device::Bound>) -> impl PinInit<Self, Error
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
index 8afb62d689cb..2eef4d1b058d 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -153,13 +153,6 @@ pub(crate) fn boot(
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

