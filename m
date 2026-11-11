Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E9606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Ow+Wrl/X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9EC610F97C;
	Wed, 11 Nov 2026 08:36:23 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011020.outbound.protection.outlook.com
 [40.93.194.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 925A810F973;
 Wed, 11 Nov 2026 08:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oW4rGcGzN/wxHCtfN4DEnr82q5CvTzKQMHC7dhg/eY6FFXgAU/LVh1WMsDhcUZmZfWKIRd+ZVzU+6ywGp/WI5wAfsZoQLfD+mDySdmVvCcLLpj+xcFCsSHNjfmiChzX8hsHEhF8rpQMN55xDRHw+arAK7ucXjDt1tIWQ0b/eGY5KBU0BHESb1uTxys44x+p3kUkFT/q7jkhdcq8ZTbFWIU/6s4szgZrqcksJuwGyuAm/7feg/Y8eUfEuoBX0x6ZJhMs39n1dxIN3iWrT2WNEUnAFJV9huxsjmQwigkSB+OCXkJC0RAaYhxrAXzc7wqI1LKQSsB95lx8cDva0ARzHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxlbnmWjrjD9khK5uQmKhouqp+ZxcZVmkvxqRB5r8Zs=;
 b=WPwa/gDGkE2gVR1r3RmjYApY29fygMnbEBchxc8ll2eafkpNli4fZc91go35NTKkUPEWLJBaSZHrFwsjeMljnzdiG+c05Mcc1XdRSFYiwmST81QIOsO/fFy66MjIesacuLfI1W+NhNSuu78pGvYWolhbUNL/rOynq3vWHgxy+9RTRLQFFLeQdMMKjDGUOgX07PEvXi9pQOHSSitxFz8ZgCvYTcCwFTVdNc10WPXvAgDwxeRqrZ/EIv9q/+b8gdGBb9rk9pTXfNszAhLScFk8Oeia6lrSAxD5eUaogKAtqeMPMCTDXCUlY4QY1qTM/BwsJVSexmBp+swkRjtsOJbHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxlbnmWjrjD9khK5uQmKhouqp+ZxcZVmkvxqRB5r8Zs=;
 b=Ow+Wrl/XtipCWOfSNgr+Sh/NehjbR+3D5rHMrZFoSmELLHrH9QmOIDWFwZqJkroHky5I4BzZ/rn+3Z79o/gyCvZtI4sNVU+5YB/RI4lx+jR+1flhP+LcoAWcbEsuapC9Tuoa/jej7kJ4RxSowdew4PSfb5MFiR9r971PJf2dp+4=
Received: from MW4PR04CA0312.namprd04.prod.outlook.com (2603:10b6:303:82::17)
 by IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 08:36:04 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::58) by MW4PR04CA0312.outlook.office365.com
 (2603:10b6:303:82::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 08:36:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 08:36:04 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 02:36:01 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>, <tzimmermann@suse.de>, "Prike
 Liang" <Prike.Liang@amd.com>
Subject: [PATCH 2/5] drm/vblank: Stop drm_crtc_wait_one_vblank() when vblank
 is turned off
Date: Wed, 11 Nov 2026 16:35:31 +0800
Message-ID: <20261111083534.514290-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111083534.514290-1-Prike.Liang@amd.com>
References: <20261111083534.514290-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e496262-fc8f-47cd-7c4a-08df3fced2d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261022115727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009221227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: O+0mkOzj8yTF365I2flS86urL6qeaBpbS7aXHZH/XsA2KeksCzJTRAjGz9a5vhthpfGMOJFbDn8VbFZhTR452lVv+3X3/rYqUYJVNXDZeXdPq2Dku6Ysl2lNa8SpjyoNVdYALdtMDr++/+C1GygxPmhMKIkLL9xHZHN0K3VvNvTJuUvbDnYK2AaFve8WTHxmcHudL3LYDOGCHNSatwidpYXaHegL/vf0xt/BXYEB2S5yJ4vF9FfVRkm6OkfLT0PuTntclbUhPAxntCjJPS21ICKn8Z0hQwQ2uH6K2GEXMX4sLz27hKF6S+DAIe3+pLkJcBI7WhkWy1APr7g80/tmVqrL9N64Q93eZVBBTneuhlk3LDARdHKTZsTcbWfmUmbvAG6zV7N9cVoaIWl8AQh/UbOtU52kHMGjoOvWJdxQec0FvNbtfrSaTe01HboZm3pMkrVLTQ69tktrys4nGmHCbJKjdEApWhMG6DwxfGaeylSrKHNTTTCkX09jUfOqXxaw+MJhArpsIybF+RJtBcmdAPV2h+o2xyVxQdb3jTDGroSLQejul8cvS+dfWpUWs1oMQ0R2WBIU+arMviHHQagvhWeac4FTcEeiHyDrdJwZpWIgxq4wOTu6Jf+lMmy6sakuhrF4omsKfPJJGzz7TD/7q1GVLqXg49LefhyriaoI7UwfO50AlKu3bWQsbtNEF11X1WvDFjmXQ2iP4zZAOvhNrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261022115727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009221227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TB2xR87AntYvA7FpcYXEiCEzKUAGyUilrX4FTMjDIiPdrpS0F2yg2vtsBU/8edc7xMHlIwEJz4hnU1n+pzSxCG7ZTnke4rbWJOZko07t2JrwQd+BhidAhbO27STf0GOQylvixmF9qxiUon8gDK502Y3iZ2vU2Hmtl6Uw6RZbFaJOW5EYsd6fioxvpj9Wl+KGR582NaXKNoLLWJBGlxKVcG4pPZcqKepmIgXPWzrXQxUcZADtZCZLcpM/sSG03h9rFHQcSvfkNpITU4+cXE4NBPAGJhKS29cH9Gb+pYGx0TlnDE9u6Q6kvXIrQU8unKsnH8GZ2ssrAobqCszXim63slRp5dBuX/KUSABRSHzbGhhcnZNlFG+NrXoXKPRrwuqmPUsasA3kyT9y33Y2StRIqetTwzFKcvjytpsKPghkRPpzYV1xxfJ1KljleW9vKYaz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:36:04.1668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e496262-fc8f-47cd-7c4a-08df3fced2d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_crtc_vblank_off() turns off the vblank interrupt even while someone
holds a vblank reference and waits for a vblank. It then wakes up the
vblank wait queue. DRM_IOCTL_WAIT_VBLANK stops waiting at this point,
because its wait condition also checks whether vblank is still enabled.

drm_crtc_wait_one_vblank() and drm_crtc_wait_one_vblank_interruptible()
only check whether the vblank count has changed. Once vblank is off, the
count doesn't change, so the woken waiter sleeps again until the wait
times out after one second and warns "vblank wait timed out". This
happens, for example, when the fbdev damage worker or FBIO_WAITFORVSYNC
waits for a vblank while the driver turns the CRTC off for suspend or a
GPU reset.

Make __drm_crtc_wait_one_vblank(), which implements both functions, also
stop waiting when vblank is turned off, and return -EINVAL if no vblank
passed, the same error that drm_vblank_get() returns when vblank is off.
The wait condition is checked before going to sleep, so this also covers
vblank being turned off between drm_vblank_get() and the wait. Waits
that see a vblank, time out or are interrupted behave as before.

Fixes: e8450f51a4b3 ("drm/irq: Implement a generic vblank_wait function")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Assisted-by: Copilot:claude-opus-5.5
---
 drivers/gpu/drm/drm_vblank.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index c3c9afc08ed2..5e247663978a 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1315,21 +1315,29 @@ static int __drm_crtc_wait_one_vblank(struct drm_crtc *crtc, bool interruptible)
 
 	if (interruptible)
 		timeout = wait_event_interruptible_timeout(vblank->queue,
-							   last != drm_vblank_count(dev, pipe),
+							   last != drm_vblank_count(dev, pipe) ||
+							   !READ_ONCE(vblank->enabled),
 							   timeout);
 	else
 		timeout = wait_event_timeout(vblank->queue,
-					     last != drm_vblank_count(dev, pipe),
+					     last != drm_vblank_count(dev, pipe) ||
+					     !READ_ONCE(vblank->enabled),
 					     timeout);
 
 	drm_WARN(dev, timeout == 0, "vblank wait timed out on crtc %i\n", pipe);
 
-	drm_vblank_put(dev, pipe);
-
 	if (timeout < 0)
-		return timeout;
+		ret = timeout;
+	else if (!timeout)
+		ret = -ETIMEDOUT;
+	else if (last == drm_vblank_count(dev, pipe))
+		ret = -EINVAL; /* drm_crtc_vblank_off() ended the wait */
+	else
+		ret = 0;
 
-	return timeout ? 0 : -ETIMEDOUT;
+	drm_vblank_put(dev, pipe);
+
+	return ret;
 }
 
 /**
@@ -1338,7 +1346,8 @@ static int __drm_crtc_wait_one_vblank(struct drm_crtc *crtc, bool interruptible)
  *
  * This waits for one vblank to pass on @crtc, using the irq driver interfaces.
  * It is a failure to call this when the vblank irq for @crtc is disabled, e.g.
- * due to lack of driver support or because the crtc is off.
+ * due to lack of driver support or because the crtc is off. The wait also fails
+ * if drm_crtc_vblank_off() disables the vblank irq before a vblank passes.
  *
  * Returns: 0 on success, negative error on failures.
  */
-- 
2.34.1

