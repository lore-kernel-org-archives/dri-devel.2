Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F691C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAA0510EEF8;
	Mon, 14 Sep 2026 14:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="aJQvwysT";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F25310EEF7
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 14:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=xJ0o8sR+OjcGomGzdO8nhX3+HLQ1KDBd4fDV/e/c5yc=; b=aJQvwysTSbDYaepohkvl7tBZh1
 g/YP+pkCmy2c/PAblQmrdvFBqUs+xszz9gedRNZyRY8NAeUtHSbgcD4eBnATF371p9aQimPmpmIYe
 l00ed02BFHT7zYtlwtt2ebb50Oi5VeTD++TPlTwnQXB97Q+tB/PCE8R69j8TZyoTAcI/RiKpCYxyy
 ZJw51o5nGstvQKpwocVBeaPCQY6QuG1pgtvCkw5NLyk8Vj2LQ53aYqgmmooPNhPr39j2PezPpACt6
 T63hH/L2gESOmulHNYMs1rzd9bnT4zLiHfcy9WLr0v0U3n+jKFUpxLrvwqlH4lzCuU8iPe5il3sP3
 +1wNJq0Q==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x6875-001x6K-2X; Mon, 14 Sep 2026 16:56:55 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	kernel-dev@igalia.com
Subject: Re: [PATCH] drm/sysfs: Remove drm_class_device_(un)register()
Date: Mon, 14 Sep 2026 11:56:31 -0300
Message-ID: <178939778742.87852.10344097395380818843.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803132706.1497980-2-mcanal@igalia.com>
References: <20260803132706.1497980-2-mcanal@igalia.com>
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


On Mon, 03 Aug 2026 10:26:52 -0300, Maíra Canal wrote:
> The last usage of the functions drm_class_device_register() and
> drm_class_device_unregister() was removed in commit ed89fff97382
> ("drm/ttm: drop sysfs directory").
> 
> Remove such functions as they are no longer used.
> 
> 
> [...]

Applied, thanks!

[1/1] drm/sysfs: Remove drm_class_device_(un)register()
      commit: eff5a355919641c29ffae99a15cbe59b74551e8f

Best regards,
- Maíra
