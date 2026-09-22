Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D94BC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9BBA10E714;
	Tue, 22 Sep 2026 13:33:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Gdg4ce0Y";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACFE510E4DC
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 13:33:45 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so24105635e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790084024; x=1790688824; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ezI6opJL+TJWnK9b0Jz6azXtBu0v4XKOZOc9c416xu4=;
 b=Gdg4ce0YjKs/DEXawZILsps3/8DtHDpDFvcCmUAVyjnY0ZWwzKG2roQGRv1uFxWxi7
 3rPQCSSiVPR4iubtc/twTn1+qjVKCSJSd/RErYSEZ29whhwt0e7ZlpF7QUbxKHprN84w
 AnbuOkNOZXIUHDipe0LM0uMVf3dg7x83K6OwusK0L8PunhzPYbBe5ZF0AhU+8V/WBZHW
 +pX4RdkJUBPbgXRAlNFE8bRgQ2e5BGzRCceL6qGT5eHI0XI72pOOewV1q11lfUSZr/8f
 uVFsijiysnC/gAgACXckwM0Fwu9ifZ9MZ7uv0mhsUO6rPkLXWmrl1fz59Eyq5Ywv3OKM
 zNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790084024; x=1790688824;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ezI6opJL+TJWnK9b0Jz6azXtBu0v4XKOZOc9c416xu4=;
 b=FLgC+6m6KXwrd7yKw0pw6GsaaXii+5ykhE8jAFbjGM3FjdYf6p+Rlss5JlcEqjNyLE
 GfokBL4PDjjQ5jLCEoSmwD6MvSILhQogTvBlPPBwXPb/jBpYc92RVJNdc3U1R1zOM/yN
 5vOnUHwCGNtMMgwk3hp5RD9wY0QdqU2xgdWL8nIrc+UwtFrlztw1RPJ7WOBwdWQ+dLJ9
 AQRRMCnMtTizWwF5D4HJAplt3v/eOLiMe4doVyViNpRTioUi+IP9DiBO/C+68Y/irXe3
 1m3wxJZRJq7GV1RL9mfKxz/HEPk1Sl/bzSZ1wMCRJ+jBWNjWbNwrLazGcqLAYxeXk+eA
 4VkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6E6umiH7+VF9+j6LCgIn+1j0jPsEB0zUUlNk/+DmQVEol76vv6LrysOJ8rOLKn99WCetl4pna6RM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kt5Fe3ar+kNiaOvhyxYxfILG9S5Gdh08yuTsI3GmjG7dWij6Pg
 AcwUVHe7rBN9IBVP8dpk03qENsqp+wkGHaulFPYuapEA/BbY6+pFpaEJJ/KWGkvlL2c=
X-Gm-Gg: AYBFou2jVMLGYf7+ebTPLosNxym4QR9Sn5igNntOm7K2u2/vW/HqkrMixySrUGMQMdg
 5s6xyZ1kdqR1+sIwr71+w31AUTqRbiSFd7Cb0mX71pK3i+rCTnDpeBrqTBf4haCdeYH/zSgJfWt
 B8NO3wM+Py5jsA3vroL7Q6EBr9vlfaQW7p5Jd/aS4Yt1kwm0iodZJnwS5WDWCGWvvBx8JIRzSw6
 NOjkb8CTA9lwYhclVblxBAlrkKWyEeBi0fjE3zspQuF4P2ONJMwv6zBohp2KzIAogJkAdp+/NBS
 yHVMssPktBHDE8pc7V23NgtC3ANtWT9AdD0QP1BPzWnyBMBIznI9rh5QPebR34zrWDYwwd5J9Pf
 KQ8dtbRtOSgo8d/hvcklqnAKOCZ3G9NKO+ixUt1mk3+oMxyJm83M0TpYzQeBi6O+jbyPJY9bfim
 L8zYKThCoNTin83ZxFTdoIRhyZxbAy2EWegcb2o4SMleG2FXrfWFAVry2usXbZfZhZ98mJ0hWxl
 epM8m6evomB26hWnftQGNwtRz6R/eNTXsvDjfOglXnGmqzSDrECRMFcAhuvl7pvwp18PbA=
X-Received: by 2002:a05:600c:81c8:b0:49c:fc6c:be08 with SMTP id
 5b1f17b1804b1-49fc58581bfmr184348345e9.31.1790084023989; 
 Tue, 22 Sep 2026 06:33:43 -0700 (PDT)
Received: from zovi.suse.cz
 (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz.
 [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdace76e8sm70243845e9.1.2026.09.22.06.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 06:33:43 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rudolf Marek <r.marek@assembler.cz>,
 Andi Shyti <andi.shyti@kernel.org>, Chris Snook <chris.snook@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] module: Remove obsolete __MODULE_STRING()
Date: Tue, 22 Sep 2026 15:32:23 +0200
Message-ID: <20260922-module-string-v1-3-c18766690185@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922-module-string-v1-0-c18766690185@suse.com>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

__MODULE_STRING() has been an alias for __stringify() since "[PATCH]
MODULE_PARM support for older modules" [1] in 2002-12. That change also
moved it to the graveyard section at the end of linux/module.h

Remove __MODULE_STRING() now that all remaining uses have been replaced
directly with __stringify().

Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..0d9157a2d487 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -886,10 +886,6 @@ extern const struct kobj_type module_ktype;
 
 #define symbol_request(x) try_then_request_module(symbol_get(x), "symbol:" #x)
 
-/* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
-
-#define __MODULE_STRING(x) __stringify(x)
-
 #ifdef CONFIG_GENERIC_BUG
 void module_bug_finalize(const Elf_Ehdr *, const Elf_Shdr *,
 			 struct module *);

-- 
2.55.0
