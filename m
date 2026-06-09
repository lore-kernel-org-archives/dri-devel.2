Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACDCCD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:39:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF1710E3F9;
	Tue,  9 Jun 2026 15:39:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="h0hW3YKx";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021099.outbound.protection.outlook.com [52.101.95.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92C2110E3F9
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 15:39:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYWSrAaJbRv8P/suxSHs3fVSCu1nIxg3Hw1xuLsZRE9LR4XGLXIaUprP6K5TzfNI6VMRjVkzdwwmqzavQzFUZdxORbDQ/aSUVQfFfy9jCSfD9N9Nj4cT0HyuJcPbpYXXiaJYzc4xsmyAr7Rc2P9PF05bv8JvuvWgLf7nCVdtLGqrsPNg/bkUFq6UrXIo44AYdH5REFpwosh4aGazsF62oJLqreJlY6ebgGPf/p5NITJg3rb17kXNBCseoqn4neX0HMVjOSBkR+D7pHprPRWs5x+f1WRItb5i0W45WxHa2eqIRPQ/qM8zXyYm0jvO+d0ER82DiIAhcuibMrODZioemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ho6eQa514E4Jc6fX5ZN59nyGFrcUSabM31KRwmz278=;
 b=ikDnl4h9R5x6PUIDGcaKdSrsd7LMJS1Cyx8ijzbGUoq55OzvdE8At+sh2SYNIYuq1CmdVwToNp7qlVIDcxOGNKU/f86AYsRftcsbrMTbp883DZRWvqRrmFbcS+Y9CXKcyDrFCHkgS0tXxH6eoYybmwUxcCAs7gaUanUbH+suyZVAv5geuvV8KB623ipJgj7zTtFTMyN5KHMoNIX7Zq6LsbKVnP6e1urTOHAAumN1P7SdrrhKMFTLvxLs3yFxXVzFYHlAKG/upnx2UWqiWGpvecADjs94yQNm8dbkMHyWyk5MIx+KPks5k5yU2ZWvyYXcgR4qK8ixgmrVzFCSWTR8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ho6eQa514E4Jc6fX5ZN59nyGFrcUSabM31KRwmz278=;
 b=h0hW3YKxtd2xCGB+JnbZFMwFO+esTJ9EBFXWVG8SXABaOLw6UsLZELbuEhGQPiSncmnTpO/Shk0jiGYCIvUZPIHcr03zet5j1UiqDhtdfNLz6JeKSC/k9Xd5JvKPZ4FODVczcCEmFyxoDWozC48nAePE3ZExTfqbaA/BM9YZSBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6167.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:183::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 15:39:00 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 15:38:59 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 09 Jun 2026 16:38:40 +0100
Subject: [PATCH v2 4/4] gpu: nova-core: fix barrier usage in GSP->CPU
 messaging path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rust-barrier-v2-4-30fcc48e1cd0@garyguo.net>
References: <20260609-rust-barrier-v2-0-30fcc48e1cd0@garyguo.net>
In-Reply-To: <20260609-rust-barrier-v2-0-30fcc48e1cd0@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Gary Guo <gary@garyguo.net>, Alan Stern <stern@rowland.harvard.edu>, 
 Andrea Parri <parri.andrea@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, 
 David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, 
 Luc Maranget <luc.maranget@inria.fr>, 
 "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
 Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 lkmm@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781019537; l=3210;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=w4oRsqyqOvP6/Pm0p3EcktDaor4KF82lYT6fPTqd8K4=;
 b=0dCL0Qi3h7EpY/GNwEKNxfBVbRRnSLcjQ+mfT+lBJqedBA2G1zOydM8iriyt/veRFsgVnMJDX
 TJdm3wSpGpQDGYiPlS26Izr1g51sbfF0+eOpccEOzfSz3iVTUg0RPfh
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0128.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: e4116ddf-693c-4c7f-2f4a-08dec63d39d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|366016|1800799024|921020|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: vs/b4ZeyIE9VZ1MpNxBGlIFHxje3WaGMQgIgOGqPMCb3axfgykPIiSCAGbW/FtCV0y827cetSRvbb/wqSCv1DuZ1D+JiAkPbiI7wMxjptxgYg8zE5XvKMO0LDKtfKJroY+wbv4fIdkk6BLdIZhi510yFKjdteILxcyPEMwttrUWrg9ujqdmd3TlSVB8BpAwMF48F+BDJ/MUw52pnws1VYpFjNXeGqPkxo9BcEDPprm84wiNiluHyPEoSPdycBF12wAmXA3kboQZE69u0A+PILGAA2F3kxo1tOfu8kKIj69sh8/9wtE+j0ATkXMMdVlLvmecE6aI7pdA8ZlryfbxvJaAONQZX3KMEHcyhwWOhJ7kf8PMB9sTNY8Qd/yplj/nX14VsUYlmRdsMc1haIthNvxNZmo2QWvhd7biZmEjkTNT5Hw139pab58mTY9sYvjKhIz+bxRRmWHWMftToGNTRAbZB8fuTOiVAobRI2VHuQcxuc4TbXB0QYzccBdVinD0bvQnFGp8uZD54l5B/fvRUxlj4UIPi5HgyHyI2pznv4/TffWjj4F3nLBxQAY6Qkgbk5am0fwsmCB+F47UhpFVFoz5hagdMWfgEtbeJivQWg4VsDEvaz1kf3f1tLYpQb3p0bAMerAha4cyIQ5f5fQYQ/RfHV8/Ne/TkqaXdULvGKd0WmtGS3IOjshV76xnqXHhuDqUGeWZPJAQc3LmLEn26LC36X33QOCb8mvmVsBFM5Mw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(22082099003)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFVOSkdQOFhWYUZQSnVpNVFHOUVBRWg1amM0NnR0WTU5RWNjV1Q0Z1JUQWVv?=
 =?utf-8?B?YXhHb0swNVlZbW9ROHA3ZzV4bDRncUMyYnJoSDcydU5waE5EandXKzJjUFVj?=
 =?utf-8?B?WWVLbzFCdGV3M0tQSjV0RENrRXdqWXFKYncreGRMdGI3V1Q4Z1gwTE0vRWVC?=
 =?utf-8?B?UjlZWGd1TnVlR1gzZjlId3Y2c0crU2dEU1BoZlhvU1haSGoxV01rYkFDZ2t0?=
 =?utf-8?B?UmFaU3Zxc20wTUJ3MklKY0xzeFRLamhxVUVtMVFvRjNlTitOcjJGdE1OdklZ?=
 =?utf-8?B?WElCYTY4OU9wZGtwL0pyTlNwaUsrWVByVStRUzViYklzcFlGR3lLdnIzcjU3?=
 =?utf-8?B?SmhnRE5mOFQ3Wk52Zko0RFlsb2lobm5HRzNGYSszMlpsVGlKZFpxeGUwZVls?=
 =?utf-8?B?YWZJMnhtdU10NThYM1E2eFJCdGQyYmJ0dTFFdFdJb3F3eGZwcjdRejdyS2ZL?=
 =?utf-8?B?Nnl0c2I1clNkNHJDdm10WHFxRSsxTXh1V0toV1ZyTjhocEFBNjVLdnpMSnFn?=
 =?utf-8?B?SDYvNzBReTRWektMOUZ6WW9ZZysva005MG5ST0pCQkJJMHgyaUNWbzU0aWM3?=
 =?utf-8?B?Q3hMU1V4QUY1NWI1eXV3ZXBDdUhJUXFUbnVQQXdLbk1iK1UrQmRLamNPdUpT?=
 =?utf-8?B?WkxkTHNHaGhmY2ZFN1V3OGV5TGZoUGtyb0J3ajJlNDF6VU1mT0Y1Q0JCZFVm?=
 =?utf-8?B?cjg4azRBTUhVMEk0WnZya3BxMHZOT2xjQlV6dDlWTDhCR2JKSHBrOGJlMWlQ?=
 =?utf-8?B?SUEzNFM5eURHOHl6TXQrRVFPdEVjVmFMRHN4T1VRL1RSbmV2am54ckh6Ym9K?=
 =?utf-8?B?cm5sbjA1a3FrTTBiWjlKdHp2YUpHcUlQVUs2ekFweTBKcHlDY1c0dnRrMTMy?=
 =?utf-8?B?NkhUdE9DQmhzRU1hd3cvSm8reEErck1UQmtnZ3dMZXlLZ3BwZEVIaWhwNUpN?=
 =?utf-8?B?NFlIOFZsblVaMUNSdWxySFVhSExodEZtMUZoeUxERUF0VzFmS24zVFZyNVBR?=
 =?utf-8?B?SXJpY1Z2L0NkLzUyVVJxN2Y0cEpxazVzN3p3Ym41eWpDSUJwYmFlNVV0dlpG?=
 =?utf-8?B?L2JtWDhyZ2FSM1RCbjdvMkNCWVVnUEVjdUE0blJNOWpadTBKQTJRK1I5aGpH?=
 =?utf-8?B?UnV2bjBRZW1Ed0N5VWlpcVJHYm13aCt4akNZZUM1UHZmWVdPNis4ZEozc3NO?=
 =?utf-8?B?UnhBLzNUMWszRVB6M0FBK01WMXh6dE5lWXVTbS9YWVpoMkw2ZFNId1NrZzZX?=
 =?utf-8?B?czFFQVMvVUpHVjhBWnNzaXZ0LzJhalo4U2lUUjJiUzQwYmdTU29yQkVKMENk?=
 =?utf-8?B?UUEyOHhkcFhhYWJCSVNsdUt1K24yYmJPbWhEL0JjcXY0RE14UHpLV1M3L0Jl?=
 =?utf-8?B?SjJsM2RsYVU0ZE5JYzE4OG9HOE04a0xacVBHcnN3QjJTa3N4andCamNlRENZ?=
 =?utf-8?B?Qy9ST0hZWUN1R2RLdGFqL3ZyQ3h0VXJlNXhRMi81OUlqVmY4cWJBS2htTFNr?=
 =?utf-8?B?R1J1ZEduQTRUOTlTS21PN2pJKzdraHMxQWg0Q1RTanB3eUZwbmZqYzdpdlVL?=
 =?utf-8?B?VHY0Zk9CaHdzYkltZjJRSFNIZExPblNyenlFNWo0Kzg1VmREOEpFYTEwTm00?=
 =?utf-8?B?UG13WU9HVDlPMkFiTjUzREZzc0I3LzdRQVlhMno5V3V4SHBRZW5RbExRVTNw?=
 =?utf-8?B?WURoNnl6YUtWcGxJMkZwbjJmMFJOR1hkSE13dVlrMUlKOXovM2I1ekI0dXNG?=
 =?utf-8?B?MVJpeXVkZVgwdXl5S3dXRW8zdm52OTVkdEtKaDZlMmEwYUc4WXpmR2N2RWRs?=
 =?utf-8?B?MGtwVVBXcEg3bElOelpnZEZIRmJQV2xqK1p3aGZxOTVjUlc4cVJUVzdTdzVF?=
 =?utf-8?B?T2pOVmwvQ2lCd010ZUhOWjVETFVKZ3BRUkFxekF1cVg1ZjJpaU5qamNxRWV0?=
 =?utf-8?B?N2RnSmgyWnRDOGYrRm01WHJ4ZVNiempBK2JJcXA0ZFpsY05zK0pyQ0xKRG12?=
 =?utf-8?B?aExoQ2tvSlVCOFptZEV4NnRZMlZqU2Vaa3JBYkJjM0FMWE03dUowSmpuOWt1?=
 =?utf-8?B?cDEzODAvS1JmK3p5ZDJKSnhkTXQ2M3l0U1VXUWJsWnpsZzNZUHdSaE9sbW8r?=
 =?utf-8?B?cENWRnJxR3dMV0o2RitUdXEzN3pNUlIzVnZuYzkyZmxoSTFzcFh2MTA1RkhP?=
 =?utf-8?B?aFNvbTFGbDFGSkR4RklyV1g4QkRPOFpISFdFNllGemc0cWxUZnlrVmNkT0xq?=
 =?utf-8?B?SFEyY0xNMGpaWW5jZEMzdjA0MTlpWTMwSjg5a3I1V1dacS9rbnl4bldMblN5?=
 =?utf-8?B?UnQ5TFNUVXl0OS9ReFlnTTNsK1F5WHhIbXNHM3VNTHM3d01KY3lVUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e4116ddf-693c-4c7f-2f4a-08dec63d39d7
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 15:38:59.9588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRRgFT3iy4QhsJ3Dzj1WD+2QlnfwG/yeH9RRplUJoNtUFUfdkb2BM6VZ+GJP/5U1t3xKY9SlmJVseJMw4pwfyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6167
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

In the CPU->GSP messaging path, the code reads the write pointer from GSP,
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
so move it out to cmdq.rs for clarity.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 8 ++++++++
 drivers/gpu/nova-core/gsp/fw.rs   | 9 ---------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 94c2790d943d..229d49a67077 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -22,6 +22,8 @@
         aref::ARef,
         barrier::{
             dma_mb,
+            Full,
+            Read,
             Write, //
         },
         Mutex, //
@@ -339,6 +341,9 @@ fn driver_write_area_size(&self) -> usize {
             (MSGQ_NUM_PAGES, tx)
         };
 
+        // ORDERING: Ensure data load is ordered after load of GSP write pointer.
+        dma_mb(Read);
+
         // SAFETY:
         // - `data` was created from a valid pointer, and `rx` and `tx` are in the
         //   `0..MSGQ_NUM_PAGES` range per the invariants of `gsp_write_ptr` and `cpu_read_ptr`,
@@ -436,6 +441,9 @@ fn cpu_read_ptr(&self) -> u32 {
 
     // Informs the GSP that it can send `elem_count` new pages into the message queue.
     fn advance_cpu_read_ptr(&mut self, elem_count: u32) {
+        // ORDERING: Ensure read pointer is properly ordered with a LOAD->STORE ordering.
+        dma_mb(Full);
+
         super::fw::gsp_mem::advance_cpu_read_ptr(&self.0, elem_count)
     }
 
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index fae2eae495d1..b213385c1f01 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -46,11 +46,6 @@
 
 // TODO: Replace with `IoView` projections once available.
 pub(super) mod gsp_mem {
-    use core::sync::atomic::{
-        fence,
-        Ordering, //
-    };
-
     use kernel::{
         dma::Coherent,
         dma_read,
@@ -76,10 +71,6 @@ pub(in crate::gsp) fn cpu_read_ptr(qs: &Coherent<GspMem>) -> u32 {
 
     pub(in crate::gsp) fn advance_cpu_read_ptr(qs: &Coherent<GspMem>, count: u32) {
         let rptr = cpu_read_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAGES;
-
-        // Ensure read pointer is properly ordered.
-        fence(Ordering::SeqCst);
-
         dma_write!(qs, .cpuq.rx.0.readPtr, rptr);
     }
 

-- 
2.54.0

