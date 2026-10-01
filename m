Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF970CA5FD4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D094110F773;
	Thu,  1 Oct 2026 19:59:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AqD/Mnee";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02CF910F773
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 19:59:02 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a022e9cbebso7497775e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 12:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790884740; x=1791489540; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j79G9x93qm3T0R3P1TfLErsNrxHPzMPCo5TuV1Ni39U=;
 b=AqD/Mnee19B+C5HkIePbZIbqX4BNWPp3Bw3a2cCmHXvjxx0F/VIthmKNeuik66TxaE
 zMt5AGTenL9QUWmNxldvaWhevSgSQwAdYtxftGi4O9vET6n4UUCx7kmEhIShXzcE3/r1
 izd6EiSpGhf2PICAVrv0ckEU5XayJZiln4gYuS2ITvHQ9VZ4Ab/6jZLmGd61f4Num4j0
 hYJqnELZOVmJpXY3KhDhsFyGKVoMiS+jVXx8BwlJYUpmBpr7Bh8jtIMVMirLkWIyVo+G
 0cnJ643M3cFzqqbpdXCdqQ6l/piU72qxpUgttSGeYp0bEZ3MbJWkbJhm9XQt+pJk82dv
 WDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790884740; x=1791489540;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j79G9x93qm3T0R3P1TfLErsNrxHPzMPCo5TuV1Ni39U=;
 b=al9upiu+ARgHN3qU3Jk3DowVlMsA1YpVbBMKZ0/+fh059D+UAP+8KyOpImqUEAujkr
 YlH4I+SNzWpr0njs0Rg/cHNyfa2t1oxftf1zhs+R4Pae1Ho86V1xLIlkqwp/IhGDMlPR
 1fyFsG/aBplDiLZvTFUs0xsOtNA58NeZ1h+hDUUUvdJSdIYunFhOKIFLOyrgVoEQB8gC
 VDpeKzvJLGz2DtxAmGRgutKvxigOmRx0evEqtVzM82gzzrxerDMLOgwYimIE3YDyJAsO
 eppJWfwcjBrWJqw+tSbtxL9knBefMgKcSI2EXB+u+X2n9WmrVjMb3kivE5tKYqkagbCV
 2EHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzT2l2URpAE9toyNQ16ITAw+nrNa0Eg2DjzbZ5CkESeUJDT5awWcl34qUksZmL3BYYGvcnJzwPe8nU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nT4wBUEV6iON3/ut58kBMhONU24Imn6ydhj+/ZR5f3UelLHFaY
 rDi1/ZtjyCvBdMoJ4lrNN0aMn3aasOj3wK63qti6k79hdSmpBW5Bn1ladk2n4Ciu
X-Gm-Gg: AYBFou22xRC7UG/fKA1yvpxoSjS0vSJJHBE5aBTgygic049eol8DupXOmnI6BFZJxrv
 RDErD5tdNvVYFSUiOIbjNSh8g/8Xj7aEPd4ze2KFwmNFl0IusGhf6wfFB38XxKyCdJ/jUhW4hZT
 RK43AoK8es8oLXphyvxnHDdWDEL/vpZJCo6QRzvxf4HwTjWxIqtv7A8fsJSNYTJilXPi2GgmpO4
 /Uxj0TINCz3REY1AaNvR+MMwgEruVn8BdpfzBBE97Aj+kETz32ge7XWcNRWkvaafdjk+GWufB9p
 WK69t/01VYPSZKd1uCcG9uTYkW6vl027hs8+OVVoEN+tNraEGDUTQqkzdsTsRV6r0PZDRWq0YOa
 xYU22JlIBpHGqTkn8cv4nusTWykSKnhifz947GnB06rchxwWXB7srCJzNpkOC+yV2ulauVUIEgn
 sCA5Zvf1Oo2D1zOBlkc3QPEaXy37TjqHW5vc+t47AhfOszEBPNuUfomxsGQdZy0Y9dvz4Oq9gkm
 ltt1XlJqZMnSmQb7Wb+qC6RTw==
X-Received: by 2002:a05:600c:3501:b0:4a0:1723:2d8e with SMTP id
 5b1f17b1804b1-4a0274f3bcdmr12096855e9.2.1790884740123; 
 Thu, 01 Oct 2026 12:59:00 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0276f92d9sm15031045e9.4.2026.10.01.12.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 12:58:59 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Francesco Valla <francesco@valla.it>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH RFC v4 05/13] drm: docs: remove bootsplash from TODO
Date: Thu,  1 Oct 2026 21:58:39 +0200
Message-Id: <20261001195847.141192-6-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261001195847.141192-1-maximpedraza@gmail.com>
References: <20261001195847.141192-1-maximpedraza@gmail.com>
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

Now that a splash client exists, remove the bootsplash task from the
TODO list for the DRM subsystem.

Signed-off-by: Francesco Valla <francesco@valla.it>
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 Documentation/gpu/todo.rst | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index a437ae5c71f4..e77de5e2a24f 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -773,23 +773,6 @@ See drivers/gpu/drm/amd/display/TODO for tasks.
 
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

