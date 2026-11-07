Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B8D606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 01:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QrABO07D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A943810E2E9;
	Sat,  7 Nov 2026 01:38:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B324610E2E9
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 01:38:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B4B6A60E03;
 Sat,  7 Nov 2026 01:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4551F0089F;
 Sat,  7 Nov 2026 01:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794015519;
 bh=3DKMi402lRON4IQ5GMfyj9glYZKcgZcGdIr3Q4HZEFQ=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=QrABO07D0LJYx0EiYqliUdb+bqI5sTgUqIBG6/ohJuuivw3TljzNJLZDpcAsHulqa
 904MmwN/RdyNAmjqh1miY30nhJ8QWHQUZrEzCvrXvUQ4COLjoufHbRRVzHoFrVdrNf
 d+6CXe6KhQ6UeieWC15SDZW3tDRNys3tRC+x5IX0X9xpX48dW9Uqxdxe2k3uyS2P5y
 UG6bhcl0/JzUjIShGridEwNgK7nToCtzW1Ipn2J/qpxaTgOFeYbrz0fjZe18umgiRs
 c7Abkx7ZptiC8VTjxOd7LY8odOIiRLmsVD/Z+v+KeSDa7AG/RwFZ9/YRmbDFSCWN7+
 ETMd6b4nEg80w==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 02:38:35 +0100
Message-Id: <DMOLFAB4UNSV.1A99UVEZAI527@kernel.org>
Subject: Re: [PATCH v6 0/3] gpu: nova-core: retain the GSP-RM log buffers
Cc: "Vladislav Zaharov" <vladazaharova2018@gmail.com>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <ttabi@nvidia.com>,
 <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261014154554.231015-1-vladazaharova2018@gmail.com>
 <ce4c6b64-98ff-4b50-8454-9cdb5aa6970e@nvidia.com>
In-Reply-To: <ce4c6b64-98ff-4b50-8454-9cdb5aa6970e@nvidia.com>
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

On Sat Nov 7, 2026 at 1:39 AM CET, John Hubbard wrote:
> Specifically, (as you mention above), I had to add "retained/" to the
> directory path in order to retrieve the logs. That is awkward, because
> that means that if I ask for gsp_keep_logs=3D1, now I have to know/rememb=
er
> that they are in:
>
>     /sys/kernel/debug/nova-core/retained/<BDF>/
>
> instead of:
>
>     /sys/kernel/debug/nova-core/<BDF>
>
> We should try hard to avoid such complications, especially given that
> debugging is often done when one has a thousand other complicated things
> going on at the same time, late at night, too.

It doesn't bother me too much, but I think the concern is fair.

The retained directory keeps a clear separation between live buffers and
retained buffers, but I don't think that's a strong reason to keep it.

In nouveau we don't have that separation either, but nouveau also keeps the
retained buffers until module unload. I.e. after the first retention nouvea=
u
never exposes new buffers (including the live ones) unless you reload the
module. This works, but can be rather unexpected when e.g. doing multiple
rebinds via sysfs.

Rebinding via sysfs can be especially useful in multi-GPU setups, where you
don't want to unbind all GPUs by unloading the module.

So, getting rid of retained/ is fine, but let's not follow what nouveau doe=
s.
Instead, let's make the same files point to the live buffers when the devic=
e is
bound and otherwise let them point at the retained buffers.

Thanks,
Danilo
