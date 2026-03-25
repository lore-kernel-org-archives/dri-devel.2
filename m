Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D53106B50F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9166410E89A;
	Wed, 25 Mar 2026 12:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y3Y/HjyM";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A04B210E867
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajsJFFfiqkU/DBlPV7slfBhz00G0CNHDJhEWnPDIP/g4Ol0Hjv8pfQ62uDbTCQun+FljFiKNlVxIx8GbNrpev6CcHjWhMIczaeI3R4pDaU+1qVkqb7Zu9ehcDo2NbZZM/IWMGJr//1lk9IXyxMB7C4w0gWr2v6smRUat5dnmjKVbKaoS77dUYwQrUfaVeq/dGAIgTcWmCUT4kVsDmOGoFySDR5zsWLNwsW4jq55eVUu76m7/jF7+es0qzDwJMrXzfYjQSn2Szz9+4AWWMxzfNWhOHvqyzIdj3+rO9Za29Oh/OnEOz0vHA1OBkwwsQf2jxoL5LGbvO0qaqr2FnmIKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLAhdwywARLzTGBT7yOEB9jmb0feAo5V6YfEP3s0E3Q=;
 b=fPeXp1yljpo6yCP5xwXrqiGdYWCyW+Z1lxgDHCogGCeHwRgAyEpEqOarprgryW44LgbkkpnPdWycmjgNdYMehPFqSnSxDGefW2zOP+t5V820okeM183mpp0sm5Ktzjsyq7zUPSfdJbjdCq/6WzluB95y+K9kZ2xDgW+zOvUrleU098L1qlXvAMKKQFEpAQ9hiHyY+Tm2OQXuFdUqPWmfwCTUZ767ziDR2D7FVsN1BoOVDRHcf0Eo3lywKtAwqnZfkUBUQPu14wQwqSsE0pO644eap3LZFoWxbbQ2re5+Y3LuK1ghD5PGvEd5hBW9FASa+lGUGRv+5OlEznAI14PZpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLAhdwywARLzTGBT7yOEB9jmb0feAo5V6YfEP3s0E3Q=;
 b=Y3Y/HjyM96unAnqtLVkFWyGp64rRoBkiSyMJj328y4ytPNFMrLv1pH8Gs53QwIrHYmU99TT/WzzDZJlLkpXJpT3XHZPczueW1TTNSCZh7ig7Rra9Am5Yk+yqY33ZLKeU9Ftc2aj19jnyJsUhK71+ES54atkzwzdf20Owb9fMzUPBqOtPhinHSqYDB4o1T8WXShvimwKRUpuqNiBJ7Odwbpg68OGubCvBnP9aEuLXOOWrm0enAS6N4W5d79rGvSiGguY6+zYnnNC0yrrFKxU6GCeo4m4vQeYXLSzV9eOM5iIhbIFSZlnHtgKWopwWwzNBLcfQN6eIlJzLFDy8WWHOsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:14:21 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 12:14:21 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 25 Mar 2026 21:13:46 +0900
Subject: [PATCH v3 8/9] gpu: nova-core: gsp: add CE fault method buffer
 size bindings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-rmcontrol-v3-8-f3101093484e@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0098.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: fa01e1a6-ccc0-47a1-933e-08de8a680bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ywM9Vw5PDn6KAd4zo5Xi+SoXz3KNmw7I9hlZ/yRcb7m/GTj67U+8V6jCd//5o06geBIGV0opO/uvRSXHX4l+IJiM6Xg1+shYLZmKykYXLYNf9p/683JfvwD/TYFl33HsVAHEgCPaAxz8SCTuWeLNtm6atnLbiDgmYBdtHOAJ2SzsyjMNunFL9cnFxKczo/LDmsVOcJNzrAFbZBpmtMGGAI/hvNqQdTwisOxl+qvrMM3PavpzrjmT7nXf6pAWWY54PUkPdnC2SWuzZlUng4yIjPVF5Buc8qX3FsKC91WHRzVPVQUIUNDY+r4bwRKOJvnIavQt6ytplnUuFOHu9YQScyR2C+hDvBdpK2oRX321oI2plOoarWZggSVxm5EFQeAjcwPjxqq8U6zFKEtMSzOVAZ4TlhJgUF60t712Hu5gqXQ9/FXctew+3R08j/DPLlAdvOu2gQ80Z7PAu+RQVsvn+XPA4pglwi6eHV8L7kQ8zP2wq4Lp1yRw0cCNvc3w2Cx5liB4PUsCSFtWoNLQmPDWBtNCfktM4GHaQkL/oyd4vVGMusSUGHrgxRHs87WI7N+xGa0WpxDZEvdU1AZY54JgiOJHILuMb6JMk3h03SduIfmmHLVblrFev0LgkjlRxWsny9t+G8XvhlA+0VQBY7f0Bf4V3xEzABlF2Ben2fQaZExIdYMIY56wGq5rgfxYNszsIaT39i9olJUS/1j5H55wcWHptcAcr/sSSy0qADvI8vw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXpjbExOdU5vMlhGM05IS1R1NEFCdkw4MVAyRXE4YmlwYlU4MzBaWWVUSmEv?=
 =?utf-8?B?OTVmWVpCNHQ3bk5PdmloQ1BJVGVaL2JqT3ZVbEhTUk0vd1IxQ3ptQUMveVFi?=
 =?utf-8?B?bjg5c0Z0S1Z0VGhyRm5wMjVlZ0JYTTd1YjFLY2tUdzVwK1dkV0VGbDFmUG1S?=
 =?utf-8?B?S1BZYzAvVFh3Q3EwUDVHdXVCa05BbklHd3N1OHZQb1BDQThqQTJRcExiNG94?=
 =?utf-8?B?TjVWNlpXSHZrVGJtdlR2bFdHSVN5UkxqMVRMdkw1a1IzRkxrK1NMWjkvV2xZ?=
 =?utf-8?B?ZE1Kb3BKUnpNSjBBb0tUNW45bTdOK2VrOThhVmRSSDFGK2JrZVBvMzNyb055?=
 =?utf-8?B?c28rNXNpZ21HYWJ3blp0dzFwdFA5V2p3WTYvRkNSYjd2dzJEbnQrTENHcDRh?=
 =?utf-8?B?UnBBYklmb25MV3lZS1pjdVBpbGsyOFhDVWtIMCtjTmtwU2ZoR1FyV2E3K2lY?=
 =?utf-8?B?WjRxclhRSitLM2V1YW5yZTF3WkxQc00vbW5aQ1RzQ3pNMTlsQ3BGSVdGZ1hK?=
 =?utf-8?B?eS9Renc5Tm4yMlVQNTdSNGFsdGxNY1A4RlRsOXNCei9vRGl5bmQ4MWJyWFRs?=
 =?utf-8?B?ZXNCcUFEOE1OSzdpWFZWSHZjSk5HMHh6b3ZoKzVQRTV4Nk5oNEhTR1llS2Yy?=
 =?utf-8?B?Smw4ZG82M3NmdEV5bjJ3VGxjRHNBclUwaHBaK1NJWDM5OFhtYnppS1YxanhU?=
 =?utf-8?B?WkZwR3BHb2dQUThtalN1dkJBdHdzVk9UQ1Fjd0JnV1FUTUoxL3JKMmpHY1Nw?=
 =?utf-8?B?Y1BuSGlyTzhkbDNPV1YyMDNsMGhBREtzNUxFQnFqY0VXWS9LNXFzb0EydXE3?=
 =?utf-8?B?NXZUcW5KS0x1bTJIVFlqSERDSGxHUHVIQ0NWYlFlTHRacjN0WUpWSVhFREdB?=
 =?utf-8?B?bFFTY2Y3T3BudHdoeG5qTGR1TmUwTCtQR255aituTjRQdjJyYmhEMVRpWkR3?=
 =?utf-8?B?QkNtRlVMbHF6K21MeDVzWEc4Y1ZyV2NOL3NRQVBBWUdmbkUzN1FMVkF0VUtl?=
 =?utf-8?B?OG5KZnBGcW5zcEpiVzlvaGhUaGZaU2t5TUFnMFpFWFhiOWlBc2JWbElNNFkw?=
 =?utf-8?B?eWhyY0pBR3RUQncyWnZpaTlEOVpQKzlxbUMraEhjR0hlOWVRSFQxUCtGay9i?=
 =?utf-8?B?NXluWmZRakNrVjNLOGtOYzg0cnlaL0EwMWFPbGFTMlpHRmhzOEh2MEM2ZWR5?=
 =?utf-8?B?aS9nZ1M2Mk42NWY3dGlWWDJPUUNoRUdsQXQzZnVzejZqT1o4ZVlRRXhCOWVX?=
 =?utf-8?B?ajlTM0tUNklyK1gvNWh2cFlwNDE5TEZMNVQ2YVdjMU0weldCLy8vL2dsYVY0?=
 =?utf-8?B?Qk1JcUdiS1BxMHh1Q3ZHdzVCOUVaLzduWWx2M2E5c2E5b1R2MlorK1hqYklr?=
 =?utf-8?B?cldWVlJXb1RpUUUybmFPbmtEWHZxNXhuN0VhMGRIVFJqNjRXdmlZVnR0YXdC?=
 =?utf-8?B?OE4xOU04WUNGZG1qVk5Ga2MzMUk5WEpHMXcyQ1owVjlUUlpWZHRVcE4yb2Ru?=
 =?utf-8?B?OXVTZU1FRzAvUk9hbm4xcDRTZy85MEtBV1JGa083bVNRZ0pYaDViNlNvcEJJ?=
 =?utf-8?B?Q0xoSmxJOFF2SEYzTTJTa2NEaVdvRmtMU2NEWlEwOEY1WnJaaDFWTnhZUk9w?=
 =?utf-8?B?dk5idjM1bWUwWG5VdlMxdGFJcisyOVN2WTd5Q0lOK3c3WGVRRlBZbnZOQVRy?=
 =?utf-8?B?cHorK3VzWDdCbWdieXlKTUdTTSt5djRRczhrQ0V1a0FCRHB4TDhJRnVZQkE1?=
 =?utf-8?B?azBkRU5GU3UrQUR4ajFhS0VCbTg3dzVZbmxuT1drdzNkT21yTzZxV2U5Sklv?=
 =?utf-8?B?OXBVK2MrcC9OZkhEZXIrRzl0NEpmMkIwMDRXKzRMMEhJcm12a2dTOEFwUWt5?=
 =?utf-8?B?YXo5aWN4NXc3VXNtcnRRVzVQTEMrZjFuUVdUVk80a2lsdlQ4VkVwRytzak04?=
 =?utf-8?B?S0Y1MnJLYXprMnBKQXBRMFZ4YXBvYXI0YWRFM3d3aFV1NVh6T0M3TTA5TG54?=
 =?utf-8?B?UUl1elhkemxxSllteS9hbDFwWUxLTVgxUm9KaTRDQzlIK3JJL1JPZEJqcGFi?=
 =?utf-8?B?K1lZNzNCUVUxWU0xU3NTUk1ncVAzOFJIR3RqdEE5cnUxVVdka1VCS2NCSlZH?=
 =?utf-8?B?Y2I0MlovTTJMcjRWcVp4MG1ScnpVT2NjOXR1b1JCdzBCRjVhMUxXVEhsUG16?=
 =?utf-8?B?R1kxYk9kNnRTL216T2wvTVN5WFR1TVhKNmVQWXYxZGpNTFZWdldOdCtybFJj?=
 =?utf-8?B?ZlRYTVNKeFVLMUtOakZXeVFXUUpZU1p5d2J0cHd2RTNEWU9mN2xGMWZPeVdl?=
 =?utf-8?B?d3pGd2J3c1FaWExEUU1ZTkl3WlFVYUgxNHFvaklVUW5wcnZIb2NGajdwRzhB?=
 =?utf-8?Q?guGB5EU+lN4o5O6x1FblLxwoqcyEy3q4EgKb5kITW8Z7C?=
X-MS-Exchange-AntiSpam-MessageData-1: Le6jKDNF9IdLwA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa01e1a6-ccc0-47a1-933e-08de8a680bf7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 12:14:21.7492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4uaFYNNVNw/pYHYgkipwqHnvakGR4jchQrC3l2PA+jfj4ygOQCu6XiPTh7JetknpqBRh7Gcwc2+/YvrlRrsTQ==
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

Add the bindings for CE fault method buffer size RM control RPC. This
will be needed for channel allocation and is also a simple way to
demonstrate the usage of the RM control infrastructure for now.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
index ece31cc32f5b..354ee2cfa295 100644
--- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
@@ -1025,6 +1025,11 @@ fn default() -> Self {
     }
 }
 #[repr(C)]
+#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+pub struct NV2080_CTRL_CE_GET_FAULT_METHOD_BUFFER_SIZE_PARAMS {
+    pub size: u32_,
+}
+#[repr(C)]
 #[derive(Debug, Default, MaybeZeroable)]
 pub struct rpc_gsp_rm_control_v03_00 {
     pub hClient: u32_,

-- 
2.53.0

