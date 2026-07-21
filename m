Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A049C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB9510E6DE;
	Tue, 21 Jul 2026 08:21:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OTeLA6Rv";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC71310E2F6
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:21:31 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-69e08ad526cso7876959a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 01:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784622090; x=1785226890; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9+ia3WLYSRNd9xkwqotEf8gwl8oDgEsTaLE4rh2ip0U=;
 b=OTeLA6RvX7IuX3Bw1JMzotC+IcnVcV6RIvZtyHCNiInFKXxmwa6P4xXIpHnXXpSm2S
 imdqDf4KUDPvL175cVuTcuBEn4kF5xZCVJDnYeEB/5wSxRTt6f0DLMGxaStOfuBlCIQu
 KPpaJKXyaufPyhcIJixARlVkOnopKltI6d+pBgCmajQws/Trw9K2QCfk3QWLfim9kbEw
 X2XgrsJlYV1H4VOf5PIag7NS5Bs/RzdFgfXlY59w6Mrau3iDMosRmYR/zXU+hsFlzXXS
 Kq8iBdVVUSnjW3OLPtnsO/cExaPBIW0qrzxe/TugSFoQrVBjTelBRLvddFKJx/g2RPcM
 oRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784622090; x=1785226890;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9+ia3WLYSRNd9xkwqotEf8gwl8oDgEsTaLE4rh2ip0U=;
 b=p8QD+b0rFJCpQWSeEjPJfHhOQR+PvybOT/NnVhiiZcP1ECoDnqavXgyszRKwNx2KNV
 4aHCwjiyDYxej+QUpfYFPvs8RNx4M+h0rCsR+1H1RhOsQWZdH0PLnMsjmG09RZZ/N632
 TkqSahKvDMy8ATUx+58+yrfW+So3hxRO8LnouEs+T/cSnWP4NvMzLKUXh+nkbhg5K+kt
 wn8XPAyZFOR+2s7/VBgJwDfHfXaMrnn/TUPth5dde35YD2GFzpgsocispkwp3PwMkdNx
 qB59IRKJG7PWMGta1zF+Ay2Y198y2ibMDkz9T0MFMmMOwK0BrmZSSP6WfrBwK3E4XvEM
 nyYA==
X-Gm-Message-State: AOJu0YyNCvqY1CKnH7WNV+xXybHUf/bjVFkNOu+fRN5tHzumqsbFr0UT
 ABmjJw1tGtkMY445dNvQAvTVBMf8NiEDteC6j1mfI2lZAQ0lGd2brUxd5dL8HBcpX5w=
X-Gm-Gg: AfdE7cmvkfc2ZePxDpT6FPaH17QHmlISjqfH1ZwM/+ja2x9ZNrSHbOgFMnntgHjvbtm
 9EJyju6DQRyOAfj7iY+N5sP9itE5AiVNHECjju52nt+WApNWJ3xjsnwyeZcznJE/cbN0ipOiGvs
 itppYYtTTY3d/CG5kzeBReCTSUGWT5Y3xzGy0avMsh3vqxdzTJcQSlx9R8xpRbxZd+xSTaqIx0P
 B72Ek99eND4P5Sa1d0yEAwjFUYFtWeiizk7PNhMRxRSZPacMs2+y53yoY9+6Hj2dg6Hcrs6oiXd
 XkhvJRiAU1WoS1EIRDiZ0K6LqHZZZ5/lGbCJXKNvdzNi0Rax0DGs0otkVj2j+Ux6jQURm9pUz8y
 aJAAo5piCw5HJsGl7VhOFoZCiZ7GZMAx8nwRBKDUll5QwYo94ddb+ULDo/2wug3917RbdAUreqR
 e7JRpXGV9L9fZ2Rn38PQv91qnUqJ4G4e7ohyw/58TU4AzxT+mVX16xduL1rx1qwZr5SQ==
X-Received: by 2002:a17:906:eece:b0:c0d:cd71:6463 with SMTP id
 a640c23a62f3a-c16b46b6474mr753086366b.16.1784622090194; 
 Tue, 21 Jul 2026 01:21:30 -0700 (PDT)
Received: from puffmais2.c.googlers.com
 (185.155.90.34.bc.googleusercontent.com. [34.90.155.185])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1724f50b72sm564725066b.48.2026.07.21.01.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:21:29 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v3 0/2] drm/drm_crtc: dma_fence_ops fixes
Date: Tue, 21 Jul 2026 09:21:25 +0100
Message-Id: <20260721-linux-drm_crtc_fix2-v3-0-afa8c71506e6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAUsX2oC/33NQQ6CMBAF0KuQrh3TToEaV97DGFJKgSZKyRQbD
 OHuFjbGhS7/z/w3CwuWnA3snC2MbHTB+SEFeciY6fXQWXBNygw5lrwUJ7i74TlDQ4/K0GSq1s0
 IKLUyssh1LpCl5Ug29bt6vaXcuzB5eu1Potja/14UIMBwaZWqZdnK/JKuNPmjp45tYMQPovgPB
 IGDaRXWVhWNKvQXsq7rG/mUxaj8AAAA
X-Change-ID: 20260618-linux-drm_crtc_fix2-23a7c354a412
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Sean Paul <seanpaul@chromium.org>, 
 Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, Simona Vetter <simona.vetter@ffwll.ch>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
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

Hi,

These patches fix two issues in the drm/drm_crtc driver. Initially I
was hitting the BUG_ON() in a scenario as explained in the commit
message of what is now the second patch in this series.

After posting, sashiko.dev noticed another issue, that was previously
masked by the now-removed BUG_ON(). Since we can't have a loud BUG() be
replaced with silent data corruption or worse, I've also added a patch
to address this issue highlighted by sashiko.dev. I believe its
observation and analysis to be correct.

Cheers,
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v3:
- Philipp:
  - patch 1: update kerneldoc, add Fixes:
  - patch 2: shorten commit message
  - explicitly Cc: stable
  - collect tag
- Link to v2: https://lore.kernel.org/r/20260708-linux-drm_crtc_fix2-v2-0-cf72be75d75a@linaro.org

Changes in v2:
- add new patch 1 to address sashiko observation
- original patch 1 becomes patch 2
- patch 2:
  - don't turn fence_to_crtc() into macro (Jani, Philipp)
  - update commit message to include reference to deprecated use of BUG
- Link to v1: https://lore.kernel.org/r/20260618-linux-drm_crtc_fix2-v1-1-c03e77b36f34@linaro.org

---
André Draszik (2):
      drm/drm_crtc: ensure dma_fence_ops remain valid during device unbind
      drm/drm_crtc: fix race with dma_fence_signal() in ::get_driver_name()

 drivers/gpu/drm/drm_crtc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)
---
base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
change-id: 20260618-linux-drm_crtc_fix2-23a7c354a412

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

