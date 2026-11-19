Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0420E606A335
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0LzyR1Nq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6608B1120E5;
	Thu, 19 Nov 2026 08:24:47 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011015.outbound.protection.outlook.com
 [40.93.194.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C56231120E6;
 Thu, 19 Nov 2026 08:24:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtW40gMorq/793phR5LAtWuBOXhgCacvZzTu8DWvzx0yA/xP38PskU3HgZA+CH41GoBZqRpoQKdR3GATI4UZ+Ftxqf4b6O/l8gCjfsQQHfA2ab4pyQz6JFrXnvjAtIddKBZ5GddYT3XYe9rwcwgoR6goPIg7acCERw6RwC60V6NVCFZh0eaFZUvAmz3flLt01Lt8dgae8JBTYmip+UjhLP12D8ofd1z6TRpYEha6t27LrxYNNEjUkYbuysGm6ArsMq9raMnQYNcxD+BaapAtdNBGrDW3DUhlMsSIY7IxWTV47cHHdKF7292VLBYjKspPz59vIoBTsKk00sAUYIfY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jRyfZKq0ouwsQyeEAQGxU1hjzyyI7aXobcq5Gi4viw=;
 b=sD4TQCzjzujMIdrFKXUVn3yN1L5GnjS7VIYB5G3cZV4nwAT5CJyU+OelFzUBewwhQn27nF61bNSPBMC/iBwqOl2O04GviK14MtYu4yY8bVbTW0Xv3xjjRs5ap1HU2EmYMkQxTnTooB9Y2ANKyB2fmaCtWpgfLEUEml8+stLgdSG4+/jvXedEXyWIjOc5aKLhZsVttHOcRV2oKxTFqmLVP2t1s7OqVhoyzbUgmLai3lxVtHjDqXyt+QuVVRFngEbzgVO6GTsLoHLpH/jP/PdNqfrz0RXWmdYEVKszNare5ej1b1mROZ8bz5Y2dSVSzUEjej6d9YOgbt0gCsEKUktRjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jRyfZKq0ouwsQyeEAQGxU1hjzyyI7aXobcq5Gi4viw=;
 b=0LzyR1NqfaOzU5MLFq2+I7mokFCVLSp/ZgKAldfVS/nx8j3ZMDLs3RWJ959JeaF5EPgMrN9rZDBlhlEl9rHaTtEQ5rtXWA3fqRInn0sEhSaW8wqt0sXtioEqXiVjUBKbdwLbggagDm8PJM0w/x7JLPLPVmO5F8lvs1ZHCzZ+Z2c=
Received: from SN7PR04CA0053.namprd04.prod.outlook.com (2603:10b6:806:120::28)
 by SAEPR12MB328447.namprd12.prod.outlook.com (2603:10b6:802:209::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 08:24:37 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:120:cafe::1b) by SN7PR04CA0053.outlook.office365.com
 (2603:10b6:806:120::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 08:24:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 19 Nov 2026 08:24:37 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 02:24:34 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>, <tzimmermann@suse.de>,
 <ville.syrjala@linux.intel.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 1/5] drm/vblank: Stop drm_crtc_wait_one_vblank() when
 vblank is turned off
Date: Thu, 19 Nov 2026 16:24:20 +0800
Message-ID: <20261119082424.554841-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SAEPR12MB328447:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d019a11-f869-4a40-096c-08df46168c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261022075727099003|261021123027099003|10067099003|56012099006|261102130727099003|11063799006|261022115727099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|261009221227099003|261009223027099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: YuLgyOnNKPManpN9r+jDcwoAz0V3m1GZrPF3+x3EkjzjlVuGDdohIOiaQILnNMQqF2lhkERJHcwh0776weOv2cyo6YRpCoFNBEL8lWXU9lD9FkNPTn2VL5Wt7us5s/yjO79Hq1zFyFYpuKDlbZEj2aWTrNL1s5yfVSwIJxPANGibUvlSkJUEkH3Qo31ZKPTdfUL/eVDAyh7TdwH5qC/KLBbKg0DSVpWMk8Ep0hEo8jdqtW/LOYlFd2gsz4OREcfETubxGy9e3nk4DCmC6PIAEHW/w48gAjdTaAoyT+1097+c6OMpuEMQJ1po/1IxnREAsevyFw8yAgyI/6x3GgIpi5wcnOYXYyWZHhCHAWB+7VcOjdBL9KYjYooUgTZ5Xrws+hc0GCh0ZgC9kYXxxPZ0ohGqhwuvB4ciaPvnkabidkLITdNTdGv+tqsIjxYjbub+Twz8y8YLAGGSoz35eBzN23PMhUlOoEGF5MKtt6eA16swo3ReDWJPFI+fTs5+bWZna8Jnhrpg/r17gtosF5w01hkYZMU2HShJPnizJrwA7oX8L1KW4tAxSrKIWCnOTvVY5Btz07cY+8ySUSb+GQlL6gugtkhes0MPayGNbfDK/h/ocrhHExiButwFPvDxwdxIb5mKy6po7sTM9pLnTSQ7/TbakJ0SD/95Hmrs/85lEk4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261022075727099003)(261021123027099003)(10067099003)(56012099006)(261102130727099003)(11063799006)(261022115727099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(261009221227099003)(261009223027099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QavPDZVtAYvt7agDyUYySdQ3/v9FrrgoBQ353/8PvaW7aYn4YMBjfi7+P0JwUGGSiBOt+nz9G+8wG3jrD/JzzXqfHHiNwTWLO/xs/l21VCsNQ76qZdXdMttZhrUzZyFLyhhDGP29zoRZvfH6jUBRTqwezZrk1koSO4Dcopjdl+YAcgL1u8rPwQNqdT4vLhI/vXRH1YAC0jCLm/9lVqBY0KFY9cy7Fy7Q8JnhAaqB/v3gfKiGGNYRb+9O16TQ1tTm+5bTS5uA5kvN3l6CfrNgTpHklkvihjKYFWjVurlID+72PsIxeQ266a6ZSAlV2APHhPvbPfZ9m2Cv1SDEcwF6erm2vZpNAbWUlNWE2AXaOg+acaykhOIdZGMreOM61aFQK+cNnjMznq/49nHovWfaLUjaYThd1xkfb/YWdxkNRWp3s1rYxv/OpT1QagcA0tRO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 08:24:37.1546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d019a11-f869-4a40-096c-08df46168c9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAEPR12MB328447
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_crtc_vblank_off() turns off the vblank interrupt even while someone
holds a vblank reference and waits for a vblank. It then wakes up the
vblank wait queue. DRM_IOCTL_WAIT_VBLANK stops waiting at this point,
because its wait condition also checks whether vblank is still enabled.

drm_crtc_wait_one_vblank() only checks whether the vblank count has
changed. Once vblank is off, the count doesn't change, so the woken
waiter sleeps again until the wait times out after one second and warns
"vblank wait timed out". This happens, for example, when the fbdev
damage worker or FBIO_WAITFORVSYNC waits for a vblank while the driver
turns the CRTC off for suspend or a GPU reset.

Make drm_crtc_wait_one_vblank() also stop waiting when vblank is turned
off, and return -EINVAL if no vblank passed, the same error that
drm_vblank_get() returns when vblank is off. The wait condition is
checked before going to sleep, so this also covers vblank being turned
off between drm_vblank_get() and the wait. Waits that see a vblank or
time out behave as before.

The two cases differ in that drm_crtc_wait_one_vblank() warns "vblank
not available" if drm_vblank_get() fails, but doesn't warn if
drm_crtc_vblank_off() ends the wait. That is intentional: it's a
failure to call the function while vblank is off, but a waiter, such as
the fbdev damage worker, can't keep the CRTC from being turned off
meanwhile. The error only tells the caller that no more vblanks are
coming.

version update:
1) https://lists.freedesktop.org/archives/dri-devel/2026-November/616745.html

Fixes: e8450f51a4b3 ("drm/irq: Implement a generic vblank_wait function")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Assisted-by: Copilot:claude-opus-5.5
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/drm_vblank.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f90fb2d13e42..54118eb1413c 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1303,7 +1303,8 @@ EXPORT_SYMBOL(drm_crtc_vblank_put);
  *
  * This waits for one vblank to pass on @crtc, using the irq driver interfaces.
  * It is a failure to call this when the vblank irq for @crtc is disabled, e.g.
- * due to lack of driver support or because the crtc is off.
+ * due to lack of driver support or because the crtc is off. The wait also fails
+ * if drm_crtc_vblank_off() disables the vblank irq before a vblank passes.
  *
  * Returns: 0 on success, negative error on failures.
  */
@@ -1323,14 +1324,22 @@ int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
 	last = drm_vblank_count(dev, pipe);
 
 	ret = wait_event_timeout(vblank->queue,
-				 last != drm_vblank_count(dev, pipe),
+				 last != drm_vblank_count(dev, pipe) ||
+				 !READ_ONCE(vblank->enabled),
 				 msecs_to_jiffies(1000));
 
 	drm_WARN(dev, ret == 0, "vblank wait timed out on crtc %i\n", pipe);
 
+	if (!ret)
+		ret = -ETIMEDOUT;
+	else if (last == drm_vblank_count(dev, pipe))
+		ret = -EINVAL; /* drm_crtc_vblank_off() ended the wait */
+	else
+		ret = 0;
+
 	drm_vblank_put(dev, pipe);
 
-	return ret ? 0 : -ETIMEDOUT;
+	return ret;
 }
 EXPORT_SYMBOL(drm_crtc_wait_one_vblank);
 
-- 
2.34.1

