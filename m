Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47D0CDB466
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2758C10F5F0;
	Fri, 19 Jun 2026 13:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iIhTWuL2";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010014.outbound.protection.outlook.com [52.101.46.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9346A10F5F0
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 13:42:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu1+FwEAC9QJgfdD3+Iq1QA/ctW/UjTB2EsQpAWl0UEJ3prbsTIdzT3oEh5VEFFuOY74wjSorhfAC/vEIvhFkvvzEMTdHSxOJrTKq+5kkjxpF2OcgSObf/KrSLYHqJT1NJ0q+hKpf3OaIrYnU+q0gdXin12dTkzD+ocv0LASyQDOUo4YnU/g8sKR1kOA5m3Esk3J16WB9v9i9tVyFHenNyDrZQMstf0o/8ApXrxpdTl5iKdtuvLHpmTDFk6ciMwr5nW2/0TQi1O+BJhf4QggweELm/v+Kt2xU52A64+RUc3Ulo86ubNqmSfd1DaTJ1lFeiByGj7/UooS8ELfpWbQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cx3+iEuDKmzsSY2P4ExDWrdlak3Hl9QjlpzlafW28ts=;
 b=hZbPn5VwvwNXQkhXSg4Co1+zsAqfzj/f16AU5ZeNOo9g9Q/Tn1xAJZ92hZx96QaLI9LWWycb8hu4EaNEYOdnvM72N+CqJ/kBns/35a1NrVagA7y3h3WGUYFtORSO5CIXpoz48jzYSEXi4jPJ7uJLjNna9cfgQ0hij8e5oQsrJEWaYFk0hMb/b8xrFF1eTMjBectbiV5lbC7H0L+y/DIL+WM/bpRphXptQ4kApyBV1dO7KOqNEyYXbNZaljS6baj0ghbFgeFACGy9HZeWY16myIpszRCPnO18NzNiNEX9z8KU5yPznqNrsctVlyKQUuGuzskAcR4gH2r8M9dGH8QahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cx3+iEuDKmzsSY2P4ExDWrdlak3Hl9QjlpzlafW28ts=;
 b=iIhTWuL2wo408s57mlwqaZZaejKYww9qVoE18f6LsvfvkF5J0ClJvI3n1LWA5sKZiCKUDmZPGmNZrdbIbIHPJbaezs7xBn9BPqwJiEhvvvZPS6RkdWxlGX6i4HZJRDVLrvOiFEj7d6z+n4MRtTzzKm5+rUJHbxPqH6/+GZrsemfs3ZrQO8rip9A9jr96OKAT/wMYTEb4H1O7obC/MZuCheCZXDmnD8ydU4qlBmGwsDn4eP+HkGqLU0C+JqyI5agourLBw9l8eQrg/IRnw5D9nlUAiLgIRybCMh1uLAMfEbBucPEtucFiJn6HcT7p9w7U7zY3J+JosMWItohE3fIAgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 13:42:36 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 13:42:36 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 19 Jun 2026 22:42:17 +0900
Subject: [PATCH 2/6] gpu: nova-core: gsp: sequencer: do not store sequence
 into GspSequencer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-nova-bootcontext-v1-2-45193cd0a2e5@nvidia.com>
References: <20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com>
In-Reply-To: <20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com>
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
X-ClientProxiedBy: TY4P286CA0090.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: abb08624-4208-4c3e-c230-08dece089f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|1800799024|366016|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 6MpFb775Vu0rB2c7NzCNb+EzA0MMV6HeCFH7bAl/+vI1Fqi4Pj1jr83DjMUFQx1vRHD/558f+mXefN/nk12Ro6/u9jMg7MYyiWFtJbz2S0boU8q79D0ucUNMLdL1WxCvonTU8F3K3I6WmlSKj3Ro0QUccoi28WDOESXX0O+U5CvHkRd8JFEpJ0TMCROpnlRerrTnkd3B+U9q7CkM8CGOvmdDcTGveGAz+24NCyWcjpYr8Bl0c0ysIbVqxEmhQDBJP0Uj+jlNNMniENBtnJ2oGYHy8v+i6hRukuJbPHXWWPuauocNIe1PTyhNj/PYM/2sUQ59EF9a6oF6NGUsVDZxMlUT5MKZoUND62oaXnQkDnTOlEEw7UGB+qzcOwfLGQe4Te8iDt2Rt2BdxIkI4HLGjMpcfIpJTF7Z+iJZp1iV4oPMYLMiOh23zX5f826IUMIDqUnBR61leVpsbLPVUNzbh4KILyE0WNQvpEuucGHJHY2o6L2ZP8hwU8drTT/NFzuuSvK23iPJfozOiW5ehgl+1KuDdhEXS7iep52tV94rdIdMgmx1QriOPog1C0IrNf5CyB9JkaBotmHZlIAc+cvYOpE/RknmdONazBxI94YuJfJPP7DXNi8RiaDXISrwYQckdpiYuZHDmDVS5leu8izXOpPO2meG0+lqHXaPhWDU9bg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWRBdUcxV3NCdnFER3F6M212b1ROdVZIaEhCKzUxRll3TDNxVlNJMXV3dHlm?=
 =?utf-8?B?UzZVMGlVMERkY1hXeTFKRzZZeHppNEt0QS92YTNtRG9Zb3FrZHFtU0F0Ukpm?=
 =?utf-8?B?UERNT04vK1J0bjI3N2VJYWU2MkFaWndHY3krOGt2ODlsT01HaU55S1NOMEpv?=
 =?utf-8?B?Si9RYkJ6RHlSeGFWY0twT0ZVaGpDOTNLSDF5Qk00VzFmSjViQTYxak9RRzln?=
 =?utf-8?B?VUJJdDU3dnQ1T2NXS2dsbXF6VDNacHBBNHlYUi9PUHg3aHp3bzBQTTNPa3JO?=
 =?utf-8?B?a29reEJtcjZMU1dUazV2SXpUeEdWS2h6amszbGgwSzBFMlRSZzU0MnBCQzg5?=
 =?utf-8?B?K01acXNwaXRXVmxON3hvSHl6bzBJZ2c3N2VYUjQ5b2pGa0IrOTNTMENrNzdx?=
 =?utf-8?B?OXVWdy9ncGQxa3NXQWhWVEEyVUpYSVdGVUY0RmdySjQxeFVwc3lseFowM25k?=
 =?utf-8?B?S3N3Y0w2STJnOWsxVTdWbW1nZXFZcHJHYlk5WGJJOUh1TmhLSVZGcnZ0SlVB?=
 =?utf-8?B?N09FeUZxMXhldVlBalhXRHZRMFVhbE4yWXlibEM2UnBCQkJFckF5OGR6NTV0?=
 =?utf-8?B?Q1gwcEtQNVlGcG5CTjVweWJQOHlVVEdxdDljS041dmNwUUJ1UDZOeXhoS3pi?=
 =?utf-8?B?UVNiT2I1RnBoOWh0R1p3MEtRMDRFeHhIVUlvMjQxd0hqaU9aazExTklTbHl2?=
 =?utf-8?B?Z2J5RzVIVUE3QjlrU1dKOG9hbkJzQWxSZm4wbTJsUXdjZVZxMGNnMEZxems4?=
 =?utf-8?B?d1UvVE5aT1VlcUdESXZPbitEQTFsVGwydzFHdm8wYTVOOXhudktKeVBQZ1du?=
 =?utf-8?B?NDRRUGhhd3FQdWpGYXF5cS9sTkZTV1BvVzFiN1pURllpdnNVUnFBTWFLbmpI?=
 =?utf-8?B?YVgxYk9HbkFYZFVyRkpPYTFQV0hMenFLdDhwRmxtRnhkUVk3ZVc4YmFaWTl1?=
 =?utf-8?B?YU8wUVNua3R2OXVrMlZOZGxuNk8xcHl6UWs4WFd2emNWZUxNQ0NQUjdwVnAz?=
 =?utf-8?B?UGhvb1lWcURHaGhzbFNOZEVYZjZvOWQydEgwNkErVWRpRjgzOFA0UHNVVFN3?=
 =?utf-8?B?L3A1amFaTWVtZjI5UjdodTRQL0VXZzY0dmlFdWVoRm1ObGRXNWxSYjl1MGhh?=
 =?utf-8?B?anpZb2lzTUpwVm9vclpUYUYvaUtvMnZXK3RuaFUwdVVBNVZaS25JdnF0R21x?=
 =?utf-8?B?d2s2QVlqSmVxd0JmY0tzSC9UemR3S1BrdXVQUHJSYnlYaklKTE5Zb0F4QS95?=
 =?utf-8?B?eEFoNyswTktmcEUzdERocVdIekFIWFMrVTR5QW1xaDRFQWdZYjF2L0E5UWE5?=
 =?utf-8?B?VmdDcUtnZERMbCtWYUlzcjdGWWhxQ0l2SCtVOWZHNkgrUDdMeGlCMFEyOXF5?=
 =?utf-8?B?TGQ1eDhzYWg2VlFORHByU0lGQWcrL0tEbEtObUY1bitXeWM5eGtpTGRLb0lC?=
 =?utf-8?B?SnQ5SktiUXVqdWZyUWc2dllVOWxHaHZHZHk4R1VDNkdMQTJhdTFadUtXTFgr?=
 =?utf-8?B?K01GZWsvNlVCOW03SmZMNFB5YWJaRjZ3SUtFV1JrZVFERTNGcjlzU2VVVmZ0?=
 =?utf-8?B?TE5SdTNwTGV5TnBrbEF1RnJVUStPOVprU0dHekhTbkZ3WmhaQTV5Z3FBbkVy?=
 =?utf-8?B?enhBME1zRG9MMXhFcmxWM3o3azBOMEYxZWhnbWU0UXBaNE5XRU54SFlLTFox?=
 =?utf-8?B?WHlRcm9hZEN4L0VzUk84N3p1Tm4yM0JqVkhPcWh6ZldlUnAwSkhCL1orWTUx?=
 =?utf-8?B?V1cvb0xvOUFST2pISS9QMm9zc0lDU1JDWTF3UGREVGtlTXRhd1RzMTZvTVVX?=
 =?utf-8?B?YUxvSDBBbzh3UWhIOEZFcUpjOWZtUi9oclhyTGNic2E2NmxvUHIzSkhPSTdB?=
 =?utf-8?B?bUpFR2E2RWY4bXd1MFhKQjc5N0tzNnNCdllWYTdmVk1jMjBjaXJrdXZ1aE1M?=
 =?utf-8?B?bXdPMWVtWEJLRFNGSUlIZlN5RnkvdEVkYjZJd2R5UU9jQWhlL3AzY0ZDa21m?=
 =?utf-8?B?bWZzS2RzUUVUM3hwL3ZMR2FQdGlETDZnSWZUTG5OcVluKzNGdXR0OE1tUk42?=
 =?utf-8?B?MGh3cFZTbTQzTEhnMXFQUXdPRjF2cktkZ0tXMjBKS1U5N0t0YWwxc09wUGRR?=
 =?utf-8?B?RmJVYkhCVmdxWVRNcnlqRk9GcDlvT3pnd2hsY1ptYndGa3pUV01SNDhlQVdj?=
 =?utf-8?B?YUxJU0lPSm1wZyt5Q3VLeTJtVHVLQVpCZGRzaG9uajRqZHJwRFFZRVJ0bEgv?=
 =?utf-8?B?Z3M2ZkVoby8vbS9BNCt6ZHJrRTBGNGFFNG5nL01XUldFbzd4bG85b2txN29I?=
 =?utf-8?B?dHRqZmx1SWtsVmMwWGhid28zbmRpOG9hOHM3V3piVVJrbGQzUTRtcWMyUUVa?=
 =?utf-8?Q?FjNNKQsKYrryuq99CLd5HOvKqWWxtvSROyXZezUmyve88?=
X-MS-Exchange-AntiSpam-MessageData-1: IsFBMfHP9ASkdA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb08624-4208-4c3e-c230-08dece089f70
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:42:36.5111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5DYZ8g3UdvMKkxTzGsCGNQDQkxMGVhzIJ7uqNorMZgQdXW/Z7y/NnN6ZWIflfn4sq+og4k2GL9mjt45poRKXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450
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

