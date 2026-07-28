Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705EFC54F52
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6EC810EA06;
	Tue, 28 Jul 2026 21:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hLkP+1Kj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BF8D10E5F6
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 21:29:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EA7CF43E56;
 Tue, 28 Jul 2026 21:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6551F000E9;
 Tue, 28 Jul 2026 21:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785274187;
 bh=qo02jaG/iaehK9IgIjzDd8LisvcZ4kRjvn4JiVQc3xA=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=hLkP+1KjEAlsQ19hJQFFhwP8059JEmTMPHxmns1KbC3HsrXzLCpwR9ubnvCM+HEzF
 TsWbPvsjfIZ8b40jj7Hj09FSfmQHyv6J/nWJaEjktZ12u8g8YbcDF52/cssvpJDvBt
 4SXXY5r0ZAyyZDBlkKOdf2ZgjDNfYCR84AdYB6te9Luvsjh//xV5LqoAWLVlwvSQya
 hUffvZa7w5+CvAFJ8ueKgNx6pPWyFcRb2Ev+i2QGG2k9oXInP7Hl+s9fqw9YHUNvfm
 eYAXIGSsKckyFAJ+gofeeIxPH4gJ/TmraMb3trcZ22l5PM4D+iVXq0ZEDWyH54GSgu
 FTP98qXm9cS6A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 23:29:43 +0200
Message-Id: <DKAIVPSA45O9.1NZES5S3BII10@kernel.org>
Subject: Re: [PATCH v3 3/7] drm: nova: Add chipid enum to nova-drm UAPI
Cc: <nova-gpu@lists.linux.dev>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260723063046.1265791-1-apopple@nvidia.com>
 <20260723063046.1265791-4-apopple@nvidia.com>
 <DK7R7PB91GUE.1PS77AQM8ZR99@kernel.org>
 <amhdA35CcMD_uY2f@nvdebian.thelocal>
In-Reply-To: <amhdA35CcMD_uY2f@nvdebian.thelocal>
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

On Tue Jul 28, 2026 at 10:00 AM CEST, Alistair Popple wrote:
> On 2026-07-26 at 01:23 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
>> On Thu Jul 23, 2026 at 8:30 AM CEST, Alistair Popple wrote:
>> > diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
>> > index 3ca90ed9d2bb..cb13fba6b952 100644
>> > --- a/include/uapi/drm/nova_drm.h
>> > +++ b/include/uapi/drm/nova_drm.h
>> > @@ -25,6 +25,39 @@ extern "C" {
>> >   */
>> >  #define NOVA_GETPARAM_VRAM_BAR_SIZE	0x1
>> > =20
>> > +enum drm_nova_chipid {
>>=20
>> It seems trivial, but let's add at least some documentation.
>
> No, good idea.
>
>> For instance, what's valid for userspace to extract from this? Given chi=
pid is a
>> composed value, is userspace e.g. allowed to make assumptions on extract=
ing the
>> architecture? Or is this something we want to expose separately and tell
>> userspace that the chipid is an opaque value identifying a specific chip=
 only?
>
> I _think_ it makes sense for this to just be an opaque value, but it's a =
good
> question that I should probably try and get some internal feedback on as =
well.
> Reading the arch would then be a separate parameter.

I'd prefer exposing it as an opaque value and provide other information
separately; the kernel already does the work anyway, so why duplicate it in
userspace. It would also remain much cleaner if encoding details ever chang=
e.

>> > +	/* Turing */
>> > +	NOVA_DRM_CHIPID_TU102 =3D 0x162,
>> > +	NOVA_DRM_CHIPID_TU104 =3D 0x164,
>> > +	NOVA_DRM_CHIPID_TU106 =3D 0x166,
>> > +	NOVA_DRM_CHIPID_TU117 =3D 0x167,
>> > +	NOVA_DRM_CHIPID_TU116 =3D 0x168,
>> > +	/* Ampere */
>> > +	NOVA_DRM_CHIPID_GA100 =3D 0x170,
>> > +	NOVA_DRM_CHIPID_GA102 =3D 0x172,
>> > +	NOVA_DRM_CHIPID_GA103 =3D 0x173,
>> > +	NOVA_DRM_CHIPID_GA104 =3D 0x174,
>> > +	NOVA_DRM_CHIPID_GA106 =3D 0x176,
>> > +	NOVA_DRM_CHIPID_GA107 =3D 0x177,
>> > +	/* Hopper */
>> > +	NOVA_DRM_CHIPID_GH100 =3D 0x180,
>> > +	/* Ada */
>> > +	NOVA_DRM_CHIPID_AD102 =3D 0x192,
>> > +	NOVA_DRM_CHIPID_AD103 =3D 0x193,
>> > +	NOVA_DRM_CHIPID_AD104 =3D 0x194,
>> > +	NOVA_DRM_CHIPID_AD106 =3D 0x196,
>> > +	NOVA_DRM_CHIPID_AD107 =3D 0x197,
>> > +	/* Blackwell GB10x */
>> > +	NOVA_DRM_CHIPID_GB100 =3D 0x1a0,
>> > +	NOVA_DRM_CHIPID_GB102 =3D 0x1a2,
>> > +	/* Blackwell GB20x */
>> > +	NOVA_DRM_CHIPID_GB202 =3D 0x1b2,
>> > +	NOVA_DRM_CHIPID_GB203 =3D 0x1b3,
>> > +	NOVA_DRM_CHIPID_GB205 =3D 0x1b5,
>> > +	NOVA_DRM_CHIPID_GB206 =3D 0x1b6,
>> > +	NOVA_DRM_CHIPID_GB207 =3D 0x1b7,
>> > +};

