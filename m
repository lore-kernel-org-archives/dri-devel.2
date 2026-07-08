Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188D1C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 699F710E521;
	Wed,  8 Jul 2026 15:22:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z1dJLckD";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E47D910E603
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 15:22:09 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so1400723a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783524128; x=1784128928; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RZIUQ8lhybvuqUO/Qu4fqmCKQSSQtg8HD8yQYy4im0M=;
 b=z1dJLckDo41q2+2vzT17xUC+W8dZxNIW+3WFNA6/OOAJDv6Lv6hdK7VolAOuaLAc9t
 4rFsO9LtgJn5H319RKiwhwIVtqnBKs2rLRgX7fwE1DmVX6vVX20j69u83xCHlMWQ0rPD
 wtYPEAENH3bSujUCn0MxAa3yiY7vd5FwTNbJ76Xg8vvXlJLnYXcN+J2EYBW6XpxfiOfd
 ivt/BVpuYbvYQaiG3twDqiydqJjtArbbuiuGsrcbPI5nmliAN2Iqo+USbnllWikAR1U/
 L8vIMo+I9LyOgA1+xS726mh2FABCfJtfjreUmLaqTcrCM/Io/P6HJBqKmsMpBflfx0NM
 1nOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783524128; x=1784128928;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RZIUQ8lhybvuqUO/Qu4fqmCKQSSQtg8HD8yQYy4im0M=;
 b=NsLicecVvRtKXLj97c9t+OSSrPNgirl5xx29FWP/AaCSic0CtLR1zK1NZrnzXf1L2z
 D2pnOom3lEXD0nR6qVVMRy70i7Mg5V3U2eo+xQSAjoPnmP5Q7fhnB/sYzPDeGsvszJW6
 4eD/diO9/D6xkb7JrVSWkMLkRoLSHw8jAtMs9FYQYUFENfGkgHGQE/NMc5qdb6rRUyr4
 FbGCiOuTBfpgkK/cg6A59VxL2W1u8mY1O9SnO3IB6oD4lCJ2SPkQ28NasWmgchDz3kT5
 oT9qWuWfzWiS0qy1U6HdOBJqbNQzweTtUmMylZPy4c/LTRv3ikxAmRvM4gZtgTi//hL/
 tVOw==
X-Gm-Message-State: AOJu0Yz6rpw9ykgfyVf1tI9m+Bkq9LxKeCbEQdI2k0t7w1upV8mg999K
 Lq2rmA3Zy4Vrv2x+SuDppM4ESgg4YMSPuK6chaaul0P6IlpJWJ1Uj85rv7LJS8Q49io=
X-Gm-Gg: AfdE7clY2+ZU28LMnzDUW1eWtlfwFxjFfRLZzHBblNlv0GYwNJF+IUuMmrgMXiwCOMu
 zCFeiKOopPL6qLEL0fJDjQzHR5JVcNKekOgqMPUctVolBTgu7TT56TNMuQF8UxV1nziOXnMF5ej
 lSxpxrk8aAPrVfHr7cTo4/9ptTVSvsz3w+l4gKrirnJa4eM15b5Qaawy1/Ew4Cx34dXXoHb4sxd
 C+Sgv9XP5J6WusNxptUTvhbzHqD3/14kTH61T4gh+slhLwQ8fHjjfGzok1LcawkpM9j6os4a629
 cjWAG8fcf9LDFg710PAetMfsXK7ThJTL5ya5TaHJPyC+KZVd/RYMKCV4cakGQv7ajRmOGvPeE4/
 vJuujEcLFw/ibf5XQUFDk0BtCt6Z1CqChUPgQ8aNPrlwOByRtNgNgGS80sE50ESy+op1ARZUlRs
 zPLRzKBeClnin1lHYRvGIdoXao0U8UsfwWeDI9PLZ1tO9jwt/YlCzBIJuP3b16CNr9PzwOK12Rj
 PlTMFk=
X-Received: by 2002:a17:906:f0d1:b0:c15:cc30:6c70 with SMTP id
 a640c23a62f3a-c15ce0c06damr103325566b.42.1783524128259; 
 Wed, 08 Jul 2026 08:22:08 -0700 (PDT)
Received: from puffmais2.c.googlers.com
 (181.179.204.35.bc.googleusercontent.com. [35.204.179.181])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15beb53b86sm213932966b.25.2026.07.08.08.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 08:22:07 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 08 Jul 2026 16:22:05 +0100
Subject: [PATCH v2 1/2] drm/drm_crtc: ensure dma_fence_ops remain valid
 during device unbind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260708-linux-drm_crtc_fix2-v2-1-cf72be75d75a@linaro.org>
References: <20260708-linux-drm_crtc_fix2-v2-0-cf72be75d75a@linaro.org>
In-Reply-To: <20260708-linux-drm_crtc_fix2-v2-0-cf72be75d75a@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.3
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

In [1], sashiko reported the following issue:

=== snip ===
Looking at how these fences are managed, drm_crtc_create_fence()
creates a dma_fence without taking a reference to the drm_device or
drm_crtc. Because the sync_file framework exposes this fence to
userspace, the fence can outlive the CRTC.

The dma_fence contract requires that data accessed by dma_fence_ops
(like get_driver_name) must remain valid for an RCU grace period after
the fence is signaled. However, drm_crtc_cleanup() and the subsequent
freeing of the device do not wait for an RCU grace period via
synchronize_rcu().

If userspace calls ioctl(SYNC_IOC_FILE_INFO) concurrently with a device
hot-unplug:

CPU1 (Userspace)
sync_file_get_name()
  ops = rcu_dereference(fence->ops);
  if (!dma_fence_test_signaled_flag())
    // Preempted or delayed here

CPU2 (Driver Teardown)
Signals the fence (setting fence->ops = NULL)
Destroys and frees the CRTC without waiting for an RCU grace period

CPU1 (Resumes)
  ops->get_driver_name(fence) -> drm_crtc_fence_get_driver_name()
  crtc = fence_to_crtc(fence); // Casts to the freed CRTC
  return crtc->dev->driver->name; // Use-after-free

...

Does the CRTC or DRM device need to be kept alive for the RCU grace
period, or should the fence hold a proper reference to prevent the
use-after-free when get_driver_name() and get_timeline_name() access
the freed CRTC structure?
=== snap ===

I believe this to be a correct observation and this patch implements
the suggestion of waiting for an RCU grace period before proceeding
with destruction of the drm_crtc, so that get_driver_name() and
get_timeline_name() can still work.

Link: https://sashiko.dev/#/patchset/20260618-linux-drm_crtc_fix2-v1-1-c03e77b36f34@linaro.org?part=1
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/gpu/drm/drm_crtc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 63ead8ba6756..d55f1377ec36 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -501,6 +501,12 @@ void drm_crtc_cleanup(struct drm_crtc *crtc)
 {
 	struct drm_device *dev = crtc->dev;
 
+	/* Ensure our dma_fence_ops remain valid for an RCU grace period after
+	 * the fence is signaled. This is necessary because our dma_fence_ops
+	 * dereference crtc->dev.
+	 */
+	synchronize_rcu();
+
 	/* Note that the crtc_list is considered to be static; should we
 	 * remove the drm_crtc at runtime we would have to decrement all
 	 * the indices on the drm_crtc after us in the crtc_list.

-- 
2.55.0.795.g602f6c329a-goog

