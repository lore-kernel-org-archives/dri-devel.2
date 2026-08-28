Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C543C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 03:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B9A10F21B;
	Fri, 28 Aug 2026 03:36:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QCdA2bGl";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A67510F21B
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 03:36:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuNlNYV7fr7yfsfMNqkTXH6/feq1awqFBo9rgffatc2asEuzAlZGYd3L4mFeKK4TQ9gLXhv0qcV5MQX+YLBsM2oUw8wOy4GR7xyYO/9XEuOgPpHtCkEdU6LLnc+qvmr9jIToLft+InPm1XmzowrCfpOO7oJxJVZp55l9g/B3o5QqEO2fo90AY9ldoz/Ft9zevdn7kHa6lc4pPg/4cuJ8FLLNQLcqKmXcGffVMS/VCrmlJfl6WF3quqSeFsBEJBxclzFZUj1nGJxt+GOBN7Fr9fDhqYZq/RMUUoUAglUQMSI5VdPpEf7FAWRvLfVOFGRowOm0zFywqupfPR43Zpc02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvEx4sW9kSLTlV0kpv5AfoocCRFYAn5Fr6YaAah6T9s=;
 b=Dsy5N/bKifG+qcTa2fVIv3/b+xCYKqX1zAKJbwsWi8gKG2/6T2S6/CI7K9T6xhd7B94ZnLLU5l3CUDF/ulyXnvYdl/vT3cZLc36OK/adEPjXITxMeebfKxKVLplVqx09hBRgLrEiIaIF8p3nvEzOZMR7ACvhbf111An+h1yaDQxesSqPjkoMI+aUO+XWMDT6CI4n7HwKtn1NaE7KKgwImMAV+dAYmIY8sLfevSQGv124km8D/3GLcgLtTctH18tv9FRVdQuokbQ3taq5jqw1UXOu03B6abSc0HCrUDWgrdAzdEsY7sThm2MV/nCsW/Og+QzsdKTeY+L2G7mTkPdBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvEx4sW9kSLTlV0kpv5AfoocCRFYAn5Fr6YaAah6T9s=;
 b=QCdA2bGlOxGGN+8SnLsDhwllfhIXjjiUJhcZ1YyUaRoQTmu4LlivAYv+V1H0FLPyemCpBZWolNW5BfPKiC6zz7z19T2WZWN/iZ19/byTwve/tuv99rHKuQFUyACuQYBX6ug3RTS/5K8aXKNdOjD5Wrb7AUmcDQXQCLqtVUxUA7ERUV2m9ZHbJPA2wZ70m6RYESvaoRxhLJVuoqllFfR2Z7n13INMq9rv9/ot+zM0QdasZBO0b5eL4IRMS/OU4QWaufXXcqOcY0aVGL0ZNjW112vl41Lxq8t5WEe6UJsg9TKCnEg606gd7FvTjeS+0tvOeTWU15wSZAAAisq7+VkKXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 28 Aug
 2026 03:36:37 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 03:36:37 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>,
 M Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v5 09/11] drm: nova: Report GPU name in GPU info
Date: Fri, 28 Aug 2026 13:35:29 +1000
Message-ID: <20260828033531.1117754-10-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828033531.1117754-1-apopple@nvidia.com>
References: <20260828033531.1117754-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0038.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::7) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c19b8b6-753b-49ea-498f-08df04b590b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|3023799007|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YaRcpb36O6ee1dtufYa/KSPMtYHVApTMUaBtYNGqjnGyUdIW+WehdXxJ99RMwWhVkn9Cm7m6oc9aKNwfNjOd5VoXZOBM1FGbUtC7DJpSQJCSFMmp9v3nB2o5Bynx7SYmHL86Q2mKq940Gcwpbh/pNH3vSqZoDHbCcYwVrviNy2MeGEj3Lj6+hkxTMf4FxwoRlzTpaFkhd3Qwm/lyE9qiinsNMjWjrb5ovioI/Ued+6dT0vF+EW6AU//kkvo8156hoh0yv8Hjo9dplUJ1q+/MayrJq7GJz+Jp8G4gKufXUEOWwLs8BVYUtP8FNbUdeVJ7RsU2+Jpj4KBug3k6jocOlq0dfalCU7UtnpQNmzrUxg+sMz+neiHSvFKvZIUXJ1spIqHoUEpR3Z1r7lo/GnOOyM3dbHhaQqQUuSU9b/jHzvVfAcy5fAEkL6YwueL6MeDKaPFDeWPzKWpn1kbmbB4kxTuOWiaPwrMpvykLO9ApsqauJpx66NdE/s/W3M9QQs5fIM/AzOyASvfNkQdJrVDZeH/Ngt64ajHRhpJxXLg2KMC2JaZ7oXTL7h4+LiIbABgWZ/WxuG8dGgDAUu61dHtkRIwhMlQ7dG1A3uour6Xraf6N43Cutyo8TjfSUI6TJGHsqOmka5EMTvM8DMjlbH93qDcKn4sBwA6ID6R3BxIzcOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(3023799007)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vjt/ZG4nxfiIICYHNlWihnoSVIxvpY8//tTOUczYm8/4M6piKExlO4D1eRis?=
 =?us-ascii?Q?/b0lLrZLWY9pmpZPPiR1YsFO/77EaHZKv9u3fiJ5k9Szu1yeU99UdeF1XeVj?=
 =?us-ascii?Q?Hnc8YnAXjPcNcjGc8exq8kw/tRsoOWt+UaLPrpjdxFV+Povn2s2B4yfT4eia?=
 =?us-ascii?Q?9lcuaeY5HaIArOSkzvLqiO28l3jPUfzGsWXzvQ8fy4/UANtTqSFp4y50U8cy?=
 =?us-ascii?Q?NQQkI8ai2pm2JN99rAkOnQuMAfq+d36R0fWz5aKRo9eTRSqV/ykQHcm3JLT2?=
 =?us-ascii?Q?cXpvgkKjjYtEs+TiP0VZCZvcHqJyr2hqcNIRnxyh/qPwDKP7EwslBy4JZMxP?=
 =?us-ascii?Q?Esfw4YfAX9wRPMyfWEOfbJYQ9zlMY2iDE19FwQMGJ6Qq0QimwO9Nd8pm+o3j?=
 =?us-ascii?Q?+EyK+qukdST9+6iiNzXgNQEefwdaBW1QuLZBLFVPRhKHCcliq03KeFF4PWmZ?=
 =?us-ascii?Q?ndfMrFYGiEVxm7GTMKK7rcTOHecoiWDRZmu+EXZ9ISx5EMn6q0BYpmWkLl7A?=
 =?us-ascii?Q?npiZCqTPGgJvdy9TUaNwP5dWTxhmgteROgGJtguw+ea5QlQW0zCxArZw66vQ?=
 =?us-ascii?Q?+jXgBP4Yn8pBgdIu6nEYH3zUFFVfdme0NyeMecQMZ25bXAjJhBmhXIyDmT7m?=
 =?us-ascii?Q?rP0jvdvGv3QuX1PlftiEDxbjSLF818EfJeGuqUHATWzQGoAcNnJARwSYhFLe?=
 =?us-ascii?Q?yg236q6OnLbr7K/TTSYWSV68FjaSUp0hIP4MqAXU5q1CXXBtbtIyEBPtKQMQ?=
 =?us-ascii?Q?hdAah7ee7GytYDcnBd5wWEDdnqDsWOitusMdJLRYinWpvrzbxVy3A7Txs8X+?=
 =?us-ascii?Q?V6WtG75NcnShM7oi9YO7/xlGFf8UmFuCdBhwura143HcNc4S1KLPKd1GV6YM?=
 =?us-ascii?Q?eg8pMfGS7Q8bNIJ0Y+Iw0pw8x5qtPzspcPD626OJE7xHkK6l6uJh9WtaV9Ad?=
 =?us-ascii?Q?KaZY9qxQGoKthnmO7sWhxFd23pPNcCGR+G6pq5ijnDl+eO/bvH5QCn4NY7WB?=
 =?us-ascii?Q?TrJOKkB+VPhvAN2RZzacV2rDU+Y+h3mbgCXsarzMDVqX/1tM9W6oFtIVc52h?=
 =?us-ascii?Q?TT5mNP5SalL2sAhIG/SED34nDxIx4iy8BdIK5MBBfJLxjIVsSfD0mPlvnPgO?=
 =?us-ascii?Q?Y35OUh2K/hk6lVSMMU1yXPJKFC2qbCBzdoHk/aeqPjaroAhsZfAPOGAziKeb?=
 =?us-ascii?Q?y5Vb8M9KYKSh5IPrCTK018lZXAN0P8XgTxT0BS32bx8JdrWHP8FN+snClM6s?=
 =?us-ascii?Q?LmFMbCHFjggIv9hYbMx05AATKxFpSjepniYN6xosB70oPUh3njqgxfX+ZnnL?=
 =?us-ascii?Q?zfEtzJ+i5IOXQeyav3TxrbHuTiCJ5iUbeP1zfzW0kppfkGc7j4AP2NQcZpKa?=
 =?us-ascii?Q?4aOJrxPsH4sk6jiC4ZL4NTYIgnXQfXlk2MBnraa30wHYyyREOsB0QzGJUCrc?=
 =?us-ascii?Q?tU9IBwwi2XaRW9Qgi09Kl/gL+4cfkiDJb00POdAi1qxjRbbAoQxz7ZcMqQWW?=
 =?us-ascii?Q?UQrZcu+vNPifSLxmgcunP0pZSySQg8tSlz9MCI3jMEkQgqfCfFO8vtpmaHuq?=
 =?us-ascii?Q?cHK1Ru252ZSiFGihcBWdFRJ20qo9jwYjBQkTve1Yb3aoe4T85+Z10yJwez9H?=
 =?us-ascii?Q?g+DfVRrkHoe6wgl1QfomiaZeL6azVHtTVOXz2gkKRXOJw2tj5V9AqA4KOtOW?=
 =?us-ascii?Q?jyVSVtmBVRiCSVImGZ7CNGTOkhu+E867d7KWGC90QZVicWrMyHuae+Xi6nMc?=
 =?us-ascii?Q?mwNTlC/b5g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c19b8b6-753b-49ea-498f-08df04b590b2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 03:36:37.4900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUSRegfz5YB9aEmHArUVXshPcAKFkiD6umYE7EzTZ8zdXsxJlMtB0pihLb4J9NWAGhDrvBdpY3SBd0Hg8uTeFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
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

Add the full GPU name to the GPU info structure.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v4:

 - New for v5
---
 drivers/gpu/drm/nova/file.rs          | 1 +
 drivers/gpu/nova-core/api.rs          | 5 +++++
 drivers/gpu/nova-core/gsp/commands.rs | 5 +++++
 include/uapi/drm/nova_drm.h           | 5 +++++
 4 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 6fc169c66d02..ab04a10d3353 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -36,6 +36,7 @@ fn new(reg_data: &DrmRegData<'_>) -> Self {
             architecture: reg_data.api.architecture(),
             implementation: reg_data.api.implementation(),
             vram_size: reg_data.api.vram_size(),
+            gpu_name: reg_data.api.gpu_name(),
         })
     }
 }
diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index f4fd78f9c321..e6789f1485d1 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -24,6 +24,11 @@ pub struct NovaCoreApi<'bound> {
 }
 
 impl NovaCoreApi<'_> {
+    /// Returns the NUL-terminated full GPU name supplied by GSP-RM.
+    pub fn gpu_name(&self) -> [u8; 64] {
+        *self.gpu.gsp_static_info.gpu_name_bytes()
+    }
+
     /// Obtain a [`NovaCoreApi`] handle from an auxiliary device registered
     /// by nova-core.
     pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreApi<'_>>> {
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 6453184af55b..b8dc64808620 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -251,6 +251,11 @@ pub(crate) enum GpuNameError {
 }
 
 impl GetGspStaticInfoReply {
+    /// Returns the full GPU name as a NUL-terminated byte string.
+    pub(crate) fn gpu_name_bytes(&self) -> &[u8; 64] {
+        &self.gpu_name
+    }
+
     /// Returns the name of the GPU as a string.
     ///
     /// Returns an error if the string given by the GSP does not contain a null terminator or
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index b80bb50acaa1..7e11d1bfeb6b 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -142,6 +142,11 @@ struct drm_nova_gpu_info {
 	 * regions.
 	 */
 	__u64 vram_size;
+
+	/**
+	 * @gpu_name: NUL-terminated full GPU name.
+	 */
+	__u8 gpu_name[64];
 };
 
 #define DRM_NOVA_GETPARAM		0x00
-- 
2.54.0

