Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE1AC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 19:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8425710E18E;
	Mon, 24 Aug 2026 19:10:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CW4St/tb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3FC810E0F5
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 19:10:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7955B42AE4;
 Mon, 24 Aug 2026 19:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D32C1F000E9;
 Mon, 24 Aug 2026 19:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787598608;
 bh=/CsiULjFpCPEuvRQWJKqgN0bBYnaYHc0+oV1+e1PNY4=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=CW4St/tb3/yC0Jgwt/GzhO7vILEjAOHYWgZJN5fJDGYuwYZ2aPZtsGTw6w67v/zb1
 C3orxEMzYjRb+lkMkMluV29GaAK5Kd971Ot323qYCyRGTj33ha6zccGVu3ytpT8Vs0
 /HxnZIVtlGLvMEiHDE9fkJSCt07S7DWac2xh/LdNvrGUqqCZMqR+7QNSWvQItf2G1A
 ftKB+F5Mv3XmOyK1QpmSwVjNmZmsiETv5t9Uc3dfV28VB7NXzSjGg4axMtdXGxzhYo
 nPGuOS4oKIvz1jvZ+B0YerR48fUT3bRpLt2HSb7rXUDMRN/GwZHo4MvnqLAds3idb6
 7LzQf1LVz6FUQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 21:10:04 +0200
Message-Id: <DKXETHVKYVV4.1P8RNJ6AXV3X8@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 4/7] drm: nova: Add a GPU info ioctl
Cc: "nova-gpu" <nova-gpu@lists.linux.dev>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Alexandre
 Courbot" <acourbot@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>, "John
 Hubbard" <jhubbard@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
References: <20260811050657.646799-1-apopple@nvidia.com>
 <20260811050657.646799-5-apopple@nvidia.com>
 <DKRHW6G6P4K5.15H1A4DGR6672@kernel.org>
 <aofWfMSZtV-bNYrr@nvdebian.thelocal>
In-Reply-To: <aofWfMSZtV-bNYrr@nvdebian.thelocal>
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

On Fri Aug 21, 2026 at 7:10 AM CEST, Alistair Popple wrote:
> On 2026-08-18 at 06:18 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
>> On Tue Aug 11, 2026 at 7:06 AM CEST, Alistair Popple wrote:
>> > diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
>> > index ea7665383644..2604e4d2698b 100644
>> > --- a/include/uapi/drm/nova_drm.h
>> > +++ b/include/uapi/drm/nova_drm.h
>> > @@ -118,9 +118,34 @@ struct drm_nova_gem_info {
>> >  	__u64 size;
>> >  };
>> > =20
>> > +/**
>> > + * struct drm_nova_gpu_info - query DRM GPU info.
>> > + */
>> > +struct drm_nova_gpu_info {
>> > +	/**
>> > +	 * @size: The amount of space allocated by userspace for this struct=
ure.
>> > +	 * The kernel will return the amount of data it did/could actually w=
rite.
>> > +	 * User space can use this to determine how much of the struct is va=
lid
>> > +	 * when running against an older kernel.
>> > +	 */
>> > +	__u64 size;
>> > +
>> > +	/**
>> > +	 * @chipid: GPU chip identifier. See &enum drm_nova_chipid for curre=
ntly
>> > +	 * known chip identifiers.
>> > +	 */
>> > +	__u32 chipid;

I think we now also want to add a field for the architecture now that chipi=
d is
considered opaque.

>> > +
>> > +	/**
>> > +	 * @pad: 32 bit padding, must be 0.
>> > +	 */
>> > +	__u32 pad;
>> > +};
>>=20
>> I think we should add the indirection we discussed in [1], i.e. have an
>> indirection via
>>=20
>> 	struct drm_nova_info {
>> 		__u32 id;
>> 		__u32 size;
>> 		__u64 info;
>> 		/* Revserved fields, just in case? */
>> 	};
>>=20
>> so we can easily add new info structures, or extend an existing one with=
 a v2
>> without having to create new ioctls for this purpose.
>
> Sorry, I should have called this difference out more explicitly.
>
> Basically I ended up doing it this way because it didn't make much sense =
to me
> putting an ioctl interface within an ioctl interface when DRM ioctl handl=
ing
> can already deal with matching numbers and truncating/extending the struc=
t as
> required. It just leads to more code comparing ID's, etc and I'm not real=
ly sure
> what the advantage is. Are we concerned about running out of ioctls if we=
 have
> to add other types of info struct?
>
> Doing this as top-level ioctl makes the strace decoders simpler and means=
 we can
> just rely on the existing DRM ioctl handling to get everything right rath=
er than
> duplicating that in nova-drm. Or is there some other advantage to [1] tha=
t I've
> missed that isn't solved here?

I don't think we are really concerned about running out of ioctls, but it s=
eems
cleaner and more self-contained than having N ioctls for different info str=
ucts
and in the worst case having v2...vN info ioctls.

It also allows us to define a new info type struct whenever we think someth=
ing
is a new logical info group. Making it per ioctl will always raise the ques=
tion
of "do we really need a new ioctl for this, can't we just fit it in X", whi=
ch
over time tends to get messy.

I think eventually we will have a bunch of different info categories. OpenR=
M
seems to have quite some as well (not too many categories, but with lots of
fields), Xe and amdgpu have even more categories.

> Thanks for looking.
>
>  - Alistair
>
>>=20
>> [1] https://lore.kernel.org/nova-gpu/DKC6T1DQX2L3.HTHPB2L167TC@kernel.or=
g/
>>=20
>> >  #define DRM_NOVA_GETPARAM		0x00
>> >  #define DRM_NOVA_GEM_CREATE		0x01
>> >  #define DRM_NOVA_GEM_INFO		0x02
>> > +#define DRM_NOVA_GPU_INFO		0x03
>> > =20
>> >  /* Note: this is an enum so that it can be resolved by Rust bindgen. =
*/
>> >  enum {
>> > @@ -130,6 +155,8 @@ enum {
>> >  						   struct drm_nova_gem_create),
>> >  	DRM_IOCTL_NOVA_GEM_INFO		=3D DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GE=
M_INFO,
>> >  						   struct drm_nova_gem_info),
>> > +	DRM_IOCTL_NOVA_GPU_INFO		=3D DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GP=
U_INFO,
>> > +						   struct drm_nova_gpu_info),
>> >  };
>> > =20
>> >  #if defined(__cplusplus)
>> > --=20
>> > 2.54.0
>>=20

