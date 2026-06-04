Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B22CCD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 19:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B655011A181;
	Thu,  4 Jun 2026 19:44:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="M5mBimPE";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 078F811A181
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 19:44:41 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so13271985e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 12:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1780602279; x=1781207079; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S3Mz5gFS0uICYS8oUauxnCGzN+B8DWW7+Ft4l095als=;
 b=M5mBimPE/s8l+eBOvT/whBfY81zD9qnCkZIvmvLrpw9QHimMIPjcMemqwKwn8ovmfA
 nvVnlnhe+cGbeH/CTkV1HA8j44PhdC9P99XOsAg9CuY93A1TOZfVaTDQpIXMHuWKF+E0
 ebeBDyVw/NQjPwwUi4pD5jL/NPdX6/fat8Xik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780602279; x=1781207079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S3Mz5gFS0uICYS8oUauxnCGzN+B8DWW7+Ft4l095als=;
 b=iAiPXXRzmY54Fs52n95RQnhsruo0ceV2c88cnRUWlUgUv409/fUTMU31D8TzOW+ZOa
 fgNq3DtdihqvrQ95+QUKnmbANbRP7xXQ9F3dEDp/RgN2ke2AI3ShedydvOcZY/PGndUo
 FaH/N28mwJU8xnr3x8+0L0RHElFAqOiYwoHzgBwZMRv1C3g40XYdf0iCNcw0HG9rAc4S
 ACwzkh8qxhlEMkgdndj8F7JDJU30cgxNVEDN6azZqT29BDldLJU8bP95sa7iTwiCh6HY
 3IfwSE7smZPdcVKIEdHKP+8N/4A64hE9T0lP/4l8IDePctya6k9zqJUIrBIyF3IeWchB
 4HFw==
X-Gm-Message-State: AOJu0YzpN+10WJ7hx6+2+kPwnlSR1eV/DDkC/VD5l9D1PxPgAgIyvWQZ
 /q6WRb4sfcpQ1ZBuMlVoyUZ8KVQ6B1Rw824erhGwJLG9EzgTgrY0icpkG/MEQ1DiC9APyR5uUDU
 t/rH532Q=
X-Gm-Gg: Acq92OFnW1t6rPeCQ1gMgbYUzbVZJ5nUAlnX/QoBJGoVQeNgV9fYJdUUCR01UYWOC7N
 QN+Zp2K36p01T7G4eBecq93h2yUhVPPR7/L0UE8Fiq6GHs5oaiTfGmOV7VLHyfWl6JF4R4pnQBj
 fjLf+rnx6cnmfm4xfESr4WrKmng+IJepVpeUojV/QmazWaojkmsrFNVzHsPPq7sPVtLlLngCjPf
 d8isIrxsxhdl+hA3vnMAUhrSU1pq6wnivft7xd1lq9uk7xhAe85Qr5bE0+ZC/iXmX6NOcr6teiW
 k/oAhbssIBz+v84oJwaiHuweymHRMksZI9HSaclpdbMSaGdanIwDUxebchcSEsomZaOEmiurdEB
 idtdTaAPIeqS08erdLJ2sUuG/B7WsC3PIc5YOEuU6vka37EPPR/EKbPKeOL8XqwDVBMAu0jmyOF
 ClwMevM0lhlqEevVY4llf/clsE9th8IJwGDN2ISGQ6qDGJdQ==
X-Received: by 2002:a05:600c:34ca:b0:490:9df1:f0cf with SMTP id
 5b1f17b1804b1-490c2592042mr668855e9.2.1780602279616; 
 Thu, 04 Jun 2026 12:44:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc39eb04sm96489005e9.6.2026.06.04.12.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 12:44:39 -0700 (PDT)
From: Simona Vetter <simona.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
 "DARKNAVY (@DarkNavyOrg)" <vr@darknavy.com>,
 syzbot+d7c9eed171647e421013@syzkaller.appspotmail.com,
 stable@vger.kernel.org, Edward Adam Davis <eadavis@qq.com>,
 Dave Airlie <airlied@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Francis <David.Francis@amd.com>,
 Puttimet Thammasaeng <pwn8official@gmail.com>,
 Christian Koenig <Christian.Koenig@amd.com>,
 Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH] drm/gem: Try to fix change_handle ioctl, attempt 4
Date: Thu,  4 Jun 2026 21:44:37 +0200
Message-ID: <20260604194437.1725314-1-simona.vetter@ffwll.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604191916.1713387-1-simona.vetter@ffwll.ch>
References: <20260604191916.1713387-1-simona.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On-list because the cat is out of the bag and we're clearly not good
enough to figure this out in private. The story thus far:

5e28b7b94408 ("drm: Set old handle to NULL before prime swap in
change_handle") tried to fix a race condition between the gem_close and
gem_change_handle ioctls, but got a few things wrong:

- There's a confusion with the local variable handle, which is actually
  the new handle, and so the two-stage trick was actually applied to the
  wrong idr slot. 7164d78559b0 ("drm/gem: fix race between
  change_handle and handle_delete") tried to fix that by adding yet
  another code block, but forgot to add the error handling. Which meant
  we now have two paths, both kinda wrong.

- dc366607c41c ("drm: Replace old pointer to new idr") tried to apply
  another fix, but inconsistently, again because of the handle confusion
  - this would be the right fix (kinda, somewhat, it's a mess) if we'd
  do the two-stage approach for the new handle. Except that wasn't the
  intent of the original fix.

We also didn't have an igt merged for the original ioctl, which is a big
no-go. This was attempted to address off-list in the original bugfix,
and amd QA people claimed the bug was fixed now. Very clearly that's not
the case. Here's my attempt to sort this out:

- Rename the local variable to new_handle, the old aliasing with
  args->handle is just too dangerously confusing.

- Merge the gem obj lookup with the two-stage idr_replace so that we
  avoid getting ourselves confused there.

- This means we don't have a surplus temporary reference anymore, only
  an inherited from the idr. A concurrent gem_close on the new_handle
  could steal that. Fix that with the same two-stage approach
  create_tail uses. This is a bit overkill as documented in the comment,
  but I also don't trust my ability to understand this all correctly, so
  go with the established pattern we have from other ioctls instead for
  maximum paranoia.

- Adjust error paths. I've tried to make the error and success paths
  common, because they are identical except for which handle is removed
  and on which we call idr_replace to (re)install the object again. But
  that made things messier to read, so I've left it at the more verbose
  version, which unfortunately hides the symmetry in the entire code
  flow a bit.

- While at it, also replace the 7 space indent with 1 tab.

And finally, because I flat out don't trust my abilities here at all
anymore:

- Disable the ioctl until we have the igt situation and everything else
  sorted out on-list and with full consensus.

v2:

Sashiko noticed that I didn't handle the error path for idr_replace
correctly, it must be checked with IS_ERR_OR_NULL like in
gem_handle_delete. So yeah, definitely should just the existing paths
1:1 because this is endless amounts of tricky.

Also add the Fixes: line for the original ioctl, I forgot that too.

Reported-by: DARKNAVY (@DarkNavyOrg) <vr@darknavy.com>
Signed-off-by: Simona Vetter <simona.vetter@ffwll.ch>
Fixes: dc366607c41c ("drm: Replace old pointer to new idr")
Cc: syzbot+d7c9eed171647e421013@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 5e28b7b94408 ("drm: Set old handle to NULL before prime swap in change_handle")
Cc: David Francis <David.Francis@amd.com>
Cc: Puttimet Thammasaeng <pwn8official@gmail.com>
Cc: Christian Koenig <Christian.Koenig@amd.com>
Fixes: 7164d78559b0 ("drm/gem: fix race between change_handle and handle_delete")
Cc: Zhenghang Xiao <kipreyyy@gmail.com>
Fixes: 5e28b7b94408 ("drm: Set old handle to NULL before prime swap in change_handle")
---
 drivers/gpu/drm/drm_gem.c   | 62 +++++++++++++------------------------
 drivers/gpu/drm/drm_ioctl.c |  2 +-
 2 files changed, 23 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index e12cdf91f4dc..f49f1724eda5 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1019,8 +1019,8 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file_priv)
 {
 	struct drm_gem_change_handle *args = data;
-	struct drm_gem_object *obj, *idrobj;
-	int handle, ret;
+	struct drm_gem_object *obj;
+	int new_handle, ret;
 
 	if (!drm_core_check_feature(dev, DRIVER_GEM))
 		return -EOPNOTSUPP;
@@ -1028,52 +1028,36 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 	/* idr_alloc() limitation. */
 	if (args->new_handle > INT_MAX)
 		return -EINVAL;
-	handle = args->new_handle;
-
-	obj = drm_gem_object_lookup(file_priv, args->handle);
-	if (!obj)
-		return -ENOENT;
+	new_handle = args->new_handle;
 
-	if (args->handle == handle) {
-		ret = 0;
-		goto out;
-	}
+	if (args->handle == new_handle)
+		return 0;
 
 	mutex_lock(&file_priv->prime.lock);
-
 	spin_lock(&file_priv->table_lock);
-
-       /* When create_tail allocs an obj idr, it needs to first alloc as NULL,
-	* then later replace with the correct object. This is not necessary
-	* here, because the only operations that could race are drm_prime
-	* bookkeeping, and we hold the prime lock.
-	*/
-	ret = idr_alloc(&file_priv->object_idr, obj, handle, handle + 1,
+	ret = idr_alloc(&file_priv->object_idr, NULL, new_handle, new_handle + 1,
 			GFP_NOWAIT);
 
-       if (ret < 0) {
-	       spin_unlock(&file_priv->table_lock);
-	       goto out_unlock;
-       }
-
-       idrobj = idr_replace(&file_priv->object_idr, NULL, handle);
-       if (idrobj != obj) {
-	       idr_replace(&file_priv->object_idr, idrobj, handle);
-	       idr_remove(&file_priv->object_idr, args->new_handle);
-	       spin_unlock(&file_priv->table_lock);
-	       ret = -ENOENT;
-	       goto out_unlock;
-       }
-
-	idr_replace(&file_priv->object_idr, NULL, args->handle);
+	if (ret < 0) {
+		spin_unlock(&file_priv->table_lock);
+		goto out_unlock;
+	}
+
+	obj = idr_replace(&file_priv->object_idr, NULL, args->handle);
+	if (IS_ERR_OR_NULL(obj)) {
+		idr_remove(&file_priv->object_idr, new_handle);
+		spin_unlock(&file_priv->table_lock);
+		ret = -ENOENT;
+		goto out_unlock;
+	}
 	spin_unlock(&file_priv->table_lock);
 
 	if (obj->dma_buf) {
 		ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
-					       handle);
+					       new_handle);
 		if (ret < 0) {
 			spin_lock(&file_priv->table_lock);
-			idr_remove(&file_priv->object_idr, handle);
+			idr_remove(&file_priv->object_idr, new_handle);
 			idr_replace(&file_priv->object_idr, obj, args->handle);
 			spin_unlock(&file_priv->table_lock);
 			goto out_unlock;
@@ -1086,14 +1070,12 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 
 	spin_lock(&file_priv->table_lock);
 	idr_remove(&file_priv->object_idr, args->handle);
-	idrobj = idr_replace(&file_priv->object_idr, obj, handle);
+	obj = idr_replace(&file_priv->object_idr, obj, new_handle);
 	spin_unlock(&file_priv->table_lock);
-	WARN_ON(idrobj != NULL);
+	WARN_ON(obj != NULL);
 
 out_unlock:
 	mutex_unlock(&file_priv->prime.lock);
-out:
-	drm_gem_object_put(obj);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index ff193155129e..937fc1e2c017 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -660,7 +660,7 @@ static const struct drm_ioctl_desc drm_ioctls[] = {
 	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CLOSE, drm_gem_close_ioctl, DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF(DRM_IOCTL_GEM_FLINK, drm_gem_flink_ioctl, DRM_AUTH),
 	DRM_IOCTL_DEF(DRM_IOCTL_GEM_OPEN, drm_gem_open_ioctl, DRM_AUTH),
-	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_gem_change_handle_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_invalid_op, DRM_RENDER_ALLOW),
 
 	DRM_IOCTL_DEF(DRM_IOCTL_MODE_GETRESOURCES, drm_mode_getresources, 0),
 
-- 
2.53.0

