Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDD3C43327
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06C1410F616;
	Fri,  3 Jul 2026 03:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="COwpx01v";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6CD310F616
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:02:54 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-475417f010dso40703f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047773; x=1783652573;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QnRIGpd9LFK9d5U1y9xNKUj2Bxx5+4E/zuaNAi10W6o=;
 b=COwpx01vq1yKajSYqDE9C+nztyLH+CU2pgEPCHvmh20rCSI71m2BV/prquytW0VB/n
 EA6j+J7ghU8Yp8Tkt0NKqlYHRJ7jZu3NND2CiCLvFuLl46N6vOP5L9YXqIM/YMFie8rn
 m3KGCrlZsSJrVk6/isqQQ9nCzCtXr0pUN3VbMHujhBCMF60y3Dc5T7ixtXnXfezlcvn9
 VNiZO+7bSi4ugU2z42DJQ/ONv6sNQEwQnCu9x+k2gQToeUTEhRiJ78L0jU8E/ja3S2Yr
 WxbGQFDUfp6NTQAesACkvfYcNoMFpykmWMTJDjmlkn06yUUi0v52bfmWYIwnBXJQWhtz
 QnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047773; x=1783652573;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QnRIGpd9LFK9d5U1y9xNKUj2Bxx5+4E/zuaNAi10W6o=;
 b=CjjKrXozuSznjVFm3WJfuqSw0qT6wp1mfWXGrk9lT0hHBib3AQWw7y+UeGwGUdNqpQ
 +aM1+aoizBIckpu3FqMBXDlrA2gd0A7QUz+VXtoNmIttuC0dS9s9OVGB1oJgjnUR6D0J
 hj1M2ALvVg9Ai52ivAbimZ6t3ItRTkJFVRGZy7go+m0yHh8CX0Qj3j/zrJ42H4OdXcfD
 DtIxid8e61kJS874KRZ77oOnbdrLJe3l25gEErr23wbGGttzqMqC6d97UY7eWL69A/Uv
 G1i6LNU8hBYv/oDla6Y52zEv29b1rdees1T6diMR/S3llMQqIGOOn4fWl5c7KkS3zqyY
 zkEQ==
X-Gm-Message-State: AOJu0Yz7I/phnZb5RRGKPAMgdT41qGj13WmGgfE0vk0CGEl78rpWBhCl
 OP5oqZR1TOZg26rgSDRlgfLwzkH71p+AjXftHbdj2Snz8KX4A5CVZypS/CYFj8g3FDVcOwC2XkK
 TCTGiykMF
X-Gm-Gg: AfdE7cmU3VAC9x9jB2cGc/lElJPDgQxVA1yNQgCndoegIwUglntN2pdQZLSpwFKjQbQ
 k0dl9od+Pu8xq978Hx6tCqwXQYbHHzme2TWYF4exrdBodnnfmD6zvnpo2LANc1fl7YfH7m/bSta
 M6Ct69h564ZOB6J2DDt8eId5HRwb9lG7fTXy2+/TOCxWVUxD8t/ipCFLe8CNIHvx/RGjp7+JhEY
 3p/85oEeSO23Y/Zcs0UTxk8WLjI1OtbEAC8Nu3VECpFXIUVsB6KYjTyrotfTptG2zoP76nt9VdU
 CHMDG+ZkTop05Tmzm5tuj3jY7wAea/H9/yohIxxmTt+d6L0kyLeMStEzDUB8JvkMW3LkW+UMhZh
 ucRyPVcHMBnIU8i0tU3e25uFy9enve6wwZq3hlzcWWR/ZpQeItfJzjExxDJzusgFvRMGy3cVBRn
 uy67GAuG2de2A/v7OPFo0fPO9ocBXkMP2K81D2nkrKnskdAsaYdKezfzet
X-Received: by 2002:a05:6000:2410:b0:465:81cb:bb20 with SMTP id
 ffacd0b85a97d-477571cb83emr12354121f8f.9.1783047773100; 
 Thu, 02 Jul 2026 20:02:53 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dde1a4fdsm15198199f8f.26.2026.07.02.20.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:02:52 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: rust-for-linux@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 linux-kernel@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [RFC PATCH 0/2] drm/evdi: a Rust EVDI virtual display (a working KMS
 consumer)
Date: Fri,  3 Jul 2026 04:02:45 +0100
Message-ID: <20260703030249.2949-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
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

evdi ("revdi" as a project) is a from-scratch Rust rewrite of DisplayLink's
out-of-tree evdi module: it presents virtual DRM/KMS displays whose scanout
is pulled by a userspace daemon over a drm_event + ioctl ABI, rather than
scanned out to local hardware. It identifies itself to userspace as "evdi"
for compatibility with the existing libevdi / DisplayLinkManager stack (an
ABI-compatible Rust rewrite of libevdi lives in the standalone project and
is not part of this posting).

Why post it as an RFC now: it is a *second, working* consumer of the safe
Rust KMS mode-object layer and the evdi/KMS bindings in the companion
series ("[RFC PATCH v2 00/18] rust: drm: safe KMS mode-object layer + evdi
bindings"). The other consumer posted alongside it, the vino DisplayLink
DL3 driver, is blocked at the dock's content-protection wall -- it never
gets the dock to engage its encrypted control plane, so it cannot prove
pixels actually flow on real hardware. evdi drives real monitors end to end
*today* under KWin/Wayland: multi-head output, live delta-damage updates,
a hardware cursor, DDC/CI, and clean teardown on unplug. So where vino
exercises this binding surface but can't demonstrate it, evdi does -- it is
the working validation of the same abstractions.

  1/2  drm/kms: three fixes to the safe Rust KMS layer, shaken out while
       bringing evdi up (a dangling mode_config vtable crash [RIP=0x9], a
       stale-cache coherency gap in the Framebuffer::vmap() guard, and a
       leaked-connector teardown). All are equally correct for vino and any
       other KmsDriver.
  2/2  the driver itself, under drivers/gpu/drm/evdi/.

NOT FOR MERGE AS POSTED: this depends on the not-yet-merged Rust DRM/KMS
bindings (the companion "rust: drm" series and the sync/DRM-registration
prerequisites it in turn depends on), so it does not build against mainline
as posted. It is sent to validate the binding surface with a driver that
works, and for review of the approach. Source:
  https://github.com/FireBurn/linux/tree/vino
  https://gitlab.freedesktop.org/FireBurn/linux/-/tree/vino

Mike Lothian (2):
  drm/kms: rust: fixes for a virtual KMS consumer
  drm/evdi: add the Rust EVDI virtual-display driver

 drivers/gpu/drm/Kconfig            |   2 +
 drivers/gpu/drm/Makefile           |   1 +
 drivers/gpu/drm/evdi/Kconfig       |  20 +
 drivers/gpu/drm/evdi/Makefile      |   2 +
 drivers/gpu/drm/evdi/ddcci.rs      |  43 +++
 drivers/gpu/drm/evdi/evdi.rs       | 405 ++++++++++++++++++++
 drivers/gpu/drm/evdi/ioctl.rs      | 248 ++++++++++++
 drivers/gpu/drm/evdi/kms.rs        | 589 +++++++++++++++++++++++++++++
 drivers/gpu/drm/evdi/painter.rs    | 199 ++++++++++
 drivers/gpu/drm/evdi/uapi.rs       | 210 ++++++++++
 rust/kernel/drm/driver.rs          |  24 +-
 rust/kernel/drm/kms.rs             |  12 +-
 rust/kernel/drm/kms/framebuffer.rs |  24 ++
 13 files changed, 1764 insertions(+), 15 deletions(-)
 create mode 100644 drivers/gpu/drm/evdi/Kconfig
 create mode 100644 drivers/gpu/drm/evdi/Makefile
 create mode 100644 drivers/gpu/drm/evdi/ddcci.rs
 create mode 100644 drivers/gpu/drm/evdi/evdi.rs
 create mode 100644 drivers/gpu/drm/evdi/ioctl.rs
 create mode 100644 drivers/gpu/drm/evdi/kms.rs
 create mode 100644 drivers/gpu/drm/evdi/painter.rs
 create mode 100644 drivers/gpu/drm/evdi/uapi.rs

-- 
2.55.0

