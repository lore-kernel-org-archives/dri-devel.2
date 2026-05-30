Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FCBCD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF2B211284B;
	Sat, 30 May 2026 14:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="edAt3CZr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1673811283B
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:02:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8E920600BB;
 Sat, 30 May 2026 14:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31351F00893;
 Sat, 30 May 2026 14:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149772;
 bh=u6xhlNh+s4qS9ptXONO+QPTvxfs/B5eCp5PvHFvWUig=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=edAt3CZrkIKDtBOa6iAgNAPNCCL4RyI5+l2OCUqPJuUZcVFq5GOSI/3a7ClpJds0I
 jmRmUq0wVgrt6pXGyLoBhX0d4h2ItPuwwRp3xWj9bUVlP6imVb83l3DoPCecWHpZQw
 qiQyRpdGeeXFEZlPfT1z9gUjXfB8Qs+O1TSzMBSYRSQzcJII72Jx9IhP1mu6Azwx3H
 xOBhgo7h3HzruDnO11VwvmKYxgJAVWoXrtvXrXt2EcxVJd8/ygOgTO0TQU5JfA5AEU
 XCnMnUVdOweFIv1+VChjZICh8y/0GIIvTJJgyu5rI+3QsaeT5cuxKrkoxslC5kdqnl
 RGj/2rYQ+QYLQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 16:00:11 +0200
Subject: [PATCH 66/76] drm/tests: bridge: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-66-875d828d31bc@kernel.org>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=mripard@kernel.org;
 h=from:subject:message-id; bh=3SmQ9VzcC6wJ2AYtS+2hh3zjGSVRjIHCIc+aCojzUfI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb4MiPxQopl5S7UhZYbrk7z/L4jtuvw+9YdavCZ9xe
 EX2/kdfOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE/j1mrA/9b7hJXMG03GHX
 4amvT17992yW0s3He34vk7X7F3s37Pr+RzHd06uZVMV6BTfs+C+du5qxTtvkkujeyhtr/p+py3m
 Vekfsab7M/T0cU1dtr3zRqnlRXKrz59tdAh6id2fOXbT+T/GNHwA=
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

The drm_bridge_funcs.atomic_reset callback and its
drm_atomic_helper_bridge_reset() helper are deprecated.

Switch to the atomic_create_state callback and its
drm_atomic_helper_bridge_create_state() counterpart.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_bridge_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
index 64b665580a88..3f0269e52432 100644
--- a/drivers/gpu/drm/tests/drm_bridge_test.c
+++ b/drivers/gpu/drm/tests/drm_bridge_test.c
@@ -90,11 +90,11 @@ static const struct drm_bridge_funcs drm_test_bridge_atomic_funcs = {
 	.destroy		= drm_test_bridge_priv_destroy,
 	.atomic_enable		= drm_test_bridge_atomic_enable,
 	.atomic_disable		= drm_test_bridge_atomic_disable,
 	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_bridge_duplicate_state,
-	.atomic_reset		= drm_atomic_helper_bridge_reset,
+	.atomic_create_state		= drm_atomic_helper_bridge_create_state,
 };
 
 KUNIT_DEFINE_ACTION_WRAPPER(drm_bridge_remove_wrapper,
 			    drm_bridge_remove,
 			    struct drm_bridge *);

-- 
2.54.0

