Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E8CCD98CF
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76E9910E499;
	Mon, 15 Jun 2026 14:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DvXjqiFT";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46D4910E499
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 14:41:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0wSIHYUmni/R+VFY2UA3yjlZWmdqH82KrLoZTIWia7vCCybv8FqDMZgJgJK4KbeqKC4rprl8U2sINTvWk/L+yRznOr6vW6ZSFZz7ADKoZeHdwZwJnL1LrW9O3y7Z4U3+vJE9teUW5/C3/24RrnGyRzaLtxFhVYKnYgPt6CY3hQ8VHZlaKf1ggP4lpumlbVN0Qq9sS9dBNUIgMFIZUmJnZxaM+4xskN2Ez3wV6bgoEqm38WpVloTxSEffDrL1GPQg0M5yGRC+QkvZYdso/J7O/VoaHoVe+DkG9rqtG8Z604zP+kqQs21/gChFRXyDPlGnIsAqP3+Z7nAuNOwp7wGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1yCR59ApZg/MwoMKCCf688qkC5lDfz+6wr0BPZ5GiQ=;
 b=L43lEbdg0KVXq0a3/AAz8d+HF28ZxMM6cS9AEwI6RV/hWoY5C3KrE/YeGXHl17gIcXWSOYKWU0J4G+VkgejNnIbEF9HfSIeTBkbVoAO91KZednXNVyv+3xTOpxhS4vRb4qqyHAG5geMroLMFozy24miSr48oEc4TmtJ2JO1txVEJAAjbeCtNLKA6h+pR+blZQYs47zwgu0qu3+2aBAuLShrmI1xl4ttAYUK1uWZJUDVQoryFGLaUlUdtQs9dYx+38PevIweZyXT9/6KvuGPByLuDKGdXT0tgjB0Z7Kog5II0FspGtUjEPkVQnIp1zMZueGAWOiQQ5yEE6PvXFbAJpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1yCR59ApZg/MwoMKCCf688qkC5lDfz+6wr0BPZ5GiQ=;
 b=DvXjqiFTAytXifWjBEFvS7B0gvKPE2uQU5AIvfK6qPH95ykLzoVmHIdvRbXDCi3dmXujWVAlJZi299XSzNbdg65Q601SPhvYA3DgOpHVthOQoqBHF0ZhswTLyQQWBJIp4hMQO3DaItBCPimr1WQwBDVVN5mlQEZOUHJNTdKbybPJGvyem4hCiEOq7PPK5cGNAuFvYrvEEWTjetiLUcTVtQt8u+bjbBxP8K9ZFYB5/vatZ8B5kdANrkhL/O/a602C+D2vgEX0DBn3I+CXItbLY5+QcxIi1951ScHZAyTygfTMGoLWVCedPc0QvSdso6qc2ociup0voHDAPF8tsx8m9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:41:37 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:41:37 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 15 Jun 2026 23:40:42 +0900
Subject: [PATCH 02/13] gpu: nova-core: fsp: catch bogus queue pointer
 issues
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-blackwell-fixes-v1-2-f2853e49ff7d@nvidia.com>
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0094.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: c371cedb-45a1-47e0-7bbe-08decaec342b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: aYatQ8pKfVpbA9WuWJTFGNnfouDibxYZkaMfXU7JTknqiUiPAVetIfokEneCO6vQnslWkEf+2KFQaFEcJcYGc5tRaLWL3aQOr9BhE2dfTuyMr0Vgz5u0VHe/bRGFfezd3sVfDKtQrby1JvhSPM2/Ty0nM3WErrn9/wNEYvv5+V2avbN52ywm9TD6MqB/Ok3VzJKR/y4Pg0IDsWQh2P9OP1BEtIAW8gczU41A48Uue3wRXqgytZKzMo+EWV1e/To1LwPRJ0NigMw4A/6P7IpexC71bFnNwW+HhonLCQDwAR+Vj8E3Q7dpCk04wdPXYRC34Nd75f277uhRA0pS5VnpgkHegdqxfcO69yWmR9zreA0JYFsw9K4CKMAYxVZbY0oTXmL/2r9qthg/lmyLgnYHOzTiiVLcpAbgThOCm1/mSyecfYcw/+dOzqNxcBjfTOfQAvi2u6Mfhp9cw1YdcusaEyFihxFxZAzl+i7h694USi1D3R2GcOCvYlUqUgk/vvit4V7VNjmpN6mob1cM5v2r2Q2EFBGTApog15+fUNN3QSAL4YqzlA72sxCzP4gbbzJQfiK8wCfd679RK8CstphTnQrm3ln935GAn4z13CYAQxhbu/eTpQUukquAfvAjcYL2ID6dY4H8X/d+xMcT6JygQ50EogsP3yx5ADP7p2vaS6BCAP8Bh1vXR4zCExroyMba
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlZ4anMycVZEamxVeXpqL3NtVjM1MlV5TzhORU9JMjRGVkRSczhEbDN5S2lx?=
 =?utf-8?B?Z0lCbGdBU3ZvVWwwa3pSa0RaQUZYbC9pM3B1N1V1amRuNW41MnFjbW1tQTV5?=
 =?utf-8?B?RnpIV2Z5eEwyU2VyeVdKRXpKakNZOXk1NTU1a2twVjI4V29aNGx0blROdGQv?=
 =?utf-8?B?L2tibnRaNkRjdkw0RTQyZENEL204VFp4b21JMW9rU1NkODVGMnRQdWlEaktn?=
 =?utf-8?B?WGVnbkw5Z2VVeW5YbXhvQTFWQ2lzdzRRT2tJUkNnU2F4M2FoMnRmdU9Ba1lF?=
 =?utf-8?B?TjE0ektoblE1aWdvajFFaDNuMWdGYXh4WmpjS1RnNUhkczhab1BONkxBekpk?=
 =?utf-8?B?T0YzeWhaZHE3YUlrd2hiemh3alBUb1duQk5oSUNqOG5OZ3RGUXBPUWw0TC9k?=
 =?utf-8?B?bHZGVklYdkZlTURSN3BPRjlSNTZuRGRWUTAyOE5PMFpYQWtWRnB2ZGp1QWtl?=
 =?utf-8?B?QlZtNkR1bEtiNWJBR29aZkxDNk02bldQRHlaYTZVN1NYMFEyUmMxVDczZGF3?=
 =?utf-8?B?WWZ1SXFpNzNoS3cwRGZHWGNBZVgreGplV3ZGWU0xNDhObUxJcHQ5aVZrdUFq?=
 =?utf-8?B?TitPSks1aWk2Ym42cnlZZlNOS2RTT2NnWjBrT2pEcHBoNE5kRFdiRk9uejBn?=
 =?utf-8?B?MWdiRkRRWjZnTUNLRGZrNHYrMkdxNmlPMEFFdGhwUWtqRE12UmdPYXorcjU2?=
 =?utf-8?B?UlEwanlld3NpRUZYRyswL2tYWG5DY0xsVXRiMUIwcXZaMmV3dmVETUNldWV2?=
 =?utf-8?B?cENTN1JFSktjcHFsdncwM0RHMittQXhtSW1HWW04Z3ZGbGdlbEpGcHIyeVpU?=
 =?utf-8?B?RVlvVTYrdUl5OHZsd3BLN0w1T2FTMlhOdkRTTzViZTJZdzViclBKVFo3Wkh5?=
 =?utf-8?B?bmhOT29VaE1MQWVYa0tDejhnbmhMR20wWHBZd01kYWl6UVUwZDlyZjk3eGlB?=
 =?utf-8?B?S3YvM01tdWlBc1pPVnA3Nk9DWnR0TkJ4NXNtdVhSMnMxTFhWMEZGK3pDUUxL?=
 =?utf-8?B?dmlQdUlzTk5wZ0pTQ3ZVa0o4cGh0N1d1cmczUjAzTi94U1RpZXd5dkdyYWxU?=
 =?utf-8?B?L1VnejdzaXYveTlsWDlmNVZJZEZuTmhhNTc5UndTQUtlcUVIZUxlVTkzZUNj?=
 =?utf-8?B?RGUyRUF4WWp6aXVxLzFpcGJvbkd2VEp0WEMwQ3JxbStQTWxxUWp4MGpVNTd2?=
 =?utf-8?B?dXdiOXVUNXFJTXl5MDVveWZnNUhXYkt5TjhRV3FBKzNkQThmMTlscDMwcm5t?=
 =?utf-8?B?NHZpemhmNFdkT2VYMnh0WklITXFnNVpjdTVvb1BmdDVDZEsyZnUwZndtczBm?=
 =?utf-8?B?M3E2QWhwZHU1OVU1QzlFRkxjdWVOTmxBUzg4WVdjRFBFbmErRzdvRkdTQXpx?=
 =?utf-8?B?WXdmR2VMV003aTljQjlZRitlQzFFU0lLMzJjUnhEMVRtWnBKWGkwWnozYTI3?=
 =?utf-8?B?TnF4STkydFR2bkttWGZiT3d6ZEVYVHl3RTcyb29WRVFDME1FWWJtakRNVWJ5?=
 =?utf-8?B?T0pJRG9rRm5oN1JVbXYwK0J4MEh6T0Y4YVpYYmYrSEl3cXQ3UkUwQWdLNlhr?=
 =?utf-8?B?djJBaDdUanlKYjdFbnBjWEZLZkhKRkpzQ0p5MWZPV1BBbk1ZMFVpWWx5dDV3?=
 =?utf-8?B?MkN3VGR6a0s3UGNEeC9STjdqeTA1eFRuYzA5RVp4WmRkUXAvaUpNU3RnU3FI?=
 =?utf-8?B?RGpMVlVXQ0s1cUlXL0tFSWpTbjh6T3NXTUtndmpKWUdIZmlHQ3FXWGYrTnRj?=
 =?utf-8?B?VUY1dmN3MTRUZWxMMDgzYW5qNUg3cVZBOEFyYWhBZXJBMTFRRlBOb0ZMRWk0?=
 =?utf-8?B?VTRLMWdxMVdSU3JReXBhSVdhYWh2TlpsSVBBTW8zQ1d3MGhpb2ZmNE9USjNE?=
 =?utf-8?B?Uy80QlRObjcwbW5DTUZpM1ZOK3Y5RFhlZFB5Q0poaXN3Z0RGNE9ySzdOakYy?=
 =?utf-8?B?OGxSTjRBakZlMmVJSXNpR3U2c0dGVzBsYkFwdllOQ0YxZUU4SFdMVW4xa2R1?=
 =?utf-8?B?Tzltd3drSTdCSTlnVWFKMlRwRTRwL3J6SHJDWWU0Rkord1pDTE9kSUNab1Z0?=
 =?utf-8?B?SDk3cXg4NzBreE1IaDhJWjVoclVLRngxdWNNNG5yZW56V280MTBlZGR0bTNW?=
 =?utf-8?B?VUhrbnRlVWhXNFo4Yk9zaFpJY09Mem9pMDBvbUtuWGR5MXgrMmdWMnVmbXJN?=
 =?utf-8?B?TUdMOEUrdFlFUkt6bndZc1pmMzRSbWZ3NU1tTmhMc3ZMWW5wMnFCMkZ6VFpl?=
 =?utf-8?B?U2RFODZNcVZrU0Q1NThGdHF0djRFQ3NpY3IwbEJQdm9iWDhTb0RwUjFXYzlx?=
 =?utf-8?B?akppdlhNbGhPRTY1VG5PbWxDMTRXZ3dReTF3K3BMVHpMZXdieDhPc3YrQkNi?=
 =?utf-8?Q?9KvjNoyFhaSW+cG5N8oLsKqQSG9m6oh3JnQIQlKfoUiY6?=
X-MS-Exchange-AntiSpam-MessageData-1: q78ncgFJ8LuPjw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c371cedb-45a1-47e0-7bbe-08decaec342b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:41:37.0612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fgxpaw1NMrrgvXcG4YQAv6wZHJawHvFhDLcv5CeGwtHDvt6LKBOmMzi9ZgK2RBiIF7kM3WWE7mI7SqYzAEpCIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105
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

Currently, `poll_msgq` will report a message of size 4 if the queue
pointers are broken. It's easy to catch this if it occurs, so have
`poll_msgq` return an error in this case.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/falcon/fsp.rs | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/falcon/fsp.rs
index e7419a6e71e2..21eaa8e261ce 100644
--- a/drivers/gpu/nova-core/falcon/fsp.rs
+++ b/drivers/gpu/nova-core/falcon/fsp.rs
@@ -107,19 +107,22 @@ fn read_emem(&mut self, bar: Bar0<'_>, data: &mut [u8]) -> Result {
     /// Poll FSP for incoming data.
     ///
     /// Returns the size of available data in bytes, or 0 if no data is available.
+    /// Returns an error if the queue pointers are bogus (`tail < head`).
     ///
     /// The FSP message queue is not circular. Pointers are reset to 0 after each
     /// message exchange, so `tail >= head` is always true when data is present.
-    fn poll_msgq(&self, bar: Bar0<'_>) -> u32 {
+    fn poll_msgq(&self, bar: Bar0<'_>) -> Result<u32> {
         let head = bar.read(regs::NV_PFSP_MSGQ_HEAD::at(0)).val();
         let tail = bar.read(regs::NV_PFSP_MSGQ_TAIL::at(0)).val();
 
         if head == tail {
-            return 0;
+            Ok(0)
+        } else {
+            // TAIL points at the last DWORD written, so the size is `tail - head + 4`.
+            tail.checked_sub(head)
+                .and_then(|delta| delta.checked_add(4))
+                .ok_or(EIO)
         }
-
-        // TAIL points at last DWORD written, so add 4 to get total size.
-        tail.saturating_sub(head).saturating_add(4)
     }
 
     /// Writes `packet` to FSP EMEM and updates the queue pointers to notify FSP.
@@ -154,7 +157,7 @@ pub(crate) fn send_msg(&mut self, bar: Bar0<'_>, packet: &[u8]) -> Result {
     pub(crate) fn recv_msg(&mut self, bar: Bar0<'_>) -> Result<KVec<u8>> {
         let result = (|| {
             let msg_size = read_poll_timeout(
-                || Ok(self.poll_msgq(bar)),
+                || self.poll_msgq(bar),
                 |&size| size > 0,
                 Delta::from_millis(10),
                 Delta::from_millis(FSP_MSG_TIMEOUT_MS),

-- 
2.54.0

