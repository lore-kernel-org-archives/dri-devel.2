Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66892CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C481F10E378;
	Mon, 25 May 2026 13:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gj0MOX/4";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91CDC10E37E
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNSwEO0mNoiA4LDC0hsa/ZUXIFCRFlLeiYEZ36KRcBx/SglA+qzuDBcvGiE/DgjXWpRLRzoLm6UY8i8andxpNbgh0RtJETYdHAQ9oqHgvJVwVTeNKJLW72Bno51TbYpLzZEzQIktRFxl1FzJ92dejXYivZbLPj/HMq7sB7OMgyyp/WqV4J4H9WQ7Xn49XLG6h3gtib3ai1M+qnFj78Dkk6RGK0HPXQjHGaLfGSpRg+GFG7tMh00VbCPTuENABuSSz9Kjq+B5wQqT1A6+IsNd7V0F7O5h5tS2dgVKP096L0DwxCu5yuTJBmh+GndvMNtf6+gCkNF9GKm5i/VJJE67UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uk9pFeENMzk1vGw5V2IC+se+8Qb55gcxR7EZeG33eac=;
 b=F/a5Zgz2yNXovZqwWjxs8iSUjZCPqBLtlc9yo6BVj6jakh7dPljl9fL8nq9yMmmFD3f/pufFOoG/p7mTYGDzapIA88m2ctHGCDd8gvmkeIlDawJ3dMdqWZbeUD3+u+IHg8lAoz6EbyQYD5+GRsWfPO+QhwxL1Cxehf+1P3AnO728l0WYKvU71mUCXXnQUjtp8QhuMr/5Nk/wgbRNBwBJb7XsBsvr3rvYmL/cvLpH/S1OcUPP+Iz8rXooyiGKGV72ZuAKgX+vS/T+DmQ1q7a3mCVxr26v60QTnrK84OkNsujzCavLp6Ns+kZFr2O4OoQGnWe+ql5WcWLLRz0E62EDcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk9pFeENMzk1vGw5V2IC+se+8Qb55gcxR7EZeG33eac=;
 b=Gj0MOX/4Raa+TcPB/uXdpiHuhtEXaufGhzgD7Pw2NE80dTF9gjK8jgCb610EV40WSeuCB7EkWCUq/2T+lcOJ0Fpftz/oDmuQP0u4H4hwacc6G2Zt0Kuk+cAiPY5VGb7d0aJ+SRu0MhriHr7mdoo+pK6SXAnqYsp8Bpqm/lqr6MDsCMcQK8jAn2lyDExezMftlcop3yFKsPeeMhwFbrfX6kkdZUyJyslRbE7g96BPB732wWHPfAmFEIg9fal8/rAHiJyjX7dcLQK6P9HxBolxm1xJVRWUmsq6FwY8GkcTnDxbsldfb70I11iVOk8XBRTC7LBj2Y+6QFvSZNgK9Z3GEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:58:20 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:58:20 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 25 May 2026 22:57:27 +0900
Subject: [PATCH v5 09/22] gpu: nova-core: vbios: keep PmuLookupTable local
 in setup_falcon_data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-fix-vbios-v5-9-e5e455251537@nvidia.com>
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
In-Reply-To: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
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
X-ClientProxiedBy: TYWPR01CA0049.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::20) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8aacb0-9066-435e-7a13-08deba65ad94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: Mj3UaKSygIS6d8RVnVc7VLD31XnABMQdn/+Arfgr+jnWvrRv8X+GILcW7I4fzSOc8Q36/MvNfEMnIlt4AOa2+Laul2XFw0WjOlCz8WVFvcdjNAnsAS89VgYve4LDPdhNvv8MHWtH5bmjqwhc3/cqTERk61MCmCBz8r+O6j71IiMM6af8LzCljXA9oeGJeMsS4fue71ViLZCm/ZEt2uAb7uw8YovDJgLiwmnO4NcJPUWXW5oDs9u7+WD8Q3Hb6WVHJfiggDB/4Kt6sHlWLqXeMgjlqEYgE+ub4A6mCOTprkRWbKRdVff7bfVVmLdcLASjrD7q7oP7fsQuDO7Dntl3KnHKavr82uw3FEpzuCWawXWu00YAxdMJWVTqdCQEJKd847yD2rbFi1su0BznEKPVHRjexCfk0RBJ59+6vflYd1RJfy+1/2pmSzU8q+jbAZLb7gXt6bV8x2OwlVvYi0ctUdefsFtB5exTQDh5yWSzYy6OqcbxH4TbP/rfk6FehAF49uNfk/QHOr1HaO/v3Pnr4PSv2rbH0neqJMlVnLaYkRlwJT0xdKenNN1MOegOyhYRIn/QdMuFZboxTgmkbu3AuqMH/ZV4uzISliL3zxPL4+Mt5Xrps3Yg2vqruWayn8Dc1MkE95k2G4wrIpaePKBG3r/eMD6X6RX+EtvKwagUedwZu5ac96h23XzlbXw0b7Ap
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkwvQkltdmhoSnhmYXhKMTE0M2dncWgyelViMlJZMXc4MEhONkJLdXdDNjFR?=
 =?utf-8?B?T1ErekRJdUxxWklDSFhkVnh0WHkvMUdZamdobmFXTGtNZG10Y0w1VFpjZk5G?=
 =?utf-8?B?ZmQwMUZaNmtGdHNCRXpwLytRWk1MK2o3SkV2VCtNSkxOQU5DVi8wZlhoK041?=
 =?utf-8?B?eDI0VGczY0ZPZ1RmWm91aG5EQkljNzZLUzZvU3ZzSEZMTUhManJoOFhNTWJ3?=
 =?utf-8?B?dDJMNC9QdjBESXJiZnFBa1hIRHhNT1pVZXlkanlTUVhVS09GbnNxL1RTMk4v?=
 =?utf-8?B?eFdXL0I5VG5lWC85d2VUdGhrL2psM25lMmNTcHFmMVZwQW9FVUsyNHI1K0dZ?=
 =?utf-8?B?Wm5HZm1XOFZaZlpWcjdNaTh0Z0JydGcvRzYyOFZvUklzdTdWNjJ1RWJ5SlZl?=
 =?utf-8?B?ajM4Z1c2Yy9vZGhHLzQ4bjBWSTYxVmdTL280cUFNZGZrMUpUSjNWVHBsREZY?=
 =?utf-8?B?bG1keEdCWGRHZUFxN0ZWK3gvSHA5RDVoUEJKeE0yNmtxUWpqMWhNZkgxR0ha?=
 =?utf-8?B?cC9iUFRRWGpDcUp0V0UxVDdhNWR6SllpbEllbDRkWDR3YmdPZWJiRnl5dFJV?=
 =?utf-8?B?MjVlaHFyeWxHMnZOOFdhLzFZd2VQMHFFOGpuRUVjS3BxUWFkSFg1MlZzbllQ?=
 =?utf-8?B?UUc3alNyc1FvUU5sMWhnMFVYS1IrQjJobXYrcms1ZFlsSE9pNGRveE5iTWtJ?=
 =?utf-8?B?UzQwamp4d2ZsVldEcy9wUkNBZm9JeXJyM1l0MkQ1MDE0QTZPYVlkMjFvbE91?=
 =?utf-8?B?M0lqRVUxT0pyTE9KUkhJWm54VlErVVF4Y3VHMy90QmFCdjR6eU1WeDBtWVht?=
 =?utf-8?B?aFlJR1NjMjV0L1pNWGx5bTNqaUc3UkZObXZ5aWE4TW1rSnRWZm9NRVpIT2ZQ?=
 =?utf-8?B?NXpnK2FzdVhwT1JJZi94T3pWTUtFSnNLdjk3dmE0Uzh1Rk5sSnp2a2pXcll2?=
 =?utf-8?B?S0gzcE1TVlBhVm04WkJYRHVVS09mbk53UjArWDA2ZzlVazdlKzZoK3VMOVpO?=
 =?utf-8?B?R0trWmxybW93VjNFN1U3TURmZUZCSnpnWjlZRlR4RHNFRnAxZTNsRjRRVUJo?=
 =?utf-8?B?cGhHMjRLaFAyRzhqRFV2ZEtpMkkrQ0dQQ3I1bnJTYlhQRC82RDdxQTkxOC94?=
 =?utf-8?B?c1FrMzhsMXY1SU9DeFRlMUVwQzdLZjQ3T0dSK1d1WkNNd2JVTUxSbU9yRXFk?=
 =?utf-8?B?akwyTEhKbStYTnQ3T1RoQlR6UTA1RzZXU2I4WEovQW51dzZsdWk4OS9VYThU?=
 =?utf-8?B?TlhUakEvSWFJbEsvNFZzT3M0Mk5MRXFHOHQ5eHRUYkV3U1pCYm0vL0FOdmNH?=
 =?utf-8?B?OGFBbUlYcWJmL2lmRitOek9PUXl1dkhFKzhRZURNaGk0cVE0emZxYU5tRTdN?=
 =?utf-8?B?OVdzckM5cGYyWFVqajY2UjJHSHZXeWR2bFBLd0lPVjMrNm1zOVF1eU56VGZr?=
 =?utf-8?B?eXNvRnlNenhQYXNoYjNmcjJJN1MrR2NmZ0NYYmtOMVVUOFFpMk83L0tKWi9q?=
 =?utf-8?B?c1NXQ0hnOXlEeFNEbDNiNGFJN2FLUVI4S21YS3Z6M1IwR2pCS2xEcFVia0hH?=
 =?utf-8?B?Wk8rTzh2TFdaRGxmdnh6NTRORk0zRmRQb1FBSmZBcXNkQ1cxUDQ4a2tjZ3JD?=
 =?utf-8?B?a2JTTEx2RXFMeTJ3RGxzR0ZjTjJ3bDJWZmY2dU43YVJNaXgrNS9oTGhUZmRZ?=
 =?utf-8?B?cWJrZm5QYmxUbUZNOTFiYnJqcytRZmRONldRQzdpMDh3L2JpUnJ6TWZjcFZI?=
 =?utf-8?B?YmQvVU1Lb0hsR3FBTE1mQ0I3SHQxTk5HdnVWcGlZZVpaNjhJTFZZWnBGTGV4?=
 =?utf-8?B?T1grdWRoS1VoYTBTV2RnQzkrdHF6MVN5SWE4dEtnbjZtOExVV1k1WEs3dlY1?=
 =?utf-8?B?MUNTL1ltdXJod0FCM0hTWUJLWlNGTUtadTZCcllJMWRNUWpwYUl1Q0QwVkpE?=
 =?utf-8?B?K055QUZlQlYraWk3c0FycVZtcUpGYlNkM0FvNjJVWnhtUFFsUU5SZFM4dHdm?=
 =?utf-8?B?RkJUT2JRTTZKVEVWcVV0eTJ2QlJCcWpGTWoyOXRXdXF1NFRabmtiTEphcUg4?=
 =?utf-8?B?Y0xYVlJKWFhPSG1qK3BiZDJzRlVRMmVtcDJpcnM1ZzdDdDFZWXE0bDQzdlRM?=
 =?utf-8?B?TDF1UmxPS01zRHMxUFdRUGk2UmpSeXR0b1gyWk1TV1p2ckhTbGlhYkFseDMz?=
 =?utf-8?B?OURaMjM1VWZnWVlqc08wVEU2Q01yNW1wZkVrS2haSG44V1drSkRjSEFOY3py?=
 =?utf-8?B?VERMZWw0NlR6eFZOK05GZituNDB1T1lBb1NvSWRLTERlY2k4dE5zclFyZWpr?=
 =?utf-8?B?YkdLZzAySUcxalg3cm5vOTJyTHZMdWM1WlptekJHMWhBOUJoWEQ4UXBYcTVh?=
 =?utf-8?Q?0axHMQD4byXJo3qfAejWW+6H7hjqxHdfEZDyA/It+IGIy?=
X-MS-Exchange-AntiSpam-MessageData-1: qoEqU6GxoQROmA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8aacb0-9066-435e-7a13-08deba65ad94
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:58:20.1317 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZ+6Z7ODybxD6Euq8pBtYdxKTUzWeCRxWgIc7lnxjNI52Xna5rrHA5Y62LewQxyDzzNNQHGoZ2RsVi5PRn07Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
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

