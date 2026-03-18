Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FA610775E1
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 16:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3810410E0EC;
	Wed, 18 Mar 2026 16:34:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hO5zJHhV";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0654510E179
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 16:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773851678;
 bh=zbxs3LDFZQRVY/2Lmvcucz8fWoAGHNzgahFwwm8KltA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hO5zJHhVhW7KdCyOEMFfoJPK5SVcSFx63LqA3viAQ2P76h7N9oDyo3VVblYTLxGtU
 godS7NAmkWGx1235HgxeEsgxxM8NXrZJ1ODkn62TAhkEgwLaQMQI1rWrgnQkbdlUtd
 7vPsURL4daKUZjJMUv5PaswVrEJsg+Se30nQ8gtjaopovFBoIWxyf37lA31oMVbP6+
 26ZMDpVfBJGMHKokpG/LHAPsWEdXyVWiaiNYqfgPmFeCaUhUbZGZ/vkm2sndc98CoB
 zDMwoNPXGRxcRKGD4yCWrkgG7URF8rT51GnW/lfPSlfyI/wMXOobwnI/WV/qlsDqfu
 tvxWieekbGLFg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 30E7717E0CF3;
 Wed, 18 Mar 2026 17:34:38 +0100 (CET)
Date: Wed, 18 Mar 2026 17:34:33 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Marcin =?UTF-8?B?xZpsdXNhcno=?= <marcin.slusarz@arm.com>, Liviu Dudau
 <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Lukas Zapolskas <lukas.zapolskas@arm.com>, nd@arm.com
Subject: Re: [PATCH] drm/panthor: extend timestamp query with flags
Message-ID: <20260318173433.1b5811f0@fedora>
In-Reply-To: <72a93cdd-b105-41aa-bf12-d6caf7e90078@arm.com>
References: <20260318112952.645160-1-marcin.slusarz@arm.com>
 <20260318131030.4ae7f820@fedora> <abq75MJM5n-U33Fl@e129842.arm.com>
 <72a93cdd-b105-41aa-bf12-d6caf7e90078@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed, 18 Mar 2026 15:20:18 +0000
Steven Price <steven.price@arm.com> wrote:

> On 18/03/2026 14:51, Marcin =C5=9Alusarz wrote:
> > On Wed, Mar 18, 2026 at 01:10:30PM +0100, Boris Brezillon wrote: =20
> >> On Wed, 18 Mar 2026 12:29:52 +0100
> >> Marcin Slusarz <marcin.slusarz@arm.com> wrote:
> >> =20
> >>> Flags now control which data user space wants to query,
> >>> there is more information sources, and there's ability
> >>> to query duration of multiple timestamp reads.
> >>>
> >>> New sources:
> >>> - CPU's monotonic,
> >>> - CPU's monotonic raw,
> >>> - GPU's cycle count
> >>>
> >>> These changes should make the implementation of
> >>> VK_KHR_calibrated_timestamps more accurate and much simpler.
> >>>
> >>> Signed-off-by: Marcin Slusarz <marcin.slusarz@arm.com>
> >>> ---
> >>> This is counter proposal to https://lore.kernel.org/all/2025091620075=
1.3999354-1-olvaffe@gmail.com/
> >>> ---
> >>>  drivers/gpu/drm/panthor/panthor_drv.c | 124 ++++++++++++++++++++++++=
--
> >>>  include/uapi/drm/panthor_drm.h        |  51 ++++++++++-
> >>>  2 files changed, 166 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/=
panthor/panthor_drv.c
> >>> index 165dddfde6ca..19ede20a578e 100644
> >>> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> >>> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> >>> @@ -13,7 +13,9 @@
> >>>  #include <linux/pagemap.h>
> >>>  #include <linux/platform_device.h>
> >>>  #include <linux/pm_runtime.h>
> >>> +#include <linux/sched/clock.h>
> >>>  #include <linux/time64.h>
> >>> +#include <linux/time_namespace.h>
> >>> =20
> >>>  #include <drm/drm_auth.h>
> >>>  #include <drm/drm_debugfs.h>
> >>> @@ -762,21 +764,123 @@ static void panthor_submit_ctx_cleanup(struct =
panthor_submit_ctx *ctx,
> >>>  }
> >>> =20
> >>>  static int panthor_query_timestamp_info(struct panthor_device *ptdev,
> >>> -					struct drm_panthor_timestamp_info *arg)
> >>> +					struct drm_panthor_timestamp_info *arg,
> >>> +					u32 size)
> >>>  {
> >>>  	int ret;
> >>> +	u32 flags;
> >>> +	unsigned long irq_flags;
> >>> +	struct timespec64 cpu_ts;
> >>> +	u64 query_start_time;
> >>> +	bool minimize_interruption;
> >>> +	u32 timestamp_types =3D 0;
> >>> +
> >>> +	if (size >=3D offsetof(struct drm_panthor_timestamp_info, pad1) + s=
izeof(arg->pad1) &&
> >>> +			arg->pad1 !=3D 0)
> >>> +		return -EINVAL;
> >>> +
> >>> +	if (size >=3D offsetof(struct drm_panthor_timestamp_info, flags) + =
sizeof(arg->flags))
> >>> +		flags =3D arg->flags;
> >>> +	else
> >>> +		flags =3D DRM_PANTHOR_TIMESTAMP_GPU |
> >>> +			DRM_PANTHOR_TIMESTAMP_GPU_OFFSET |
> >>> +			DRM_PANTHOR_TIMESTAMP_FREQ; =20
> >>
> >> How about we add a DRM_PANTHOR_TIMESTAMP_ADVANCED_QUERY flag that tells
> >> the driver whether the default should be picked or not instead of this
> >> weird is-this-the-new-or-old-struct detection based on the size. =20
> >=20
> > Well, as is, we would read uninitialized data from kernel stack if
> > user passed old struct with the original size. It's fixable, but
> > I'm not sure why you think checking size to detect the use of new
> > interface is weird. I thought it's a pretty standard thing. =20
>=20
> What you need is copy_struct_from_user() - it will zero any fields that
> user space didn't provide.
> So adding a flags field to the end of the
> struct will be guaranteed to be zero with old (binary of) user space.

Okay, so the problem seems to be that we've always treated DEV_QUERY
args as write-only, and we don't have this copy_struct_from_user() trick
on the args yet. Given the opt-out/in discussion, and the fact we want
something that's read-write (reads flags, outputs timestamps and other
props), I'd be tempted to make that a separate DEV_QUERY
(DRM_PANTHOR_DEV_QUERY_ADVANCED_TIMESTAMP_INFO?).

