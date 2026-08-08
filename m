Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DBAC5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68DD610E67E;
	Mon, 10 Aug 2026 06:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ok7O40vN";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 981DA10E092
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 23:10:11 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso745486a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 16:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786230611; x=1786835411; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BE5i97l5+UkocwDHkAbi6GQw7M6Leoq3/Bn3JNcvt7I=;
 b=ok7O40vNLvWNgWyCfti5Tm1bccZxiUOZExI8K3XNGjgOQy8xsxEAwGmfFXBMRnRkN2
 hyDzX19grjthKQkBjNpen/lupLPWspEUdqWBRTNm5B1BzV+gX1MWDEMHMD9UdYMmPpRe
 xYXTFZ6fnlFsG6htWfhCxg7FYw9XSXsUO1vpa9qRk0U4gG2gqKpCR2mLwwtQqRbE+URG
 5xSQp1maNeOdiCL8VzfOzlFa+SyjmBQ6QXvavk9EELx9xjvbm+D42nflrfQNNeFXpK/a
 MAGk0WUGjnuhhTgvQ0UDFq7QhBP8zEkknJhBzChSf1eK7QC8qaZ+E8L6SakdWIoZHtXO
 Zf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786230611; x=1786835411;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BE5i97l5+UkocwDHkAbi6GQw7M6Leoq3/Bn3JNcvt7I=;
 b=hZmZWvTvQmt/RRhrFnazClMs9S9I8OYVx79byNS/7joZAGFOLbUq/9CnGKDA31ETn4
 7wHDfKWet/NtAJ2oRiDMZpFxXyApKDJAp55M8KI/wIUM4acAm9cO7gnkjCteHQ5O3hTN
 u0B3AoOOk2OAyMJYtO4TgfFod0nVNZgC0C4vfhMcWrxLsdt1mJAyvdUqqTxfnRp23+Kf
 wFTiFGycn+JE73qAprbannaHFiy+BTG+KTlaYLGI/0Pvwz5xSVkMl1phBHBkokhYDL2V
 7lIaE7X2cT6laYSjup7xKAbp26CDToo0JYJ6cIp0U77Hm99ZkLGrsaK9IT1ZPQN5SKAq
 55fA==
X-Forwarded-Encrypted: i=1;
 AHgh+RohE6MnLM13jOUEhR47QPoE23MNb1ETYqcWTY+UC7QoauJdy+yIbRwXVWM3ZvuSI9AKG9goINe+NXI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYFs1aM+fP2qjCq4KUnkxT+OSDxdaaZAVFHEzKkdEGdzwQS9gX
 pYjL5T26040QoyJqduFca13fLIp/CFcEI3pmfKJhws1Rh41UK+mHMC7r
X-Gm-Gg: AR+sD12PrStaY95+BgS9cFzKr+bv3A/rAZILNPV9rGY7/tVm9WJiq/3LGFZvPkz5wLd
 pAGqgykAKqJxVlQCYZrOMQS5DkO1t8roW/SV+bYxhEXzkgE8u+zSRizyQdFH3JzzyIFsc7YwjNR
 BV6P0WNMYDvfsP4l9lEHeF2YBqz0xHCQS+0KDVYXUk9+R7T3NZCBAWPPMYKD9sbLtFH51yNR8fn
 5aVh3m4xyVLkd51PVlNUhcmRSfqPIN+45MielMpeJqS03mzTMvOqk7rm+8M9Q4MwqnHENZGw/NJ
 rkZF6UAzNSKRPKZF/Ca7UQPckTIa6Vv0RwmlptWkzovzSPQtbmk0uUUS9iWqG7HNcC9ygfZ80qb
 PzX4WHUsSLABIiKNHdRIIj6/urTHFnQTmhfb4HSHScjibbQV4kqDBkbQUw3+Cju99OuFLf0sNbd
 vA0OF+GdV8ufHCnaC7frX3MAacBFBXYM8GD+/QwVomqHO+s4Y2Pzfi
X-Received: by 2002:a17:90b:51ca:b0:38e:6c37:d95a with SMTP id
 98e67ed59e1d1-39262305b87mr14578046a91.19.1786230611047; 
 Sat, 08 Aug 2026 16:10:11 -0700 (PDT)
Received: from beelink.. ([186.22.57.86]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141019b4eabsm19551087c88.6.2026.08.08.16.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 16:10:09 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] drm/vmwgfx: return an error when a shared GB surface has no
 backup buffer
Date: Sat,  8 Aug 2026 20:10:02 -0300
Message-ID: <20260808231002.67559-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

vmw_gb_surface_reference_internal() rejects a surface without a backup
buffer by logging an error and jumping to the exit label, but it never
sets ret on that path:

	ret = vmw_surface_handle_reference(dev_priv, file_priv, req->sid,
					   req->handle_type, &base);
	if (unlikely(ret != 0))
		return ret;
	...
	if (!srf->res.guest_memory_bo) {
		DRM_ERROR("Shared GB surface is missing a backup buffer.\n");
		goto out_bad_resource;
	}
	...
out_bad_resource:
	ttm_base_object_unref(&base);

	return ret;

ret is still 0 from the successful vmw_surface_handle_reference() above,
so the function returns success while leaving *rep completely unwritten.
The other goto to the same label is inside an if (ret != 0) block and so
carries a real error; this one is the only path that reaches the label
with ret == 0.

The caller then copies that untouched output structure to user space.
For DRM_VMW_GB_SURFACE_REF, vmw_gb_surface_reference_ioctl() passes a
stack local:

	struct drm_vmw_gb_surface_ref_ext_rep rep_ext;
	int ret;

	ret = vmw_gb_surface_reference_internal(dev, req, &rep_ext, file_priv);

	if (unlikely(ret != 0))
		return ret;

	rep->creq = rep_ext.creq.base;
	rep->crep = rep_ext.crep;

so 48 + 24 = 72 bytes of an uninitialised stack variable are copied into
the ioctl buffer, and drm_ioctl() copies that buffer back out.  The ioctl
is a DRM_IOWR of exactly 72 bytes, so in_size == out_size and the core
does not zero any tail.  DRM_VMW_GB_SURFACE_REF is DRM_RENDER_ALLOW, so
this is reachable by an unprivileged local user through a render node.

What actually leaks depends on how the kernel was built.  With
CONFIG_INIT_STACK_ALL_ZERO, which is the Kconfig default whenever the
compiler supports it and therefore what the major distributions ship,
rep_ext is zeroed on function entry and user space receives 72 zero
bytes.  With CONFIG_INIT_STACK_NONE the contents are whatever the
previous call at that stack depth left behind; on a test kernel built
that way, 53 of the 72 bytes came back non-zero and several of them were
kernel pointers.  So the information disclosure is configuration
dependent, but the control flow defect is not: on every configuration
the ioctl reports success and hands back a reply that was never
produced, which user space cannot distinguish from a real one.

The path was correct when the ioctl was introduced in a97e21923b42
("drm/vmwgfx: Hook up guest-backed surfaces"): ret was initialised to
-EINVAL and the first assignment to it came after this goto, so the
label really did return -EINVAL.  14b1c33e8429 split the handler into
vmw_gb_surface_reference_internal() and moved the
vmw_surface_handle_reference() call - and with it the first assignment
to ret - above the check, which left the initialiser dead and this path
returning 0.  The dead initialiser was removed later, as a Coverity
"unused value", by c594285f30fa ("drm/vmwgfx: remove redundant
assignment to variable ret"); that removal was correct in itself.

The driver already knows the request failed - it logs an error - so
report that to the caller.

Fixes: 14b1c33e8429 ("drm/vmwgfx: Add new ioctl for GB surface create and reference")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -1720,6 +1720,7 @@ vmw_gb_surface_reference_internal(struct drm_device *dev,
 	srf = &user_srf->srf;
 	if (!srf->res.guest_memory_bo) {
 		DRM_ERROR("Shared GB surface is missing a backup buffer.\n");
+		ret = -EINVAL;
 		goto out_bad_resource;
 	}
 	metadata = &srf->metadata;
