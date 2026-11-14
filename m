Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0417D606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 04:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uUGRBiqG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C2D410E3C2;
	Sat, 14 Nov 2026 04:43:23 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8855410E3C2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 04:43:16 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3ae7626d14aso864603a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794631396; x=1795236196; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NiLyLycHtB+4ZXXMT4vdH4DfsyKDD4oOgAOd0xeeHHI=;
 b=uUGRBiqGulkv/CktVvcOv6DhHavRYTFqe2giGGREFmLCrRYPWsdcoauwOoFqBj3fo+
 gySs+cuNPYeAGyQZaC9jF2iuD3lMk5GyOcSjf4VFJGnVe5pcLnOOUpXx5h5v6LNHPECq
 kuogOo91o9OXDSWgC83/lrbGOYxu08WcbCELlZ0BY9InQYbHicp5eyAXTl+J/aT7bCDf
 UIVMg0X17BV2UREILkDU888rsw3tdHenIvhgIlQ4eGbGuXRWaiXEwGVr9BqYCjdIyIpV
 YBbjoeNd1B4GpBY1V0Xg/AW/fBttkTRTP0rVJWVxwsnRpIviK5P8+GaooJdQFVbMEWkt
 3fvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794631396; x=1795236196;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NiLyLycHtB+4ZXXMT4vdH4DfsyKDD4oOgAOd0xeeHHI=;
 b=tNXwMUiSeQahZnd7XH01EtrqsmuJKsoiRSvJvuTpx9JpRIDc+5YN9lnNMF/iQkJzjU
 Zq5aEBHle3MP8tkStIc+ntU29E2NmuJooXz3oRPduFFzcX4UYKdrNHQdr1LyNUKbxeDa
 vuuVBlMIcF/FQsbPvhPKDZiy6C/fCTwcSarWkDpeZTwKc3R0LlYLurQmKFLNyRF6omUI
 iaLExxasLU2pzlCXLkC6vGyPO214nnol6nkbIfhY8d/3AcogUB0JrWqLqf4+toNf85vZ
 2L/4fepg/VtHgRzcmDYeGWxllK17In9s2HOp/Ebh57obX8stJVA8nZGTykwuwXWWf04r
 PPMQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEaxNEsaXNF0E5lXCHWye7TNgsW0QNorSCWj6U/Za32/IxMulvpxzFykA98REPO3kIbfuLn9L0YdUY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/aKCZchd8WlmJATPIj9xBOq6mNf3fYdNmGx9gLSJXVW4wWeEIK
 rfnAvCPkPZ0fmrjjpdkZgIV/R14tf7FUj9o+3HDawjpfaQF3Yc3y3VPs
X-Gm-Gg: AYBFou3pAVMuTfJy1F5xG9pHVAMvoDG2Hv5Nfra7yKTQznB35tBRbtDs18YmaWqaX+n
 M9kMWV6aqCvvgp2Eu1u9rLY0CokllxG8IN6ktOLuYpjOxS9L0JeGMyimV7LH+n8DKApshH9d97E
 iwAc13OFKUuek8IkYNhA/9A56xNllPN++7SWKnlhSWnUKGN3t2oc0P+GTjYQO+HEIE73gAv2nm1
 5da/ItCLywB2I31FAR0v9ZB7yhthS8eOuZIOnwo3g9yM/y7KIiwfjPy3mjPHYOAJ66fS1gm7QUb
 fYiyxKfNaB9yDrbm1FF01+2Y09KMCqe52fbklpMjejGcztrKJb/YFCTCoa+b6hTI0weH+Olb5SH
 Hrdr1fac23RFB8PEh6Qzx4Q6RWmFJzvHfeNeaWC7iKrUSR3EvNPbqMSX/woFqXwcbwZE2s2OEOU
 pSwxj1Zvsmtp77yNDAuTdSvccczYFbwcppwdrBJ19JU1UhK0Xb6d5VoqfwHU4BxGURn4FORsLbM
 FErOq/RGc7qgCwnybuogu64M81kI7MCViSnPd3eqpLkd9MuNj21EIK756mKJfBb68mwNy5AzfaH
 F8aGQh9diQhbg4uo1EzU8J0WxwoTCctWVrE=
X-Received: by 2002:a17:90b:528c:b0:3b0:a9de:9884 with SMTP id
 98e67ed59e1d1-3b1b0a4e3bbmr4061630a91.40.1794631395879; 
 Fri, 13 Nov 2026 20:43:15 -0800 (PST)
Received: from localhost ([176.210.133.73]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3eaf732sm3230685a91.3.2026.11.13.20.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 20:43:15 -0800 (PST)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, vladazaharova2018@gmail.com
Subject: [PATCH v8 0/4] gpu: nova-core: retain the GSP-RM log buffers
Date: Sat, 14 Nov 2026 11:43:00 +0700
Message-ID: <20261114044304.245684-1-vladazaharova2018@gmail.com>
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

Changes since v7:
 - patch 3: check only gsp_keep_logs, not CONFIG_DEBUG_FS, drop the
   reserve() before replacing the copies, add RetainedLogs::push() and
   mark retained_logs() #[inline] (Danilo)
 - collect Alexandre's Reviewed-by for patches 1 and 2

The code and the commit messages were drafted with an LLM coding
assistant and reviewed by me. Each patch builds on its own, and the
series was tested again on a GB203: the copies are kept after unbind
and after a failed probe, replaced by the live buffers on the next
bind, and nothing is kept without gsp_keep_logs.

v7: https://lore.kernel.org/nova-gpu/20261113075317.934264-1-vladazaharova2018@gmail.com/

Vladislav Zaharov (4):
  gpu: nova-core: move the debugfs root into the module data
  gpu: nova-core: gsp: move the log buffers into their own file
  gpu: nova-core: gsp: retain the GSP-RM log buffers after unbind
  Documentation: nova: remove completed GSP log buffer task

 Documentation/gpu/nova/core/todo.rst   |  12 --
 drivers/gpu/nova-core/debugfs.rs       |  45 ++++++
 drivers/gpu/nova-core/gsp.rs           | 100 +++---------
 drivers/gpu/nova-core/gsp/logbuffer.rs | 205 +++++++++++++++++++++++++
 drivers/gpu/nova-core/nova_core.rs     |  68 +++++---
 5 files changed, 313 insertions(+), 117 deletions(-)
 create mode 100644 drivers/gpu/nova-core/debugfs.rs
 create mode 100644 drivers/gpu/nova-core/gsp/logbuffer.rs


base-commit: 0ff9e5b9ff6736c37593cd7db89f4593ec4f8e86
-- 
2.56.0

