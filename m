Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86764C9833E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E58DD10E581;
	Sun, 27 Sep 2026 11:15:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BrM2iBiY";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C441110E54A
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 11:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qImJbfhXfEUcbrWUCim2NVmOymWyHgOCaQmwimeomOWGjHNJ1+wrr1lhc4rtZf1zeQNByrjOGI1r+sou4d8iwkOjTqzv1l4AtsXuCEWKS6mG9T4RrIbzHg5sP4c6rAUXfR55EMGDiTCpMjFFtVQBFHqzPt+BmThCdytk7crrMM6ZkyV/ntbuMZvjS6/xH34GCmNgIWofQDpYqHvnyFO3p1Icy5f4p6Ka7dm5qnRRHQMH5aeqN83OzM2G5ur8Z98QoJUzfiPUhrOtxQheKeYq98+RT9gZLUE/rSgNrA9zoWvBfTyLTtdkHnvtxzTmlKWBbdMYjXnObE3ahownTdjLDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9M0glkbLSRXoZo2icAVce5z8OLnohM7yEIpD7QQ9DFw=;
 b=g+0h7HKl0AC4GVV+vzdVN2H4JJxWZek341szF4j8Kki6fDtCMZgnJZP2b3U4g2MdRmb1qzwnDi/ezQenAoLrXQ7bkNHQEYK/0/y2O8pqDiWAP9uhGIqJA+wYizJJ0OMKaDSGBIoiuyrrjUcp1x6ok9fIZf5i+7uRKHGgkSY41iDJykOc1urkvmWV+6GOb0S1gs0J2J6HsIffN8g7HsLZfvLMa1fWfO/rszP8m2amcKKNAiJOlh4OAIKi1mqzeVfDzBqGb6yUeX1ea9WtINPj9BcMHFjTV21Q5ufn6q1VHNQpaKrrgU+f0gd2J2xHWwQ+B+NRRzpXNEy0IJ2A8EmeWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9M0glkbLSRXoZo2icAVce5z8OLnohM7yEIpD7QQ9DFw=;
 b=BrM2iBiYGjnPiizTzDAJCFuvA3aRhCOpUAdYKPGxfkfV1sCW8Q+zBsNe3qi1HNoKzTIM2+oL9UyMPH7YZyqs9P2Ja+RnrfMomws8VLseioAoBRzeZaFeaKZwhj8SqtBPD0P1fy6gFkz8MbIrHxfZ3nlI3lkq6uVB5//KwX9PljYzHAOlM0vmgPwqV3n8PaZuRvV0k56c/8/mE7Rok2dNU9sB89Mm33YyqPTMn5UykfkqgwMCuHGeAxFMH+tdG/M1eCxwOQ6x3DUhfepIlRspnj8uYFAW6BfyRub8o6II0O6ic35hrB0z8vd0citFBYn+g1CoMo+RgRp33n1lk+i4sA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 11:14:53 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 11:14:53 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 27 Sep 2026 20:14:30 +0900
Subject: [PATCH 08/10] gpu: nova-core: gsp: cmdq: move the RPC receive code
 into a sub-module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cmdq-rpc-v1-8-822db5af910e@nvidia.com>
References: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
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
X-ClientProxiedBy: TYWP286CA0014.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::20) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 5815b074-50e5-4f40-773d-08df1c888db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|10070799003|23010399003|22082099003|18002099003|10067099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: U4nM5xdt8tKc26yY7iKZmFfQ5z0Z1y0/OJtaUqf2A9Wbn/PWKdFcvFg7rKh5MNmDUnYD3sM0Zs/iXBbbnA7dCzhgkdt955fjFY/1SW2hVqHkrk0Lru2j6yYGHmVfpjM/znqh33tNcaDS48U3MkvArN9tRyL6Y12atVcpctEfHY44oozvKiU1jQNsFUzRyh/cZgSST/MZBxdEy5gK2Ci/QhOA6SbELihJW5VrweSOCgk9/0tPKj/UwdR59jheSdFIWDIOMcQqIdaV9mfa/cujhSKNCrs9lYXnAAR8DPlJDHOFnokarjatprUEymwkX8vtMYpwLceBmwWMXibOvUbN0keXj+FyJ2XhCE0ZbiyGQ0B9TgjLkbgAggrOBEz6dZJpptyGqex6JOcM65qcQL9TWqWYTGzZ0MRv7rDOGl7vtTBsXjkKJUlvtpXQBrT3lmeiASyf5jEp8uqHipClWsGxHIkMZccUPDNWubdWsj27g5hmzN/SnT9XflAQ4jSWoCB+kld4GWFLuxhp81RN14SiET2Mo8sIhfoWGYOvAN1ZBAGh0HJuzhaPtlbnJah7dPa9foZenzuxFCn6hOyG5P2N6DoSEoX1I07upNyQfPfIgLjVkKtEb4bwz6x1ke/sAiuijcLRa354e3q7RHmDFyHhvjok08I+/Mea6if56M4C4Us=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(23010399003)(22082099003)(18002099003)(10067099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG51d0NuanZ0Ylc3S0tWNnEwQ0c3SnJYK0toV3NSWXRNVmhOWXU4K0RLV1dD?=
 =?utf-8?B?dnBTZXU4Z0cxVFlRWXNKQlhkRk5uR3B6RXU1RTVYWjh3eklIMWhaSDBrVGsz?=
 =?utf-8?B?ZHY1czhvQTJXa1NyTi96TVJoRU9jK2p5UlNSeVUzL0ZnT090UHFWV0ltcSs0?=
 =?utf-8?B?VmhUNUYzK0xKMEZFdkFmZUd2VlJkUGhrUnJLcTAzeGxpUHFOR2gzbCtndjVw?=
 =?utf-8?B?ZEpZQ0hrK1YxVGdRMTFsRWlZVGxnVE4vaGxWK3BBakQyaVI3c1dSRWNlSGVX?=
 =?utf-8?B?UCtwMkFJRDFLTFRtSzcrQWVtZm5Ea1JZRFYzditoemZRME5QRDYwSXBGSy9F?=
 =?utf-8?B?M0l6WWFRRW5WalJ6VElDR3MyNE1RQk9PZUlIZkhZdWNvSmNadFlkRUtralZF?=
 =?utf-8?B?eG1oTWZmNUpJN1N0M1c5aVdhaHZ0MXM1ZEhYUG5ydWhHN09pNDJJVGpPcVNZ?=
 =?utf-8?B?Tm5QUWU2V3FTZzJRWnp1OStWbHZWdWs5OEtpOU1DRHF6YndzaGVuZTczRjc1?=
 =?utf-8?B?aUNOZElBOUh2Q0xSaEFhOEt5TGdoeElvSGsvY0FCRkV2MUxrY1pNdGsvTzBZ?=
 =?utf-8?B?VFVhV25Cclg0N3hjd2FDY0JVdHgrekRTYnVUNkZ2STZ3NDhHN1l5dmZaRWFr?=
 =?utf-8?B?WGJVdU0zc0NEcjBBSnNJYmlyaWE2dTd0NkZtQVYzc2l5S0d0TDdjcFBXTjh6?=
 =?utf-8?B?YjMvSU51Y1BhZDkxZ0FNd0hXUDhiaThWbXFxN0tNb2kzZnBQcDBpVkp4d0Vh?=
 =?utf-8?B?YzZ6bjlqZjJMb1NzZTdabHp1WVZlN1licTdBWlk3ZUpsRE1KdCtZeTEzSWZ4?=
 =?utf-8?B?RnE4R0JEUWo4eS9LS3VSRk5RVC9lcXpKN0JzVTNEakE2NGU2d2g4czYwUHFU?=
 =?utf-8?B?MWFidVNFU1RORm9BdnhoL2hUZUpVRjg0MExCSEtyZmFuK1VlNUVxT25OL2Ji?=
 =?utf-8?B?RVc2TGhjek1sTEliVzBhVVo2Qzc1N1daQ01YWkFySGxYVk1yWklSVE9GcDZD?=
 =?utf-8?B?alRpTWIrdUtTNzF4elBkYTFLQkxvWUR4RlEyRFJEemNCRWxwMXZnREE5UWhX?=
 =?utf-8?B?cWdNcE1jRWlaaEtHMnNJdG5ld1JwWWFqQ2JzRUJlaGhhOWVTTTJkalVGdDNG?=
 =?utf-8?B?MldPNksvZUxrYkRqT2VhNFJaY09ValU3b0crMkhHL1hGdzVUSWdZczF4YytY?=
 =?utf-8?B?TnhYNFdQci9ZZFVqNllLSTdmbmZ1ZFhpbmY4UDhzZkJ4T0xHaW5UbkcrU2h6?=
 =?utf-8?B?bHlOL3N6WFZ1cXFpTHVESG5OZTZMNG5oUitMQ0svWmI5SFhEeGJUVzUySERV?=
 =?utf-8?B?Ujc0czFLVHhFdTRrWS9leENaZTkrcVVOREROdzY5U1QyVjJaRUNSbEhCY2dm?=
 =?utf-8?B?OXZtcWt6SDBUSUN1MFhXTDJ6c09OdVg4a3BYNUQ0VXpYWUV3RGxabUhQb3U2?=
 =?utf-8?B?M3Myd1BRYkVyY1JwVDhZeGFaQTQ5MHd2Z3JUVldpanUxb2lObXVrZ2NnZG93?=
 =?utf-8?B?aFVoSmQ2ZmJLbHMydE00OXlrcXdjUzVUdEZPQmJZVmFQRjQ5MjJ2MVZrLzli?=
 =?utf-8?B?M3h4UnRTOHNIYzJ0TlhzYjRrTlBZeTZIa2kvMHNkekppdEtVVFNKdUl5aXNC?=
 =?utf-8?B?ZnNMQWRJNjJOQTh3ZG1DeHl6UWNJQnJOYml4UUhLcGlQbzBzdjVta0N3NHd2?=
 =?utf-8?B?eWJtNTdxN0VWa205bkNlc0lDSi9hN3lXd3U1TjFnVmNMWlBWUEJTbWU4T0lM?=
 =?utf-8?B?TGVSMG5oS1FESWFFUTBRTTlvbTVtSHBicEtPb09vdzRuenF5aThpaEIwQ1BD?=
 =?utf-8?B?MStVYTZzU1Q2cEdYVmViL1ZtY3A0ZS9lRmdQUVB2Um00R0RhOFU3Y0dsSnZy?=
 =?utf-8?B?TEpBTWlmNi9teEhGY2x6OWlNVFBSMXFlc2JVVlFubmZnVEhNSnF1MnF2OXpG?=
 =?utf-8?B?ZFEvdnhRVU1rWTZFa3hENkd2U0t2bVpaVVJOL0w1Q0xGU0gvMlNYdE90eFJp?=
 =?utf-8?B?anZYOVd3RkxRMjFmcU5MaExGUWFGWDU2Q1lpVUFrMk5qZ2FGNThnT3R2eFVv?=
 =?utf-8?B?VTlPd0IrT0x0SXpneENINEhUcU1EdWMzVkdIRUVGS2lSRFJLeWVFcDdLWHFR?=
 =?utf-8?B?c25kSzA0akNVblpzZkRkeUltM1ZJUWlxQjZ4YWloUFZROTNKNWRsYjBTeGw0?=
 =?utf-8?B?NUNuZkpzMExMTmlXbjdXN3JpejZQM0ZDV1JZS2d3ZHdXWm1rcnJvWndydU5O?=
 =?utf-8?B?N2xiSXlQR0xXcjNsZzJaVER2RGhXN3lDSk5SdVVFeWFoY1QwR1B2OHh5QUtn?=
 =?utf-8?B?VzRSdEpQaW55M3c0aTEvSmFsaEJ4QS9PZnY0cEFsZVVobDc4a00rN1pucjNU?=
 =?utf-8?Q?qErLNYSCA+IUBFDIx8+sxIwCWUITZFsMlcLxZn8bUV1wd?=
X-MS-Exchange-AntiSpam-MessageData-1: CjXso/zHf6O+Ug==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5815b074-50e5-4f40-773d-08df1c888db0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 11:14:52.9165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0huy28x61rwSFXFN3JHP9xe9Xf+aTTdw6IwduF6DaP+GaK2v27bmbX7SR3qJuIFiBCuZe5+8LRF8VuhgR1m+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154
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
 drivers/gpu/nova-core/gsp/cmdq.rs      | 130 --------------------------------
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs  | 132 ++++++++++++++++++++++++++++++++-
 drivers/gpu/nova-core/gsp/commands.rs  |   6 +-
 drivers/gpu/nova-core/gsp/sequencer.rs |   4 +-
 4 files changed, 137 insertions(+), 135 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index d50a2a594f82..ea395c70324a 100644
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
@@ -613,99 +578,4 @@ fn wait_for_element(&self, timeout: Delta) -> Result<GspMessage<'_>> {
             contents: (slice_1, slice_2),
         })
     }
-
-    fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
-        let GspMessage {
-            header,
-            contents: (slice_1, slice_2),
-        } = self.wait_for_element(timeout)?;
-
-        let rpc_header = header.rpc_header();
-        let payload_length = rpc_header.length();
-
-        dev_dbg!(
-            &self.dev,
-            "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
-            rpc_header.sequence(),
-            rpc_header.function(),
-            payload_length,
-        );
-
-        // Validate the RPC layer before returning the message.
-
-        // Check that the driver read area is large enough for the message.
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
-    /// The read pointer is always advanced past the message, regardless of whether it matched.
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
-        let message = self.wait_for_msg(timeout)?;
-        let function = message.header.rpc_header().function().map_err(|_| EINVAL)?;
-
-        // Extract the message. Store the result as we want to advance the read pointer even in
-        // case of failure.
-        let result = if function == M::FUNCTION {
-            let (cmd, contents_1) = M::Message::from_bytes_prefix(message.contents.0).ok_or(EIO)?;
-            let mut sbuffer = SBufferIter::new_reader([contents_1, message.contents.1]);
-
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
-
-        // Advance the read pointer past this message.
-        self.gsp_mem
-            .advance_cpu_read_ptr(message.header.element_count());
-
-        result
-    }
 }
diff --git a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
index 3bafe456efd6..335f94c4d2aa 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
@@ -7,6 +7,7 @@
 
 use kernel::{
     prelude::*,
+    time::Delta,
     transmute::{
         AsBytes,
         FromBytes, //
@@ -35,7 +36,7 @@
 use super::{
     Cmdq,
     CmdqInner,
-    MessageFromGsp, //
+    GspMessage, //
 };
 
 /// Trait implemented by types representing a command to send to the GSP.
@@ -100,6 +101,29 @@ fn size(&self) -> usize {
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
@@ -191,6 +215,101 @@ fn send_command<M>(&mut self, command: M) -> Result
             }
         }
     }
+
+    fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
+        let GspMessage {
+            header,
+            contents: (slice_1, slice_2),
+        } = self.wait_for_element(timeout)?;
+
+        let rpc_header = header.rpc_header();
+        let payload_length = rpc_header.length();
+
+        dev_dbg!(
+            &self.dev,
+            "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
+            rpc_header.sequence(),
+            rpc_header.function(),
+            payload_length,
+        );
+
+        // Validate the RPC layer before returning the message.
+
+        // Check that the driver read area is large enough for the message.
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
+    /// The read pointer is always advanced past the message, regardless of whether it matched.
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
+        let message = self.wait_for_msg(timeout)?;
+        let function = message.header.rpc_header().function().map_err(|_| EINVAL)?;
+
+        // Extract the message. Store the result as we want to advance the read pointer even in
+        // case of failure.
+        let result = if function == M::FUNCTION {
+            let (cmd, contents_1) = M::Message::from_bytes_prefix(message.contents.0).ok_or(EIO)?;
+            let mut sbuffer = SBufferIter::new_reader([contents_1, message.contents.1]);
+
+            M::read(cmd, &mut sbuffer)
+                .map_err(|e| e.into())
+                .inspect(|_| {
+                    if !sbuffer.is_empty() {
+                        dev_warn!(
+                            &self.dev,
+                            "GSP message {:?} has unprocessed data\n",
+                            function
+                        );
+                    }
+                })
+        } else {
+            Err(ERANGE)
+        };
+
+        // Advance the read pointer past this message.
+        self.gsp_mem
+            .advance_cpu_read_ptr(message.header.element_count());
+
+        result
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
index 4322a4d554f9..81bd457a6eb6 100644
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

