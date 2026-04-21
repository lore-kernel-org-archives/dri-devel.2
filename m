Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FFDF327BF
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 233E210E868;
	Tue, 21 Apr 2026 08:20:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="YvQntPJW";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C55CD10EBAE
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:20:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsHa4s5AF/XT5DBLuJtJ7t2rzVq/GFbytnCAJyxMuod2uGq+wp/hLa4StNxMtOSRY7AvTfgWJmOBmrTyuuofUnlCYx7/vEX5fKJBS0n22PiFx4KvPvFcdUqijDcuPe+DhUkjDH+iV/ziws4ZuYiGYqUjolETp2OAvauZTZ8UNU/hsgEp+bE6pJj/vmm6Q/yzKF97vLjp/xBvHzZpf2GKXNBneoA+sHa8sS2afu9Wxa8N3ivWKwLLnL1+pM50+XdSV/jpAQAhxUqVCaz3mMFzwDFW9C6Vy4Is9RVzZAXZYtIsVMIaPGv/Af8QfJyUrG6ueklDy2r3WOYVwDkuhLP2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzJKy9nr8p/NBiGBqymBpLYwlO0WKKIv69Wsf6gVICY=;
 b=nPpdlrV0i5gwCVuNwQvBm76POzr47wZTrTGpOp+gAgrtu9E089d7ap8HS/BXhwJ1YFZjHqmglIA4E4mXBJ0+qsfITlim4TETInlc7vr9M/FTzaGLCuCTS8yH/Vbi0VXCII2aEyj/U8Z30LsI7mjFaI9Up7oesItnaAO2JCAB0QjKAKIdfTl19Rs/X6hz+GGN4n3VOic3VJWgxLXhX81hdY5quXJRJOvL+Dyxh5B1xVIGHVh5CLZaxggjioEicNwhS2w63wr+nOYpQFd3fz6t1voQAYsLT9MObyoNPp2HFwWH803BBJ5bsX5Hr3UJlSCClKqIc0VRsMTAkl9qCfEIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzJKy9nr8p/NBiGBqymBpLYwlO0WKKIv69Wsf6gVICY=;
 b=YvQntPJWQfWbTypaT2v9MCjLoAgrGcDhIv51Iw5sVseEcLWi/iSXZKyC+mi++5JHuWHgw6RgW4+xt3q/QJ4lrK1z5r3oSgJvwELrj+sccXOdw96aoLLyf1yRnZWowpiHbXKi93MeUmTtKFjkMwr8StOdxCalHus+gh5Tr3ydnS8PtFOeqDsEyMY+itAO0nxxWHnDzspD/vnZYpfMmnDG2xinH1aJMOxpA5h0C/zs4z/3ET1VUmlHl9Jv6Mo8dbVvv7ANRLAHENlIEB/87jAtxtR0QD8YEsfOxMqx6uHLsfp+nXmD+UNtSv14l8y2x6iJm3aaNijrCJG9dmYSd44d3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 08:20:52 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 08:20:52 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 21 Apr 2026 17:20:22 +0900
Subject: [PATCH v3 03/11] gpu: nova-core: vbios: use checked ops and
 accesses in `FwSecBiosImage::ucode`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-fix-vbios-v3-3-8f648aef7a85@nvidia.com>
References: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
In-Reply-To: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0202.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 51bfb35d-ed84-41e3-582d-08de9f7ee6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: YfVvXIVRmpsOMq6pSF4uHoW01eBhBan33jNgTEJ7eJJXaKaY+QOAXHoiG0m71C+jLff9BGe6fgRPafVdVtxqDfmcnYgaiWhj42IQqPW9UTrA1DGh+THRvEmkT6tAPWWIe3vd+tpPqyqev6eAS42bnlfEaLbRc5ntQP/5DxbNMiuRCK9+pZwuyw70lN8YKDLLe35lV7UYBeA4XDAaJpGyWyIiRzE5/vSExwkvI6mqq5t+j9hWoSAl6bR2MC/BuIaRVCPsGAITSqFB3o5NQ6U5J0ntK3ti3T04hG3kyOZg18Zd/lyG26BDSsoQHdWLkT1jjtmabxP0phTo6U0D5DdVWItVqvbXXHhsJYrP6U/oEAAsqp6wrOU+rRdaA0Q3gTZcwRN6lD/OjA/9LXHZ57RbzxfS/c8WkWO0fUz3qndOpmMDh7/0Wfi1OxzW9++tNNoP+iHP5mjEZgHUMarPE3jgwFgIfcsFYDMuzmmSrHRY4qGfVVgMl5Qf+Vi0BXB57bIoHjrtVGIgf/9W09+6Z5sHHzvz21GOFFkTYN60oYHkMpzg7C6mX7NMyue02gBpiOJVdPexY4bQpf1WDFDk7EJ2aDAWtsY4UKuL2uGYaIEP90/ucO/KrH2sDDSWnBQbbPAzvakmnf4aKdWs2rVvNEm/Ynatsk7+4iKSAOtnWQRBuuLZJGqlNHU8cYAyar/tKNSXe8y9si+YTKGxQ/4E6lWvTNILgx+yl/O2xbOkCvlp3DU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVVmdmVYMGFWMmlWVklHNFI3Sm9UeGE0RTlTdVVWOCtLNjd1SjRKempPYTZh?=
 =?utf-8?B?RmdTMjJDRWJjaXk4UEJlQUxpWHVUajZ5Rk4xU2pheUNuM2h5NXMyOXdWeGlU?=
 =?utf-8?B?RTVDRVZxSHk5bThpdzlTcEN6YjRDYStxRit1bk9iVk81RFBwUWZnMnRzZVRE?=
 =?utf-8?B?czNrNVg0ekdBU0c2SExKK2RQRjIzY2FScTVGeWN4TGVETWdBazBjMFYxM2Rn?=
 =?utf-8?B?RGlzTk1OalZhYWFYdWlYdThkNGtmTEhIakQzNDI0SVBzM3VUMEpudWZ1OUhJ?=
 =?utf-8?B?K3JIa0N1b3lvQlpPRnVieWQ1UjdBNkJYVkZ3L1NNRFVWQzhhS0RVQWtYTFNS?=
 =?utf-8?B?RjVRYlozNFdxaFRJalhudFRlY0VDS09BdW1STFE2QTVLdlNrdTVNeXNYQUFK?=
 =?utf-8?B?RUZjc1pWVXQxUWdMTjJvdW9WcnlqbjkvSUtBZTdWUmlZUmU4ZkdKZzNxNVE5?=
 =?utf-8?B?endrakJrbE5nTVNkTHZlOFRUWXBjZG5aSjRVQlhseFhjTW5HMzdDditrNjRV?=
 =?utf-8?B?WjZZTXdVOEpmREs4MGlGSUQvN0hrdzE1L1VVdkpvazFETXV3dWpKVmJaNEh3?=
 =?utf-8?B?WlRVWENoNnE0SzVYWVZCU051NFhsdHJOYVlTcTNKaWxldDlPNkJCVDAwU0VR?=
 =?utf-8?B?N3hsWk5nMkhvcEIzR3JKWlVMc014VExnbkFVUXhRak1XS0xmcWh6Y245SEEr?=
 =?utf-8?B?Y0NtZSsrbTJtVEw1ZGhMVFBsdFlRdjJVL21RZUN1M3Q1K3dTOVFMSjhsTTlh?=
 =?utf-8?B?MzNrVGNOS2NkTitVU0o5MTlndWFScnFjU2Nnb3d6VndjKzcwUzNqY0NleXFH?=
 =?utf-8?B?bC9aNmVxYXBIejhQajhZWXFjQ2pPM29HbzlOMDgzck1Od0J5aWVnQ1dkY25q?=
 =?utf-8?B?L0V3eSt4TkVpNnVSWHhxdERKRTZLUCtsMm5pZ2lFZjVJRVFwWFE4WnNxa3NW?=
 =?utf-8?B?NGk3cVBXUExwZHNGbFRsVS9Ealo0Y2VnZFBkelRWY0hkK2NyUUJRZFZ1bEVy?=
 =?utf-8?B?NmxSSFViQ0t2b1E2MTNNT1QxWXdiQ0JJTy9ST1pCaW5YTVpQanhOdm5CU2lI?=
 =?utf-8?B?VFBqY2hVL25xM1ZrZXZLekltOWx1V2pJeHlIR2tNWlpZUW12dGNxRnZkSnlP?=
 =?utf-8?B?S3pKemF0MTlJY3FSeWVhM1BQYW5mMFlGTXd0RkdrcndQN1JKd0dQeHlwbHRH?=
 =?utf-8?B?UUswS1NLa1gxVVBMZzN0c2lGU2d1TWtvM2htUGpRU1Vic2NWcW5rSyt3cHZm?=
 =?utf-8?B?eHF6SjFnYjZCVmc0Y0VFWnVGQStpZEFkdjRGSVB6SlRsMDVFd3lHelJFNkts?=
 =?utf-8?B?WWxsRmhhL0dJblVGVkJCMVBtLzdWSkNqc2NHL2NqM3krVFVqVkJPUnNUZU5w?=
 =?utf-8?B?N3ZLdUV4anNpMWtzZ1NjemVRTm1lUHJ0eE5LS3Z1bjZqT0lRVHNQcmVlR0tj?=
 =?utf-8?B?eDlFTWlqa2JUSnlkQTlMMHNaaHo3Kzh6cHZFWlpvWTk2dFV3bFlzT2t5Nk56?=
 =?utf-8?B?TTZRZjdRdTBQU3VpNzk5cTJsRG1sWUFwVnNjZDZyWFZYcFU1eUNhbldsbEpo?=
 =?utf-8?B?S0FJMVpnYVZBdGtmc3RtZUlDRmlnanp2aVdpcUlOMk9lWkFEN0VMeDJyUHhT?=
 =?utf-8?B?cE5NeGQ0ckNtWVJZZHdZY1J4R0lUNjBFL1ZmclhjL3Z2NTgvbndld1QvMnJI?=
 =?utf-8?B?eWdSbE5ITmJXVmpsYkRyUzMvVFg3YjBPMjJaZ0IzcnNabkdBczFUSE9jWFlX?=
 =?utf-8?B?N21KQkhHRWdlR3d3M2pBcmhZbHJETC9uZ0ZuL2ZFTmxsV25MakM1aU8zMmt4?=
 =?utf-8?B?QUtPRU5BNGExWDBOcUV6eVF5SGJkbVNia1JjaFVXNHZORWFDTmZndm1LRkY5?=
 =?utf-8?B?c0JzU2g3RllNaHJtbGJ4Q05MbmI1UjFmb01hTlIyc0loMWFlbjZJWUUxOUFB?=
 =?utf-8?B?c1hISUNGTnJMZWUrVnYzRXdPR1hpWkU5eExlWjZPNU1QSFE0TGk3cVk2UlRH?=
 =?utf-8?B?VTJwMU1tRi83SVZwSkhMY2tLN0NMN2RVNWVDOC9NOVVmZmhSem9xVWJaMmkr?=
 =?utf-8?B?RlpzTkNEUW0zRlp1Q3o0QXp1bWZyZFY2R3YrS3RuZGE1TFBjamFENFp2SzIv?=
 =?utf-8?B?QVphUVdNSTZJNkFpeUhCWWd2TGpaRWFiVGg5QlJiNzZnNlV3bEVSYnJwdHVZ?=
 =?utf-8?B?aGZ6VGhFOVh0WVY2MC9LMzJIS0FRTFlxSkZkcVE5MzhSZkEzK05PSksxWWtG?=
 =?utf-8?B?MGZmQUdNa1REYWJkU0dLMFVUSFVZeS9odDYvY3hCQ2w4akMveGl6MjIvVlQr?=
 =?utf-8?B?S3I4V1d4K0FrcFJRb1RVcDdSZTYxNXQyQ29Zc2ZzMEtpbkNBYWhDRGMxcmFw?=
 =?utf-8?Q?Hxi4Ku8q3blaqAXwlIZc5eJWGcr3L0p9QDJlD4xefks4d?=
X-MS-Exchange-AntiSpam-MessageData-1: XTAR1yGEk5Vixw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bfb35d-ed84-41e3-582d-08de9f7ee6f7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:20:52.4033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8620opC5EmYXuAwPj1k+ptVkKdcKWpx0iIeThoHa6+Mu+yt8xu8oEoNgQPhZaAFznPu7mCkrpFiEOJzyG5iXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
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

Use checked arithmetic and access for extracting the microcode since the
offsets are firmware derived.

Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucode extraction")
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index de856000de23..632c8a90ea76 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -1029,16 +1029,21 @@ pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
 
     /// Get the ucode data as a byte slice
     pub(crate) fn ucode(&self, desc: &FalconUCodeDesc) -> Result<&[u8]> {
-        let falcon_ucode_offset = self.falcon_ucode_offset;
-
         // The ucode data follows the descriptor.
-        let ucode_data_offset = falcon_ucode_offset + desc.size();
-        let size = usize::from_safe_cast(desc.imem_load_size() + desc.dmem_load_size());
+        let data = self
+            .base
+            .data
+            .get(self.falcon_ucode_offset..)
+            .ok_or(ERANGE)?;
+        let size = usize::from_safe_cast(
+            desc.imem_load_size()
+                .checked_add(desc.dmem_load_size())
+                .ok_or(ERANGE)?,
+        );
 
         // Get the data slice, checking bounds in a single operation.
-        self.base
-            .data
-            .get(ucode_data_offset..ucode_data_offset + size)
+        data.get(desc.size()..)
+            .and_then(|data| data.get(..size))
             .ok_or(ERANGE)
             .inspect_err(|_| {
                 dev_err!(

-- 
2.53.0

