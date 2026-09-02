Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B595DC624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D0C410F3F7;
	Thu,  3 Sep 2026 07:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="psIbauGR";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2D3410F1AB
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 12:29:03 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cc1c7364550so1120528a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 05:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788352143; x=1788956943; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/qoMjdLtE5Tb+izhhpMSUX+0Aq5eRvzQV4VKQzJTc+8=;
 b=psIbauGRrMXk9wXLp9ZEd6OX6qNVoRsAXolmR6ZN5PSKuP6jGjz4nIkCc9BAzit3RF
 LF+C55BDPyOrwi7y0SeMV7hh+T3gNYtkfSlwpjSdZjrMUsZx8iMETeT3X+/WwGPXk5Ef
 AC8iSHXasaUhHc0ucB7pNrmm/8Qd9ZFQwsmiNyahd6sO+1AnJseunr19hcspNj3u7ZiR
 2cwQEhr6j6UryqM9v2JsDOh/0/2HccyXzohUk4sItXFwyYvbxflqvvm6UH9b3XEWQrLs
 Mr0xh6McPQtED/uQXVQICrvKzPi3uNfM+hUjuoYFIIUoUc0QMTn4oLfK1oPO5wZzT82H
 XSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788352143; x=1788956943;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/qoMjdLtE5Tb+izhhpMSUX+0Aq5eRvzQV4VKQzJTc+8=;
 b=m554b7w41X/U/RYixQL5FjVax9ayMqOjIG1uDAM8tM/7A+zgZZArWmw/Ke17Gdcm1S
 K7sbmGdoqpEGrzyvluM1u6uOvROCCiNWufiK+gsCwIzjLzovppGquCIxbK66BPNwDOZp
 yKj2oIkrYQAZ8kz9VEgxoTBx/dWwtxBLsrrulbyTZRIOxtBmL7r/GgDJn9FltV7CaynM
 hsoIWtVgzR3tyrSUlnWznvg2+i4NcryAL5GoQ0wnQR9ZaKWk8MVR+ofoBPorUcOIktKV
 E2ZMm/MuJ1PwnUtlquzKtLVLh2gCvfhmIkQ9dp+V4sKgkg7FAj3D+wDoSMewm7draEcA
 qxUw==
X-Gm-Message-State: AFuF++mxGw/o9WfbGlkLY6kQ/hL7ry62e2U4369zc+q/dsENUHmyLSCC
 DIVgah6/fgmQ7PE3nDfc3Tr5xwQhee0ekPIpCofR00gNrfWoXpiPYvBp
X-Gm-Gg: AR+sD10ez8OJ3s4f1cRSmFDKeT01Dk0/si8Em3+5vqB+fH75pGvCSZVw2mjnhBOBb+u
 9/flhUS9YFIn3zrKdVR/4WJ71qr9oz/XxxpPiy2xZjpoTQasANS8h1VdXevrwIXMnIbC2bNLLXA
 5MnpvvLYo+2Nc/M8fsRzChRH5lHECPiK8TS/JHFiMhNCP4EMtsw8+qK7RYRQ93C9H7KvdXG8hpr
 kYBv4IshirsCM+/p0UMIhYwT3Y7OgS1JYs2nJ2NS1oK37DC5OI/ANGNv4OI+41kfd5xjfa8HFxZ
 6HWRMMdmSSj7ZP5redNUunxbr6hTleVe0KhvIRyluZDiH+2kqv5OK+e82fzuJK/ekp/81oFaMKq
 pBwBEZIF92CHcFcXMzmDcUbUsNTYXmf8BWmb7v5a2djKjb+1AzPZdqiFn79NrjRw7VnALpMa69g
 ruztd4P+afA5ISZ2gmw/b6EBLpOLwZnq4dJtE7CRLdFMb2JUSvZdGy8IsJKU4=
X-Received: by 2002:a05:6a20:2d22:b0:3d3:aec2:4dcb with SMTP id
 adf61e73a8af0-3d9b051aa7dmr7668765637.23.1788352143372; 
 Wed, 02 Sep 2026 05:29:03 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.37])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc34d03b5a8sm944767a12.26.2026.09.02.05.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 05:29:02 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Subject: [PATCH v2 0/2] drm/gpuvm: reject zero-length VM_BIND ranges at the
 shared gate
Date: Wed, 02 Sep 2026 20:28:41 +0800
Message-Id: <20260902-drm-gpuvm-zerorange-v2-v2-0-da63269c6ec4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHkWmGoC/y2MywqDMBBFf0Vm3YF0WiTtr5Qu8hg1BR9MNBTFf
 zexXZ7DvWeDyBI4wrPaQDiFGMYhA10qcJ0ZWsbgMwMpqtVDEXrpsZ2W1OPKMso5SYSGrnftm5u
 urYZ8noSb8D3Dr/eP42I/7OZSKwtrIqPNAdcV9W8KFg/7fgCxrzjWmgAAAA==
X-Change-ID: 20260902-drm-gpuvm-zerorange-v2-a2148df386b8
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788352136; l=2561;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=Y4UF1kjYtRztU8LqPmvUCwD+sr0gZn8JnAKvIXkPkOw=;
 b=kdB6ANHPAWt1uIv+6CXPurZjkjDoqYI5cORAK4jhKYzt60UFnJTGsQy2mZ0iOBS9OnYp9dBuA
 btjcHle4QJ5BziAZXjhT+zrIYN/lB/OO7O/pk0H5sMLn50vge7Jm1YU
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

v1 fixed this in the nouveau driver by rejecting a zero-length range in
nouveau_uvmm_validate_range(). Danilo pointed out that this should be
fixed in GPUVM instead, and he is right: the defect is in the core, so
this v2 moves the fix there.

A zero-length range passes drm_gpuvm_range_valid() (0 is page-aligned and
addr + 0 does not overflow), and the GPUVA interval tree then computes a
node's last key as addr + range - 1, which underflows to addr - 1. The
resulting inverted interval corrupts the augmented rb-tree. Because both
the underflowing arithmetic and the single validation gate live in
drm_gpuvm.c, the core protects no one: nouveau and msm are affected, while
xe and imagination are saved only by their own explicit checks near the
ioctl boundary. Patch 2 adds the rejection to drm_gpuvm_range_valid(),
closing the hole for all callers at once.

Fixing only the core would, however, interact badly with panthor. Its
synchronous VM_BIND path already treats a zero-length op as a no-op
(returns 0), but its asynchronous path does not: a zero-length async
MAP/UNMAP reaches drm_gpuvm_sm_map()/drm_gpuvm_sm_unmap(). Today a
zero-length async map into unmapped space can already insert a malformed
node there, so patch 1 fixes a pre-existing corruption on its own; and
once the core starts rejecting a zero range, panthor_vm_bind_run_job()
would additionally escalate the resulting -EINVAL to
panthor_vm_declare_unusable(), permanently killing the VM. Patch 1
therefore makes panthor's asynchronous path treat a zero-length op as a
no-op, matching its synchronous path, and must be applied before patch 2.

Both patches are Cc: stable.

Changes since v1:
- Move the fix from the nouveau driver into the GPUVM core
  (drm_gpuvm_range_valid()), per Danilo's feedback.
- Add a preparatory panthor patch so the core change does not regress
  panthor's asynchronous VM_BIND path.
- Link to v1: https://lore.kernel.org/all/20260812-nouveau-uvmm-pt-fixes-v1-1-ab3a823f946e@gmail.com

Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
Zhenhao Wan (2):
      drm/panthor: Treat a zero-length VM_BIND op as a no-op
      drm/gpuvm: reject zero-length range in drm_gpuvm_range_valid()

 drivers/gpu/drm/drm_gpuvm.c           | 6 ++++--
 drivers/gpu/drm/panthor/panthor_mmu.c | 9 +++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260902-drm-gpuvm-zerorange-v2-a2148df386b8

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

