Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5370C5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A20A10E2FE;
	Sun, 16 Aug 2026 14:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XrlMMTVk";
	dkim-atps=neutral
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F0810E133
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 05:08:31 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-39faa67fab8so11270071fa.2
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 22:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786770509; x=1787375309; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+Ki1f29ZNNzrhAw8g31VS5wgylnUVVZbopDUMwHeVLM=;
 b=XrlMMTVkYyE6vavbVZWTd0agzPziqs+AuC0WLKiWtegYoAz0205lokqUXVUhXf/y3h
 H1Vg/Ox8jSj8avVaClisyfHxFmcbtfPGk7lyxQw/BUV3tCqLPTVLcWe81xwIYVjbft6+
 cNcicPqOXpGZAzj5z/zs7t1dzZ8KQ6IUMh645wlsxkL0AS5NV4RYTK77u3+TcAQL22bH
 gmkLTzHLlG5QAHu7ttghq9qGxSnMTacDokg+VDYmy8kQrbaBRHH8MPhVQPj/6uvDWEPc
 04JpUziKbhS7I8SkaIvoxEVxNw0RiASc9SIOA/yriVzrlxIEVNGZcEvp1lvNN7vb9HMm
 PbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786770509; x=1787375309;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+Ki1f29ZNNzrhAw8g31VS5wgylnUVVZbopDUMwHeVLM=;
 b=Sg7h1SfuUw4aANLqdS9U1dG6V/CMDplPAMVx2mciss7BEuPjgMt+Q7f8M7EXI5zjx+
 UfSbR+qr3s+GjT/3VKSM0N/zcQSoL+fwsw6xPgEuTjVSsTf/O1Bwmi3N2zn0mnAS5nVi
 KJk4iLTYixsof52AhQE00bx3ec19+IwIb4DojKyW2iL+09Xcs6C9tCsa15YeF6kpTdpF
 PA/0VZHgteyJbtB71Bg5p4DmW8lPOycn9UKR1qP6vzyCGx3AZdx0zRFobl4+A7REO0Je
 yCv29dcaj7VSda+anHAMJ7+9fefvygnvsQxegfCNcOJnPubUDOWaScnDXFskKqjwcP49
 qZKw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEdzvKRtesE62mJan1YOl56g6YvUCQfpWetjp73YOIRzzz8S6JgP1BO36Ge8kOzP25XXDN7E1EcXw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3wmZRp/Qwn6aqryHjuACR7klby1xy9AQpcDWAlQscWCIVpU5S
 lytqKyTpnrTgYsSWfaDCZKYkIHkJ+GYjpMyVw9sZMZ4v2OTri7rdL9UP
X-Gm-Gg: AR+sD101/55vsMHvht7ZRRXczN+bQNra8wBJXWI/brALU5z0WQ8VkJYpv3QTo4emjsW
 Ui+NqwozRz6H6BJEFYXCfaYyYRjjM+W9FYS9smGFG3rGKzr1lfYPs4UIGS7+/T694uX2J7bfL72
 aDcU8+NlE3vaa+0bZsXcYGIhwDQWnbh/w6F14y80RxLiVjltEXi013evwRPXGXnu/DAaDUa4PbR
 fzyXLqWJv9mlKII+2VgHeG9TXQlX7xrw19FmjflQWz7aWNb3cg6/hersAjOhpIS37v1IBW8V7jd
 Pz4YiLcyIocMm014GQI1EweniTpjH6IaRTmiiV4Ck//JZe7WwyauLqxhV8PIQ7Vu6vPmFRbxC0f
 dcuvfw7gqhSzTWXyU4+Y/2Sg1+O8Kl1SPA2PopziPokK3YAnQZr9tCt2tffjVWjkLVyvyN0fGua
 3Vzhw7gnerEb42YSszrclBU6qQnN74c/WyBm1kA4a/OD2QlsYkm5LLhPIomELllCNiPktzTWVWS
 4mqyA==
X-Received: by 2002:a05:6512:3da4:b0:5b0:1879:1b9d with SMTP id
 2adb3069b0e04-5b45913b940mr1711971e87.26.1786770508996; 
 Fri, 14 Aug 2026 22:08:28 -0700 (PDT)
Received: from localhost ([95.190.110.153]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b458b9a9a7sm932354e87.13.2026.08.14.22.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 22:08:28 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Vladislav Zaharov <vladazaharova2018@gmail.com>
Subject: [PATCH v2 0/2] gpu: nova-core: retain the GSP-RM log buffers
Date: Sat, 15 Aug 2026 12:08:24 +0700
Message-ID: <20260815050826.306717-1-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

The GSP-RM log buffers are exposed through debugfs, but the entries are
owned by the Gpu that probe() builds, and the buffers themselves are DMA
allocations that cannot outlive the device. They are therefore gone as
soon as the GPU is unbound, and in particular as soon as probe() fails -
which is the case todo.rst singled out, and the one where a GSP log is
worth having.

Patch 1 adds a gsp_keep_logs module parameter: when it is set, whatever
the GSP wrote is copied into memory owned by the module and exposed
under a "retained" directory until the module is unloaded. Patch 2 drops
the now completed task from todo.rst.

Changes since v1:
 - use a gsp_keep_logs module parameter instead of a Kconfig option, so
   that no kernel rebuild is needed
 - use VVec rather than KVec for the copies
 - move the log buffer code into gsp/logbuffer.rs
 - create the "retained" directory in module_init(), which removes the
   additional unsafe block from the teardown path
 - dev_dbg!() instead of dev_info!()
 - take every allocation that can fail before dropping a previous copy
   of the same device, so that running out of memory cannot leave that
   device with no logs at all

Two things did not make it into this revision:

The parameter is a u8 taking 0 or 1 rather than a bool. bool is not
available in this tree: the macro fails with "Unsupported parameter type
bool", as rust/kernel/module_param.rs only instantiates param ops for
i8..u64, isize and usize. There is a TODO in the code to switch over
once it arrives.

The dma_rmb() discussed on v1 is likewise not here yet, as the barrier
abstractions are still making their way in via the tip tree. I will send
it as a separate patch once the backmerge has happened.

Testing was done on top of drm-rust-next with the TLV firmware images
installed, which also settles the question left open on v1 about the
older base. On a GB203:

  - with gsp_keep_logs unset, no "retained" directory is created and the
    entries disappear on unbind, as before;
  - with gsp_keep_logs=1, retained/<BDF>/{loginit,logintr,logrm} hold
    the contents the live entries had, all 64 KiB of each readable;
  - binding the GPU again recreates the live entries without disturbing
    the copies, and unbinding it a second time replaces them, leaving
    exactly one set behind;
  - with a failure injected after the GSP has booted, probe() fails with
    -EINVAL, the driver stays unbound, and the logs of that attempt are
    still readable;
  - the copies are released on module unload, and three load/unload
    cycles leave nothing behind.

No warnings, oopses or refcount complaints in dmesg throughout. Built
and checked with CLIPPY=1 and rustfmtcheck. checkpatch --strict is clean
apart from the MAINTAINERS note for the new file, which is already
covered by the existing "F: drivers/gpu/nova-core/" pattern.

Vladislav Zaharov (2):
  gpu: nova-core: gsp: retain the GSP-RM log buffers after unbind
  Documentation: nova: remove completed GSP log buffer task

 Documentation/gpu/nova/core/todo.rst   |  12 --
 drivers/gpu/nova-core/gsp.rs           | 100 ++---------
 drivers/gpu/nova-core/gsp/logbuffer.rs | 235 +++++++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs     |  28 +++
 4 files changed, 282 insertions(+), 93 deletions(-)
 create mode 100644 drivers/gpu/nova-core/gsp/logbuffer.rs

-- 
2.55.0

