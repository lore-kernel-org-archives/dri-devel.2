Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12F8CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 04:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 464DD10ECD1;
	Mon,  8 Jun 2026 04:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T3Fx+MA1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9920610ECCF;
 Mon,  8 Jun 2026 04:54:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 74A4C43FFD;
 Mon,  8 Jun 2026 04:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A03CC2BCB0;
 Mon,  8 Jun 2026 04:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780894482;
 bh=zz+ReJGPCjYBFBCb2r084XSplvTHAjsBwYFx0jJ9sDo=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=T3Fx+MA1ifV+eBA9lm8IqQLJ3o7hr6+paOiASowXe+bLjRrfSvUB4ryQsiGA5SUGH
 Gvv2i4WvmscspasIAR7weNHWYualDDgB/K1Ho4541rrU9qJf1w+BlyoyHzP4NjvaJi
 OBhbUaMaXoVXiJU+CJcWRIhEAG7sS66IrLxSY2j18IU1druj2f2WKyujfKZ+wcr/Ti
 fUZ/UnXA/d8tDPaBUOQGjnleik+SLOcjZT+KcTcG9s35AfHB8n3q7XQS4iTMMhnP4S
 ftQCotpJGJjTLQ+jkomdLGsOgPO/byik5EjqaeSmbiXAYFdSkkWCQurQTnwWCJrs9t
 IfQmEASETC0yA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 40437CD8C92;
 Mon,  8 Jun 2026 04:54:42 +0000 (UTC)
From: Jens Glathe via B4 Relay
 <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Mon, 08 Jun 2026 06:54:39 +0200
Subject: [PATCH v3] drm/msm/dp: add missing drm_edid_connector_update()
 before add_modes on cached EDID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm_plug_flaky_edid-v3-1-1ca632938e7f@oldschoolsolutions.biz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OSw6CMBCA4auYrq1pByzWlfcwhkAf0FgpaaERC
 Xe3sHGjLv9J5puZUVDeqIDOuxl5FU0wrkuR7XdItFXXKGxkagQEGDlmFEv/KHs7NqW21X0qlTQ
 SC1EUeaaZ5oSjtNl7pc1zU6+31K0Jg/PTdiTSdfrfixRTDAU5CcqkULy4OCuDaJ2zwdlxSD+GQ
 21eaMUjfEBG4DsICaTAuK55DsD5T3BZljf8jnCRFAEAAA==
X-Change-ID: 20260531-drm_plug_flaky_edid-cc7743f6f909
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Douglas Anderson <dianders@chromium.org>, 
 Jani Nikula <jani.nikula@intel.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780894481; l=2688;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=55G4LQVrxBJzJlYE3Z1ybkSrDyEmlX4rhTBkpovP1x0=;
 b=dAQQLZtUlP2REJbgAX15/NGYkNWqDsTe/tGnHcSFaGRUxwNNn1zj+Uv7+inVOEEmkB4fzz1Ut
 ucAanTR8vm7AfZs50kVKzzIvKPGuy40yr9sDOjDtfIMfCkdAB2fkAa/
X-Developer-Key: i=jens.glathe@oldschoolsolutions.biz; a=ed25519;
 pk=JcRJqJc/y8LsxOlPakALD3juGfOKmFBWtO+GfELMJVg=
X-Endpoint-Received: by B4 Relay for
 jens.glathe@oldschoolsolutions.biz/20240919 with auth_id=216
X-Original-From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
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
Reply-To: jens.glathe@oldschoolsolutions.biz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

After the refactor to struct drm_edid, the fast path in
msm_dp_panel_get_modes() that already held a cached EDID called
drm_edid_connector_add_modes() directly without first calling
drm_edid_connector_update().

The new API requires the update step to associate the EDID with the
connector. Add the missing call. This restores correct behaviour for
the cached-EDID path.

Fixes: 5bea90ad9743 ("drm/msm/dp: switch to struct drm_edid")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
Hi there,

thank you for the feedback on V1. I dug a little deeper and heeded Janis'
and Dmitry's request to print the "garbage" EDID, and to my surprise it 
was the genuine valid EDID for the display. The code is documented in [1].

That changed the picture a bit - "right" EDID but not tied to the connector.
The retry code does the drm_edid_connector_update() before 
drm_edid_connector_add_modes(), so I only added that missing piece in 
msm_dp_panel_get_modes(). This proves to be sufficient to get a stable
link with the desired resolution. Therefore I dropped the entire re-read 
and retry logic, because it is of course an ugly hack.
I have tested this with my complete collection of adapters and hubs, and
all work well.

[1]: https://github.com/jglathe/linux_ms_dev_kit/tree/jg/flaky_edid_retry

with best regards,

Jens
---
Changes in v3:
- cleaned up trailer spacing, added r-b tag (thank you, Dmitry)
- Link to v2: https://lore.kernel.org/r/20260602-drm_plug_flaky_edid-v2-1-1269fb942299@oldschoolsolutions.biz

Changes in v2:
- Dropped the retry + re-read logic
- Just add the missing drm_edid_connector_update() in the cached EDID path
- Link to v1: https://lore.kernel.org/r/20260531-drm_plug_flaky_edid-v1-1-2708c16dce97@oldschoolsolutions.biz
---
 drivers/gpu/drm/msm/dp/dp_panel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 6bb021820d7c5..5b4954e7cb748 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -332,8 +332,10 @@ int msm_dp_panel_get_modes(struct msm_dp_panel *msm_dp_panel,
 		return -EINVAL;
 	}
 
-	if (msm_dp_panel->drm_edid)
+	if (msm_dp_panel->drm_edid) {
+		drm_edid_connector_update(connector, msm_dp_panel->drm_edid);
 		return drm_edid_connector_add_modes(connector);
+	}
 
 	return 0;
 }

---
base-commit: 7da7f07112610a520567421dd2ffcb51beaefbcc
change-id: 20260531-drm_plug_flaky_edid-cc7743f6f909

Best regards,
-- 
Jens Glathe <jens.glathe@oldschoolsolutions.biz>


