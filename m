Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C0ECD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 22:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DCAF10F69A;
	Thu, 28 May 2026 22:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="li/1oKA+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6D610F69A;
 Thu, 28 May 2026 22:28:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7999741502;
 Thu, 28 May 2026 22:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31D61F000E9;
 Thu, 28 May 2026 22:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780007283;
 bh=lJodPUarOR8wGQDRsCbfN6impEITQVF2OzJly9uaExc=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=li/1oKA+LOrS8vX+EF1yIBouswvrN8EdnPOg3IBLoISANATEr190coNu/wWY3wKeo
 kd1zNl2ZGCjNyIl0S4R6X5J4ieo4lmBTlfIuojuKwOrAsj+ve2lVcNDbGFhJ4YCUD0
 lT4iSQH6qNM06LnVJWA5DGXUv6+jKoT6OiR7FaPcJpuwKxZfJ2AugPyxt6VHp3644B
 WSyTYIseuHryWniR2mbZ8sYn+nUsTnQSwoQpWHx/8IyzgMArBWlOkyKv0uLrDXHoUc
 z8D6erJ4VmxB+SpM40apIE4ksWlOMjLZiSiN+9QoQglZ1YjTPLv8H7H0m+tb1Zo/fP
 n3IhA3QMXJZig==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 00:27:58 +0200
Message-Id: <DIUNX2Y69INR.HKKUZE3OSEEY@kernel.org>
Subject: Re: [PATCH v3 1/1] rust: drm: add FEAT_RENDER flag for render node
 support
Cc: <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <boris.brezillon@collabora.com>,
 <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <kernel@collabora.com>, "Daniel Almeida" <daniel.almeida@collabora.com>
To: "Laura Nao" <laura.nao@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260507080914.95478-1-laura.nao@collabora.com>
 <20260507080914.95478-2-laura.nao@collabora.com>
In-Reply-To: <20260507080914.95478-2-laura.nao@collabora.com>
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

On Thu May 7, 2026 at 10:09 AM CEST, Laura Nao wrote:
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.r=
s
> index e20a5978eed6..f0c2d6e4db3a 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -186,6 +186,7 @@ impl drm::Driver for TyrDrmDriver {
>      type Object =3D drm::gem::shmem::Object<BoData>;
> =20
>      const INFO: drm::DriverInfo =3D INFO;
> +    const FEAT_RENDER: bool =3D true;

In general this should be two separate patches, one adding the feature and
another one using it in the driver.

But in this case it is minor, so fine to leave it as is.
