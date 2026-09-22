Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37164C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52A6910E67A;
	Tue, 22 Sep 2026 10:08:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="rhvP0DLB";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rhvP0DLB";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012061.outbound.protection.outlook.com [52.101.66.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D746610E67A
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 10:08:39 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=OdrKahqhhcHr+NCIQtxLXVGU/ncHealkAV9yh+wsqLg1zu1hFXuJ3mngs0NqBh9IuJgL18UE5wlc/Irge4AUICfNlMhLecQp8FKsQbdXixGWNAbImUTposl43KzcH/Swz48hA96LN7zCiLdu1nsOKg72U7DrSktbsNCKvaNWKQJ92slePbNt7Yz9CBPFn7ktzRRmV3fyv4a1JSvKdko2Udb0EL8FR5zH155kd08t7HE9aRvLVdt1aK7zuMvYmeRnQWQFvjgIZbm6X3kfTaQbjlG6kxb6Alb/E972JlYabgnqb3XgDYDpl/Dh6YjOKi1t3zm661qYmVM8Fj2MjDkilw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gm4VQxQkLZ8YjxBmBAexzeCAr+19qOUdBPD64lJk71g=;
 b=VI9ZlDVlNLDorfEcLzOWc0KTeugmoAh4Y1s2akbjAY5Qmc3mlbmZ+dN07wUr8/VR/idPqj/SBs86rp1G9qb6jiILcYOfoTNJFyEoHbUbIJUBY10UZmjSziFaGlBVQYU4OGneEiKYVOpXRKaBuXJP2V++ae9zvFFwI9HV+tZcfuVpBi67lVvBWUqmEN5bS/cYBdckGwF1mJuehYhIQDTG2VCtKlYtin3je1oLZM/0AcWuS4dusC0egBGlcDtgG0EcpYDtTVKjm2SiPsgbvhTF2HR/EWCvKwTxx+9PKh8yTHpx5WQnywA6pZY3QZkQ/SAZDDJ9wANVZRjfh99gsro+2Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm4VQxQkLZ8YjxBmBAexzeCAr+19qOUdBPD64lJk71g=;
 b=rhvP0DLBKcNy3uiUTTq5S9ibBh+nHzaeg2H2oyoGJ77dw7Z96YA30C1C5SAJzI+6pr37rq/k5QPWbQLcS4EBZdAns5H+4quFY7z7Kpf4CgCaDcpaP5mW/zuUOy+ZMbmZyd2IaC5HdMv9wqbMtIGTr5IlWGetXjdYTzCtE5kG6DY=
Received: from DUZPR01CA0273.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::14) by FRWPR08MB11635.eurprd08.prod.outlook.com
 (2603:10a6:d10:1b2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 10:08:33 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::9d) by DUZPR01CA0273.outlook.office365.com
 (2603:10a6:10:4b9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 10:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Tue, 22 Sep 2026 10:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLHH5OniH1ultHC30ryAuMciIs3X4IHvjMiQVhH2w4AOHVCxTMOxMeP846B5xHDABRtZ7rdGoAzXJqVeJ/1yUJcJsoLdY6uS3iFHB+DBskLKGALdeNLPFdJvzRlu35svIWK4RUgaMmQgGRlbk2qD+zDZ7zhAhUClBJgOA2BQM3e6mza24PxM2KH5ex1SpatTQTw9BWiwPHQxwOqHtzABnlLuwpUKkdUOjuDXE/DeMDhlVRnRdlCkwAwW+0RgLN+4WX0CZa4TPa0cwnSs6kelWR934wmIQDnKMCYzsUVTLdWVaX5onqwmbSaRirsWqLOHGGsawdVCprEO9VHf3EtaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gm4VQxQkLZ8YjxBmBAexzeCAr+19qOUdBPD64lJk71g=;
 b=shY0izCGDPgL2rd1c0tK7nyDJPPQD2LjEwoRaopbEGy5VZ6ScHG2BdihWKNprf+NFfTUZ7m7MeRbBQ4stsEqKkio3SCsX/GFS02MTAdT3CMKVVfxWLu2ryXkslw6h9VsNbNb1hHbwvONeg/uvJDb9olmoMenqdXzCi1zkYOmQ30W4Rke8cVmDQ2xhXHLlnFfo8HJwFT2WfrC5/rwX1KcjngXFVTqKsULz3zvDAF+q5sqcmGeef4Vgl7vpAM+g08Pp8beO5mzaF3UnRqu/EE8NknjYiWvL4203jpHEc641Lz0qrMs5gSgSAWRjnNEzzrVvFWp//QMNU0grl5O69hjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm4VQxQkLZ8YjxBmBAexzeCAr+19qOUdBPD64lJk71g=;
 b=rhvP0DLBKcNy3uiUTTq5S9ibBh+nHzaeg2H2oyoGJ77dw7Z96YA30C1C5SAJzI+6pr37rq/k5QPWbQLcS4EBZdAns5H+4quFY7z7Kpf4CgCaDcpaP5mW/zuUOy+ZMbmZyd2IaC5HdMv9wqbMtIGTr5IlWGetXjdYTzCtE5kG6DY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com (2603:10a6:150:316::8)
 by GV1PR08MB11092.eurprd08.prod.outlook.com (2603:10a6:150:1f3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 10:07:49 +0000
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133]) by GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133%7]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 10:07:46 +0000
From: Akash Goel <akash.goel@arm.com>
To: boris.brezillon@collabora.com, liviu.dudau@arm.com, steven.price@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com,
 Akash Goel <akash.goel@arm.com>
Subject: [PATCH] drm/panthor: Fix handling of NO_MMAP BOs
Date: Tue, 22 Sep 2026 11:07:43 +0100
Message-Id: <20260922100743.447700-1-akash.goel@arm.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0047.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::16) To GVXPR08MB11744.eurprd08.prod.outlook.com
 (2603:10a6:150:316::8)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11744:EE_|GV1PR08MB11092:EE_|DB1PEPF000509E3:EE_|FRWPR08MB11635:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ff430d-92e0-4c5c-e77c-08df1891735c
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info-Original: 8+hhC8iNowrcO9SVBNhZRMmwfIHu/MYrpZIdbi6U62rQXPCe5zbNAFGf9uK1M/XBOJdXHWZb1uzrIYF0VOmYeQ8q9VeRdd04AAf4OdgAOWBI/28fUkqyAIz4LjcSS50temVdms38ho5GmAD5lnBfO6fLiiH+bywmqad/8vUtQjt3QGHTbIGQcF9z/S0vjUceZuuTKU5XFNTExbzFSMxCogtp99/8q7csefqmjusKVPLLXDLSKZXvq0b4KtGBZJnVQu/JcMABlw1f4mdw/HWqcQhyuljK+9gQlZMIRyXT1avqTrpitpl50IKgtYWBsXVlbD6jAr568UpKFAXvCgYFWxE7+dkPL64OyQE37249RECSj7X14c1VpJsHWn2gmupriNcLkQOv8W4a/VTir3RU3Gk5aSSv06zeGZIJuj5HRdBhRN+wAxv/j8sguOjYXc/sqBDsIi+nRpFS4jVTjrKBvURVZocjsUSk8bfkycG+0xqKUN811NJUIGMTXy+X2eEo/sxLKTp11vVJSLH9zzUA0KD/ahjYQLFR/M53hUSYJddZ/FkDPbS0TNyJ5YvhtVxxC0ounj2xWjwpEDnDPbVqeDmTbMssSHxpgeTNuaQ11+myZMG8PJph+N2J03ff2BX2vsVP/k5RholxZNEY2AwWbjdSc9EOMLKOikIS7l2t7NE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11744.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: oE9hVJOn/w4zFtcKca4axWvdcsxMvOSF224DANkCRDAF9IBDtRueI2Ck9JNxoM3Sks4Qt1TxeLsGPttTOmgKWkL0daR2qxFlkUeQmIaXT5autqaGcV0QSQqusIftGUmRlvpsruH/PPKE1GEoGZA0jtklHKjL+xQ6aQeX9vhUyycE+1d99Jk0LNl8NcWwKAfjbGf6ahAEtTwPAmygkEVJF5rHeO83mwdKCNkO/mUpjh8k3S9k7jN+PdgvamMQ0X+eEtg4GZYt59SqPBlPnAv7PWEtZmgCoH9JyQN86g5pH03QnLbmtlBc20GIIy9kQfkkv57x8r/HCsD4COiZ/rpg3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11092
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 71c024e5-644e-425f-bbee-08df18915958
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|14060799003|1800799024|23010399003|35042699022|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: XAiVTRhmX++WtO3fbUOfYrVZWJ8Z/v5TFlNWEwN8NDfNl4XZr6u3BQzqXyltfepftEgwfXTOVdLsgExzvxAwhokGN0gzWrm9ycaoHIF4C1CzGuzOXKNdH6QL7v0KfUasPTUAhdvJ+7ZPcvPbaS2rtWinal/XYr4dtQTx8BvFiyT/FUta4jFq2CsVKEn5zZxD8dI0wGyNa9wy0ohk1GF1LPUUNitX56AeEX3t83P6xJIKloc07/XSO0mf2AxA1NYrQR4YKs0dtWkd2Dg7l7UruLxbqfg79Gmgtkc7x4exe++AISiGsjAENDemHAGNsmYxxkkv80xqb3GOfUJFgk+AWXQbdjp8k1gev4ZllCOhBIpMEP/D7MO2YGsrPp5C+c2dccaGw5AjFLt8cEem/bGeqSh8oVHzgQNIoYy3G2x0GKIU0Dzsu0AgZ5x3f45h5dq2xgy+GV0Ma0VA3U6sUL42iPgrERYMIGEcpYFI6+JcAKZ5mwivjp7I5aB+sNcpGDnkgMnlxrtlSrRhcgxLV4yQa+J+sJA2S9//k30H/l+wjPXsBNP75JfLRlx1hPfRL3AzVqQGZ5+N6rub5qwD/9snww5Ztt1tntA/EH7cCFDn9Y7jWxyuKCxEcskD+YL9fc896gg/l92G3WjPOdo0ro0HrqhhTKqhpq0Adb6vxz31czoyHhzX+ylFStfF69iI15AVIxnK6yjB2vJ249yncMJShg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(14060799003)(1800799024)(23010399003)(35042699022)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cWFY14MUGZ+99/vUNjzWAjWdHV+z7QWYE48Y9Olcly7Es/19aUiTZkZ3G/eW7gGLZwIOPG2D6FvFjhAedf9YHpqneZrNqCrkpa2ytWOYyRPd1rHalvSTrA2rX3IZo2NV/Y3Sq4Tf7MzJqH3jNDklaZ7awJyqpG2GiNgEQpAgrlq/cV1scrkzFjMnj7D7vIz8lFwgvMA4E7ixCKDYEIQyygORLxODbodw64LjGx0jAKiUd9i030c2DDsN6ngPmKojUZVQIOlyTgOK6NeNUuQABGQ3uy8SZZwfQmjfM2o5HRYCbDfUU1uFmjMppGg/8UfkB0GhMTsTZn/etqeVZasKXyt2q3GD3xFu0cFFl+hI5cfqnryr6HuqTBtOSKpMEyLxYdwWaOAU6PgVJcnTI21Qr/RzUn1NFrvrCQCH7P1O05JjpClwdygyv8o56LcMVxUX
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:08:29.3741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ff430d-92e0-4c5c-e77c-08df1891735c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR08MB11635
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

The BOs created with DRM_PANTHOR_BO_NO_MMAP flag are not supposed to be
mmappable by the Userspace. But after the rework to support shrinker,
it became possible to mmap NO_MMAP BOs. Userspace could second guess
the file offset range, allocated unconditionally at the BO creation
time, and create a CPU mapping. There may not be any adverse effect of
such a CPU mapping though.
This commit removes the unconditional allocation of file offset range
when a user/kernel BO is created. For user BOs, allocation of file
offset range would be done from BO_MMAP_OFFSET ioctl handler which has
a check for NO_MMAP flag. For kernel BOs, there is no need to allocate
file offset range.

Fixes: 68cbf96b1e9b ("drm/panthor: Part ways with drm_gem_shmem_object")
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Akash Goel <akash.goel@arm.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index c07a44057e42..5cfe66537e87 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -1021,10 +1021,6 @@ panthor_gem_create(struct drm_device *dev, size_t size, uint32_t flags,
 	mapping_set_gfp_mask(bo->base.filp->f_mapping,
 			     GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
 
-	ret = drm_gem_create_mmap_offset(&bo->base);
-	if (ret)
-		goto err_put;
-
 	if (exclusive_vm) {
 		bo->exclusive_vm_root_gem = panthor_vm_root_gem(exclusive_vm);
 		drm_gem_object_get(bo->exclusive_vm_root_gem);
-- 
2.25.1

