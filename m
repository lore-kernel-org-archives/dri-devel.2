Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0495C606A334
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=d4mOxrkl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6878810E120;
	Fri, 20 Nov 2026 16:24:27 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77EEA112BAE
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795191859;
 bh=fcy12No5QCrnAOUZgkGdvGdHHMJsgzaVa8BGW+ywOe0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=d4mOxrkl4G40xmOzMt8BiUz7e8/hDKC+KDW9zb4AErCSyAOyv7gtUVLyYCRWNhtKS
 8Gwetp6WMHJoDB85pWApNfkzM7hA60b/zFru8Ex4jIaf8hjetkJbP1BdSg1ZM8bXgY
 b/9RzRGij0RG1DWK23kUIz84M34sl8fx6KKGw2IC/tlS4WH0AX1n6HEwGY5raJ5V0O
 JSW2ykqLQKBIAul3V/tf4RtCB+d0+BWLxlfJIHOj6DLyTyiAl6VxReGzMq2wiI8jjp
 hydsziA/0F3PtDa2uDPBZ4qjROXPb6ynmq8SKhlwKzEkNgXSgpinEuOGxb/kKtDvNe
 Fz0XstB3lXUvA==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3C74217E0564;
 Fri, 20 Nov 2026 17:24:18 +0100 (CET)
Date: Fri, 20 Nov 2026 17:24:15 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Faith Ekstrand
 <faith.ekstrand@collabora.com>, Rob Herring <robh@kernel.org>, Steven Price
 <steven.price@arm.com>, =?UTF-8?B?QWRyacOhbg==?= Larumbe
 <adrian.larumbe@collabora.com>, Liviu Dudau <liviu.dudau@arm.com>, Akash
 Goel <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>, Lukas
 Zapolskas <lukas.zapolskas@arm.com>, Chris Diamand <chris.diamand@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, Alice Ryhl
 <aliceryhl@google.com>, kernel-dev@igalia.com,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 0/6] drm/panfrost,panthor: Refuse to export WB_MMAP BOs
Message-ID: <20261120172415.2aa235f0@fedora1.home>
In-Reply-To: <d2aa7dd9-367a-4b6f-8dee-3913b8e5f6a2@igalia.com>
References: <20261119-pan-drop-dma-buf-hooks-v1-0-6c6f1629e7f9@igalia.com>
 <20261120105654.63e1c254@fedora1.home>
 <d2aa7dd9-367a-4b6f-8dee-3913b8e5f6a2@igalia.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 13:05:50 -0300
Ma=C3=ADra Canal <mcanal@igalia.com> wrote:

> Hi Boris,
>=20
> On 20/11/26 06:56, Boris Brezillon wrote:
> >>
> >> Still, if you think this would be problematic, I can drop patches 3 an=
d 6. =20
> >=20
> > I was about to suggest forcing uncached CPU mappings for shareable BOs
> > on systems where the GPU is IO coherent, but there's actually no way we
> > can know whether a BO will be exported on not on Panfrost (on Panthor
> > we at least have this exclusive_vm thing that gives this guarantee). So
> > there's actually no way around it, it's either going back to a "broken"
> > state (broken in the sense it's not doing what it's supposed to, but no
> > one really complained in the past) or keep this sync logic to try to do
> > our best (even if it's not entirely safe, especially if the importer
> > does crazy stuff like pretending to be UMA when it's not).
> >=20
> > Sorry for not having a better answer than: it might be okay, but it
> > looks wrong. Every time I tried to understand what's expected from us
> > for this shared buffer synchronization, I ended up more confused than
> > before...
> >  =20
>=20
> That makes two of us :)
>=20
> I'm okay dropping patches 3 and 6. I decided to send them as suggested
> in our last discussion, but when I analyzed the IO-coherent case, I also
> had the impression that this could be a step back.
>=20
> V3D doesn't have the IO coherent case, so I can move forward with only
> Faith's drm_gem_shmem_sync() helper and I won't need the custom
> dma_buf_ops.
>=20
> If possible, could you take a look at patches 1-2 and 4-5? I'd
> appreciate it.

They look good to me.

>=20
> >>
> >> The Panthor changes were tested on hardware, but Panfrost changes were
> >> only compile-tested. =20
> >=20
> > Could you prepare a custom gfx-ci kernel [1] so we can check that mesa
> > CI is not regressed by this change? I know none of the tests in mesa CI
> > would normally hit the removed logic, but better safe than sorry. =20
>=20
> Sure, I'll test the series on Mesa CI (without patches 3 and 6).
>=20
> Best regards,
> - Ma=C3=ADra
>=20

