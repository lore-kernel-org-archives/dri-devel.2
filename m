Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E59F606A337
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ci2tyFfv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9823C10E21B;
	Tue, 17 Nov 2026 21:44:28 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4531210E6AC
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 21:44:23 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso11321905e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794951862; x=1795556662; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qJvVhGm7m/yddOVh7TzhHkOYiZu5bDfmIBnbwu2rovg=;
 b=Ci2tyFfvDTYYgOnSEu7Rjo+JPBOsyXuhCAM0kAxcSeV3qmozKAMyzBu6qVcFiJ7EQK
 XVZy8sRmMMCfXeDEpZp/Ae8ZawGFSuTMSNWpZANb9fuiONuj14eFl67Zv8fV1tLFQgTr
 9ea6Y8mfBiz8QZaUMllDVFRGBHVXwjwHZwvaPsK1xtTjZnL5zX1XsIHKWTUwjInVzy9m
 cyhIoBoNVje5WxKo8V3gQpGbTo61B63OzeNdh0abgmdUnCjK0sryosQ+jsgOVKPpSrbj
 V+oUd2mf+jPdayuGs80BU+2dt8IRsL4JRg/EcGypcBQ60RinEKJWniuqbvIj5F/hv+Nd
 jFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794951862; x=1795556662;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qJvVhGm7m/yddOVh7TzhHkOYiZu5bDfmIBnbwu2rovg=;
 b=KEhCMMPO5KtiGyMaLUifOyXxAW0LBsvdgHaOR3WHRVDbfPhbUID0puknq5d4jc7+o3
 x50I1LwFiTrTNEkhYu6f5BvAK4NV9MCrbSnHpZgavlSw1wOomfCvFpbQeTGRjwuUr/VQ
 VeTLjnAKNkBrKhRUDKbcnPSiziF9dYZykBizGKInjGfYcxF0RFtZUp+8ClhFpjsC9/ol
 AIZcWHiVwEx6noTWSi2dLvuFaIHweBiPt9YFo2pmdjPsUdPHBM6SdyuJhBLbhKTXPFYN
 W+zpARYQ4NbXDQSWaAZLbvBAwRT/BJOh//Xd5NFhAP7qOW+TxUwht9BLPnjhypGU2Dqm
 y4NQ==
X-Gm-Message-State: APuU4Z8fV91wwTMgcV21FLK8F/QIVd5URIuwLnS64bBqk2T3lJsg6XBJ
 IeWjMSjLzNXgSpDgByiTSAIcZLYCkDAPfZ5JXJpgTAtI6I4wepEiWmkq
X-Gm-Gg: AYBFou2ufcN7g+Vv5LeJ+EJQ58usrr5ucGB/BSyW757bVmO4IDxFDei4gWDMa5KyrbB
 PuIcLQfY4yfdcvfuTuw4eMMLS7e5gkq2yBXp5uXxPW+01M8jsKHpYETB5D9V2R+nHbBLtcSYgEK
 Ud7yyfMaSbNeHQl6JdK0ht3t/rUm00RoyWJWIoDI8eStNo0R2pby3IqGlHeeEVDjwS2VZsaBG2a
 10YZeGGqjG5LLyWrMSEQjmNopktU0KWRb+yhlBDk7gieEcHTcDwTBiV3svz5l18voD/wWQi8BKd
 cOH3sUA6SqUMF+pjyLAzaIfOLIRT5jbjkgTG6+bRorZaIjJ0XpZZ2d1VM+gudRKaFCmRAsriL1Q
 kBcj4+7mjIhVjIkejjqj+6d5o/hCthy4cEV32uWifgIGX7PxBEFGuS7yJt0a1xdONje7alkSdzC
 X0si2cMY7DfQRC3uPh667jzDR0Ly6M88xusHCh51gYWU9OGPqqKp7+gzix1J79jfuKO9vArG4mv
 gvXXXuclJ1Nha1IJClf4BOxTStGly23vQ25P95elMa5TQOqeqzVq5tuChbsnJWSbmhmVaAZxPVJ
 c9ZQzg15qTCByXrnjE1tBb0+VZhFMLjf82UbjDCKMWlHiqNYraelGK51aYOWPw==
X-Received: by 2002:a05:600c:6090:b0:4a2:1960:6fa with SMTP id
 5b1f17b1804b1-4bb7da0c872mr9124615e9.4.1794951861506; 
 Tue, 17 Nov 2026 13:44:21 -0800 (PST)
Received: from fedora ([94.200.248.157]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb784231basm95069675e9.11.2026.11.17.13.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 13:44:20 -0800 (PST)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mary Guillemard <mary@mary.zone>,
 nouveau@lists.freedesktop.org,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH 0/3] drm/nouveau: fix instmem io_mapping faults and slowdowns
Date: Wed, 18 Nov 2026 01:43:49 +0400
Message-ID: <20261117214352.337961-1-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.56.1
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

After the instmem io_mapping commit, some people noticed that some VK CTS
tests became much, much slower, while others started running into apps
MMU faulting. This was because of two issues that combine together.

A synchronous VM_BIND waits for its job with an interruptible wait and
ignores the result. On a signal, the ioctl returns 0 before the page
tables are written. Userspace can then use the new mappings, and the
channel takes an MMU fault. This was an old pre-existing bug.

On the GSP path, the BAR code keeps an ioremap() of the first page of
BAR2 to flush BAR2 writes with a read while flushFBZero is not mapped.
The instmem io_mapping covers all of BAR2 and overlaps it. However, PAT
gives the new mapping the type of the older mapping it overlaps,
uncached-minus, so instmem was now uncached without write-combining and
bind jobs became much slower. This is what caused the slowdowns, and the
slowdowns in turn made it easier to hit the pre-existing VM_BIND bug.

Patch 1 fixes the faults. A synchronous VM_BIND now waits uninterruptibly
for its job.

Patch 2 takes the flush pointer from the io_mapping which allows us to
skip the ioremap entirely. Nothing maps BAR2 before instmem does, so the
io_mapping is write-combined again.

Patch 3 sizes the io_mapping to the part of BAR2 that the driver uses.
This is technically not required, but this matches OpenRM and makes more
sense. It also guarantees that a similar issue can't happen again if
something changes in the upper half.

Mohamed Ahmed (3):
  drm/nouveau: do not return early from a synchronous VM_BIND
  drm/nouveau/bar: take the GSP-RM flush pointer from the BAR2
    io_mapping
  drm/nouveau/instmem: map only the part of BAR2 that is used

 drivers/gpu/drm/nouveau/nouveau_sched.c       |  6 +++-
 .../gpu/drm/nouveau/nvkm/subdev/bar/gf100.c   |  6 ++++
 .../gpu/drm/nouveau/nvkm/subdev/bar/priv.h    |  1 +
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c | 32 ++++++++++++++-----
 .../drm/nouveau/nvkm/subdev/instmem/nv50.c    | 19 ++++++++---
 .../drm/nouveau/nvkm/subdev/instmem/priv.h    |  3 ++
 6 files changed, 53 insertions(+), 14 deletions(-)

-- 
2.56.1

