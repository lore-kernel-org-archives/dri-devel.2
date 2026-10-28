Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B25D606A331
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=J+++zcBe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF8AD10F940;
	Wed, 28 Oct 2026 02:08:25 +0000 (UTC)
X-Greylist: delayed 364 seconds by postgrey-1.36 at gabe;
 Wed, 28 Oct 2026 02:08:19 UTC
Received: from mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 296E410F953
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 02:08:19 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=1VmNsjXZ33fxd9I6qk4WqjAifQMRdQQI9ROACXEeoFk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793153297; v=1; x=1793758097;
 b=J+++zcBe3ZS3mrN/nb326p3H0kFSArZJS0betLT3BL8fIzzX8hDIM5P6uylbDI18mPGaLkhQ
 Nm34nFEpKrzDJt0wbSPKAvVNMNRzZyIvW1uvHwX9Y2B++w/L+bqVyNGrYVGbsioOeG0ig8JXhDl
 9G9PVVYOD9XRGse2gDYX+TQM=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id ccf0161f9d1d6e92;
 Wed, 28 Oct 2026 02:02:13 +0000
X-Mizu-Trace-ID: ccf0161f9d1d6e92
X-Migadu-Flow: FLOW_OUT
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>
Cc: Teguh Sobirin <teguh@sobir.in>, Jessica Zhang <jesszhan0024@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH] drm/panel: chipwealth-ch13726a: Fix dark grays rendering
 green at 120 Hz
Date: Tue, 27 Oct 2026 19:01:47 -0700
Message-ID: <20261028020147.2014466-1-matthew.schwartz@linux.dev>
X-Mailer: git-send-email 2.56.0
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The init sequence writes 0xf0 0x50 followed by 0xb9 0x00. The panel
configuration in the Thor's stock Android firmware (decompiled from its
devicetree overlay, dtbo.img) has two runtime command sequences that
differ only in the 0xb9 value, both "display off; f0 50; b9 xx; display
on":

  qcom,mdss-dsi-ram-command:        b9 11
  qcom,mdss-dsi-bypass-ram-command: b9 00

With 0x00, in the 120 Hz mode, a full-screen gray ramp from black to
white, shown with identity color management, renders black as green and
the darkest grays as bright green, both at maximum and at reduced
brightness, and the tint is more noticeable at lower brightness. The
60 Hz mode renders it correctly. With 0x11 the ramp renders correctly in
both modes and the panel dims without a color shift.

Use 0x11, the value from the vendor's ram-command sequence, instead.

Fixes: 3ee01b8647b5 ("drm/panel: Add panel driver for ChipWealth CH13726A based panels")
Reported-by: Aaron Kling <webgeek1234@gmail.com>
Link: https://lore.kernel.org/all/20260727-ch13726a-washout-v1-1-bf869ddfc5cf@gmail.com/
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
Aaron, this should be the 120 Hz issue from your washout patch; could
you give it a try on your Thor? I found the issue here separately and
saw your patch as I was prepping for submission, and I bet I was seeing
the same bug you originally saw.

 drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
index 562dc573528d..0832e49b77a9 100644
--- a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
+++ b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
@@ -65,7 +65,8 @@ static int ch13726a_on(struct ch13726a_panel *ctx)
 	ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
 	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x50);
-	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb9, 0x00);
+	/* 0x00 (the vendor "bypass ram" sequence) renders near-black as green */
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb9, 0x11);
 
 	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 

base-commit: 8ef66514d7b993c9fb96a5886f001e3556610c1c
-- 
2.56.0

