Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B71EC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B2410F428;
	Thu,  9 Jul 2026 07:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VfadeY82";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC4F489ECB
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:05:16 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2cc891373e0so25116275ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 08:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783436716; x=1784041516; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JGVhoJBTQ+C/shIBMcaZxxiUzHSDCbdKbDb/tDZozNo=;
 b=VfadeY82LzdOeXhmHEypRAiFTpoNBzxzV09S0+y3PMePaufKGgej+LPN70pAIA/GBK
 y/gpcNayX02ZoChkS+9kf9141nlw4yl+wZCHhSaZJh+l1UwzJfOyxKzua7erMH3U8RjR
 TyNsl9jDn3fHBTfzamW7NIhRKqDQvjrqSb2kls/4YL47Vpz1KlAXqMAkNKgPThF86yfR
 Q7474XItsbjSPekhKRkGeT+5y/qj8Fr9GOIPXmCiSx5xa8oTTON5fS577EYCG2LzCGSN
 v5ukftPOUW5w33tvUXoWlpHrjSky0EEUFBzn/nkvIozSfnRWq97ZkA5u960f20B7DUXs
 VkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783436716; x=1784041516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JGVhoJBTQ+C/shIBMcaZxxiUzHSDCbdKbDb/tDZozNo=;
 b=MYlJEFE1FgN7sBklAvKs24cBeG0+yCMz6Cv42jdSmnRixzWDb5KAeWuRB6fifoDvLp
 Q0FOFeMrHDI4Idep+PMNj52CXrC0ot/6nplf2FGH7T2nNwBSS0t09j2hEYYE3M1wvy7k
 bO/s2qsOXOkgh0GhUy0wvIBwDvsD/zjNmr5NpWcGWRr4avioCoh+P9Guu1x+NHEzjeLO
 XKuK6G7JAAs5h5qj1XYiPFq90dIH9fiL3yQ4pvkKzbxIgAg+puEZV3c0AgGRsRRvGGuL
 X7y2jv8Ije2mjwxMCD0VymqP4qYhuLXu+mlZa9ucF43xDRzWWMrIa9oK5aHhGio/pVE8
 6MBg==
X-Gm-Message-State: AOJu0YyleFgGnVuj3PiKCz0UVmoNWQ6SeAw8xAi4eflF99bidWd9m9Jk
 +vN7barJFvnzIrhKdmJWrJMdCuV4A+UGbFWZYwqhTKzwQk6HRH43plmV
X-Gm-Gg: AfdE7cnsMc8n34gyXttJ14PsFok24Vtijr12JZAIUqtBD200Fkl3VzVrP9RsOgHo0FB
 7c76Dvma1tZsASjwWk6LtcRXxul3lZPOigQroCBoHumOigZBp3BBgkLRJbK6lWhLz2KgMM9IvzJ
 XUxf+cBEtJaZdwWb4kN9kDRiPEtjSX44FZEXUWF7PsFhURuQv4in8onU1HRsnFYBP54F3vdasQ3
 MEf+LTHfOv7BrMG2UljLTrriI3coPoTk0jrpJq5M37r3NfCAj3QBheDrway9kfi9Z3ZSEd++e21
 pxhLd+ger48piLIrDEAvTEfEG+JKUaDLjLQLjnhCdTRZj13T8ZuReiZ06hGR/saHbZ2lNCWNajA
 9K+hxxKuHMvNBI2ji0ZropmDB0p5qS5JFPvBH0/jNlzMxh72XaGALMZLUPqjlmmHUuG6QMXNeVx
 rlbV2wwaeWyBGCoNGEprkv+fzXbo2YdZEgd3jd2ykplBU=
X-Received: by 2002:a17:902:ef44:b0:2c9:cf62:6f61 with SMTP id
 d9443c01a7336-2ccbe616252mr55602255ad.17.1783436715990; 
 Tue, 07 Jul 2026 08:05:15 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:239e:a31b:1d0d:374f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bc42sm13598865ad.63.2026.07.07.08.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:05:15 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: p.zabel@pengutronix.de, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, Frank.Li@nxp.com, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] drm/imx/ipuv3: Check CRTC state before freeing
Date: Tue,  7 Jul 2026 23:05:08 +0800
Message-ID: <20260707150508.2267884-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

imx_drm_crtc_reset() destroys the current CRTC state only when
crtc->state is non-NULL, but it always converts crtc->state to
struct imx_crtc_state and passes the result to kfree().

When reset is called without an existing state, container_of(NULL, ...)
does not produce NULL. Keep the imx state free in the same crtc->state
guard as the helper state destruction.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 8ed5dcf966dd ("drm/imx: Use __drm_atomic_helper_crtc_reset")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c
index 1405e50ee56b5..e4f0c91dc7610 100644
--- a/drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c
+++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c
@@ -111,10 +111,10 @@ static void imx_drm_crtc_reset(struct drm_crtc *crtc)
 {
 	struct imx_crtc_state *state;
 
-	if (crtc->state)
+	if (crtc->state) {
 		__drm_atomic_helper_crtc_destroy_state(crtc->state);
-
-	kfree(to_imx_crtc_state(crtc->state));
+		kfree(to_imx_crtc_state(crtc->state));
+	}
 	crtc->state = NULL;
 
 	state = kzalloc_obj(*state);
-- 
2.51.0

