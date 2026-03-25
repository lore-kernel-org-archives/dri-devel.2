Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A84106B50C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7CC10E867;
	Wed, 25 Mar 2026 12:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="d3knDzDm";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D888710E89C
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftDcwqWkQqhwJRRJ5N0IRtFt4KwAsVmOfupOUusx4FSHUJk0WfyX5263Ugxi2+9VJssBVmL6aXmLPuuDWMBBDmSR+nbZ7wxYwuwI6+99om6/+GJy7/VZrtSPtAPMF894N3Q/9xr9lP0UvVXGPlVRMPdqJl5tH9yNYvrgDBdFnFGQeb0yu6NDN+2GBYKF3lRrc0MkbyHL/K+8Ztky7HH3uKu6VMWDN7O+T12JMic/ojAfRtUYbGSTKsFYtswdQbatk5+gWWADffuSNbGIX1iAZlS9ULSshLDZaxKjiWILgoeRfLdB2f/cwnRKPCvlfJceFw1vj4m6+rQjsW9UXiL0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAdv4EsEnz4pa/hccDO+aPbUA6jV0i3gF4VPXNK89TA=;
 b=MKHZfFTkqmp3pPV9aA1ABeQgpg3BaFskQljYWrKx0TISkR7f0REFbOvkR0KyaNQm5kssItPlitaMYx7f52DIo4pREr03AHTsZv+Aoqj9AQogjdU/C2RpWqArYSWaAeWklefWxtimuMrCnUDQlTn0RR9gKZT8RJ6BYyQmST5zf/iLFXrACeeuiEO0g1Gsm9Yg7ImgIk4EZWOlIaiM2sEVRTYL4EbDiVDBSLFmj7eVYgCYmxiAIA+DcsuzTB1evhtJ96k/Foprq+b+X1yuF+cgFo288zjyl+8qnY7ReRHEt2COOv3uz1SBPEUcx2dLFzrFJVlA0BvcTm44ZlX7042ygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAdv4EsEnz4pa/hccDO+aPbUA6jV0i3gF4VPXNK89TA=;
 b=d3knDzDm3RoV3PuPe79kHKut/wEWtz9tJuRQQWf7Dy1hs5iKL+jywxpJ3UpSs60KowgVWvqXTGoaiBG77lsxSPO5mQ+AZE6Dhp2l+KBD/jt/9+wqiaMvGPEjilwMPrWQSfwvLhv1CZ2xt1UDACb+ptwB06Q3RqkS6r4s68QYzwFDFfU6jHBvf45otpYSEP0UYrD3s/xDpYk5KFxG/3j848IPo+0dUR6ssCkberMsi42X9srqNcgP2Qe5h5dLCJB8/6qc/R4KdwTuFZbLIDz8u3HNhQk1NCB7I8L8HcxYlKKr4snMq5Dej8hshtaFD6lRboyppe4sM3BoE1Zsg8jxlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:14:11 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 12:14:11 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 25 Mar 2026 21:13:44 +0900
Subject: [PATCH v3 6/9] gpu: nova-core: use KVVec for SBufferIter flush
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-rmcontrol-v3-6-f3101093484e@nvidia.com>
References: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
In-Reply-To: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TYCP286CA0131.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::13) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba4d599-1ccf-46ce-b778-08de8a6805fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 9uYKaCXHfdzpVv/e0bQPD/OgCUFJXO7mYq1EREsrTw/A6JActCw6p2PsOKunyL6n6U6RH3b3CgBmDEAFgDzYScrJkcvE1rm53NGzqOQiiF70Q8np6usmEfyV1lkkvWUNpNsL06xY5phoNyj8JrRAtbfjrNSwoNPepO93EDNVGqsJax0orsJafDS+ekmPCX857aqanpOA9o/+tjCWRkPM7qJONjfhq02beEkmyFjOuSIen5N9yq1w5xTzZ87MRSXF3aKppy3xz/JNaoWucQxW+660caM8w4VOZ5H6nrZVpv8s9CBr2178CtBI149KgFbN/o3B6b/5KYUAAwlyIntqr46NKDDdl5efqRQlbZP3/VdyNP/b8p327azH+mgSSD/AUZvyNbxssQcka4hXxEKkyHsStIWG5Q5G9BmmB/cEhWjJSwcazWqXAVKDzNMzZBq5Q4ZItpEhL2hMgcc/YuFU3JXQSvAKXvccmQNKJniWgq5VqH8nu/bUNAAcLx83kXoRFq80YrgwfbxFmkgkprplgVrQkarcCBZEOGyN9+RHKgGtRKXaGB7dMYQEa2dEAwcFXTHVCsIezHXfLDBgNEGn1v5W//blI6YpMa3LTLFEsq6MPSazN8tz02V6xC4Cc4WMsLDHh7I+8Sqyzmk/8/KwyCdZxStQiNvOnu2BcOE+A/Bo2p5VV+OOxmvvv786YzrOiyuIKFS0lR/w9ryt1ydsrZ74x/J0qcsADN97PDA+Oeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlJwYnl2dlZtcUlyUGEvbkFIK3doMS9Xd0oxVnYxZGtsRi84MUdRWE0zcUhZ?=
 =?utf-8?B?RC9OTjRLWm1KMjRldW1RVmh1N3UzVGxuL3hhNnZ5cnZaWnRQKzVacHlUVERu?=
 =?utf-8?B?d3VSSnBBbTdPc0Q1VmNibkc4N0kyOXRQaXE3dEIxdURZQlNZVjVTbzg1RzZt?=
 =?utf-8?B?ZU9uYXZpb1RsVVNpWEp4YlV2ME1Fdm9xSExvNlBlWDR3Ly9kOXNzekVXYTlG?=
 =?utf-8?B?Q2Fya0lrRXZ5Nm9zTUFwSXRRWU5KbjNtNXhzSG5EaDdNTW0vVmRjM1dkVmlB?=
 =?utf-8?B?NE1oZkZodWt1b2NNRkJtNFViM3Y0ZGdBY0d1SExoT2pMNm9rUTJIOW1qM2Fi?=
 =?utf-8?B?VE4vSVlnNVdFaVpqdUVZUm1xTVdOa1VMalNtVUVwbzFNV1o5Zmptc25oRHox?=
 =?utf-8?B?dnZISGpTQjJXSy9EKzYwY0lacXBCMnUxV3BNT1dMWFROb1hPb2VYNWxTTG56?=
 =?utf-8?B?NzhXZjY1RktldTVXcEtTY3JheFJyU1BLOXVPZlhuUXBkUlI5T2JOd0RnMjFX?=
 =?utf-8?B?ckVXRGxaN3hQYm0zV01KcTA4TmhhbGxMSThBc0U4aCtrOFByLzE4RHRtS2t3?=
 =?utf-8?B?MmxRS0dHakNjNlNXYXJrMEJiK0p5aDVYTEVOV1pJSWVneE44Z2w0cnRJY2hx?=
 =?utf-8?B?ZzlqSmcrdnZ5SmttUS9ua2pzRmhZVzlXcEU3bjdnNzZhd25LTWk2QUM0VUli?=
 =?utf-8?B?THR6YTRGWGpJdTVab0RnTzRwUXMrKyt0Qnc0ZjBBZHdsTVlWNDN2Y21xVzFI?=
 =?utf-8?B?RWk1eFBTT0s2TlROcnhHcDdDUFV0aWtNOGFMZ1BhRmdUckpvZTNEREN2Uzdn?=
 =?utf-8?B?MzVic1Bza3U0MlYvNlFMOUtmMXJkTlZjZm5uZ0tyUjIyNVV3RFZBNUVMSkVV?=
 =?utf-8?B?dng5SWVVTncxb0JaOFdDVVVhNzZFM3pnemZDbEROVUVVSURiVVY1MzFzNm9P?=
 =?utf-8?B?UlJVMWtJVnBOVGx2UTFkSWdINm4ya2laNG5oWEZydkN1cUM2WDZQRldnUVoz?=
 =?utf-8?B?VlZUazFqRU9nTk9KazVtcXhSK2VScXQvcGJvQTdYcVhSWEhJS2htTDJ0Vk5B?=
 =?utf-8?B?VktHL0ljVklWNk4wNFQvTUFPQnNnSjJYZ3RKUmRkZjBXRTNMbmp2QmMrc1NM?=
 =?utf-8?B?RjcwTnorM2h3R2s5b3dtNnAxaXc2SUlER3MvbG1QdzhFajg2cGZHSnlWUnJJ?=
 =?utf-8?B?TjdpT1BiVE5IL1dQaFpuZC9jcDBHM3dLU2s1Zy9xYzlrS0tpMTJiVkFUN3U1?=
 =?utf-8?B?Y1ZLQjFMQ2I5NXZXMi9yRkRtQjk0OUZQR2VHQ1lIcmRJOHF1ak1JeXVvWm9Y?=
 =?utf-8?B?aC93R2E4Z1VwWnM1MkRqUjRQV1pjS0VsNEhPQy9veExwS09vV2ZTS3RsUklD?=
 =?utf-8?B?K3pxVndSRmpGWDR4OVpBdUZuU1ZQQ0ZkS25EMjNMTjZsVnBRVkNFS0FqNWJL?=
 =?utf-8?B?MVJNdU4vL1Z0NmI4RUIvVDBXZnRZalE5WjcrRlhGWm5xd1dVRTZ0U2ZRKzVn?=
 =?utf-8?B?bVZSWENRUHN1d3llenhDM25RSTU0MnU5UlM1TjIrYU5rNkk3MVZGeituR0RC?=
 =?utf-8?B?WXY5RCt5VVJLMHB5a0VabGw4SWJueVhiN1dONjcvb3Qxc3kyeDBQbXhCVlB5?=
 =?utf-8?B?ZGk5cGZiUENFYjJKUTh6a0VWc1NaaHdnb1I1d3Nuek1ReW5MTU5zVjR4SUQ1?=
 =?utf-8?B?S0NVSW12cXlMQ2ZCQStEeURJK3JpcFd3Tk96aDhFcGl2NTdYQkh4UndEZHZJ?=
 =?utf-8?B?bjcyZnpQNlhJblEvOEJmK1AzVW01S0tyQjQrT0FxUSszYTZqTEpSYlZHa1N0?=
 =?utf-8?B?enRXL3VjQzl0d1h4K3hsNHJET0FNMjlIVlZGS2gvaWlJZzlDLzhZN1Njc2o2?=
 =?utf-8?B?eWFhWUZoRG5vOHlBb01oa2g5YllPVVF4VW9UMzdIaW1QbDJSUmVWcHlRSDhQ?=
 =?utf-8?B?WndjN3dBYzdnaFhpUm0rcG8wY2wvWkZIRGpqK2JqOU5nMERtVVBVUWQ5YzJI?=
 =?utf-8?B?bWYydDVmRHpXNkRXak50dldBQmhLUGVRU21XNmtYQk5taUJ6amF0ZmZNZHU1?=
 =?utf-8?B?T2RWbVA5NXZSVi9xeDBPdGRJZDdVK0kxRVpzcEo1eTlKcVdzcWlJdGtrcElV?=
 =?utf-8?B?SWRRK1l6blB2ODU3bjVIek1MN29rYTdmcmIyUzhLZzgza1ZQc25lM2JrQmNz?=
 =?utf-8?B?NEFBUzMxS29HZVJDSW91QTNiZFJoVjh6enpGeEo0RmtuOWsvQnZ4b3pzNXlo?=
 =?utf-8?B?d0xEbjY3Z1FraGNEeFQ3M0lZTzBWZ1ZDN1BtTG5rajVHaHU0Vk50UENZSWZB?=
 =?utf-8?B?cG5SUDBXNnN2Tm5IYWNyWDdNYWxHandaL1RDbEk1aHRiM0VuMUZweXlST05r?=
 =?utf-8?Q?AQYf9cGHHsH7sHBdjhqwZ2nm4sNU8fJF4wnowsna4TNYt?=
X-MS-Exchange-AntiSpam-MessageData-1: TpO89LKxVuuzQQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba4d599-1ccf-46ce-b778-08de8a6805fd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:14:11.7562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4O7t7t8WkfmZrD6jMMbx1v56Ag3qWkTZpEVEHeariFmxUC9/3Pmr19RWA4dI4/MZfSq3zXK5WKUhA0qe7eNFrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
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

