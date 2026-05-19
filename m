Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D30BCD4F54
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 19:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C60910E170;
	Tue, 19 May 2026 19:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FbadDv9w";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B363C10E170
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 19:28:23 +0000 (UTC)
Received: from smtp.kernel.org
 (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D3B343F50;
 Tue, 19 May 2026 19:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB30A1F000E9;
 Tue, 19 May 2026 19:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779218903;
 bh=YTS4bNSKOXdEhxMkE7f4lWZFVBdpOGwn8B+fbBdHW54=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=FbadDv9wrtzbzkKkSw8dYjPu778nxjROQmQtwhRK+NNtocjFx8EboYmBwBRABUZFn
 rV4OBNHwv0LeKw5OExpucpC+ZIesPYmD37jOI+wHmLaQfMYYB3PwX/PK55kkBNmKRo
 hXOIkVpquhHQDME2jJlhEnrJ3aN78hPIQPkZNj9AGjhELCcP+r5JvF/qIVYSO5YEJg
 H6o9PWTywMR0oFyem7P90XIOrcXk95HBBvFXCm9+dAT26oTeV8lWrk2Eg1lUSF/w+P
 LA04sJu6SBTNnsUe++9WCqnuxG6vHwbOABotrPw2bUD03PVIbITXea8WHHBe1d70dz
 uggt8NBQ1rfRQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 21:28:17 +0200
Message-Id: <DIMWGLNJ922I.3PCET9O1J83TS@kernel.org>
Subject: Re: [PATCH 0/6] rust: drm: Higher-Ranked Lifetime private data
Cc: "Deborah Brouwer" <deborah.brouwer@collabora.com>,
 <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <daniel.almeida@collabora.com>, <acourbot@nvidia.com>,
 <apopple@nvidia.com>, <ecourtney@nvidia.com>, <lyude@redhat.com>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <driver-core@lists.linux.dev>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Boris Brezillon" <boris.brezillon@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260506221027.858481-1-dakr@kernel.org>
 <DICCEKZ3HU84.34ES3SW3D1FNI@kernel.org> <agYbppHWXk_hW99M@um790>
 <DIIMVPTLV3O5.3Q3DHU66WQZUA@kernel.org> <20260519205947.3c9d99b3@fedora>
In-Reply-To: <20260519205947.3c9d99b3@fedora>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue May 19, 2026 at 8:59 PM CEST, Boris Brezillon wrote:
> On Thu, 14 May 2026 21:07:11 +0200
> "Danilo Krummrich" <dakr@kernel.org> wrote:
>
>> On Thu May 14, 2026 at 8:59 PM CEST, Deborah Brouwer wrote:
>> > let unreg_dev =3D drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, d=
ata)?; =20
>>=20
>> You shouldn't need this anymore as the drm::Registration itself has priv=
ate data
>> now that is bound to the lifetime of the underlying bus device, which sh=
ould be
>> the correct lifetime for juggling the GPU page tables.
>
> The problem we have is that, to initialize some of the sub-components
> of the driver, we need to be able to allocate GEM objects before the DRM
> device is exposed (registered), and because the data we want to attach
> to the final registration contains these sub-components, we need to
> defer the data assignment to the registration step (which was allowed
> by [1], but apparently this was dropped from the latest version of
> the series for some reason).

I'm perfectly aware, what I'm saying above is that you probably want to sto=
re
those GEM objects (that you can create with the previously allocated
drm::Device) in the drm::Registration data. This fulfills this requirement =
*and*
ties the lifetime of those GEM objects to the lifetime of the underlying bu=
s
device being bound to the driver, which is exactly what you want for GEM ob=
jects
that contain the device page tables.
