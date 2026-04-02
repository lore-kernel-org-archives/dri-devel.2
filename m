Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43698CC6B30
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A654A10F197;
	Thu,  2 Apr 2026 08:23:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tIWiyezw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C52710F197
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 08:23:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 56BC741674;
 Thu,  2 Apr 2026 08:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D1CC116C6;
 Thu,  2 Apr 2026 08:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775118236;
 bh=iWXNVIUZfnMW7ccKC6aXFgVMhK9ernXK6+j0PJXs1tU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=tIWiyezwCAFoPLv2uxCkYLhBz+hIFf6VJN2MHl80L0OaIXtpT9YZHcgXB4lnzOJ+M
 rKVL94vHukPQ4/Og7QQQXjzPAwf0wq7u8E3NpNxPgMB1SgvHqpJI+kxOTVX8dZ/Mky
 pAa4VF1cxSdu9icT0pR7QHMsWTLPCmdzZLeO9MuPWU6dndfP/xehCuYVOMwLsgonJE
 sWCSf+bX4mnJlJyA37LJNHL4SZsDfsuJkwXs0NfjGaIfH20uRuD4OvuBBVh9MSYbak
 M/oY9DkIJ6gM846m6LXSDFDMTfnYIe1izUh3I1zMJBACBaZPgloFBb+U/tYF6EF29b
 UofjFQm3PCenA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 02 Apr 2026 10:23:31 +0200
Subject: [PATCH v3 2/2] Documentation: drm: Remove drm_atomic_state rename
 entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-drm-drm-atomic-update-v3-2-b826f51ac511@kernel.org>
References: <20260402-drm-drm-atomic-update-v3-0-b826f51ac511@kernel.org>
In-Reply-To: <20260402-drm-drm-atomic-update-v3-0-b826f51ac511@kernel.org>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; i=mripard@kernel.org;
 h=from:subject:message-id; bh=iWXNVIUZfnMW7ccKC6aXFgVMhK9ernXK6+j0PJXs1tU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJnn1Ls9TmtHJl57YFohlCAnUHChWH5CToCKsKLiDK9LH
 3IvbvreMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZyT5mxoXnu5uXN8iL+a4TL
 7waZMzgLc/qx1ibx90Yb3ZSMO6Q4VylAYqnH7tP7Xzr15X2PuHGYsT5FhFt3xoR1qdKTP03bmML
 rxpp/8Phpdc8NjZvyzsQlMfR/2Ztn1my252vvrvnML+1iCwA=
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
index 2ceb00e08c59f0602de994749ec137107c80fb14..cdddf8db35f533787aaad22c3066766e804e8ecf 100644
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

