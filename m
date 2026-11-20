Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75E60A2629
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WW6IXoll
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC3810E7CD;
	Fri, 20 Nov 2026 10:40:41 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4956B10E5F0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 10:40:35 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so6213455e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 02:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795171234; x=1795776034; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hHlxygDCb53QOZol2Y7OOBQXofD0V8rGJEydBMdsadE=;
 b=WW6IXollQJUg37ht8r/9BrqmRDjREjCL2laMIHNHLTVccXXWIPtGGAgdmfmj/iV9sZ
 pS+XLUOtv2YCl17jWt1aPr3oXiyBGrwJNMqTHdVRO+vvYBiG8KInWlv9QixIZLXw2tIb
 Ql2ETfM9I8SMhMclmx/KRZ0NyqqINytBcQ8MYAkrM8SzeQulhjOYXiABLOUkq4h/aQgZ
 IphQjotE5LdCBDn+KlGgErqAfzC53XhG5LlXdv4PUGQzFekoSlFwheIlyTC8Zy6Rd95y
 3rxx+tUgVUF0XGuAkQlY/2EnBrroCNPmOvOgHV/7IM4mn2/65hV89yBAekuIhgtCd/FQ
 ejMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171234; x=1795776034;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hHlxygDCb53QOZol2Y7OOBQXofD0V8rGJEydBMdsadE=;
 b=as7C7nmHpLPZxq0dyxRDZde7zwIlLJ76hZIaBDph068NwaKEwj2OHLjnxP395SuI1h
 lKp8uHGxZd/lsrxBe6mBEpAIyqlM91F1Fob83S9R6mOSW7zXQMnj0K7149OXvRD+Ycsc
 tBPLSZr1aCOqi/P/e76P9iexhe79WGc0qEFRfO7QmwjkQgysaTYdTuwvaHzfbEnlkR7h
 5hqjbEo05yX2ZLFUYXFaHhss12L8+2nPgAyOrc+kLJFsFwL5AtaSekauNFpIQLyncVQb
 YVymTOo67qUCU1KZNhfLN2H+FKtF78P5kiPrHg8woiFCA254td8xyd2FaY37JD/Lb2qO
 QomQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHSRH6PljpaA6gn0fXjC6MEbLx1xmPAGPopzaIE6YeOIIyiJ5ZOrq1lt4GGny0yKMDUEjeK0v7UfCw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9hiLefORTI/qWMBT3a/ZqiX3Wzvxc2rcKhdvTszJgIf5eRbb7f
 C/HDkAwIS2f3RQr3kzAnqljRpVZN9UBg2hnvXivUFIyLCOIw7dho/t/x
X-Gm-Gg: AYBFou3+XOE4wdbtiL53ys8FjYnuhnKRalkRwGME3SOPokoAbyyqmFtTNU23u/7QV7i
 rWty7J1xqzfCT+ceDnQnFrXYKpDKvFX6eeOYnkll7FSpgvqppJkZOyF7pvwpECs/JPGPv3+kWSt
 UyhscFuFkFS+fSsHZ1/K9KADrllOMQpApyJujwBYSW86W/SeWsHe1xOCUSyGfCLM7XVp7gYts1T
 5lTB4B8GWCp6qwMOTu2gXxzC9iY6r98V2YtujRSiAOa65Hpm+ik8+ST4CwK6hetADGQK5CH81XY
 Gn4Tg0+fOQR9YNg7V7Ek9GzdeTrUxtps+f+si8YJS1M9elt7u1d1s+wRujykZWxgwmVoZGHNDEQ
 3BTRt6ffFIY/Gd3WfpBK0hqTPYhXdIUEMm8bFnR/pKWgQGjZYQJU+UBzbQkAxrXOUKpyduW/7/l
 dDKiyR+K8M1E7CFtOl/h9TUftHv7nb29CBhFc7TzhOkSPKljOf878b2YTgYM9/lStJQtlToJhUr
 xhbvSXOKzwt3sR3gc0ZUoVaF8Rin8wPnfEymO7x8xUqEB+HO8XpvhZ1dTAgYqCnlWlRgDs3kJ86
 VQ2c+QEiopCyh4AGwBhkatn41TVci5nm4UOX1U63DsrhRjpE49XIpALHvyZncvHps+bb88DJ4xx
 4VjtV7GuXpEYqp2FgIDZZ44qlwWUV7oSEPk9segfNFI4cTaB4siA=
X-Received: by 2002:a05:600c:848d:b0:4a5:1cf1:b7bd with SMTP id
 5b1f17b1804b1-4bb88810b2dmr54158015e9.16.1795171233380; 
 Fri, 20 Nov 2026 02:40:33 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb895eec06sm22297535e9.2.2026.11.20.02.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:40:32 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH 0/7] drm/etnaviv: Report GPU clock changes to userspace
Date: Fri, 20 Nov 2026 11:40:26 +0100
Message-Id: <20261120-etnaviv-gpu-freq-trace-v1-0-445fc6eacddf@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2MQQ6CQAxFr0K6tomtAolXMS5G6GA3A3aGiQnh7
 jbK8v389zbIYioZbs0GJlWzzsmBTg0Mr5AmQR2dgc/cEVGHUlKoWnFaVowmbywWBsGW5cr0vMS
 eR3B5MYn6+YXvjz/7efV+OcZ9/wJRgfV6fQAAAA==
X-Change-ID: 20261116-etnaviv-gpu-freq-trace-52e421b3f72d
To: Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: kernel-dev@igalia.com, etnaviv@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Christian Gmeiner <cgmeiner@igalia.com>, stable@vger.kernel.org, 
 stable+noautosel@kernel.org
X-Mailer: b4 0.14.3
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

Userspace that converts GPU cycle counts to time, like Mesa, needs the
core clock rate a job ran at. The thermal cooling device can change
this rate at any time, and userspace has no way to learn about it.

This series adds a CLOCK_HISTORY ioctl that returns the last clock
rate changes of a GPU with their timestamps. Userspace compares them
with the fence timestamp of a job and knows the rate the job ran at.
A trace event reports the same changes.

For this a job must run at a single rate. Today the cooling device
changes the clock while a job is running, which can also hang the GPU.
On a GC7000 rev 6009 I toggled the cooling state every 200 ms during
glmark2 runs and got 25 hang recoveries in 24 runs. With this series I
got none in 34 runs. So the first patches fix the cooling device:

- Patch 1 fixes the GPU state after a failed init and after unbind.
  Patch 4 uses this state to decide if the clock can be changed.
- Patches 2-4 change the order of the cooling device registration,
  skip requests that keep the clock and close a race with runtime
  suspend.
- Patch 5 makes a clock change wait for the queued jobs.
- Patch 6 adds the trace event.
- Patch 7 keeps the last 256 changes in a ring buffer and adds the
  ioctl to read them.

Tested on GC7000 rev 6214 (i.MX8MQ), and with backports to 6.6 on
GC7000 rev 6009 (i.MX8QM) and to 6.12 on GC2000 rev 5108 (i.MX6Q,
FSCALE path).

Link to the Mesa MR implementing the userspace side:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/46538

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
Christian Gmeiner (7):
      drm/etnaviv: Don't set up a GPU on resume that is not initialized
      drm/etnaviv: Register the cooling device last and unregister it first
      drm/etnaviv: Skip cooling requests that keep the clock
      drm/etnaviv: Don't change the clock of a suspended GPU
      drm/etnaviv: Change the GPU clock between jobs
      drm/etnaviv: Add a GPU clock change trace event
      drm/etnaviv: Add an ioctl to read back GPU clock changes

 drivers/gpu/drm/etnaviv/Makefile               |   5 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c          |  20 ++-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c          | 240 ++++++++++++++++++++++---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h          |  12 ++
 drivers/gpu/drm/etnaviv/etnaviv_trace.h        |  62 +++++++
 drivers/gpu/drm/etnaviv/etnaviv_trace_points.c |   9 +
 include/uapi/drm/etnaviv_drm.h                 |  62 ++++++-
 7 files changed, 378 insertions(+), 32 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261116-etnaviv-gpu-freq-trace-52e421b3f72d

Best regards,
-- 
Christian Gmeiner <cgmeiner@igalia.com>

