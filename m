Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BEAC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D01910ECBD;
	Wed,  5 Aug 2026 05:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="CKEZEnLC";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DDD210ECBD
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:45:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2vmBNm8ZKdTku0c/Anu0IioZs069BLEwuKmIsqG06YRTsuoDuWw+FtFRMmnsKZ8ihwcFZF9uaEcVs0YaNfxa3IlFTgs297ynLGmLcIAVhkcSJgbZieAIvBtz0MzONTDX6tHwWe+V2VyH69xpZ8sYVXsgC67yEFe16tet7+oX7Cla2HedE2wW82PENuESGyOFY5otl363d8bjuRV+yH28Vh05AOBjNCi/+zSrNhaC9nv4c5zVw4HhAk8unPijBwKigzkVIYjP5/YuVSGL+DvFBJiH8PNW5fpjABmu5mclkASoK29WwTi2sbPGUwoHtO0n6P53vYo0qjEQhMMV8a19w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KjGLUsdeDbF05LW8xaG7z77P1x04IOr0/x4163CZxY=;
 b=r5BvVS26zUFooKgs4KiH8p6T6cFx+NRledTLAuWCVgi60WfF2yQ5jBqQ1eE5EnXFwZLNyY3y4VMFUOR1sMRouGqPRcpqxVBK0A9p8Vi5h7Yo3Zv4P38QhPum1nZCtUeP5KE6weF/eGWNtMfYtrK/UBvsN63NuEktA8GyAkg/ynA6+CaA8upBh0zPs5IyOgMA7mzhttmdNz0LIvQ7EwmA4P5U9EBE+nZwTHAzxicqWBwRnw9tf00Ry3gFg/bd71RG/Bqqi8ELIeGp/mDCdLbgEXSH27hXTu3flp6RwngZr5tAecq7UgkNemxAhG5HF2VcwmK3w/vns+/+ov7Z1UkPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KjGLUsdeDbF05LW8xaG7z77P1x04IOr0/x4163CZxY=;
 b=CKEZEnLCP3Tu1dd1owvciXofzd+iMWfU6u3vakgpcAl44ozsucJF4Y94a1z09oVY04xnN05Cibn/wMnhTCFiiCHWCZU9gdB3QmlDtfaSdGyAm03fe6DOgkW3TKX4lNr6Y93LOKutdGp/5htDa3qkafFNMGX4YCfuAhTNsyD4QRY8UTCWK08UdoZceKpEO1QoDu2DWSBf1KuXqJLmZyjkrdrupNDZywTSaMstzLcso45I27LBEwviQH3X8ms/7X/OOhZFcFUnniygKAF/1fZazRXhfnxbmCqVC0AHL367Ws0XA8/TLZH/lnfSIgoA85X7b2i/e2h7tR9ZSoV9+S0Eig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 05:45:35 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 05:45:35 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 05 Aug 2026 14:44:53 +0900
Subject: [PATCH 06/12] gpu: nova-core: mm: Add PRAMIN window registers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pramin-split-v1-6-ff3e84a75dac@nvidia.com>
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
In-Reply-To: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Yury Norov <yury.norov@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0044.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 08aeb838-d536-434b-9e0c-08def2b4c55a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|10070799003|10067099003|11063799006|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TiOBOYcgfm50halVEhQvmhATbLaHiIts/uP5QVz+PQn+gh3cTO0BnX3RwOkPDmXWeEPsc8nuaYRqOlsCJ97PF0e6K5IbM5UayjOjCSaSH/VWTvQKxTuIFhTd7MJ6OsveoVNftGygjr3JvyA5BgRzRBaANbt+x4faSTEmCeMO+778sRol4pGUkcqKMDit/wkfpA7BSYMq2RARzfoJFzoaGtoZRL2yvksqUx3QalJtotZyLlsF/yN6K+Uoj1VBbvtsxvzz/W/iSZMyIqVQ8nihbsCLEBymKhwmT85vsvponIMEBYXd0O4XcldVc/nnHURMjYxMZuDP79wsWkOUoI0gsJs/3Ma7SDkm7GVBOlDDm92wv1rAjNXXxg+HdHpjaxbg0zRwx7KkpxT/iAx1zwq4YCGk4eVE7VZYzYaGAgX7BP6RQZiJRUQMoIgzXM/jYS9n0/Vk3Vw+7KCZVFVIbtZ/pcY+jdOl3uLXFgLseVAY9BMVtyDw5EO7yhqKiVALHm53ppnzv3TPQip8Eb2Gk0MK64mtahereFQBlAffsJGlz0MCwkVlTWPEfRF/POG9HlJZMcOCT1GM2entwp7EKmOtLluX6iSyF11ogAqrO53g7LoNTdgM3LjQT6xhYLjQk57Iagv9GTrSdKDsUX74uMYLZeUUQOzxTvJB7OIoAXN7PIPlABWiBo6mC3twDqy2XYu2Hbk2g0pTdVDwoAS0jYXe3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10070799003)(10067099003)(11063799006)(56012099006)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2dzSE9mN2UvWHQ4TlU1dEtTLzN3YnBWT0Q3bkxKcG95L2d5MHBmMEhIYytO?=
 =?utf-8?B?VTJxNE9sb0dIdlZHSXJtMFUxcWdiZG9oblBJejVGcWIrbTZpOXZucTFhdDBS?=
 =?utf-8?B?V0VrRGZRcUsrVC9uY0IzVUgzOU1mbFZ0SVJvWHdnOFp6WitQR0tUWjRPbzZa?=
 =?utf-8?B?dU1PTEx6SmpYV0VQNE1najByQTQrRDhIRnkrYmpTV0p4MFg2NWptRzBpR3BH?=
 =?utf-8?B?V2I5OHpQY0VVdVl0U3JqQ1l2T0tOVlZUeWpxa29ySE15RUx3ZXBZZW1pd0tm?=
 =?utf-8?B?VnRwNXYyUFdEdVQrbU1GejFiejN0SnJpYldOZVNmK0daVTh2eHFuUmsvZmFa?=
 =?utf-8?B?aGVQa0ZLcEU1Z0I0eEwrZ1A0cWtlYjJYbTA1L3p1M2grZmhUN0lralRKamVm?=
 =?utf-8?B?RCtkNzA3RmszM0VxeTQyYkJ0UXNtVlA4bVd5TlBRN2tsQ1dKU1YvNFhwTFFX?=
 =?utf-8?B?Z0VQT2tQR3lHY3Fkb3BwTTBuOFcrTWVHVG9aS3RMNCtjNWZTd2xOWG9ublpX?=
 =?utf-8?B?N3Z4NTA5aTQ4MGdSMUlITUNCY1h0VWNqSWZqZlZZcVJiUnBuUWlkSEVWTXJY?=
 =?utf-8?B?R1lpYlk4Nk9OenJucngwMDZSUGlZY2ZPTDAxRFhnNHNlb2xrSHF0Q1BkYjgw?=
 =?utf-8?B?aVZnS3g5TkVxS0VWUmRpemdtVWRCVGVsUnVLWWUzd3A2aUlxVythUHNqMWZB?=
 =?utf-8?B?N2tmMTh6bDRPdldyMTVPdDk5ZkdLRGEvMFEwUTZOZkNxSEdESE5aYzRHK2JZ?=
 =?utf-8?B?RVg2cUlpeCtDTWpzdEY2N1lqY29LWXEwNTFOT0Y5LzlCMjFGdjVBeHZpaW9W?=
 =?utf-8?B?Z2xmSXpnRzBKZ3BHY3dFUXlhWHp0S0ltTEN5YTJDUTVnNkRXeWFiNlB0YlJh?=
 =?utf-8?B?ZWErZVlLMFEzRGVvekNqSTVxOExHN0xIbUpMUG9XeHEzRG5IL3E0V01QcCtO?=
 =?utf-8?B?NWY3ZXVVZkhVanovMk83RURPczh6RXpxcXFwRHRwWjc4M0xyUzNpcmVodXZM?=
 =?utf-8?B?RTJnVFhDZXhYTEptQjRYekVEL1Q1L2FidC85eFNZMk5MLzgzK1pMVUQzalk3?=
 =?utf-8?B?YXcxcGJsc1dqTGdxaXFkWTJza0h6TEp4WWE2ZnI1Mm16M0ZaQ2lHeW1yU0NH?=
 =?utf-8?B?Qko0UUlydGhodnVkUzk4NjFiZDRxdjEvbCs0OEtnOUhFUEF6WGtsbTFJUjFl?=
 =?utf-8?B?aWxJaTdydlNqaHliQ2ZNWTFpMDEvUjhldlN6cVRlMTd0ck9YMDlTT3NUckd3?=
 =?utf-8?B?aWJmd3dLQmVMOWZ6TW5iS293N1Myc1RoOWZDbnk1UU1iUjlVdHV6RW9JWThz?=
 =?utf-8?B?MjlTb21Ta3cveEhFM1ZuZmp5NkZZR2ZtTXV4SEdKaDdOWVJGQkxFcVJ1c3ht?=
 =?utf-8?B?YUJXQ1NzdEM0VUZlb1VlRkdoZW00dXZNL2ZFNjBHZGxVeGtCNWlDa0NDYXV4?=
 =?utf-8?B?NXBCR1Z2alJ4QVplNUdnUFVxUHB4S1ZZTFY4a3ViZ2E5N2hScmJhb0IwYU9Y?=
 =?utf-8?B?VmN5M0FCcGRTWU5PSlU4MTBEdDFjZU50bm9vcm5QdHFoZHZUREViWU1kdElR?=
 =?utf-8?B?elV5SlhpTHVCMTdtWGpVZWlVb2dqODZISEthREtYckdKajJpbURPOVV1aEFF?=
 =?utf-8?B?d2krRUVicDhZTUk3b2ZZQ1R5Q2N0ejhDV1hwUkJyL0MyTlpMN3pVNEFEeU9r?=
 =?utf-8?B?azFIQ3FKY0djdjkrVTg1RWJiTmhvRm8wZndLODJNUnc1S1hSZlBldmtSajFW?=
 =?utf-8?B?MHdPWnc0cFhVZHBzS3Fhb0hMNWlhTzJ6OU5sMDl3MkppVk8xbStoc1ozSEgy?=
 =?utf-8?B?aUdvSW40U0NKWThBcy9WZSt5Nkx3QjRDcEpEQzhvdHltKzBzRXJ5and2TGND?=
 =?utf-8?B?KzBHTmdtaXJtMktlcUpKNm0ybzl5RCtVSC9oZTdjdW9qT05KYmsyeTA0dlUx?=
 =?utf-8?B?TjAyM2NuZmhMd2J0T0ZXWTQ1SHVicWpUWklvTkVUTW4xNktWeEFKeUFNQTZ1?=
 =?utf-8?B?YkVKMWx1TjlpSkhzb2ptVDZ3aHEyczN4TGxiVHZOYmZKNnJ4RjlLbGkxemlJ?=
 =?utf-8?B?T3d3bm5PaDNLY0M5aGNXaTRJcE5SMTBqT211SWxZajZ0c2IvMVhSMWgvdlY2?=
 =?utf-8?B?R0dFS1d6OW5aUFVoZDhlcllncDVVcDhMYnhhRFRPLzFKd1NndzZLYVpMRi96?=
 =?utf-8?B?YlpaYW4rWWtlRC9uLzBhcS9rYURFM2Q4dVYxUFVEMzB3YWo4a3pyeG52dE90?=
 =?utf-8?B?bVdyNFhwNlc1V24wd29XbnlyVFRmSUNIT2VpcTdYdlJFMEhuZTdlUnlKM0Fo?=
 =?utf-8?B?cDdUT1loQUVzMks3VnN2dkZRMlFlMkhmR3h2c2Z4Vk9ITzk2ZHBzd3ZnbTh0?=
 =?utf-8?Q?DlZ//qu/mfTtuTR/jK4+nCQQptcbJUtl5gFr6sgJAuEye?=
X-MS-Exchange-AntiSpam-MessageData-1: kgtYuQmiA+FSwg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08aeb838-d536-434b-9e0c-08def2b4c55a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:45:35.3554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0sNhXadeytOMTmKcQ2s9DS4P60mYQjsRwk+SB4CvFuq2xXODTLcOXxRLeVrIJmRys8YZjHoe+Q5RI5Pjp+0XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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

From: Joel Fernandes <joelagnelf@nvidia.com>

PRAMIN apertures are a crucial mechanism for direct CPU read/write to
VRAM. Add the BAR0 window registers that position the PRAMIN aperture
on all supported GPU architectures: Turing, Ampere, Ada (via
`NV_PBUS_BAR0_WINDOW`), Hopper (via `gh100::NV_XAL_EP_BAR0_WINDOW`),
and Blackwell (via `gb100::NV_XAL_EP_BAR0_WINDOW`).

Hopper/Blackwell window-base registers are based on Eliot Courtney's
offlist reference patch.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: split the registers out of the PRAMIN patch into mm/regs.rs]
[ecourtney: drop the register read path]
[ecourtney: reword the message for the split, narrow visibility to mm]
[ecourtney: plain base fields, as the bitfield cast+shift patch is dropped]
[ecourtney: rename the target to VidMem, fix derives, redo the target docs]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/mm.rs      |  2 ++
 drivers/gpu/nova-core/mm/regs.rs | 57 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index f9d80ffbe01d..7d24ad790310 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -19,6 +19,8 @@
     },
 };
 
+mod regs;
+
 /// Physical VRAM address in GPU video memory.
 #[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
 #[repr(transparent)]
diff --git a/drivers/gpu/nova-core/mm/regs.rs b/drivers/gpu/nova-core/mm/regs.rs
new file mode 100644
index 000000000000..541941918add
--- /dev/null
+++ b/drivers/gpu/nova-core/mm/regs.rs
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+//! Registers used by the memory management subsystems: the BAR0 PRAMIN window.
+
+use kernel::io::register;
+
+use crate::bounded_enum;
+
+// PRAMIN window
+
+bounded_enum! {
+    /// Target memory type for the BAR0 window register.
+    ///
+    /// Only VRAM is needed by the driver. Pre-Hopper window registers also define
+    /// system-memory targets that are unused here; Hopper+ uses a separate register
+    /// without a target field.
+    #[derive(Debug, Copy, Clone)]
+    pub(super) enum Bar0WindowTarget with TryFrom<Bounded<u32, 2>> {
+        /// Video memory (GPU framebuffer memory).
+        VidMem = 0,
+    }
+}
+
+register! {
+    /// BAR0 window control for PRAMIN access.
+    pub(super) NV_PBUS_BAR0_WINDOW(u32) @ 0x00001700 {
+        /// Target memory aperture for the window.
+        25:24   target ?=> Bar0WindowTarget;
+        /// PRAMIN window base bits 39:16.
+        23:0    base;
+    }
+}
+
+pub(super) mod gh100 {
+    use kernel::io::register;
+
+    register! {
+        /// Hopper register for PRAMIN window.
+        pub(crate) NV_XAL_EP_BAR0_WINDOW(u32) @ 0x0010fd40 {
+            /// PRAMIN window base bits 37:16.
+            21:0    base;
+        }
+    }
+}
+
+pub(super) mod gb100 {
+    use kernel::io::register;
+
+    register! {
+        /// Blackwell GB10x/GB20x register for PRAMIN window.
+        pub(crate) NV_XAL_EP_BAR0_WINDOW(u32) @ 0x0010fd40 {
+            /// PRAMIN window base bits 38:16.
+            22:0    base;
+        }
+    }
+}

-- 
2.55.0

