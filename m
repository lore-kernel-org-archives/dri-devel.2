Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99767606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VqpyptJr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 042A310FB9C;
	Wed, 25 Nov 2026 11:37:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7152A10FB9C;
 Wed, 25 Nov 2026 11:37:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9197462919;
 Wed, 25 Nov 2026 11:37:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795606630;
 b=rnadFziWWhclqJCsEIYDiV94uTByLaQsDxbWgBphYK4P0+NykaF60mYdwPr75BwthMl6
 PPbHkSU2eppkKBVY/dbluOkkdz+I51auDL3vm7TZGB817QVQgR+xPP+7qlK0/olddj3HI
 2AuQXuL07qp8uaSStrf2TH+vqHosEJHY1B6SwydbwiulS6SrYqJpGG8kbEmwx0bA8gNnJ
 e2ZV5nuJfv+UGKBM5xuEC9fWWpVDbHu35TwsZSGwXiakP4PHavazgs2E7HWnCiuzPDiqa
 wWW6i2mr4r3vXv7a3xj2ocySySMnIOFuS1DJBygIuWm7/5r8ed0B8zU+71H5U6ebftQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795606630;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Urgc9IazF2mCtC2qPTlgAIEJYRY7GbC0mTCLTb2SyA0=;
 b=HZqj4JsNHq7AkFkRqEmUVmF79zzXB3q6wbE17ZAGeeT43oL0m0c5+VFzh368XKYqfHHt
 I2v7v2n5EO9qPZciEcOWgJ95J31mxXnq8W++E+FniYjsagOQo4qP/RfkNRj1V4LN1cCxJ
 +vEYzQ5hrHNZ2ZgIEIunTArrCdvMdBOEzEE4Co+jAZCGsDQYzYuqfRtZWKwsQb+0VVoMH
 TFUQS74DMT2M0QgIxFZaPLCktaDBF7XmIorstYYMCLg6bTP1K7gGTJVy5b+JliBOZ+Hbj
 2nOTVdDHT+0Zb2pZScdYNFXLbcavEmWE2fvc+si4Z08gmIJJ2ELQlMrdodRxhmzrzSw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id B725E1F000C0;
 Wed, 25 Nov 2026 11:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795606630;
 bh=Urgc9IazF2mCtC2qPTlgAIEJYRY7GbC0mTCLTb2SyA0=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=VqpyptJrnzLDpaDETwQVYD6FUBaOFFkSNlSlIfYFo6X4dSpDzaZRlXQ0sNBSzd0GC
 QzQMNYMZUDIGZk5OG3qi7XBw+XfTKmjKsSvxMv3/mTRG2zBBpfJTPhiIuWjPoH/GmM
 Ms2N18tbaV2RtQ8Qhk9LDHTzAaEfPoRp4DArQUoPWuA/TFkVlOjCNor1fUKzLIiFAs
 3vE04d2C3aYPIJd5uM0KrJvIv8pgAKb6VcNngtAFrezo+TKzWiMJeE2DBBJSy0hqKn
 RIK3wFRALFjkfXE5WfHK8Z50SU4/DPtAQ7JCnyyKEIHgLbTFeniQHHXvfB+63REsqe
 NlIP5GkPFnmDw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 175D14CE93;
 Wed, 25 Nov 2026 11:36:58 +0000 (UTC)
From: Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org>
Date: Wed, 25 Nov 2026 12:36:56 +0100
Subject: [PATCH] drm/msm/dp: clear AUX_TRANS_CTRL on reset and enable
 HPD_REFTIMER
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-drm-msm-dp-aux-resume-v1-1-17f5a40b9a61@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFfIBmsC/x3MMQqAMAxA0atIZgO2YLVeRRzUppqhKgmKIN7d4
 viG/x9QEiaFrnhA6GLlfcswZQHzOm4LIYdssJV1xtgagyRMmjAcOJ43CumZCH3r42Qn3wRXQ24
 Pocj3/+2H9/0AI4wKsGcAAAA=
X-Change-ID: 20261125-drm-msm-dp-aux-resume-989fb2b97d65
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Stephen Boyd <swboyd@chromium.org>, Vara Reddy <quic_varar@quicinc.com>, 
 Guenter Roeck <groeck@chromium.org>
Cc: Chandan Uddaraju <chandanu@codeaurora.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Robert Ijtsma <robertijtsma@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795606616; l=2417;
 i=robertijtsma@gmail.com; s=20261122; h=from:subject:message-id;
 bh=+w3WryHW52WZHIQwqGhCofikKiZ/0IuvGEhWNHLjCn0=;
 b=ltcA/KwYNwrXXIpJz1KcowA3irEz+fjhPBvQcHZAOHC5Ekm7xY8tBM0JHTVGvy27uw5LFdycS
 rDystoXd6UtBw7VQtJoX+opc+LmCccRmsIWRIR+HKu9b71VR5h9YB0a
X-Developer-Key: i=robertijtsma@gmail.com; a=ed25519;
 pk=qiDyKVqFicxFIR5sB5m+p9SWPKL2/+mMoiQnUx0C9P0=
X-Endpoint-Received: by B4 Relay for robertijtsma@gmail.com/20261122 with
 auth_id=1604
X-Original-From: Robert Ijtsma <robertijtsma@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: robertijtsma@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Robert Ijtsma <robertijtsma@gmail.com>

On boards using an external HPD bridge (such as Microsoft Surface Pro X /
SC8180X), internal HPD_CTRL is never enabled via msm_dp_aux_hpd_enable().
Across runtime PM or s2idle suspend/resume power collapse, two AUX
controller issues prevent reliable link re-training:

1. msm_dp_aux_reset() does not clear REG_DP_AUX_TRANS_CTRL before
   pulsing DP_AUX_CTRL_RESET, which can leave a stale transaction bit
   latched across reset.
2. msm_dp_aux_enable() relies on msm_dp_aux_hpd_enable() to set
   DP_DP_HPD_REFTIMER_ENABLE; when internal HPD is unused, AUX timeouts
   can stall after power collapse because the 1us reference timer is off.

Clear REG_DP_AUX_TRANS_CTRL in msm_dp_aux_reset() and ensure
DP_DP_HPD_REFTIMER_ENABLE is set in msm_dp_aux_enable().

Tested on Microsoft Surface Pro X SQ2 (SC8180X) across s2idle suspend
and resume.

Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")

Signed-off-by: Robert Ijtsma <robertijtsma@gmail.com>
---
Ensure AUX reset clears REG_DP_AUX_TRANS_CTRL and msm_dp_aux_enable()
enables the 1us HPD reference timer even when internal HPD is unused.
---
 drivers/gpu/drm/msm/dp/dp_aux.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index b52393dcc067049529a51a9885990e5da663d802..2584dbf96043121b79310689b01ee21edc223107 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -76,6 +76,8 @@ static void msm_dp_aux_reset(struct msm_dp_aux_private *aux)
 {
 	u32 aux_ctrl;
 
+	msm_dp_write_aux(aux, REG_DP_AUX_TRANS_CTRL, 0);
+
 	aux_ctrl = msm_dp_read_aux(aux, REG_DP_AUX_CTRL);
 
 	aux_ctrl |= DP_AUX_CTRL_RESET;
@@ -88,7 +90,12 @@ static void msm_dp_aux_reset(struct msm_dp_aux_private *aux)
 
 static void msm_dp_aux_enable(struct msm_dp_aux_private *aux)
 {
-	u32 aux_ctrl;
+	u32 aux_ctrl, reftimer;
+
+	/* Keep the 1us AUX/HPD reference timer running without internal HPD. */
+	reftimer = msm_dp_read_aux(aux, REG_DP_DP_HPD_REFTIMER);
+	reftimer |= DP_DP_HPD_REFTIMER_ENABLE;
+	msm_dp_write_aux(aux, REG_DP_DP_HPD_REFTIMER, reftimer);
 
 	aux_ctrl = msm_dp_read_aux(aux, REG_DP_AUX_CTRL);
 

---
base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
change-id: 20261125-drm-msm-dp-aux-resume-989fb2b97d65

Best regards,
-- 
Robert Ijtsma <robertijtsma@gmail.com>


