Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527D7FF8865
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA1E310E591;
	Mon, 27 Apr 2026 06:57:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="NLYN0hob";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013047.outbound.protection.outlook.com
 [40.93.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F6510E5B7
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:57:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mj1nToeEPTUt0tUlnTH2u32mKysAinN++MKMtp8dFa/67y0xOvc1IMIDDv8tQ6iQamZm63DHSNLfUyz70U9PLDIJpZqX9Qtsf6vB8fC8vsaB88IcPfjk3cVElfWXVswlqcOICE0BjwG3fSWhLJgiIDUEx0ru7dXLa54aQyex/d1VLqS9jLejPqb6Uk0TuJYbleEjZbJN+b3QZY2obwGzM4FwNPyUZoBXE694PITZTcWJMboSa8te30dn0VY37R1Pi+e7gjTZKizMXVEEOCMcvgd1+qTg2fk3IHlEhVQIoZChHkMAv/G4dCUvAJNx1RXAIVARRNl8HgUugufrUljMLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTW4I3G2hezY3K8lHikPTG8O/zFpIaT8JO5A27Q6BOg=;
 b=BcYMweaHAA3N1nvZPWrVJCGB/WuXtklHUO2swEFO8q7I1kIJP95jIs0ud+9wr8FspXvfxhbp4WLkhRns1bCFHFtUCfclfhyisXdDB1hyyQREALQk+Yq7BNVa5APNtSJpsc8JgpL2ixXVpBY6vgUbtq/IJaOjJ0xMLDx7UgoEQV19bX7mdNtmQ0R/0cWPztqKR8+zhdGjf86RfhdnFKMUp5zLVaSyEHEtmTP49vjDK4rcq5Yj8OBp4t3T7NVlwVBNQenVLkYfj7perZdKIS1htNr1z7XxHe8G+FuLAMc4PjRkU/jLpoL00BNZFIMMYu2hAXQYrSYH8jkDzr1s8dtoyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTW4I3G2hezY3K8lHikPTG8O/zFpIaT8JO5A27Q6BOg=;
 b=NLYN0hobqHazLnYhQaZI/Fg2BNwBgKunlkMZFHIxH4jixmdYPoURjrsoQR6ZMDjPgahgEa7VtA7rmpd0tXLAiAgH3JHNTlogiGxozjez9r+KuFmpaSKrTSqjxJ7S8dp/r2bHfKgF6DE6FaDSz+C26GUiZ0iqhGcPwEXgFyRXxM00yphNdZ7BR+Jf7ugprRqa5Mwey/b3BWc2xL4+BWcPX4W/+BLIR95V/ULMneLZPt52OBzHwsgifQ3zWFMFWeWODNcfM+48LS2mPaGYXnOqqoTUn+Nj/f0JbT4ahla1TWnlcnoIYPNEgNG21bA7bsW2vTcqXQjLtj5u2viLSSrzRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 06:57:21 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 06:57:21 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 27 Apr 2026 15:57:01 +0900
Subject: [PATCH v4 4/8] gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP
 command upon unloading
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-nova-unload-v4-4-e145ccddae66@nvidia.com>
References: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
In-Reply-To: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0037.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d144899-b082-4eff-6723-08dea42a3a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4Tx0YW1gk0ucgrS4TPQmom10iEoTjT8J5relQQ+jBMPoRPgqZtE8rxYzOtSerMzxzM2GVfCDEEN5i/bRcyhQNVF7zrbgi3I07eh4iIovfpxB8vw2E1p2jWMjiqS5YBsmyYDDXcBvDPwYi+27aBIqkrCYD0n5Cy/ilu7k88++X43piG5kr+eEHkPiQvzOWBc8mjpvoHPbVEPBlkcuCl0/P3I+/Pvr00ZH0Ri4N3uaNr4RtPmilbl3Oxr8OVBpaa4cbf9VHvtVelTHdBJTA4tjbV2STpkBwuotwc4iNSw+MmrpjRsu18ZF2pQNeNJVxcPdvX+MhfLmkV0o9qrwvWJAw/AZO9BbrTgdZAL4lUlXDhyJEQK4YO5UOjWYX6X4M4z0gkmxB3p6eBkkiGwpoeG4EBNllGMVt2qRU+5AWUnj4xbjPXxMIgk9PWGS0QyEWmykG4Q4fGWsewpSEfCpzlYTT+sBqyXqL84GY/CFjsUdat8SZ3N8OXQ4YRiUZcHhz0+nQszMZe0SzhUhaxk8ogSxktK0xVMJ5w1SDIofgAwh3gMk3wKuFZTahq6fVAfmZslGNFxImbusjg6j3Re0alBO2jYCik1DsGG571t1m6yjtg4mu2QR6jFF1toe907I2TBzj6Ot/1LZJENgbciQSgFzt7nzLng2l3wAx4YMPkm4FUk4DP0TWGZdaO4VntA8xe7/sur9K5gCV7reWA6Vm8jFRNM1Ck8InhnlT4W7uxHhYYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTZqUzYwclNoMnl3U0txUmRYRVpTNTFlbURidDJJRW1yUVd6akNYZkczQ2k5?=
 =?utf-8?B?UitmUWFzRE10S25tVWtnVDlwOWVuVUtZQWhBMDdybWpudldvSmVlci8vb2pJ?=
 =?utf-8?B?NFFmdDNmNEZjV0YrcTNwQWg3SWVlS3RydkJ1OUM2TzZibjBLSUVacm1kTWpz?=
 =?utf-8?B?eFByYnFld1RzSDZGMXhrTWxVNk5vazgwREVCckRnSXptUW9MbUMvNVV2ZC9i?=
 =?utf-8?B?MjJOUG4wdjIxaS9HZkZoaDlJRG92VmluN0R1NlVwZDVNcUNORVhaM1pOQ00w?=
 =?utf-8?B?TzlTUkZTci9JNTZrRTUwSFFjU1BJQVNPU3IyMmg5dmY5U2xacS9lampnMFZW?=
 =?utf-8?B?WkVOcXdwOU81RjR0Q1NQZGZBcFlDMG81OFh6SHoyazVFVWtsWWJvNFl1ZkxO?=
 =?utf-8?B?NHc3TjhINUZpTjI3TUQra2tyWDFyQzZUZDd4K0pRMlhoYkdBYUZ1SlVHcy9G?=
 =?utf-8?B?c09taVRjeFlMTTRGUWlkaWFmSjdnV3J6dkNBRnBkS0R2YTRnejhTYTZiREFv?=
 =?utf-8?B?WUlSOHNPdmREZksxdGZEbVhsUGZRTkp4Wmp1TThVZGhzWGJMZmVUTjVGQnFC?=
 =?utf-8?B?eTRVaFNIRkc2TlYyU0YrK21RYy9pL2I2ZVl0N2NoYW9ZNi9yOUsyQmxkQkFn?=
 =?utf-8?B?LytjR0xPZzZudDBnZW1iK2tCcXhaUlhDV01mN01ZUENFcHdjUitBWHZIdnZY?=
 =?utf-8?B?N3REZXBNSUpuL0cza0ExWmxyMkJTZFMzelFEV3M3cHk5ZXg2RzFLTWR4dG85?=
 =?utf-8?B?U2xXY1M1alpsQU4xY000V2grOEVFMXpmTGNhdmk3a1FTTUhFOWg4cXZ0WlFs?=
 =?utf-8?B?eHNYa01vaUN6SjdwU3RoK2F6SFZWNGtwL0RUMTVvUStTbGx5ZVR1M1ZFcGxk?=
 =?utf-8?B?ajlvMzR6cXN1Qkh5aGZ6K2pIVG83Ry9tSUcydmxyekRGYlZDckFIbThkQ3lG?=
 =?utf-8?B?dHBhVFdEc2dSL2ZCR2psai91MU9qSkorRGRBdS91V3QvNkVlVHJmTHVlN3Rk?=
 =?utf-8?B?aFIzL05YSjN3c3JxRzVnM1lGbjB2ZUdEQUIxNEdKS284VzQxLzhyVm5OVEpY?=
 =?utf-8?B?Sk1vWCt2MFQ3ZG01UFBndVdvalhGZ0RmUUo2KzhYQW9xMEpmR1N2bnFKc1pC?=
 =?utf-8?B?U3JMeXRDN1ZVQUo2VzFKTEpGUWlEeDZRTnQ1Vk8vR1lPQkdyeTBaZUxzYVA2?=
 =?utf-8?B?S2JEUDNiY3piTXdnNHduRlpYVFhjUkI1SC96cGswbklKOEhxQVE5cjgyenFM?=
 =?utf-8?B?TUhnOXhNR1dxazA3LytocVl5UExSSy9ZUHZIaWQzRkwrYlJmUzB2V2kwdmJM?=
 =?utf-8?B?UGU0VHR6Rnk4NmN1VVhhMTlFZENjRlBDZjdDVy84ZGszUCtjSlcraDNCM3ll?=
 =?utf-8?B?bHY5VHYxVFpyTlNWYXFyTkZvR0l1Qjl5bnVRWmJSWE0zVm0rSkR1WDdnMC80?=
 =?utf-8?B?N1RQTkc5TTE5SU9Gc1hIdEdzTHdpeU5UdnBJYTRReFpra1FMZzQ1ajViZUh1?=
 =?utf-8?B?Y0tZSmRlazhLN3lwYXcyRzhreitaalJVTWNKQXloWmVZdWs1a01STVhqOTN0?=
 =?utf-8?B?V3AvRFU0S2VXVHZ0ZXJnSmUvUVRCVWdOTGExblR4MXJ6bGZBck1RTktoQ2w2?=
 =?utf-8?B?SGRRdHJHZDhzM0hoWmlaREFkQlZON09uMTNPYzkxRTE0QUVYamlEUWVTRWlR?=
 =?utf-8?B?enhVeTRlSGluZkpCZjdpWkpOZ1cvU1BuaERSeE1FYWk5THZjdkMzYTlDakxT?=
 =?utf-8?B?YURDMkVRNXAwUTc4dGprU2JtejhiYmo2YklXaHZlWVVHd3BEcldPZEpZWmVX?=
 =?utf-8?B?T3BmVVlQK3AwaDFZSVFiN2ZzV25DblJDK05iUldwU0pCSHh2R2VhZGQxVVNS?=
 =?utf-8?B?Ui84R05KeEwzK1FYWWhhMW4ySjRyaVpEbHluWVZoblJ3Ui9ER0Q3ZlR5WTBj?=
 =?utf-8?B?SGpaR1lCZXg1UFc5YUdnc1dWUzZpMXhvSFBvOTJMeFRBQ2pRdTlkNUI3TWFk?=
 =?utf-8?B?SUZ0L3FmN2VIZldyZUQ4cW13SXljM3NKL0RFUVZpbHlLSnlNekNRZnRVQ0dt?=
 =?utf-8?B?d0hDaVVlNm4vdW91NkVZbWdKLzhkZVRCN005anRuckk0eVNnb0hRYmswSXJV?=
 =?utf-8?B?aHYyeWF0ZFlkaTVqWDIwUTM1ZnoxUFhXR0lsSXc5VlpXWWFjZGMxQzNqaFpS?=
 =?utf-8?B?MnU0STV5dWVrcEYvWEtrZEF4ejVXbkZibEFnbWFzRHZxMDJYcTdhNE5lY2hQ?=
 =?utf-8?B?a255aTNJUXZrbFV3UHhwNTEyYXcxM29Dcjg3NkpIYnN5Wk5lbTJZOGtLMXhq?=
 =?utf-8?B?RlJUcjhpYlRBOGZVbzJnK3RIN01FK2xxVllxRW1qb0wydnI5QWZWcTJpeXht?=
 =?utf-8?Q?xY28zVBnGZkDT8SEqMADL9hsHmuUQGreKzyBnunaY8Jb4?=
X-MS-Exchange-AntiSpam-MessageData-1: +LTx4KbbXRgSqQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d144899-b082-4eff-6723-08dea42a3a5e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 06:57:20.9247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/Ebcmb5rYjWXhqiW5LFHi6g1FJDk6EM+CgSaziGFt9daR37lU5RHe/mvbSSS8faFhVJx334PyNFhHTJEUZo4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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

Currently, the GSP is left running after the driver is unbound. This is
not great for several reasons, notably that it can still access shared
memory areas that the kernel will now reclaim (especially problematic on
setups without an IOMMU).

Fix this by sending the `UNLOADING_GUEST_DRIVER` GSP command when
unbinding. This stops the GSP and lets us proceed with the rest of the
unbind sequence in a later patch.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs                      | 10 ++++++
 drivers/gpu/nova-core/gsp/boot.rs                 | 44 +++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/commands.rs             | 43 ++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs                   |  4 +++
 drivers/gpu/nova-core/gsp/fw/commands.rs          | 44 +++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs | 11 ++++++
 6 files changed, 156 insertions(+)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 920783362251..1dd25c93a67e 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -317,6 +317,9 @@ pub(crate) fn new<'a>(
 
     /// Called when the corresponding [`Device`](device::Device) is unbound.
     ///
+    /// Prepares the GPU for unbinding by shutting down the GSP and unregistering the sysmem flush
+    /// memory page.
+    ///
     /// Note: This method must only be called from `Driver::unbind`.
     pub(crate) fn unbind(&self, dev: &device::Device<device::Core>) {
         let Ok(bar) = self.bar.access(dev) else {
@@ -324,6 +327,13 @@ pub(crate) fn unbind(&self, dev: &device::Device<device::Core>) {
             return;
         };
 
+        // Do not return upon error as the sysmem flush page must be unregistered in any case.
+        let _ = self
+            .gsp
+            .unload(dev, bar, &self.gsp_falcon)
+            .inspect_err(|e| dev_err!(dev, "failed to unload GSP: {:?}\n", e));
+
+        // Unregister the sysmem flush page before the driver data is dropped.
         self.sysmem_flush.unregister(bar);
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index e838d61bef50..d39da38c8918 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use kernel::{
+    bits,
     device,
     dma::Coherent,
     io::poll::read_poll_timeout,
@@ -36,6 +37,7 @@
         Chipset, //
     },
     gsp::{
+        cmdq::Cmdq,
         commands,
         sequencer::{
             GspSequencer,
@@ -251,4 +253,46 @@ pub(crate) fn boot(
 
         Ok(())
     }
+
+    /// Shut down the GSP and wait until it is offline.
+    fn shutdown_gsp(
+        cmdq: &Cmdq,
+        bar: &Bar0,
+        gsp_falcon: &Falcon<Gsp>,
+        mode: commands::PowerStateLevel,
+    ) -> Result<()> {
+        // Command to shut the GSP down.
+        cmdq.send_command(bar, commands::UnloadingGuestDriver::new(mode))?;
+
+        // Wait until GSP signals it is suspended.
+        const LIBOS_INTERRUPT_PROCESSOR_SUSPENDED: u32 = bits::bit_u32(31);
+        read_poll_timeout(
+            || Ok(gsp_falcon.read_mailbox0(bar)),
+            |&mb0| mb0 & LIBOS_INTERRUPT_PROCESSOR_SUSPENDED != 0,
+            Delta::from_millis(10),
+            Delta::from_secs(5),
+        )
+        .map(|_| ())
+    }
+
+    /// Attempts to unload the GSP firmware.
+    ///
+    /// This stops all activity on the GSP.
+    pub(crate) fn unload(
+        &self,
+        dev: &device::Device<device::Bound>,
+        bar: &Bar0,
+        gsp_falcon: &Falcon<Gsp>,
+    ) -> Result {
+        // Shut down the GSP.
+        Self::shutdown_gsp(
+            &self.cmdq,
+            bar,
+            gsp_falcon,
+            commands::PowerStateLevel::Level0,
+        )
+        .inspect_err(|e| dev_err!(dev, "Unload guest driver failed: {:?}\n", e))?;
+
+        Ok(())
+    }
 }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 484aeb7dfd39..8cb0ebdc0d06 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -231,3 +231,46 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
             .map_err(GpuNameError::InvalidUtf8)
     }
 }
+
+pub(crate) use fw::commands::PowerStateLevel;
+
+/// The `UnloadingGuestDriver` command, used to shut down the GSP.
+///
+/// Only used within the `gsp` module.
+pub(super) struct UnloadingGuestDriver {
+    level: PowerStateLevel,
+}
+
+impl UnloadingGuestDriver {
+    /// Creates a new `UnloadingGuestDriver` command for the given [`PowerStateLevel`].
+    pub(super) fn new(level: PowerStateLevel) -> Self {
+        Self { level }
+    }
+}
+
+impl CommandToGsp for UnloadingGuestDriver {
+    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
+    type Command = fw::commands::UnloadingGuestDriver;
+    type Reply = UnloadingGuestDriverReply;
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        fw::commands::UnloadingGuestDriver::new(self.level)
+    }
+}
+
+/// The reply from the GSP to the [`UnloadingGuestDriver`] command.
+pub(super) struct UnloadingGuestDriverReply;
+
+impl MessageFromGsp for UnloadingGuestDriverReply {
+    const FUNCTION: MsgFunction = MsgFunction::UnloadingGuestDriver;
+    type InitError = Infallible;
+    type Message = ();
+
+    fn read(
+        _msg: &Self::Message,
+        _sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
+    ) -> Result<Self, Self::InitError> {
+        Ok(UnloadingGuestDriverReply)
+    }
+}
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 3245793bbe42..33c9f5860771 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -279,6 +279,7 @@ pub(crate) enum MsgFunction {
     Nop = bindings::NV_VGPU_MSG_FUNCTION_NOP,
     SetGuestSystemInfo = bindings::NV_VGPU_MSG_FUNCTION_SET_GUEST_SYSTEM_INFO,
     SetRegistry = bindings::NV_VGPU_MSG_FUNCTION_SET_REGISTRY,
+    UnloadingGuestDriver = bindings::NV_VGPU_MSG_FUNCTION_UNLOADING_GUEST_DRIVER,
 
     // Event codes
     GspInitDone = bindings::NV_VGPU_MSG_EVENT_GSP_INIT_DONE,
@@ -323,6 +324,9 @@ fn try_from(value: u32) -> Result<MsgFunction> {
                 Ok(MsgFunction::SetGuestSystemInfo)
             }
             bindings::NV_VGPU_MSG_FUNCTION_SET_REGISTRY => Ok(MsgFunction::SetRegistry),
+            bindings::NV_VGPU_MSG_FUNCTION_UNLOADING_GUEST_DRIVER => {
+                Ok(MsgFunction::UnloadingGuestDriver)
+            }
 
             // Event codes
             bindings::NV_VGPU_MSG_EVENT_GSP_INIT_DONE => Ok(MsgFunction::GspInitDone),
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index db46276430be..e0f1cd92681c 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -129,3 +129,47 @@ unsafe impl AsBytes for GspStaticConfigInfo {}
 // SAFETY: This struct only contains integer types for which all bit patterns
 // are valid.
 unsafe impl FromBytes for GspStaticConfigInfo {}
+
+/// Power level requested to the [`UnloadingGuestDriver`] command.
+#[derive(Clone, Copy, Debug, PartialEq, Eq)]
+#[repr(u32)]
+#[expect(unused)]
+pub(crate) enum PowerStateLevel {
+    /// Full unload.
+    Level0 = bindings::NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_0,
+    /// S3 (suspend to RAM).
+    Level3 = bindings::NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_3,
+    /// Hibernate (suspend to disk).
+    Level7 = bindings::NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_7,
+}
+
+impl PowerStateLevel {
+    /// Returns `true` if this state represents a power management transition, i.e. some GPU state
+    /// must survive it (as opposed to a full unload).
+    pub(crate) fn is_power_transition(self) -> bool {
+        self != PowerStateLevel::Level0
+    }
+}
+
+/// Payload of the `UnloadingGuestDriver` command and message.
+#[repr(transparent)]
+#[derive(Clone, Copy, Debug, Zeroable)]
+pub(crate) struct UnloadingGuestDriver(bindings::rpc_unloading_guest_driver_v1F_07);
+
+impl UnloadingGuestDriver {
+    pub(crate) fn new(level: PowerStateLevel) -> Self {
+        Self(bindings::rpc_unloading_guest_driver_v1F_07 {
+            bInPMTransition: u8::from(level.is_power_transition()),
+            bGc6Entering: 0,
+            newLevel: level as u32,
+            ..Zeroable::zeroed()
+        })
+    }
+}
+
+// SAFETY: Padding is explicit and will not contain uninitialized data.
+unsafe impl AsBytes for UnloadingGuestDriver {}
+
+// SAFETY: This struct only contains integer types for which all bit patterns
+// are valid.
+unsafe impl FromBytes for UnloadingGuestDriver {}
diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
index 334e8be5fde8..f82ed097b283 100644
--- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
@@ -30,6 +30,9 @@ fn fmt(&self, fmt: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
         fmt.write_str("__IncompleteArrayField")
     }
 }
+pub const NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_0: u32 = 0;
+pub const NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_3: u32 = 3;
+pub const NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_7: u32 = 7;
 pub const NV_VGPU_MSG_SIGNATURE_VALID: u32 = 1129337430;
 pub const GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS2: u32 = 0;
 pub const GSP_FW_HEAP_PARAM_OS_SIZE_LIBOS3_BAREMETAL: u32 = 23068672;
@@ -880,6 +883,14 @@ fn default() -> Self {
     }
 }
 #[repr(C)]
+#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+pub struct rpc_unloading_guest_driver_v1F_07 {
+    pub bInPMTransition: u8_,
+    pub bGc6Entering: u8_,
+    pub __bindgen_padding_0: [u8; 2usize],
+    pub newLevel: u32_,
+}
+#[repr(C)]
 #[derive(Debug, Default, MaybeZeroable)]
 pub struct rpc_run_cpu_sequencer_v17_00 {
     pub bufferSizeDWord: u32_,

-- 
2.54.0

