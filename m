Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3017F43854
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 16:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D22A10E0D1;
	Wed, 15 Apr 2026 16:20:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jQt70s4Z";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A32310E0D1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 16:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776270018; x=1807806018;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=m4YfnDIbCi7BXmV+lau7F/ghCdmY+G7YbxewybdrT2k=;
 b=jQt70s4ZD7/Tn7jrSJ5fPQ2eSdG2a65q9NBUIYgl8bF9FJ50EuE8vZGb
 mHt06MdRzyNbf2/qgXw24W7msNPZWXnRQOTO2+9FAUkv4UyVglP/O4SF+
 edZThXLsGSztKBaAag74iY79JKlvDX08N4qKkTE4/So5ESX4H/t5lz71C
 oOAk6CVkCtsCHf/iCyfGFgKp8sBt4FaZsU573esHE5ylHPW6nyH/HDK2x
 QbWyLely2I7YCI+KwE8yQS6SIWURJY7s60uLywonLWMHsN9eGsPiFkoya
 8IBeBwHPaWYxG9rq+IksS7wu7yD+ryxqJ4v6QbS61DaLW8viLJ1ursqV/ w==;
X-CSE-ConnectionGUID: FTYGlgaxRHGGr86RpcVeUg==
X-CSE-MsgGUID: AKrQ7ZuuTGyrbXxAUxRo3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="94825378"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="94825378"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 09:20:09 -0700
X-CSE-ConnectionGUID: yWeGjXwYR1y2LwoFVhcMbA==
X-CSE-MsgGUID: qVPLAql/R8iGq5jKthnWiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; d="scan'208";a="253883302"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.25])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2026 09:20:05 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v7 6/6] drm/panthor: Bump the driver version to 1.9
In-Reply-To: <ad-ZeRTbYYGatj7G@sobremesa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
 <20260415112900.681834-7-adrian.larumbe@collabora.com>
 <65fecdade3d25886c2c110d399517408b7a8ea34@intel.com>
 <ad-ZeRTbYYGatj7G@sobremesa>
Date: Wed, 15 Apr 2026 19:20:02 +0300
Message-ID: <204ed6d8712c571a570ce3298b9d586939cd4918@intel.com>
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

On Wed, 15 Apr 2026, Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wro=
te:
> Hi Jani,
>
> On 15.04.2026 16:54, Jani Nikula wrote:
>> On Wed, 15 Apr 2026, Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> =
wrote:
>> > Bump the driver version to reflect the new MMU info query ioctl
>> > parameter and the VM_BIND map sparse flag.
>>
>> You're not actually bumping the version, just adding to the comment.
>
> Forgot to increase the driver's minor revision number, thanks for the cat=
ch.
>
>> Does the version actually work for you for checking stuff? Do you have
>> userspace checking it? Should it be some capability thing instead?
>
> We absolutely need it because the UMD must be compatible with previous ke=
rnel versions,
> which means in the case of sparse mappings, the old method of creating th=
e dummy BO
> in user mode and then having the Mesa driver do repeated mappings over it=
 through
> successive VM_BIND ioctl's must be available.

Okay, I was just wondering as the last time we bumped i915 version was
nearly 20 years ago. ;D


BR,
Jani.




>
>> BR,
>> Jani.
>>
>> >
>> > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
>> > ---
>> >  drivers/gpu/drm/panthor/panthor_drv.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/p=
anthor/panthor_drv.c
>> > index a8090bc4e33c..c8fb63ede62c 100644
>> > --- a/drivers/gpu/drm/panthor/panthor_drv.c
>> > +++ b/drivers/gpu/drm/panthor/panthor_drv.c
>> > @@ -1787,6 +1787,8 @@ static void panthor_debugfs_init(struct drm_mino=
r *minor)
>> >   *       - adds DRM_IOCTL_PANTHOR_BO_QUERY_INFO ioctl
>> >   *       - adds drm_panthor_gpu_info::selected_coherency
>> >   * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
>> > + * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
>> > + *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
>> >   */
>> >  static const struct drm_driver panthor_drm_driver =3D {
>> >  	.driver_features =3D DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
>>
>> --
>> Jani Nikula, Intel
>
> Adrian Larumbe

--=20
Jani Nikula, Intel
