Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B19C606AA0D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wJMSpyVt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8151210F577;
	Tue, 27 Oct 2026 13:54:09 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDF0810F572
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:54:01 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso2666252f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793109240; x=1793714040; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=udMEtEpdximcj4tmN6XEoXZYcbf6JGtTIKRmg964qrM=;
 b=wJMSpyVt/qJQ3VldcVyWzoOFeg75xladJN/lR3msqkA11S8HddAw9uN4jQ92Yj0OkK
 uI6nY0K20YgXzVkDBmx9N54ohzynLg28MzJWXzFhP115jXeQsbkYnLBHdimJu1UpNF7L
 uyzKNiDj8/gd4Zkm6zHOACUZgbof9B0gBotansR3cv0SGCKDDxcelN/KpicaVjfzFT1S
 boE1b/36FlOTMWOQXq35f3O5psJGCMFwzj+hz3VG40SWdrxSKj6nbkhceCQiLh0Kz0iE
 KxcArclr5KajrESSLVPR3hjK1PDjwELZjNm6IqUBoLtHvvnSBCGFTUu9w1E47WLsyR0d
 yamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109240; x=1793714040;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=udMEtEpdximcj4tmN6XEoXZYcbf6JGtTIKRmg964qrM=;
 b=cJx94JFg5TDD26l3EHq3Ia5eDinlh3CZDkFNp0xc81kzEyjaBO5aAZVIhw1SA9LH+j
 9gjO0E0qrUQoS66v/Wwpq+cwXTVv4fv811MnuLq2YSDgxyD00Ovor779M/jONQNtuoEJ
 fsmk3iRuGm2MxCgO36MGw44xPvJbDqe3/Uz9NCv6QpYBwyVjAaH2OKLxuRqNcZ8a8Fxa
 +vHPnxCtq+vnQNP2CLAONHys1QXm/9UwxbHGQh+Y+yrsfD2N4l2bdO+anGUS8C0h9rVA
 fpYqBxA03yr8HmbaVei7fy6rrOF6BpQ3rswpNyxY9imGcSkNuvE7e0nHC5YB/Kthpz5b
 t50g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFf/l8GwLQ0yboWME9xSOwMz0g+kBX3dQ47c1+lmOrZKDhF/w8qUeuinAzjxH3JbgWtqoyy6CTthE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKMULtlqRjRTvpkbMVMIJyYVplrHsqqbbGmZ3Y6gwjS5IAnEJv/
 +JwqVUG2CazCL69mZA/mkKn/tnDacjiwCqt1C7Rh5TXCTNOSU9m7+GHT
X-Gm-Gg: AYBFou0w+gaHunoOduNxZSFSfff6+WZ0OiU+XF1Ph73XQ/1ltNulEv1hrek+BsmQBaB
 sABP0BjxJpHkh2voVcJ/dTDoKevgR2ePlfAJUBGAO1ZknYQCa3terCNjGcNvKygECZpSE7BlQqn
 moUCFhIn9Ld6rshO0XkdxXThJK1haBvu32L6KOb31k75SwtQulQbQdrLPOjyrO6RRH/0ELgvm6P
 ++QIBSlHOBm2DPOBgxuS6P0rb5j2JoEdYKRurTCCurV5iOCDUjQNB8MCqAA0s7C8Q4rGSQWYECW
 S+qQyoF1N9RRwisuaGAtcwxki/Xx5l42XKpy70h4Qkux7QXbkq/7HESt/dL98K/jADslmOJc8X4
 8zbgyKsLzniqt1BekYvj46WzT5uCYEugR0nULEdhg1EPAQCNJwrX7MBlI/9HOTB9eXUpVcmUuM7
 /GF6kgoVI/tT3dR7sA87VHvSx60l+tJovJX2hgz7VH1TCJeDPAJ6t1AwgT6PUV82PKA0m5iNjxm
 3PLPSK4wS4yQ/gurgLH4F/V/5eKGX2OWC6umsN8u9xwBJSjmjUGvxkv51yQOzY0bQiZn6TAOq1K
 fR9Fd/qNmU2MnZ43iKZIdPZOBcnU
X-Received: by 2002:a5d:5e8a:0:b0:48d:f56d:be56 with SMTP id
 ffacd0b85a97d-48e3eb7642cmr19483905f8f.13.1793109240024; 
 Tue, 27 Oct 2026 06:54:00 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:53:59 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
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
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/15] drm: docs: remove bootsplash from TODO
Date: Tue, 27 Oct 2026 14:53:33 +0100
Message-Id: <20261027135342.2003632-7-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261027135342.2003632-1-maximpedraza@gmail.com>
References: <20261027135342.2003632-1-maximpedraza@gmail.com>
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
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Francesco Valla <francesco@valla.it>

Now that a splash client exists, remove the bootsplash task from the
TODO list for the DRM subsystem.

Signed-off-by: Francesco Valla <francesco@valla.it>
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 Documentation/gpu/todo.rst | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index e6d36f8da086..5e987e18bfcd 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -756,23 +756,6 @@ See drivers/gpu/drm/amd/display/TODO for tasks.
 
 Contact: Harry Wentland, Alex Deucher
 
-Bootsplash
-==========
-
-There is support in place now for writing internal DRM clients making it
-possible to pick up the bootsplash work that was rejected because it was written
-for fbdev.
-
-- [v6,8/8] drm/client: Hack: Add bootsplash example
-  https://patchwork.freedesktop.org/patch/306579/
-
-- [RFC PATCH v2 00/13] Kernel based bootsplash
-  https://lore.kernel.org/r/20171213194755.3409-1-mstaudt@suse.de
-
-Contact: Sam Ravnborg
-
-Level: Advanced
-
 Brightness handling on devices with multiple internal panels
 ============================================================
 
-- 
2.39.5

