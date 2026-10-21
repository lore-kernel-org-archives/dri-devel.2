Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33D0606A320
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kSuQbOsJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42FD610F7F3;
	Tue, 20 Oct 2026 22:50:36 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E8210F809
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 22:50:19 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so680945e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 15:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792536618; x=1793141418; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4zL0S6kvmtkQoYmoWRmufP9rJujsnjUqprK46hj2fn0=;
 b=kSuQbOsJ4anyXrrGqwT6jgdKMSqyIrIEVLzlPEBoUYW1ouMLBwLLazi5kE+FDxaRnr
 AJU34HBXvoFtdwhN4XtLw+nLGKEwNa34Te0mHuNeQbuOtvuCmLg/xABlgC/18DdXK8Kt
 991SN3IlUpZwmNcZEm6/+HFSu5/0b9Y/+7OfLJhWDs7qoQ1cNiufq8enaFFC5LCer73k
 W2UoW3q7mJrlDwU+ALU5R7h/npUsOZpxiojukGlxMiQEITt+lYm8MkPQEi+Hp81S+P9h
 lfewE/3Tw42ijhYo276uWIMX9m3v2oz64FXw+U8nVvHls6VnNY4kWNJAHk5Jt1sPyeAK
 g5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792536618; x=1793141418;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4zL0S6kvmtkQoYmoWRmufP9rJujsnjUqprK46hj2fn0=;
 b=KH9oJALMnRiU/xoYuBMbCVsRIfbO+4P+ulakzmC2AEknPTpIy7nTN+FOXHWz51BYqc
 ucRxvGoSe4y666SqyOKgvsJN037j2A+GhJnQ0ewtXZzNTPoNxKyBFeAEviFM13EYGf3w
 0JFnQnkqLWWnUvqdWBuxBH5lONE4eVc0z+I7M4Qzlt08D461kFPZzryxY0I/e4ZnfbzW
 YO4wq7f7j1MyzswcS54g2W7RhSL3j+TH3EUrKDu28/JyPYluaigkh3Bml8AKx0FRsPzr
 E/UKQaDkIlWALQcGTQNYgU2Ck8/nzQLz9Jzcl8AegrKp0eagvQhRzqzAEBRSlDQRrvGX
 DxJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkdLyj9LSQqI3b0PjSODM3+wVPfPrGwRIV/P4YJRN176hNW6Lof7DwlaBUZhhx/SH5fLkOntEU/bI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLh2cl4QTJi6HLNJgUqY/lTWgc00LN6yJZO9Fi3sWyqttQtsUfj
 b6LtgY0RUKmUAV9vwMrxg/WHi+7Qt/3M5NNqWbYUz+LTLQC83BB/JDJj+d+bJopk
X-Gm-Gg: AYBFou0vJd49M3cuiMWPyL9zsnGHwLmB9TMtrHMeZG3o2bNis1aBWkLl7GDaAlqHPSQ
 26NodO+wl5Nv672IckXcOf0XQ2SP7DljnBpxHZBNNKPgx6XQhfvY62BJXnrfMgrCae6kTOkbpj5
 gpDHmm4W9OfeosKJ3sexcMUBXqQmeW8DIZwVhZVezhidvEXNj+0QLvwCYbX2rDjKKly70tkR1AD
 0mVGXS2smTzLcgX1wqC7oa4MEuZxezZCOeNGfdPKp/e+Hi5+3RLwj1H3hUq/QJ4+J28Bsn655LB
 JZGBVwQh1jNMs5SUOtoGtDPilILoYve9rOozaBQGOQy13gBHA4cjr+X9Kn9lppqSwYOUbnHxUhd
 fa+/VySyaPEjBbmql+m5Y8p84Q6PWQiiOMI8IBuuwSMz/Mew/S1nszFUszC7nz6Ud6xPZCXn0Dw
 6WZyH2HPsMCEcdpzIkZx1iPUHMUQDaES/GtRJHh0yAVMp7MGSaK1RIGAAHSI3SDFOISG4fbJfqY
 HYqDI5k966rSSL08GIy4Hrc
X-Received: by 2002:a05:600c:b8d:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4a1fdb165d8mr2576335e9.5.1792536618009; 
 Tue, 20 Oct 2026 15:50:18 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc0b42bdsm17511805e9.0.2026.10.20.15.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 15:50:17 -0700 (PDT)
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
Subject: Re: [PATCH v5 09/13] drm/client: splash: turn the device tree image
 as it asks
Date: Wed, 21 Oct 2026 02:50:04 +0200
Message-Id: <20261021005006.2341200-5-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <350adc03-dd7f-4120-ac9c-b6d04ff44faf@suse.de>
References: <20261013093243.505776-1-maximpedraza@gmail.com>
 <20261013093243.505776-10-maximpedraza@gmail.com>
 <350adc03-dd7f-4120-ac9c-b6d04ff44faf@suse.de>
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

Am 20.10.26 um 13:16 schrieb Thomas Zimmermann:
> Reading the code below, may I suggest to do this in two steps: first
> read the image data into a temporary buffer, invert height and rotate as
> needed.  Second, copy the temporary image into the graphics buffer and
> adjust the color format.
>
> Eventually we want to have a useful and flexible drawing/blitting API
> for the DRM clients. Keeping drawing steps separate will help a lot in
> the long run.

Makes sense. v6 will do it that way: the first step turns and flips
the BMP into an XRGB8888 buffer, and the second converts that into the
framebuffer's format. The buffer is as large as the image in
XRGB8888, up to 8 MB for a full screen 1080p splash, and it goes once
the image is drawn. If there is a helper you would like the second
step to go through, or a shape you have in mind for the API, I am happy
to follow it.

Best regards,
Màxim
