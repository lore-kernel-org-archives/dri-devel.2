Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46FFC44503
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8772E10F406;
	Thu,  9 Jul 2026 07:25:21 +0000 (UTC)
X-Greylist: delayed 18681 seconds by postgrey-1.36 at gabe;
 Mon, 06 Jul 2026 14:36:47 UTC
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net
 (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
 by gabe.freedesktop.org (Postfix) with ESMTP id C8A1210E3B2;
 Mon,  6 Jul 2026 14:36:47 +0000 (UTC)
Received: from zju.edu.cn (unknown [10.98.66.117])
 by mtasvr (Coremail) with SMTP id _____wA3lWV7vUtqkwsSAA--.40276S3;
 Mon, 06 Jul 2026 22:36:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
 by mail-app1 (Coremail) with SMTP id yy_KCgCXUpp7vUtqr5qdAg--.62646S2;
 Mon, 06 Jul 2026 22:36:43 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: alexander.deucher@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com
Cc: christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v2] drm/amd/display: fix HDCP workqueue use-after-free on
 destroy
Date: Mon,  6 Jul 2026 14:35:48 +0000
Message-Id: <20260706143548.136979-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: yy_KCgCXUpp7vUtqr5qdAg--.62646S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?hJKP1wXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
 sfnVCjTgEH9dVomQuWcozCBBGoR3dPZ79r59DHMQ051o0gjtqxuCbEIjiKMJGoEUvIi0Pt
 AvxUW0K5SLWfMxk7ti+p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxXFW7ZFWkWr47tF4kKr4ftFc_yoWrAw4rpr
 WYqr1Yyw4UAr42qr9rXF1kWF90k3ZYqFW0kr4xCw4ay3yrGr13tw1rJFy2gF4xWFWDZa1a
 vF4UX39rZrn0vwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
 xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
 CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
 xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
 kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
 WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
 cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

hdcp_destroy() cancels callback_dwork, watchdog_timer_dwork and
property_validate_dwork, but leaves cpirq_work and property_update_work
queued. These works are queued with schedule_work(), recover struct
hdcp_workqueue through container_of(), and dereference it. If either work
runs after hdcp_destroy() frees hdcp_work, it can trigger a
use-after-free.

The HDCP callbacks also call process_output(), which can requeue the HDCP
works: it always queues property_validate_dwork and may queue
callback_dwork or watchdog_timer_dwork depending on the state-machine
output. A simple cancel sequence can therefore miss work requeued by
another callback. hdcp_handle_cpirq() can also queue cpirq_work from
outside the callback path.

Set a teardown flag under hdcp_work->mutex before draining the works.
The callbacks already hold this mutex while calling process_output(), and
hdcp_handle_cpirq() takes it before queueing cpirq_work, so once teardown
is set no path can requeue work. Then cancel cpirq_work, the delayed
works, and property_update_work before freeing hdcp_work.

This bug was found by static analysis.

Fixes: a193ed2094ba ("drm/amd/display: Create amdgpu_dm_hdcp")
Fixes: da3fd7ac0bcf ("drm/amd/display: Update CP property based on HW query")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>

---
Changes in v2:
- Gate hdcp_handle_cpirq() with the teardown flag so late CPIRQ handling
  cannot requeue cpirq_work after hdcp_destroy() starts.
---
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 20 ++++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |  2 ++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 4c164ae4a4f9..2293e9761891 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -164,6 +164,9 @@ void process_output(struct hdcp_workqueue *hdcp_work)
 {
 	struct mod_hdcp_output output = hdcp_work->output;
 
+	if (hdcp_work->teardown)
+		return;
+
 	if (output.callback_stop)
 		cancel_delayed_work(&hdcp_work->callback_dwork);
 
@@ -310,7 +313,10 @@ void hdcp_handle_cpirq(struct hdcp_workqueue *hdcp_work, unsigned int link_index
 {
 	struct hdcp_workqueue *hdcp_w = &hdcp_work[link_index];
 
-	schedule_work(&hdcp_w->cpirq_work);
+	mutex_lock(&hdcp_w->mutex);
+	if (!hdcp_w->teardown)
+		schedule_work(&hdcp_w->cpirq_work);
+	mutex_unlock(&hdcp_w->mutex);
 }
 
 static void event_callback(struct work_struct *work)
@@ -487,9 +493,21 @@ void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work)
 	int i = 0;
 
 	for (i = 0; i < hdcp_work->max_link; i++) {
+		/*
+		 * process_output() can requeue the HDCP works. Set teardown
+		 * under the callback mutex first so no callback can requeue
+		 * work after destroy starts, then drain any work already
+		 * queued.
+		 */
+		mutex_lock(&hdcp_work[i].mutex);
+		hdcp_work[i].teardown = true;
+		mutex_unlock(&hdcp_work[i].mutex);
+
+		cancel_work_sync(&hdcp_work[i].cpirq_work);
 		cancel_delayed_work_sync(&hdcp_work[i].callback_dwork);
 		cancel_delayed_work_sync(&hdcp_work[i].watchdog_timer_dwork);
 		cancel_delayed_work_sync(&hdcp_work[i].property_validate_dwork);
+		cancel_work_sync(&hdcp_work[i].property_update_work);
 	}
 
 	sysfs_remove_bin_file(kobj, &hdcp_work[0].attr);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
index 90b18c450ca6..2313434b57c0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
@@ -54,6 +54,8 @@ struct hdcp_workqueue {
 	struct amdgpu_dm_connector *aconnector[AMDGPU_DM_MAX_DISPLAY_INDEX];
 	struct mutex mutex;
 
+	bool teardown;
+
 	struct mod_hdcp hdcp;
 	struct mod_hdcp_output output;
 	struct mod_hdcp_display display;
-- 
2.34.1

