Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BB4C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:27:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 800B710ECF2;
	Tue, 22 Sep 2026 13:27:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Kscz2ohy";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B2A310ECE4
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 13:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=9AH7XvUQeXimKEn+NYgT9twLa6tDkMKRqTcvWt2w9HA=; b=Kscz2ohymasZpCaeDbhnD6k7zB
 Jxs1GN+31sbjzsOiRe1ziyThUf2+8gGwndcssbpYFyFXmnHMXomaZAiDHFDyLbx15nfhg2+iTRm/8
 ZzvluiTglUdadF1e0/ul9KpL9aOXVmNQuQ335zhhNNXVdjhFcyiD/JimQ4z7V9xc0KvjdMsJRwleT
 PPDYq/DQP91eL5dfKwWaFkWc0wL8XkYN9mU/tOvsoruD3oPyLyexiLjwoRLW5EkWxcW+ri6XQObL5
 hXnTvlbkTCLQyb2XX3n2axJIucGWjI7jY3YE1Qb2WM1XGN1nUURRyhSFFBnl83zRmGG3bDMo3KJ50
 Jjr/ODKQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x90WS-005e24-FX; Tue, 22 Sep 2026 15:27:01 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH v2 0/2] drm/v3d: Skip perfmon serialization when it cannot
 be observed
Date: Tue, 22 Sep 2026 10:24:49 -0300
Message-Id: <20260922-v3d-quick-exit-perfmon-serialize-v2-0-2a8021dc32f2@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WNQQ6CMBQFr0K69pu2BgFX3sOwaMpDfhSKLTYo4
 e4WbuBy3ktmFhHgGUFcskV4RA7shgT6kAnbmeEO4iax0FKfZaUVxVNDrzfbB2HmiUb4tncDbRr
 z5C+oQoXSwti8LETSjB4tz3viVifuOEzOf/ZiVNv6hzwqkoS8NDBKFjn0le/pMUfrelGv6/oDg
 2PvINEAAAA=
X-Change-ID: 20260921-v3d-quick-exit-perfmon-serialize-9e9e8ceac587
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2308; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=SvnWAHQ8qQhZvBxQj16oHUsot9td84jQ0Le+KSmY5mA=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqsoHJUNVLJf2pTaUtk5i6EbgzgCozQ4VEDg4xy
 MM9yuQHHiKJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCarKByQAKCRA/8w6Kdoj6
 qoMxB/9THBVxfNvTvP3unsi8CSPb7Chd2aGRuEu36bre0SXt+m+AYmBox7ZLbBlrPhPwksX7N5D
 SLtd9AfQOU2AZG73lsu+6o7mUFdJAqcJ45VNkXIX4A5/GzR5tM21iwK6pzHNu3CD1niC4N9kb/E
 iGf7DwEEF/y5Fz9sN0mYzKzQ24yvKp0Ncn7CPjsE2H3OQmmbiOAC2DE0N7doqPt9XSSV2ourWG7
 H/Cmj51Z7mLqYFCxoZQ6ZDnAraIKeu+hiSPtsoGrxxFwftLNru+kLgi3ZBeCwUULxQD3EoegmCE
 jc0YcWdB90VqQga0YYe9vlk7rkiqvJIzGURBIYox6SgJynm8
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The V3D core has a single set of performance counters. So that a perfmon
only counts the jobs it is attached to, a job carrying a non-global
perfmon waits for every job still in flight, and while it is in flight
every later job waits for it. Knowing what is in flight requires every
job to merge its finished fence into a per-queue accumulator.

That accumulator is maintained unconditionally, so a client pays a fence
merge on every job even when no dependency can ever be built out of it.
This series turns the bookkeeping off in the two cases where that holds:

  1. No perfmon is alive on the device, which is the common case since
     perfmons only exist while userspace runs a performance query;

  2. A global perfmon is set and the job carries no perfmon of its own.
     A global perfmon counts concurrent activity from every job, so
     nothing has to wait. Jobs carrying their own perfmon stay tracked,
     since the global perfmon may be cleared before they run and only
     one of them can be programmed in the HW at a time.

Both share the same trade-off: a job that goes unrecorded never carries a
perfmon, so the only cost is that the first job measured after tracking
resumes may overlap it. Considering the use cases of performance monitors
and that it will only affect the first job, it's a reasonable compromise
to make for the average case.

Best regards,
- Maíra

---
Changes in v2:

- [1/2, 2/2] Add Iago's R-b to both patches.
- [1/2, 2/2] Add a comment to the last_hw_fence field expliciting that
             tracking is only done while nperfmons > 0 and no global
             perform is set (Iago Toral).
- Link to v1: https://lore.kernel.org/r/20260921-v3d-quick-exit-perfmon-serialize-v1-0-e58aea1075e2@igalia.com

---
Maíra Canal (2):
      drm/v3d: Skip perfmon serialization while the device has no perfmon
      drm/v3d: Skip perfmon serialization while a global perfmon is set

 drivers/gpu/drm/v3d/v3d_drv.h     | 14 ++++++++++++--
 drivers/gpu/drm/v3d/v3d_perfmon.c |  8 ++++++--
 drivers/gpu/drm/v3d/v3d_submit.c  | 19 ++++++++++++-------
 3 files changed, 30 insertions(+), 11 deletions(-)
---
base-commit: 8ef59ee794076e2b58cff357b12de2ba5d441271
change-id: 20260921-v3d-quick-exit-perfmon-serialize-9e9e8ceac587

