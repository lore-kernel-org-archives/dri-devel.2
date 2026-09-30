Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0177CA5FCD
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E927E10F456;
	Wed, 30 Sep 2026 14:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cqioOyqL";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011012.outbound.protection.outlook.com
 [40.93.194.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D8410F430
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 14:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3bQvzVuJXzDL5T0dJ2vLPc1A9GTU6dLPu1+4yablm0klOTtUaRK19nCi+r0OKZsc4kmaWwQ7KNqaCzyCumVro44R3WLNnVcE7RY7n/w5VNoo5JhbtwOSBRJ4gUEylSR/iB/iyuEsooek3W3PhoUoDFsKpVPClEviKAfE219AWV/r+LNcwqb+xwNZleICgOQ3gqlS4vfAyjr4wKvpQcRywAgfsjp9qIULQq/NnE3mBVlf5l7I5Ekcs67oTleVCfKpy75s6TNgFyEAtvY0VKAF3wwMXgqqTAaZo6UjjDxm0uVozKxWoCvaUZJzb/9xTr2nDmAY8K9+sQruvIPj5ceIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENoGO1RMKwpk5Vx16msvgGiqJc/zAGHHFwP8Ykv38jw=;
 b=UQmrexUAr2r6sH/eMHmQcrz7lIHe/jphH1PJlLBzewiFvPAM94XTd0K1TARSoCOGSwJ1DgxntbODjBtN7uVegjLQTMRoLe5qj5FPFgGzGCT3LzNxyH0zcZLcz0R1/nelRVKzcann6R0HniI3Q+OdBG7gumA+TkQccUWA0jo7KIK7+u9OCgF8NSlPTslLfCMX+6LNAf+E9XuPue3p47Ggud2r1RPp2DOBJGk025tQ+zOPncSpbRITI9D8qQYTC9IWudoyj91ksI9V0r4008RccJ1NdYUIy/QJ6X/VizVsDTO4xa1gOcKHodXqrvN27K0mlRSk/4AhjBAFMoI2idaQJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENoGO1RMKwpk5Vx16msvgGiqJc/zAGHHFwP8Ykv38jw=;
 b=cqioOyqL7+LKJ+70VmgZOObKzVYI3g/6+cZ4xIHC0affPGSLi4S67Lja93gLfUTEuJQ+AvYBWK3t4RCe7ZPPEth9SrWZmhZo2cPcXABd/feDYUwZ2gqpo0mxEFfvQDohm26fLo4OrBrbad1zfue32OzZ+7++hEjXibk/R9giir+WKa0TsINU8kYzM77nQ3MRUKZzRbKhEOIeWXMk8yXQn8gVapDfK8E3qMy847juZp4s0Z6rs5S1WFqOrFNOY9BOy7NKjYmJnFCCCsg+f0rn81eraAeyUgICaLOScI1oHCOpBmNs9JiVMXCC7OJ50Cs6UVvStgeMyliWO3JH5bqjag==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.15; Wed, 30 Sep 2026 14:57:13 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 14:57:13 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 30 Sep 2026 23:55:45 +0900
Subject: [PATCH v3 6/9] gpu: nova-core: gsp: cmdq: split the transport part
 of the receive path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-cmdq-rpc-v3-6-91613f06520b@nvidia.com>
References: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
In-Reply-To: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0050.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9b9d8c-78f5-402f-5d68-08df1f031c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|23010399003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Yo7BsTd51jYZkS/rrORW9TOzsL9OZqHo+PVf+4oeqfqOdVZ07fRxbZCE2Xct4/uem9n1UPBd8mGBwBhn7AzhgTN6BSAeFHpEu9aonv1tW+P6WBb5mDoVo6eVGY6mBdsMTtJUGGI3H2kpwzo317D7sKcjD+iEzOg/eSnKRN+LxdHEYJOuCNlM8iKkNQToIulKGggHF0SXte1cfgiZyA+R2xaKBljgww8z/d8ibKsXMygOGZk9lB+dAmssfqoLnVU6QkrC/jEcf6fwUFFL3dnAxk4Hs00BMjRWBZmnU1YrQSoTTUidJu6d9kbHk5R3ysgrGE586S6OhmUG9nYbi4VVrfEd59P36h8CwQXSFhA9qqCRQlbIujOvAyp5wJyf/skTS4tAPPkq5xg/gBdlns260mknqWIxXWg9yztCPmJU7qHBusxtPIze1nL5i5IEJKMYHaffy5gF9bFzflIFAF/8xMmonhaLRDYP9/S2Ek87WpJCRoq6JRd9i+isjWSq7HaXKof8sRGG7jINYT1/YIHURljkserLOJDr/EtKXSQwJMcqpG9UmpefpAf3M3Sn0RBoKjNJqM54/iiJkKertlqzlhnEgIahMpCsfuexcGPFMTmvxpK2tGLGz5Rc+j2aQCbM82+ra6vwVcEPDxETFSkpPP8Dbug7Bv0KutEvR8btHK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(23010399003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkxEa29WNVVZaTdRWTNPT0VUbjVLUkJFaVUyd09BUnZCTXBEbVJqUTNVVGI0?=
 =?utf-8?B?TXlZQ1FzYjVOUnQvUUNsZno5TnVoOGdlZnJXZWNjcmtCT2RCU2R0NXZUelZ1?=
 =?utf-8?B?UWRocUlDSFBsbE9kalVWbWVzalFxN2xkaXBnd0NaaEtmbHdwaEpZU2czQjFJ?=
 =?utf-8?B?VTlYUGdOcmN5K3VJSFNRYUlkWVpXenhrTTBVQzFxL3dUbkFHdE1POW1hZ2tB?=
 =?utf-8?B?YlJDNkNaM2VVR3RWNjNWVmpoQlVBdit3WmQwamFSWk0xb1A3MGw2bzJBWG9E?=
 =?utf-8?B?Rnh2YjQwMU53RUtIZExuUTQzV2c0QVhwQ2gvK3o1amZUZGVyUWtDTkJyaWVS?=
 =?utf-8?B?L1E0R3V4T04xemJlTEhIbXhWMUxjQ0lJR3k4eEhENUtqdXNQbGlzVTB1OWpM?=
 =?utf-8?B?c05qdjBScGtnSFljdFNwRUltSlRCNUMyeXB2QUtGcjEvMzEzSTF3UWxveEdU?=
 =?utf-8?B?eExMOU8rNlZVWjBza2hia1hsZ2pCczNwdzZpL1J4Mkt0bUQrQmVmaE1DMnNp?=
 =?utf-8?B?Vi9scnl3cFNKY1ZRbjlHVnNJK3dtaXBBa1gybWlFYXNhenhkVjNiMHJwVmo3?=
 =?utf-8?B?S3dIdks5SWcwYWpEQzE2cWZqalNhbm5jZTlFMmNTU3RHbzBSeHNVRVJRTk9s?=
 =?utf-8?B?VHZLQ3BObVYwMTFNQU9iTExRWVErejRYTC9TY0xEV004UGJ2c0VIcnFwL25s?=
 =?utf-8?B?UWtNZkNGV1FIWUU2ZmpiKzFOU2ZrcG9ndnRiL1RKYkJ3elVzVVYrSlR1bDBI?=
 =?utf-8?B?MU51YWtuem5vUDhrTTdZdFhQeWR1NGs4NDVTWlBFQVFlcEpna1hBaTE4SFlX?=
 =?utf-8?B?bjRaWWNzQU5vYVdqK0UxL0FKVnFSREE5ZkNTVUYwWHFJOTNQbjY0S0pkaWRT?=
 =?utf-8?B?dUlCcnhFMjZWNjZ1b0FLQWNoMERiOWhxYVFESXpqSm51SjVPeHQ5TkZVeXdw?=
 =?utf-8?B?aEFQUlpKY0xOTUVvSktvR0dLNktiejVTZlpYMkZJdVdiYVRIQWVhMUhXNkVq?=
 =?utf-8?B?em1yWG9XSlBHVVZCYmcyR2JIS1BiSlFDdnp2N1lYWTM0UVVKcDQxRFlGbkVO?=
 =?utf-8?B?enRUSFVhWXVtcW1sVllvbnJ4RHh0Y0F4Y0xSd1d1Sm9lTTFBdTlOQ2doa1No?=
 =?utf-8?B?TWNXSTlHWmg0bi9aanI5NzVNL3o2d24ybU00RUYzaWxLWFNmSkZwRnY4WG5k?=
 =?utf-8?B?dmxmOTR0NStEMXIyWWJ0a0FhSXpjWGg4UXlDbzJtbzN6T21nWDJsSWFOMEd3?=
 =?utf-8?B?c3Vha04zMWV1TWlGVWNHbEZEa201RUNmS0ZTUkZvd0llaTl1NEVGWGlmRnl5?=
 =?utf-8?B?clpoRER6WUl3cm0wSy9CWUpDbFpNbWdJSVcyZEpxaXRNVVE4T0dkMlpobGwz?=
 =?utf-8?B?UjZPUEVwWUIxWUJHb3gwaTNubFdYVzJscVhYVVp5VzZoU0UzUVNzR0IyNFpq?=
 =?utf-8?B?dEJMZmQvbUg5bGdocHFHdGhkVTUwTVVKb3pIZWcyQVRzSU5OS2hDY0xYT2hF?=
 =?utf-8?B?Rmp4WTdYeHJYTlJrZi8xQyt6NHE2ZDByYzhrNkdBazBYSGJIQnZvYnRCQzQ4?=
 =?utf-8?B?bGNrZnkvb1FJa0x3UGZvZzhNQ0VuR3dUYm42UVAxTW1ZS2k1ZHprRVdZOU1N?=
 =?utf-8?B?YkF2eko3aVhNdWJUUEJmdFd3bTAwYVF6R0RyV0pQY1BBVFZieVJjSXA0VFl6?=
 =?utf-8?B?TkU0K0N2NzAvMk5EaVg5YXVVaVlvM0hxdUE5WU1IWnEvelVGRTNRTDN6MzY0?=
 =?utf-8?B?QTVXMUxvYWFFRkxGSHVvVmRzZmZQRlVpQnVXTmNMRUtoeGdrNGpncVNpSVVi?=
 =?utf-8?B?aWhyUXNaWXpNRzlKZjIyaXk2RnFFNlRWWTUvMmlQRjdHcTlWeWo1NTBXR0l3?=
 =?utf-8?B?UkRuWDdsdE81RWMzRUlNR0pSSjhtc3hTVURHZXY2Y0xoRTduc0Zna3J5d1Js?=
 =?utf-8?B?R1ZROHYreXlaTWRKWHVHWlVlY3h6VkxjNk1zMW9lTkNoYXF6SzF2Vk9HMzN4?=
 =?utf-8?B?U3dVS2dYQWJ0QWdmSHRGU3pSQS9mMFJOWDlNVG5RYWdPTExxWVpnUUIrNWgw?=
 =?utf-8?B?c1g2YlladUF4UWZ5TTZvNEx5T3EvQnNjaGVpN1M4bW5KTStVU29IVGVpaU5K?=
 =?utf-8?B?dUxZVW1yMVczN1cxc05MYnhvOTJrRkNGWjZMR2NmMjVjRTZsUGRvWHFoWlU2?=
 =?utf-8?B?VEtLTW1iVDdTbEhBZXZWL2xiSzV0MEo0UGcwK0h2K3FJRGY2M3ZHWFZ5MTBw?=
 =?utf-8?B?SGVXZXFwalBJVjBDMzNIZ0Vsb29FUlZ6Q0VxdmljM1N6SmhkY0JjOWhTc1M2?=
 =?utf-8?B?dGlUWVY2ZVFDR0dLNlJZV1lrWm9NQm1pL2F5dEZNWW9wSUx1L3Y5RG51Y2NE?=
 =?utf-8?Q?JQN4100rrC+zPoLxWzOoKqd9cumRPHYq2OxMhpKFwu1i4?=
X-MS-Exchange-AntiSpam-MessageData-1: k+N5TO/gO8iJUg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9b9d8c-78f5-402f-5d68-08df1f031c34
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:57:13.0203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MJwwI7/AJ/V9NbJU1v9Y7H5jjJB3pwQYW0UPAkfPYqp+8SVDiH1rYF3B3hXjhwznZt68Ucny/PfRj+ALnakVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
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
`consume_element`, a transport-level method which reads the message's
contents using an implementation of the `MessageElement` trait before
advancing the CPU read pointer past it, and `parse_rpc_message`, which
validates the RPC layer. This sets things up for moving the RPC code
into its own module, leaving the transport agnostic of the message type.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 219 +++++++++++++++++++++-----------------
 1 file changed, 119 insertions(+), 100 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index b8a9e02b76fe..07036972dbec 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -195,6 +195,15 @@ fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspCommand<'_>) -> Res
     }
 }
 
+/// Trait implemented by types that can be received as single command queue elements.
+///
+/// The command queue validates the element header before calling `read()` to interpret the
+/// contents.
+trait MessageElement: Sized {
+    /// Tries to read `Self` from `element`. `dev` is the queue's device, to be used for logging.
+    fn read(dev: &device::Device, element: GspMessage<'_>) -> Result<Self>;
+}
+
 /// Trait representing messages received from the GSP.
 ///
 /// This trait tells [`Cmdq::receive_msg`] how it can receive a given type of message.
@@ -218,6 +227,94 @@ fn read(
     ) -> Result<Self, Self::InitError>;
 }
 
+/// Wrapper type for receiving a RPC message from a command queue element.
+///
+/// [`MessageElement`] cannot be directly implemented for all [`MessageFromGsp`] with a blanket
+/// implementation as it would conflict with other future message types.
+struct RpcMessageElement<M>(M);
+
+impl<M> RpcMessageElement<M>
+where
+    M: MessageFromGsp,
+{
+    /// Validate the RPC layer of `element` and returns its RPC header and its contents trimmed down
+    /// to the RPC payload.
+    ///
+    /// # Errors
+    ///
+    /// - `EIO` if the element is shorter than the payload length advertised by the RPC header.
+    fn parse_rpc_message<'a>(
+        dev: &device::Device,
+        element: GspMessage<'a>,
+    ) -> Result<RpcMessage<'a>> {
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
+        Ok(RpcMessage {
+            header: rpc_header,
+            contents: (slice_1, slice_2),
+        })
+    }
+}
+
+impl<M> MessageElement for RpcMessageElement<M>
+where
+    M: MessageFromGsp,
+    Error: From<M::InitError>,
+{
+    fn read(dev: &device::Device, element: GspMessage<'_>) -> Result<Self> {
+        let message = Self::parse_rpc_message(dev, element)?;
+        let function = message.header.function().map_err(|_| EINVAL)?;
+
+        if function != M::FUNCTION {
+            return Err(ERANGE);
+        }
+
+        let (cmd, contents_1) = M::Message::from_bytes_prefix(message.contents.0).ok_or(EIO)?;
+        let mut sbuffer = SBufferIter::new_reader([contents_1, message.contents.1]);
+
+        M::read(cmd, &mut sbuffer)
+            .map(Self)
+            .map_err(|e| e.into())
+            .inspect(|_| {
+                if !sbuffer.is_empty() {
+                    dev_warn!(dev, "GSP message {:?} has unprocessed data\n", function);
+                }
+            })
+    }
+}
+
 /// Number of GSP pages making the [`Msgq`].
 pub(crate) const MSGQ_NUM_PAGES: u32 = 0x3f;
 
@@ -544,7 +641,7 @@ struct GspCommand<'a> {
 
 /// A message ready to be processed from the message queue.
 ///
-/// This is the type returned by [`CmdqInner::wait_for_msg`].
+/// This is the type returned by [`CmdqInner::wait_for_element`].
 struct GspMessage<'a> {
     // Reference to the header of the message.
     header: &'a GspMsgElement,
@@ -662,8 +759,8 @@ pub(crate) fn send_command<M>(&self, command: M) -> Result<M::Reply>
         inner.send_command(command)?;
 
         loop {
-            match inner.receive_msg::<M::Reply>(Self::RECEIVE_TIMEOUT) {
-                Ok(reply) => break Ok(reply),
+            match inner.consume_element::<RpcMessageElement<M::Reply>>(Self::RECEIVE_TIMEOUT) {
+                Ok(reply) => break Ok(reply.0),
                 Err(ERANGE) => continue,
                 Err(e) => break Err(e),
             }
@@ -689,13 +786,16 @@ pub(crate) fn send_command_no_wait<M>(&self, command: M) -> Result
 
     /// Receive a message from the GSP.
     ///
-    /// See [`CmdqInner::receive_msg`] for details.
+    /// See [`CmdqInner::consume_element`] for details.
     pub(crate) fn receive_msg<M: MessageFromGsp>(&self, timeout: Delta) -> Result<M>
     where
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
         Error: From<M::InitError>,
     {
-        self.inner.lock().receive_msg(timeout)
+        self.inner
+            .lock()
+            .consume_element::<RpcMessageElement<M>>(timeout)
+            .map(|m| m.0)
     }
 }
 
@@ -787,7 +887,7 @@ fn send_command<M>(&mut self, command: M) -> Result
         }
     }
 
-    /// Wait for a message to become available on the message queue.
+    /// Wait for the next element to become available on the message queue.
     ///
     /// This works purely at the transport layer and does not interpret or validate the message
     /// beyond the advertised length in its [`GspMsgElement`].
@@ -805,7 +905,7 @@ fn send_command<M>(&mut self, command: M) -> Result
     ///   message queue.
     ///
     /// Error codes returned by the message constructor are propagated as-is.
-    fn wait_for_msg(&self, timeout: Delta) -> Result<RpcMessage<'_>> {
+    fn wait_for_element(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         // Wait for a message to arrive from the GSP.
         let (slice_1, slice_2) = read_poll_timeout(
             || Ok(self.gsp_mem.driver_read_area()),
@@ -827,108 +927,27 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<RpcMessage<'_>> {
             return Err(EIO);
         }
 
-        self.parse_rpc_message(GspMessage {
+        Ok(GspMessage {
             header,
             contents: (slice_1, slice_2),
         })
     }
 
-    /// Validate the RPC layer of `element` and returns its RPC header and its contents trimmed down
-    /// to the RPC payload.
+    /// Wait for the next element on the message queue, pass it to [`MessageElement::read`], and
+    /// advances the read pointer past it.
+    ///
+    /// The read pointer advances regardless of whether [`MessageElement::read`] succeeds or not.
     ///
     /// # Errors
     ///
-    /// - `EIO` if the element is shorter than the payload length advertised by the RPC header.
-    fn parse_rpc_message<'a>(&self, element: GspMessage<'a>) -> Result<RpcMessage<'a>> {
-        let GspMessage {
-            header,
-            contents: (slice_1, slice_2),
-        } = element;
+    /// Errors from [`Self::wait_for_element`] and from [`MessageElement::read`] are propagated
+    /// as-is.
+    fn consume_element<M: MessageElement>(&mut self, timeout: Delta) -> Result<M> {
+        let message = self.wait_for_element(timeout)?;
+        let elem_count = u32::try_from(message.header.length().div_ceil(GSP_PAGE_SIZE))?;
+        let result = M::read(self.dev, message);
 
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
-        Ok(RpcMessage {
-            header: rpc_header,
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
-        let function = message.header.function().map_err(|_| EINVAL)?;
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
-        self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
-            message.header.length().div_ceil(GSP_PAGE_SIZE),
-        )?);
+        self.gsp_mem.advance_cpu_read_ptr(elem_count);
 
         result
     }

-- 
2.55.0

