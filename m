Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1BFCDB475
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A82310E4D1;
	Mon, 22 Jun 2026 07:11:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="kt2WF6LO";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 471F810E4D1
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:11:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1oFLJQoAOA0p2oYzGsaao6hvomJNAphaF0Jw9k3FWZH+euaRtI1/CRbwFKs1CKfU39BjpMH6287juHMrfBu5VmcE9l1N/1ja9Hck3YZBaLO4TsoJHT2VuZlJRzedeQIJfYjDrFOhU3d/kkIvNU/Yw3QfaFuQaeP1eb/PQ8bTw8IiKoscfDHI+mEHA3kWVa2jUmaakssQEic7qXZT8pS3hHslctW9PWtsPgkAnEwFTrQlg+aUw0y/onyUXf50b5G1+KUxbpY4NFcmqNOd9S8n7YxAzWcKPLWquL1g8GbytHMTlEIxJQpdmlbbkmb/CDoIgmKVNmP9NWy0tNFqM9T3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cx3+iEuDKmzsSY2P4ExDWrdlak3Hl9QjlpzlafW28ts=;
 b=Z44OVWM81JYnd5opmwpoLqJrq6OI7DCp1k48yjcTZcd7RyByk8XuShrFyk/Hrs1bZuPnQqF23mU0x9WsHV+s2Rcsptyxv+1BsJR01GXPdoJ3NmCLpYHGgtELtMCFMzRUIouh6Jdz0iYbSfJxsBdOhVWtWc2CYOoilmo9dLk06Iotjv9RText/M6arosXGWDpwbtkCP04PdgER7q+bGbfaqxjYmEdFXtp/3JzaFF9cj5aRB9xDpl7/tHsKux/bZXlELPcyZoBQJnDpipm6iQGMsesZAT1v2V6wSPy1UelTPqSNvM6vhsIkAM6BZ0H2XLalP37bw5vM2dtuVgxj9YEuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cx3+iEuDKmzsSY2P4ExDWrdlak3Hl9QjlpzlafW28ts=;
 b=kt2WF6LOX0fo7h1GDwTCu2qbqfqWg2toLHOPiNgvyX67i5XNFSBurkBPTNcsENTRMwxOyT5CAgh1nlEfhd5IGtyheE0cNNhNTRy5ZlVgc+2P2nS3xROKW295EIp/u4vUNKyu4oCJqkWMVTFhvZp9HKhVWnWdLKy9SFtOD+81nuNxPZQAbQcIixuHJE6hkH4nItbx30i4MkvrsctI9ddRB39PeOu4BXD7Wwn5ivL93OUkik2q7F9nk6WXFr2ReaFnSRZSD+Rk8Dg5cTFPZf9MtiYk3p1GnboMHgKylv52yq63Y620KK6dxm1EGOm9Toca6lDOvpX+b9aRpvxORDUa1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 07:11:02 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:11:02 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 22 Jun 2026 16:10:24 +0900
Subject: [PATCH v2 02/13] gpu: nova-core: gsp: sequencer: do not store
 sequence into GspSequencer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-nova-bootcontext-v2-2-0ddeafc06f5d@nvidia.com>
References: <20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com>
In-Reply-To: <20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0128.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::17) To BY5PR12MB3986.namprd12.prod.outlook.com
 (2603:10b6:a03:195::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 364b447d-98b7-4136-a294-08ded02d6a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10070799003|18002099003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: z7R4ld+IQMGyVjr29zpmgC4qUSC6ldaK2uTVMDtyrzX3SkR8mdHJo6rDO/aSBFmYR29xQrldlaqq+rRIX0KhCrS4KTTMEwvwAkBCTtNpWIFczY08bQtnaLXiDLrw6EGx4y662EKxVCPje8ANKEGONZ3lkMMWuP1T9vbJZMyxVoJ+5vAjbwbeWBHAoTY8/RZapKm5Av3MWTgxlVmmI54Y8tOwCFPNe9Wcuss/QRXj5HR1wAtApAEf0BAAmVZ0Mlv+CsDosPAeMVMQKlsPxE4ZzGKMhTCyUf1IuLJvB2wlECGc5yBGO2gyq4seaMtsuRULI0LxSb38XhRbe+XjLVL8kBWATZ58bH6RJ0gvkm8ds5HEDP9lTOGSEDJrbbouYO55BTnt1zo4b9BRm7VyOWRcMivrIHF3UkfBkTL1yeR8GpDi1vPzWJTkd+2pviavso2wxoVQtJQq4LoYmJnJQG+DPcWW+bD7mkHi9e99wEec6H6w86bFnLAJ/n91EKLJvI8pO/MKaIwQcLwkOSdFT1su+eIhcNpr+IxhrxnuabIrCHyx6a6Q2nnorT5IRdrWFkZ/E7To+Jl5LihO1Pbc0HC7hijK1/mqvSL8p6/MLGLYbqseMSlVfIbTQ1skue5xAu/ncr3wAuezsdgOHkDCNSdLeFZXrz5PyWRbvIl2cj6sv9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czRxQmFScG9vZkp3cUI5OFYrNnJWS09ITzFuUGw0aXpHYjA3S0EvN21sTkZL?=
 =?utf-8?B?MEFQOW1MK1BnVjloUHVpaE5TYkpTQnJwSFF6VTArK2pqSUlOcG56R01tV1di?=
 =?utf-8?B?MGdBK3p1MStma3FERGdqWEhtckNnL24wWTFLQTdEVnE5VmZNS1daMjhVT2hK?=
 =?utf-8?B?eER6R201Q3M4OWcxVmozTm9zZlB4UmdSTW1aUFphdXZvV0ZrSXhlOEYvS3NY?=
 =?utf-8?B?UFBqSkZHbTA4TSttWVozR2xlZ2dvQ3dnK20vbnRDSmZIQXdGU3BHUndPaUlI?=
 =?utf-8?B?L2FEVlVkckRFaFJEL1BMdXhtMm01UVZYL20wcWFCM09lbXE0U0dGVzdnaFFT?=
 =?utf-8?B?dEcyUWxtSitjU1BrUnV1UTNuVmNXNHZhdUpsUnFNYmVZRUJTMEhoM1d1VW4z?=
 =?utf-8?B?cmlTTDY4Ly9xR0dxenBKT3lGdWRkNFdXOUJ0clBZWnJUdUFUNzQrVlVidkZT?=
 =?utf-8?B?ZWFCUzZLUzRaMEFZOU9KNVpVYlVKMGQwSmpqM3lrTXJkUlhJY3daNEFnZTdT?=
 =?utf-8?B?WlFoNmZwV0Q4cnZ2TElnM2dJTWI5MThCVklvK2NLdWoyckZhZFJkZTNJSXBq?=
 =?utf-8?B?ajZNL0Q5OUxMU055T0t5TWdqeVpsTG9GVVFFMklzTmxXOXd3TE44UDNoRzVO?=
 =?utf-8?B?VWl6T0tLWGlhZm91ZGxheHFaWmpSbmUvUGRZNFlZQnRCU2dHc3VLZWQ1Q2Vw?=
 =?utf-8?B?OGllY0E2eU9UT0tDNTdiMDh3Qkdkbk91dy9hTjZWSDdYOTVyZjF3WnNzSkNl?=
 =?utf-8?B?VnJrTFoxdDNxbWpNUmtmSkxYSnozSVVYRzVkV1hBYlZLQVVQclE2RGxCSGtD?=
 =?utf-8?B?QkdBNlovSnc3TmpwU0dYdjhUYWc0YzhUQnlCL2tDMjlwalc4THRwQzZvZjVP?=
 =?utf-8?B?K0xpTGZUODMxeU43eFd3OUpHeURrZzk3YVNUb2FFb2s5RGZiNS9iTEkyK2Jw?=
 =?utf-8?B?Uk5wMEhLditBYTgrV3NOc1M1TU9CVzJNS1lRQTZNTDJVRWQ2NmFpbnN5K29C?=
 =?utf-8?B?cnR3TGtIR01hVWFHVENsKy94dWQxcUc4amR2VWpMUzQ0dElrcm1JKzNIS0xr?=
 =?utf-8?B?azZSamwyYVNjWlNwaFdIQ1lNOVlSb3BqT3JYU1h5K1RWcmZnb3ZtcDBIekZ1?=
 =?utf-8?B?cGtsTmhmZWlkVjk0bm9NUDFLVFdCTVB2TjVkWWVuOFdRV2hhakNicmE1R2xI?=
 =?utf-8?B?ZldsNTVoYnQrTjVXQkVBOElWNEtwM3VDZnpIQ0V4elJaUDZlYWt2UlFjMWhR?=
 =?utf-8?B?UmpaSmEyakpnOGFMbmQ2NFdvVFFFR1R4LzEwdUFsaktYSUFzMVBtOGd6Q3BG?=
 =?utf-8?B?cFB2cjUzSGpMYVU3QmprT3ZxenFhSjJxL2lJQ1RjZDJZb3psWSs4a1ZNcjd0?=
 =?utf-8?B?VVIxU3RzYVd4bW5ndzVMTTVSTENZK2VtRGVHWTNKOGg4aXkvYklKT09WeEcx?=
 =?utf-8?B?T1ZtenlwQ3QwUWFUUjNUeDVvWmFGYkVTbjBVak5HMkFpaDBuTk85UFprUXda?=
 =?utf-8?B?eFN2K25jUlNkV2M0NWJEZ0pCN28xeVBsbHJQd21vYkhLTXlVd0hmTnA0NmRE?=
 =?utf-8?B?Z0ZDblV3bFVIei8vTWE0ZkdXd2YxZTJ5bEc1SmRlcjFTNUU0YmdSSGtwSTlQ?=
 =?utf-8?B?S0tnWVo1YWJHMHZzeU9RWTZjd1hmczJFUmtZTFBCazFmRHJOZlM5aUVPa1RC?=
 =?utf-8?B?anJMcEpOWEdxaWYrb0dzNGpUL0p3Y3lCNUpRdmNvU01LcFhnOG5uSngvQ0M3?=
 =?utf-8?B?QjZtYUxzb0trK29DNGdRSnlwMzBEQ0p2M2Fndm5ibVdQRHlpYy9EeHJTN0xj?=
 =?utf-8?B?N3pVV0hqRUU5T0FaUElHZFVsTWxFQ2Jod3NKVVhsZDFNa1NxUEE0d1RwcTBH?=
 =?utf-8?B?YkE0MkhFbmRwam11b0JZWFlZcHV4Z3piU3d1dy9oSUpZU0x2dlFsYXFIN05I?=
 =?utf-8?B?MkJKUkJkL1A2STBiOER5L2ZOU2xMa1hndkJLYkVUbUlmZ1E3bmRVckdkN2RH?=
 =?utf-8?B?RDFhMUV0MEFWUDRTbXdjN2xSbUlVMVpwamY3TkpoUEU3bzRwVDJGOW9GbWlB?=
 =?utf-8?B?cjVVZ1loU2lDdk5kbUV6d2NjR0EwWXhIRnpFSXBsY29QM25Ic21TdUxETkQx?=
 =?utf-8?B?M1hHNTRYUFNHM3gzSnJwL1Y3YzVFL2lrOHNad1JmSU80eXZ1RzRpVFNDTW5w?=
 =?utf-8?B?clJ6RE9WVmhhZTI1L0NqdUY5dVNKKytoRVhOcmxUSzVDZ3ZzNHZ1YVJGVkxZ?=
 =?utf-8?B?dDVaYW9aalJ2eWZTUVlMV0ZXVzRmUlIwOExwYjg2Q0JPSHRJdU9LaWVGU2Vw?=
 =?utf-8?B?bzhmcW9HdU1TUmhmb1ROWUpteTB4bVpvY011anBKTTlJUFJ4VmVPUmJ6azlP?=
 =?utf-8?Q?SXX+m0lUA8COJpb7Zr3D2T2Rq28LsEtAKoJFpW0VBQolM?=
X-MS-Exchange-AntiSpam-MessageData-1: mjvPiH3tgxa85A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364b447d-98b7-4136-a294-08ded02d6a96
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3986.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:11:02.3905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xf0aZqLu7+fJNoMmnnd+0q2C9Z4vKxOHsRl2sz+/sqwov7wxEX/LdcMqDczBFuySteoYdpqXaqle4YPMUj2hgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
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
---
 drivers/gpu/nova-core/gsp/sequencer.rs | 35 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index 0da3c3531886..b5e049f76c28 100644
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
@@ -271,7 +269,7 @@ fn run(&self, seq: &GspSequencer<'_>) -> Result {
 }
 
 /// Iterator over GSP sequencer commands.
-pub(crate) struct GspSeqIter<'a> {
+struct GspSeqIter<'a> {
     /// Command data buffer.
     cmd_data: &'a [u8],
     /// Current position in the buffer.
@@ -284,6 +282,18 @@ pub(crate) struct GspSeqIter<'a> {
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
 
@@ -325,20 +335,6 @@ fn next(&mut self) -> Option<Self::Item> {
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
@@ -355,7 +351,6 @@ pub(crate) fn run(
         };
 
         let sequencer = GspSequencer {
-            seq_info,
             bar: ctx.bar,
             sec2_falcon: ctx.sec2_falcon,
             gsp_falcon: ctx.gsp_falcon,
@@ -366,14 +361,14 @@ pub(crate) fn run(
 
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

