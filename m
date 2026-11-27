Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95059606A330
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REy9Wo72
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4FEC112B8F;
	Fri, 27 Nov 2026 15:25:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8CE112B8F;
 Fri, 27 Nov 2026 15:24:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E427362028;
 Fri, 27 Nov 2026 15:24:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795793093;
 b=YVjv9mvi8aKA4/cex8stUKTgvEC/cquMvVUTS7gKGO8pbSMNKVX5RJJ1P6lcKB3JIi6S
 wKc1gGTz1DpL418HYQNAMDahmSrn3L5PdsVY9s76kwwjqH84Mm1VwErhmIty/LBOAQ7Cz
 iqPN9WEhPIRwiRhod40MvDLoh1g5ideCRRA1A81xKOY3kJU0eCb2YOys5D6/j2GrBBRKA
 TzNnn/DGD0lX4SqaTUHBZ4U+jVLYwzrcKPAKP0KE3Euk3G+hE39JrZRgKhxd1RkjwUkTp
 ODIH4k9eo6AdEZ6oCm7dmwY9jJNU/nv5TvDW8+8z4NXj6laG5iiT2N+CvkI2zDVVsnQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795793093;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=JQ3aam2jLOFpYrKlCUnHuVKdqm91LCjlOXB+O2uB1uM=;
 b=GwJkaVLycVQOHisBhTvWA3mckyelQo+IlqxorVXBm4lOS50Fulf9OBncNwHDUedIc5+9
 9IU5tv0YiqVfsH/jp5JOcuVMh/M5byYQftDN1Uzr/uafJ4yy2beLK5NdDU8a9/t/FL0UW
 r5H3zVC/OK4gr+540WCwVPJoJLntV82rDxqQ3Z3wKU7SgN1QP78JlhJpBX+0s93ijVpOD
 QnlmVP9UIGoDgwCZJg/Z23jNNaDix3xFw0zBbFT8DBbxuiPji+VRE3uSto82g9qU+6yIm
 Z5okNwpFIyrXK/gpxJcZY0FvH9bLOjSSSZzx25kcZpcxHc4nBc8vzJ/dWlapw6vXCNg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 7A83C1F00929;
 Fri, 27 Nov 2026 15:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795793093;
 bh=JQ3aam2jLOFpYrKlCUnHuVKdqm91LCjlOXB+O2uB1uM=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=REy9Wo72gMdfhefW3kXWoB9U6nHeNrUN+EimeM5jCkovfpigajJlLq5jeKg7NN+wu
 TdygJ2c4Neg9pnv88M3p0S2PfDKdGRaEFUinQedJKW7KSEldyh/CBvIhVeJvr1Nod3
 9g6OjSUhVYgeuBKb1fP4+6BQSrF+096vGaTzt6IbnJEVUwZzlehprOIaQN1SQdlzOK
 9nORzIr8g6aSgycJiJNnzyh0+LU4xSQCgnrM0kzGhA9zvq4oGoa7X14QQs7IFwnS54
 mzZUph9XP0m5sIcqO4Z+YCzdLY77jbLBLjqqCFJPWPVAcNdhpj3NQP71SD2Gka0qNC
 eBi/fByHetvlg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 023244B85E;
 Fri, 27 Nov 2026 15:24:39 +0000 (UTC)
From: Zhendong Liu via B4 Relay <devnull+yzddmr6.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 23:24:37 +0800
Subject: [PATCH v2] drm/msm/dsi: Fix double put of the PHY device on probe
 deferral
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-upstream2-msm-dsi-phy-ref-v2-1-be82aab71166@gmail.com>
X-B4-Tracking: v=1; b=H4sIALSgCWsC/42Oyw6CMBBFf8V07SAtL+PK/zAs+higxgLpAJEQ/
 t0WE9cuz507J3djhN4isdtpYx4XS3boA4jzielO9i2CNYGZSEXJuUhhHmnyKJ0ARw4MWRi7FTw
 2oLDJjMbMNFiy8D+G0L4P96P+Ms3qiXqKwthQkhCUl73uYvRTX47DUiU5eJ3FZmdpGvx6zFx4N
 P6zaOHAwYiyUtfKFHnR3Fsn7SvRg2P1vu8ffpuClv4AAAA=
X-Change-ID: 20261120-upstream2-msm-dsi-phy-ref-bef3dce3dfe6
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miaoqian Lin <linmq006@gmail.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Zhendong Liu <yzddmr6@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795793078; l=2946;
 i=yzddmr6@gmail.com; s=20261028; h=from:subject:message-id;
 bh=7pDeVytCnO+Ht8gillWTKBsW0hZk8jkNgWUnJt2sCQc=;
 b=OP/iel1IqGfob8BkPZuho3vNQCEgYSMhN1s5aYKbitq3QmqUqaPt8DOPBLz+9gYhVM0WI8chv
 FLaoDIVNTruAwtKO+up8aAXOqEGzDbNxK6geJVWNHxPH5Pf8bqEBBP1
X-Developer-Key: i=yzddmr6@gmail.com; a=ed25519;
 pk=QLT2mwairk4R38oU379hkHynqjoLrlqd0Cl1ERUqIqY=
X-Endpoint-Received: by B4 Relay for yzddmr6@gmail.com/20261028 with
 auth_id=1489
X-Original-From: Zhendong Liu <yzddmr6@gmail.com>
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
Reply-To: yzddmr6@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_REPLYTO,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhendong Liu <yzddmr6@gmail.com>

Since commit 6977cc89c875 ("drm/msm/dsi: Fix some reference counted
resource leaks"), dsi_get_phy() stores the PHY device it looked up in
msm_dsi->phy_dev before it checks whether the PHY driver has bound, and
dsi_destroy() drops that reference. dsi_init() calls dsi_destroy() when
dsi_get_phy() fails.

Commit c04c3148ca12 ("drm/msm/dsi: Fix missing put_device() call in
dsi_get_phy") then added a put_device() for the case where the PHY
device exists but has no driver data yet. In that case the reference is
now dropped twice, once in dsi_get_phy() and again in dsi_destroy(), so
each probe deferral for this reason takes one reference too many from
the PHY platform device. Enough deferrals underflow its refcount and
free it while it is still registered.

fw_devlink normally keeps the DSI host from probing before its PHY has
bound. The path is reached with fw_devlink=permissive or off, and after
the deferred probe timeout when no driver matches the PHY device, as
the device link is relaxed then and every probe retry of the DSI host
drops another reference.

Drop the put_device() and leave the reference to dsi_destroy(). This
effectively reverts that commit and brings back the single check that
it split in two.

The double put was found with the help of an AI coding assistant during
a review of the driver.

Fixes: c04c3148ca12 ("drm/msm/dsi: Fix missing put_device() call in dsi_get_phy")
Signed-off-by: Zhendong Liu <yzddmr6@gmail.com>
---
Found by reading the code; I have not hit this on hardware, and there
is no reproducer. Build-tested only: drivers/gpu/drm/msm/ with W=1
(arm64 defconfig) on the base commit below, no new warnings.

I used an AI coding assistant for this work. It found the double put
while reviewing the driver and drafted this patch and changelog. I have
reviewed the change.
---
Changes in v2:
- Use my legal name in the From: and Signed-off-by: lines, as requested.
- Link to v1: https://patch.msgid.link/20261120-upstream2-msm-dsi-phy-ref-v1-1-d267b87d545f@gmail.com
---
 drivers/gpu/drm/msm/dsi/dsi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 090726be5061..5f9a1409432a 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -44,12 +44,7 @@ static int dsi_get_phy(struct msm_dsi *msm_dsi)
 
 	of_node_put(phy_node);
 
-	if (!phy_pdev) {
-		DRM_DEV_ERROR(&pdev->dev, "%s: phy driver is not ready\n", __func__);
-		return -EPROBE_DEFER;
-	}
-	if (!msm_dsi->phy) {
-		put_device(&phy_pdev->dev);
+	if (!phy_pdev || !msm_dsi->phy) {
 		DRM_DEV_ERROR(&pdev->dev, "%s: phy driver is not ready\n", __func__);
 		return -EPROBE_DEFER;
 	}

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261120-upstream2-msm-dsi-phy-ref-bef3dce3dfe6

Best regards,
--  
Zhendong Liu <yzddmr6@gmail.com>


