Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D70A606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5NSuymV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A1FC112A4D;
	Fri, 27 Nov 2026 11:45:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B39A810E9D3;
 Fri, 27 Nov 2026 11:45:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 66AAF40352;
 Fri, 27 Nov 2026 11:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941A21F00893;
 Fri, 27 Nov 2026 11:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795779906;
 bh=IM/zWShc0hYOKqUKcrt/IAaGmyLjPyaK1b5adG9uu4c=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=Z5NSuymVw5Gx0vQuodvEF+/eMvg4ArrUnitEiUYv6xsS9yL3d2UC29zzE7ZA3oTXe
 l4gui5m3Nq813ghQl5Z7lj/4pblaO/FWce9LvKE74JCZY4sX+F61eWCy5HtTkCQ39d
 o2SWbHE1YGK5QQGhn0ecF8tqXkEF3aOm2JQO/VMzFF4eAdjkV9oJq+VY6VUOW1hmgS
 rDp7qKwjl+moi668DGx1JMVBIjqFCEEF2ZtbXgdmUXsAIfBscPFMko1+XsWEdpvCF+
 KGQr3k0MdJHySAnLWbRyK5JIW3wtQdvv4B5Q87drvODspN/u8xaKPQ4Vg3JBCXtnp8
 Tg6IM3979dcrA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 12:45:00 +0100
Message-Id: <DN5YUHBCE0HD.NVOQNS6BD9WQ@kernel.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: Hot-fix timestamp misordering
Cc: <phasta@kernel.org>, "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 "Sumit Semwal" <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Alex Deucher" <alexander.deucher@amd.com>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Matthew Brost" <matthew.brost@intel.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Mario Limonciello (AMD)"
 <superm1@kernel.org>, "Aurabindo Pillai" <aurabindo.pillai@amd.com>,
 "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>, "Gustavo
 Padovan" <gustavo.padovan@collabora.com>, "Chris Wilson"
 <chris@chris-wilson.co.uk>, "Luben Tuikov" <ltuikov89@gmail.com>, "Shashank
 Sharma" <shashank.sharma@amd.com>, "Paul E . McKenney"
 <paulmck@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <stable@vger.kernel.org>
To: "Philipp Stanner" <phasta@mailbox.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261126172046.2473303-2-phasta@kernel.org>
 <20261126172046.2473303-5-phasta@kernel.org>
 <71b2506f-8534-468e-881d-1abf8f8224d9@igalia.com>
 <69845631bb184d86b4af8b4143b3b7adf726e0ca.camel@mailbox.org>
In-Reply-To: <69845631bb184d86b4af8b4143b3b7adf726e0ca.camel@mailbox.org>
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

On Fri Nov 27, 2026 at 11:30 AM CET, Philipp Stanner wrote:
> Reason would be that amdgpu only ever runs on x86

I think nothing prevents plugging an AMD card into a system with a weakly
ordered architecture using amdgpu.
