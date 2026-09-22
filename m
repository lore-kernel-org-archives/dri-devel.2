Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAF7C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C1510EB5F;
	Tue, 22 Sep 2026 20:47:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="jJKHlSRy";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jJKHlSRy";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013019.outbound.protection.outlook.com
 [40.107.162.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C82C810EB5F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:47:27 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=YQBlmcVFP3f/mXqhbooiC0o067oemCeg45olnnq6O4PuT81CUoKZvPI+vrInCzmj859/ZhhiCUrhfIvkzCAZnFIuUhzovPOLHetYFru4u3jlnFtqvIrvknA95hZczQYMrrf+rBdmh4dXWz2X1mOy2V1vs/5zOWn0Vq9huI11O/OaBblSITikCt+0jo7k6cETWHR2E8yXRM7HxqQDxlkGAOhRWaEiDXRjGZ72cbv8m7MG/oe6JGCJXzwZy/a1hRFjcX8p7MuqHWWT83qxN1ijWXBARChJH+siE1BiI5MniKE8f8p28kcJdFBImndp5m6W/LAjKx8d7CsXGEytTEE4Ow==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKCYPQnmKMXMA1fzQ46hp1KTByU1+gXLfUU7WOtzneQ=;
 b=hh22DVwgb2DbAYPfRUpSQm1BgLaX6Njzn207zC9zc4ncPGemaCgOI9Rcul4o3dvZehIaQgTEplffNbqLqMMwsiXM2v3YHnaf73ej12R2yPbIBKIEAyaYns7ZV34WQQVIBXjUikVJVcVoombRSjvCQmuYQrZ134JNVYjuOmmHiltgwCf+p2E00FZORoFXng5qPaZh2Yg2MYYO5R/MeuE54JAyDlAptdN5pjxEMpIzYynwDHYnCAr/HCqCKO1IA80nyAaSzc+E9nCf5j+MtGy63hLx7qyQrUCizBaqXxFWf6KSZJEwzaYap0A4pQOoMv9lV97Ip56IHsl/FyFHRlNVAg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKCYPQnmKMXMA1fzQ46hp1KTByU1+gXLfUU7WOtzneQ=;
 b=jJKHlSRy0UHxeudMO+Qgb32Ek5TOHcPyUX3S86quQr0XiFshzV7xnJo3FVENKRo+vY8GaNRcu+2ZdScqCabCdewzY/a1VE0e5GDkkYXnpDX9mRIYiZHBT9lLH8gdJPWhJJi0zgFzClEu4qWSGC8OY7BMH5q+Tk1ayR8UYhsalTU=
Received: from GV3PEPF0001DDA3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6ca) by VE1PR08MB5840.eurprd08.prod.outlook.com
 (2603:10a6:800:1b2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:47:20 +0000
Received: from WA1PEPF000099CF.eurprd04.prod.outlook.com (2603:10a6:1d8::167)
 by GV3PEPF0001DDA3.outlook.office365.com (2603:10a6:158:401::6ca)
 with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.406.11 via Frontend Transport; Tue, 22 Sep 2026 20:47:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF000099CF.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 20:47:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bc3cSlruXD8UBNBAmca2/j+nsI0PoFCc44xQxnHcN4wrnTi8Vsa707BdenTlbd+QQjmvguSjQ1eOC+y2clUQto0jGPVrO7DoB1CwTnBQ7Sx2tlyHw/bh6na7Y5DQ5YNVdnfXWRgg5aOytScB5TY2PxC3JJegi04IBqlmK1Jgx1tbH/r2H/c/3AjZFUVKGriddabWUDZAq+B+sGof7sozrwPkGagiH5FyteRxXWVXFH4AyktWibwa8F76BkKs18LCm9r32EE1bwTfJpBWQ7ylNMUpevCXGAqIZ9aj9MTM/+iFwztV0cYyLSSuX7Vk5fMR6NrQj9Uw9pMWLnZDq1zl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKCYPQnmKMXMA1fzQ46hp1KTByU1+gXLfUU7WOtzneQ=;
 b=IrJynkI4CyF0kYU/egYy/eHM5v9IEdEcTE5L0PVT/FC964QI9TX9+uPc61GO47VQTI9u341YwxMGJfqcTmF3YMyk4MGf+qY5ehsotbshICQGjeR90SNyaCeW/SytAvmKzbvKgSUN6heTFEFnIrVUgn0ycrWaX//GZGy643QmSdyPmwtRFvxcgJdYj/rw5wxxxs6FLDUUeJKSpepRQvLGoq627fEeC7x44DC4IYrh6siD9G1T9uug/077bLS0fazHrwmQPmo0FnebDyjwVYW2+ZF35a46osKPCgH/KO0aXB6zZ0TyJZ8s4/+zpu9fwKPlyA25hCdqHRRS//tzI/thBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKCYPQnmKMXMA1fzQ46hp1KTByU1+gXLfUU7WOtzneQ=;
 b=jJKHlSRy0UHxeudMO+Qgb32Ek5TOHcPyUX3S86quQr0XiFshzV7xnJo3FVENKRo+vY8GaNRcu+2ZdScqCabCdewzY/a1VE0e5GDkkYXnpDX9mRIYiZHBT9lLH8gdJPWhJJi0zgFzClEu4qWSGC8OY7BMH5q+Tk1ayR8UYhsalTU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DBBPR08MB10796.eurprd08.prod.outlook.com
 (2603:10a6:10:530::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 20:46:47 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%3]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 20:46:47 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 11/27] drm/panthor: Add AM_SYSTEM platform driver
Date: Tue, 22 Sep 2026 21:45:05 +0100
Message-ID: <20260922204535.2850094-12-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922204535.2850094-1-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0216.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::23) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DBBPR08MB10796:EE_|WA1PEPF000099CF:EE_|VE1PR08MB5840:EE_
X-MS-Office365-Filtering-Correlation-Id: c91a91e2-92e7-4b1a-c573-08df18eab231
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: 4DJtYL3tSNkMFY/drM9w6SBUkmWQuz6qmv/jvtznNEkR1oWmozpBzBQRXIrHfGw8psDPiKs/+IyOjCz2sVbACfGsG4PbQczhlWsuMsvucZsyESX0XJbhc6QNN07MOzVFsqPWSuaRZqKF9etova8bPR5j4zHUWD+xbhxMQAGxTYiXoZo4Pa/KblYRRd+7THllZHQ6Iix+iaUoJa+Kzvi1RFNg3NWmGuvzE5MwOoZEKkwTrYd6OZX2Or65Jw00eT/1AWhz/ChU8Ysfs22lsO+LgzT6ID3siOdxoKp2rsNiPgNXDMD1uNrMilH+oLMgOjhJBO0ipEt+zshkLsdlcoBp6sxU/a0W5Zl4iWaO1XjzbOF+wuUp8ZXzeD10EAYiloM7vKp/rc3j/4OP4iTTuXOqDOyUzOzNR8dKbFzaklXB8xG0FP3Wa4RBBXIMV2AxABSTtS/6/byalSxgrB3ZnqTfDgv4MDzcOv3zjomUfRQFqawFuQeQZiXNGzL+3M5xw0LW+fcqSdXV9q/qsStl72sA8gThVai4gN5WD/Zr1krbdPanVDetb89ZBZlSL7+ybOTTylIuLngkcHaF+/klh5y5IK5JgXG+mtWPt+XuuUxM3NwiCySsz9t5F6m4hRqXinEM78lXpUwSKA5lG6nlJiae+vunYcBoSbTAEGONpGC6ZHs=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 0kXT3sSSdviG9ESRHzE0sqXNaXwxPLkQS74Eq6Lia79sCnceDO9H9CJxKjLNHezzmdxROJdQ3f0QmjIw/OvbLy/J1J9mDNXf/RJWw4eEh8QKCU9bgQ4Qm16XEf/Lrgl3b4BuOfkffvI+pJ5LCDtG3mzty1LUI0lE+ugAkTju7Dz+BzJmL7UaXr6L83agEp0v68oR7LxuNmKq8l005oQfC/Lt+bXKR7/l8fXO0Vo/g9NBUk8qeSfdLu/wFFfo4Rc9HN9+tVIKzi7a6ghqf7RuSXTnAiSLsVxyP3joZBNyCSAMEsh1j4isQgKitDLEZCepyGU4O000PMBYpTP6MPFurw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10796
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: WA1PEPF000099CF.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3aa196d6-6c37-4c47-32df-08df18ea9deb
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|7416014|14060799003|82310400026|23010399003|35042699022|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pmDNLQWYbFMAKbsqNkaRYOHCExHbYL3AoRZ6ezqAkQnRRwsYS4uOH8+KLgHQLiTputyYkD5YWFrhU4Pu6gSWoW24q3ukuZkHxXv/Z7B8Xzi9UPErhpItQ3eBmO2pLbNM26omp0n4XHiL9imzI2EBpfxpgpJXBrCNCBbqOkKX3kdIp7/fYYETa9CpaBWgfbjQvnvDRSPH3gFTDLd+ZBY/rCubhCRxMGHNpJ3qj7WwRmC4rbYYFmLiqZaIfDayJjNDGjf5e5fGg+Wx4mW1iBGXGWbScqh7W4mbX82HRWBJ/vhadSlUELkXMU5lEmgPPLPl4qWXuqxmNnxClIp0sXEkFEsIuQuO/supoZOEIngCH+Kl8IWCpBW9iLlgFpNKCFJMMNkngnLIq0Oe5hDa0fWfJsVc2qxQfTBRpw/99ng3ajyAoKfVMikIap/fWWnw+xMo7HhWHF3JvzPQtShBT6RbPG7yDevJproOd0SymUrygTgGl+QX8J3YbTKC37xxVnhTsZh8uFzoS5Oc2J4yaFDDGgxv7Wx4m4+2TaTnDGHCluRux/sEdyblr81gtD5PTYkPvofItadCePMn2izdmNSlZ9g8pkST6H9GhEz5ME8/7Gx4ERGdVyAXtJDrrwAARebhAKmR0ifyEC0r2s3AnnqzTzW+8i+yEmFl0ymAM2O7TV7MxzsMmEx5RMc66finj+Lbz/ZGNVLiSZU7vZxzCk7Mjg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(7416014)(14060799003)(82310400026)(23010399003)(35042699022)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MObx3oLDv+prU+ubxHveHz/0sXNnHoP9wxdV6N27YCpGdqxq9bB37mTPn8TkMo916jwPHgjsTn6NQP8043W1uva/2qHjGg1+s56CmgdEipvyc18odlt/ZBOMdXtno3pOeNHOnHZLsjJKNpHsjBMAY6rjI+eyeoKt7rpApN4eqwRMSrZ8tsn5ZFXKh4fZ/iREQSnroroNw8teV6sbXz86xASIuU0i8yKdVjW35+9J7oRiUi2BwFF7hkii1p0czalyeiLVtY+mSHXrit8TFSxdNQLPdV/GaSqKuavuDoKnW75S4qcDeyFfvfrS5/BRJmlj/EsgFFS9+HD3DeGnj7vfJNhbJnDAfyWPA8Kf6J+BWgriS1VkBd3Wy1FdKXrYai8IprTDvzLNxTe7IH/jCZYhf1wlo+0hHUHtfKcDhOO2mX4ikbmQgrSyJf8eoAAVjNH6
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 20:47:19.8886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c91a91e2-92e7-4b1a-c573-08df18eab231
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099CF.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5840
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

Mali v15 AM systems expose an AM_SYSTEM block for GPU-wide control.

Add a small AM_SYSTEM platform driver, wire it into Kconfig and the
panthor build, and use it to manage the GPU clock and regulator
resources. The driver also performs the initial GPU reset sequence
during probe.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
v1:
- Renames panthor_system.c to panthor_system_drv.c to facilitate adding
  another source file for v15-AE support.
- Explicitly obtain named "system" IOMEM resource.
- Explicitly use "gpu-supply" regulator instead of inferring it from the
  "clock-names" DT property.
- Populate/depopulate child devices.
- Clear stale RESET_COMPLETED interrupts before reset.

 drivers/gpu/drm/panthor/Kconfig               |  10 +
 drivers/gpu/drm/panthor/Makefile              |   1 +
 drivers/gpu/drm/panthor/system/Makefile       |  13 +
 .../drm/panthor/system/panthor_system_drv.c   | 304 ++++++++++++++++++
 4 files changed, 328 insertions(+)
 create mode 100644 drivers/gpu/drm/panthor/system/Makefile
 create mode 100644 drivers/gpu/drm/panthor/system/panthor_system_drv.c

diff --git a/drivers/gpu/drm/panthor/Kconfig b/drivers/gpu/drm/panthor/Kconfig
index 911e7f4810c39..e17c93035e8b7 100644
--- a/drivers/gpu/drm/panthor/Kconfig
+++ b/drivers/gpu/drm/panthor/Kconfig
@@ -20,3 +20,13 @@ config DRM_PANTHOR
 
 	  Note that the Mali-G68 and Mali-G78, while Valhall architecture, will
 	  be supported with the panfrost driver as they are not CSF GPUs.
+
+config DRM_PANTHOR_SYSTEM
+	tristate "GPU-wide configuration for Arm Mali 5th Gen AM GPUs"
+	depends on DRM_PANTHOR
+	depends on OF
+	help
+	  Enable support for the AM_SYSTEM block found on Arm Mali 5th Gen
+	  AM GPUs. This block provides GPU-wide control outside the main GPU
+	  register window, including reset handling and management of shared
+	  clock and regulator resources.
diff --git a/drivers/gpu/drm/panthor/Makefile b/drivers/gpu/drm/panthor/Makefile
index dd15d52a88bac..488a5e03efbc4 100644
--- a/drivers/gpu/drm/panthor/Makefile
+++ b/drivers/gpu/drm/panthor/Makefile
@@ -14,5 +14,6 @@ panthor-y := \
 	panthor_sched.o
 
 obj-$(CONFIG_DRM_PANTHOR) += panthor.o
+obj-$(CONFIG_DRM_PANTHOR_SYSTEM) += system/
 
 CFLAGS_panthor_gpu.o := -I$(src)
diff --git a/drivers/gpu/drm/panthor/system/Makefile b/drivers/gpu/drm/panthor/system/Makefile
new file mode 100644
index 0000000000000..018b569655b67
--- /dev/null
+++ b/drivers/gpu/drm/panthor/system/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0 OR MIT
+# Copyright 2026 ARM Limited. All rights reserved.
+
+obj-$(CONFIG_DRM_PANTHOR_SYSTEM) += panthor_system.o
+
+panthor_system-y := \
+	panthor_system_drv.o
+
+INCLUDES = \
+	-I$(src)/..
+
+ccflags-y += $(INCLUDES)
+subdir-ccflags-y += $(INCLUDES)
diff --git a/drivers/gpu/drm/panthor/system/panthor_system_drv.c b/drivers/gpu/drm/panthor/system/panthor_system_drv.c
new file mode 100644
index 0000000000000..1f25c7bad49b5
--- /dev/null
+++ b/drivers/gpu/drm/panthor/system/panthor_system_drv.c
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/* Copyright 2026 ARM Limited. All rights reserved. */
+
+#include <linux/clk.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+
+#include "panthor_device_io.h"
+
+#define AM_SYS_IRQ_RAWSTAT			0x40
+#define AM_SYS_IRQ_CLEAR			0x4C
+#define AM_SYS_IRQ_MASK				0x58
+#define AM_SYS_IRQ_STATUS			0x70
+#define   AM_SYS_IRQ_RESET_COMPLETED		BIT(1)
+#define   AM_SYS_IRQ_INVALID_COMMAND		BIT(2)
+#define   AM_SYS_IRQ_INVALID_ACCESS_MASK	GENMASK(31, 16)
+#define   AM_SYS_IRQ_INVALID_ACCESS(x)		FIELD_GET(AM_SYS_IRQ_INVALID_ACCESS_MASK, x)
+
+#define AM_SYS_STATUS				0xC0
+#define AM_SYS_COMMAND				0xC4
+#define   AM_SYS_CMD_INDEX(x)			FIELD_PREP(GENMASK(11, 8), x)
+#define   AM_SYS_CMD_SOFT_RESET			0x10
+#define   AM_SYS_CMD_HARD_RESET			0x11
+#define   AM_SYS_CMD_AW_RESET			0x12
+
+#define AM_SYS_RESET_SLEEP_US			10
+#define AM_RESET_TIMEOUT_US			(20 * USEC_PER_MSEC)
+
+/**
+ * struct panthor_system - System device
+ */
+struct panthor_system {
+	/** @dev: Device pointer */
+	struct device *dev;
+
+	/** @iomem: CPU mapping of the AM_SYSTEM IOMEM region */
+	void __iomem *iomem;
+
+	/** @regulator: Pointer to device regulator */
+	struct regulator *regulator;
+
+	/** @clk: Pointer to device clk */
+	struct clk *clk;
+};
+
+static int panthor_system_regulator_init(struct panthor_system *sdev)
+{
+	struct regulator *regulator = NULL;
+	int ret;
+
+	regulator = devm_regulator_get_optional(sdev->dev, "gpu");
+	if (IS_ERR(regulator)) {
+		ret = PTR_ERR(regulator);
+
+		/* Regulator not found. Exit */
+		if (ret == -ENODEV)
+			return 0;
+
+		return dev_err_probe(sdev->dev, ret, "Failed to get gpu-supply");
+	}
+
+	sdev->regulator = regulator;
+
+	return 0;
+}
+
+static int panthor_system_regulator_resume(struct panthor_system *sdev)
+{
+	int ret;
+
+	if (!sdev->regulator)
+		return 0;
+
+	ret = regulator_enable(sdev->regulator);
+	if (ret) {
+		dev_err(sdev->dev, "Failed to enable regulator");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int panthor_system_regulator_suspend(struct panthor_system *sdev)
+{
+	int ret;
+
+	if (!sdev->regulator)
+		return 0;
+
+	ret = regulator_disable(sdev->regulator);
+	if (ret) {
+		dev_err(sdev->dev, "Failed to disable regulator");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int panthor_system_clk_init(struct panthor_system *sdev)
+{
+	struct clk *clk = NULL;
+
+	clk = devm_clk_get(sdev->dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(sdev->dev, PTR_ERR(clk),
+				     "Failed to get clk");
+
+	sdev->clk = clk;
+
+	return 0;
+}
+
+static int panthor_system_clk_resume(struct panthor_system *sdev)
+{
+	int ret;
+
+	ret = clk_prepare_enable(sdev->clk);
+	if (ret) {
+		dev_err(sdev->dev, "Failed to enable clk: %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void panthor_system_clk_suspend(struct panthor_system *sdev)
+{
+	clk_disable_unprepare(sdev->clk);
+}
+
+static int __panthor_system_reset(struct panthor_system *sdev, u32 cmd)
+{
+	u64 val;
+
+	/* Clear stale RESET_COMPLETED IRQs before issuing reset */
+	gpu_write64(sdev->iomem, AM_SYS_IRQ_CLEAR, AM_SYS_IRQ_RESET_COMPLETED);
+
+	gpu_write(sdev->iomem, AM_SYS_COMMAND, cmd);
+
+	return read_poll_timeout(gpu_read64, val,
+				 (val & AM_SYS_IRQ_RESET_COMPLETED),
+				 AM_SYS_RESET_SLEEP_US, AM_RESET_TIMEOUT_US, false,
+				 sdev->iomem, AM_SYS_IRQ_RAWSTAT);
+}
+
+static int panthor_system_reset(struct panthor_system *sdev)
+{
+	int ret;
+
+	ret = __panthor_system_reset(sdev, AM_SYS_CMD_SOFT_RESET);
+	if (ret) {
+		dev_err(sdev->dev, "SOFT_RESET failed, attempting HARD_RESET");
+
+		ret = __panthor_system_reset(sdev, AM_SYS_CMD_HARD_RESET);
+		if (ret) {
+			dev_err(sdev->dev, "HARD_RESET failed");
+			return -EIO;
+		}
+	}
+
+	gpu_write64(sdev->iomem, AM_SYS_IRQ_CLEAR, AM_SYS_IRQ_RESET_COMPLETED);
+
+	return 0;
+}
+
+static int panthor_system_suspend(struct device *dev)
+{
+	struct panthor_system *sdev = dev_get_drvdata(dev);
+
+	panthor_system_clk_suspend(sdev);
+	return panthor_system_regulator_suspend(sdev);
+}
+
+static int panthor_system_resume(struct device *dev)
+{
+	struct panthor_system *sdev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = panthor_system_regulator_resume(sdev);
+	if (ret)
+		return ret;
+
+	ret = panthor_system_clk_resume(sdev);
+	if (ret)
+		goto err_regulator_suspend;
+
+	return 0;
+
+err_regulator_suspend:
+	panthor_system_regulator_suspend(sdev);
+
+	return ret;
+}
+
+static int panthor_system_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct panthor_system *sdev;
+	void __iomem *iomem;
+	int ret;
+
+	sdev = devm_kzalloc(dev, sizeof(*sdev), GFP_KERNEL);
+	if (!sdev)
+		return -ENOMEM;
+
+	iomem = devm_platform_ioremap_resource_byname(pdev, "system");
+	if (IS_ERR(iomem)) {
+		return dev_err_probe(dev, PTR_ERR(iomem), "Failed to ioremap \"system\"");
+	}
+
+	sdev->dev = dev;
+	sdev->iomem = iomem;
+
+	ret = panthor_system_regulator_init(sdev);
+	if (ret)
+		return ret;
+
+	ret = panthor_system_clk_init(sdev);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(dev, sdev);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM");
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to resume device");
+
+	ret = panthor_system_reset(sdev);
+	if (ret) {
+		dev_err(dev, "Failed to reset GPU");
+		goto err_rpm_put;
+	}
+
+	/* Probe any child devices */
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret)
+		goto err_depopulate;
+
+	pm_runtime_put_sync_suspend(dev);
+	return 0;
+
+err_depopulate:
+	of_platform_depopulate(dev);
+err_rpm_put:
+	pm_runtime_put_sync_suspend(dev);
+
+	return ret;
+}
+
+static void panthor_system_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		dev_warn(dev, "failed to resume during remove: %d", ret);
+
+	of_platform_depopulate(dev);
+
+	if (ret >= 0)
+		pm_runtime_put_sync_suspend(dev);
+	else
+		pm_runtime_set_suspended(dev);
+}
+
+static const struct dev_pm_ops panthor_system_pm_ops = {
+	.suspend = pm_runtime_force_suspend,
+	.resume = pm_runtime_force_resume,
+	.runtime_suspend = panthor_system_suspend,
+	.runtime_resume = panthor_system_resume,
+};
+
+static const struct of_device_id panthor_system_dt_match[] = {
+	{ .compatible = "arm,mali-gen5-am-system" },
+	{}
+};
+
+static struct platform_driver panthor_system_driver = {
+	.probe = panthor_system_probe,
+	.remove = panthor_system_remove,
+	.driver = {
+		.name = "panthor_system",
+		.pm = pm_ptr(&panthor_system_pm_ops),
+		.of_match_table = panthor_system_dt_match,
+	},
+};
+
+module_platform_driver(panthor_system_driver);
+
+MODULE_AUTHOR("ARM Ltd.");
+MODULE_DESCRIPTION("GPU system driver for AM GPUs");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.43.0

