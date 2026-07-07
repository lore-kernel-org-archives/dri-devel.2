Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0440C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06BCC10E46D;
	Tue,  7 Jul 2026 07:22:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LzUagPtb";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010019.outbound.protection.outlook.com
 [40.93.198.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FA7B10E46D
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:22:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOrIz5MQttk+ELyLL8w0JgOi1B+sni62xD7BC9vDN/XCCkOSR8OcgmtXfO86KD+4RoYL7mtwvthQIdz8EZwwkQ/6nt6xCR4hF3yNmrzMymQ6NF8EHyVJuBAHek6wP/yoaSd1n7d6gbvDcvyH6fHk5yILTvQrJbISCo/cbeStECeLs8erYb6MyM935Gh4ZGccrMskN6eALk+g/QoxiFwq7XJoO9OJdXomKJ4IrX0Ku1ABqZ8s99mdEkwehtwpATIV436N+nMGLS7AZwwVjTj8mEjB351B9SGISgdWiLcz1SChf5XRyzBowlZu25YeBHkB5kaWQZ/t+PfIWwVPPPAn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qkze93cEg+LCCQm3xDADseKkFalthwRlHlAxiwtn1ck=;
 b=mjgKqI5+tbL9iH0PuVkU9ZBuLGsS+v0DwbxKWs6Yj6UulEc5DyPR3TGD99TQQBMPEYOMdh0SHuyPSoTAcrsRxhMwT87PBqSguLbbjOqbB1ngI0psIfYTTc6eq6i/bx5XZkLyvcpcc2ePTDZ7HiD3HVHMP8BOwRS4pP0WYn3lgbvp85kJ1ZW7C13xnmkPTXD4etVzfNrvdRtZn46AOZmsq71Of6fHX7qP0zra2tkCG9+MDKPH4Hvjq0dGjNYgcvtrAt9YMaaZxlzdxdCCNi4Fe68lqu8IRZOqW0qPAu72x7Ih+cR6jd3zfUWzv7Ki2BU+r5U7C3EgTUGQ3spEVa5F2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qkze93cEg+LCCQm3xDADseKkFalthwRlHlAxiwtn1ck=;
 b=LzUagPtb15XO2g9/DfiTEH6kd289EK0vMclx3gNtrcegNGxW2ikk2QyhnDcOpMXTTE1f/KQLpW9xuwChpukM2BwIHmOMSc80eW5rUClX2YfiCjRCnpytQbkTL5RVNnKppmDTNnArFbesGnCpUTuariDmkgKvClCUNgTnzc2gTYoI4MMJnY1pprQ5cC/d+5yOdGaScnee3RlWDyhrOolKn+bLXDRhbTGMkNTqZNGCWz1u5XcWhq2xndheY2C+eCZvq1zPUd//4GSinZPU7hTAsdSXSEgDDfw8c9cJ/O/WGvfwm8tt8l8Mbv4OniIFW2JKat50vFkZLTvZFu6hJqrCGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 07:22:03 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:22:03 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 07 Jul 2026 16:21:35 +0900
Subject: [PATCH v5 02/13] gpu: nova-core: gsp: sequencer: do not store
 sequence into GspSequencer
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-nova-bootcontext-v5-2-ecad9346387f@nvidia.com>
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
In-Reply-To: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0371.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c40275-dcd5-4283-700d-08dedbf8712b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10070799003|18002099003|921020|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: ZsVDcYr1te46emBumx6HEAJ6qKPf57EY/sLxl8s3LkkbRas449MC9UsOtJlqcIXLfhZ3eDoxDr14wmu3j1nqn+o9J7caC6WdCcoxVXgXBWe6f65dLKRplCcaeHWYjFS/DgyEtamYk8RcWXGZDEyqxVoUjyuPiKCO8mPxJ5VFEvNcXk0XOG45SeNZvP0LZ0kDrYlTIoncjF66IyQLYYruTBjM5g36njhMhO/HqRP5fYj/iC3BDC1blNBhq9zcSgQukkQmV7rNPowT5yYoe/CIS6shgRRIh0tZFaAsQtcqfGLowVLGXMcl4vFSZznCwlX/wxNRX0zQyQ/b7Ao6qF+pk2Ud4Dd/5Vybl95bi07xNTTwsokmhDFB0WkXaDULBND+z8B0b340KMitHLdADhVefdQuQq3pojFuA0ChUwcMkShlbCBT0B5THYjYln8fcfYEQu58vHbuQ9Y379pJKGU7AmPbE5i/VV20D5FqvYhXjCrWpiQljSoniFzvZ98zRyoIqN/WkggxihrHtgV258zR73i0rzpb6Dw3R5XB8vkwYm2sbzsc5+C8HqflmH5viKw15cNm2LB3fLDX2mEPfGN9TSK/ANeR1C1b7DiCfE59Gmi/TEHtrrYnSAslQJR3D3FprEByY/+IjhZ3QrqytWjAffDFk3SjQkCClJlhhHtgKbYReMlydFrVtaShmekx9TLrgJ3SjFKZ2h5ZIcO8NVLDBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10070799003)(18002099003)(921020)(22082099003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NERvcWxNN0lxRFduUFA3emR0Uk9JZkZEWlUvdC9iSjV1MUw0dHpldGVLOHo0?=
 =?utf-8?B?RmppZ3NQM21pVkhXcDNHb243RDlTZ1F5bllNaEtrbTBpNUJiOXNRdWdkOS9p?=
 =?utf-8?B?NFEzTHIzT0VPSHd1N2JSc2FSVGlVNEJJbGlEUFY2d2RoN25QM0lBUkRsYlh5?=
 =?utf-8?B?dlM2eGZERmVNeWZESzBpK1VwLzNmUGt4aHdVdC9Ta1ZuTlR2bE50ZWRlbEFF?=
 =?utf-8?B?QWRqK0hkQ1YvVDJIQUZqT3Jjek95TDRDOXNUWERrZWlDNFBnQjJWeGhCZWQr?=
 =?utf-8?B?UVcxbU4xdHA4YThzVko4ODAzYkNUb01QaE5MVityaE5DaW9EWUp0WExIMG50?=
 =?utf-8?B?UUNVekNQczNLaXhXSzBZdVlPTXBjaCtTbDk5bHZsWFZTVWlPK2NjSFBXdGR5?=
 =?utf-8?B?ZjFFbkdJbjRZaXRFUHU3RkZsRUZwVXJ3QUdCcDNrWkhwQlBURXloSHJKWEhx?=
 =?utf-8?B?TmEvdEtNdVhhQWVseUZFSGsvMFl3NHBjdVVwY21jVm1yMWpQSGJUYVJYeWph?=
 =?utf-8?B?ZGJoYUVJSjlzZHZSRDAwSlI0VkxEZWRUNTJOd0hGRDdqVFZRb1ppUmIrajFO?=
 =?utf-8?B?ZmZtckNsMDFUSk5Eb0FqTEZlMWVBRlBCRHAyUGNQVkNqdVJqRWg4ODlqR1Jq?=
 =?utf-8?B?K3JqdDQ2VlFFK1Z1alUrTDY5VU9ocW5kMVZWTWF5TFJjZUM1NUNJV2lVLzJ5?=
 =?utf-8?B?SWdlV1J5SjVsYzZGZ0Nad2NjSUZUc0hhQk9TQityakxObXJRdTR4dVQvMzZq?=
 =?utf-8?B?OEoyeVlvVTVJQ2hUTDZmK2M0V2JFOEJmbU9DSERMczl6clhxeHFaVlNCc2Qv?=
 =?utf-8?B?T2Y2NGtzWGRIaEZ0NTltNm9FSU1yK2h4MVk1NWEyUENTR25xUzBiTk1vOHRO?=
 =?utf-8?B?aStMMks1alMrMFlteHNPa2tERUhMM3dyQnlxWHBFaWhLUDdoN0dsWUlMYW5w?=
 =?utf-8?B?UXp4bDN5L1JySUx3MERrWXFsV1BzcDU1cTExdGt6TVU1VllFb2t1N2UxcGdO?=
 =?utf-8?B?K1ZCK3RuY0VqZm1hYkdvVGdoVXR5cEhoTmptOTdPOHVyNWJGcWQxamlrcHA4?=
 =?utf-8?B?R0pnZHNCWWJBSXphZGJGOWl6aFJtVEJYaktiN3BLcElGRkhZKzlPSndmTjJt?=
 =?utf-8?B?QkJxNUtQVTJIbElPMS9WY2xLUE1UU01hN2V0V09SdCtnUVlsQmw3ZHBrWU5o?=
 =?utf-8?B?emdhU1NZc2dpelhpN2ZzZlpKZmtVWGRZcDViZThqdHJ2QURMemRWL1h3dzNE?=
 =?utf-8?B?ZU5GY2tvOTVIbGRjSGNRZzc0SnJPY1pTMk9TQm1qYmdaM2xERDR2U25NU3FF?=
 =?utf-8?B?NWg3YWRWN0xycVlmRmFZWFFTdTczZ01zd2czd0RvT2wydzhWdzFsMnhHa1dW?=
 =?utf-8?B?cUdVcHVSYk5GVkFNZU5MUDViR0JUeGxPUStOOXZST0NPMEVVOXQvcVdRS0lV?=
 =?utf-8?B?NGU0VG11Wk9VUWNLV0xMWWw0d0lwMmMvS3V4ZGFJQUZ3UlBhQ3pWaXV2bldJ?=
 =?utf-8?B?NWJuUHN3SSsxN3p1RkVqaC83OC9Pc2w2NjB3clQ2T1g0OUM1c2c2dnZOSUxv?=
 =?utf-8?B?WVNXNlJIR1FjaFZvakVDTDhaQ201UVZYZ2xaS0ZnNGF2eFNpdVJ3cVlzSnBu?=
 =?utf-8?B?YjRwc3FGK3pwSVYvWkFMTDMwWXdibXpnU2ZVSjl4MFRZK3R4ZEdpM0tLU3Ax?=
 =?utf-8?B?SHVKdU1SL2FFNGJ2T09UYjVkRmNmcU9LZkdXaDRSVzJ2YW80Z2ErcG1odisy?=
 =?utf-8?B?MVI2M1J2MVJIclhqcG1qd2Y5SXJGcmMydUVkUWN3eWI4V0wvR1dQb1Vvc1Qr?=
 =?utf-8?B?VElXNmw4bXkwOWF4Qkd6REtEVlM0eUhtUldJNzh5UUFzQjZQYit2dXlFSkZq?=
 =?utf-8?B?b2E1bCtjNDNDcDA0eldqbVBGL3ZBYnBaSy81MklweElDMWt5SnhMVUh4MnVl?=
 =?utf-8?B?U0M4dVg5dVRmOUthd2VHKytLTEZPSlp0Mk9sM2VKQi82aFc1WFpFMlJyQjA1?=
 =?utf-8?B?ZENjb3FSZDFCajlyK0JmVHBOZkpINllmTUxkakgvWkJOdWpyZ1RnWVNpNWw2?=
 =?utf-8?B?dlpDY29CdHdCWXpnTkwxWmFub3BReEhNN3lpRHcwMExwK3c1aUNmQUJoSHlP?=
 =?utf-8?B?L1NIQUtWRzZURExld0NCaUNueld5dEJ6YThVVXhqQWdYZ0NOSVpKL2EwMFh4?=
 =?utf-8?B?SW1TN0tpckg4aXU5c0Vmb3ZXb0VDZXZNM2pwSUFtcUJhMVVlU0I2cm9tb0o4?=
 =?utf-8?B?ZXZXN1BSVmxFa2FvODhhWnc3dW1ZTVgyTytqTW9CTlY4RkxiWU5IVXZpVGdY?=
 =?utf-8?B?anlvMDJHanBiWVd5NjI3V1NiVHZJOVRqZks0d21vOTAvQU1jcmVLZFQrQk0y?=
 =?utf-8?Q?5Fu8iqoqTqXdOc9TBXih8q8regJL4uYbWuhoM+DkUflUB?=
X-MS-Exchange-AntiSpam-MessageData-1: nl86LHEcKKUf0g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c40275-dcd5-4283-700d-08dedbf8712b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:22:03.1712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Rw6ZIvEGGN8kFsLk1vAXi2PYaqXOFdQScxG9Itb6YFHdpZ0Z4XoJB4iv4vD6QnPcM4wosqmzhLw/VBnV9DxGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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

