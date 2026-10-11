Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565B2CA9EC9
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 02:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9848410E28C;
	Sun, 11 Oct 2026 02:55:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NLBWOUp9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DFDA10E28C
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 02:55:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C2EB241592;
 Sun, 11 Oct 2026 02:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDF61F00893;
 Sun, 11 Oct 2026 02:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791687344;
 bh=DOoYMQZ2DO4lFxMSUPOPAn/DLkN7QJpUtfwwE27zcOY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NLBWOUp9K+WB5dlBYk4IZbK3VD2lmk/cwypXmvhzw9HmvD+Bbkt/clY/X/sgorqJr
 qa19lWhAKcr1lqeFOJXRDCdpSL8LhQAgQdscMtwSaGrw8VYhWqdSU0fG+etJJT1aFC
 Y57ad3hrsM/YNQKnsPMy/6E58A0dQ3VvMz0p/Ij4no7fpPdFsKcsRU1A6BonoX/izL
 oq48JA4EzOdJvKWsBjBDMszoRl2YtCQu4YaCFeUa+FxEDHgvL/kFTbDtUMLuiGTIQv
 flgcyaHuJGAoSOgF1zblqABt4fiB0Aac0p1ViHeGpA3rP36Oypla5BwTjn1ngktSj5
 o7xUX5RvYmIGA==
Message-ID: <sashiko-outbox-166987@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v1 4/4] selftests: net: add devmem RX and TX netdev
 unregister tests
To: "Mina Almasry" <almasrymina@google.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261010025532.839559-5-almasrymina@google.com>
References: <20261010025532.839559-1-almasrymina@google.com>
 <20261010025532.839559-5-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 02:55:43 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests: net: global dmabuf debugfs parsing causes spurious te=
st failures
- [Low] selftests: net: resource leak on exception in devmem unregister tes=
ts
--

commit 920bd7824b195d91554d5afd53f2bc33d3bbf933
Author: Mina Almasry <almasrymina@google.com>
Subject: selftests: net: add devmem RX and TX netdev unregister tests

This commit adds devmem_bind_rx_unregister_check and
devmem_bind_tx_unregister_check to verify that unregistering a netdevsim
device synchronously detaches dma_buf attachments. It ensures netlink
sockets close cleanly without page faults or use-after-free bugs.

> diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/sel=
ftests/net/nl_netdev.py
> index ceb44c8e1fec5..bad230ee9dcd2 100755
> --- a/tools/testing/selftests/net/nl_netdev.py
> +++ b/tools/testing/selftests/net/nl_netdev.py

[ ... ]

> +def _dmabuf_attached_devs():
> +    """Return attached device names from debugfs dma_buf/bufinfo if avai=
lable."""
> +    path =3D "/sys/kernel/debug/dma_buf/bufinfo"
> +    if not os.path.exists(path):
> +        return None
> +    with open(path, "r", encoding=3D"utf-8") as f:
> +        text =3D f.read()
> +    attached =3D []
> +    in_attached =3D False
> +    for line in text.splitlines():
> +        if line.strip() =3D=3D "Attached Devices:":
> +            in_attached =3D True
> +            continue
> +        if in_attached:
> +            if line.startswith("\t") and line.strip():
> +                attached.append(line.strip())
> +            else:
> +                in_attached =3D False

[Severity: Medium]
Will this loop blindly accumulate attached devices for all dma_bufs
system-wide without filtering by inode or specific fd?=20

If there are other active dma_bufs on the system, such as from DRM or V4L2
workloads, it looks like their attachments would all be unconditionally
appended to this global list.

> +    return attached
> +
> +
> +def devmem_bind_rx_unregister_check(_nf) -> None:
> +    """Verify RX devmem bindings detach dma_buf synchronously on netdev =
unregister."""
> +    dmabuf_fd =3D _create_udmabuf()
> +    nf_priv =3D NetdevFamily()
> +    ef =3D EthtoolFamily()
> +    nsimdev =3D NetdevSimDev(queue_count=3D2)
> +    nsim =3D nsimdev.nsims[0]
> +
> +    ip(f"link set dev {nsim.ifname} up")

[Severity: Low]
If a test helper like ip() or nf_priv.bind_rx() raises an exception, will
these resources be permanently leaked?

The file descriptor from _create_udmabuf() and the NetdevSimDev are created
but do not appear to be protected by defer(). If an exception occurs, it
could skip the manual cleanup calls at the end of the function.

> +    ef.rings_set({"header": {"dev-index": nsim.ifindex},
> +                  "tcp-data-split": "enabled"})
> +    nf_priv.bind_rx({
> +        "ifindex": nsim.ifindex,
> +        "fd": dmabuf_fd,
> +        "queues": [{"id": 1, "type": "rx"}],
> +    })
> +
> +    attached =3D _dmabuf_attached_devs()
> +    if attached is not None:
> +        ksft_ge(len(attached), 1)
> +
> +    nsimdev.remove()
> +
> +    attached =3D _dmabuf_attached_devs()
> +    if attached is not None:
> +        ksft_eq(len(attached), 0)

[Severity: Medium]
Because _dmabuf_attached_devs() aggregates attachments system-wide, does
this make the test exceedingly brittle?=20

If any unrelated dma_buf has attachments, this assertion could incorrectly
fail and cause spurious test failures in CI environments.

> +
> +    del nf_priv
> +    os.close(dmabuf_fd)
> +
> +
> +def devmem_bind_tx_unregister_check(_nf) -> None:
> +    """Verify TX devmem bindings detach cleanly on netdev unregister wit=
hout UAF."""
> +    dmabuf_fd =3D _create_udmabuf()
> +    nf_priv =3D NetdevFamily()
> +    nsimdev =3D NetdevSimDev(queue_count=3D2)
> +    nsim =3D nsimdev.nsims[0]
> +
> +    ip(f"link set dev {nsim.ifname} up")

[Severity: Low]
Similar to the RX test above, does this code leak the simulated netdev and
file descriptor if an exception is raised before the manual cleanup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010025532.8395=
59-1-almasrymina@google.com?part=3D4
