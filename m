Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646F606A320
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=ewY2GHnQ;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=O2ZuP0Vm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D0DB10E0DE;
	Sun,  8 Nov 2026 21:33:26 +0000 (UTC)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7552610E0DE
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 21:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1794173578; bh=mld1YjQVRW7XQTMott+990Z
 WzRSiS3g1hcDI5GmZvEs=; b=ewY2GHnQ/pmFHOwOVOu3RQ+UT4GGCl9LSvnX7r6y6RjbYnG1Kb
 3lUc88gD42HzocT/TH7KTBy7HvT5urPZKrksCYz+ezN8cu12wMN3eX8Yt6FQ3x4TrBIrjTlty74
 rTWUutVa58JbukKJ8W46reWp/MqZceQ+cK8OXmnfclgEeX8wAJqb5XKR1JmwPBUU+7RUrqPWvm0
 7m81mNQKgt8+w53ZApnPqHZ1OlkU0843w6AWW4ZwkPiPmoKNvK8UgNBSjK5DyBicJpuNU7C3me7
 AAlL9LuzQtBg+UWIWdDGOhT4pjPZE/VkODP08yWwH6YZfV/8zupFiIi3lacikWb8ArQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1794173578; bh=mld1YjQVRW7XQTMott+990Z
 WzRSiS3g1hcDI5GmZvEs=; b=O2ZuP0VmVFDWbNwvY1yDWjbb/aiRSnhIza9WfiVOOeVPxGrv45
 R0X8DLxWpNUZ04OdvQgn1Agd/uUjVYKtrzBA==;
From: Dang Huynh <dang.huynh@mainlining.org>
Date: Mon, 09 Nov 2026 04:32:50 +0700
Subject: [PATCH] drm/panel: boe-bf060y8m-aj0: Correct display pixel clock
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-pro1x-display-pixelclock-v1-1-c81453fab5e4@mainlining.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBCF4auUWTswycIaryIu2mSio6EJmSqV0
 rs3xeXH4/0rKFdhhWu3QuWvqOSpwZw68M9hejBKaAZL9mwMOSw1mwWDaEnDD4ssnHzK/o2XkSi
 Sc72NAdq9VI5tPdK3+9/6GV/s56MH27YDZUoId3wAAAA=
X-Change-ID: 20261109-pro1x-display-pixelclock-8b00f09972fd
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Dang Huynh <dang.huynh@mainlining.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794173575; l=1490;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=Z1BQM/pf1WR+1Kl4QTU3Y+a6rdxjZnhPHpwNe7Jhyhw=;
 b=UK5ym6da1N3ikhvb16kUg2wQh779tDMoZuYealnE4vJzo9cep5u99nj6kD0nmPkqIkZfQ6S9A
 lvhg64ghIC3AVxgBlSfQbweDUVeaJIGGBrnN8mGyUMu4lr1GnAO31Lr
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
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

The driver has been using the wrong pixel clock ever since it's
submission.

The panel is 60Hz, but the mainline driver ran at 165268 Hz
which is 61Hz and the following formula can confirm this:
(1080 + 36 + 24 + 96) * (2160 + 16 + 1 + 15) * 61 / 1000

This causes the panel to show heavy signs of ghost touches, making
the display unusable for anything practical.

After the pixel clock is corrected, the display no longer show any
sign of ghost touches.

Fixes: a19125a28112 ("drm/panel: Add BOE BF060Y8M-AJ0 5.99" AMOLED panel driver")
Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
index 84c21c62a43e..b1f428e0808d 100644
--- a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
+++ b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
@@ -168,7 +168,7 @@ static int boe_bf060y8m_aj0_unprepare(struct drm_panel *panel)
 }
 
 static const struct drm_display_mode boe_bf060y8m_aj0_mode = {
-	.clock = 165268,
+	.clock = (1080 + 36 + 24 + 96) * (2160 + 16 + 1 + 15) * 60 / 1000,
 	.hdisplay = 1080,
 	.hsync_start = 1080 + 36,
 	.hsync_end = 1080 + 36 + 24,

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261109-pro1x-display-pixelclock-8b00f09972fd

Best regards,
--  
Dang Huynh <dang.huynh@mainlining.org>
