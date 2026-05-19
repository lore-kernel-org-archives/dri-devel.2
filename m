Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9DFCD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B261810EA22;
	Tue, 19 May 2026 02:56:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bnWiQf93";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D6010EA21
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8FODGZKbUczoN8gCAb7bZGZ67x3HQh9wrNBV7ZgKnkNN/2lawu0Gf8rQBxUO6t86sp40I9Led8B54q5p8mmOVFmQnRnzpmanQ8/55csEmdk5iGnq71A7dppOsIRGJFMnwZaDTYiMIi7i4HRfTNZfRy5uuKLA4vuyiwgBmQng7bpFitHsdB0oWSVmIybMaraowNgOycngcx/COpDyPsM/espXzCfAkulgmyMOXPcqr/9sbLdEGGUUsPtAkgGPvoFnOLNoaVbtn1S09gVANjRPpBrzxEHQB4pr2I029NQA/ip+SqiH69BmttJDpFREhMtaZWy9CgCy2dW0L+xODXzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGuKEf5dzgCf88Zl3fZKUXKAcIWrjIVQrRC5W9csxWY=;
 b=Xlk1IPSTP+BEKW7g74+0/nPCXaBwFaAm+Jwk7zqZc7acrcBP44sJVeXmmJ82RWlspfK5+wESGLbSGgx9rPkcEJMyoMvUqoKk12xTDO9JE9V/n1d/KB+W2YUhrofuIYTzsGvbdopxqzDyH0PipE+k1xRsYvnnqp5TWBG7Iuw4UNamcmIZy9A0l2jyYYCQFWmrNt1WR4/0OJ9rxhX3y6AVLcF1SaHW0w7y5czf5UTJUgvcU1kARuQsHnO13rxCnGGpbu+6vG7p9uZgtATDVMsnLvdCW4fD2UnNCLZexZmLKY0Lq5g5TW3a4IE/x5ccqJpvJIfpgwzIMgQfYNB/b6C73w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGuKEf5dzgCf88Zl3fZKUXKAcIWrjIVQrRC5W9csxWY=;
 b=bnWiQf93L3dk5L3aammQVAMhBulQG0+TDW08b3fAI4i4O0sfs/igHf5vd+2IXMMEkB43JeJkJhtXM7PaOV6goVX6pIQkg2RgniLKM4FY1axQRw6fG6yTi/G4hq/1Yq/4pAzLdEmR3IZrCnvM7FK0l/6nebtnXQNxwHMB/9lpkzwCWxkggrvB+fpJBIlgb70Uk9FkOpUrXe/awHCTbydGjdTBrrQWpWAyMD0iZPt4dDzY8Cs/C45AwnKiVGiTYCgV1aJjSAJJ6ihzYsqbY7A5FR5OjEcVOhfb4S1PU5WF7XlNy1TvRSTGka2thVY8bQmQJtu/m9CsULnfXn0POpKgXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:56:12 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:56:12 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:55:00 +0900
Subject: [PATCH v4 06/20] gpu: nova-core: vbios: use checked access in
 `FwSecBiosImage::header`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-6-5d3f210c5602@nvidia.com>
References: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
In-Reply-To: <20260519-fix-vbios-v4-0-5d3f210c5602@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0245.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::13) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d4e849-f608-4db5-0c58-08deb5522f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: xJb8PXuPDMSdSit5WZn5tMOfoEYG/IT85Tu40/+IxoT4nKd5FABR3DbBXClNU+Vb4VlOaRk3egsweEUG5HRWSP08iwi7JtPlSqYW9kM09v9qdTI6dmLEC62N5N9dgbGFNP732D7tLCH//jwt6DK4n0YZYXdOa5L7gWYW+5dBy03q2OPlwezbKhiju8MxlyRP0THYLzItowii9VOrmcCgVeCSk3EP36TNIAHoK33/kvEAsqGfSUPIh8Et85HCVo9HKvc0OScQnrEPgSnw7DBvnVu1lJnVrVqHxb2faHhNcBWlGbTQ4dtBNMFfhMQIbte6uXeEBW17pyUQXjEd9pbxUx6/FV74vZ87tufiumdFSS1QDmZcK/GjJ+rKGxOAhCTvCKTJ6zvl0uPQ/GpBvDZOH2yQVUbMlG0FciJglkL4CAtewwTGW0jgcuaCo936o48NlGcAZvHaX2K0auqe+HbodFVJ3R1OH/KE/8bD6THVM7baQ3WsJzezcatR0a7EDDbG0l/g3sQMUIc1ZzgR6XrsXUxysAEAvbwNqXbmicucB8pQJQ1w96XPi9XPbR3xLVZYJeHGu/W1sLU8k4eTiPfYIj8mCaReG7ee6NC+ORCAzLV6J27WtjskNzEYVf0+mMgKGL6HIlqPp3tF17eRo6SrxUvvYyMjJipolSlvchwg14eVr7Vkzaxt1FioQzZvbxJr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHRISTkwMW53VWNjUUxpbmFJbTA2eGJaNmx5cWQvYm5PbDVQVXAyNEZobW5y?=
 =?utf-8?B?NjBsaUZEdDFSbFIyWFNPbTVQTnFZanBWQytCaG9lVUNZa2d6TXUyNkErc2ND?=
 =?utf-8?B?dDVNTnhvbUV5UWZvUmthVmFkM21OeEJBT0RjK2Y5VGU2VjRVdnVEdVNsQ3BP?=
 =?utf-8?B?SXNET1NDVjY4Vk82dkNQY0JLaDc5V1VWeXA4V0wveEMvY1JNSW5WRzFLcFZF?=
 =?utf-8?B?TVpuZzBZVUlleVRMbCtpRlAyMGVTY05aemk1azJXNkxWQmd5LzdhYnhQZjVz?=
 =?utf-8?B?dGM1TjdHdm4veHJpeUlQUmQ3dUFCN3dmaElSQlZQZkpzYkV4ZSt1S3hITk9i?=
 =?utf-8?B?cVZSWUZQdVRJZlhIY04vRlJPSzJ4V3oxbGw1M0RITDBoVENKWWNodDBlZWZV?=
 =?utf-8?B?STlyVDFlNXpVek1MTnVsd2pRZ21tOVhwUk9lM2VIUThXSENUbGVuT1RpRzc3?=
 =?utf-8?B?Tjh1Q2lFSDB6WWw1L2lzTTJtZzIzbjBkWkJhdjhMcTZHR21lRWNMKzBUM2M0?=
 =?utf-8?B?VzNqY2VPZ3RxYkp1OWcxUGFzMUhoVWZtcHRNNjkyVS9uOEtUaS9LR2ExaVNP?=
 =?utf-8?B?WTdpWmtUM1RlbHU3MlF3b3V0dmo5d3UyZlNWY1NFWklTRUVHM3gzUzB6akx5?=
 =?utf-8?B?KzVvVWZqVnJMSHFreGZZNUd6blBZQ09BMTVpYUxIT2JuRmtJVFVibm5kRUVR?=
 =?utf-8?B?SFJ5ZkhZazlTdjhDcTY4aGJCN1FBbXJFeE9qekF0MjdCQUVFbXNHa1JrekF3?=
 =?utf-8?B?bVVtQmVFVXdJdEdxeVQ3WGQxbHAyTmM4VmV1TmE4YzVZZnJQeDNFblpTbG9P?=
 =?utf-8?B?SWowWXJlWmp3TzRLUEhXdlQwQ3hmaERIY0ZzTTlDTUxLOEcrbm12cFdkUmh5?=
 =?utf-8?B?RTdZNVBta0NpRzNCQjRZcnR5OFMxbXVHOHZhNUVGWVBDT01IdStySDRCckpJ?=
 =?utf-8?B?Ly9SMDlyVGY4cWpmNFkwSkI1R0lJeUhKOUUrbXcwTjN1VXg5NE1JS1lKcFhG?=
 =?utf-8?B?cGMrQUlLVDNVS3h3NDBuK2FsUkw4enlEeXdncG9RbUN5Rlh0WEYyRmVXZjRh?=
 =?utf-8?B?Rm1vaUNwZ1Q0MzNQbnExdlZ0TVNiWXAzeGZnWEJvK1RaelJVMy9kaDkwK3Va?=
 =?utf-8?B?cFlFU1RWam44ZVR1SU4zd21BZHV2R3pocUwvSkVOVTF3M2lBOCs0VElKeGRz?=
 =?utf-8?B?Z2lraXc2MVVZY2U2SGtOVGd6ZlFVM2ZGZjlkM2ZmSUZJS0QzM1pENHBOdUVP?=
 =?utf-8?B?YjUybTN1MFZyOWVuL2ZkZW81dGVabUgraDV4SDlzcDFBM0xrcndqVDF1TWxT?=
 =?utf-8?B?VXlCRkdJbUNWdzY2bVZ4ZFN5cGVuVGdSUGoyQmVhVGh6SXdTRVNucUhwZGJj?=
 =?utf-8?B?U3lSRkR3Sm9XdSs1RFU1SE9DalRCUjdIN2Jrd2dtYi91d21uaGJTWG5OZTJa?=
 =?utf-8?B?NytiVG5vZXhWakRTbnlqMTAzMHFtSjhpdnVVMlpaemVqTWJPQUR4bUxUNkIv?=
 =?utf-8?B?cnRQbFVlMHJoQWhZZStVendZZzFpbEVzV0pJeVhpd1hNTlFzZmZHMVZWN1RQ?=
 =?utf-8?B?bXZ0eWpscEdRbzJ2VlY3TXhpZXdCeUNVaXJiNkxhZjNueXdqQXhYUk94amN5?=
 =?utf-8?B?MllyWmxWM3BXT1NlaGpIUXNaMnZRT0Q4RUdscjF6MGFLc2VjNWZ1Uk15dzRq?=
 =?utf-8?B?bnRsbTF6ZnByZXprZWRsREhDcXIrRlc5ZzN5R2wweXI0MUp2aTBEUFZuT2Zr?=
 =?utf-8?B?RUtYUC9jRXN5N1kzaUtReVFzdzZEUW5vZVh4QzcwQmZlbGgwc3RCTWtBaDB3?=
 =?utf-8?B?MkZPeWxnN0Y2MmxmRVRLS1RnSHVycmJzZ0NBLzZGcUpLS2tMY3BRbHFlTFl5?=
 =?utf-8?B?RGEwRENCVVp2Y0FpekZvWkZZaWdTVDMwM3dCVU1UK2k2Vk9hU2FPQUNDL29t?=
 =?utf-8?B?VHg0R3B4RWhkeUFZQUYxTjZPUmtEajRON2dDb0JOZ0xBS2h2Nk00c3BWK2tO?=
 =?utf-8?B?VUpxS28vOFRsM3E1cmVINndiRTNFTUt5U0VXZHdxK2drZVFDWk1DWmtzTkds?=
 =?utf-8?B?ZkN1REVtb05GTnFVaWZzU2k1WEUvQ2Y5WWlQVE5GTjBRYnpRVzR5WVMybTAr?=
 =?utf-8?B?YWkzcHVmV0RYcGYySE1RVjM3UC8ybFNMR2hyUHo0TXpHY3RCUlJ2OThxSzRs?=
 =?utf-8?B?M25IRjJlYzU3VmZqd0RzU2wycndEc2lZeElzR05SaTcwMWUvdnVBdTJ0MGhU?=
 =?utf-8?B?QldJcVc4RmJybWhZaXBwTTJoUXpYZm9NVVNmOEE1YUEwQ2EwY2ZyT0dqZUli?=
 =?utf-8?B?WWdIUU1Nblc3dmtLMzZhRmVSY3crd0hSdTRmZzlDZDlpWFVURFQ4WWdnRm5s?=
 =?utf-8?Q?rAO1PluOdaGpzWfImZZnhoWNiG/n/khfE1zUlCo+bYb6Q?=
X-MS-Exchange-AntiSpam-MessageData-1: u9g9/q/v+2wcKQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d4e849-f608-4db5-0c58-08deb5522f4c
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:56:12.4770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nm++URQRTSJWdA9PBt/hSoD2xQt/z+PjstAYqIfzZxAc8+VCl2aKMqXUWC2G+0Gk8DoKnuUbjnoX/Las8Lf5HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
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

Use checked access in `FwSecBiosImage::header` for getting the header
version since the value is firmware derived.

Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucode extraction")
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index c62d918a3041..48a46684e279 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -1077,17 +1077,14 @@ fn build(self) -> Result<FwSecBiosImage> {
 impl FwSecBiosImage {
     /// Get the FwSec header ([`FalconUCodeDesc`]).
     pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
-        // Get the falcon ucode offset that was found in setup_falcon_data.
-        let falcon_ucode_offset = self.falcon_ucode_offset;
+        let data = self
+            .base
+            .data
+            .get(self.falcon_ucode_offset..)
+            .ok_or(EINVAL)?;
 
-        // Read the first 4 bytes to get the version.
-        let hdr_bytes: [u8; 4] = self.base.data[falcon_ucode_offset..falcon_ucode_offset + 4]
-            .try_into()
-            .map_err(|_| EINVAL)?;
-        let hdr = u32::from_le_bytes(hdr_bytes);
-        let ver = (hdr & 0xff00) >> 8;
-
-        let data = self.base.data.get(falcon_ucode_offset..).ok_or(EINVAL)?;
+        // Read the version byte from the header.
+        let ver = data.get(1).copied().ok_or(EINVAL)?;
         match ver {
             2 => {
                 let v2 = FalconUCodeDescV2::from_bytes_copy_prefix(data)

-- 
2.54.0

