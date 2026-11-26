Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D3D606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=asjDfbnM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A783810E980;
	Thu, 26 Nov 2026 08:55:56 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2514810E980;
 Thu, 26 Nov 2026 08:55:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jh43d2zLC6Xa/fV+xSL/RKE9SqChSR7jjQH88g6gK6bDLs0mHOvH03cLgmbPlKCRyY00Gb77Njz9ar2zMTbGh2gI4w+jHmNP3PV5MDqY3sQIXeHUSB1nI2Y8M9KcnaMfPuDTY9YLfpmEIX63O0mI76SPxX6zPLghZIS+/5VV884++v0EWU0MecbPBf1dEc3fFnIrKhAZMBQmfiQEDFAFcH+r2/cO0LPwRFL7fepLGb5LKuIUQajgMyxeeg46TWORSlgHEFWaa455WWsS8tpvSwwmWzMD3oe5/kPoefzRwsI3/tg65U+Pv676lwvW/LMIx2W5jgYPqgzcC6xmkbVJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1vzElkEHxIvJnfEfPtogXM8xYQkDILgypZ6JQOC0k4=;
 b=K16x8jNnE67D0fdBSxi1DwyIEXKcha2M9b3HZXRlfQgMxpXuur1j1wnA9ca8tqxUR9Xd7ZtpG1xWqxYZbnF34JPY3Xs82S0iTSCeOr2/SyLLs7TtJvCnxJ2o+eNMEcJW5fTllRK+GiUZ/jMlfaOCMeVZq7AnJHOpKsvWv8ipQ/6yX4Dl0shWu7FSUvsQmMCMeXJrZ8Rd8oB1jtW3JSCQuO8dPjuk42U291aPugqA1a/ffHiyZpHSj4zzQdfSnWRfYzt8yDUe6Il0izxDbKkh51sWeEovT5UovAbFZolRcosV+pFV7ZuDhI94tO4lRA7sVxDC5WU/77a5kKf4cVKwng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1vzElkEHxIvJnfEfPtogXM8xYQkDILgypZ6JQOC0k4=;
 b=asjDfbnMXasYtKdn+SfxaRsw+XeuLJImKmvu3dJSvgD5XqmKo8u0700AUhJ/vMjap4u/VFlbVoSp4EEy6dmAv/T/qM3A4x1VzXsCSlquSo+ah0UO5+jhCgnKgFXMFHE8W74r67BcUKXe/JsEDVknCh6c8aS6PoA/lYu1uGE5WU4=
Received: from DS1PR04CA0001.namprd04.prod.outlook.com (2603:10b6:8:44f::8) by
 PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 26 Nov
 2026 08:55:43 +0000
Received: from CY8PEPF00000057.namprd21.prod.outlook.com
 (2603:10b6:8:44f:cafe::44) by DS1PR04CA0001.outlook.office365.com
 (2603:10b6:8:44f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 08:55:41 +0000
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
 15.21.688.0 via Frontend Transport; Thu, 26 Nov 2026 08:55:41 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 02:55:39 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <tzimmermann@suse.de>, Prike Liang <Prike.Liang@amd.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH 1/3] drm/vblank: Stop drm_crtc_wait_one_vblank() when vblank
 is turned off
Date: Thu, 26 Nov 2026 16:55:26 +0800
Message-ID: <20261126085528.820182-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000057:EE_|PH7PR12MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 21fd1e71-e772-430b-5dd8-08df4b9b0c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|261009221227099003|261009223027099003|13003099007|18002099003|261022115727099003|261026140227099003|261022075727099003|261026121527099003|261028144727099003|261022105027099003|261102123227099003|261102130727099003|261021123027099003|261021121427099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: gvOvEkaKX50Gealn5mFsPA8+J6hbXAetJ7T+TRyISJlMxhnhLDoKHe/nVrlgb8BQkmEJ5DiDUl/1R/SKWlXTuoF2QnGWMdgOb7a6YxrtovPx5fxZEIxubsHkSB+E/AoUTFFXIdf9QKtRpYxbD+EBliNx/NY6P61cR5Ccj1q+uQPgaocBSAWW+EGob5xJcga1B38ZFXUBGEphTxM5MhK3IazALdNxP7BqTYTg+Pc/8zD4YBF88+GdE+moQBl59XFWpH8APoH6Edp/1/2xXBMQnhdJn9wTZ9hjTnMUodli0jKuud7J0qefDv2vIEWfdHZvGYu8OpjRS8dufwbYddoh7rawp5+djbxzjIfnc9OYplUoBvpG/tJ9VT5/i4FcLZ2d3gMSQVhlHGHw9UbmY6pj3DIeGQWFYYZEBTkOOyjrYji+AgkkH0+fjGSbLlwgWemsjjO7Y5Wlks6DWoHm8pwYZRwYkxnCSOlIZjhq9p44AM1C5UYQG9GoWW8EXI414oIzOqiBD2PqeVzK2jMYD0tXNYIQpO6TwCxHFbUdXWhU8naQA3xwVzkcn5JFysHOQLPk18i9RkqmobVLY07zSwDbi/xumogU3GIvjyO4CWffqVdtWYjgCoLlhGTM5KVzZJOs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(261009221227099003)(261009223027099003)(13003099007)(18002099003)(261022115727099003)(261026140227099003)(261022075727099003)(261026121527099003)(261028144727099003)(261022105027099003)(261102123227099003)(261102130727099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R/BmBfq8OFQ5SD/bFRo+Q9aWUa1l7xp2lG1vTnyW2GzSP11S2jzxHxwd6Qfe0wBPN/TCa4ZC3Ntr12Ww5hjiC+ExY6j5MQEaWTr37edWlBKXNnY9B+eeq18h2QFzq1jAm85v7d6kHVRnAsKgYpH78gkY1XbDDpSuNZIEEwahmIMrGOdLcBfcEPmJLomB5pLJmqSjTT1G4Ku2uWrlbwQh8J8fyBrotOledaZQRdmy6dxawaFcsQSfqLgxQtOjFhYRxTqUM7o5VTre+Zd2q/8tKIFMW8oXEOqU+WoB7ojcZbQG+wFT4g/PB/hLjMbDUsiX0ZQKTHdTUFnqzNe8PJEVL30dtsivuXvm2Efv3eXM676naTyRwlLdl6gwgZRwWZKPG+Ij2F32J345JoAVJ5doJV/q1yJ6564a7+XGSg3lj16fm3g8Mq7+X0vtzSnHQQq1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:55:41.0376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fd1e71-e772-430b-5dd8-08df4b9b0c7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF00000057.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161
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

Link: https://lore.kernel.org/r/20261119082424.554841-1-Prike.Liang@amd.com
Fixes: e8450f51a4b3 ("drm/irq: Implement a generic vblank_wait function")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Assisted-by: Copilot:claude-opus-5.5
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_vblank.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f90fb2d13e42..02abed5324ce 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1303,7 +1303,9 @@ EXPORT_SYMBOL(drm_crtc_vblank_put);
  *
  * This waits for one vblank to pass on @crtc, using the irq driver interfaces.
  * It is a failure to call this when the vblank irq for @crtc is disabled, e.g.
- * due to lack of driver support or because the crtc is off.
+ * due to lack of driver support or because the crtc is off. The wait terminates
+ * early with an error if drm_crtc_vblank_off() disables the vblank irq before
+ * a vblank passes.
  *
  * Returns: 0 on success, negative error on failures.
  */
@@ -1323,14 +1325,22 @@ int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
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

