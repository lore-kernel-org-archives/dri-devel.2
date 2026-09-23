Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2F0C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 18:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2376610E137;
	Wed, 23 Sep 2026 18:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="TxhvpBzJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E84710E137
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 18:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=w8KP7d7Zhm557qDuz3R7pAh3sl9P6YepNQ03SUq6HfQ=; b=TxhvpBzJDRWlQhXQT94Lf1+iDg
 32G2a3yvJ7z+yPq2YucMZD3ZiflRY2Vk/M4mwDA7aU9UWWeGl+seahFeFXOXDB5wIQbqqIPKAVxV8
 51IrCywKmNZCLhvhRaYPoz0etg1cAPLdePyj8O/pQmawsz3ZxdPGIsbVfMXKdPE4Psb0Sn6PlXjJ1
 Tm8WtTBTJXbLntdR737wUIdrIBuUUkAY4auMxYBR9FtRM7nJ1RrJidhuixvh6cgPatzYsaUvlNDIO
 ql7vKHEg1TdiV63pXUQOD7o8miSR5zH1BxcHdNihEqqaVFeiUm61Wl5tvw/Yi4ulw0N8S+XN1lmOP
 VhilVHnw==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x9RJ8-006GlL-CP; Wed, 23 Sep 2026 20:03:02 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/2] drm/v3d: Skip perfmon serialization when it cannot
 be observed
Date: Wed, 23 Sep 2026 15:02:38 -0300
Message-ID: <179018655565.1013951.14990932537787239089.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922-v3d-quick-exit-perfmon-serialize-v2-0-2a8021dc32f2@igalia.com>
References: <20260922-v3d-quick-exit-perfmon-serialize-v2-0-2a8021dc32f2@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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


On Tue, 22 Sep 2026 10:24:49 -0300, Maíra Canal wrote:
> The V3D core has a single set of performance counters. So that a perfmon
> only counts the jobs it is attached to, a job carrying a non-global
> perfmon waits for every job still in flight, and while it is in flight
> every later job waits for it. Knowing what is in flight requires every
> job to merge its finished fence into a per-queue accumulator.
> 
> That accumulator is maintained unconditionally, so a client pays a fence
> merge on every job even when no dependency can ever be built out of it.
> This series turns the bookkeeping off in the two cases where that holds:
> 
> [...]

Applied, thanks!

[1/2] drm/v3d: Skip perfmon serialization while the device has no perfmon
      commit: 537684e232fb590659a1448fca8a23d77d948ab1
[2/2] drm/v3d: Skip perfmon serialization while a global perfmon is set
      commit: 6e375de99d0c420169481fcd36064177ab55b09d

Best regards,
- Maíra
