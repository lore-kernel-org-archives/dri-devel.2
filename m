Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE461606A339
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 05:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VefpCUWo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F3E10FD20;
	Fri,  6 Nov 2026 05:44:52 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012022.outbound.protection.outlook.com
 [40.93.195.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4D4310FD20
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 05:44:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XskJiIvzkstYm8FJp3Pp+7rEEFCv1gld3jd0RePRBSr7TZnH8cdB/iUuu4TtUDypIhL7hrdcrj3nyQzBswRQIKWNtWZCWs3jv6Hs26iYf7VbJ60FKedH+NBRb3KsXuWZOlZaM5C+mFg5wckcM/T1/KcoKyG3lJh2pb7X2ey1O8yGaFlGzErT69SsM7HRM+1twosqAFClRQ8T/TvUNStPPgeelXqcrjvKIk9No/ViHN0Pf27kDhS9CtCFSTho79nK389FodD7VeQgGvCAT9XV394YUEaFfbPBRFgJZaAF3ZumILyKvVzfuDyyq0hSEnRADTOCJV9XGKZeEBQDPCDGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a19CVipS4QeMorzUhMkuw7qeJE4jDZ1YvhgEs79+kJw=;
 b=P48c2ZANF4s/2a9izsJgdfoMskEhJNU1odnQnYcxGxJ2mcFgdE29Vv8o3mNniOgtfCe3v1yMhkQv0kQOVdp1xELOL5eE0ltmAb1awohETQ9r/surVdJxMtAdgbHfzAtbvGDQZ6s4J396ocmuileLEzXsnGE8TuA8TnbYoMUMlWQltYOmtLmWt6xKTJ3eCaF4JMJMPE0Byrt9xhdZVthOBhk9mNNcrNUetyuep2JYbq9HTOw8aG9MIJAHXNTmo/MNOCa0oWfgCkj+tSR3HQSHqtqrnrcibpchxzcFNpkdQ6wJdTUi9zSrNM1ek1ib/HdMN6qc/3hphmNzKWGCZm0aRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a19CVipS4QeMorzUhMkuw7qeJE4jDZ1YvhgEs79+kJw=;
 b=VefpCUWo0UAhHrWC5ZHgtTGCIMP0eWMfzTkJmo6uBhL53Bplup8UPGrc/bPaaE3iOneEssfkF0MqMi0pR+4ZLEmdbYz7pZWWbgnUieFwMIh0Rs/LvxNciZvbRKb9r0qHcKA/0B9kh6JuUUb4W2s1JmtU2TQBgDiTv5q4BDnsRAaYWOYUeGOm5111wv7NnWBJiYyFNTv27F5EW/Fzr3hl7rULYI8vPBLZXNynI+SFapHLChZkP+SFppvnaLa5w3GQpjlZVmeO9opYRcPP0IypAnVIlftwr8+qqABS5oxem8bZuoMawrn78bMJh2vfvi64afD4abUHMeKCby06M3SN7g==
Received: from CY8PR22CA0001.namprd22.prod.outlook.com (2603:10b6:930:45::6)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:44:40 +0000
Received: from CY4PEPF000392D8.namprd03.prod.outlook.com
 (2603:10b6:930:45:cafe::a) by CY8PR22CA0001.outlook.office365.com
 (2603:10b6:930:45::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:44:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF000392D8.mail.protection.outlook.com (10.167.247.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:44:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 21:44:22 -0800
Received: from kalok-SPC741D16QM3.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 21:44:09 -0800
From: Alok Kumar <alkumar@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <jhubbard@nvidia.com>,
 <apopple@nvidia.com>, <joelagnelf@nvidia.com>, <ecourtney@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v4 15/32] gpu: nova-core: vgpu: add r000 plugin bindings
Date: Fri, 6 Nov 2026 11:09:48 +0530
Message-ID: <3b7d5e1b1538e27ce000d8c6360502f8728ad9b3.1793906667.git.alkumar@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793906667.git.alkumar@nvidia.com>
References: <cover.1793906667.git.alkumar@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D8:EE_|SJ0PR12MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 25fe5341-23b7-4239-f0d0-08df3bc90ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|7416014|376014|1800799024|22082099003|6133799003|18002099003|3023799007|10067099003|56012099006|261022113327099003|11063799006|261021121427099003|261021135927099003|261026121527099003|261009223027099003|261102123227099003|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: JYxekwVAwm9D2/L0zTj7Q2AHprbivd3jARkWtxaNJPuecYHXTKNKwMJLrnARN4NLa5Y/tclVKp+CfdLHB74igBqHKlvzk4Ybz+tVkoAPCP29hm/vOjoX67p0pCgNCZJk0M9m7svm2ldFKsll/ogwr/hTttWDimKu2GfzW2BacT06OlCMb1ibIn3fieN1q2PhNS4yNKTCEtW3c6QbHvoQT5Nekx8gs+K/OwvVN6O5yOoOlL31EWB97fUvl6AZ5ZgJotn+ajFb8lsheT1a6zZM1yWuV972L+bZkT038owVHUOLsY9qZCBAodj0HjO4aKeiLSd2nvCepJUK5TZv2kEyyEMl1ewAJf+sfg01k+NPpNnJ3MRntRXQoeuB/pEtiKmpDWMp48456b5/Z90SQmdNnruCekkbUFGOnpcBSJhpSXG2DiOym5gmAjXFZipKQd4jVzj+xYpIVmcoKm5Znlmj/vz4U/b9DViPDl8JV5z5RfE1iraT0e8Ul3WR4tlZ/WmeJCdGjqbJ/PmS7sqPyYy16mwbl27oLD+F9b/X5uWMNtVtgSTA8OyaBrkH6rnyu5m0WgzJAUtgyyYYSuUPI1yOMU6rnGMPFbXBt9uTrCuis3WqLor9oEI5AtiBjlO3o7ljtg5uMT9oRpIoPxCq3GbXZe1DNvN3aGU2PKH3d8ubr/S8FozdpFyfRoJEbLmX9HsX5dgco0nonPB9QJqrh3DdPA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(376014)(1800799024)(22082099003)(6133799003)(18002099003)(3023799007)(10067099003)(56012099006)(261022113327099003)(11063799006)(261021121427099003)(261021135927099003)(261026121527099003)(261009223027099003)(261102123227099003)(260925022911599003)(260925021911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9NSGf5Y1MMRwZX8YAmh4JDBu0OiSthVyuJSqivUqQ6PgGu9zKpCB36QMOi9ujtJoE7DTUKkRDjYcx6ymEX9YtmrqJjAljdF/QNO8Sk0hYF5xUiXdJKu2b6Rchov/IZBvjfJ25Ui8pp6RkrdeJvqmshsL2poVzwr4tGwX8zC5c+ITucKxpfYpXulGnBpozT02zCA+SZGTze51mIWk7L/zz+UD8QDOSDhqvygV9HtskGAyPF3o+7WbZFf+rtgRKE9KlGMIf7xKPWMapEjxdlf8kTzLOFtAL3xesBN2b36oe+AJaSHhhX1NWD4GqPagYdkuAh0Lb+i6IDXHqQPXB/N5EAJZ/XKBKcxUqMuP/921qZ/4r91W2FZJml1d5lteMXeRMtVVL50ItfdPS4DlqmAksVxcbnaz9EJ54oAx+M5WVjZOmuh+TT29n9g5AA8oGMXo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:44:40.0233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fe5341-23b7-4239-f0d0-08df3bc90ce7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392D8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhi Wang <zhiw@nvidia.com>

The GSP plugin communication area and RPC protocol are defined by the r000
firmware interface. Keeping local copies of that ABI risks letting the vGPU
manager drift from the firmware layout.

Extend the existing r000 binding set with the nova-core subset of
dev_vgpu_gsp_shared.h. The bindings expose the control and response
region types, message IDs, and firmware-defined region sizes. Keep the
raw declarations private and expose only the symbols needed by the GSP
plugin communication layer.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Alok Kumar <alkumar@nvidia.com>
---
 .../gpu/nova-core/gsp/fw/r000_00/bindings.rs  | 173 ++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs
index fa17d3e2edf6..3cc718bb2ab8 100644
--- a/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
 #[repr(C)]
 #[derive(Default)]
@@ -850,3 +851,175 @@ fn default() -> Self {
         }
     }
 }
+pub const GSP_PLUGIN_BOOTLOADED: u32 = 1315261039;
+pub const VGPU_CPU_GSP_CTRL_BUFF_VERSION: u32 = 2;
+pub const VGPU_CPU_GSP_CTRL_BUFF_REGION_SIZE: u32 = 4096;
+pub const VGPU_CPU_GSP_RESPONSE_BUFF_REGION_SIZE: u32 = 4096;
+pub const VGPU_CPU_GSP_MESSAGE_BUFF_REGION_SIZE: u32 = 4096;
+pub const VGPU_CPU_GSP_MIGRATION_BUFF_REGION_SIZE: u32 = 2097152;
+pub const VGPU_CPU_GSP_ERROR_BUFF_REGION_SIZE: u32 = 4096;
+pub const VGPU_CPU_GSP_INIT_TASK_LOG_BUFF_REGION_SIZE: u32 = 131072;
+pub const VGPU_CPU_GSP_VGPU_TASK_LOG_BUFF_REGION_SIZE: u32 = 262144;
+pub const VGPU_CPU_GSP_KERNEL_TASK_LOG_BUFF_REGION_SIZE: u32 = 65536;
+pub const VGPU_CPU_GSP_GUEST_RPC_TRACE_BUFF_REGION_SIZE: u32 = 65536;
+pub const VGPU_CPU_GSP_COMMUNICATION_BUFF_TOTAL_SIZE: u32 = 2637824;
+pub type VGPU_CPU_GSP_BOOL = u32_;
+#[repr(C)]
+#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+pub struct VGPU_CPU_GSP_VGX_VERSION {
+    pub major_number: u32_,
+    pub minor_number: u32_,
+}
+#[repr(C)]
+#[derive(Debug, Copy, Clone, MaybeZeroable)]
+pub struct VGPU_CPU_GSP_GUEST_INFO {
+    pub vgx_version: VGPU_CPU_GSP_VGX_VERSION,
+    pub guest_driver_version_buffer_length: u32_,
+    pub guest_version_buffer_length: u32_,
+    pub guest_title_buffer_length: u32_,
+    pub guest_changelist_number: u32_,
+    pub guest_driver_version_buffer: [ffi::c_char; 256usize],
+    pub guest_version_buffer: [ffi::c_char; 256usize],
+    pub guest_title_buffer: [ffi::c_char; 256usize],
+    pub guest_branch_buffer: [ffi::c_char; 256usize],
+}
+impl Default for VGPU_CPU_GSP_GUEST_INFO {
+    fn default() -> Self {
+        let mut s = ::core::mem::MaybeUninit::<Self>::uninit();
+        unsafe {
+            ::core::ptr::write_bytes(s.as_mut_ptr(), 0, 1);
+            s.assume_init()
+        }
+    }
+}
+#[repr(C)]
+#[derive(Copy, Clone, MaybeZeroable)]
+pub union VGPU_CPU_GSP_CTRL_BUFF_REGION {
+    pub buf: [u8_; 4096usize],
+    pub __bindgen_anon_1: VGPU_CPU_GSP_CTRL_BUFF_REGION__bindgen_ty_1,
+}
+#[repr(C)]
+#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+pub struct VGPU_CPU_GSP_CTRL_BUFF_REGION__bindgen_ty_1 {
+    pub version: u32_,
+    pub message_type: u32_,
+    pub message_seq_num: u32_,
+    pub __bindgen_padding_0: [u8; 4usize],
+    pub response_buff_offset: u64_,
+    pub message_buff_offset: u64_,
+    pub migration_buff_offset: u64_,
+    pub error_buff_offset: u64_,
+    pub guest_rpc_trace_buff_offset: u64_,
+    pub migration_buf_cpu_access_offset: u32_,
+    pub is_migration_in_progress: u8_,
+    pub __bindgen_padding_1: [u8; 3usize],
+    pub error_buff_cpu_get_idx: u32_,
+    pub guest_rpc_trace_buff_cpu_get_idx: u32_,
+    pub attached_vgpu_count: u32_,
+    pub is_gr_init_done: u8_,
+    pub __bindgen_padding_2: [u8; 3usize],
+    pub host_info: [VGPU_CPU_GSP_CTRL_BUFF_REGION__bindgen_ty_1__bindgen_ty_1; 16usize],
+}
+#[repr(C)]
+#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+pub struct VGPU_CPU_GSP_CTRL_BUFF_REGION__bindgen_ty_1__bindgen_ty_1 {
+    pub vgpu_type_id: u32_,
+    pub host_gpu_pci_id: u32_,
+    pub pci_dev_id: u32_,
+    pub vgpu_uuid: [u8_; 16usize],
+}
+impl Default for VGPU_CPU_GSP_CTRL_BUFF_REGION {
+    fn default() -> Self {
+        let mut s = ::core::mem::MaybeUninit::<Self>::uninit();
+        unsafe {
+            ::core::ptr::write_bytes(s.as_mut_ptr(), 0, 1);
+            s.assume_init()
+        }
+    }
+}
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_VERSION_NEGOTIATION: MESSAGE = 1;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_SETUP_CONFIG_PARAMS_AND_INIT: MESSAGE = 2;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_RESET: MESSAGE = 3;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_MIGRATION_STOP_WORK: MESSAGE = 4;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_MIGRATION_CANCEL_STOP: MESSAGE = 5;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_MIGRATION_SAVE_STATE: MESSAGE = 6;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_MIGRATION_CANCEL_SAVE: MESSAGE = 7;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_MIGRATION_RESTORE_STATE: MESSAGE = 8;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_MIGRATION_RESTORE_DEFERRED_STATE: MESSAGE = 9;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_MIGRATION_RESUME_WORK: MESSAGE = 10;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_CONSOLE_VNC_STATE: MESSAGE = 11;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_VF_BAR0_REG_ACCESS: MESSAGE = 12;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_UPDATE_BME_STATE: MESSAGE = 13;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_RESET_MIGRATION_BUFFER_PTR: MESSAGE = 14;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_RELEASE_CLIENT_DATABASE: MESSAGE = 15;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_CHECK_IS_ALIVE: MESSAGE = 16;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_SEND_STATIC_INFO: MESSAGE = 17;
+pub const MESSAGE_NV_VGPU_CPU_RPC_MSG_MAX: MESSAGE = 18;
+pub type MESSAGE = ffi::c_uint;
+#[repr(C)]
+#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+pub struct VGPU_CPU_GSP_DISPLAYLESS_SURFACE {
+    pub sequence_update_start: u64_,
+    pub sequence_update_end: u64_,
+    pub effective_fb_page_size: u32_,
+    pub rect_width: u32_,
+    pub rect_height: u32_,
+    pub surface_width: u32_,
+    pub surface_height: u32_,
+    pub surface_size: u32_,
+    pub surface_offset: u32_,
+    pub surface_format: u32_,
+    pub surface_kind: u32_,
+    pub surface_pitch: u32_,
+    pub surface_type: u32_,
+    pub surface_block_height: u8_,
+    pub __bindgen_padding_0: [u8; 3usize],
+    pub is_blanking_enabled: VGPU_CPU_GSP_BOOL,
+    pub is_flip_pending: VGPU_CPU_GSP_BOOL,
+    pub is_free_pending: VGPU_CPU_GSP_BOOL,
+    pub is_memory_blocklinear: VGPU_CPU_GSP_BOOL,
+}
+#[repr(C)]
+#[derive(Copy, Clone, MaybeZeroable)]
+pub union VGPU_CPU_GSP_RESPONSE_BUFF_REGION {
+    pub buf: [u8_; 4096usize],
+    pub __bindgen_anon_1: VGPU_CPU_GSP_RESPONSE_BUFF_REGION__bindgen_ty_1,
+}
+#[repr(C)]
+#[derive(Debug, Copy, Clone, MaybeZeroable)]
+pub struct VGPU_CPU_GSP_RESPONSE_BUFF_REGION__bindgen_ty_1 {
+    pub message_seq_num_received: u32_,
+    pub message_seq_num_processed: u32_,
+    pub result_code: u32_,
+    pub guest_rpc_version: u32_,
+    pub migration_buf_gsp_access_offset: u32_,
+    pub migration_state_save_complete: u32_,
+    pub is_migration_allowed: VGPU_CPU_GSP_BOOL,
+    pub __bindgen_padding_0: [u8; 4usize],
+    pub surface: [VGPU_CPU_GSP_DISPLAYLESS_SURFACE; 4usize],
+    pub error_buff_gsp_put_idx: u32_,
+    pub grid_license_state: u32_,
+    pub guest_os_type: u32_,
+    pub frl_config: u32_,
+    pub guest_info: VGPU_CPU_GSP_GUEST_INFO,
+    pub is_guest_info_populated: VGPU_CPU_GSP_BOOL,
+    pub guest_rpc_trace_buff_gsp_put_idx: u32_,
+}
+impl Default for VGPU_CPU_GSP_RESPONSE_BUFF_REGION__bindgen_ty_1 {
+    fn default() -> Self {
+        let mut s = ::core::mem::MaybeUninit::<Self>::uninit();
+        unsafe {
+            ::core::ptr::write_bytes(s.as_mut_ptr(), 0, 1);
+            s.assume_init()
+        }
+    }
+}
+impl Default for VGPU_CPU_GSP_RESPONSE_BUFF_REGION {
+    fn default() -> Self {
+        let mut s = ::core::mem::MaybeUninit::<Self>::uninit();
+        unsafe {
+            ::core::ptr::write_bytes(s.as_mut_ptr(), 0, 1);
+            s.assume_init()
+        }
+    }
+}
-- 
2.53.0

