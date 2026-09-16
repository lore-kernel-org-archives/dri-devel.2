Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F094C982C4
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:23:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B5810E05C;
	Wed, 16 Sep 2026 15:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EKIJpwdB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AABB110E05C
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 15:23:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EB3A9602CB;
 Wed, 16 Sep 2026 15:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139FB1F000FF;
 Wed, 16 Sep 2026 15:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789572200;
 bh=8XrCLw0N5Bj3c9gGn7s8ZZDqA5ZxMunPjxBKuNACMAA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EKIJpwdBuYKsxoBu78MMneqFf3aw8kJWCyxcbQ0yg2dE+1gcoPJtPjD63QYO/CqHC
 9o6dc63baqKhlhH5aL9+4DZQl6qom0HJ3no903iTGKdA8mt4KZuee4oi54QqcDNPC8
 Nv+POdd+Xk5lZVlYdwxizqml1fkpMBlrmEc6CAbgMpkH3oQNEnCmpkiAJCrBODJoD6
 7WtlCNjVOYYmNo947kuRv952neMNcLzqA6A7lcf87QsXEH0+0yaiZu9Y7/VtdkZncC
 xKxvmS6sAEGzWApuWSUdyABJGFgWgInfjp/l9sva9C7IEpA19lfi8Rva1w/dzw6R8f
 UxKk1VfNmQ/DQ==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 0/9] drm/plane: Convert all drivers to
 atomic_create_state and remove reset
Date: Wed, 16 Sep 2026 17:23:14 +0200
Message-ID: <178957219055.2965664.16396763960121735725.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
References: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
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

On Wed, 16 Sep 2026 10:55:43 +0200, Maxime Ripard wrote:
> This is a follow-up to the bridge reset removal series, and part of a
> larger effort to remove the reset hook from all KMS objects.
> 
> The plane reset hook is overloaded: it is called both at probe time
> to create the initial software state and during suspend/resume to
> reset hardware and software state. These two roles have different
> requirements, and the reset hook is not fallible, making error
> handling difficult for the initial state allocation path.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next)

[1/9] drm/arcgpu: Switch to drm_atomic_helper_plane_create_state
      commit: a88a31a625af4c990860a60a5b84797a9dd4a446
[2/9] drm/aspeed: Switch to drm_atomic_helper_plane_create_state
      commit: fbc8f33eebfae0f79526fa759690aff9bf98fa4e
[3/9] drm/mcde: Switch to drm_atomic_helper_plane_create_state
      commit: d24a400a17df2105bce34f0cd6b22e0341297368
[4/9] drm/pl111: Switch to drm_atomic_helper_plane_create_state
      commit: 896c2267d1555b8343da61e9667360cfd9e4be2f
[5/9] drm/tve200: Switch to drm_atomic_helper_plane_create_state
      commit: 18b4aaafdc18e5de08c58623066a69c86528ba46
[6/9] drm/xen: Switch to drm_atomic_helper_plane_create_state
      commit: 79d498da3eee2ea6945840e8e051fb7564a17cc5
[7/9] drm/atomic-state-helper: Remove drm_atomic_helper_plane_reset()
      commit: e62864df82f6a47c969485636b2894472f321acd
[8/9] drm/atomic-state-helper: Remove __drm_atomic_helper_plane_reset()
      commit: 18216d5fa8dc29c76c4d3944282d990ebc41514c
[9/9] drm/plane: Remove reset
      commit: 5589ef09f93b85b6f506e279a502d4cf1654f232

Thanks!
Maxime
