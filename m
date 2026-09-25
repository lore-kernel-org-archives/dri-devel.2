Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87DFC98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 14:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E839510FAF6;
	Fri, 25 Sep 2026 14:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ioU/GpfN";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E54610FAF6
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=dI6bBwIKN837u15LRjHH6yORdLJ9Jv+nGmfAtWoSIj4=; b=ioU/GpfNjfa62OUxfeGvW6DW12
 c4fgOUVYMwNTcttmdh8BxOz34aUZnFpQamcymo4bK7n2RKsLImC6ULN5ILwRQx0L3mIndvivp6eUK
 eZ60NC9rAIFJvLQauigufGK0ZsToOCNIEDhhtUsZ3tgSvkikb704pWnwbq4UnwwdAwFNlOwrdHzVN
 5SBGRXms0heZcKcsEkLImF9/lUYsNpeaHMzFlWfntWOC2a95HTCW2IJn/HIf97+XG+35giNf6Frdx
 yxYr2apycUzRbGpYGAmTPKCzalAj0NuS7SYCMb8zemr12MFzI9mgXZyafK5z7++NIZo+16zcQzeFg
 Ldks3oJw==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xA6qh-007BCc-9l; Fri, 25 Sep 2026 16:24:27 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: mripard@kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 dave.stevenson@raspberrypi.com, kernel-list@raspberrypi.com,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, eric@anholt.net, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/vc4: drain the hangcheck timer and works on V3D
 unbind
Date: Fri, 25 Sep 2026 11:23:17 -0300
Message-ID: <179034619503.422955.6530940008343029668.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915095103.156007-1-fanwu01@zju.edu.cn>
References: <20260915095103.156007-1-fanwu01@zju.edu.cn>
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


On Tue, 15 Sep 2026 09:51:03 +0000, Fan Wu wrote:
> Nothing stops the hangcheck timer that submitted jobs arm, or the
> job_done_work that the render-done interrupt queues, at teardown:
> vc4_irq_disable() cancels only overflow_mem_work, and vc4_gem_destroy()
> runs from the drm-managed release, after vc4_v3d_unbind() has already
> uninstalled the V3D interrupt and cleared vc4->v3d. A timer still armed
> by then reads V3D registers through the NULL vc4->v3d pointer, and the
> late callbacks run on the vc4_dev embedding them after it has been
> freed.
> 
> [...]

Applied with a small adjustment to the first comment, thanks!

[1/1] drm/vc4: drain the hangcheck timer and works on V3D unbind
      commit: 94cf5971b1d04c6382437387c4dc3836cc7a1437

Best regards,
- Maíra
