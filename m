Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25579CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6690910E9DB;
	Wed, 14 Oct 2026 15:46:13 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64B2210E9D9
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 15:46:07 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cc52c1b8286so2645610a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791992767; x=1792597567; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=guVsG4hFn4zNEbHwQhhELW9kDSSxFBpoASzURJMZkH8=;
 b=JFQ6+0+JCPZIWRyKQuDgbG9IFWMTAQWRg/deeBprT2Ykg1Am/xMKDAoYJfS22BLXuD
 5c25OE/OX3P6u2R3PfGT3hdtLiO0AL49AS3h2tQu5DI00j6Ps2Fm+gIFzQY5ItQUlYEy
 JyUAk/oV/EyKuK8fu8N/LZdX5XqfSkCnKii8nW6PMlhnF0POULI5mWuZgPHqq1Vis14k
 09fn4LJn0ghyy/XfrcH2FaGWCB7dED1lxM/yZXFjRWIW4ZpxdTkbTdh91kyYjofBbFbC
 BFK7eVIn9n92Hq/259zdMb8bpSrOzMlSTIC1Jgpw2TGICBnilbdllTjAZY1saiz8RhvZ
 XOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791992767; x=1792597567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=guVsG4hFn4zNEbHwQhhELW9kDSSxFBpoASzURJMZkH8=;
 b=E+p80iMQD0FEFQ66NDsy4dHhrwydAcv3G2OofDfV7tQX9RoM9fzCpzYUmy5KJaxl8d
 /VyZvRTTCKllY6FTSgFKVJUUbdV0P//tnkprvvagGShXruTtj7fLe8VSbiS4BBoPyD2M
 96q/y7PJ15xwFk3oOZGrF3Sa5MFdMSWCpv0xveLcKxrLzqw8XXG3T9JfD0J3trw4WcoC
 fKfUd6ddU0s3NRNyJUCP7Dg0pRs0uqcUQN3KpRQMTFSygsCEPBhCSOrdlKrPfQWozY2W
 oFhzdhzVm0Tpbv6a53o+wdsgQxcXMiPyn7MxEwq8mHRZkdiqeLItNMR/MS4E9NqPOBxv
 ULGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzW/h6IsFs8g7n9drMmoSVRB8nBmRwvu2NH4EJwuvhCF1ODtNIwGOEIwbX3Q5G2i9LFo0kkX/BwjAE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKhpUVaGCnbbAtSPXiNdBXzWDHJN1AwFx0umRlJupKPfZeSp89A
 P/DxZ7myJ3AImbqBU8iZy2qMESQAWrlvtmlAnPtCfqMQU+U6E/RfTqtA
X-Gm-Gg: AYBFou0vaoX7nbNYHvtPrndWUGXZQT4UsMC0wjvY1plwmqORdte5I4LZNchHTvWS4zv
 OfUnvsZ8YWwcJajlLW+/RkpeeAoeIh+uKKQCz94OiH+aIVcl1fLPRLw5+iRvOsoWYwSpbHHY7k3
 rQj+TPb1GOBg0Lh4mJ9CCK6X8fLV0gf1QveMIKJxUplqfHg/qEPR/5AL0vapIjXZQlcQodi/v5d
 j2sN8JzRQhRGN49VljVUo+OBQI361FTE8ZeuaObHVkrVgkKW8i40JqsdH9jRgpLwLk6OodWfp6b
 a7Iv6LVTWjVLgN9c1HqMaNxXYkPHBb7GpsU/0xYkehzwQCKdc8Ry1UVEVfOA2Io/eMCXtFvQAWi
 6IhXCEOm/futWenjrozkkTVC0y5gY7H2c1nyN0Mx1ZgGf6cYfvNcsAklTWcRytZNx3tYrJNj6Gb
 7MCm2itOFieZMaA5ceroaSInKFZS7ydc8gXQp9RgJjtD03ALrMaaEX2ihOnzfqcLDjiq04Tuk9S
 eo2
X-Received: by 2002:a05:6a20:a11f:b0:3e1:3734:63e0 with SMTP id
 adf61e73a8af0-3e16bec52eamr10308336637.41.1791992766832; 
 Wed, 14 Oct 2026 08:46:06 -0700 (PDT)
Received: from localhost ([37.22.102.248]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89d80511db9sm1300598b3a.56.2026.10.14.08.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 08:46:06 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Vladislav Zaharov <vladazaharova2018@gmail.com>
Subject: [PATCH v6 0/3] gpu: nova-core: retain the GSP-RM log buffers
Date: Wed, 14 Oct 2026 22:45:51 +0700
Message-ID: <20261014154554.231015-1-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The GSP-RM log buffers are exposed through debugfs, but they are DMA
allocations of the device, so they go away as soon as the GPU is unbound,
and in particular when probe() fails. That is the case todo.rst asks
about, and the one where a GSP log is most useful.

Patch 1 moves the debugfs root into the module data. Patch 2 adds a
gsp_keep_logs module parameter: when it is set, whatever the GSP wrote
is copied into module memory and kept under a "retained" directory until
the module is unloaded. Patch 3 drops the completed item from todo.rst.

v5 got no comments, so this version only carries one fix and a rebase.

Changes since v5:
 - keep the "put" pointer read before the barrier in the copy, rather
   than the one the copy reads again, which is not ordered against the
   rest of the data (reported by the Sashiko review bot)
 - rebase onto current drm-rust-next

Tested on a GB203 on top of drm-rust-next with the TLV firmware images:

  - without gsp_keep_logs nothing changes, and no "retained" directory
    is created;
  - with gsp_keep_logs=1, retained/<BDF>/{loginit,logintr,logrm} hold
    the full 64 KiB of each buffer after unbind;
  - binding again does not disturb the copies, and a second unbind
    replaces them, leaving one set;
  - with a failure injected after the GSP has booted, probe() fails with
    -EINVAL and the logs of that attempt are still readable;
  - with a failure injected into the driver registration, the module
    fails to load, leaves no debugfs directory behind, and the next load
    works;
  - repeated load/unload cycles leave nothing behind.

No warnings or oopses in dmesg. Each patch builds on its own, and the
series is clean with CLIPPY=1, rustfmtcheck and checkpatch --strict
(apart from the MAINTAINERS note for the new file, which is already
covered by "F: drivers/gpu/nova-core/").

v5: https://lore.kernel.org/nova-gpu/20260923045551.229259-1-vladazaharova2018@gmail.com/

Vladislav Zaharov (3):
  gpu: nova-core: move the debugfs root into the module data
  gpu: nova-core: gsp: retain the GSP-RM log buffers after unbind
  Documentation: nova: remove completed GSP log buffer task

 Documentation/gpu/nova/core/todo.rst   |  12 --
 drivers/gpu/nova-core/gsp.rs           | 100 ++--------
 drivers/gpu/nova-core/gsp/logbuffer.rs | 255 +++++++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs     | 101 ++++++++--
 4 files changed, 356 insertions(+), 112 deletions(-)
 create mode 100644 drivers/gpu/nova-core/gsp/logbuffer.rs


base-commit: 5a1b7121a6c4db6c0239d3ac3fd1c2bb33a40025
-- 
2.56.0

