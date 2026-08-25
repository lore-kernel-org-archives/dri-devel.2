Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E995AC61DB9
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 214A210E609;
	Tue, 25 Aug 2026 22:37:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R31o1gmS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3973910E609
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 22:37:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 17C8C600C4;
 Tue, 25 Aug 2026 22:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562B01F000E9;
 Tue, 25 Aug 2026 22:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787697439;
 bh=tkkG3jNmCMaPTmK+y0e5pwDKOHFGTRb3nSdU+OGdo2g=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=R31o1gmSWZH3IZUMS6Svk1BxH9q8QOyfHlHbL7C+yN9cNi1Fa/LLz+GZsJyls3/Tp
 Spz8Wjo8ngE9HvypMd1mhWwpF0Uneu6FL2QBEXT9HdSRPANrWwgADOap80vu87TYS0
 vnNU69nLDmsbwaodp/MFoyFXhKkATQTHExa0SzI0dgb84QP5ysEjETZ0dcLUXoAjX9
 bj33nfsOq8KQhyrtUdPUPTChsjYoWOEJjokh+56Cpvb9FfNAsM5PGWle4eCHkwEo0s
 lgx96pIniY1Nx3uWivh3v24pnzQUtbHSiYgatgDMvuBiJzfv/WZYbND8TU17/XZG9S
 DFcVgBIUg5GDw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 00:37:15 +0200
Message-Id: <DKYDUOFB4C8P.3STNQMZY571XI@kernel.org>
Cc: "nova-gpu" <nova-gpu@lists.linux.dev>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Alexandre
 Courbot" <acourbot@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>, "John
 Hubbard" <jhubbard@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 4/7] drm: nova: Add a GPU info ioctl
References: <20260811050657.646799-1-apopple@nvidia.com>
 <20260811050657.646799-5-apopple@nvidia.com>
 <DKRHW6G6P4K5.15H1A4DGR6672@kernel.org>
 <aofWfMSZtV-bNYrr@nvdebian.thelocal>
 <DKXETHVKYVV4.1P8RNJ6AXV3X8@kernel.org>
 <ao1AnG7fUhJ8a1U-@nvdebian.thelocal>
In-Reply-To: <ao1AnG7fUhJ8a1U-@nvdebian.thelocal>
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

On Tue Aug 25, 2026 at 9:32 AM CEST, Alistair Popple wrote:
> On 2026-08-25 at 05:10 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
>> I don't think we are really concerned about running out of ioctls, but i=
t seems
>> cleaner and more self-contained than having N ioctls for different info =
structs
>> and in the worst case having v2...vN info ioctls.
>
> But isn't v2...vN info ioctls dealt with in the usual way by extending th=
e
> existing struct and bumping the size? That seems like a pretty clean and
> self-contained API to me.

To be clear, my main point is that having a single info ioctl with differen=
t
info types is more self-contained and provides more flexibility to introduc=
e new
info types whenever we think it is warranted. Long term I expect it to be t=
he
cleaner API.

>> It also allows us to define a new info type struct whenever we think som=
ething
>> is a new logical info group. Making it per ioctl will always raise the q=
uestion
>> of "do we really need a new ioctl for this, can't we just fit it in X", =
which
>> over time tends to get messy.
>
> Doesn't that question also apply to adding GETPARAM N+1 though? If we're =
not
> worried about running out of top-level ioctls I don't understand why they
> are considered special enough to warrant the extra complexity of creating=
 and
> decoding a hiearchy of sub-ioctls.

I think the code would be rather trivial:

	fn write_info<T: AsBytes>(info: &mut uapi::drm_nova_info, value: &T) -> Re=
sult {
	    let len =3D size_of_val(value).min(info.size);
	    let uptr =3D UserPtr::from_addr(info.data);
	    let mut writer =3D UserSlice::new(uptr, len).writer();

	    // Note: I made this up, as I think we want to add this method to
	    // `UserSliceWriter`, to avoid having to call `as_bytes()`.
	    writer.write_truncated(&value)?;
	    info.size =3D len;

	    Ok(())
	}

	match info.id {
	    uapi::DRM_NOVA_INFO_GPU =3D> write_info(info, &uapi::drm_nova_gpu_info=
 { ... })?,
	    uapi::DRM_NOVA_INFO_MEM =3D> write_info(info, &uapi::drm_nova_mem_info=
 { ... })?,
	    _ =3D> return Err(EINVAL),
	}

Honestly, I think this is even less complicated that adding a new ioctl for=
 a
new info struct.

And on the userspace side:

	fn query_info<T: Default>(fd: &DrmDevice, id: DrmNovaInfoId) -> Result<T> =
{
	    let mut value =3D T::default();
	    let mut info =3D drm_nova_info {
	        id: id.as_raw(),
	        size: size_of::<T>(),
	        data: ptr::from_mut(&mut value) as u64,
	    };

	    fd.ioctl(DRM_IOCTL_NOVA_INFO, &mut info)?;
	    Ok(value)
	}

	let gpu_info: drm_nova_gpu_info =3D query_info(&dev, DRM_NOVA_INFO_GPU)?;
	let mem_info: drm_nova_mem_info =3D query_info(&dev, DRM_NOVA_INFO_MEM)?;

(I pushed a few cleanups to drm-test, so this code should work.)
