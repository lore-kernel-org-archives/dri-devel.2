Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2BECC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0336A10E5F1;
	Tue, 13 Oct 2026 17:43:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F24B10E3BB
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:43:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21D1C44017;
 Tue, 13 Oct 2026 17:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CD21F000FF;
 Tue, 13 Oct 2026 17:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791913403;
 bh=fL+I6tKYrDQmsJdPyYET/FTO+BenPvH5rqpr5ZfqJzQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K8wVpoirLdyIK2P64a2Ubvo863X7S4ctzAu8nCua4hTnSnzhIifb47Vr4xjkr0wlD
 +JMaOp71QQBY3ixc4t5rzk2wBBwpJUy25uKbvCHRvFDBGB+XnJpFtkZ/XfGKxaaf29
 AphEwFbq4FNLq+azeeiBxQiIlNjSAZL4o9ULfhF5Nsuf2q7MRPNuEjnEDT7bUZY0ZZ
 eBgLGOpoLWseJ5zwavF9RzR6nJrN7MFD5UZuJlzYaqerSv9ZbaF69Z+iNGAW+op7hk
 eYjGGEW6aIZE4yJq0hFnlGiJTUBWk/Me/g8rMDsDozyrDyj6ohw7zSJ2pLPxziinfp
 XaTqKYl9MFw8g==
Message-ID: <sashiko-outbox-170250@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 4/4] selftests: net: add devmem RX and TX netdev
 unregister tests
To: "Mina Almasry" <almasrymina@google.com>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261012174300.2338784-5-almasrymina@google.com>
References: <20261012174300.2338784-1-almasrymina@google.com>
 <20261012174300.2338784-5-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:43:22 +0000
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
- [Medium] selftests: net: test falsely assumes global dma_buf attachments =
drop to zero
- [Medium] selftests: net: netdevsim device leak on exception paths
--

commit 3ebc183bfb941c2f36dca38f1bd05b883cc61a30
Author: Mina Almasry <almasrymina@google.com>

selftests: net: add devmem RX and TX netdev unregister tests

Add devmem_bind_rx_unregister_check and devmem_bind_tx_unregister_check
to nl_netdev.py to verify that unregistering a netdevsim device while a
netlink socket holds an active RX or TX devmem binding synchronously
detaches the dma_buf attachment and cleanly closes the netlink socket
without use-after-free or page faults.

> diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/sel=
ftests/net/nl_netdev.py
> --- a/tools/testing/selftests/net/nl_netdev.py
> +++ b/tools/testing/selftests/net/nl_netdev.py
[ ... ]
> +def _dmabuf_attached_devs():
> +    """Return attached device names from debugfs dma_buf/bufinfo if avai=
lable."""
> +    path =3D "/sys/kernel/debug/dma_buf/bufinfo"
[ ... ]
> +    for line in text.splitlines():
> +        if line.strip() =3D=3D "Attached Devices:":
> +            in_attached =3D True
> +            continue
> +        if in_attached:
> +            if line.startswith("\t") and line.strip():
> +                attached.append(line.strip())

[Severity: Medium]
Will this parsing approach unconditionally aggregate all attachments across=
 all
dma_bufs in the system?

Because this does not filter the debugfs output to the specific dma_buf
created by the test, if the system executing the test has any other active
dma_bufs with attachments (e.g., from DRM graphics drivers), the global
attached count will remain non-zero.

> +            else:
> +                in_attached =3D False
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

[Severity: Medium]
If an exception occurs during the test, will this leak the netdevsim device?

The netdevsim device is instantiated without registering a teardown deferral
like defer(nsimdev.remove) or using a try/finally block. If any step before
the manual nsimdev.remove() call raises an exception, the cleanup is
bypassed. This permanently leaks the kernel netdevsim device and its sysfs
entries in the kernel namespace, potentially causing subsequent tests to fa=
il.

[ ... ]
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
Can this assertion spuriously fail if other dma_bufs exist system-wide?

Since _dmabuf_attached_devs() aggregates all attachments without filtering
for the specific dma_buf created by the test, the attached count will not
drop to zero if the system has other active dma_bufs, causing the test to
fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012174300.2338=
784-1-almasrymina@google.com?part=3D4
