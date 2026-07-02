Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C4FC43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF4A10E5B6;
	Fri,  3 Jul 2026 07:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="IY8i61ij";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA75B10E4A9
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 12:05:38 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-5bd7309af69so561659e0c.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 05:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782993937; x=1783598737; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rmBb3AiIVPGFeOn7V5UKb1QDdSuVN0QXacb3HjQ+rKU=;
 b=IY8i61ijOvhMyeNBftS4O0Aum5Pi/dX/duOpIJJfpn0+v91tqYaKnFnZo7oaKWS/TH
 0mRdUnb303pisdWXgyR+xUN7owiJ1UvpKvgp/44d+WIIGs3/qUmIBwxpDnWHPBJZBpXP
 unwuqt8sJA1qG2+xFVkM9wh+hfm0P3hM5I64rPIxKi/SQay9au1d3HtZBWdrKuDRWF0Q
 qSTQFJTmf2B+tZKBmK6uCalfFMxauYfBZZK361xdgKWgqWPBR2rVCt6TPExlFalV71fM
 SeramZuyDn6SywDdFa6IyfF5le74Xy7KqIMrn6c1a/sUBjIyTwFgQ+MFiQiNOFIpvBlN
 TVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782993937; x=1783598737;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmBb3AiIVPGFeOn7V5UKb1QDdSuVN0QXacb3HjQ+rKU=;
 b=MDEZmSimR/P2vLsH9/g/xw4LvkA5rL9o8/cDDSATWwkAjxQZ4v3ls95CTqm6ha7f4H
 D/h7TtnMnXFi4yaG1bGBYVjCOAYfHRYk6ctjq/3msZMpLwM/b2XSKmwam0QvzIo6AeLM
 DlyFfnFxgXPkPcSX1p9StwnGu4SWjXpTguifPWnJoDkGC64BRntqKq/iOmis9ioIil9x
 taLTKrI/HnBIKGG7wbfv8N8WhBo7+uyInNehMu4Ly5YXHjissrju/5JPRaOuxD6FPXze
 9MKOWZwninMbtlFUfFEIiIVNpGZlKb6hxRC61Zaf+x5FuZNoB5VgX3XcnMYxcSW7ZTQb
 B+KQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/q11DxEnOxn5pMrCi1L4XSwTL7oA9DVigm+wc5Vc/PqObGVl7zGxhyqS1ZWCP+WAX+4UWf8BIkLs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+FAABA4x7BQBwSrtPLdnH9AbPkwE4nTjcLlngnpW6gUNluAXl
 mbax/9nqSFPUOjDEhNusGYzuKDNL0YYhp6Mgq/mnwcjJVejzdv3SGs6k6R3i+PCsFRw=
X-Gm-Gg: AfdE7cmReDpyiN458b9a8msd1VE3yUiR3d4hrlb69cjuGzRdLYsoXc5SVXrSOlKVJOc
 Ti/aUYmJRXf5i2eVXc2JQXWF+nqCfFCYMrzhijUmJzf8vNjem7DTn8Ia/DnqnzJWXzdJC2B+7kF
 zos6pSbD6dQa0jgZ8r8IeXtiy+fwD7u2F/SThYJRHvddbQXEIJSLHJABmCMY4kO3K9PaNYmqpvS
 k7HZMXGiPrlmNgSGEan7SCMujvk4gE2twBOIqCkIyqSWJuBPxHvNN5vkyBaQsbsKtbP2ZLXXb4H
 CsXPkWhr75QZYgIH+m+RKo7J4NdOFb16iRsVqScc/UnnDM9wS82C402gcIeVJPw5+TvwXxJrNvf
 0gf4EPg0eU5A4OcnVw9Z0fqYfxQ2Yia4VyyF2MzGFxU1d17WewAJpIkskNXazhU3VQhQgJtBM9G
 vWlnA15o/NQbLqRj0sGTUXInPV8A==
X-Received: by 2002:a05:6102:54a4:b0:736:e617:b4f7 with SMTP id
 ada2fe7eead31-73dabb35dd4mr2370159137.21.1782993937394; 
 Thu, 02 Jul 2026 05:05:37 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1caf43casm1182470137.11.2026.07.02.05.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:05:36 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	apopple@nvidia.com
Cc: nico.antinori.7@gmail.com, aliceryhl@google.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev,
 Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [RESEND PATCH v2 0/5] drm/nova: replace `transmute` with `zerocopy`
Date: Thu,  2 Jul 2026 09:03:19 -0300
Message-Id: <20260702120324.40388-1-niyudi.honda@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:04:17 +0000
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

From: Pedro Yudi Honda <niyudi.honda@usp.br>


This series follows the introduction of `zerocopy` to rust-next and
replaces `transmute` traits with `zerocopy` traits. These changes are
mechanical and don't alter functionality.

This series is built upon Nicolás' recent patch, and does not touch
gsp bindings.

Specifically, the trait `transmute::FromBytes` is replaced by
`zerocopy::FromBytes` and the trait `transmute::AsBytes` is replaced
by `zerocopy::IntoBytes`. Additional traits such as
`zerocopy::Immutable` and `zerocopy::KnownLayout` are implemented as
necessary.

Resent because of wrong target list and wrong email in "From:".

Pedro Yudi Honda (5):
  drm/nova: use `zerocopy` in firmware.rs
  drm/nova: use `zerocopy` in booter.rs
  drm/nova: use `zerocopy` in fwsec.rs
  drm/nova: use `zerocopy` in bootloader.rs
  drm/nova: use `zerocopy` in riscv.rs

 drivers/gpu/nova-core/firmware.rs             | 10 ++--
 drivers/gpu/nova-core/firmware/booter.rs      | 26 +++-------
 drivers/gpu/nova-core/firmware/fwsec.rs       | 49 +++++--------------
 .../nova-core/firmware/fwsec/bootloader.rs    | 18 ++-----
 drivers/gpu/nova-core/firmware/riscv.rs       | 10 ++--
 5 files changed, 30 insertions(+), 83 deletions(-)

-- 
2.34.1

