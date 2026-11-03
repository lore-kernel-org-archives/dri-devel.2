Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3749D606A32C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zc6NX/ge
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97EDA10F838;
	Tue,  3 Nov 2026 20:47:35 +0000 (UTC)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E820B10F838
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 20:47:28 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-5eae1276409so1417028e0c.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 12:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793738848; x=1794343648; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g/w0MVtXQhj8idCIpqV/0m1Lb366EccRtPJCicxmKT8=;
 b=zc6NX/geVoUZ0KxHXf85cVsUTPwVH7bm+pyDVFfdeWXMbky/Z6dvV8ApF88Dq4rgN6
 KNPhvAes5sBy7dFoj2fOFrwNLN1JfCqabTchdicOutGLgCXBh7kXV48/SXYf+Vr9+4e7
 P4hKLLSnKfE6YIyfZ9vxEc5WExc1ZBHgYKWZoE/nuke8esydtGDj2ZUkHdku/evrTMoO
 NgZaEm1vI/P8Ovxg9ncOf3Eh/rx/VxI4tL8nrNZUaV7H5K4xc80bY5/Rp3uNVPHuSFJN
 dJ4GfsW5YCoCyQqCzHgFZ1gl6wh9r/2gffJ5nip9XlRgMqg0wskwVOPjZ2U6KqlIssA8
 oCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793738848; x=1794343648;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g/w0MVtXQhj8idCIpqV/0m1Lb366EccRtPJCicxmKT8=;
 b=hL2XCdZYkl0ArgSb7za9ZH2ADqIe5k2GIpDFTR12wryZhO7jhYh4D2jRkfXffQYpj2
 nE6JiGHjkyHV1Gq497tjw/jZwh0pSFHYwzIlOUT9JlTSGjpTliz2DyIp55mYDjjyLKle
 M0FTh8UkahBSeos4qmfY31ZtO7BxFnS40tTURzTzg6iW8xso/qWAnhcFoszYw1ieDuUE
 TYuUR6p0TwzspRGW48bkG6xOTufexk/D+RdJUYA5ANS3Nv3xmNu2B8aQRynTk7aEXbI1
 GO1SQKznD9CykTNiCpFSbm1GNiwQmJKqgYKUHEyy9hYppPsG7wupqCPMc5Zn2gcRTuRw
 YnsA==
X-Forwarded-Encrypted: i=1;
 AKwUvByEjtBbz4BuSGzww8xo07GbcxdQj9A/RlUrFyiHC8+QAjOvvNE+U9kWxuhGr3prQAUng8MEhkUQ5gU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8scwma+x0aZYyaEtk0+R994ZCbnl5vSyYwvDj3rLFXXqrkEAyo
 yAetHhIB0R0sjIAvaPZ6jNJpemUmU8yuDzO9qcjvmYOWVYDt3wNgLVw=
X-Gm-Gg: AYBFou1ii+cciO2bJJgN6y7zWO3w2c+4xHAGE+EB1VDL8QtiMmJYFut40IrGTenZ8Xt
 VTbd23nvnVSKEEzJBMxnc+bz9GZUjIOICvmFJM5HxTaKD7B97KRjxOkU3eVINjaQlZxosb+j7KK
 aKbnHb7fsb0hGcAHeCyWaQQulH1gJLk4rdTHDf/CJreul9ochsiETrGq8TEMsUp0Joy75/fZ8Y6
 RtinpbuHwekGmUxdTeAH29KiMOB68kccziOw4WAan/2qmMY8onb6gWdgUv1l6DA7exov9IsYb9I
 84FYIa3i5fwx/JFoS5ZqneHxs2fF1+kKxjoF4Up2yrkZXvs9JpnhVk2qLugMYyQ12cFAlonIZgm
 vDsTd5FG4RMy/+YHZ2FQt4qqg7bPqiZP/TWqyR8o+ai4XBCWyOLbgfssmBCTOOTbxfAsuzBvkoY
 tjJ4sINdXbdow7mdWyFjFtpGqYTh/QdfF6QfCB/wqaw/0hOoPlhbBrb1+6QjN7QW9CNvXebsS5z
 HFpFrUkEXRDQ/xYkFl0zU78teBUUX8OovcEVqG33zeAtkpqB/nEfnhA+zPAXLXvKawnEQCebXiQ
 uVfxju+IM2cjgh0A0wy3j/om93ffy5OudN10f8G6L16Ick1/wWU4smO8H4Z4Jz6iUBcUqJov7PC
 YF7ms
X-Received: by 2002:a05:6122:3c54:b0:5ea:c11b:432c with SMTP id
 71dfb90a1353d-5ec68971961mr6087782e0c.15.1793738847860; 
 Tue, 03 Nov 2026 12:47:27 -0800 (PST)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5eca89b81b3sm119618e0c.2.2026.11.03.12.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 12:47:27 -0800 (PST)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v6 3/3] MAINTAINERS: add entry for Chipwealth CH1115 OLED
 Controller
Date: Tue,  3 Nov 2026 17:46:53 -0300
Message-ID: <1deac1052da01f892b385f0061c24bfefd8d0594.1793735996.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793735996.git.nico.antinori.7@gmail.com>
References: <cover.1793735996.git.nico.antinori.7@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add MAINTAINERS entry for the Chipwealth CH1115 dot matrix OLED
controller.

Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..ada64be352b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8285,6 +8285,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
 F:	drivers/gpu/drm/bridge/chipone-icn6211.c

+DRM DRIVER FOR CHIPWEALTH CH1115 PANELS
+M:	Nicolás Antinori <nico.antinori.7@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
+F:	drivers/gpu/drm/tiny/ch1115-i2c.c
+
 DRM DRIVER FOR EBBG FT8719 PANEL
 M:	Joel Selvaraj <jo@jsfamily.in>
 S:	Maintained
--
2.47.3

