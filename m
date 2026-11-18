Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661EA606A330
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=CZOWkl7a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B24E0112069;
	Wed, 18 Nov 2026 21:47:53 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C60C5112068
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=CNB6iSHvxedKweBduiq/ZM5d60BtJ26KViuAeTWVp6k=; t=1795038464; x=2110398464; 
 b=CZOWkl7aQaOiWPu/ZPxy/feV/Bk3gOUW3HpApp3rQO5OifPEmptHtSe2898zw9f+iYv72iUj6Bf
 oTMo+5Sz+Ery6DTCzB5cJM43PeQHnhzlpnUg2SGm+j4r7giOkmfEKGSVNmPdEKW5EDB7CxeZVgnQG
 I+f6inv+bmMw9rteFPujwrm50W4RAFUOgwveQdAWh1I3X2yexJMhay6uzfoKU2D2kNath3pLgbB/L
 bEho8xwAT4hdKtesgubP+yzoiWoUFNg8KvPQNGXv99IxQtatkifuKj8+p4Aua1H8O5p/BpPrdbmfF
 dXf/hdcfSF3X/Cs1Kcr7r818Dnos2KIP3Fuw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xTnVG-00000001DOD-1t8O; Wed, 18 Nov 2026 22:47:42 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 18 Nov 2026 18:47:28 -0300
Subject: [PATCH 1/4] drm/vc4: Fix off-by-one in the shader record BO handle
 check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261118-vc4-icache-workaround-v1-1-5b8adc2c84fe@igalia.com>
References: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
In-Reply-To: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
To: Iago Toral <itoral@igalia.com>, 
 "Juan A. Suarez Romero" <jasuarez@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=XNYsBpRqYjrTgWPoLRTtBGrva2YK8YUh+MlM1gtp31w=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq/hz2xNPULxF58DQPnhhBojGn/EVjzHQ2RAFOB
 CP0ZALTyG+JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCav4c9gAKCRA/8w6Kdoj6
 qscBB/9yU+UMVgOZ9oiRUZq5czxN4GvmCGKveOviF2YA647bNP7YDSSm3gWpne69cVfAD228lKK
 hP4E2X9JEYhjWNtGo3uSCyKBIdQcEryOlhyYAkjok7VePUBMeGACuF0t7cD+N7ErRKjwRudeMgu
 HlI3+CWHj91ieQEbxKJigp4u3KUlYYUzeqhlE9RjIenkIN9MwOi09ffakRkRuk4YGKwnJxyvOOp
 KBkIpvsKQLXxoCLlDI1ldQh5131Ay23nuuR6um3/p0lz1w8y0Piskdbv3EtVfqy5Jw0FupJ5Fns
 u44x6Sjs6ZZZjGOgawnD3QHbeT6c6OTFgkiOjf3bQ+FblRsI
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

validate_gl_shader_rec() accepts a shader BO handle equal to
exec->bo_count, reading one entry past the end of exec->bo[] and
using it as a GEM object.

Reject handles that aren't below exec->bo_count.

Cc: stable@vger.kernel.org
Fixes: d5b1a78a772f ("drm/vc4: Add support for drawing 3D frames.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_validate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_validate.c b/drivers/gpu/drm/vc4/vc4_validate.c
index 565227657b43..0d2b08abf1ad 100644
--- a/drivers/gpu/drm/vc4/vc4_validate.c
+++ b/drivers/gpu/drm/vc4/vc4_validate.c
@@ -815,7 +815,7 @@ validate_gl_shader_rec(struct drm_device *dev,
 	exec->shader_rec_size -= packet_size;
 
 	for (i = 0; i < shader_reloc_count; i++) {
-		if (src_handles[i] > exec->bo_count) {
+		if (src_handles[i] >= exec->bo_count) {
 			DRM_DEBUG("Shader handle %d too big\n", src_handles[i]);
 			return -EINVAL;
 		}

-- 
2.56.0

