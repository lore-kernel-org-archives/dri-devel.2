Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26C2C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4405110EE6C;
	Wed, 19 Aug 2026 17:29:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="WPqKnYTW";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020137.outbound.protection.outlook.com [52.101.195.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3935510EE7F
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 17:28:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QncziQpkFk4C1dX0Xa4PEcZHx6jGxyNC4A61G+EzqgfjPbrkUAlhx/7UBg/BBMTLiIc/6SIsg6NxptFE1dQu4nmBjaHk8gwntzij5A1rqlTmjXaNhrpHF2y2hHkIK24xkCwhVi1yoaFlBvZtSgWH3Xopc5ArtDeNxWw40xmH/aymQQ4j6LjkuDZf14qZSi8ys7Ly8mi0zGUbIA6FbJpDogV/N+P3YmJu3NNFP1iB4GEvq9gSwwHNveSkcjRr4Fw3B0IyAZV2F91SxzvIWiwRpRQyEgWPLcAfRxQzPiwYPTgjT4PFKlaKxO1SObINYFGEcQ0zmymmU9Q2Y76nwJxcVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0AnX+IOloPYcb3W46oh9On/k5B6TL51gjldG4cWxNg=;
 b=XVClbyn7a1LyCVgK5tCITJjHaeGhlgx/VcetgUVa0B38GgXMXB7X+yQe4/fnC/vt0E5WCQeehKHMFmW/hhy6sxVVzYvwsSNzTfzArq3L5Py/PvmYXTwrlDycXQzxaWcvOhWkH2HcMl2T3A5xqGRGA0o+dLogpd6ykqWfanYmVcSzwjwSnqA1kTfF06ZarfQgyqBskxZsOASUhohEQmAc9MezPWZZU62GY33vdgSTnqLb5VXjlKxz9cwAK0MoBNnOKDmvQfNIEacf/HLzUXLJmE6tjg9y81kotW76ZxN9pIneXqIKjJb91YuOJ1stO39QTqGzJk2Wmi9w7YYeCHtrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0AnX+IOloPYcb3W46oh9On/k5B6TL51gjldG4cWxNg=;
 b=WPqKnYTWxDVUyngxn3WuJ4Z0jnwbh6LywCP41A9tVJhZXx2LDBtfrQC7LEDUV3w+ZH4ITH+YbKUHnWT8Ijl4uoqhdphqWqd2K30htHoEMUukotiHpvSZbScEUOguptnytFRH/D185NeSdCLiG2AMgEqjCNx0LwdDGwcS3zfTBVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB6482.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 17:28:54 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 17:28:54 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 19 Aug 2026 18:28:44 +0100
Subject: [PATCH v3 2/2] gpu: nova-core: fix barrier usage in GSP->CPU
 messaging path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-rust-barrier-v3-2-d5b7bd7e6624@garyguo.net>
References: <20260819-rust-barrier-v3-0-d5b7bd7e6624@garyguo.net>
In-Reply-To: <20260819-rust-barrier-v3-0-d5b7bd7e6624@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787160532; l=2721;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=iJ28+wGQQtXj5E8pL1tbnXco8rJyHLFq4usQCHNarXY=;
 b=Kz/qJQfg//tNIgrPf27oNF2l9HBovPKHiWTCUurTNntdxo3/G/9x0akIhU4y/loGTuFL7pORd
 2kpfum/jOudCACQ+rz6uqzuSdylrhI6NgyqV2rhqFWB4UQX0/eDfBvL
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0414.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::23) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: 03dec6fe-bc84-4057-fcaa-08defe175762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|23010399003|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bX47Qc6HrtkOX9meU3xNUb5O60x81IQ9TZWGybcBQPBWMYRMtqsgWO6rxC2X7VRs89k5mo8jDl4DTPFBzZu68TXulbyLLi7TW8angOJ0Xj5Fro5oJkb1JIaPO0tfqI2rqilhxvtkXK59pua8suBqEJECKT3IBViKyOBxgQjfD9B4YerNjuTdEMQrs7uMdALtXaUUT/3eFPU3k7NqjC7Sl19NDYWC6mf0m6ktW+btXOht3WaeOo16ZZ9mXGar9JP5m/ycpTJvdYYuQ4/ylh+iB44OJ17ylYmS8fKqIHuOAFxxomf05elynoi4qwuMxIebiXrb+Fhe6BabtsQkqtOOplslHcdjbxT7gHbegUySYkklFvVyG+KUVI5dwfpl3xUrVsdTlsUfYbsxrnILMgU1SaiP+8bLKIBSO2l5PoXYdBWzeA40dRWv4ARWB7Rdzbv2H7sKRcxU2cUoRrh3ydaH4xwINA/joEnAJ9vnv2G6PIMyU3Zln/TbXHZLQ7FBQamQDkHK0O1pvNX9saPtdRGbPmzLt8ccb6Z0Gz7YxIwCGwFFO0qqDJBCeToVutXPHvCEZRn5Yk6hTfDzGYS/yNY6bhnQU2bisFMYmn5fVj78jFGzyHQMkXikh465yS1e8SCPHCvLvEADRWYLT3prSaQz7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnZOUjlUZWpSSUZwK1ZDQmF3S3lrTzg0THVXak8wd2NYZ1FHMFJIOHQ3d09K?=
 =?utf-8?B?OHY0RjVLOWtTMVkwemg4Qkd5MHZ6ZEE4b0tncTNKOHRnc0dMZUY5dXZ0RU42?=
 =?utf-8?B?T09qUWtnL2lOVVFTdE4rVVNjemZPU1l6OFBIck9yQldGVWhHSjRCUDRqYTA3?=
 =?utf-8?B?Tjk3VCs1Y2dBOHFzcWV4V0ZTeHVsRlN2dkJET21XM0J2WUNkdENMMDllaXU4?=
 =?utf-8?B?VWhkTnFNZW5HbzFqS2crQ0w3cVlTc3ZWbmQ5M05VcDNOM2wrYnZuWldxRkxQ?=
 =?utf-8?B?NktjZE5keHNHUVVMV2UzODN2RkJCNnk2T2loNjhYK2Q2QXl4aXZGM2NNc0My?=
 =?utf-8?B?MUx5SHY4T0VxVTdtdm9FSlFGOThoTjlrL09SOFRZYVhiQ0NiSldtaTQ5YXZP?=
 =?utf-8?B?MHdxQmFjN2xGRTJsV3NEY3dsTElCYjJCRGZJYWtodFptaWtENWtWRmF4TXFq?=
 =?utf-8?B?RjRTbWpPT3REclJzRG95L3Q1NmswNEpwYThNaG9EVktlcFBrSjJGRDgvZ1hy?=
 =?utf-8?B?WkdIWEFJWTE3Y0d1dXVMUTdZWHMvZ21tSWI5TitVblBlcTV1RFFGUFIrQUlH?=
 =?utf-8?B?OE8xd09wMk1aUU43aitRL01zczJyRm1pdjF1OUp6TGVybEFjUnhRYnpXWEFn?=
 =?utf-8?B?aGFEUHl6bkNvUmZKT3RyeXZabHV3blFia2tzZ0xEcjhUM2ZrUGJWMEJXcWpI?=
 =?utf-8?B?K3M1VFNFK2lNdGVrL3lpdzQ0MXRBQWFPanFHMjR5ZDZBakJSQ09rSEdtTGE4?=
 =?utf-8?B?RXJ6T0JYKzhPOHFVbFZwT3MxbUR4ZmpaNm8ySXBtd1QrZjlpY2JXQVovcXEx?=
 =?utf-8?B?WVcySXZVOTdzR1dUc1JEcVMzMHR3VytFT0EwZ3QxSGo0TmxoNUlySEd4Z1Bn?=
 =?utf-8?B?MDNncGg1eGVRL3VzWW1hY1VHY1ltdlVMQVhPTXdTdkxJYW5YUmtGSTJ0Vnla?=
 =?utf-8?B?MkVpeXBxZkNtaTFXOFFVWFBWeG02NFZmeVdOcnk0Q1B2ZHVydVFUZ3psemFJ?=
 =?utf-8?B?dE9Sem1EM1lHUmZBU2JaQ2w2MjhHczBjQjdDTzMzKzJkTG0yWFJkNURZSHJN?=
 =?utf-8?B?RU56eTVhVUl4UGpQOUd3aCs4L0QyUUpmRzh4djRVekRaZnJ0dC9NanJ0eTdm?=
 =?utf-8?B?WXZEczNZUE9KbUl6cDRMQnRob05GWWhhK3hpNzZlTURTa0UyRk12NnV3Mjh4?=
 =?utf-8?B?UlFKOVlyVXYrUGVudnRseEZwWmdUY1JjR3R0ZnpUajJORHlZRVI4VnRpQkp6?=
 =?utf-8?B?ZldLTW9jaVZJV3M3Z3VWaTBqUnJ5c1lJRmRVZzVxaFpDb2M2SzBjRG5BTkow?=
 =?utf-8?B?cENweUM4WFdSRTM3OVlsY210RVEwNXZYbFVtY3NDTmRDL1dwUWNhajJ0RjRX?=
 =?utf-8?B?TVd2RzRrV3MxMjZQaE4rWEc0TUc3WlhzK1FOMTNiZ2dsMnFRbEc1NnVJVWdO?=
 =?utf-8?B?cG4wbng0bml0aFhhNWhaalFvaFVGL0JSS1lqMTUrVDhlaVppM0pqSFZ2bTZI?=
 =?utf-8?B?aVN5T3FsWDFRY0NxOXk3Qk9KZi9hTDlIdmFvUUdJTWt1ZWphK2ZPV29SUmJ4?=
 =?utf-8?B?SU9zWG5DaDRrd1NVQ3JJNTBuT1hPcGZyQVROU01GTFBOeW5XK0ZWMTFydjBx?=
 =?utf-8?B?Tk1Bb1o2S1JHVCtWRnpORHhaalB0SFJ6ZXF6SkF3bkl0MzcxVDZmb2VXemhF?=
 =?utf-8?B?U3BhRExod21GUVlEeFlkWmFVcjVKMFN2YlIxUWxyV3JZMzREMjcxaE9MZ3FT?=
 =?utf-8?B?b1hBcjljaGROUjVSRkxJa21QbjJ1ZUJNbU9JblZzOU9ybUY5OFIreUF6bStT?=
 =?utf-8?B?Um01R2U5ZnZxZ1pxSmp3NTN2RUw3OGl2SFBKWGc2TEVNSExTNEliL1FNNEZS?=
 =?utf-8?B?OE0xZU1lNlgrYzVjNGtDK3ZMSzlRd0FaZGtrK3ZYZFQ3ZmJoV2NrMjBYcnU5?=
 =?utf-8?B?RVhjeGVmUG5aTGRJbVE5UXRKNlpYUXl6STlieGFjdW5CNDZNM1hxQ3VHdk52?=
 =?utf-8?B?ZnNsZUg0QkZRSnRSdTFNOFdCc29nUlp4RzhwdUErNE93RVRSU1IvZEIzL0Ns?=
 =?utf-8?B?NU9yZXZqbnlDOGJPVU1KelAxTUtaMnkzeUFNVHBuSW9JeUdqb203VFliVHdV?=
 =?utf-8?B?UVJXeUZweWtOVk91b2VyQ3ZHWHJBbmx6WWpVdXlYSXhGR2hCSFU0MDM1NGxr?=
 =?utf-8?B?SWl6K3lRMjhOemxiMmE4ZmQ4YlZqVW5QRVNKL2xTZUZMRHllUmZqN1dWb0hD?=
 =?utf-8?B?cWF0NGc4UU96eTRZQUFVbzRoYUhpY05rMlVyQUhaMmxtQ21wMmY5WndoV0g5?=
 =?utf-8?B?ZmszOEF1VU9TZGZaaHBGL1pjZE1XaUdibUZqTHJFWGJoanU5NmVZdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 03dec6fe-bc84-4057-fcaa-08defe175762
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 17:28:53.7576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: af2QT/tPmk5KVRh1J+1GmAZq6QdzgnX/mfZBqtpsBI2smXSssh1tFyN5U3Ajqq0m+mh21z/GJ91qCvrsKpLQew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6482
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
 drivers/gpu/nova-core/gsp/cmdq.rs | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 70674d2d0f77..9fe393da6b10 100644
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
@@ -339,6 +334,9 @@ fn driver_write_area_size(&self) -> usize {
             (MSGQ_NUM_PAGES, tx)
         };
 
+        // ORDERING: LOAD->LOAD ordering needed to order `gsp_write_ptr` read before data read.
+        dma_mb(Read);
+
         // SAFETY:
         // - `data` was created from a valid pointer, and `rx` and `tx` are in the
         //   `0..MSGQ_NUM_PAGES` range per the invariants of `gsp_write_ptr` and `cpu_read_ptr`,
@@ -436,12 +434,11 @@ fn cpu_read_ptr(&self) -> u32 {
 
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

