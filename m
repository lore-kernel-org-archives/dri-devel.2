Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BDFCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 14:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49378113A5F;
	Tue,  2 Jun 2026 14:18:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="HCIfNjhQ";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020076.outbound.protection.outlook.com [52.101.196.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD81113A55
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 14:18:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewrYNTs7gJruZkvEwSrwG0zcovjxKa4EyqMCYP/9Mfl/ohsjrrSA6T/uisoYWQnHNWpnTnRlwzh06dhCt0JBub/923RKAhX7gxk2eISORCla9n0PzZ0yjKDfgFFAOuTmXxC+QlHTR7t0bIeG70IBmXYj9AjKXxBE2tr+kIJGfAnSUJxtXAKN0bJ8/whaFFVUTQfDivZm/mDK8StFgY4NHAm8/GO7c5gJqpNtKHwCNSASWo+DGpcH3H5YllZEeh0V9Bom1bHmVx98naFhZfSAvSSGqoa090PW29LNNR7xMPbdn9+jNKorZDDvg5YwO/Bu31Q7gBr996Ea5p+7IjkZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4zZMK/7h4iqLlD+baFLT1XgssBJzfQJQok27mit+Uk=;
 b=QvjBDumY4vBgyptqLuApUovY/CWhv90vWp/g4xvM2pfA5dQWy8Eyyl45MlqaC1Km3HpSlquSxAVtMFzo1CgnFrXYy+n81tGsntdkpCzYwofyvgw7YeLXVu3beN3KvYeqev0F6DsQw2qpxUzmKI+cHH6BRsXfc5ZICFRtI50bQsYxBixFKqFoqbuAL9HJ/oxzBXuTh/5aUXOvmPeWzziEEmpWeXiwE+MuFP3wMhDoFyo1IboaspYT1v49pV/sckVf93CVqzUSt5QPBc05tX3UljOB9vfbrGSrt6yLOKKJAs+o2EzSleZoURLAalG7M3ENyoWq+rhnBPNfQ61hwiPhVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4zZMK/7h4iqLlD+baFLT1XgssBJzfQJQok27mit+Uk=;
 b=HCIfNjhQB3v8TasynnwawWJffKY4jdg9eV92XdWhqi7/uUVODw0xKRxC8Q1b960KukxkVvn9/24SfemVa0WrUqPfleD9NtNJiZKemaVZe5znLu+Ff5xklh5tUD5wuo27VL7SZxpes9rrcy4Zf5opRjRKn+AuBNd41NtgRydUEXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3626.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1b5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 14:18:03 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 14:18:03 +0000
From: Gary Guo <gary@garyguo.net>
Date: Tue, 02 Jun 2026 15:17:56 +0100
Subject: [PATCH v2 5/6] gpu: nova-core: convert to keyworded projection syntax
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-projection-syntax-rework-v2-5-6989470f5440@garyguo.net>
References: <20260602-projection-syntax-rework-v2-0-6989470f5440@garyguo.net>
In-Reply-To: <20260602-projection-syntax-rework-v2-0-6989470f5440@garyguo.net>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780409881; l=1991;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=2S4LA7wmS4606LlO4moCawDT8voANZGuazZhpD5ppxE=;
 b=rcXroriMVp/pN0IugLWraGESUJKTQzB7Fchd0FzWIvFtuKhBjwOnm/HbZp+GRrND1jyo/WzGL
 cI+4YYklXcuD3urxMcKPVufVSQdVYeyHiibEQIK1g6/sHF6i3a1Skes
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0539.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3626:EE_
X-MS-Office365-Filtering-Correlation-Id: d8863c59-f29f-4cf3-337d-08dec0b1c249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|7416014|1800799024|22082099003|18002099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info: b4pl0XfI6r8FfvP/XwYZListUoSfSLdytfJGctjVwFL/dIlMp8LotcX755lKh5HqFyl4vmu3XhLXG/HSgyOz0HVV9prY6JuArG0WSbBUaoBDPFm2zEhVeHOv4P+ebQD6iS17O+vHEOmBV7Y854ZWVwJIARntH8ujSN/NzBnpbJ+mKBZZuLSn90wRfsecW+5OTrv1BXamcNv4D/5oDYHFVuCLIct00GVY4dP9nVwG0vU1gPmiTrwsvEJRThKgFMEcmYxfMJp/aqlT/8YjEMNyoTD6/IsA/1Hg0m0s0lzE5AqBWYYzWsHVGCGWQeO2IvwmELBCf6xR6xyDviu0O1iG3eKSMlId7GV1Mk3ddYlHWGZi030jPpK8Zb5Lu/tlr/2ohQwJFrRlNaUGCY9J2BEMTd4pBvvkfstHPYd+yQCnDQR00YWNa1XqnAz07J0wHUesN2R7+4N+N0PbdIYP+Y4EWTwllOsS4T/kXq6YcYhgJA1hbyyU1JU2JUCkXLJc61mTyqkW3pfFu+AHIzjC62u4l7MrU+Yyz7brUEkr6KQoIds7Pc4ojgJL0/ZLQY6Pv89MVDXLRMeUU8oE4lpT8XkrpOocgdJu89gNRenRZufLOWk/LAS6CevUT+zdiC+aWnWxGNnhBvMw+ks/Ls0zPjY+bYAZgV9gVLdgcRX6f718rU8O6Vo5Shm5ce23jFGlqmoPzlg8d73JoyBKWiamHyriLtJSlN2D7joRTmhW3HHNijk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(921020)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGFhT2dnNWNRb25nWUlwVFBFUnh3WWcvK1E1Zll6cXBpNjdYMFozdGYzaTZH?=
 =?utf-8?B?V0RkL2dwekRPMGxpKzZoRi9NTDE4b0NsSzF4WFJFR0gyZmhheDR5aWhYdVZq?=
 =?utf-8?B?UE1IMmRnbWM0bmVpeDVSc3NYRFFvdGJKV0RsOE5jUDZPZE1XL2NGMUthcDFT?=
 =?utf-8?B?V3pKZHRaWEorc1lWOTNhY05YVXNPeS93SW5vWHVQVUxWeHdhcE40a1ZmNXB3?=
 =?utf-8?B?ZzJFRXY3UTJ5cDRYZEQwWFowemZncUV4ZjR5N1QxaitHZzJMRTBBdjd6T2dW?=
 =?utf-8?B?cUFhRnViaFdDL0F3N0NTSHFGekt1ZWtlVUdXaU52a0REeVhzTnQ4VHduNlRj?=
 =?utf-8?B?cWhIMGFIQ0tib3ZMQ213aHNNQ1U1TmN5U3k4dDlwQnRQN1NsRXNVbjZUaUYv?=
 =?utf-8?B?ZFpVbzZ4L1ZBQkN5cDVPT2VRUXRNQ3R3T2d6Z044dkhQRE5DOEFhaUU1L3lu?=
 =?utf-8?B?WjlrWE5IRHhFT1hzbmE3OFlXaVJVVHlLeVg2cUxLalJ2NUZMZ2NZZUhHQ2Zm?=
 =?utf-8?B?K2tLRjdLSE52N3UrSDlSbkFxOWdHTmN1V0pLdU9BbnR0OUdGeFZmb2MyaW96?=
 =?utf-8?B?LzIzL3NXR0xSSFFiL21iUjZQMy9rdG80M0owQk5uZ2VOc3I3dytEQVFUL1Mw?=
 =?utf-8?B?a0tBRjlqOUlRL091aDNxSERQS3VFT0I0andPTGEzUVhwcU16b2RQRmxVam9u?=
 =?utf-8?B?Q0ZJSGJoTVhNdWdEQWpBVFoyR3U2Um9wSUszZkIxa1NEa0lyQytmbVVXQW00?=
 =?utf-8?B?bTNiR2dlOFNmaFRUbHdQc2tENFR3a1R4Wi9rbGgwaHdYSDc0cFRUeDg2SEc2?=
 =?utf-8?B?emlwa09Ha1FXSWRrZDlWUzR1YkttVU5Kb3hQcG9tTTlyNTE2VlNhMncyajc5?=
 =?utf-8?B?SHZDSjR4SEl5ejBKUHZRYWkyUU9xT3hQSnByZUxhWjFnZHhueklDelFtNy81?=
 =?utf-8?B?RHBHK0cxUTBydWkzcTdGT29XZjBuYzhDd0lOTUxZcFM3L29teW1tVzVFUlVq?=
 =?utf-8?B?aGRMRlExK1FTcFdqRGxHYkJBTUpBTmJrejlCM2RGZU5ONXFqTU55dmFFajV4?=
 =?utf-8?B?SVBSMnI2dEZJYndLNnlKODFRczk0WmNYb1FxdFlSb1ZZamN2MGwxVk0rSHQv?=
 =?utf-8?B?a3ZndWlkWlFHMk1QZTRRVGNGUE5ZYW5IYU05bUhOMi8vc2QvYnZLZG4zaDZ6?=
 =?utf-8?B?TGlldDJzMm5oUkFvYW9sRU1HeVpTSmI3T2lRV0l5U0pqRkM4WUtsdG5XVkhS?=
 =?utf-8?B?TG5OSWdEWVUyTDRudEYvVWd1SG84d1YxVm5UMVI0bUVVRnN0VTQ0TW9UMURW?=
 =?utf-8?B?YmZ5anpZUVpLNFhyWDRMejRJZ29ibFpyZm1kRFpUQm5DMkh3T2pPM1ZhQTJH?=
 =?utf-8?B?cllCK1prV0FOSHhXSHNGRDhDSXBSNU9Qd3ZlUHV3QTZQTmRsOTdBZTZ0Vnd6?=
 =?utf-8?B?R0dzZFhycjYyTXNjM0pWSDVRbXEvR2poYkpWUkNVZEp4NW9UU1haeHkxalZJ?=
 =?utf-8?B?c0ZXOGxjN3dzSmJVYjhCMzd1eDl4NWdCWko5QWJJM0V0UC9xK3pDY1FydENa?=
 =?utf-8?B?NGZxdzlFTFhwZUQ4N0FIOFRxbFNpOGE3enlMV04vNldqTk03NGdDTVpTNjJW?=
 =?utf-8?B?QUVQOUpiQjc1RjlNSFE5NklvZVZEdHQxQ2t4cnJKWUQ5MXZCR3NFR2xtRi9z?=
 =?utf-8?B?N1h0VE1yZlNDSzRwNjNvYVRJT29CMnI4Q0F5K3J6M004aEVreUhLSENta1dD?=
 =?utf-8?B?b1hHbWdkcWNIV0RMbHd2ZnJyZjc1bFJ1Ym1mMkNoVTE3Z0ZEQTd2Wkw0dE83?=
 =?utf-8?B?ZEhFeW5qNHF4aDlDRThlNmlnVGJ2ckNoSUVaRlh1dUVzS3ZCRXExakMrb2w1?=
 =?utf-8?B?bW93MnA0SmZ5cGpxaXd3RWdrbDJNZE1ZcDl6Z0s2TUJoeEFhTXJEdHNvS0g0?=
 =?utf-8?B?MnYzOThZTStGc3ZBMHlhMFN5bzdhdGh6YTArSTc5ZjFBcFdvbks5SUZ5L0Vn?=
 =?utf-8?B?dFdyMC9TMDNpQ055Rkl4K0tHWHF5RmxhelhLOVZXVU9JS2xpN2JVTEVvZ2Iw?=
 =?utf-8?B?eEdHS3RQSXdTNzlobjR1UXhOazVTVmJBeTNwY2Y5YnNSY282RGFTQzNlbDIv?=
 =?utf-8?B?WFZ0LzgxR2JYYXByMDljclFGSWxCU0FOdTN6ODJFb0hDS0NYeHpyV2VLenhB?=
 =?utf-8?B?ZUhubksrdFNTOWpmZG96aWpTZHFUcTFEWURqN3ArTGJTWmhHaktlZ2RsYStL?=
 =?utf-8?B?RXZoYmlxSTdzd0p3YmxhTGlNczJLNWVwNDhmd3luOG9zQmxhNTlHamE1YThQ?=
 =?utf-8?B?K1R4alZsYTduR3pBK0p1YVl4U3FXVWpsaHdaZGhVTWdOU3lEb3U0UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d8863c59-f29f-4cf3-337d-08dec0b1c249
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 14:18:03.5176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqy6R1oAh4H7U3kJPZeflwZi4jjhofRd7PAsy+uOodNEQvMGq0Pyf7K97iDUyCY+zDywQz+xQslpYBwuyI6tBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3626
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

Use "build" to denote that the index bounds checking here is performed at
build time.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 275da9b1ee0e..1c9b2085f5e4 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -237,7 +237,7 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
         let start = gsp_mem.dma_handle();
         // Write values one by one to avoid an on-stack instance of `PteArray`.
         for i in 0..GspMem::PTE_ARRAY_SIZE {
-            dma_write!(gsp_mem, .ptes.0[i], PteArray::<0>::entry(start, i)?);
+            dma_write!(gsp_mem, .ptes.0[build: i], PteArray::<0>::entry(start, i)?);
         }
 
         dma_write!(
@@ -260,7 +260,7 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
         let rx = self.gsp_read_ptr();
 
         // Pointer to the first entry of the CPU message queue.
-        let data = ptr::project!(mut self.0.as_mut_ptr(), .cpuq.msgq.data[0]);
+        let data = ptr::project!(mut self.0.as_mut_ptr(), .cpuq.msgq.data[build: 0]);
 
         let (tail_end, wrap_end) = if rx == 0 {
             // The write area is non-wrapping, and stops at the second-to-last entry of the command
@@ -322,7 +322,7 @@ fn driver_write_area_size(&self) -> usize {
         let rx = self.cpu_read_ptr();
 
         // Pointer to the first entry of the GSP message queue.
-        let data = ptr::project!(self.0.as_ptr(), .gspq.msgq.data[0]);
+        let data = ptr::project!(self.0.as_ptr(), .gspq.msgq.data[build: 0]);
 
         let (tail_end, wrap_end) = if rx <= tx {
             // Read area is non-wrapping and stops right before `tx`.

-- 
2.54.0

