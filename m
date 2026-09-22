Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA78C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4482D10EA38;
	Tue, 22 Sep 2026 20:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Wr+zVj2J";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Wr+zVj2J";
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA36810EA38
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:46:55 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ULpHY/CXTbjcHcvTUyGxXe6b4trUmmUPNqLdy+4Eg7upqnPhN5wEjkNjL+QPVuJp730CH536hlQlbOM5m1zoKYeuO8osyybB1trSw+0GNEYUZjoBC177oPmGU6OMgxwxErEIdf5h6o8xvAeGYp8IlqE3cxD/Y9iG40c3knXYLu54P3EAU+o6CLSgnkbb0jbvqgV96awwdn7KE1wh1WriNAhAcSSiys4f0BCrpK/O00DNXXmg4EYCYjwC/ZT9VMOYyCtyolB6yKFye1nImpTTE4+HQuwOd5zwzl+pD4aDu+shGIMnY1/dMIeTD3CiHZC3+Z2jwLOplh1J3Re3zA3xvA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TOubLhCWENXXq1VGrm6QlvMSKDEp0BBppU4m2n+Ch4=;
 b=cfPe6P+U2QjBsdln+vU4MpndX6LcmlKP4uFcn1c2RCjIJGvUREXkJhwhFefSbK9i5LQNSWXYcWI6Z4qMsChXRZVk+1aHhM5ujjaEgonGbxEKekX1oF7+RzsRk/LdJpd+rFPm1nNHx0OiowcB4Y+ch+9piukkUjFFhOoAYZOzsHdsqK8HTqQgPdAZwaAvUzWY7zmpu+hT/l+G++KqIIVTkAKhbMlAwSny9PpzBadGwOPpaHN7iEg5BX/joC/8a5bl8FL/z1Zl4ORi2qgHji2fNCgUEuvCLAp7ekWo2JxQkFUSKjyDApjYhFtv8gPDp+6u8bakwfuSjVmG5hiAWpqiTQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TOubLhCWENXXq1VGrm6QlvMSKDEp0BBppU4m2n+Ch4=;
 b=Wr+zVj2JqV8b8NO1KmP7KfPFFlaB60nYD3T6xNHua/3GaannS7Y0d+oXdNLGInspreczPBAQ36lI5XwDcBL6GNaY8dSBZN8nlggQgG2KAsSL+gDrWMydW6mQoVY0QmnP0Zr2nr6e3ZUh5+XKkzPm+cZuq54RosUPPrDdzQzx62c=
Received: from AS4P191CA0022.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::13)
 by DU0PR08MB8709.eurprd08.prod.outlook.com (2603:10a6:10:403::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:46:48 +0000
Received: from CPH1EPF0000051A.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::4d) by AS4P191CA0022.outlook.office365.com
 (2603:10a6:20b:5d9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 20:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 CPH1EPF0000051A.mail.protection.outlook.com (10.167.241.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:46:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eg2DRBJQgKYHuV5FfFzQmkea+vppHM1yEg62tppLMAgx22Yb3aRr1k6RBdxNcaPxCgFAOlqBJONQEl3QoLGEmDd7KZS7mYyCaG/tNWXZTIZ1m28YmJSwzrced7vUwEOvG7Uqyt8/kYUBGcfSBSmk37njGJg3gYhZssy5QuJ89YJXveA1mKPRMBQvMp42LzVsqwSzPrzVcUuzgeiIq2fI50Kt6XodOdAy/PIfKXxelWzKVQDrZVJFAcZKUU1abEGllpeRWe4ELWfvVdUKYKEdpGGs+OBuz4v+w/YM1n2CXu9GSLWiXnRkXbApPYIKTmA0qd8BMWdUc1HDkT1matsiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TOubLhCWENXXq1VGrm6QlvMSKDEp0BBppU4m2n+Ch4=;
 b=baP28ATgyb9+UA76NTRo9KzLxLaOyj3/nA5uHP9M+9fCYnERvZ1BJZ1RUUkH1f/Qa6zWFEY19Q0739GpKvneKwgrPZDK/SnQWKYvoqEqj5i6/ppGQfTWOY5IaTRTvSZE/2BpCreOStE3wEK30rFcRJwkKhVCkuVZ129Wxu6a6c4crOZ/LBE8piUkFkNy5x/mexo6h+3objzp9bFSUAizVXCpYsTxSGJH3CPz28P+v196n6w1hwA0cZ4Blt35WegPN11Wo2xRp9edCTzhFJrBjYeLowLsSm2UgwrD9CWL2wjOyj/hSR5njuWBHtvuBHOVOW9ng5oBZI0VZY/Ez8u91w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TOubLhCWENXXq1VGrm6QlvMSKDEp0BBppU4m2n+Ch4=;
 b=Wr+zVj2JqV8b8NO1KmP7KfPFFlaB60nYD3T6xNHua/3GaannS7Y0d+oXdNLGInspreczPBAQ36lI5XwDcBL6GNaY8dSBZN8nlggQgG2KAsSL+gDrWMydW6mQoVY0QmnP0Zr2nr6e3ZUh5+XKkzPm+cZuq54RosUPPrDdzQzx62c=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DBBPR08MB10796.eurprd08.prod.outlook.com
 (2603:10a6:10:530::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:46:15 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:46:14 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH v1 04/27] drm/panthor: Add 64-bit GPU_ID decoding for v15 GPUs
Date: Tue, 22 Sep 2026 21:44:58 +0100
Message-ID: <20260922204535.2850094-5-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0039.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::18) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DBBPR08MB10796:EE_|CPH1EPF0000051A:EE_|DU0PR08MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: ff721487-80e7-4fe5-2a87-08df18ea9ec7
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: qrsfiqXlmtMjstb2kzUXidoZ+GZDgSrwVat3dic75Y8+6PoieVNKxE/8j95A5cYHzdFiqDK+mEa/0oIUhyjm6S7RA1+/RAoYblfNPD39K+lxk0Blhw1CD8sen6nF8DNM25TNlL2Shcp1jOwuGJuMGUsei6LMX1cLwCOT2tNnPApJUO+t4UKgroBzqNaq87jNfI9C9wOGd6ll1ZttuJKuCx6Xl35hNRxjU4LeQzR01slk+/Lhplu+p6uBxfs8NlKnUttTV+YDKRCyuzU67dmL9IrV2lqcJgfl//G5bNwdRKjzwwTaGBo/OjqDroNhySeLUxAwRLwHTI1UUt30t4jS6JH82VLBePFd/AyMHCvwtl7UCj458tlVN7BGMxTu0BUu+U+n4B444GvFd4oxQ8JmHBVCXKG7Aci3cRB2QV71K+L3CllafaY4sD1FnSWMO8Gj4c5x9BrkonpGBXRwcFx8CecxA6eXrTulRo+Yh/pobQgv/zt7VRVj9bbcAVjthXeUoSyjTy6g+bg2W9BCmcU7sTgnUzIPKf+0OqA/Mw5WUA9LNxeR+GIxCarz8G1b/jimVZRKDsvlgIvbI+3QV+TeFbUYveSR3sy/QBggJjPpPINrhPplUoNxNZfBtB704UN65nFfn/7BHPK704t6pOYr9EKfapDS0quWYZxWgF3tjrs=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: fDzXOAM0wVZmZMTPIdpS/zWvGxEPWAZeG3eqSUIrCzrcC8oavS+fdQ58oTlu5Yna3gne2DwLj7pJjn0Cj8R9DMyX7pGWvEEipRLq1oHnIZyluP/WFioo25Cs4TwE2dcSYkZDdHJ15PiAbGspysSISjz2dm5UadU6z4uZbham3jSyzWfJGU4gDN+4GQTfjFSeNfWZ599GvYYMKo32nmdvS3NItSjOXbEawBV8nCiuhDYNYgvbuDm0Ex/ZVaS34EmlFFpiNGp0vSx25wznRB5jfbl6BePriWI4SyZcwd8euPzLz54MMvnDfTWu+mfrAuLvNBLXcc2WuvKx/pgdyitfpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10796
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF0000051A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d435f3eb-021e-4524-42ae-08df18ea8b12
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|36860700016|35042699022|376014|82310400026|14060799003|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kPPCh+Q8RsFzrQUKEHcaa1R6RL4v8Q/xIJKdp3us0edUJRBH9Nrgt0TORg9fDU94qJd9/Bmigjjc56q8wgGMkggbO3skDMvRIigcYwcuhAYzSWZX6+zae0y84+30nZFGZ2BbdLyIio4EvTV6v3Vo+AT0+2FanBkuI8ADr1oFDvSpkFJhxfOm8juGNNCA2H5Ar9lYo1FaPEK3cd1uSq5vQ/cZ3/Vj4iDnUBuuA6N2iNjynod0mJGV+6BCB4uYkv7KCALSyIF5cquNqLXGMPlZO6wTp7rtaF+RQA+80jU86t8yEohqXR0W8uw/vd+UXcbiBuuiu59sb3qEDObJtvAjb0YxMqvPsdKk5oaXFB1YB7IekZ1dQXnBEDYk99oVAlzYp/T13nIih6BEaiYPcXsYuRjOr6Sm8o2nFEEJMlv2QnAebk/FYhPvblubxWuE9TuEOGIxl45o8I7mbOBEYK9029T67ZBPhJboZNaFo5tfjIpm4jwF4V8ewTEIIuvNhffXevsKFSbKUJLkvWUTsTFUNJnneBAirdSYrT6VTD2oucjiQEvr6UoorAbWHbFGNaV/w9N2QTFAEsT0PpXgLecaz5LFmGkY6TNckrVMu0KeQ/0Mnnya6el+/eu7TPI6hn97i9/rEBpZRq71XPwuYxT8//Xg0llasWgyF+IOuwm0NXxXbOvAs5ZmzSIhMVSUjc2d
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(36860700016)(35042699022)(376014)(82310400026)(14060799003)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ojgBZRno6Lc7pTnhwdI3uTvP9t6e+wk6TtB5THjQQZCAUDfQseeFhlkg5srm90fKAM6+3SN4Vx2pwTfsZZvTiNZKyn99EH64fI4Ren+TnhXYg2eC+VhTpVNFafma4F16zku5o2piTNoibsvL1+oqjQiQEBEnBUXVMXdmPIGRo+ilj6sdtzB3qsN50anegcjCA4wV5WqUVmuzJv3W7bEMQK6iW6y/U+yodJ1kweZ8edu4TObn+kEfxenqmv8AwBStWf5AIRJVDLMcg1PHv60hAkpuVfeeKg2O0ZNZMgKpWDqxmOzvz18LVVIpy9Ck8i+V80ZS3pFDcWRAaQCxaeM/iKMhpOOKcSssNf/Qg1ehoYjAcbRODlbEDJViuMQroklGWh2EAjdIzT4tQ+aZcUNplCFSZvA84FFwC81G3pyXDJUtjEF6mVugyrr9fIjtOvp0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:46:47.3600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff721487-80e7-4fe5-2a87-08df18ea9ec7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF0000051A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8709
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

Mali v15 exposes a 64-bit GPU_ID register with a different field layout
from earlier GPUs.

Add the register definitions and decoding helpers for the new format,
read GPU_WIDE_ID when the compatibility value indicates a v15 GPU, and
populate both the cached GPU_ID fields and the uAPI gpu_wide_id field.

This allows userspace and the driver to identify v15 GPUs correctly.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v1:
- Decode selected GPU_ID format after checking compatibility value.
- Document GPU_DISCOVER and GPU_CONTROL register offset differences
  between GPUs.
- Fix mask generation in panthor_gpu_discover_regs.h

 .../drm/panthor/panthor_gpu_discover_regs.h   | 19 +++++++++
 drivers/gpu/drm/panthor/panthor_hw.c          | 42 +++++++++++++++----
 include/uapi/drm/panthor_drm.h                | 13 ++++++
 3 files changed, 65 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h

diff --git a/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
new file mode 100644
index 0000000000000..e6bfe1fe2c68a
--- /dev/null
+++ b/drivers/gpu/drm/panthor/panthor_gpu_discover_regs.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#ifndef __PANTHOR_GPU_DISCOVER_REGS_H__
+#define __PANTHOR_GPU_DISCOVER_REGS_H__
+
+#include <linux/bits.h>
+
+#define GPU_WIDE_ID					0x0
+#define   GPU_WIDE_COMPAT				0xF
+#define   GPU_WIDE_ARCH_MAJOR(x)			(((x) & GENMASK_U64(63, 56)) >> 56)
+#define   GPU_WIDE_ARCH_MINOR(x)			(((x) & GENMASK_U64(55, 48)) >> 48)
+#define   GPU_WIDE_ARCH_REV(x)				(((x) & GENMASK_U64(47, 40)) >> 40)
+#define   GPU_WIDE_PROD_MAJOR(x)			(((x) & GENMASK_U64(39, 32)) >> 32)
+#define   GPU_WIDE_VER_MAJOR(x)				(((x) & GENMASK_U64(23, 16)) >> 16)
+#define   GPU_WIDE_VER_MINOR(x)				(((x) & GENMASK_U64(15, 8)) >> 8)
+#define   GPU_WIDE_VER_STATUS(x)			((x) & GENMASK_U64(7, 0))
+
+#endif /* __PANTHOR_GPU_DISCOVER_REGS_H__ */
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 2143e57d48106..40012ba7e23ca 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -8,6 +8,7 @@
 
 #include "panthor_device.h"
 #include "panthor_gpu.h"
+#include "panthor_gpu_discover_regs.h"
 #include "panthor_gpu_regs.h"
 #include "panthor_hw.h"
 #include "panthor_pwr.h"
@@ -296,18 +297,41 @@ static int panthor_hw_bind_device(struct panthor_device *ptdev)
 static int panthor_hw_gpu_id_init(struct panthor_device *ptdev)
 {
 	struct panthor_gpu_id *gpu_id = &ptdev->gpu_id;
-	ptdev->gpu_info.gpu_id = gpu_read(ptdev->iomem, GPU_ID);
+	u32 gpu_id32 = gpu_read(ptdev->iomem, GPU_ID);
 
-	if (!ptdev->gpu_info.gpu_id)
+	if (!gpu_id32)
 		return -ENXIO;
 
-	gpu_id->arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
-	gpu_id->arch_minor = GPU_ARCH_MINOR(ptdev->gpu_info.gpu_id);
-	gpu_id->arch_rev = GPU_ARCH_REV(ptdev->gpu_info.gpu_id);
-	gpu_id->prod_major = GPU_PROD_MAJOR(ptdev->gpu_info.gpu_id);
-	gpu_id->ver_major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
-	gpu_id->ver_minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
-	gpu_id->ver_status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
+	if (GPU_ARCH_MAJOR(gpu_id32) == GPU_WIDE_COMPAT) {
+		/*
+		 * GPU_DISCOVER register block always starts at offset zero,
+		 * so does the GPU_CONTROL register block on pre-v15 GPUs.
+		 */
+		void __iomem *discover = ptdev->iomem;
+		u64 gpu_id64 = gpu_read64(discover, GPU_WIDE_ID);
+		if (!gpu_id64)
+			return -ENXIO;
+
+		ptdev->gpu_info.gpu_wide_id = gpu_id64;
+
+		gpu_id->arch_major = GPU_WIDE_ARCH_MAJOR(gpu_id64);
+		gpu_id->arch_minor = GPU_WIDE_ARCH_MINOR(gpu_id64);
+		gpu_id->arch_rev = GPU_WIDE_ARCH_REV(gpu_id64);
+		gpu_id->prod_major = GPU_WIDE_PROD_MAJOR(gpu_id64);
+		gpu_id->ver_major = GPU_WIDE_VER_MAJOR(gpu_id64);
+		gpu_id->ver_minor = GPU_WIDE_VER_MINOR(gpu_id64);
+		gpu_id->ver_status = GPU_WIDE_VER_STATUS(gpu_id64);
+	} else {
+		ptdev->gpu_info.gpu_id = gpu_id32;
+
+		gpu_id->arch_major = GPU_ARCH_MAJOR(gpu_id32);
+		gpu_id->arch_minor = GPU_ARCH_MINOR(gpu_id32);
+		gpu_id->arch_rev = GPU_ARCH_REV(gpu_id32);
+		gpu_id->prod_major = GPU_PROD_MAJOR(gpu_id32);
+		gpu_id->ver_major = GPU_VER_MAJOR(gpu_id32);
+		gpu_id->ver_minor = GPU_VER_MINOR(gpu_id32);
+		gpu_id->ver_status = GPU_VER_STATUS(gpu_id32);
+	}
 
 	return 0;
 }
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index a2ff0f4ec6915..843a0b40e1d36 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -376,6 +376,19 @@ struct drm_panthor_gpu_info {
 
 	/** @gpu_features: Bitmask describing supported GPU-wide features */
 	__u64 gpu_features;
+
+	/**
+	 * @gpu_wide_id: 64-bit GPU ID for v15 and later GPUs. @gpu_id is 0 when
+	 * this is populated.
+	 */
+	__u64 gpu_wide_id;
+#define DRM_PANTHOR_WIDE_ARCH_MAJOR(x)		(((x) >> 56) & 0xff)
+#define DRM_PANTHOR_WIDE_ARCH_MINOR(x)		(((x) >> 48) & 0xff)
+#define DRM_PANTHOR_WIDE_ARCH_REV(x)		(((x) >> 40) & 0xff)
+#define DRM_PANTHOR_WIDE_PRODUCT_MAJOR(x)	(((x) >> 32) & 0xff)
+#define DRM_PANTHOR_WIDE_VERSION_MAJOR(x)	(((x) >> 16) & 0xff)
+#define DRM_PANTHOR_WIDE_VERSION_MINOR(x)	(((x) >> 8) & 0xff)
+#define DRM_PANTHOR_WIDE_VERSION_STATUS(x)	((x) & 0xff)
 };
 
 /**
-- 
2.43.0

