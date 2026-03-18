Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA860FCD0C3
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B40510E6CA;
	Wed, 18 Mar 2026 07:16:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tu0kzBUR";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1684610E6B5
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:16:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muTCAWq9tmZb7/qV32dV6tSSrseQrq0wOLx9KeEC189ruFo+q1Or8K6qyhmrXqt+GQHaACsAimWAPQD2KVQwcP3sV55eh5xQqSXcj5fc4lkfPKRchBAkjLLdrSSv40BnXcpugPkFHPNnLWw8Lpu6SLMyZZS8YhECvqf6xflZ0EvA9czsNtSdTqJPki+mrv/yaFjwQS6zbpm+41qWYy2Sv9wbVeiNrluhd2MmKRFg6e2ESye4nJe69/8XsaDkS2CG6OTlv05caW52BNcEEWqz6K09j4t9WCiBHzEl0/djs0nOX+RRHbhKV4FgOIeNxGZEswx9U81d9lnx2HrmPbuq+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2QqrmfLFZaGxNMkoQW3RgqoiGxks02o6xL5FpsW8Js=;
 b=cn/3dkU6sq6Le8/MIaC6BN1o+n8ri9tDgqbdKEuUyTcfQuRr2w5jAZVYvJAalXNDnLn9OoSq5wSpxMA4Wqu5t3yJB4rY0jFWUSxSaE1xLXGUoXwxb/bRUzmFcvnFn2xPmEzVaz8Nswjcq8LhhMgxdnb0kjy+i8y12MYPVL1RYgBQxLZfLxgpl091RNVdrwM87K+GRYVSKrsvvexTH9NztrUjvMaf4AV1lztOuTTsiP7v/fOnSL9YkbwkiuP183Sdebr9pjZT/3+DipDvwncb3Iyp/EiH/4JjoqN4FWYhYNvE/+P089DLL8eeoXPi0VMWSCI/bfrN0G892rnYJzlWiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2QqrmfLFZaGxNMkoQW3RgqoiGxks02o6xL5FpsW8Js=;
 b=tu0kzBUR7FZ+AVDe4mWuqevFYenY76kbMbBOfLFW+u/3tgq2BOMpCPOd9gc1fAOdMn+KFQFRkvauRmry8A+Iim6Ujim8vvzQ240x8rB8GrYTJCvCV3hiUxZCrcV/iOgo9glLA/alHUPXdQ7DU2THDG5/ePQv6FCCpRnewWjVrL0v37xdCS5Rq5MgfQE+1M8nTlJ+ifhBaXh5rlbsVaU9Ow2X7a5ZZEDf46ZvZMkiEcHc/k18s23+PmTqNuiVdGHPAmWnVcBEaq9Lw5/dfKvnP0z7a0UADyiVkL9itwWVuFDvuk+aQCt7BOvlG6bLswah/K3ubEte5m4rVr3FKc7hbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 07:15:02 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 07:15:02 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 18 Mar 2026 16:14:03 +0900
Subject: [PATCH v2 7/9] gpu: nova-core: gsp: add RM control command
 infrastructure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-rmcontrol-v2-7-9a9fa6f1c4c3@nvidia.com>
References: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
In-Reply-To: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP301CA0046.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::10) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 01222e43-2a14-407f-3184-08de84be1295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: p97k/gh/fOOJcB2Yw1b+nY39Oxo1+e+47Qsmo1M+oj9Dm2Of96cH9v4bJr3x4Kby3nCHPY14Kok3WAn844ff0k8RIiLLYZZ+ki7G2xoyjcdPje2vuUQZ4jRw0f0aMdWfyFX8eL2kwa3W2k06ZrVW0phHehOXAILjrMtkmHS6uN+iaQFSMlIHN6YduuZAq3V8hE3tz//cKfPHa/d4kuBUS2ytRBteDV7tQSXH8PbH7OujGxgeLYr5be10yAxO1TLHXeqeSqWiiu9LW2SiJtWCUL+jAatdZ0Fu6FsVkH7WnXtm5QSzSsdBJm/6MqFyDSFVr9kyQUYVIK921w4hxIPak5CSwT7v8Qae2wm3+9K8+ygrkxAysJyYovNQFKeGTHIHrv18tSAmOWld6Ux54szKxpvfuiHNUcEk6dOZdWSv1WbYpADsf3FWgMBxBjrNeM3usYjDRHXuMt6REIK/21ifAF3BifFbD589dTejEIamKhyBTWHz2kou5WrFCfoY/zqtal4qUhQU3r5K+QUIQC1y3Qz9twOaS19xj5zT+jYJbu10IleuxNUHFS9jAI9QX2dYTH7FXqrdpEJVlXkL9FhTto1yjtuYrXwNPEZ+vPG4kJwGpD1q9TZNYUjY+CSEthuca6l6M0kKw+7HJfa6n22xci6KKW7+bWno9Bkr8kzHm+XX6DxhuCp4ZP14vdMvr+estl5g6loiw2MAd5dlW9mH7glTKExNkAZIsfSCupb9LjQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1N0eWlFdWZEVFNsSnB3RnBLWHZrMURCYnViNG9HaFhadmVDSjBDMmFiaXhz?=
 =?utf-8?B?eHhwOFREc3RrWEpGZS9JNHdSWDFBbW4yYUNNV2R3eXVleVZUSjY4c2E4aWNG?=
 =?utf-8?B?aXJXTytGQ05EQkppUTY3SXFKZGsvRi9QUGZOdVYwSm5ycDllTVZXN0ZRRElr?=
 =?utf-8?B?UWJwQm5XWGtVYmdiY0xuMjBIeHIwcUY5ak5YRXNkdzkzQ0h4REY3aGJjOVZM?=
 =?utf-8?B?Qkc1S3VFUEtVZFlmcERFazd4c0hNL3BJbFVzRDJ2RnVxUWZCcER2TmZ6OU9p?=
 =?utf-8?B?dVZMSVZvWGRaV0tMVTNLZGljcnU1RG96UXJxVHF4bGlIOXhWRlhWRzRxdUN3?=
 =?utf-8?B?elZLQUZsZEpkNUYrWDZqS0s1V3dyMzdOaXFSN0lxME13Wmc3Z25STmtkdVha?=
 =?utf-8?B?WCtqZGdrdEo1bGhlZU9maG5sRXQxUW12MXpDdFR5b3JFa0k2N2R5d0N6WFVr?=
 =?utf-8?B?Q1RoUXFXRXhMUklsekhaMDh2ZDRsYTNBUUFUZWdtak9zOXdIYUs5L1pCbE9t?=
 =?utf-8?B?K0gxZVQyQzYycXo3bUU5STN5SVpQeEpsY3BLaUI0d1lGdXA2SXN1blBNa0lH?=
 =?utf-8?B?amtuMVlvWi96RmFnZVB5MWhGU0U1WDhvUk5WNERUUDJ3VnJzWTZxekZVWGxu?=
 =?utf-8?B?cENNTW9hREtFVWFiT1VMUXhJNW1uSzMxbitkMHdMTlh4MEZFSVJnVUxyQXJQ?=
 =?utf-8?B?TWVJMERmYVlJcnB1bFp6S2VNSkRWSXJiV1dOd21BZ1dzUVFVUDIyeVdTVGp0?=
 =?utf-8?B?ZFkyTURDRkdYTUUyNzVVOVJSS3RMRXlKNStnMTNmTTFWZlZvYVM5NUJHOS9T?=
 =?utf-8?B?aUpqbzhyT1JsQk4zVXFWL3pWdDBGOGNPeUhGeEd6dzVVRzYzMzh6Y3h0dHNJ?=
 =?utf-8?B?RFFrcXUxWFpMNUdMZ2pNM1FpelhiaDcwb28rNkJGakZ3MWl1MkRMSFpNOVRr?=
 =?utf-8?B?TFNZWGRlYm4yUnV1UTRSRVBBWmFiclJ6NGJWR3ZtSk1ITUtTMTVQb3BKcjhm?=
 =?utf-8?B?aEN5SVljRmVYd05aU2xzbHIrS1NmZHVMRjRsdnR2eDZuSEl2akNUUDFhTTMx?=
 =?utf-8?B?dnl6RG5peVVpVXcxdVNMenk1emF0bUNacGMvRmhmT0R0SHYweTgzTTB6VThT?=
 =?utf-8?B?TTYyZHdvekNKYld1c015WmVsRUZZMG53Um9OSXgzUUpoUUJZUk4vWVdNdkNO?=
 =?utf-8?B?T3g0OTFENHZGWlZRRE5uNjZVK0Y5ZG91WmVrQ3R2eldJM29kdlVSMWg3WGw4?=
 =?utf-8?B?dE5yT2RyY1pBRldBTmdUQWgvNVdnMm91WHVQM0YveWhxdkpVU0VySVExYVdC?=
 =?utf-8?B?aHdScXpwY1RITStoRDEwQW5zaU1zU2FRbG1oTEhxS3ZvSU54TkZzbkF1b1d3?=
 =?utf-8?B?bklHd3ZybFNDT0pxQ21zZ2w2blBFT0hCcU41OE1INmdwR2hSZlRkNlA4RkU5?=
 =?utf-8?B?K29xRThhVFVSTTRPYUlSMzRWR0MzOWxvbERmMnVEZkdtVXBNV1dTVDRrbVhq?=
 =?utf-8?B?R0lqWE9qdjluN0F1cFhjT3hCQWhRakNpOW1OMkJUa0J4RG5EMk5IUFU3V2ZX?=
 =?utf-8?B?ZkFLdUF3d3EzS01mM0phUmltMk1mV0xpVDFiZzRhSmR2ZmhXZHRwNlJvN3J1?=
 =?utf-8?B?UzdIdnB5RGRFcW9xQmNZUXgrNWhlMWFLSGE1Q3JtQUEwcmJBdytHTXN5OWkv?=
 =?utf-8?B?TDg5YThpOVZnVG1LdWZSUDJnZnF0Nmtrd2wxSmpiTDVhT1RCSlNWR1drNU0r?=
 =?utf-8?B?NkZIZFlXb2Q4OGxEUGczangrekxjdnlmSDFKdVVUeGNhWUlBcVErNS9VTVRZ?=
 =?utf-8?B?bjJNbS9tYmNIYVJidzQ2UlV1TVh6eUNtTkRlOEhwWllBR0NIZ0hXSjJ3djF3?=
 =?utf-8?B?emVCbEMvTUxQd1QyakZEUEZHdWJKQVdjTUJ4TXFCOWxkMUp6VGxKY1BYUkJH?=
 =?utf-8?B?Wm4xUHJycWdQTmQxM0UxRWZaZGRUU0VUOGVZOUFubzBlazAxaWgxT0NISTdh?=
 =?utf-8?B?amIwdi90Sng0N0hWcWQ3T0lCMkFvY2krNGhBR0VXRVRXUXVQS0toMkNkamls?=
 =?utf-8?B?eEpnUzk0K09SRURpYitsREF5eFN4RllUYXJqb1VKUVJQeU9QSkgyZVJQeE9i?=
 =?utf-8?B?MTJFRUYxaGdCRDg1dEVxSUdHNXJYbytCci9HUWc1bGljN2Fmd3hPM2dBRmpM?=
 =?utf-8?B?RXJhZ3Y2TkNzd0w3U01aMWxHNHh5MzNWMXBHeUszTUlFRnlTam1PNUhaVGlt?=
 =?utf-8?B?aEQwOTl5SWtvc0dzV1NBZkxGMDhJZ1RRN3FhT0ozRHFXNDJSSG95U1c2QVFR?=
 =?utf-8?B?RnR4OXBqMkk1aG85UHJqeWx2Z1JVMFRpZzlQRXJOb1NqUVplTXRmbXl0bFhF?=
 =?utf-8?Q?pDvnu3u+GQnwEDyeFN4OXX3xuEc06lYAZkfxrW/5rum1S?=
X-MS-Exchange-AntiSpam-MessageData-1: StBc8O90AvGMVw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01222e43-2a14-407f-3184-08de84be1295
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:15:02.4769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OK1Rxfy3XbTlB5usED9X/zKBXT7Qhgkd3VLKrNWky2CE4vncSKBdloenp15W8g7JofY6oXJOhiwRqIUBV4/K6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
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

Add `RmControl` which implements CommandToGsp for sending RM control
RPCs.

Add `RmControlReply` which implements MessageFromGsp for getting the
reply back.

Add `send_rm_control` which sends an RM control RPC via the command
queue using the above structures.

This gives a generic way to send each RM control RPC. Each new RM
control RPC can be added by extending RmControlMsgFunction and adding
its bindings wrappers and writing a helper function to send it via
`send_rm_control`.

Tested-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs             |   1 +
 drivers/gpu/nova-core/gsp/fw/rm.rs       |   1 -
 drivers/gpu/nova-core/gsp/rm.rs          |   3 +
 drivers/gpu/nova-core/gsp/rm/commands.rs | 118 +++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 72f173726f87..14c734c53e7c 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -17,6 +17,7 @@
 pub(crate) mod cmdq;
 pub(crate) mod commands;
 mod fw;
+pub(crate) mod rm;
 mod sequencer;
 
 pub(crate) use fw::{
diff --git a/drivers/gpu/nova-core/gsp/fw/rm.rs b/drivers/gpu/nova-core/gsp/fw/rm.rs
index 4a4f97d88ecf..1c6e8b4c4865 100644
--- a/drivers/gpu/nova-core/gsp/fw/rm.rs
+++ b/drivers/gpu/nova-core/gsp/fw/rm.rs
@@ -53,7 +53,6 @@ pub(crate) struct GspRmControl {
     inner: bindings::rpc_gsp_rm_control_v03_00,
 }
 
-#[expect(dead_code)]
 impl GspRmControl {
     /// Creates a new RM control command.
     pub(crate) fn new<T>(
diff --git a/drivers/gpu/nova-core/gsp/rm.rs b/drivers/gpu/nova-core/gsp/rm.rs
new file mode 100644
index 000000000000..10e879a3e842
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/rm.rs
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0
+
+pub(crate) mod commands;
diff --git a/drivers/gpu/nova-core/gsp/rm/commands.rs b/drivers/gpu/nova-core/gsp/rm/commands.rs
new file mode 100644
index 000000000000..5a3ac7bd415a
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/rm/commands.rs
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use core::{
+    array,
+    convert::Infallible, //
+};
+
+use kernel::prelude::*;
+
+use crate::{
+    driver::Bar0,
+    gsp::{
+        cmdq::{
+            Cmdq,
+            CommandToGsp,
+            MessageFromGsp, //
+        },
+        commands::{
+            Client,
+            Handle, //
+        },
+        fw::{
+            rm::*,
+            MsgFunction,
+            NvStatus, //
+        },
+    },
+    sbuffer::SBufferIter,
+};
+
+/// Command for sending an RM control message to the GSP.
+///
+/// RM control messages are used to query or control RM objects (see [`Handle`] for more info on RM
+/// objects). It takes a client handle and an RM object handle identifying the target of the
+/// message, within the given client.
+struct RmControl<'a, T> {
+    /// The client handle under which `object` is allocated.
+    client: Handle<Client>,
+    /// The RM object handle to query or control.
+    object: Handle<T>,
+    /// The specific control message to send.
+    cmd: RmControlMsgFunction,
+    /// The raw parameter bytes to send with the control message. Interpretation of these bytes is
+    /// specific to the control message being sent.
+    params: &'a [u8],
+}
+
+impl<'a, T> RmControl<'a, T> {
+    /// Creates a new RM control command.
+    #[expect(dead_code)]
+    fn new(
+        client: Handle<Client>,
+        object: Handle<T>,
+        cmd: RmControlMsgFunction,
+        params: &'a [u8],
+    ) -> Self {
+        Self {
+            client,
+            object,
+            cmd,
+            params,
+        }
+    }
+}
+
+impl<T> CommandToGsp for RmControl<'_, T> {
+    const FUNCTION: MsgFunction = MsgFunction::GspRmControl;
+    type Command = GspRmControl;
+    type Reply = RmControlReply;
+    type InitError = Infallible;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        GspRmControl::new(self.client, self.object, self.cmd, self.params.len() as u32)
+    }
+
+    fn variable_payload_len(&self) -> usize {
+        self.params.len()
+    }
+
+    fn init_variable_payload(
+        &self,
+        dst: &mut SBufferIter<array::IntoIter<&mut [u8], 2>>,
+    ) -> Result {
+        dst.write_all(self.params)
+    }
+}
+
+/// Response from an RM control message.
+pub(crate) struct RmControlReply {
+    status: NvStatus,
+    params: KVVec<u8>,
+}
+
+impl MessageFromGsp for RmControlReply {
+    const FUNCTION: MsgFunction = MsgFunction::GspRmControl;
+    type Message = GspRmControl;
+    type InitError = Error;
+
+    fn read(
+        msg: &Self::Message,
+        sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
+    ) -> Result<Self, Self::InitError> {
+        Ok(RmControlReply {
+            status: msg.status(),
+            params: sbuffer.read_to_vec(GFP_KERNEL)?,
+        })
+    }
+}
+
+/// Sends an RM control command, checks the reply status, and returns the raw parameter bytes.
+#[expect(dead_code)]
+fn send_rm_control<T>(cmdq: &Cmdq, bar: &Bar0, cmd: RmControl<'_, T>) -> Result<KVVec<u8>> {
+    let reply = cmdq.send_command(bar, cmd)?;
+
+    Result::from(reply.status)?;
+
+    Ok(reply.params)
+}

-- 
2.53.0

