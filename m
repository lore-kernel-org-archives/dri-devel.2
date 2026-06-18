Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AF6CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CB4410E40B;
	Thu, 18 Jun 2026 14:53:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RbweEWvR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F3810E3E1
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 14:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781794412; x=1813330412;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=LQK1k5amiHum4k7v4qC2gC4HASrAHvCiHPCPe6WMhvw=;
 b=RbweEWvRVXW3Ud8F1wQKHSmBlYuQJH09IY+nOzxGwNxwe+FvX2bun3eH
 5VlgaP6UilWgXLg/fBdROQ2c7W6A/Ep8u9mXUp37/DIGgB/+ponoupf1S
 pq6Kvtlryt0p1W7cCzUqlSb1+l/r7tqOI/PfPB5EXyTurVpgJOtpCrhNL
 fiJFd0cgn4Opq9Lo7KpuiMqJTYCx6+2cz7yayHLMLWp5TEbLyfpuMECtH
 q0xyjafeuc2boofgYtB0OOxYyEQ/9xY6TdpVpr9AVO/AY60ecztc0Ifll
 4sS3brzDr7Tffz5ufMQLVlhNSuQvYb4jvrHTD1L07cxwNxGQqFNbLO0/E w==;
X-CSE-ConnectionGUID: RD1irFtcREGdQKWM2Ub5Kg==
X-CSE-MsgGUID: 9U+/4rBKTgeNihc3Clw+5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="100043986"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="100043986"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 07:53:31 -0700
X-CSE-ConnectionGUID: PZCw4ob6SS6eGvQzQ+Kg9A==
X-CSE-MsgGUID: YUYyLKqDRGSAcHM4J6hSkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="244027388"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
 by fmviesa006-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 07:53:26 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: =?utf-8?Q?Andr=C3=A9?= Draszik <andre.draszik@linaro.org>, Maarten
 Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Juan
 Yescas <jyescas@google.com>, kernel-team@android.com, =?utf-8?Q?Andr?=
 =?utf-8?Q?=C3=A9?= Draszik <andre.draszik@linaro.org>
Subject: Re: [PATCH] drm/drm_crtc: fix race with dma_fence_signal() in
 ::get_driver_name()
In-Reply-To: <20260618-linux-drm_crtc_fix2-v1-1-c03e77b36f34@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260618-linux-drm_crtc_fix2-v1-1-c03e77b36f34@linaro.org>
Date: Thu, 18 Jun 2026 17:53:23 +0300
Message-ID: <03ea95355325fb0f8672005e10a8275304d93409@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 18 Jun 2026, Andr=C3=A9 Draszik <andre.draszik@linaro.org> wrote:
> Since commit 541c8f2468b9 ("dma-buf: detach fence ops on signal v3"),
> I'm seeing the BUG_ON() triggering in drm_crtc's fence_to_crtc() via
> drm_crtc_fence_get_driver_name() regularly:
>
>     Call trace:
>      panic+0x58/0x5c
>      die+0x160/0x178
>      bug_brk_handler+0x70/0xa4
>      call_el1_break_hook+0x3c/0x1a0
>      do_el1_brk64+0x24/0x74
>      el1_brk64+0x34/0x54
>      el1h_64_sync_handler+0x80/0xfc
>      el1h_64_sync+0x84/0x88
>      drm_crtc_fence_get_driver_name+0x60/0x68 (P)
>      sync_file_get_name+0x184/0x45c
>      sync_file_ioctl+0x404/0xf70
>      __arm64_sys_ioctl+0x124/0x1dc
>
> This looks to be caused by a code flow similar to the following:
>
> +++ snip +++
> thread A                             thread B
>
>                                      ioctl(SYNC_IOC_FILE_INFO)
>                                      sync_file_ioctl()
>                                      sync_file_get_name()
> dma_fence_signal_timestamp_locked()  dma_fence_driver_name()
>                                        ops =3D rcu_dereference(fence->ops)
>                                        if (!dma_fence_test_signaled_flag(=
))
>                                          ops->get_driver_name(fence) i.e.
>                                          drm_crtc_fence_get_driver_name()
> test_and_set_bit(SIGNALED)
> RCU_INIT_POINTER(fence->ops, NULL)
>                                      drm_crtc_fence_get_driver_name()
>                                        BUG_ON(rcu_access_pointer(fence->o=
ps)
>                                               !=3D &drm_crtc_fence_ops)
> +++ snap +++
>
> I see two ways to resolve this:
> a) simply drop the BUG_ON(). It can not work anymore since above
>    commit, as it is racy now.
> b) pass the original 'ops' pointer obtained in dma_fence_driver_name()
>    to all callees.
>
> This patch implements option a), as because:
> * I don't see much benefit in passing the extra pointer just for this
>   BUG_ON() to work.
> * Requiring the dma_fence_ops in those callbacks is an implementation
>   detail of the drm_crtc driver, and therefore upper layers shouldn't
>   have to care about that.
> * The existence of the BUG_ON() doesn't appear to be consistent with
>   implementations of ::get_driver_name() or ::get_timeline_name() in
>   the majority of other DRM drivers in the first place. Those that do
>   have a similar BUG_ON() (i915, xe) probably also need an update
>   similar to this patch here but I'm not in a position to test those.
>
> Note that the adjacent drm_crtc_fence_get_timeline_name() has the same
> problem and is fixed by this patch as well.
>
> Fixes: 541c8f2468b9 ("dma-buf: detach fence ops on signal v3")
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
>  drivers/gpu/drm/drm_crtc.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index 63ead8ba6756..31c8636e7467 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -73,6 +73,9 @@
>   * &drm_mode_config_funcs.atomic_check.
>   */
>=20=20
> +#define fence_to_crtc(f) container_of((f)->extern_lock, \
> +				      struct drm_crtc, fence_lock)
> +
>  /**
>   * drm_crtc_from_index - find the registered CRTC at an index
>   * @dev: DRM device
> @@ -154,14 +157,6 @@ static void drm_crtc_crc_fini(struct drm_crtc *crtc)
>  #endif
>  }
>=20=20
> -static const struct dma_fence_ops drm_crtc_fence_ops;
> -
> -static struct drm_crtc *fence_to_crtc(struct dma_fence *fence)
> -{
> -	BUG_ON(rcu_access_pointer(fence->ops) !=3D &drm_crtc_fence_ops);

Whether removing the BUG_ON() turns out to be the right choice or not, I
couldn't say, but please don't turn this function into a macro, at least
not without rationale. (I can't think of any.)

BR,
Jani.

> -	return container_of(fence->extern_lock, struct drm_crtc, fence_lock);
> -}
> -
>  static const char *drm_crtc_fence_get_driver_name(struct dma_fence *fenc=
e)
>  {
>  	struct drm_crtc *crtc =3D fence_to_crtc(fence);
>
> ---
> base-commit: e2cae00c05d196491c318196792297f2dfbaa02c
> change-id: 20260618-linux-drm_crtc_fix2-23a7c354a412
>
> Best regards,

--=20
Jani Nikula, Intel
