Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862F5606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HoA7NMXE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA74710F810;
	Tue,  3 Nov 2026 23:01:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B4E410F8C9
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 23:01:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B8A044160F;
 Tue,  3 Nov 2026 23:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C031F00919;
 Tue,  3 Nov 2026 23:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793746901;
 bh=HG4LeYVIQaO4suE98EnGjr2FaWxwF7kTUOTBDjpiOjY=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=HoA7NMXEILwYsUjUJgECQiOuE7gXz3tL2ediH183RegRFwVnAuoWkwdJHd19/cCcy
 f7C7tRcz4Mnjqvz+boi1fnPuDCs7vBlGNhdzTaggfEpm1ZpT95uqS92hGsygEjDOxn
 RpNqgj0WXsl1Ge6IrrLilZvay5IZwcV18qQhDUuTc9/CE7BS9kr1HqZ6VpkecYFXNK
 eSjY/ASE9jd8dsX+UhL/GMad0QJ5Ben/xTkxlNGMo0QPZDx5X5TIz+1iqmHk7JmAli
 ARKUaBTHtMs9/YI9gJX5GoNJz/H7sEtchPLBWKsVhIy2oQ6vxcv8rqis6MP12ZuaJt
 nQc1nQbTWnX9A==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:01:36 +0100
Message-Id: <DMLY7GDT8VBO.EE1P01ZX2HPK@kernel.org>
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
Cc: "Alex Deucher" <alexdeucher@gmail.com>, "Dave Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Jani Nikula"
 <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Tvrtko Ursulin" <tursulin@ursulin.net>,
 "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Alex Deucher"
 <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>, "Mark Brown"
 <broonie@kernel.org>, <linux-next@vger.kernel.org>
To: "Rodrigo Vivi" <rodrigo.vivi@intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <aujZcJBUyQ7iX_PM@intel.com>
 <DMKY979I29AF.BS1DF5YAZMOY@kernel.org> <aujikV14tF6K1Xqw@intel.com>
 <DMKZR0YZV1CX.DWVK9V47GR1J@kernel.org>
 <CAPM=9tww=CJdxzvfUvLwQ6V4uoszg8JrB1XCAcp15upM-xPvSg@mail.gmail.com>
 <DMLTRKUXTL3P.11VRVU1A8ERMG@kernel.org> <aupFKGpAwAiGXN0U@intel.com>
 <DMLVPRO7XF7F.21199FO61MFRD@kernel.org>
 <CADnq5_N-6_T8EnihjoTSqpHGb_mZPogi6z=Ti-7_oue5d07oTw@mail.gmail.com>
 <aupktBCwcN_coHEH@intel.com>
In-Reply-To: <aupktBCwcN_coHEH@intel.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 3, 2026 at 11:48 PM CET, Rodrigo Vivi wrote:
> On Tue, Nov 03, 2026 at 04:19:11PM -0500, Alex Deucher wrote:
>> On Tue, Nov 3, 2026 at 4:11=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
>> >
>> > On Tue Nov 3, 2026 at 9:33 PM CET, Rodrigo Vivi wrote:
>> > > On Tue, Nov 03, 2026 at 08:32:48PM +0100, Danilo Krummrich wrote:
>> > >> IOW, linux-next merges tip/for-linux-next, and tip/for-linux-next m=
erges
>> > >> $tree/for-linux-next, rather than $tree/$tree-next.
>> > >
>> > > For this to work we need:
>> > > 1. xe to create for-linux-next for-linux-next-fixes
>> > > 2. amd to create for-linux-next for-linux-next-fixes
>> >
>> > Huh, I thought all the trees are doing this already. Well, that explai=
ns
>> > where the the problem comes from. :)
>> >
>> > In any case, drm-misc, drm-rust and drm-intel already have for-linux-n=
ext and
>> > for-linux-next-fixes, and the implementation is generic. So, adding it=
 to xe and
>> > amd is trivial.
>>=20
>> I've started doing this for amdgpu this cycle as well, but I still
>> pushed an amdgpu-next branch as well since that is the source of all
>> of the cherry-picks for -fixes and -next-fixes.
>
> But it only works if you stop this branch of updating after you sent your=
 last
> -PR and from that point and on you merge or cherry-pick-from your -next-f=
ixes.
> Otherwise you are sending next.next material to -linux-next.
> And this is the current issue Mark is raising to us for a while.
>
> We have 2 proposals on the table:
> 1. (this RFC): a global unified drm-for-linux-next that is a chop-point w=
hile
>    drm-tip is getting constructed.
>    If we go with this option you don't need to do anything, but stop main=
taining
>    your for-linux-next.
> 2. (Danilo's proposal): Each driver/domain keep their for-intel-next and
>    for-intel-next-fixes for granular control of the blackout weeks
>    and dim merge them together into a drm-for-linux-next
>    If we go with this you need to at least ensure that your for-linux-nex=
t
>    doesn't contain next.next material during our blackout periods.

dim already does that, fully automatically, it checks:

	git merge-base --is-ancestor $remote/$linux_next_fixes $remote/$linux_fixe=
s

which means:

- If -next-fixes is an ancestor of (or equal to) -fixes: feed for-linux-nex=
t
  from -next. This means -fixes has caught up with all of -next-fixes.

- Otherwise: feed it from -next-fixes, which contains changes that haven=E2=
=80=99t
  reached -fixes.

The only think maintainers need to do is push $tree-next-fixes to catch up =
with
$tree-next, which they need to do anyways.

IMO, this is more robust than relying on all maintainers freezing $tree-nex=
t at
exactly one global cutoff.
