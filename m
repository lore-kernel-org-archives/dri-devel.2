Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C571B106F317
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 10:09:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3359310E36F;
	Thu, 26 Mar 2026 10:09:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hv9rPz9e";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1584E10E36F
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 10:09:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EF97E434B7;
 Thu, 26 Mar 2026 10:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D26AC116C6;
 Thu, 26 Mar 2026 10:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774519793;
 bh=ehwJ0z/KHrCfGQljJUa7Xkhys1ou4TDKybZZvsmc+Mk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Hv9rPz9e8txkHnqwpeTyHCyTrBSltAqpTSvpUUPeZSncnZwh/gRpH/Yj/Te4l7hqm
 rB7cTRCzGlSgcMJsmy5xCsPqfKT3/jL6cPp7Xfqo3uNPy/e13c3Wc2cUSf+rwJLjr8
 PMi35ovkyaGdlH0JmoVUQ6XbioNC2C8Ue5+o2yrJ8DusJw3W3W6IFKtd1XxKcnhrx2
 /n7A7RcdnbPp9Qz4a6ro6BY9CloAW6rYG6ulo1LgIBRFnG5pYkTW+IHt4FgtrKi/yz
 4eivB1Jq2gwpSMwA4mWaZgTfre/nSf1JX2365rzCdW91x0THtXdxb3hjzNsYZDUm9N
 PnjjPoPExu2uQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 26 Mar 2026 11:09:39 +0100
Subject: [PATCH 2/2] Documentation: drm: Remove drm_atomic_state rename entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-drm-drm-atomic-update-v1-2-2f7af5f4ad02@kernel.org>
References: <20260326-drm-drm-atomic-update-v1-0-2f7af5f4ad02@kernel.org>
In-Reply-To: <20260326-drm-drm-atomic-update-v1-0-2f7af5f4ad02@kernel.org>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1726; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ehwJ0z/KHrCfGQljJUa7Xkhys1ou4TDKybZZvsmc+Mk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJlHWZ+7GDmeuhD130FvRw9Ta6NE/Zb1ol9z/E90x053X
 /JftKSmYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAExEKJaxzjb8PZscz6f46f1n
 3EJc97AsqipUn9HP+NTgxhJfIVux01YFzldm6d4IcFtytXrzt6kVjPWFTwrfJF6tEfPsTpxnfj/
 94vRPG9g31k8/4xYmscLW0s1kNve7UpfHsm5bG32S317N8wcA
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

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 Documentation/gpu/todo.rst | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 520da44a04a625e6ded3c6ef672c221523a993f8..407ceb14524e6971a13812fed4496d0feb91108a 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -118,33 +118,10 @@ still look at that flag.
 
 Contact: Simona Vetter, respective driver maintainers
 
 Level: Advanced
 
-Rename drm_atomic_state
------------------------
-
-The KMS framework uses two slightly different definitions for the ``state``
-concept. For a given object (plane, CRTC, encoder, etc., so
-``drm_$OBJECT_state``), the state is the entire state of that object. However,
-at the device level, ``drm_atomic_state`` refers to a state update for a
-limited number of objects.
-
-The state isn't the entire device state, but only the full state of some
-objects in that device. This is confusing to newcomers, and
-``drm_atomic_state`` should be renamed to something clearer like
-``drm_atomic_commit``.
-
-In addition to renaming the structure itself, it would also imply renaming some
-related functions (``drm_atomic_state_alloc``, ``drm_atomic_state_get``,
-``drm_atomic_state_put``, ``drm_atomic_state_init``,
-``__drm_atomic_state_free``, etc.).
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

