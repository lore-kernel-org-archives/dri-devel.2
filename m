Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E47BCC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EFEB112622;
	Fri, 16 Oct 2026 07:32:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE85112622
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 07:32:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 219BB601FE;
 Fri, 16 Oct 2026 07:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E2E1F000C4;
 Fri, 16 Oct 2026 07:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792135919;
 bh=5/Ie465qnlNgII+rz7vZuby5Ts3O3OoWZbRZsv4JZws=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=AF6TTljCxZhT0jURXSINkMAO+7XvJq4Zs318ZgdpeBogcRHxO4vIgzS+/ihanzgKV
 32KxwEJM/v9Vl63YaG5axoy2hiUyfChuzYvaY5pvhj3DdwwcXfsJtcwvNjoKUwtIfM
 yWHYDQwZksFd9EjjtCMDkSNR/+i+G0x/50c76smsxNX3EDYGrgNTl0V1uHniL3tkNu
 u7l2yg05Z73iMtxVTq1olSldRmbtQDvaGf/0KnUt+OlAkEjsK7d2hs6tI1kofsGKuH
 DZ4k2cWCH7X44CjvWyUWJ6nhDY+h9W37iBzG4IqKDqS7Fry2MFgAWh061lHpnZypfw
 RC6By7z1W+71A==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 16 Oct 2026 09:31:33 +0200
Subject: [PATCH v5 01/14] drm/atomic: Switch to krealloc_array() in
 drm_atomic_get_private_obj_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-drm-reset-state-flag-v5-1-dad2d64b693b@kernel.org>
References: <20261016-drm-reset-state-flag-v5-0-dad2d64b693b@kernel.org>
In-Reply-To: <20261016-drm-reset-state-flag-v5-0-dad2d64b693b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=mripard@kernel.org;
 h=from:subject:message-id; bh=fMyUJAt+U6yiT87rnthLZ+bR8CT/dYgEIqh9S6vKb58=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkXLz3Mv9CX92B7PcPeYzJ7pvVwTc9e0p+4SXlTEkPCd
 K/ZE1nZOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEvq5mrA8KKlWqj9rKttwv
 6HVA1zfuujs3FvJs9lgn23mzJuPj8RcqOyZ1TJNh09cPMjBU99Faydiw6Kr5y51mNt5Sma84VC6
 kenMutUwOVlqx3LbsIGt7t3yB6j/35UvWpQpe3BSWqh257hsA
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
Reviewed-by: Daniel Stone <daniels@collabora.com>
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

