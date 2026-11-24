Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B5606A336
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MJdDytRe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9205810E249;
	Tue, 24 Nov 2026 18:22:11 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A94E710E249
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 18:22:05 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb69f5b161so31712315e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795544524; x=1796149324; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UNWM0kxmEWnOWwACmt2LEHoYvhY3LG1h6QPQ7rX8clQ=;
 b=MJdDytRex59mt/tjGesM4+pai0v9a0UgPjn0GuEKU7VoQAeeyC1WU8BQXm9iLP4GYe
 WK8kvWifHTt7q3a6xf3TNiAghogv7EmO5pg/R7MohncokjQWT35ICPhEI2+pFgjNGPFV
 Bxgpwav8nv2k6ryn7qe5fxRAsKPagI8dYXq9UaHz+nHeWC6+IrWbJ5tVnqUOEiBv6/z6
 Eie75RcToFTo6Q/P3WYavUBrjWIPC65BwzCZxAiItd+RIt9WJoKGDqmsnn1t3RfOE7y3
 DWexDUZ7Gd9HOPgmj/KcJ5tJZ0QUEpiefBHJnbTn213Plv1vo5xrn/14O3ECna4NaqKm
 I+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795544524; x=1796149324;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UNWM0kxmEWnOWwACmt2LEHoYvhY3LG1h6QPQ7rX8clQ=;
 b=GV69sOpd1xlnguubR8bBaex3TnrO5UcpnDaAqEtNRMwhhb6uD73XtdlqfLavo5SgYf
 bI54c8AEZT+eD9VJ8ZOCV3G/ES+tWv7ZJUi/huxCu1QeKmpM+xMJPqN8kqD34Aya1LTD
 dH5YTcg+J2mEKJ+Av8KtKFx8Zrfzvzy07CmSjCAKG2YzW0GqxRMHVlVd7M70/Xkd5f45
 qch1zdtkuNcuCM+LH/JjVT3Kkda7TBdNLzuVJMfcvb9SB9cOmq2lT2Pe6fC0IuPpHWH5
 rF1DZ/7wKvhOBKGi9Y9BzeDEC9JQ8jSg0NsT/Esu54RvIkbgz9nT8a8w5GsLkbnuMPnU
 iO6Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHK/CCsyHUaaDdfQ3ziqIGcVYI/+ne5MyvseLvXY4/t8C9kEoO/WXxps69a/NQuWiUjWhPpF9KdgXg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/2ITXK664Lo0ZJhM9jSL4zeSZMCt2rN2y3ZbcKQxgTIIwm6X9f
 /7R/XLaXlCXU3uo9n0fFCjtfFN7qAqtdfEoOxVgNh8D7j4iCsISBT9v+
X-Gm-Gg: AZFdTZeXofq5yMNfVL6LS4qvyKyXL7x/HkqoHGrzdPC3nQHsqhzh/c2XPLCfroRKSZz
 6oStk5i/ctUeq2X2jThoZScNNraL403whiq/EuSm/62bLhavvnqrAjJQl3jcC2Xc0b+FTus8CQp
 4Nu9SmV8eN5T7OH5/KSX8vspJBxC3RGAzTcqVwRrAdOdSwAQYuSv/+0HLujr3Wo2lrnFF8Ly3/a
 UyCbVadJrujt0KaMGgRwZsQK6+7ufNdkXzBUEC4bb64hWJU547QSbwgkleQQ1e6Wp0rqEGgJZy/
 Q/q6xcC7JQv4la8+SjyMdlj01VIIou+CSQembP6tKEumY1oT5gYVc03k55WJhy3MUJPY7kG0x4H
 DUGRZ23hBRACGvqWTE9caFewr0a40nG+R1c0/DRLf26CeMxz0bWsilSRiHuBK6Yx7INBJ7Fnxj0
 RqEb7Ofl09RoSMuOw0/+uZ7UfzAHFTpROLNAFWMBG7Ual1ZblrzixYEt0HTxRe4BTb1/EmonZik
 PgY/7ghk35LNbKN5QNiqSlgncs6OrCoJoOlAX5GDZ49U/FBX1Z8NQWdWJRuEIHWi+oxoXS3fvTy
 EErhN5JgwUfIAC6U7IQn1mQwpsQFUR/f
X-Received: by 2002:a05:600c:3b88:b0:4a1:e672:5721 with SMTP id
 5b1f17b1804b1-4bb8880789dmr358586325e9.13.1795544523856; 
 Tue, 24 Nov 2026 10:22:03 -0800 (PST)
Received: from ArchOarora ([95.179.249.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f204sm34524117f8f.21.2026.11.24.10.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:22:03 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 jose.exposito89@gmail.com, Jonathan Corbet <corbet@lwn.net>,
 Harry Wentland <harry.wentland@amd.com>,
 Lucas De Marchi <demarchi@kernel.org>,
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com,
 victoria@system76.com, thomas.petazzoni@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>,
 llvm@lists.linux.dev
Subject: Re: [PATCH v6 13/43] drm/vkms: Add KUnit test for device lifecycle
Date: Tue, 24 Nov 2026 19:21:49 +0100
Message-ID: <awXRsQbfxPzFWHzw@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120-vkms-all-config-v6-13-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-13-78ace90f4fc1@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Louis,

Two problems.

.kunitconfig fails the config stage, so none of the four suites runs:

- DEBUG_SLAB and PAGE_POISONING_ZERO are gone (2a19be61a651, f289041ed4cf);
  PAGE_POISONING_NO_SANITY too (8f424750baaa), but it is =n and skipped.
- DEBUG_KMEMLEAK and DEBUG_OBJECTS* need DEBUG_KERNEL, unset in the UML base
  config.

The device name collides, 9 of 12 cases fail:

- vkms_config_default_create() uses DEFAULT_DEVICE_NAME, already taken by
  vkms_init(); device_add() fails with -EEXIST, vkms_create() returns
  -ENODEV.
- 12/12 with create_default_dev=0.

Tested at f046b77fa3e9, CONFIG_DRM_VKMS=m.

Thank you,
Oarora Etimis
