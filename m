Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4F606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tMQL6Fto
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F3F10F9A1;
	Wed, 11 Nov 2026 08:55:58 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012036.outbound.protection.outlook.com
 [40.107.200.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A1E10F9A1;
 Wed, 11 Nov 2026 08:55:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irxqMZMiVpK5a7qnL1Fa/N6W8ciGBDvnF5wmYdor0jSghPidC76YHYialtm8Wcv/VfwiAix+8A1jW7J8Urz0BDyT0WKPyLbCn8PeN2wL0keJPeKeYBDhKRZsa6550RWuGOiCw2TxQg5DWKe2B4sHG3qTpGU6JE3g30QIlRqwhcswfLlL3dppgkcwkfQkAw9jlO/KSZxZESu+MvY7c0TmyM+kioAHkQ+QbC0fhOps9lZVp4Z72vyGpVDsV2+9dcPe4lhdksfr6/7d4NQq+Cz77AAjyDtGFNEOl3sYAb3ahNGvai19uxerS+Op7LqPgXvm4oM/i03KzwAooXDcKB4PPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrKJLBnwJZvN7p9IbiYzBxGx3w3p4Sgzu5Qbv3vJhkE=;
 b=ib+97hBFPpMsHxAmSQy0oihbCtUeGkHvMcGac5pa26KotxBs1vVGco3/LJJzPrkSK2cx6HwU7WiQ9+XTHw33uGq0urEbMNmGDw0fxURPmaGhpnln8r+MAAIJl3U3/UyIzxmYWgJdCnBsx2TpDsQCRTpL0ddb+PqD6c6uK+JXUMByr+2AoKg0Dz8w/eEwqAEfghOb+k3vIKW72sq71GZUwEypKFzz0c1lP/xYVPN8ptF83LKJYJgsTQKICKDAbJoDqQRYNeecDnZmDuNNRYVeHxnM2Sk1nLMjwGu78YVEHxjOufPs/VVY92ppCC+F6FXjknDjeDKcZl13S+QhR5bxXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrKJLBnwJZvN7p9IbiYzBxGx3w3p4Sgzu5Qbv3vJhkE=;
 b=tMQL6FtoTiiCeNAwoVv9jPSZbctjEv02HmM8zt7YZQZ/Dcc9AnqH5CfIbsNawupp7l2zoF8mQhuWxWjsLnp7EntAh7Cfzn+mp5DgjZQXhd1KBxo87JoZlrHOC3ED3tdBTRscZPa5a0BWk34qbmtA6Sw1OdtHYmghKQDXKNS/Cz8=
Received: from DS7PR06CA0050.namprd06.prod.outlook.com (2603:10b6:8:54::32) by
 CH9PR12MB987669.namprd12.prod.outlook.com (2603:10b6:610:312::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 08:55:49 +0000
Received: from DM3PEPF000265B8.namprd04.prod.outlook.com
 (2603:10b6:8:54:cafe::37) by DS7PR06CA0050.outlook.office365.com
 (2603:10b6:8:54::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 08:55:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B8.mail.protection.outlook.com (10.167.23.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 08:55:48 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 02:55:46 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>, <tzimmermann@suse.de>, "Prike
 Liang" <Prike.Liang@amd.com>
Subject: [PATCH RESEND 2/5] drm/vblank: Stop drm_crtc_wait_one_vblank() when
 vblank is turned off
Date: Wed, 11 Nov 2026 16:55:31 +0800
Message-ID: <20261111085534.514957-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111085534.514957-1-Prike.Liang@amd.com>
References: <20261111085534.514957-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B8:EE_|CH9PR12MB987669:EE_
X-MS-Office365-Filtering-Correlation-Id: 1461a546-1367-4602-64ba-08df3fd194eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|11063799006|56012099006|261022115727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009221227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5+a0VzydNWAl/005uRjQiQ+/LoSbs6hHVK6Wd92B/sBzhD7ORnRZGTPm8L5zbrhRLlaOlZYmJfaqIghHvxm1Pr1bJEtBaZr2tZszU3gAYzJmoBTXhsK78NiVHirAvpwK6Muxyqum4ln2PgdR1VCk7WInkTKu/0GK3CQqUY9LY7nwtLtoEVj65PUosRYORmzIbWZgsgsit/J6dZGvbBpTk6KiSuVS5M88KEJ0B0BJNHrrithk99RRVMWlzG3KxSP1P0gPPwa6erVVkeYq4HjtR5zDjTQY19nZ2eQL3vgw2gbYHCJTtd+ldtSsV0CGfSCoYX35/0v7N971hFOF8b3jP8JvDMBxxGL8GyriFIdl8TeiFJoWQbKvlvKSZ2lANDqjmlRx2OneZ/6sgiGjyRkcBP92DS+ehDeP3vL2zkcnU7Jdu8299eFIIBNvBzQjEzHCBVrd+lwY+7RgdspaQdd5aC9U8MQdZK9apu0sU2jKFAXjuqFhMXxltlng4MdcWdRQ26t4Rzz66ay0uhOQjLzOUdYRlfN9GHG6wIN+bIQzADTWHWe9rwTje6oloyZdIkw6OO5Pjhh5OQUv6sZWeHH1Kkaccz6+5slZ1P07bl2KcVuoujzHUMwLRERp784HmNqUQtyQlHQs89LQEGuk61jBjbOri3mzhFCDjG4vnuyKSN0vl5OihmNKRHZRJ5khVvE44mkC2cT9ksBTkRCiQUFgGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261022115727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009221227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AjfFx6A4u5k9KkSMgxF2SBkCFglWxnrh7sE3p359sGgvMK6Zd6WJr6uH4gH11HDEURnda8ggXkQBvCcb84UMOJs+a+oE8Cq5SUpuKbVqjOYeB9P4YquLzanwn09IOGWbqCU4xEb3m46kHUzEVAXkBaQANKh4UzYenfjLM4oz5llF3YOXUxTyOkbC9DNY8qa33QL285pJ+cdan6dkrwcyGOuEp7j8aHVy5yNjm3R+M+TqGd2sH3vPzyj7G8eO4CtUodfwTCqYtTyU4kTuEp8WCjasSeOfletukQpDXUMZVymmrVuT89fePrb56I6HSWtmra62YJbt8CTTplNlcvqJJxGuMzt1k0qqr7a7/uOZoRtSKbK/pSn5CtR7NWxMm7ndK7OAm7yUC3mVTFQ49zK8u8G0yOoKIBFowUYzjhh+fBfJOc7kzbW8iayW76eQwWna
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:55:48.8334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1461a546-1367-4602-64ba-08df3fd194eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265B8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB987669
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
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
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

