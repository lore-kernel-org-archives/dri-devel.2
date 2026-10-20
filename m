Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D1C60A2617
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iMKcWGgV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A061510F497;
	Tue, 20 Oct 2026 10:09:04 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A8FA10F492
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:08:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4mxfd4SGHHB14ltHxyds9ZL7lHPgpp4NvyqPITTU4np3EcSKIhMpR/w6wCbSOL+16U54EjacTI4e6DvqH1QaRuvjsZu7oyC9EzrRABYH5k+iiidTrFmNtGc71bb5ZWZlI8lGOX701K6QoOcUO4fUyoeRi2zPnVt7Y2v8NOgz7eTHBwk37R64qor3kd5jdACvgJMS0Zw+az23qkzhP+q0dUiK/k/NjudcvPuGgWXQoTK4pWjOTyMNjwtd/0HX22wDoSRqOUFWLM4CmhLZc76uf2UfBM+bi/kRZagiF/JXpB2TN3c4mrH4ejkRI4vRjDK26I2d2xl5OBqDK7P6zQ9dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wadkDx3ScHHWqYjiyksoJzXWrtN2cww0+cGJr88lv8=;
 b=Jw2QumZi+Dlliy3Ced9oTRweZeNsgyDWle1Yj3wRKmBxVY9kVZVei5lrC8gtevjuRa8fYJZEZ0Pj1LeTDJHSog+Z6Vt5UAqywuWfno/ZP/qw/xVt6vtvM1FoELBSGzTPK7wGRkvLZxH7rFYU8zDp5xq0QjATUfYAK0egkYRKT8miHmPG0/AnlZJuF2j4GdOMTuAJLwN4RzWh/nKLcxXyZlEY6V+YFImYgEMSjQKVtao66+K905k0RRFQFHUkmD5wKJpLgaBhXTI4Jpu8gr91Uc5g0YQT+Y1XL2n0S2b/kq7j4ZlfmNZi0Cc0NhhYHpbubCNZhQqMz0QKoBdzZ57NBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wadkDx3ScHHWqYjiyksoJzXWrtN2cww0+cGJr88lv8=;
 b=iMKcWGgVLRnv3sSUMNeZrqnJvvVl+t8beAxkGcZ8UMUeAcufG0Ln20FBmSU7sWdBhEvCO+cALNEMophEeZZCO88PSTXOXPE5H/j42yljM/a4gvxuF095UlBAA3ZHMS8kYBLzUPFzB8LL6HeoP4rMzDdeoVzqoFBgYQFIBRafHgigFDsJyeR1h/9SV73MAy1cOfEqF/EVetTpvHexWGAxWWvDgANY7qYCyNg9q7+0uEjysh0ryNW6Tb73dVRQZbavEVhNMi0vt77SYDvRtoOkL1zYcyWJUcKogW42koKcJpyNSOSiaBcxBiETSk+k9W+rRpPCeoTPgsBWPO/OpHhAbg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:08:48 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:08:47 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 20 Oct 2026 19:08:27 +0900
Subject: [PATCH v5 06/14] gpu: nova-core: gsp: cmdq: split the transport
 part of the send path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-cmdq-rpc-v5-6-dceeb8f360ec@nvidia.com>
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
In-Reply-To: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0076.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: a4216c1e-368e-42a9-b934-08df2e92219c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|10070799003|1800799024|6133799003|18002099003|22082099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: FldDi2C8FlHkj3D6TcGdjThXLsI+dzcUFRLZpa0UE02f+iWgTtsXiVoHiuqSFm13HZnoXoP9pbKXuc3g0A4PgXTOm+ZRTx+/1ZY03Iv+Dvfqg26Ns68La2vLV3r0wbPh7zGfZ0eYFvx4LkcYg0PFzjQwQfth7XvFCMATQsXunIN/d45PCWI1zmRZWu2tQqIqzd/FMuSptuN7XlJcn05V9c4t+Ne8UPiO2YRmwUKo5coI2D+qyTvLe5NC1YVviNlbu6+aIMGcHXtmcXodfK9vLu7eRGvRujqYY5V6EaN9Zgo6bUMpIbOYn7ZRI+b/mIUohqewv/wiYvAdpT1jAeKgRHfmLusZfY2N2Pq1JbC3B3Rs4nHTzyueaftbqLcfPtRtLkrcCBsLD0Jwbx8ZMT2bA5Cn3plcTDRBLoca6SWgicgHZBlg5NgwhDRPV0B2iVdCJFhhOoLG/O2LO0fwArUVFmurgAyvsFJ/6fl7oS6Muz0TqbWzLQk/qLGIMWNzU8a1S8s77dAZZLOAHxXXLGdzY/TOWx6P5hNKrPzaCLWrwfWgbtRv3ySUVtbY4gbOD+MQ4Jp+fjwfCfMemNOzRsJvk6YKZMDH4SztWcXQ6/aIuyYFQnxg2ENSF3m8BXEdoZPhNXHY6M9tiY4dlLBGBkyPmgHF9oMe7xtuXL6Y5SV4h8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(10070799003)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmgzTTkveVlrSENQakNlMXZuUlkvNWRkbVM3OXNGWlFiZXZhU2FxR0pNbUE4?=
 =?utf-8?B?VHFURHArMTU4ajdNeSt1cHZXbytUeGdGaXIvQjdOTjVERUx1VnNaeElrUFg2?=
 =?utf-8?B?UWhwblFNYm5PZzdyVmNaU3hkTDZ4T1RLUlB5L2ttcWlmSVlVTkFRMDNCUWh0?=
 =?utf-8?B?Tjl0clJCM2o1Z0szaHJWdzhlcGlUa0tLRGhRUWNQUjgraHN4Q2VvTFdTL1Zt?=
 =?utf-8?B?cjdkU0VoT0tiOHl6OGdWdnBOcUdQalk2WGxtcktUNHNlSnFnU1QyRUdlWmJj?=
 =?utf-8?B?RFF0eDRkRGVRN0huVEJNdmhoRlp1dVgxdjl6YUJNbVMzV1RRcjhxaVFPcEN5?=
 =?utf-8?B?RVJNd1FhSExPTUxydVJBbUpPUWJKdHU0NnlyMGI5L0t5RjRIbXdaUkVSdkVD?=
 =?utf-8?B?S3hDWDU5MGY0K3hHbjgxT1NGTGZFNEJ0VzY0SHREWm5EbXlibElnOE9ZQmE0?=
 =?utf-8?B?bHpkcFFlU2xRYnlOdCt0amhjNU44ZGpndjZ2NE1IRExmcHRMVUpEaGYvV3pB?=
 =?utf-8?B?TG1nTmRzYlhTQjdNazQzUVk5Sk14Y1ROaUQya1lISTdDcUhrVXhjRVBiTE1Q?=
 =?utf-8?B?c0tVclNmamNHN3ZnRlljNWdxSTVWbTM3QmhXVEUzbjM0S0VMc25hbVdYK1Zp?=
 =?utf-8?B?L1YyMWI5YXhEWUdETUgwL2RmNFJMTUo4ZHFNOThaVS9sV2hIVnVlNlJpd2ds?=
 =?utf-8?B?UWZMMU9NOXJTbnNWMkFKTGM0ZVd5UEtGRjdnQXdtaDZZc3NGYXpYWHVkdTVj?=
 =?utf-8?B?SU9TbFJiNHJBdTdDcUJyOHhZVng0dnNrNVh3WExSV2RPa201NXhMWXA5aCtM?=
 =?utf-8?B?UnRYazhoZEFKN3E2ZER5OGJpKzBvSWZzZE5XaWFLU1VqcjR4OCtsUEtJbWw1?=
 =?utf-8?B?eUF4a1JKeEJSclRJRk1KY1BnZEIycVlGM0xDcFhXZVVXVHhEZmpNWk9EU1NQ?=
 =?utf-8?B?YXFyUTFOTDRDay9wQUxnMnNFR0NMVkVnN1V2WitPRVVxTEpicWloYjBydG5I?=
 =?utf-8?B?UUFFSW5YSXJHRW5jU2Iwbk1WVkhmNzFkLzV4ZHFQVjMxdisvZDk0K2xUVlNk?=
 =?utf-8?B?NGloaE5pWFZkS1RqaHdpYVRqaFlyVTcxYTlQeVQyY1ZxS3JIY3lGK1EzNlpP?=
 =?utf-8?B?Z1JCSVU3eTNGbFE3QkNKNUUzUzZUVFlBZXVsRFZTRkVVcGZvQ2EwUDVHZ1VU?=
 =?utf-8?B?ajdXRHdKTFk1MTdSWHFINW1BdVo1bjlUanlFcUNnemVFM0hTSHExdFB4dHlJ?=
 =?utf-8?B?ZmZSN3hnVy82dnI1cDBWRTNtdkdLNmJMVE5NREFmMmFKbk96MllHZVNETmhq?=
 =?utf-8?B?b2tTT1hLUG1ETzJzaGppTkI1Rno2TExzYlFzelo2Q1RPdC9XSXdoZ2doRTc1?=
 =?utf-8?B?aGNjbUI2dE1FVTlnQlR1aHZNbXJ3MEtEd0JLajhTTmtQakFQaW1VMEdOUmZp?=
 =?utf-8?B?bm82citJdG1sVzZqeDRtaEU1bHFnOUowNXdIVkI3dXVRcjZKTWEyN2xxQnMz?=
 =?utf-8?B?YWhtQzAwbGpPeGwzTUJKYS9mc21jang4U2FGcnFkMmtzV2hRT1BHMG5LZXdu?=
 =?utf-8?B?K1FZOWJMc011Tm5rbGpzNHRkbk56VmI5ZnZKY3FXaEZmdnpIOHhlWllGT3dr?=
 =?utf-8?B?ZTd5RlI5SXRWZW9CbmlTK1NSaGI4dFFXRjh4TUpRZnpCTmlDUlBMdG5FMkR3?=
 =?utf-8?B?Sktkd2JMdVh0K09mMlVWLzlCWXJTNjVrUWpuaDRmYVlZOFAvRTRkRkZoUWcr?=
 =?utf-8?B?OURqaWZzdnlBM1JsMzBYSVlLMjQyTkVxWWVkcml0cjM5cGN2U3pOSDF0YWlR?=
 =?utf-8?B?NWYzZVZrZW5MR0J0VVVtSzRmKzRpYVdLR1RwYnBLYVNTZFdrZ1FrSjloTFRu?=
 =?utf-8?B?L0VKZ0ZjSU91dStocnBjclgvL3ExMjZRcHgwczExamxnVWJkNzNMcEpvdk80?=
 =?utf-8?B?b1ZlTmpyaGIyVEwzbkY1S2ZVcitZODIzYUgzdmcvamdMdUZ2RllNeE03cFo2?=
 =?utf-8?B?NFF4ZkF2bGNLbzc1Q1VCRWZpRHNLbkVqc3htSkg1ZkRucUJVdzZ0R1ZhNExK?=
 =?utf-8?B?YkplaUhMd0d4T0ZNTWZ6WHI5RGRSV1Rka1A5eHJlREtidjN0WWZ4RjNnOVE2?=
 =?utf-8?B?VnJzZXFrcXFid3BtbHJ2ODBwNVB2bEJqc0plMmRQT0RNRDJlR0ZzbncwYS9P?=
 =?utf-8?B?MXRZa1V3UmRZd3lza21zK0p6QzRIYk55VmJpY1dBWHZSUXd0VUgzY2kyL1Jo?=
 =?utf-8?B?b0lmVUhlb01rYzBmRENBWlFGUFZkRXc1bG1mTG4zSTg2RC9zNDBhTkNQb2hN?=
 =?utf-8?B?Zkh6VnRYS3NmcVN0NkxWMzZza2F6dXYrbkMrZUs2U0pyK3JzcGZkU2pUNFFu?=
 =?utf-8?Q?eu7wkNrgFq103Hmg5+Yc+lgDnRzQfTtkw5HVMKiUZYulz?=
X-MS-Exchange-AntiSpam-MessageData-1: PBZaz0CInzxfpw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4216c1e-368e-42a9-b934-08df2e92219c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:08:47.4966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxGADZNDgJN6nMMERzNO8b07nmvv5SayRhzg783skjWWO6Dviek1JcyFk2csTjB/ZMAHBdlxz2tjOCgOxtW60A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce the `CommandElement` trait and `RpcCommandElement` wrapper
type to define how messages (independently of their type) are sent
through the transport layer. `send_single_command` becomes
`send_command_element`, which allocates the queue slots, writes the
element header, and delegates the writing of the message itself to the
implementation of `CommandElement` before computing the checksum,
advancing the write pointer and ringing the doorbell.

The RPC part of `send_single_command` (writing the RPC header and the
command payload) is now part of the `CommandElement` implementation.
This sets things up for moving the RPC code into its own sub-module,
leaving the transport agnostic of the message type.

No functional change intended.

Suggested-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 133 +++++++++++++++++++++++---------------
 1 file changed, 80 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 88d81a4e37ef..ef59f541f7e6 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -39,10 +39,7 @@
     },
 };
 
-use continuation::{
-    ContinuationRecord,
-    SplitState, //
-};
+use continuation::SplitState;
 
 use pin_init::pin_init_scope;
 
@@ -71,6 +68,19 @@
 /// reply type are sent using [`Cmdq::send_command_no_wait`].
 pub(crate) struct NoReply;
 
+/// Trait implemented by types that can be sent as a single command queue element.
+///
+/// The command queue allocates `size()` bytes after the `GspMsgElement` header and calls `write()`
+/// to fill them.
+trait CommandElement {
+    /// Size in bytes of the element, not including the `GspMsgElement` header.
+    fn size(&self) -> usize;
+
+    /// Writes the contents of the command into `dst`. `dev` is the queue's device (to be used for
+    /// logging), `seq` is the sequence number of the element.
+    fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspCommand<'_>) -> Result;
+}
+
 /// Trait implemented by types representing a command to send to the GSP.
 ///
 /// The main purpose of this trait is to provide [`Cmdq`] with the information it needs to send
@@ -133,6 +143,62 @@ fn size(&self) -> usize {
     }
 }
 
+/// Wrapper type for sending a RPC command as a command queue element.
+///
+/// [`CommandElement`] cannot be directly implemented for all [`CommandToGsp`] with a blanket
+/// implementation as it would conflict with other future command types.
+struct RpcCommandElement<M>(M);
+
+impl<M> CommandElement for RpcCommandElement<M>
+where
+    M: CommandToGsp,
+    Error: From<M::InitError>,
+{
+    fn size(&self) -> usize {
+        self.0.size()
+    }
+
+    fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspCommand<'_>) -> Result {
+        let command = &self.0;
+        let size_in_bytes = command.size();
+        // Extract area for the command itself. The GSP message header and the command header
+        // together are guaranteed to fit entirely into a single page, so it's ok to only look
+        // at `dst.contents.0` here.
+        let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
+        let rpc_header_init = RpcMessageHeader::init(size_in_bytes, M::FUNCTION);
+        // SAFETY: `dst.header.rpc_header_mut()` is a valid reference, and is not touched if the
+        // initializer fails.
+        unsafe {
+            pin_init::raw_try_init(
+                core::ptr::from_mut(dst.header.rpc_header_mut()),
+                rpc_header_init,
+            )?;
+        }
+        // SAFETY: `cmd` is a valid reference, and is not touched if the initializer fails.
+        unsafe {
+            pin_init::raw_try_init(core::ptr::from_mut(cmd), command.init())?;
+        }
+
+        // Fill the variable-length payload, which may be empty.
+        let mut sbuffer = SBufferIter::new_writer([&mut payload_1[..], &mut dst.contents.1[..]]);
+        command.init_variable_payload(&mut sbuffer)?;
+
+        if !sbuffer.is_empty() {
+            return Err(EIO);
+        }
+
+        dev_dbg!(
+            dev,
+            "GSP RPC: send: seq# {}, function={:?}, length=0x{:x}\n",
+            seq,
+            M::FUNCTION,
+            size_in_bytes,
+        );
+
+        Ok(())
+    }
+}
+
 /// Trait representing messages received from the GSP.
 ///
 /// A reply that [`Cmdq::send_command`] waits for, or an event that [`Cmdq::await_msg`] waits for.
@@ -662,24 +728,18 @@ impl CmdqInner<'_> {
     /// Timeout for waiting for space on the command queue.
     const ALLOCATE_TIMEOUT: Delta = Delta::from_secs(1);
 
-    /// Sends `command` to the GSP, without splitting it.
+    /// Allocate enough space on the command queue to store `command`, initialize it with
+    /// [`CommandElement::write`], and send the command to the GSP.
     ///
     /// # Errors
     ///
     /// - `EMSGSIZE` if the command exceeds the maximum queue element size.
     /// - `ETIMEDOUT` if space does not become available within the timeout.
-    /// - `EIO` if the variable payload requested by the command has not been entirely
-    ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
-    /// Error codes returned by the command initializers are propagated as-is.
-    fn send_single_command<M>(&mut self, command: M) -> Result
-    where
-        M: CommandToGsp,
-        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
-        Error: From<M::InitError>,
-    {
+    /// Error codes returned by [`CommandElement::write`] are returned as-is.
+    fn send_command_element<E: CommandElement>(&mut self, command: E) -> Result {
         let size_in_bytes = command.size();
-        let dst = self
+        let mut dst = self
             .gsp_mem
             .allocate_command(size_in_bytes, Self::ALLOCATE_TIMEOUT)?;
 
@@ -690,40 +750,8 @@ fn send_single_command<M>(&mut self, command: M) -> Result
             pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_element_init)?;
         }
 
-        // Extract area for the command itself. The GSP message header and the command header
-        // together are guaranteed to fit entirely into a single page, so it's ok to only look
-        // at `dst.contents.0` here.
-        let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
-        let rpc_header_init = RpcMessageHeader::init(size_in_bytes, M::FUNCTION);
-        // SAFETY: `dst.header.rpc_header_mut()` is a valid reference, and is not touched if the
-        // initializer fails.
-        unsafe {
-            pin_init::raw_try_init(
-                core::ptr::from_mut(dst.header.rpc_header_mut()),
-                rpc_header_init,
-            )?;
-        }
-        // SAFETY: `cmd` is a valid reference, and is not touched if the initializer fails.
-        unsafe {
-            pin_init::raw_try_init(core::ptr::from_mut(cmd), command.init())?;
-        }
-
-        // Fill the variable-length payload, which may be empty.
-        let mut sbuffer = SBufferIter::new_writer([&mut payload_1[..], &mut dst.contents.1[..]]);
-        command.init_variable_payload(&mut sbuffer)?;
-
-        if !sbuffer.is_empty() {
-            return Err(EIO);
-        }
-        drop(sbuffer);
-
-        dev_dbg!(
-            &self.dev,
-            "GSP RPC: send: seq# {}, function={:?}, length=0x{:x}\n",
-            self.seq,
-            M::FUNCTION,
-            size_in_bytes,
-        );
+        // Write the message payload.
+        command.write(self.dev, self.seq, &mut dst)?;
 
         // Compute checksum now that the whole message is ready.
         dst.header
@@ -759,13 +787,12 @@ fn send_command<M>(&mut self, command: M) -> Result
         Error: From<M::InitError>,
     {
         match SplitState::new(command)? {
-            SplitState::Single(command) => self.send_single_command(command),
+            SplitState::Single(command) => self.send_command_element(RpcCommandElement(command)),
             SplitState::Split(command, mut continuations) => {
-                self.send_single_command(command)?;
+                self.send_command_element(RpcCommandElement(command))?;
 
                 while let Some(continuation) = continuations.next() {
-                    // Turbofish needed because the compiler cannot infer M here.
-                    self.send_single_command::<ContinuationRecord<'_>>(continuation)?;
+                    self.send_command_element(RpcCommandElement(continuation))?;
                 }
 
                 Ok(())

-- 
2.56.0

