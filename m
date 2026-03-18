Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA43610775E0
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 16:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C62510E040;
	Wed, 18 Mar 2026 16:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="MXWBMUgb";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3E3910E040
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1773850016;
 bh=/BZhzcK4gj7iAcnIws8JWOideBOmHSDSiVdZIqnxQcs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MXWBMUgbhkX/X9qDeh8WEmIZx+Lx0tsXoleF6FJE36xAAYEPm9hgxAff8bfR8+U/P
 9hJ+s1JFVri5d6pzAuY7CREcGMvpMZ3B9n+/LlQg10et6V7v1ig8jmkcUg8ZAkxtCW
 IJgydeclx2n5xmivAm1airPDiaYAnL4y1qIis2FOzKr8dvBH5NMeHca0hYNAdsqgha
 TpjrNP/OR9AVqz6V8poEoVGyhPEFM7PkGBE0aACXiwWrTYvleBnRQMZ5i9bWABuFYS
 3vLGwl/AL7z6jaE7PJLwwx/u9E1h+AFsfvaiCty+VItB91nIXgc4dS+vdni/3lqfaN
 9FUlBxzqDBanw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 12E4017E1005;
 Wed, 18 Mar 2026 17:06:56 +0100 (CET)
Date: Wed, 18 Mar 2026 17:06:50 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Marcin =?UTF-8?B?xZpsdXNhcno=?= <marcin.slusarz@arm.com>, Liviu Dudau
 <liviu.dudau@arm.com>, dri-devel@lists.freedesktop.org, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Lukas Zapolskas <lukas.zapolskas@arm.com>, nd@arm.com
Subject: Re: [PATCH] drm/panthor: extend timestamp query with flags
Message-ID: <20260318170650.496872ae@fedora>
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
> user space didn't provide. So adding a flags field to the end of the
> struct will be guaranteed to be zero with old (binary of) user space.

This ^.

>=20
> This is the standard way of extending an API. If user space is
> recompiled with new headers then user space will pass in the larger size
> (because it uses sizeof()), but will zero initialise any fields that it
> doesn't know about. If you look purely at the size passed by userspace
> then the sizeof() will be wrong and no flags will get set.
>=20
> > If the conclusion will be that checking size must be dropped, then
> > I think looking at flags being non-zero would be enough - there's
> > no need for new special flag that says other bits mean something. =20
>=20
> That would be fine if we don't want the 'default' flags behaviour you
> have above. So either GPU/GPU_OFFSET/FREQ are unconditionally enabled or
> you need to reverse the meaning of those flags.

Right, if you don't want the extra ADVANCED_QUERY flag, the GPU,
GPU_OFFSET and FREQ flags need to be opt-out, but that's a bit
confusing if the other flags are opt-in.

> Or of course go with
> Boris's suggestion of a flag to enable the new behaviour.
>=20
> [...]
>=20
> >>>  /**
> >>>   * struct drm_panthor_timestamp_info - Timestamp information
> >>>   *
> >>> @@ -421,11 +450,29 @@ struct drm_panthor_timestamp_info {
> >>>  	 */
> >>>  	__u64 timestamp_frequency;
> >>> =20
> >>> -	/** @current_timestamp: The current timestamp. */
> >>> +	/** @current_timestamp: The current GPU timestamp. */
> >>>  	__u64 current_timestamp;
> >>> =20
> >>> -	/** @timestamp_offset: The offset of the timestamp timer. */
> >>> +	/** @timestamp_offset: The offset of the GPU timestamp timer. */
> >>>  	__u64 timestamp_offset;
> >>> +
> >>> +	/** @flags: Bitmask of drm_panthor_timestamp_info_flags. */
> >>> +	__u32 flags;
> >>> +
> >>> +	/** @duration_nsec: Duration of time query. */
> >>> +	__u32 duration_nsec;
> >>> +
> >>> +	/** @cycle_count: Value of GPU_CYCLE_COUNT. */
> >>> +	__u64 cycle_count;
> >>> +
> >>> +	/** @cpu_timestamp_sec: Seconds part of CPU timestamp. */
> >>> +	__u64 cpu_timestamp_sec;
> >>> +
> >>> +	/** @cpu_timestamp_nsec: Nanseconds part of CPU timestamp. */
> >>> +	__u32 cpu_timestamp_nsec;
> >>> +
> >>> +	/** @pad1: Padding, MBZ. */
> >>> +	__u32 pad1; =20
> >>
> >> Let's re-purpose the existing pad field into flags, move duration_nsec=
 after
> >> cpu_timestamp_nsec, and get rid of this pad1. =20
> >=20
> > I'm not sure I understand. Do you want me to extend flags to u64?
> > What's the point of that? =20
>=20
> I'm not sure I necessarily understand Boris's comment either, but I
> would suggest making flags u64 would be better.

I was confused by the fact the field was named pad1, and I assumed
there was a pad field already present in the struct, which is why I
suggested re-purposing that one instead of adding a new field that
would in turn require extra padding. Given there's no pre-existing
padding, I'd rename pad1 into pad and call it a day.

>=20
> By shuffling things around to have a u64 flags you no longer have any
> padding fields. And the unused part of the flags will be naturally
> checked for being 0 rather than the explicit check for pad1 you
> currently have.
>=20
> Not a big deal to me - but it's easier to just avoid padding fields
> where possible as they often get overlooked in the validation.

We certainly want to ensure they are, this way we can re-purpose
existing padding fields instead of adding new ones when we need to
extend the logic.
