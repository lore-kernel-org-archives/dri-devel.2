Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5BCCD98EE
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C69A10EE46;
	Wed, 17 Jun 2026 06:43:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GTAMMNGK";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4851810EE24
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 06:43:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihLaOFpMd5zkMruLg+zxAeKBfDgDVDJF28LXPXBICWPTKkywPiGzdBrVlhFBRQPXB/bkjfSLajMQRXL4jhsZJ9FB1i9W8AmREXhwndXiFkYLfYBCGZJBtNyr56xd4IP5sUADtTGh+39z4X/L0OZVOZD5zvc9S1hWsUI8+UC/ph5wEctGy/4aobhzNrSTd7xgU/D/2UzUv+7suVq/KvsQBmCZDHvSMJE5/+M8DiOf2DquGxYTAv00uh+hYYzgpayr9klPL83sVnHGlHXiCYE3knYDpxVSWOsfRgg2LP7z54xPtq36bETJHoPePLtQNVOAQIRyTnDf06eto3C6F5vG+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CjLlbPu/RAqooVLXWxSP3n8sJSOpwKb2YxGApPuQFg=;
 b=ptAJ3VtP9D4hxAml178vCI+pbkpS9tW9wcLv3PCDl02AJd2zOcvLtFDgPXV4s3J+j2KCAz/FprNY6R5uFQwildlPtqfmMMYyz/I6xTnv2QTSZN0JEvNXLDTojtaBxUxYZbyxYaD5rY2T3YFpRCDXfrrIS4DJOYzh1/t58/8XLMW9mquSK9Os+/yRqt4lAHq42+baQoS34NJEkwV/Pqc64U7d523fYpG0XPwgPNIRrOBAjsUGcPTgq6qVLnDjo58nyf3Rhz0nS2f4wgpvM5MmbApaIIMulmMHxU42LynlUl52zrubGzrty4+e35X2mIUWqHRDDZ5dmOQ0r+G1isDMaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CjLlbPu/RAqooVLXWxSP3n8sJSOpwKb2YxGApPuQFg=;
 b=GTAMMNGKUvaVxaUUDJtCxMxoEYrlULNHuU4+boXsdL+k06vW4ep4559oNJD3si1Mm/jMIuwnbyN4lcPsb8I6nDJ3M4ePV3rw+GtJ2f0gzJO+Qx3GEe0sJtZQ3CwZwte5E//WD5xMu8XaQEDIoYcZjXaCn/nKLzz2n9PGWevS9+E36EYe5iRrw2Wg+6mo9VymI/ZAi20edYwG2OT0EYoyJ9WUBpQfZeS4KLe+/EoGvi/YlqnV7PI7y/kdZhgf0nhACt7i635wW2uZugLWtDtSVt5tawYHvrOyNuNblrhi0vC7GpIK6KrRH3e8ZxUzhN5aifMaXg9Fl6O3z8F5qO9rgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Wed, 17 Jun 2026 06:43:20 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 06:43:20 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 17 Jun 2026 15:43:11 +0900
Subject: [PATCH v2 1/3] gpu: nova-core: move GSP unload state to a pinned
 Gpu subobject
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-boot-vram-v2-1-15c979001c70@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0021.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a43882-bef6-4a23-feeb-08decc3bb857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|10070799003|1800799024|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: StwPAAFQlO9f8e4LQoikYVtKgxfEvyHQAOdNiZdedP8XrFPuqnxM5A8iSAwo02U756X2bBYC2GW5m4Ep+jIfRSYc5bwWcrHz9umgccp2CM19aoS73NhgCkuOyVP0ctDctsoUZNORR/1qVTfkmqQ8R53lLiLmy4TpetMk2Xagkh88zdRIdZDcXqzWtH9lyrIynYmj6CS+TsCOK+YbO4oxSNPqjek29xPCjW3crOStIVeFPm+IaJVHUVQXokBNrf3Z4ZVRYfKwhxlycpgK50oE2VQDBPCmuVYIT5L2NfsetyaF5Cj0rdzOEKai5qsaFM+7CL7QPUhzIRLOFaCI96HpR4dF1NREbqO9H10Zja/0BCteIG7X+B0UN8O3AV4IlrPww5SnayH4M6Axv0nJwXJQb1mIqEvy+Lc7QqEvz6/IbfV43MHSFooAg1CNvQpfNz1Fp07XbsQIbS7iyfJsGSxYoKcG1056vHLrOWespULYn8O/RdpvVoRLhO1OQ+ZronqlcSNCortcacFU6eXwUeer0EBN4WDp8SiB/sV5F0leSPhAmaz2uv1TAhRzkwnD0G7CTvpJeBdnxRvD3/8++WJ11laOUJQS2HixMvtAqdzkJrmA8DC+vWnpTW5cuN4lQh4Ud0QUhSKK4Dt49LeqwTflK1BZ/O1Y4UcPRic+0cxZPCv4/1H6hJMb/1Bww4q3vJC+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(10070799003)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTVlZUh3U3JiaTJFaER2bFJMWlpFdDM2c2doVzFHeXhiUE9oY2FzSjVIeklT?=
 =?utf-8?B?TVErSlhyV0gxdFFuU1ZlbHEzZyt6WlREQUJ5TEZ5aEJPbFNvcjNLZkhxQ0xR?=
 =?utf-8?B?UkE0OU1lOUVTSXRTa2ZjU0Ewd0xLVkIxMTJDQTRwY1lQb0RPZUw2RnlJYmNE?=
 =?utf-8?B?bGdQdVBtYmc2UWlldnZHNnBRYVkwMWFiOG1hekRKSTM1VGdKSE0vTFNMUG5l?=
 =?utf-8?B?b0pXdmcyS28yL2VVakw3c3pJMDJucFAxeUs4NStRQXJBeGQxcGFYTHFnZU1r?=
 =?utf-8?B?aDZpTGlJbDNSWE1HTStuVDJFb0c5eXRzUG9uNlRLUHNPTzBuUzM1R1pQNDZl?=
 =?utf-8?B?UHpRR29lWTJkWlBzUjhFYTY4SU5lSEhPczNCaHpvdHNPZHNHTXd3UjNlR0Ir?=
 =?utf-8?B?bWphVjNQMkJSOXRWbW05MlZhMWQ3V3R0dmM3RHBWS0RWV2NtclFxR3lmTS9F?=
 =?utf-8?B?NCticlI4dUtQUmh0djhwR0xEVEcwY0VkRVl3MUtUUUVYbm5wT3o5RzBSN2Iv?=
 =?utf-8?B?Z0ZkR2NWR3FFT04rQ1EvOU45dWlwZG15czJ1V3ZOeXpxV1pPeFBGU3U2MjRF?=
 =?utf-8?B?aG91dFlEK3Awc3JMRHd3TFJpSW9wVjczTStzYkhFelQ5WFYwNU40ZjV2RXpj?=
 =?utf-8?B?RW42aS9mZlh6QmVJTm5LRGNZU29wR2UwWFNMcVhrRGF6SVBqaWxMcXRObVNC?=
 =?utf-8?B?Z083MFRGRHRjS3FCbG05TW1wOCtqNm5vblU3dHFxRjdldDdiSjltU2Q2cDFZ?=
 =?utf-8?B?RG5lVzdYZlltU1E3enc2QXBzNmYxSFFoTGcvZ0Y3VEpCRS8raEU1REd0MXdp?=
 =?utf-8?B?cldYakxKYzlyaHFBRGY2VlM4UFYwU01zTGh0c1I0d1VOSGRqZ3dmM2FSYlpU?=
 =?utf-8?B?L1JRZ29ydkNNaW5ibitBdE5DR1U4MDR6T2xHTkZyS1JPbzVoK2d6L1UzclJj?=
 =?utf-8?B?U1lRK005MC9NNm9WRUhwQUtENjEyYkJnRW5QeUhTOW0rSlM3TU5PZ2hIYXB4?=
 =?utf-8?B?TTZ4VUdpRFNqNXhkUnQrbGtlbGdxTGp1dC9TZTFmSjRWZ3BkZ3ZlNlBONXda?=
 =?utf-8?B?ZzFXa2RYaXZpMXp3QzdlRUtBQTRHNW9UK0hWKzlDRlBLZGdDTTRuR1hOd1Y4?=
 =?utf-8?B?dTcrRXJ4SDVTQ3hOd3N1VlYwQmtkaEZmdGJyVG5LWTVGb3FOazNJY1h0ekx2?=
 =?utf-8?B?dm4vdmdaTEI4M1dXbHplS3NIcGVLUTNJY1IwNlE3MXBwanhmZWRzVmYrZGRC?=
 =?utf-8?B?R0ZzQTgrMWxFVlNJU1JlQkF0YzdZMC9SMXAxaDJEbi9GZVlLNW0rQ2IvRmox?=
 =?utf-8?B?eVlZYkV3eWoyTGxhazV4aWg5VzlBYVk4UUpDNEN4SS9CL2lmbWNsaVBxdWhq?=
 =?utf-8?B?ZkRVSko0bGpIN0d3ay80Nk5hU1hndXVwcVI5VmhJOUg3aWtwVWRjMHg1U0Vn?=
 =?utf-8?B?M1hyT0RqelA5WHFCaVl1SERpZy9obTdrbExQMW9TTndSSzYyQkFuMEUyck14?=
 =?utf-8?B?Vmk4WmtEeWI5ZUJsdFZITVp4dmRXYWZPWEJXc2dPWncveWlpTEFrcjdKSmdO?=
 =?utf-8?B?YndTb1g2Ti9WajFkc3RkeFRJVWZZQTUyd21UeE9ZUkdkM3UzUXJvYjJMaWNo?=
 =?utf-8?B?MGVLdWRZcW5BY1JuRkp4QlcrU3ltdnhMT0drbWdPMmhhU3BwRmZ2eDBYOEs2?=
 =?utf-8?B?a2daREhoYTNQRlZ0bHlIeFExMkE2V1Fnb3ZtVVM2SUJDM1VldEgvUXQ1di8y?=
 =?utf-8?B?V0VyZkdQcmszdHdZdUpENmJTajdXdkVhK3RoRUhMU3FkQmxrY3I3MG9IMi9p?=
 =?utf-8?B?azBndEo3RTR6akV0WTMxRXJBUHlCUDlaZU11a0dSVXlnTEljYmFNS1BWMXZn?=
 =?utf-8?B?bUtUc2w5WU5mZmU3cis3c2dvc014V3czenRBVXptWHVwTUdLMFN1ZnpiVmRE?=
 =?utf-8?B?WFhGbCt1L2diRUZGSmhMQ0tqY0Z0dmJHenFSTGZsUU12dXIrZzZ5TEord1dt?=
 =?utf-8?B?TEtoeDZkUGFwKzRTc1RNdklaYUg4dy90bTIxZHRKaWwvaUJWbFhlR0drbU1B?=
 =?utf-8?B?ZGd3dnJNd0hWZjZLd3lMbzBKanpwWEtvTjJuNHRjdDJZN0NHVDVieDVTU0VT?=
 =?utf-8?B?WE1HcTlwSDNzN25mMVpwbjRBV29YcFJEdjl6Z0VBQkxNRStHMmhoeXppR1J6?=
 =?utf-8?B?VWJjRHlySnZoZDJ6alQ2VVArY0NScHBhL2JxamRMU3NJM09rOCsxQ2hzeC8r?=
 =?utf-8?B?RzZwd05hc3VlRnlxQzBCZjF1TWJLU3p5d3BaL2hRNTIweFBpRDBFNmhvTHdL?=
 =?utf-8?B?bjFma2VwWWs5Uy9YeW9UY0dDd29uTDdKZDFxUm1TVVpPdjFONUxQcTZzaURB?=
 =?utf-8?Q?OdTbV0v9yQ+C3xAyXtbzZiYHlXB9O9DUc01jPru8rDKbB?=
X-MS-Exchange-AntiSpam-MessageData-1: +f3nCprrLP+odg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a43882-bef6-4a23-feeb-08decc3bb857
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 06:43:20.2331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEfxQaRQUIobmq80UJ9QlUeauDUJflY6kYjS6IO+/ahVFyheJBrdjeAAb8TVqXsquC3ph5RqURAhyvmx0ZFHaw==
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

`Gpu` currently owns the state needed to unload the GSP directly. This
means that `unload_bundle` has to be the last initialized field: once GSP
boot succeeds, any later initialization failure would leave `Gpu`
partially initialized, and its `PinnedDrop` implementation would not run.

This prevents adding fallible `Gpu` fields that need to query the GSP
after it has booted.

Move the GSP state and unload bundle into a dedicated pinned
`GspResources` object. Once that subobject has been initialized, its
`PinnedDrop` implementation will run even if initialization of a later
`Gpu` field fails, ensuring that the GSP unload sequence is executed.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs | 90 ++++++++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index b3c91731db45..b5cffcee9817 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -262,35 +262,62 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
     }
 }
 
-/// Structure holding the resources required to operate the GPU.
+/// Self-contained resources to operate and drop the GSP.
 #[pin_data(PinnedDrop)]
-pub(crate) struct Gpu<'gpu> {
+struct GspResources<'gpu> {
     /// Device owning the GPU.
     device: &'gpu device::Device<device::Bound>,
-    spec: Spec,
     /// MMIO mapping of PCI BAR 0.
     bar: Bar0<'gpu>,
-    /// System memory page required for flushing all pending GPU-side memory writes done through
-    /// PCIE into system memory, via sysmembar (A GPU-initiated HW memory-barrier operation).
-    sysmem_flush: SysmemFlush<'gpu>,
     /// GSP falcon instance, used for GSP boot up and cleanup.
     gsp_falcon: Falcon<GspFalcon>,
     /// SEC2 falcon instance, used for GSP boot up and cleanup.
     sec2_falcon: Falcon<Sec2Falcon>,
-    /// GSP runtime data. Temporarily an empty placeholder.
+    /// GSP runtime data.
     #[pin]
     gsp: Gsp,
     /// GSP unload firmware bundle, if any.
     unload_bundle: Option<gsp::UnloadBundle>,
 }
 
+/// Structure holding the resources required to operate the GPU.
+#[pin_data]
+pub(crate) struct Gpu<'gpu> {
+    spec: Spec,
+    /// GSP and its resources.
+    #[pin]
+    gsp_resources: GspResources<'gpu>,
+    /// System memory page required for flushing all pending GPU-side memory writes done through
+    /// PCIE into system memory, via sysmembar (A GPU-initiated HW memory-barrier operation).
+    ///
+    /// Must be kept declared *after* `gsp_resources`, as the latter's `PinnedDrop` implementation
+    /// requires the sysmem flush page to be in place.
+    sysmem_flush: SysmemFlush<'gpu>,
+}
+
+#[pinned_drop]
+impl PinnedDrop for GspResources<'_> {
+    fn drop(self: Pin<&mut Self>) {
+        let this = self.project();
+        let device = *this.device;
+        let bar = *this.bar;
+        let bundle = this.unload_bundle.take();
+
+        let _ = this
+            .gsp
+            .as_ref()
+            .get_ref()
+            .unload(device, bar, &*this.gsp_falcon, &*this.sec2_falcon, bundle)
+            .inspect_err(|e| dev_err!(device, "failed to unload GSP: {:?}\n", e));
+    }
+}
+
 impl<'gpu> Gpu<'gpu> {
     pub(crate) fn new(
         pdev: &'gpu pci::Device<device::Core<'_>>,
         bar: Bar0<'gpu>,
     ) -> impl PinInit<Self, Error> + 'gpu {
         try_pin_init!(Self {
-            device: pdev.as_ref(),
             spec: Spec::new(pdev.as_ref(), bar).inspect(|spec| {
                 dev_info!(pdev,"NVIDIA ({})\n", spec);
             })?,
@@ -308,40 +335,29 @@ pub(crate) fn new(
                     .inspect_err(|_| dev_err!(pdev, "GFW boot did not complete\n"))?;
             },
 
+            // Initialize this early because `gsp_resources` depends on it.
             sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spec.chipset)?,
 
-            gsp_falcon: Falcon::new(
-                pdev.as_ref(),
-                spec.chipset,
-            )
-            .inspect(|falcon| falcon.clear_swgen0_intr(bar))?,
+            gsp_resources <- try_pin_init!(GspResources {
+                device: pdev.as_ref(),
 
-            sec2_falcon: Falcon::new(pdev.as_ref(), spec.chipset)?,
+                bar,
 
-            gsp <- Gsp::new(pdev),
+                gsp_falcon: Falcon::new(
+                    pdev.as_ref(),
+                    spec.chipset,
+                )
+                .inspect(|falcon| falcon.clear_swgen0_intr(bar))?,
 
-            // This member must be initialized last, so the `UnloadBundle` can never be dropped from
-            // outside of the constructed `Gpu`, ensuring that the unload sequence is properly run
-            // in case of failure.
-            unload_bundle: gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)?,
-            bar,
+                sec2_falcon: Falcon::new(pdev.as_ref(), spec.chipset)?,
+
+                gsp <- Gsp::new(pdev),
+
+                // This member must be initialized last, so the `UnloadBundle` can never be dropped
+                // from outside of the constructed `GspResources`, ensuring that the unload sequence
+                // is properly run in case of failure.
+                unload_bundle: gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)?,
+            }),
         })
     }
 }
-
-#[pinned_drop]
-impl PinnedDrop for Gpu<'_> {
-    fn drop(self: Pin<&mut Self>) {
-        let this = self.project();
-        let device = *this.device;
-        let bar = *this.bar;
-        let bundle = this.unload_bundle.take();
-
-        let _ = this
-            .gsp
-            .as_ref()
-            .get_ref()
-            .unload(device, bar, &*this.gsp_falcon, &*this.sec2_falcon, bundle)
-            .inspect_err(|e| dev_err!(device, "failed to unload GSP: {:?}\n", e));
-    }
-}

-- 
2.54.0

