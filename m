Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3541FF8862
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B1C010E5A2;
	Mon, 27 Apr 2026 07:03:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xj+0wbrn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE91A10E5A2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:03:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A5FC543510;
 Mon, 27 Apr 2026 07:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0671AC19425;
 Mon, 27 Apr 2026 07:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777273403;
 bh=j51Q+8mt4C7VLTrw6ArNSmzDrpkGTUdoDwgnpPfZf10=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Xj+0wbrnoLj+OKinrC05V1Y1/UMoYUN6WWwcivuWZoLvcThOzZZlxrtu2QoQKsFjV
 IWzGdy+amVBVu7PBDUmC39nmnz3RNJE/haAVeZWYD+pr56idooP1XWvHqS10C+VIX9
 7zIy9j3WGHdcrzedMeFS2/9GP/wclCd5wkQkm6umbWS+TBFivyut86Fy6/y7ptFs37
 utn3s6mMxFF7YjabR7D/hw7+JigLpFCV8yRpCLAAaUgczn8m5oF2akV+yuo6FTMzsc
 +17hWTQrcUV1YqWj5A5YSpYGXL6044Lkvdtd4syMURkrPGxfHKGRmWc9cvwLuDE83A
 IrhlEFpwuSNmQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 27 Apr 2026 09:02:58 +0200
Subject: [PATCH v4 2/2] Documentation: drm: Remove drm_atomic_state rename
 entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-drm-drm-atomic-update-v4-2-c0e713bfdf25@kernel.org>
References: <20260427-drm-drm-atomic-update-v4-0-c0e713bfdf25@kernel.org>
In-Reply-To: <20260427-drm-drm-atomic-update-v4-0-c0e713bfdf25@kernel.org>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Jani Nikula <jani.nikula@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1781; i=mripard@kernel.org;
 h=from:subject:message-id; bh=j51Q+8mt4C7VLTrw6ArNSmzDrpkGTUdoDwgnpPfZf10=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJnvuQyeuZ5Vmi34InBy1Ur9nomdfw3OL7hv5m744WTIh
 qdvotaEdkxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJeB5lrGY99LeA76nnx7nG
 PZr8CztmdoWav/U9XbixJPcS07zF052X7L/7WTFSh3lV2AnlmxWGTxgbDqossYsL/Xpyvddelov
 LnBvzQwJcxRPTpt6adMqm3bNxqVix8cu5GoKph8Wb5hdmC80BAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

We just did that item so we can remove it.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 Documentation/gpu/todo.rst | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 2ceb00e08c59..cdddf8db35f5 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -150,33 +150,10 @@ still look at that flag.
 
 Contact: Simona Vetter, respective driver maintainers
 
 Level: Advanced
 
-Rename drm_atomic_commit
------------------------
-
-The KMS framework uses two slightly different definitions for the ``state``
-concept. For a given object (plane, CRTC, encoder, etc., so
-``drm_$OBJECT_state``), the state is the entire state of that object. However,
-at the device level, ``drm_atomic_commit`` refers to a state update for a
-limited number of objects.
-
-The state isn't the entire device state, but only the full state of some
-objects in that device. This is confusing to newcomers, and
-``drm_atomic_commit`` should be renamed to something clearer like
-``drm_atomic_commit``.
-
-In addition to renaming the structure itself, it would also imply renaming some
-related functions (``drm_atomic_commit_alloc``, ``drm_atomic_commit_get``,
-``drm_atomic_commit_put``, ``drm_atomic_commit_init``,
-``__drm_atomic_commit_free``, etc.).
-
-Contact: Maxime Ripard <mripard@kernel.org>
-
-Level: Advanced
-
 Fallout from atomic KMS
 -----------------------
 
 ``drm_atomic_helper.c`` provides a batch of functions which implement legacy
 IOCTLs on top of the new atomic driver interface. Which is really nice for

-- 
2.53.0

