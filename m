Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B347460A260F
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iRmveH4x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB3A310E594;
	Fri, 30 Oct 2026 10:28:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FF3C11270C
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:28:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 381A9437A4;
 Fri, 30 Oct 2026 10:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944BD1F00A02;
 Fri, 30 Oct 2026 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793356081;
 bh=hYIZ0Nxu3e4yHwGzd5Edo5K+65SxK/KdsxGn3Zo1Zf8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=iRmveH4xAcSJdMTcNRwb6M8yTlIPGY5nAdLM+OFrBzmuufRbiAtxi31mm7n9NHTmw
 LaksTLoTMB3ulnyjIa/m3qieRaAnE8xAcedoK+IfvAPJrL6N/Fa4Uox80l8o6WKNB2
 ac8VuSbLyvswJ3wvXxYShvOsFIVbdnfrIYHfwRNWgc6WHQc9mEoZSn7AFnZQhZZlzt
 Qyb3eOaB7+0cyNoEJBKHW45tLRU1N6CXnEOkNCYzu5w/wZC3yytoQLqOtXiotc2l7i
 YJCLTQmQBiduh+Nb/aKxnpsUiMHsiY5PlPk23uIJzABWbqEGD3qrUIMdf8YZ5btOhz
 PvJWLXzYhQOLw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 11:27:36 +0100
Subject: [PATCH v7 04/16] drm/atomic: Use __GFP_ZERO instead of explicit
 memset in drm_atomic_get_private_obj_state()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-reset-state-flag-v7-4-4e55eaeae683@kernel.org>
References: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
In-Reply-To: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1481; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/y0t9kvV8Kz+g1uKURCfaTtHcrjM3f6qXQBsVU8JRDM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPCiXb5nvdMp1737qu8E/isrI4s4xpPu98UpzXS8uuK
 zZvcz/bMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACbCU8nYsMKzxXraxdu3dreZ
 8n3vLD/xc29gl8IJsVvsq9zqtx5Y9Da6bs9Oq3SW9PjatNhpM88sY6yVS59jk6GmGsG6/mZiqi/
 zLYsNH/nqmEOLz3qUW+xa57n1Q7fhh9g1PX+rVBi1y/eu+AoA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The drm_atomic_get_private_obj_state() function allocates a new entry in
the private_objs array using krealloc_array(), then zeroes the new entry
with a separate memset() call.

However, since krealloc_array() already supports the __GFP_ZERO flag to
zero newly allocated memory, the explicit memset() is redundant.

Pass __GFP_ZERO to krealloc_array() and drop the manual memset().

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index aa47c647df31..43b58e9b25e4 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1096,5 +1096,5 @@ drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
 	num_objs = state->num_private_objs + 1;
 	arr = krealloc_array(state->private_objs, num_objs,
-			     sizeof(*state->private_objs), GFP_KERNEL);
+			     sizeof(*state->private_objs), GFP_KERNEL | __GFP_ZERO);
 	if (!arr)
 		return ERR_PTR(-ENOMEM);
@@ -1102,5 +1102,4 @@ drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
 	state->private_objs = arr;
 	index = state->num_private_objs;
-	memset(&state->private_objs[index], 0, sizeof(*state->private_objs));
 
 	obj_state = obj->funcs->atomic_duplicate_state(obj);

-- 
2.55.0

