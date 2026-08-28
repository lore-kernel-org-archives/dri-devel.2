Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2734CC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 03:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5881510F229;
	Fri, 28 Aug 2026 03:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iwOyCnq5";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F99C10F22B
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 03:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJMFJtug0Ob8iziHi5BgFcYOwnernTjKvwADwwYJg+pDKA2TtOCtjVqMyH+r23wlyfBA1fNAE+ERVyp4yAr14w8OMZ5Y1kHZJdA3trx8wAa0l7PWqdbVfxOH0X8aTBQIiZHGrkPn3b1q/HqOOzfjQhvgubPfFM5YTT+4gGEkldJfs+sB3lvGheGPAaj/RehefJDRmzh9WZCIZZ/8hivNV68wU/J5zVFG7pMxzPre8jmBJ3Yj+1mBHbp7HvOr6ftNpyO/Iq2g3HeSuksVaw1cLgapcJk3zn/2nDrRCHvRh41ff80Ruv60eKGdJhDgcuSGl7zt/7n+Lxq5Xk+7VYPvyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UStHbTUDuYFdBrLi6Z661kqtDPRWB4YOqEA62YVqgHg=;
 b=hFTGdKOdnGC51j2tp6O+gm9R+gL/rapilp7fxD6fdaDTrg0poX9p9hdkAD9vzp0i2613r8UJEiEBaPk/IcUTbKt+omc5VnIlnqusTJAl2g8UF/QW9FeShdMmVZTbkuPODObwcq1sQRLHUHjv+Btv2p93RjddAWTq0t78ribXmONCC84GfsvmNr4w52Kk68nTAJaXWmQ/kdR/96qqQ7T7t1se+UmY+LqPlQz/ZFUkfBddy1rL2EmiOSQaU2f6qtYRcwz0r/NWl4ebLDb3gCnEdo6iPI9p+c6i0EqTFAQkLt2bYl84GmuVuNEa0/VcBxTLeSlBqTe25GrE11L9KAmGRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UStHbTUDuYFdBrLi6Z661kqtDPRWB4YOqEA62YVqgHg=;
 b=iwOyCnq5HO1TN9W9zNgueegosjpM4bhp/wg/Ki/us66PvbRQU+Fuw99R2rNAcuBQRDmLdLvCI/eLTyQIo2R9Ko/kDZ180B0g6dPNitWpQmss/l4r7E+Z6P539Xed/BLHfzC6iY7d3ST85WHDzZ1AqivjAdHvcypw3VCvMSa94b2UpZEw05NFN05anRCey9ay0KUdAKdyCeppA312QTZ12NuSK2EwGOaSmMzVEOslHaeGsY0rZBbdZBA6cEbITgpxzMDNB+BdhP2onreJnRuqYo/3r7fsHxy2ij9zquxHj/k/jvxhK681/Uv/Io2ftOt9+chCBxNeM02WkoeYQpx4Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 28 Aug
 2026 03:36:42 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 03:36:42 +0000
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
Subject: [PATCH v5 10/11] drm: nova: Report GPU short name in GPU info
Date: Fri, 28 Aug 2026 13:35:30 +1000
Message-ID: <20260828033531.1117754-11-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828033531.1117754-1-apopple@nvidia.com>
References: <20260828033531.1117754-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0027.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::14) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4d383c-326d-4301-9b20-08df04b593e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|3023799007|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sEFeXPaM3LKpCXiDn1cd/3t/PLk6JIkhIOD24kgjAvwKrlz1Nk5qLTyXXagPPqlR2Ea0/XZs3lIdi31FeOjiKsGeAHOqQG8iWWyw3TBmlQNwRzYsLowYUG9rJZUSKgwrZnmH6jOJ1Lz89Nub2qbDLOjj7f8FtdJRxU2EjKw1t2MlBVpNIFhsyFO5gw1uLoG8ryH5QNfQhhfX9PT4WRQEBwU3b3Quxv//QwhvhRv3UQV2GqkgOWXF1tRHvpaGdoWzmtvELjV2d7tuBXG7ywjiPXmALVBw185zhCV97MF2R82k8VULQ/42MbBM9fwn86QPvciU1oRrXs/fVRv9rQKqoRefADmHcNBcfGIIIZBFTHIC1kAl17gZYpe3DY3gqzt0hyDLMoKAqqVWqvF17kJ/0eZ7T06Zfi4BP3S9pjrPa7EBNBtWlMQ/dzuAxn9pxwJjNrZ321oEfZBiW2h3REWgXnF/PL3TD761RKXX8jKNaRjh+Qs5Gbcy/71V96A7oqFI8s05tO1IZzX7I11cdF33Ael5dmHzkgVLryfW7u5RMgdEPuAYf0kX/T77gMAC3imv7GOH9BFitwCftRuI6yFCfb0JHzh8pU2I5Z2Wv0bXrokSuD6K5TYZh2BRziBvcMiC1T4AjrNIxoskuQnnqCAiVZp2xfV5jjWYQ3IAfDZghFA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(3023799007)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HinUMfnbsWxCHTerMcv0ELTPsMr89yMJQf0gxSx3e4MvEzXOygegx+f6MANX?=
 =?us-ascii?Q?bploKcJr5HuVGPhEznRkjqQ+cVnP+mywTkyVDM6e7ZANlTmtdOrbCY2cqF0R?=
 =?us-ascii?Q?VDCueqGNQInaQfmEg5y4g5XCHb78vt6AXmDZ0UvkCZdixPVJ1rSmXChCJQjd?=
 =?us-ascii?Q?vti1c5xHgmZ4HdapcfBwD6FQkx5xUBWa7HhMeP7k+krrAfmMthPVuYrBw+ws?=
 =?us-ascii?Q?E5HG8ldem0jy1Efm7/GmKBC4UqJ9xV7qR5BIT9OWA3gbIa1FMg913ZDHb8V0?=
 =?us-ascii?Q?+wa7ub3KGBQLWXFUfIRyz5FHxpQ2BI9Shqioe6zDJ+4H1ctU4Xvddx7SFLLI?=
 =?us-ascii?Q?mWk1y7pmhQAIrPsJWc/XPMCbYP68ybEaCPAcBabvStLs5U1FmNHDkUmcSHB8?=
 =?us-ascii?Q?7tZBXS9ZN3dasjaN+y1pCs5kvleGLaszH8uI78fKf4jIrYPqkePRBgXx7UMM?=
 =?us-ascii?Q?o4kjWY028o5cNUT1KYPWq4UDcvKJiUOnoXMzjn4eonmig7TydKjD4rWWeF4M?=
 =?us-ascii?Q?7MWFC9aI6PrsAjSjImolWxn0Q0DKEk9vtfKuA9oaGpILlJs3Yezd2vCDbQnm?=
 =?us-ascii?Q?8G7zKPcfr/+QwMZ8VIeUoxjNvREP4M4KwZvA/G3kJ7bgi8VDk67IDPqtBzYi?=
 =?us-ascii?Q?ojLe+BkBkKuuclV5HDnM8BmGliM/JxrATKfkJYbny0WS2YgZuJEu5vaZ9CYh?=
 =?us-ascii?Q?/HCJMx6BqOg3JjF/xlsRxFtRUUgrHBJiqcSZCfc6Xanm7l4Jx4PUAq/DbHuJ?=
 =?us-ascii?Q?3dAtOMPcpVtmwRU6cshTQumNSfcJQmRS/W6KZOc4QUGsbWsFiteDDxvciyir?=
 =?us-ascii?Q?Jqqptr5tHFPk7mHcETn3e9EC5zY3QVZa+LHvZh39qJni3B8sQA8c/tjjkkAZ?=
 =?us-ascii?Q?jDuU0iwc/KOYYuD1N4ySSpZszGzDFMQGBb2GbyGBW7HvARriPOVTwp/hMdz3?=
 =?us-ascii?Q?osko3X+m6518ue9dm0F/S1dO2reuXO+0SdEC8ZNCh2mQdsS2GVKSIWspiBCD?=
 =?us-ascii?Q?P4f0ZlmWdqD/xOmOsc+58pqY2RvewsvPsxer+kIbOhZgVXM6y3QubafufxnG?=
 =?us-ascii?Q?8puCv0Ud7foDm9z8LICeL/1xrZSrWiBl8vc3U3FgJE23ZCSsDk/VZykroXEF?=
 =?us-ascii?Q?MXvAQWPf1uVzBcaDawlMU83V92BDmtrikzRXDBHQx1oYPmCsh9odliz4qh1w?=
 =?us-ascii?Q?mOiNA9t0kcV+oV2WsnfJzVUX3cw7+tYhnjIMCVnXWV0A0XwbqSfwOGlLd0zT?=
 =?us-ascii?Q?Stvuchh72acehWMcOZ4GduYzKi8b5I0b/mAb+9wrM78URVsVke+fq+KkThbp?=
 =?us-ascii?Q?hUbswj6EgUrJN9Pgvw/HG8FgdxpmDRfh/ITf9AGl4JvJRUUi+EBwJLzH+3Wu?=
 =?us-ascii?Q?StpRcN5rcOTW535fDKEFLS3F/u/Q3Gq6DTk/3mWGJUieWjZ0pJ/ZC19x/JD5?=
 =?us-ascii?Q?8JaiFKDaXg9Tj/So4nkPxxRUrWVsbSrO3qekzZFt1gVoAB4A5WT86tZWTndY?=
 =?us-ascii?Q?fSGrFwbdzEFopsQMxcQzGxWh5Wu0tfFXVCIPVtPwvdWXnzoMH0N9KGtVObXn?=
 =?us-ascii?Q?st/d7T3jjoooz4WBSG+wlGIF+TU446sli5gEfUl8HIjkxOniQTeRVPB+eFrH?=
 =?us-ascii?Q?55/3exypIyJESEfLKR3Za2VzljhunZuTLgOY0oP2Ve5tPpduR1MGXP3fxT8K?=
 =?us-ascii?Q?3lDGF5xTN9mhc3ky3ZqSUb5tjMpi1maJeIA7r/lG6BEQBKuV0SIKIOnstKwr?=
 =?us-ascii?Q?1VVxxq0aDQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4d383c-326d-4301-9b20-08df04b593e9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 03:36:42.7981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhkjVLOimRdrwim9LMbXzDTfuzex58FTldPEp6bgNWIDZHi0rBziZXCtoQHATyw5pWsq4f9SPerB0VodcIQGYw==
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

Add the short GPU name to the GPU info structure.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v4:

 - New for v5
---
 drivers/gpu/drm/nova/file.rs             | 1 +
 drivers/gpu/nova-core/api.rs             | 5 +++++
 drivers/gpu/nova-core/gsp/commands.rs    | 7 +++++++
 drivers/gpu/nova-core/gsp/fw/commands.rs | 5 +++++
 include/uapi/drm/nova_drm.h              | 5 +++++
 5 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index ab04a10d3353..64d9f68c7cf0 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -37,6 +37,7 @@ fn new(reg_data: &DrmRegData<'_>) -> Self {
             implementation: reg_data.api.implementation(),
             vram_size: reg_data.api.vram_size(),
             gpu_name: reg_data.api.gpu_name(),
+            gpu_short_name: reg_data.api.gpu_short_name(),
         })
     }
 }
diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index e6789f1485d1..c18fa1766892 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -29,6 +29,11 @@ impl NovaCoreApi<'_> {
         *self.gpu.gsp_static_info.gpu_name_bytes()
     }
 
+    /// Returns the NUL-terminated short GPU name supplied by GSP-RM.
+    pub fn gpu_short_name(&self) -> [u8; 64] {
+        *self.gpu.gsp_static_info.gpu_short_name_bytes()
+    }
+
     /// Obtain a [`NovaCoreApi`] handle from an auxiliary device registered
     /// by nova-core.
     pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreApi<'_>>> {
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index b8dc64808620..b9f19be9b29c 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -214,6 +214,7 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
 /// The reply from the GSP to the [`GetGspStaticInfo`] command.
 pub(crate) struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
+    gpu_short_name: [u8; 64],
     /// Usable FB (VRAM) regions for driver memory allocation.
     pub(crate) usable_fb_regions: KVec<Range<u64>>,
 }
@@ -234,6 +235,7 @@ fn read(
 
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
+            gpu_short_name: msg.gpu_short_name_str(),
             usable_fb_regions,
         })
     }
@@ -256,6 +258,11 @@ impl GetGspStaticInfoReply {
         &self.gpu_name
     }
 
+    /// Returns the short GPU name as a NUL-terminated byte string.
+    pub(crate) fn gpu_short_name_bytes(&self) -> &[u8; 64] {
+        &self.gpu_short_name
+    }
+
     /// Returns the name of the GPU as a string.
     ///
     /// Returns an error if the string given by the GSP does not contain a null terminator or
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 6dc31d1bf5ae..8dddd0876145 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -131,6 +131,11 @@ impl GspStaticConfigInfo {
         self.0.gpuNameString
     }
 
+    /// Returns a bytes array containing the NUL-terminated short name of this GPU.
+    pub(crate) fn gpu_short_name_str(&self) -> [u8; 64] {
+        self.0.gpuShortNameString
+    }
+
     /// Returns an iterator over valid FB regions from GSP firmware data.
     fn fb_regions(
         &self,
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index 7e11d1bfeb6b..f912c5bf3b4f 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -147,6 +147,11 @@ struct drm_nova_gpu_info {
 	 * @gpu_name: NUL-terminated full GPU name.
 	 */
 	__u8 gpu_name[64];
+
+	/**
+	 * @gpu_short_name: NUL-terminated short GPU name.
+	 */
+	__u8 gpu_short_name[64];
 };
 
 #define DRM_NOVA_GETPARAM		0x00
-- 
2.54.0

