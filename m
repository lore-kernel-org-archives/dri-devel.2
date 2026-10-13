Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA86ECC6B10
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DD0C10F67F;
	Tue, 13 Oct 2026 09:33:13 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3431910E785
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:33:00 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-487049569b6so1892177f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 02:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791883978; x=1792488778; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6FMp4bmsFYk3mzSCH1/ElOs2cwgfyNFSJhXfclhOUCc=;
 b=EJH4Wsw6fNNljZoyCWLHXHnvAIye/+dvVOz9Y51F4iaiNXM2scVcdqXnLlbfYTbj5f
 oZUxahGHilse+0J0iNsQKe9ON2PH9NcsWVdfNEiGvxXH/eIx/FoJRK4kntMMbSf4tTQj
 wxsw2a7bIij45By69RwFu6YiWDpTO44Le6YfOI3bzgQAFMESUdKtDZCDpkLhZqa8dY+j
 KoQefbDpBwogipE+18xBFALGQM3nxg2ZAm0k7Yl4SLZYG6f5IUvjf9Tz9pwAND2hR1Az
 SEDrioyo/oAI8V4Vc+9jSu+WB3QZXXaOlXXnwbeVsU4QMBypf2oIHjLYVUmHpLWsMj0+
 TY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791883978; x=1792488778;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6FMp4bmsFYk3mzSCH1/ElOs2cwgfyNFSJhXfclhOUCc=;
 b=eqoUPMO6UqSa9EYmPjDA6Bba6Q/s9OcW9uYti69Q84r1dFCWql1+xr9Uw2MxYZiE/8
 /Y4G9boUJS28KqUAnGlIPLmXOkgSYNuWfQopT3Edqzi//kwUdq/Gv9Uhrqtvr9iN3BGa
 RBAaXQR3zeX1LdX1TmP0KqZfdj0ZWUKNeDtBtugo2CU8mvSExjAxXlOZHaCp93tDX3qp
 BCsUaZ/oEjqAd2NPjOztmPtl2L/gm0/G8dMzEZiP5SnubEYSDA2eqEwnCk/bXIGQt4K9
 tW6CAAFx96yAfenpu4YJBvqUzhGvS7e4x7Q0gQ9yzJv16LXV17/n8jE+5c+5WEKQHTd+
 UMnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/6RZWMk2gzzhyLgISNJSz5FnohNxzk95i0xnRoTFFTZprPGB2SlCTA1iBUzZ0u77hSmJMsR/NaqA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYINbvcJupkD94KFKxX+KWpQ85Hfw6epINe40wjvS6s5mO6l+Ojp
 XiN2+GMMcvx2P1kvPgP2XwKcIN5/IljndLAO1063gbIcBQnnIf2/vhH4
X-Gm-Gg: AYBFou1Qc6/tckFPYOW9RKdmMZNxj9aYzWFcElkdU22EZQOTN85rh/0fleiQIJ02dly
 5cz0qv2DsjK58wxqTe1wt8HTDfT/L60wAVkc68ZyTP7aapLEtIBTIkBVK2bncqRVhW0OeAzNt4i
 tZmnrR7X6I1OvdmvuqgiNLSVf20iRBnh28Rd8wzpqzXJlf2cPT/Q4pkPln5FDC7MVbFMIoNpx+l
 22ceWjTWERtk2rOYBpEK+ZxUT4D5RxXeSmncSOkod2mQ7b6/4hufwP78ncB4Uq2fNfXTWYG5v9U
 2sRCD1KDkegNjzW4wN7NI3BCCM4rsN/lrAYg0g/L9RgK4g5yPaqH/P6qNn/6DPpkda/OmdKet4+
 79giaGKHrM7KQIDRDyFmgt81rQTY8R2WA5ZRoMqiQOekkIkNjjKOj6lF/1b/Fjfjz/3NbE9fN/U
 U0Y3EuKHK5wV6pCgbWp231hkvwgySGQAgSYvpW+1GfIIOXe5cz2ywWSwU3za2pDcMidg8DnnNpA
 aL9qkWVNMPFHMffl6iOMvXg
X-Received: by 2002:a05:6000:4313:b0:48c:77e3:6c8e with SMTP id
 ffacd0b85a97d-48dbacf4700mr22504037f8f.49.1791883978432; 
 Tue, 13 Oct 2026 02:32:58 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc4ec6sm3986774f8f.48.2026.10.13.02.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 02:32:58 -0700 (PDT)
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
Subject: [PATCH v5 04/13] MAINTAINERS: add entry for DRM splash client
Date: Tue, 13 Oct 2026 11:32:34 +0200
Message-Id: <20261013093243.505776-5-maximpedraza@gmail.com>
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

From: Francesco Valla <francesco@valla.it>

Add myself as maintainer for the DRM splash client.

Signed-off-by: Francesco Valla <francesco@valla.it>
[Màxim: add myself as co-maintainer]
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a08087fb6e67..321ecb9f5b5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9168,6 +9168,14 @@ F:	Documentation/gpu/drm-ras.rst
 F:	drivers/gpu/drm/drm_ras*
 F:	include/drm/drm_ras*
 
+DRM SPLASH
+M:	Francesco Valla <francesco@valla.it>
+M:	Màxim Pedraza Padilla <maximpedraza@gmail.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	drivers/gpu/drm/clients/drm_splash.c
+
 DRM TTM SUBSYSTEM
 M:	Natalie Vock <nat@pixelcluster.dev>
 M:	Arun Pravin <arunpravin.paneerselvam@amd.com>
-- 
2.39.5

