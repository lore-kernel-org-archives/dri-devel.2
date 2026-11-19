Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DE3606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t0eLYzw3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DE7B112148;
	Thu, 19 Nov 2026 08:25:34 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4DC8112141;
 Thu, 19 Nov 2026 08:25:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJHGORW2Hj6oTff07C3lU/DzjnFERIlBkI0i7I6XSIw0PawL4fE30JyP+tbxYBtKIMOaPmHE6azyruOpZMIQ4Er7MrufuUjv9zGw6edOolfGf7Q/j7q3kwctZSV1EmYakJKEqcf4XCNhIXL3q9K2C3be5slX/3AEKqdStHLrYp1aZ4hc/HEjJCu11BeDGHZjwTvllOFZuoUEUaFxyEPAnG1IOkyIiMUSZLDC8DM/IX5z1vpMKQBhkyqXYzQ2V2yyy/PfL3SitdF5jvw4OPHxBPk+QUTFtmEathj2U6sTRqeswWSyodLrLPsxiQrii7VuKjhznDmGzA1rgk0VdhjyyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABvkKxahJt6d5Fj+mRtR2yTJjrRp2flEKIZSN9N+wLA=;
 b=LxvaDQs/jb96buJLf0CVpiPwgvsiOBhpbMaxduxGKXaYHlNqrQ8cIuED0sxNHM+AvueqOTJFDYR36KWvbA4JDfu94TBAh4GbtjQEwW2nH9ed/T1IW8+r0O9B/LON3h8c+fnITBtQBR30wd1qiUL8Z9OkV06FFbeghdItPTgW+Mbn9ZrgQzEHdEWAtGgA7izjEoN3IrbPjOLAIsU5ScjpiEC1JTOH29BeyRsMTLlGdqCo9bvMt3+m+v3MMwgflb6UmslQ2uGCj15cqtegJijU8aYrfVFZ969Hyr9jzhE2igpDoIPH5FIh8Ic2CCw5LHD+U/PrsIx7AOliZLCiE5BWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABvkKxahJt6d5Fj+mRtR2yTJjrRp2flEKIZSN9N+wLA=;
 b=t0eLYzw3773y4KDo8E4FeifJkdYdGdLn0BQLIjrywCpCGnLZSG4SKKZ3efIbxWr05CQHtVbSmNOqPkqP0LOzfc7QeMGI3e2xj24vSc34KoJkQuckz2kXw/6C5wDgnHLr6Z8ILbDPdWKhx80joCEGqwZpO/38aOGxyXFT5nsz6YQ=
Received: from SN7PR04CA0067.namprd04.prod.outlook.com (2603:10b6:806:121::12)
 by DS5PR12MB015052.namprd12.prod.outlook.com (2603:10b6:8:47d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 08:24:42 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::29) by SN7PR04CA0067.outlook.office365.com
 (2603:10b6:806:121::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 08:24:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 19 Nov 2026 08:24:41 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 02:24:39 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>, <tzimmermann@suse.de>,
 <ville.syrjala@linux.intel.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 3/5] drm/client: Make the FBIO_WAITFORVSYNC vblank wait
 interruptible
Date: Thu, 19 Nov 2026 16:24:22 +0800
Message-ID: <20261119082424.554841-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119082424.554841-1-Prike.Liang@amd.com>
References: <20261119082424.554841-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|DS5PR12MB015052:EE_
X-MS-Office365-Filtering-Correlation-Id: 8247f425-5e74-4181-6182-08df46168f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|5023799004|11063799006|56012099006|261021121427099003|261021123027099003|261009221227099003|261009223027099003|261102123227099003|261102130727099003|261022105027099003|261026140227099003|261022115727099003|261028144727099003|261026121527099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: +7benET1cvLodHvou1ORroawEPErZXsFUet+CzHWBJ4uC480Dh3/PKN+neKS3lVw73ZFaHd+WmPgsq1VVaNTkMAjSaPLVlQuFL5hv3/Z4m2mlje87SckNUtLsG90sDQQsA61HMTFqw6noZf0MpcxElRpPOu8Am1TMm3JqnjjAqIOaWf1Xl/0HWpcMyO14GMpl4dTg9on4nEGV0j7tAvb0i5LqZcUGCDl9FMIMvFdsIpYZiT69zsUABtt1u4DamJ16fs9m4+3K4wjUWymgIHz1zQD22qj93rlc2fvzNHxmVBM/FoilFCdSHDwVbmoamovSIoC5XBimypsi7Vj/KjTUy808vthSmRtLwu6LC7v4p1rChfCBRXzJMymXN/GFYtxiIOBPNY67vi11wBP2WOMcAUZYDRnW5UdC6v4a2TeHRl0WzfmnkdzsuLbvXIhG2fpKi1arcSU4FrwGAFA2XzBmdq4upmP+Zm+eDKuh7FWA0IEL8WC1Sj3IUWiuWy2p+XFvocDIFdS+bkfCHJDvLfertTn27u9g9VJvqBWaS2F/B6rw3XqNK51ggdLDc4SiwAIsEshZYELRW2dTx971grF6uD061lH+s16eTTtktjEVpKvITZP2rvEsgTNanm86ksIARB+BKSyHC/NkX1d5f+kUfP/bpe1MbQhRHn6ywV323Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(5023799004)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009221227099003)(261009223027099003)(261102123227099003)(261102130727099003)(261022105027099003)(261026140227099003)(261022115727099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xqM9MdHzUGGKhPYSBKNlrvdD0LgWuz8pFwQBKyN4+qH+P6RwQcLMP9mz2amaLTFuistQKK2+2+jafLQ8q/ndYStDtJuUg9ssJ68rzFau+mLP06NXHzSS842CLysdLKYb3hxYu3ysCgZEw9/dO7ArhpsvcUKDD7rdKjI/nlxYs+VItOTog7ievF++haCnkduIKmnoQn6TaYgGbO0HjB6YvdqwqtiZINtOlgCu3dp20XSI6tUVspTUBWhiWFcdZe3ZB1WF6VWAXEDwH3afS5NcCSzWc2NyFf2owJN44y8I3ly36epSX9gFBiVe79kWAa6jkINLr4dqm7TUKQOzgGE9vovBRsk9TXmY2maT3AT17xItOclKS/cXaEuqL6tymLQvsYW49xjF7lluX/dWCsNRFypccq7A//tv7khVjshknjZGFvDWJpy9AAJq7JcloaON
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 08:24:41.9903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8247f425-5e74-4181-6182-08df46168f7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR12MB015052
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

Version update:
1) https://lists.freedesktop.org/archives/dri-devel/2026-November/616727.html

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Assisted-by: Copilot:claude-opus-5.5
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/drm_client_modeset.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 0080a8e9556a..b475b8dbdb17 100644
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

