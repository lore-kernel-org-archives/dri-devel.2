Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF14F428D3
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 19:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BEA010E756;
	Wed, 15 Apr 2026 19:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="s51LaD46";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020081.outbound.protection.outlook.com [52.101.196.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F8E10E18F;
 Wed, 15 Apr 2026 19:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3LxmAmMK92zSvQhTfJ5tRqp5myOaXRt2qruGB+Qw7EETknxaFSXc47JNZzy4Di9WtGgCDaimKbgrL/y+THBLTnaZX5EUoJ8z/PRKUr/UNMkBwmtrMgmgmt/12X1OFTGlrYDmWOzgbHkokZ9c4tSDS5+SEq8cgTgXV1nEU90brlQENLoVAe98g41zgXO2wPKoiVhkfe41QFzgHuJddp4xOQw6pgmCYThKymxFBkFFK9Aw5G79BqrfbiWFfRdUQ/fm40POvucgQ/6AYy1M8KHfFqyiT+lvwWMo3PotVVMnDoYzwsCtkiYmVdYa+zUBygoEQjQ5CciRmqRUW5Jrb6QFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZIiLi9x3fE+V2ejFmr/3EeY3ITUEFCcTPgkvfGfqBo=;
 b=NgTuOH+Lhje9QqpOjzob/iuvfm4191vesW7+bsyRs1wUSdmYSUXbg7sSqrT9A1c1hiAGHGtGWHa4VYzQixTfAjW8oiQrlylHdl6cvnzcFDVHhLRvvxEr1ybtaGZwpSVULEaI/t2xpOt9TBsLPFYEDSdwlHMs5TtdSpOIuwATupXrC9YZghjeJ1i3rr5UXdKXsSXiso+cJrEvN8ORPOIU7swR1L5xXtHNbCa6ac4oPJXtSD9i3sQC6tSO5EqyOaS27573Az3G1Zc/lXQ0u92QdwyVhPCK8u3wQm+JoDUKQubSvCElRAC9QzIED2cvXeNKJ5GmSC7uwNdi6SmUH3f7KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZIiLi9x3fE+V2ejFmr/3EeY3ITUEFCcTPgkvfGfqBo=;
 b=s51LaD46gcbqlh4HbxSZicIvvJEfw1CqYxDVdDTPw0wevDUOkc8sJe6yW6VNMeYQoZDqCZvCNuwcOedU0nHVbT2NOoLi1r5QAowo/T09BpmGPIGc7ckXkYFRD8AMROsb6OZjyflSbqfuVAxzlhrlLHT225CFNoPXyDyzQ29a1tc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB1910.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:32::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 19:58:07 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 19:58:06 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 15 Apr 2026 20:57:14 +0100
Subject: [PATCH 3/5] gpu: nova-core: convert to keyworded projection syntax
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-projection-syntax-rework-v1-3-450723cb3727@garyguo.net>
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
In-Reply-To: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Alexandre Courbot <acourbot@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776283085; l=1889;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=vQiN78STvYTW9CBHlHELFu0E4dV6C/Imopr+6r4WBnk=;
 b=Jo5DImdT15KQ7gh5mFVa00sTqdvX/mWnC62kLa+/x6sRnCdDU/CbxeSg5m/EH6OscR7eo83kz
 DfLocvnVtgJBtWYbcprgT09VC7PlAcCBRKwmQ0ejnHNpdb72LLRo9Yi
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0276.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::11) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB1910:EE_
X-MS-Office365-Filtering-Correlation-Id: 445bf1ea-2926-4f85-1f53-08de9b294fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|7416014|376014|22082099003|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: G2uvZw/EZOpTi9yWTSNH30Kk033nuYspih9BjNlBTq0jiXCyYzLGVKaW8kRr6ZjdE7lC/US3YX0wKM1JGAqa50td550ZUQDNPcN7HcorKiRbYamYsuYBb3L0xVhaP3+mFlj2pelEGuDlEp8rpwkbkQlOdwPP+Yue2/DGzNhFwbJlIyJ1Ol0lj0OKPzIMo+f/4xvK2+MQE0Is/nKbHLmePMAjwRqfSYHIayoOJ3xHBV/Hr4ZpQIICPXHV09XTKQA6BSFWRqjpNOJ3WN0ulQ554d8Tbd5upOoqO5JWL4GPQIBimBVoAOmttFQA4eIhzdaHjpDuLC84KhZiz73rk1S0gQ4giAvPU3jJAIBi3E9uT5SGpaTjdkdRmQfATBYZVBntzvYz0eNuVumVBmkyvK6wUdfI/cuC+35L1LCcybc/lW03R0ChWnMhnG4dmynNwgT72Uw++aa+lX4qq4bd5/ntOptLohnmWodrIuEGYASlimtWVlHE4TyCf/XJQmhNKGHUR88nMt8qvPQLVKVpG6lbqlmCzdmdsPUXrks0NU/E2wb8g+LW4aZYnD91Tc/LsbpNx8hRO93Tm1GmvJ4ifaPyEpuNEGqD/rkV1qgbVlqitbatgiEwyAojEhl3Tihr+DKc0wPTkZrqscUFdbxciRbWutfck4CeasPZ6L+4G64ZOM82o6tr00LbxafXKN4PdQp0KE3TFT/BTZ0cIkR31bGlWaKAAUn2Dzdve9LHZEgpszWYyjga2s+uC2kN8HlfCs/zeJ9lRUEfivLT+wklKjW0ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(22082099003)(921020)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnVuQll1ckpyWEo4aHZ6ZldCSFI3KzB0ZXNEN1F0bThQZ2paS0I4QXVhaEJU?=
 =?utf-8?B?ZWllVW56VU01U0ZLTngzQXpOeG5pRStUbUU1N2FDbmJuTEpES2lRMjJENzhZ?=
 =?utf-8?B?VVNhT2x6c0xodE5GbXBYTHVNbEgrVW9GUnBLdi9JMzFMMTR2U3EzeW5MY1RM?=
 =?utf-8?B?L0RRdmhvNjdCOGhGRjZESlBTVDczZk03alpTTXNwN2dXN3BUS2dxQ25la2NJ?=
 =?utf-8?B?b1FzNHpKSDl2TVY1RSt4UnNuUkhoalVuSGcxcnlXNXoxTVN2NGJZL0YrdHdv?=
 =?utf-8?B?dzV4NW1GMk9PcVdpTjgyNUNqS20vYkdRTEs5YUZpWHhQOGYzTC9ib1JxRjlu?=
 =?utf-8?B?eUZITDFmdzdid0hiNXNzdytFWTFVMUUrMU56TW9XOEpEYW90NWh6VUlvQ0Nq?=
 =?utf-8?B?WXFKZk8xejUrek16RDBwNmMvN1BsdldZa01nUjVlUmE5Wm9paEJHa1FWb3ND?=
 =?utf-8?B?OWpqUWtlN0NBeVJTTGJkQVRUcmZQYURCS094Z0dPUDdJT2VmNkMyNEpROXNF?=
 =?utf-8?B?d250SnIwU080R1l5MVhEZy9YbjdTT2xudzBjMmZqdllDYVhQNVV0ckt4UWhH?=
 =?utf-8?B?dk01S0h3TWZMaWgwL1ZzRExCTk1kaksrNGtkQnNXUTNQR2RoOG5RZnlIQjJv?=
 =?utf-8?B?bzU4d3BVY0Fza0ZzYk1kc3VSWXZoZDg0RmQvMExLZk9yeWRMS2ZCamVNLzJT?=
 =?utf-8?B?NzRIT0FyOGFERkVFTnJVZW9FbkxMbGQ3Q0tZYzhpTm9KaGZvd0pzRENhNWZ5?=
 =?utf-8?B?Wlhnc0JJUFJQMkNlNm1TK1RVNjJaNmtrTlArZ3VVU2dtRWJMMEduQkh4eDVL?=
 =?utf-8?B?M2hMRjZHSFhHNDdsMWx2ZXFaaks1VlV4VWZEWXAzZU9MWnUxbkF4K05SUnBK?=
 =?utf-8?B?cDBaNmhFQ3pHMGJHbUltS2U4amhOYlorbEREK216VXBpM1JHNG9KY2ZrOEFF?=
 =?utf-8?B?Y3kycStsYWhhakNlS1VXaTkvR1F4bE5Xc0xadWFtVU5uQVY1cFdaZlZzZmdn?=
 =?utf-8?B?MC9KbGt4cERVRTR4OWViWWNiVUpldVhyenBOSWEzOFZkajVPODYwRkQ0cWdI?=
 =?utf-8?B?cGhremFOYTgybWZwUmZ2b0tpK1Vjek5WV3JRMWVkcFhxdGprdHpFR3BjTENM?=
 =?utf-8?B?V1RaUGkvYjFIWWc1MSs4QnpLOC8xRERLS214SVdCQ1JJTEkxcUtRSjBBYkM2?=
 =?utf-8?B?VlArcHFSNjJ0WnpEQTJqN2N3dzh3SXQvKzQ4cDIzR0JFdGgzakZscUVYT0Uw?=
 =?utf-8?B?MzdWa0FRNkRvdWY0RFZqKzcwTE92Z0RxZUJvYlQyVWRmaC9VWEFhaFpVL1JZ?=
 =?utf-8?B?WnlaU2ZrTlpyZ1c0cG5jRE9XSEdkamJJNjJ3M2pyYWNlMENUU0RBVDFQVlBa?=
 =?utf-8?B?UE40U3BuOWNOa01kRHpGZzZjOXJ5TlB5a1d4cWdsK3c5YWdOaDVibFBRamFF?=
 =?utf-8?B?TVVqeUVJa0ZuKzQ1cEhrTFUrNXZTQXd2VlkzQ3A5Z3NaVFZGVzVxSU5IRVNl?=
 =?utf-8?B?QmpQZ1RxYVFOQ3pleFhsV3lsUUc0aCtmUExyd21VYmlod21iSzZFcktsVDhY?=
 =?utf-8?B?RWVYeHIwSjRKUmd2a3ZQSHRqMXhLU1JyYlM4cGk0bDIrN0llTXB0N3NuSmxL?=
 =?utf-8?B?dG44Si84T1BzdEZOZXR2YU01K3dMOHZuVzIzejU0a3pDdm56SVJyUFJCTzV1?=
 =?utf-8?B?eDJEdHF3bnFrVUlLcEs3SHJwREtxbUh1eXVQQmJTSWVCMkluL0tMejFqN0VS?=
 =?utf-8?B?eHJObGZZNnJSVXlMOUJiMnpPS1Qwb2lza1FsLzNUS3N3WDhHekJWd3Y1ejFU?=
 =?utf-8?B?VzJXTWovU2ZwRkFDWm5oZzNhN3lURUlXZWdDWEZVZkRNMGxHRmdEajlJUFpu?=
 =?utf-8?B?QzIzOGtQUzF0ZWNyeS9DZmJvcklVVHpFNThObG9CcHlLcy9Xd2xWaTlxWDcy?=
 =?utf-8?B?STZWb05mNFBHSFBBMk1YNVlSMldMaWVaMmxJSjczaWpaWXBKeXYvZFc3Ym0v?=
 =?utf-8?B?S1Y1eno0ZndQazFyOEdjbzVTRGxCdnhVTnVvTWIxWEFteXRlZjFQKzVuVytG?=
 =?utf-8?B?MGsxT3p5VXNhcXZVNEZDL1JBZXNLSGx3K0dLbXk3aUZhTDlEbk4wUnEweWZ1?=
 =?utf-8?B?TENGc2lGRFNHOFVEZmlUKzZZMXZCZkhXRWRsV2E2blZGVlhMV0JPWjNEcjRQ?=
 =?utf-8?B?TjVmdy9vdjZqcWFQMVN1bU5LNUsrL0FaU1h0MTZhQ3hVZldaVUM1YytUOGlv?=
 =?utf-8?B?OHlNUDNKRjhod2RjZS9LY3g1NDR3TjR1OW9EUm1sKzZrOS9oM1VwSFg0Nk5h?=
 =?utf-8?B?dzhIMG9aZjJvQ3dmODg3bDJhZVo5Tk5RVXRtc1BSdktkMHhZMnBNZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 445bf1ea-2926-4f85-1f53-08de9b294fd7
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 19:58:06.9423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PqoxCme4zarxLzsI5mfxzbUDon2XjzsRWn3p4J6B/+3r359PP/dJAoSBowPwNzWjAezXXKV6GCvhc9ySiaLZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1910
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
2.51.2

