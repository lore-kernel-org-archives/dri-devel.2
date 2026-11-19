Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CEF60A2601
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=VAYwE76a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B063F112416;
	Thu, 19 Nov 2026 13:54:50 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9673112422
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=bs3e533bt5D0o+EpSdAjhPVi/JGC5ZQYFdjvbtCNaXk=; t=1795096484; x=2110456484; 
 b=VAYwE76agjPIpv4JxRS9lS5lfCTFCLKzbtfPldi/BCIozChhS4tGmp/LP54UnOUL2BSIwTlNOU7
 fUPj0PS92xX0HRf/sRnxKEpo6pv/A3QkZL2h1qEeRw4ckAKyB6BxZqZiFJ4DhiZ/PBxOtUYuiR7Ss
 6HPIIxYqVkmYwX+0MYFdrIqE5wx9+3Wn/R833FVchYOezTEshRG0go7/bjiLJcwmtcL3XcgQ8NlWm
 F1CHzmiygsBUrjwpGw8yjJ/9znAhIlF2ffwKQK6z6dEd0OkbRq8+xZ/lhfLgkS5Uzi/cgWYgP89in
 SU73aYhO8SlVbvLsCenAKM9Vfe2pHNL1tmOw==;
Received: from [179.105.94.163] (helo=prince)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xU2b3-00000001TSi-3SwJ; Thu, 19 Nov 2026 14:54:42 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Iago Toral <itoral@igalia.com>,
 "Juan A. Suarez Romero" <jasuarez@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 0/4] drm/vc4: Work around GFXH-16 instruction cache
 livelock
Date: Thu, 19 Nov 2026 10:54:10 -0300
Message-ID: <179509644527.2610316.12481910514496776613.b4-ty@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
References: <20261118-vc4-icache-workaround-v1-0-5b8adc2c84fe@igalia.com>
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


On Wed, 18 Nov 2026 18:47:27 -0300, Maíra Canal wrote:
> Mesa issue #16652 [1] reports GPU resets every few minutes on the
> Raspberry Pi 3. They happen when text labels are drawn over their shadows:
> two different threaded fragment shaders, plus untextured single-threaded
> ones, in the same tiles.
> 
> During a hang, the performance counters show four QPUs fetching
> instructions with 0 cache hits, ~6.5M misses per 100 ms, and 0 valid
> instructions executed. This matches HW erratum GFXH-16: the QPUs of a
> slice share one instruction cache and can livelock, evicting each other's
> fills. Since shader code always starts at offset 0 of a page-aligned BO,
> every shader competes for the same cache sets.
> 
> [...]

Applied, thanks!

[1/4] drm/vc4: Fix off-by-one in the shader record BO handle check
      commit: 1fbbd14add401c70c178f0fa13016a3a53ef0de5
[2/4] drm/vc4: Check for a validated shader before reading its thread mode
      commit: 15da41dff1f66a389d238db60a1c19fa83582d07
[3/4] drm/vc4: Start shader code at varying offsets in its BO
      commit: c0e1ed41ad86cf5230d64dc5f2c6d2e3aeb59937
[4/4] drm/vc4: Clear the slice caches before resetting a stalled GPU
      commit: af1cf92e8617a7f7aa24b415596cbf64b76a12e7

Best regards,
- Maíra
