Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74782606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LMCqPm3U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB860112A6A;
	Fri, 27 Nov 2026 11:54:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 046A6112A59;
 Fri, 27 Nov 2026 11:53:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 018E7627A0;
 Fri, 27 Nov 2026 11:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598EC1F00893;
 Fri, 27 Nov 2026 11:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795780432;
 bh=6tFmyAKl3TXYw7GdISc3v4tvYWnA4KFaP0LI5fdW8KM=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=LMCqPm3UyC6hhDjz1bVyrTScq6Cuy8LxDb8t6owUObO91YVDVBbRaNyWduk1hyDDl
 JP/wmYEU6R4xmV3mB8O/j3oW01CX6jsaqTizKQS/z+B0A9jTMhXA8WcLuBpcVwBE5s
 qAnLqkACrQ0LAoIOh/iqyBiFzTxEwbNqRJou09sjiVxPIus3dksSH5/ZweC5wTR1iH
 uvYGD9phpxvFwnju9TuAFcvZO3QggLw8CbZQGRoOHh6V4lkgNv4XRgcx8owWFMSzrL
 rFu8AjVkkTA7m9oBGhok2ZfcuF7UwsfGMJa6w/JCN0O9I8vh0FLkAgxkT/w+0juqiO
 S6OoKvop9IyHA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 12:53:42 +0100
Message-Id: <DN5Z15CLM3L7.2469NKSE6ASED@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 0/3] dma-fence: Properly order timestamps
Cc: <phasta@kernel.org>, "Sumit Semwal" <sumit.semwal@linaro.org>,
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
To: "Philipp Stanner" <phasta@mailbox.org>
References: <20261126172046.2473303-2-phasta@kernel.org>
 <DN5YMFCMLL2E.3LMY2Z5ZQAYFG@kernel.org>
 <b6b75395da594c4bf8deb1daaf857854565c66cd.camel@mailbox.org>
In-Reply-To: <b6b75395da594c4bf8deb1daaf857854565c66cd.camel@mailbox.org>
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

On Fri Nov 27, 2026 at 12:43 PM CET, Philipp Stanner wrote:
> On Fri, 2026-11-27 at 12:34 +0100, Danilo Krummrich wrote:
> What do you mean with that, like not backporting it?

No, the issue should be addressed in stable kernels as well, but that is
different from providing a temporary hotfix.

There's usually no reason to send a hotfix for -rc6 (this would be earliest=
 the
patches can reach Linus's tree) for a long standing issue that was never
reported to cause a real bug.

If the proper solution can't be backported to stable trees for some reason,=
 then
a separate fix for stable makes sense.
