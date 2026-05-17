Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10194CD4F21
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 14:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 744C710E27B;
	Sun, 17 May 2026 14:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="gZXHDU0h";
	dkim-atps=neutral
Received: from mail-03.1984.is (mail-03.1984.is [93.95.224.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3443810E27B
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 14:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com; 
 s=1984;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qMNdWleJAyyXRPfAgARUZHHfO8D6SfRFtzZ2O+6AJUs=; b=gZXHDU0h97/hJ0rt3WX8xMp897
 Yy8KVei6rnJ1XaNaa8cnORqUlvyflSUG5lgc2KIVNQp9GrFeOw4q0pKLEc7/C0PONysCPg5q810U3
 OPVcmMIb0gyGflWmIYdM/KOyd3I7iuvJnO07hfruO4LNpVo2Pwh2yuBzdyZYdutDhELApr5a3LCFz
 zArE+Mz8gvCIR0Ky2Q8twil6iFB4aQ0KoU9LXk1oTMVoHnn76EH5mzcq511DPH3HXsNAf6mn/AyWz
 uUJ7VQXwRvtLAVZU5m/Vw29x/ems4bv56mhqY8urXUXgYOHvYrzc46BgjO4vb9vvVJrMzQfZpDOvu
 KAvvdyYA==;
Received: from localhost by mail-03.1984.is with utf8esmtp (Exim 4.96)
 (envelope-from <me@berkoc.com>) id 1wOcHC-00HFSV-2m;
 Sun, 17 May 2026 14:15:31 +0000
From: Berkant Koc <me@berkoc.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Michael Kelley <mhklinux@outlook.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Deepak Rawat <drawat.floss@gmail.com>
Subject: [PATCH v2 0/2] drm/hyperv: harden VMBus message parser input
 validation
Date: Sun, 17 May 2026 16:25:00 +0200
Message-ID: <20260517-drm-hyperv-cover-v2@berkoc.com>
In-Reply-To: <20260517-drm-hyperv-cover@berkoc.com>
References: <20260517-drm-hyperv-cover@berkoc.com>
 <20260517134926.B4179C2BCB0@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: git-send-email/2.47.3
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
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

v2 folds two further issues into patch 1 that the sashiko-bot review
pointed out on v1:

  1. The resolution_count bounds check in v1 returned -ENODEV, but
     hyperv_connect_vsp() only logged a warning and continued without
     setting hv->screen_width_max / height_max / preferred_*. That
     left dev->mode_config.max_width and max_height at 0, which made
     drm_internal_framebuffer_create() reject every userspace
     framebuffer with -EINVAL. v2 falls back to the WIN8 defaults on
     that error path, matching the pre-WIN10 branch.

  2. The three sequential VSP requests in hyperv_connect_vsp()
     (negotiate version, update VRAM location, get supported
     resolution) all wait on the same hv->wait completion without
     calling reinit_completion() between requests. A delayed
     complete() after a wait_for_completion_timeout() can leak into
     the next request and let it parse stale data out of
     hv->init_buf. v2 calls reinit_completion() before each send.

Patch 2 is unchanged from v1.

v1: https://lore.kernel.org/r/20260517-drm-hyperv-cover@berkoc.com

Berkant Koc (2):
  drm/hyperv: validate resolution_count and harden VSP request paths
  drm/hyperv: validate VMBus packet size in receive callback

 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 32 ++++++++++++++++++-----
 1 file changed, 26 insertions(+), 6 deletions(-)


base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
-- 
2.47.3

