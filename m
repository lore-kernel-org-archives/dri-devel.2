Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7E0606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=FK4afTl+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08E0A1129D1;
	Fri, 30 Oct 2026 20:52:39 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E8541129D1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 20:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=VQ1bTLRkRrwqnRBt9T47q1A1q/EZj5GZpebCsFmWhkE=; b=FK4afTl+Zl9SWLgnkFInSKTqtP
 nrX07wgYZnC7S1XAr15oJ5EveZ744pfe6N1pU0qOWt1nPd8B1aynZEuiES+GV466c402bvuN4Aq5+
 fyJSrjQWrKPEj4EL4lvUwVuqG2VjCHl8527693ppF6UCpyM/zVmic0Ntton26oO419Blf5K2f2Vl7
 bcgpSixDBobRGMBAAhpQYYby4IokbAIAzB29SjjzNStzmMpAhUJEww2zhJQzXLmz9LLP1UKi+5CZZ
 7GRG26iRVui8BVKZw6+KXXfo31YeD0DM0w8SK9okfVo8fxeyZfyHQT06IOIiLS3fkKY95Qn1FV82r
 tjaphG6g==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xMtaB-00FLiF-5m; Fri, 30 Oct 2026 21:52:15 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Fri, 30 Oct 2026 17:50:30 -0300
Subject: [PATCH RFC 12/12] drm/v3d: Advertise support for write-back
 cacheable BOs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-v3d-cached-maps-v1-12-0a6a6b363382@igalia.com>
References: <20261030-v3d-cached-maps-v1-0-0a6a6b363382@igalia.com>
In-Reply-To: <20261030-v3d-cached-maps-v1-0-0a6a6b363382@igalia.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 JaeHoon Lee <dlwognsdc610@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1236; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=bmYwGnujozFBaEletR4SC07na1nrSpHxaKqv6rolGNg=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq5QNEuIB/M9qI7qskaeKhOd4trFhyK5Hoi0sIL
 SsVssZDqg6JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCauUDRAAKCRA/8w6Kdoj6
 qgTXB/9H0EAliDFKL0IXsDdC8CAwOsuOOdYa01hQxdVHFNq82RXwDKVPVM4jlBhxSEIu1PrTOkU
 vGRxRu9RXu36y2ERpgDYvoLz9CW2jtilKwM6ARb2qD6IPZdiOD032Ah2qTvYmytSdxorPU3CC1t
 ydpgzrj/PG6QqgFJNZOXQ63dhfrV8J7NaJuXqwheg6xz52Z+4Na2ZoeK64PjjPESoIwX1E7IBHF
 jioGP6Kacyb6s/kRSr5qlOmDR8aej1YzDNrqbrJPRMJebpj6qE62+Df6IXNilZIyB8igPNd6loz
 G3sbO5hUbNgeBuqEHszpJeBEFWLTUNjXLYnhIhFsNeqkf0D6
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Advertise support for DRM_V3D_BO_WB_MMAP and DRM_IOCTL_V3D_SYNC_BO by
adding a new V3D parameter.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 3 +++
 include/uapi/drm/v3d_drm.h    | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 9e6e4f832eee..e613af3ac81f 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -132,6 +132,9 @@ static int v3d_get_param_ioctl(struct drm_device *dev, void *data,
 	case DRM_V3D_PARAM_SUPPORTS_TFU_CCOL:
 		args->value = (v3d->ver >= V3D_GEN_71);
 		return 0;
+	case DRM_V3D_PARAM_SUPPORTS_WB_MMAP:
+		args->value = 1;
+		return 0;
 	default:
 		drm_dbg(dev, "Unknown parameter %d\n", args->param);
 		return -EINVAL;
diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
index c2f7f1409ae4..7035319766e8 100644
--- a/include/uapi/drm/v3d_drm.h
+++ b/include/uapi/drm/v3d_drm.h
@@ -304,6 +304,7 @@ enum drm_v3d_param {
 	DRM_V3D_PARAM_GLOBAL_RESET_COUNTER,
 	DRM_V3D_PARAM_CONTEXT_RESET_COUNTER,
 	DRM_V3D_PARAM_SUPPORTS_TFU_CCOL,
+	DRM_V3D_PARAM_SUPPORTS_WB_MMAP,
 };
 
 struct drm_v3d_get_param {

-- 
2.56.0

