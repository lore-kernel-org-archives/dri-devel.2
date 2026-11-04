Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4F0606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=c9WxttgQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0AE10F967;
	Wed,  4 Nov 2026 02:41:29 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FCF610F965;
 Wed,  4 Nov 2026 02:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DScPjfQ9FkA8Q/B4q5P4HlfAdaJGL2M2ExAnx2zKiNI3z5SiXlc1gFwMVwy8s/FX3A4GBTb5I5LHutXUR+a5mj5PCKHs8KuQ2NNyIB2Zk7u592vi1oyZkW+c5aW4+zAlekyhmOFLKsqqJWFOUVolITeZGkfzoDiGY8+cZe03lHpMmpOYPhO4wAgd40dc+a0eSZXKk2FnuPLNwdA+4N43AiJPfL0Skv+7p5KmScBtomuFSXklYzolPnEpAJ3wm069JdQ+Ed80XE/8wnM+Dy8abD24eDh9s3rsrgmFqY/JjBpQBS57lP17zSbuaM51LJHtrKx7e3wh2A+kAEsKSBLkRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVXIWvLko9oxna3w/BYnZ7fVN4LFgmrlAfpI9Y0dvv8=;
 b=y9L4L3LcX6jBnnI8yeYs222LGzBcVg4YD2ILwDfE4ackAVX/Dqs0ovCpogpc5e+sktVrQzvkHK6aWfLpsScOAcE+TfpnypGZOhvLUqBx8Yoh4fW+7GTWsPSPeISqD/DL/SoTzmP6edF/oa0q7LMrqSTjQcaRNGib3uhbecZSVAtH8L3FZHwGfuu8mXkZQdU1POU082th4EQ2ufkFHiAC+ZWrOeegFwM7iLFWU3VN7Wn1XfCeSrMS01Ui7AkhqqY8NAhghoDtLSjAIriUYg8BPGHkw5Kk1kJZu3W9E0j1HhvZDgsTIRKdYKay//7wUvqinUFxmwdvNFo1Bqk3SyInvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVXIWvLko9oxna3w/BYnZ7fVN4LFgmrlAfpI9Y0dvv8=;
 b=c9WxttgQLgd2giBqNJvucP/qIZjOAlp9ZAwGmnhdbBg7yMQrweAjMrQjkiB0Qc7LekpRQ5rxsbgJQIHNKy64jnK3Z72WIz5TGADHHEdet4g1vmn+EkdhGXr59TAP+SDtQbt+JpUoKb/N8RykqWb/hGo/r7R3jfU2ZLaWqOzkKk8=
Received: from CH2PR02CA0026.namprd02.prod.outlook.com (2603:10b6:610:4e::36)
 by CH3PR12MB578402.namprd12.prod.outlook.com (2603:10b6:610:34a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 02:41:19 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::80) by CH2PR02CA0026.outlook.office365.com
 (2603:10b6:610:4e::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 02:41:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 02:41:18 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 20:41:15 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Prike Liang <Prike.Liang@amd.com>, David Airlie <airlied@redhat.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/client: Don't warn when a client's VBLANK wait times out
Date: Wed, 4 Nov 2026 10:41:06 +0800
Message-ID: <20261104024106.3109873-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|CH3PR12MB578402:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba7012b-02eb-4a5a-8c90-08df3a1d1ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|261102123227099003|261102130727099003|5023799004|11063799006|261028144727099003|261021121427099003|261022115727099003|261009223027099003|261026140227099003|261026121527099003|261021123027099003|261022105027099003|56012099006|261022075727099003|261009221227099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: nfenvozEKJyqD+yI+JuD0/kvLuJu3tjhJUxdafr7UCNBpasos9jxFZ/TXGz1mtEpUzvm0JU3sXwdgAJPo7e8bQECKg7PhS624LpBrTAHSRJc8X2pSWkCI3gJIym8IGCqWK9dtqq8/BMXjq3jn3LfAPIQgipGLvAHPTBtB3bA94BgrbyKFZtD237bs4s2BEY29AoSzAmhQQaQEC7IsbYIYhnmNFSZ5r/WhUtO6TbRhFah8TKJBUfjdUOx8tyn+XEqD4RlHuCJDzNBGp3o3DZ3EjiwCqQ9vdrRD3qknavq4Sxc7KotxeAc3dB5ZO4UfqBJFPXujZ2BHl0c2KYjLoJQ045/J19vCyA7dOfDv3Z1xrSTo7UnTLVY1HwQBDe2/PRz/f1QMehkuqP7TD2pHJZmqX2Y+SxxfMyOl8+hdXMjR4hR5hBn182VMGCWBruMU4FRW63A3sXHwLu3JBUWHi9mgKPisbMz3QppjTO7S31lwWmpOshgmXvEAqJ907jCFv9+CUZnn6nOtvwnUIz7s0bIdUIKRIx2ZW7cc1KqBf0KcXiaNlyLhM7tlMuOIa7a68/X0gdiJcOPdamCVeqylhaaSyy3gNLLGDZJXIuEQ/jRLq49dUhBEj4MIYWvY/ZrRJfHDtgJJ4Ypkpdg8Nk9gEkKlJULQ9qbKtyEqWq0F2M34u5mEHfUpXk/7/ixSOPko4Hory5mTfT5zJQDGIPEO5secg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(261102123227099003)(261102130727099003)(5023799004)(11063799006)(261028144727099003)(261021121427099003)(261022115727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022105027099003)(56012099006)(261022075727099003)(261009221227099003)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: O3Y0oVpitj19808+5uX6asV54HDccsapo+sgYp21L0BokmeKdW8rzFKHWuq9W0WBEC7Csp3VWZdndzQHZhJL8HPTr6mGJKNXD4AV73aPgZMz1Ui3OXecUlmLrxI4vmfWVz872LCzPlXi3RNZYj9yhgXS4IVV8E03lyjmhhbYig/8x5fT7UsTfL386ipzT2vSID8zUUgzN+zOBm3PrcWWfHap6E17Rvq/3d3PipKzK4NVDOROUdnuRi39s4VFYDoqidZUTNt7QTWRk2PLdmWxyPLCnIsX0yMqg4S5BYwvs0ngfT369vZhPQxvd4I2Pv1fSCtJNqMdUPhFTRpbdAeAsrB64XoLwS1pSxUOn/nPx6xE2I8mhSXpY3cF/2b+pZfbyvlMOis6V8eLKtuDZwz4V9n03+FKs0jeBeyhSf6RM5y2pBA1PhlQsZO2i52707Cp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 02:41:18.8909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba7012b-02eb-4a5a-8c90-08df3a1d1ae0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB578402
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

drm_client_modeset_wait_for_vblank() only rate-limits fbdev damage
updates and serves FBIO_WAITFORVSYNC, but it waits with
drm_crtc_wait_one_vblank(), which warns if no VBLANK arrives in time.

VBLANK interrupts can stop while the fbdev client keeps running. Since
commit ebc3351cc4a9 ("drm/amdgpu: remove suspend/resume DRM clients
during GPU recovery"), amdgpu no longer suspends DRM clients for GPU
recovery, as that made recovery wait for clientlist_mutex, the console
lock and the damage worker, whose holders can depend on fences that
only signal after the reset. The display is still shut down for the
reset, so the damage worker now times out and warns:

  amdgpu 0000:03:00.0: [drm] vblank wait timed out on crtc 0
  WARNING: drivers/gpu/drm/drm_vblank.c:1320 at drm_crtc_wait_one_vblank+0x194/0x200
  Workqueue: events drm_fb_helper_damage_work
  Call Trace:
   drm_client_modeset_wait_for_vblank+0x63/0x80
   drm_fb_helper_damage_work+0x89/0x1a0

Userspace can trigger the same warning with FBIO_WAITFORVSYNC. Wait on
the VBLANK queue with the same timeout, but log a debug message instead
of warning when it expires; a missed VBLANK only means the update isn't
synchronized.

Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker with vblank")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Cc: David Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/drm_client_modeset.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 0080a8e9556a..7b3193d73bbf 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -1301,7 +1301,8 @@ EXPORT_SYMBOL(drm_client_modeset_dpms);
  *
  * Block the caller until the given CRTC has seen a VBLANK. Do nothing
  * if the CRTC is disabled. If there's another DRM master present, fail
- * with -EBUSY.
+ * with -EBUSY. Give up without a warning if no VBLANK arrives within a
+ * second, e.g. while the driver resets the display hardware.
  *
  * Returns:
  * 0 on success, or negative error code otherwise.
@@ -1328,7 +1329,14 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
 	 */
 	ret = drm_crtc_vblank_get(crtc);
 	if (!ret) {
-		drm_crtc_wait_one_vblank(crtc);
+		u64 last = drm_crtc_vblank_count(crtc);
+
+		/* Unlike drm_crtc_wait_one_vblank(), don't warn if VBLANKs stop. */
+		if (!wait_event_timeout(*drm_crtc_vblank_waitqueue(crtc),
+					drm_crtc_vblank_count(crtc) != last,
+					msecs_to_jiffies(1000)))
+			drm_dbg_vbl(dev, "[CRTC:%d:%s] vblank wait timed out\n",
+				    crtc->base.id, crtc->name);
 		drm_crtc_vblank_put(crtc);
 	}
 
-- 
2.34.1

