Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258C3F9D0C4
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 11:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AD9510E5C7;
	Tue, 14 Apr 2026 11:54:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="X7dQng+C";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010035.outbound.protection.outlook.com
 [40.93.198.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 282B510E5C7
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 11:54:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSnnVLuQgMHTyCAKKUaJqwjEVR3XhpEncgdryDTEeDlsKTaStt7DmgEGlhCzxbvTrJJtyKicLOFS7r+ri5iyg2rPu9Hi6Nls48/jXKG5otDSxtD5EEttKA951tdJQWoEKRACSkuTF5cZEkDCt18fAn0YnttuAAJwjrmXNC+rIZJLCr8legg5O2qUBjxWaRtFxZKNlQ2CnGUlvlbJ7KnM9TQo36IR0w7+869i7Q12xx/+YwzvhiRbR9nAi79cAoIpDZeb+zfx6kxWFHq5KvlFGRruAH0+1Bn9f1xMa+JhqKoaRMpmAcd2PEi6fAxcMcrJT06FVdbZlUGuCY43qhMhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQozavHaE6+j9EIxyMMT208iJxGk366tiMnKj2Zm+p8=;
 b=eOxlPkAR958y2sC+JCzpFFBNowPFBZTHis3A4Yr/Syg507lZk9FAP7y0bYxTcGYiX+Kdp+uz+rvWF9+HQ4AnhQVCieh+mMfq2uHZpG/qOT4KpNhWnfqvWHNr0fuLlz/k8qjJ8oystUwbj2i/5HdAjJcx4+IGAFyn21+3oo5MNheiitizuBAELgg+zJ0VvXpht4mS6p368oQdYkjbO7BRHQ4c6cwJgQAMuqwtTyykDJM3gx+0b1UeGBvUiJJU4M98MD1Fx7wMzjXLutrleySzbI623Gw19Q6UX0UBhLfgslcwlV/xM6IVrny+R3LYW6BpCYMR+aF6KoyLX6THzRHv1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQozavHaE6+j9EIxyMMT208iJxGk366tiMnKj2Zm+p8=;
 b=X7dQng+C3qqLeU79ktZNjReWgUW/4B1j6DrVW0JkYEBUonr0t1XIPRz1QF8NVKejV0P95I2OT9+gbS/DXS0tUf1JX/TeMl5y3j6R3TM+s5q1kZm4zYFfXFASsu6ejsINFs1FLRbD3J8DDWZ+aaMFTEXKBW7rj6zRCXmjg8fvR725KYkYkORsTdBFpAMzDxxjAHsBUDDAyOKnpme+9Rg70eUZ9b28370kpk/BYDHgqomMotC6iedG0jC+fsFaEDeFG/sDskljGDmzNOkEdS2v7bq5OpjpuSodENH/lihyyTyLqD9uSzaPd4PVXRwSWPXxEQfunSNr2331bgJ3ycHLkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Tue, 14 Apr
 2026 11:54:44 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 11:54:44 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 14 Apr 2026 20:54:10 +0900
Subject: [PATCH v2 07/11] gpu: nova-core: vbios: keep PmuLookupTable local
 in setup_falcon_data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-fix-vbios-v2-7-705d30d16bba@nvidia.com>
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
X-ClientProxiedBy: DM6PR21CA0029.namprd21.prod.outlook.com
 (2603:10b6:5:174::39) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 743b31f4-c505-4504-f774-08de9a1c9e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: mbwWVt6nFvQ5yWX50yewuZINNIKKi5x8q06eZXMZOGTGGLAUOzUUcFZuSK7WABvKEsHc0CLjmK+kGQb40UYytHWHmT/+0xuQMjgUqO2BT/rIIYZ3mZbm8P5EFQCy7mM+btJElN1qfqUCRrsQFXQxitLW2iKDsReqQ9sycs3jTbUt9HdzT4NkUmxGSog1HjabBrRyy8dri2z5nMpaYv2Z94It5gKTdE5XnZ+J4cFY8kOhTadAAu7eagSg9Ei+jW4P64zqNN3wxTwHVs4iurqrblmbVAwS1pGBMCYpaPCiuDRAWsgLFJYjmrePYxG/onVlPBDXfaq9FWAGaR5pGnYtRDnNsUYwNlEPhKPhCAJeI3SlVr/cX39CN0iJgnlRDU7c1+wHIZJVIHjLC+e8+1wL9fVRKadRq67g6ZVCvebRvWs0M3KrsMmgl+7/G0WQcpZ0I4LZz2ztDBXKM86C8eiKz1XurwfidaoZFK0kA+rO91ig25hE9TRwFpiy+oELQcHbAF1TGaGIFyHS+JPoi5yheJpr4Km2R3M7sqls4pG1Yklx3tzLEgeoxjoKhSk+SXk1JRIeAyCzL/g9ihxnU9qlbhOeRJ45lCRdfTnaZQrOlSC9Wv9tSiT8W+cSCj09JAbpR6FIliRofPTJCB7HZZcDZGPogiTbvLRwygAhCeUwXuHo0ogZPnVfMwtvP7RrYl+CU6Cva/H7cCv2ohpko+Mo4sPOV761iDggC/lmpnA+3YE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T25tUlpwR293TWJIWS9haGhmQ1d6eUkySDA1dkpweVZ6c0s0UTIrVzEwT0hk?=
 =?utf-8?B?allZczRJNFlPbm9NTUtnbXJ6WWk1OTJBN2pRZ0tFMWdFRU1rdGExa3JKeWpG?=
 =?utf-8?B?alZPYlJCZDM5ODU5V1JaYW9EQTArY1pCTFpISzVFeU9WdFI2L25lOGpSYTk5?=
 =?utf-8?B?MlJqaHREYTZlRmEweGl6d1d0MDVoSFoySkZOWHFVZWlRVWxZTnFOOVNvczFv?=
 =?utf-8?B?eUVBWUk4TDFVMyttR1NOejExY0FKdDFwZWFLZ2tLcXVYYVNkVWM2cjBEa2tE?=
 =?utf-8?B?RGVqQkl4eVRXQjR0anNpOVVrVDlkVktZdVpKQVhSTHZCVUN3d0tudnJjMUJC?=
 =?utf-8?B?aWxjeDFDNXJDNTluaDZ6Z2lPUU5lQ0FJdjhENzFlUS9DTjZPOUJncjExeDRw?=
 =?utf-8?B?elR5RUNxamo1NUNUL0pvMzB3ek0xaXpiMVF2V1l1eXdhQ0R4NFptZlF3VFhU?=
 =?utf-8?B?U2VLaFNOMkE0NFQrSUFRSExaZEc2THFmTHY5dURkWUNoa3ZWOStNUnp4Vkl4?=
 =?utf-8?B?THF6amFwVXR1WndaQm9KVVdmMjdHb1VLeEE1NFZRMnpCN3NtYWNmRUx2RXM5?=
 =?utf-8?B?UHZWeEx6SzBoeTYrZ0NvTTBHakxaVkJlQWVtMTI5RVR5Mlpha002YVcydmVj?=
 =?utf-8?B?UVNUdVNwY0pXbTEvdWdTa2ZQSGI0c1lYSlNHeDdrNjlSYXlZWjVpd3VxcVBI?=
 =?utf-8?B?TUx5clN4djNiQjRWMTZiOU9MaGptNjQ1MnFqNVhJZUtENWtPdFZBM3RXK0tX?=
 =?utf-8?B?V3ozQUYzeVVVbW04MW9vSENQblBhZTI5dGt0NXVLQlhCQlZVS3ZjaDNNYUhx?=
 =?utf-8?B?aFk5SFlrMmNWTEtoZU5ZbjVFQUJnOVVCMWtFcExJL0RoL2hiWHZSaUFuTXBN?=
 =?utf-8?B?QkpzL1RwV3VxQ2pYRStOY1N5REJpQzk2TFh0b2NJWU1lakprNWw5TExvaVll?=
 =?utf-8?B?UWk5akRRMG4wT0tIN29nbjZPZnR4SlJWSjF5Tzl6U3JNaXk0OTJmbjNGQnM1?=
 =?utf-8?B?Y0cwMUJEU2lQb1NOeHVWM09zR1lKUnlnek40UzBrVnFhMU02TUh3ZE9PelZX?=
 =?utf-8?B?UFhLcitiL1hIWmV2bHpKUnNDSHlWVHJvamI5S3ZMeGF4U0xtM051UGNkalcv?=
 =?utf-8?B?ZUtKVGZ4akFnRFE5aTc5Y3dTbyt2L0Evdm10L1JPbnIyaEFnYkxUK3UweXRq?=
 =?utf-8?B?YmovdlFYL0pUQm96eEN1L1p6WnplY3hpQjg2V0xld3UwWmt3VXNET3RIcXBq?=
 =?utf-8?B?N01QcWlPREtDcnFzYzZEZkFZQmE3RzZnTll0dFlZV3FQWWpMeEZLUFZyZHlr?=
 =?utf-8?B?WG1LSkhvaENSSnZBWkZDL0t2Q1NvUENBM2xnMDkyVGpnc0ZpNzhOVmtMOWIw?=
 =?utf-8?B?WXN6Umxyc01RNDE2RHFBVHJDMjM4V2xuVStwVXhNUi8wVXdhUVROV2UwME9a?=
 =?utf-8?B?Yk9VRXlBQVFtRUNrcURDRWxzNmUrVVBMc3c3QlVraE8xN2k0S3d2cUwva0hO?=
 =?utf-8?B?VUhrRkRTVENzTEdHL3dhNTNMQWlyM0VOVFpuQk5NMHl5UmNIWUkyR3JBVVRl?=
 =?utf-8?B?cDIvTWRBMlVycWZoSEt1Mk1XRWxORENOZUVKU0piQ3hTZFA0ODBhWlpQOFBK?=
 =?utf-8?B?L0xsZW5sa3BsZjBwcUVlOG0xUWhXNEVHRzlJeTVSaW54dHN3d2R4ZHhrTVA4?=
 =?utf-8?B?aEZ1TEVIVGlZUnNMRk02OFdEUHFZdFBwN3MxQ3pMazRLcFpxRTJzbElmaDc4?=
 =?utf-8?B?ZWVsWFlSUG83Tm1BMkw1NUhSVi9HMmltZGh6ZVVvK2F6V3F6NVZWOWhwL3Z1?=
 =?utf-8?B?QXZRQ0pMcEFjdzBYNytxcUNBTmdZK0d2ZWYzRWZDQlJnVXVMV3l5WlBUZGw2?=
 =?utf-8?B?REdETVE0dzJNaHk2Mnd0eXl2My9DamNNVkNoWXUxVlV0bFpsL3owa21ydGFT?=
 =?utf-8?B?bXNnMmd3dVc1U0RILzJOUEZja2lSMFA4TURDMlkrczlwWVRac3VPZWl5d1R5?=
 =?utf-8?B?WlJwMVh1ekhhdThydnlyWEJkcUY4UjBmSEk5ditVaEM5TnVkSXlYbWhXMnc0?=
 =?utf-8?B?aExmc2tWcUtVcU1BYUI2WElEeVBaYlMxUVk3ODk3cVNoRmFHUVZTS3pUQXU5?=
 =?utf-8?B?OEFtU3Ira3RtSmV5UHR4akROdEhVSCtlRGVNYVJqZEo1c3JLMFFSRW4zVjBs?=
 =?utf-8?B?blgzR0g2Y1NQWkczaHlKcDhoNjljSE9idDg1WC8zekE3Wm5oMGxiblkxUGZz?=
 =?utf-8?B?emJmNzI0czVadys3Sm1WZUQvY1dMZzRlL05Xc2FXekg3M2xHYTE4OVBmZFVO?=
 =?utf-8?B?YUxSQXpXbllSUGFuenhpSytGQ2xhMFFEck51ZG9vb2lXemFDcDRRemJOak5x?=
 =?utf-8?Q?hjKiHW8GD8BpBQeuZIgrqiOEsm+AHWEgiw1HWYCpxW7NJ?=
X-MS-Exchange-AntiSpam-MessageData-1: yip1NYmlGTMd7A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743b31f4-c505-4504-f774-08de9a1c9e5f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 11:54:44.1263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSFez5JntYQOp364S/J40vjDHzZ7SMllG05lHcM0E4dkwqbJH1bNriiIdMG2dH7iWUA5B6NiJRiRPWTt/6gmzw==
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

This does not need to be stored, so we can remove it.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index d63af95eb642..01f65d50cbb3 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -256,7 +256,6 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
                 Ok(BiosImageType::FwSec) => {
                     let fwsec = FwSecBiosBuilder {
                         base: image,
-                        pmu_lookup_table: None,
                         falcon_ucode_offset: None,
                     };
                     if first_fwsec_image.is_none() {
@@ -630,8 +629,6 @@ struct FwSecBiosBuilder {
     /// Once FwSecBiosBuilder is constructed, the `falcon_ucode_offset` will be copied into a new
     /// [`FwSecBiosImage`].
     ///
-    /// The [`PmuLookupTable`] starts at the offset of the falcon data pointer.
-    pmu_lookup_table: Option<PmuLookupTable>,
     /// The offset of the Falcon ucode.
     falcon_ucode_offset: Option<usize>,
 }
@@ -931,24 +928,14 @@ fn setup_falcon_data(
             offset -= first_fwsec.base.data.len();
         }
 
-        if pmu_in_first_fwsec {
-            self.pmu_lookup_table = Some(PmuLookupTable::new(
-                &self.base.dev,
-                &first_fwsec.base.data[offset..],
-            )?);
+        let pmu_lookup_data = if pmu_in_first_fwsec {
+            &first_fwsec.base.data[offset..]
         } else {
-            self.pmu_lookup_table = Some(PmuLookupTable::new(
-                &self.base.dev,
-                &self.base.data[offset..],
-            )?);
-        }
+            self.base.data.get(offset..).ok_or(EINVAL)?
+        };
+        let pmu_lookup_table = PmuLookupTable::new(&self.base.dev, pmu_lookup_data)?;
 
-        match self
-            .pmu_lookup_table
-            .as_ref()
-            .ok_or(EINVAL)?
-            .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
-        {
+        match pmu_lookup_table.find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD) {
             Ok(entry) => {
                 self.falcon_ucode_offset = Some(
                     usize::from_safe_cast(entry.data)

-- 
2.53.0

