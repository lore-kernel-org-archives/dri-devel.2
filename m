Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CB1C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 13:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DCBA10E601;
	Sun, 27 Sep 2026 13:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BlxKO1mv";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013045.outbound.protection.outlook.com
 [40.93.196.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76D7810E600
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 13:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yP0jdj5qXtzMwqAomo95ICltgxulKCUV3d5ihQKuz4M70YG3wJEcEBtzpE2zHJqTxtbS9EGnWg7PEZZh+DwzZz6KyncO/+WrxkwMgVgNLd+YH7CmFaAi9DIK50pQMOzEy8jbZvDaYz3ueaTDY0ZsWyGMzMm2ca0HeGyP+pY/Nagdwc4UaWuyoLQrPrOGutAflv4TsuFZWLDk5sNxFraAT0CfF06aQvPExbqRUYxcaQ3vE4C6XHxmTycNsMZdcwzbj77xStFz3ZFFtbnJA1AZL1wAdWECue4wkqL5uP2qhNSWb3TkPg8ZIO8fTE6L1AKbQeMMQK/pmVoftzAJLexjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J58UP9m77CgHQ2AfymKtjpD6SDoyPQa9fe1LtnxmH3U=;
 b=A1c/JTfBfNsluKzyfT0OC0kw+pXar2XG8qroPQ3rGDm1SCr9g4rtx4QxVgPbsbgtqW2/GuhLQRqskBlIrxa8Pz8pogCcmdoVOxZhj7yWoS2esRusavh+kHVkkV/iE0xs27h5pbMr/eZ2+BJnltVpoL/5RtzAv4Vx4vd+4FIuM+mmXkEP+fXmT8FCwydu4iaqwfPm5oJooYrGLT4XYDkZdD8nTxfgLh//pNO7vNRejquzhjSeTboO7JDWObiWRlfYHIhxVC7QHypTjnvi6HpeXkTTJhZt5df+SOcYRvBomSEIDxskuWy0Qv5WDneSuRLtchTMlYDQiBvxmmECtY+65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J58UP9m77CgHQ2AfymKtjpD6SDoyPQa9fe1LtnxmH3U=;
 b=BlxKO1mvTexgB9hFj0GCogCYHuK8mlq5J6pdqCeqZgpzIGHqQF/FXc01iZtI3e3uL2dZqOku/ZW2kW/qi/GKaWtDkFzRhyF9ntppe/nDPlREXBswR01WL443Dmq+DkIzkNREqDsyDGrMB1Pk/giBWWZWMzgRAyq5FiX6xWMU5kQk/BTcDx+lYyfJ4eh0ri/jOU5SqhgmhKqghEtGaPEphs3ABoltMYBXFiiekDPUtRqr0AEZ1Gg89IEksZ4xgU0WuOmuGEhBjj9hArFtXRW6S0E7PZ4yOtiqk4s0AxQdEhiO2r0q2qCLtz/9BLjJSbLn1ihDTwM6qfH5U/BkhknmjA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 13:46:46 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 13:46:46 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 27 Sep 2026 22:46:24 +0900
Subject: [PATCH v2 7/9] gpu: nova-core: gsp: cmdq: move the RPC receive
 code into a sub-module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cmdq-rpc-v2-7-c3f66ae73be4@nvidia.com>
References: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v2-0-c3f66ae73be4@nvidia.com>
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
X-ClientProxiedBy: TY6P286CA0035.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b52499-6b8d-4267-e36d-08df1c9dc5ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|366016|23010399003|10067099003|3023799007|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1jYlnlF9dZKcFBDAhgPoP1YW8IuYP9VhGe8mu6gYxnuMtYQA0xkAIcM9Z2Ww3UIpC7eGnqjdM5EZoXvq8ddT3trL3hTmqKQ1JnK6Cj5/3CGMsb6/DGKivnSrD+FrDMXvcJ+8pNcyeFVSAxdgJif46UOKjWRoMXRiyoHYo9Vho8RYqz4+n1bbgtExVwBmUPRMH13ji9bR/2/gdeJF0YNBF3FemkrJPeDFUcxnEsHRd0A1IGNssTQoacFLYqlL1xSEblqk5rXjI5tF9rJAAJSsa/7iBt3m+Vm0jPAPoOjr0gCWd2bTNbCob6Ix6ww0AS9OHwIRUKue7OFje1RDyl78r0i/Bp9sXz+DYAOaOyDvYBsi1liPV8ilb7FfK03MXW5iY1JXqjuYqh05w2VH2LOrl6x0HksqPLyN85GGWVoMw/5Mc39RlM5ZCTaXrNACUJuVCwfWRdXsCSt01W/+6r0mMuLNrYcsDuE01GMg4v1RhF9V0SDUXVn+Wwo+KggL6JMmMH1jFftzFr+XMsTh9tqhr1RAPRoDZDIM2kweGSkwRVYa90NqYjN2F0aXYhyvZshCrs/1N7G4BQTRU1tFd7FDTcCOHPyT1HRO6lAwBoA+Na18PJByuDYzsqiYBDwA80elbvIz3oLt7+FqJUTE1wz3dfOTN48+OT1zjW7vxn4bXeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(23010399003)(10067099003)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWs4MU9XN3pFNmJXRjZQdnllZnc0Nk1lVFlJNlBsYUY1T1JLM2E2OE5LQUpj?=
 =?utf-8?B?QjZyOUNSMnAxMWFuWFlzZU5rV0xqaUgwaXluTEdwaG1oaFJjdFUyUFdnMy8y?=
 =?utf-8?B?a2Jad2lyeDlpcGNGY3pmZ291ZjZMMmZ0ZERCVFp2V2tSMExFZEM4ZUV3bnJi?=
 =?utf-8?B?OHNsOWExeXlzR2xBSUZ1UWY3WkYwNjJpVVRyL1NuTTBQcllKcGN2RHo4cDBa?=
 =?utf-8?B?ZExGWWtwUDhDS1daS3o4RW1TY24xUHBaSTY0SDM3OHFTcm4zTForcG1heHZq?=
 =?utf-8?B?SU1oMVhabFAybE95RFQ2L29JOFlXTE54SGo5eWQrYlJwZStYeENxYkZtQmJu?=
 =?utf-8?B?K2JyVmthQmx2R0YwWDgzS1dXR1RtTUVtclRSM1BBYzc5SVhDWUpHSWYyMk9Z?=
 =?utf-8?B?YTFrWmd3c01LaHp3M1RqKzRUYVdtV2hGZHNxQ01sbXRUTGlDWlh3eDF0WUor?=
 =?utf-8?B?SzdxREhrMDJhQjlYU1dTNFp1RDN1UzZzZDNoNXA5SWJZVlUrVzlocWNvQTcr?=
 =?utf-8?B?QXl4Wi9hZ1hMTUgzUWgzaFBQWXc3U0F1VFF6Q2h5c2RMZ0s5QTIrRlpndkg1?=
 =?utf-8?B?MVV1eDlNSGNEeU1UKzg0RTg0Z2Y4M2FSODJxMkhnTGxIbGI4RlBPWHIxSzV3?=
 =?utf-8?B?WGVzaXFpOUZYTGROK0VnbmZEVEFNaXp0dEtkYkx3UStlV3JNeCsxUnFmR3Y4?=
 =?utf-8?B?cUM4K1FGQzVjQjZlRHdaUFY5RFJEVjlpbkhyVjJSeEVzdEduRmoyOXZSa2M5?=
 =?utf-8?B?QTZOaVNlMXc2ZkJhbDFaN3d6aGhKSXhDd25SeUFtZjhqU0dUZDR4ajBaR0RD?=
 =?utf-8?B?b2JlYkROVXdIMGx0dmtkRzE0ZDJ6Q3VJb01kNXlyWkhWaHJ3N09DcWFvWU9k?=
 =?utf-8?B?NWNOR0xwWTkxaFZkSjZhVVZ4K3B0VGlYdzBWSVJoSU9PNFZ3Q1o0K2JlME5q?=
 =?utf-8?B?YldjU3NQc1NybXBFb3JnRjFVN2xkNzRUV0gvQnJQZFd5clV0QUhEZ01XcDhh?=
 =?utf-8?B?OXNJK2Z0L1l0alBIazRleVhtV21yeVRXMkppWkFCM2o4cGc1YjJaNUJtK0or?=
 =?utf-8?B?b1U1aEcyc0pVaWZUYjRiVmhPUTZjbERvTkN1ZzBrK0MyLzJtQ2JFUDVTUE5y?=
 =?utf-8?B?SFpLVEl6dUFaalVhTktCQnRGUU9ZM0twZys3WHdGUG9KSGo1dDFtQXVlaE91?=
 =?utf-8?B?UURzMDZ4VFVQM0p1WXJtK2JRYmUxbTM4bGY1NmEzcm9rODQrV0JqanVVcFY5?=
 =?utf-8?B?aFJhWnIySnhkVkJTeFFuTlNqNWVsUzhvNFJiclEzajRES3hBZ1lvMGNSZjRz?=
 =?utf-8?B?U3BDOGF4S3gwMjNaaWFXYVEyVi9vNDAyb0puM3RVN3VpUVA5ZlBqa1RSZW9q?=
 =?utf-8?B?dTRic3Nxeno0VE5FYTFpZzk2cVpMWDFrbHBrVEJMUFZkU2hHN2UwVGw4RW9q?=
 =?utf-8?B?V0t6TkdocHNLMUZNK2tRWE9iSnAveWdub2JpempJYTRmTUFzdzFwWldFc3Rn?=
 =?utf-8?B?UkcwUERrOTIrK0V5RjVSRWlIN29rVDZMWXdIKzViRnhyT3FlUlJ2S2loZC9r?=
 =?utf-8?B?TXFaQTY5VGp2OE9GZlp3Ykg1Mzh1VzZoRExaWUVNQ2dkWGtXTFdvQ3BVQXJ6?=
 =?utf-8?B?Qk5rTTNhODNNdVdjTEJuKzhzVDFsYk5Bd3VTYXFvcEwvdUFIUnZoQmd2NTU2?=
 =?utf-8?B?Z2x2Y0FudHFMS2VtVTBuOWE3ZHAvR1pGdGVpdXZqQi95SW1sMUJreWJLNk5E?=
 =?utf-8?B?bnRtTWRWK2tyYnNWUzNFM01tN3IxNGZGeCs3MzJyZW56b0RsSWVkOXBNb2Nz?=
 =?utf-8?B?RDFWOVpzN2h6VWJoNEpHcWtOSlFydS81b21BdVBWZW9mWEppSUtYdGtDMXgv?=
 =?utf-8?B?SE1USGRwRE5ZdDRIUWtZeWd0SnpPN2ozbldZU3ZxVDczd2VjMm1JSUtQWFo1?=
 =?utf-8?B?eDFCTUFKd2ZpZFp6N1RGMDhTUHhsd1ROOFVMRHpNcnp4VWtJV25mbnNCcVd1?=
 =?utf-8?B?S05ncjVGN09LUFhsd3M5bngvREltQmdHU3dweW1CWG41TVQ4aGRKODZoNnpj?=
 =?utf-8?B?dkxaYWMwMTk2b3UyWU40VU1BdU8zeE94V1RveFd0d0RkZlM5RTE2SUhXeXVM?=
 =?utf-8?B?eGd0SkpTMDEvRUdJSGx6QXNRcUpPOUdLcE10Yzg4UXlXM1V1UTZaVyttTDdF?=
 =?utf-8?B?RnBrbE1aa0VOZW5rZlhCY0dqcU92MUw2Sll3Q0YvUVY3b3YyZ0NkWngzVDBC?=
 =?utf-8?B?enhwVHFxaEpCellEdjBDK1RqTFpkNmx1NlRIQ2JaQ2NLd05ocFN2S3dQdEdG?=
 =?utf-8?B?NHJ1eHA3ZzM4ZDRTV2VsUnRGRGgvUEFNSXZFbUV0OUo5UmlubDN0NVhRTWhp?=
 =?utf-8?Q?5CgCI7YwTIL5xg3MII3nTonhQ0nLaG8wr5u6pSmOTaVFR?=
X-MS-Exchange-AntiSpam-MessageData-1: itJQtFCvkTzI4g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b52499-6b8d-4267-e36d-08df1c9dc5ba
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 13:46:46.3819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1KT/T5PUoKFfZJbpv1MsbDLfa+6D+BA6Wn8Ft1s2FdkqkI3HuuQ2okJMKAKMMbQT7jEN5BgXQnXy0vh4Dl0AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9687
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

Move the types and code related to receiving a RPC message into the
`rpc` sub-module. The methods are still declared as members of
`CmdqInner` and `Cmdq`; only they are now in their own sub-module.

This is a pure move commit, with no functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs      | 129 --------------------------------
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs  | 132 ++++++++++++++++++++++++++++++++-
 drivers/gpu/nova-core/gsp/commands.rs  |   6 +-
 drivers/gpu/nova-core/gsp/sequencer.rs |   4 +-
 4 files changed, 137 insertions(+), 134 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 169ef0865339..16e40a52fa57 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -43,7 +43,6 @@
     gsp::{
         fw::{
             GspMsgElement,
-            MsgFunction,
             MsgqRxHeader,
             MsgqTxHeader,
             GSP_MSG_QUEUE_ELEMENT_SIZE_MAX, //
@@ -62,29 +61,6 @@
 /// reply type are sent using [`Cmdq::send_command_no_wait`].
 pub(crate) struct NoReply;
 
-/// Trait representing messages received from the GSP.
-///
-/// This trait tells [`Cmdq::receive_msg`] how it can receive a given type of message.
-pub(crate) trait MessageFromGsp: Sized {
-    /// Function identifying this message from the GSP.
-    const FUNCTION: MsgFunction;
-
-    /// Error type returned by [`MessageFromGsp::read`].
-    type InitError;
-
-    /// Type containing the raw message to be read from the message queue.
-    type Message: FromBytes;
-
-    /// Method reading the message from the message queue and returning it.
-    ///
-    /// From a `Self::Message` and a [`SBufferIter`], constructs an instance of `Self` and returns
-    /// it.
-    fn read(
-        msg: &Self::Message,
-        sbuffer: &mut SBufferIter<core::array::IntoIter<&[u8], 2>>,
-    ) -> Result<Self, Self::InitError>;
-}
-
 /// Number of GSP pages making the [`Msgq`].
 pub(crate) const MSGQ_NUM_PAGES: u32 = 0x3f;
 
@@ -490,17 +466,6 @@ fn calculate_checksum<T: Iterator<Item = u8>>(it: T) -> u32 {
     fn notify_gsp(bar: Bar0<'_>) {
         bar.write_reg(regs::NV_PGSP_QUEUE_HEAD::zeroed().with_address(0u32));
     }
-
-    /// Receive a message from the GSP.
-    ///
-    /// See [`CmdqInner::receive_msg`] for details.
-    pub(crate) fn receive_msg<M: MessageFromGsp>(&self, timeout: Delta) -> Result<M>
-    where
-        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
-        Error: From<M::InitError>,
-    {
-        self.inner.lock().receive_msg(timeout)
-    }
 }
 
 /// Inner mutex protected state of [`Cmdq`].
@@ -638,98 +603,4 @@ fn consume_element<R>(
 
         result
     }
-
-    /// Validate the RPC layer of `element` and trim its contents down to the RPC payload.
-    ///
-    /// # Errors
-    ///
-    /// - `EIO` if the element is shorter than the payload length advertised by the RPC header.
-    fn parse_rpc_message<'a>(
-        dev: &device::Device,
-        element: GspMessage<'a>,
-    ) -> Result<GspMessage<'a>> {
-        let GspMessage {
-            header,
-            contents: (slice_1, slice_2),
-        } = element;
-
-        let rpc_header = header.rpc_header();
-        let payload_length = rpc_header.length();
-
-        dev_dbg!(
-            dev,
-            "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
-            rpc_header.sequence(),
-            rpc_header.function(),
-            payload_length,
-        );
-
-        // Check that the element is large enough for the message.
-        if slice_1.len() + slice_2.len() < payload_length {
-            return Err(EIO);
-        }
-
-        // Cut the message slices down to the actual length of the message.
-        let (slice_1, slice_2) = if slice_1.len() > payload_length {
-            // PANIC: we checked above that `slice_1` is at least as long as `payload_length`.
-            (slice_1.split_at(payload_length).0, &slice_2[0..0])
-        } else {
-            (
-                slice_1,
-                // PANIC: we checked above that `slice_1.len() + slice_2.len()` is at least as
-                // large as `payload_length`.
-                slice_2.split_at(payload_length - slice_1.len()).0,
-            )
-        };
-
-        Ok(GspMessage {
-            header,
-            contents: (slice_1, slice_2),
-        })
-    }
-
-    /// Receive a message from the GSP.
-    ///
-    /// The expected message type is specified using the `M` generic parameter. If the pending
-    /// message has a different function code, `ERANGE` is returned and the message is consumed.
-    ///
-    /// The read pointer is always advanced past the message, regardless of whether it matched or
-    /// could be parsed.
-    ///
-    /// # Errors
-    ///
-    /// - `ETIMEDOUT` if `timeout` has elapsed before any message becomes available.
-    /// - `EIO` if there was some inconsistency (e.g. message shorter than advertised) on the
-    ///   message queue.
-    /// - `EINVAL` if the function code of the message was not recognized.
-    /// - `ERANGE` if the message had a recognized but non-matching function code.
-    ///
-    /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
-    fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
-    where
-        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
-        Error: From<M::InitError>,
-    {
-        let dev = self.dev;
-
-        self.consume_element(timeout, |element| {
-            let message = Self::parse_rpc_message(dev, element)?;
-            let function = message.header.rpc_header().function().map_err(|_| EINVAL)?;
-
-            if function != M::FUNCTION {
-                return Err(ERANGE);
-            }
-
-            let (cmd, contents_1) = M::Message::from_bytes_prefix(message.contents.0).ok_or(EIO)?;
-            let mut sbuffer = SBufferIter::new_reader([contents_1, message.contents.1]);
-
-            M::read(cmd, &mut sbuffer)
-                .map_err(|e| e.into())
-                .inspect(|_| {
-                    if !sbuffer.is_empty() {
-                        dev_warn!(dev, "GSP message {:?} has unprocessed data\n", function);
-                    }
-                })
-        })
-    }
 }
diff --git a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
index 3bafe456efd6..a0e1e7e20ac3 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
@@ -6,7 +6,9 @@
 mod continuation;
 
 use kernel::{
+    device,
     prelude::*,
+    time::Delta,
     transmute::{
         AsBytes,
         FromBytes, //
@@ -35,7 +37,7 @@
 use super::{
     Cmdq,
     CmdqInner,
-    MessageFromGsp, //
+    GspMessage, //
 };
 
 /// Trait implemented by types representing a command to send to the GSP.
@@ -100,6 +102,29 @@ fn size(&self) -> usize {
     }
 }
 
+/// Trait representing messages received from the GSP.
+///
+/// This trait tells [`Cmdq::receive_msg`] how it can receive a given type of message.
+pub(crate) trait MessageFromGsp: Sized {
+    /// Function identifying this message from the GSP.
+    const FUNCTION: MsgFunction;
+
+    /// Error type returned by [`MessageFromGsp::read`].
+    type InitError;
+
+    /// Type containing the raw message to be read from the message queue.
+    type Message: FromBytes;
+
+    /// Method reading the message from the message queue and returning it.
+    ///
+    /// From a `Self::Message` and a [`SBufferIter`], constructs an instance of `Self` and returns
+    /// it.
+    fn read(
+        msg: &Self::Message,
+        sbuffer: &mut SBufferIter<core::array::IntoIter<&[u8], 2>>,
+    ) -> Result<Self, Self::InitError>;
+}
+
 impl CmdqInner<'_> {
     /// Sends `command` to the GSP, without splitting it.
     ///
@@ -191,6 +216,100 @@ fn send_command<M>(&mut self, command: M) -> Result
             }
         }
     }
+
+    /// Validate the RPC layer of `element` and trim its contents down to the RPC payload.
+    ///
+    /// # Errors
+    ///
+    /// - `EIO` if the element is shorter than the payload length advertised by the RPC header.
+    fn parse_rpc_message<'a>(
+        dev: &device::Device,
+        element: GspMessage<'a>,
+    ) -> Result<GspMessage<'a>> {
+        let GspMessage {
+            header,
+            contents: (slice_1, slice_2),
+        } = element;
+
+        let rpc_header = header.rpc_header();
+        let payload_length = rpc_header.length();
+
+        dev_dbg!(
+            dev,
+            "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
+            rpc_header.sequence(),
+            rpc_header.function(),
+            payload_length,
+        );
+
+        // Check that the element is large enough for the message.
+        if slice_1.len() + slice_2.len() < payload_length {
+            return Err(EIO);
+        }
+
+        // Cut the message slices down to the actual length of the message.
+        let (slice_1, slice_2) = if slice_1.len() > payload_length {
+            // PANIC: we checked above that `slice_1` is at least as long as `payload_length`.
+            (slice_1.split_at(payload_length).0, &slice_2[0..0])
+        } else {
+            (
+                slice_1,
+                // PANIC: we checked above that `slice_1.len() + slice_2.len()` is at least as
+                // large as `payload_length`.
+                slice_2.split_at(payload_length - slice_1.len()).0,
+            )
+        };
+
+        Ok(GspMessage {
+            header,
+            contents: (slice_1, slice_2),
+        })
+    }
+
+    /// Receive a message from the GSP.
+    ///
+    /// The expected message type is specified using the `M` generic parameter. If the pending
+    /// message has a different function code, `ERANGE` is returned and the message is consumed.
+    ///
+    /// The read pointer is always advanced past the message, regardless of whether it matched or
+    /// could be parsed.
+    ///
+    /// # Errors
+    ///
+    /// - `ETIMEDOUT` if `timeout` has elapsed before any message becomes available.
+    /// - `EIO` if there was some inconsistency (e.g. message shorter than advertised) on the
+    ///   message queue.
+    /// - `EINVAL` if the function code of the message was not recognized.
+    /// - `ERANGE` if the message had a recognized but non-matching function code.
+    ///
+    /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
+    fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
+    where
+        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
+        Error: From<M::InitError>,
+    {
+        let dev = self.dev;
+
+        self.consume_element(timeout, |element| {
+            let message = Self::parse_rpc_message(dev, element)?;
+            let function = message.header.rpc_header().function().map_err(|_| EINVAL)?;
+
+            if function != M::FUNCTION {
+                return Err(ERANGE);
+            }
+
+            let (cmd, contents_1) = M::Message::from_bytes_prefix(message.contents.0).ok_or(EIO)?;
+            let mut sbuffer = SBufferIter::new_reader([contents_1, message.contents.1]);
+
+            M::read(cmd, &mut sbuffer)
+                .map_err(|e| e.into())
+                .inspect(|_| {
+                    if !sbuffer.is_empty() {
+                        dev_warn!(dev, "GSP message {:?} has unprocessed data\n", function);
+                    }
+                })
+        })
+    }
 }
 
 impl Cmdq<'_> {
@@ -245,4 +364,15 @@ pub(crate) fn send_command_no_wait<M>(&self, command: M) -> Result
     {
         self.inner.lock().send_command(command)
     }
+
+    /// Receive a message from the GSP.
+    ///
+    /// See [`CmdqInner::receive_msg`] for details.
+    pub(crate) fn receive_msg<M: MessageFromGsp>(&self, timeout: Delta) -> Result<M>
+    where
+        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
+        Error: From<M::InitError>,
+    {
+        self.inner.lock().receive_msg(timeout)
+    }
 }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 03bd0d881934..25a5a8d33d64 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -23,9 +23,11 @@
     gpu::Chipset,
     gsp::{
         cmdq::{
-            rpc::CommandToGsp,
+            rpc::{
+                CommandToGsp,
+                MessageFromGsp, //
+            },
             Cmdq,
-            MessageFromGsp,
             NoReply, //
         },
         fw::{
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index dae34c11eb05..ebf13867746f 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -28,8 +28,8 @@
     },
     gsp::{
         cmdq::{
-            Cmdq,
-            MessageFromGsp, //
+            rpc::MessageFromGsp,
+            Cmdq, //
         },
         fw,
         GspBootContext,

-- 
2.55.0

