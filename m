Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B6D606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akOqDgwi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61FB711238B;
	Fri, 13 Nov 2026 09:31:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFF76112325;
 Fri, 13 Nov 2026 09:31:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 97DDE444EA;
 Fri, 13 Nov 2026 09:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F2C1F000C4;
 Fri, 13 Nov 2026 09:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794562286;
 bh=EMfXNYkZVks7flMrKu46XaAukhBAJVxT9U2dtg8td+A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=akOqDgwi1ZOWtxGBNJUwwA0lC8PNQpA7oZJ7gd5aRY8wFX4DwX0CXzusFVGMP8HDW
 +w0jb/BoZEBKSpqHIwVtXQpghl2++WwDJKAvYfOm0f9aRHW1XmhwmnQGA0/sDkB1Fe
 08k/RTa/oF8MP1apqx7WvhPeFDEuhG4WYqXj9FvDyAVv7wz4arsNJfUrbwvNkV2N53
 ruq56b3aKlbkk/FJyufUj8YDX0/gCTnTYkb6fxhWe+jNbVpH5JL84bWawJ+EwzSEBh
 0+sMa1n0ix4K3xzhNU/RFESpOU+ysaSngiZSOhhwTGFCTqVne1eqgJRWAisSPVoz4Q
 IkPrLaVI+Y0XA==
Message-ID: <sashiko-outbox-212547@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] stddef: Add offsetofend() variant of
 struct_offset()
To: "Bence Csokas" <bence.csokas@arm.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-scsi@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261112-offsetof-v2-1-276ede839967@arm.com>
References: <20261112-offsetof-v2-0-276ede839967@arm.com>
 <20261112-offsetof-v2-1-276ede839967@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:31:25 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] overflow: inaccurate kernel-doc Return comment for
  struct_offsetofend()
--

commit a83afd15b73f01058421922341af6cf7cf31d535
Author: Bence Csokas <bence.csokas@arm.com>

stddef: Add offsetofend() variant of struct_offset()

This commit adds the struct_offsetofend() macro to include/linux/overflow.h
to calculate offsetofend() on the type of a struct pointer.

> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index d0f04436343e5..060dad4b6f3e0 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -464,6 +464,18 @@ static __always_inline size_t __must_check size_sub(=
size_t minuend, size_t subtr
>   */
>  #define struct_offset(p, member) (offsetof(typeof(*(p)), member))
> =20
> +/**
> + * struct_offsetofend() - Calculate the end of a member within a struct
> + * @p: Pointer to the struct
> + * @member: Name of the member to get the end offset of
> + *
> + * Calculates the offset of the end of a particular @member of the struc=
ture
> + * pointed to by @p.
> + *
> + * Return: number of bytes to the location of @member.
> + */
> +#define struct_offsetofend(p, member) (offsetofend(typeof(*(p)), member))

[Severity: Low]
This isn't a bug, but the Return description was copied from
struct_offset() and says "the location of @member" rather than the end of
@member.  Also, the commit message body refers to adding an "offsetof()
variant" instead of an offsetofend() variant, and the subject uses the
"stddef:" prefix for a change in include/linux/overflow.h.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-offsetof-v=
2-0-276ede839967@arm.com?part=3D1
