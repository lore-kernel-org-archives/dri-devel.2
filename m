Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5A2606AB15
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hm4CXr0O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B1710FF6E;
	Wed,  4 Nov 2026 22:35:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F5610FF6F
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 22:35:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 88BBB601F7;
 Wed,  4 Nov 2026 22:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2381F00919;
 Wed,  4 Nov 2026 22:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793831715;
 bh=b9rrLA8vq8kbHeVnEqzwo8GkMq00BCC6WSP2R9K6GIE=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=hm4CXr0OyEQEjl3Ky4AWo+pbM6UTltNrHiK6EI89KbmvbVrNOL4RXVaMf8hq3QKzH
 vJfaoRF8WO0NFEPiE938aeWdOSGhtoP0iPGxk0QnVuJOZnPFWSeujv79GoW8yq7nzA
 bwZGIdDrWpsi2rNQfNUUq7KBPEJa6mjxRP3Ti1Lb1kPInEIRXC5MovL1V2ZxDkI8TW
 Vk7jsvOCB9JKZwwB54aXKwOPH9vHhKpb/Gr6SVdBDkd419gcGD0r2qVu7+ed1YQf/a
 QUmvX8qb2/KzD9ZQiQePwcgz3gwv4FWIteFajzfa8BqDBMMpe6tu6PAE2HhVR4ezsj
 peRtOdzGwikcg==
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 23:35:10 +0100
Message-Id: <DMMS9R5JJ4ME.TBIB1TNLB3IP@kernel.org>
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
Cc: "Dave Airlie" <airlied@gmail.com>, "Alex Deucher"
 <alexdeucher@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Jani
 Nikula" <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Tvrtko Ursulin" <tursulin@ursulin.net>,
 "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Alex Deucher"
 <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>, "Mark Brown"
 <broonie@kernel.org>, <linux-next@vger.kernel.org>
To: "Rodrigo Vivi" <rodrigo.vivi@intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <CAPM=9tww=CJdxzvfUvLwQ6V4uoszg8JrB1XCAcp15upM-xPvSg@mail.gmail.com>
 <DMLTRKUXTL3P.11VRVU1A8ERMG@kernel.org> <aupFKGpAwAiGXN0U@intel.com>
 <DMLVPRO7XF7F.21199FO61MFRD@kernel.org>
 <CADnq5_N-6_T8EnihjoTSqpHGb_mZPogi6z=Ti-7_oue5d07oTw@mail.gmail.com>
 <aupktBCwcN_coHEH@intel.com> <DMLY7GDT8VBO.EE1P01ZX2HPK@kernel.org>
 <auqaZdocMvOIxN1c@intel.com>
 <CAPM=9tzu6MYQ-Y0iYK=2PLiM5=1BsEN+Q5WnmYh=hkKnLJ4b1Q@mail.gmail.com>
 <DMMDNQ0GD6AP.6HPRG6JWUEYQ@kernel.org> <autvCxZuSCxFjtgr@intel.com>
In-Reply-To: <autvCxZuSCxFjtgr@intel.com>
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

On Wed Nov 4, 2026 at 6:44 PM CET, Rodrigo Vivi wrote:
> On Wed, Nov 04, 2026 at 12:08:08PM +0100, Danilo Krummrich wrote:
>> On Wed Nov 4, 2026 at 4:29 AM CET, Dave Airlie wrote:
>> > Yes this is the thing I like, while I like maintainers having freedom,
>> > relying on them to do something manually every release at the same
>> > time doesn't seem to scale so well.
>>=20
>> I think maintainers have to do something manually every release in both =
cases.
>>=20
>> The difference is between "everyone has to do it at the exact cutoff day=
" vs.
>> "everyone has to fast-forward their -next-fixes branch" (which to be fai=
r has to
>> be done in both cases).
>>=20
>> For the former, a tree that closes before the global cutoff can still le=
ak
>> following-cycle work into linux-next.
>
> On that I already agreed that we should move the blackout from -rc6 to -r=
c5.
> So, the only thing that every maintainer needs to ensure is to prepare,
> at least, one PR after -rc5 and we won't have absolutely any leak.
>
> And I believe we are all already doing this anyway, so again, there won't=
 be any
> special thing that maintainers would need to do to ensure correctness.

It doesn't change the fundamental problem if we define the global cutoff so=
oner
or later.

To preserve both properties, each tree's transition would have to coincide =
with
the global cutoff., otherwise it can happen that either stuff leaks into
linux-next that doesn't belong there (tree state updated before cutoff), or
you're not getting linux-next exposure in the first place (tree state updat=
ed
after cutoff).

Making the cutoff day sooner makes it much more unlikely to leak stuff into
linux-next, as closing a tree before -rc5 would be pretty odd.

But that trades the leakage risk for patches added after -rc5 losing linux-=
next
exposure until they reach drm-next. That may be preferable, but it still lo=
ses
intended linux-next coverage.

In a normal cycle this would mean that trees collect up to a full week of
patches without them seeing linux-next, which is a concern for me as well.

More generally it remains that correctness is based on a timing promise abo=
ut
the tree state rather than the tree state itself (which is the actual sourc=
e of
truth).

I don't see why we would want to make this kind of compromise where we prev=
ent
intended linux-next exposure for up to a week, while the existing per-tree
selection logic in dim we have today can preserve both properties:
following-cycle work stays out of linux-next, and work for the upcoming mer=
ge
window gets linux-next exposure before entering drm-next.

To me a fixed global cutoff in tip comes down to either one of the two:

  (1) Make a compromise where e.g. patches that belong in linux-next get up=
 to a
      week delayed exposure.

  (2) Require each tree's transition to following-cycle work to coincide wi=
th
      the global cutoff, in *addition* to managing its branches correctly.

>> I.e. the global switch is automatic, but doesn't ensure correctness by i=
tself.
>> In order to be correct, maintainers have to do something manually.
>>=20
>> So eventually it comes down to whether doing the correct thing derives f=
rom an
>> explicit operation (i.e. fast-forward -next-fixes, or just add the --fin=
al
>> helper), or an implicit commitment to push and tag branches on a specifi=
c day.
>>=20
>> I think it is better to derive the tree status from its actual state rat=
her than
>> a promise about that state at a specified cutoff day.
>>=20
>> > If we can't have the tool enforce what we send to -next after -rc6
>> > then it's going to have gaps.
>>=20
>> I don't think either option can enforce correctness. The difference is t=
hat one
>> approach relies on a timing promise about the tree state, while the othe=
r uses
>> the tree state itself to make the decision.

