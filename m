Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8F3CD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B8510E472;
	Tue,  9 Jun 2026 15:39:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Oi+RhTd+";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021099.outbound.protection.outlook.com [52.101.95.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E15BC10E3F9
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 15:39:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFBhGz4vUwn2yZ/c8UjaYq6dxGnCM/eHuHTyilri8bXgJvGl3LcrJI/lF/911DECxGBj+0Bf7otjQHPrWeX42fmmqdCcoCXuc2o7KiXnA0KaXgFww2pSh3kUbj9NRoorU0QXrcvdcNk1LKph1O7L6LnhI9mW4Qd80wiL7HWl98bCnk1kOxgb1z2Mt14svEVfeaJGqOyncvsxSpY9UjmrCMbhmk9Ddn+ts2xSmVcK5t2kKGXUGWAzORdr5qAwo/nl8G4ilbSyL2ceU0LtwEvdo0Zs7bUD/wXc2qg9OsNZ1opsxjJMGd7+ziMKOED2eC5RANfpuyHdzRrJGcsB23f57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIH/jeTQaiOF8guY1Zvck6Guk00QdsD7TChSRKy2cNQ=;
 b=OKbRbvP/d0ICSH5mgeJUwFXNOv0eakSj+4PIWoa7IzT12Nl1GPA/jBVrH8LSYdBtWCDE3lPBvRGCarAb6b4fM1XU+j0YA5fjPqjkNijBhrIC6tNZrrjcpPmogijtrkAp/ZzCGM1s6/DptGVSRL7kgeWD+ajfu8vr/R2XTxrOlj8UZDO5PqLIojwQMBj9F9Nb/+FuSCStvVptKBKuAJ4Pj5eqLL/xdiWpmiZT5xkIiT0VjBJE8pygx54XSt5sY0TOWRqirjy2JjR5MSOOl7LUYRxBC8MbyXU8ERwiShhUbaMNo/8/eqYylgfBsZM60eIxHeRMWI100PU2C4+9OjxbTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIH/jeTQaiOF8guY1Zvck6Guk00QdsD7TChSRKy2cNQ=;
 b=Oi+RhTd+anZR7Enk8DMst7hJ8IjI7vOTcPtrl5dTozVgE1UzwuCZxqDykkImhNMyeaAEboDQ0uP1lGdgzlOm9r+NsKCIhvRxdxfP+xuPphhQb4wR/bfjy33E7201qpgYm6J2Z0cvVSewxEZoqEQOMUxDiInzR3w2k/vmfACdcSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6167.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:183::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 15:38:59 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 15:38:59 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 09 Jun 2026 16:38:39 +0100
Subject: [PATCH v2 3/4] gpu: nova-core: fix barrier usage in CPU->GSP
 messaging path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-rust-barrier-v2-3-30fcc48e1cd0@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781019537; l=3018;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=yfKCyoTjURKZBbetFjk84TsvhfsCoS0zIsnyZZoxNqg=;
 b=rZF6nYuMwYTD109dMGRuLUJh/rRTE7jNFtgK1tNRtmhXl6bWTnzhsrr2ST4hb1qEGlZaldChs
 Vn4vKFf50PmAhM6JFOpL/EvgMB9st+vuACIHd7sLjX3t2b4oF5pDvQ0
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0128.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c05f374-90db-4efc-d36e-08dec63d398f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|366016|1800799024|921020|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: tszNaShK3r5azFIuFlA9OGuWQ50PDznNKJqRYqarvBVpP36VcZQ4HGhGcZYdYihHKwn7B3nr+0WUCYxE2J8vVEaTJGhGMBsyW2MYYnUO+6rQcUMd4rAqfV4zOhxCGFBPwF6I7G0ZyUjUzR//qsp8SGj4zCua8ukw+7EAh+3ipi9sjSuCnKGAftLU72/F790HMhSxl23AMducZRXid0La8F94CcPLYTeQilGCA7AE9OrabjNIUwK/d/mcYIrykkhfbwEV92xHCC7DbgYmiK7tTZR/Yc4z2YPWOhEFyDOemogUOxlYuJalqRCNSQNAT/WSwU0NbQcrahu0nbgYBBlpUdIgKufdWoWl9UjOi3R/hK8kNZBoGtZNBqgG6goEL1FTpmnEC89kj9Pbp3krr3AT+9hrdRNhynWA2rcGd1jjMZ3krbWATi1a1knTRysVVw7gU79Dlq6PuLKSIwmMulRIg1nzXbjcAHD+e5JrZRy8XWt6nUcxSoGYAPnL31nDmePKZOIzEV+cVn2fofOaN9ra2fXU2ZPn8bA9UUQM9x8XHuVjl35nlReCSv5ztE0kWdAMLDK9Z3O9oaGDtKKGSZp7QXbtl3KOJOIY7sBUFHWZJAONoCnPytsH4qqszgdc4N/9Oo825PsKckJQmuYwepg3rCi1DCYSVNlhoUsi6EEkLM1hvwd+C6NApf4nTsJkHPUAjtuLFpzwLF5TDDI4tHjy0F7wDFRc4TRUWYw9cqTOFPo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(22082099003)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWxvSEJJaDBGNGlXclh0aDY0UjI4Wms3NXZBSXNqSXh6NDVNRnBMMlhRaU1k?=
 =?utf-8?B?blFqRXo1KzNlV3c5SFF2NG1MTHBIdHpJNGozVEpCbkdsdVN0dThrMWNhcWV3?=
 =?utf-8?B?NXZxbEFDczBPUEczeTFQejlWYmF2N2VNNytTTERRNEp2a2pSQnM3d1dBSFlM?=
 =?utf-8?B?ZndQK09ZYUdtd2piTzIrdXBjaTJzdDFZWUxxMGxuNDRkOGlzd0RZR0k2TTgw?=
 =?utf-8?B?OWZCVFR3L0ErdW9YZHI5MnlIaHFnaHh5N0h2VkdTNGNWcHRQZGEvMUZUaDJH?=
 =?utf-8?B?UjBoK0dxaDl6OUFZME1td1BPQWwvUi9SSThwbmNQSEd3UFQ5QXByenlMYmZ6?=
 =?utf-8?B?TytBUGJ1U1hjTDV3a2ptSFRRUmQvVk1sK1JYUThld2s4bUtpdXFCUUc2YWc2?=
 =?utf-8?B?WU1jMzRRdUlHZXlXdktlM2h0UEkyalNXcTY5MGFaSTU5V2N2Yk1mUVl5N0k0?=
 =?utf-8?B?TnhzbmZSWmVFZ2NzWmFLRDJQZFFRVXFPS1Y2YzdFODUza0h2QWpJekxabEdq?=
 =?utf-8?B?a0VVdk4wNlpLK0NYU1VieXowME5Gdmw2eHRpMlU2VnR5cXBEMWRTdkRweFg4?=
 =?utf-8?B?RnBZTE10ajdVL0ZIZWRyMjJuZnppYzFveVpLK2RKSjdkVEZITWRWM2xWdUU1?=
 =?utf-8?B?NE04UlFhVGdPbkVpdElDKy9aSlBBbUpSOXdxTUdRaG1SMFhHc1JYNFptWS8r?=
 =?utf-8?B?L2NBdnBLZXMwRGRNdFFWY2MwelI2Ym5ST3YwLzF6bXpzS0hyd0FISDFma3Iz?=
 =?utf-8?B?UlRHU29tblg0ZjEza2ljZWpBckpjSlBzLzdPZTFlaVI1TTJOMUhKMU9MYWZC?=
 =?utf-8?B?ZXIrRDN0cDNCekpVUUVYeXlSTWk1Ui9xdVhCSmYrVE16YkZlSmp4THFxYmdB?=
 =?utf-8?B?WFQ1ajQrWnVaNnVLM2hMSU13YkNYVDB0aHcwVS9MYndIUFFXQ1ZsSnlrTzlQ?=
 =?utf-8?B?UStIVi9kZWQyT2dOb2N1aFpGZ1FpaVFYVVdoeklzSnVSeUNsZmlsaXpVUDNU?=
 =?utf-8?B?Z1lRZ3lMeDZMUktjUUpQZ1hqM2tCb0VjdmhjN1dPd0FWSWV1Mnl1SXpOd2k0?=
 =?utf-8?B?TG44NFNYZXhGZkEwd0RwbEVpTkljZ1h1blY2U3JBY3FYVCt0Rm9LTHBaaFVJ?=
 =?utf-8?B?TFc4Znc2bmVRMHY3dWRPbUMvK3dkd2NiV21tbUJpVGlsYVhxYWhXL3l6VXVF?=
 =?utf-8?B?alBwL0ZvaFYxT2FsTUtPOFU4cXVGUFNFZ3YvaFg0U0p5MG56QzQwcjd6QUFq?=
 =?utf-8?B?U29EelcxMWFmNnViUWF1aHdKbWx2eE9GeEF4Zmp2K004Z2Z2SElFcEg4QU5S?=
 =?utf-8?B?VTZ6eE9STFFmdHF5T0pFbDdoM2ZBU2F2bzFOQ2VudGFnaDRuOVZpNnlGQzVq?=
 =?utf-8?B?aDVoeWhXSUR0ZDlaSWpFSktYTWpjdGMvV0RRbGFWaVg2OW9lOHN0Vm5Jb1hM?=
 =?utf-8?B?OTkwNldibEpOaTFEM3kySUpaVjlBTUJyWkc5TFJ4bVg4YjBlRVhGenJwR084?=
 =?utf-8?B?ZnRzTXJEZVoyL2huUnlIbDRBZlk5MStXSnY1OTR1dzVVSlozL3BGMEdEQWRU?=
 =?utf-8?B?bGFaUWNNT0s4UFMrOWdRcDg1bTd6R2JEMnZwOUtUUGZzc3ZoTXdRZzZNV0M5?=
 =?utf-8?B?cmxydjhxRGlyeERuWkxlMDloYXMxM3hNWXROcGl1emlrRE9YaGxaUDZUVEY3?=
 =?utf-8?B?NTNJTXhlczZsYitSa1hPaWhVQWt3RHNSQkpwVUNzWlFycFJ6STlFZHBSK3Nh?=
 =?utf-8?B?VTc2RWtJSmthOFF5aDZTc0h5VE9RK0Z5WDBnYXpkQ0xLeTl6SC9GcFIwL0tO?=
 =?utf-8?B?bktEa2FSNnhGcUtEZ3UrWU1yNXp4VnlINjJZSVBOV2EwNEZFL3ZUSGU2SFdp?=
 =?utf-8?B?OEVkaDFtVGREaDdCcXZlT3l1Wk9mSjAwdUZHZzRxNXgyN3Rlak5BdkdNL05j?=
 =?utf-8?B?TGc2Z2xBUEIzYldqanNZbElacjVqdEtGOUgwN2pEOHE1alh3em5hNm84WjFI?=
 =?utf-8?B?U1JTcEpWRjd1clROSi9JdEFPOHM3ZUIrcjNuODNZWTJJSmJLMTYxRGx1N1VS?=
 =?utf-8?B?cmp2MWRMK2FDc1N4WHp0WW1jUnZvcEdVK2U2ejllSnI2S2JqdmxQeTZNNWk4?=
 =?utf-8?B?ZGZ4bVR1VzE2TzRXOXMyMFJVTERwLzNTdTVlS050M1BiYytvQlZsOTZJcXFY?=
 =?utf-8?B?ZnB5N3hHUFJQQXBPWUM5czM0eTFoNlIzdW5OZ0l6MUNMWEtkc29lak9nem8z?=
 =?utf-8?B?TTdiQ0o0R0doM0w1a0ozbTVVZkVwWXRCdHZCanNrd1RvTG9WQXJrN3RWb0tR?=
 =?utf-8?B?S2RtU2hGOGRVV1RrN1ZQb2I0VUdRM1VsbVNVNXgrM2VIa1dvQ2YyZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c05f374-90db-4efc-d36e-08dec63d398f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 15:38:59.4822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYb0zoTCKYk3sJKV/nOFqf5C3FsjDNtIDfx4/G3629aJdfnT04AQDQty6BVifstmeXlQIZv8OUadNkakrCUojw==
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

In the CPU->GSP messaging path, the code reads the read pointer from GSP,
writes the command, advances the write pointer, and then notifies the GSP.

A LOAD->STORE ordering is needed after reading the read pointer from GSP
and writing the command. A barrier is not needed here because control
dependency provides the required ordering. Still, document it explicitly.

A STORE->STORE ordering is needed after the command write and the write
pointer advance. This is currently incorrectly done after the write pointer
advance (and before GSP notification), but this can cause issue if GSP is
still processing ring buffer, as it may observe the write pointer advance
before command write. Thus move this barrier to be before the write pointer
advance. Note that barriers are not needed between write pointer advance
and GSP notification, as MMIO accessors already carries the required
barrier.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 10 ++++++++++
 drivers/gpu/nova-core/gsp/fw.rs   |  3 ---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 070de0731e95..94c2790d943d 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -20,6 +20,10 @@
     ptr,
     sync::{
         aref::ARef,
+        barrier::{
+            dma_mb,
+            Write, //
+        },
         Mutex, //
     },
     time::Delta,
@@ -274,6 +278,9 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
             (rx - 1, 0)
         };
 
+        // ORDERING: control dependency provides necessary LOAD->STORE ordering.
+        // `dma_mb(Full)` may be used here if we don't want to rely on control dependency.
+
         // SAFETY:
         // - `data` was created from a valid pointer, and `rx` and `tx` are in the
         //   `0..MSGQ_NUM_PAGES` range per the invariants of `cpu_write_ptr` and `gsp_read_ptr`,
@@ -443,6 +450,9 @@ fn cpu_write_ptr(&self) -> u32 {
 
     // Informs the GSP that it can process `elem_count` new pages from the command queue.
     fn advance_cpu_write_ptr(&mut self, elem_count: u32) {
+        // ORDERING: Ensure all command data is visible before updateing ring buffer pointer.
+        dma_mb(Write);
+
         super::fw::gsp_mem::advance_cpu_write_ptr(&self.0, elem_count)
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 4db0cfa4dc4d..fae2eae495d1 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -91,9 +91,6 @@ pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &Coherent<GspMem>, count: u32) {
         let wptr = cpu_write_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAGES;
 
         dma_write!(qs, .cpuq.tx.0.writePtr, wptr);
-
-        // Ensure all command data is visible before triggering the GSP read.
-        fence(Ordering::SeqCst);
     }
 }
 

-- 
2.54.0

