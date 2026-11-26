Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F09B606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pZdiuGc0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE2E10E4EC;
	Fri, 27 Nov 2026 08:29:15 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC69112703
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 20:58:16 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so72307455e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795726695; x=1796331495; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bVF2Aml6UGa7N1lcHjm2DlZyvQYza3JyQ52ICFi1d40=;
 b=pZdiuGc0tZ4IVU8MTMJ4hopgRQTnYDvh4uvcHHh6bbfDAwM6x1kwAjpODl7LqpaBYP
 LuNXCT8dB4ozNGXDd9ujvTxCKD9/pVPU1JTD+C9eD25CBYTZ8g6l0mpRb7vc82+XSvcB
 0Q7z0/kJ+0wM841KUP39TZKFzOjI2+UEYfd/mo29LrzbKmQ0Zu+mTYNFYOiwR8qA5N8B
 B6jb+E5tyZneODnk6YhdT1i3SEhVJwRIm9steqIfteqX+HCmXqSW+T8PK4MHi9vTBobC
 eWazqEZHfxpTJJ+LH8kQLAOyk+HqL/IcLfn+La9SXR0Oce+eqkMrROnd0eaM28k8qkFZ
 tLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795726695; x=1796331495;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bVF2Aml6UGa7N1lcHjm2DlZyvQYza3JyQ52ICFi1d40=;
 b=yy1UO9OmNNhwEsHFpG6U/P82NVHj9fsV28rwVoiqjSCHsmxKjfB2KmnJO9l5Ns/8r4
 gsV16o9H0VyX5kNevP6+DpyJ0KtoyA3GX7bArFqCaxbCTP6noVXUJwjdBEYOWDn1YmjW
 W2QirLyE/eyTDB0M3ZXfgwBGfKD7SEpQAlESyIJKPSc+F8k2vSLhHhxR8/m36aaPDDgT
 KHXrdMU1ADCcI7yn2c0uIv1830wj8jdngpUP61+JR79SFJiC5H3Ezc8V+vtvqNwBbHJR
 x33SqDPALxPa/8hT7d3FCjyc110umZa4BeJJejgfnSioaCoRpO6xD94dPi0L4BDP+XRR
 j9cA==
X-Gm-Message-State: APuU4Z8gyVkY1JykJ5gb/iqUq+pDAhpZerY0llJgcbS5fPqoo9C5YtKf
 9jLhhtLvAO9R1TGWBwytzbkTdizluSaX6FtQTvaUV3wxq2XWe2aATH18
X-Gm-Gg: AZFdTZfINriYUn2QNtHo6iJ1e1tO+UpWoS3orkQ7arRv2nmx4TadN0cGh/ZQmmRNkAF
 TCF8AwBYN5o7W/psOxW5McEorvGmmhA4p5pi20FttHzkgvCrP0m9+kNtAh5Ma0UW+mH+rCKChPL
 MBK2ryV/ZgYnDfFrVKoTbdYYZVVv/APTcN/2NOdB33HTE2gOblxyqFbOaKbKY3JCBgEG90Bxljy
 srgEmt5f5OQLx8CfNbYXO3mO6DLufOFpUgE6CnicSVsg0ci68NkitN4r+/kn5culY3B380VVwbP
 qPOXfHEROTuA+IscEybz79zE45Z9zkZaSsT1DTtQgvAK/z6Cgim3J7acQnk2ZQ46kHJHU5/+zhV
 OKuziGkU3TYbX5UMiSWlMqCIrrk7QT35S3uOaBRMk+sC1/F+czLn5QFf8++6U5DTTMkpAC3NiL2
 Ypk7BfRZ8uPGD5ZbCA/ZHZr/nopukZJR1xDCQVBVED2wa8nctbmdTQaH+U2wgM2PyZSN7uivF8h
 UPIsphgjtl+9s3caeFYoxJrDaboqgKqNal1X8w+JjcsdZC0eMtu5eEIku8c80v5HyQBD8kNY+HZ
 mV9EjSKA1XBloZrQC/acEps+VFdDWFxzAPa9bs6WpMDUzVhUVb5ShRCVUoxi2P+dHWrQh8V1TUZ
 uwaq/h+VrPrJJLN4UwALWOFYw
X-Received: by 2002:a05:600c:848d:b0:4bb:52d8:73ef with SMTP id
 5b1f17b1804b1-4bb88940f1bmr445978055e9.34.1795726694400; 
 Thu, 26 Nov 2026 12:58:14 -0800 (PST)
Received: from localhost (2001-1ae9-5b-ad10--33.ip6.tmcz.cz.
 [2001:1ae9:5b:ad10::33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb85399d52sm611178075e9.6.2026.11.26.12.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 12:58:13 -0800 (PST)
From: Arisa Snowbell <arisa.snowbell@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
 Arisa Snowbell <arisa.snowbell@gmail.com>
Subject: [PATCH 0/5] drm/xe: load the DG2 HuC through the GSC via mei_pxp
Date: Thu, 26 Nov 2026 21:57:52 +0100
Message-ID: <20261126205758.49845-1-arisa.snowbell@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On DG2 the HuC is loaded and authenticated by the GSC, through the PXP
client on HECI1, so xe has never had a HuC there: VDEnc encode with bitrate
control (CBR/VBR, used by the media driver, QSV and anv's Vulkan Video)
does not work on DG2 under xe. This series adds the path i915 uses:

  1. xe exposes HECI1 to mei as "xe.mei-gsc", with 4 MiB of VRAM as the
     GSC extended operational memory and its interrupt routed.
  2. mei-gsc binds it.
  3. xe registers as the I915_COMPONENT_PXP component and, after every uC
     load (probe, GT reset, resume) and when mei_pxp binds, asks the GSC
     to load the HuC with PXP43 START_HUC_AUTH through gsc_command(). The
     GSC hardware stays with mei.
  4. As i915 does (i915_request_await_huc()), video decode jobs wait on a
     fence of the pending load, and the HuC version query waits for it too
     (interruptibly, at most 10 s), so userspace probing at init does not
     see a HuC-less device. The uAPI doc says so.
  5. The DG2 blob (i915/dg2_huc_gsc.bin) is selected; only this patch
     changes behavior, so the series bisects.

If mei_pxp is missing or does not bind within 10 s, the HuC stays unloaded
and later loads stop waiting for it until it binds, like i915's
INTEL_HUC_DELAYED_LOAD_ERROR. A failed setup leaves the HuC unloaded and
does not fail the probe.

I know the stance from issue 234 is that i915 is the driver for DG2 and
that xe does not plan to enable the HuC there. I'm sending this anyway
because DG2 runs well on xe otherwise and the HuC is the piece missing for
media on it; if it is still not wanted, I'd be glad to hear what would
make it acceptable. MR !361 on the xe GitLab tried the same and reviews
there asked for what this series does: media waiting for the load, the
GSC left to mei through mei_pxp, and suspend handled while a load is
pending.

Tested on an Arc Pro A40 (8086:56b1) with the same patches applied to
7.4-rc4 (the only conflict was an include line):
  - boot: mei_pxp binds ~1 s after probe, HuC 7.10.16 authenticated,
    huc_info RUNNING; h264_vaapi CBR 8 Mbit/s gives 7.95 Mbit/s
  - GT reset (force_reset_sync): HuC stays RUNNING, CBR as before
  - S3 suspend and resume: mei_pxp re-binds, HuC RUNNING, CBR as before
  - runtime D3cold (the slot's ACPI power resource goes off), three times
    in a row: the first encode after waking runs at CBR as before, HuC
    RUNNING
  - anv Vulkan Video and iHD (VA-API, oneVPL) encode with rate control
Each patch builds with W=1 on drm-xe-next; checkpatch --strict is clean
apart from the MAINTAINERS note for the new files.

Known limitation, the same as on i915: a GSC command that never returns
holds up a reset or suspend in the stop of the load worker until mei
resets; decode submissions do not wait on it past the 10 s deadline.

Copyright: I'm not from Intel and unsure how the header of the new files
should read. xe_huc_mei.c is adapted in large part from i915's
intel_huc.c and intel_pxp_huc.c, so it keeps "Copyright © 2016-2022 Intel
Corporation" and adds my own line; xe_huc_mei.h carries only mine. Please
tell me if it should be written differently.

Tools: the code and changelogs were written with an LLM coding assistant
(Claude) in a long interactive session, from i915's implementation, the
xe sources and my description of what to build, and reviewed by a second
LLM pass. I reviewed, tested and debugged everything on the hardware
above, and I'm responsible for it.

Arisa Snowbell (5):
  drm/xe/heci: expose the DG2 HECI1 interface to mei
  mei: gsc: bind the xe HECI1 device
  drm/xe/huc: load the DG2 HuC through the GSC via mei_pxp
  drm/xe: hold video decode work and HuC queries for a pending DG2 HuC
    load
  drm/xe/uc_fw: select the DG2 HuC blob for a load by the GSC

 drivers/gpu/drm/xe/Makefile           |   1 +
 drivers/gpu/drm/xe/regs/xe_gsc_regs.h |   1 +
 drivers/gpu/drm/xe/regs/xe_guc_regs.h |   3 +
 drivers/gpu/drm/xe/xe_exec.c          |  13 +
 drivers/gpu/drm/xe/xe_heci_gsc.c      | 171 +++++---
 drivers/gpu/drm/xe/xe_heci_gsc.h      |  27 +-
 drivers/gpu/drm/xe/xe_huc.c           |  16 +-
 drivers/gpu/drm/xe/xe_huc_mei.c       | 569 ++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_huc_mei.h       |  21 +
 drivers/gpu/drm/xe/xe_huc_types.h     |  57 +++
 drivers/gpu/drm/xe/xe_irq.c           |   2 +
 drivers/gpu/drm/xe/xe_query.c         |   5 +
 drivers/gpu/drm/xe/xe_uc.c            |   7 +
 drivers/gpu/drm/xe/xe_uc_fw.c         |  14 +-
 drivers/misc/mei/gsc-me.c             |   5 +
 include/uapi/drm/xe_drm.h             |   5 +
 16 files changed, 859 insertions(+), 58 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_huc_mei.c
 create mode 100644 drivers/gpu/drm/xe/xe_huc_mei.h


base-commit: fc2a3dd1a3a2105f34e2f5c7a3e21f82fc0a0851
-- 
2.56.1

