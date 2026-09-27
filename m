Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1CBC9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 13:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A086010E600;
	Sun, 27 Sep 2026 13:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jXNNaxW/";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80B6510E600
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 13:46:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtjGU514rxMQlNKPNxkL1UY92m8j6+PAtsWkXEGxZOVaIlkFM5ucVa1QVO0CnZghjkPZEzjhGCsLz6Bh6rZEFA3v0E/egiihYLraOTPNN1fUvULhfe7LbRdRsk9HEgC0XCm5V8s6QtMPsvATjrLliPq2jyNEq9Bbxy8ccF2B+yPf8j7kelpBAVT/9LxyTvsMhVULBb16cm5pRn0sqUt0+TSPYWVA0vV0MxbMPig63OhMBhoP8Y4bxR/rXmpbx9xt/S8KnJNG7W0rlDymEYxD/kOWGUdB3zJzGm1g8CaEWfIFRqHqZZuNkoaE18I7ULNZ9VxiQDNQZVm6UT/HSFYcsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2efSOFIUWPvVkHBocs0LgWtj6qeypB8IMYX+4ltKLG4=;
 b=V5EZbbauUt9w/cMD99HBrBa4y1DPLRO2sd80e9oPcqkwoIGbvc2rbyMCwQq135YKPKQBTvQMj38LgveNfO1yOTFSkNT2fkQ+qIkxlE0Uy6wKxYlyYme7RiG7c4Qi20Pntf+JDNYR2rXeTUNaO87g8aYSs7CzCzoNOjOXBeFSruyFOMlHNoS+Ql3TdEZrVDzQzzgWay1TxTlxMBqMHnC3MEn3W2jORgf+l550YvdhMhwFLhtL960lRNSqg72bhlv3hpqC3xeWswvNNRm0wYWNoNHbujkMgknY9BsN+4nV/HQ3SzBWZw3W1d59/I4w0jfKx39OV6a/aDCIXwawxU/MiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2efSOFIUWPvVkHBocs0LgWtj6qeypB8IMYX+4ltKLG4=;
 b=jXNNaxW/VkTyF9vAywrrBYQy4lFEA19PgqMxQPV1qyypYEBb8zaTCslo5uf7pv5uqBnu5EiXGKI2l1Ib3/Eq4pXNq+LnMy3xfFtBnyKMqkzcT+kDbKoEM6HNPQ0mPfg5oZj85NefempyS0FugLT1oc1Xxbg2CjIuYQrkkm8F/Nc+5Zw8G51n46GlJqWY6nAcQ6ybPczd8SSYk6Bi2dzaLxyh5lBk4Y9lGdfe/gQw9hqcLERYpBAEPDb9BtzAiSVqheqAvPlun+0lL1lczINCZ2lLMZ3wGewtuaSgr4fngFIdHPXZTCxDx2JqHYtjYsuS9Sacbc15L5NY/os68KIPTQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 13:46:43 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 13:46:43 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 27 Sep 2026 22:46:23 +0900
Subject: [PATCH v2 6/9] gpu: nova-core: gsp: cmdq: split the transport part
 of the receive path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cmdq-rpc-v2-6-c3f66ae73be4@nvidia.com>
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
X-ClientProxiedBy: TY6PR01CA0039.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1bd93b-4844-4211-6d8c-08df1c9dc3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|10070799003|366016|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dz/6FIF51M9dTCIrWvt3iu/qN6yvgaJ6A4DOYKIIwQED3tp9mVMDBTExLPLAlYD6jZog1hVL1DQvnEy2DHQq8vn51NtoMH1JDiXPHjj9qiNry+xj1K9CBaAlpz6dbZwc7BXiFHob/UVWcScL/a3KDxoK2PstPJFYjOhbj5nmVykg6eyr0nl0jCRuv1lini3ETwgrO8qXzN/jvChLDxX0vPE8XJ7neckPVb8XqOonILw/vJCpIZD30iGnjOb3gNYgChnISvkrDzKSXjh/hNCWYw1a79mcjZNs5T9UrnXocRpA7Ey2ZXry7CNfZEtJfH3TjBnFZ0QB+BGR4v245qVJ1OCFOp2FwsLCZhPvdGNUZZ55wR1z0k4jOdr7vM7YR/35w6pOJJtco+ly2MpmEkggaAT6gKvoEG1BppNicbC4v36VtASpVV3OwUCdUiv0ESZq/HYOHlkWW+v7E/kZZ7LzkggVZEJwZrk8ys1CYubMQwXWapcgV5rAug4JN86aD2ABabBe11HxBeUrflyKWXS0hT38K9MrNUlBMqlvuiZQm2iE1uqcVTXAhYxBbsHxM34V1pB1kNj1S4kZNfSftk4YXebIaA6FKeY0lMoydmojv/HcyikEI8P9oRehqqLyWm9PKmCJz175Y1LCWXH/4+ksxX0tfj4/jgfEcIt0Wr4T/AQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjhrbWc4UkR4OFdkd0JDeVNzaWJmQ0tTUS9MS3FiaG0xNk9hcmo0OTZlaHMy?=
 =?utf-8?B?V1lJdmVnNUZESFlHTmUrR2s2bE55TTBDZncrR2hUajYrQW5qQzkyL2E5ZWJX?=
 =?utf-8?B?RzIxNWt0UEFnVXpmV0V6cTFycVBodFRXUHJHRkdmSTA4NGxpNi9sVFB3OGM1?=
 =?utf-8?B?Rzh5Y3JPRHdKR0YxcTl0V3ErVDZnbnlmVlppUVd0Z1ZpZ25XaXNPZmV2VUFX?=
 =?utf-8?B?OERPUXF3OEdUQWpENUlsT2pZY1M2Y2FMUEQvdzdsRkJaZzBycUttMWk3eDRL?=
 =?utf-8?B?cWNwVDVLL3YraHg3SjVpcjcxS2pHZ1h0UzJSZnpUTFMyUmdsbFFlQm5uV0ww?=
 =?utf-8?B?anhvNy82KzJVVUVFNnlKeEZmQVRaZEE1RFhzaFJuVWZDVytReU9DUUNDT2Vp?=
 =?utf-8?B?VDdSSVhnSWVVRFVQMlZiWS9URWxiRUVXS0ozYzdSUllmQWs2WkdXREhuWGhk?=
 =?utf-8?B?ZDJKTnlUY3VsV29TM2VHSjBJejAyY0NBWXVkUTdRcmFBeloyTlRoWmpSTTlK?=
 =?utf-8?B?c1MxdUdVNzZjQll4RGhLdlRVaE54bEJMMW1lcEpVKzRsckFBUlZKTVpyOCtS?=
 =?utf-8?B?ZjkzTzRkN010cVZhakhjeThZNlQzclBncjhNV3pLMzViTXRaMDV4RTh6NDl3?=
 =?utf-8?B?ckZHeHI5dDN0UEo0MjVNNVk5MHc2WGZtRkNwdGN0eFdZakJkcDZQelRlRnNj?=
 =?utf-8?B?ekRYUHE3YlZaR25VUGgxd1EzODBBZDl0ZGtQNjdzRHEzNEhmVW1Ma3pJMlYw?=
 =?utf-8?B?NU9Oald2N3FnUDJoL2RIZkxZU1VUUzA3N3JoQjAwNnZZakpsNW9IZDdnUVNC?=
 =?utf-8?B?b2ZLWXFHL05CSUJMcVkrU2Z3V1JrTkFCaUhucGtBRGNtZTdzcGNQeUtDUTQv?=
 =?utf-8?B?NytTbE9CeWR2ZXhsSjJmaGhXY0kxdVJlUnUxaCttUkxPbG9JT1AzS1pMOEFV?=
 =?utf-8?B?cFVpakFkMWY1RDFZQ2pIZEI2M09LeDdZYkQxY1hIR1E3MmFTUFdOQ0hDSW5R?=
 =?utf-8?B?aC9VaHEwbWhWNFlrZUlNR3N5dzZpbkhXTVV1Q003Nlp1eVlrMnVYTWxoNGl1?=
 =?utf-8?B?VXVUS1Y2TTFpNERFdlNLSHBDdHZWR1NZZTlqcHhkb1dJc29UYWlSVkgyTDFi?=
 =?utf-8?B?a3BHVGhEZFRJam8vWkhpM0ZVQWZIdjg1dkNGUVNVdjlOeWt1R3EyWjUySGxB?=
 =?utf-8?B?UXpFQnEwT3hONkFtR0Rqc3VwZkNzSVRTNUw2MDRPdFZ6bU83SWF6RU1WWkhq?=
 =?utf-8?B?ajgvc1BJVmxsaTdjUXd6amNwZ3hVbUZ2TTdrb1hTMVZKNG94aFJCWFVMK1pz?=
 =?utf-8?B?Z1FteGJiY0RxRjRtVThCeDUwMGhWT1VXRVdXODFPZlFYdXhZZGV4UGdEK0M0?=
 =?utf-8?B?NENrRzJxcURIVTRIRzBKYlB1U3pwL1lMYktYQTdvTGZXQWdramx2a1JLNDBO?=
 =?utf-8?B?NC9NQWRISncxa25Da0RieVJKc3dJVy9sY05tNTZJTHRRRkJEVG9tUkUzdnpS?=
 =?utf-8?B?dnhocVo3anVFZlh3MlNhdGdSNXdOMGJORjU0M3h1b21xV0dtdXlqY3hOOXpN?=
 =?utf-8?B?Z3dKQTJPRElIZER3dlFGb2U1SldJUVN3VjlLMXlXZWI2QmZHbnVEaTN2SVlK?=
 =?utf-8?B?cnBmTDFkZEpaOUZzdXRlSEt2Z0hnV2x3WVZlVGZMc1JVUWtrYWtWcGxUTGhK?=
 =?utf-8?B?VmRSTW9OOU5nK2hobDBPMTR1SUJvcS9lS0JHTzZLVzVUV3FWOVNraTNhK1Bs?=
 =?utf-8?B?RmZ2UFNVQ2lJRU1uMzdZUWN5VkhuQkpjVTBib0tEZnlNd0RxbHU1QktxQlNl?=
 =?utf-8?B?elh0OUlMbWMxRzBueE9rVmFzNkZnajZHVHhuU2h3SUF3U1hoV1IyYmlhSWRi?=
 =?utf-8?B?ZThvVzNaT3lUdGFzTjJXYkQ1NDVyVVk0RWRGdzQ1a2RCSnB2S0w2MUlvZUNS?=
 =?utf-8?B?cWlkNGtSVVpTTnRDL3h2NStocmZrMVlZRHZuSS9OZ0RwUWU1TGNzNzBWMVBS?=
 =?utf-8?B?Nm5zdXpTaWF6WmVYYlYrL2sxdDhBQ3VySHgydTQwQU1BOS81L1hhK1JtaDB3?=
 =?utf-8?B?U3NvVlVKNUliZXBKY0E1MHB4QU5yK2ZGcGw2S1dOWi9GbTd6ZVU3ZUpmVU01?=
 =?utf-8?B?aitESjlkSkNSbFRwZHZHMWhPWlpVODdiZjVFVSs1MzBXQWF6V0UxQm44RWQ0?=
 =?utf-8?B?ZGVWa2I4TC81OXBRRTRualhmVGIybHlhWkJpVGxxYmw1NDVwekhWRGQ0VHZ4?=
 =?utf-8?B?RDIzeTJoSVp6a2xqc0lsSWE1ejUzYndCYmUvM0NsU3FuZVZDQ3dCWERNQXBT?=
 =?utf-8?B?aFBFZi9NU0wxajZ3aEZSTHR0RlhOcmZ6ZVB0eC92ZFdCdXBtam5SQlFYQVVL?=
 =?utf-8?Q?lqvN8KoDq8JOfN6+EykcmlZ5oOHE4g9XFktVnE+3RqLOQ?=
X-MS-Exchange-AntiSpam-MessageData-1: ++ebJJPZgo0HUw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1bd93b-4844-4211-6d8c-08df1c9dc3f3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 13:46:43.3766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UM9Z/T9dzYBFzDpYq//5QppvzCJ7I4C2zjLuE2A76spT2sCZTyGUSOYT4ebQnZFtR42syrRqL9Kw4pYNyp1Scw==
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

`wait_for_msg` mixes two layers: the transport layer which polls the
queue, extracts the element header and validates the checksum, and the
RPC layer which reads the RPC header and trims the payload slices to the
length advertised by the RPC header.

Move the transport layer into `wait_for_element`, and introduce
`consume_element`, a transport-level method which runs a closure on the
next element before advancing the CPU read pointer past it, and
`parse_rpc_message`, which validates the RPC layer. This sets things up
for moving the RPC code into its own module, leaving the transport
  agnostic of the message type.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 91 ++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 640afe2e29cb..169ef0865339 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -411,7 +411,7 @@ struct GspCommand<'a> {
 
 /// A message ready to be processed from the message queue.
 ///
-/// This is the type returned by [`CmdqInner::wait_for_msg`].
+/// This is the type returned by [`CmdqInner::wait_for_element`].
 struct GspMessage<'a> {
     // Reference to the header of the message.
     header: &'a GspMsgElement,
@@ -566,7 +566,7 @@ fn send_command_element(
         Ok(())
     }
 
-    /// Wait for a message to become available on the message queue.
+    /// Wait for the next element to become available on the message queue.
     ///
     /// This works purely at the transport layer and does not interpret or validate the message
     /// beyond the advertised length in its [`GspMsgElement`].
@@ -584,7 +584,7 @@ fn send_command_element(
     ///   message queue.
     ///
     /// Error codes returned by the message constructor are propagated as-is.
-    fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
+    fn wait_for_element(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         // Wait for a message to arrive from the GSP.
         let (slice_1, slice_2) = read_poll_timeout(
             || Ok(self.gsp_mem.driver_read_area()),
@@ -606,18 +606,65 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
             return Err(EIO);
         }
 
+        Ok(GspMessage {
+            header,
+            contents: (slice_1, slice_2),
+        })
+    }
+
+    /// Wait for the next element on the message queue, pass it to `process_element`, and advances
+    /// the read pointer past it.
+    ///
+    /// The read pointer advances regardless of whether `process_element` succeeds or not.
+    ///
+    /// # Errors
+    ///
+    /// Errors from [`Self::wait_for_element`] and from `process_element` are propagated as-is.
+    fn consume_element<R>(
+        &mut self,
+        timeout: Delta,
+        process_element: impl FnOnce(GspMessage<'_>) -> Result<R>,
+    ) -> Result<R> {
+        let (elem_count, result) = {
+            let message = self.wait_for_element(timeout)?;
+
+            (
+                u32::try_from(message.header.length().div_ceil(GSP_PAGE_SIZE))?,
+                process_element(message),
+            )
+        };
+
+        self.gsp_mem.advance_cpu_read_ptr(elem_count);
+
+        result
+    }
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
         let rpc_header = header.rpc_header();
         let payload_length = rpc_header.length();
 
         dev_dbg!(
-            &self.dev,
+            dev,
             "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
             rpc_header.sequence(),
             rpc_header.function(),
             payload_length,
         );
 
-        // Check that the driver read area is large enough for the message.
+        // Check that the element is large enough for the message.
         if slice_1.len() + slice_2.len() < payload_length {
             return Err(EIO);
         }
@@ -646,7 +693,8 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
     /// The expected message type is specified using the `M` generic parameter. If the pending
     /// message has a different function code, `ERANGE` is returned and the message is consumed.
     ///
-    /// The read pointer is always advanced past the message, regardless of whether it matched.
+    /// The read pointer is always advanced past the message, regardless of whether it matched or
+    /// could be parsed.
     ///
     /// # Errors
     ///
@@ -662,12 +710,16 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
         Error: From<M::InitError>,
     {
-        let message = self.wait_for_msg(timeout)?;
-        let function = message.header.rpc_header().function().map_err(|_| EINVAL)?;
+        let dev = self.dev;
+
+        self.consume_element(timeout, |element| {
+            let message = Self::parse_rpc_message(dev, element)?;
+            let function = message.header.rpc_header().function().map_err(|_| EINVAL)?;
+
+            if function != M::FUNCTION {
+                return Err(ERANGE);
+            }
 
-        // Extract the message. Store the result as we want to advance the read pointer even in
-        // case of failure.
-        let result = if function == M::FUNCTION {
             let (cmd, contents_1) = M::Message::from_bytes_prefix(message.contents.0).ok_or(EIO)?;
             let mut sbuffer = SBufferIter::new_reader([contents_1, message.contents.1]);
 
@@ -675,22 +727,9 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
                 .map_err(|e| e.into())
                 .inspect(|_| {
                     if !sbuffer.is_empty() {
-                        dev_warn!(
-                            &self.dev,
-                            "GSP message {:?} has unprocessed data\n",
-                            function
-                        );
+                        dev_warn!(dev, "GSP message {:?} has unprocessed data\n", function);
                     }
                 })
-        } else {
-            Err(ERANGE)
-        };
-
-        // Advance the read pointer past this message.
-        self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
-            message.header.length().div_ceil(GSP_PAGE_SIZE),
-        )?);
-
-        result
+        })
     }
 }

-- 
2.55.0

