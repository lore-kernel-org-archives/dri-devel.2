Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F82CD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 22:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19FCE10EC03;
	Wed, 10 Jun 2026 22:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ZRTcCX11";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 196AC10E563
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 22:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nh3RigvW6ljD4vTO/ZO6MABgQavth7p9zrjMGp7Sy5M=; b=ZRTcCX11mDrn5OsgVklFHCC5fK
 /PWA2SA2YnIY5/AjLWDupa6oADgrRxQ+Ws51Qmm3GU/FRTjJu7LbD2DNaD2driEl83J1o4TQp7Q1W
 YRlOzOkk7m3ylJQI+vxr7853+fJCCrr42U5A3f7sX2brIHhMru313tPFzoiunVGs4cXYTY2/XSHgB
 hdRfemdTNUx1IMAItqWlSDnM6FjxUyLLcDUg0Pe10vsp8mAWXC+rMbzj+dVCrfR1iw0MKN0oXkm+/
 4sbxEdklW07jP5kVb85ACWW5jXTg0yH2sVJeaQUy8mIOKZuh8TUKlwbz69ByocKs4gpymc4sTSBFG
 KIu6B8yA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wXRlN-00FrrZ-5e; Thu, 11 Jun 2026 00:51:09 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/3] drm/v3d: Miscellaneous fixes
Date: Wed, 10 Jun 2026 19:50:58 -0300
Message-Id: <20260610-v3d-cpu-job-fixes-v1-0-0d9c88989edc@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LOwqAMBBF0a2EqR3IBwXdilgY89SxUElQhODeD
 ZaHy82UEAWJOpUp4pYkx15gKkXTOu4LWEIxWW0b3eiWbxd4Oi/eDs+zPEg8e1hdGw+4kcp3Rvy
 hbP3wvh9v4WvdYwAAAA==
X-Change-ID: 20260609-v3d-cpu-job-fixes-fbe2051bee3a
To: Melissa Wen <mwen@igalia.com>, Iago Toral Quiroga <itoral@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1240; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=dXBAbX42eCidjgfa/wex1i8gS6ldIZfIYHCV5QUADOE=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqKepaCG12F9MeoqxurYXW+b40adANziqYTWmGK
 zsMV9sbP0GJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCainqWgAKCRA/8w6Kdoj6
 qsfNB/4lyupdBCCMkaezcuIMuSpv7QJfzF0GIkEUpp01BrnUJMk20pFzRYem5Eh48k1yPFPpQ7E
 WwOrsnVnbxcbqmc6ql36409qzudhr72CCk3ufdYzAjmi3rv13dBIj0ZL+pohYZms4+PkJTdI7BT
 eUlAytPbQapO9UAA065xqeDM/8P/cqgdlDEOTOKIrMKIdXIRhMZFFsw0fBLUrP0+QeTH3FeGJdy
 XTrncDA46DSo92E5LVD3Zf5+/V55IOz3HlwNOHQY/zhj8NM9TIzuBrxSlQsdwOIiyL+bgfyrRCJ
 e4PLP8G8+/Fe9GbV+qwo5w0vztnKgIkqp7YLB4iYgki5EUAy
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

Being brief, this small series collects a correctness fix (#1) reported by
Sashiko, a error-path fix (#2) reported by Sashiko, and a cleanup (#3)
found while reading the code.

The first patch is the only notable one: a v3d submission expands into a
chain of jobs (e.g. BIN + RENDER + CACHE CLEAN), but the BO list was only
ever attached to the last job. Since implicit synchronization is added
per-job and gated on job->bo_count, every job before the last one silently
skipped implicit dependencies. In practice the binning job could read a
buffer object while another context was still writing it. It's fixed by
looking up the BOs onto every job that references them.

Best regards,
- Maíra

---
Maíra Canal (3):
      drm/v3d: Associate BOs with every job that accesses them
      drm/v3d: Reject invalid indirect BO handle in indirect CSD setup
      drm/v3d: Use write_to_buffer() helper in performance query copy

 drivers/gpu/drm/v3d/v3d_sched.c  | 11 ++--------
 drivers/gpu/drm/v3d/v3d_submit.c | 43 ++++++++++++++++++++++------------------
 2 files changed, 26 insertions(+), 28 deletions(-)
---
base-commit: 2df5efb45425b48fbf5a3c1f36a686af26871009
change-id: 20260609-v3d-cpu-job-fixes-fbe2051bee3a

