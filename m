Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C62606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZGOHnORA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A293D10F823;
	Tue, 20 Oct 2026 22:50:36 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AECE10F816
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 22:50:21 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so703645e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 15:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792536620; x=1793141420; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RGix8b+4rEGPx1vlWyRM//jxrhYNPw7VId0i+fn4vP0=;
 b=ZGOHnORANLihkYSIx9yMPAgFlOdxAj+PyU5cYsbwF0D7kq9qhU3XCuZWJs0cHbzf30
 ojJXA97Mps1GWRMU9x20vtyyqxNNvQ7TW/uNOPhWsRX9erNraeSk8M++k69Sla7Dd6lF
 qXIOjAfZgnFljK/Mz/UMqSAoCFsUXx/WmeQGHh1IxglYc/wsAF1Is/9x55qwSM3bnIXE
 VvqxWDEq/7HFeegH3q5saWXkENPM7vYu0Cx2J1CIu0EGlnJr1TK03cpLVaaweUv83Uz9
 sIL0d+r7kD6orVdOIT5LFFLvmqQ5h1E6nsii5QAsfoOgWy1nYYPAImRtLrlY83nmkPfg
 BqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792536620; x=1793141420;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RGix8b+4rEGPx1vlWyRM//jxrhYNPw7VId0i+fn4vP0=;
 b=x1Ib34Sxe+BK5A/1VrZ96zZcmPAEOBjmlkUViQnFpqZ1QjTQxyDEvvgX3YUzM7Kx3H
 3TjKIv71MftX08A++IiivSZBUEk33T2uspao6IL74AQkOr/eUzLAR30Nd3D1K7f2QjKO
 auw6z5t55WM1auGjGC55wGfgdkLlq10uATxp+0kcRgN/hTy2P09QUR4X9P6iYBgXvkgp
 U1eBrnOK20XItqtUDX0rexWqs1CXePbdhAdMRC3aBZghOvAeS4FpT8SvIBw5J4yyj+GA
 E0WC+vrgY1Xv+RgRcDynK4muqwwrJ8+CwmwmPHDo5jYMS/0DLjKdT+QsrAQNbL64NL8R
 5lfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBziWSMRGZDJ4BX//0nLFHlOqrz0DxK7lEAxmafCP8+COSycSMGvyzrpJN/vk1ubD29nNToOGLu/3OQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK+nSpmXbYPozlG5qOZLSP2lIEcGdI9BPlvjUSa52afv1mOrQLu
 8uQ4b6pJeMigitqDulsk1NUhxzGIw9qu1SyC1aHVxRx9RIbtXmlieBtw
X-Gm-Gg: AYBFou2/ASfBmO6C8HyknD7nB6Ws8jMVbNtg9pbzpwK7ehts63GHiO8+T4DXOfFFF9s
 wWKYwv9j6UbTpDXITA75qRf1K2urQcwasu4Oc86ZrJ4zc7eNKhBh70CxXrhmW1NhobDx5GU5Q5f
 dbOPEgecQvxYUum+xzHm1+CAJ/1VyXYZdLGgjBKnbJ2nfMGl1GpZpS0+AtDjXY+mI4GRe4RUhUs
 emBU6/z4GjUQxD0HLZW8eXV2i575dqnxngAEKoebm5v3hM33V1uekof++oVKFL+8iW4kyRzrpuK
 IJ915xJqmr0LBsIA9x0rZfuhB40+7vKJbKTyJu1p5RJNi0FLjtw0wh56JIpu102dOstPcoLH5Qi
 N5AtYup+L7hvajKuL51w2/MBQN6U/uijSKXLUuyV9D9CJt8mWM4dpxLG01bHcNML7T8HQ0hhEDa
 rmOd2nkYEDtSDrKTNRs+ZgHmIa8ISt8SJ5NfJ3Ke1sYUsVWRXI7bs10XKa2hVUYAM2zFWEwfqQR
 518hTW88Qd2gb2Q9NwXqw2lsA==
X-Received: by 2002:a05:600c:3b01:b0:4a1:7c7d:8881 with SMTP id
 5b1f17b1804b1-4a1fdb04f88mr2783945e9.13.1792536619814; 
 Tue, 20 Oct 2026 15:50:19 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc0b42bdsm17511805e9.0.2026.10.20.15.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 15:50:19 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Francesco Valla <francesco@valla.it>,
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
Subject: Re: [PATCH v5 10/13] drm/client: splash: take the background colour
 from the image source
Date: Wed, 21 Oct 2026 02:50:05 +0200
Message-Id: <20261021005006.2341200-6-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <ad6a04b7-cf57-4b22-9c22-85a61af29f1f@suse.de>
References: <20261013093243.505776-1-maximpedraza@gmail.com>
 <20261013093243.505776-11-maximpedraza@gmail.com>
 <ad6a04b7-cf57-4b22-9c22-85a61af29f1f@suse.de>
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Thomas,

Am 20.10.26 um 13:19 schrieb Thomas Zimmermann:
> Please see my earlier comment in module parameters.

I answered on patch 3: I would like to keep splash_color as an override
for one boot, for a bootloader that wants to show a boot state, with
the default from Kconfig or the device tree. If you still prefer none,
v6 takes the colour from the node or from Kconfig only.

Best regards,
Màxim
