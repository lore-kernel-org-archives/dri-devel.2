Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FB7606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iirwKghM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 612F710E1D4;
	Wed,  4 Nov 2026 12:46:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2310A10E1D4
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 12:46:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 138D7612D8;
 Wed,  4 Nov 2026 12:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BEE1F000C1;
 Wed,  4 Nov 2026 12:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793796364;
 bh=PFEBhpVkx/Db8FKRqQ1f85p8DYST/pInzrhzPSOP1ko=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iirwKghMMMh85yOn9eMgrtze/QVFlkbamubxCg5KXK9uIiE1xxZkFy3spIr9QXM00
 me/JMZv1X13+X32IwTbGLy0yRlrLX2QZ6uTUB4aIpHpiAf8e4QAjKi/7eZSHXH8AqP
 kjBT4yuLGNXCODj1eVe+1wAZqYYQz7qExZfH+SEyjf+8umNgHoh1s/jdGeil4W9p9T
 Q5AueLgnrVkMw0bqofKC/zJ9+oxC5JncAqIr3Q9Sy0lmUQy2KNSM/s1ca83C36OpZq
 Jxs/ryagZN9leSZ5n7M/mX0dR0jrHdHigb+cJWn7zBm91YQjiPMl+XrxV4OCVIbsTW
 IvgWW2yoYnUtg==
Date: Wed, 4 Nov 2026 07:46:03 -0500
From: Sasha Levin <sashal@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, Dave Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
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
 dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
 linux-next@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [RFC] linux-next: replace the DRM trees with a single
 drm-for-linux-next
Message-ID: <auspCwOuROyorRnv@laps>
References: <aujZcJBUyQ7iX_PM@intel.com>
 <e14e582e-d9d1-4c95-a23e-cf1e6f2feabd@leemhuis.info>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e14e582e-d9d1-4c95-a23e-cf1e6f2feabd@leemhuis.info>
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

On Wed, Nov 04, 2026 at 06:49:29AM +0100, Thorsten Leemhuis wrote:
>On 11/2/26 19:41, Rodrigo Vivi wrote:
>>
>> We'd like to replace most of the DRM trees in linux-next with a single
>> branch:
>>
>>   https://gitlab.freedesktop.org/drm/tip.git#drm-for-linux-next
>>
>> It replaces these entries:
>>
>>   drm/drm-next, drm/drm-fixes
>>   drm-misc/for-linux-next, drm-misc/for-linux-next-fixes
>>   drm-intel/for-linux-next, drm-intel/for-linux-next-fixes
>>   drm-xe/drm-xe-next
>>   drm-rust/for-linux-next, drm-rust/for-linux-next-fixes
>>   amdgpu (agd5f/linux.git#drm-next)
>>
>> drm-exynos, drm-msm, drm-msm-fixes, drm-msm-lumag, drm-nova and etnaviv
>> are not part of it and stay as they are.
>>
>> The main reason is to reduce the conflict pain that Mark constantly faces.
>> All of them should be handled already when we are rebuilding drm-tip.> [...]
>
>Please correct me if I'm wrong: this seems to mix up patches for the
>current cycle (e.g., -fixes branches) with those for the next one -- so
>I assume the former won't end up in next/pending-fixes anymore?
>
>Do we care? Or is this a situation along the lines of "yeah, that's a
>downside of this, but given the upsides, we do this nevertheless"?
>
>For my work it was kind of nice to have the two tracks separated, as it
>allowed me to easily check "is this fix for a recent regression in
>pending-fixes, as it should, because it should be fixed this cycle".
>
>Side note: two years ago there was also the idea to increase testing of
>pending-fixes or branches feeding into it separately, but it afaics got
>no real traction:
>
>linus-next: improving functional testing for to-be-merged pull requests
>https://lore.kernel.org/all/ZyI-Y00J3DBUkon3@sashalap/

This is actually still happening today, just evolved a bit!

I have a tree similar to linux-next, but it's fully automated, using LLMs for
conflict resolutions, and generated a few times a day:

https://git.kernel.org/pub/scm/linux/kernel/git/sashal/linux-next.git/

Instead of just a single tree, it builds the tree with categories, grouping
them into "%s-next" trees for easier testing by subsystem or theme, and later
merges them all into the one big "all-next" branch.

The equivalent of the auto-pending-fixes branch you mentioned would be the
"fixes-next" branch, and for the drm folks it would be the "drm-next" branch.

This whole thing is still being very much used today, finding real problems :)

-- 
Thanks,
Sasha
