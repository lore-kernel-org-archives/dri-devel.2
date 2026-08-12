Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A971C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8089910E415;
	Wed, 12 Aug 2026 14:08:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="XQ6uAeU7";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E61F10E415
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786543661; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=V6OEEgm5QIPfEGM2KJiT3LCgDCLcnA13CFRuNpkgJPtH3n4L//f9S69L2GSYxbDJ9Dq0APMIG6XWAKkZ+e/QMX5CvbVyzFJfynLJu2kzXOXBWUBV3iECbPlorpKLlnfcXpeJo30gbgmrEZhqPDKeK8oVxtRwg+eQBo8X4XJD0bY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786543661;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HtaUknOBrtxOVm97oCaJuMIizysi38YEI9j5FiYHokU=; 
 b=H/8XY+e/DMLZBtklbTdoL9oogCuV2GSBH+XijPjYjBWhz+VKB+LZkSCSetwJyCI1sNifrPtWCXsNrVHCiPeK7TgQArlRDTr0/FmJguzPp0XDhyI4FpJcw3f/euf/aOnkRIkr+U7Havl3/ZNknaQjwXZOSFO6OGgRjUwnLpsG/1o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786543661; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=HtaUknOBrtxOVm97oCaJuMIizysi38YEI9j5FiYHokU=;
 b=XQ6uAeU77Dcgy/kAuuHQ0kAcrkRXGgfrA7cnhkzaPFVKymtSx4PBE41SRqfh4yhS
 mjbtw+lronIW2FI1uRMlX3D5zGTUyUGa8P8BC+fBjHNNyFOBLiL4Q39nGmWxj8aIS+d
 gfV1Ibuj/NE9Ygd0rRJy1Ol0QhGC0PtN6xcUt/64=
Received: by mx.zohomail.com with SMTPS id 1786543659744525.0726026625509;
 Wed, 12 Aug 2026 07:07:39 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v4 0/3] Rework panthor's cache flush and soft reset locking
Date: Wed, 12 Aug 2026 16:07:17 +0200
Message-Id: <20260812-panthor-cache-flush-fix-v4-0-751e32901898@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XO3W6EIBAF4FcxXJeWH3fFvep7bPYCBig0KhbQt
 Nn47kXXpE1Tr8ghM9+cO0omepPQpbqjaGaffBhKqJ8qBE4ObwZ7XTJihJ1JwwQe5ZBdiBgkOIN
 tNyWHrf/Eip9B0ZNtGXBUtsdoyvcmX2+PnCb1biCv3D4RzcdUTubHGFIyGQyh732+VDr2OPvxZ
 X/RijifcohfW9uZbjt7sfaw2EwxwYycWkaN5iDoK4SukypE+Vxube7MflmcHFtstUTTkroRylr
 7n8V/LEHpscWLVTeaAVWKaqn+WsuyfANnuQs8nwEAAA==
X-Change-ID: 20260728-panthor-cache-flush-fix-b36cb15f92c3
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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

There is a problem in panthor's cache flushing/soft reset code
related to locking.

They take the reqs_lock spinlock with _irqsave, even though the
contended lock is never acquired in a raw interrupt handler. Only a
threaded handler locks it.

A new tracepoint to debug cache flushing duration without initial
locking waits is thrown in for good measure as well, to complement
what's in lock_stat and what the function tracer can already do.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Changes in v4:
- Replace flush tracepoints with just one tracepoint that has a duration
  and exit status argument
- Link to v3: https://patch.msgid.link/20260811-panthor-cache-flush-fix-v3-0-47d2c1bb1dab@collabora.com

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
      drm/panthor: Add tracepoint for cache flushing
      drm/panthor: Revisit reqs_lock handling in flush/reset paths
      drm/panthor: Take reqs_lock in soft_reset for clearing pending_reqs

 drivers/gpu/drm/panthor/panthor_gpu.c   | 89 ++++++++++++++++++++-------------
 drivers/gpu/drm/panthor/panthor_trace.h | 38 ++++++++++++++
 2 files changed, 93 insertions(+), 34 deletions(-)
---
base-commit: 96ddbb14986632af742523e68f90d51c138c57f0
change-id: 20260728-panthor-cache-flush-fix-b36cb15f92c3

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

