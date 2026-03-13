Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724AA105F7B7
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 15:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F2110E179;
	Fri, 13 Mar 2026 15:17:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="RiaGjnbN";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A38EC10E040;
 Fri, 13 Mar 2026 15:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1773415055;
 bh=5eNoYHCSMzYd+S9So2IEnn5g5OJgECQY4oOJqyqNQ4Q=;
 h=From:To:Cc:Subject:Date:From;
 b=RiaGjnbNh5n9PAPwvu07ivoOA7VYSI2oxofQvoLs//39emKpb0r/B2KWK6XXrEavQ
 LvVr20W4naGz4PJTi3N/SwTH8z+5K3zLMfk/YzoHAvOtmlC2GQbWOV6Fy0ZLIiikbr
 47lpo3oc3EpQBelckc1tNbzgwYTUWJMq/McVmLYloIhYsYOA14h9gOHklfzCjqv03m
 9NVzTfGLb6wnL/lZBu4l1unxUGmuBVwBBXmgji7Xtlm1Kfx4Xpe3LNVIqXVcacK2+i
 ascrK++9V1Vh50bOWNv7Vo3b308TCCVpyGrxwT9GF565UN6DZVB7DAgqlwZT3hHXNk
 KCWacN7KJg1IA==
From: Maarten Lankhorst <dev@lankhorst.se>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v2 0/1] Fix use-after-free on framebuffers and property blobs
 when calling drm_dev_unplug
Date: Fri, 13 Mar 2026 16:17:26 +0100
Message-ID: <20260313151728.14990-3-dev@lankhorst.se>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

I tried to see what happened with xe_module_unload --r reload on a fully
running system, and came across these bugs in the kernel. Even after
these fixes I still see a hang when reloading, related to cgroups, so
likely some more fixes are needed to address those.

Should this patch have a fixes tag or cc stable patch?

Test-with: https://patchwork.freedesktop.org/series/162133/

Maarten Lankhorst (1):
  drm: Fix use-after-free on framebuffers and property blobs when
    calling drm_dev_unplug

 drivers/gpu/drm/drm_file.c        | 5 ++++-
 drivers/gpu/drm/drm_mode_config.c | 9 ++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.51.0

