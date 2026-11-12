Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EB7606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=pU0tP/RA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BE0A112108;
	Thu, 12 Nov 2026 12:57:20 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D99A8112108
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 12:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=3NQ59OMNKcd9t+j12Tee+t591FmbFKofgobaYbJuglY=; t=1794488233; x=2109848233; 
 b=pU0tP/RAoqLd2ZbKjGzn6bS9uiOXA5aEmF+s0+pK8ZHHMHHQjKFFKy1BVhSiFe4escDdhRctCMj
 2aEYk9yPsfxwUTKUotUM9CwOl7wyE61LhokvI2gfM7bldOH4KI2fp3Xhsgfy8VWTffNCQfeuVfEpK
 uFtq+DVxvejzR6TPDHWL6JCZs1STDcbtVYpB62X2Wmqj8cjmUHG80Mf5eSqJaA+FfXgw1zAyLnQXw
 3+RsBwomus+L4TIukwsKDabw6kJ9qvoTkfvNloIKwfx0FhhywdxIiBuUC2Nc3NGATFmqUYCNAWjBC
 jegBKVp7CaO+axlWH0ikLOknBY9b4pBkw7vg==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xRUMS-009Xxy-FO; Thu, 12 Nov 2026 13:57:04 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/2] drm/vc4: Fix async page flip completion
Date: Thu, 12 Nov 2026 09:56:54 -0300
Message-Id: <20261112-vc4-async-flip-fixes-v1-0-42449a703840@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2LSQqAMAwAvyI5GzDign5FPLQ1akCqNCCK+HeDc
 xuGeUA5CSv02QOJT1HZownlGYTVxYVRJnMoi7IhA89QodM7Bpw3OXCWixXJk/PUTqHtarD1SPw
 HO4fxfT+Ho0FeZgAAAA==
X-Change-ID: 20261111-vc4-async-flip-fixes-1b1ab17dc795
To: Iago Toral <itoral@igalia.com>, Melissa Wen <mwen@igalia.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2520; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=clP/E8svD4QHx2DDpj4aVerbORgSn1ktcdo4AoG6um0=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq9beZcJn+SwfZR7BIPW10lVdnDDBmgGfrymuBe
 NzFoKmzIV6JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCavW3mQAKCRA/8w6Kdoj6
 qiMhCACCodUudZ+/m3kJb0PpvFa3ZKUnzS1EzSHpcmeMpMguLLBN3jie4HlzrmvNNplqKk/fMJR
 LoxDumJz0GjPh1ToGZaAbBo9iclXdnAEc8jIB5bY6kjVzuqn4lNbeeT4NwH8sY3erVTD/ZlAIf8
 yenU1uszFdx26sgrhyrW9Cg1np/7rnupr7Usf/EFLbQtJkkZSboJHY1/NvVvyHjKkiUBvsRV+GM
 R/KwHX/9oZzTjUXr0ovWJlJuIFJ703y8Hkgzbvx1sYmuUSUPpdHIljDZrvmXPMa1q7MHF3qBY/R
 fqihmyw6qXen6jWHJjyzaxnvW5z856UdlsLXmYBmLNdI8sra
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VC4 implements async page flips with a custom code path that waits for
the BO fence before completing the flip. On VC4_GEN_4 (RPi 0-3), the
completion also decrements the usecnt of the old FB's BO. This series
fixes two bugs in that path.

Since commit e8941ac97f28 ("drm/vc4: Remove BOs seqnos"), the completion
runs from a dma_fence callback. VC4 signals that fence from the render
job IRQ handler. As vc4_bo_dec_usecnt() takes a mutex, running an SDL
application with SDL_VIDEODRIVER=kmsdrm on the RPi 3 triggers:

  [ 2511.636319] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:623
  [ 2511.636667] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/0
  [ 2511.636681] preempt_count: 1000002, expected: 0
  [ 2511.636689] RCU nest depth: 0, expected: 0
  [ 2511.636698] locks held by swapper/0/0: 1, on CPU#0:
  [ 2511.636711]  #0: ffff000037183198 (&fence->inline_lock){-...}-{3:3}, at: dma_fence_signal+0x88/0xec
  <snip>
  [ 2511.636892] Hardware name: Raspberry Pi 3 Model B Plus Rev 1.3 (DT)
  [ 2511.636899] Call trace:
  <snip>
  [ 2511.636991]  mutex_lock_nested+0x24/0x30
  [ 2511.637002]  vc4_bo_dec_usecnt+0x40/0x124 [vc4]
  [ 2511.637070]  vc4_async_page_flip_complete_with_cleanup+0xa0/0xc4 [vc4]
  [ 2511.637102]  dma_fence_signal_timestamp_locked+0x118/0x290
  [ 2511.637116]  dma_fence_signal+0x9c/0xec
  [ 2511.637126]  vc4_irq_render_job_done+0x24/0x114 [vc4]
  [ 2511.637158]  vc4_irq+0x16c/0x274 [vc4]

While looking into this issue, I also noticed that, since commit
4d12c36fb73b ("drm/vc4: crtc: Move the BO handling out of common page-flip
callback"), the old FB is released before decrementing its BO usecnt. If
userspace removes the old FB and closes its handle while the flip is
pending, vc4_bo_dec_usecnt() runs on a freed or recycled BO.

Patch 1 fixes the use-after-free and patch 2 moves the completion to a
worker. The UAF fix comes first, as it affects older stable kernels that
don't have the dma_fence-based completion.

Best regards,
- Maíra

---
Maíra Canal (2):
      drm/vc4: Drop BO usecnt before releasing the old FB
      drm/vc4: Complete async page flips from an ordered workqueue

 drivers/gpu/drm/vc4/vc4_crtc.c | 108 ++++++++++++++++++++---------------------
 drivers/gpu/drm/vc4/vc4_drv.h  |   6 +++
 2 files changed, 58 insertions(+), 56 deletions(-)
---
base-commit: 8bf8cda54c08ee3693f4dd1e2b7607fe5e466c79
change-id: 20261111-vc4-async-flip-fixes-1b1ab17dc795

