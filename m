Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975F8606A32E
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8e9UgiF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD60710E6BE;
	Mon,  2 Nov 2026 18:51:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D86A10E6BE
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 18:51:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 695226053A;
 Mon,  2 Nov 2026 18:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B5D1F00A17;
 Mon,  2 Nov 2026 18:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793645478;
 bh=otXeKG6/gRRVfdqsTiK4DIFWyfU/stsI1BzcXuDzzyo=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=T8e9UgiFwdH6mxjIKF0JFIdqmskIpM26NiN2xPXdEp8Lt++6ltlhiWTXkrLr0UxgG
 EoFPlz4BHgbtx3aZPyPcK9+dK8xmrk8zIl9IM/+9iMg1psdbDySeKULyTtlD8ObXIC
 hjoLhX2P+n1KRlHo4ZTXdAt4qXNXgikreECS/G7mRrwp2TtfbCOk0l0CHPUmZTulQ1
 o6an0XahklNEV+Ea9qEwgJXBMmliOcPe+h4WwoYH5rEcAVUAmfMatHBB4AUfH7Wydp
 65Z8Kuw1PG7EYHyUTwOREIQ/RUg/CWq4Pgezthn9qD65Z3HygAYRyWaahNhmFNB5TI
 uR9qLnvaUMYaA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 19:51:13 +0100
Message-Id: <DMKY979I29AF.BS1DF5YAZMOY@kernel.org>
To: "Rodrigo Vivi" <rodrigo.vivi@intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
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
References: <aujZcJBUyQ7iX_PM@intel.com>
In-Reply-To: <aujZcJBUyQ7iX_PM@intel.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 2, 2026 at 7:41 PM CET, Rodrigo Vivi wrote:
> Hi folks,
>
> We'd like to replace most of the DRM trees in linux-next with a single
> branch:
>
>   https://gitlab.freedesktop.org/drm/tip.git#drm-for-linux-next
>
> It replaces these entries:
>
>   drm/drm-next, drm/drm-fixes
>   drm-misc/for-linux-next, drm-misc/for-linux-next-fixes
>   drm-intel/for-linux-next, drm-intel/for-linux-next-fixes
>   drm-xe/drm-xe-next
>   drm-rust/for-linux-next, drm-rust/for-linux-next-fixes
>   amdgpu (agd5f/linux.git#drm-next)
>
> drm-exynos, drm-msm, drm-msm-fixes, drm-msm-lumag, drm-nova and etnaviv
> are not part of it and stay as they are.
>
> The main reason is to reduce the conflict pain that Mark constantly faces=
.
> All of them should be handled already when we are rebuilding drm-tip.
>
> During this work, I realized that drm-xe is a big culprit for leaking
> future work without a blackout date from -rc6 to <next>-rc1.
> So, another quick solution would be to get a drm-xe for-linux-next like
> the other domains are doing. However, I still believe that this unified
> one will make Mark's life much easier anyway.
>
> The unified branch is rebuilt by dim together with drm-tip. It has all th=
e DRM
> -fixes, drm-next, -next-fixes and driver -next branches merged, with
> the conflicts between them already resolved on our side. From -rc6
> until -rc1 (per Linus' tree) the driver -next branches are left out, so
> nothing for the following merge window lands early.

Seems reasonable; I assume the logic for individual trees would remain? I.e=
.
-next goes into tip/for-linux-next until -next-fixes is fast forwarded? IOW=
,
trees keep control over when exactly -next closes for the upcoming merge wi=
ndow?
