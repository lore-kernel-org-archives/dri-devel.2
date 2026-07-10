Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726B3C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE5A810F7D6;
	Fri, 10 Jul 2026 07:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fuYvY4rr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F87510E13A
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 07:27:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 770146001A;
 Fri, 10 Jul 2026 07:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F50B1F000E9;
 Fri, 10 Jul 2026 07:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783668432;
 bh=50dGMBJi41QmVHDUjU3SjIbFAIpM+hFrWc/CzuNwHVQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fuYvY4rrduDK8ugsWG2BR6kFnwOBopwKlRh1kTi+Mm9O+iZWCyz4tNYbff/mXlakM
 SL8mV0yZSVSb/GOLLqYsSliEjzeMk4IPuG0DQIolf+xt8U/j5d4XFzTho/Hp3meOAZ
 OQp3u1jy6ktl0NLcy2bYPPX2LVvMeTMgrgtxpOZZ5oCq3bNUE7n7wUVnCb5amkXBii
 i/lcaih6cbCW7bzmhaxyeevAU4L1iCCLDHZkKHHBH04R0wnyZy+hzhhi8+1IQg1e0j
 LT0U6mRpKEqv7hfjqhiCwQnqcq1fPv9hR8muqaNvItYuqshBrFZYzFgOpQLGY4823z
 M0OQNrHTQYhAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260708-tcpdm-large-niovs-v5-3-34bf6fac941b@meta.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-3-34bf6fac941b@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 07:27:11 +0000
Message-Id: <20260710072712.0F50B1F000E9@smtp.kernel.org>
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
- [Medium] Unhandled Python exception in selftests when hugepages are disab=
led or sysctl is read-only.
--

--- Patch [3]: [PATCH net-next v5 3/3] selftests/net: devmem.py: add check_=
rx_large_niov ---
commit c6680f91b9c04fa78f7d8b9d5f92ce1bee9816c1
Author: Bobby Eshleman <bobbyeshleman@meta.com>

selftests/net: devmem.py: add check_rx_large_niov

This commit adds a new devmem test case for binding a dmabuf with a 16K
rx-buf-size. It also sweeps various RX payload sizes across the niov bounda=
ry
to exercise the sub-niov, exact-niov, and multi-niov RX paths.

> diff --git a/tools/testing/selftests/drivers/net/hw/devmem_lib.py b/tools=
/testing/selftests/drivers/net/hw/devmem_lib.py
> --- a/tools/testing/selftests/drivers/net/hw/devmem_lib.py
> +++ b/tools/testing/selftests/drivers/net/hw/devmem_lib.py

[ ... ]

> +def run_rx_large_niov(cfg):
> +    """Run the devmem RX test with a large niov (rx-buf-size > PAGE_SIZE=
).
> +
> +    Sweep payload sizes that straddle the niov boundary: below, equal to,
> +    and above rx_buf_size, to exercise sub-niov, exact-niov, and multi-n=
iov
> +    RX paths.
> +    """
> +    hp_file =3D "/proc/sys/vm/nr_hugepages"
> +    with open(hp_file, 'r+', encoding=3D'utf-8') as f:

[Severity: Medium]
Will this crash with an unhandled exception on systems without hugepages
enabled or when run without write permissions to /proc/sys?

If the system was compiled without CONFIG_HUGETLB_PAGE=3Dy, opening this fi=
le
will throw a FileNotFoundError, causing the kselftest framework to report a
test failure rather than gracefully skipping.=20

Could this be wrapped in a try/except block to catch these exceptions and
raise KsftSkipEx instead?

> +        nr_hugepages =3D int(f.read().strip())
> +        if nr_hugepages < 64:
> +            f.seek(0)
> +            f.write("64")
> +            defer(_restore_nr_hugepages, hp_file, nr_hugepages)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-tcpdm-larg=
e-niovs-v5-0-34bf6fac941b@meta.com?part=3D3
