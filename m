Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80C0CA5FAB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 04:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 101D510F171;
	Wed, 30 Sep 2026 04:00:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nGaCaPCK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEAAC10F171
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:59:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 52764601DE;
 Wed, 30 Sep 2026 03:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0CA1F000FF;
 Wed, 30 Sep 2026 03:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790740799;
 bh=oIQ113lNTA6DuZWdXyjlPJq3wkLfDPy/swHXpiMTpNo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nGaCaPCKmyR2nAKkxyz4u/LLqNAhrxRQySAom3bGGp/3HmGP/zbVdbSA23DXn5f3/
 UNJeC+lLfDFqzcQ5HMD22pmpvBU1U/TWlVTNeDYVj4OS6lmY4KyiBo+jg/ZpdUykig
 UVwCuBNzHMu07ILPIa7woAIZGI655fDJBNo0DxYr6yAQf/Z4kIfHwc1uE+mZ9UnTz0
 h54BR+qwtDhmo2dh3bFKv5LdTdpyVXtJ/yQz9+fsIF4P7ahv/U8AJswV3gObiVNz3v
 c9C0mcyvhEFbtoM8RI0g1wFtjfQHj+54pgw+dt+HsFPnOl6yCeQFKMdoGp8R8QrAZZ
 3fjnXMbQt4+xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 19/20] accel/amdxdna: Add stub hwctx_config for AIE4
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930033233.1727265-20-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
 <20260930033233.1727265-20-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 03:59:58 +0000
Message-Id: <20260930035958.DC0CA1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] amdxdna: aie4_hwctx_config unconditionally returns success for u=
nsupported types
--

commit 2fb62e44c1bbca14b0a25248c16851b8cb0c7aa6
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Add stub hwctx_config for AIE4

XRT issues DRM_AMDXDNA_CONFIG_HWCTX during hardware context
initialization. If hwctx_config is NULL, the ioctl returns -EOPNOTSUPP,
causing userspace validation tests like GEMM to fail. Add a stub=20
aie4_hwctx_config() returning 0 and wire it to aie4_vf_ops and
aie4_classic_ops.

> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie=
4_pci.c
> index 007b14be5245f..62ee7dfc7bd37 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -1369,12 +1369,19 @@ const struct amdxdna_dev_ops aie4_pf_ops =3D {
>  	.runtime_suspend	=3D aie4_pf_runtime_suspend,
>  };
> =20
> +static int aie4_hwctx_config(struct amdxdna_hwctx *hwctx, u32 type, u64 =
value,
> +			     void *buf, u32 size)
> +{
> +	return 0;
> +}

[Severity: Medium]
Does returning 0 unconditionally here falsely report success for unsupported
hardware context configuration commands?

If a userspace library like XRT calls the AMDXDNA_CONFIG_HWCTX ioctl with an
unsupported type (such as DRM_AMDXDNA_HWCTX_ASSIGN_DBG_BUF), returning 0
could cause userspace to assume the operation was successful. Could this
cause userspace to read uninitialized or garbage data from the buffer since
it relies on standard kernel error codes like -EOPNOTSUPP or -EINVAL to
detect hardware capabilities?

> +
>  const struct amdxdna_dev_ops aie4_vf_ops =3D {
>  	.init			=3D aie4_vf_init,
>  	.fini			=3D aie4_vf_fini,
>  	.debugfs_init		=3D aie4_debugfs_init,
>  	.hwctx_init		=3D aie4_hwctx_init,
>  	.hwctx_fini		=3D aie4_hwctx_fini,
> +	.hwctx_config		=3D aie4_hwctx_config,
>  	.cmd_submit		=3D aie4_cmd_submit,
>  	.cmd_wait		=3D aie4_cmd_wait,
>  	.get_aie_info		=3D aie4_get_info,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930033233.1727=
265-1-yidong.zhang@amd.com?part=3D19
