Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942F1C624D6
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 22:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C40A010F7DD;
	Thu,  3 Sep 2026 22:16:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Gnepje8Y";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D81B10F7D5
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 22:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788473791; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JKScbrY8mJKFBOk4gWjHsQ2eUiuL+OzJxuFYDly+hE86c+necr/CDKVWJ+uz/q7FBweNJsYrBzjIJHUiBlmi832Xb+qX2GHyePbp7dCvuEZmrkd6OI3vkcIwqFL3RRFd193tKr60GiTvXx3q9O3TS+LAjlBYbwKMITbmNVLYQzc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788473791;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RWOu6GJfHwlVwN5aizsAATz9AbxY/g0p76dvf7h/0WM=; 
 b=QFt+zF66oIB+oaebcKpgUyaDst/ujMpTCCIfaVnfuv/ualsr7Kx5POjZVndqNr7Iz3fgNzjo6CSmDpFYYWjF6usfkxB1JAwFs9YdB+z2KHm8vmTuyOV+7L3l5SO6D+fNbwrG/EVPtw56k44HKva5huU00puWRJWXHwD9U3hLckw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788473791; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=RWOu6GJfHwlVwN5aizsAATz9AbxY/g0p76dvf7h/0WM=;
 b=Gnepje8YnI0WypZChVR+bwIMVMs9Q4fMv5KTsV0j22N671f3pwyPR0ipgke5NPF6
 nqlhMB06Os1SP10rAUCS2wAEe4hFCrb0Y/wzo4WXdW96RKQv43BofKpG1rPtYuhFled
 1KyYc0rqrhQoMm4V7ZAQfBbiKOV2Gx3qPI/UoOdE=
Received: by mx.zohomail.com with SMTPS id 1788473791201272.4860508436931;
 Thu, 3 Sep 2026 15:16:31 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 7/9] drm/tyr: refactor new_dummy_object to use new_object
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260902-tyr-ioctls-v1-7-e0fdbf8bd108@kylinos.cn>
Date: Thu, 3 Sep 2026 19:16:12 -0300
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 Alvin Sun <alvin.sun@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <260753A3-F6C0-426F-B640-C397BC4EA3D7@collabora.com>
References: <20260902-tyr-ioctls-v1-0-e0fdbf8bd108@kylinos.cn>
 <20260902-tyr-ioctls-v1-7-e0fdbf8bd108@kylinos.cn>
To: sunke@kylinos.cn
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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



> On 1 Sep 2026, at 13:09, Ke Sun via B4 Relay =
<devnull+sunke.kylinos.cn@kernel.org> wrote:
>=20
> From: Alvin Sun <alvin.sun@linux.dev>
>=20
> new_dummy_object() duplicated the BO creation code that new_object()
> now provides; call new_object() instead.
>=20
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
> drivers/gpu/drm/tyr/gem.rs | 13 ++-----------
> 1 file changed, 2 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
> index be1affe80db1a..d9ddcb287f52b 100644
> --- a/drivers/gpu/drm/tyr/gem.rs
> +++ b/drivers/gpu/drm/tyr/gem.rs
> @@ -82,17 +82,8 @@ pub(crate) fn lookup_handle(file: &TyrDrmFile, =
handle: u32) -> Result<ARef<Bo>>
>=20
> /// Creates a dummy GEM object to serve as the root of a GPUVM.
> pub(crate) fn new_dummy_object(ddev: &TyrDrmDevice) -> =
Result<ARef<Bo>> {
> -    let bo =3D Bo::new(
> -        ddev,
> -        4096,
> -        shmem::ObjectConfig {
> -            map_wc: true,
> -            parent_resv_obj: None,
> -        },
> -        BoCreateArgs { flags: 0 },
> -    )?;
> -
> -    Ok(bo)
> +    // FIXME: use a Rust resv-object abstraction once available, =
rather than a real BO.
> +    new_object(ddev, 4096, 0)

For the same reason as the previous patch, I think this needs to be =
PAGE_SIZE too.

Feel free to work on the FIXME itself separately, if you want.

> }
>=20
> /// Specifies how to choose a GPU virtual address for a [`KernelBo`].
>=20
> --=20
> 2.43.0
>=20
>=20
>=20

With the change above,

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

