Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473B9C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D9A310EEF7;
	Wed,  9 Sep 2026 06:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sf1fOhEQ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED1C110EEF2
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+nXQMjhxgfz03nhgZnE624uBr6JA2pCay1sEV7iAo+lD/x4XrbP/eBL5pzZ6fuysMrCMHzsYJJZiQR0zMwiJIrQYvNHhCsalfQ23s8jjKwI2vdHha6joW9BhCoaNhwUTj02MkJV7sAgXVwrlOI/SvkTuDewlvbTje93YaSMlE71/1Z7H3ieND5V87mZrEZPLQQtNSIj21bjH3ZLk66SULnQRfGl7A0rR+YAXPxj4Zv31SePRwLkL20XLHt53iFuMBAD9RmFZNqPckL11bu9ZkreBl4SqE0N6FZz2zafNRXTHQZDZ4Xfn7je3RYoqZa3+dk7oczLu2HJj+YPHpI9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTaV1fFNEJNn0+qyBa7L8zmBmR/35eNVUjZuIo6Z3RE=;
 b=cWt8Ggn0U3L+wGofQF2F+Q5mD4MefMx9Bjn8YodEdOwhN7dqWmRh5Si2AnaxlK4P/CYayQ43tMKuieQ6vf83BkqEH3jzQQhNbSTTy4ATTAYReUZEF+EnyvV13WyRCKIAIGOfXoAdRX68kmQozfR/TJT5v0Eqo0E7cJtzjMw6BTDSpX0br/nJtdLro+3F7GSO1diDI/hiKz4wDGs1u4v+cUciM7ejGdfQt/ttTySaTaF1Pye0kaKE8nNvmhpwod+X+9TxGYoX8wDc+lpupT+Cv0DZo8A9/2apEM8VBSvx2OWGkIAu247tmZ1Bg9gRBfsQLk3/1ygqDzXfkw4srR2WXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTaV1fFNEJNn0+qyBa7L8zmBmR/35eNVUjZuIo6Z3RE=;
 b=sf1fOhEQSwxqnepl720dEoZ+RhNc7WoVfcegCwl1XpHqDDlIF7TgtBhr6Mi24uJhEdi8jz8ZSzLpzQD/BUS0ebgGqLPeiLiaGry9pGhCb01pJrVRBRy41wQc1CG4PcxCeHJd6IaiB4INhvci6lRNookFyQAQjAcACuwhLtInJhuMKTf6tQdk7/5BSWoGtoArA9nF8is3WNryy6o3iH0ZqJsUV6iDWEvKaJM6dVzLqRr3dKMBkj+VP3xJTJKuTxnniVSyA9cqRezLpsDiR6CAPSELvK8dxk26q3Zg1DCBovsgaj95LhEOEw+7f8BO8I2F1kI9Qv7tXlVqHnpwMXZREQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 06:46:27 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 06:46:27 +0000
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
Subject: [PATCH v6 13/13] drm: nova: Report GPU GID in GPU info
Date: Wed,  9 Sep 2026 16:45:06 +1000
Message-ID: <20260909064506.910162-14-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260909064506.910162-1-apopple@nvidia.com>
References: <20260909064506.910162-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0069.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::13) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 969438b2-4788-45a6-bdbf-08df0e3e1256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|56012099006|10067099003|11063799006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UxGTdy7yMoGIYARHOW0DngoejOrFeQIR9v8G2hlmKivlGDn5/pLe+CM4i02+w7FN1CL2eViGybXdwJRxewFQLdoYvJYUwF9HvFZtFe0o3qCWKBt4NIV43nIjJggXFgGUWkxk62oydyVgud0Dl8AX6vdjAD7ySb09gLxMurxjWrtY1bx8RRFGP5544avqeaElB2HWr4EwlfxGbdK5JSzsPKiTU+sk/qwG0sjLPuP3xcZzkD6jqPHQjZUV9im5fm7HyVyKgBtgeExaPN0aIf3ij1bI4Yb4hGrV1+78/vtFRpq8X2ftN7Cjh7d4zbJETin/KchBA9UxKQaYbmFE/O+73omiulCl2NEC8tX+5w7S7s2SSuZYC9wAo/JemDup+TXV17l387Z92rDbTvG2iEn+m5ok3d/7HUp+L2hbNkWN8i7j5fmfRCZMCzcfRuL1jAxU0hThGJljsZ0rMVsbrxtcivik/rVYrvgmGIdUCdgG7kQ+V7NSdM68il5H5aIxmhivXwgnN6PVme4BBzeH9WBZuJxEcJ0Da9FldB1HFu18SMf6POC549y3xy9ws6echDj4uxje2sSygrd+FyQv2J2k5b7uuFVr0SkjMZX9Z/N5PwK5aywqQg56hiwP4/SOJOCU9sFF99WONqsywX7BGLWnhUguXh/3IXBBpcaNzBGVNk0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(6133799003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k8bjZ2TkkKYidtGeTbP4KNlWpGsLzWu9WJWOS1SBsXg9J5+RtZ6BzeZhAKiR?=
 =?us-ascii?Q?O2s4rL7FQOwcxIm936GkUldxAL1DuzB9tPCq3NgJMZfmLBSFuGHq6uMPH9+/?=
 =?us-ascii?Q?geavrdHSYTAiC0OGUNW+QSSdF/8z6GKEP1K/qRXfFOmSryh5Pb1mo7TIIEnL?=
 =?us-ascii?Q?vY4dJ/D/yzXNaXRmA3PnsjUtLZKHUynFeMRUUfr9WKdE+B0mG/WyX+3iHEJC?=
 =?us-ascii?Q?mdIAQpM4jTu3QmqU/EfmKdgxauVBVjB4Vg4Db9xbSh7qhRves6XTuaFYu07V?=
 =?us-ascii?Q?b8++0kLRrjVipw2h47fAwrzV92n6CV1q2fWSZMKsMvAwVAWAoRIp1CfJwlRL?=
 =?us-ascii?Q?oRbcSlLmA0xYoaMY3cklW+RQwuw/qNJZu6jSfHQkK9FmDbH/VM9v819htfyQ?=
 =?us-ascii?Q?WSkFkWeEhpcj/FA3HSgMfxsu0mQROUJbiQoO5sDllfeBE4ezvvspIDNQmi5M?=
 =?us-ascii?Q?OnfxID8XEbb4Ys8RBUKaDvGHBiLH0DmLISKIygw5I0z+R2ubg0E18dAERLaM?=
 =?us-ascii?Q?E2MqR55HxIQmtjfBq28n0kmfQObo1TtlFgeIknUqCBfI4n7iSleGUhLrGZjr?=
 =?us-ascii?Q?HHJII8X/GlN4XUszTHx1gFOoLS11BlcBNsHQzpT+zpjGVt6HhRCAMIANmOQV?=
 =?us-ascii?Q?QRVER5ioglz+N35ja2qawKNwW+j0CGv5olhzumPwBOnfJ2h1cNcDlZPikf8D?=
 =?us-ascii?Q?Vj2XIleLUPkGpoMOdGFi5RgbF8WUQjlCpRTzMnNUFXkoWYrXgA7yDD8eZUMY?=
 =?us-ascii?Q?xcRyA9jPGYY9F4AVWpL7q27Z5yqLZVSxi7FDbYxKKHTLhpntsKgZanrnUcAn?=
 =?us-ascii?Q?BAf/fFNlXbNFhZwZffCibiJ4KOrO6p6UokP84wLNAGKLNj8N7++MnbQHFAmX?=
 =?us-ascii?Q?gRZ4rNo1E8LCHn656ofwze9OyQdqMycsgaUBwuG7g3qPaPP2j7gAyCMEaYaT?=
 =?us-ascii?Q?rM4ckUlF5maDTDDgQvGETO7lsKYguHeMDvBKqQlX/shAmDRelg+oaVVGbjBc?=
 =?us-ascii?Q?V6/KjGEUfZH3SSROWUIVuMJjIdDQ6DuEZJFib4VE7ydEalXemATbCjWN+aCd?=
 =?us-ascii?Q?mFh25JIgxKh43peFeW2qSqq0I3VEO/xoRXr8Jef30hS2I4IHtd7ZjL7hStvG?=
 =?us-ascii?Q?of2LiIh939J2VNeKtxUQuGiku+COKTA+Pm/W8H7L1o61CmYJWh2qSQOnJ0UY?=
 =?us-ascii?Q?mwzQTwVj7PRNXdepz1MOY3EOMoSVW3nF6craKmk6VgHjTSDYVejPtesNwsPG?=
 =?us-ascii?Q?WBvpotP/Xf6WqMoUQ1hdd0yeXs5HB+3M+xRfAWPnfmdtHalaWtpzvZut8oXR?=
 =?us-ascii?Q?ELruyMQc7xBApHYCBvPJi1rKI2ipF8+kxXll6JO7oa3ALRvkcBJR0zFwSskf?=
 =?us-ascii?Q?Pa1K7Hmp+UNoQk60SVBqYL7H2GX/0JX6ah1y1FW8xB0jo+VPnJZU1iCLCtG8?=
 =?us-ascii?Q?XkoxiTsem/WratpSIh0fErn2LV8ymKJtyqsERcMhhPdTZ3ZzH62GxeZj0jeK?=
 =?us-ascii?Q?eZgx7kPMOu81KJ3WpF463uAcy67oQessbESqmQGoah8razPkJxqIXbkLtwQa?=
 =?us-ascii?Q?vkDepsopR1wjFlZsrrQssHFMiWyyTAV83x+xPIQdu6GRXgoYCpn8yd5l9Ug2?=
 =?us-ascii?Q?Zsx3pxpYiDFw64wGc2Vhu8P5mCV0merpEva7q1F/rmQnYGeoG8nhhi0lTnMx?=
 =?us-ascii?Q?y45b7ChlSgsdzXDbOSVe5TkubQlr9ep24ll6iX5R+8Ya1zQgYx/PV+9w+56C?=
 =?us-ascii?Q?2tpDQNiFHA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969438b2-4788-45a6-bdbf-08df0e3e1256
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 06:46:27.1358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHof99bmnqJCrbODZRIc5U1b+cYGFHDlN0hIjXMkPrMrgrd2jA6H6QYnX2B66OIyXHiu7ne0qno75ZTz+ZM+2g==
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

Add the GPU GID to the reported GPU info. This is the 16-byte SHA-1
based identifier GSP-RM reports for the GPU.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v5:

 - Read the GID from the GSP static info exposed by nova-core rather
   than adding a forwarding method

Changes since v4:

 - New for v5
---
 drivers/gpu/drm/nova/file.rs             |  1 +
 drivers/gpu/nova-core/gsp/commands.rs    |  3 +++
 drivers/gpu/nova-core/gsp/fw/commands.rs | 10 ++++++++++
 include/uapi/drm/nova_drm.h              |  5 +++++
 4 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index d2e1f9f798a4..7f7f0a0ba622 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -56,6 +56,7 @@ fn new(reg_data: &DrmRegData<'_>) -> Result<Self> {
             architecture: spec.chipset.arch() as u32,
             chipid: spec.chipset as u32,
             vram_size: gsp_static_info.vram_size(),
+            gpu_gid: gsp_static_info.gpu_gid,
             ..Default::default()
         };
 
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 5ea0f625f7df..40cef8332eae 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -215,6 +215,8 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
 pub struct GetGspStaticInfoReply {
     gpu_name: [u8; 64],
     gpu_short_name: [u8; 64],
+    /// The 16-byte SHA-1 based GPU identifier (GID) reported by GSP-RM.
+    pub gpu_gid: [u8; 16],
     /// Usable FB (VRAM) regions for driver memory allocation.
     pub(crate) usable_fb_regions: KVec<Range<u64>>,
 }
@@ -236,6 +238,7 @@ fn read(
         Ok(GetGspStaticInfoReply {
             gpu_name: msg.gpu_name_str(),
             gpu_short_name: msg.gpu_short_name_str(),
+            gpu_gid: msg.gpu_gid(),
             usable_fb_regions,
         })
     }
diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index f62fb85f4473..d1ce2f1aeda9 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -136,6 +136,16 @@ impl GspStaticConfigInfo {
         self.0.gpuShortNameString
     }
 
+    /// Returns the 16-byte SHA-1 GPU identifier supplied by GSP-RM.
+    ///
+    /// GSP-RM reports the GID in binary SHA-1 form, which occupies the first 16 bytes of the
+    /// GID info payload.
+    pub(crate) fn gpu_gid(&self) -> [u8; 16] {
+        let mut gid = [0u8; 16];
+        gid.copy_from_slice(&self.0.gidInfo.data[..16]);
+        gid
+    }
+
     /// Returns an iterator over valid FB regions from GSP firmware data.
     fn fb_regions(
         &self,
diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
index b0af9945b6c5..9283660a04cb 100644
--- a/include/uapi/drm/nova_drm.h
+++ b/include/uapi/drm/nova_drm.h
@@ -196,6 +196,11 @@ struct drm_nova_info_gpu {
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

