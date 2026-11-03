Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E826606A33F
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cc3/tB1U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6426A10F3EB;
	Tue,  3 Nov 2026 07:40:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D870610F3EB
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:40:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5726B60609;
 Tue,  3 Nov 2026 07:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6751F00A02;
 Tue,  3 Nov 2026 07:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793691623;
 bh=ULjdA9wzSU2kw+awG6ZtiJyO3lhT38uTwMSGCOJzZFU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Cc3/tB1Udx63fMwXJzTEZ3epE88HM20y6rglVAHnkzdQgOZ+92RXaxfZTKQbYmyc3
 qI6TMGKp2sILn/6yWQNRGdOgZ1ZC3FHDPW9C8KD+9XlPB+Wi9bNYE5SZ8owQen4eMD
 8CXq0t2e0qehR/+8KuMLwqlMSPjiDyKQ5EcYCOwxSREAAWFaFgt2DO31V7jFkA/IEk
 z4aON0pDK7wF4tqMIYZFSvzdzPQP5v67JJtUkb/QXP9thyJj1znHt9YzlfXwUrv4GT
 9W0a93vmhq2Yv+MVFJT/tliAVb6pJmMVK2EigjNDf/GhImLg2oBgFXUHuDZ127LuE6
 WYpo6rw15Z5Dg==
From: Hans Verkuil <hverkuil+cisco@kernel.org>
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil+cisco@kernel.org>,
 Alain Volmat <alain.volmat@foss.st.com>, Maxime Ripard <mripard@kernel.org>
Subject: [PATCHv2 01/13] gpu: drm: sti: call cec_notifier_phys_addr_invalidate
 if no EDID
Date: Tue,  3 Nov 2026 08:31:52 +0100
Message-ID: <5dd7ac527b4d3143fea73bf93c60b22a66d16d3d.1793691124.git.hverkuil+cisco@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793691124.git.hverkuil+cisco@kernel.org>
References: <cover.1793691124.git.hverkuil+cisco@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If an EDID is present, then call cec_notifier_set_phys_addr. If not, then
call cec_notifier_phys_addr_invalidate. This helps the CEC framework
differentiate between CEC_PHYS_ADDR_INVALID due to no EDID, or due to an
EDID without a Physical Address.

This driver is one of the few that was using cec_notifier_set_phys_addr
on disconnect instead of cec_notifier_phys_addr_invalidate.

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Alain Volmat <alain.volmat@foss.st.com>
Cc: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 7ba9e0b7ba6c..12e05505bbde 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -790,7 +790,7 @@ static void sti_hdmi_disable(struct drm_bridge *bridge,
 
 	hdmi->enabled = false;
 
-	cec_notifier_set_phys_addr(hdmi->notifier, CEC_PHYS_ADDR_INVALID);
+	cec_notifier_phys_addr_invalidate(hdmi->notifier);
 }
 
 /*
@@ -1068,7 +1068,7 @@ sti_hdmi_connector_detect(struct drm_connector *connector, bool force)
 	}
 
 	DRM_DEBUG_DRIVER("hdmi cable disconnected\n");
-	cec_notifier_set_phys_addr(hdmi->notifier, CEC_PHYS_ADDR_INVALID);
+	cec_notifier_phys_addr_invalidate(hdmi->notifier);
 	return connector_status_disconnected;
 }
 
-- 
2.53.0

