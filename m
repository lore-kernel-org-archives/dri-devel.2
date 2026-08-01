Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24566C55171
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 00:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9372B10E265;
	Sat,  1 Aug 2026 00:33:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S9xycIdY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 789FC10E167
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 00:33:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 249714179A;
 Sat,  1 Aug 2026 00:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59B51F00AC4;
 Sat,  1 Aug 2026 00:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785544385;
 bh=oF8XFmOCU4DXenTnLB+n5cPbz0TkoqsyBGzfFFfbZt4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S9xycIdY38z77gMHHCZx6dlUCE2fdw6dxm25bFIcKQMhwvzYc+NvPzFfrb5f34MXu
 v8OSpuwBj8eJ6HAHkLHJGR5d6aNs0oDjcx8v836UOHL5Aay98M8CPRYZEDKkjBF4ZG
 Ll56nrwOnjNMUJgdbSyGe6x4EjsYzbR8Tu+PvFUk4/rjX9NKsp2nbQ76IvyqU5yqNL
 aIB/OK5eYQFqHnpIHmql9OradNYwx6d5hYh6LvZz/wtvDHLJ/BuK8QjpYOXDF0iaAl
 jylvILdlydYoqRfJds2SNGxF5PGsnd6pUb5TloMJpSx3HMsHSYpTSaonnU7TFIplns
 Htt1z3MGGBx5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260730-tcpdm-large-niovs-v7-3-033d580a619d@meta.com>
References: <20260730-tcpdm-large-niovs-v7-0-033d580a619d@meta.com>
 <20260730-tcpdm-large-niovs-v7-3-033d580a619d@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 00:33:04 +0000
Message-Id: <20260801003304.D59B51F00AC4@smtp.kernel.org>
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
- [Medium] The newly added rx_page_size probe in require_devmem() fails to =
execute within the correct network namespace, causing the test to incorrect=
ly skip in containerized environments (like nk_devmem.py).
--

--- Patch [3]: [PATCH net-next v7 3/3] selftests/net: devmem.py: add check_=
rx_large_niov ---
commit 53558ad37aa9b0e02e2eb8a09081a53ab1fd981c
Author: Bobby Eshleman <bobbyeshleman@meta.com>

selftests/net: devmem.py: add check_rx_large_niov

Add a new devmem test case for binding the dmabuf with rx-page-size=3D16K.
The test sweeps RX payload sizes straddling the niov boundary to cover
the sub-niov, exact-niov, and multi-niov RX paths.

> diff --git a/tools/testing/selftests/drivers/net/hw/devmem_lib.py b/tools=
/testing/selftests/drivers/net/hw/devmem_lib.py
> index 0921ff03eb81c..cbe3a8e498239 100644
> --- a/tools/testing/selftests/drivers/net/hw/devmem_lib.py
> +++ b/tools/testing/selftests/drivers/net/hw/devmem_lib.py

[ ... ]

> @@ -18,6 +28,25 @@ def require_devmem(cfg):
>      if not cfg.devmem_supported:
>          raise KsftSkipEx("Test requires devmem support")
> =20
> +    if rx_page_size > 0:
> +        page_size =3D os.sysconf("SC_PAGE_SIZE")
> +        if not _is_aligned(rx_page_size, page_size):
> +            raise KsftSkipEx(
> +                f"rx-page-size=3D{rx_page_size} is invalid for this plat=
form "
> +                f"(must be a multiple of PAGE_SIZE=3D{page_size})")
> +
> +        if not hasattr(cfg, "devmem_rx_page_size_probed"):
> +            cfg.devmem_rx_page_size_probed =3D {}
> +
> +        if rx_page_size not in cfg.devmem_rx_page_size_probed:
> +            probe_command =3D f"{cfg.bin_local} -f {cfg.ifname} -b {rx_p=
age_size}"
> +            cfg.devmem_rx_page_size_probed[rx_page_size] =3D \
> +                cmd(probe_command, fail=3DFalse, shell=3DTrue).ret =3D=
=3D 0

[Severity: Medium]
Is it intentional that this probe command executes in the default namespace
rather than the containerized network namespace?

Since cmd() is called without the ns=3Dgetattr(cfg, "netns", None) argument,
it appears this probe runs outside of the proper network context. Could this
cause tests in container environments (like nk_devmem.py) to incorrectly sk=
ip
because the rx_page_size capability probe fails?

> +
> +        if not cfg.devmem_rx_page_size_probed[rx_page_size]:
> +            raise KsftSkipEx(
> +                f"Test requires devmem rx-page-size=3D{rx_page_size} sup=
port")
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-tcpdm-larg=
e-niovs-v7-0-033d580a619d@meta.com?part=3D3
