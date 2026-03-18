Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1325FCD0C7
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0611210E6D0;
	Wed, 18 Mar 2026 07:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="eEfHDe84";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A17710E6B5
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:16:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9LyOK9ZWX8osE3FCD8e8tYzovcal2bWFHCO2fgIvao+x+XFfJEUYLUlFo07gfEwbm2lascvGaZPvoZLARM8IJvc9AEj1LW5WNOBJDQbkdUYQjE3RfQ4xqqPdYKtx6H+NrOWSNHg3n7Jys0GP58A9cHz8wGQgF4EShHEA6A1r9Bdv5/spbaTIWuT40I49uS5WWFrSqm9MIJ9h+5u5hLk/SHwvm4aBEuCuoAmc2fNl7+UVpKBdBtA3AGj2NTnpPVLVNjcF688e0wdaMjauJlSNHaB+WRCko9mUz2JKF6AIEaKRir34qr35f8CfBFVFw8mvTdUkdHSRjDjtULN12ptNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfnlYRV2MNGJXBUPbdMkjFwkVzVAHCM28pA4IuEmCtc=;
 b=aCQzvW2+xA3x1XNiBQvHWbUPc4Axfl58QtSQOkn/v25Ouju/fHhKgNJ3Zc1TLUyxoKcJFeUGQfjpY3l+URFIAe7xHyPUwSkfRqevDnxOXZOkR7vbhyQenI5FYgJW0ADlxv9RYupgiCcrB3yCbPBg060SKe0TZu84JrQtyrb8EY7odOPk9ul1l5Zb915xDrTKcZ7SYgaJfS7cNKOX4ztr/5K/AGHtr5DjDi9ZoQlN2l1ezGPM0sxbkMwDIttlzN2YnxRCVvwKDYPQ4MwfVeN8mwgYlz3PFcCFFLvJbBonQDWzNn4N7IhGKtu0OI/3hXGLYGQcQ9oUJgVWOfiReCnHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfnlYRV2MNGJXBUPbdMkjFwkVzVAHCM28pA4IuEmCtc=;
 b=eEfHDe84UY6T4L5oe6WR0lXdITtia8aCY8Xat2Oay1rwwnezY5Yymhnvy5cOQO2LS8y4F7iO2lyqZGsMq+ClPX98EyLpAG3zIOSAXCncgqYxaKZxdogg7uPvZaP8i5x4DRsS/iu2+93/TtWnGdowLajFpQTKlO2dNUyW8F+aHUDeh8OZDSpHf4RjmS7lUBNG2pxXrDYVfhiLZ+hdXMOn4/wZKqDiYFQQGgb3fOrfUcBpaeN5tqiHIVg0po9ue987CgPCKkTt84t9rvZ0QfMmuG8FcdtrNiFq2dyM8sm70n5zlHjhw4vK///gfy1f1D1AlTZmwo2BpacNkMQchIIy+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 07:15:11 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 07:15:11 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 18 Mar 2026 16:14:05 +0900
Subject: [PATCH v2 9/9] gpu: nova-core: gsp: add CeGetFaultMethodBufferSize
 RM control command
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-rmcontrol-v2-9-9a9fa6f1c4c3@nvidia.com>
References: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
In-Reply-To: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0120.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::20) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: ad808aa3-1882-4567-20e6-08de84be1796
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: d519paX0o1XQWIvU5cMvnPipsoMEYRZB0EshOso11MbfQbTvo3S6aD9QKt1q+wTXoCxyvssxOJMHcfaXgu5rVzjVNAmp+RcJ1HWj9g8xa5xbkyekQvZaoh2LcV//IHTENUjCbNbgAVikn8qLgJ3D3i2VqbJFncU961f2+DriLxDK+IRnfHG+XpigZfz4/7WRZ3guB5Ua+Q/85r5DktESri7DPBWWvy8BLRvIx+F2H/kO6XxTHTXE3Rs0weflwHNycZhy3Eu/mzW+vnnQo3GKB0e0hKXZnval8RPSZix29IbIsg7UsnMwXWd4gXxnrjf7nfcZNmZP5PK6BAux4g81gqL/VTiwQujB6Lr2nqbQVNEUAyhjTB/A9W7+O3EHU6ymAeZrtuv8Ny+yc9+bAcPbMcmPabAauqkxUBcCuk7SEBOfoLt6fjxyCkY3Ecdzql8zFKm0aQA1YpwqfwmFpzbTnOYuLeGclhwhKQrzRmAFIYa1z3hcSFaPTugguEgm6ayCPFaNiq1sxGDcJa66+4qe1k3ivJjnz4eIwKIccFck9Smdq4eF8OQuvWbKOPOWmbXesaCAYMkQw74G8PVLeyusXiN3jiILRiLTJWySwLgCxzLOyfE4zYcCiI+7TFBhvfXkTD5OOh1xsyZYCdQdqfXK2ETvSBzXr4b/kymmWAILuiwb18b3YXSp+eA+c93qHh/mxf34Tt97nq9atI0ZNZBMUzaur0lxlsSVDQ59aKCNric=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OStaRnFEWUVBV01UdUNyaHlrckxOS054U1RRUk9Nb1EydVIwUjdCL1RuUmdj?=
 =?utf-8?B?cHA3RTZyMWk0eFo1TExuN1RWUGlTVE1rSmNRUlM3K0oxUFZuOVg1TFFobERp?=
 =?utf-8?B?K2gzV2JGKzF6SHE2R3RyNDVZQjVoRXdURU5kdGZJNmIxck03NG83eE9Wc0lr?=
 =?utf-8?B?dU83WUxjL20rUDlsRmdJUm01Z2xvQ2prbUFSbFplKytDOElhQ0VWSE1Femwv?=
 =?utf-8?B?d1FDMCtQdmZ4VDNmcE1GZWwrb0tiYm1JTkg0ZFlybWJjMjdVWGJzM1d0b1dX?=
 =?utf-8?B?UjZ2SzZyS0VBajRodFFWdzNMeTJpZmFhVENEeDZvR1ArZUt2anJJMTlVa0dz?=
 =?utf-8?B?TnUwcWFwWFBCU3A1YmdNa01wVG1zMGtFQjJWcWFaS3UrQW1pYmkvdm80TnJo?=
 =?utf-8?B?bHhNY2dURm5idnJkSk83OVNYWDExQ2ZTTzludjlpNk5tZitqTktJeWc1VXlC?=
 =?utf-8?B?YTAzMDdMTmh2eFNGNzV4UlA4YjFOSXpxMGlZRlVuaHp5NG5KcnhNQ2V5TE9p?=
 =?utf-8?B?U012N1U1OW1FODIzc1d2cjk1VmRmWkpnOUJYbXZJMGlaMXczNmxlRXJ5ZEVV?=
 =?utf-8?B?eU45emhNbEJaR2dzZjcvYno0LzJRb2Z1QTMzZVhRSndLY3lLQjJUVlhyY2ZB?=
 =?utf-8?B?YnZrVjYyOVdzQjFFcjdkaXBKUVU0bG1aOVVya0Yzc2hVTFlGeFJLU0JaUElp?=
 =?utf-8?B?SWJqai9Pc2E4K2lOdEtrVVUxRmI3bDJ1SGhlZ2ZucmR2RGFJOFkxMkNzSHRH?=
 =?utf-8?B?enkyTXZONURMaDZZYzZwdW9nKzNNSDNHNnhXVGxEU3A3RU5CZURyU1Y4RmYy?=
 =?utf-8?B?VnRzVktzUXM5OHppWnlLem9VSUlpMXFNNERtcDBJSDNvdEhlMnlVdVp0cVBv?=
 =?utf-8?B?QndOQk1iNWI0UXhaaEd1OGJEdEt1M21nRW9tT0dIVGRCQ2FlZzR5UWIxaTlF?=
 =?utf-8?B?cDZKS0R2bGhYVjN5cmxBeDNILzhENkN2MVd3U0lFeVQwUUUxbTBIY0p5Q3RH?=
 =?utf-8?B?UWJ4a1BzbGlNVElHVGltM0lBN0w4aDhSeTJxUGtpQ2EwS3FDMUpNdXRVdWNV?=
 =?utf-8?B?SnBkQTl4cmZ1a1FMMW1pSzA5NldBOHBMVElBU2JzM3VMZ3FYNjhJRklhM2sz?=
 =?utf-8?B?SWxmVnhGRHNNM2dxekplYWh5NWs5bVhGMnRJczhBalRDaDBjUENaUlQ5U3pD?=
 =?utf-8?B?TGpBVFNMUk5hMW1mWGhlVzNaT1JCRy9OSCtFd212RTlPYlVkSzI5YUExWXFK?=
 =?utf-8?B?NjJ6RDVjV0RKVzgyR0kveFBla3duaXRQMVFYeloyRUoya2VVYm03a3Exc2NI?=
 =?utf-8?B?eWU4UFMyWUhWL1JlMnhjeE1rVFFDZnRBOURWU2dGclhGV3JkQjFwMERCWkkx?=
 =?utf-8?B?MkZaRmN3UklUNmIrOGJCTzNxdEpHUklILzhDN2JNcjE4TnJCeHhRQzNCZ24v?=
 =?utf-8?B?UFhpTWk4Z0pidXR6KzB4Y08yTVRXS01ETXRqNXFMc3ZZRHAwR1YrUGVOQ2N1?=
 =?utf-8?B?dFkrTWxVM2RXZEc5VFFHOVhmMjhzZkthU3Z5dm1lSndadFBSNmgzZk1hQ2xU?=
 =?utf-8?B?cTFDY3lDOStOaDdqanQ0Y2MxTFV0WGRQUzdrMlo0VFNPWlhmSnMvMlNFVmow?=
 =?utf-8?B?Y0VKQzhBamtaN3M2OVpxZFBYUmdjMlUxYzlraGpBcUE3dmFzL3hzNVVzUDNK?=
 =?utf-8?B?dDl2MU0vZUhIOTIwNVE3VHd3dFpNRzRNcHNpZHg4REs3WlVaeFlBYUVKc0hF?=
 =?utf-8?B?RzBtWTgyUXErbUUySENHYlZXaFg3K2xpWGozNU5VbERQUW9sTnM1aUU5YU9W?=
 =?utf-8?B?WStrc2NmcmxtcWlFVzVHME1WV0RJaVNWV3pPR1VtTkw4VUNRN3Ezd3ZVM2Fy?=
 =?utf-8?B?cFV6ekRqNmdPOVZ6VFdMZ3lXanRRUVdpaXRyZjVucFNrTnNKZTVheDgzTTNW?=
 =?utf-8?B?aDlqcnI4VHFLYXVBSDREaXR2M0twVXJ6aUNmbERWYktYR3F1TjVIQis2TklV?=
 =?utf-8?B?Nnp2enlIdW8zZFhUOG1vT0V6RHRxQVZud0dJc0N2dXJpSVpRSzR0akhUVFgw?=
 =?utf-8?B?WjE2VnYrZkZjdkZMQ3poNEs3ck00b2Z6OSt3T1pSUVBVLzJCVU1TWkx0ZWlX?=
 =?utf-8?B?dFEvOWU4M3lWU1k2VER5TFYyOEFRdlBoM1RHekZESkJWZWlWeURQd2VzZXp3?=
 =?utf-8?B?aTN0UzFLSmhhUEtwUHlhY0xjSmlJeFlOdms0UDU3MnFiUmJwTXI1MUFqQmpm?=
 =?utf-8?B?NkNVRmsxb0wyb1IwVGVKVUg5ZjlDYTVXR0dDSk40b0RzbnBvZURRaWVzdjh4?=
 =?utf-8?B?bkF5RUZyZzFmdnNJeWNKRE1ZdGVjYXczSVVBT3ZTdUh5alR4dzRidU5oV1NO?=
 =?utf-8?Q?2sfoMgTyfkZG6yolTnPnFU+6SAhBOuR1lsrNDnIzMTN5g?=
X-MS-Exchange-AntiSpam-MessageData-1: yCoGtLDOasfswg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad808aa3-1882-4567-20e6-08de84be1796
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:15:11.0967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwEf3ztkUGomjpGJNikxfuj5G4YVkkBTf65IlaZPDJL5X3e+huxG017NRD1DXloP/0qA36YUlRu6A3DcbkksRg==
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

Add `CeGetFaultMethodBufferSizeParams` which wraps the bindings.

Add `get_ce_fault_method_buffer_size` which sends the RM control RPC
and returns the buffer size. This is needed for channel allocation.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw/rm.rs       | 16 +++++++++++++
 drivers/gpu/nova-core/gsp/rm/commands.rs | 39 ++++++++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/fw/rm.rs b/drivers/gpu/nova-core/gsp/fw/rm.rs
index 1c6e8b4c4865..561f358ec4f1 100644
--- a/drivers/gpu/nova-core/gsp/fw/rm.rs
+++ b/drivers/gpu/nova-core/gsp/fw/rm.rs
@@ -85,3 +85,19 @@ unsafe impl FromBytes for GspRmControl {}
 
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
+    pub(crate) fn size(&self) -> u32 {
+        self.0.size
+    }
+}
+
+// SAFETY: This struct only contains integer types for which all bit patterns are valid.
+unsafe impl FromBytes for CeGetFaultMethodBufferSizeParams {}
diff --git a/drivers/gpu/nova-core/gsp/rm/commands.rs b/drivers/gpu/nova-core/gsp/rm/commands.rs
index 5a3ac7bd415a..05a8cfae385c 100644
--- a/drivers/gpu/nova-core/gsp/rm/commands.rs
+++ b/drivers/gpu/nova-core/gsp/rm/commands.rs
@@ -2,10 +2,14 @@
 
 use core::{
     array,
-    convert::Infallible, //
+    convert::Infallible,
+    mem::size_of, //
 };
 
-use kernel::prelude::*;
+use kernel::{
+    prelude::*,
+    transmute::FromBytes, //
+};
 
 use crate::{
     driver::Bar0,
@@ -17,7 +21,8 @@
         },
         commands::{
             Client,
-            Handle, //
+            Handle,
+            Subdevice, //
         },
         fw::{
             rm::*,
@@ -47,7 +52,6 @@ struct RmControl<'a, T> {
 
 impl<'a, T> RmControl<'a, T> {
     /// Creates a new RM control command.
-    #[expect(dead_code)]
     fn new(
         client: Handle<Client>,
         object: Handle<T>,
@@ -108,7 +112,6 @@ fn read(
 }
 
 /// Sends an RM control command, checks the reply status, and returns the raw parameter bytes.
-#[expect(dead_code)]
 fn send_rm_control<T>(cmdq: &Cmdq, bar: &Bar0, cmd: RmControl<'_, T>) -> Result<KVVec<u8>> {
     let reply = cmdq.send_command(bar, cmd)?;
 
@@ -116,3 +119,29 @@ fn send_rm_control<T>(cmdq: &Cmdq, bar: &Bar0, cmd: RmControl<'_, T>) -> Result<
 
     Ok(reply.params)
 }
+
+/// Sends the `CeGetFaultMethodBufferSize` RM control command and waits for its reply.
+///
+/// Returns the CE fault method buffer size in bytes.
+#[expect(dead_code)]
+pub(crate) fn get_ce_fault_method_buffer_size(
+    cmdq: &Cmdq,
+    bar: &Bar0,
+    client: Handle<Client>,
+    subdevice: Handle<Subdevice>,
+) -> Result<u32> {
+    // Stack-allocate the request; CeGetFaultMethodBufferSizeParams is small (4 bytes).
+    let req = [0u8; size_of::<CeGetFaultMethodBufferSizeParams>()];
+
+    let cmd = RmControl::new(
+        client,
+        subdevice,
+        RmControlMsgFunction::CeGetFaultMethodBufferSize,
+        &req,
+    );
+    let reply = send_rm_control(cmdq, bar, cmd)?;
+
+    let params = CeGetFaultMethodBufferSizeParams::from_bytes(&reply).ok_or(EINVAL)?;
+
+    Ok(params.size())
+}

-- 
2.53.0

