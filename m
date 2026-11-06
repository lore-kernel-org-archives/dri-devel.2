Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07598606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0CF711294C;
	Fri,  6 Nov 2026 09:18:41 +0000 (UTC)
X-Greylist: delayed 467 seconds by postgrey-1.36 at gabe;
 Fri, 06 Nov 2026 05:50:02 UTC
Received: from smtp3.hiworks.co.kr (smtp3.hiworks.co.kr [121.254.168.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58358112513
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 05:50:02 +0000 (UTC)
Received: from hi-smtp-node3 (unknown [172.18.0.2])
 by smtp3.hiworks.co.kr (Postfix) with ESMTPS id 4jLSk502DLzYmkF8
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:42:21 +0900 (KST)
Received: from hi-smtp-node3 (unknown [192.168.71.11])
 by hi-smtp-node3 (Postfix) with ESMTP id 4jLSk46gBbzQMMbv
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:42:20 +0900 (KST)
Received: from hi-total-node5
 (amphora-3294b420-308a-4b9e-8a1d-bf25580dae1f.openstack.gabia.io)
 by hi-smtp-node3 with ESMTP id lbr5lkd2fuvv5ysj;
 Fri, 06 Nov 2026 14:42:20 +0900 (KST)
X-Authinfo: HIWORKS SMTP authenticated
 <nirvanah@nirvanahyj.com|114.203.237.180|nirvanah@nirvanahyj.com|261106144220_6981351674>
X-Hiworks-Remote-IP: 114.203.237.180
X-Hiworks-User: (SASL_USER) nirvanah@nirvanahyj.com
X-MailFrom-INFO: <country_code:KR|rbl_level:0>
Received: from localhost.localdomain (unknown [114.203.237.180])
 (Authenticated sender: nirvanah@nirvanahyj.com)
 by hi-total-node5 (Postfix) with ESMTPSA id 4jLSk33fXvzSqYcS;
 Fri,  6 Nov 2026 14:42:19 +0900 (KST)
From: Young-Jun Hong <nirvanah@nirvanahyj.com>
To: 
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Alexey Sheplyakov <asheplyakov@basealt.ru>,
 "Vadim V. Vlasov" <vadim.vlasov@elpitech.ru>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/panfrost: only put powered shader cores in the job
 affinity
Date: Fri,  6 Nov 2026 14:41:50 +0900
Message-ID: <20261106054210.2893230-4-nirvanah@nirvanahyj.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106054210.2893230-1-nirvanah@nirvanahyj.com>
References: <20261106054210.2893230-1-nirvanah@nirvanahyj.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On GPUs with more than one L2 (core group), panfrost powers only the
first core group (panfrost_get_core_mask()), but the job affinity is
written from shader_present, i.e. it also names the cores of the second,
unpowered group (Mali-T628 MP6 on Exynos 5422: l2_present 0x11, 4+2
cores, affinity 0x3f while only 0x0f is powered).

Write the affinity from the same mask that was powered, so a job never
names cores that are off.

Tested on Samsung ARTIK 10 (Exynos 5422), Mali-T628 MP6.

The analysis, the code and this changelog were produced with Claude
Code (Anthropic), a coding assistant.

Fixes: 6e55d273708b ("drm/panfrost: initial dual core group GPUs support")
Signed-off-by: Young-Jun Hong <nirvanah@nirvanahyj.com>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 6 ++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.h | 1 +
 drivers/gpu/drm/panfrost/panfrost_job.c | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 6081b27829e1..420d224276a5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -452,6 +452,12 @@ static u64 panfrost_get_core_mask(struct panfrost_device *pfdev)
 	return core_mask;
 }
 
+/* cores that panfrost_gpu_power_on() powers */
+u64 panfrost_powered_core_mask(struct panfrost_device *pfdev)
+{
+	return pfdev->features.shader_present & panfrost_get_core_mask(pfdev);
+}
+
 void panfrost_gpu_power_on(struct panfrost_device *pfdev)
 {
 	int ret;
diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.h b/drivers/gpu/drm/panfrost/panfrost_gpu.h
index b4fef11211d5..78a6270b7fcb 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.h
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.h
@@ -13,6 +13,7 @@ void panfrost_gpu_fini(struct panfrost_device *pfdev);
 u32 panfrost_gpu_get_latest_flush_id(struct panfrost_device *pfdev);
 
 int panfrost_gpu_soft_reset(struct panfrost_device *pfdev);
+u64 panfrost_powered_core_mask(struct panfrost_device *pfdev);
 void panfrost_gpu_power_on(struct panfrost_device *pfdev);
 void panfrost_gpu_power_off(struct panfrost_device *pfdev);
 void panfrost_gpu_suspend_irq(struct panfrost_device *pfdev);
diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 4ddf4b722ddf..33da86587db7 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -143,7 +143,7 @@ static void panfrost_job_write_affinity(struct panfrost_device *pfdev,
 	 * Eventually we may need to support tiler only jobs and h/w with
 	 * multiple (2) coherent core groups
 	 */
-	affinity = pfdev->features.shader_present;
+	affinity = panfrost_powered_core_mask(pfdev);
 
 	job_write(pfdev, JS_AFFINITY_NEXT_LO(js), lower_32_bits(affinity));
 	job_write(pfdev, JS_AFFINITY_NEXT_HI(js), upper_32_bits(affinity));
-- 
2.47.3

