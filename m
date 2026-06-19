Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD3BCD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83EE910F5FA;
	Fri, 19 Jun 2026 13:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="W7WLVy/Z";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C3910F5FA
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 13:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpSmzKQ3/XOhu4SeNTpSPqrNVlVcbLzvILM66Akdc2lj/UqAnXHQxpYQvKrzslProuqUdOVgMnufwLMvLTHWeYQjwhwoN+Re0aGeASiKP9PdGy9quoV7NA2TmFuaPoBpW4tfUI94atu1xZC5rvoxdfwr8CPOAUv2dAA6NPjsbdmMSJo7TOad3d9sBx9zSrkD7AWSRMvtgla+2AXt4a+h3c2pjO370FkVdTo9lRY+eR/jIDBgK8olOXwNdaSVh3ZSZfWAuO0LXxZGvtH9HuyMxMmVTUMe3+67XFlVgnqJfrAQEW0SkdkaSjXs538LAgBslPEZMkePxdsw2ZxltqLZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atVGstqD88V623iEovnpEjVcGpX5B+GJ3YrgYyU+2oE=;
 b=l7uDrYIFoXFmqWthxIWIo1Uap9TzzgQ0GPxyQRt1rtUOuoEo2DLKEQwjSbM+uyqeasjiaq2ClDhwrxWqLaTFCOCi38UNgi0GQU3m0ZQ2MHqw/wWGX42pjZFjgQ+uV5gBo5zJ39C/9WbEjSNB+8Jv/uJjnGY8NxCOGFWOCZf56D3FcIhF7bhAxFk6ApSdvgW8lufaFvGgZed2asJTix3mHZtXoBHMdEQHR78LxXU2gPc5fzXAUvswiYBTdxuYR8LUhapvyamtMLhdvMSt5aLF0Ougw+cXl+OC5MrI1ATaXGGLFxl9SRY4NeyruJJNAtXuZzPqOEB9IrkYRTSKWJRn6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atVGstqD88V623iEovnpEjVcGpX5B+GJ3YrgYyU+2oE=;
 b=W7WLVy/ZW9tWr4E7JLl1tE9JdAk5jBDfeUbrnqokBU1N3TKc4T9yNgH0WO8GuTmMGm+p2VNQHQSFpH9S1UDY2+dmdFqtowE0zGPkz72H6AT4zPqPBs/TWUzlAdy7UHYTebQopnK126FA7/pwvggEC2KBaGV6FCDHEN5RkBegh8mBDUYPA/YpWZqR27TZMvbJXJmbdrpWOcQPCA7BIBrtpc/kmQHry4ZVIno5SC6xzK0BMZvV1E0VEJkHCgqBXAUZznl9iEBkgHNeflBDHeXjCFr0MQoH7ZnF29tGAxWeWuKPr+rrHJl/V3HYGMlK5yd0GC4NXz9p7KY4/lXBw9CANg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 13:42:40 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 13:42:40 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 19 Jun 2026 22:42:18 +0900
Subject: [PATCH 3/6] gpu: nova-core: gsp: move boot code into local closure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-nova-bootcontext-v1-3-45193cd0a2e5@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5bf90a-138f-4731-c6f9-08dece08a1a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|1800799024|366016|11063799006|56012099006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 9bTWh6KQngLF03GIMZdsOpY4sbmtIk/Z93Wo4OM5+Zs0iOcgz0HJIMRVW22XndCvS9JwoAfYO7jICSJqUNriVcQYpjpybVXEAza7rJfJZJ5BKI7Fz29ZDc56m/4tGjUSDd4ktWQAm5xGyerF9uhOs6q4US36p4QccQWoPLfCBvAxZnbcAzafxDUCGuZXdf5PW17XgQ0HYNT8x3h0mQIc/xVGcGq9vUjMqdqVwIJP2CcHCgz52wCMVks1SUT+lAoFT3v0CqQ2iIkmceNmTMvZxIGzhx6NFYc3IM8rDG7XRND+R+iJnm6SrP6iBfSiKjFz7zOAiedir2Lfz9G2xMscjmRDBH2rHMqS6zaiTmRqnmk41vGQJUBXRvFMSB5yt7gvgrIg1hzxAwNh+09OOzRmB9/ytiC4UfpOtVBQMLOYn0OYw7JNsbRCJ5IhguVBCXFBtQblXW/yzO7VFY1/j6ETW3SDYwzanbqcirvbO12rFivJs5sjfB9pIn1lRqDMCzp4wogSR6z6zURP3EhhhGjeOuYCb7pYpDmA0ep6snzxw+sv++D0Lnabqklhd+1HHfC8J6djn0pYoh5lP0Mr7UuqmUbsyUH7tFRnSbEWgWI2V6BIHR8D3R4wNoX68VNvUFX+YtAQUv/Bq9goZ4DVgFJnEbFbevFjNfXEbeZE4ff/Dbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmU2QmpkQzN4aVJLQTFDVVRyNy9QQWNpbkZSZEIrSm45ZVJYaGtZVk1pa0Jh?=
 =?utf-8?B?c1VGdmRqeCsrR3hhcnJrTU9yT1pPZTlMM0lDZFRQenRHaERGUXRmaVZUSGlR?=
 =?utf-8?B?THcwT0hhM2dGMnM5NnhTTGpXRzV3ajQyZzAxTmRLSzZpMW5nRGo4dXB6MWh6?=
 =?utf-8?B?YUxPbU5xOUU3c2lVMHhPanVrNnpsSlY1K0hsQVU3V0xKQVVWV216VEh4S3o2?=
 =?utf-8?B?WEwvT1AyYVJhcHdWdlJVWFNXQ3R1L1o4cFNpL2VOUkwyMzlkNUJCWTNmQWRu?=
 =?utf-8?B?WmRsNjNTRFFsQWhKUGNEWnM5MzRBUzlrc2ZDVlc4dWowaHkwVWpnV3pjTnhL?=
 =?utf-8?B?YWpONk9EVGxEWjNKSG1pZStoRXpaYVl2RXd6cFAvRjg3MWZGV1JSZVByUkRu?=
 =?utf-8?B?U0xjNU9MYUw5WjREL00yaC84bmhXUk1MSHMrUW9HT0pRMjJTMXB6a01NT1lQ?=
 =?utf-8?B?akVqYkdLWHcxakdVeHY4V0JpNVovZEd4TTU4ekhwcE9obS9aMmZRTFJoUDVI?=
 =?utf-8?B?bzhaeVlGTXRqV0F2NXgzN0ZJd05sdzJMK2s4emR5NklIV3FjaVlSWEpFUDdS?=
 =?utf-8?B?dVRqN2orSWpXb0d5anZqWmdJZzNjeTErNWxHTG9NTXFoMGNQQkxTUnFLd2hG?=
 =?utf-8?B?Z05rc3RlOEZyamUxc2YwM0Z5MU11WC9CQjZhYXNtZEVNeE82bTg1ak1Kazlp?=
 =?utf-8?B?UUxmNWpneEREcXZnVGFIZWdhai9ib3BOZkJNKzFRdWxiZE45aEFzc3Z3OEQr?=
 =?utf-8?B?UGRua0FGdDhuWkFieWt6eDUvYk1FTk03RG5qejdWRVRsZ3FSRm9vZjcxYzBu?=
 =?utf-8?B?Z20rdkczM01RNTdsdGdpL3JGMVRLV2hmZWFxUVpRT3hNVFo5NXdnUzVrUmhj?=
 =?utf-8?B?MXZKcHo5dXNHeHZ6QlhYd202UThBN2toZXNyb2FZRTQ3QjlueEVWMnVHZWxp?=
 =?utf-8?B?MUF5TlA2VUVyaG9GcC8vV2J5aTYrUFlNa0R4bFlEcmMxK0tzZEsrY0tyYXVH?=
 =?utf-8?B?SEgyWnRyS1VkTUovTHBTVGVjTXhpUVBLYzlDOWlmNXVURW1TY1ZGbjV4MnR5?=
 =?utf-8?B?NVA4aXA2STg1Mjc4b1NFUFFoZUx5SDg0dFllNXJjWjVEQ1JkSHptRklhVkh5?=
 =?utf-8?B?ZkVmdWdrdXlkSklaR1pweTNVcWI1eDc2Qmd4QXBMZ0tsb2IweHlWaUZpR0NU?=
 =?utf-8?B?UTlvYUx1UmZQeHRWL3pMdnBJVnpsbVBvZkxQckRWRHRrZDMvcXRoNGI1bEZa?=
 =?utf-8?B?eE1nYXUwOGFCNktyNDltcUxmUDRtVjJYS2UvUWhRbFYzdkpDZ3I4UHBUUTJp?=
 =?utf-8?B?Zm9nQjM3M2JrRmJlcDdvQ21VSnZmUmdlSlBuVGZkcndmdmlFOXIycTQ1RHdm?=
 =?utf-8?B?RnBMcGlOY0htaldJcnFpdS9xYWtmSkhGMitoWDMySzE5TUEySUpPdG5CemFo?=
 =?utf-8?B?OExvK1V2NUZJVmp0L0VXZW5udCtxU0U0MDhjYVZXcG9QUjRkNGJmYlFBQ1cx?=
 =?utf-8?B?OStoWWV1MkcwSWJMeitXbUNhaVhHOE9oc0ZTcU1vTm1jSjZpeHlGMUFmMXRK?=
 =?utf-8?B?MDVBbHRWSDFuZzdlSnB0YzF6a3RlazYwMmZ1VW9teDFTQjVpNU9SSzUybmRs?=
 =?utf-8?B?d29pcHdFSmxQZ0d6NnU5dmZCejBHR29HV3h0dzV1VnU3alZyWWVPektvR1VT?=
 =?utf-8?B?ZmdIM3dNUFJYQ081Y21CajAyMHdYdnJPNFFNcUNOYjFES0JDOHc5ZUdabEti?=
 =?utf-8?B?TzZxaU8rMjJnQkltTGlNWjNOdUoxeHFZWkVweVVCbndoOEVMZmNyK0ZqSGZO?=
 =?utf-8?B?V2RDWkdCc25NRWVoWDhVTXIyYkZiQmRFTUYrSWhoOWRIdWRvc0QrbGV0T2x0?=
 =?utf-8?B?MDhuV0JKZXpSZnd4cGNSakZncWUzUjV0Q015S0pObTQ4ZFZBeDVjRHpubzNv?=
 =?utf-8?B?Rk1ITEVQSDIzNnBRditMelAvRnl1K3pzUTUxb1BTdy9paEZXam9QM2E0UXFJ?=
 =?utf-8?B?WW90TmdENG5kZlViWFhtd0dKWFBOdko1c2gxWWZJWDRyU3R0dFNOYVZXT2NK?=
 =?utf-8?B?TDIzNy8wdi9ERXo1OUNjNWF4VTNIcG5NWHpOa0dFYkxiVk5LQ1RSWG8zS2FS?=
 =?utf-8?B?TVZnbXFlR3E5VGtVR1pMMFpXVGZkTXkwbzRUdURJQzFlQlRqYm9CNTlPN2VL?=
 =?utf-8?B?WmVVYldDTG5vaGdaQVRsY3NmdUg3U2M1MjZPK01nVkJmeWttRDJybWtEMjhm?=
 =?utf-8?B?M2tVbGh4UDJIQ0oxLzlVMHZJTXFYTmdVRHJCSzZNZ1lvMVppTWE5Qjl3amor?=
 =?utf-8?B?aW9TUTJnanB5djdzZ3Q4RGQxcmFQc2RxS0VKTGJocjRpbUFUY3FJeDNFZEpv?=
 =?utf-8?Q?d5oVl1Orb9OJ6quX8Hb/GaQQ91zH57AX0mo7mPwd+s3Xp?=
X-MS-Exchange-AntiSpam-MessageData-1: BCk6rih2yjIoAg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5bf90a-138f-4731-c6f9-08dece08a1a4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:42:40.3427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aS1SBMu/gJwhOHvi+dky8Hx8lznFTWGVD7SHQHPMrvBSg2SSIB9dA79GECytQlqLzrEXh0lDCVurGb4HSAJHuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450
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

The next patch aims at replacing the cumbersome `BootUnloadGuard` with a
more local and less intrusive mechanism to run the GSP unload sequence
upon GSP boot failure. Doing so requires running the boot code in a
local closure, which changes its indentation and would make other
changes difficult to track in the diff. Thus, this preparatory patch
moves said boot code into a local closure that is run upon construction,
so the next patch does not need to re-indent code that changes.

This is a mechanical preparatory patch to make the next patch easier to
read. No functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs      | 42 ++++++++-------
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 40 +++++++-------
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 96 ++++++++++++++++++----------------
 3 files changed, 96 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index bb2000b7a78b..9eccfd634b61 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -119,30 +119,36 @@ pub(crate) fn boot(
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
         let unload_guard = hal.boot(&self, &ctx, &fb_layout, &wpr_meta)?;
+        // Run from a closure so we can retrieve the result, and run the unload sequence of the GSP
+        // in case of error.
+        let res = (|| {
+            gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
 
-        gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
+            // Poll for RISC-V to become active before continuing.
+            read_poll_timeout(
+                || Ok(gsp_falcon.is_riscv_active(bar)),
+                |val: &bool| *val,
+                Delta::from_millis(10),
+                Delta::from_secs(5),
+            )?;
 
-        // Poll for RISC-V to become active before continuing.
-        read_poll_timeout(
-            || Ok(gsp_falcon.is_riscv_active(bar)),
-            |val: &bool| *val,
-            Delta::from_millis(10),
-            Delta::from_secs(5),
-        )?;
+            dev_dbg!(pdev, "RISC-V active? {}\n", gsp_falcon.is_riscv_active(bar),);
 
-        dev_dbg!(pdev, "RISC-V active? {}\n", gsp_falcon.is_riscv_active(bar),);
+            self.cmdq
+                .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev, chipset))?;
+            self.cmdq
+                .send_command_no_wait(bar, commands::SetRegistry::new())?;
 
-        self.cmdq
-            .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev, chipset))?;
-        self.cmdq
-            .send_command_no_wait(bar, commands::SetRegistry::new())?;
+            hal.post_boot(&self, &ctx, &gsp_fw)?;
 
-        hal.post_boot(&self, &ctx, &gsp_fw)?;
+            // Wait until GSP is fully initialized.
+            commands::wait_gsp_init_done(&self.cmdq)
+        })();
 
-        // Wait until GSP is fully initialized.
-        commands::wait_gsp_init_done(&self.cmdq)?;
-
-        Ok(unload_guard.dismiss())
+        match res {
+            Err(e) => Err(e),
+            Ok(()) => Ok(unload_guard.dismiss()),
+        }
     }
 
     /// Shut down the GSP and wait until it is offline.
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index c9fdc8cacedc..46e03f34bc74 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -162,31 +162,35 @@ fn boot<'a>(
         let gsp_falcon = ctx.gsp_falcon;
         let sec2_falcon = ctx.sec2_falcon;
 
-        let fsp_fw = FspFirmware::new(dev, chipset, FIRMWARE_VERSION)?;
+        let res = (|| {
+            let fsp_fw = FspFirmware::new(dev, chipset, FIRMWARE_VERSION)?;
 
-        let unload_bundle = crate::gsp::UnloadBundle(
-            KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
-        );
+            let unload_bundle = crate::gsp::UnloadBundle(
+                KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
+            );
 
-        // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
-        let unload_guard =
-            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, Some(unload_bundle));
+            // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
+            let unload_guard =
+                BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, Some(unload_bundle));
 
-        let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset, fsp_fw)?;
+            let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset, fsp_fw)?;
 
-        let args = FmcBootArgs::new(
-            dev,
-            chipset,
-            wpr_meta.dma_handle(),
-            gsp.libos.dma_handle(),
-            false,
-        )?;
+            let args = FmcBootArgs::new(
+                dev,
+                chipset,
+                wpr_meta.dma_handle(),
+                gsp.libos.dma_handle(),
+                false,
+            )?;
 
-        fsp.boot_fmc(dev, bar, fb_layout, &args)?;
+            fsp.boot_fmc(dev, bar, fb_layout, &args)?;
 
-        wait_for_gsp_lockdown_release(dev, bar, gsp_falcon, args.boot_params_dma_handle())?;
+            wait_for_gsp_lockdown_release(dev, bar, gsp_falcon, args.boot_params_dma_handle())?;
 
-        Ok(unload_guard)
+            Ok(unload_guard)
+        })();
+
+        res
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 6ed4ee268086..9b24361f924b 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -277,59 +277,63 @@ fn boot<'a>(
         let gsp_falcon = ctx.gsp_falcon;
         let sec2_falcon = ctx.sec2_falcon;
 
-        let bios = Vbios::new(dev, bar)?;
+        let res = (|| {
+            let bios = Vbios::new(dev, bar)?;
 
-        // Try and prepare the unload bundle.
-        //
-        // If the unload bundle creation fails, the GPU will need to be reset before the driver can
-        // be probed again.
-        let unload_bundle =
-            Sec2UnloadBundle::build(dev, bar, chipset, &bios, gsp_falcon, sec2_falcon)
-                .inspect_err(|e| {
-                    dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e);
-                    dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
-                    dev_warn!(
-                        dev,
-                        "The GPU will need to be reset before the driver can bind again.\n"
-                    );
-                })
-                .ok()
-                .map(crate::gsp::UnloadBundle);
+            // Try and prepare the unload bundle.
+            //
+            // If the unload bundle creation fails, the GPU will need to be reset before the driver
+            // can be probed again.
+            let unload_bundle =
+                Sec2UnloadBundle::build(dev, bar, chipset, &bios, gsp_falcon, sec2_falcon)
+                    .inspect_err(|e| {
+                        dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e);
+                        dev_warn!(dev, "The GSP won't be able to unload properly on unbind.\n");
+                        dev_warn!(
+                            dev,
+                            "The GPU will need to be reset before the driver can bind again.\n"
+                        );
+                    })
+                    .ok()
+                    .map(crate::gsp::UnloadBundle);
 
-        // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
-        let unload_guard =
-            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, unload_bundle);
+            // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
+            let unload_guard =
+                BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, unload_bundle);
 
-        // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
-        if !fb_layout.frts.is_empty() {
-            run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
-        }
+            // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
+            if !fb_layout.frts.is_empty() {
+                run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout)?;
+            }
 
-        gsp_falcon.reset(bar)?;
-        let libos_handle = gsp.libos.dma_handle();
-        let (mbox0, mbox1) = gsp_falcon.boot(
-            bar,
-            Some(libos_handle as u32),
-            Some((libos_handle >> 32) as u32),
-        )?;
-        dev_dbg!(dev, "GSP MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
+            gsp_falcon.reset(bar)?;
+            let libos_handle = gsp.libos.dma_handle();
+            let (mbox0, mbox1) = gsp_falcon.boot(
+                bar,
+                Some(libos_handle as u32),
+                Some((libos_handle >> 32) as u32),
+            )?;
+            dev_dbg!(dev, "GSP MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
 
-        dev_dbg!(
-            dev,
-            "Using SEC2 to load and run the booter_load firmware...\n"
-        );
+            dev_dbg!(
+                dev,
+                "Using SEC2 to load and run the booter_load firmware...\n"
+            );
 
-        BooterFirmware::new(
-            dev,
-            BooterKind::Loader,
-            chipset,
-            FIRMWARE_VERSION,
-            sec2_falcon,
-            bar,
-        )?
-        .run(dev, bar, sec2_falcon, wpr_meta)?;
+            BooterFirmware::new(
+                dev,
+                BooterKind::Loader,
+                chipset,
+                FIRMWARE_VERSION,
+                sec2_falcon,
+                bar,
+            )?
+            .run(dev, bar, sec2_falcon, wpr_meta)?;
 
-        Ok(unload_guard)
+            Ok(unload_guard)
+        })();
+
+        res
     }
 
     fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {

-- 
2.54.0

