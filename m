Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F597CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 13:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8616410F332;
	Thu, 21 May 2026 13:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="TAYlyn8L";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 996DF10F32F
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 13:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779371491; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Xj1l6SCXFilAgiCmPOoUOIOipkS1n0jV6y+dEbnFm9OCFziJ+pIwZfcpnThnHe9obVVsilBddkUDGnQJE7V2bat5UcsULJ6hDaONzGQH2TKc8jCdcVA59n/ShQwou69iV2wCJW1B/kmcpHFVkdo6Lhc5ZQKV5L/W4B3MyHCKE6g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779371491;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=27/DsMQHvE8GN7cV15fGmw7sO45eST2Z/oa3bBIf+lE=; 
 b=BcTj2kkrNoY6tDulEWt1fPLGkrVYAaeTp29T/9xP4KLU2VDdOVTNf/llv1PjP0higG99utbfap4dyGfF5xej4iPVqO6XKQolFr01FevCEfDxNIk37cYM/cY7zJh4NPiWZIGdfdknRYyZb6CyCPStwj8WSuL74Hx6TgV0x8S+u8o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779371491; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=27/DsMQHvE8GN7cV15fGmw7sO45eST2Z/oa3bBIf+lE=;
 b=TAYlyn8LY+97jWSBVzBleNt9nnlhRX28es/ZLtZjD+nyHlmV5FlQbE5aSM68P4fu
 z6T+7D/0XQzPgq/bZDbXN4vlcefl7WObwRT2HcPMXBwrSu+bMpSM/AaPIXjFEinGq7i
 tlwSGegXHsxOgoGDP/1nDTh0Vhf0zWRwZVYc6ndI=
Received: by mx.zohomail.com with SMTPS id 1779371490551254.02408473226046;
 Thu, 21 May 2026 06:51:30 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v5 0/2] Let userspace know about swapped out panthor GEM
 objects
Date: Thu, 21 May 2026 15:51:14 +0200
Message-Id: <20260521-panthor-bo-reclaim-observability-v5-0-49313994da55@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43PwW6DMAwG4FdBOc9TQkIoPe09ph2cYEYmIF2So
 lYV775AJ62aeuBoyf7+3zcWKTiK7FjcWKDZReenPFQvBbM9Tp8Ers0zK3mpuSo5nHBKvQ9gPAS
 yA7oRvMnIjMYNLl2hqbmuG9tUUlqWmVOgzl22iPeP+xzP5otsWt3fjUDf55yd7mvMYCSwfhxdO
 hZtGGF00cJElwRrEeAVCMVWrXcx+XDd+s9iO95fdRbAAVUrUGqig+rerB8GND7ga07fAubyERU
 70DKjthGyImo7o5+i8hGVO1CZUc2xk6XQCp83VX9otet9tb1fo9HCmgNv/6PLsvwAs/e9zCECA
 AA=
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

In this series, Panthor's gems debugfs is extended so that information
on evicted pages can be gathered by users.

---
Changes in v5:
- Drop fdinfo patch to unblock series
- Don't set the flag introduced in fdinfo patch in panthor
- Link to v4: https://patch.msgid.link/20260520-panthor-bo-reclaim-observability-v4-0-a47ab61cb80d@collabora.com

Changes in v4:
- Change "evicted" memory type documentation to no longer explicitly
  mention swap
- Link to v3: https://patch.msgid.link/20260423-panthor-bo-reclaim-observability-v3-0-60af32164a4f@collabora.com

Changes in v3:
- Add documentation for new "evicted" memory type in fdinfo
- Link to v2: https://patch.msgid.link/20260421-panthor-bo-reclaim-observability-v2-0-c9135eedfb6f@collabora.com

Changes in v2:
- Change reclaimed_count to saturate at INT_MAX
- Add "evictions" column to panthor gems debugfs which prints
  reclaimed_count
- Add a patch to reduce the padding of one panthor gems debugfs column a
  bit
- Link to v1: https://patch.msgid.link/20260420-panthor-bo-reclaim-observability-v1-0-a4d1a36ee84f@collabora.com

To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

---
Nicolas Frattaroli (2):
      drm/panthor: Implement evicted status for GEM objects
      drm/panthor: Reduce padding in gems debugfs for refcount

 drivers/gpu/drm/panthor/panthor_gem.c | 16 ++++++++++++----
 drivers/gpu/drm/panthor/panthor_gem.h | 10 ++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)
---
base-commit: 69c95e4c529297c25503e60acba757fba24fdc95
change-id: 20260420-panthor-bo-reclaim-observability-970679c9533c

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

