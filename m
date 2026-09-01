Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6605C61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59FC910E65E;
	Tue,  1 Sep 2026 20:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Xnx1cKIt";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022079.outbound.protection.outlook.com [52.101.101.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7CD310E1F8
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 20:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YS/O2sVqb0squuzvbIvL3OD6Df3yY3J2hUUamyFfF79UlZHnHECh9lv2lPV+Tpc6QM9ROJk52Fz7oRFLbgPVKUQ2VpKwkFCBn2vEbI+smIr6zxfhEfR4ybbd2asjStz2tMDqtTw9HNSMMyW0EVbzPuKigoTchVr6C7ooLv6Bc5xjpjbbcaXhL1jjhQxMKyslw2YRsh9RxXeqltG5V6JG0XSKGeb26O2c2CDshItz1uwuPU259jy5r0+jHn1x0bSqV31oSWleMMsO27GcfWFp3aKZoPW+QCyX4ON3ybkKNndLTmGQqwvVNG3xX/ccsHmzlQI4rK9JR0X6PGPf8et56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63/mqNJ0HUwdtO8Q3Y+nu1Umq5PHanDwGsV0T7xcUvQ=;
 b=N+++lmXvMFknAXnC+p0t2WmmkKhBFvHS7GQbndVDDfexTdSZOEpUye7jR8+Dp3jXyYo/DyDHMwRpTGZIdI8JteNpFsJugbGpb5y5z3HTNqITZ8mMqkIJzaUd3vpA3KtnMwu5YJ2SjyBmmQMCG7dH+UTRGxuRDWAuanOtf0/MEOJgCylvgvryGSfIELr3dRnYPYsVTjwM3UT//605stS8A7DC5kOdV483LtLwDsxPOHwqIopTP0SxaXnUSuOQY0KyN/UGTJnLXclYw6XpdEBI6abv773ELiQl1fxmw3P5hawL6BTYoBlrJPlZiUXtkY6BvLFw1YSixqMj3S1zvnFj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63/mqNJ0HUwdtO8Q3Y+nu1Umq5PHanDwGsV0T7xcUvQ=;
 b=Xnx1cKItxYGaNkFo2toEKXx9siG0oXCCBAaHOSaUToeUecGdGPaqhRpYfQnzylxD3GHGkmMUPd6TKJTTtuPcdXeXLHS4quN3n38/FqIPrHyvhy0j1LGa3HNnFcc5N8q5ZZmiUqqATFB/DZ4Mla5UCR0SUrGJuaHFi3nf9Qu2W+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO2P265MB2624.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:146::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:59:43 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 20:59:43 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 01 Sep 2026 21:59:33 +0100
Subject: [PATCH v4 2/2] gpu: nova-core: fix barrier usage in GSP->CPU
 messaging path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-rust-barrier-v4-2-94427f445310@garyguo.net>
References: <20260901-rust-barrier-v4-0-94427f445310@garyguo.net>
In-Reply-To: <20260901-rust-barrier-v4-0-94427f445310@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788296382; l=2907;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=ZMyXNHTAh6vKIRfPgjk9v7wcxMKcn6bAbxX3mtXG9sw=;
 b=Eftfe7lKKOwB26dLdPpfDlXLYd/lTK11AjqJaIxj3iTTrMRc3jrIqDp2E92+MPYkZFnwG6rIx
 hHojum+v0S9D1v79t0OZ1eAy99rVPXLcVFqQ9qZhiHy1kywErN8ek78
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0251.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::19) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO2P265MB2624:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d09f214-1ba9-4d2d-cfee-08df086bf262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|23010399003|1800799024|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: HO3Fhsz0qlJCWwuraZfkGCw/YqE7HaKmeVwSDmDvVx8nS/qoeOsbUNsKbNRJwzis9o4oPFQoeSHL1ght0kQwqMumkFxa3sBvMp1WCxsKMVxf0IiQEoRCAwlBKQKak9Ck6In2QxVBQs8UW0xKbvtWG/FdJDudmHhvVCyfLA9OY25l7Il8jO3iaLUNuk12gw4hqk0wi8sRJ9F/8k3grf6SCW0LFTZh7o9774Wmy/03IttIf4ZQJsqRoD9hi06tQtA+sXkpbVhKSKRx1bjQ6z70ursDlzDNXt6Nn0Mgln2bjOFdk0fVFG6OIggrdPDhtfP7LsCMqgvqcR6+rrdbI+kN0wNeIe6EZwn97vjdj3Cn5DBpdsz1Xg6rpu9Pgol7Peaubb830ja1NpW7RVnoARPmuM7nDrqwze2phRE2GeV5qcuAgvfKlvn2lPQSlruhVwwR9RXhbC9CWGMtnOXrScJyed7xCo+S6nBwMpC5X76NXWrN8h56lE/pIyjZfru5PLATzxQhIKfjRSY681I0brBprShXGa8AHOEPRgYKzHSFIiuI2h5OmBLCubtQXOHp7RDQPY/WTz8jnV2XADycXhAwsnNhDRy/6g/KcoMxyzyFYlpNnLn1hfzcKsI09s4y11VUQCsgPj7cpc4uvSUMFIr6wEN47N0j6R7kTeBVfAsrDP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEhhV2JNUVNYUVlXdHZIR1I2RW9PN3B0UHpXdENObXFvdThzeGRrTXp5ZVpV?=
 =?utf-8?B?RG96QlVTR0xIckxQZGtnME5mL0NCYXhveVh6aFhFL2xaV292b0hRWSsvenhX?=
 =?utf-8?B?K2w2MUVnTXJRY2tMQzc3MEF4SlFuQ1VReElIdGhRMXlZRXZNV2F6OTBnenZi?=
 =?utf-8?B?ZGVXakZYZWNCSkpWOEdiQnIvZmJoR1R3TGZzSVVhWDhhWlo4bnFBd0JvUFdZ?=
 =?utf-8?B?ZFRWeFA5eTNtVWdGQVBHTTRSTHZEam92T1c4Wm9DYXR6KzdjbmtxTTdzYkdV?=
 =?utf-8?B?R094cS9xMmJIRFRoTkFzUDVFVE11a3dGdlBXMDY3MVZwZVE5cktQWUo3cjZO?=
 =?utf-8?B?QnN0QkRJdkI0aFJHQm9YdkowOW9uZUxCK2hzUTZkWnZHa3JnS3FjekxtZmxE?=
 =?utf-8?B?Mk1RcGRidjd4QVNoNFBORUdiVDJVUXJROXlWSWVzWEs2L2U1WnhvTDlKbmZp?=
 =?utf-8?B?Q242ZFI3VlZVOUJyOFBKeEtuWm1mUlhyNTg1Yys3ZFl5NDF6Y2ZTdUpveUZh?=
 =?utf-8?B?SU04NW5MOFZpY0c2WWdFU1oxT3hoL0FBckRFc2xzcFArNVdLRUVQZXZtNzc0?=
 =?utf-8?B?bU0wMjdkVG81dEp4S1hOcUNlbDNRdmJzbVNDUWZMRStvNENFREZWQWFuZ3Vw?=
 =?utf-8?B?UEM5cVhCVU1RL25UWmo3RTlycGJwZi9HcmdHYlRSd3dhVDF6Z2pWVjZpSGNW?=
 =?utf-8?B?WVBRSnY5NnRCSzg3Vi9mTXkzNW1MQnpqZXdGMXpRWFdLZ3pDMnhacTA2REt6?=
 =?utf-8?B?WGllVmt1QVZBUUorUnFvK2lYeEZsMjcxbzhKTUZkc0RXaEpTMjdXM3NXM1dJ?=
 =?utf-8?B?eFNBVHRreVVZb1YramRaNTZYYURwTnB4NWs3TDFqa09BUnV6dU14UWlUS3Fi?=
 =?utf-8?B?RUQwcmtUbmUwUlFDaW94ZmsxUXc5Y0tMcFovUm5tTml4Z3BwRkVGYnBaakJW?=
 =?utf-8?B?TTRFdExhMVhqdFFJbGxZelZIMmFEVW5lejFySTh1dncraW1vMElUdldUYmpk?=
 =?utf-8?B?WSsweXpMNWxZUjRQcnlkZzJCckRTUnd4V05XS25FOWhvVGFxbkxhc0UyS3FZ?=
 =?utf-8?B?TnA3U0Qzd2JmY2JSUDdBcWx4WW1FeGtwMHU4ME50N1d0TVdZbFdhV2tzR1VY?=
 =?utf-8?B?VEtFdFRwMVQ1SnRQUmVvbzlZZkwvZlFvTUVMdkQxemZ5OWMwZkliOVlLZjBV?=
 =?utf-8?B?YjY3QjVJUFJ0cGVScGk0emoveHBjRDZaTGlQOHhUbnFFRi9xN0FQWG43VktD?=
 =?utf-8?B?SFJOSDRoeHg2cHBPakYvelltRy9BRkV6dWtJRGljc0RvN2dlcTY0OEg2M3J5?=
 =?utf-8?B?MHZqNWdPOVNRSU1xTVlFSzJkcGNuR3BKNEJVTUJHYm0wYjBLOXF0MlJwYmVE?=
 =?utf-8?B?c1d2RjhvNk8xWk1pRjNCM0RkUzZhZWVuTEJoT1NxWmlMTHZrWEd1UVR4R09R?=
 =?utf-8?B?NGlNUU44YStRUFFGWlBFcktlT1EvT3RRam5Rb01QVjRkWU5VWFpwNjllblJR?=
 =?utf-8?B?Zm5mNXlsZnlvM1VKcThBTzRBdTg3cnE4eDNvVm15YjN6Zkhrczlya2oxZlVz?=
 =?utf-8?B?SkppRzhGRE80ekcrOStsOC8zUVBzWEpxdGw4OUVSSkxObVUwU05wNG81R3hs?=
 =?utf-8?B?dG1FVEdwaW5rcXF5aFJLV1VjNXZ4RjNEMXRtaytQV2k4WjRSYkw5RDZreXQw?=
 =?utf-8?B?NnloclozSGJPY2N0cHNlaUNzdDFzckRtMW51cGZjaGRGRGx3K0wxczFhbjlG?=
 =?utf-8?B?SWZYQ1hQb1NyZkU3ckRleUM2NTR4UDJPYjJwWEhtTnp6bmcxQmIxYTRVTE5o?=
 =?utf-8?B?ejlicXVPZWlNMVpIbU4zQXNyelZXYlhnRmp2eUhiK1gwcmpxTnF0cXdQQzJP?=
 =?utf-8?B?di83cUpSRk0wY2VxTi9XcE1idjg4a0VWcEZsRjNHdVB3QWNQOW5Nb2pjQ21a?=
 =?utf-8?B?M3paQUdicUh3VDlQQlJRUmtxRXhaalNUTUxHSWdEblNTbnhwNU52QnZyS3Z4?=
 =?utf-8?B?N1BCWEtvTG4xYVd1UEhzT0hXNGM1K2NxeHpDTWhhMFV2TFlNNGhnOXR3Qjc3?=
 =?utf-8?B?TGJsUHQ1RFovcm0wNVVUR01HSVJmWHlRdkZXNGxJblNwMkZLT0tmOEdPOTJ3?=
 =?utf-8?B?NTN5aGdweG5YMis0RXpVd1JMNUxDTGk3VWdob014OUNsWXA1RzIyM3p1cHp6?=
 =?utf-8?B?V2tGMkk4aUdmcDNlUTRQemZsWE1wbFNrQzAzdHBDNE1hdXNRazdUcHBaclJm?=
 =?utf-8?B?eHFmNG02clF4SVRVSlMvdjZCQUxHN1RIV2ZpcUZZMXNCVGFmVXUrMTBoZG5m?=
 =?utf-8?B?VWduUEtROW52V1kzekhpcEdBY3pyRE1ySjN4V3RDaEV3eDRXQ1FIZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d09f214-1ba9-4d2d-cfee-08df086bf262
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:59:43.1550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJyhhGimZuFT7AB4S/QX0cyfsET/NK3qMdgwDd64PdTpF+3hErVKnsZsYH+bSEsbni2Gv/7gaUUUsVvlYo26fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2624
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

In the GSP->CPU messaging path, the code reads the write pointer from GSP,
reads the response and advances the read pointer.

A LOAD->LOAD ordering is required after the write pointer read and the data
read. Add it as this is currently missing.

A LOAD->STORE ordering is required after the data read and the advance of
read pointer. Currently a Rust `SeqCst` barrier is used, which roughly maps
to `smp_mb(Full)`; this however does not order DMA operations (notably on
ARM, the generate barrier orders inner shareable and not outer shareable,
which is ordered by `dma_mb`). This ordering does not need to be in between
read pointer read and write, because it's for ordering between the ring
buffer data and the pointer; the RMW operation does not internally need a
barrier (nor it has to be atomic, as CPU pointers are updated by CPU only),
so move it to before the RMW sequence for clarity.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index bfd61e678802..14a711307654 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -2,13 +2,7 @@
 
 mod continuation;
 
-use core::{
-    mem,
-    sync::atomic::{
-        fence,
-        Ordering, //
-    },
-};
+use core::mem;
 
 use kernel::{
     device,
@@ -30,6 +24,7 @@
         barrier::{
             dma_mb,
             Full,
+            Read,
             Write, //
         },
         Mutex, //
@@ -409,7 +404,12 @@ fn allocate_command(&mut self, size: usize, timeout: Delta) -> Result<GspCommand
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
     fn gsp_write_ptr(&self) -> u32 {
-        MsgqTxHeader::write_ptr(io_project!(self.0, .gspq.tx)) % MSGQ_NUM_PAGES
+        let ptr = MsgqTxHeader::write_ptr(io_project!(self.0, .gspq.tx)) % MSGQ_NUM_PAGES;
+
+        // ORDERING: LOAD->LOAD ordering needed to order `gsp_write_ptr` read before data read.
+        dma_mb(Read);
+
+        ptr
     }
 
     // Returns the index of the memory page the GSP will read the next command from.
@@ -437,12 +437,11 @@ fn cpu_read_ptr(&self) -> u32 {
 
     // Informs the GSP that it can send `elem_count` new pages into the message queue.
     fn advance_cpu_read_ptr(&mut self, elem_count: u32) {
+        // ORDERING: LOAD->STORE ordering needed to order `cpu_read_ptr` write after data read.
+        dma_mb(Full);
+
         let rx = io_project!(self.0, .cpuq.rx);
         let rptr = MsgqRxHeader::read_ptr(rx).wrapping_add(elem_count) % MSGQ_NUM_PAGES;
-
-        // Ensure read pointer is properly ordered.
-        fence(Ordering::SeqCst);
-
         MsgqRxHeader::set_read_ptr(rx, rptr)
     }
 

-- 
2.54.0

