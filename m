Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38319106B50D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EABE10E89C;
	Wed, 25 Mar 2026 12:14:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="O2jVkO1q";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D97AE10E867
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:14:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxJCIgFLDZV/PJUxEA6Y0DlECZOvPDHqOCtETlMaYWxxFCwjHz6XdgHPD+tpB91YZrdUogVo8baa196Nwae2rnYBpiA9efdl4P98mderUtzRmrJ9xDRQcf0UR2YLKJ2j2H1GILDMChlGVZHQj1FKqTfIWbLTUrGk9ngRn9ZmI3ihmneRya9gb1jzJM6+mbuw6kEoiscMsRQyVyWpxL5XwwGzyN/sKSN2MNY3SgfRuzF14jOUJWaD/tk+pP0rdLO7j3/EGVBq2hGcGqyC2XjZjtdQbM5YStNeDkW0u8kEc8oHfPALzmrn1ZIVhtCynA+KtkiWd9IWjyXJid68BqsgLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/YwBQW6s3m8KEiumrCLmkjTLi7JmCmxU1fk1GCwUhk=;
 b=THr9bU6Ht6gcDVunJzWyAeWVsbK+FYER9AreCs8zroe6m408nfjMASZKpuOz+H9qzIKKdFdm3VESXpViZuwD2synJ5xDMyl8cMIKoDvAOKnR1xniB7yuHsg7HDL/rKvgOWAp/5ncMnUBily8l5lYMudeouGssKiSJT6m/8jqv6ctwGR2KLPEPqab8CwwAGtPoeCtAwFB10S984VnwYZiTJtoldFTaGQIXuqkba+y7I4M2S9magmNfvlGPn8nB6MyS4THxxodl9P9IIbSMQytnT8zO46jt+4J6rDZ+qLbPaMJhf8lgKOAwvGO22NCpnqO1VonR165qObKhfxBo225QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/YwBQW6s3m8KEiumrCLmkjTLi7JmCmxU1fk1GCwUhk=;
 b=O2jVkO1qehSOLhKLu5o98p+2YZf7XRm6H+zUSDaAK7DuUe5oGiC8omhcZPB5xut6cGoZR8S9SUP1/xm6e3MI/YoFJkwksZQgDdm9IMEMlNA/Ultma08T9VSSR3aKfqiOuh6UFkpncTMaIMeRc7RgAopJQfDor1PRn1SaeRNudGxO/4pi2nExEJIDODItqN3HFCBCknkPfhqMsZBq9NQsHKH8GyLqs0EDZFzGV8Ltn/sKhI2CzXkF+LFs2xYI8q1cEPRwoy2J4i6LlUsg3IBJgv7dIXUJ36x97RW5LM7Mut5eNVWqkgeUBjaeEbqBN0plO63CR16zy70hwScEcr+afA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:14:16 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 12:14:16 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 25 Mar 2026 21:13:45 +0900
Subject: [PATCH v3 7/9] gpu: nova-core: gsp: add RM control command
 infrastructure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-rmcontrol-v3-7-f3101093484e@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0210.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: a9aa153b-d819-4ac5-076e-08de8a6808a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: H6a8mUU70+dldWlGARy0HUBDPWEDYaUkNtKYwbEaBb4hWRwiFyB+Bhs5ueSXwMFqN9HZ3mI1Q/cAhgECpBpmeHRYOJN7B8IiS+n1y5qHe5TavfNL0jSdTs/HUm6qeglCKTNNhoYjt8FqM+6b1tsZrdpt58zX4ZapTU+d03DMBs4zaSDas7K0HLrdtFGQDCZD/ftk5GNBZ0bXRzUj8zpUUjK6UuGDEGJjcMuBVbf7sWvtVrMZfNgBA6iwpaMJEw2YukGVF2ay6bcIr67mTVMvv7isSpo/XC9in6SpvHq6pO1hxm8LkJrf+PlQjlYbkQSaKrmpHDXuJ8Jz497PmBzRvgAXbIk6kk3undMcivVqDMiUTKPq2x9PyTTc1qgTLw0jpitqLQ3sCw4dW3m8kIPw+YgxG4q5somgDCbfHnzzXbPlrjo7m4D0IcLqB42kVMGadqM18nnPnrweVeBjOMj66mSPCtLjGguAYcFfAbm9b+HO8lH4GfgU9A7FE8j84CjB8TDixCBY26Vj+exHiWCneUPI0lMvi1i16/eW1rrCuNcBk2aYhVl056msi6ghm2GFSuBIXalUKUAug6qeeIHrc46wJVfsbsmZ06r6kHejslq9yzfWBZvyTGrFfOZGMo3q7GaXBjaEutPzOdIOjWdKUUSVa3+zYj63csnVpIq2JgAuE7aGe8AgHYaYAhuKjxwo6/CZzbxwkolZxOB5VeLlMPL8psY/MI657ucK3YgqsMM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2ZEK3lKSEh4bWtVcWRwTjF5MXFXZ2FYK1BSdkhHRGRCUHdvcHFOUU9ieUY2?=
 =?utf-8?B?aElXYk80dzFLZWVWdTRnSEc4bVpkN2d3bEhDV3hMdEVWNUMzVlhjYTloT0k5?=
 =?utf-8?B?b213UlJGWG1FMFArdnVjQ2g4SHMrWnBQMnluYnhIRjNVMUhEZVY3bXZMenFF?=
 =?utf-8?B?YTBJb3dJUWk4ZmRocE1VeUxWL25VZEoxSVRkNVc3V2M1UVEvb2k0RytDUWVL?=
 =?utf-8?B?SzdNK1hXb1p1TnJEcDNiRUpOL2dySjN6ekpURFBkM004YjJJY08rSXp1ckNq?=
 =?utf-8?B?UHVYU0h4ODNRYWc5c1Bta0FrbXBCTGlyYm5iTmY2S0VhS2I1M3BtTE9PNmZ1?=
 =?utf-8?B?NHNFQ3ZTcVZ0VmwvRVplL3NLQUJ1VkM2MWhGWlhic3RqT05lMEU4N1pHb2hY?=
 =?utf-8?B?enB3NVpRenB1Y1ZrcFBKN2swMXdpU0E2anhZK2NHV1FpSVovQ3hZM3g0bzVv?=
 =?utf-8?B?eGhJRjlkSWRxUjJPUUFvVXhoVTlTem96MTdPQTJaUGZweFNiVFhXWHRNZGpD?=
 =?utf-8?B?NmhUTFM3ZDN1RE8yN1ZwelRuN3BEaWJVbWFEZ3g0MUswYXVQUXdRMXZRZjYy?=
 =?utf-8?B?bVpiWCt0c1RFVEFWSW9sUHUyV204cTlNdHc5WUhVYjV5TVRPZkxCTXV0aDZ2?=
 =?utf-8?B?T3lyVmlybXp2VGt3bWtwd2ZmT1JsL2hlN2V3MGFLZzg1SFdpUSt5VVEzYmV3?=
 =?utf-8?B?MTFibnpOMWZLMVdBdy9iS1UvNEVGVXFaUGc2MUtEd1VNeks0ay8vUWsxZEh1?=
 =?utf-8?B?MFpUeUtCU1l4SFlFRUhRUWYyclhCa3hjeHRPZFBPSy94MHFBZFVKaFhDc3FZ?=
 =?utf-8?B?U3FtaWhLR2MxZkVzQllFSVdoN3FvelFYV2JkVEt6QStzTFhTYVBMeFUwRjNG?=
 =?utf-8?B?WkdwVmhCUkUrYUpMSVc5Mk1BUWxiRkhTM01oK0hXYzNPUXcrd3E2Uk9JZEU4?=
 =?utf-8?B?dVJhUjdHR3paQTl6SGpaZ3NqeWRoM2xRVXc0SHNEWnBkYThjYjZTYlhobWdU?=
 =?utf-8?B?ZnMzSFV6QlBaRUs1MVR4MzBkR3J6Z0Z2Mm4yM1FvbTBMMWR0MTlydmM4Z1Nl?=
 =?utf-8?B?dkpvQ3NWREJUeldaR2RnNnFjOGZ6L25yN1k3cENtaGk0OEVoZ3lBc3pobkx2?=
 =?utf-8?B?R3ppU3VFbFNhMzFOdEdhbW1Ea0k1K3ZWWmZaKzZ2dTNEQjliL00wVGNDYnNo?=
 =?utf-8?B?NDZVOVVhZU1vWWE1aUZUa0ZVeVI0ekFFQld6QTRHWEhZVEZmU1hxUTl1a3JR?=
 =?utf-8?B?cjR3RkcyY3VDQ3o0VEpQaWlLZXRmeXkwWFJFT2MvTXVMU1d5bWRtcUYrMDZs?=
 =?utf-8?B?VFU0SHhFVUovZzgwZ1ZqR21kSzNrMXlvVm5aNU5SN1RHVjEvNXNXeS92Mk8z?=
 =?utf-8?B?YmcrRkRUQ3lyRHg3VW1oWEY3UnZWeEZsOWtKUEpCN0cxNEVtQTErY053d3dF?=
 =?utf-8?B?Z25PcUR2Y3lpOERNalVaQXFRM044WjdEd1VlZFlobjVlMGtCVk1XZHVPU2Ey?=
 =?utf-8?B?cjh5NnczVG9odzRxdlF5dmtGWjloN1RrVWNsMC9kVHAyZENsR043eTZsRzlw?=
 =?utf-8?B?Yis0K3NZWGMvU2Q4UGtSZ1RqK29xWmI4cFlmUEtVR0ZjbVZBdGhpc0lreSs5?=
 =?utf-8?B?ZWVMZ1pvazRZVVpWVWhMQmU1dHF6S1dmK0lZWitPY0ZrTjQrZkJlK3BURWRJ?=
 =?utf-8?B?TlQ2SFl0ZnkycjhzaUVvUy9tbmtOTWpkZXNtQlZWR0thQTJ1d00rWC9VdW1F?=
 =?utf-8?B?VU1URmwwSWJja2UvVm5pTGRyRnFYL3FLZHd6RUVSVFQ3bjFiOUFPZU5Sc0d6?=
 =?utf-8?B?VE5QU0lKcEY2cnhIVVhzL1YvU1NpVUFNdks2R1RiQnJIcEdzZkZVN1hhbVc2?=
 =?utf-8?B?b1htdktiSGROaVI2OFJmUGJOQWI1eCtlMXZDZ1lKSDZQdyt5djhYR2h5K2l2?=
 =?utf-8?B?eEU3c1lTR3ZoVUo3aGFLbzdLZStpclU2ODV4T1dkMFFvUmVSRkszRnYyb1Vn?=
 =?utf-8?B?NmlEOGZEdlhWdnNjcGphTEx5VkNRZ0ljNEFOa3RMMml1eklHbTVPam1ubkpP?=
 =?utf-8?B?M09WbDFyWktteDcvcUtyVzh0Z1pleGpqVnk2OWdCakkxSnFWY1ZsQnRoSUJj?=
 =?utf-8?B?QWNvb2xtdlVzVWFOZ2JxTjgvbXNJcUgydStBdVAxN1g1UVV1bjMrUDFBWS90?=
 =?utf-8?B?Tld2STBKTzdkR09teHVYbnI1SmRFeVlzOHNMbFVtblR3a2hVeVgrclRMeDFw?=
 =?utf-8?B?UmlLd2hET25rS0RMaTZ3MitzTTIxZ0FsS3Nic3FSNVhUelZ6SWFGUFlqUFAr?=
 =?utf-8?B?NENacGp4enZ3Qnl4cnpib3hlU1dzeFRxYUxSdVJaOW5JdE9nMkxXdk03d09P?=
 =?utf-8?Q?utiRvmCqd1sYlsS4Qf3D3BjDiupYqMtXVB/mzLIYTJP+0?=
X-MS-Exchange-AntiSpam-MessageData-1: wb5VX42+gAJmbQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9aa153b-d819-4ac5-076e-08de8a6808a4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:14:16.2277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSsdZPVn7QBd/BavApSliZbkQ+rcvW32jBl38d7Gf4JFNIpQS6cJhHyAb9FUrydm5ouLf1HysNHW3ZDEWtNU3w==
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

Add `RawRmControl` which implements CommandToGsp for sending RM control
RPCs. Add `RmControlReply` which implements MessageFromGsp for getting
the reply back. Add the `RmControlCommand` trait for defining an RM
control message.

Add `RmControl` which sends an RM control RPC via the command queue
using the above structures.

This gives a generic way to send each RM control RPC. Each new RM
control RPC can be added by extending RmControlMsgFunction, adding its
bindings wrappers and writing an implementation of `RmControlCommand`
that can be sent using `RmControl`.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp.rs             |   1 +
 drivers/gpu/nova-core/gsp/fw/rm.rs       |   1 -
 drivers/gpu/nova-core/gsp/rm.rs          |   3 +
 drivers/gpu/nova-core/gsp/rm/commands.rs | 141 +++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 04e3976127cc..09d6e673aa65 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -21,6 +21,7 @@
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
index 000000000000..8845ca0a0225
--- /dev/null
+++ b/drivers/gpu/nova-core/gsp/rm/commands.rs
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use core::array;
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
+    sbuffer::SBufferIter, //
+};
+
+/// Wraps a [`RmControl`] command to provide the infrastructure for sending it on the command queue.
+struct RawRmControl<'a, T>(&'a RmControl<T>)
+where
+    T: RmControlCommand;
+
+impl<'a, T: RmControlCommand> CommandToGsp for RawRmControl<'a, T> {
+    const FUNCTION: MsgFunction = MsgFunction::GspRmControl;
+    type Command = GspRmControl;
+    type Reply = RmControlReply;
+    type InitError = Error;
+
+    fn init(&self) -> impl Init<Self::Command, Self::InitError> {
+        let params_size: u32 = T::LEN.try_into()?;
+        Ok(GspRmControl::new(
+            self.0.client,
+            self.0.object,
+            T::FUNCTION,
+            params_size,
+        ))
+    }
+
+    fn variable_payload_len(&self) -> usize {
+        T::LEN
+    }
+
+    fn init_variable_payload(
+        &self,
+        dst: &mut SBufferIter<array::IntoIter<&mut [u8], 2>>,
+    ) -> Result {
+        self.0.cmd.write_payload(dst)
+    }
+}
+
+/// Command for sending an RM control message to the GSP.
+///
+/// RM control messages are used to query or control RM objects (see [`Handle`] for more info on RM
+/// objects). It takes a client handle and an RM object handle identifying the target of the
+/// message, within the given client.
+pub(crate) struct RmControl<T>
+where
+    T: RmControlCommand,
+{
+    /// The client handle under which `object` is allocated.
+    client: Handle<Client>,
+    /// The RM object handle to query or control.
+    object: Handle<T::Target>,
+    /// The specific RM control command to send.
+    cmd: T,
+}
+
+#[expect(unused)]
+impl<T: RmControlCommand> RmControl<T> {
+    /// Creates a new RM control command.
+    pub(crate) fn new(client: Handle<Client>, object: Handle<T::Target>, cmd: T) -> Self {
+        Self {
+            client,
+            object,
+            cmd,
+        }
+    }
+
+    /// Sends an RM control command, checks the reply status, and returns the reply.
+    pub(crate) fn send(self, cmdq: &Cmdq, bar: &Bar0) -> Result<T::Reply> {
+        let reply = cmdq.send_command(bar, RawRmControl(&self))?;
+
+        Result::from(reply.status)?;
+
+        self.cmd.parse_reply(&reply.params)
+    }
+}
+
+/// Response from an RM control message.
+struct RmControlReply {
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
+/// Trait for RM control commands that can be sent using [`RmControl`].
+pub(crate) trait RmControlCommand {
+    /// The specific RM control message kind to send.
+    const FUNCTION: RmControlMsgFunction;
+
+    /// Length of the command-specific payload to send with the RM control message.
+    const LEN: usize;
+
+    /// The type of the reply after parsing the raw bytes from the RM control reply message.
+    type Reply;
+
+    /// The type of the RM object that this command targets.
+    type Target;
+
+    /// Writes the payload of the command into `dst`.
+    fn write_payload(&self, dst: &mut SBufferIter<array::IntoIter<&mut [u8], 2>>) -> Result;
+
+    /// Parses the reply bytes from an RM control reply message into the command-specific
+    /// reply type.
+    fn parse_reply(&self, params: &[u8]) -> Result<Self::Reply>;
+}

-- 
2.53.0

