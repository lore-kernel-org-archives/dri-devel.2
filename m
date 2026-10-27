Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BC2606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OCpHcXiN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82BFD10E194;
	Tue, 27 Oct 2026 08:55:45 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DA8A10E194
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 08:55:39 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so21201105e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 01:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793091337; x=1793696137; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ho9s6p1VYtelviR5lwhrV0eO33rHviRLYIfI2vUHdcc=;
 b=OCpHcXiNMT5ZoQyFuWh8Xokt+bX5mTOE31+MNauIK5zfUyV6R372dquYaNPasv7wd9
 ktY29dT73H+9NtCUjvrkswkSRkLOsxxf0BpgxIk8QbzGEy7R/FXHfTpy66xhNXi3t8bP
 03H9RS43OaXv/JxbZxYFRAOwNq2rznmM2HvUdKpI9JV6cSTw61m2NzFIlTyGtw9vXGuv
 eXdOkm6uA2Nd2/b/uQGb33Un26pvBUjUIS2UCtkT5du62GbS5Eb4Ibm0zIG+PrrPF0UH
 D3tUjPSt6Wu71LAolN65j1ZX39IDPtV2QFjhYCE+1xmkDU7DmLFl1yYzCRHG4paC2x9y
 BE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793091337; x=1793696137;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ho9s6p1VYtelviR5lwhrV0eO33rHviRLYIfI2vUHdcc=;
 b=1h1y/d9IGpQH7QoJOVAp6iyNy1t8IpLJjcDiaqhAvBDh3yL8X9ab0V7QZRiiVT7c8S
 evl5RSxzPf6TOH64LWiG9njZUtoJmqv9BqkrO7esKJ8wHWqKRnK5m03loH/d80TNMIFB
 9OhrcXnXPmC7hJ7t8w64nldZWdXTWZpxziE3t7KZBkRQah6Bf4/JvX40iw3LkPQLKYBD
 muItviTaJGpI3tjPCCU8dX51dRtM5Vn7DpiIXT7XBe3EsI4Ag1pJlHdk+4PqXKpSg0UX
 1zM5B7I2DiKtZ53YyX+V33x3zWD3HJqO7fKxAIJoC7kvjBR656AEGcsUK3fsD7dR2Udu
 I25w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8pVAcGCLTNUjEtHKfRCo+N4KmNkebrToSU4EhiE8hdRutsBsmrm9JR2vPym62lSCj2pmp+YiN1rY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLpnFgNJ+USR2gZvHrkLZAouvN2qDx20E9Qk1pOIuKvcg5YljfK
 PKOtrL1EClxlE8wNs7L1XAzatBsLIPiq4+mw/VKmPfsu+GWTrUy7S6Z2
X-Gm-Gg: AYBFou2X+sRBBwk9g3npRwnLptvE0rjT38SvJcLHmMBd/QsJXUv6BSZOf5RRBwNhhAW
 h0h4Ykljr4iAFhqJiqjre8hCkGaAfobWg2KN7ByTecnrKQLmxu3b60Rnsi73KjjjRWa3n/Ydx4P
 1khe54e420/jvC1h9xKvko/g8Y7H8TX05qI//6rM8vgxZIQTxY+3a2jQuiG7T9Tich1b9HPsPSv
 lDZAAyngxqt8qILFdGFqldTzADCHQ/zzt3SBXL1qRqrKQMEYDxIRiqwVyLnrqBEHjf0duGI/n9v
 D1KR7cMluzPsNEj3wmIuKGJs118cr7XEe6B1vIGsaSCp+clL7br2vRh5PAMynfObpc+NbAEFAl7
 gt4X7gvWrRO+7458q8xiCbic4w60ct5qlma6bB7eiUP42n80RXqA+2PCixhDYOTznqUr3T1uoQ8
 NnA36Ep9wJmQplc7pYZ9qXnb/O2+5A4gdfg7ZfxdIr9GdXolBGeJiIGaTUMGn02XCcLwZYxINQN
 L/DDlq9qy2hKFkq9cObaNwjo6gYZtkudi2j1Ypk9+dhqFzN8nszkn00cqynZDzlvte+CNfFOc2Z
 N+sagWQm
X-Received: by 2002:a05:600c:3544:b0:49f:fd40:80fa with SMTP id
 5b1f17b1804b1-4a35acc6b74mr187900455e9.34.1793091336983; 
 Tue, 27 Oct 2026 01:55:36 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm249835425e9.0.2026.10.27.01.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 01:55:36 -0700 (PDT)
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
Subject: Re: [PATCH v5 03/13] drm: client: add splash client
Date: Tue, 27 Oct 2026 09:55:34 +0100
Message-Id: <20261027085534.1746021-1-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <645c1c2b-9aa8-44b4-8a67-dcd7bfbe8fbd@suse.de>
References: <20261013093243.505776-1-maximpedraza@gmail.com>
 <20261013093243.505776-4-maximpedraza@gmail.com>
 <fafa7327-e624-49f2-98b2-83fd602a0ad7@suse.de>
 <20261021005006.2341200-2-maximpedraza@gmail.com>
 <645c1c2b-9aa8-44b4-8a67-dcd7bfbe8fbd@suse.de>
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

Am 23.10.26 um 13:26 schrieb Thomas Zimmermann:
> Please drop the parameters for now. If we want to give status messages
> from boot loader to kernel, we should first evaluate how to do that
> correctly.

Fair enough. They are all gone in v6: the colour and the BMP's name
are set in Kconfig only, and the patch that let the command line win
over the device tree is dropped.

> Oh, I just noticed that my comment got truncated. I meant to that "i
> should likely by unsigned int as well".

It is in v6.

> At some point I'd like to have a nice, shared drawing interface that all
> the clients can use easily.

The image is drawn in two steps in v6, as you suggested on patch 9:
the BMP into an XRGB8888 buffer, then that into the framebuffer's
format. The second step should move onto such an interface without
much change once there is one.

> It's probably ok to address things in small steps.

Thanks. v6 rebuilds the scanouts on every hotplug and keeps the old
ones on screen until the new ones are committed. I will send it
shortly.

Best regards,
Màxim
