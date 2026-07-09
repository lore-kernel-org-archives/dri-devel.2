Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D64AC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FB6910F3BB;
	Thu,  9 Jul 2026 06:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="JL/LOEYi";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83BCA10F3B9
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:56:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qt921bNoUjg1SCbQrG1R6HYodCBLl77xHAcurEt3QDLURVJZo60S5+euz5rEe4j1dbnEGbByIpwDJuc6S7cmnpxJYMiRArGHHj0uEzFj6BO1WNTCJaLoFqWd69OIcsU1zZ+gWyiI2pWGRiN0uMFuzgcErdQ3KjiVxP9SF+c1MmIE/f6MWxnBX8puPVXd2gHTIu9plqEsXqMSYQW837bN7jZgYhNbxNqk0gBzR7EZ9blmf4sWhUqWKBhlFqIkByRwlzXJsfj3AUlpYtATqUbKpOHx94Neuwi9RQH7k0lq4W2HjKWmB4o6sTOzUkxxrLFIcxJ8Y8BEcsStEte8CEID7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qkze93cEg+LCCQm3xDADseKkFalthwRlHlAxiwtn1ck=;
 b=Fjd12V6skHAPSy+ZJ9mNVgN9H8uag2yRfqDuUm7T51/Im+4xHRAUiLgvgI6mV3U22A6tlJ0c7Sw0cJ0GcMTt794ONya5omp4AUSt8ROHn/0KThJcSOxVrwlzfi0UYz5kFDzUjRErGBT6lJC6oHuKB7E0cxhhLTDZyy8nxjeYevo1DvLjclRNT/jn3gdC4grvBxsO4WYKz/G7GIxYhC/fk036FTSh3s6hCMm3EdaIFiw8NSeb5TZ7UoiXhzjcleneLKgC3F30CnHR6kYkuNBDqsm3ruDTBMdYi+uWo0lczW6/uInPcRxZGRLGsBrW4ZMqPm+tI8L4EpJOTYnfLrAdNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qkze93cEg+LCCQm3xDADseKkFalthwRlHlAxiwtn1ck=;
 b=JL/LOEYiwkDtEu0RvKszLlo1Vk7kUbADkJy23gXphHaD1yNBwsQPIj2xJiEbHyVhsvcGhyF4pRe+V3bdYKdXsrHJa9bsoyIwCeJoADt7hperxxP5kZXXhJ0DP/cJL2B1rhkwqIYXaUqMcbRfcPCPVBDwHpHPKViDqRmvBU5n0h/MoWWoRUn84FNqrSVQGVQ1trLc8RIEhybyKPw1nPIw4cn6LZVgSZzlUUaf3PFyULPaTDiU/vNKQcEALjHnzP/LkjtT3XnOBaxtXscKI6+xK5zd9c0YLMqEnSzo/Bz6DtxhLqVruozRxNtoSxMcEturmf3g7b2Jixt8oqLwWC6QWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 06:56:41 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 06:56:41 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 09 Jul 2026 15:52:55 +0900
Subject: [PATCH v6 02/13] gpu: nova-core: gsp: sequencer: do not store
 sequence into GspSequencer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nova-bootcontext-v6-2-520cbf8b9b50@nvidia.com>
References: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
In-Reply-To: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0177.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::16) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a89a19-2f5f-4ecf-faa7-08dedd873aa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|10070799003|1800799024|3023799007|11063799006|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lcytEMwejm2Y7bSFoQxdj7gsztJRMKRRNtHrkLhWQt31lJxeTK1sFmxL4SFRPxDZm8eFi4lss+/tDKsWPzZ/Vr1zpEnCGQahDaJOoJMa47t7yPCs/UiLIOB0HZUvFP0EkrycEzS07uUiFmTuhRmklmkvR7eX4BvnxX3NFhbL8nXBtEIvxNze8nqLmbZj6XHYPkA40ibYPEyhrPqqGC4E8kOIMN/wEQod8AOCMC8DNhYH2b+fBlAhJBrCgnaQ3qPDmORljT7UuEHG7+M80obUzRDi0ym6KXB7vDyiD5Xg1DpAbEFiT7yEGqCJFQRretUIMeXCo1MHTHEW/o0rCJS8MzsCjG6iW27sxe0V7zEdEDQfIlSifduZCaFZdq+KOk/Lo5IDCdkTDQmKj+tsdFxIItdb6DFPeER0fZk03B381mLXSHh551MbngZwvPlz6rkA6KUtRgOyKMRRcLgYItKlFlo6OuGSRBxIiXN4aBP8g5N8YVO7pEicY9zHcH90UCeaZ/03Rp0e+QDnQxuETDwtkYjRJTp1lbeKaPk++KjEkvke8c3LB25Ln1x3JMOo7PNDNWZkiS+5irqFiaG9zmCTPh554Z8R3kChWUNUd8YIdJqOthC9JTxZ5iwu4YMkojkMaVW0oCvMr1ncKxXx5jXR5xjbg/qJok+pbNQCfbQh7BQJOuCVoQXsF+BVc/bJzHrKgxCm03e0FIt95uBSty72vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(10070799003)(1800799024)(3023799007)(11063799006)(56012099006)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SExWNzljcnpBaWRFYlA1RXdLRVRXaWFQMDFLbDlhdFBJS05WZnRKWWc4THRi?=
 =?utf-8?B?R29pcXBlSWVGUXF2WGJSMWhnV3RQVGgyYTdkN1M5dGgrTStKdEhTZmprUS9Y?=
 =?utf-8?B?YlNXdkFrRk01WFhFa2Qzd003clZXVXlRMUlFc09sZGtkaWhKRGRmSTk2aDU2?=
 =?utf-8?B?bXZQMWJmbmZXSU5ScHpUV2dpT2hWbVVBRHowYmlXNVpNWUtJME5mejZxV0tz?=
 =?utf-8?B?WTRNMHJYUW9UTTRqTnk4eEZDaWI2Nmw3bjBDZHdYTWZueHYvbHEveFU3Umtw?=
 =?utf-8?B?OXVpSThuVCtlSzdzNnRJS2FJbk9Lc2JKZDVqbzJUSFJxS2tzVVZBZFhlQXJl?=
 =?utf-8?B?cFNyV2EyV3ZEMmJWTXhza1pmdHRUdnFudDJlUVNYdllMZVRrZzdFdEplQk5Q?=
 =?utf-8?B?MFJIT01EajlpRm96OHBMNDFWRUJDZ1pwdG9iNHVWdXZaUmM4WUF1VTZHWERX?=
 =?utf-8?B?MWVnbDVtOUlpUjUxS3BJcFN1UHV0WmZES2FpdlB4NVVMZ3I3ckRpWG5kVlhD?=
 =?utf-8?B?cERUOU96VW5WeHVTLzlQeTN1Wi9tNmJXMTFhek5BNDFyQ29WNmUyakVNYzdz?=
 =?utf-8?B?UTZlOXVTNHpQZWd5QmkrNFVjQTBzWmordlhjNjJCcE9EcU1kdnBRdHpMQity?=
 =?utf-8?B?ZWNMeDJkQ0Z4a2FwV2oyaXQ1SThIYVlOQ0JKKzhiRHRiKzVBU2c4ZmxLRE4z?=
 =?utf-8?B?TUhxYlRKRmRhZm9xWDNpd0N4TEdaMFlzTXVpNjRpTTJPMXFreERTTFMyTURm?=
 =?utf-8?B?L3FxZ1dSVU1ZUFFJNExNZnY2ZWhuNVlwald3V2JGc2RETG9DK1hqczhSaGpG?=
 =?utf-8?B?ZXFFYytwSzZqOFZPbitybzFkQ3p4WCs2amJEcy9FNzZyTnNoSGtEUzY5REgv?=
 =?utf-8?B?dTZJd09GeDZkclFMTmRIdjR1TGlzUjRzb01Ha1FjVldoM2crZm9sanZBa3Fw?=
 =?utf-8?B?YjlPeHVSRGN2MVhzTEFJV2lZMHJNdVRVZjFIeU5nQ0VDWDRqZm8wcFF2VTA5?=
 =?utf-8?B?RmhQZFIwOWJjL2JVaDlyVmNQaTJONjlSWXdxV05OQnU1LzRURmp0ZHorV1RN?=
 =?utf-8?B?ckYxbnVLU0NRdjhYR3ZRT2xGbVQyRXJYUDJtL1dvdDFZZkpuUXE1S0xMNUh3?=
 =?utf-8?B?aHlYdytGK1VRYlRaS0gvK2pPYU1MRHhpNU5uWEZpbXd2NjZkcmVLQ1UzTjha?=
 =?utf-8?B?QThqMnUyVEYvWDlENmN1Zk9GSjVTWVJkRnJQN3F0WHJVS0hwMXduMldCRURi?=
 =?utf-8?B?c3VvQVE3VlZpOThadUJNcmZwU2FVSWUySkY2bmtvNlpTV0EvbkxwcU1XQi9j?=
 =?utf-8?B?SGZDQUVQTGo5Nk5BcVZuTGlWaFgrZC9jWDZxUFhqZWhNaXJPMmJXenJrczZj?=
 =?utf-8?B?YnFBV1BYb25kVUtxNGR2WFIzWE85T00zUk05NW1TWGcyWjQzOTZNSFlRRGUv?=
 =?utf-8?B?UVJBcEFFTERzQWpJaTV6QVc5TGhGdEFtMnk3amI3ckZSV1ZQNDVOWDE0cnhw?=
 =?utf-8?B?ZEg5ekRQNzdkYkN5M2IvblA5c3ViczFpNzZQa3BwbnV4SklRdEVFL1hMMHZL?=
 =?utf-8?B?dW14dlFVNlYyN3czb2kzREFDOWQzRUV1QmJsVGlwZTR2TmZ0UTJmSnhINk1i?=
 =?utf-8?B?STk0bjVlTXZwZUJyNk5oenJLUitnMEZzbkcxbVE4cUdqMnd3SmdQMi9EeWNy?=
 =?utf-8?B?QWgzMTlwZFVFcFRlT29NU3lLWlZMdnk5YWRqN0ZmYTEyR1ZVdytDL2RFa3lS?=
 =?utf-8?B?WFlFbGxKbVYwQ1ZZeWY2NzZNSXVlZm1aaThtQStYamJIbFBncGp5VUpHZnN3?=
 =?utf-8?B?U2RBS3ZFOENTaFpNRnFCaWprVUU0UFNFV01xNk80ZEN4THJIUlhOY3RCWVBq?=
 =?utf-8?B?QzNVRzVndHMzNzBhTGkySGtOYjZpam05NHEzLzBpZnRCZ1pBaEcrRkp0V29R?=
 =?utf-8?B?MEN1UjMyM2N0RnJJUVZxVDF2SEczd0QxdW92NEJVWFNnSi9waG1jMGt4Tk5a?=
 =?utf-8?B?YlVycDBhK0I2bHlWL2FZMzA5NGU4cjNNK1Q2cUExdUxrWlNQZHlGZ1F6QkNm?=
 =?utf-8?B?YlpURCtlRGlmS21vY2ExdUYvM0lBMjVhYkM4TzZucWZGL2ZOU0NjQ3UrcUxW?=
 =?utf-8?B?M0ZTVk04VkhZUTRqTjJuSk4zMW1hM1U0YW5laUNzUEFrNFNqeDhJR2tkeVRZ?=
 =?utf-8?B?THVBSE8rNkFUaVVoRDhKckdIdEQwNzJCRDRkUnZlU3R5L3drT3k0T0szZjVU?=
 =?utf-8?B?S0FRYTBML3YxT2ViK2owbGFOQTdGNzE5cUhaV0ErTzJuRy9uUXVYcEE5SjVF?=
 =?utf-8?B?WEMrQmdBTktjMDNiUm9qVG5LOFBzenU5RVYxdkwza21raFhhZE8xZExJRkd1?=
 =?utf-8?Q?YK+ArgGBqQ8ocMlDGkAPswDx7h3rRrY08n/z2u55UzAO0?=
X-MS-Exchange-AntiSpam-MessageData-1: iCJegnV9Hui7BQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a89a19-2f5f-4ecf-faa7-08dedd873aa1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:56:40.9716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swSM0ceuOPkmSbviCnMXmYvXMPEy1d2XPbH/44fjOqa/n7TDSR60TXYSjk0qg/LOVWiMU+JpmVCG4p9XQQ6y+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668
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

The sequence is currently stored in the `GspSequencer` even though its
lifetime is limited to `GspSequencer::run`. This object-oriented design
does not play well with the borrow-checker, as `GspSequencer::iter`
borrows the `GspSequencer`, which makes it difficult to introduce
mutable references in `GspBootContext`, as we want to do in order to
make the `Falcon` references mutable.

Thus, store the sequence locally in `GspSequencer::run`, and move
iterator creation to `GspSeqIter::new` so it no longer needs to borrow
the whole `GspSequencer`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/sequencer.rs | 35 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index f55205bd61f3..ddce32cc4e30 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -129,8 +129,6 @@ pub(crate) fn new(data: &[u8], dev: &device::Device) -> Result<(Self, usize)> {
 
 /// GSP Sequencer for executing firmware commands during boot.
 pub(crate) struct GspSequencer<'a> {
-    /// Sequencer information with command data.
-    seq_info: GspSequence,
     /// `Bar0` for register access.
     bar: Bar0<'a>,
     /// SEC2 falcon for core operations.
@@ -268,7 +266,7 @@ fn run(&self, seq: &GspSequencer<'_>) -> Result {
 }
 
 /// Iterator over GSP sequencer commands.
-pub(crate) struct GspSeqIter<'a> {
+struct GspSeqIter<'a> {
     /// Command data buffer.
     cmd_data: &'a [u8],
     /// Current position in the buffer.
@@ -281,6 +279,18 @@ pub(crate) struct GspSeqIter<'a> {
     dev: &'a device::Device,
 }
 
+impl<'a> GspSeqIter<'a> {
+    fn new(seq: &'a GspSequence, dev: &'a device::Device) -> Self {
+        Self {
+            cmd_data: &seq.cmd_data,
+            current_offset: 0,
+            total_cmds: seq.cmd_index,
+            cmds_processed: 0,
+            dev,
+        }
+    }
+}
+
 impl<'a> Iterator for GspSeqIter<'a> {
     type Item = Result<GspSeqCmd>;
 
@@ -322,20 +332,6 @@ fn next(&mut self) -> Option<Self::Item> {
     }
 }
 
-impl<'a> GspSequencer<'a> {
-    fn iter(&self) -> GspSeqIter<'_> {
-        let cmd_data = &self.seq_info.cmd_data[..];
-
-        GspSeqIter {
-            cmd_data,
-            current_offset: 0,
-            total_cmds: self.seq_info.cmd_index,
-            cmds_processed: 0,
-            dev: self.dev,
-        }
-    }
-}
-
 impl<'a> GspSequencer<'a> {
     pub(crate) fn run(
         cmdq: &Cmdq,
@@ -352,7 +348,6 @@ pub(crate) fn run(
         };
 
         let sequencer = GspSequencer {
-            seq_info,
             bar: ctx.bar,
             sec2_falcon: ctx.sec2_falcon,
             gsp_falcon: ctx.gsp_falcon,
@@ -363,14 +358,14 @@ pub(crate) fn run(
 
         dev_dbg!(sequencer.dev, "Running CPU Sequencer commands\n");
 
-        for cmd_result in sequencer.iter() {
+        for cmd_result in GspSeqIter::new(&seq_info, sequencer.dev) {
             match cmd_result {
                 Ok(cmd) => cmd.run(&sequencer)?,
                 Err(e) => {
                     dev_err!(
                         sequencer.dev,
                         "Error running command at index {}\n",
-                        sequencer.seq_info.cmd_index
+                        seq_info.cmd_index
                     );
                     return Err(e);
                 }

-- 
2.55.0

