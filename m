Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA93CA5FE3
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 08:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E6AE10E644;
	Fri,  2 Oct 2026 08:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="MQGRQXc0";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9680710E65F
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 08:32:27 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912df756so55587135e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790929946; x=1791534746; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ys5uWke9XBV3Ke8D3pwy0Lwn7XKjGlruZIy2p0X3uuk=;
 b=MQGRQXc0ssRQFHaUPES2WGQuEiusRxvcRYaB8QHJS99++57gmvm3z/Os4/QPZQyJVp
 yyWDvhwtYMloV8wWRc2xUsHlarKKseDJtve5/JBXaddoa0aGLnJ5D2pvjOvDg6P1yKJ7
 FiDfRuELeoKBFMwcMfzT12mQcamUwuB8ql/x6rI1LFH20RTBsz3soT4cANvBbyFbPV10
 m/HMbe+ugLNKPC/dtvaMm14oKcOpmzGUECl9j7wJENK3Wxcwj9LfG5zAfAy+cr5u8DXV
 iDFoNDE5tRUNtpG2sxVgs/ur83J0LfhKAUizSYUmZjdf6Cjdyeu31gvm6Eu4tNlcS9+1
 AQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790929946; x=1791534746;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ys5uWke9XBV3Ke8D3pwy0Lwn7XKjGlruZIy2p0X3uuk=;
 b=SRaif3GqlP48Y+SbliFd3/fCceFukiC6cfAGG1udZg0j3mHA1O60nnShne2GUbTVSX
 rEWuho8orRPMojHAWmG+a+D7m7GJQeltz86p6bV+v4gcCmTWU4Kgsvl4W7yxfXMg7RwN
 mNDMPEUyf2iC5k7S9TXlXHQUeTxR0dD60Ad/oeuBc+kj5PaYxDlRQ37Oy14d0ANV6+do
 PkzNxrxaWrLh+AaZ+OKZ4G/1wAciYGKkE1oWvwBU7/c8V0JBgSRIVeFVq5Cx1Iu3GytF
 ltWw90FJb+5pvBbqpDyFeYPRCfMhaOghEc5sf8ipVEBLLDwjLrgrwPeu+Kh6KjbhHXZ5
 2YOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/AkqTUpnQYCXZzbHgVRUbtIfOr0UArj3AAwQpEFHMcGon0DUaWJqZxrzPsxpIwErupDDJU/BfGK0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mXpdGzlrxuzIPwtZOoBSe2/PdGqXSxUwZ63emKxDGnzPY1zFKf
 FY6Ju4V9P8PdGJxGHECzgJALeTC3lkW7wcEG0FvYc5yYyGHmLadOz4Kberl8FJqRQak=
X-Gm-Gg: AYBFou2uL8P4FC+f+D4yBpIiXusfHQ20T8ClWUod00iloH/tjyBLqS7U+SvrX+Aq3Xr
 /P91fx8YxBWvyJKLwe9Bnu/F1yHr8++0viKOpNuLrDOV4Vy1IyqeqnP6LMK3Lj6f3WODsUpmyv7
 OeekUKUN9gCb0xM1MSKHeEQuyqVTq60R5YjGX2evOWz391t7rtSacSn3hEYh2q58PZpXyOT3Srj
 X2b3PYcgxwWNMmLXDFoO7u54PWik+c8qjuRSaO8YI0d7cuSTF9Loxj4hd9TKKCuIChZ9sB5fl39
 InBv7hk1nPUiYMZXOJbwuneMjwSIHF+M99ZN6VqD55awK8lM62mQsviSYyss2KCRXtlvUdKPJ0O
 E6fpDX2hL+niDxZmQWCwFA/GJoSA96OPIHS3b6CrKjMk2UGe8B0hgz1zOjoIbjdcRZU1ST0+GZY
 jMJ0N9mkbHRCWdt4UynS0Timdp37maJJuGxyHagKOh2FVYJFi/LI69BTaqa+IudrwmxBM=
X-Received: by 2002:a05:600c:4307:b0:4a0:b6:4619 with SMTP id
 5b1f17b1804b1-4a0274569f9mr25694905e9.0.1790929945843; 
 Fri, 02 Oct 2026 01:32:25 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03feed16bsm42507905e9.4.2026.10.02.01.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 01:32:25 -0700 (PDT)
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
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] module: Remove obsolete __MODULE_STRING()
Date: Fri,  2 Oct 2026 10:31:03 +0200
Message-ID: <20261002-module-string-v2-3-fc7438acaf4d@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
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
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/module.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index f6f90cd88f15..37de77340032 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -896,10 +896,6 @@ extern const struct kobj_type module_ktype;
 
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
