Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86C4CC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:33:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0993F10F67A;
	Tue, 13 Oct 2026 09:32:59 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA4610F695
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:32:52 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so1588315f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 02:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791883970; x=1792488770; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NZQM6qPjUipP3twsEWuLikKTTxPNmXURRnws6p/YBzA=;
 b=kejupLqxqms829ZbGYIzko7LmUWggqN+pWViDTQY0c3PeBVa1EpcWM67DmAsrDAoHO
 jOdk6wsFrskAfT3OQ5UQ3rUtTOEfvVFLJddsGZw7DhJ+VKqeNmVWwBYgye9fo6Pb2gBp
 R0Xcio6Oo0yPLFX5SQjOjUrBo5N+3xQYEp5nBoPs4Pog0EJzAikJhZjKWmsWTshQhL0J
 AXEgSx8Klbw9iDDavZ9CahXtId0Ep9KbyN+EvxoDNLWsSiOJaYM0PDCHhlBx47Y6ebTi
 quU3jtjc9dUvQ02zRXZzlZGVrHrNygyECTOKaGrLoUHc0MUNqBW2KO3/MZkludnniE/t
 /GdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791883970; x=1792488770;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NZQM6qPjUipP3twsEWuLikKTTxPNmXURRnws6p/YBzA=;
 b=JyFgzfER9dbrXPLEYvNBeCzNEz7TUq5jlmgMbTfr8wlvY09U2gQHP8b4a5NOyQRIi3
 jbQDWr+n0Ls3/rxuoZVntlt8NZSYa0QkduMyR5rjIJorNhlZvf+byS80RyqG4vMzJ2A1
 IFtbA0PX3qWz7WmlkFwRk0XEBcWWSsRiJQgIpj6w6WKD7dNV0d+VUM/r4mZxVc0yfMN9
 Ll9v/Pi4dGc4TD3brEf0cY5RvlRwiBwVPY9P1JovL/KAdSv+A5njktVizM2VedYKcvsT
 wkH9mOBZPtYHwLxucuixsFK1QnWeCfHgUlvfaM1eyuechHyiQXX0jcUjd4CTQKxntH8I
 TqwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmoFUIllRfbpB2gdEVM8mwragjFgjSsWZuXs9v+BE3k/jv8q7xBXgi8vbpi3zY+O7QJr7BEDDliAM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJPe+IQ9h3RHRW1wpj8tXSrcpL4BYiv/RzHrd77kBXArzSrYhYn
 xKZMXlszYDlLeU3Pt6GDhOqEeRYVbyl59Sk+01Ivj09A1SMdlhhFanew
X-Gm-Gg: AYBFou0JW8+qizhG8JqHCbQssOCNo2R+vL7KBl653X0+5qQBnkE1mTh8lQZNr4gg92n
 oVqwjDiwSIV5OtGzTM7raSpC2gy7MSWTnrcU1zKrveRQ+X94/nZoXvGR9HEXSjGDbjMMD6zusu+
 hArabA9MbESbkqYJpCrHlHLEOHSFQm7/ysU+apy2xLkH/sdYOMRXw0x4/59pnf7IvIOq0BJGTrI
 xoZ3/wDM8Z585NXsakBGH93ZBNtmkheY/rOAC83XfcKFg92beGfCEsxQ7NDeycYfDNfUs4aSGlQ
 brTEmgSeuphIwJ63ULV8VKhQB4walOY2IlD8O7QSUdTbCoWMZQCel6p3M+vB3CP6eGSriLaNRYa
 guzsskG5KmH4Ixi7zS6ECrXwnLlMGlhT6EkWKlo6utORo714Z2ompc377bKCPkBWyKDP0mHI9zv
 phQet7b98AenbABNwThZRkWoS4GdI3R4ks4XA8ogfz8U0tlKYsSzBff/QmEd68GT3+cvlFPOaOY
 9z1okaK7zEAcOt/vOHE0mUt92Nz/Qw0w0g=
X-Received: by 2002:adf:d002:0:b0:48a:f11a:c34a with SMTP id
 ffacd0b85a97d-48dbaaecf8fmr18349529f8f.52.1791883970450; 
 Tue, 13 Oct 2026 02:32:50 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc4ec6sm3986774f8f.48.2026.10.13.02.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 02:32:50 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Francesco Valla <francesco@valla.it>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/13] drm/clients: Kconfig: indent DRM_CLIENT_DEFAULT with
 tabs
Date: Tue, 13 Oct 2026 11:32:31 +0200
Message-Id: <20261013093243.505776-2-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261013093243.505776-1-maximpedraza@gmail.com>
References: <20261013093243.505776-1-maximpedraza@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The body of DRM_CLIENT_DEFAULT is indented with spaces, unlike every
other entry in the file. Use tabs, so that the next client added to the
list does not have to pick one or the other.

No functional change.

Assisted-by: Claude:claude-opus-5-5
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

