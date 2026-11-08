Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76260606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 05:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFc9nXjA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88EAC10E750;
	Sun,  8 Nov 2026 05:21:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E71610E74E
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 05:21:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1491943FBE;
 Sun,  8 Nov 2026 05:21:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794115307;
 b=J/FSpwGIEpF6Twig2bx35fk8AN2xHKalbG1BLG/Su7+3aV39byur2CznBAWcCJDEFMbc
 2JluhK8M7BuwMGFHKZLYN00TWZV2qohuFZvhodpS93Bb2AG9pwnQjmQ8U41Yx0g8AV9OD
 wGo/keYnD652YtxS4v/EZqvgU7oQPjUC1eGq6RJvWd5D4vErgrixVt+hp+zZu1xUqxQtM
 /vCAzCbAyj30Egeo0yGEGCwEs/k7OUR9oUITi3arR2b0rq6aXuUQ3QNEAVIl/vfVB95iG
 UlAbSC2Equ7xNoqddzPDEyHm8aVhknEnXKVYvLzq71eYcJ1cYveBBhwtoAZ5Ig7f5KA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794115307;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=dFRh1RIDMrDysy0Y8CMBpFk0XYpF7u7gwkMGgMDzy6I=;
 b=MCy2YggIG/kHY+FZVR21Nsk+jRsb0Y+fFmTuku8+o5YY+MlW2iWxsDKCnpm2Srka2bzB
 8M+j7hejh/1ZSQ7DAxslbuQ6n6VzGT9oCPOXvJFuPdHmIiynsDGsO43uU4M1S5ITowFBX
 a/XluiqtEHTVsWLKlczfucoCVQiaedQekZPHOUs86OxDqJ9x9CyY9p4NVIek/gir2NblZ
 McAMJr/uP3DVcCG0ubNdcoFx2LcySjWSYulIQ9Ujq79mPqTRdzJOK+nKgT0HGvPksnH7f
 /tNIAJMFVZ8tl5enB/yNEL5O662ZLl6NY29+8Q7In9Uml2/fUZjREgAU5BI93uXDDaQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 3CF521F0089F;
 Sun,  8 Nov 2026 05:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794115307;
 bh=dFRh1RIDMrDysy0Y8CMBpFk0XYpF7u7gwkMGgMDzy6I=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=iFc9nXjASN6dWTwRiNKQkxQNiwswB+mxMvvKGr5EjDOotRLtKfEZtHta5STcTLsjC
 /+w0mpbxhtHIVUL2nZbUpCvF1121nDISyVGShXuljX1PqUtuyqIoxLd6gt93yyyPqz
 97A3Vu6VVaDAVVMh9rkP/ByAexH+TPhS3lmjm94EtgC3kr8pOBa9m07BpmxUVfKLR7
 O59NH9tEAPa8DWsdz6FksRBdiJ1KjxhmFRBg+i1DZNeyzzojqWcmysVdIeicAaQBAw
 czRHSBI0FOI1VLb9WeEhWMpgLofut3f2yCWtGlD1mQ1Xkyq+9c8OQP1XYqSOWsIgsO
 pTLb2IRJOuU1w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 8B50B47E19;
 Sun,  8 Nov 2026 05:21:46 +0000 (UTC)
From: DelaySystem via B4 Relay <devnull+DelaySystem.tubot.lat@kernel.org>
Subject: [PATCH RFC 0/2] Uninterruptible host1x syncpoint wait for Tegra
 video capture
Date: Sat, 07 Nov 2026 21:21:45 -0800
Message-Id: <20261107-batch1-b1-host1x-wait-v1-0-8c8198adf600@tubot.lat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBAAv1L27EI3BSVeBR/gtfSQjatZD61ko
 y2U/t2oxxmYWcEkqxgcmxWyvNV0GivQroGYwngX1GtlcK3bE7UH5FBiImTCNFmhBeegBbvIHXs
 nnryH2j6z3HT5fXu4nE8w/KW9+CGxfI+wbR+zXgVRfgAAAA==
X-Change-ID: 20261107-batch1-b1-host1x-wait-3cb3b92e9199
To: mperttunen@nvidia.com, thierry.reding@kernel.org
Cc: DelaySystem <DelaySystem@tubot.lat>, dri-devel@lists.freedesktop.org, 
 luca.ceresoli@bootlin.com, gregkh@linuxfoundation.org, mchehab@kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 clamor95@gmail.com, jonathanh@nvidia.com, linux-tegra@vger.kernel.org, 
 skomatineni@nvidia.com, linux-media@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2521;
 i=DelaySystem@tubot.lat; h=from:subject:message-id;
 bh=DLUckEgyR5Ni9ibN8qkK+UlCenVeIET585HOCl21B1Q=;
 b=owGbwMvMwCH2SNl4+SzWXm/G02pJDFkf2F7NNQoS2/EpUWuyo8xRho7U69tnTPt5MWzywW1CP
 I3nOx56d5SyMIhxMMiKKbKIyfC8r7+vE2dtNecEzBxWJpAhDFycAjCReB5Ghiff5mdefPm1PF32
 XOykyKOvPQ1mTncoVv3YpfrKSG7Tmi2MDDMUnRZG5FvaXOP9E22qyOG+WF/mlVzW1YWTv8rHXVd
 15gIA
X-Developer-Key: i=DelaySystem@tubot.lat; a=openpgp;
 fpr=161C0CEF7FDF2C5E3B3A9CC8E22333A79A058D4B
X-Endpoint-Received: by B4 Relay for DelaySystem@tubot.lat/default with
 auth_id=1447
X-Original-From: DelaySystem <DelaySystem@tubot.lat>
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
Reply-To: DelaySystem@tubot.lat
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: DelaySystem <DelaySystem@tubot.lat>
The Tegra20 video capture path runs in a kernel thread and waits on
host1x syncpoints with host1x_syncpt_wait(), which is unconditionally
interruptible: any signal aborts the wait with -ERESTARTSYS. At high
resolutions and framerates these spurious failures are common, so the
driver wraps both waits in do/while retry loops, with a TODO asking
for an uninterruptible variant of the wait.

This series proposes one: patch 1 refactors host1x_syncpt_wait() so
the interruptible behavior is preserved exactly for existing callers
(including two DRM ioctls that are userspace ABI and must stay
interruptible) and adds host1x_syncpt_wait_uninterruptible() for
in-kernel users. Patch 2 converts the Tegra20 capture waits and drops
the retry loops and the TODO.

This is sent as an RFC because the API shape and the scope need
agreement before a final series:

1. Is a separate _uninterruptible() variant the shape host1x wants,
   or would the maintainers prefer something else (for example an
   internal helper with a flag, or a different name)?
2. Tegra210's two waits (tegra210.c) have no retry loop: a spurious
   -ERESTARTSYS currently fails the buffer. Should they convert to
   the uninterruptible wait as well, or is failing on signal
   intentional there?
3. drivers/crypto/tegra/tegra-se-main.c also waits with
   MAX_SCHEDULE_TIMEOUT; left out of scope here, but flagging in
   case its maintainer wants the same treatment.

drivers/staging/media/tegra-video with VIDEO_TEGRA=m, zero warnings).
The tegra20.c change itself has no compile coverage here: that object
builds only for 32-bit ARM (ARCH_TEGRA_2x_SOC/_3x_SOC) and no ARM
toolchain is available, and there is no Tegra hardware for runtime
testing. Hardware testing help is needed before any final series.

Testing: compile-tested only (arm64: drivers/gpu/host1x and
---
DelaySystem (2):
      gpu: host1x: add uninterruptible syncpoint wait variant
      staging: media: tegra-video: uninterruptible syncpt wait for tegra20

 drivers/gpu/host1x/syncpt.c                 | 46 ++++++++++++++++++++++-------
 drivers/staging/media/tegra-video/tegra20.c | 37 +++++++----------------
 include/linux/host1x.h                      |  2 ++
 3 files changed, 48 insertions(+), 37 deletions(-)
---
base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
change-id: 20261107-batch1-b1-host1x-wait-3cb3b92e9199

Best regards,
--  
DelaySystem <DelaySystem@tubot.lat>


