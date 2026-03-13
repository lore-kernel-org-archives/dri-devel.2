Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E88105F781
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 09:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAE3110EB54;
	Fri, 13 Mar 2026 09:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="qrCWNn48";
	dkim-atps=neutral
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net
 [178.154.239.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD0910E0DA
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 09:17:49 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:571a:0:640:23e3:0])
 by forward101a.mail.yandex.net (Yandex) with ESMTPS id BA6AC80E9A;
 Fri, 13 Mar 2026 12:17:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id 3HEusrTGkmI0-9zP4Lv6M; 
 Fri, 13 Mar 2026 12:17:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=mail; t=1773393466;
 bh=zw4BW7xq9n36BgD6MB8AZl3w8nnFPfRvDfzjrTAcMTw=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=qrCWNn48F/vf+k8Ltav4UisfBQXf/aJ0aJ54nfPMfO3JKTNtOoxVEmOG3YftN8DFk
 s7rgfNKxMR1HizlJDv/GumR4B00d5taBgR4juYkMe7IHM8O6GKu0RyuAtuXd0R6YrZ
 44oZXVlfw3TczEpU1AnGGH74E+3jM1xZ2QxT3Bfg=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net;
 dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v1 RESEND 0/4] drm/tyr: implement GPU reset API
Date: Fri, 13 Mar 2026 12:16:40 +0300
Message-ID: <20260313091646.16938-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series adds GPU reset handling support for Tyr in a new module
drivers/gpu/drm/tyr/driver.rs which encapsulates the low-level reset
controller internals and exposes a ResetHandle API to the driver.

The reset module owns reset state, queueing and execution ordering
through OrderedQueue and handles duplicate/concurrent reset requests
with a pending flag.

Apart from the reset module, the first 3 patches:

- Fixes a potential reset-complete stale state bug by clearing completed
  state before doing soft reset.
- Adds Work::disable_sync() (wrapper of bindings::disable_work_sync).
- Adds OrderedQueue support.

Runtime tested on hardware by Deborah Brouwer (see [1]) and myself.

[1]: https://gitlab.freedesktop.org/panfrost/linux/-/merge_requests/63#note_3364131

Link: https://gitlab.freedesktop.org/panfrost/linux/-/issues/28
---

Onur Özkan (4):
  drm/tyr: clear reset IRQ before soft reset
  rust: add Work::disable_sync
  rust: add ordered workqueue wrapper
  drm/tyr: add GPU reset handling

 drivers/gpu/drm/tyr/driver.rs |  38 +++----
 drivers/gpu/drm/tyr/reset.rs  | 180 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/tyr.rs    |   1 +
 rust/helpers/workqueue.c      |   6 ++
 rust/kernel/workqueue.rs      |  62 ++++++++++++
 5 files changed, 260 insertions(+), 27 deletions(-)
 create mode 100644 drivers/gpu/drm/tyr/reset.rs


base-commit: 0ccc0dac94bf2f5c6eb3e9e7f1014cd9dddf009f
-- 
2.51.2

