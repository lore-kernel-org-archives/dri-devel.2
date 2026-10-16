Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98C5606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AD0212og
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71D0D10F2D9;
	Tue, 20 Oct 2026 07:36:09 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C688C897F6
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 16:29:19 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48de72fc832so19940f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792168158; x=1792772958; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JOC0Tt4izqijGr6CwbYBXFuZxdub0c8E+AAfI2tlm98=;
 b=AD0212ogd5rk9yacQcc/FTJWewBKtGSH1xvFEOj8dVzj+IBUoPTH7Oc7W3dsWX7Ovo
 2CEcmqL5GqPzCcX/MXwxnlErrT/5k6vEihMB+8hfWjoQaF9wa9PiZhx750RrRIrhyXnD
 sMVdgWakMFSAaMH310G5nJYEkfqKqt6zoY+jA/qFb8fpx8rLkhSjaFa+fYwaZ12cK4Sv
 x50mfZjn+edDIn4qoEoY69j76zIjjQIYCdUlqaN6yIrs6WPIMWu41Ff6duaX9Kk/WNNJ
 5k5i+cRJrAhNL1qgGHxeqIdG4OJ5d1EQ7mBpoKFAcnMLntvW4tQL0Pb2MP3KbAr0MOFu
 69ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792168158; x=1792772958;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JOC0Tt4izqijGr6CwbYBXFuZxdub0c8E+AAfI2tlm98=;
 b=FmojEOWf2KFRP7759HyVkzf0XEFjMaJ/hHdTimz6BYEBUnNC6edXR1/h10pSIXJLsr
 Pktv+q2FqpxPi8554O1Dio0LNuBbe+fgK/xLuFJMYKLiZsdFiEIUgBm/lNhVxYRLet01
 4j5YwBNdEdkSPln3whtuE8qUuQdQiie8dbpDcujYCa5zsVeShqMYzrtcFf+1ws3x8ZnT
 A6MwX2x3j16vJUob/uFauX+bFm07UcqhxQZyFBXq3r71+kvZy+yYhMJyzMH5yqcXxijm
 mIRdpmFpdT216zyeqFtqaXMQNVNQAg1X9t7Ommwn4uCd1p9ZaG9mKkc9b2t8j8puJbVq
 LnUA==
X-Gm-Message-State: AFq9FYJ0oKyK5fD+98CMgJMLQSeH0x16FR6WK8LT+aIvKoOB14rvkX3S
 dFJ6HdlWHBILJldCF1mOWY4dQo5JvnsWu+Xk+slt5qsHpBgTMYwUPhvo
X-Gm-Gg: AYBFou2m4mhHU82MM5SY/jYbQ2zCClKzlavi1UF7y8PY0Peax9T2LmJrWrbAyayJqry
 A+glja80h3gEE0QmFvxwjtN2jZmK8fqADa69Rho6yjRfpG/6693P+YO+PE6vmlxUit+nKiD4OCG
 wTTjYR3QFEM/BrMf7DDJZ4iN+nRD6EtBAzMPGXIm12GTABMBBq/nB1UORPbAfe850rHRqLAqBQ2
 /yjHUXNsds9Qxns8N2nyIa1Ffhg48DzQz44joJOOxLN8uVX2Wd0f1KfmwQnxWbDjJtA3Vd2NB1B
 k64rW6jxkQD6a+tpx3QtYNd7YXg/sRIMQu0359O/+sTVh6k5DApKJDb2eJLTkqJHLqvERja437U
 Lo+J7mJityTHKmQ7/nx1pLrIBpQB3A63niSy84WdkVvfanADSBgwqObeYr81fPpW4wVnAwHqbuE
 P7t2OCbmSJ4JbgbVIPdO12bFPkKAcVikr1wmGKQgifxeeLuo2uXbK9ZGWEWKTE04/T0pSMZu3Q6
 aZZUiw7GOWt7HlP411juQNzGH35J9C1UBwzorpzzrvaY6bDKTEyJrqUi9Z2qKC/CQXxvtrj52wH
 m85PgjH277Ol
X-Received: by 2002:a05:6000:260f:b0:48d:ee35:b3fe with SMTP id
 ffacd0b85a97d-48e07988925mr282504f8f.8.1792168157866; 
 Fri, 16 Oct 2026 09:29:17 -0700 (PDT)
Received: from machine.home.arpa ([2a0d:3344:57f6::103c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4c5942sm9404317f8f.16.2026.10.16.09.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:29:17 -0700 (PDT)
From: Luka Panio <lukapanio@gmail.com>
To: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, pavel@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luka Panio <lukapanio@gmail.com>
Subject: [PATCH 0/2] backlight: Add Awinic AW99703 driver
Date: Fri, 16 Oct 2026 18:29:10 +0200
Message-ID: <20261016162912.64581-1-lukapanio@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Awinic AW99703 is a high-efficiency 3-channel WLED driver with an
integrated boost converter and 11-bit brightness control over I2C,
optionally combined with a PWM input. It is used as an LCD backlight
driver in some mobile devices.

This series adds the devicetree binding and a driver for it.

Tested on the Nexphone by Nex Computers.

A board DTS using it will follow separately.

Luka Panio (2):
  dt-bindings: leds: backlight: Add Awinic AW99703 backlight
  backlight: Add Awinic AW99703 backlight driver

 .../leds/backlight/awinic,aw99703.yaml        | 131 ++++
 MAINTAINERS                                   |   6 +
 drivers/video/backlight/Kconfig               |  11 +
 drivers/video/backlight/Makefile              |   1 +
 drivers/video/backlight/aw99703.c             | 583 ++++++++++++++++++
 5 files changed, 732 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/awinic,aw99703.yaml
 create mode 100644 drivers/video/backlight/aw99703.c


base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
-- 
2.55.0

