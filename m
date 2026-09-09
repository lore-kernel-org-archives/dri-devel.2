Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB70C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE33410EEF6;
	Wed,  9 Sep 2026 06:46:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="j7U2O5zm";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75BD810EEF9
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:46:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOfZH472E8UzGUjH8TqzgUVNc0EMsW/ww5wql8h+o9ttbfHsdlk7YLCchdukSCPtl35moAticFSYy/0DwlmawJ9SrI70CKm2R8aN5Awo63lCgM0Igep/5qqyn3GHBUsy4Kt1kDXn6glezxXtSYTNU/1FA3dovwkvKj8Kd4MdiRDs1bfPpYCRWEEHXMFgYDlrK7mxrDm8c8LC32c1HltQUVNWHVvNWnnN5pfukg6an7zQB1YzXWpEHgy5qlJAa1JmUtr/7AMgv8NHQtSbAQvLXMmzeSLC8e3l93Mo2EwcOuj7vb30mujk4AomFGdiUmy8g8Lgjsshz4AattjYEIdeng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvqSwIwMGMcS3aumxTvpqshpxhdtdwSCvw/lv4f9Wio=;
 b=JCTJlIFos8mja61s31fJHZtJlxz/44RErm7D2USZ7v5MMyA82VzyaGpbAPmi3Qkfrmncx85yBvolFCdpwoE+mrG7VNkaVaFmwkQAEGMFVIWn7trqDAN7XILo1WM0M4u8QAuPXYeJGiID6UvASTtA05gBMu8/DTpz0/oM6gcKr5hR8ANZ6vfgAIeYn+7lF13pGF4tdpTjT7h61V5WcPJeYtHbnYtQuURDEw159AL6u67XT0FhX69mn7MIz7/jPzFcXo0FSo8OY58r5ZiuHzMAquccL414VxuZmgzLzwQa7c2+WZmlvDsQgJKc9JWnMtOWAllIZToHt6XXsVBUnxv8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvqSwIwMGMcS3aumxTvpqshpxhdtdwSCvw/lv4f9Wio=;
 b=j7U2O5zm3L65wug/aqyoFuxYkkVd23r43Z65/y3LxSf2tI1/HJFq2fGKCri4T9juaQgCATEVvs4QS7OC3mRaSiL5I5U9gGmKdQYvDOUakp054TCyqHE63WHfgDNwbVbQ18IW4RAMGtvxZP12UMOOuHONqn/MciC8bwrFuu1YN2KfAKCB3M/dYKYkfld3AAFLPNK64tqdT78lPhQjsKRHhSpEk8Pk6pfi52PStRmgPNtcS31t9EtIMKUrt+uu/SJC7L4sFgiP6x5eN3LFHd43CqZNd6ZkEkmDTyOwwwGmBqjZ/NsuSxZNkYR0NInmveeYT3FG0Lp+ID2zf/ey6eRYiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 06:46:16 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:46:16 +0000
From: Alistair Popple <apopple@nvidia.com>
To: rust-for-linux@vger.kernel.org,
	nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>,
 M Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v6 11/13] drm: nova: Report GPU name in GPU info
Date: Wed,  9 Sep 2026 16:45:04 +1000
Message-ID: <20260909064506.910162-12-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260909064506.910162-1-apopple@nvidia.com>
References: <20260909064506.910162-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0119.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::13) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f100d97-8f9a-4c50-5deb-08df0e3e0be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|56012099006|10067099003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vogavG0uPIJFB9FD/Gy1lquusDxPk7SP7WNjBtyA27gWPGEOUxpxT/3nIXOp2TxQrmmPuS3z259Jgo0CDXBCpwEHRkuvcK2h2qAfWLkR4A6cokTBUTevnLSjcXA8a3mBT0EnN4sOC3ImrnfZPVvk26pAd/5KRhRD1qeuHNNJZm93dqew+eXpoFYMs5s/m1a3oyXNpxu20/kjJ9QughN6bUIPu8XEgdGA4n1bGajn4FVMb/7Y+Q5wDNDFTT28ALToAnCYWfgmJQghWQ0gxeqeEOvMcLtWfgT64A07IlSdZ22xrKnfn8D5R56oacHiSLyi3Cf77yjUK3K52kza5S6q/5oEOCQhMAWehadt6ynJMDq47SS2JKotNx6/HonaPtCJptL9F3hOl8fDsNG0N80b5mR2T7q02+DRWWT/Iq6n/j7zkCcvJD6Qyy+QIikiCPRrWZvrqCTfCEyM7ME/7kqUkcrdsLcge2iDXgRSSqBLvaDkWxXXXBJdVIbUtpfH1bhTxOX+4fnux3LDboE0ihTyw6s3Y19izetU4+ybQH1BPBIu89BR4VGRe7q3PSpRcHhjRsZF8R/8qaLNZX5EYtT9jnX+dJfKsrLywU+kDo2S3/COribJ4aY8Z/mGWntgb7bU7tLJq5QkDLs/Mb9UuK2FtO2pc+2SQEXLAM6mJz/712M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xsi3XeOZbxy5DfZk8Ato07OcZ03g0qsX76bYjdROoFRjKxD4Um1miOdPE7fn?=
 =?us-ascii?Q?lMWygd3bejVTerX3UpZe46jLLb2fqTVbPxDhEldluziyzNNfYd6IYXOar4dR?=
 =?us-ascii?Q?0GxYijjicQ2720GwZ8Gg53w+j8/Iz9uLjx/s1LljZIcyS3M2DlbfVT4sfd0T?=
 =?us-ascii?Q?b1CZq6//iuioXj0PPQLbnrYcSROGfdxQ1a+Qxb0BlO6BEjxFEhlj88xXtArV?=
 =?us-ascii?Q?UEchp8zIRe8/Y0Buo+4z0HqwrDVrPFeMA6VLqVtrSib15nHNCKsWrNIe2cRQ?=
 =?us-ascii?Q?K5aWtE1ACLKYPb8izMk2+ZN1FbYHnobfXD8Nw5DxF+PwN8wZm4x8MXzmzGjb?=
 =?us-ascii?Q?mXTsmaPMyob0LRMWxbBRU81hLDaSEDDdFlyrUWfFquiGDR2VE4miP3kV7zni?=
 =?us-ascii?Q?KEgHT2OqUuk7lUG9sJ8ySuVVOa4UAa9MLTXn3lsKnvsrY2WJHCAme7x0nhVX?=
 =?us-ascii?Q?BQVu5NH2XUqikY2MG+2ygtv0lO8qGp59FT4hLPKgQlIPTq51qPjqj5m46Yo1?=
 =?us-ascii?Q?4y+Mwc4Ad+efgU2Pvt2TceWp7KlQWwEvnP64t4QPvSJBb7sHwv8Opxf/MHxq?=
 =?us-ascii?Q?QEMaL/xoRfnwGbVPeLXT1+7y2WZ0U6bWiMIKlaf2ipdgxHO+rHYG5LxOf16f?=
 =?us-ascii?Q?CCQaNnscNIuKsmjwZ2NF5N30w5eJb6HOilkduVfGuT/ZbCx4nGJVXM0FXmf3?=
 =?us-ascii?Q?LIx+Stvf7Gez4ssLMCT8q8MVPlUaudTBSlIYE1Xu36eCOKSkYgNk7304gCIt?=
 =?us-ascii?Q?URXK8BxkvOXTNMfZenlJKoaKe9JrUn1i+mk4U9+IOt9+u+HMzPx00RBsOw7K?=
 =?us-ascii?Q?L/tPH7bQQqEDFBNGrn4Nh4sXelT4Mi7o6w5xuXkmkauf3y+b4fO8rjN1VZ0l?=
 =?us-ascii?Q?NSuB5FJoksABEwYNNVG/lHugEA1hzrpWsv2OnFri+6j0IojZqSr/xjFHSHxC?=
 =?us-ascii?Q?3UufQB9pV24oZeUVzEZmDeHcfwXvxC3xTj+xLzVdRAxS/LhYodpsF3jmhTM9?=
 =?us-ascii?Q?h0+WtrNSxvlxxLM9txgu1Ry8jJJIahQ+JqXRXuLDaBiOr6fTxkA3TUA1/QfW?=
 =?us-ascii?Q?Pw20tGqFR675mBZA0nGCkzDafcT3lVtVO9xS4btjMAUGNszTSUM2CKyblMVj?=
 =?us-ascii?Q?rYdCXpne6T+IJhGo0DLbnqb2r6TOoQouv7J+t697FWYyOQsFWxxnBA1qn2Yu?=
 =?us-ascii?Q?CxdjF3pXYtaubrX4IHEscAE8HUnN2TP9ziBNVUiiyYhovYHyAS6vGeZIF/vs?=
 =?us-ascii?Q?fRVPhnj63WtMjfPODuJuRNSrx51vEd9oAF5K/VqdLOH6eb4hmCmlyAyytHig?=
 =?us-ascii?Q?akskqb+DaG4N7SXungsebEtJN9MYlHLxiskVm0z2WNyE1GtfKz+FmMmAbWkh?=
 =?us-ascii?Q?KOTlWlLV5S3Gf3WQmVoLPJILKdCm2HiW3DB3RgtKRDAq/+lQ8EqoclfLn8eH?=
 =?us-ascii?Q?8uBcXKPXUviVJQawOV78VPva7cknwqMqJd0O9CwrZKSDcEuYtKGwtKUQmop0?=
 =?us-ascii?Q?XuqWMKFfLH/0LjLg/dlsall1we93BtGA6LA6VqR8HJErpcdGZDX3eqtS/gdy?=
 =?us-ascii?Q?Eazd9laEe1crV9OLi9/+LjNmodAzefq5n+AFNyETcAbLsPNBw/486mKBuhpD?=
 =?us-ascii?Q?BV8QFjA1olQlltAOo63hdOHryxs5APX1SQjArMeSVFf8foRlq1jVgtU3WobX?=
 =?us-ascii?Q?NktUVelQS6nCQq/sawCdcEdbgI2marGnUlHyGsNUjVBGqWFSQ+mcAOkJMMVi?=
 =?us-ascii?Q?H1JaHA+95A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f100d97-8f9a-4c50-5deb-08df0e3e0be9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:46:16.1832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PihOAbX377mUc6bmvHg0r5BPjKngyppiyoWXj1I4eyY1OR4tOg/+SsLVdW13VuUiayn65jPYnXC6lBHUfueQNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697
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

Add the full GPU name to the GPU info structure. The name is copied from
the validated, NUL-terminated string nova-core already extracts from the
GSP static info rather than from the raw firmware bytes.

GpuInfo::new() is deliberately fallible here. A malformed name string
from the GSP is unexpected and is reported to userspace as an error
rather than being silently replaced with an empty name.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v5:

 - Use the existing validated gpu_name() accessor instead of exposing the
   raw bytes, as suggested by Danilo
 - Keep GpuInfo::new() fallible so that unexpected GSP errors such as a
   bad name string fail the ioctl instead of falling back to an empty name

Changes since v4:

 - New for v5
---
 drivers/gpu/drm/nova/file.rs          | 21 ++++++++++++++++++++-
 drivers/gpu/nova-core/gsp/commands.rs |  5 ++---
 include/uapi/drm/nova_drm.h           |  5 +++++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index dad3c83c920b..4753d9bca13b 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -25,6 +25,21 @@
 #[repr(transparent)]
 struct GpuInfo(uapi::drm_nova_info_gpu);
 
+/// Copies `name` into the zero initialised, fixed size uAPI buffer `dst`, keeping it
+/// NUL-terminated.
+///
+/// Fails with [`ENAMETOOLONG`] if `name` does not fit in `dst` with room for the terminator.
+fn copy_name(dst: &mut [u8], name: &str) -> Result {
+    let bytes = name.as_bytes();
+
+    if bytes.len() >= dst.len() {
+        return Err(ENAMETOOLONG);
+    }
+    dst[..bytes.len()].copy_from_slice(bytes);
+
+    Ok(())
+}
+
 impl GpuInfo {
     /// Collects the GPU information reported to userspace.
     ///
@@ -37,11 +52,15 @@ fn new(reg_data: &DrmRegData<'_>) -> Result<Self> {
         let spec = reg_data.api.with(|api| api.get_ref().spec());
         let gsp_static_info = reg_data.api.with(|api| api.get_ref().gsp_static_info());
 
-        let info = uapi::drm_nova_info_gpu {
+        let mut info = uapi::drm_nova_info_gpu {
             architecture: spec.chipset.arch() as u32,
             chipid: spec.chipset as u32,
             vram_size: gsp_static_info.vram_size(),
+            ..Default::default()
         };
+
+        copy_name(&mut info.gpu_name, gsp_static_info.gpu_name().map_err(|_| EINVAL)?)?;
+
         Ok(Self(info))
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 5c1f9d296198..00cfcef260c5 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -241,12 +241,11 @@ fn read(
 
 /// Error type for [`GetGspStaticInfoReply::gpu_name`].
 #[derive(Debug)]
-pub(crate) enum GpuNameError {
+pub enum GpuNameError {
     /// The GPU name string does not contain a null terminator.
     NoNullTerminator(FromBytesUntilNulError),
 
     /// The GPU name string contains invalid UTF-8.
-    #[expect(dead_code)]
     InvalidUtf8(Utf8Error),
 }
 
@@ -255,7 +254,7 @@ impl GetGspStaticInfoReply {
     ///
     /// Returns an error if the string given by the GSP does not contain a null terminator or
     /// contains invalid UTF-8.
-    pub(crate) fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
+    pub fn gpu_name(&self) -> core::result::Result<&str, GpuNameError> {
         CStr::from_bytes_until_nul(&self.gpu_name)
             .map_err(GpuNameError::NoNullTerminator)?
             .to_str()
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index 946bd4bf8fbd..c692cacaa552 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -186,6 +186,11 @@ struct drm_nova_info_gpu {
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

