Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D92C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 06:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66EC010E233;
	Wed, 29 Jul 2026 06:20:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="CEDGyZxp";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F302210E233
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785306010; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SxENcy4tAWPxuWcNsnzQZy+NRXukQck1HEgibJdYohf5+GOXWjJzdD4vgWq0vj/Mo23/o98LSN+4/bnRfLjkRPHB8vEcqtXE/rH/rpfJ/+Xs5/NtVW/yZRVdhbRla1s3mNAtZsKKk5YCF/H84Zdl5PbF1x6RSNJnufccR5NK9MM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785306010;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=LcPy/OklKjXHhgvBvBHEu3COEFzG3JBaEkM4/MoUaTE=; 
 b=Ulp58vzVpnn/U5S6ERm1Ffn/n0y+SdYub/vXCKr4UNNiodDTqvskVS+mdoTnzeDqnUbPjDvafo0jt4itCHcpDlqVWo4Iy2y2u+xvJGdxCdj22S6Yee+bD/rZK+sRri85w85SNgiuB5nGcM16iusvJqSAv/kWnjcDV22qJ7xPYHM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785306010; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=LcPy/OklKjXHhgvBvBHEu3COEFzG3JBaEkM4/MoUaTE=;
 b=CEDGyZxpEA3OY7CQut62GIFC1HbN2zo2berK78ebV1ydLX3T+3I0YU6k0Y2BJ/od
 FuUlGKIcu8FaD9DxV31i+LbCnxIGKpb2or2djF9Hb8UgBkSviCn+N304+/k+gWM0G6Y
 4rh3EX29+lQr2HWmRpYPKlL7vZ7urtHuPXfYyQQM=
Received: by mx.zohomail.com with SMTPS id 1785306008697356.1189702710186;
 Tue, 28 Jul 2026 23:20:08 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH 0/3] Rework panthor's cache flush and soft reset locking
Date: Wed, 29 Jul 2026 08:19:48 +0200
Message-Id: <20260729-panthor-cache-flush-fix-v1-0-205921ed3c81@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NTQ6CMBCFr9LM2olQIipXMSzaYbBjLGBbjAnh7
 lZh9fK9vJ8FIgfhCI1aIPBbooxDhvKggJwZ7ozSZQZd6Lo46wtOZkhuDEiGHGP/nKPDXj5oq5p
 seeqvmirI7Slwtv/Lt3bjONsHU/rN7YnArzlfpi0G1kRGGr2X1KgueEwyHXeFdl2/VC+/Za4AA
 AA=
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
Nicolas Frattaroli (3):
      wait: Introduce non-irq variants of wait_event_lock_timeout
      drm/panthor: Revisit reqs_lock handling in flush/reset paths
      drm/panthor: Add tracepoints for cache flushing

 drivers/gpu/drm/panthor/panthor_gpu.c   | 28 +++++------
 drivers/gpu/drm/panthor/panthor_trace.h | 58 +++++++++++++++++++++++
 include/linux/wait.h                    | 84 +++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+), 14 deletions(-)
---
base-commit: f57436380d5de1c1ded898e21378b0b4159c8790
change-id: 20260728-panthor-cache-flush-fix-b36cb15f92c3

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

