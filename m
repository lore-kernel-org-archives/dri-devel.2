Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF42C606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=qen1ezhm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F104110E7E5;
	Mon, 23 Nov 2026 16:55:19 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id 0389C10E569
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:55:13 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1216)
 id EECE320B7167; Mon, 23 Nov 2026 08:55:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EECE320B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1795452909;
 bh=R0YaxkJAta/mVlVE1XP9/S1/mFJSUrN6mUoMtBEqewI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qen1ezhmMTbNcdPmeI9v32zYARX+1yjzwcy7MgPKuwwCzwLdQrJ3zy1q95LBgseB7
 tSXQlWXLmYWwYw5IZZd792vwUzgJ1JKgV5P/aA9QP4X65LGOKWY7PqlyUZUX2gzfhG
 I+xO8ElKYevVL4deVSkOqSOB+sx+l5YfxzxTZgG0=
Date: Mon, 23 Nov 2026 11:55:09 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: dri-devel@lists.freedesktop.org, Dexuan Cui <decui@microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/hyperv: wait for flip_done instead of vblanks in
 commit tail
Message-ID: <awRv7c1yVG3QWxp+@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261112184553.1595055-1-hamzamahfooz@linux.microsoft.com>
 <avyT6Zop6s5G5qwu@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avyT6Zop6s5G5qwu@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 09:50:33AM -0800, Saurabh Singh Sengar wrote:
> Thanks for the patch. Below are my thoughts:
> 
> Since flip_done is normally signalled through the same vblank timer,
> this change does not remove the dependency on that timer. However,
> drm_atomic_helper_wait_for_vblanks() has a 1-second timeout, whereas
> drm_atomic_helper_wait_for_flip_done() waits up to 10 seconds.
> Could you clarify whether the change resolves the reported case because
> of the longer timeout, or because it avoids waiting for another vblank
> after the commit's event has already completed ?
> 

It does come down to the longer timeout, I've done some stress testing
and the timeout doesn't seem to exceed 2-3 seconds (on Azure and
even on the lowest end SKUs).

> This seems relevant to other timer-backed virtual DRM drivers as well.
> The older wait_for_vblanks helper also predates flip_done tracking and
> has previously been described as an interim solution [1].
> 
> We already have a vblank timeout increase [2], and Thomas's timer
> reliability series [3] also discusses delayed vblank handling triggering
> DRM checks, although it is not clear whether those changes address this
> particular case.
> 

From my testing they don't address the issue.

> Using flip_done is consistent with VKMS and seems reasonable. However,
> rather than duplicating the default commit tail in each affected driver,
> could we consider a common DRM solution for all ?
> 

Most drivers implicitally rely on drm_atomic_helper_wait_for_vblanks()
through drm_atomic_helper_commit_tail(), so I don't think we should
touch that unless we can prove it doesn't regress anyone. Though it
is worth nothing that fbdev has a similiar timeout that is fixed by [1].

> It would help to identify the precise condition causing the hyperv_drm
> warning and explain why the existing generic timeout increase is
> insufficient. If this is needed as a targeted stable fix, please document
> this in the commit message and as a comment in code.
> 

The vblank timer is an hrtimer, so it can't fire while its vCPU isn't
running, whereas the committing task can keep running on another vCPU
and time out. On Azure, a 10 ms timer sampling the vCPU run time that
Hyper-V reports caught the host not running a vCPU for up to 128 ms,
mostly inside storvsc's vmbus_set_event() hypercall. As the warnings
coincide with boot-time disk I/O, the host appears to hold a vCPU like
that for seconds at times. Also, it doesn't really need to go into
stable if we don't enable panic_on_warn() (and assuming no one is
complaining about the timeout in stable releases).

[1] https://lore.kernel.org/dri-devel/20261104024106.3109873-1-Prike.Liang@amd.com/

Hamza

> [1] https://patchwork.freedesktop.org/patch/318967/
> [2] https://git.kernel.org/linus/79ae8510b5b81b9500370f89c619b50ca9c0990f
> [3] https://lore.kernel.org/dri-devel/20260601141922.91498-1-tzimmermann@suse.de/
> 
> - Saurabh


