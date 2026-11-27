Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8321606A326
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJOdUt8f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08B9E1128B6;
	Fri, 27 Nov 2026 11:34:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB111128B6;
 Fri, 27 Nov 2026 11:34:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D45641669;
 Fri, 27 Nov 2026 11:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E0D1F00899;
 Fri, 27 Nov 2026 11:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795779274;
 bh=+TtWQm0Jbb5pA7zQRAqTD0mcWKi7bUWXYCnzVEumBoQ=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=RJOdUt8fsxedUj1n7Y8VN2eISd2hcoyKKn9lbvemBW7cFtbJ6GNosOj4rVAh0xYwB
 ni66oMVmp7kWjavz3k4GsoTZ/z7Ocf2rvdVTKdQoVqIEi/0H7jpIsrMxQJcUGr3e8Z
 D9v6+sjWR7WddwPfmc7n7qDOQCpYl1WzgwsCLz2JmJMO+RRQlAUmVnhUh+qVXvW0k3
 ULADG47FUAlhOGp7pTieQyBsq+hKcDoZ1Nat6uEYf9d3+j7co5BxA/1fA1Bsw9HSGh
 Tle8wYM4s4TIN4kJe/gDKJHVKRZ1bSnB7/92fao2BoK4UziqVa2GTLQhrDijVXrV71
 wNjdUY1JOImew==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 12:34:29 +0100
Message-Id: <DN5YMFCMLL2E.3LMY2Z5ZQAYFG@kernel.org>
Subject: Re: [PATCH 0/3] dma-fence: Properly order timestamps
Cc: "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Alex Deucher"
 <alexander.deucher@amd.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Matthew Brost" <matthew.brost@intel.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Tvrtko
 Ursulin" <tvrtko.ursulin@igalia.com>, "Mario Limonciello (AMD)"
 <superm1@kernel.org>, "Aurabindo Pillai" <aurabindo.pillai@amd.com>,
 "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>, "Gustavo
 Padovan" <gustavo.padovan@collabora.com>, "Chris Wilson"
 <chris@chris-wilson.co.uk>, "Luben Tuikov" <ltuikov89@gmail.com>, "Shashank
 Sharma" <shashank.sharma@amd.com>, "Paul E . McKenney"
 <paulmck@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>
To: "Philipp Stanner" <phasta@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261126172046.2473303-2-phasta@kernel.org>
In-Reply-To: <20261126172046.2473303-2-phasta@kernel.org>
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

On Thu Nov 26, 2026 at 6:20 PM CET, Philipp Stanner wrote:
> I propose stuffing these hotfixes into the stable kernel / misc-fixes
> while we move on on misc-next with a more proper solution. I'll post a
> series for that soonish, too.

"Hotfix" kind of implies that it causes serious issues for "live" users.

One of the patches says "fence timestamps can be written and read without a=
ny
memory ordering since, presumably, forever."

What has changed that this now became an issue that needs a hotfix? Do we h=
ave
broken users?

If so, it would be good link a report if there's one publicly available.
Otherwise, I'd suggest to just go ahead with the proper solution you work o=
n.

Thanks,
Danilo
