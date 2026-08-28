Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE3DC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 03:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C28110F22B;
	Fri, 28 Aug 2026 03:36:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="d8RW+DxH";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B730B10F22B
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 03:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtguSi8DPF5zmdd3RBmt1/6i2ShYgikU7nKYBX7Uri6rr6fWSmtLCFlRcX6Bayc2xZ9grh7vc4rHN9CqqoWaDKVBHAxyKaD4P1JD7JGRB6/GhKfBq0/ot0o600l5YyDTguUcyD5PQeyzP4G9zP23+pvq9iPadgcVUUWpueF8z0WVTEJcOWq3VpFmhoDTHaJnia6NStD+YoQRFpw9+NkUjJ9O7MGpQsf3I/u8+WDukk2E8U8F5wNWVFnMO7bhLpZ4Uuyqn5ZEYw0xNROE8+ZcajG/pQL3Ih0s5fTCJX6AvsNKSeQuem3DKwysYtZSfBlc7pH0XSfivi5jmTCnMdJEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Mc88GR/Nm1POTPR8JvDGOW4eAdOgpJwo2oOcdTSfBw=;
 b=fQnVZv/sva9UUdj1++Xqf1u4mvXvC2C95KmC6VJ7hHJecMOrIYosZxw4cgZlBtR3fwsv1p5IqJu6hNFjsM31jAJfPTHlqsnVcCpluI7KYSk1a69VzlH/UA/J5PPVY/JbGnyje4oOQ9MUFjy8YhTwxJ8dKkZqJXYR7Qf7XniUkyHHQt258uvvieXv7OMFbIzOeThvYBZAx1GIx0a5tLHJ/xqAcJCcQefCdtCTRtTqujgfHWvsk/jrTx+fA+uRhmL2+8XZG+1ny+zUy+/yvsj6dh5yI+CCvk3RzvamJVfGfVdIa2VO8SJB04+JDcISXYCeRcogf9adC6aN05mrGKkI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Mc88GR/Nm1POTPR8JvDGOW4eAdOgpJwo2oOcdTSfBw=;
 b=d8RW+DxH656raEeT1VszrC/8NNJaPB3G7kRo6prmq2PMHa4HwOIs/VTKHvVw7M9ORt+CgDo4pXg+Dt2z2B2CKkeCzaK5mOlweNctRTapASo/sMSVI2KkqKwtrAaC5weDfcHDIe8TWfbxj00llHh8/eQR/+B2aAW3KCeH6Ja/3QQPHj2PZswFklfp3SBPg+iBPSqC1P/hEj12F6z/zGVunyVmG9iuI1QCbHyQHwGXX1aqvGgVQcVSw6UGg9KwmX+mUkFs3Wi6kyjQMVFX71onmXpt2DnZDAig5PGRjNo3xLrUr//XvkBFynIhyO/NL8thaCYgYGKj1w14IqmKK8LZzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Fri, 28 Aug
 2026 03:36:48 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 03:36:47 +0000
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
Subject: [PATCH v5 11/11] drm: nova: Report GPU GID in GPU info
Date: Fri, 28 Aug 2026 13:35:31 +1000
Message-ID: <20260828033531.1117754-12-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828033531.1117754-1-apopple@nvidia.com>
References: <20260828033531.1117754-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0117.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20b::18) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|CY8PR12MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 30783041-42b3-40bc-8e7b-08df04b596bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|11063799006|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: mH3NdZE47wKyGjqRwhEXXhPsTC1RPEAj3gxa5rfvLoNUA0xo0E00nXDfy8DlOso37bAJghFQLLYngHqj6UBOTgga7X7V7CJ1EIjS9URkgMQqqvUGpRQL7GMufr6Q0TvfD9HXnicgSjUc1/Hcyc9EshJzk3UxjN2yAaXI4HiS6EBAfczwsSryuq4TVZ78tzXHua9fOUcuLEZt1w2nA8twTBW3esOB+R7GiFwlMHy1sM+88vWusx9bKmHOqP535ko4v8z8bwHUSR8L4yhTenxC9/+n7B0ZLHeTXFaaYGh9G2Oy2tK9+MgsHyDGwN1ia33+yx1OIUYjela4+/4lHz0O9KrWuf6oK3fN2m2JfarTg4ChYocZaSsitetRDR+DuKw4GgI54Q1mmUfcCR1zzaBYeV2RH7nm4TW+qWl881Lfzli26gfxqV1fW/UChCu9ydg0d3krlZLIUaYt3PK+DM30pghJ2CP2TdLRiVlis3YGQ2V9WMWlkSpuhQ4uDRn2GB3+Mye6+OaE0RaN9udewJC4jMRtw7F5Y1/crP5FEEn1sVZ7fGsgoQZm9ZgWMnc0ZptOmGXGStKSzp6GcOoXCAuhpkUJOMMk2EbN8RYO8fREqoRbQGh4Sw7VnNi5+8KXBr3MVMbBBKxyEpNDyKiIrnUPpxpMkENilUSrXPpSiTNhdc8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(3023799007)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KfKlCOPSU0drExcEh538TL77LGm5PchKoy8yF0XBitB0SaPiV5vK2lvmcPRA?=
 =?us-ascii?Q?46A8fhYhy5gZhrw+r5pQraU4H1jsZwlSnxw68FzdR2NY4oXjnHDmpjCGsqdR?=
 =?us-ascii?Q?uXQ4mRhvrY/7qyoEla/8itw7CzIEhn3dJG+0x1hhbJML5xZtBbTBGXRtOQ5J?=
 =?us-ascii?Q?HE8/59PdSNlL6CdSzEPZYPwiwsbG8HkKcbve8CKeXsK1ukkiRtEu16hiiMjn?=
 =?us-ascii?Q?ec66wEs+9MQb5CunYfkb73vUAH4ctaByk2v/srs7iUPEntsZ/Iwe7u4Sfuy0?=
 =?us-ascii?Q?aECkHp6dWAjaX3AqWhUVOrWuiITBe7g+ZvLzBIFPtyog3F4aMPOozXu4Sit/?=
 =?us-ascii?Q?edRFh+H5yDW271Zefj6x1eyiQ1IjSlhP1PNDbZrenvTggBCMcfCkHyEkFs7J?=
 =?us-ascii?Q?EZoRGksSNJIUOvXr0YgmITUwcIi3IgCPDciCFZrQVO91F2ufcxDVfTlwzOi3?=
 =?us-ascii?Q?BFdbhCROb1efeYqQFPY8mvucBUj2mUQwTXGASTiftSbLLqUQ7aiSpVQr4z6r?=
 =?us-ascii?Q?+EXZvPuKzSbrcKh5mRN8I2YCnJVnGCaYpb5djnnw97xwGgLZ73/5B4K49ue6?=
 =?us-ascii?Q?JJmdgWY1r/GWVjsqaA6piXZ/VN+ZxRdSijwRTcZNIwr9R/ep485wVGRSDUMF?=
 =?us-ascii?Q?hYaT3OAqUG/AJ3BAUxAG/Gh0+fSnQAHQtJTrHJOdC+v/qPNkSX91kN+cR8gr?=
 =?us-ascii?Q?RXid2261mGsgXD6KaKb3liX1VH9LPV6f2Nfl8Jg4EnzTQDSl7faDUL3c33bw?=
 =?us-ascii?Q?MXPtgRy5V4d/Y7SLFiSBLEKXDAumi5FPo95Mwq6f4ea3FzpUzPzk0XwMUgB9?=
 =?us-ascii?Q?Kydgx1xvCx/awUgS1v366R0aZWKI0rT0Cpg5ZBS75x3Fa48J2b54sH/20wpm?=
 =?us-ascii?Q?KOQ1WzJWOa2wxWDSZWzfujIJ1Mr6Xfzu+mutENXueoTFxQwTaGBzfEPPaF3f?=
 =?us-ascii?Q?jSOZOEYrVxfcEjCYubn5HT0UZfy0y58bjZYbnZ+xuFIGV+19M1+vhMRUH3xs?=
 =?us-ascii?Q?v6YddM6YfUTSitsce9v/8mQgRBR6ZL9zqywrsWyp6/woXhv6w+wbM05r+5MK?=
 =?us-ascii?Q?+SviZI7peQvY7O45RQ/WIO0wn7nOjWg0RmuK7b4q6T1DuFRRJatfWlvH7rNp?=
 =?us-ascii?Q?RzXXyfsZIkWl+xxxTovrGTtCAFaldLPEfy+oIf5ZcycqmMUbGJMsSKJSWvaU?=
 =?us-ascii?Q?FIj9l9FsE30zTHQGuCnR6ihLEVuHgVKnh6tH2qTDbCPw1JZzCA+9zxVkMUB3?=
 =?us-ascii?Q?ihjcWkOg+St/bI07zn16lQlANsz9tcaMnSYpQkcSQcgiNaWWrFWvbNk7OG5f?=
 =?us-ascii?Q?AkDyGXH2MnHQbLV+qdQOhGWQpP8+Z19de6rQOcVkUZejzrAJpvqcBSIO/6B3?=
 =?us-ascii?Q?mvhCJ+bY78jYCndVTeb8gu+G4pRd0VxEXc6ekHfxvyOSw0PU0K9k1Gz1KQ/2?=
 =?us-ascii?Q?ftNqopY9D/O5aY2WBgTQzE/QdLljLNlqWWn8nYgYQIfLsS9uLBJwH6sPVFxu?=
 =?us-ascii?Q?ltSZeZjk4fGvNt2XbAOKf2KWrWjx8XxBBfuVtai8zv827DdIHpko174vPDIq?=
 =?us-ascii?Q?lMhRK9TGqzsKTnAjuZGf7ewukj4lHUsJ+xhNqPb0Nh8nv2qUUxdtGAbo/RRo?=
 =?us-ascii?Q?tRly6mcE6s0GkDFnf2QpTgYfW8lYwukqG5l5jW0YNqbu2dQwa7PjjHySWMc6?=
 =?us-ascii?Q?EMODLBnZPd5HJsk5ghIfM4QdlrrEk4g5ZWksQeFHPVXDpo0qr1Ws8mPib4kR?=
 =?us-ascii?Q?tlJBeqDVeQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30783041-42b3-40bc-8e7b-08df04b596bd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 03:36:47.5676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55fOiUrOuFFCV2BBq5Qe00GSF71ApKW4GbGYMK9Y1T4kSGa+N9hsK1Sb2lD7u1n2duAXeJmR+i7ZHAhnL9iENg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433
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

Add GPU GID to the reported GPU info.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v4:

 - New for v5
---
 drivers/gpu/drm/nova/file.rs             | 1 +
 drivers/gpu/nova-core/api.rs             | 5 +++++
 drivers/gpu/nova-core/gsp/commands.rs    | 7 +++++++
 drivers/gpu/nova-core/gsp/fw/commands.rs | 7 +++++++
 include/uapi/drm/nova_drm.h              | 5 +++++
 5 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 64d9f68c7cf0..e1223a29f8b1 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -38,6 +38,7 @@ fn new(reg_data: &DrmRegData<'_>) -> Self {
             vram_size: reg_data.api.vram_size(),
             gpu_name: reg_data.api.gpu_name(),
             gpu_short_name: reg_data.api.gpu_short_name(),
+            gpu_gid: reg_data.api.gpu_gid(),
         })
     }
 }
diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index c18fa1766892..ad4b62db1e5f 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -34,6 +34,11 @@ impl NovaCoreApi<'_> {
         *self.gpu.gsp_static_info.gpu_short_name_bytes()
     }
 
+    /// Returns the 16-byte SHA-1 GPU identifier supplied by GSP-RM.
+    pub fn gpu_gid(&self) -> [u8; 16] {
+        *self.gpu.gsp_static_info.gpu_gid()
+    }
+
     /// Obtain a [`NovaCoreApi`] handle from an auxiliary device registered
     /// by nova-core.
     pub fn of(adev: &auxiliary::Device<Bound>) -> Result<Pin<&NovaCoreApi<'_>>> {
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index b9f19be9b29c..c01b978f46d2 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -215,6 +215,7 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
 pub(crate) struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
     gpu_short_name: [u8; 64],
+    gpu_gid: [u8; 16],
     /// Usable FB (VRAM) regions for driver memory allocation.
     pub(crate) usable_fb_regions: KVec<Range<u64>>,
 }
@@ -236,6 +237,7 @@ fn read(
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
             gpu_short_name: msg.gpu_short_name_str(),
+            gpu_gid: msg.gpu_gid(),
             usable_fb_regions,
         })
     }
@@ -263,6 +265,11 @@ impl GetGspStaticInfoReply {
         &self.gpu_short_name
     }
 
+    /// Returns the 16-byte SHA-1 GPU identifier.
+    pub(crate) fn gpu_gid(&self) -> &[u8; 16] {
+        &self.gpu_gid
+    }
+
     /// Returns the name of the GPU as a string.
     ///
     /// Returns an error if the string given by the GSP does not contain a null terminator or
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 8dddd0876145..1020de51a83c 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -136,6 +136,13 @@ impl GspStaticConfigInfo {
         self.0.gpuShortNameString
     }
 
+    /// Returns the 16-byte SHA-1 GPU identifier.
+    pub(crate) fn gpu_gid(&self) -> [u8; 16] {
+        let mut gid = [0; 16];
+        gid.copy_from_slice(&self.0.gidInfo.data[..16]);
+        gid
+    }
+
     /// Returns an iterator over valid FB regions from GSP firmware data.
     fn fb_regions(
         &self,
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index f912c5bf3b4f..3bd9db27c665 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -152,6 +152,11 @@ struct drm_nova_gpu_info {
 	 * @gpu_short_name: NUL-terminated short GPU name.
 	 */
 	__u8 gpu_short_name[64];
+
+	/**
+	 * @gpu_gid: 16-byte SHA-1 GPU identifier supplied by GSP-RM.
+	 */
+	__u8 gpu_gid[16];
 };
 
 #define DRM_NOVA_GETPARAM		0x00
-- 
2.54.0

