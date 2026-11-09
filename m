Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1C5606A326
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=sDpNnGeu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6266D10F355;
	Mon,  9 Nov 2026 14:13:39 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F7110F355
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=uDmYN+k1+pC9+pfahjAfTCHA3/30xS5R6Y4/GmBD8AU=; t=1794233613; x=2109593613; 
 b=sDpNnGeuPvlDWwXBEJTmcgavGEAH2YwoX7HGJFHkKKFoWqoPLG1vUT/msYTVZxm/5xcCItcJcmR
 1HgDncpN1yj/Ms9PH0D1U8RIUpYwUdSYQf61Bno9ikHW4GfoJ9yC+kv4pWADdPv5js7X0zp8QFHYU
 fKKtAnrGKnkbmrPozDPBYp1TWoBtn7McTH/8RNgPpEKGJmGCN2JwqSTHZkpy6My7xQL9sQGFDAivt
 HKPWWb/B60xaFTbAdqObgWdOnJxwp7x7yN+4+mkCxsSvcZFYG52ftsfBfWFmJy3aXxwuxEJGn/l72
 w7hA6OvGQw5p3pZ29dJV7p1nPObrNkfiD4Ug==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xQQ7i-007LZM-Ip; Mon, 09 Nov 2026 15:13:26 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 00/11] drm/vc4: Split and shrink job_lock
Date: Mon,  9 Nov 2026 11:13:08 -0300
Message-ID: <179423355865.3034179.8380357915741092100.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
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


On Sun, 04 Oct 2026 12:42:00 -0300, Maíra Canal wrote:
> vc4->job_lock is a device-wide spinlock taken by the V3D interrupt handler,
> so everything under it runs with interrupts disabled. It currently
> protects several unrelated things: job queues, the binner slot pool, the
> saved hang state, the active perfmon, the attachment of the job fence to
> every BO, and more.
> 
> This series aims to (1) split vc4->job_lock into multiple independent locks
> and (2) shrinks its critical sections when possible.
> 
> [...]

Applied, thanks!

[03/11] drm/vc4: Refcount vc4_exec_info
        commit: 66190d52ce5100320b29b2237e83b7b8d7cc56ee
[04/11] drm/vc4: Return the seqno of the submitted job
        commit: d5e814a3fa2579bb69058f1e88f521f89d5beca1
[05/11] drm/vc4: Attach the job fences outside of job_lock
        commit: 0abc50c2c69ff6cf7dc0f28d0b43c1eb0e63bef6
[06/11] drm/vc4: Use the inline fence lock
        commit: 3e7768d8a8ad9d916cf19b1379602c9d20a9ac40
[07/11] drm/vc4: Signal the render fence outside of job_lock
        commit: 4f0f809738e8d801d283518340da8d128e775c8c
[08/11] drm/vc4: Take job_lock only once to drain job_done_list
        commit: d88f725d8bac6a66c96a12f98afe406252294ff7
[09/11] drm/vc4: Protect perfmon state with a dedicated lock
        commit: 2898d618761173cb27787dbe51e6baca2fef268e
[10/11] drm/vc4: Protect the hang state with a dedicated lock
        commit: fed35e1ce274e0c81122f6869d8ff45f41efb586
[11/11] drm/vc4: Split out bin_alloc_lock
        commit: 851a478fa1ef6e63f5260d8fa6b228d9ca893952

Best regards,
- Maíra
