Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886A8C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA8AD10E8AD;
	Tue,  1 Sep 2026 20:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="nZbF5R/k";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022079.outbound.protection.outlook.com [52.101.101.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D61A10E1F8
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 20:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qcMTuFF0QxT8jd22L2pjGmJ7UnLtoMU4IxSKidYOrqaUYG011YyivblkWfY3Ix8g4aA8VrUqGmq70pRMRnIsbBexhZ4EfElcewjbcxhYdu/gOp7FRPQdj8/R08QotLVG83j7OOVJosli1s0zL5lv9vzuPogp9wz9fWK0Qd1KNpDdU4X8NjhaToXxu6TwxL5ytINPaiLjAcrXsJO9wPrxiAZpXWQIRwPfc+/bFlb5Tt0s4w9CA7YVbqVczc0VlsYI19aHPDKYxYWGzO11cRNbiqzCKHCYSMDDr7RlMIKqEwvn+AOEpR/L36+LS7FNb3ySAB27vpfryjA2BB727NndWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NSxa3sS3V5oCUbl7eX+7LUrlfqDG/dfV63nGnzQCCQ=;
 b=YkrZNLXbkP7vUJhU/HjD6ARx0CZpFIpVAMsEOyyevnaGfHCqkQqB7eljQE+zHa8Ux3iM6NJtYHq+iPIuMhMjcaBnqMMJwB0E0KcCFexLUJk23xBb31zChYjg7xwP+K+yc/+DzLXGllzaTKLxFziGEzPhaVr9zbCDKmU0G2iM/9iRr1K8Z99F58+xLjjG+WjGhEwdh8iteNxmK0yHClgvE2E/a9+hD4G0piE/mdLKaC2fIBVcXq1zh5gFcK5K062wUAu8k+thOWV5ROCqfAa0yo3tGz6yFHHnapuDqzg1T9i5nRNMgo8mHNl8k/jtkE39M5l76tcEkfM+CjKRjC0LLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NSxa3sS3V5oCUbl7eX+7LUrlfqDG/dfV63nGnzQCCQ=;
 b=nZbF5R/k7MF+Htphr3lfsdwoCKvp8HXVCy9yykK28TzN1cuN4gQrFqbtYkTsFISVvp9PbB3k/Jmt5dlLSdE/ncWt9X3Hvxsw4bm2w2epzQd3SYyipoD1kXviHAntgdUldbVUlvrK9Aq5DYnCdIY6MK8vq2y36hpShxu71QJOzZM=
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
Date: Tue, 01 Sep 2026 21:59:32 +0100
Subject: [PATCH v4 1/2] gpu: nova-core: fix barrier usage in CPU->GSP
 messaging path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-rust-barrier-v4-1-94427f445310@garyguo.net>
References: <20260901-rust-barrier-v4-0-94427f445310@garyguo.net>
In-Reply-To: <20260901-rust-barrier-v4-0-94427f445310@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788296382; l=2742;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=33Pm3hRXK5jx771N7w2zNBSOklF04nwD2U2IvnmDhfQ=;
 b=Q5k5qG01D7pJ22lt96U3jW3U0auIMtK7XiUXJJ2fDW+ytCG2MpMkjhnwPQ/ekR8RjVV9R5FO7
 8mdA47iweI0DEKoghyrjjn8B7NMlhQ3Uu1ivselPzWk1QL7lPDjOEkg
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0251.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::19) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO2P265MB2624:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db7dc9b-36df-45ce-04eb-08df086bf23d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|23010399003|1800799024|22082099003|18002099003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: aNHKaxCO/5FF8qWKtOFFseWlJHce1znlLLCv/acTeKGz0lOkL0J+UTlUf5US1Iy2C4rIFSzf5rIc1D9nEft39Qic6aiiEoXkDkK8BrNYZl/C2Eg8YKoTzIq0aiFFzDpF7tBNrUjDCDr4kOsfWZCJypI3QkIG83yso8BJOJhwOVDYcO2cot9TNQxQCvsSLM/cEzHoU9qRSJHWh57Mma06iavh8UFd8EIJ+Tm3/SKQI5PC+Zhaxlnz6sVYxgJMomiboirllky46sek5+eeJozUtmox2yzPeHVEtD2sSUVWHLNvsYp4J2dzebx+d6pVzK+C52AbkCBthf2r6usCiJwqHA3at3ep0/iDVhzQxH1SZM8+YNSrWaRoBdSmgUpG+Rb0bg25w8BT81NvReqRugreHRE3WgFfVZ1XxEI/5xYjx00iACUjdGCXLhcA3pvTPJ7hwEAuOWQCttqtg2NQEgVVXZAVKeM0V0pTq/CMOVq1O7tuURSH8A2YuMZmtvtlylDuviiTd6PXv8+51zpVsxGQzekFUL67K9wfQrBAnhSbmhwT69sV9ka1m6BT+5FFeTVasVM9SppP/+UOZaV9yhcXZygY2EuK5WGfGDXV4X+1+34n0ZSfqHIgSBJ23kZwSB0hoGDGRUczupnnt6NgMdQN2BVNYiPngc+JmuVxB0UBARo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWpQeHM1ZXUraGFpa2xWSXFzYnlUVjI2YUJ5SkZQR2FmYzMwMG9MUlB0ckFH?=
 =?utf-8?B?MW5PdzFNOU5LVWVKZFMwK3pVYnRad3FXeDVDN0M4MnpOaWl2bTcvOGNhSXJB?=
 =?utf-8?B?Z0k3ZjlueGVHek5ESVJSNHlRcmJqMW5TSjJBQ2NNTTlranR6QUZaeGp6VFZ5?=
 =?utf-8?B?cEFaeEZyTGhTWVF6eVovQjF6SmQzRVh2MVlKekxLVlNKTkpyTldsUktGczJT?=
 =?utf-8?B?dFFONlJaWldxeXdydXlzZ05hQjk3c3p4YW5Hd3luQkY1a3pVM2E5TVg0bXdE?=
 =?utf-8?B?cW0xY0JlNWt0QTlUUHhveS8rQTBwbjB4TXI2MHVZV1ZFNnFDMFF0M1BqQ0dB?=
 =?utf-8?B?TkhlbHhnTWpCY0N3Z1VuVWZSdFM1VnQrKzF2b2k0N2RhRGR6cmVUc09GNjlS?=
 =?utf-8?B?dTdZdHZiR1F1ais3dG1sZkJPMVNUVWdZc25Ib0NmTVY3bzV2a3RsV1FNZWs1?=
 =?utf-8?B?WGhtN1oyWHh4YWczbXZJVXRENFJzdzAwcll1eWlyVFhhVWNsaGhNN3BnZW1F?=
 =?utf-8?B?TUJteWw1eWVXOXpVS2J6bldoWm5iUkJrM1gxOFIxNmRGVXZYUzBOUzVMNnBL?=
 =?utf-8?B?N2N0bVRCbXh3TU56d2UwL05wRTNORnJ3S2U4dzhRbUpzSW5oVW5aY1ZuVU56?=
 =?utf-8?B?OHlqVlNtVzlmeDF4ZVlYL1VDMDRKM2gxZzVUK2NKdE9sQlJxaDRVWUI2anRy?=
 =?utf-8?B?UTRBVXBUTjZVSktjMENxTk83VmNLa3JZVUxtRWpuRFkvSW9UMktaRU1FdzRi?=
 =?utf-8?B?ejVvZGRtUUZvN0VBNDZ2WVIxNmthNFVaWmxNQzBGdWQ0Umd2aDRKcGNTYXNv?=
 =?utf-8?B?UEEwMmdpWUNFY2tsQ1IrcmhUcXpIeFRZaXhNNk1pam5rYjVtYlNhUytmcWlq?=
 =?utf-8?B?TTlENHZxRUpoSTJpZHlZRzBFcExlQ3MzUTNJZ0hvRWxKUThQVE51a0xWcm42?=
 =?utf-8?B?SGxFYWdOOTBaUmQ2bFF6TkNiOW40bThkdUVLRzJUVkhGY1JUa3BkZ2RNVy95?=
 =?utf-8?B?cWUxLzN2UGU4VG1rQk5tV3dzalduREpmK045dnllWHlsN3YwN0JNM0JCSGFl?=
 =?utf-8?B?OEw1TUFXV0MyMEZYT0VONHB2YzFXaWVWdC9yTng2Zy91VnI1WWd3QnU5UXdM?=
 =?utf-8?B?c0RUV1RLWGp5WG1SL3prcktRb1BzekdZR3FiK3MxbjV1MHRoNWZzQzhNSFlQ?=
 =?utf-8?B?MEFlQmtheWhIUGlmLzgxWmZzMDRsekZ1TkNhMXNOeG5EUkVweVFqZkc4OWFV?=
 =?utf-8?B?UXdBZUZzNXJMc1JnNmJ4TURBaitNemg3N0tSdXdsUW9kR2d0WXIweTFhcWN6?=
 =?utf-8?B?bWs0UkhsbDgybGNXWEc0eHo0SjE0SWhGTTAzZDRNRGlDZExmWGJWSnViNExT?=
 =?utf-8?B?VGlXNTNUVlh1VGJDU1M3L0JjT1phaktEbjRNVVBIVXBZZmJEa2p2S2VNL2N4?=
 =?utf-8?B?bVVLMk5hRTJWUEhsMnptZ0JkaHpNUE1uOFFycWVTQTZ2ekhYWVFPVE9KY1Jx?=
 =?utf-8?B?OUQ5V3FYcnEwdjdRNGxZV3EwWG0vMFVmU1B2SEpla1A5ZnMzM1V4bzVDUW04?=
 =?utf-8?B?d1k1MVZPMnZPRGk1NmZMR0l3ejMrVTFDZGMvZmw5RGZScGRZTUY1WW5iRUVS?=
 =?utf-8?B?NGxCbFExbmt5T1ZrVWFocWgyL1oxaFFiZlFiK1ozZzQwVGQ5T2VFTEdtdm8x?=
 =?utf-8?B?NzF1TDlyVzVNdW5ZcHEwOUk1Z1VwSExOZ1A1RmxZSnhvb2RPNzNEWXdjYUtH?=
 =?utf-8?B?VFRGRlBTZFVwUUNwQ2ltbEs4anlHbFZ5WUR6d3ZEYkIyZ0ZCaGhVU2wrelVD?=
 =?utf-8?B?U243eDlaY0l4STd5VGp2RVFNdkNKZitNU1ZyRnJyVlJ6UVZoLzltajJSQVZJ?=
 =?utf-8?B?bEZPdXpaUUg3KzhCdlNDZ3FEMEd6WGQ0SExHSjFUOFpBU0QwS240MGJ0MTdL?=
 =?utf-8?B?eFhSZktsaE5FMi9JekRqSG1EakNycTEzVk1jU1dqOU1NdXc0NytrRlB6Mzhp?=
 =?utf-8?B?NnVaWEk4cU5KdEJoMmFaVjh0Z2lobXplTERUcHJNWjNkZEp4NWpWemppNW1Y?=
 =?utf-8?B?a2wrMHZHUmcvMHk5SitSSkVvL0Z6N3hTcEFTU2NsOHcwSjNoRGE1ZXNUNlov?=
 =?utf-8?B?c09EbUpxdVhVMXdBQW5pRTNkaVQzYm1aWlZzZTE1cVpzbi9TVHRPU0ErQWlm?=
 =?utf-8?B?K2VMb1JTZkRhYklRN1YzWXdoTENzZVRkYU9jdzZxVFlaUDN5K2c0OWgxYVBV?=
 =?utf-8?B?UFl3dEdmSjdvR0pTNm5sb3M3RkpnK0ZCN09WM3JUdEpBek9sVUdMTlA0TVdT?=
 =?utf-8?B?dUU2S2hHQWZIYmdKSVVjVGNqODNwMDgyQ1Ava01CU0VhVXNwSGxidz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db7dc9b-36df-45ce-04eb-08df086bf23d
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:59:42.9107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1L1Tq3cG07PR2K0gAc598FMEkXlgvNZaqXNH9OKNMDo4r3p7e9KRdpEWyFsoKAVhxaF4E1t0iw1NpbDpxH0Yg==
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

In the CPU->GSP messaging path, the code reads the read pointer from GSP,
writes the command, advances the write pointer, and then notifies the GSP.

A LOAD->STORE ordering is needed after reading the read pointer from GSP
and writing the command. Control dependency exists here which provide the
needed ordering, but it's best to avoid depending on it.

A STORE->STORE ordering is needed after the command write and before the
write pointer advance. This is currently incorrectly done after the write
pointer advance (and before GSP notification), but this can cause issue if
GSP is still processing ring buffer, as it may observe the write pointer
advance before command write. Thus move this barrier to be before the write
pointer advance. Note that barriers are not needed between write pointer
advance and GSP notification, as MMIO accessors already carries the
required barrier.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 6da728201281..bfd61e678802 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -27,6 +27,11 @@
     ptr,
     sync::{
         aref::ARef,
+        barrier::{
+            dma_mb,
+            Full,
+            Write, //
+        },
         Mutex, //
     },
     time::Delta,
@@ -413,7 +418,12 @@ fn gsp_write_ptr(&self) -> u32 {
     //
     // - The returned value is within `0..MSGQ_NUM_PAGES`.
     fn gsp_read_ptr(&self) -> u32 {
-        MsgqRxHeader::read_ptr(io_project!(self.0, .gspq.rx)) % MSGQ_NUM_PAGES
+        let ptr = MsgqRxHeader::read_ptr(io_project!(self.0, .gspq.rx)) % MSGQ_NUM_PAGES;
+
+        // ORDERING: LOAD->STORE ordering needed to order `gsp_read_ptr` read before data write.
+        dma_mb(Full);
+
+        ptr
     }
 
     // Returns the index of the memory page the CPU can read the next message from.
@@ -447,12 +457,12 @@ fn cpu_write_ptr(&self) -> u32 {
 
     // Informs the GSP that it can process `elem_count` new pages from the command queue.
     fn advance_cpu_write_ptr(&mut self, elem_count: u32) {
+        // ORDERING: STORE->STORE ordering needed to order `cpu_write_ptr` write after data write.
+        dma_mb(Write);
+
         let tx = io_project!(self.0, .cpuq.tx);
         let wptr = MsgqTxHeader::write_ptr(tx).wrapping_add(elem_count) % MSGQ_NUM_PAGES;
         MsgqTxHeader::set_write_ptr(tx, wptr);
-
-        // Ensure all command data is visible before triggering the GSP read.
-        fence(Ordering::SeqCst);
     }
 }
 

-- 
2.54.0

