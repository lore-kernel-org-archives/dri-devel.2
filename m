Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22631606AA1B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vo1w/ZGM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6EE810F57D;
	Tue, 27 Oct 2026 13:54:09 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D873B10F576
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:53:59 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so29690315e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793109238; x=1793714038; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6FMp4bmsFYk3mzSCH1/ElOs2cwgfyNFSJhXfclhOUCc=;
 b=Vo1w/ZGMCHOLRMI6Y6GYXgxDbu+uK5fqCHpbW9EZLEF/ftZF8c8WkvnbSCExwPdlLg
 YGOfGykHH0rdoBiMf8O/6N9vEUosed7ujsoMf+Rh9WT9gCEpNawAOVTn9/Bptj1vqjxe
 W0v8wtMaVTG7kLH6wsI+pFCioISIEhXxIDhIK92ds26GBm5N9qOy2aSIqpo6qK5VIjwB
 b1zF+ppb8EZ0zASNGSvXvHDgPG7sdfcV9dkVWaKdvWsxcoECbAPFqib4gnMLl8rq2Qsr
 exCVIgyq0aMGXJkzEZV0fkrahR5mXJtx9+mquJ7IkSyahuOoQvkMV43r1cRQxOgsyX1X
 1NBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109238; x=1793714038;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6FMp4bmsFYk3mzSCH1/ElOs2cwgfyNFSJhXfclhOUCc=;
 b=TEUB0b4x/z1YsB3A5LydHfEeVpSp+lrz5JaYu46w1YOCAzu5G+AuevXIVUGGufg2Kh
 Lu8ap1cvQ6ssU6M9QAV9uP2ZZsAXuu9tUKwC5TA6bVsDwRk9jytGL0Vc8WtU88VKU/LI
 catsKncatL8ZEFbW/4zGklTw7cEndqlsxDWv8bjQqnCiTCEUSMluN5h5dE4nUd33vnw8
 k/V8hTDrNiYBUJ0suU8ZMxgIFUlSvJkPtZhET3UcpklhL5kuaelWNPy/x00RoKOKFTFQ
 H6MWy5Y2IAJ9Rf9Ipst2VrBqa5aDN/5HmumCvYogyREXe7FgH+zoTgjEu8b9Ih07PbWQ
 b31Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx63NkW5RNb6jOGsILd1Y7kw+AbTLlRwA13AyWb1VAVfMJBo6PTMwaDFVzkgQYDXgw+tf1ZQEHRL0U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKqTqbFZkOxqKx8mPxFvOnDBtZx7j8bBYMBiNAGkPZtGBx1MtYq
 JhBbBf9HOYduAjxRcreQjwmuMOq8QXfVLZS7kEZ80OO2c+/ETfrI+UUI
X-Gm-Gg: AYBFou16VFfMhG0oaTWcfEXHbPm4oert/c9EVfIfo7HXLD81+hW7Gz1W1dhoCAQf8LE
 /sCEj1+nZq2jfczvHv3l4jdJyRQx6YzwLWhO5DkhE+8RPBsREi5SCg+3xB8QdMuUlJUh6cg0CNw
 y0QED99bveNyBEJSY/MiK9PWcWRnWKyD1ih9+VHin6Kqxip0iLgolIaeHk1t2r1m7nhlFXW7Um/
 JgIGF0E3rZyCIHOf0txDfjvb+FfrsdZKDQhqihj/cBm+/VgDeP6kJNqIQ8G2RBLLIdGVakPVViK
 vgHmxsm3v3e3HkP9SHNepO0Mfa7CaAgJMsc5JmCnXiF1qEkYLotnQDXuedcKnXoHh9XzRECfAdE
 Eh5+A1Xd4X3flgmg1jZjtL20ff/dmpSuuL2Hm5miKhsDZXEbCFGc8FDFA/Eq2YgrjusJ40dzg9y
 FEaNcf3xAvcjsQk6Y+dBvH/KtiKUVyGkSJhCUUOGzV3ZikTCZwfQ4v0dSt3YCwyoxnjur66oE3j
 ZkYDFOW/jSLT9vgL1bKF5OYw4aAi3AzapukStZmFJ52B8t8GMIxMQGJjyBO2xwF+RQo2GcS91I6
 X0iHyew=
X-Received: by 2002:a05:600c:524c:b0:4a0:1c94:7042 with SMTP id
 5b1f17b1804b1-4a35ac8bdc6mr188823805e9.8.1793109237982; 
 Tue, 27 Oct 2026 06:53:57 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:53:57 -0700 (PDT)
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
Subject: [PATCH v6 05/15] MAINTAINERS: add entry for DRM splash client
Date: Tue, 27 Oct 2026 14:53:32 +0100
Message-Id: <20261027135342.2003632-6-maximpedraza@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

