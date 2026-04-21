Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DADF89256
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 10:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE0C10E023;
	Tue, 21 Apr 2026 10:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="LV7rGMn7";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E3B10E023
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 10:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776768350; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lHAAwkz3zwSkImRYEAC9nSDrdai4WnYr32tgge1sYxrCzNA4+XDoS6Mcp69F1xp7//E+m8zegmbtbCED9aMykow7hquaurL7HlWmKri0aIbxpBynrV0AW4nx8SzQCCL0a0867Ya6f4SP+jAj4m8GgBg2zsRJgJUtLciuq/9fOqU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776768350;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=m/MmJ47Gr9IoAobW8sWPbsECGc4PqpV/447xs8/mWR4=; 
 b=eyHYeEHKOwU0iYUVh/56o2pcp0rjxcURahrwctW3vxI9LmmeWcebvWCsp5Fumo8UTnpWqbFJ4gv5D6oOH7mfKxLI+mlVpiBESJQR3w8Qj1hmLE0AQfBcWfBRB9vQ+Os16+PtDi7VZEmUoGWlwmxeKSnlc8DHDqeEDwsYAzi1ifk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776768350; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=m/MmJ47Gr9IoAobW8sWPbsECGc4PqpV/447xs8/mWR4=;
 b=LV7rGMn7CDrbeMvhSegQJYWWmj0COlnz/tTyc8dKqVkcnYMNXVWxGEVKRaC/sWd8
 VEsPZfDpx1GNe5650wtoGNXw/C+4UIvX/tgfhr48yqSh8jpzPJC9cgHc2sPZBfXBXj6
 LOt9sePf7/RfvTTiF3y9mS2rtic6pEHPlkpyXHG0=
Received: by mx.zohomail.com with SMTPS id 1776768349281337.8570273075851;
 Tue, 21 Apr 2026 03:45:49 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v2 0/3] Let userspace know about swapped out panthor GEM
 objects
Date: Tue, 21 Apr 2026 12:45:12 +0200
Message-Id: <20260421-panthor-bo-reclaim-observability-v2-0-c9135eedfb6f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Oy27CMBBFfyWaNdM6jwbCqv9RsRg7A5kqjunYR
 CCUf68J7Z7dHOnOufcOkVU4wr64g/IsUcKUodoU4AaaTozSZ4bKVK1pKoNnmtIQFG1AZTeSeAw
 2S2ayMkq6Ybc17bZz3UddO8ias/JRrmvF1+HJ8WK/2aWH9y+h/HPJ3ekZA0uR0QXvJe2LXj16i
 e79/8CJrwkerkFiCnpb18/l+vr60LlEg9T0JdUt8645frowjmSD0lvuhsOyLL8wHi9eIAEAAA=
 =
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

---
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
Nicolas Frattaroli (3):
      drm/fdinfo: Add "evicted" memory accounting
      drm/panthor: Implement evicted status for GEM objects
      drm/panthor: Reduce padding in gems debugfs for refcount

 drivers/gpu/drm/drm_file.c            |  8 ++++++++
 drivers/gpu/drm/panthor/panthor_gem.c | 18 ++++++++++++++----
 drivers/gpu/drm/panthor/panthor_gem.h | 10 ++++++++++
 include/drm/drm_file.h                |  2 ++
 include/drm/drm_gem.h                 |  2 ++
 5 files changed, 36 insertions(+), 4 deletions(-)
---
base-commit: 3f9357c30a44734d45e3093c521d52b2aefb09f5
change-id: 20260420-panthor-bo-reclaim-observability-970679c9533c

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

