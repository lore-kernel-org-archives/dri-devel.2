Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0143C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 11:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0450010E142;
	Thu, 30 Jul 2026 11:45:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="YAZ5/Jut";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFBF510E142
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 11:45:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785411937; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JcyG1DSqOBDk1J81Cy7xw5WbPDok3/8zc2OkZAz/rYmsufwEbzN+j028PLysFqEvbNYkD76TL7T1HMPRot9cogk+uIydHd2iSWRbtHVUdoL+bKMMiMtxFF8sOD233YHlr1f+19QzWchPPsuCbO/BoiT7VH+4mU/TMoRwLJnDFvM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785411937;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=rF90dIXuL4AXHKEg2OuLC8atnpVkkb9BGR+Ghiw5ktU=; 
 b=jZLz4gFRsU/KaF63LevJ7VPHkcgNZM4rhwfLRqB275QZ7cCYOvx7hkcXsQN1WXXJnhykCHiInnDnLUYz/11ylpeynw6AE87KB++j2rkJIRVTsXJgzcJX3/ryd0rWLomOYMH+M2c9yNxXJO2zfw9AWK4X7zMOMYpFimZUfIO4WOM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785411937; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=rF90dIXuL4AXHKEg2OuLC8atnpVkkb9BGR+Ghiw5ktU=;
 b=YAZ5/Jutn2uDGbsUtfmrXYcpzn3/xRwO9NExChbfTDG8/LJCYCTmK26pRt+VtGRh
 iiVXbkaN3SjhuRLRm/1RlzrMhYuailIGo4DGFzs1DBhjzlG64BGduHGKwgFfl5a5AWa
 BnkEVq1hPqWEIcK6/QfCPLsYCqmJJDI0wnCETeFI=
Received: by mx.zohomail.com with SMTPS id 1785411935727257.15462936737913;
 Thu, 30 Jul 2026 04:45:35 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v2 0/3] Rework panthor's cache flush and soft reset locking
Date: Thu, 30 Jul 2026 13:45:13 +0200
Message-Id: <20260730-panthor-cache-flush-fix-v2-0-28790478bfff@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOyw6CMBBFf4XM2lFa4gNW/odx0Q6DrQGKbSEaw
 79bka2ryZ3cx3lDYG85QJW9wfNkg3V9EnKTARnV3xhtnTTIXB7yozzhoPponEdSZBibdgwGG/t
 EXRxIi31TSiogpQfP6b00X64/HUZ9Z4rfutXh+TGmyfizgVaBkVzX2Vhlte8w2mG3XviWGBui8
 6+FdhJLZgUr/4JNAnOU+b6UguuCTuJMrm2Vdl5t0xZc53n+AHkKd54HAQAA
X-Change-ID: 20260728-panthor-cache-flush-fix-b36cb15f92c3
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
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
Changes in v2:
- Use trace event template for the two tracepoints (ty Steven Rostedt)
- Link to v1: https://patch.msgid.link/20260729-panthor-cache-flush-fix-v1-0-205921ed3c81@collabora.com

---
Nicolas Frattaroli (3):
      wait: Introduce non-irq variants of wait_event_lock_timeout
      drm/panthor: Revisit reqs_lock handling in flush/reset paths
      drm/panthor: Add tracepoints for cache flushing

 drivers/gpu/drm/panthor/panthor_gpu.c   | 28 +++++------
 drivers/gpu/drm/panthor/panthor_trace.h | 49 +++++++++++++++++++
 include/linux/wait.h                    | 84 +++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+), 14 deletions(-)
---
base-commit: 5e24f68d311764bf343f9def49b752b509dfd5fd
change-id: 20260728-panthor-cache-flush-fix-b36cb15f92c3

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

