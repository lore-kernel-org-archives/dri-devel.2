Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6651DC5B56A
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BEF610EC49;
	Tue, 11 Aug 2026 14:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="JoE1ssjx";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4325910EC49
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:09:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786457329; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dNeO9kFwP3BtstpULXBbUro+orfiS+BR1dREmFI/TwxsQdpbVB340S+HezyuxEFUk+h+JB2yxpKZIR5BpH5qx2axzz0kaqJNQwVqm0M4gLxsfbDBwGzYWBpidLDStrKwV2nwQ2c2AeX6U758+7FJ/gZsbiwmMAvqtJnLDYiiSvU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786457329;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=WvlG8a9f4hNgYcdkw5/tDwK4MN31jOnX9fg6HSJmYBQ=; 
 b=bpyMEfboGgaICdsDjm5nNDatEO+qvmFIFh7bU9lwQ1ABxifr5mHlZ1heR1sxX7A5/qZdeVDVz4Zg8AGAclP5idtY3MfVFAjhNHCb3eprXDFY8qJFH8jZqufZk0BnM3pZXisnWUKvz67BM7b+uCjzqoIZ7oJsn10APf9nS1OtdG0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786457329; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=WvlG8a9f4hNgYcdkw5/tDwK4MN31jOnX9fg6HSJmYBQ=;
 b=JoE1ssjxCJ1lOF9h8SbAX2+yIA5yMaEdvUdX9aKLeY2R62d6E3dDvDj+hwK3OFT8
 JRPJcsSglC1uZXJueP9uSzfi82io3hyRXPKrUJr3w6YrrX6Zrj/t7xvsNT4BbRtyyYv
 4O1/SyW3xCHRzRbvhsXF316r9A3qn3DKeGTFJJXg=
Received: by mx.zohomail.com with SMTPS id 1786457326979303.25613537224;
 Tue, 11 Aug 2026 07:08:46 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v3 0/3] Rework panthor's cache flush and soft reset locking
Date: Tue, 11 Aug 2026 16:08:30 +0200
Message-Id: <20260811-panthor-cache-flush-fix-v3-0-47d2c1bb1dab@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOzW6DMBCEXwX53G390wTIqe9R9WAv69oVYGIb1
 Cri3WsIh6pSTqtZzXwzN5YoekrsUt1YpMUnH8Yi1FPF0Onxk8B3RTPJ5ZnXsoFJj9mFCKjREdh
 +Tg6s/wajzmjEybYSFSvpKVJ57+T3j7tOs/kizBvucES6zqUy323M6ESAYRh8vlRdHCD76eW4b
 IM4n3KIP/vaReyZY1j7cNgigIPkp1YK6hQ24g1D32sTon4uXTt3kX9Yij9myY3V1C1/rRtjrf3
 PWtf1F0s9MxhTAQAA
X-Change-ID: 20260728-panthor-cache-flush-fix-b36cb15f92c3
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Steven Rostedt <rostedt@goodmis.org>
X-Mailer: b4 0.15.2
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

There are two problems in panthor's cache flushing/soft reset code
related to locking.

The first problem is that the spinlocks are taken with _irqsave, even
though the contended lock is never acquired in a raw interrupt handler.
Only a threaded handler locks it.

The second problem is that the wait_event condition references
pending_reqs without holding the required lock. This means there's a
data race.

While resolving the first problem is easy, the second problem requires
adding some more macro variants to wait.h, which is done in the first
patch.

New tracepoints to debug cache flushing duration without initial locking
waits is thrown in for good measure as well, to complement what's in
lock_stat and what the function tracer can already do.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Changes in v3:
- Drop new wait_event macro patch as the existing ones have a memory
  barrier that makes the current use valid
- Rewrite fix patch to use scoped guards, and just get rid of the IRQ
  disabling
- Add separate fix for the outside-of-lock pending_reqs clearing in soft
  reset path
- Move tracepoint patch to before fixes for easier before/after testing
- Link to v2: https://patch.msgid.link/20260730-panthor-cache-flush-fix-v2-0-28790478bfff@collabora.com

Changes in v2:
- Use trace event template for the two tracepoints (ty Steven Rostedt)
- Link to v1: https://patch.msgid.link/20260729-panthor-cache-flush-fix-v1-0-205921ed3c81@collabora.com

---
Nicolas Frattaroli (3):
      drm/panthor: Add tracepoints for cache flushing
      drm/panthor: Revisit reqs_lock handling in flush/reset paths
      drm/panthor: Take reqs_lock in soft_reset for clearing pending_reqs

 drivers/gpu/drm/panthor/panthor_gpu.c   | 70 +++++++++++++++++----------------
 drivers/gpu/drm/panthor/panthor_trace.h | 49 +++++++++++++++++++++++
 2 files changed, 85 insertions(+), 34 deletions(-)
---
base-commit: dc462ab791b686c48545c160ecc81be64f77a846
change-id: 20260728-panthor-cache-flush-fix-b36cb15f92c3

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

