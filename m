Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC3EC982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73AF710E8FD;
	Fri, 18 Sep 2026 14:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JJ83R+sn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4055010E8FD
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 14:18:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EACC440524;
 Fri, 18 Sep 2026 14:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0898F1F000FF;
 Fri, 18 Sep 2026 14:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789741085;
 bh=F4UcFgN5ms+bbUQcU8tcSIW9gIecezr/8JMKx3gOffg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JJ83R+sn88/JyA2gROVKjZ8kC7WSOIarK1qoaSgxjUL/0lrPLeEzOykFzCNr1PqhC
 PDYtTOVCIQtAOwD/yXD/LkOat0oRn/1GwgnGqoKvA5k7eziFAFRxKupt0PmaiaiJUC
 Ak6tWqDWi3GMQAj3eLSkau0lCOmj3MD5nrcgzwsQd5WQzZMblkL/363c2DMXIcGP+J
 3ZMSTPFPcrrjC2eAvCmvP3YJmgUZBOTeCPXQtunFMhtJzYVeRGC20s7jMAEr8UcIrY
 wDYm56iMc7IHoD6uomWTQXomYev1zl6QW6KznfTTdNSgzpy80CcRA4KYUED2rNN1Ca
 zkxu6orVEs/TA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 18 Sep 2026 16:17:50 +0200
Subject: [PATCH v4 01/13] drm/atomic: Switch to krealloc_array() in
 drm_atomic_get_private_obj_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-drm-reset-state-flag-v4-1-5ad106370f05@kernel.org>
References: <20260918-drm-reset-state-flag-v4-0-5ad106370f05@kernel.org>
In-Reply-To: <20260918-drm-reset-state-flag-v4-0-5ad106370f05@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1700; i=mripard@kernel.org;
 h=from:subject:message-id; bh=sx1UwW3xDFuaLzMdKnc77CcZQnHJXWxl0xTfnmk86HM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlrPfg1+G6+il6lxe27/4LG+mStN70hbhxG5zK88uuc4
 l+16O/rmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABOJsGZseG//d21frafz+wtf
 /oq8EVt5VmtFovP9i5MdtjQXvVnsc2SmwL0us5NRSgnNhkzOJ0POM9YnhpR+Y2/UM3xoHp966EO
 oWobZ5+nWHuH/UpcZVeqaSZ5q/mW5tmtC3d6cS7+EBZ/3GAMA
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

The drm_atomic_get_private_obj_state() function manually computes the
allocation size by multiplying the element count by the element size
before passing it to krealloc().

krealloc_array() handles this multiplication internally and includes
overflow checking. Switch to it and drop the now-unused size variable.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 9bb761eda59f..aa47c647df31 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1077,11 +1077,10 @@ EXPORT_SYMBOL(drm_atomic_private_obj_fini);
 struct drm_private_state *
 drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
 				 struct drm_private_obj *obj)
 {
 	int index, num_objs, ret;
-	size_t size;
 	struct __drm_private_objs_state *arr;
 	struct drm_private_state *obj_state;
 
 	WARN_ON(!state->acquire_ctx);
 	drm_WARN_ON(state->dev, state->checked);
@@ -1093,12 +1092,12 @@ drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
 	ret = drm_modeset_lock(&obj->lock, state->acquire_ctx);
 	if (ret)
 		return ERR_PTR(ret);
 
 	num_objs = state->num_private_objs + 1;
-	size = sizeof(*state->private_objs) * num_objs;
-	arr = krealloc(state->private_objs, size, GFP_KERNEL);
+	arr = krealloc_array(state->private_objs, num_objs,
+			     sizeof(*state->private_objs), GFP_KERNEL);
 	if (!arr)
 		return ERR_PTR(-ENOMEM);
 
 	state->private_objs = arr;
 	index = state->num_private_objs;

-- 
2.55.0

