Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D72606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eiyvllqy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD1A11298B;
	Thu,  5 Nov 2026 23:27:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE63211298B
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 23:27:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8BE1660147;
 Thu,  5 Nov 2026 23:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4441F0089F;
 Thu,  5 Nov 2026 23:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793921247;
 bh=AEz8pNkGHn83+fF/VrrN7CKbHTIruuNUNYYmRjTOgOI=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=eiyvllqy8agcumJJnreFDSEgniRILOnQrFKKjJP+i+Z4Jb0U3c7/gfXhsU1hcgeMX
 En3VdThZH6mE1r9PgyjOAlXz8H76u1EBVwd5gJNmNs1rXi7ahxEPbo8g8dSiBencEq
 GKQln7vsLQYp0e7VDyc1NZ5dDjjSODxl2TLC28GQ/eNjxKmEvI3htdFcfVyR1tA0L5
 aKPVwPtK35p0eVZ6P7o2d/lh/fSWiO+0jZdKapU+zuJ3fjj48FozaTMEzg46nQ8sSu
 b0iXlV0bUHBXI03b81WcYyCQ95XJTtaQFqo3m1RBJtjdhRzdibDTgxi20jlqs40uKV
 vgSLnBSOWMIYw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 00:27:22 +0100
Message-Id: <DMNO09PAED4M.34GSWNA0Q55E1@kernel.org>
To: "Rodrigo Vivi" <rodrigo.vivi@intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
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
References: <aupFKGpAwAiGXN0U@intel.com>
 <DMLVPRO7XF7F.21199FO61MFRD@kernel.org>
 <CADnq5_N-6_T8EnihjoTSqpHGb_mZPogi6z=Ti-7_oue5d07oTw@mail.gmail.com>
 <aupktBCwcN_coHEH@intel.com> <DMLY7GDT8VBO.EE1P01ZX2HPK@kernel.org>
 <auqaZdocMvOIxN1c@intel.com>
 <CAPM=9tzu6MYQ-Y0iYK=2PLiM5=1BsEN+Q5WnmYh=hkKnLJ4b1Q@mail.gmail.com>
 <DMMDNQ0GD6AP.6HPRG6JWUEYQ@kernel.org> <autvCxZuSCxFjtgr@intel.com>
 <DMMS9R5JJ4ME.TBIB1TNLB3IP@kernel.org> <auz6sKjP98m3IoG3@intel.com>
In-Reply-To: <auz6sKjP98m3IoG3@intel.com>
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

On Thu Nov 5, 2026 at 10:52 PM CET, Rodrigo Vivi wrote:
> On Wed, Nov 04, 2026 at 11:35:10PM +0100, Danilo Krummrich wrote:
>> On Wed Nov 4, 2026 at 6:44 PM CET, Rodrigo Vivi wrote:
>> > On Wed, Nov 04, 2026 at 12:08:08PM +0100, Danilo Krummrich wrote:
>> >> On Wed Nov 4, 2026 at 4:29 AM CET, Dave Airlie wrote:
>> >> > Yes this is the thing I like, while I like maintainers having freed=
om,
>> >> > relying on them to do something manually every release at the same
>> >> > time doesn't seem to scale so well.
>> >>=20
>> >> I think maintainers have to do something manually every release in bo=
th cases.
>> >>=20
>> >> The difference is between "everyone has to do it at the exact cutoff =
day" vs.
>> >> "everyone has to fast-forward their -next-fixes branch" (which to be =
fair has to
>> >> be done in both cases).
>> >>=20
>> >> For the former, a tree that closes before the global cutoff can still=
 leak
>> >> following-cycle work into linux-next.
>> >
>> > On that I already agreed that we should move the blackout from -rc6 to=
 -rc5.
>> > So, the only thing that every maintainer needs to ensure is to prepare=
,
>> > at least, one PR after -rc5 and we won't have absolutely any leak.
>> >
>> > And I believe we are all already doing this anyway, so again, there wo=
n't be any
>> > special thing that maintainers would need to do to ensure correctness.
>>=20
>> It doesn't change the fundamental problem if we define the global cutoff=
 sooner
>> or later.
>>=20
>> To preserve both properties, each tree's transition would have to coinci=
de with
>> the global cutoff., otherwise it can happen that either stuff leaks into
>> linux-next that doesn't belong there (tree state updated before cutoff),=
 or
>> you're not getting linux-next exposure in the first place (tree state up=
dated
>> after cutoff).
>>=20
>> Making the cutoff day sooner makes it much more unlikely to leak stuff i=
nto
>> linux-next, as closing a tree before -rc5 would be pretty odd.
>>=20
>> But that trades the leakage risk for patches added after -rc5 losing lin=
ux-next
>> exposure until they reach drm-next. That may be preferable, but it still=
 loses
>> intended linux-next coverage.
>>=20
>> In a normal cycle this would mean that trees collect up to a full week o=
f
>> patches without them seeing linux-next, which is a concern for me as wel=
l.
>>=20
>> More generally it remains that correctness is based on a timing promise =
about
>> the tree state rather than the tree state itself (which is the actual so=
urce of
>> truth).
>
> The current way is already a 'timing promise'. Multiple promises in a mat=
ter of
> fact. promise that you will send the PR around -rc5, -rc6 anyway + promis=
e that
> you will update your -next-fixes so the current fragile blackout check wo=
rks.

Of course one still wants to send the final PR somewhen around -rc5/-rc6, b=
ut
there's no exact point of time where the corresponding tree management has =
to be
done in order for the correct thing to happen for linux-next.

I don't agree that the the update of -next-fixes is fragile. It has to be f=
ast
forwarded to -next anyway with the cutoff, as otherwise people can't apply =
fixes
for what's staged for the merge window anymore.

If we'd cut off but not update -next-fixes accordingly, it's an invitation =
for
committers to keep pushing to -next kicking of the cherry-picks.

I also think this works very well for drm-misc (and drm-rust).

>> I don't see why we would want to make this kind of compromise where we p=
revent
>> intended linux-next exposure for up to a week, while the existing per-tr=
ee
>> selection logic in dim we have today can preserve both properties:
>> following-cycle work stays out of linux-next, and work for the upcoming =
merge
>> window gets linux-next exposure before entering drm-next.
>>=20
>> To me a fixed global cutoff in tip comes down to either one of the two:
>>=20
>>   (1) Make a compromise where e.g. patches that belong in linux-next get=
 up to a
>>       week delayed exposure.
>
> I really fail to see how this is a issue...

Because it means less exposure to linux-next overall and less exposure wher=
e it
actually matters, at the end of the cycle.

It also means that if something breaks in linux-next during this period the=
 only
way to fix it is to 1. send another -next PR, 2. wait until the tree closes=
 and
push the fix to -next-fixes, 3. close the tree immediately and push the fix=
 to
-next-fixes.

> But anyway, as I told, please provide the patches to dim for the unified =
tree
> with a more reliable way to guarantee our promises and let's take from th=
ere.

Sure, I'm happy to look into this.

>>=20
>>   (2) Require each tree's transition to following-cycle work to coincide=
 with
>>       the global cutoff, in *addition* to managing its branches correctl=
y.
>>=20
>> >> I.e. the global switch is automatic, but doesn't ensure correctness b=
y itself.
>> >> In order to be correct, maintainers have to do something manually.
>> >>=20
>> >> So eventually it comes down to whether doing the correct thing derive=
s from an
>> >> explicit operation (i.e. fast-forward -next-fixes, or just add the --=
final
>> >> helper), or an implicit commitment to push and tag branches on a spec=
ific day.
>> >>=20
>> >> I think it is better to derive the tree status from its actual state =
rather than
>> >> a promise about that state at a specified cutoff day.
>> >>=20
>> >> > If we can't have the tool enforce what we send to -next after -rc6
>> >> > then it's going to have gaps.
>> >>=20
>> >> I don't think either option can enforce correctness. The difference i=
s that one
>> >> approach relies on a timing promise about the tree state, while the o=
ther uses
>> >> the tree state itself to make the decision.
>>=20

