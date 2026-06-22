Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0E5CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1907E10E4E1;
	Mon, 22 Jun 2026 07:11:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="IYooUes2";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAA2010E4EE
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPSC2z9o6xW0VRT3NRtGEwREssCrXBHM76OPox4kslmUSP3m+wVe/8bCMQEeJD6UGFHYEkyttmgRTTbTjSoJQ9faY31G9jZ7PIqM9fzuCA0gheO6eKNyjMUIq/Kp7Uf7vVaOVaFLg/Qw2r8eVUgMUvlmC9SmZ4lLEqwok1AgamyxmzSQhCbyubu0kHvIjj8tj7/sJDzunllf4C1DpLM8mPu/33Ri/4cS9xD6grCcTuJZsEHlTKDtESPFKLsKg48zrFvdVxZp7fmr4+bN8E4QRTf9iUMZMuL4/YAtuzfXHvxEoKL5TIwCD3eQHJWS2kejfjhmB7XZHtBefZJc7MF1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DsNf91Lyu49qaDbykvVp+UyjDhA5m4VqBvS+Jml4rQ=;
 b=suWZlbwIBMzLWfMonqezDxc4/d6uO8o8wsYToEM2hst3o+ERU25law9Mpfx4dKbOBStyyoWs+u8bolFzPRoOiN++F777Xj9KZuM1hiiz+nohq4tGQP+hl8bFw66oHb4zt8rMIByhZcmz+UiWRRHDBM16UwisYnxNXh0yNGUvUclXTy+2O2EABbrTLwujysyhgI+oBVxGmcgwFQAjSLIV3pVAjB3by72ZqS123EB8QBWrgaSf/v2gf9RvHLBitbCvFjluRlC5VE7xugcGfaFT9wMARFLo3wmH/dvySq2dke+PVsRbHDNeFYJnGBvUDyeTnZsdGQ27jJQiqvXN0LT4DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DsNf91Lyu49qaDbykvVp+UyjDhA5m4VqBvS+Jml4rQ=;
 b=IYooUes2PlTbPQBTCmLj8IyQyBij6Gu91rle8HKyaF1XJrKZSHJ5gYT74gfw3QlDQIaEqbHeCKFJPAC0nIJN5LGLPfXu2WeU9hlpHHLIQ2Hu7i3Y+N24gZ8AwYph9WxYrwXBOXFpJRwVKfbkYga3K2MmREakbsVYBfP3FnzK+S2MPXb5wxNnjqieasRbloHMGmBnq2nfQQPtipe2/J/U6vqewfRGwXmtRGNSQyGbexvi/vDq5ytJlSCKdy4vAGwXuXUCdpiwXcj7J+kFXMKrx8Z6tzjmMIfvrH7QHcwuD9zj02JxPVy6joFEzsLH52pa4EH/FzE03Ys0SiFIqqg2PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 07:11:47 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:11:47 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 22 Jun 2026 16:10:29 +0900
Subject: [PATCH v2 07/13] gpu: nova-core: gsp: fold TU102 unload bundle
 construction into HAL method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-nova-bootcontext-v2-7-0ddeafc06f5d@nvidia.com>
References: <20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com>
In-Reply-To: <20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com>
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
X-ClientProxiedBy: TYCPR01CA0135.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::15) To BY5PR12MB3986.namprd12.prod.outlook.com
 (2603:10b6:a03:195::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: ba615582-60af-4ff9-4a76-08ded02d8553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10070799003|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: X+BUXSnmIun9S1fc3PNfK1YAw4oiMQcZVIT7SQ2OVfu5MU5XTe/2R44errM9bjg3MtArl/MBbPoiIs/EjmTb6VprkWiDVMxa80RGaRIr56Vfd36ffB7la6A3/xW5cqVFvfFx4v9fxUA1C8MhHlZtX4VewA1olmRsygQPaEnVZtbsucWOGxm5rlWob2orx7RlJ+yOj7TR9pBYKAZ4YcH/mjgsMxWIqTN1bCJW5h056ssYStuXxYP128TEPwq5iKJP6gPuylrGEuopAbTGZy1PDquD/VBnENNqs9rrEh9CbLpLd4LnF/03gTEV7cXmfjM9jlfB9TGMuIYjEti2FE78yR46zJVMJC7K4Ci1YixNl31jH3lyBaKVvYQxj6L+PW3AMTzI6zI1aM99yGgdVE38jfrBkWVbS3Vev4+cLFSLJQUR13kkF8Q2TmtbPDOGkoklRPuVpTXBkPuTkGLpjewuCwqB0zFrjeMUIU1uj9T7d3WwHr3o2pMRiXgK+v5W4HuprQyLIMAwleUpRepQ0nDR93adfa6if7GGE3At2nu2AaEf5KZwQybkWW7tOzx2r8qnCi4jAHw7oKW+3DunSYT99RfuDeiMpk0UfiLn0Xvv7Jam20tDqJpqbmWq6PJempkxmKfP/PaBLbFWDIvtK0EUVt7biLrXfJ5FR2Ja+wYr78Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmUrVERPZmRWZXJyRXRKdi9QMDJRRWVCUHp4dlcwdGxsZ2NIMHpacitSaWVm?=
 =?utf-8?B?MWxOQzFLcHMvcGpZakRxd1M0L2Y5SE9PdEtnU1UxL0tldzI5ZVhqRndEZlhw?=
 =?utf-8?B?R05yekQ2cVNoaGlUT080M0NQcUNlWEowSmZJMzlhakZEZVc3YUMyTi9HaWdu?=
 =?utf-8?B?WjRicCtXTmFva3NkWS9kbm5BS2laWTdTUUpUTGZGcW53U3lkTGZzc20zdVRG?=
 =?utf-8?B?ZURUN0dFSjgyd3hBTUhsSVdsUXBkUDI3eUJRdkFneFV4OUNYTm1yS3JDS01r?=
 =?utf-8?B?d01wMkR2T1hxYUpSRWV2TE1lN1o5UXprY1Y5U1pzNTNkd0twRlFtckhMZisy?=
 =?utf-8?B?RmNaZ0xZNXE3SnRLZGdKaVN3cFl3czNrNklsMkFTeGJyRnNUbzB1cnZJMDFx?=
 =?utf-8?B?azlFMUZpbTREbG05S1RiZmRvTm8zRDVPaHBEQ3E4N3BReWxNQWdnYTFVcEY1?=
 =?utf-8?B?Snp4K1kxUXJibXRNWE9kTkppTmxyZ2lJMStmUHNZdnhaRFdjcTBpNzhRcTlh?=
 =?utf-8?B?QnlXWXR6MHdidUMwajJWL0tGK2pDR21SOFVnb0MvZkswZGdqQWNFSHlJZ1lx?=
 =?utf-8?B?NGNsMENiZURYbmQrbXoxWFZyZXpiMkNUdVBnU2YzVkJUblBJUFkvdWdoaUhm?=
 =?utf-8?B?OENadlZZRUVVVjUyN2tPeVVpeGI5Ykl1aFZiZkdmZHpkaTFGNDZnb3gvNnc5?=
 =?utf-8?B?aXNDTWZvTGx5dUNuMCs2OXNDWmkvQnViRmNEUWtCOFFxTjdJQ05Yems5Z21t?=
 =?utf-8?B?QzBCSjdlemdxUlEyMUlzZldMbTJTdHZJSGt0NERIaWtpZWF1THF4NlJYdGV5?=
 =?utf-8?B?RnhESWZWZ2pQcmtkOVlhYkxSWTAxQjcyRHNJVFhZa25pdDVFSS9WT0VCR1Vu?=
 =?utf-8?B?cDFwYlg4clVRM3dOcDBJQXMrNUNub2lUb3J3VnZCT3dtdXlBTVpWZDlYdHI2?=
 =?utf-8?B?S2lHdWtRNWZxbTV4TnJFSGR5YXc3VCtOQkRRRC9BNFJkeUVYaWNvUHNnaGVt?=
 =?utf-8?B?K3p4YlJGSTFLd0E5bXpDQm1QS1RYUXdLVVdsa0pQc3dpU2lBazZUV1lYd2pp?=
 =?utf-8?B?ajRtMFZZRHpGWWptUTZmc08zLzFjUGFFVDlicTRIYmp2VGZLay83bSthTGNI?=
 =?utf-8?B?c1l0UElvME5hK25ycVUyeXEzQ1daVG9JYjREM2lRSEdEV21haWh3VjRiOVd2?=
 =?utf-8?B?Tjd0dE5wV0Z1RTJOV3cxZGRoa0NCNDZla0cwbzRZa0dKZlNzMHNrZVdGTisv?=
 =?utf-8?B?Nzhodzk4MFdJMjJiYXpJWjcvZ083WE5lQkJJTStWV1ZoVUdrL25IUnJwR3Jr?=
 =?utf-8?B?bWd5ZXIrQ3lheFkvVjAxUjRDNklNakJOLzVqSSs5UUdyR0tZa0NqN0JmS1Bn?=
 =?utf-8?B?TVUxeFhJd20ycFNLMGxIendIUnN0amRpOXhxUFRvd1ZmbzBoRDdpeGhtVHkx?=
 =?utf-8?B?Um5QQldZVlcxQk1kUmtXZGFOWVRJa0lRWU1tUEJEWnRaeWppNzd6dUxDV2FU?=
 =?utf-8?B?RGVqMXFhL0Rrek93Q1R2Ty9HZ2RFYmJIVi91cWpWd253VTVPckcwUURoWHNM?=
 =?utf-8?B?eHErUUgvSW1UellGUXIwZ3dnd3QzWnIrZTh6TFgycWhkRVREMyt4SFZhNHlv?=
 =?utf-8?B?b3Z0cHNUN0RtWGU3RDRNcnhxbUcvanU3bnVLN1NVQ3BBdXNhZTBNUzdCQ2lw?=
 =?utf-8?B?cmQ3dTdvQXhKMlpiNU5YVHp5a1lsUC9NZnhmd3ZsS2NRc2dRZUMzdkxrd084?=
 =?utf-8?B?ZG9mZVNTRGNRZGpVMGJwUFhxRm9oV0kyQzRkS0trekl2VVJWcHRZKzRIcFdS?=
 =?utf-8?B?NDR0b3RxdFUxeDRxdVVBOWhhbkMydGdiMWxJRVBXSkFIN1h1ZkFsTUZyRW02?=
 =?utf-8?B?ZnY5ZWptQWpHdlExNU1KTmxlRDZoajl4THFWY0pYMnNHV25ZY3oyaHhxWjZV?=
 =?utf-8?B?VlFzWm9jUWE3dUR4dkd6YzlRVXl0OFZGZlU0REZnT01iQWsyUkx0YzdHT1VW?=
 =?utf-8?B?czFLNUs1ZHUxbndseWxRdFl6VFZGU1VBcWVmRFhQdjhkdlBsRUV5dzh1ay9a?=
 =?utf-8?B?bi9WbnNBK3JzRG8yOFRabHd6dE1PZk1BbGVoTDViTys3cHFtUEpERUhIbko0?=
 =?utf-8?B?NGkrOG9wY3JZMVFsZ2UvUTltOVhnWjBtOUsxQm1SZkVzM1BkZGpwTHV1RG5T?=
 =?utf-8?B?VXVCL3BUdFdab2JxN3hEbFdnMGVZeTcwSGJJUVhOSXpIcUdKRHV4SThPSkc0?=
 =?utf-8?B?TnV4S2c2czcwUHA0WjhlV1lXSU92TWMrMDl5SDBNWXJLOWNsS3puQ3dzK1VM?=
 =?utf-8?B?QjlzRi9FNkFuRWhBQjNkYjVwN29qUDA1MzluWUY0RG04RHNpQkF1czY4a0ZF?=
 =?utf-8?Q?OcfCksC+py9hqSS3jAh0vu0NzyzRz7qHRXncleT84zbXd?=
X-MS-Exchange-AntiSpam-MessageData-1: m55pZ6vJT5yiFg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba615582-60af-4ff9-4a76-08ded02d8553
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3986.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:11:47.2382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MrkS0N4B4KdPABjXOth5Fi0GC6RvlnvXn7snyxxsZIjgG6uJO38JX+Xf1ancfKQ05xLGB2KvlppzBhDYlZl3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
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

The construction of the unload bundle is currently a bit convoluted and
could be done in one function instead of two.

Additionally, turn that function into a method of `Tu102`. A following
patch will turn the "use FWSEC bootloader" property into a flag of the
TU102 HAL itself, and making this a method will allow the code to access
it instead of querying `Chipset`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 90 ++++++++++++++++------------------
 1 file changed, 42 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 7cb322b0e31d..230145146540 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -55,23 +55,6 @@ enum FwsecUnloadFirmware {
 }
 
 impl FwsecUnloadFirmware {
-    /// Loads the FWSEC SB firmware, as well as its bootloader if `chipset` requires it.
-    fn new(
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        chipset: Chipset,
-        bios: &Vbios,
-        gsp_falcon: &Falcon<GspEngine>,
-    ) -> Result<Self> {
-        let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bar, bios, FwsecCommand::Sb)?;
-
-        Ok(if chipset.needs_fwsec_bootloader() {
-            Self::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset)?)
-        } else {
-            Self::WithoutBl(fwsec_sb)
-        })
-    }
-
     /// Runs the FWSEC SB firmware.
     fn run(
         &self,
@@ -93,35 +76,6 @@ struct Sec2UnloadBundle {
     booter_unloader: BooterFirmware,
 }
 
-impl Sec2UnloadBundle {
-    /// Load and prepare the resources required to properly reset the GSP after it has been stopped.
-    fn build(
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        chipset: Chipset,
-        bios: &Vbios,
-        gsp_falcon: &Falcon<GspEngine>,
-        sec2_falcon: &Falcon<Sec2>,
-    ) -> Result<KBox<dyn UnloadBundle>> {
-        KBox::new(
-            Self {
-                fwsec_sb: FwsecUnloadFirmware::new(dev, bar, chipset, bios, gsp_falcon)?,
-                booter_unloader: BooterFirmware::new(
-                    dev,
-                    BooterKind::Unloader,
-                    chipset,
-                    FIRMWARE_VERSION,
-                    sec2_falcon,
-                    bar,
-                )?,
-            },
-            GFP_KERNEL,
-        )
-        .map(|b| b as KBox<dyn UnloadBundle>)
-        .map_err(Into::into)
-    }
-}
-
 impl UnloadBundle for Sec2UnloadBundle {
     fn run(&self, ctx: &GspBootContext<'_>) -> Result {
         let dev = ctx.dev();
@@ -260,6 +214,47 @@ fn run_fwsec_frts(
 
 struct Tu102;
 
+impl Tu102 {
+    /// Load and prepare the resources required to properly reset the GSP after it has been stopped.
+    fn build_unload_bundle(
+        &self,
+        dev: &device::Device<device::Bound>,
+        bar: Bar0<'_>,
+        chipset: Chipset,
+        bios: &Vbios,
+        gsp_falcon: &Falcon<GspEngine>,
+        sec2_falcon: &Falcon<Sec2>,
+    ) -> Result<crate::gsp::UnloadBundle> {
+        // Load the FWSEC SB firmware, as well as its bootloader if required.
+        let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bar, bios, FwsecCommand::Sb).and_then(
+            |fwsec_sb| {
+                Ok(if chipset.needs_fwsec_bootloader() {
+                    FwsecUnloadFirmware::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset)?)
+                } else {
+                    FwsecUnloadFirmware::WithoutBl(fwsec_sb)
+                })
+            },
+        )?;
+
+        KBox::new(
+            Sec2UnloadBundle {
+                fwsec_sb,
+                booter_unloader: BooterFirmware::new(
+                    dev,
+                    BooterKind::Unloader,
+                    chipset,
+                    FIRMWARE_VERSION,
+                    sec2_falcon,
+                    bar,
+                )?,
+            },
+            GFP_KERNEL,
+        )
+        .map(|b| crate::gsp::UnloadBundle(b))
+        .map_err(Into::into)
+    }
+}
+
 impl GspHal for Tu102 {
     fn boot(
         &self,
@@ -284,8 +279,7 @@ fn boot(
             // If the unload bundle creation fails, the GPU will need to be reset before the driver
             // can be probed again.
             unload_bundle =
-                Sec2UnloadBundle::build(dev, bar, chipset, &bios, gsp_falcon, sec2_falcon)
-                    .map(crate::gsp::UnloadBundle);
+                self.build_unload_bundle(dev, bar, chipset, &bios, gsp_falcon, sec2_falcon);
 
             // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
             if !fb_layout.frts.is_empty() {

-- 
2.54.0

