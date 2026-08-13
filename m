Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0410C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508CA10F307;
	Fri, 14 Aug 2026 07:04:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ElE7xhMM";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A72110F325
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:14:21 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-84f3ab8750cso1876098b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786626861; x=1787231661; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lMjx6F1TSzytJZWqY2HUhhf0vDBC3SrSTqRCJ5oQEAA=;
 b=ElE7xhMM6sz1kUM8nPg6CLW3PG4/HS7Be1TbJajZIw6xdBiY8hT8+4IyMCkDfx54lb
 rRml3MjW5f0BAVLs7k5tZR+Xgo4I24ExQzkOQf7UVdNny3VYeHUZwOZbIBDLg2mgw4hE
 FcOqvRfUU2LrPw4ZWNbx9iW81dSdMNrZPss+GEcDGMl0V9KlKUD+1no+gevK82B0ncRf
 Ur2ZU7B6ic9iNXkklr13mspkWibkGNfCWe1GF0Z3qME1c57updmRteozgI/Nq/3/SCRo
 +V/d+oOXhlwQsmG7Q6iQffpzAAsSXe+b5NS9hw/3tgj5YtNd1i8M8ytkMeGTxVKNRwdz
 ZkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786626861; x=1787231661;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lMjx6F1TSzytJZWqY2HUhhf0vDBC3SrSTqRCJ5oQEAA=;
 b=g2VIcJ9BkXniw2h5Nb6f4sAc87tXZOsEOniid60I4LlS3Y/JxxHrbe65x/m3JXFV+e
 cI9+jtfi1BHrm47Bl2eD7Dn6dDs76ymgO5W1f+Sk6+hoS4QHJM30SLgcIw/Ia9GmriTM
 NYUJWYxGk5XpjNyla2pRaSKMW/Q47Cf7pjrqpZBraCsRSMTEe2i+SNmvxPXmaThE5cE4
 2Mtu1ReND+7uH4fPfQReAO6my7hYk5nin/CpiPo45WhfEAOZqnrIawCN3A7rQjvMQja7
 PzivrE4lmNzvqH9EVxUqfemAhrY5opuYgwdGfwzrK9/DXuzaKH46YCN5S05zQ3PhkTgX
 tamg==
X-Gm-Message-State: AOJu0YwN+/g2N5Ij/TWqReU9segCa+7/yJCKl5bN8rPkJS3vpBaK/8Re
 o7I1MHokr6KIUMpttbxbQUH6sxXsMm4TjLxM9Rv5DaFVqOdnCgL20umy
X-Gm-Gg: AR+sD139/skfP+alKSfoT+LYDTATSlxbgYbTGZuaSjHUP1KLWKSet1q36dYEg9ySUz+
 rvgHHQckHTFf1JWa9UqXGBSOJYxjoWF6EkmYxBJ6XvmBAYqoTntNpp/PNlfDV28frrBtp904vy6
 7BfAhXK1ZwOE5mZnOGT/pNTRyAXE2RQHN3PpYfrFcDh5CLRKpLnfHMaxizfRAfXvxJ00gyg7onL
 Tqgn3/MvQ/uwi0T13VXjBGlUh+9wbhn4QNOB7i4EZHpLJxrSYeFrW7uudnXuZ7UXA5KdWMJsgLt
 ctKs9PwRQHMEvEdOHm5siunx4lTeG82heldJVy1HL+Ty5kDXB1K9aXbI/U5FgdPx83eelASB/ex
 6vUUZiJPByQegrfJhKMq/KgDv3qWEgduGjN7hkMR9/hYGLTn/5W5AR3OdUw0j+4IALoI0Ai++Nt
 StybHaFsKahbGxeFj+DIamEoLy412N3T7IJYaVbJY4nY2OYqOx8Zp3pTYQezo=
X-Received: by 2002:a05:6a00:124e:b0:84a:2fff:ced2 with SMTP id
 d2e1a72fcca58-84fc7694568mr5608723b3a.35.1786626860773; 
 Thu, 13 Aug 2026 06:14:20 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef6a4a4f5sm1084669a12.9.2026.08.13.06.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 06:14:20 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Thu, 13 Aug 2026 21:14:08 +0800
Subject: [PATCH] drm/nouveau: reject zero-size notifier object allocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-nouveau-abi16-notifierobj-zero-size-v1-1-20dee38077cb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAB/DfWoC/yXNQQ6DIBCF4auYWXcSkUhJr9J0ATLacQENiDEa7
 95pXb18m/8dUCgzFXg0B2RauXCKAnVrYHi7OBFyEEPXdqa1SmNMdSVX0XlWRrTwyJSTn3GXwcI
 7YR+0tTZo4/s7SOmTaeTt//J8XS7VzzQsvzSc5xcN0nxlhwAAAA==
X-Change-ID: 20260813-nouveau-abi16-notifierobj-zero-size-5d3888d36b57
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786626855; l=1998;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=f/7hmALYx1pUavsqR9dX4xDKx4SJ9Gehp6aIWoZk6lE=;
 b=JzBvG33pFgsgUZm3gcV+sluPbY85ddmYsDyvCdNM9M42adhFWTnHbKTyJhu8MgcNPFlyRhplW
 /1cni1BqMUkAfpVfdotWiTvDnbpRubL+xOM++Kx3OqwfdikGFXjDL70
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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

nouveau_abi16_ioctl_notifierobj_alloc() passes the userspace-controlled
info->size to nvkm_mm_head() as both size_max and size_min without a lower
bound.  A zero size satisfies the allocator's "e - s < size_min" gate
(size_min == 0 makes the unsigned comparison inert) and yields a
zero-length node, after which

	args.limit = ntfy->node->offset + ntfy->node->length - 1;

underflows (offset 0, length 0 -> 0xffffffff) into an oversized ~4 GiB DMA
window.  The dma object constructor only rejects start > limit, so the
validly ordered [base, base + 0xffffffff] range passes and is programmed
into the GPU DMA context.  The ioctl is DRM_RENDER_ALLOW, so any render
node client can trigger this on pre-Fermi hardware.

Reject a zero-size request before allocating anything.

Fixes: ebb945a94bba ("drm/nouveau: port all engines to new engine module format")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_abi16.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
index 291203121f0c..8d139bbb2934 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -660,6 +660,10 @@ nouveau_abi16_ioctl_notifierobj_alloc(ABI16_IOCTL_ARGS)
 	if (unlikely(device->info.family >= NV_DEVICE_INFO_V0_FERMI))
 		return nouveau_abi16_put(abi16, -EINVAL);
 
+	/* zero size yields a zero-length node, underflowing args.limit */
+	if (unlikely(!info->size))
+		return nouveau_abi16_put(abi16, -EINVAL);
+
 	chan = nouveau_abi16_chan(abi16, info->channel);
 	if (!chan)
 		return nouveau_abi16_put(abi16, -ENOENT);

---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260813-nouveau-abi16-notifierobj-zero-size-5d3888d36b57

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

