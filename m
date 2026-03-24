Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9158F532F6
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A4110E606;
	Tue, 24 Mar 2026 08:58:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="V2sj8kij";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0B6510E606
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 08:58:30 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id E5E02C58095;
 Tue, 24 Mar 2026 08:58:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B4F536011D;
 Tue, 24 Mar 2026 08:58:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DB98E10450FBD; Tue, 24 Mar 2026 09:58:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774342708; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=dTPjWWPYXj8pYDGBW4Mu8+D8bWZWJwrgTHxQSd0GcUQ=;
 b=V2sj8kijmrig/BHwN7UJAGn4Bj/smYmcny7KCaHMCSnkX/Og8pP4P3rGPsw1BMcT8ZEba8
 Qluj6SoLFGV0OlC7Inuh5spElqszNzX3u1ICx4Ex6hlO4Kkk9EH0DcGEabF4hGJADVT9g0
 gJCZbIsNVAVQCEmRCjKFQ9wyWEx+0y2alxyjTwcrznYC+tVb875zWsnckJ2lLZsEXcFwCV
 hmM6/eSDobo2JnTwPJV8GzCyxe6dllyLbM6SYFSgE5e7plTAb0bzmum1gnzHmofgIa2V6I
 BWBA0BX+WvBYP9Fl978GB4KK0gLE3Tp5mtidGO6OdTDeX5p76tX6t0lQqH0spA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 24 Mar 2026 09:58:09 +0100
Subject: [PATCH v5 2/7] drm/encoder: drm_encoder_cleanup: lock the encoder
 chain mutex during removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-2-8bf786c5c7e6@bootlin.com>
References: <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-0-8bf786c5c7e6@bootlin.com>
In-Reply-To: <20260324-drm-bridge-alloc-encoder-chain-mutex-v5-0-8bf786c5c7e6@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
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

drm_encoder_cleanup() modifies the encoder chain by removing bridges via
drm_bridge_detach(). Protect this whole operation by taking the mutex, so
that:

 * any users iterating over the chain will not access it during the change
 * other code willing to modify the list (drm_bridge_attach()) will wait
   until drm_encoder_cleanup() is done

Note that the _safe macro in use here is providing a different and
orthogonal kind of protection than the mutex:

 1. list_for_each_entry_safe() allows removing the current entry from the
    list it is iterating on, synchronously; the non-safe version would be
    unable to find the next entry after the current entry has been removed
 2. the mutex being added allows to ensure that the list is not used
    asynchronously by other code while it is being modified; this prevents
    such other concurrent code to derail because it is iterating over an
    element while it is removed

The _safe macro, which works by taking the "next" pointer in addition to
the "current" one, does not even try to provide the protection at item 2
above. This is visible e.g. when the "next" element is removed by other
concurrent code. This is what would happen without the added mutex:

 1. start loop: list_for_each_entry_safe(pos, n, ...) sets:
    pos = list_first_entry()   = (bridge 1)
    n   = list_next_entry(pos) = (bridge 2)
 2. enter the loop 1st time, do something with *pos (bridge 1)
 3. in the meanwhile bridge 2 is hot-unplugged
    -> another thread removes bridge 2
       -> drm_bridge_detach()
          -> list_del() sets (bridge 2)->next = LIST_POISON1
 4. loop iteration 1 finishes, list_for_each_entry_safe() sets:
    pos = n (previously set to bridge 2)
    n   = (bridge 2)->next = LIST_POISON1
 5. enter the loop 2nd time, do something with *pos (bridge 2)
 6. loop iteration 2 finishes, list_for_each_entry_safe() sets:
    pos = n = LIST_POISON1 ==> bug!

However, simply adding mutex_[un]lock(&encoder->bridge_chain_mutex)
before/after the list_for_each_entry_safe() seems a simple and good
solution, but it is introducing a possible ABBA deadlock (found by
PROVE_LOCKING). The two code paths involved are:

 * drm_encoder_cleanup():
   - takes the bridge_chain_mutex (A)
   - calls drm_bridge_detach -> drm_atomic_private_obj_fini ->
     DRM_MODESET_LOCK_ALL_BEGIN() which takes all locks in the
     acquisition context (B)
 * drm_mode_getconnector() (and other code paths):
   - calls drm_helper_probe_single_connector_modes() which:
     - takes a drm_modeset_lock in the acquisition context (B)
     - calls __drm_helper_update_and_validate ->
       drm_bridge_chain_mode_valid -> drm_for_each_bridge_in_chain_from()
       which takes the bridge_chain_mutex (A)

To avoid this potential ABBA deadlock, move all list items to a temporary
list while holding the bridge_chain_mutex, then detach all elements from
the temporary list without the mutex.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v5:
- Small commit message improvement

Changes in v3:
- Prevent ABBA deadlock by using a temporary list
- Improve commit message

Changes in v2:
- Expanded commit messge with rationale, as discussed
---
 drivers/gpu/drm/drm_encoder.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_encoder.c b/drivers/gpu/drm/drm_encoder.c
index 3261f142baea..0d5dbed06db4 100644
--- a/drivers/gpu/drm/drm_encoder.c
+++ b/drivers/gpu/drm/drm_encoder.c
@@ -189,14 +189,26 @@ void drm_encoder_cleanup(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
 	struct drm_bridge *bridge, *next;
+	LIST_HEAD(tmplist);
 
 	/* Note that the encoder_list is considered to be static; should we
 	 * remove the drm_encoder at runtime we would have to decrement all
 	 * the indices on the drm_encoder after us in the encoder_list.
 	 */
 
-	list_for_each_entry_safe(bridge, next, &encoder->bridge_chain,
-				 chain_node)
+	/*
+	 * We need the bridge_chain_mutex to modify the chain, but
+	 * drm_bridge_detach() will call DRM_MODESET_LOCK_ALL_BEGIN() (in
+	 * drm_modeset_lock_fini()), resulting in a possible ABBA circular
+	 * deadlock. Avoid it by first moving all the bridges to a
+	 * temporary list holding the lock, and then calling
+	 * drm_bridge_detach() without the lock.
+	 */
+	mutex_lock(&encoder->bridge_chain_mutex);
+	list_cut_before(&tmplist, &encoder->bridge_chain, &encoder->bridge_chain);
+	mutex_unlock(&encoder->bridge_chain_mutex);
+
+	list_for_each_entry_safe(bridge, next, &tmplist, chain_node)
 		drm_bridge_detach(bridge);
 
 	drm_mode_object_unregister(dev, &encoder->base);

-- 
2.53.0

