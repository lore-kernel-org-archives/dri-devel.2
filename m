Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FDBCD6E7D
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 18:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C47112928;
	Thu,  4 Jun 2026 18:05:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WWGbAExE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E2D112922;
 Thu,  4 Jun 2026 18:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=I7DrWxmBzxPOglXuI1YiImqe0UP51nuTNj2kxaFtVkY=; b=WWGbAExE33530/+JJfDqjg/DJs
 kiJmIu88QWY6zuKZIbSa3ZUthlCMtif52cq2cCyjcJsD1rfMVWGPL6SjE27gae5mz7zELXQnTZR3A
 GW4okr9DGJoj57pTK7d6RzmsV+k43X/xQ5TqzFBlhHdqSu/fxXrBh5cJ/nZCi8t15c8wVO5pfrAai
 y/kPHYJLF02gvvqyAffS98JX0lkZyg8dPi86liMZCk/UrA4xrPkCpsPe5ZA4wAeVv2TieMVoQgHx8
 EtwJbqbknKIbZF2DbLCjc8X5EIuqjzhKipBx5G7kKlA8B/XBsJM5NTd/eZKlJDzdefvaU6rysRZF2
 QPLtRA1g==;
Received: from [79.117.146.159] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wVCRI-00Ckqs-9m; Thu, 04 Jun 2026 20:05:08 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de
Cc: Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 Sebastian Wick <sebastian.wick@redhat.com>,
 John Harrison <John.Harrison@Igalia.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/3] drm/atomic: duplicate state of all colorops
Date: Thu,  4 Jun 2026 19:59:06 +0200
Message-ID: <20260604180457.1110110-3-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604180457.1110110-1-mwen@igalia.com>
References: <20260604180457.1110110-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Userspace expects that colorop settings of an inactive color pipeline
persist, so that, when the color pipeline is activated again, colorops
previously set preserves their values when it was deactivated. Colorop
setup is expected to persist even during a suspend/resume. To snapshot
colorop settings correctly, duplicate state of all colorops in a given
plane, independent if color pipeline is active or not.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 51f39edc31ed..ea15e58518fd 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3752,12 +3752,9 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
 			goto free;
 		}
 
-		if (plane_state->color_pipeline) {
-			err = drm_atomic_add_affected_colorops(state, plane);
-			if (err)
-				goto free;
-		}
-
+		err = drm_atomic_add_affected_colorops(state, plane);
+		if (err)
+			goto free;
 	}
 
 	drm_connector_list_iter_begin(dev, &conn_iter);
-- 
2.53.0

