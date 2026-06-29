Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4859C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E25610E8FF;
	Mon, 29 Jun 2026 14:10:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nn58DK6F";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012050.outbound.protection.outlook.com [52.101.48.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9C4F10E8FF
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:10:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9B2+ppDTA9JJHN6hG45v9T8S6fw3ebC4RG7HQzex8ss2X47hBs3TcH90Zis+yW2gyjlsMmzqBJKN1tf8cuW/UwCg4u9Ok6Ou9WPsI8b68sNxlJwXa4HkQ2TxdPpGHTJvZAv4t4G4YM8E5FI5hvoYqVdiPxgnSEJs18AAQpjuaK/7RPYyjBYTlOT1wZssnqXYvBfznZ3G58Bw/RmGgU9bqUVG3LrXlUX6wPDGqHVviiL9FYxlrJYGXnGW0+PVedYxfqMn8eT604Fjy/TVakyu0m5X3ZIxheRhllG1Vf2Og2yTCktZWj0zEeGP1kscMXT3vrTuqGC+OMnHLMK13MEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uB6wPeaXdK39UerLkaThpu8kCy6ncbC0N8op8lbVhXw=;
 b=Nh9TEvvvGVymvZRlRdRjEIi2uEBGEZtgC6RQl/KyG9AtVuGhXlpTkxaeCqKDgMESLb1q22ENw1rwYd6Pj+OuWd/dXNwAStn3nkESN+KyMHRP/UKPMgB41x5AkROaanrOedGnxbVdZA6IPowQEP0SlGWayCsnPROq020xXAnJg1JIcx+Vr0RxJ5PU3fIIxB4H9zF2NEuZGH1YhW4CSUUqXixIPPQRFHm4llclUbWyRNtA1Eu/qE2kz9iCUzwU9qW3YaqOEhdHQPSGpkN8dDR049xtmRVKdgjC4yApTU7vICRsxGNWWzuCk5HE2NFhEOScW0/HZTizuOq0gar3vsRZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB6wPeaXdK39UerLkaThpu8kCy6ncbC0N8op8lbVhXw=;
 b=Nn58DK6F2Ph8lfbFahGD2wtGad7eq7e2ZPxHA5bHPhnsP2ieAxhNkop2Mls522JjABunuwdzvfp7SFRewBUskA0Nesmq0KZUQGUNg48u14F24auchZE2DVpQlU1e1vGLgtfW0dZKH6bRmlPw3DdqkVwEiAqrbyT4qUPXb+zOnkZTtJMPiyFLipP5H8slY8j/Dbj6a1obDDcjzA9ql+dXFJ3l/kY0++qxwYdJol3jHLjNDrr/Z1QwfvAwD++Wyf5l5duZBq3oYu4KnCFIc338S6eZhrV8ys+8mmqN4Xloczh1jgIX5Rnr38MEq0lb552aUgPjt6G2gMRJzbbthrzYMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:09:53 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:09:53 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 23:09:34 +0900
Subject: [PATCH v4 02/13] gpu: nova-core: gsp: sequencer: do not store
 sequence into GspSequencer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v4-2-5539d8469590@nvidia.com>
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0076.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: c297be7e-8999-4946-6b1a-08ded5e81716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|23010399003|3023799007|56012099006|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: jIyOb0xPzl6nTvID6SgnmNtryK6kxi+kR+anfJ21AuK1+4OfkTi6Izheg0StD8xqaKUhb0KcoY9X9PvVrnPrmmGU0o/I6+lJm2DQKbgfUgJuTbpu2JIr0iI379+QZw3nmwsvjgwPVLr2vN9WAmFIoF7EY3sWYNOe1OdyCrinYuv3Q3xVqOpMhbt1LaRvgZSpLcRck6JsM8BKWvMksYiegP0YDacjb/+RBOXLVoWfrF8e38PW+pV3iRKe7tCrpZcrdpCkLJlSVMZnBFz/QSPhwd0CDS23JkYII0YJpE1VkPgXHuB0HWzRsOpVQiSrlmsmbFO6HWPFhENtI2r0s1NS9byN3o2FgyqjSjf2Md9qQ4geZziDBRcPQ5/7RDRwUnd5qQEdjhAJ+sqEP28+tol1TJ7uN+jf+CBgU3tIfgha35Y8wdMEqbhrxLn4QO94grhlbMKk2KuMGSVMr3OUU/IKaBcIVS+shwaUwTIvfbD9/jAC3+ql3ERewsD5O5Z17a1Aii7dFgiKr0L77Cb4HuSRBHoN/WfIJ37GHSepH/GS+Ilwv7cGmmEQlUivQSyxGFX5YOC7X5V4sVmbcHTv5+tZnlUyVySzOeHJzgcTWRxV/cSx1GkRx2T/vNGOvRZdIF03IxVnyncCaWhb4dJKGlxtudwNBeiPXDfwm23OJj159f/b0/jmXpyeLZzKHs6hXRfMVjF0vI+NFDOPZBycsMtGlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(23010399003)(3023799007)(56012099006)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODdXVDdVTmJRaU01ZWptaDJzNVdMK2FhcEQ1N1JOR2xUdnVYVHJJRHZLQmor?=
 =?utf-8?B?a1ZTUGNrVDIxenptU3pzaGJkQ1hJMmRXc1dON1FEOHRkYUlkU2JhcTZINVZV?=
 =?utf-8?B?U2s0ZEpwcm1LZDlMTXcrWHg5Sy9JbndrUUZlckZGTHVuaVFaNjloczdlM0tw?=
 =?utf-8?B?eS8rMVVZeXBRREdzeUU3M2VHUk9CVVJKUUJ6N1hBMk8yUnNYZTByazUvWW9i?=
 =?utf-8?B?SFVOTzRjNGZld1kza2hqSWU5ZkcveTdmTG80Wi9Wc0hEU0szbmdBbnd0bERk?=
 =?utf-8?B?Z2ZvcGhmS1lyZjBIVGt4dXJmS29uZDJvRmZydTNCVmMyRGs1dG5oaEVrK0dl?=
 =?utf-8?B?RXhQRTl1UGJXZVBNcW9IWHpSWmptV1VJL3piMnpQbTdDQlR0KzI0M2hjSFlO?=
 =?utf-8?B?OU45VGtmdmc5Tm1SRy80Znp0bUsyUEJRd2xoWHAyYkdoQmhMcHJWTDU0ejNl?=
 =?utf-8?B?ZzlmV3JXWG1URWVMUFNvL3FJRGtNN2YvOWlMNjVJcXlUcVRJYlJZYWpZMHAx?=
 =?utf-8?B?NjZqZ3NoN2NaeDZBMGVaZEZpTXE4SnMyYWdHUGRubEZ6a3FxNkdvNkY2V2cz?=
 =?utf-8?B?UzFwYlJHQ0FWdm9qZm5CTGZGM3ZCVGZmY2VEZnhKakJONnFCcitNWERmdGQ4?=
 =?utf-8?B?WHpEUE5GUVFCcEwyK3QrcXBaS3hnNUhOWi9Pa080MmQ3N3ZUeUtEZkFCUExk?=
 =?utf-8?B?SEl3N3VWdVQvRDNJUkNta0t6M3AvVDhCRnFmb0NCMEE2TmU0RklnWnlQQnp3?=
 =?utf-8?B?bmF0MkFZSzE0WjdXc3pWd0FLSjUxbzdhRXI1Z2NqZDZ0SENpNlhpOGlIaWlZ?=
 =?utf-8?B?RmFFSG5zdktrSElXVVNmdmVOb0xNOEg3SndSR3VsTC84ZG51dXgyU3h4cnd3?=
 =?utf-8?B?YUdZcUh4TGZJci9CYUFGajRNM3Nrd3ZUTVh4L0NJcTdraHNPOHh2SnN3OEx1?=
 =?utf-8?B?K1RZMkMwNG83aHpiZkF4RlZLZ0pLeWNrS0tYSWVVMFNFVFZzOFpPNXJ0T0Ez?=
 =?utf-8?B?OXo5OHhFbDFEdGlvd0tOeTJjUCtsblZpN3NZQTdkcDRmLzNxNFd0YW44TlA5?=
 =?utf-8?B?cWJoemc3cmFZeWkyU0xCeEJDOENDSDJweHh4OU53T09XWDdvOHdnZ28wVjJt?=
 =?utf-8?B?MGNTdDBLemF0NHliZUl6VmFrMDQyN2lOVDB1dlRsZTNNdTJtckx0K3RJQ1U5?=
 =?utf-8?B?dVdvYjl5RHdLSmVGTmc5Z25JSk1EOWJoL2lBdWRqUmtSREp5QkJ4eHRXNG9h?=
 =?utf-8?B?V0t4NXNENG81Y2dIa0RJK2pyNFpmTjZZSTlOdmttOG56cHo0VjdkakJHSVdW?=
 =?utf-8?B?d2JmaThWL3U2NTVBQTNFTk5qQ0NSYXFDT0ZZaWpPZnA2Z0Q1TXorQ096cEY4?=
 =?utf-8?B?SFhkWUZ6ejJmR2liNlZkYThvOUlzZGdVejAyRGxBMDl6T21jTTZZRncxNEE4?=
 =?utf-8?B?eGpqWVBENTBKeWpnYitUbEpFdFlUdFRPS3FpaEkvbjhhWkFjOUNmWmY0NlNm?=
 =?utf-8?B?M0F2OUhmcStwZ0FtdnV2V3p5QnQ4Z0Zzemt3elJZVUEzV3pqQUhyT1ZoMXo2?=
 =?utf-8?B?dHd1bEhmRjF3d1JubS9kbStKcWZ5SHVUaTVFU1BWeFluaVZzby9pd08yeWto?=
 =?utf-8?B?L0hocXZMSjQzay9uWENhNFVXdFErVDdsWWM0aTNDZHBhbTZhTmlBWDZTNXJC?=
 =?utf-8?B?TG1CSVZwSG91TlV0amk2ZC8vOS95YVBIVi9UYWlqMG5PeXFkcXZLR0ZCeHcz?=
 =?utf-8?B?aStWb3BUS2x5RkVqT3ExdXJBdytmaHNyNGtDS2hHQkVCcitLenlZTDBBUmov?=
 =?utf-8?B?OVp4WVJjaU5oRjhtcXlhVTdCZnJnMS9QUDRnVE1ibk1qRGxtTFBib0dzdjZu?=
 =?utf-8?B?Ris4N01adzJIMFF4YjhZZmlkK0oxMUxhd3Y3aVZIR0ZxbmRIT1R6SStJSjRR?=
 =?utf-8?B?NWRWUXdjYXRqc2ZrdHdQcnFjdVNYRGhqc2d3Z2xaWXJVUXV5Ym9xNytwOFpt?=
 =?utf-8?B?cXF1amJUMTZ3VFlyelRDWDY2dllFSjdNUkxqMkg4SGxtcjVMbVZhLytjeWJ5?=
 =?utf-8?B?ZzFOYnpoSmlYOHN0cVhWYTJVdldOd3luZTEyMmJXZlVrN3ZEL1ZqeGliZDNV?=
 =?utf-8?B?cFV5K2d2UDhaclYvZ0VpK2ZISm50ZHFSYjVHRll1eHQ1TjY1c3VSZHlEZDM4?=
 =?utf-8?B?U1Jta1YzdW0vUXlFbXNVZDNOTktJbk9NTlNLY2lYNGZ0cHhZcUdxSjhMUE5n?=
 =?utf-8?B?UnM1QVhOYWZZYnFtTzhxaWlqOEN3dUV0dDYvS1JsbXpyL1pZWEpXWHQrVjBw?=
 =?utf-8?B?S0ZqU29FeGhtWHVHeGFzVlhic1A2QW5LcjAzWTAvOGJMLzJ2Tll0aTZGRWh5?=
 =?utf-8?Q?OfvJLgRx5MBOHWg3WgHhWvqzgSpN+n+hymW2lIQmJfZ1B?=
X-MS-Exchange-AntiSpam-MessageData-1: DD3JbZQeJ8mxtQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c297be7e-8999-4946-6b1a-08ded5e81716
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:09:53.1682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZ8qJZ0+3Wv9KwJFbSa0sqXhjuEjJzTTPPZVHziln6WcXWcSzeFua5JKb0NaH9ULcT4tB73hvH9GTXJxL79XmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
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
borrows a reference to the `GspSequencer`, which makes it difficult to
introduce mutable references in `GspBootContext`, as we want to do in
order to make the `Falcon` references mutable.

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
2.54.0

