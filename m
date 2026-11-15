Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9BE606A31E
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=jTHSvA5/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B14A10E051;
	Sun, 15 Nov 2026 11:53:25 +0000 (UTC)
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Sun, 15 Nov 2026 11:53:18 UTC
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com
 [101.71.155.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A44310E051
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 11:53:17 +0000 (UTC)
Received: from [192.168.17.1] (unknown [124.79.98.159])
 by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04f2;
 Sun, 15 Nov 2026 19:48:10 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [RFC PATCH v2 1/2] drm/bridge: protect complete HPD helpers during
 unplug
Date: Sun, 15 Nov 2026 19:48:07 +0800
Message-ID: <179474328799.103840.339489006600833395@seu.edu.cn>
In-Reply-To: <179474328603.103840.4363768155390012601@seu.edu.cn>
References: <179474328603.103840.4363768155390012601@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-HM-Tid: 0aa1df094ac503a1kunmbac61c98bf7ba
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHx9NVkpLSUwYH0xJGUlITlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
 ++
DKIM-Signature: a=rsa-sha256;
 b=jTHSvA5/LJKPs2weugYzR09ChYp1GF56CvCcatsb3rpW3QtLCt9A7JC4We2q2h7mvlYronOSvXow5nJbrq2IQbTVYj4oaNiyB+RfRi80ghzHjlQIFMJ9/01QZrSrFhoKumo3QSGaJ1ApqWce3n6a2cJvmWWlOoI1bk1D5S8x0S0=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=9zw9gLo4xSdeNGbb2wIoBEkOuWDWIwBbMytZCe7N47s=;
 h=date:mime-version:subject:message-id:from;
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A bridge driver can protect its HPD hook with drm_bridge_enter(),
but the core HPD helpers acquire their own mutexes before that hook
and release them after it returns. A driver-only section therefore
does not make drm_bridge_unplug() wait for those mutex users before
drm_bridge_remove() destroys the HPD mutexes.

Enter the unplug critical section before acquiring HPD mutexes in
enable, disable and notify, and leave it after the final unlock. An
unplugged bridge then rejects later calls before mutex or hook use,
and unplug waits for the complete helpers already in progress.

Found by the author's in-house static analysis tool.

Fixes: d36137085a4a ("drm/bridge: add drm_bridge_unplug() and drm_bridge_enter/exit()")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260728135214.1850-1-getshell@seu.edu.cn/
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
---

Discovery: found by the author's in-house static analysis tool.

 drivers/gpu/drm/drm_bridge.c | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 1b4ee74..e2adb94 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -300,6 +300,16 @@ void drm_bridge_unplug(struct drm_bridge *bridge)
 
 	synchronize_srcu(&drm_bridge_unplug_srcu);
 
+	/*
+	 * No helper can enter any more and every in-flight one has finished.
+	 * Drop the HPD registration now, while drm_bridge_remove() has not
+	 * destroyed the mutexes that protect it.
+	 */
+	mutex_lock(&bridge->hpd_mutex);
+	bridge->hpd_cb = NULL;
+	bridge->hpd_data = NULL;
+	mutex_unlock(&bridge->hpd_mutex);
+
 	drm_bridge_remove(bridge);
 }
 EXPORT_SYMBOL(drm_bridge_unplug);
@@ -1551,6 +1561,10 @@ EXPORT_SYMBOL_GPL(drm_bridge_edid_read);
  * Hot plug detection is supported only if the DRM_BRIDGE_OP_HPD flag is set in
  * bridge->ops. This function shall not be called when the flag is not set.
  *
+ * Calls are serialized against drm_bridge_unplug(); once the bridge has been
+ * unplugged, this function returns without installing the callback or calling
+ * &drm_bridge_funcs.hpd_enable.
+ *
  * Only one hot plug detection callback can be registered at a time, it is an
  * error to call this function when hot plug detection is already enabled for
  * the bridge.
@@ -1560,9 +1574,14 @@ void drm_bridge_hpd_enable(struct drm_bridge *bridge,
 				      enum drm_connector_status status),
 			   void *data)
 {
+	int idx;
+
 	if (!(bridge->ops & DRM_BRIDGE_OP_HPD))
 		return;
 
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
+
 	mutex_lock(&bridge->hpd_state_mutex);
 
 	mutex_lock(&bridge->hpd_mutex);
@@ -1582,6 +1601,7 @@ void drm_bridge_hpd_enable(struct drm_bridge *bridge,
 
 unlock:
 	mutex_unlock(&bridge->hpd_state_mutex);
+	drm_bridge_exit(idx);
 }
 EXPORT_SYMBOL_GPL(drm_bridge_hpd_enable);
 
@@ -1596,12 +1616,23 @@ EXPORT_SYMBOL_GPL(drm_bridge_hpd_enable);
  *
  * Hot plug detection is supported only if the DRM_BRIDGE_OP_HPD flag is set in
  * bridge->ops. This function shall not be called when the flag is not set.
+ *
+ * Calls are serialized against drm_bridge_unplug(), which waits for any
+ * in-flight helper and clears the registered callback before removing the
+ * bridge.  Once the bridge has been unplugged, this function therefore
+ * returns without calling &drm_bridge_funcs.hpd_disable.
  */
 void drm_bridge_hpd_disable(struct drm_bridge *bridge)
 {
+	int idx;
+
 	if (!(bridge->ops & DRM_BRIDGE_OP_HPD))
 		return;
 
+	/* drm_bridge_unplug() has already dropped the registration. */
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
+
 	mutex_lock(&bridge->hpd_state_mutex);
 	if (bridge->funcs->hpd_disable)
 		bridge->funcs->hpd_disable(bridge);
@@ -1611,6 +1642,7 @@ void drm_bridge_hpd_disable(struct drm_bridge *bridge)
 	bridge->hpd_data = NULL;
 	mutex_unlock(&bridge->hpd_mutex);
 	mutex_unlock(&bridge->hpd_state_mutex);
+	drm_bridge_exit(idx);
 }
 EXPORT_SYMBOL_GPL(drm_bridge_hpd_disable);
 
@@ -1624,14 +1656,23 @@ EXPORT_SYMBOL_GPL(drm_bridge_hpd_disable);
  * enabled by drm_bridge_hpd_enable().
  *
  * This function shall be called in a context that can sleep.
+ *
+ * Once the bridge has been unplugged the event is dropped: the registered
+ * callback is not invoked.
  */
 void drm_bridge_hpd_notify(struct drm_bridge *bridge,
 			   enum drm_connector_status status)
 {
+	int idx;
+
+	if (!drm_bridge_enter(bridge, &idx))
+		return;
+
 	mutex_lock(&bridge->hpd_mutex);
 	if (bridge->hpd_cb)
 		bridge->hpd_cb(bridge->hpd_data, status);
 	mutex_unlock(&bridge->hpd_mutex);
+	drm_bridge_exit(idx);
 }
 EXPORT_SYMBOL_GPL(drm_bridge_hpd_notify);
 
-- 
2.50.1.windows.1
