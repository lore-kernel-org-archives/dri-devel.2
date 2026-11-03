Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A57E606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djIRgvsJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EE1B10F86C;
	Tue,  3 Nov 2026 21:04:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64DB910E1D8
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 21:04:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A922460136;
 Tue,  3 Nov 2026 21:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192231F000C1;
 Tue,  3 Nov 2026 21:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793739873;
 bh=jX4SDPUuSDvp9qViMsndjuML6aJlMfu5cI5xM9EiD1E=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=djIRgvsJLQZKty3ipIXbg9IiHMbuuEGpXPjxSyzC1f22murZNBx/Yj8PJbQLLtYie
 sJp0zl6g6KAc7PirHwHVzkPzCeERg77mXe+6eNmoYW0LsS73p7wD4nRzlXj8XNDOu/
 XYFmX6jCypeNDDD1He4FVkY7PFr79aYyOyTU+/x/AtRy/+GdgsxxKEjqEN8lxqgnwA
 iRnIyB5+JssrdyjS75n6/3YWHLXRmzah2MwFTLFmxqd3VudM8rXkFmp0X2o9fDg3uu
 lcccFg9c3yqBQu5NsSm1949kg01wImogH0pLQ6E7SziK2cCUeqikSG+HpLNCfLIuAI
 sdlFohZqri1QA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 22:04:28 +0100
Message-Id: <DMLVPRO7XF7F.21199FO61MFRD@kernel.org>
Cc: "Dave Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
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
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
References: <aujZcJBUyQ7iX_PM@intel.com>
 <DMKY979I29AF.BS1DF5YAZMOY@kernel.org> <aujikV14tF6K1Xqw@intel.com>
 <DMKZR0YZV1CX.DWVK9V47GR1J@kernel.org>
 <CAPM=9tww=CJdxzvfUvLwQ6V4uoszg8JrB1XCAcp15upM-xPvSg@mail.gmail.com>
 <DMLTRKUXTL3P.11VRVU1A8ERMG@kernel.org> <aupFKGpAwAiGXN0U@intel.com>
In-Reply-To: <aupFKGpAwAiGXN0U@intel.com>
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

On Tue Nov 3, 2026 at 9:33 PM CET, Rodrigo Vivi wrote:
> On Tue, Nov 03, 2026 at 08:32:48PM +0100, Danilo Krummrich wrote:
>> IOW, linux-next merges tip/for-linux-next, and tip/for-linux-next merges
>> $tree/for-linux-next, rather than $tree/$tree-next.
>
> For this to work we need:
> 1. xe to create for-linux-next for-linux-next-fixes
> 2. amd to create for-linux-next for-linux-next-fixes

Huh, I thought all the trees are doing this already. Well, that explains
where the the problem comes from. :)

In any case, drm-misc, drm-rust and drm-intel already have for-linux-next a=
nd
for-linux-next-fixes, and the implementation is generic. So, adding it to x=
e and
amd is trivial.

> 3. All maintainers to agree to move their -next-fixes on the same day tha=
t
> they are sending the last PR. Or have a new dim sub-command dim final-pr

That's what drm-misc, drm-rust and drm-intel promise, yes.

Something like dim request-pull --final seems like a reasonable helper to m=
e.

> 4. Instrument dim to have this secondary reconstructed tree instead of th=
e
> implemented chop.

I think for this part isn't different; tip/for-linux-next just merges one o=
r the
other.

> 5. Prepare every committer to deal with this extra build time and extra
> conflict resolution.

Which extra build time and conflict resolution? You have two tip trees in e=
ither
case, no? One that contains $tree/$tree-next and one that doesn't.

> I honestly prefer the simple chop solution. But it would be okay by me
> if you take the lead and implement the dim changes for this flow.

I don't mind doing this. :)

>> I.e. the ultimate source of what is linux-next material remains to be $t=
ree.
>>=20
>> In general, I think that this is more accurate and probably less error p=
rone
>
> I would argue the other way around.
>
> The reason that we are seeing so much escapes from next-next into linux-n=
ext
> might be exactly by the fact that the blackout right now depends on 2 sep=
arate
> actions to help simultaneously (last PR + rebase of -next-fixes). What mo=
st
> of us are not doing.

Interesting, why is that? It seems to work perfectly fine in drm-misc, drm-=
rust
and drm-intel.

The only thing maintainers need to do is push $tree-next to $tree-next-fixe=
s at
the cutoff. The rest is automatically handled by dim already.

>> For instance, let's say a tree closes (i.e. tags the last -next tag of t=
he
>> cycle) a few days before -rc6, it could happen that subsequent commits t=
o
>> $tree-next still appear in linux-next because tip still picks them up un=
til
>> after -rc6. So, after -rc6 those commits (that were in linux-next for a =
few
>> days) would disappear from linux-next again.
>>=20
>> Not that big of a deal, but technically they didn't even belong in linux=
-next
>> for only a few days.
>
> But well, this is a good catch and a bug on the current proposal indeed.
> Should we move that to -rc5 to -rc1? We just need to ensure that everyone
> have at least 1 PR after -rc5 and we are all aligned.
>
> The only caveat is that patches landing in drivers-next during -rc5/-rc6 =
will
> take a few days more to propagate, but it shouldn't be the end of the wor=
ld.
> It is still a couple weeks before the merge-window.
>
>>=20
>> If we kept $tree/for-linux-next, tip would never pick those commits up, =
because
>> a tree that closed a few days before -rc6 would already have switched
>> $tree/for-linux-next to $tree/$tree-next-fixes.
>
> Well, if you don't move your -next-fixes at the same time of your last PR
> you are leaking that as well. And this is happening.

Where is this happening?

> At least now we know why it is happening (besides xe and amd sending
> straight from -next instead of having the -for-linux-next branches).

I think if xe and amd would have those branches there'd not be a problem to
begin with.

But independent of that, I think it is nice to give the "fully merge confli=
ct
resolved thing" to Mark. :)
