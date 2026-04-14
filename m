Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D59F9D0C9
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 11:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 045B710E5A4;
	Tue, 14 Apr 2026 11:54:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="I9Uc0oTD";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012021.outbound.protection.outlook.com
 [40.93.195.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC7C810E5A4
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 11:54:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaztHHogfPvs9HDADL6Y9pia/G35Lyghue9ItQRc2FSijzMT3UwGGXvJLBgAyODFDHilS5N7BrpAoXxS4WR6f77E9r7DkyT249k84cLZmn/ugE8mAJCjoFsXES2z2ZvfxCcCNvMXwwyJYElSPAR270lgcLkH6AT9fgTLwM3jX/QgboQYSx1oFI48YAwM2nVTkoEWEU63zlGkdJx59K20UJZMUoM1HIPHUFGSvt+Y3IRcsAf9xaHBlntul+4U1tbwt5okcxhpQBBJ8ClQN9zQe65vcdieVytMDsjDgpFvJKjwkdD8EFOiCRbJcS/8+lmByg9Uset0aexlY0GtyPcV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzJKy9nr8p/NBiGBqymBpLYwlO0WKKIv69Wsf6gVICY=;
 b=rqd0xGeX+ChWu3udTNzFncvARzNOGWzuPRUePoF3Et/XcwOg+xmlYDbBrjnK9RpjCsNf16+elsSHVcWvo2nXZGzfViWLxUDDFLRGEtYRs+IFzum2xtiDKr9JB0vW9liOdYIlnjT4wCCH+I873vkPGTEzmK0RQYwvtgtEaYjFgJVnLCpb8DKcmaSHlKgaB35Fsjm2qhvi8usYL1wcxnvYbT70roUs0wp0EmZCfLC0JDtU+WXxSJvOh/kAHArUzU1J6CLtOSnPe5dvVVmE0+1y95ELXlzdaloTTrTm2NDzAuRppG68p1F6MwBj8ZKXYEQMTDflGkTN9GYVG1MdNN12mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzJKy9nr8p/NBiGBqymBpLYwlO0WKKIv69Wsf6gVICY=;
 b=I9Uc0oTDTpbcsl2HqUMQAkghgSssI5xWPnCB0bwY+y2Uq80vPjKmCxZKNuX+VPH791WqM923KqVKV41iHmcMv+6ifZRyZXRMy/XVIXZVBot1A11pI3bxXtQsccli9nXM+PY+skj27HhEDg7jnWq0PsdwrSad6uNWk6dr6Nc+CmzWxqxM8gGLC6Irw6rU1rliCSXiLd56C8wPatYhMgNcSAZSkTYSClXX+IEORajujNsZaz0MKdIU82WNbM0Z8RYGP0uY/S4SwreTVCTm2ykpdmMVuph1HKyunaZkTe99jDAcxPFHdkHEZZ9SCXm9xsyuJpdUIZRLVwTlvCCVIvzHyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Tue, 14 Apr
 2026 11:54:29 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 11:54:29 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 14 Apr 2026 20:54:06 +0900
Subject: [PATCH v2 03/11] gpu: nova-core: vbios: use checked ops and
 accesses in `FwSecBiosImage::ucode`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-fix-vbios-v2-3-705d30d16bba@nvidia.com>
References: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
In-Reply-To: <20260414-fix-vbios-v2-0-705d30d16bba@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: TY4P301CA0108.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::11) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c48ce97-d9cd-40a6-530b-08de9a1c959f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: kRTEL9LT/olvN6t4nPAEcLcfh5kvZzkO95h04pohP1X3s2uBIi2FGsO3XwVXDSYdznEvGHxCa1+2okXuYGsMwAMqn2r1LUf61/58897kvdMh6CP/le6rd0pQFl224eCXDt14IYy/yPKLhGTsPcrGHWiGjjqpBn/jVzcVPo6+2JPqjMfUADxqGkGoEfk3iL3+2djznE+u7QWHVKQYrkJi9Z8GyByMAN8deVjZzIv4tg0ENaifGW8JB3VL6YFp38hJq+BWUM2Bpv1RYymSkEmplkyS/qGDNyCAbc3QLXix2CRNVyjb6fQjI/73a+SC4WBbuWe5iTZUL7mRkK1ERiWaTe2sgFG8vooML+JrctmUNImJvHquQjVtno6mwDr1z6zwaz2qxS5KDbAOseC74/bFwpklBCwY3/DAWt1SrThF+JAlnvF3Z+8/h/w05FQphN2JLZx851gLx5E2dctRDd9oiW0d9y4UTPQL+GXZo8LYXa3KTUVpU6mvptpKvs/mBwyq6hDWAbRD758uCE4i7MMXhCufo0sYFKlJqyfEm9Sa4rQHTS+qQjmKAOf4s4KNx4R66+WWmue9avnen3VCFUir61gtGicBSxzSXZERtm8iXgOaj6Z1bm3QEoe3LNa7ZZlFFzlFM6zz6tPqHLd0Y78WXYa/RKirkYawb6+tBmcgJ9eWeJ7iMPuGTuTCG++qN6eL9CaMS8lYzQMnmJ8oKiLw8cwzx4jrYM1FE9p4eAmfnWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGkwVE5hanBtdGI1VVRzcUlPR2VFVHMxTk14UVBvaFE1dnZZakkwa2lucTVN?=
 =?utf-8?B?MC92MTlEVDZ5elZ6bityOG5Dc014SzNCbDJFaStwZkZ4U3ZlQWdPTFYvcnVM?=
 =?utf-8?B?TlM5eVZwVVRvWWgzaEFzSjBPWXVkbkFBcUR6OUpzOUtVTURyZHhRY3VIbEFC?=
 =?utf-8?B?dFdMRy9XdVI2YmthNU5PZUVpb25PbC9SdlkxTFNjTHY2ZXlSalltMFB1RFI2?=
 =?utf-8?B?WUpMUTd0SVBPZURFNDBVWmhMRGRxNjRxQnA5SVJJaVZQSnhBOVhBVnBSeGFS?=
 =?utf-8?B?WVVBQzI2QUo4ZmR3dG5vWDdCMitPVXZaNEtUeURLYmRZdHdIc3NCaTkrWFVq?=
 =?utf-8?B?VHBLak13YllkZzd0SnE4bmxTZ1B1b2FFM29ZRy9EQURhZmN5Mng2Tlc5eFc2?=
 =?utf-8?B?SCtIZVNJQ0h5QkhRVlA0Sy9tZTdreWZjKzU4cHVTR3R3Um4vRmYrdVM4SDBm?=
 =?utf-8?B?MGk1KzlZWVU4cFZ5VHVvcXN6bWhyQW1GQnkvRnV5c0N5bWp1Nkh5Ni8ydTEw?=
 =?utf-8?B?dHoyWm1NVTlwL1cyTGpYa1dwcEtQQ0ZPOFFCL21qRFg5MnpZN0tzSnh1L2Ew?=
 =?utf-8?B?K2M0aTl2NldTUHUzRU15Z2pxeXdrUE9tbUROdmxBOVRReWlMZnRKbnNTRzd1?=
 =?utf-8?B?UHk5aW11U0ljVkhDeG9zdnd2NHNyUVpjcE9XT0Z2N1Zyb3ljSklIemU5UkdJ?=
 =?utf-8?B?N21CVWZHZ2lVWHdRVnRnSUdNTlRSN1dpM01xYms3RzJFR0VnT2Vxek5NcDUw?=
 =?utf-8?B?NTFpUklKRmFKSW9Jdms4MnlqTE1pRTA2WmR1OW93UXAzYUM3K2hEYisxL0Nz?=
 =?utf-8?B?ZEg3N2tFcHdRaXdDYzZNR3AxM1JLRVpkRUNJSVQ4VlJJazEza2R4a0cxZGE5?=
 =?utf-8?B?SU9sMWxFSFJ2NEZXYmhESnkwejFiRWFQTlFWaEJZRmYzMDFBVXh1d3JXNVBZ?=
 =?utf-8?B?RmtWakltTXI3UFUxRGpLU1BCS1ZjeTJvbkdhTXFPSnFZcDlSbFV3VTlveFpP?=
 =?utf-8?B?R1N2WnNkSmlicUFFNldGdHF3UnRoL3llMkttWllZV1JQUmp5MDg5TlRNMUNB?=
 =?utf-8?B?Wk1DdUlpQlNGK3JHTDhmdWphS2dPOG4zQ3hsRzVNeUZEYzFVRDRsWVNzcTI0?=
 =?utf-8?B?eUZmU3FvMDErTGY1RzVZZUd6TTBQOTBZeEdvSkx5Q3hwR0QyeWxEVGRtSVg1?=
 =?utf-8?B?cnJKb3ptYytrYmdOSlhsOXFnZERsY3dkNEZjZ1pLZnczVTdZd05QNTNYd0dJ?=
 =?utf-8?B?eTVpdWd5QmFkUXU0RFdvUXpIelpyTEhrTDhtcjkwU1ZRQVNUZnZCNkhJYUg4?=
 =?utf-8?B?dHZPNmpNejFmNWsvbnN5T0NYbWEzWFBHeFYrWjhxMVdqN21nSEduQWtwQmdB?=
 =?utf-8?B?bkMzUTJNR0pSalF0dGFhbE52TzlwWm5zcFlSc0kwMjIrNmtsWDkrT1NpcHFr?=
 =?utf-8?B?MHl4bTRuK2FxYm5vNDFrUEZKbEE4b25RL3pyakttS2ZjN1VqY0pjUnF1bS9K?=
 =?utf-8?B?SEJqS0d0eDJtYkliU0M2bElJNWI0bUVra0pITWdZQ2pKSlFCQVR4L1B3M3pW?=
 =?utf-8?B?dWpPbHNPSjlUUS9qOEdFY0pzclRYejBoQ2ZtWWh2SEpXcU9aRjNaWG9CVkJ3?=
 =?utf-8?B?d0R6NFMrbngxaUE1U0ZOSUJUSmF0YnZBc0ZUK0NEK3hwMTBLOUpDYjdRZEVv?=
 =?utf-8?B?bnUvM3dOd1VacDV1ZG1HUGVWa0lnbVNjOHVTUXhsMmV5R01ieFBlZHBoeHlh?=
 =?utf-8?B?djdwTGFiZy9HYURWanpJVDJoTjRTb3o1Wlh5U09IRWhNWXNhM3h1bU4vWm5Z?=
 =?utf-8?B?S25xOWFIcmxOMzdsWUdJK0Y0KzF3QUlmN0liQ3VJaEtHNTkzYjFvaFlVaTB4?=
 =?utf-8?B?a1NYOUVhRXFTNXd2YUNzMmVHeVFPaEttOGdyb2oyRElIOW9qdVQwejFHSEht?=
 =?utf-8?B?WTNDMHhCdnVSZHkyWmlhWnRWaUY1UVVNdkJmbHVRTGd0a0RHYU5wb1o5OS9K?=
 =?utf-8?B?VUZlN1VaT0pOUWpKdm05cDEvUi9zcXo4aVR0S2tFN1pLZ3E1MXFlMjdTQnFQ?=
 =?utf-8?B?dzlVTGZLME9wU0hPcVJQOWxsWWpLU3JBenNoem9saUpMMER3L2Z5VkVNK2kx?=
 =?utf-8?B?UllpU0R0R3ExUm9OT3pPUEc5Uy91L3pjb3h6bVVCTW5vSHQ5RVBYcWx4ZTE5?=
 =?utf-8?B?QUtPMWloVDdKMlRRdUU2S2hPUWZxZ01Hek5sSGpJbllwUHlpMFl5MTIyTlBQ?=
 =?utf-8?B?SWJZU1FBbFdrZExPZUNDT3NNTEllN0JzK3EzZ21jYTJ2ZUJZZWZsSWpYMEYv?=
 =?utf-8?B?TFpaQkp1dW1CZU5NUFFyUmRFLzQzcWpSUldjNjhzb0FnWlZPYlg0Yk5ra09k?=
 =?utf-8?Q?7LZiFAQ+2chmqY7nBJGYPYnaHIE1Y787McDx1m11fnYwb?=
X-MS-Exchange-AntiSpam-MessageData-1: Vge1Um5fkm0LRw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c48ce97-d9cd-40a6-530b-08de9a1c959f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 11:54:29.4256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEMU+Yy28cOTdGM/k/9CQrCcnJkMm1OFwXb0Igd++bBzQ3cpPacb1aTGVpmJB1N9OW7aOZoiLhCrO0GKjRmchA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
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

