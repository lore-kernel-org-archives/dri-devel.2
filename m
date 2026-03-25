Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FD7106B50E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5ACE10E89D;
	Wed, 25 Mar 2026 12:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oGV4oEdo";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010070.outbound.protection.outlook.com [52.101.85.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81CE110E867
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYHl9/aAIpQoe+EqSPX04NM/HJKLnaZobRci8q5tNZyIkUyvw1KLiymlHjIjH23G1Z1ko8gudfM6eUJssPISJU3TT2ex4NQlBOhl9uXxvRBzsINvAzR1SxG4JOfTcHVaOFvzlgdpZlTG508vphvhhx2dHDEK2LYztL6cGJonNR87IANYl9nsCNq1+HsbrBZfM+JlhUQi47Hs0VDWTftIrToluftB54XWgrKHRyxHa/Zll27WNojrQKLvkAItLmuGXC6QxGAmGoAZ5XVH9BTsktIyh7EwaZPb0bmd1T1CZGh47moVWIqhA+6hY/b7hOl/THgKAjiCe22lraJZ86YP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bzk8l0wBEZlfkcUQp/6QC5TUxt2SlkMJY8QfrZKKHOg=;
 b=MQUC1XwXqbKn2qb6GBbfHt0YfuAroXs86m4IhYA9HxzgaEroIeHfF/RiJvOcBgOLVt6ImBV/ix/pzZRMFB38BI9QY7uJV3QueJif2hh26YasrCm2JuQmtSpKnyO1eVbgGIwTKJv4THPPuzxDvajg6o/y6KqNrAw9U1ONOs+A33z+t0Th6U9VX4whw9nsX2qIjSE8cGlHi+u+Y9v6mYsbrcvpF972aIcFv7E3/2Y/fXrmfoQnlhz7nIvOr4vX6e7Vv0Lkh3puFGc+Z279hkLlN0wP1iFs328YxjR0/F0jYtmDY/V/xVLpW2xsrUa290pZ2fVEv7YoR5RhgQ9iDnJHzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bzk8l0wBEZlfkcUQp/6QC5TUxt2SlkMJY8QfrZKKHOg=;
 b=oGV4oEdoXV7PmoqmMdioORBvxbx+78Ke/JrMuvQWjXeKegss88oAOCpHn4H2HsaLHj4dA/N/LYt2dKjW/yuYqHZBdIg4+udWBn/eCjw6ruSBKoa+e5PVIC/4Y9ZzitUo/5+2bQ5e4hl3eD0/3az+ptflznqTQhc/TQUd8w3Ko8CwovSFzy1qFSQOkrY+C905OlSsTEfo1+tTDn/4eepSkVbq+tp8blnvaQSZ9hys1sCqhka/JZv4N4C4V8N6sNSszpyIHRczctW4eibiTorz4LfGHoeYyf5YRe+aWajDNWPxO2vIjXSLw1TDP2JAu2+Bro4MZ2wrXqTqyvoyihN/BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:14:26 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 12:14:26 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 25 Mar 2026 21:13:47 +0900
Subject: [PATCH v3 9/9] gpu: nova-core: gsp: add FaultMethodBufferSize RM
 control command
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-rmcontrol-v3-9-f3101093484e@nvidia.com>
References: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
In-Reply-To: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TY4P286CA0077.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: fe47d53e-1d1b-49da-6671-08de8a680e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 2jTB9RDeTHTOXxgqI2cbc+UorweWFfC3SZwe+PpIiM7ORyZnlDoLa5NyQqsfpYYC9T066lvoFFpfErh3/+oQgLecToHM1wROP9LWjBZ0JvtRivMh1p8t4kv6o37I+VouxVVAvHf7hDSRBRMyWm5JGP6qhVlZWNc9EOI209OFS+c8rIN8lpwX3fQ4uM7MUovjLgGV2JVKOIDwQL06SjH5DRfJ/ifWXvGHxCptncpKR7GBXgPzi+2eDWfuKJepwpAZU0POnwiPdLM3x9tPGpmjjK+i+/aBZTkHUIqdigDSEz/DIG6kX8nMhPgWa1mQ1YvAGUmKNEzeFXp4XogS7ElfbP7vmgX/mRMIRo/iu9KxaoSsFyfkS/tVdJpMQN2OIatczhmcpHsAODI1l0JE4oBSOiEvUefRWVl2FRxDrEJTbHTwtukRxKr31lGgc9ZwzQco/HyMVivZokT/oHxj8RM9SjUn3VYOs50YTQsOEkAOGUXd4WKGt05Otq0jePanYmEyZSOcM1TCZQR4d51xR7QJdBL966qg7dUr3vjkohQmkzS9hcWmOCS1oHPdMbF4WLCMFiJwbqupuk1fzAn+0Z0O7zFfcFw1AFY1VVYB/u4xrIQwiEHiq3nnD3Vl6KMmPowGKcZNEgZ/RC+HdvlzIuBGTg5movN/TLiZ/3xLlK9gYxFooEzmeaAy8HV0rh+G5O2VIS7LmlQ0Pa2ajXXIqmLI/49jkibBCY2RpqsHptvqPvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGl4VkgwalRlbCtpZFhqa0FlTjUxK0EwTFNJT1FxbG9tZ3luWUNnK0Ria0k4?=
 =?utf-8?B?QmpINW5lcnZ4TGxTN0h0SUQzaStmcXUyZTBqYm94ZFBDNFhCVkFKeWhGYmYv?=
 =?utf-8?B?bHFGWXovZFlQM25rOXFJaDh5UVl6T1hCU2kwdXZ4TGwvaDZhYmJ5QmJOQkVa?=
 =?utf-8?B?aGVOTGJVMEZzM3N4KzJtNWE2SW5Qb3lpajgyd3Y1NXh2SG4yZTQrZnoxNXBI?=
 =?utf-8?B?SlQvV2ZwOFJZS3J6MnFmTkVtNjlrY3V6WWVkUkF6NFdjVkRESXJ1MTJ0ckto?=
 =?utf-8?B?RnRScW9TL0dpdVJzMCtrVDdSZ1FBaVFmVExkU2NiMGJHM1RNQ0RuWUdSZXgv?=
 =?utf-8?B?NzZwcytCSlZqby9va2VhRmtWOURQWk51OUhxVmloY1RVRXlTLzF0aHFpUHM1?=
 =?utf-8?B?TGg1VkNKSHY1a2R1Vlc1UUFrZklGN2VQRGQ2N2VEd1NuaFNwTmgrQWQydktx?=
 =?utf-8?B?RytjNkFkc0FZRC9xVUhlWnNFTkhYWlByaXh3VGR3TjhEd25acEJzK2dYMklY?=
 =?utf-8?B?bUdvL3RyN3hxNmdGeEtPT2FYU1JIajlpeHJ2a3J4bnczYnVNSTJwMnlUQ2NQ?=
 =?utf-8?B?b3FreFkyakVRdmhYL0owVmVib2tYS1ZlYzVNWDhIaXMzSExIZmN5YXpxakpR?=
 =?utf-8?B?QUxjVS9WUTFKV3J0VE4zdm03ZGFjNFN2R2w1MnlpNDZ2eEorQ2RhRTZweHdT?=
 =?utf-8?B?SUlJMUpZcHlBVEY2U25UcHByUEhIL3R6eEwrNTM3MEVhV3lzRDdQWkpMVm5o?=
 =?utf-8?B?aklsQWl4aW5mYWJvRllmdWNSclAxT1BpNG16ZGY3V3BVc3V6Z1Y0d1FobUFh?=
 =?utf-8?B?eUcrWjJwbkdhNnhINzhCa3Z2c0ZwRG5uay9TREVWczdDd0VkWlZxL1drUG5Q?=
 =?utf-8?B?Zk9rcENaQm9ONWdXVHh4b3hoWVRTODJJNzZlL2FHcGRwbG8xN3B0TjZSVElI?=
 =?utf-8?B?eDc0dHNQQ1JJdmo4T3d5dnM3V3Vrb3UxOCszOEZUQ2w3ZUk3ZHdNd0tFV3lQ?=
 =?utf-8?B?Qk45dWlFck84WnFOR0J6MkwrSThVbG5oSGE2Mzl6cm1KNDYyZnppMGNNZlR6?=
 =?utf-8?B?TmNYQlU5TjJZdFJ3TG84S3ppQ0FhS1BxSjhVbTdDcWpJcEZnUWJveWZ5RVIx?=
 =?utf-8?B?bzVFb1R4eGVEcURLckVHWENsYmhkWHlUcXZJcGNpYXY5K05pMVFCajd0Y0g5?=
 =?utf-8?B?UlFMQ2tjTU4yM1UrTTJ5clpFVE9pakU1R0g1STR5NFRhY2s4dng0SnJpc0RL?=
 =?utf-8?B?UWw5T0FHYmR3OFZ3WkV6OUE3ckpXWVpCWFpidFpUSlFyTDR2VE1JU05OYWgy?=
 =?utf-8?B?MWxEZFIrT21KN1k5WW9rUk5BZVhQbHlNNiswYzFXYklMZWdra2lBeGZ2T09r?=
 =?utf-8?B?a1psc0dyenhyMkllWTRGeWlubk11RDVCWCs3bVFMTzZmQ0sybE5FYzBrTDcx?=
 =?utf-8?B?ZG9qVWFNTEhRb2J3K2piOGtLV3RYZDNZR1BvSVBySkZnbmhidVpHcE9URWVp?=
 =?utf-8?B?cDFBeGxzeDRGRzdOaW1kSlliZmQzR0w4UXZyOE1za0psMlNYTjliSi9mYXIz?=
 =?utf-8?B?MHhSUFdHbmZKR0N0NmQ4L21obm1Wb0lpaWVab01MRkQ2eXFpYVdEY3pTbUpN?=
 =?utf-8?B?TWc0YXIzRmpIaTF6bEJCME9aUmJiUVFVSUtobWh2WEhNTktZQW9QRWhvZnNZ?=
 =?utf-8?B?MnlOZEFlWW5nd2hpRFNqVmM2dlJQb1dwRDUxQVEzM2N0a1JMS3BEZFB5MW5P?=
 =?utf-8?B?aFpuZlc3Sk95MUdqSWJpNmVoZ2RtbjFROVJ0VUR0WmpQN2VZeVBOYzlqU1Vu?=
 =?utf-8?B?bzJaU0VreG5ja3Z0V0FtUEp2MlRhcGlSVUZZV2E1OHBWT2tLU0g5bUc5Q3Fr?=
 =?utf-8?B?bVVwbjVOSEdKTG9yMDNQc3VnekFLeHVCMXNyWUl0SENnbEh2a3pzcDh1dEtH?=
 =?utf-8?B?RFZSNXVtWVhQMzFxNExsODJQQmZESTF4Q2x6SE5OME1tcUZ5akI2SC9hbEdY?=
 =?utf-8?B?bHVYUk5BQVZBV1ZXMVZOc3FJS2Z5QXdMcFkvM2NjMml3bFhkUy9PTnNZbzdj?=
 =?utf-8?B?WlhTWU0yZWE3U3JicEx4NGwrY202TERGeEtuYzNwMmw1M0lzL1NYZ3NoSjZa?=
 =?utf-8?B?MnIwTG5CUk5KaGJQOHpPMXpaemdlVnRRT3QvajFRWWh2MEpXK3JEeWV0R1hJ?=
 =?utf-8?B?bHI1c3BXazladGIrNktMdFZ1aVloMFFTRGtEaU1wRDlYd2JLK01QRXA4S0Zk?=
 =?utf-8?B?YzhTRlFQY29WUHJpS0hPaXpLYTRNS3Y5N0phempFeGhaL2o0NjRoUVpHd05h?=
 =?utf-8?B?T2hlVjFhakVMMHB3L2g4Q3R2YXk5M3htNEk4WkpiVUhEN0xnNXZ2aW84SEVs?=
 =?utf-8?Q?++8d5/5STKF4HMlkze393E2ohb3mmUTIwZm03zQ9dAQlO?=
X-MS-Exchange-AntiSpam-MessageData-1: a4ymx+uWaK693w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe47d53e-1d1b-49da-6671-08de8a680e71
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:14:25.9819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPssakCdHJcAb533qM9exZrCJNiPlsTJTFpOHxh4ZZyM2YEu2pE4UP+vvmx/UDeLzXed+QNjnAHfBr684H+QWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
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

Add `CeGetFaultMethodBufferSizeParams` which wraps the bindings.

Add `FaultMethodBufferSize` RM control command which returns the fault
method buffer size we should use. This is needed for channel allocation.

Finally, print out the fault method buffer size on GSP boot.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs        | 11 +++++++++++
 drivers/gpu/nova-core/gsp/commands.rs    |  2 --
 drivers/gpu/nova-core/gsp/fw/rm.rs       | 25 ++++++++++++++++++++---
 drivers/gpu/nova-core/gsp/rm/commands.rs | 34 ++++++++++++++++++++++++++++----
 4 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index e55210ebb6d1..8a4ad4c6ea98 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -33,6 +33,10 @@
     gpu::Chipset,
     gsp::{
         commands,
+        rm::commands::{
+            FaultMethodBufferSize,
+            RmControl, //
+        },
         sequencer::{
             GspSequencer,
             GspSequencerParams, //
@@ -232,6 +236,13 @@ pub(crate) fn boot(
             Err(e) => dev_warn!(pdev, "GPU name unavailable: {:?}\n", e),
         }
 
+        match RmControl::new(info.client(), info.subdevice(), FaultMethodBufferSize)
+            .send(&self.cmdq, bar)
+        {
+            Ok(size) => dev_info!(pdev, "Fault method buffer size: {} bytes\n", size),
+            Err(e) => dev_warn!(pdev, "Failed to get fault method buffer size: {:?}\n", e),
+        }
+
         Ok(())
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 8c9599aa227b..56655bade9ab 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -285,13 +285,11 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
     }
 
     /// Returns the client handle allocated by GSP-RM.
-    #[expect(dead_code)]
     pub(crate) fn client(&self) -> Handle<Client> {
         self.client
     }
 
     /// Returns the subdevice handle allocated by GSP-RM.
-    #[expect(dead_code)]
     pub(crate) fn subdevice(&self) -> Handle<Subdevice> {
         self.subdevice
     }
diff --git a/drivers/gpu/nova-core/gsp/fw/rm.rs b/drivers/gpu/nova-core/gsp/fw/rm.rs
index 1c6e8b4c4865..73913541d9d4 100644
--- a/drivers/gpu/nova-core/gsp/fw/rm.rs
+++ b/drivers/gpu/nova-core/gsp/fw/rm.rs
@@ -8,9 +8,12 @@
     }, //
 };
 
-use crate::gsp::commands::{
-    Client,
-    Handle, //
+use crate::{
+    gsp::commands::{
+        Client,
+        Handle, //
+    },
+    num, //
 };
 
 use super::{
@@ -85,3 +88,19 @@ unsafe impl FromBytes for GspRmControl {}
 
 // SAFETY: This struct contains no padding.
 unsafe impl AsBytes for GspRmControl {}
+
+/// Wrapper for [`bindings::NV2080_CTRL_CE_GET_FAULT_METHOD_BUFFER_SIZE_PARAMS`].
+#[repr(transparent)]
+pub(crate) struct CeGetFaultMethodBufferSizeParams(
+    bindings::NV2080_CTRL_CE_GET_FAULT_METHOD_BUFFER_SIZE_PARAMS,
+);
+
+impl CeGetFaultMethodBufferSizeParams {
+    /// Returns the CE fault method buffer size in bytes.
+    pub(crate) fn size(&self) -> usize {
+        num::u32_as_usize(self.0.size)
+    }
+}
+
+// SAFETY: This struct only contains integer types for which all bit patterns are valid.
+unsafe impl FromBytes for CeGetFaultMethodBufferSizeParams {}
diff --git a/drivers/gpu/nova-core/gsp/rm/commands.rs b/drivers/gpu/nova-core/gsp/rm/commands.rs
index 8845ca0a0225..de290f4845f4 100644
--- a/drivers/gpu/nova-core/gsp/rm/commands.rs
+++ b/drivers/gpu/nova-core/gsp/rm/commands.rs
@@ -1,8 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use core::array;
+use core::{
+    array,
+    mem::size_of, //
+};
 
-use kernel::prelude::*;
+use kernel::{
+    prelude::*,
+    transmute::FromBytes, //
+};
 
 use crate::{
     driver::Bar0,
@@ -14,7 +20,8 @@
         },
         commands::{
             Client,
-            Handle, //
+            Handle,
+            Subdevice, //
         },
         fw::{
             rm::*,
@@ -75,7 +82,6 @@ pub(crate) struct RmControl<T>
     cmd: T,
 }
 
-#[expect(unused)]
 impl<T: RmControlCommand> RmControl<T> {
     /// Creates a new RM control command.
     pub(crate) fn new(client: Handle<Client>, object: Handle<T::Target>, cmd: T) -> Self {
@@ -139,3 +145,23 @@ pub(crate) trait RmControlCommand {
     /// reply type.
     fn parse_reply(&self, params: &[u8]) -> Result<Self::Reply>;
 }
+
+/// RM control command for querying the fault method buffer size. This is required for setting up
+/// channels.
+pub(crate) struct FaultMethodBufferSize;
+
+impl RmControlCommand for FaultMethodBufferSize {
+    const FUNCTION: RmControlMsgFunction = RmControlMsgFunction::CeGetFaultMethodBufferSize;
+    const LEN: usize = size_of::<CeGetFaultMethodBufferSizeParams>();
+    type Reply = usize;
+    type Target = Subdevice;
+
+    fn write_payload(&self, dst: &mut SBufferIter<array::IntoIter<&mut [u8], 2>>) -> Result {
+        dst.write_all(&[0u8; Self::LEN])
+    }
+
+    fn parse_reply(&self, params: &[u8]) -> Result<Self::Reply> {
+        let reply = CeGetFaultMethodBufferSizeParams::from_bytes(params).ok_or(EINVAL)?;
+        Ok(reply.size())
+    }
+}

-- 
2.53.0

