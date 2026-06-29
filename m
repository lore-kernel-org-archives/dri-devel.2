Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420C4C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99B7510E894;
	Mon, 29 Jun 2026 12:32:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="My+WMhox";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B48E510E883
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:32:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwUmTM4DlTQ6sHSeh3T6xSwzgMhapzGR1MeetIkIY02g0QwsYKAHu55LvBbYQjlHmmlrVFY/alkSwqIRekdRtfgsz4DrZ85lyGJCDc9WfRm+fStxtwQiOjbay8sJnQ0j8nTm2x2WkRK2cvNKynum0aPUhP6LtFbD42B10mR9ADGaBsH8de4xlZM2/p2swXmv1k8GQBQWCL+QzcDvFcF38ciwHOH8/twD144xo+r9O2qQEIoF8m3xaR8fKm3zAs9bJq6t8m2OzbInLeCkNdH6fslqGVa0ZX/9AQTrHjjXL1hTGcKJD/sLKKmbCja6L1T/STWO3hNM2/6QYKMqVqK44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPc5zojT5ZbHdj5dGp+/O7eXhAPd532jsjUkgfeMPfo=;
 b=a58GMIAlmkFNFCR5u+4quV4Sulh2p0Cz8QsXRsqHL+LhKAHtY0wkDS2Z9FwVe56xJyD9uJ6dykEtYqrNm3vn38C0qNUlEh0MJpdTlNl3LxNQVFdIXmKCemBfxEFXTi6W8BnNWyfKQ94vdrPqEnLd8YjWkN4p7pcPWMrClcxEnHWKwrcgyCTvBz+Gsdo7re/uKOB4ApJ9cTCCKzUiK+LTfS7k/ESbJWCK7Py3g+wods5J00007Tl1AVI25VujdfTCs8EheBGHQH8BYzVyIH2mpRzSzdiOL2LvLiAnW7ZH0HTKl/JPiXP+lbZPXYXOrnyhcGdyeyPqnaF78sftfi+38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPc5zojT5ZbHdj5dGp+/O7eXhAPd532jsjUkgfeMPfo=;
 b=My+WMhoxxJHBaTdWAo4vjw8yCbCZTXknDmt+hBRaxq1U4iNWlnnRIXr72RnnNF++mDhqAh4bSNBSPp2wD6abD4bGBynorYfKro68qTKUGFyozlX+sEYCDtEru4u2ZbxXjyVAF45um+9idFWO0lMh0CpzxHmOWUbXGQqJSfLdBKcCDtxheTEr9kq2NfBSX+q/yXVmgsih9F0qIEbGHZALXXH9uyn1Gr0ixNW8g+dnAO5Z+rGbb4QMATsWoMvYJnIs4d0G9hD8yl9wMsWFs8wLAHcQz6xyreufkKeRdJw+q/kkRpZRdgmtbjPcLxXAPOwPf4hlEcXnv2wuMtD/16dFPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:32:03 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:32:03 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 29 Jun 2026 21:31:45 +0900
Subject: [PATCH v3 02/12] gpu: nova-core: gsp: sequencer: do not store
 sequence into GspSequencer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-nova-bootcontext-v3-2-26cb29ee8dee@nvidia.com>
References: <20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0051.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: 4344e574-3ae4-4a14-4320-08ded5da6c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10070799003|921020|18002099003|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: ZOZl4I+33puLasWAeRwWFJ6EZTUqFBkHcMtj/a8vbysLYPqezvKO8sfKbs2z5d8FyTnmBUgPyBOi8L8TRr2M99Yun5vOtNo8nRCTro5Ck5ANtPRne6P1z4mFlqvGxD4vwhz7EehJQffcmoXrrolKHvJ4FrryP/b0+I5hRkOU3Ai48pujjeN8V+1XJ66cfAVNjRqKBvom7N911Je1olzLjxpdBA7jDOc+P5hhsyI/XAbK0UcjqF9fa1tkHmffZOqVAhRB0nzduL7l2Xf4janYdfBrHC8OS13IHBvXukO6RKf4wATcufZ5QsCrrCWghB2lgN9bGxYgP84T9cR2xcePrwbVZ93QyMeXEoN53GvlWITfvLSHcjZWk4azznfJZV8tactDlQxLTmayxIXlueOUKLU1DhHeKaH/JHp5l+zOtYE+16I8eT9ujg/kyGZB5fLdtMGvJpgWZbQ2KlsyLoxclrdDqDjhNoZ+HubMRpF8aqskuTV55CW0I9jsJ/rkXEDVzpFk3FXV63ICubchvIY8EFWE+pDzC/jQz670+cvk/GJDAqyR8HrbnWBpOM3vxMcZs4s2JGu4W+RFwoE6EQN9fo3KfFQzF+d2sbfrQeXL/Bt2uS8YcMKrSXVNm73A7PZ2Yss4i2OR8EL5uEuM23Lhe4oi0Tv/qcZj21ydSTnJObtqDqzYLgDXljSd7HRtB4sdSUx9VY9d3tNrNAjX9sVCAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10070799003)(921020)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWV6U0N0TGtsT1V1ZFZETjhQUDVrR1N6ejR5NlZVVVBNUGlIeCt2TmNzbmdt?=
 =?utf-8?B?VlFSZ0N6OGhrWGx4bTZ1RCtBbi91c05RcmVrMXdyTWlMVDdsdjRqaG5Kb0pM?=
 =?utf-8?B?bnNGeFdyR3lGOWNsSXExTUpaVGVidTJwQWYyTlFSUEhGcCt6WFRoMjNuUHky?=
 =?utf-8?B?REw0bGUvQXlhalJlblJ6VWpJcXA1T3NNMFNqNXJ5MEtTLy85RXgxNTRtNk5W?=
 =?utf-8?B?Y2w0SzVXYUJxa2tWRm8zb24vOThXbVBiSnFmMWlLY1pBSTFNVXpRbHNrRmll?=
 =?utf-8?B?YzhRMmFzWXRTUUNrRjV2NHVXd1Z0d3BJWlNxemg3OVFhVk9VcTdEMEtCVXR2?=
 =?utf-8?B?M0NGYURUdWZjK1Y3MHBIQ2t4U09INE1KclVEVitHZWN6ZzdzaDhka1YvdUlq?=
 =?utf-8?B?UUdTdExYRUFPZ292VUhacEVpSEYvRjMrdGczZXVTOXJ4V1JnSVhDWnV2ZU03?=
 =?utf-8?B?bnFIV212QTZxdVZqcGlOSmRwL0RWNk9LUFhoZWNic21VV2RRUk81M0N3ajdE?=
 =?utf-8?B?WGxpNllJcENaSTFkV0dITmpDckRDMHlNVW5RRFhOdE1QSkgyRlVtMEZ0bE5R?=
 =?utf-8?B?L0xDWWQyQjRJalNRQ1lzcnNLUUd3NTRvZWExUTFXZklPQ1J4aFdEQXg4RE44?=
 =?utf-8?B?ejZWNUt6SCthUGZVc2R0OEVYL2Jwc3M0bGZwNlNGbW5Hc1d1WVBQVmVyUWUw?=
 =?utf-8?B?TzVLWVJ4alpPelg1S2RLYTQwODhMUVArN3ptdVVsOGVIVHZIQ1hRclZRQUIx?=
 =?utf-8?B?RUtNd21nQzFUMmQ5SERDbUVTZmcyNHZIc2p5QmRlaVZQNTVuT3lMSnR2dkRR?=
 =?utf-8?B?MVFjdjdVcG1jb0x1MTg1OXRwNVF3WG50dHVPOU1SbUQydVpPTHhybVh2Tmpq?=
 =?utf-8?B?NXZiQW5Ld1FGbS94Q003ZFpJdThwRjRpWnRqVk91MFhuQWRwQnNCWjI0MmJ1?=
 =?utf-8?B?VFVvZ2ZOZGh0U1ZlN3RvSlAzUUJFdnlHYzR4Vmd6YTNkOUNVVVQreUNtUGhZ?=
 =?utf-8?B?aVIwclk3ajRxNlFaekZTbVFxTGQzZjdVd3VhemRaemZmZmZIMUpMclV6djhV?=
 =?utf-8?B?WUhsbTB2Sm5Pb0VubU5uamhsZzd2T3AyQmpTZVFraGtmM0U2TmZtTkk3QzVN?=
 =?utf-8?B?aFhuMW5JRDhMcnVtdVRTdnp0VFlBUlUwVkNyRUk0NmJ6SHVrLzhXMW9DVjJj?=
 =?utf-8?B?eTBwQ1ErQzJZZDgvYU14SFlYSXhLeGJkcG1jbHd2cjk2RTRwVXNLZXBIbi8z?=
 =?utf-8?B?VWhtRTI2UjRGazhKQVlMQ0d3MlJsS2VvcXlHL2RDTGllNEZBWjZxUktpRU1S?=
 =?utf-8?B?cHZ5QXlocndPcGxSNE1OS0czYXZiZkZNMmRFZjZvdk1kMksvU1pDLzF6aFEv?=
 =?utf-8?B?WHBURGgvRDd4RjFSQWttNm56UUlqcnptQ0pnWEl3cU4vUzZsL1VWSURjN01G?=
 =?utf-8?B?c2o2VWxBZ3N0MHNCT0FKUTN4ajBVNE05dm1WMmlacHpLbkFKRGI0SmdVc29J?=
 =?utf-8?B?TlErMS9RRFlGbjBvK1BjcDI1RXVGK3hlRlh2c3phcit4NzJXRXo5ZkFnMzRS?=
 =?utf-8?B?MnUyRGdpNkV0UmQ4citpOFNXQXZ5RThjcWtWVFJUK3BkWDhqdlVqamVMblpI?=
 =?utf-8?B?TmJzOW0zeVovRjJaZUxqQUllTHg0akMvNVlpako4T1MwR09zZHlhNTB4bHJQ?=
 =?utf-8?B?aWlyeTdhbnZmNllXVXBMb1RMQmhKNWtNT0xjdnptY0xJa1J4OTNjelFubGE5?=
 =?utf-8?B?M09rMjhHeVcyTmZwcUQ5blJlREw3VzNNSExlU1dueG1uNGFDUzFXNS9vbVBa?=
 =?utf-8?B?U1AySlZYMmV2OXZzV2JXU3JIVE9DbXBZRVlISWlOYVFEL3B1UWx1ekdQV0Yw?=
 =?utf-8?B?SUFxMlVoZFl4WmpSQXMwZFFNOFRhcGxuS0VvMlV1WmNFc3ZNMS9YU1lCYWJM?=
 =?utf-8?B?NVZ4SUdrVHFQeVpna2hmSWo4RmdmNlR4UkpPQ1ArVGc4cjgzdFhtYnFJM2tH?=
 =?utf-8?B?MFo1VFhaMGVUVC8xbnpUZTNKZnJkOHVxU3VBTVdsR2E0Z0FEZ0VFYlVuY1J5?=
 =?utf-8?B?Qjh0TCs4WmRDamFQT2w0S0NhS3krcytqUFdKelovc3M4RGVrenhwOXlEREFT?=
 =?utf-8?B?S2F3R1RYc1lubENCOURQbkkxc0JVQitRR0U0SnJDdVdYZ3h6WWlObTBNL0Ra?=
 =?utf-8?B?WEdMSFRhd3h2bTUwaVRFQVRBWDFDMjR6VXNWRTIzWm9CeEgvOWdtZTB3K1dn?=
 =?utf-8?B?MzNDdVZBM2V3Z1EwUWJxRStMSjg2djJKdWFqTzZ0Zy94MDhGaUdFcHhkVzcy?=
 =?utf-8?B?WUd5bkJGditIZlNLSmN0cHlITWdZZmNYV0pWcjJ4ZVVHZmdRYnl4MHpuMHZW?=
 =?utf-8?Q?BzhqfBrqR2w+V/Mh+PriG8Qs6ubdAAoYHLydoEHr2wvUy?=
X-MS-Exchange-AntiSpam-MessageData-1: HYri2Kk1UtlT3g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4344e574-3ae4-4a14-4320-08ded5da6c24
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:32:02.9707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPnHJz7zxcMJSvYbtBpfMaGDnuc3ChJHJ/Mfnzu/vbd4ex20jIwII/z/KpbPVaiZXAYmNGsqXLMkon0qa5Gyqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311
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

