Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C62BCD6E60
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 14:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC0E113A5A;
	Tue,  2 Jun 2026 14:18:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="FQLB3WAL";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020076.outbound.protection.outlook.com [52.101.196.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B117113A55
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 14:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsNA/NoUVw9K0xyFgtXx60xf4uIpblFgj7AuKcJzp7VgDK1OXsPcMde3HHb9dNc3UZSc03j+PfbTdbYH/THaodWd8ZZSH732EiZDEGlLvqta3urA5eA4DWgUtZBigCWJl9/CHM4+umWHeIOP5YFoVe185om+DsUcvHZg9VRBLp7ilqRibO64zJY4VuYBGRT/rzZoLZJW6qVjJ0HCt0m93rg9J04HskViTXyQvjSk3OXQvIQTC56R7auSJxbjS/STFuianQ0z93sgJeeu5TVW/NTN5pVi7nUMIUEAqtxP95goMSepoYuO5qQVH6qcUdEqMweOhif+RwO3Zc3JyNF0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amOcFwqBcNigusJB60iddNNFuPbFU0aR8/CY4+6FsHg=;
 b=jMC9fqBOrpcRd5gip9FcX6Osek6xI0w+Dq/04HduXuA2Y6JBGcC+5JUW8sRs26plT84gmT3urm6Y2Rpwu6WSMVV3Rx3Na5ziytEwVQMQ0y4amsjzCkAZdUvfGZi88KdAjkK/sjF8tx1ACwy2dlbvGN8yM0G22itstfH3OKj234yvVGuieoS3+yVU2GDFwZuUNXnY2J6eWs3bXkFNtCaQxFbe8ER+5KVLBl9wZhz4j73nV8/6EHvPmboFrkPlRKJpyg0IWspptjbUy13bPoO5SqeGLKk5N4P3dSjgJEq4z73qhYWl0u2hxaHSTBsG/rT2I33dc4svdacw21yYllAuNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amOcFwqBcNigusJB60iddNNFuPbFU0aR8/CY4+6FsHg=;
 b=FQLB3WALvVMPEvHIZjyaOUBzxw8pveA0JoEBy3G4Fm0Bgg5jOfJQVWsJ7iQpPTCOTJnVXh3BOvR8QuR2yjr25CTtiYAHPm28Dujl9SbFbY7XAyLcBpjiXcW1SGXggIPqo8J2ZKAwniwZLSq6Y5MiuMOx/H7P5HtVbT8fesJR9yE=
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
Date: Tue, 02 Jun 2026 15:17:55 +0100
Subject: [PATCH v2 4/6] rust: dma: update to keyworded index projection syntax
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-projection-syntax-rework-v2-4-6989470f5440@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780409881; l=3143;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=eRDG6w0FISL1J7oUyssmle3iwxwHtdHrnBtOIHtu7r0=;
 b=bDEmQdmBwzFjNJd3dT6mVlNN0oU21+/fr/Qaia5keIGW9AiHzyXoyD4X+CxKJP5JDsO191uhc
 R5Q/stAIC/OCy6wmv5r1Ekxn0SG7wzra2LQd6Ubds4o7VeFspfIKPW/
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0539.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3626:EE_
X-MS-Office365-Filtering-Correlation-Id: 66bba71d-83ec-438f-cc35-08dec0b1c215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|7416014|1800799024|22082099003|18002099003|921020|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: obKb9TOl3i8RWKAjZojS5+DWVMzt08HBNh5dMZlPySqMTrOXKfdqaXg7wqNKrc3JVf+xa3VM5ATjcYHuJTZ3ctLLuy4Ovkk6+RdJJ1qjNAmxXBz8II0DiKMtlSxp65BXs5NHtYcf1Trlul0MPA9zV898bUqDd6UUYuhYilKN5538T1sE3olo0k441/F9ayjH7wQKODoklfUpunXmIxeBChPE7eU3U7n/vczc2QfqBIO+F5c6z6jRHM3zJR8u5JbL/9mkKPIYUjiC+eAQ1qlBtvHgBSKSAdAL9OZa/mD0fYMMGPx0seSbSGF5B2/vRSH4D3kGBbDeuZunEVeyj9jFrtxqCoPy41/aoHKMyvvD6Q2MvI9/i/BeKviAM09ZqK3N3ZOSt5IUIjT+pjQAelFiPoSlVt3cZPFhKEu2UMNAzsvUGf6fNbcdpX8u5sp9ZdQ5mNG1q6bDN7vm5xvoeO15jdNtC/6/9yGTkG8TbhcydJ9Y17eWLJfwHqn7wKJTP2yW8702XX0m8Kv+j8EqChF4YU+lYvjL3rDUG53S55uiPYxb5UP79rl6xm2cdsuZNz6VvLK8dNW4ta+9q/zA5XuN67Di2agjqUNSyeDu4YfXH5BCqp0xLrX5nRJD+4HcsLL6i++RS7UrEraSAKaSt1vrPjcKdj5vA/kSVoJ01uHxQtgdwLAfArrt1pAA9vDPEFHFK109GzkOviAyajEjN4EAKjAuJZf3IeuJDbXyRSVlbsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(921020)(56012099006)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2xnMVZ6MFpibCsxNmE0Ky9UT0hoU2tEb3ViN2hxZFo2ZnBxRks5L2I3Q0dO?=
 =?utf-8?B?S0tkd0RKenZ1Rjk3NTNKYmtSVHAvSmhGdVpnQVNnRWtSNEtiTHliWXZuczlL?=
 =?utf-8?B?WGl2V1pmRXNHVm1WZ0hmRGNZakUrY3I4Z1RzbGZ1N2xMQjBUbUxMczVsRUoy?=
 =?utf-8?B?S2ZEaFVVanN4VnhiY3VWNzZNL1NRdWNITVBPOVNsaEJ1MkhsVGk1bGZQMktu?=
 =?utf-8?B?ZCtzRlpZNmFaOXNKMXpZY0NpRnltOWJpZm5Fd1VuYUxqQWt6VzR4b3Q3KzA1?=
 =?utf-8?B?YWhGZFQ4cUZ5eGJnYlVsTEpiV05mUElNZ3pnMWkzZlFOREhZZ08vSU5IdGJ3?=
 =?utf-8?B?MHlSMzJxbllCUVNvQlpKK1lzVWlWdGZTOHZhMFphYkh5ellIaUVIR0F5eTho?=
 =?utf-8?B?TmFIRmRSQVBXRDliNnpGNzNqLzRkMTQ3aC9ITlZrZExpOHlkYmRMVEpuTmFO?=
 =?utf-8?B?djFFSGxIbjRWWllLVGhxejhha29pMnZ4bzdzekd1eWYveEphWWNsRi9NNUlN?=
 =?utf-8?B?WkZ2UHlXZ0liUFVCUnVpWXNXWTdrL2pCaGlPQ3dKQVNMU1Y4dm9LSXJTMkxu?=
 =?utf-8?B?T0tKdWpLZFlDdVdlNnJkZFE2NFdoZDFMMzFtR0doMFUxdDd0clZYM0NEUWhJ?=
 =?utf-8?B?aXk4ZndnK0N6eWFVR21HaXZqeSs1VStLQWE3aElyUlFKbk5QYmRFRWdFSHAx?=
 =?utf-8?B?bXpTSzV1UlFWVWVoR2FZWDJPQmpoaFFyTkZvVTQyNWpCOGY0ZUZHL0JuSUxq?=
 =?utf-8?B?eDludkZMTHlKUG1iRXZLU1JtYWdpd0ZnMytiZnVNVTl0NFYybCtOdnVkTmZN?=
 =?utf-8?B?VVNteUZGeWtyVkx4WWhUOEU0dGtVTHJCc1FaOGVDVk1TTjQ5eHNBTk5nakNY?=
 =?utf-8?B?RWg4MGV1RkhuUDd4QWVYaUlpZEY4U0RBanlXdnU4LzZjMzJEVzZIRW1OdCsw?=
 =?utf-8?B?ZzlnQiszSnpseUNUK3lSYkJvNEE5aGJOb1N2OTRLemhkZjUyQWFyb21RNUd3?=
 =?utf-8?B?L0xTaGphQ3Y2dDg3YWlNZUl6anFhSjdnTmFhbHpFdXFjWGFIbjY3VFVFWnV6?=
 =?utf-8?B?WXVIaWlGR3VBYy9YU1VUTjhjaVNJYlhZZlR4enJXNVRmdXpoZCtLUE54MTla?=
 =?utf-8?B?cDB5aVg5RDYzMURSc3ZTVGRyb25WMGFNNFRYVFlCVGtGdWxyUnZGMkVWamlD?=
 =?utf-8?B?QlltS3QrQVRoUW5GeXpXRmg3ckw0NjlyU0s1MG1lcEZUeXE5SlRyY0FVVjFv?=
 =?utf-8?B?NzAwUlFZUk40WTN3UkR5V2VpUERPL09UVWM2eWY2MEl5L3hBQ0tYMWk3azNJ?=
 =?utf-8?B?TnByTWN5azhhSnMveWZiOWtZUkJGZStNYktXMDZHQ3pJL1hCSE10eHpEb1Ez?=
 =?utf-8?B?QzVUOHZpZTJ4ckZOT0hOUmpEd3R1R1QycVhnbmliUDVxODVjZithL0ZRYXB6?=
 =?utf-8?B?Z2E0UUhkZ3J3RFpiWHVuZUMxV0V5OWhaVDlZQkRmZGhNalUyd05TQmNQeDFa?=
 =?utf-8?B?K2wzYXAxMTR4WUhISmZRems0Tk16b0J4cGFtZGlpZ0dMcHQ4RWd5UlZGTGt1?=
 =?utf-8?B?ZllTOXRqdnVMZEhVU2M4akZydzhoOVlPOEhCVytkK0paNUs1WHMzL042UldW?=
 =?utf-8?B?S0l5aFBRYTJDdUZpdms1eXVzL1RRSGJMOWVrb2lFTExvdTB5QTk1NTU2OHdi?=
 =?utf-8?B?R1BIbXZXVy9uWjVJK3BXVGJacGQ3cWVBNnBDOFRnV1FxSk9XQjRFLzJieHZ1?=
 =?utf-8?B?Y21uYjRjbGZ2YzFSdk1EMVRUUXlUbXlxV3FEVUtIVmwzN0ZwWWtya0RreVR5?=
 =?utf-8?B?MnY2Z211NjBpWU1VdWhJeGZNZnkzVURCeUdMa3RTSmZsb1p2ZDF0NDdsTWJE?=
 =?utf-8?B?MXl6MGZvbUZ2UXNORXh6ZzFxelZ4VGJIdStmQmpMTG1ybXJSajJHMUxHbDJ5?=
 =?utf-8?B?eXBZdjJWSHNlSWdCRGZ2bVdhOEFyMHRja1drdFNOZVhxd2wxL3BKa2pUcXR4?=
 =?utf-8?B?Smoya0NOVWRjanRwcDFpK3hSMlZkNXRLUi83YWgvMHZzL0F5UDZVekpzTHoz?=
 =?utf-8?B?cTVIMmowRC9Fd0tkSkhmU1poWUV2L1R3U3luRUFNYnlqVCtkVXZMN2gxekJy?=
 =?utf-8?B?WC9lNGFKS2N6R2dTLytCVXh0ZkNkczRORVg0YnNueDMxRUswZytYTmFFb0x3?=
 =?utf-8?B?RHlFOU16c29yZnJJRE9qRGJVVVRKdENuSjZpUCsrY0Q5bzZGVzlqb3hhN2hl?=
 =?utf-8?B?TDVOOTgzU2E2NHRTaDFpSmtQa2VJNEEzbUFUMWYvREVIcGttUTNQaUNkS3BE?=
 =?utf-8?B?WElwclBYRXVSOTA1Yk02UXlpaTBiZlVXSGsybXRyajJjOHBacTlQdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bba71d-83ec-438f-cc35-08dec0b1c215
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 14:18:03.1764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IyjqzSdpCSePrDDaCIiB4BmaDuPUVBEeL+XALyovPKJTR+9vfPLRF+OUQjUFsj/BCpiwUKYUS4bLYyu5afOptw==
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

Demonstrate the preferred syntax of index projection in DMA documentation
and examples. A few `[i]?` cases are converted to demonstrate the new
variant.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/dma.rs       |  8 ++++----
 samples/rust/rust_dma.rs | 12 +++++-------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index ff69739eae35..79125ee012a9 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -1152,8 +1152,8 @@ unsafe impl Sync for CoherentHandle {}
 /// unsafe impl kernel::transmute::AsBytes for MyStruct{};
 ///
 /// # fn test(alloc: &kernel::dma::Coherent<[MyStruct]>) -> Result {
-/// let whole = kernel::dma_read!(alloc, [2]?);
-/// let field = kernel::dma_read!(alloc, [1]?.field);
+/// let whole = kernel::dma_read!(alloc, [try: 2]);
+/// let field = kernel::dma_read!(alloc, [panic: 1].field);
 /// # Ok::<(), Error>(()) }
 /// ```
 #[macro_export]
@@ -1189,8 +1189,8 @@ macro_rules! dma_read {
 /// unsafe impl kernel::transmute::AsBytes for MyStruct{};
 ///
 /// # fn test(alloc: &kernel::dma::Coherent<[MyStruct]>) -> Result {
-/// kernel::dma_write!(alloc, [2]?.member, 0xf);
-/// kernel::dma_write!(alloc, [1]?, MyStruct { member: 0xf });
+/// kernel::dma_write!(alloc, [try: 2].member, 0xf);
+/// kernel::dma_write!(alloc, [panic: 1], MyStruct { member: 0xf });
 /// # Ok::<(), Error>(()) }
 /// ```
 #[macro_export]
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index c4d2d36602af..5046b4628d0e 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -77,7 +77,7 @@ fn probe<'bound>(
                 Coherent::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
 
             for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                kernel::dma_write!(ca, [i]?, MyStruct::new(value.0, value.1));
+                kernel::dma_write!(ca, [try: i], MyStruct::new(value.0, value.1));
             }
 
             let size = 4 * page::PAGE_SIZE;
@@ -95,16 +95,14 @@ fn probe<'bound>(
 }
 
 impl DmaSampleDriver {
-    fn check_dma(&self) -> Result {
+    fn check_dma(&self) {
         for (i, value) in TEST_VALUES.into_iter().enumerate() {
-            let val0 = kernel::dma_read!(self.ca, [i]?.h);
-            let val1 = kernel::dma_read!(self.ca, [i]?.b);
+            let val0 = kernel::dma_read!(self.ca, [panic: i].h);
+            let val1 = kernel::dma_read!(self.ca, [panic: i].b);
 
             assert_eq!(val0, value.0);
             assert_eq!(val1, value.1);
         }
-
-        Ok(())
     }
 }
 
@@ -113,7 +111,7 @@ impl PinnedDrop for DmaSampleDriver {
     fn drop(self: Pin<&mut Self>) {
         dev_info!(self.pdev, "Unload DMA test driver.\n");
 
-        assert!(self.check_dma().is_ok());
+        self.check_dma();
 
         for (i, entry) in self.sgt.iter().enumerate() {
             dev_info!(

-- 
2.54.0

