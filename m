Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5225F588E7
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 15:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49FE510E6B3;
	Mon, 20 Apr 2026 15:47:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="aKqAO/yE";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E535E10E6B3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776700043; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nj/jSH35QPgcNZ8Z4mHWoTD5eHlj1SbrvPdfEXJR6CYZSohdR1KXZJoqgxPPwMr6oBuEMYWlCSC0QZ9+TvbrQmj0UsryRkWChpFwZtHRvG6o3tJjq6VQqm3FuCU2ONMabVFhoPBjBa8C5OWKacWra0LDSt4TCWmEhYX2cxqEKEI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776700043;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tq+45xuZOrGUm2FZZCTQ7EAbkpHyxDQ8MsYlQTLecK4=; 
 b=a1lCCrnfe0FkZ+U1ipsCOgyPtI9bRXD1fCExEN6ODGROo0zTGOQw5zrni0zHavhFwicz+qkgqiK7qWjaoIL7kIT/w+8YJ6o/6iIDrizGJH7i3rH8wfdBNx8jdzFzoBBKTJtPGMMYZ3DPajyS0kQwOVWHUh9KEKVObgZlTKEqpxI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776700043; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=tq+45xuZOrGUm2FZZCTQ7EAbkpHyxDQ8MsYlQTLecK4=;
 b=aKqAO/yEq7mNV+vsSUjx2sdgaiu2iPJZc2TfsRSDiKf9znyc2+7d02OqqZZCYjSd
 33pVFpjkwLg69NQQOuZF2/I84FyKEPB6WYr7J3UNmFjYbNFnyHcWBYB3prMuP5Wkdde
 ZuYZmrWiyNPb10E72bsH8YfoS1Jn7EFq9sFKwfeo=
Received: by mx.zohomail.com with SMTPS id 1776700042207398.0105287533718;
 Mon, 20 Apr 2026 08:47:22 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH 0/2] Let userspace know about swapped out panthor GEM objects
Date: Mon, 20 Apr 2026 17:46:58 +0200
Message-Id: <20260420-panthor-bo-reclaim-observability-v1-0-a4d1a36ee84f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWNQQ6CMBBFr0Jm7cQKCoGrGBZtGWUMbbEtBEO4u
 1V091/y894KgTxTgCZbwdPMgZ1NcDpkoHtp74TcJYZc5KU45wJHaWPvPCqHnvQg2aBTSTJLxQP
 HF9aVKKta15ei0JA0o6cbL9/Etd05TOpBOn68v4en55Tacb+BkoFQO2M4NlnnDRoO+vgfaGmJ0
 G7bG8rdYWy+AAAA
X-Change-ID: 20260420-panthor-bo-reclaim-observability-970679c9533c
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
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

Panthor has recently gained a GEM shrinker. It allows evicting memory
that backs unused GEM objects to swap.

In this series, both fdinfo and Panthor's gems debugfs are extended so
that information on evicted pages can be gathered by users through these
two methods.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Nicolas Frattaroli (2):
      drm/fdinfo: Add "evicted" memory accounting
      drm/panthor: Implement evicted status for GEM objects

 drivers/gpu/drm/drm_file.c            |  8 ++++++++
 drivers/gpu/drm/panthor/panthor_gem.c | 10 ++++++++++
 drivers/gpu/drm/panthor/panthor_gem.h | 11 +++++++++++
 include/drm/drm_file.h                |  2 ++
 include/drm/drm_gem.h                 |  2 ++
 5 files changed, 33 insertions(+)
---
base-commit: 3f9357c30a44734d45e3093c521d52b2aefb09f5
change-id: 20260420-panthor-bo-reclaim-observability-970679c9533c

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

