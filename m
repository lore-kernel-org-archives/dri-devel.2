Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD316C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 23:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39B5D10F249;
	Thu, 23 Jul 2026 23:13:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rm7v2Vbq";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59EFC10F249
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 23:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=GuabusJUCwReDf/oB0m+9ls13Guj7z4MS8hlsidlBTE=; b=rm7v2VbqDi29hZ65tECuqvfIgG
 5H+oVLU2WhfLhDEGSgfrTd/5wg7Ane/CNvH500ZSCCwqTvAFyWYaOdT2PcvspEkbeWAyn4OLZaqvT
 7ccpunjlJGCcZsDy2YPo5LXTHcAvnlSemDfoyM3hetpfEvVxZ4OYNcAT/ayr9SSQchacFEMeOTD32
 IMi5KjY2cCG4TRe9y2am3D9b4yZS+sxfOgiyP7McNGhi2VGUMOUyQY6po7OsayDR+drnAG+RJYLMv
 TlQxvK4XmaA5w6tAxLtnTGRqfFoGHp5rjVo7hjchOt6Ab86KH9l0On1bYZSJt7sCmGselpNQNT8h/
 ITpJa6NQ==;
Received: from [187.36.208.132] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wn2bF-003dqX-03; Fri, 24 Jul 2026 01:13:09 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Linmao Li <lilinmao@kylinos.cn>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Eric Anholt <eric@anholt.net>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: Shut down BO cache timer before teardown
Date: Thu, 23 Jul 2026 20:12:41 -0300
Message-ID: <178484835832.1636116.12347863223467970899.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720084426.1632508-1-lilinmao@kylinos.cn>
References: <20260720084426.1632508-1-lilinmao@kylinos.cn>
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


On Mon, 20 Jul 2026 16:44:26 +0800, Linmao Li wrote:
> The BO cache timer callback schedules time_work, and time_work can rearm
> the timer through vc4_bo_cache_free_old().
> 
> vc4_bo_cache_destroy() deletes the timer and then cancels the work, which
> does not break that cycle: the work being cancelled can rearm the timer,
> and the timer then queues work again after teardown.
> 
> [...]

Applied, thanks!

[1/1] drm/vc4: Shut down BO cache timer before teardown
      commit: 6273dd3ffb54ec581855b82ae77331b66028249c

Best regards,
- Maíra
