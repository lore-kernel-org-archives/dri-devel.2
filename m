Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440756082BC1
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hk3+73cQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B070010F250;
	Thu,  5 Nov 2026 17:25:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF55B10E203;
 Thu,  5 Nov 2026 17:25:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 63633600B4;
 Thu,  5 Nov 2026 17:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3A31F000C1;
 Thu,  5 Nov 2026 17:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793899551;
 bh=NPkHrIBcg/8lpAx8TomjVgpgtliD3lXe8zJJ4DdOAT4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hk3+73cQvZT5TZodDginoYp6hD4La4PlWOrgGyXER0mFvwIZBDqswdlcj1gTP7if2
 Pasfne2Zzt+F092SisqDAsnzydV1ArLACpnvLaYuU5BPD3rbOMXMZiCR+G4yZhGiQ1
 pMu7c7bHpYWnAY1zA7NOQhuarxAr6x+Qpk8YR4R6NURmLJi984anwDxjAN9+ERocyX
 w/U+xSfX25WTPkariD01IVvp8nxW71vnu4bc2s4Brnm8DE1igi8pDwYtnGh75xY6Ql
 yJZuqoKlyhpaxMI02KZ9Oepothec4DvQDf3IGvNoh0H/XoU0unVvY+6ViL60Ii7Vko
 iK1tQj3FKUVQw==
Message-ID: <sashiko-outbox-199612@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] stddef: Add offsetofp() and offsetofendp() for
 pointer arithmetic
To: "Bence Csokas" <bence.csokas@arm.com>
Cc: linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261105-offsetof-v1-1-4153f5c10edc@arm.com>
References: <20261105-offsetof-v1-0-4153f5c10edc@arm.com>
 <20261105-offsetof-v1-1-4153f5c10edc@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:25:50 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] stddef: offsetofp() duplicates existing struct_offset() macro
--

commit 1381df6311c78f1d5db9e362d720874ccb5bad75
Author: Bence Csokas <bence.csokas@arm.com>

stddef: Add offsetofp() and offsetofendp() for pointer arithmetic

This commit introduces offsetofp() and offsetofendp() in
include/linux/stddef.h as convenience wrappers around offsetof() and
offsetofend() that take a struct pointer instead of a struct type.

> diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> index e1851c50c89b5..87f0e131d2350 100644
> --- a/include/linux/stddef.h
> +++ b/include/linux/stddef.h
> @@ -32,6 +32,22 @@ enum {
>  #define offsetofend(TYPE, MEMBER) \
>  	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
> =20
> +/**
> + * offsetofp() - Get the offset of a struct field from a pointer to the =
struct
> + *
> + * @P: Pointer to the structure
> + * @MEMBER: The member within the structure to get the start offset of
> + */
> +#define offsetofp(P, MEMBER) offsetof(typeof(*(P)), MEMBER)
> +
> +/**
> + * offsetofendp() - Get the end of a struct field from a pointer to the =
struct
> + *
> + * @P: Pointer to the structure
> + * @MEMBER: The member within the structure to get the end offset of
> + */
> +#define offsetofendp(P, MEMBER) offsetofend(typeof(*(P)), MEMBER)

[Severity: Low]
This isn't a bug, but commit f6ed9c5d3190 ("overflow: Implement
size_t saturating arithmetic helpers") already added struct_offset() in
include/linux/overflow.h with the same definition:

    #define struct_offset(p, member) (offsetof(typeof(*(p)), member))

which is currently used in kernel/trace/trace.c and
sound/soc/codecs/cs-amp-lib.c, following the struct_size(p, member, count)
vs struct_size_t(type, member, count) naming convention.

Should offsetofp() and struct_offset() be consolidated (and offsetofendp()
aligned with the chosen naming convention) so there aren't two redundant
macros for pointer-based member offsets across the tree?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-offsetof-v=
1-0-4153f5c10edc@arm.com?part=3D1
