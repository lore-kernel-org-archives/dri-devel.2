Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05D760A3835
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SHbuLEJ6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01C0811225D;
	Thu, 19 Nov 2026 21:51:50 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012066.outbound.protection.outlook.com
 [40.93.195.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87DAB112478
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 21:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/xen4lkTobKLbQLR+acbHM1yfK7AiMva0K8KbBojPulpJ6jsvjlTF5OPQH2ON82147BHG73hNTvTzlfWHompVqqXJtGUC7mvuZJZabGUXdIMO5+YCEojaFJf6H9RnyytyvlU0p/pm1Zv54rQHXVkqB9okq0RDzfDs0PFcWWF+Gb65xpXkcnXcYebtfFFY2gKLI3DmCp+OCkfRZoKFXCe+WnUcCYBVCagP1mg9F1c6xczAr/kOTzcD1qOoUamSZ/3JOeEpGWGHVM7c8aqnFQqKR/ugaw1k50P1n+4pTVlzgggF4Ug1t10lvXdALf4jdSoCwbF0k/UN/wXWGE7qq/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AF2nlMmAdDM9BUNsweS02SXLCgKxd9C+JZaknkQxdi4=;
 b=Ny9KnxECojzTtP6A3U8f5t1nJUIbchzjC7Z0MDE+iidJiheQCCRUB0a1pG3Ni6OZsmCrwwf0KQFHZvF1c3MEQQcKTIOw2wmUoCsxJWTeRAPuCJSo6RmOKYRVTT1OSrObUmRVszjGfW2a8wRkV5Fn5rxEHg5CalnjIqIt0YDPFVOvu5XFiGBNH5+NkQgY7m3WnehLUcAIoNzMPMYw/ANA2EYJPzFrtDAtVEN4g7xjmvboPJnAgT0SRKoOufrkUq3SKns2DrzF8guXBQSTbmYV7HbEwqYsFqjKSQbp3OCJBXOcFy9Lb+Q1c33kjb6bzzvYDXoyz6KMuHGdnSQ/Vi6KLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AF2nlMmAdDM9BUNsweS02SXLCgKxd9C+JZaknkQxdi4=;
 b=SHbuLEJ6xrV/IbA+u0D0S96bFArvXnh5j3Xi93uvAgcaFjWbHNMVsFzgT6bfn5ph3m/OTkFF8RB2+HqOUTJKGOiO38uQpwa9Wog94+Z1nlfPQ+ecutStFUvZc02c0XSZg4m6Jz2o/ekKntUTmkfzWv8sf2JpJDdbgG0HZKR5CBMBUbfph7HYtMqm0bz7Brz7FrbPZPsR4ciIhiluNO18oWzJMAWM1O+S7D1o19ZoUm66B5WFFYHjxcSjSp5yUW5SWsgRS6/a+l3rr1HByz727Ig+GTzFc/UpN48Nq7nLGe1k02yrO3DSeCGy8nmCv5G00Ca/lTpztziSO+xxXxWEHQ==
Received: from MW4PR04CA0232.namprd04.prod.outlook.com (2603:10b6:303:87::27)
 by DS0PR12MB6557.namprd12.prod.outlook.com (2603:10b6:8:d3::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Thu, 19 Nov 2026 21:51:33 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::61) by MW4PR04CA0232.outlook.office365.com
 (2603:10b6:303:87::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 19
 Nov 2026 21:51:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 21:51:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 13:51:07 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 19 Nov 2026 13:51:05 -0800
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <jhubbard@nvidia.com>, <ecourtney@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v3 1/9] rust: pci: add VFIO override device IDs
Date: Thu, 19 Nov 2026 13:50:36 -0800
Message-ID: <20261119215046.2892839-2-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261119215046.2892839-1-xinmengs@nvidia.com>
References: <20261119215046.2892839-1-xinmengs@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|DS0PR12MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 98a04970-2d27-403a-c4b7-08df4687468f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|7416014|18002099003|261009223027099003|22082099003|3023799007|11063799006|261026121527099003|56012099006|261021121427099003|10067099003|261102123227099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: QhIqOPsRdXmfFyL5zroxoKH4ZLd0N3Qn5cYQo4dcz1bJtBsV/FyAsra7dfWdcD5Ne7jM2aAxk4mzQ3x+57GBqV0OwnoJduCoz6z7LiZTA29FaxgVL8F6mevPQ46LNSdg6gYcF4vVJoL+Q3wQ9hMS9UMI44wOnGqrGgdTJNy+eE6pDF6BFw3vQzdHx1Xm/gzMRxW07ZeyGsAqkbJIX3txg56xT/7sLyQCToBrjTi+UIUinXjUjb3Dc8iKwXmIarRiyzb+P2qVcUD3B7GR4AvBEFwjASMoMR1+XHOAVHKVbqWSSD1ak45CiJGZMXgYhJbYM+EHFghXBHq9cdRUfrG86jB9Mdfvw957I4mPkgbDPtudaxEG9+HgHeBWBsCbi7BxsK0p5x9AY3NbKIaA6Nlh6Eq5CkXxwpdmBUqLS6rts2C2xFEC/qgTRIZdC5T0K8ucEOMMUonRH61YOOhYNCUUq2bmIIhUE1np85vGn/hOgqHUjUe3hfcMQUBg1yxNd01UllB5G8nrMXkSzLCs3ez6+gWEFjYrZN3cRcjWoh/BRsdd1Ho0Rn1gBZAqrSd/OKzNQ5yS8Oul+8KUrCyGJl4UoQV5SO/68jBAdxGKKFyH9qJF/XBQOx3p4eoziG/FQ3iNoskMTO/OnF7qqGHiqvgOVii9AEmJvoUs1KojTboj3fpgYo7RZcdTJwxJL8mfrp1VlB2x6fRjwMoQU//9q9e4dA==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(7416014)(18002099003)(261009223027099003)(22082099003)(3023799007)(11063799006)(261026121527099003)(56012099006)(261021121427099003)(10067099003)(261102123227099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mhWmz5CZfo6wm+nDWphTK22lyg/VZxhk3a44yKBXr+5OQ0PPYZ7FAbdMROjAmFwDab/5CzjDYIF95bsSEQmcBf+5jB0iTr3U+p0fAEOVT/uZM1yUwM4Yidv2fmbR+BV5yInn03qmbBAN90h6Ydkm9Om3jUhUq952aHPzAjR4CMLwTWKwNrwfSpCKUrVkQu4Tx0PuXv+f2SzYRKJ7axnV3E0IBr3AJBb7NeYnzFPgbpKmTXR27XSbuUuw1fy/EbMMQJnx/KXTzbZUCD0ZoWTOFCzkxwlT9MuzIf/PS9jn18aE4R2+DK7NqUVh7+A1k/bHhaCJIXZBPM/PmlFJbfUiFgh8ni6vfrI9IS9tzDAQFfBZR7CWyw2+mo/0tyKs2/SA59mnOIcrGy82QMmT3/4ugbZUsOzyee79prPMMLb/4LYSTfDLfydA3O7HdkIkKAoE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 21:51:32.7606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a04970-2d27-403a-c4b7-08df4687468f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557
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

From: Danilo Krummrich <dakr@kernel.org>

VFIO variant drivers need override-only IDs and VFIO-specific module
aliases so userspace can select them for PCI assignment.

Add a DeviceId constructor equivalent to PCI_DRIVER_OVERRIDE_DEVICE_VFIO,
matching a vendor and device without restricting the PCI class.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/pci.rs | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 4887052d31b1..fa67f2fc26bf 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -209,6 +209,21 @@ macro_rules! module_pci_driver {
 impl DeviceId {
     const PCI_ANY_ID: u32 = !0;
 
+    /// Create a new `pci::DeviceId` for a VFIO driver from a vendor and device ID.
+    ///
+    /// The ID matches every device with this vendor and device ID, whatever its class, but only
+    /// once userspace has selected the driver for the device through `driver_override`. The
+    /// driver is never bound to a matching device automatically. The module alias generated for
+    /// the ID has the `vfio_pci:` prefix, which lets userspace find the VFIO driver for a device.
+    ///
+    /// Equivalent to C's `PCI_DRIVER_OVERRIDE_DEVICE_VFIO` macro.
+    #[inline]
+    pub const fn from_id_vfio_override(vendor: Vendor, device: u32) -> Self {
+        let mut id = Self::from_id(vendor, device);
+        id.0.override_only = bindings::PCI_ID_F_VFIO_DRIVER_OVERRIDE;
+        id
+    }
+
     /// Equivalent to C's `PCI_DEVICE` macro.
     ///
     /// Create a new `pci::DeviceId` from a vendor and device ID.
-- 
2.43.7

