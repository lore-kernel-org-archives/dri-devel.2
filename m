Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F4BC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EBA810E27E;
	Thu, 10 Sep 2026 13:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UDaA4zYd";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C9D10E27E
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 13:36:25 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd82be878so4292005e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 06:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789047384; x=1789652184; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SdfNZLHoTwaSRGbzkk1xRxTbtBIxs9oY1WLjA5lMVdw=;
 b=UDaA4zYdhGKPc5rr+Izz2iqGkhwVIAuLuSbtHqO6U52i1S4flRBnPqnNi3+sMZnV+v
 8JZzHJM2GKfWhaBsBWeOFUap/tNqFgb7uEokbbt+J/jLu3xyqyMeeJUgECWUW4ybiaxw
 w5SU7YJPSDtdT5zVHNH9LUQiS0hDj8+TowLss4UgRB9NT5Ju7khblwEkerTXoSLoHZJV
 YVLxB9U+E+D85n+QHNA6VPEf2UmK9wiSJYb+6pIj792sJRlssUShmn+9t6YHHHqKyCFQ
 ZInA69CoqwJ+EhHptjHbYMzyjKDwzHBpFOaX4DBzP2YYUnWCUlHCF0gVsBHUZMQXzSNN
 IRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789047384; x=1789652184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SdfNZLHoTwaSRGbzkk1xRxTbtBIxs9oY1WLjA5lMVdw=;
 b=Ugx6BCpZnx4lTGk1gxqG+kmlSLpe3sv4tepoESwHLDUkE+cw+ifbuzGWAs07xiPYjA
 pcCCGQ1saOo9eS5t4cr3wzRvRxDHe4oPvGAli2yaWjWW7l/JsnfTmhy7sCelRRXDScQ7
 k9rvmEdMwlNRe7O5Hh+yxAJ6DMR8oQCLKIioHQ25R6nUgIuCXTh0YYR1mUnKFx7B7VE6
 UQgtllqFx01sLChFfP4Mvppd5Y10nP89bWEXdopzrm6iYCWwo2/UvakWDVwkYlMOzdXZ
 T6URXM0KuzfWVjHhGtJITLn5Qgpyf27Q/J6zcxeah7ybdSPUrr0ilp9Cwwp/NUbIy4Kx
 96yA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUmR8cKeIbklLErxffCsawofbYTs/zpejkCx4uqIdV9kKa0A6ozNWYs2c1ip/p8Ez8uMZl9dQqZsY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nsgYLPc2wnTCSyMYOHPy1F+K/nIhUZVNvJFaEeJjtmL4FhliSL
 B2Ti/TumO9vXRPicToPrlZoP+4PBOfRjHXKOw6OB/HYouivlJk9rpzIf
X-Gm-Gg: AYBFou3BFOfATQQzG2GX52ZweI1r6McGQYLf/rJeskmUtRYdTAlzY+q/CyiJBd4ap/D
 v6p1yGP21axJiGxuAjYMMV4xNCgRznszXzYruI5nH0TbMeyBBcBP008yL9FY0DU2ESFbU3E6kLf
 YCh9hIrfdZHLM1xLgB00cMcBFCY8OQGoI+L26oO/j4+T7yt/d/mKl2l8HeFmYPIYmuKFVa94Wde
 IPb1wKt11GgJFysm9e0R0i2y1zIBRn0Ef4Q6j36qnjVQLsL06fGva5hAcQUdqz0jE/tvs9cpmSW
 6BO+kVktd1TWmPxpHi8kpr3XxVCAeJbayM9TfHBuq/7APwbnORGUpjn/ck3cERMGc8DMDnwUCXk
 k1ro4awZE+xznnHI4bQQfNwa7X4K/4xW6L6/sX1TzARFzFsTQC37yOhDwMky6nL6BB3ZjLyKYyV
 W0NsKfPlwpv2OaJ0MwIdmja00d8JK5H23MoC3nTT4fUcPAR7dOB0tMwXEoaJEOx0FuOUXqC4OVb
 gFjIMB9v7vo+EtUWyPtF/YyC/bX3JGc40gScF41Lf3DUw0ugOyIdyulv0zpn9uewtBaMMXzOVjS
 gUUQEKv/EcuWvvA=
X-Received: by 2002:a05:600c:530d:b0:49c:e363:c66e with SMTP id
 5b1f17b1804b1-49d01dce86fmr310949945e9.1.1789047383351; 
 Thu, 10 Sep 2026 06:36:23 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B914600506D8644FC6130D5.dsl.pool.telekom.hu.
 [2001:4c4e:1b91:4600:506d:8644:fc61:30d5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26be3e0asm77721735e9.1.2026.09.10.06.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 06:36:22 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Igor Paunovic <royalnet026@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, Owen <support@armdesigner.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/rockchip: vop2: Scale the AXI clock to the
 bandwidth the mode needs
Date: Thu, 10 Sep 2026 15:36:02 +0200
Message-ID: <20260910133603.8993-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910132156.07D6B1F000FF@smtp.kernel.org>
References: <20260910132156.07D6B1F000FF@smtp.kernel.org>
MIME-Version: 1.0
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

On 9/10/26 15:21, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Does calling drm_crtc_commit_wait() here cause a kernel warning or potential
> deadlock?
>
> According to the DRM Subsystem Details, drm_atomic_helper_commit_tail()
> and its variants execute in atomic context where sleeping is forbidden.

Both findings rest on that premise, and it does not hold.  The commit
tail runs in process context: drm_atomic_helper_commit() calls
commit_tail() on the caller's stack for a blocking commit and queues it
on a workqueue for a nonblocking one.  commit_tail() then calls
drm_atomic_helper_wait_for_fences() and
drm_atomic_helper_wait_for_dependencies() - three loops of
drm_crtc_commit_wait(), the very function flagged here - immediately
before the ->atomic_commit_tail hook.  The default hooks block in
drm_atomic_helper_wait_for_vblanks(), and the CRTC atomic_enable and
atomic_disable helpers run inside them.

The wait itself is what the core asks for.  From the drm_private_obj
documentation in drm_atomic.h: "Drivers should store (and get a
reference to) the &drm_crtc_commit structure in our private state in
&drm_mode_config_helper_funcs.atomic_commit_setup, and then wait for
that commit to complete as the first step of
&drm_mode_config_helper_funcs.atomic_commit_tail, similar to
drm_atomic_helper_wait_for_dependencies()."  vc4_atomic_commit_tail()
does exactly that, followed by clk_set_min_rate(), which takes the same
clk prepare_lock as clk_set_rate().  The wait is on the previous
commits' drm_crtc_commit, never on the current one, so it cannot wait
on itself.

The pre-existing note answers itself: vop2_crtc_atomic_disable() is
called from that same commit tail, and the @atomic_commit_tail
documentation says "When disabling a CRTC this hook _must_ stall for
the commit to complete."  It also calls clk_set_parent() and
clk_disable_unprepare() there, unchanged.

I suspect the two senses of "atomic" got conflated: an atomic commit is
an all-or-nothing modeset update, not in_atomic() context.  There is no
might_sleep() or context restriction on this path.

Thanks,
Igor
