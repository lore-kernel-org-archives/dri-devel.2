Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F784C88E6E
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB61E10E1BD;
	Mon, 14 Sep 2026 15:40:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="n9j0lotr";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7114210E1BD
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 15:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=8hXe3SkzqcPJWQukn5jm9yUWHrV+E+E9FU39iO7bl3k=; b=n9j0lotriRCVxgHWmd9GTGm1ml
 3cti/gYdajFYf9ZH3s+tv2v5OlpNUgep8ZFC5+DMdUA8slq/WJzlDVeFXVze/vX/vM/Mm/63OVRzT
 M2pXLV6CqApOgmCQrh3WsDMx287jU0N1qoWTwHcr9x6a04qs7bymSU6CRVqEdPHh9xQOWTXYLCkbe
 SmCwxmNlcmf2R1J8FLfWdpzcEk1jf205VTx+mvGiQUI6B8z/Orfek8AOIGdaGteEQcCT7anZ/yWJ2
 RAkAiuNuf2UQVxV6Zb+HXHlkX37RTMgkjiHS+AyO014ojylTjN6FQZvFH85WJYbGEuBppHyLXIfis
 Fyn7mFxw==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x68mW-001yGz-4G; Mon, 14 Sep 2026 17:39:44 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Karl Mehltretter <kmehltretter@gmail.com>
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Eric Anholt <eric@anholt.net>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vc4: Use managed KMS polling to fix UAF on unbind
Date: Mon, 14 Sep 2026 12:39:14 -0300
Message-ID: <178940035097.202301.12245360803631380253.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822143110.68594-1-kmehltretter@gmail.com>
References: <20260822143110.68594-1-kmehltretter@gmail.com>
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


On Sat, 22 Aug 2026 16:31:10 +0200, Karl Mehltretter wrote:
> vc4_kms_load() calls drm_kms_helper_poll_init() but the driver provides
> no matching drm_kms_helper_poll_fini(). The output poll work stays
> scheduled after unbind and runs on the freed drm_device:
> 
>   # modprobe vc4; rmmod vc4; sleep 10
>   BUG: KASAN: slab-use-after-free in delayed_work_timer_fn
>   BUG: KASAN: slab-use-after-free in drm_client_dev_hotplug [drm]
>   Workqueue: events output_poll_execute [drm_kms_helper]
>   Allocated by task 171: __devm_drm_dev_alloc
>   Freed by task 262 (rmmod): drm_dev_put / component_del
> 
> [...]

Applied, thanks!

[1/1] drm/vc4: Use managed KMS polling to fix UAF on unbind
      commit: 073a30d75f309812ed61af134f24ffef4107b13a

Best regards,
- Maíra
