Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D68CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 02:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72FBA10EA25;
	Tue, 19 May 2026 02:56:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="g6Gz9yCN";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011064.outbound.protection.outlook.com [52.101.57.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB1310EA25
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 02:56:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0go4d9mr49CT7hQ3TAXsIHb66yaV/2j2ZUOc0D9JkAK50jLBXxcg6NG5Anozf4XK8fojiyd6/mNRd+MdTfcNoVjV1k70hhxfnVB1+dlrIH1cgX7+9IVHYC8sT6gIPNO4uuqMoQXbZ8jDkGiDBNj3FK/p+ofYlY48HWaSuzAWyEC70Y3DQNq/fJ9SFIlwjJOy9fBdbRJ0wKR2iUA1t8D5M0obQZO1HP3bCwlQhYW3gF8ZgMlaOkHaMC3RQCdz7AYW78wRHEF/xc0SLFF8W60CK/A05jR+kF1hzTTFXrmTFFysBf7FuabcFruTdZj6/iXwU86VludHew6YAu7dhNMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg+YpNzAD0rnje49VO14vQTgb7eG1CmsBGyK8xVjDnw=;
 b=U/TMP5NjexLujt+hZc+EMsY8YeR/ZNP0LKgK+t8qOY7ODitPwCBIWMn/zZ4nH5KQnqUuFUK4y3LN+yPDGLdQezlTX0AOLp2Jj/qbyH43H+3tT/uGLlrFTEdLvGeU4haNJzJcb/8arp48ModtRrz+68lhKslrTGBHET0xMNAR5xICh5IEm+FObK99wD+KGFXYFF84nfq3cRgoUkcdkicrYVeZYuPOaZIfy9XB5DlKGfdYhsn6ihpIAxKkVz9SBvE6kwGHWTM/xFp7eIfnN6jM2WjaCePf5zUVOqvh3neuj7gS+/82FTS9JAeiWa7W7kUfqFwQLUJRyO+N/tIHYsLzvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mg+YpNzAD0rnje49VO14vQTgb7eG1CmsBGyK8xVjDnw=;
 b=g6Gz9yCNntNMcSZQzATFhhxTqIFPUmF7u0MaXYAnUlS4DVOcEprg8fGCzn+vIFaOPMz4Nk8CggCwmkR2EHKo058hG26znOnMtUQeUEXN3RUaJ/1Q8YfKth1PKc8IB62JtyqKi0+luR8bRlgMqNbrPnACRSvU8Ez8CimX+Bpc/TxHkR6GJErTNTZGyDQx+3C0EUZpTdje0z9r3JCMauWa+BW8//mG4RD88r/vcUrmpoqJVKgTOY1awxWgp2lWoqRYOKbHMpXiF1EUUQGjjHn5wvTbZgu2E8CX6GvpDgxpdAhK61lTnBS1QHRKGzIIrwowhqFr7JusmxqBycF+oQd1Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 02:56:27 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 02:56:27 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 19 May 2026 11:55:03 +0900
Subject: [PATCH v4 09/20] gpu: nova-core: vbios: keep PmuLookupTable local
 in setup_falcon_data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-vbios-v4-9-5d3f210c5602@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0124.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3bbbcb-eb55-45b4-5cc5-08deb5523882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: E0y/b2lKxeNwpyvbeNerqAAjuAzzyUbuRPchfDRS39LQb+cWQXXVbbeZaXTYfQtxJ/Kemw4btL+SQNoG/PF4+jIPLOQisDI38VEwhgphK4bXlUBWAhRSuru2wxNBOEF0fIBnMZT7/UKjynNNpIxRewKnb9EkK8rcYn8uH1/b8U/0fJ68ZmBRw24sugWZWJgemURm+nWomLvmNZC3Aa9dE+P//5Ir6giNz3p4oUAlapmkbJwXUIuf23NOVHqMr58WN9BH89Lkkr/7UmvWrQh6Avkf1UKJYdN4MWs/IGVSgJTqr8Cy4bwaGLFX1IgPy2a3SK+vRAWOBytBs5q4Hl1CHetR+n7qxZ6PACvhjmzqP5U7zpqSTkDnTUgODFBAz09bTUuzkrBJudNIeh49nyZp2DFEENHG8AmnhvmFJo3XHpgfeYiimZBZaLZYhamC2zFSpf6bg3bXn7EJJINHrI8C3NPsCLL2+0a6iA4YxgW9NyvDyJy2DEm3m6fBgWBf+w31HOPLy+KftmIxz/Kq4g14T7nWMyfn8L0g8Fm0NPDGSAAYMvxJgxD7jl+NCG6hvXiIBaNBnNsStkGlVdy5UWEElU2xx88ar7Fs/nO8TZWAotbmKmG8mwNvXl0/BJt3KlDUYNV7YkUDxiy1LzKFZZ0y8D7zfkpZDCoyhfnZG0tnNrHj008A1qcjNR4qgYI1H53J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHZ3d2RBVzk1VUZtbnI2VXRwRjlSMy8vd3lRZ1V3cFlIUHVZSVhuSHl3c0lh?=
 =?utf-8?B?SThINy9NbGJHWGNFdW9jSklYdldhZWVZaFBYZnB6S0o0U1dubTNYenpUa2tO?=
 =?utf-8?B?K05hWnZ3a0pzekJSVG0yYnh2WWxOUmxMOXNVSVd0Y2hSdmxjVkhaQVVId0ZW?=
 =?utf-8?B?UktHVVhKRklsTG9Fb2dtaUZDOHV6MGNUK1pvb21QMkJYeno1RnpWNzV6dXgw?=
 =?utf-8?B?cE9mQkxzYUtqUWpjVEU3eWlTYVJvL2dMbDJLZmRyVHYrNEtsRThCelV3S1du?=
 =?utf-8?B?RnQ0S21haVVzejVrdzRMK0ZkUzR4RWJNL1Q0Z3U2ekowaUQwMHBlVXE3Zmps?=
 =?utf-8?B?bjY4UC9KY1N3R005S2NTTGJRRGN5SDBBTktmc2VwTWw4Wm5HbStPZG81OWdw?=
 =?utf-8?B?Z2pqcXBnSWhRODgyekZiTTAzcXNPUnk0QjNJZFlwd2pTMWtRVjFiVm14OUNE?=
 =?utf-8?B?T3AzRTRzRjRiYVRzK3dvaXZqUFluMHU4dm5oVC9palNGY1hEc1JheDk3NzBQ?=
 =?utf-8?B?cXcreXFLaDV0TExFb0pUUEtFVTdueUlnQWJ5STRScWxRSWM4YitPNWdYVFUr?=
 =?utf-8?B?ZUVVSXFUSDNhRmVpdEV2MDVEM3l5VUIyOHRMUXo4YTlyMitKTjh4Qnp3dG5F?=
 =?utf-8?B?Si9mTW1BOGc0ZVRySUd2NmFuTm1jVkIySEVtcllYait3bk02elI4NitVZ1JN?=
 =?utf-8?B?NXdTTVVJTmNlZFQ4UXRkNlVXbTBnem9lVjFvMjZLUmtKV1FranF4aFN6UW4z?=
 =?utf-8?B?Q3UrdXQvd2p1NDI3L2lkZUNCd05DeWtndnVmNmoxaFIwd3BnQ0x2WkdVb1JB?=
 =?utf-8?B?RUYxVHloS1lnNUVFb0ZzUmo4WXBmVjlHOEhqVVo3THI0OGJmcFAzZFpjQWJh?=
 =?utf-8?B?T0I0clpaOTFabHFYQmpBNmFKWTI1dkdnZ05iRzFtNlptc1RQV1pRdVgyZlRW?=
 =?utf-8?B?NjdETnN3WmI4YjFJMHh5cmwzSXVWM0RzTklxcWhhUlhkSnpxcVdEVzlrRkp6?=
 =?utf-8?B?SnNHanYzOUtUbXFIMFdIY20xN0g1LzV1TGNCY1pDTmFBMUxnWitucE1yc1o1?=
 =?utf-8?B?cWxOVTdkb0EyMlNFZzN6ZExreG0xNEhUa016VUdmUUlST1A3eml4V3RsSW5h?=
 =?utf-8?B?K0JxaEhLZGY4QkhseTg3MkNiczZTVnVjM1BRR25QT3NhNzdDdXJqMi9NNkRU?=
 =?utf-8?B?alRMeERySlk1TnA3V25Ram5oWGRWb1RmbnFkSGRMeC9GUjVQeVBoNDVmMklp?=
 =?utf-8?B?TFVkQXB0N0dOTE9ZQzdycklNVTNaM0MrNHAxOTNqUGpEbkc2QU5KMjBqUTJF?=
 =?utf-8?B?WkRLQUZqZzFWSnJ3TGZIcmZFMGpwbi9Hbys3MTFiUkUwQnlmbVZLYW4wSDdT?=
 =?utf-8?B?RkpmZ1ZNVXR3WnlMZlQwQXQ4MjVOUVNtMlJnbkc3OHZqZTV4V2ZjZDFPUjRU?=
 =?utf-8?B?S0l1QVFPclRqck9oM1U0R1hteHZ1b1pCMG1aL3ZQRjJZTDh0U0loYnNXcVFT?=
 =?utf-8?B?cUcyem0wSDFKMjFLNEh6M3M2VFFnWWxOSWRDR0dIRnVGYVN2dFdNU3NBUnRL?=
 =?utf-8?B?NEh3Qnk1YUlNbEt3blI2akpHYTM0bmZIY0tITlZRcEtUd0hFQll2RGUxSnZl?=
 =?utf-8?B?S0xhTXlNZWhkQkJ1REloK3Y1dXZDK0FHVnlBajVZZEhKczYrVFVRdzNZdHpI?=
 =?utf-8?B?TUVYTlR3U0NLc1ZPclJlNHJIRlFSZ3lZN0ZRQXUvRWNEOERxaXFvdkswUytU?=
 =?utf-8?B?RkdiRjBVb0wzSFp0N0k4a2doQysxSEV3dEpMaUhsUW0yZnk4WE9aRGZMTUE0?=
 =?utf-8?B?QjBXbndqZ255RnhoNkFpdExBMmQ4Z2FLSktjVVBWMjExZUZiMGFGV3ZoM3Fy?=
 =?utf-8?B?WG1QODNRNyt4emR4M2FrbnVEZFlKemNGR0hpSFNmalZ5d21uTDNyTFpYMUFH?=
 =?utf-8?B?RE9Na3VQem1CNTA0YlNoYzZaUTAvV3IvakdJU3RoYWwxY3dGc0tuRGRIWnBS?=
 =?utf-8?B?THFsQkd4OFJEOHlUblFudjRzVXduMlYyZWNDSVpOdGZSeVBvQ2pGZU5DVncy?=
 =?utf-8?B?YVpabjdDVi9PdUV2bkxNOGJydVYwczNZcUN3dW5VTjMvQ0tzVkpyKzNTUzRX?=
 =?utf-8?B?TUhhbzIzc0ZOZWxMZzRrUHAvM25TcFQ1YXFaemJMUUo2RStwcVNPL3JqNVdB?=
 =?utf-8?B?K2x4MllrUXFIN2J6WHZZS2FvTGJTVEIyb3ZKZkZ3amx3eklqaG5CRHVEMkpH?=
 =?utf-8?B?b2xnTDdYbExramtKVzBaaUJ5bEZtUkpjeW5QRnM2T0lNcWU0TWtlbEJtcERl?=
 =?utf-8?B?TWpHRWhNdmpZY3ZwRXFGdldMNHlib1ZUQzBScXdVTXV5aXVuOFFVM0xST2lv?=
 =?utf-8?Q?pEHU30nO8BSdVRJ2CkVWMdUp361krOvdnx37ilnOPx1RU?=
X-MS-Exchange-AntiSpam-MessageData-1: ThRBC/fWwBWnvg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3bbbcb-eb55-45b4-5cc5-08deb5523882
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 02:56:27.4084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: el9lmCoXNHEgmh7RzZk6afrDP+bVcSAbNTxkthuF7ZFhojheUMn7Xyp8qGuzOLYAZB7yNaTToo93KAJXvbJyYw==
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

This does not need to be stored in `FwSecBiosBuilder` so we can remove
it from there, and just create and use it locally in
`setup_falcon_data`.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 8a0e16e6c9e8..cadc6dcffefb 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -338,7 +338,6 @@ pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
                 Ok(BiosImageType::FwSec) => {
                     let fwsec = FwSecBiosBuilder {
                         base: image,
-                        pmu_lookup_table: None,
                         falcon_ucode_offset: None,
                     };
                     if first_fwsec_image.is_none() {
@@ -711,8 +710,6 @@ struct FwSecBiosBuilder {
     /// Once FwSecBiosBuilder is constructed, the `falcon_ucode_offset` will be copied into a new
     /// [`FwSecBiosImage`].
     ///
-    /// The [`PmuLookupTable`] starts at the offset of the falcon data pointer.
-    pmu_lookup_table: Option<PmuLookupTable>,
     /// The offset of the Falcon ucode.
     falcon_ucode_offset: Option<usize>,
 }
@@ -1012,24 +1009,14 @@ fn setup_falcon_data(
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
2.54.0

