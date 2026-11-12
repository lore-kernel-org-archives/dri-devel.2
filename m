Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D5C606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OjdkFdOk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 871BE1120E6;
	Thu, 12 Nov 2026 12:55:15 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD3910E529
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 09:16:36 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-491971ac844so3726429f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 01:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794474994; x=1795079794; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/ISXSUud5nnZTeoARXc9x7rvwZr7jLkEkQ/w2JWbdys=;
 b=OjdkFdOkwmd7tEuvRm8ZfcH/SART3JpxxBcSVlh4ed/zrNxU64FgJzKR2iYH68CZJi
 HhKmfFMcbag4RH4D+iBqbxYgyjac0m1rAOZPEeWzdAOBfRWD/lmojpobhWk8pQMUT3tQ
 KjDuG8WClDUIlMjhyhpN/28IzavzR3doG5m7JVx+mOf4D7r9EPjaXA2vOuzqGp+luhRs
 ZqHQ/Lg46CV6SI7bL1MT0/rOcpVz7QlLvl+doAXAKuaiYMlzWzSb/cjwvdxZmbb28UDp
 fn0/+74yqD4XE7W9sARekAbK0AlljLc9s0jPptJcIvdfWsxLhi2NwMuYvoVI7efXWo3X
 Un0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794474994; x=1795079794;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/ISXSUud5nnZTeoARXc9x7rvwZr7jLkEkQ/w2JWbdys=;
 b=JJQCAWdiim8jPqcmlZt6NEdsoA3A87dPiPVdiPt1D8Hu4lZHolsplxvjcMesEDwWN0
 7+5bz0AGFqfEPQKXBWgijE4cbXMTz/HH1U2JBbJSQtdpHq0j9Yff2g65JQogYZ/OvZIA
 ywXCSLggIt0MD+b7fzQrXEXEuOgXLXrWcL4Ywu+oEx0XN19jqFNLPra28/L2V9iFltJK
 WqVWQeygZ3xt0jxbjbDD3h6XRRXno/WUWJmkHpoi/3m+74cluAzSAT/zKXzJrawiajgl
 1K0OyIxKqwqUv+jZLg/4OtkRUv657GaFVQebLr0zv7uHjuz7H3veRPkhjP3WxTmFS7RA
 TJvg==
X-Forwarded-Encrypted: i=1;
 AL+hErER2psnBIljF6JAw38W/Osv7S17zs6YbBJ4QPwB6DGT7aBFy8SXExMtkwkuoYXaB3sCkK3R23ME4oI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9pjgB7iTDbPRhyIq43AJjYkuTYHpfLHKxp5OyEpFmG0WEA3Kck
 yHXne8ViG31zZ9kKBoMoQyIm5fE5YdFjk4taKPmOxWIVuqhmeP74Jvd+
X-Gm-Gg: AYBFou1rNqycmIqxP0NmLC1OeywVdugiFAr4jlH/CqzXgYqYBtxbQQV2pAi0Abp47rE
 mwHPOBvtZW95pC68vWCIffq5d5Dg9MwDnCNTH2+3/jZ5ko4OXfTjCVPsonowPcuCmpp4zHFLwW6
 UPPhQw/reBwEk0yan4bCYKjWLVpDClPC1x36B32+hZi1pyMZQcerQS262RS3/niOHL/R8r7Wq91
 5Yzcjg4k3Sk2IzIaZBj52pD0BZZF+l/JGqac+bwuRcc10wDQ/bNLYgMEFsJ0hCfB3D4fuKfdH57
 yt3PeekJmWL+oHqeC685yP/fbTEODo7HmZ8I3DadWZxGgNSa4sP8tPKYmyxv5oxQDkxUlJV1RqE
 HZ//b8BVgHibeSVcYSBaa/MH6ts1eErJqWjm6lK2wkspaXOo49YwUgQXJh+Jj8MJuzwOvxoHXWs
 mRAetknJVV2RgurOvqC2ShDWSFQQcC1U7X1gWmvtad0tJ0raLRL8kvDJCIPGHI5PRJ+oFZHnvrT
 yWbCqmxOic5zLP2X/RYMwBxJOT/MtsLZ5YYACrtOZ8huSOLnj1Smcs2Sf+XB525+HtKgDadNYXu
 IJY6OOk0lfil38iNSrItCI5eBPZjiIXcU8jzx4JpcL7CKDlnPtah
X-Received: by 2002:a05:600c:1c01:b0:4b0:bc65:b9b5 with SMTP id
 5b1f17b1804b1-4ba09395574mr104476985e9.35.1794474994123; 
 Thu, 12 Nov 2026 01:16:34 -0800 (PST)
Received: from angelo-Precision-7550 ([94.154.175.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e252f7fsm61497235e9.2.2026.11.12.01.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 01:16:33 -0800 (PST)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH] drm/fb-helper: flush damage before unblanking
Date: Thu, 12 Nov 2026 10:16:30 +0100
Message-ID: <20261112091630.3947184-1-angelo.compagnucci@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:55:13 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With a shadow buffer and deferred I/O, what userspace draws in fbdev
reaches the DRM framebuffer only once the deferred I/O work and then the
damage work have run. Unblanking turns the display on with the
framebuffer as it is: a program drawing its first picture and then
unblanking, such as a boot splash taking over the picture a bootloader
left on a panel, shows the previous framebuffer contents for a moment.

Seen on an Arietta G25 with an ILI9341 panel (tinydrm ili9341): enabling
the pipe sends the whole framebuffer to the panel, still black, and the
splash only replaces it once the damage work runs, a visible flicker.

On unblank, flush the deferred I/O and the damage work first.

Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 drivers/gpu/drm/clients/drm_fbdev_helper.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/clients/drm_fbdev_helper.c b/drivers/gpu/drm/clients/drm_fbdev_helper.c
index 415764ee086a..5c584dee3e55 100644
--- a/drivers/gpu/drm/clients/drm_fbdev_helper.c
+++ b/drivers/gpu/drm/clients/drm_fbdev_helper.c
@@ -150,6 +150,22 @@ static void drm_fb_helper_dpms(struct fb_info *info, int dpms_mode)
 	mutex_unlock(&fb_helper->lock);
 }
 
+/*
+ * Turning a display on sends it the framebuffer: first get there what was
+ * drawn in fbdev, still pending in deferred I/O or damage handling, else the
+ * display shows the framebuffer as it was before for a moment.
+ */
+static void drm_fb_helper_flush_damage(struct fb_info *info)
+{
+	struct drm_fb_helper *helper = info->par;
+
+#ifdef CONFIG_FB_DEFERRED_IO
+	if (info->fbdefio)
+		flush_delayed_work(&info->deferred_work);
+#endif
+	flush_work(&helper->damage_work);
+}
+
 /**
  * drm_fb_helper_blank - implementation for &fb_ops.fb_blank
  * @blank: desired blanking state
@@ -163,6 +179,7 @@ int drm_fb_helper_blank(int blank, struct fb_info *info)
 	switch (blank) {
 	/* Display: On; HSync: On, VSync: On */
 	case FB_BLANK_UNBLANK:
+		drm_fb_helper_flush_damage(info);
 		drm_fb_helper_dpms(info, DRM_MODE_DPMS_ON);
 		break;
 	/* Display: Off; HSync: On, VSync: On */
-- 
2.53.0

