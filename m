Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66A8606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bYxeuCY/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 972991121FA;
	Thu, 26 Nov 2026 08:56:05 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0ADD1121F7;
 Thu, 26 Nov 2026 08:55:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUVmumSh8glEgzS5h7JqEVxyJAu77Kg0YQhNRm6HDPH1z1GGf8CUJBKZYcgMy/4ki32b1iygurNaOTHPY6TKArzIUl61x+81kheCBy0xTcUHj4YApMddzoiKGhrj5zSG+d6DEUk7ScwYm3kW//o1kmPnXtKMfaPJT6CwJdlbs4uWYBxE3eYPvrFEEsuY6DeG4IORwMdzO4YtcaVv68YDGzity4xBB/QvQ4sxkM/gyQ3WkQlr9uhKOFrlCK59hNp54YCsICQ60sGs9RbxiP5zG8LGCkXes24L2ixHPS9lA+wBsNpxFjpPDQ5K4veq8kn/YJb0BVOtpQK0m9dgEM33KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLQEC5NPEx8eO5HJNurbEmkEZAiD1UBnA48tyQYf4h0=;
 b=eoo5oi1yZ48dR6hG6khDYSNb7sTIQsI8ApoqH7/jtnfn+oAyhxWDhozTXplzUcwYU9XUyvcqfdcOdq6gj9Iksg5aOAcGMikpf/2fw9uehibw70x09lQEGiCEGzCC3GfWRKFTW8MNqIhKFlZvH+AmBfb4CInrDGteOq+wG+neGF3tJYQw+O/cPVAIHZLa/525Amefyu2tZvxIMX63q1/oqbyCSJneXNk1VU6JhK4P5RT9Bl+jA910NfgB/ejVbHM6IEwHr7HUzcfpTqgdu+mr8d63aXXjaybbuL9r0ngNLMjOOOKgBVVu4+My6NuPXJe3wZRmGNbYTsw39TLlfI8YuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLQEC5NPEx8eO5HJNurbEmkEZAiD1UBnA48tyQYf4h0=;
 b=bYxeuCY/5Y4FjJr6WFfflmolHrGbsyfzLaVJpDtQ3Tcx9F6PTqF3yDoJUwje8XQ32XH9wZ9XUmZBbo2NUzlO1rPOA4LahaCI/QFHfwHsUbwwVceXjDiMSC5vxsH8QZZV0l+OYauLhmszYYfQaYRkbIy7dMBLSeyj6TtfbTZHSDs=
Received: from DS1PR04CA0006.namprd04.prod.outlook.com (2603:10b6:8:44f::6) by
 PH9PR12MB497784.namprd12.prod.outlook.com (2603:10b6:510:411::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 08:55:45 +0000
Received: from CY8PEPF00000057.namprd21.prod.outlook.com
 (2603:10b6:8:44f:cafe::70) by DS1PR04CA0006.outlook.office365.com
 (2603:10b6:8:44f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 08:55:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF00000057.mail.protection.outlook.com (10.167.247.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.0 via Frontend Transport; Thu, 26 Nov 2026 08:55:45 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 02:55:42 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <tzimmermann@suse.de>, Prike Liang <Prike.Liang@amd.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH 3/3] drm/client: Make the FBIO_WAITFORVSYNC vblank wait
 interruptible
Date: Thu, 26 Nov 2026 16:55:28 +0800
Message-ID: <20261126085528.820182-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126085528.820182-1-Prike.Liang@amd.com>
References: <20261126085528.820182-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000057:EE_|PH9PR12MB497784:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef572f1-6f61-4553-1f50-08df4b9b0f15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|261026140227099003|261022105027099003|261022115727099003|10067099003|261026121527099003|261102130727099003|261021123027099003|261102123227099003|261028144727099003|261021121427099003|13003099007|261009223027099003|261009221227099003|22082099003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: kEApNIhZiV3bUYVKrggWvFO3kHm6CnuWG7ULxq63zFgA9uYHVgXfQ28GkQ29hrHJDtQIvyvEN5/H+hvOj/nm/KSy53Oxh5InS19mXmUcIGabcpI3bOhqkOP3J4DzIfnRkvq+LG/Uin01SSz0wVFrMynqw9NTe35JJA9iJVf/zMHBKtjnzUqfevB0Ssdv/i7hbe2sgo3Fz8CZvSITORh+92FLocKZv7Vb25YoCl8FeXxe/AY+MYlm+9Dd1oX3Vn6tmdsIHVO2ZsmUVEpzaa+LvJ8Bvf4q6sLBe7nrZxp8fBm6983gT8UtjGjHCAL+uNFHBG/jwEVjNdTJ93DNQp1uvU8ynrvjw5CFk3Ru5sGU2jvwa+iIlJSl9jcn3ZZKx3Voqatk0MiePAyYfQT4vTkL4oB2V9mbwjUmhgCZiWQ9OaSidVf5/NwgOr/m9t5SHDybIp+BvREXZgarwfQH7OYMd0AE7vnz1UVuOqHgmsf99sR0lVRMntgFAoUjrEXPID4rHwGPsWjPsEZ58wwf8rumAYZVlDBKLUFUpfclnUnpP1SUDK7BifGEYcZiko1/+Cui1wxbJdUaBH3xt+uX67hvf3KDdmbQxLF21c4ybWKZWxoNaDPOqcDO5hzTK+dX9Dec
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(261026140227099003)(261022105027099003)(261022115727099003)(10067099003)(261026121527099003)(261102130727099003)(261021123027099003)(261102123227099003)(261028144727099003)(261021121427099003)(13003099007)(261009223027099003)(261009221227099003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aEqEBHFGs9R5L/0UASxCuyvlO5+GLGN86Qi26K7mGc1YMKpUjLdZww48odVw9m/GgO4PSnGsKKpLWABdJn7OUnr7YNWNX7IdFzfD9MzCva/QIDjQfd0H57GSFacNIAkfckXQJXlseHYwj6my3oB8M25jME814MEwYBakoYf5w44SMMLXvHYJgsnFI6L4jH8aAhbBlhHHK4FAtQY2qUbX+CjPjQYaA0zJZOt/z0rsWj5px+BnaR6UFifEWhLZctiiz5jjnTfVisHiLZgQ96Gl9qMI4SSV04clBulffdnMDDb9g/IwX8w3aOXjfiyx6wqLceQMvNyurWsrngG98BkN41Mh71at/zV7rlVa/JGBfqfGtBvhQxtQJkvja8P/2fVA6ahpIwRcsTbnmG8F/pGGS+E5rHp3ab9REE6kbjQU/Mb2aNfe0NHJ+wM1YpFoo1lR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:55:45.4060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef572f1-6f61-4553-1f50-08df4b9b0f15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF00000057.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB497784
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

FBIO_WAITFORVSYNC calls drm_client_modeset_wait_for_vblank(), which
waits with drm_crtc_wait_one_vblank(). That wait is uninterruptible and
only gives up after one second. If no vblank interrupt arrives, for
example while the driver resets the display hardware, the caller sleeps
in D state for the whole second and can't be interrupted, not even by
SIGKILL.

DRM_IOCTL_WAIT_VBLANK waits interruptibly, and so do fbdev drivers that
implement FBIO_WAITFORVSYNC themselves, such as atyfb and matroxfb.

Use drm_crtc_wait_one_vblank_interruptible() in
drm_client_modeset_wait_for_vblank(). Return -ERESTARTSYS when a signal
interrupts the wait, so that the ioctl returns to userspace or is
restarted. Timeouts and disabled CRTCs are still not reported.

The fbdev damage worker also calls drm_client_modeset_wait_for_vblank(),
but it runs in a kernel thread, which doesn't receive signals, so its
wait doesn't change.

Link: https://lore.kernel.org/r/20261119082424.554841-3-Prike.Liang@amd.com
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Assisted-by: Copilot:claude-opus-5.5
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_client_modeset.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 67f90e5d1512..122ca1bf98e6 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -1301,10 +1301,11 @@ EXPORT_SYMBOL(drm_client_modeset_dpms);
  *
  * Block the caller until the given CRTC has seen a VBLANK. Do nothing
  * if the CRTC is disabled. If there's another DRM master present, fail
- * with -EBUSY.
+ * with -EBUSY. A signal interrupts the wait.
  *
  * Returns:
- * 0 on success, or negative error code otherwise.
+ * 0 on success, -ERESTARTSYS if a signal interrupted the wait, or
+ * negative error code otherwise.
  */
 int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned int crtc_index)
 {
@@ -1328,13 +1329,14 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
 	 */
 	ret = drm_crtc_vblank_get(crtc);
 	if (!ret) {
-		drm_crtc_wait_one_vblank(crtc);
+		ret = drm_crtc_wait_one_vblank_interruptible(crtc);
 		drm_crtc_vblank_put(crtc);
 	}
 
 	drm_master_internal_release(dev);
 
-	return 0;
+	/* Only report interruption by a signal, not timeouts. */
+	return ret == -ERESTARTSYS ? ret : 0;
 }
 EXPORT_SYMBOL(drm_client_modeset_wait_for_vblank);
 
-- 
2.34.1

