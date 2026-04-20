Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E819F588C5
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:13:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B897510E5D1;
	Mon, 20 Apr 2026 13:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xt8B8SmO";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011018.outbound.protection.outlook.com
 [40.93.194.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C64210E5C4;
 Mon, 20 Apr 2026 13:13:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rxi6RYTsmAgzM8m/dOGyr9yrJHu/Gv0+kPFSGSGGBgAX8h2e1PaBhk2wRo62HualWr/62zysLFJEYn8TwSPdk1AfFRIMlHmtfDPm1uFoSgR3Bc7vRsQhQhwWGzZB5m52nWSZaoP00QX/I9ES4q8krJq2L7xzHfwu+LunAhqmHsY86/7Dc9rFJxXBrVGmmMT4VDp3VuEmHdBKs5xzcHUw59LkuhWvmPmfRH79Nkqe6ko9V3HzYGoW1N4iRKMSyNodZZw8NBmLbDYbmK3z8hjkN2MNzM780vpyOF3n8f5Ik1pcJRNcHhAekBficxQsi7CJYclN5GGRObQh/DZzCOpUBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiKcJE+3PZ2+1jGqCXx/FSgxsJojFVHwJEQHn5LbZbg=;
 b=DPvVhm6Tce7xXMUsNjEzBS7M+oblAOg+LUmrQcoUrVcfFghkjdWBT0HwnLFhP9zonN9oDFbkxfaNU52QmujbdHaEMmS+i9uINEssNfi7uuaPgvOyhTMKrURYWwbY/VMz7TaPaTnSu+emcVGBisaStqIzbN3eNehJB+UHB5n8MKVxslN1+day3Y9QmbtSIG9VFsFgJ2bzS3/u9ElnOKw66GSHSEOB6y8vGlgWs6jISyjFb9M8rJH8xYYDqrdlnH3P6hFeOj01jTY0cPAEpIsYtHNoXZ9giZ+ozUbAksscvTzvYNVq0vxhF0mOdfXz0NVLklHliUAISL/Q2TzxwcQJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiKcJE+3PZ2+1jGqCXx/FSgxsJojFVHwJEQHn5LbZbg=;
 b=xt8B8SmOqesdfnzvJVeZcoYf9kNY7+SVDifsYCej5Ca0AiJVRmg+EniwQmZ0DU/4tty61cxVNrnN9g9VBpQfq2EQzsdlDoKi/d3/Urxk73Zx04Ekxbxxiw1eRo/r7QdjAiYtw3+ESi5eP1nAX8B4Eu0sI/GN4pKf1xt5MuZLv08=
Received: from CH0PR03CA0063.namprd03.prod.outlook.com (2603:10b6:610:cc::8)
 by CY1PR12MB9649.namprd12.prod.outlook.com (2603:10b6:930:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 13:13:41 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::df) by CH0PR03CA0063.outlook.office365.com
 (2603:10b6:610:cc::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 13:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 13:13:39 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 08:13:35 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>, Honghuan He <honghuan.he@amd.com>
Subject: [RFC V3 01/12] drm/amdgpu: define SVM UAPI for GPU shared virtual
 memory
Date: Mon, 20 Apr 2026 21:12:56 +0800
Message-ID: <20260420131307.1816671-2-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420131307.1816671-1-honglei1.huang@amd.com>
References: <20260420131307.1816671-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|CY1PR12MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: 010fcf42-6778-4979-9fe1-08de9edea3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jQtFwQGouTBfs/wKNN27smO3yZDVo4CsIfCxOmqTbHHca3YSZ88h7x8luYdJgn9zutbA7i0ZUTbZi3GTah0GvWdfLiRnaS9VQIt8IYFSSbu9dSCip+wg09nypJkEii2HWDdlZMKL0Ourwd+ydJHrxRT8CZTJH1LNhAbi/SgCzZWErza+kWhhlNn6AXrD+A2b4F81vZaWSsgE3pEG86eHhw1JmVtk9bdBQh1C8dZSEgA0Q2Rz/AH0oE4VpNf+Wy5jy+T8VjikeGvk3Tf31WHZoxR/qbHT3f44t73PNNT4+/iTK8GfnxfTF1B73tsERcTKmAx5RYhPTtw28ABoB92Ih+UnTuXDgfmqZKsHyxeZBRC7Ku5rd58PeFIlBH096j/2Qv8gWe44690/U9zugdr+0mgVyMcTL0r7y9ucy57nTt7jSfNPAMiS7uhcYk0Z9pzkBX12qkUHlv20Wfv7mPWyfnZ8p9L9ujesmM5/dCSfHKu66e6vt44zxpwHbSp2URyiervsKyE412AnffdoZsW2efCHEcIt/tQQRBXb20iZ6gcXQNnzaj7N/A0YV7p3wqK1KaD6Ec0oK8Vv0xpn7CaodI6hjACs+dv0YpfAO8l/9qao8q3WPRLEXkUQ7x4328MRwlXMyaxicnw5XrvbCUGcd/jgd+S2Ve2yP1JpKAV4bkLjZ9ROnNX3tbMXXEn3hOqOaj6SzH8YNgEoi5wlsgh69PHAul/9tzhwZCY6fRSBki72jod9hAoRj0Lugs7V6JJEP/paWARFfvLYYuB8QYkHLRlVVydmEuaHF76RyQDIiFKiZ7wkDyvzrAg56nN7P+7Y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6T6/poTMnNexMyNg7L6yU+0xVtmvPICOaXz4v46XjPE+bOtBYBSUo/X4YSSIhE7ujpce8w9DnEgNjEYdCzPUpcVf4aK99ocwyU5SewlaBKx6pwAT78GsJYfqIFn7SZUed8NCM0QlS4b2dfH2k4AVgrHBn7vTvVmToNSmRygmrPNp2qpdCuGh77Th+dGoBYuFtLIKpN+MXAZOCK6s0bdLcrsZYQPDGyJ1+FZ4gEqeiGncrK6m05Uc9lPT4gk4YiJb/loEhoKQqt5pkNx76bdA8V2uZz1lC1xcP+vgbS2we0bBeSdqCZ/V9obopxIZS7vh9Kiw4xRbpm4FroVWeC18015LWA7lkQT/mhXAiwJajaDxn7sutJ9y3q7x4NKAYvfH1wosLxcX0/f2QyvB43MBKcV6MDSi0KyLF2uxzxmgNjmnccHZORx3ftfrS3Nzs9Yh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:13:39.8498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 010fcf42-6778-4979-9fe1-08de9edea3a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9649
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

From: Honglei Huang <honghuan@amd.com>

Add user-space API definitions for the amdgpu SVM subsystem built
on the DRM GPUSVM framework.

Define ioctl DRM_AMDGPU_GEM_SVM (0x1a) and the wrapped
DRM_IOCTL_AMDGPU_GEM_SVM command.

Memory attribute flags (AMDGPU_SVM_FLAG_*):
  HOST_ACCESS, COHERENT, HIVE_LOCAL, GPU_RO, GPU_EXEC,
  GPU_READ_MOSTLY, GPU_ALWAYS_MAPPED, EXT_COHERENT.

Operations: SET_ATTR and GET_ATTR.

Attribute types (AMDGPU_SVM_ATTR_*): PREFERRED_LOC, PREFETCH_LOC,
ACCESS, ACCESS_IN_PLACE, NO_ACCESS, SET_FLAGS, CLR_FLAGS,
GRANULARITY.

Location constants: SYSMEM (0) and UNDEFINED (0xffffffff).

Structures: drm_amdgpu_svm_attribute for per-attribute key/value
pairs, drm_amdgpu_gem_svm for the ioctl payload containing start
address, size, operation code, attribute count and user pointer.

Signed-off-by: Honghuan He <honghuan.he@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9f3090db2..a315adb7f 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -58,6 +58,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_SIGNAL		0x17
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
+#define DRM_AMDGPU_GEM_SVM		0x1a
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -79,6 +80,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
+#define DRM_IOCTL_AMDGPU_GEM_SVM	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
 
 /**
  * DOC: memory domains
@@ -1673,6 +1675,43 @@ struct drm_amdgpu_info_uq_metadata {
 #define AMDGPU_FAMILY_GC_11_5_4			154 /* GC 11.5.4 */
 #define AMDGPU_FAMILY_GC_12_0_0			152 /* GC 12.0.0 */
 
+#define AMDGPU_SVM_FLAG_HOST_ACCESS		0x00000001
+#define AMDGPU_SVM_FLAG_COHERENT		0x00000002
+#define AMDGPU_SVM_FLAG_HIVE_LOCAL		0x00000004
+#define AMDGPU_SVM_FLAG_GPU_RO			0x00000008
+#define AMDGPU_SVM_FLAG_GPU_EXEC		0x00000010
+#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY		0x00000020
+#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED	0x00000040
+#define AMDGPU_SVM_FLAG_EXT_COHERENT		0x00000080
+
+#define AMDGPU_SVM_OP_SET_ATTR		0
+#define AMDGPU_SVM_OP_GET_ATTR		1
+
+#define AMDGPU_SVM_ATTR_PREFERRED_LOC		0
+#define AMDGPU_SVM_ATTR_PREFETCH_LOC		1
+#define AMDGPU_SVM_ATTR_ACCESS			2
+#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE		3
+#define AMDGPU_SVM_ATTR_NO_ACCESS		4
+#define AMDGPU_SVM_ATTR_SET_FLAGS		5
+#define AMDGPU_SVM_ATTR_CLR_FLAGS		6
+#define AMDGPU_SVM_ATTR_GRANULARITY		7
+
+#define AMDGPU_SVM_LOCATION_SYSMEM		0
+#define AMDGPU_SVM_LOCATION_UNDEFINED		0xffffffff
+
+struct drm_amdgpu_svm_attribute {
+	__u32 type;
+	__u32 value;
+};
+
+struct drm_amdgpu_gem_svm {
+	__u64 start_addr;
+	__u64 size;
+	__u32 operation;
+	__u32 nattr;
+	__u64 attrs_ptr;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.34.1

