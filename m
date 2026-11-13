Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE7F606A330
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDWM526e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB1BF10F011;
	Sat, 14 Nov 2026 16:24:54 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84C0D10ECAA
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:27:57 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-3ab30d04674so2100801fa.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:27:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794601676; cv=none;
 d=google.com; s=arc-20260327;
 b=bSecNwU+V4VuBUP9Mo0+buBLE/GvkxMpRLRIJfMXPQN8FMuPYRIzMxhx/w+mXr4muZ
 ou9xzAVLTUhvrtK7vS7rG6ZVCw+Kdlr32lLzk8kpaw7Qm8Aq/thEAu5ZxhjSYluFt7yy
 TdIOE1jwz7kU+VlvqnSBs+W8ZobbnRfW2nqJ9lTdAFyfWNmY0UeLbNvWapvvmDlRLWCx
 Z77Hj/Kzzw3QmNFmW2DM/7XVzn2PVVxpEb3PkFfwPPWr8VVUjR07PsIUOGJ5vCibYSt1
 w0QLkkav9kEVYbPOuUOawM2Y5l19pCoEWzjFFbFi6BK+eRjSoeKTd1kj3iCyyHOrR3+M
 P5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u9SnaLU47gOx8//3HxIsRgGkAd4PUM4g3QaiLuxcEWU=;
 fh=Xfzz2QLnCpjUABd1fvDhGyQkaP9ZD7TxFrOxwD0MERc=;
 b=ol3orPVk1aUtWjhqHa/Wa9uqy+f63FgYmGh/B8Ju3L/yY+6/LWrw63GK6qUEbrM0Yy
 O3yCU84wmaP1g8Y5P9DWDHiPv4MUFM8VLLNrdwJgjwZi1S3mgimZbBuFSsyAfOUHQgez
 Wzap7b6h6GtfBYjygMXTR1ZvTq9u+MhVKtKmwCvnP+G+dv405oYYlzElCZSSRkT97kWK
 jfpjO1Rg0opT7kBnjMqi9EabEaY9GY0RpbIYZ4nCeII36nwGYMu5PeER5btjqw4lBUuL
 Allv1jCIemhqcso6OBNzk64LWgC6rP8lkqBKmEwJrX9hMtlXX+HydptKsNC0cFe4l0Wf
 c1ew==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794601676; x=1795206476; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u9SnaLU47gOx8//3HxIsRgGkAd4PUM4g3QaiLuxcEWU=;
 b=aDWM526eBrIFA6+ZmWA25AakzAUMvO0kadlM1AEK2UoWPiwktjOFapPA1f/vz+T3dk
 /c1UDYHuABcsWTzZE4+RU5sCThp1JX6rBqptNB0zPvmOReEa/EVxbc/Aq0y9SmubRbuw
 crWlnEu/a4DH6Swr5H67FulsG0cRxaBIlatUjLar9+Wjp6SgNIxyOsTyf0Hdw4x/Nci/
 h5ahTe0wgSl8rESA78y8THYBx+wnsLvrBT2sIh17lSzrSS1B+5IhziqmUYp6sIoQniKq
 UU4jBsKzc0Z2wiu2y4oP+p9ysYZUUfXlg+toQ9yZOllYzePRVFqWHhm+lKNKvFBAcEaO
 cG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794601676; x=1795206476;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u9SnaLU47gOx8//3HxIsRgGkAd4PUM4g3QaiLuxcEWU=;
 b=XFZgsHcs5Ls4v2Rmm2SfkjhwJuzU/zrfCjUK3X7DhxVypTWOaJ00+GWMnb4PKNCvgf
 hKZKz3MF3JmRd2ict18gM1PcZ5ebV1bk9/K8PR4gkHG75GovxOW3Vn68+5JDFzybTgNT
 K2uWSQSfFEyS9puOWWoGzeQUb3FP2I52Rw6/aoeGSnS78VanpWhHPUcgVQYKHPDFPeyR
 YXwFkWCp4ddemRDkJKJvvcJut/OaTkdpzKyl3knJFlbffb2pGS3YKItID8Co33HbAkpy
 NR1xr54bkTUYHnGHm68DdmekvQdHFhJDIXHulJZEtY5XuWMr7XGllD3dcpNbfR5fD2Sl
 dV7g==
X-Forwarded-Encrypted: i=1;
 AL+hErFCLAJ9Ikc8QilMGH2Xny9hEdji1DWAx05ShMOwxFzPAFVZCe9IO+f7UM83sPzOWrbEvJYrYxfaiGg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+BAMZOx0A42Bz0WRxqEoulEcfwh2sFUA1OEdQOKBXXKIz2sLvt
 YbMkNnhk5k/dmd72ItdqWoWAGXlfC2bmZGwZZEJIr2Mwa5gv6GLdsjt8YpBz8z19LnVmXIf0JdZ
 c/caeWyCK9hJER13HkhW3Wjhu6B8eSY8=
X-Gm-Gg: AYBFou33JEzkIxIwWADNgkAHd5HoynYpcDDBQIbCpitdFq0GJl5tSJ6dZOXozpRzIs8
 PCSR492W+7TTt5PzOhLl3rSzqcvVVBsrJppLe8OQw/KiEj++UKem+4Bsqyq4SSrmBg/SIUXKBe4
 HH4kwoh66vx7nCMvimo5MtxNVYyEh1Z3kjJq1Jk2hQi2AEENZ3z4rLEveC5j61E+dIf1R6/E+jc
 mgU18y9HKH0OIN1IHi5OUaBjxXPZRTWy4S8v+SZUuQRzr/PBn4q7VMcxjGkNk9bCyG9tymhJ4aZ
 h1idlkMkplTqtVoT99qF9bPrSh40Iyisy0ORMaUo3mwRTHcSNH9EsnhLhkQOsapUlJ6+3Tx2rhd
 ycp8s7U/tHyIQiPxNqYE8te4qdZJQWtAtbnNh9/GTCcK9qI6dY4AMTf/0aXsQonlsNiOelx5QFE
 /fi1Ul5o4/4D0e7rBA
X-Received: by 2002:a05:6512:3da4:b0:5bf:ce1f:cd22 with SMTP id
 2adb3069b0e04-5c170434e66mr1688237e87.0.1794601675592; Fri, 13 Nov 2026
 12:27:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111-drm-bridge-busfmt-einval-v2-1-fbb74905614b@gmail.com>
In-Reply-To: <20261111-drm-bridge-busfmt-einval-v2-1-fbb74905614b@gmail.com>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Fri, 13 Nov 2026 12:27:43 -0800
X-Gm-Features: AclHuK-HRQcdwr6yLC1DR59Fmq97vDFRT8A5nCzrrMnThAnV_neCVaC02KwMrAY
Message-ID: <CAEy9hNXoPbWzx=EiOXJwiiY=XJF56g1MfM86cgp96einDbONmw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: Fail an unsatisfiable bus format
 negotiation with -EINVAL
To: aiyengar1990@gmail.com
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A correction to the commit message: the DW DP example cannot happen on
mainline. No DisplayPort bridge connector has the "color format"
property, so "userspace now hits this routinely" is wrong; I hit it
with a dw-dp change that is not posted.

On mainline, -ENOTSUPP still reaches userspace from a chain with no
common bus format, as in drm_test_bridge_rgb_yuv_no_path(). The code is
unchanged; I can send a v3 with the message corrected.

Arun
