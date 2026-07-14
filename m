Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305C4C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 905E410E048;
	Tue, 14 Jul 2026 10:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NF9+AkBU";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30ED510E048
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 10:12:34 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47de008b020so424417f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 03:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784023952; x=1784628752; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6ggmizQ4gyc8HTtT89PKufZdvYWbkRhkgN1DcShr0XQ=;
 b=NF9+AkBUp6pd1MwSS17g9RqjofFeHQV/vB8lhyTF8KXjSEXVDIfpfoycQsdzyTDJ8J
 Pa5+0/ajR3SfsugMGHZDKo+t93BAA67QlJjZvMWAfrN/HYzrGtbvnWcFX7erc+3trMU3
 pTuFF2xXJrNd+Peq/qsK3hHyf4/AhLJXYlwSzMtATeRktJcrmpkPEP/OLbqH1D9qcbr0
 IlG6HPuVU0R7xYrmUzRePLnlvy7bTynTZJur77l25gHDvInh4qYkDEr3JUYLfh1KG4Yq
 SihXPp+D0kcHcetx9wqLUQDXRmjE1V80RK6eHj2rH3uciBTFw8bulQPyTeTUx5CmGHUe
 0SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784023952; x=1784628752;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6ggmizQ4gyc8HTtT89PKufZdvYWbkRhkgN1DcShr0XQ=;
 b=oOajDMpjx8ACgVIonsixuECEt9YbZusbAKwZtz7B+3JlgP6wXnrHJvt0wVAYMM1WwO
 DCMshyoBrbz/JiijVxrhG2Qew+4MhTc8lUWAsoJ+ayUKRO0cFr35+fhspkUDKuyhJdix
 9tHev99XsZ+q5iG3hZ+xvXOrI+1uBba4A6LryYjDwkg9GXaajlbtnPpKZXEcsFDUQXug
 Hpyz0FQsqiXqs2nsHaY9dfnqg/hkcxC18JNbSFJkZJuwTZKBeSakhKtZShub/qxsna3M
 0whO+3SsnOfF6tegT3+d1TeRYerKzODCSFOfFcvgxkh/+Q7ZQjHGnXOUQSVLCGcUPG8P
 DhIA==
X-Gm-Message-State: AOJu0YxnTwfvslTUCX0Opp+O6euuqZyXFCGqLumDPKISfK0q5QnACRLA
 HJlcKaxTgtXMyr5qWeP0OtLUne3utgBvlkXj4WE9x8afPSTPkz1TRW0KxzMaw/iCFXk=
X-Gm-Gg: AfdE7cnb0nrs52y4POVgJ0cNJjS8X6i7IS35QkRB+y0+Wc3UdA/xYq07MI2lqJBrxo/
 7vgzOqAmbkSaXuoE5f4fweHd+KLpBfcLN+TobN0Kigw+ERkfWaM7HVp7eBi13IPhSw/cXDElheb
 0Z8ATHLbb4EeN8GSt/eB1krLiUHfRscuuPZpr/R0mLs1tqaZiFT+E1BfsvF9rV0WsF+m4GU+EQL
 XFXwK8GpR8mT6t9iV/Z8xZ/e98uLLq/a+9/PmZYbO4dGuoUcL/1mOsIL3x27OGO9UmoXEKAqxyi
 N6HFRcRif3Qei/W6WrxZvfK9i+uIn5xCBJxdoUC3iW5AxUreLxKV2Wz61sMjXOQJJvZue2IJ9UI
 gI8AlS3rnGSoDHU60q1LDS4w3etUEZrroUkZu/kA5Zky6DQpKYjk0uAZUm5oMkHKwKruPk12Ok1
 W7ogfenC0qKNK9kZ0he0qZ05TLgZbd10crt6/xHCNkrmc8czffzbcwLtVMyQ+PymhEg3CzJiHYN
 jSucIp1rQXML7MRygJt35W0IG2EK8FhUkwzXs/CVsJwb5yqD6lEWKs=
X-Received: by 2002:a05:6000:604:b0:473:66e2:37d4 with SMTP id
 ffacd0b85a97d-47ef6990c98mr20693974f8f.27.1784023952269; 
 Tue, 14 Jul 2026 03:12:32 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a9879sm7788927f8f.22.2026.07.14.03.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 03:12:31 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 Leander Kieweg <kieweg.leander@gmail.com>
Subject: [RFC PATCH 0/3] drm: Add DRM driver for GlandaGPU (VHDL soft-IP GPU)
Date: Tue, 14 Jul 2026 12:11:42 +0200
Message-ID: <20260714101146.200416-1-kieweg.leander@gmail.com>
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

Hi everyone,

This series adds a DRM driver for GlandaGPU, a custom open-source 2D
graphics core I designed in VHDL. It currently runs on a Cyclone V
SoC (Terasic DE10-Standard), with VGA output at 640x480@60Hz. I also
built a QEMU fork that emulates the same MMIO/VRAM interface as a
digital twin, so I can develop and test without needing the FPGA
board.

  Hardware/VHDL:    https://github.com/stiangglanda/GlandaGPU
  QEMU fork:        https://github.com/stiangglanda/qemu-glandagpu
  Userspace tests:  https://github.com/stiangglanda/GlandaGPU-userspace-tests

I'm sending this as an RFC because I'd like feedback on the
following points before cleaning up the series further:

1) Mainline viability of custom FPGA hardware

   GlandaGPU isn't a commercial chip, it's an open-source soft GPU
   core. The DE10-Standard itself is a regular purchasable dev
   board, and the RTL is public, so anyone can reproduce the exact
   hardware. Testing doesn't require the FPGA either, since the
   QEMU twin models the same interface. I know this is unusual
   compared to typical mainline DRM hardware. I'd like to know
   whether this is workable, or whether it's a dealbreaker for
   mainline.

2) UAPI / ioctls / userspace

   The driver currently exposes three fixed ioctls (CLEAR,
   DRAW_RECT, DRAW_LINE), mapping directly onto the current
   hardware command set. I have two related questions here:

   a) I plan to keep developing the hardware further, which will
      likely mean more ioctls over time (for example, polygon/3D
      rendering is one direction I'm considering). Is it acceptable
      to keep adding a new, separate ioctl for each drawing
      primitive like this, or should I move to a generic
      command-buffer submission model instead, similar to
      DRM_IOCTL_VIRTGPU_EXECBUFFER in virtio_gpu, before this is
      treated as stable?

   b) If I do end up with an ioctl-based acceleration UAPI, is
      writing a Mesa/Gallium3D driver the expected way to make it
      usable from userspace, or is there a lighter-weight option
      that makes more sense for a project this size?

3) x86 QEMU platform test device

   To let reviewers try the driver against the QEMU twin without
   cross-compiling an ARM kernel and rootfs, I registered a
   platform device at a fixed address on x86. I'm aware this
   doesn't belong in the driver itself, so I isolated it into patch
   3/3 and marked it "NOT FOR MERGE". Let me know if you'd rather
   see it dropped entirely, relying only on documentation of the
   QEMU-on-ARM testing path instead.

4) Pixel format conversion

   glanda_pipe_update() currently does a per-pixel software
   conversion from XRGB8888 into the hardware's native packed
   format on every flip. I'm aware this is a known bottleneck. I'm
   planning to extend the VHDL to accept XRGB8888 natively so I can
   drop this conversion entirely. I'm flagging it here as a known
   limitation rather than blocking on it, since it's a hardware-side
   change and doesn't affect the UAPI.

5) drm_simple_display_pipe vs. manual plane/CRTC/encoder

   Since the driver only has a single plane, CRTC, and encoder, I
   tried converting it to use drm_simple_display_pipe instead of the
   manual setup. It compiled cleanly, but my userspace tests didn't
   behave the way I expected. I haven't figured out why yet, so I
   kept the manual setup for this RFC. I'm open to revisiting this
   if that's the preferred direction.

Testing Status:

The driver has been tested and verified on both the QEMU fork (x86)
and physical FPGA hardware (ARM) using:
  - A custom static userspace test: https://github.com/stiangglanda/GlandaGPU-userspace-tests
  - `modetest -M glandagpu -s 36:640x480 -v` (which successfully
    displays the test pattern)

Thanks for any feedback,
Leander Kieweg

Leander Kieweg (3):
  dt-bindings: display: Add GlandaGPU binding
  drm/glanda: Add initial DRM driver for GlandaGPU
  NOT FOR MERGE: drm/glanda: Add x86 platform test device

 .../bindings/display/glanda,gpu.yaml          |  49 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/gpu/drm/tiny/Kconfig                  |  25 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/glandagpu.c              | 808 ++++++++++++++++++
 include/uapi/drm/glanda_drm.h                 |  40 +
 7 files changed, 932 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/glanda,gpu.yaml
 create mode 100644 drivers/gpu/drm/tiny/glandagpu.c
 create mode 100644 include/uapi/drm/glanda_drm.h

-- 
2.43.0

