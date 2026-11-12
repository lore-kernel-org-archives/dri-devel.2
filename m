Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87141606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m6xZhtiM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B82F10EBD9;
	Thu, 12 Nov 2026 23:12:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A1710EBD9
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:12:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C8FF40731;
 Thu, 12 Nov 2026 23:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDAF1F000C4;
 Thu, 12 Nov 2026 23:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794525122;
 bh=9yE11MgbF30gNmfNl0c9MGkyHoXd0C/8/+CpvYn00Hw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m6xZhtiMcST/wu4ynCtiVvAEAWgVdhS7gcFpPEaLu6zDZScfWadxdVQ4gshQtFvZa
 QrcOtDZIC+R66C1+GdO43MBS5H/f0qE2BkoxHlqqM8m72FSua/SgG3El+oC67tEuxF
 Bom/+5yis4JxL5yLtId7NGDx9+rD80nogCVGLEc9s69Hh7ui6jjQmf0tONIRQO7oNw
 RU34m6mh6kU54F7qKmV2rWxwEA4fp33QBwkA4NTT3GEXBX1oiZ2VOi+82Rpg5O5XE7
 +N7X0+ngmp4y/TaKWopGfnJ21AwhOckGTgstVghin68rmFcCzXpp7JeV16OuDyNoBl
 xx9pnmQZneQKw==
Message-ID: <sashiko-outbox-211934@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 04/13] drm/powervr_sgx: Add the uAPI header and its
 documentation
To: "Joseph Telaak" <joseph@telaak.dev>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261112-powervr-sgx-v1-4-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
 <20261112-powervr-sgx-v1-4-c69b84bac011@telaak.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 23:12:02 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] drm/powervr_sgx: missing macro identifiers in uapi.rst
  kernel-doc
- [Low] drm/powervr_sgx: broken ReST role after caret in
  powervr_sgx_drm.h
--

commit f06a880dd06227c9b6234d3a185b5b25ba657094
Author: Joseph Telaak <joseph@telaak.dev>

drm/powervr_sgx: Add the uAPI header and its documentation

This commit adds the powervr_sgx DRM driver's uAPI header, Sphinx
documentation, and MAINTAINERS entry.

> diff --git a/Documentation/gpu/powervr_sgx/uapi.rst b/Documentation/gpu/p=
owervr_sgx/uapi.rst
> new file mode 100644
> index 0000000000000..8dd7908970b92
> --- /dev/null
> +++ b/Documentation/gpu/powervr_sgx/uapi.rst

[ ... ]

> +DEV_QUERY
> +---------
> +.. kernel-doc:: include/uapi/drm/powervr_sgx_drm.h
> +   :doc: PowerVR SGX IOCTL DEV_QUERY interface
> +
> +.. kernel-doc:: include/uapi/drm/powervr_sgx_drm.h
> +   :identifiers: drm_powervr_sgx_dev_query
> +                 drm_powervr_sgx_ioctl_dev_query_args
> +                 drm_powervr_sgx_dev_query_gpu_info
> +                 drm_powervr_sgx_dev_query_limits
> +                 drm_powervr_sgx_dev_query_commands
> +                 drm_powervr_sgx_dev_query_quirks
> +                 drm_powervr_sgx_heap_id
> +                 drm_powervr_sgx_heap
> +                 drm_powervr_sgx_dev_query_heap_info
> +
> +CREATE_BO
> +---------
> +.. kernel-doc:: include/uapi/drm/powervr_sgx_drm.h
> +   :doc: PowerVR SGX IOCTL CREATE_BO interface
> +
> +.. kernel-doc:: include/uapi/drm/powervr_sgx_drm.h
> +   :identifiers: drm_powervr_sgx_ioctl_create_bo_args
> +                 drm_powervr_sgx_ioctl_get_bo_mmap_offset_args

[Severity: Low]
Should these :identifiers: lists also include
DRM_POWERVR_SGX_CAP_BACKWARD_BLITS under DEV_QUERY, and
DRM_POWERVR_SGX_BO_ALLOW_CPU_ACCESS and DRM_POWERVR_SGX_BO_CODE under
CREATE_BO?

Those three macros have standalone kernel-doc comments in
powervr_sgx_drm.h rather than being part of a DOC: section, and every
kernel-doc directive in uapi.rst filters by :doc: or :identifiers:, so
their documentation (including the rules on code objects and reserved flag
bits) is omitted from the rendered Sphinx output.

> diff --git a/include/uapi/drm/powervr_sgx_drm.h b/include/uapi/drm/powerv=
r_sgx_drm.h
> new file mode 100644
> index 0000000000000..12381809503a1
> --- /dev/null
> +++ b/include/uapi/drm/powervr_sgx_drm.h
> @@ -0,0 +1,1175 @@

[ ... ]

> + *  - User pointers and device-virtual addresses are __u64. A device-vir=
tual
> + *    address at or above 2^&drm_powervr_sgx_dev_query_limits.va_bits is
> + *    rejected.

[Severity: Low]
Does 2^&drm_powervr_sgx_dev_query_limits.va_bits render raw :c:type:
markup in the generated documentation?

kernel-doc expands &drm_powervr_sgx_dev_query_limits.va_bits into a
:c:type: role right after the caret, and ReStructuredText only recognizes
an inline role when it is preceded by whitespace, a backslash-escaped
space, or punctuation such as ( or -.  Escaping the space as 2\^&\ ... or
adding parentheses as 2^(&drm_powervr_sgx_dev_query_limits.va_bits) lets
Docutils parse the cross-reference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-powervr-sg=
x-v1-0-c69b84bac011@telaak.dev?part=3D4
