Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8D9FCD0C3
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCDE410E6B5;
	Wed, 18 Mar 2026 07:16:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="o8+0++eo";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A704E10E6B5
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:16:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKz1TRfJdQGYSJR0e/FgWtgO0JKgDg7NkoR5/dUuq0HKXI6ihBAeuG+Qs3HyH/n5pTCXETFh55LnySdm5Hyk/HhMwcmYQZV9dX2hegj84Sn5/5BVGZB9WYifyFvwSDhCavHhiJo3zls0BCnpSHbdsybT70+6NvItGVckTu6ep9wrJDagsLtd5pm3JqF3okgz5g3ndQeP9QPIsW4uFhpDgaKgq0Y0ZJ+18dnU+LQZ7dJSQo+e8KOziQ9vvHfSfNrInKpmuzpc2hqU96CYpfjECHd3g6+j3UCrJuAIW/R3FD7Pd8jiiwEdQuVkZUA75UQRGDvXDfGxIFni2YXdzeLBJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAdv4EsEnz4pa/hccDO+aPbUA6jV0i3gF4VPXNK89TA=;
 b=yeVsaOCG73mCVNJqI9hlfa62b8sXWal4g84M9qtqwnnHfBaQ/D58ugXZNDr3mhCMY5PSaB61U8USvreCw58/b/BR0tTm+FUrbVuL9NTFbOgxIAKMKv00E10VCaD9hlRH8n57xbiTXyXhCdo/uQzWsLIqBYWQbAr9DV9Cgr1+vnUEI8YBtse1MHqOg0CuTHWVscTWIj36GVl5kb/FDu66sNPQ6LU4HdNMRqDdlX18PoGT+DkC7hX7XLvECYsjcsqZ5kw7xlUZL226akCkplMsVz+OFqaDnc5oljKDBKhPUQ4cvTBY6CqeXFE9HGt4fQ1QLD6M/2pbDORzMLES2+XXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAdv4EsEnz4pa/hccDO+aPbUA6jV0i3gF4VPXNK89TA=;
 b=o8+0++eoz6SW4iBMFiCvHdgPtDIkSqCvTgSDHqUHZKOIub1eHwrXLZqyV9JBLofYaEo7x/S9bajJtizSKd2qnipUGIo3DaAsgC80lqhhqwjrUQCisN9iJ3E6t9FsWqe2/i3slWBQcZm4o1iPmrRmQZfXujUUHT9OVZYJ+PeeuURqB/TSlwBIKXB1HOGw7MTsMMyFPmbEqm6tA921bxtk3gHwQLEqK5vp5yWM64itbzNIXcTLNEWFKZwNYLdEzONJs9ZZIzQUD+a7PDVITVGokVSTWA5iV9X54v2BM0MWF5rrhH+dzq63O+c8M5DVb7Xsqsa4W5nOvE5GqInKImyG0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 07:14:58 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Wed, 18 Mar 2026
 07:14:58 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 18 Mar 2026 16:14:02 +0900
Subject: [PATCH v2 6/9] gpu: nova-core: use KVVec for SBufferIter flush
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-rmcontrol-v2-6-9a9fa6f1c4c3@nvidia.com>
References: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
In-Reply-To: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::10) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: bf7951e8-a710-4ba5-a377-08de84be1016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: MeIYSru3aF1BRwR/63cEw+bm2HT8rm5NU9C0VUQdJhN/sGiRERGRsCGIGNoqtZ4KnhO+yJTF9cC20FT3+PC0F+9POv/bujt4HfUvT23ar7zhxp7CiijDVJ2yduyn0IQ9AlhM3C4g4aHStXVOFuOys9MdKXpYxOJZVkxFy0qI6PO80PNX9R0dzOZACZDxMU2WI4nacIJRPW57k/VUHnVdgwBYVz3o5mxY310u5YHFPO/aUf/s6xWEceaFlEvk/3/0qXcGarXY8mLZXnuIKppZHsRfZ7/4uA+/JTT35hLyx+zdbWGYLAANBz53KflUCgWvQBID2huIuzXr3eqJyjeOBJXcBkzNWEkvfhPTqdBRaqde/crXVAae/uaReyAX9+cm7JlHKU6LE55o8+q0nPD7k0Vk0DH9zNAKkTEDz05caumchJ+yS2bl21g+5VhH2WTkSJkFpiaDPx4UJVE5GWB+uzkqoYIL6pwY8J7m4qolCX30Yu5ZrBvN1yFLUhwQR94DvuzrjHpaTW9xoosaE7FWnw7tOY5y1ViyY9tJ4KUdRsw6EBsBqcyi3fC6EADHccttJvBxVaGUVnMDC1oeM5O6LyASznVOQhOR4ASs6IE6rWxIQoIYOp1kCkJhfJ12oLUOFWt+qJuqFhnY8pi/yWmJFvU8GJoBhl8EDnM6KxRrsOKJael0RSlsKXaMXvRLAvBvOzF21oW74U4qFRuAOwsCdUArOT2IHvMmPKvFEsWzhMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGlJa2hKVGR0Q0h5L3pCVHJibklrVzRobXIxYUtPRmlCUmdMazFwRHUyL2Mz?=
 =?utf-8?B?Ulo5S3dyakhXNTg3bHdYNE9RM2RMcDJsSUJzRXFZMkdQeStkKzZFeE5LUHlV?=
 =?utf-8?B?WUhXSGNydG84VWNuazhZeEcrMW0zMU54TnczaWFYazRRdzJKVVNFajlla1ov?=
 =?utf-8?B?SjhzOHNUODN5Z1lPNVlKeVNsb1A1WWdSSUZkQzk5OCs3eUZib09XVnZwMnBj?=
 =?utf-8?B?dE1aY2hwNFA3MVZqVjFIZjlQNjh1RlFjLytjVVNoTFlEb0tRODVPa2RKZVhu?=
 =?utf-8?B?cEJ1aTRFWG51WFF5YzU3Zlc3WjhNcGdtWStQN0JYaWFkSFNKcE1NN05BYVlw?=
 =?utf-8?B?bXJHVHJsUU5rWG5rQlhhN05rc0laREw3aWwxOS9jSmV3RENTZitkdjRwZldq?=
 =?utf-8?B?NVk4ZmpLZHROU0JLNENQd2pBU0pEYlBXZW1mcE5WcXJ6dzVyRGxnMXRwdHFt?=
 =?utf-8?B?Rm5QOTVYeDFlV3ZPNWt1c2pZV3JKVTI0NHNOc0JSa0RrU2NPOVR3em5PMWlk?=
 =?utf-8?B?ei9EQmJxdCszNmdZWGZIb25DdStidDY5bkJqdFlJaHRwajIyczFBMXVUOHdv?=
 =?utf-8?B?ZytnaFB1TFlBekJaL1h5dFhoWkFGdVlOSm01YjZNaktWWXFncnVqV0d5aWh1?=
 =?utf-8?B?cm9QRFI0UHV3ZzVBMDcxQlcyTTJucDNXVi83M0JjejdsSEwrM2ZJV2hKSi9G?=
 =?utf-8?B?MTdGTkFKOU1FMEJNb2poMzR3aGU2WFFJTWlBRDJ3c09TRU82NTFzcmtPTjJP?=
 =?utf-8?B?TUpobG5GWERkQzZlMW5kSzRNdmtuZDFxeUdaWVlxTXNKYU9ubGg2eVZwekow?=
 =?utf-8?B?cnJJTC8xVmt4R3RhYnZnMlo1Z0szQ25lbHdIRDdHckRYaElpbnNmdVcrZUwy?=
 =?utf-8?B?Qmw1cktoelJ1ZmlDNGxyNlM2bVkxVTFHVmJicXRBTmg4dnhsNWl6RldJV0ht?=
 =?utf-8?B?eFVnWDZYaFY3NVE4aXdKU2tvajIxUWp1NEhTd0lsRGhydmEzQ1hJVVhWaEt6?=
 =?utf-8?B?Y2IrOFJtdW42d2J3Z2tPWUdCQVF6UmdYOXhaYTgrOWRHMTltM0ZMeXdqcjh5?=
 =?utf-8?B?WmFLK0h5emlLUDd2RTE0RFRPYStvN2NHNlYzY2VEWHlwdUV1ck1mZk8vMWQ3?=
 =?utf-8?B?Rm1MWFZMZ2FJbmlyTDlIRVhwZXMzK1R1alZqdDcxZWtHeUxnUEY4L2NNYkZY?=
 =?utf-8?B?UlNjcGxFMHR6WUNvWDRpUXZUK29UeVJCS3FyUEJmaGQzWXZQdnl6VmNTV0lI?=
 =?utf-8?B?LzZqcEJzQ0Z3SElBSTNRZW5RV0hKMWg2M2FyWXpZQSt5Yi9ZcjEwZENWd3VG?=
 =?utf-8?B?dHkxL2RGdnJBVm9oMTlQNUM0UVZqMlU0S3QwRCtKWTRPSXNoUVFESG1UbGpw?=
 =?utf-8?B?Njh0dlNYVkFWWTliZDhLd1pzQnI2UmxvYmZqT0xSNXhINWU5c2NjNStBc0xn?=
 =?utf-8?B?cjNzQUtDTHkrNS9pNFJ6VVY0MmcyVG9VRUlkNG9yejBzcDJMeVlKWHJLVmRn?=
 =?utf-8?B?TThRQ0NGTHBpUDRKYlEzZXJoMUN4MXE5MWZUbnVhNnVoYVRHaXQwd3Q0SWk5?=
 =?utf-8?B?SXFTUjBRVUpJeGR5MVk2VmNlaUVvVWxzQ3NYd0h2TFg4LzdHNU9ZSCtDN3dR?=
 =?utf-8?B?WVZqVEJXSGY2d1RWZVRUTi9ZR0VXcHlGTHNlbU5ReVA4ZDQxdFl3RllVdkZ4?=
 =?utf-8?B?R01TZGtJS05iY2tKRFVMUzF0a25VWUdaSyt3SFprWkUvSXdqNTdSZkc3QlM1?=
 =?utf-8?B?dXVubHdybTNhanZBU1R4R2I3R2xRR1d1aVcwQklYZE9BNzB1VTZNODI3T1kr?=
 =?utf-8?B?RFBkZzI2azAzdTNaRll5UmxvWEo2VkorWVlaRTdmem9WcFpqOCs2YVViZGZ5?=
 =?utf-8?B?Yk5HV3lXcFBXbHNZNnFmTElGeU14OFdpV0dLTTZUT1YwYVl2Rm81bnowWGRY?=
 =?utf-8?B?Qi9BbUZhUnVSZFVCbWhoa2gyMGpnZ1oxVE55dEQvVzlFSWFxTlhlTlpzWFo3?=
 =?utf-8?B?Zi9zdk1MOUJrMHBJRDE0bVloWWVKSWF4a0Q3d24vSGxOTVZvM2IvNmdrOThV?=
 =?utf-8?B?djhGcFVsVzdpZ0hvTVlOVHFzOUYxQmIxa1RzMDJGMDI3ajN6Y3JBZUtVdUsw?=
 =?utf-8?B?Ty9MWEhLdDlCSmJoWllIaXpIcFNkMldXcW5tV1ZOTmtnUy9LN0tJeUoyNEJI?=
 =?utf-8?B?NElQeVczNyt4aGRhRnp4d3NuWWF5TlRCT0tIV1hhZEpTUTM0bjFQaWhTRDNF?=
 =?utf-8?B?YjNhSDRBRDM3cDNEb3ZKMnNzZmlBWDF5cUxHaWtUQ0ViSWx1c3ZzUS8vYlRo?=
 =?utf-8?B?MVdsVExQV2FITVMweTVPVWphTjhqNkhLTmdOdUxKRTJHS09US3J1cUZlOHNR?=
 =?utf-8?Q?sHxFPczNlEA28REO58/7K2xny9TVsCVlEjVQZ+F5uyuuU?=
X-MS-Exchange-AntiSpam-MessageData-1: FS3MpCvWZacSYw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7951e8-a710-4ba5-a377-08de84be1016
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 07:14:58.3008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GT1RmloJxJhoWj3w7HBTZZf4GKUPD7GyhyKwD3TgvlEhjv5mF2X+9xowGrMmwAwH3HP+vBP+wPIl+ONlLGc/ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
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

Change flush_into_kvec to return KVVec instead of KVec. KVVec uses
vmalloc for large allocations, which is appropriate since RPC reply
payloads can be large (>=20 KiB).

Update GspSequence to use KVVec accordingly.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/sequencer.rs | 4 ++--
 drivers/gpu/nova-core/sbuffer.rs       | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index 474e4c8021db..c8f587d2d57b 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -42,7 +42,7 @@ struct GspSequence {
     /// Current command index for error reporting.
     cmd_index: u32,
     /// Command data buffer containing the sequence of commands.
-    cmd_data: KVec<u8>,
+    cmd_data: KVVec<u8>,
 }
 
 impl MessageFromGsp for GspSequence {
@@ -54,7 +54,7 @@ fn read(
         msg: &Self::Message,
         sbuffer: &mut SBufferIter<array::IntoIter<&[u8], 2>>,
     ) -> Result<Self, Self::InitError> {
-        let cmd_data = sbuffer.flush_into_kvec(GFP_KERNEL)?;
+        let cmd_data = sbuffer.read_to_vec(GFP_KERNEL)?;
         Ok(GspSequence {
             cmd_index: msg.cmd_index(),
             cmd_data,
diff --git a/drivers/gpu/nova-core/sbuffer.rs b/drivers/gpu/nova-core/sbuffer.rs
index 3a41d224c77a..ae2facdcbdd4 100644
--- a/drivers/gpu/nova-core/sbuffer.rs
+++ b/drivers/gpu/nova-core/sbuffer.rs
@@ -162,11 +162,11 @@ pub(crate) fn read_exact(&mut self, mut dst: &mut [u8]) -> Result {
         Ok(())
     }
 
-    /// Read all the remaining data into a [`KVec`].
+    /// Read all the remaining data into a [`KVVec`].
     ///
     /// `self` will be empty after this operation.
-    pub(crate) fn flush_into_kvec(&mut self, flags: kernel::alloc::Flags) -> Result<KVec<u8>> {
-        let mut buf = KVec::<u8>::new();
+    pub(crate) fn read_to_vec(&mut self, flags: kernel::alloc::Flags) -> Result<KVVec<u8>> {
+        let mut buf = KVVec::<u8>::new();
 
         if let Some(slice) = core::mem::take(&mut self.cur_slice) {
             buf.extend_from_slice(slice, flags)?;

-- 
2.53.0

