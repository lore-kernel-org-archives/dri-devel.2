Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7796FC982EB
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 19:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADD7510E28E;
	Sun, 20 Sep 2026 19:40:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OBa6UdBQ";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B24910E128
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 19:39:50 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so31985165e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789933188; x=1790537988; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0lRsK/bUS1LsNCH6a4KPFVT2xb306bKtIOhyNl0hodQ=;
 b=OBa6UdBQtxkTdJiwFdJdBjBxgM5XxGcQXVw8XeKWDZtyklepGQsx+Lka6u50iodJtm
 /0aUk/taCsAl3TNN5dPLdJirCkTifAQIv/boH8aaACaix01znOfubhkeq5dcQSCvGjU0
 wbksF4fWOFyFo/SpTFyPAaQ69kSD36JoAd/THFH+DAZJrkNe0zEWBMPFj5akwLgG+tpF
 uJFb3paLBoUgzWkohgjGgzD4YvzqcXLqh18D9Fj8UscdFJXXOa15IawEIVYd0EFnQ5bG
 33KEWYE2wb+4+Debkw9Kgpnw6w7VxNSiuEJDZj2Z2RrzJeER3MOFm4sJkCnmLGIW8oZO
 F8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789933188; x=1790537988;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0lRsK/bUS1LsNCH6a4KPFVT2xb306bKtIOhyNl0hodQ=;
 b=OllTGzkSiQW69xtQ7+TVhvVty2QGXlhRBVgAZpAtuFp1sinCZe+qEGLFuj34GDiSPA
 3LDPFPE/MrUKYH9xC0jOhSSVxdQMzVd4xO3kZhMg5euoYAsu3+IQchyoOdIOz9m1KVHT
 PNyu6htEub9ID7ZpUR0+9p4Rzp9dXRep/qFoXrQj9AWfIbnpTuf1rs9dZdTxhTn8qdAv
 KPOYNFpb1EYwzYkfVq7ESxgdAPPAfarDDvUb77rDcBZQIocfXt7+IpJk8ig8MuYLAzaw
 G86Hoy8CKsNma33WiZyELSClkOMgq0LcF3Xncz8Z2oZtIYk0amZx+7qfdiEeP9vrBcXo
 1qxA==
X-Gm-Message-State: AFuF++nb22gXfyNcx8es3mUZl1cx9tEmqdQ9pfSd0kqe++zUUuSYxQW2
 dd1KhzSNTL4+Pfpq1qhALIP05YEYWSSglCR5Sm8XvOPTHq7Ex3Wxhn2gDYExyVRZ
X-Gm-Gg: AYBFou2TZm6dfnN1GSduTHA/MoVSlZAA0/yPuKLrQbrBTUEP0KPN2GoRfwFcYTTq8LO
 cjXN2TgeoqkLnogtOeO7AKrhJN4asDFjHLTmLlgRIaWXb5BZSy7XQQapj+zw42tr2mKGuJbMlmc
 e1PLdzn07R643jSkxYEtyw3H8VvV9ReSaGDbm6iAHX8aaynCWzbtLjzLr5ELg406gkqEsZYyNun
 ZduB7h62nQYub50Tm9uE9JI9E1I+RaoAucF/aizhaSsCBJNNR9XsyL/rdBaOjH8KMcRzK6c4y1u
 +5PN3ivKEr/5+HY1vvkMSafvUwQKxCeR09vNC8yvh98JWOu/6qZOGrgFBICWXllvDJGhyMuRGKW
 r8bsFv6O/fB8vUYqeaRVKIQ1EAzuf93GhVXlojnjGt5uVyZABowUAx3uMz0lj18YKmvtt25MPUx
 mP2eaRNN6oaGXU0u0JGeK/X7J2YgzuezI9RvNDfqLCbzv+V51TMfPAox5GN0wIibfgwncLXqH9n
 0TqJlFm4feHpPxsH7lWbC1d5PRH48p/om5QyuaCyDDcvxZ2tlO5O8WZ3aO+w2vSCnIPMQpMsTke
 gtWqpCkMrvVcHvyZnEJUTJn3+7zjOVZIlHUMceE35s5+g0o=
X-Received: by 2002:a05:600c:468c:b0:49d:16df:8521 with SMTP id
 5b1f17b1804b1-49fc56811dcmr122160665e9.4.1789933188393; 
 Sun, 20 Sep 2026 12:39:48 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc56aab7csm168250455e9.1.2026.09.20.12.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 12:39:47 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, u.kleine-koenig@baylibre.com,
 Leander Kieweg <kieweg.leander@gmail.com>
Subject: [PATCH v5 0/2] drm: Add DRM driver for GlandaGPU (VHDL soft-IP GPU)
Date: Sun, 20 Sep 2026 21:39:42 +0200
Message-ID: <20260920193944.110983-1-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

This is v5 of the GlandaGPU DRM driver series [1][2][3][4]. It
addresses review feedback from Thomas Zimmermann and the automated
review bot on v4.

GlandaGPU is a small VHDL soft-IP 2D display controller, currently
targeting a Terasic DE10-Standard (Cyclone V SoC). This series has
been tested against a QEMU digital twin and on real hardware.

Hardware/VHDL:   https://github.com/stiangglanda/GlandaGPU
QEMU fork:       https://github.com/stiangglanda/qemu-glandagpu
Userspace tests: https://github.com/stiangglanda/GlandaGPU-userspace-tests

Changes since v4:

dt-bindings:
- Mark "interrupts" as required in kieweg,gpu.yaml, now that the IRQ
  is a hard requirement for the driver.

driver core:
- Replace iosys_map_rd() in glanda_blit_rect() with
  iosys_map_memcpy_from() into a per-row scratch buffer allocated
  via drm_format_conv_state_reserve() (solves the unaligned-pitch
  problem without breaking uAPI) (Thomas Zimmermann).
- Add drm_atomic_helper_shutdown() to glanda_drm_fini(), after
  drm_dev_unplug() (Thomas Zimmermann).
- Add an all-ones check in glanda_irq_handler() to guard against a
  disconnected/floating ISR register (Sashiko bot).
- Add .shutdown for both the platform driver and the PCI driver
  (Sashiko bot).

The Sashiko bot also flagged drm_gem_fb_begin_cpu_access() and
drm_gem_fb_end_cpu_access() as potentially sleeping in atomic
context. I'm keeping these as they are, since they were added on
Thomas' recommendation in the first place.

Regarding IRQ handling: as Thomas suggested, I made the IRQ a hard
requirement and removed the polling fallback entirely. That fallback
was legacy from an earlier hardware revision that didn't support
IRQs at all. Since current hardware always has one, keeping two code
paths around wasn't worth the maintenance cost.

Because of this, I also had to mark "interrupts" as required in the
kieweg,gpu.yaml dt-binding again. That patch already carried a
Reviewed-by from Krzysztof Kozlowski in v4, but since the binding
changed, I'm not carrying that tag forward this time.

[1] v1: https://lore.kernel.org/dri-devel/20260714101146.200416-1-kieweg.leander@gmail.com/T/#t
[2] v2: https://lore.kernel.org/dri-devel/20260730173643.256052-1-kieweg.leander@gmail.com/T/#t
[3] v3: https://lore.kernel.org/dri-devel/20260824195418.17707-1-kieweg.leander@gmail.com/T/#t
[4] v4: https://lore.kernel.org/dri-devel/20260913205007.118552-1-kieweg.leander@gmail.com/T/#t

Leander Kieweg (2):
  dt-bindings: display: Add GlandaGPU binding
  drm/glanda: Add initial DRM driver for GlandaGPU

 .../bindings/display/kieweg,gpu.yaml          |  56 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/tiny/Kconfig                  |  11 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/glandagpu.c              | 655 ++++++++++++++++++
 6 files changed, 731 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/kieweg,gpu.yaml
 create mode 100644 drivers/gpu/drm/tiny/glandagpu.c

-- 
2.43.0

