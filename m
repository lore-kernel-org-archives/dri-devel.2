Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F226606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SuNU9844
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 657A210E149;
	Mon,  2 Nov 2026 20:01:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A367710F1CB
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 20:01:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5F83F43DEE;
 Mon,  2 Nov 2026 20:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1F21F00A16;
 Mon,  2 Nov 2026 20:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793649696;
 bh=RJYRwDLxOAqByMkWCFUQlONmwYPl4Hw9XG8zdhfVq08=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=SuNU9844wpdybe1sCRbvxPneKyTqJAElJfloJfpL/l9Tn485SCPSEB1TzxK8qnHfY
 IxMHh1AOajrdWxSznm9SLdT1Gmg8N/LChuJQE0cNIrRqMADDQGH4mcb6afAYLOFrkE
 r8Yr70XvBgbab4htfICxqwAR/S5VDY/R7qd+QzZNvkRk64fGTAZS5MBKvCqs2d0kmu
 yt//ZwxnijAHQIvLEvpYoksUIIaWZ8lAHdnEkgf2JfRAMIdc9/yepFSkq00Pb+18Ac
 uNNKpIVLoX5JZTKDv27AYGbBfvWB7nEoOeymJtSE2SG5VwL8FCq7JM5GY5UMxLa+Ra
 blKfE32l8VG5w==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 21:01:31 +0100
Message-Id: <DMKZR0YZV1CX.DWVK9V47GR1J@kernel.org>
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
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
References: <aujZcJBUyQ7iX_PM@intel.com>
 <DMKY979I29AF.BS1DF5YAZMOY@kernel.org> <aujikV14tF6K1Xqw@intel.com>
In-Reply-To: <aujikV14tF6K1Xqw@intel.com>
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

On Mon Nov 2, 2026 at 8:20 PM CET, Rodrigo Vivi wrote:
> not exactly... The per-tree check goes away and there's one global rule:
> the driver -next branches are left out from Linus' -rc6 until -rc1.
> But this is the cutoff the drm-rust docs already describe and used by eve=
ryone
> anyway.

As a general rule that's correct, but in practice we have been leaving -nex=
t
open for a bit longer (with the last PR at -rc7, depending on what's contai=
ned),
as it sometimes helps with cross-tree coordination for interactions with ot=
her
trees while we're still ramping up Rust infrastructure throughout the kerne=
l.

The Nova vGPU parts are getting closer to something that can be used in
production, but it still remains that it is useful to retain some flexibili=
ty as
we will keep having some more cross tree dependencies for a while.

> So, the maintainers are still in control on when their -next is closed. B=
ut that
> is their last PR. around -rc5/-rc6. And if they need extra PRs after that=
, it
> is also fine, because drm/drm-next is still feeding this unified for-next=
.

For a late PR that leaves a gap for stuff landing in -next and only ever hi=
tting
linux-next *after* it has been merged in drm/drm-next. Exposure to linux-ne=
xt
should however be a prerequisite for making it into drm/drm-next.

So, I think maintainers would have to commit to strictly close with -rc6 to
avoid such a situation.

> IOW, when you fast-forward drm-rust-next-fixes at your cutoff, that conte=
nt stays
> in linux-next whenever you do it. The only difference is that drm-rust-ne=
xt
> itself stops at -rc6, not when you fast-forward.

Sure, but that'd mean -next PR a few days after -rc6 would need to originat=
e
from -next-fixes in order to get linux-next exposure. Thus, with this appro=
ach
it just boils down to "no flexibility on this".

Can't we just keep the per-tree for-linux-next branches and just merge them=
 into
tip/for-linux-next?

for-linux-next-fixes could of course be removed as it always follows -fixes
anyways.
