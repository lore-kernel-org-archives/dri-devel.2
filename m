Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0351A606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Rwmq8FAf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B6810E6B8;
	Tue, 17 Nov 2026 21:22:06 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 534E010E6B8
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 21:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=AS+LdjAZ9uLUysJ7yrvtODB4cFmFqghPvSXSI4kogDk=; t=1794950520; x=2110310520; 
 b=Rwmq8FAfNuiBfGxTnX9S36yLtCz8wVg9Neu76rWKnlIr6fVtgfVZH8U/xM2sjw3hX7y3+BEisw+
 D8N+9M2RGFH22cvNgVXj70jJ5S4pxjjhpzuOHAvesqb+y4iY03luNrB7aOmyojLWZq24+8fDnYuf9
 gCYbblXLHq3BBX6JBPHH31RnLfooBycI3nfMxbBxd0yovLrKKEpqL13k1kRtd/m9UrhoBZfCzsPOy
 z+IHg+/rkbofhdjY8XI0vxuxiixwadIzP5nuTFvVxx3a9qI4ENq0XqQ4GeZNj3WUgaGNrii34woJM
 3PcxbgKZKbZ0zcm6j2l5wWj87VoAbZi76qaw==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xTQck-00000000kvm-278V; Tue, 17 Nov 2026 22:21:55 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Iago Toral <itoral@igalia.com>, Melissa Wen <mwen@igalia.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drm/vc4: Fix async page flip completion
Date: Tue, 17 Nov 2026 18:21:17 -0300
Message-ID: <179495047310.1852768.467440424263871082.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114-vc4-async-flip-fixes-v2-0-d33cbe99ed5d@igalia.com>
References: <20261114-vc4-async-flip-fixes-v2-0-d33cbe99ed5d@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sat, 14 Nov 2026 16:16:49 -0300, Maíra Canal wrote:
> VC4 implements async page flips with a custom code path that waits for
> the BO fence before completing the flip. On VC4_GEN_4 (RPi 0-3), the
> completion also decrements the usecnt of the old FB's BO. This series
> fixes three bugs in that path.
> 
> Since commit e8941ac97f28 ("drm/vc4: Remove BOs seqnos"), the completion
> runs from a dma_fence callback. VC4 signals that fence from the render
> job IRQ handler. As vc4_bo_dec_usecnt() takes a mutex, running an SDL
> application with SDL_VIDEODRIVER=kmsdrm on the RPi 3 triggers:
> 
> [...]

Applied to drm-misc-fixes, thanks!

[1/3] drm/vc4: Drop BO usecnt before releasing the old FB
      commit: 43b85636ea0d33152bf16816b7601e785723596d
[2/3] drm/vc4: Complete async page flips from an ordered workqueue
      commit: 12a321af56c436e299414d8c276457dcf387e0cf
[3/3] drm/vc4: Look up the async page flip fence before committing the flip
      commit: f9fc6da01a290609428d308033143f1d96ab658f

Best regards,
- Maíra
