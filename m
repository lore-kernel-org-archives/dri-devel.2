Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2F0C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 10:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A492410E3D8;
	Tue,  1 Sep 2026 10:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bogF0Ihn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E9910E3D8
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 10:38:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A9602601DB;
 Tue,  1 Sep 2026 10:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1871F000E9;
 Tue,  1 Sep 2026 10:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788259089;
 bh=qFJY0pjzSwJGrf4DiDAornj+7D/YJC8lZnDr3qLCuM0=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=bogF0IhnyvO3hnJ6AcOK6H4okCsMwMcXXA+vQGLrdE0Nz0gsM5uBXy98zloY8nh7S
 NXiI7Jbp6vXQTct3NRBJXcaj9EJsy3pNb+LZK6qObxP/CjRsMX+3g796WvASdbVTL/
 9/kGP6aeeW4H3h+sF+L0xpcf1GJsuS0/1DSUK0rU6mImTYnXdbH8yTbXOTTYfz8wop
 5/TPreRKgbyD1EdfRvHF7TsEEYYz/ORngBy6/chcdSyvPSwkCgNXq3OTOzbJiH41Uf
 U81qKFhqD/KCHRvgJ1Sqap+HdVkKlJNeQl1VnvSFbnY04r8ICqIB3xcYpR3ORVwYYa
 e/cjsLcB3KvkQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 12:38:05 +0200
Message-Id: <DL3WXUPD5JKE.2GZ1CNJH539ID@kernel.org>
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
Cc: "nova-gpu" <nova-gpu@lists.linux.dev>, "M Henning"
 <mhenning@darkrefraction.com>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
In-Reply-To: <20260828033531.1117754-6-apopple@nvidia.com>
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

On Fri Aug 28, 2026 at 5:35 AM CEST, Alistair Popple wrote:
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 0c12ef145981..740466af268d 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -138,6 +138,11 @@ pub(crate) const fn arch(self) -> Architecture {
>          }
>      }
> =20
> +    /// Returns the implementation identifier of this chipset.
> +    pub(crate) const fn implementation(self) -> u32 {
> +        self as u32 & 0xf
> +    }

I missed this part in my previous reply. Besides being a bit unfortunate th=
at we
have to reimplement what boot42.implementation() already gives us, I think =
the
value is not overly useful anyway.

I get the intent, architecture and implementation complement each other, bu=
t in
practice we are not interested in the implementation bits, but either in a
unique chip identifier or the architecture.

If you look at the nova-core code you will find exactly that, we either che=
ck
for a specific chip or an architecture and I think userspace will be inters=
ted
in the same.

So, I think the uAPI should provide the architecture and a unique chip
identifier.

Before we circle back, I know that the unique chip identifier in nova-core
technically contains the architecture for obvious reasons, but my point has
always been that we can give the decoded architecture to userspace and not
require it to know about and extract it from the chip identifier we conside=
r
opaque in the uAPI.
