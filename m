Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75A606A335
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JDdcix/t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FC9111226A;
	Thu,  5 Nov 2026 09:14:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E10111226A;
 Thu,  5 Nov 2026 09:14:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E7AF443D4F;
 Thu,  5 Nov 2026 09:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5347D1F0093A;
 Thu,  5 Nov 2026 09:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793870080;
 bh=lsCgcr53NQK1TI/PBS9u5riMRtU/RtsanXhSp8ZqY6Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JDdcix/tUqlpTchn2SciM2OXiiuZWqFqnxio1Kvts/Xt1XtoRygf/KK+FaYQt4x4x
 5j41usriXI4wSCoXmTzrz1WurjTVQaI0ruqMCzHs9or5Gv/fgZDrFnd7IdNSsRiS46
 479v0DYYD2CClCwCJMEpDGrdwKS8jXUPPzN0HR/ULKKPv8BWi4y9vvnIH91lnItPm9
 IK/hHJP61vRPW+aHEBGVUAwijJFZqWqT1j4eIAtqJiJMyu0V4yb5WZK5WtQNtPjupr
 ahDNKnJqQ7IcbYxclDNcxDVjR/MOHoguvL/cw/1dq82Vh4M1SZXX4aGuS09dW85kzV
 qCPtx86/xBglA==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>, Maxime Ripard <mripard@kernel.org>
Cc: Daniel Stone <daniels@collabora.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Jocelyn Falempe <jfalempe@redhat.com>,
 =?UTF-8?q?Jonas=20=C3=85dahl?= <jadahl@redhat.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Sebastian Wick <sebastian.wick@redhat.com>,
 Simon Ser <contact@emersion.fr>,
 Victoria Brekenfeld <victoria@system76.com>,
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Javier Martinez Canillas <javierm@redhat.com>,
 Daniel Stone <daniel@fooishbar.org>
Subject: Re: (subset) [PATCH v7 00/16] drm: Add DRM_MODE_ATOMIC_RESET flag
Date: Thu,  5 Nov 2026 10:14:29 +0100
Message-ID: <179387004599.656088.394688521591326726.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
References: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 11:27:32 +0100, Maxime Ripard wrote:
> Userspace currently has no atomic way to bring a display pipeline back
> to a pristine state. A compositor that wants to start from a known
> baseline must explicitly set every property on every KMS object to its
> default value, which requires tracking which properties exist and what
> their defaults are. This is fragile and must be updated every time a
> new property is added to the kernel.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next)

[02/16] drm/solomon: ssd130x: Drop the init-only assumption in ssd130x_crtc_create_state()
        commit: c257ee259841e264d13c049acea68e5bfa79b592
[03/16] drm/atomic: Switch to krealloc_array() in drm_atomic_get_private_obj_state()
        commit: 923cb729e1a5863fb64045fff1ebc25d2a0dae63
[04/16] drm/atomic: Use __GFP_ZERO instead of explicit memset in drm_atomic_get_private_obj_state()
        commit: 1dc6799ff39ed7a10089a5ca01dd7b6ffdcea24a
[05/16] drm/atomic: Use __GFP_ZERO instead of explicit memset in drm_atomic_get_connector_state()
        commit: b317ba7316be19063b867d8f23901f4698ea05f5
[06/16] drm/atomic: Create function to insert CRTC state into a commit
        commit: 99f828c16262084c2667fe8bfa3451e977be75f0
[07/16] drm/atomic: Create function to insert plane state into a commit
        commit: 40a13a109c961fc046b115b35ef1639ae81623d2
[08/16] drm/atomic: Create function to insert colorop state into a commit
        commit: b31e771eb1bdff618b3bf54e38bed0679c07f6b9
[09/16] drm/atomic: Create function to insert private obj state into a commit
        commit: 2eb56a0eee85c22fbab5e92fe66d14cfd4effbf6
[10/16] drm/atomic: Create function to insert connector state into a commit
        commit: 471e13ae24e4856ca5d762f3cc65580990a683e4
[15/16] drm/vkms: Switch container_of helpers to container_of_const
        commit: 1fd0897e3774e33a8ef7154c4048af12dee1ded2

Thanks!
Maxime
