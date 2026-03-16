Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B34F3380B
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D361410E53B;
	Tue, 17 Mar 2026 08:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cpufdEfT";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B053A10E3C9
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 11:25:45 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c73a12af63cso2771128a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 04:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773660345; x=1774265145; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgmZwA5aTm7ncl3DyHbavGYhjXi/iScqCoLnw+YPzBw=;
 b=cpufdEfTsjmg25hOSAA8b2wvMlAQYQyR+dQH8Uqczj6GkPqotbHOeyE5RVK3XkAVDf
 polxm3NazbtXco6xqSLJg3744LG18KtJvclN9Yk+U+npTfmyxfZTzZyBcG7IEUzzyjpa
 l4RYKsvQAQeX3DmwoL+bq/mPZCMaT1LuSyK9iXCo72s1mfti+QnSPzecCSwXWf5LYKAf
 pYZ0XgWJ3hhPjoqxprh+S5ASVBKyOwUqHvD2guyiNy0iB8JIh+pIjP85sQiPgzDCIHTn
 YIRb3gGmnniDIzwd/4MFRSs7VLCNypqjGj+xJUk9G67Vws8I328gPKKB2Qu3+c3lYMBD
 2EVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773660345; x=1774265145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wgmZwA5aTm7ncl3DyHbavGYhjXi/iScqCoLnw+YPzBw=;
 b=fXX80as8zvIX+t1FpzLZSe/syrDt+ug0+Qg6So1J97JyCGr07SaBmk18CdZScefZV/
 0sGEQdaptCXk4Sm54oMZPaxug5rtOcXXBe4RX+O/LdYmlUGT2HpYhHyVWoHHykYX4yph
 6a995hCqfAqPNs93x301M9+kj4NYUXhf1jUzs/UY/WrWIwLBi6oXGeBpv4lYpcENchDG
 vOIWLgZNiltgem338OOTltJewymRjXpp9lMw7nmbTm1PlNZ73jqwuobAeB1FRYrK+73W
 1LDM0WaDeiXBJMsH6+qhCqwSgxSdLKhvGDusHD4PHx8JGxItd9aVfSNBJKiDpRxRPPwy
 puBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxQI61O6VkyhcPJDXqnPIuYyLNdiIQGaITakPTmYQW46i6x1ny6Iwz4SZ1Sved0B8q/upWTEBdA3U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw56FRHnTQd7FlN1ZCuiPd/4SqtxpOGi7tLkO6YG6f1azmfueks
 Hq8qZOaLjoYX7ngLzUfGwnsjkD7vUoJLJmigzwzrMPIbKiZkmX2bHbj9
X-Gm-Gg: ATEYQzwxhN3HIH6uXg79Xtq6cZfIJwsTtsr0SdXDV/0MwtEFFyX2oikaHMTv7XuMPW6
 fASBzu7egtVIn0oqOXw+QICNUhA0SD+KuI7d94OQ7Aa04DCP2WdMuCbscfwLOIq8ngmEx89ZdVX
 01MYg25/diKF4gCeOepDhrPCla/l6tmdov0fondjTDgHJQBVVhx5p/gPGcHy4gP/220uy9397qs
 nR+1KSdqAU26mCyyoDzgJasiuA9b9V3jddXvzPXx4AAki68ZtdLQMb4JVOO8Y3LoAdoDw7vd390
 M10vfS3c/h9jw7M/k9lzvgJcdGxPbWZ06iu5bwpy9oN9gP64+KR4CeFN/DvIduk9Uf4mq2oOowW
 9BykBeWpRi6BNK11m8T9X5shB0pCOhu6AVr5Iss2aM6cw/8eACnZw8nXj7QijLjOMBvDrs6Nnxo
 T4zS3XFpNmZfVGvl9uTjtT+NiYX35WACIK8IlctjIWm/ipHVfNQ0nSF/3JhIKwBFmXt5Si6sHOm
 O41LT4R7VAUBJTI
X-Received: by 2002:a05:6a21:a345:b0:398:9820:f6ed with SMTP id
 adf61e73a8af0-398ecd67b1cmr13269758637.56.1773660345183; 
 Mon, 16 Mar 2026 04:25:45 -0700 (PDT)
Received: from localhost.localdomain ([14.160.25.72])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73fc935ad4sm4744131a12.2.2026.03.16.04.25.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Mar 2026 04:25:44 -0700 (PDT)
From: phucduc.bui@gmail.com
To: geert@linux-m68k.org
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
 laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, phucduc.bui@gmail.com, simona@ffwll.ch,
 tzimmermann@suse.de, wsa+renesas@sang-engineering.com
Subject: Re: [PATCH v2] drm: shmobile: Fix blank screen after resume when LCDC
 is stopped
Date: Mon, 16 Mar 2026 18:25:40 +0700
Message-Id: <20260316112540.8636-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <CAMuHMdXJQmfU0p=yk1kROTm=ZiiQoUHZQpw5kj813x=RWCS1fg@mail.gmail.com>
References: <CAMuHMdXJQmfU0p=yk1kROTm=ZiiQoUHZQpw5kj813x=RWCS1fg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Mar 2026 08:02:43 +0000
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

Hi Geert,

> Your MIRROR value is truncated (I don't trust the final zero)

I apologize for the inconvenience. The displayed value was
truncated due to a missing newline character in my debug print
function. As you suspected, the value is indeed not zero.

>>>Enter: shmob_drm_crtc_atomic_enable
>>>ENTER: shmob_drm_plane_atomic_update
>>>ENTER: shmob_drm_primary_plane_setup
shmob-drm fe940000.lcd-controller:
[BEFORE] LDSA1R: A=0x00000000 B=0x5c100000 MIRROR=0x5c100000
shmob-drm fe940000.lcd-controller:
[AFTER MIRROR] LDSA1R: A=0x00000000 B=0x5c100000 MIRROR=0x5c100000
shmob-drm fe940000.lcd-controller:
[AFTER SWAP] LDSA1R: A=0x00000000 B=0x5c100000 MIRROR=0x5c100000
OOM killer enabled.
Restarting tasks: Starting
Restarting tasks: Done
PM: suspend exit

> TL;DR it depends on kernel config.
> With my .config, your patch is not needed (but it doesn't hurt).
> With your .config, your patch is needed.
> Unfortunately I haven't found yet which config options causes this.
> I will send you my .config by personal email.

Thank you for sharing your configuration file. I noticed there are
numerous differences between our configurations. After further
investigation, I narrowed down the main cause to the following debug
options:

CONFIG_PROVE_LOCKING=n

CONFIG_DEBUG_LOCK_ALLOC=n

CONFIG_DEBUG_RT_MUTEXES=n

CONFIG_DEBUG_SPINLOCK=n

CONFIG_DEBUG_MUTEXES=n

CONFIG_DEBUG_WW_MUTEX_SLOWPATH=n

CONFIG_DEBUG_RWSEMS=n

CONFIG_DEBUG_LOCKING_API_SELFTESTS=n

CONFIG_LOCK_STAT=n

CONFIG_DEBUG_ATOMIC_SLEEP=n


These options are enabled in your configuration but disabled in mine.
Enabling these debug features introduces additional overhead, which
slows down the resume process. This delay unintentionally provides
enough time for the hardware to generate the Frame End interrupt,
effectively masking the issue on your system.

It is also worth mentioning that this behavior is not new. I have been
able to reproduce it consistently for a long time, dating back to the
Kernel 3.x era when armadillo800eva_defconfig was used upstream. In
fact, the issue can be reproduced as far back as Kernel 3.12. While the
exact configurations may have changed over time, the underlying
behavior has remained the same across multiple kernel versions.

This observation suggests the presence of a systemic race condition.
If the resume process completes too quickly, the Frame End interrupt
may not occur in time to trigger the transfer from Side B to Side A.
As a result, explicitly initializing Side A (priming) during resume,
as proposed in my patch, provides a more robust and deterministic
solution. This ensures correct behavior regardless of CPU speed,
system load, or debug configuration, rather than relying on the
incidental timing introduced by debug options.


Best regard,

Phuc

