Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC29606A339
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W4eWxX9I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B3FB10F81C;
	Tue, 20 Oct 2026 22:50:24 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5799110F7F3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 22:50:17 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso45718f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 15:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792536616; x=1793141416; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ux8U6EoVJ4/TwWYPZhWrag3dDFgz75/l4fo+qRdZwqQ=;
 b=W4eWxX9IrpsFpeK9rFNr+kP8foj0+Zx8Zkjv72nPaEasoTQJRJ5U4f3ceUjAt870cN
 NV8ShydXuVtmyZyVxBk4rvBaHe08LeSbZpplmQOczZ+mAKFvk9GgY9ifc3gtOQwJaTbF
 MRwSh/zszbESt5q6J4WuwFyFBonQWwKwZz1CPkGxKQS/IawBuGhrvb3EowYQfvGZ+Y/P
 HuOz9qNARccjjM2626qBraefOX734F2rb1WcWKB9W1uxVoHR7Sw7uwa6VADIpBWu9DlN
 VOc1JT7CidOUp7io2Y8QIzbTujrZcxRLLxRrMZrOOGdsC3DBsQmVu9XSwa5pqO9+V4TB
 f1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792536616; x=1793141416;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ux8U6EoVJ4/TwWYPZhWrag3dDFgz75/l4fo+qRdZwqQ=;
 b=VSHJPeXnvd1Q4xkRvexRkM1ltT+j6K/ieo7a9rhuL8Vn5R6LCTVQf8dhto884CJd4P
 7w4+/KgceJWFgw/HORUmMsjcusIG2P2oDSNn6W4ToRzN4i/F2lpjy69pwW3vrrZubNSU
 MnrNTgviPrh+4LcU2P28HfWRzj6SL5Gye0RPjLPVcrzWbY+8bgvhOqAdLD6tvwk5FzSf
 uAVvlhLlza+yRvD99bFlcb9jagrhKIW1hgQrHTW5isforEiL5lYmPrSyMEWcjKx3ox+l
 g5SI4u8mco5B8/AOpdEpMm7KISRlIDg3afsD/9YTmp1jDTDPx5tsei4P6LuZ4BqzJ1rC
 2EGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMnGN7kRB6wb3HfRkWgtupHtRtT6YawOZXPhxwAbj3RN9iFbzw3lEhkpjesR1qEanvqIqxTLKT6n0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYImN31CEtQ9GIL7CSD0l+CG5HBANfm5hMzVCkLzHkhzT9G8aib/
 OeGViL9fw5AsGtIA7/zBYrX+n1o72fNNoMHXGce3wpkTh0kO930kuycU
X-Gm-Gg: AYBFou1XnzEwyHBlflmXvMWt1JuEH6DmEriNArqo3ogxlGAClWF1dZ+HO0MHZJi9Jzk
 bXJM9bB19JdafLRIVJxUliX6e/p5eXVuAgY6EC1+x2zbVl2kCp2PafzKhJ6nOvoDcT84QvRWaL2
 DgOSpEDGBhzEGU2Lz3YR1ZV3gRIoz7MpDsxuMybTd4LI4tD26VAE4mTy0OkT0LVCgRCVOUotdJC
 rfr3sOXgUxT/h04nWeHy+xtrsNzt1F8axEJWlDksWamxCZ7S2yqEiq5YeHeHpNGLE8ctnvGsOyV
 uGaO95oB/x7DCEAO45GxmbMWrVCD1ruj/O/Lto7TVAlGOMkTowNk5si9uJpQDne/PMPyJ2hApn7
 Eiusp0En86dxkCo00O3Vf5LAWvvZsz+CbrOTlSGGBFJO0m6sRa+eLdcEb+Mki6DnOqMVvK4UDBY
 A07ZVDEwiolF0zRJUmvO8Y2e46w1S7qUc1R8L5zx/xb+ucIgUPqBl3Yp/vfgW4Rq727uPYgj21Z
 TfJ0eCoXLZynfGOWrLOLd8J
X-Received: by 2002:a05:600c:3d92:b0:4a1:c646:3edc with SMTP id
 5b1f17b1804b1-4a1fdd0b082mr2686075e9.11.1792536615591; 
 Tue, 20 Oct 2026 15:50:15 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc0b42bdsm17511805e9.0.2026.10.20.15.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 15:50:15 -0700 (PDT)
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
Subject: Re: [PATCH v5 07/13] drm/client: splash: add a device tree image
 source
Date: Wed, 21 Oct 2026 02:50:03 +0200
Message-Id: <20261021005006.2341200-4-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <9834b569-935c-484b-befb-b913acead9c1@suse.de>
References: <20261013093243.505776-1-maximpedraza@gmail.com>
 <20261013093243.505776-8-maximpedraza@gmail.com>
 <9834b569-935c-484b-befb-b913acead9c1@suse.de>
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

Am 20.10.26 um 13:04 schrieb Thomas Zimmermann:
>> +/* Where the image comes from, in order of preference */
>> +enum drm_splash_source {
> The logic behind this enum deserves a separate patch, I think.

Agreed. In v6 a patch of its own will bring in the enum and the choice
of source for the two the client already has, the BGRT and the BMP
loaded as firmware, and the device tree patch will then only add its
entry.

Best regards,
Màxim
