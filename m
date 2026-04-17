Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58789F436B4
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9DA710EA7D;
	Fri, 17 Apr 2026 15:33:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QCassdyP";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012065.outbound.protection.outlook.com
 [40.93.195.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5276E10EA7D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 15:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdtUk5YSg1WX1yCU66vqHIDUKAipplwdaQ9LAFR1OWXVH9ZLv5A40ZX9nc1zM/YQrNdvS0BOZePqA7HtjIdEqFRd5k2/G8gL+sEMTmjZaoVCih8RbupjEkPV1Pwd3UidlHnNNoqIcaya4rFvUqqcC8tFYjhlB2yjnoNvN0rTABtoQykgzNWPT1fnmn5UrUi+4Egtsj1XLp0GaOCPuusUjZaXFhhVqY68JH3wca7/awUcLmJmu0GqZLYqyvE/7ev6s6x//1Fm+JLz+ejb+iTTTOPg5FProhHW9ZJq8cqPkAmVhjQdsEt4JX5aSRTdZ1iuBOexsiqtD3Ktiw0HkFdfFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6SUhARgFZQSkn6ItCwuhj2KFGqFY2tSL2W/ygskVDM=;
 b=AcfAUq2oN5RK7Z+F3eZQ/75czBS3vvkBO1LzmuIzfYqRvJ+C+cQ03F7QIetOgqGK4cNTBbmWAgmEZpHoAZn2RlQVhMjtYtKwIvAM4ctFkB/0mH8vWA/1eJhA5KQHxY+xD3hgchrcQF2YgYOXzWhokcmufiJl20WS+s2aqMY8syYUyHApimSWQyXt03Gva8vkgRTnkU40vbqvbj211y1ro7wnDjWjfCwWZqSWhvX0+SruutUdizxFrf5Dw/y4yPcMmwKqj9rOvUWv8cZspCyGAG0MYZwTYq9QUzsg2g85OZfBw2EXM60LwUefBypS4bxqaXptgCjjWB5FtMfCey1xkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6SUhARgFZQSkn6ItCwuhj2KFGqFY2tSL2W/ygskVDM=;
 b=QCassdyPu8gACpeXGK6cNhAew+TJ+xmGv/U6U+zQnOCvQB0QdR4sm779ekBciWUzFkSijU1WkpvI8VZ1Jmpf3u9A8P6JzGbE3mEApciok9DVDmYmqx3ppjr6pgjsNdEu72U6w8YPR8EIbjneYrZVlTGknnKmxnG3vzBoVRoIjr4rKLwxTrX6vqk16V9qtZET7g2QFNhGr/N2L5bvjK7zRraHPK0WnveIpjZP06kIvG+XR3+5IeNMSTHBgqVmMEJwGhkF6zxsGJpx1cxi4cUtH7+vwdwCCMGsIjtNHH+4KSBCpLz5AFchMxrzE3XzFQT5cDSBO5cSFFhCJ8Ps0+2wbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Fri, 17 Apr 2026 15:33:44 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 15:33:43 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Sat, 18 Apr 2026 00:29:21 +0900
Subject: [PATCH v4 3/8] gpu: nova-core: gsp: add GspRpcError for Cmdq RPC
 error handling
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-rmcontrol-v4-3-fda8c76dbb95@nvidia.com>
References: <20260418-rmcontrol-v4-0-fda8c76dbb95@nvidia.com>
In-Reply-To: <20260418-rmcontrol-v4-0-fda8c76dbb95@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0173.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::16) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 982a715c-61e0-4562-231f-08de9c96b583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Ufc66otSq/g3pJhL5nyhu/R1qQM+geNhkqZlGu0UAp3MeqhDqzyWibNGwZCGDbHKbeAeYkG8whIk4I836tocIYkRmgtQ8sIwmkri8Zc/DIre1NWlc3u2hvXbBfRJjflw05B7Bt65pVR21D4x3cUdBZB3wPcR/1UCFwyJKa4aapx/qMi43UKciEgvUq1xbvorhqVW0/QV4cMFlXGEHhXHdWCfya50amSTiTMCu0KcYpOWWLrytwITIX8GCTUiAUWrslpm7nM/ejRpCn+2tCp6PUwKH2qkjSyZllJsaEZbXBbgMyhF7i16BVJQWCrlcLhec6OAXoFfTgN3z8XMHOmeYgxdpgNZVoDJC3Kk6fXvd2WZgl3Qszjrb6fymYh/PLJKPjo2zLOe7EViXlN2UmBTW9C3SS5mcji6yR9nGUxeVVum4ogvNzhmIwBHQ/gWDpr47ewOXxApCEkE65ZUeG8DhyCtn0k4oaTmOvZYRN6nCMiwQ+06iduqizwBFRvnFEQht8u0y6+Vrnm1fHErEhFPN3UUDqmM+FDSWch7GRxxnMTRjMt2dTp+tt4sEdVISRa5HsdopgAGCA6upUNkGJOnw/694dr4HXXSeFot2PR+fKNTuJC3M0JqOZB5HNWplKePo4d+td60kGCWCga2eVrrfFn62Q0LLLNtSxhKPH+XxOcIS0WAqw+FWLuScrNpT1Fx7a9Z4LYWduiYU8ai4ajPEbqZRuWEOo0EbSu/0oYNkvQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUNPWWI4YXplMElkWmUrdWxwOFBEWWs4L3M2RkE4bHl6K1pPSlJwQlRYTjcv?=
 =?utf-8?B?aDcwOUMrdWN3Q0xsbXNxeUh4bU1RNU16R3pXSzZubHM0aFovSEFOSkFzUlU2?=
 =?utf-8?B?SDI5bmdTdXJMdnpwdUtxVzU1S1c1TDloeHg5L0FDSmcxSHp3MlIvUDV5aEgv?=
 =?utf-8?B?QWJnU3BLWUlpUkRSSExTdWpLQzBTYVpqL1dET1NMVUV1Y05NSGJyeTBmd1pN?=
 =?utf-8?B?bnR6Q0hHTkVvWlJkZHFvWDByeWlhRm9HODFOS1VmUDJZR05ROHFaM0NlbXdU?=
 =?utf-8?B?c2wxbWxaQnlrQzZ4S21WUkNjVzRBN2E1VFIwVklTTHJvZHZ3d01HSkRaVXZF?=
 =?utf-8?B?dmxZaFNxNFFuNjNVVW12bUxWM011UG5Yb2FZZlB1RmFTU1dIZW1MNWtNczR1?=
 =?utf-8?B?ckszbWh3WGR1dExvNmVYWDNBR3dlT2RFN05sV3BJRlh4cXdTNFlPdWN3SVRL?=
 =?utf-8?B?SmpSYnZkQkJaMUMwZkdBRDd1bFZQM1NkQU9BRENmMHplTnFUeWJzWHE1UzdV?=
 =?utf-8?B?UVhhbTVISnJjR0RISGx6ZTZrT0UvMEY4WGRyY3BQdjhrd0NEcFBOcjN0YWhI?=
 =?utf-8?B?U2pBZlZHeVpla2lDOFN1dVpmbmpCWDB0aHNNWE1qckxPRkZyVlpKZzZhc3hN?=
 =?utf-8?B?ZTNNNzl0NStBQ1pOZHdVODJwWFhjcVJxTmQ3dEZtMlA0Sk1PSElvOEhhYXRG?=
 =?utf-8?B?MzRMWVFmejNqRFNndE9sV09SaDFSYWJXVDN6VlA2ZmU1ZTREU1VWSndSa1hy?=
 =?utf-8?B?N2tZRHdRMkMwcWFRcEJKb2dJMkFKYWlWOTUxVFJ2dVNLa1VzNUduWE53Sklt?=
 =?utf-8?B?QlhsU2hnOC9nZHpXYVZjWjhZNkxESmdDY3FOeGVYT3k3RzZCTjVOb0dwUGlr?=
 =?utf-8?B?emIzQVFMYjNlOHk3Q0lSNW95SlNaYlREYTl0aGlzK3d4bG5CQUdoNy9JTThq?=
 =?utf-8?B?WkNGcVp2ekxOSm91RkJJdjNuTWkyWUV5ck1GaGh0RjVpT2ZySktOblNTaWE5?=
 =?utf-8?B?dWdGVDgvN1Z0K05ucFlDbWhEWnE4S0NJRWdOSG5zdnRTM0UyQ1NvcEZBajhK?=
 =?utf-8?B?ODYwS0dIVVowRTJoVnZra1R6Rm1GL040TGU4bkxPYlpTcWNpeG85Nm02MXl6?=
 =?utf-8?B?M0UzSlZHMFVJVEtGd1pRU0hYOWhjMXkyV05HZEtDbTNkV29mOU1wOEpxOFYy?=
 =?utf-8?B?cC83Z21lV2lCYThiZnp2c0xIdmlSOFpGQXcwYkRNazRiTGVydzFjNGRva2hl?=
 =?utf-8?B?VEIwcDN2Rm9YbEdZaWxhUFE1NVN4QTZXcW42UlJuY0VCTUJOS01yM3piTFBD?=
 =?utf-8?B?cDc4S3NNVmZEWUlhZlorOHdHbnU5UnVvcWxDTGF1Q1MvQ1BJVzh6eWFDN3dN?=
 =?utf-8?B?S0lmbzJDMnRVWTQzM3c1TEhQU3RySElpWGFKNXV4aitDMDZUMWhhZnJFR280?=
 =?utf-8?B?UnQ4ZGdlemVRY0szNlR0M1o4ZzZUTjJDQi9GejNFSUZwUC8yZzNnRWhDbkJQ?=
 =?utf-8?B?WHRLTHJhb1ZvSGRRRGJqZmZSKytMa0JRaXFJZW0ycmRaQlk5SkZ1ZlVBbVZD?=
 =?utf-8?B?QkRneFZUN1g4dnNKbHlLRG9IRzZqUUg5UmlmZUVicUtDYUFYS0I0Ni96eFYv?=
 =?utf-8?B?SEF1UWpUd0hjMkN5TmdkZWM2eUtLQUY2U1RjOURBOVNzT3EyM0l1eWl6RlF1?=
 =?utf-8?B?Q25oMnRJYS9SUURsRU04S01ZN2h2YUlVaXlXditFZ1EreUFLSUFZWmxwSWF1?=
 =?utf-8?B?MkdKY2lZS2Iza2swWloraHFic1ZxN3ZCVG9CQm9HZk1pWENBVGt4M05vY2R5?=
 =?utf-8?B?MWFjTFNXR2tpTy93S1RmNzk0YVZkVkduRkxIUDhFZFZkOVVoOSthWS9DRC9x?=
 =?utf-8?B?YkxKSDh3cmpRYVA5U2M2dVE0NUdrUlZxYnpLVmZGN3FGRnFDSjJuSjF0TURX?=
 =?utf-8?B?eTYyTjhvUHpRMG1XTHBFbDF3eXUvTEdMTmdYdFJiMDJkUFUxTnNodHZjTmdp?=
 =?utf-8?B?K2dDd1dCZURhSHhlMTlHcDhBUkRVMFpKaU9YakpMM3NxQzgxQlVtS1RzQ1oy?=
 =?utf-8?B?WGd2aTVaSlZOOU5RSkhYMzZSUkh3bDhWeWxtZENJampKQWxib0plbDhlMXc3?=
 =?utf-8?B?ZTR6S1crdFI5TVpoMTFZcjk1dWpQazFUTFEzUm5rK2JWS2ErRGdoKytsaFo5?=
 =?utf-8?B?MVFUSE5vL1hjK2UwazJwZFgxcUd4OGdCY1NqQmVacjVwZTgvZ0MrMERuNGpl?=
 =?utf-8?B?MXFrdVcyWVlEWnQ3VWEyR0J5K2p2VnlOOHZDWDR2SC9BbnJpNWs0MTI4MUxO?=
 =?utf-8?B?NkxING5rLzZYRW5kNGFuZVoxcEpQK05zT3B0S1VIVWlEUUx2elAxRVdFNmQy?=
 =?utf-8?Q?Z6bdOuo7d0OZy4SFlhUJT62vZZQNfPLvC31Q12yhSK7jN?=
X-MS-Exchange-AntiSpam-MessageData-1: 8ABYiurTyFyg5w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982a715c-61e0-4562-231f-08de9c96b583
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:33:43.8836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zdmcV470Qtqrb2k9lYB5RVg2j/5p6BeQg724maUI0p06gU63hgnEyPsiI6TkQMHdhDFE5YQjUD9VsNN/vwlDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
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

Currently, the RPC status value is ignored, but it can actually indicate
failure from GSP-RM. Add a new error type used by `Cmdq` to surface this
failure mode.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs      | 112 ++++++++++++++++++++++-----------
 drivers/gpu/nova-core/gsp/commands.rs  |   7 ++-
 drivers/gpu/nova-core/gsp/fw.rs        |  37 ++++++++++-
 drivers/gpu/nova-core/gsp/sequencer.rs |   5 +-
 4 files changed, 117 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 569bb1a2501c..501d01e2bedd 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -41,6 +41,7 @@
     gsp::{
         fw::{
             GspMsgElement,
+            GspMsgRmError,
             MsgFunction,
             MsgqRxHeader,
             MsgqTxHeader,
@@ -55,6 +56,24 @@
     sbuffer::SBufferIter, //
 };
 
+/// Error returned by GSP RPC operations.
+#[derive(Debug)]
+pub(crate) enum GspRpcError {
+    /// The command transport or reply decoding failed.
+    Transport(Error),
+    /// The GSP-RM RPC returned an RM-specific error status.
+    Rm(GspMsgRmError),
+}
+
+impl From<GspRpcError> for Error {
+    fn from(err: GspRpcError) -> Self {
+        match err {
+            GspRpcError::Transport(err) => err,
+            GspRpcError::Rm(status) => status.into(),
+        }
+    }
+}
+
 /// Marker type representing the absence of a reply for a command. Commands using this as their
 /// reply type are sent using [`Cmdq::send_command_no_wait`].
 pub(crate) struct NoReply;
@@ -547,13 +566,14 @@ fn notify_gsp(bar: &Bar0) {
     ///
     /// # Errors
     ///
-    /// - `ETIMEDOUT` if space does not become available to send the command, or if the reply is
-    ///   not received within the timeout.
-    /// - `EIO` if the variable payload requested by the command has not been entirely
+    /// - `Transport(ETIMEDOUT)` if space does not become available to send the command, or if the
+    ///   reply is not received within the timeout.
+    /// - `Transport(EIO)` if the variable payload requested by the command has not been entirely
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
+    /// - `Rm(status)` if GSP-RM returned an error for this RPC.
     ///
-    /// Error codes returned by the command and reply initializers are propagated as-is.
-    pub(crate) fn send_command<M>(&self, bar: &Bar0, command: M) -> Result<M::Reply>
+    /// Error codes returned by the command and reply initializers are propagated as `Transport`.
+    pub(crate) fn send_command<M>(&self, bar: &Bar0, command: M) -> Result<M::Reply, GspRpcError>
     where
         M: CommandToGsp,
         M::Reply: MessageFromGsp,
@@ -561,12 +581,14 @@ pub(crate) fn send_command<M>(&self, bar: &Bar0, command: M) -> Result<M::Reply>
         Error: From<<M::Reply as MessageFromGsp>::InitError>,
     {
         let mut inner = self.inner.lock();
-        inner.send_command(bar, command)?;
+        inner
+            .send_command(bar, command)
+            .map_err(GspRpcError::Transport)?;
 
         loop {
             match inner.receive_msg::<M::Reply>(Self::RECEIVE_TIMEOUT) {
                 Ok(reply) => break Ok(reply),
-                Err(ERANGE) => continue,
+                Err(GspRpcError::Transport(ERANGE)) => continue,
                 Err(e) => break Err(e),
             }
         }
@@ -592,7 +614,7 @@ pub(crate) fn send_command_no_wait<M>(&self, bar: &Bar0, command: M) -> Result
     /// Receive a message from the GSP.
     ///
     /// See [`CmdqInner::receive_msg`] for details.
-    pub(crate) fn receive_msg<M: MessageFromGsp>(&self, timeout: Delta) -> Result<M>
+    pub(crate) fn receive_msg<M: MessageFromGsp>(&self, timeout: Delta) -> Result<M, GspRpcError>
     where
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
         Error: From<M::InitError>,
@@ -801,52 +823,68 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
     /// Receive a message from the GSP.
     ///
     /// The expected message type is specified using the `M` generic parameter. If the pending
-    /// message has a different function code, `ERANGE` is returned and the message is consumed.
+    /// message has a different function code, `Transport(ERANGE)` is returned and the message is
+    /// consumed.
     ///
     /// The read pointer is always advanced past the message, regardless of whether it matched.
     ///
     /// # Errors
     ///
-    /// - `ETIMEDOUT` if `timeout` has elapsed before any message becomes available.
-    /// - `EIO` if there was some inconsistency (e.g. message shorter than advertised) on the
-    ///   message queue.
-    /// - `EINVAL` if the function code of the message was not recognized.
-    /// - `ERANGE` if the message had a recognized but non-matching function code.
+    /// - `Transport(ETIMEDOUT)` if `timeout` has elapsed before any message becomes available.
+    /// - `Transport(EIO)` if there was some inconsistency (e.g. message shorter than advertised)
+    ///   on the message queue.
+    /// - `Transport(EINVAL)` if the function code of the message was not recognized.
+    /// - `Transport(ERANGE)` if the message had a recognized but non-matching function code.
+    /// - `Rm(status)` if GSP-RM returned an error for this RPC.
     ///
-    /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
-    fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
+    /// Error codes returned by [`MessageFromGsp::read`] are propagated as `Transport`.
+    fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M, GspRpcError>
     where
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
         Error: From<M::InitError>,
     {
-        let message = self.wait_for_msg(timeout)?;
-        let function = message.header.function().map_err(|_| EINVAL)?;
+        let message = self.wait_for_msg(timeout).map_err(GspRpcError::Transport)?;
+        let function = message
+            .header
+            .function()
+            .map_err(|_| GspRpcError::Transport(EINVAL))?;
 
         // Extract the message. Store the result as we want to advance the read pointer even in
         // case of failure.
-        let result = if function == M::FUNCTION {
-            let (cmd, contents_1) = M::Message::from_bytes_prefix(message.contents.0).ok_or(EIO)?;
+        let result = (|| -> Result<M, GspRpcError> {
+            message
+                .header
+                .status()
+                .map_err(GspRpcError::Transport)?
+                .log_if_warning(&self.dev, function)
+                .map_err(GspRpcError::Rm)?;
+
+            if function != M::FUNCTION {
+                return Err(GspRpcError::Transport(ERANGE));
+            }
+
+            let (cmd, contents_1) = M::Message::from_bytes_prefix(message.contents.0)
+                .ok_or(GspRpcError::Transport(EIO))?;
             let mut sbuffer = SBufferIter::new_reader([contents_1, message.contents.1]);
 
-            M::read(cmd, &mut sbuffer)
-                .map_err(|e| e.into())
-                .inspect(|_| {
-                    if !sbuffer.is_empty() {
-                        dev_warn!(
-                            &self.dev,
-                            "GSP message {:?} has unprocessed data\n",
-                            function
-                        );
-                    }
-                })
-        } else {
-            Err(ERANGE)
-        };
+            let msg = M::read(cmd, &mut sbuffer).map_err(|e| GspRpcError::Transport(e.into()))?;
+
+            if !sbuffer.is_empty() {
+                dev_warn!(
+                    &self.dev,
+                    "GSP message {:?} has unprocessed data\n",
+                    function
+                );
+            }
+
+            Ok(msg)
+        })();
 
         // Advance the read pointer past this message.
-        self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
-            message.header.length().div_ceil(GSP_PAGE_SIZE),
-        )?);
+        self.gsp_mem.advance_cpu_read_ptr(
+            u32::try_from(message.header.length().div_ceil(GSP_PAGE_SIZE))
+                .map_err(|_| GspRpcError::Transport(EINVAL))?,
+        );
 
         result
     }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index c89c7b57a751..b8f64bfe9313 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -23,6 +23,7 @@
         cmdq::{
             Cmdq,
             CommandToGsp,
+            GspRpcError,
             MessageFromGsp,
             NoReply, //
         },
@@ -169,8 +170,8 @@ pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq) -> Result {
     loop {
         match cmdq.receive_msg::<GspInitDone>(Cmdq::RECEIVE_TIMEOUT) {
             Ok(_) => break Ok(()),
-            Err(ERANGE) => continue,
-            Err(e) => break Err(e),
+            Err(GspRpcError::Transport(ERANGE)) => continue,
+            Err(e) => break Err(e.into()),
         }
     }
 }
@@ -234,6 +235,6 @@ pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
 }
 
 /// Send the [`GetGspInfo`] command and awaits for its reply.
-pub(crate) fn get_gsp_info(cmdq: &Cmdq, bar: &Bar0) -> Result<GetGspStaticInfoReply> {
+pub(crate) fn get_gsp_info(cmdq: &Cmdq, bar: &Bar0) -> Result<GetGspStaticInfoReply, GspRpcError> {
     cmdq.send_command(bar, GetGspStaticInfo)
 }
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index a8d7c62af097..5fabb815a919 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -6,9 +6,13 @@
 // Alias to avoid repeating the version number with every use.
 use r570_144 as bindings;
 
-use core::ops::Range;
+use core::{
+    fmt,
+    ops::Range, //
+};
 
 use kernel::{
+    device,
     dma::Coherent,
     prelude::*,
     ptr::{
@@ -99,7 +103,6 @@ pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &Coherent<GspMem>, count: u32) {
 
 /// Status code returned by GSP-RM operations.
 #[derive(Copy, Clone, Debug, PartialEq, Eq)]
-#[expect(dead_code)]
 pub(crate) enum GspMsgRmStatus {
     /// The operation succeeded.
     Ok,
@@ -605,6 +608,31 @@ fn try_from(value: u32) -> Result<Self> {
     }
 }
 
+impl GspMsgRmStatus {
+    /// Converts [`GspMsgRmStatus`] to a [`Result`], logging if the status is a warning.
+    ///
+    /// `rpc_name` identifies the RPC for the log message.
+    pub(super) fn log_if_warning(
+        self,
+        dev: &device::Device,
+        rpc_name: impl fmt::Debug,
+    ) -> Result<(), GspMsgRmError> {
+        match self {
+            Self::Ok => Ok(()),
+            Self::Warning(warning) => {
+                dev_warn!(
+                    dev,
+                    "GSP RPC {:?} returned warning {:?}\n",
+                    rpc_name,
+                    warning
+                );
+                Ok(())
+            }
+            Self::Error(status) => Err(status),
+        }
+    }
+}
+
 /// Empty type to group methods related to heap parameters for running the GSP firmware.
 enum GspFwHeapParams {}
 
@@ -1347,6 +1375,11 @@ pub(crate) fn function(&self) -> Result<MsgFunction, u32> {
             .map_err(|_| self.inner.rpc.function)
     }
 
+    /// Returns the RPC status from the message header.
+    pub(super) fn status(&self) -> Result<GspMsgRmStatus> {
+        self.inner.rpc.rpc_result.try_into()
+    }
+
     // Returns the number of elements (i.e. memory pages) used by this message.
     pub(crate) fn element_count(&self) -> u32 {
         self.inner.elemCount
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index 474e4c8021db..672c7d6c3cf6 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -29,6 +29,7 @@
     gsp::{
         cmdq::{
             Cmdq,
+            GspRpcError,
             MessageFromGsp, //
         },
         fw,
@@ -360,8 +361,8 @@ pub(crate) fn run(cmdq: &Cmdq, params: GspSequencerParams<'a>) -> Result {
         let seq_info = loop {
             match cmdq.receive_msg::<GspSequence>(Cmdq::RECEIVE_TIMEOUT) {
                 Ok(seq_info) => break seq_info,
-                Err(ERANGE) => continue,
-                Err(e) => return Err(e),
+                Err(GspRpcError::Transport(ERANGE)) => continue,
+                Err(e) => return Err(e.into()),
             }
         };
 

-- 
2.53.0

