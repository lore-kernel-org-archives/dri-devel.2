Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC23C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACCC710E8F8;
	Tue, 15 Sep 2026 14:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="feruXYBd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91FD310E8A9;
 Tue, 15 Sep 2026 14:14:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A706433CB;
 Tue, 15 Sep 2026 14:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92C91F000FF;
 Tue, 15 Sep 2026 14:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789481672;
 bh=zOqWn4PFXdHr3eeEItxz1gJOOuj70N/eMDhg8A5bxso=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=feruXYBdvIEyWgt6KDZOC+uHP6ar4vgH1B4yzQXfAIPt6Sqq8h6PuwmkXwFI+0E6H
 +RvEZdktygANMBtyad+g3Z7tl3T8mzn9Ncm07r1gBij+fbtm5kcn9EwYliRatOk16G
 Wd66eV/YxGHzzCLoOazpr//A4gzcyipyl2QIzWq3++5eQ2DkZgIgUI0uDi5r0BITuu
 dmoas7t4FGC9Bf+Uv7rUhEYgr1LH7B4OKgdQ/VoiqkKpDfLg4WgSTYFYO1pzh22UNR
 Lm3Qe9KizhBu/G401SsjcmD0Jy8sXRJKpYfUZfDwkwSjJFhEMVCrCs4cUnMRBE7NVc
 A/oumI7tegseA==
From: Maxime Ripard <mripard@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu_dm: tests: Fix wrong variable declaration
 after merge conflict
Date: Tue, 15 Sep 2026 16:14:01 +0200
Message-ID: <178948162528.1987579.18064915328472899223.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915101251.1711103-1-mripard@kernel.org>
References: <20260915101251.1711103-1-mripard@kernel.org>
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

On Tue, 15 Sep 2026 12:12:51 +0200, Maxime Ripard wrote:
> Commit 2bcec01cf105 ("drm/amdgpu_dm: Convert to atomic_create_state")
> converted dm_test_plane_create_state_initializes_state() to call
> amdgpu_dm_plane_drm_plane_create_state(), which returns a struct
> drm_plane_state pointer stored in a new plane_state variable.
> 
> However, the merge conflict resolution kept the old declaration
> (struct dm_plane_state *old_state) instead of replacing it with
> struct drm_plane_state *plane_state, leaving an unused variable with
> the wrong type.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next)

[1/1] drm/amdgpu_dm: tests: Fix wrong variable declaration after merge conflict
      commit: 87882cd6debd94a14c65894e9220be8a01b5d4fa

Thanks!
Maxime
