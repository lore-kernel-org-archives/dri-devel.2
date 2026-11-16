Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9414C606A31F
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uHrtWwae
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F374A10E1A4;
	Sun, 15 Nov 2026 23:22:24 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2893610E088
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 23:22:06 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso30651865e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 15:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794784924; x=1795389724; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2M6HoHkTeVcJIWfMAzqJ94aeV/R3TSw3Z3JZl8kxSXI=;
 b=uHrtWwaeSEwLamUOdKgJlQY47CSPpE1N/Zua/AXJSXUKNs8WvX1ky8wy40Rb2jWZT/
 O1z0am3Hat03r24NWMEaHrnwz3um6ZFf3ZKTqwsI6qsmwBno1MDAXLKpSGvz+Y1IOH6Z
 byD+eF+SDZOqGw2KH9jygx1F3fwJhy8XvtP+MlibQwkPmfXBErj51ipDmaULIRwv5KAr
 tQtfeGT4IPFjM0rpImix0lUh0JEDaQJAe5LaSWLcINaFbtw9lYXaHwC0SfUcpkGT+dlb
 KjnAdbUiEST9gHuDBci8XfsvrTy2tNvA6OFBLvt7GjYvNRkM+YD3S1v9BfMklXOCMLO3
 rdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794784924; x=1795389724;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2M6HoHkTeVcJIWfMAzqJ94aeV/R3TSw3Z3JZl8kxSXI=;
 b=z/bmDSXGL/bkHbTzhcmiY4EsvrsdqBdphPEqankPtKIbYoLrhx1Ct2+UKzZfgq+C7H
 Ke1Ms3W6yAcSJKDUZhKRh4aD57n4Nuxsy1nE2HR7hKeCgQ+NbyTLPD4FWeyC42YIgqbD
 q9kr6wfH4ywGX/o63QhMj5+4oqzzPHa6N02KhQ7ziuzRjHvcVFnYLWp0zJKQ4m45gM39
 fokHICR3P5SE3DsBxK5mVfS2hkPUSdIvLnrSmGLl3RZawgDbeApi3N00HgYWw8vZAG+W
 WBrbCsBfhiHyJR62EFUN/Y4M33D6GoZrvvL+MSuJYRD0KpdDYLMU8RGTgiIDCWaKmiZD
 P88Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHdnEWlDiy0XuHhKdQIpEt0R0xUiDvgaYuyZ1ZEVdjEalbcUTLtv0vHlafEpA36uilvcTkvRYz91Sc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8NUineVi/fuC8Y4ROxOTYNqg951nEZsFtb3S64Z7tuKapKszIx
 jb98b3nUhoX2qbhsFcSxttekxtpNRJVvWB36mb09gudIj003Ru2tbGAf
X-Gm-Gg: AYBFou0xV6/0wN1Zhc8wqbKAWIBTndjz6gb38M5pmKLrJ8lDMnWzMQfEZZ63hqS8LPh
 NVgSd9ry0L1RQFqov80+0VIbe4zr5uS8YiFdzFCSJ9FzRehsRd/giUxHVmuSPGiddQGArUK5RHW
 7aMffWejEfcrAbVad2cZCg84jwhETUftq09P8hOq+nXtME7xxRT9kP0W2jeDZZm618M2YMfyYCV
 RCPt/EZ4+pjdxAPOYhyGCakFd3Qq3NkAGgxLaeJHgMvrnWeYlDrc/7fFvjrrcwCh6lu+KSgIBOP
 GvnQPBYAyYMlgBPTjz3Qf6iOi55yg/kHTm/itFA7SBuIvBczRamdOUIX4ZhHZdzlsjTWEgF07DG
 ZmeMlZelsbWwEHzn1z5wplHpvcAT0KHMuWsz2475PK7Ef1oSECSbCPCq1Av4zSg2OD9VQna10Vh
 O7nUc9lh+IAscAA73xgvFXNESln7F8aA3SxHLm8cjL0ntyCrUGdBkG6sywi9KAF9f3zhLnuw87/
 +bzuSnLSctNt8+5DcvaWmSlmhfD3Fdtwv9XbVc/zbzad0v3spWcsmL4gsfhEzDOBa8uDBhT0IKy
 L/eW4gpwsxmdAv0QC79D98nTV9bj9Zpi9EKfDrh7qKSK6TdZko9JLxo=
X-Received: by 2002:a05:600c:482:b0:4a5:75d2:c104 with SMTP id
 5b1f17b1804b1-4bb55a59c9dmr137490185e9.22.1794784924398; 
 Sun, 15 Nov 2026 15:22:04 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571f976esm127920955e9.3.2026.11.15.15.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 15:22:04 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>,
 Peter Jones <pjones@redhat.com>
Cc: Francesco Valla <francesco@valla.it>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-efi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/6] drm/clients: Kconfig: indent DRM_CLIENT_DEFAULT with
 tabs
Date: Mon, 16 Nov 2026 01:21:51 +0100
Message-Id: <20261116002156.1027726-2-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261116002156.1027726-1-maximpedraza@gmail.com>
References: <20261116002156.1027726-1-maximpedraza@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The body of DRM_CLIENT_DEFAULT is indented with spaces, unlike every
other entry in the file. Use tabs, so that the next client added to the
list does not have to pick one or the other.

No functional change.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/clients/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/clients/Kconfig b/drivers/gpu/drm/clients/Kconfig
index 6096c623d9d5..8d8bc37ec9f2 100644
--- a/drivers/gpu/drm/clients/Kconfig
+++ b/drivers/gpu/drm/clients/Kconfig
@@ -114,10 +114,10 @@ config DRM_CLIENT_DEFAULT_LOG
 endchoice
 
 config DRM_CLIENT_DEFAULT
-       string
-       depends on DRM_CLIENT
-       default "fbdev" if DRM_CLIENT_DEFAULT_FBDEV
-       default "log" if DRM_CLIENT_DEFAULT_LOG
-       default ""
+	string
+	depends on DRM_CLIENT
+	default "fbdev" if DRM_CLIENT_DEFAULT_FBDEV
+	default "log" if DRM_CLIENT_DEFAULT_LOG
+	default ""
 
 endmenu
-- 
2.39.5

