Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB17F589AE
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D870B10F0E4;
	Thu, 23 Apr 2026 12:34:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="DHMjEIIm";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1922410F0E3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:34:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776947658; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XTmHN+tV0MIGK5aqaDPw8HcQyzWVYpLFsir0FYdJVsqv28qvTgWUctgTuPRE77vz2XB58PslObWzmXahJQTmOrV7iR+cFctYuA3qC+2GsbqGBYJL+tEhkG/FKCk6xAal1ikM7CXorYOSFC2tGi34a85xhn0nLqd6IKGDSR9wm50=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776947658;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=CStP1DqQxTgYqx2BhlJgSeGhG6tXLv7gidRy1lV9Kak=; 
 b=Cy4dnzRKRqkTDKS2+b+FfoVUNArJVlqTPksR2xoH5sZKYCDQwS+ZuHqyo7l92zVhhbWN46jxcDiPRwGqfHK3DJjXnHptqEdDmVuFjOKfr2IFDwzSET/20gs87ksjY0M6QLs+SVMebPK00hHJ/RwnWc9GT3PKQEv6XbqsLdimCg0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776947658; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=CStP1DqQxTgYqx2BhlJgSeGhG6tXLv7gidRy1lV9Kak=;
 b=DHMjEIIm5PMzd8lQjJOREHhc9M7R4CrD3Wi7zCgq+t9AK5PIWzkteIQ1wH0ViwIS
 +D6LDIAN1bKUAaz6XGH++EVUgtzQ9eLJ1MLk/+1tLnY2tQgE+GHPRnDTM3JHAJ6D6tT
 k0TBKub5/6tjGnmzFMhhXAR2PiiAbbwW9mQWxiWU=
Received: by mx.zohomail.com with SMTPS id 1776947656722924.679686641161;
 Thu, 23 Apr 2026 05:34:16 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v3 0/3] Let userspace know about swapped out panthor GEM
 objects
Date: Thu, 23 Apr 2026 14:33:53 +0200
Message-Id: <20260423-panthor-bo-reclaim-observability-v3-0-60af32164a4f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OS47CMBBErxJ5TY/8CYGwmnuMWNhOhzSKY7CNB
 UK5O06YxUizYdUqqfq9erKIgTCyQ/VkATNF8lMJalMxO+jphEBdyUxy2fBacrjoKQ0+gPEQ0I6
 aHHhTIFkbGik9oN3xZtfadquUZQVzCdjTfVX8HN853swZbVq4v42A11txp3eNGR0RrHeO0qHqg
 gNH0cKE9wTLEOB1uWyhDRSTD491fxbr8+dTswAOuu6EVg3ivu6/rR9HbXzQX8W+CrL8CxUfQGW
 B2laoLWLXm+YfdJ7nF+99uhJ3AQAA
X-Change-ID: 20260420-panthor-bo-reclaim-observability-970679c9533c
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, linux-doc@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Cc: linux-doc@vger.kernel.org
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

---
Nicolas Frattaroli (3):
      drm/fdinfo: Add "evicted" memory accounting
      drm/panthor: Implement evicted status for GEM objects
      drm/panthor: Reduce padding in gems debugfs for refcount

 Documentation/gpu/drm-usage-stats.rst |  6 ++++++
 drivers/gpu/drm/drm_file.c            |  8 ++++++++
 drivers/gpu/drm/panthor/panthor_gem.c | 18 ++++++++++++++----
 drivers/gpu/drm/panthor/panthor_gem.h | 10 ++++++++++
 include/drm/drm_file.h                |  2 ++
 include/drm/drm_gem.h                 |  2 ++
 6 files changed, 42 insertions(+), 4 deletions(-)
---
base-commit: ea61048876a7137897da26dac49ee234fb38a35a
change-id: 20260420-panthor-bo-reclaim-observability-970679c9533c

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

