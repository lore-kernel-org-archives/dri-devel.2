Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B97606A33E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ukipMRD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30AB310E0FE;
	Fri, 13 Nov 2026 07:53:37 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC02510E0FE
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:53:30 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3b12cb3c37bso266114a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794556410; x=1795161210; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6ZUV6tRnKnS42LZFZBhlQJ+eFn/2hJ53H3jt9WrofAQ=;
 b=0ukipMRDg5CEOt8JPAMJs0iT2sdsw5EO+mggKtqD4WeO6ZGs3L3KJ7eTczjpIRqjG6
 UWrw35at5tUmAF/GMqpNGswy2BbHNjzbYTg4I1jJntc/cfa/rcepi0eXsIQjGR7tdv7H
 gRbDonlCppWIiVobHCUQEa7+Mxd9H1F/qjLTdlIgzsLwA1Vs/6WcP12s3QlVbkubcH7P
 sxf14qa0HBO8bS4c7DbeyaJOSyaYGjIR+XuS1ZA3mutSYdeh+lSw2+YjAD9FYFAE9CBd
 pfxtd4NqEuNdl+b89gSqqFOIsYOuzvsyt3Ji+dlfg3Bbg7qNCHwI9KQoe6N1cPHDKd84
 I02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794556410; x=1795161210;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6ZUV6tRnKnS42LZFZBhlQJ+eFn/2hJ53H3jt9WrofAQ=;
 b=wvM0bHA6sfMjyuBdacsDNsrfcjA6ELfQLvRinH19kARBQqjOSTNxc2ty7XtF5jIcLb
 7y5W9JfBPFkDqXPwBgImbs6PPjMD+XsrRlORNBT1hBA2znofP0UHThetVk1pCR3Jk28/
 ZaH/aUtBZ2ofAPts5GSNjk6hgehoba1ASoMJ0YCkHAby8J1syXtVCACXIy3KBksAIL0t
 ZQLDW+AqGxYveFbMwN/bypI0w0fJauwtmJLesLUCFeqv31AtYIc7GcTqY3bS0+06lmIV
 lXxHeqbZc4xEeNvZL6ljA0BjXMD9/CjNkCNIwKsmVFjhffzJWWXeBCr3QReHFC+jghVy
 BeIw==
X-Forwarded-Encrypted: i=1;
 AL+hErGJpo5PrZI78yaTa9LHePb1cLEv2h2mE9Mx8jF2yUNDu7403tmD1PPmwncCb3LCnJBl41eWHTfnAWc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/yC56aGMgti24stcU3Jnu/BlmIJd3/K5Jtsgdxlm2pJKNrC9j+
 gthu/j0Nxv/CGwgzCaWcOru0sThj7wYHKP4RWK8+QjBuuYL/DPGyFNDC
X-Gm-Gg: AYBFou1DJUCCUsz0G23nPD42rQvAPvo2OC+243kDK30zGaBXKgH5cXqjxJq0pJtSWoN
 WY3qYGI9O/FPqroQrLZ2bp5tQMzB1T95AEhPZRlt77MqExLsRXKwcUGmTIU3XGgrK53kBley/VV
 K9ZewHWeINgV7ZPwU7GvAay6kC247YzqYG5VQqB5F6x3FXaWF2v7tYPd3b0GOZ82boxWXAXck4w
 X8rEVfjjWyAYiBGm+/3QGybGLMVG1eN4teRYAq9v5+ANmmREX6W/HrkOt+GU9s4LK2OjUUcB8cV
 8ohjWwEwG5J1ebkQ9tquDbx56KswWWRaWozBt3zll32Nfx3TEW48l+QI7BsR2ZLBrW+mupAxeVg
 UpqTNZ+WI/s5hKimFALWPKPymtbT5VCaQ6F5a61vpknOM522dU37VPh3yBAf/KINjCj8fYYYVPV
 9RhLJOQ4eA0QyhebTkLO5IxaAETaJ2m41KWut4+OcvWThSugy+hwOB9mKgUJD8DGnLQNo4KnYIh
 Y9K1c+xqICOf3LzJba5QYJsRiaTVf3lNlvfugpw58fec6SgPAvvyEJm2pB7hLlK94i/zUutAhaA
 8/G2wao76XctfHJ2yNnH+8kNS8RpecXwF04=
X-Received: by 2002:a17:90b:2e83:b0:3b0:a4d1:6d7a with SMTP id
 98e67ed59e1d1-3b1b0a1f08cmr1423738a91.31.1794556410033; 
 Thu, 12 Nov 2026 23:53:30 -0800 (PST)
Received: from localhost ([176.210.133.73]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3b708adsm993234a91.4.2026.11.12.23.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 23:53:29 -0800 (PST)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, vladazaharova2018@gmail.com
Subject: [PATCH v7 0/4] gpu: nova-core: retain the GSP-RM log buffers
Date: Fri, 13 Nov 2026 14:53:13 +0700
Message-ID: <20261113075317.934264-1-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The GSP-RM log buffers are exposed through debugfs, but they go away
when the GPU is unbound, including when probe() fails, which is when
they are most useful.

Patch 1 moves the debugfs root into the module data, which also fixes
the root being leaked when the driver registration fails. Patch 2 moves
the log buffer code into its own file. Patch 3 adds a gsp_keep_logs
module parameter that keeps a copy of the buffers after unbind. Patch 4
drops the completed item from todo.rst.

Changes since v6:
 - drop the "retained/" directory: the copies are exposed in the same
   files as the live buffers, and are dropped when the GPU is bound
   again (Danilo, John)
 - split the code move out of the retain patch (Alexandre)
 - move DebugfsData into debugfs.rs, make the accessor
   NovaCoreModule::debugfs_data(), reword the comments around
   DEBUGFS_DATA as invariants, add a Fixes: tag (Alexandre, Danilo)
 - shorten the commit messages and comments (Alexandre)
 - rebase onto current drm-rust-next

The code and the commit messages were drafted with an LLM coding
assistant and reviewed by me. Each patch builds on its own, and the
series was tested on a GB203:

  - without gsp_keep_logs nothing changes;
  - with gsp_keep_logs=1, <BDF>/{loginit,logintr,logrm} keep the full
    64 KiB of each buffer after unbind, show the live buffers again
    after the next bind, and a second unbind replaces the copies;
  - with a failure injected after the GSP has booted, probe() fails
    with -EINVAL and the logs of that attempt are still readable;
  - with a failure injected into the driver registration, the module
    fails to load and leaves no debugfs directory behind;
  - 40 load/bind/unbind/unload cycles use no more memory with
    gsp_keep_logs=1 than without it.

v6: https://lore.kernel.org/nova-gpu/20261014154554.231015-1-vladazaharova2018@gmail.com/

Vladislav Zaharov (4):
  gpu: nova-core: move the debugfs root into the module data
  gpu: nova-core: gsp: move the log buffers into their own file
  gpu: nova-core: gsp: retain the GSP-RM log buffers after unbind
  Documentation: nova: remove completed GSP log buffer task

 Documentation/gpu/nova/core/todo.rst   |  12 --
 drivers/gpu/nova-core/debugfs.rs       |  44 ++++++
 drivers/gpu/nova-core/gsp.rs           | 100 +++---------
 drivers/gpu/nova-core/gsp/logbuffer.rs | 204 +++++++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs     |  68 ++++++---
 5 files changed, 311 insertions(+), 117 deletions(-)
 create mode 100644 drivers/gpu/nova-core/debugfs.rs
 create mode 100644 drivers/gpu/nova-core/gsp/logbuffer.rs


base-commit: 0ff9e5b9ff6736c37593cd7db89f4593ec4f8e86
-- 
2.56.0

