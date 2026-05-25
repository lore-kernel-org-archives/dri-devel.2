Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46A3CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 23:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 104D010E350;
	Mon, 25 May 2026 23:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="OAv5XXRG";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1889610E350
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 23:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779750233; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=W16URHxLrRf063Nbc1cqwkLKgLZgiB0XMk2IDwWlx6KWfVjZJlD5p6Yuw2MH2xlwW6MuThbc/9hBCRMdN0++CvZhpZvFxPT7Ecs5OrnASm4F6L8Jc5cbt3lxfPds2gYIN8Zw7Wv6JjAPQZupQoMsOxYQo41L9hU5Iw7+pbl6L3U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779750233;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=r59dlwZbto10IILOaFizsE9SyZW/qPRtuY80fbqubEc=; 
 b=AIFg4fRDK5MEZ+4kq9YLIIUZ1NvxihbpiZw7ftw9WLI1yfIaX/T7+idoh2U0hulxDb5s4CIGevG1zvD2eX0EWOatfMYhG8XXBOrNT/5jW+FoOShT1Cutq6ZlBnXmtSX9qolZXuZDpekMSvXxfzZG7l4UOKGFBtRYl/JePJaFqXM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779750232; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=r59dlwZbto10IILOaFizsE9SyZW/qPRtuY80fbqubEc=;
 b=OAv5XXRGgMbCVTcRwAmIrEnn3DsVcEb3+MIdfOdQOMvHGiopXiV0YNnIjECmdfxq
 DelHSzV9ZXjVRUkzoLCW6wJU4notJ8ojyGKg8R7bnbDvpKJIxQRZ8fCKKlgkn4iJxiA
 YotLb4XyXzjWjwYgjhE73NYntJcQ52QJyvyNkXXw=
Received: by mx.zohomail.com with SMTPS id 1779750230905980.2652943115111;
 Mon, 25 May 2026 16:03:50 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH 0/4] RPM, percnt and other minor fixes for Panfrost
Date: Tue, 26 May 2026 00:03:34 +0100
Message-Id: <20260526-claude-fixes-v1-0-16e92eaa4949@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM3QpAQBCG4VvRHNtau0huRQ72ZzAS2kFK7t3i8
 Onr/S5gDIQMdXJBwIOYljkiSxNwg5l7FOSjQUlVykJp4SazexQdnciiUlZqk+ncVA5isgb8hlg
 07W/e7Yhuez/gvh/6RbXRcAAAAA==
X-Change-ID: 20260523-claude-fixes-82b03a134a8c
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1582;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=DnfFqmHwIQLq09vcFweT1CVuLAK6yegUP4USc7+CNq0=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqFNVTnk23auY6SQqh7Z3BNaNT73C48bkvGpQJg
 +qHL6kPPKuJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCahTVUwAKCRAOJn5M7lND
 PfOzC/9eZhilMTOvPSXSXeIzqYwOLGCbLvXe7CWOSxU/ItrOqIjooOPuUP+ZNfBSug5ySJdegAU
 YNi1zzIDVREMyvNxhbiFIZ+s9eLd9DSQ9YZuRk5rLI1deotA4LE7cxdvDUvLRjnIe1mA50HXTvZ
 0/qtECBjjL5w5vJQuNOhEB2glq9UGhVloN1TZviL1Rew0oydMyhrU++6P6UdaKPrGT154DM8Ilj
 V3WaUCI7M4p7BtrxOsAChM7t1PIudBsPgz02cwd+iZDZvxE84LlNNEYx4/fmTNR8jeCH9sMw7qn
 BbBMmIU9FK6/tIJd9T6z+JWSBbNpJJyBKjSPwg8A+Al8e+DS8mAPfr+2KZaOOjKfhOQ1RcEC8/e
 iQ/wn2I7/tNpl//J0OItigmBd/T+CIrG9cPHsmOoPYq7AS8el5iueCRBPDJ66TMAiAKFxJNbDMT
 1X7jwIhsj/P2D6Omuv6j5egDdlBUhcYRJO0YkTSXkFePMGJIwLtjxxh95tOWuRjZC6wEg=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

This patch series comes with some minor fixes for Panfrost. Some of the
issues addressed were uncovered by LLM tools, while the one about RPM was
traditionally debugged.

I haven't yet added any Fixes or Reported-By tags, because the purpose of
the first revision is probing appetite for these changes and eliciting
early discussion.

The only proper bug fixes are the ones for perfcnt and RPM, and the others
are more about ensuring robustness. perfcnt bug was never observed in the
open, because no one had faced a HW reset when a perfcnt session was
ongoing. RPM fix addresses a long-standing issue I had been observing for
quite some time, but that I had completely misunderstood.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
Adrián Larumbe (4):
      drm/panfrost: Check another bo field for cache option query
      drm/panfrost: Make reset sequence deal with an active HWPerf session
      drm/panfrost: Prevent division by 0
      drm/panfrost: Fix RPM so device suspends when no jobs are in flight

 drivers/gpu/drm/panfrost/panfrost_devfreq.c |  3 +-
 drivers/gpu/drm/panfrost/panfrost_device.c  |  1 +
 drivers/gpu/drm/panfrost/panfrost_drv.c     | 10 +++--
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 58 +++++++++++++++++++----------
 drivers/gpu/drm/panfrost/panfrost_perfcnt.h |  1 +
 5 files changed, 49 insertions(+), 24 deletions(-)
---
base-commit: c1079aebb4de218caa86c44f9a53700d1a582683
change-id: 20260523-claude-fixes-82b03a134a8c

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

