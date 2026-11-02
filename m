Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD2606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i/6gflur
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5814A10F165;
	Mon,  2 Nov 2026 18:58:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D47510F15B
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 18:58:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 18E8842DB2;
 Mon,  2 Nov 2026 18:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DC41F00A16;
 Mon,  2 Nov 2026 18:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793645901;
 bh=PqIXqjgnM8/paxcRb4ZO0roh+rl6Un/oWXZwqQspqlM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=i/6gflurSQgWurTrLOkjByc2ij5T83zOhIv5zDBkfKu3kgRos7aFuUUG5aii3q5Y7
 ZSrHljoeZtNaS545iWzCAV+Pj8uihNeb2W1y+HsJnXNtPoEbMp+RcAAH9H2esoLniH
 FLF3IH9ca8SWsbBDeAMj3sHcNXDsm9BxWR6m92UEAbnE9Vk3xhXMBpuDbmdYkns9oT
 iIKqLgQXVpkR+0pCseVhixkkP29NoA2bW5yelXM5Ps74aIM+IRjLhndba6vcfegCsD
 K+SwlnjBU2ynwPgcL1a4jenvm3pj2vvz1DVt37pmN+9nSDoBFmhsuoolbuCTGwucvy
 zH2WZ/In+XavA==
Date: Mon, 2 Nov 2026 18:58:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-next@vger.kernel.org
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
Message-ID: <eeeddbdc-8683-46ef-b8a2-64563dcdd9c8@sirena.org.uk>
References: <aujZcJBUyQ7iX_PM@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LFcTm9mm7q7eaQ2q"
Content-Disposition: inline
In-Reply-To: <aujZcJBUyQ7iX_PM@intel.com>
X-Cookie: Used with permission.
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


--LFcTm9mm7q7eaQ2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 02, 2026 at 01:41:52PM -0500, Rodrigo Vivi wrote:

> We'd like to replace most of the DRM trees in linux-next with a single
> branch:

>   https://gitlab.freedesktop.org/drm/tip.git#drm-for-linux-next

Thanks, I really appreciate this!

> drm-exynos, drm-msm, drm-msm-fixes, drm-msm-lumag, drm-nova and etnaviv
> are not part of it and stay as they are.

Those are all fairly quiet anyway, and if they do get rolled in it's
easy enough to make the updates.  Your rollup includes all the frequent
fliers.

> During this work, I realized that drm-xe is a big culprit for leaking
> future work without a blackout date from -rc6 to <next>-rc1.
> So, another quick solution would be to get a drm-xe for-linux-next like
> the other domains are doing. However, I still believe that this unified
> one will make Mark's life much easier anyway.

Yeah, drm-xe and amdgpu were the biggest non-rebasing sources of commits
in -next that don't get merged this time around - I actually just
mentioned this in my "here's what's going on" mail to Linus a few
minutes ago.  Their numbers were:

  96	amdgpu
  84	drm-xe

> Mark, you're in Cc for visibility only. Once we have all the acks, I'll
> send you the formal request. After linux-next switches, we stop
> updating the old for-linux-next* branches (patch below).

I'll wait for a separate mail.

--LFcTm9mm7q7eaQ2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmro3UYACgkQJNaLcl1U
h9BlXwf/X5CLvA+oEE1JwQc0inKw4V1OwDDgdKzpRyO3PA6qk4WHx6NfFYos2FOT
M/pSMUEsEGRCKAX5/pc15/8EzU5pViqRW9f155piL411th3QNrhmlbI4sF6I7wl+
U+GZdfIyr2oLcGlqn0sq4Ta3G/CHzDx00oWn3qInp4y0kQFAv2GOMMY9VI/x3ltP
lzyFNOV0sYidED3vmrfSsxGRwoFJjUDQfBjZHevRSostJ4oS2Cspx7SMkbnz5jPf
TE77AdEE268NzuP1MCqalSJRNcrNnn3juOltlHN88noH3up6A/1+OKB7fv3hUICU
gJAbfwmUTpUcRhL0kiWaTBb99D4M/g==
=jV2m
-----END PGP SIGNATURE-----

--LFcTm9mm7q7eaQ2q--
