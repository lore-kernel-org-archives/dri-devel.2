Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B9FCA9EC9
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 03:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBB6010E2B7;
	Sun, 11 Oct 2026 03:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LSHJfP/I";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B61A10E282
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 03:38:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 833AB4450C;
 Sun, 11 Oct 2026 03:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54211F00893;
 Sun, 11 Oct 2026 03:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791689904;
 bh=DhT2Sc1qZOsPqVuOtTlejOzafSl9/+wC5w47v4hyl3w=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=LSHJfP/IDboyc/VdiFW0S5vIbArmrOGlWGu/rf8Sh8b+nve3NdVCJHXsysp4l9xaH
 tD4nZz3H2ZukItiafHfTQjAnJmrAdmTRwxKLV3nJR4XGcpWcLGef/wR8PqhWRPI5HR
 muaHaCh6nYMsarMSJlbuwA114GYKMFTPCUSkucosh0wzaDPMJgqlyUFHLFhy2jma/j
 a2KBtbQ/hC3yjjj2yu6EILi7ByOptub1AdzKbl62tWxeRgpvpM3S5S6OD0a0VY2PAV
 obgXc63PF1EQDAttMzuZo4oAgEmdZUlABXqaqErfF06EHfxtqUsjKEqS31zb4sEcD6
 FIqE/AFVbfJMg==
Subject: Re: [PATCH net v1 4/4] selftests: net: add devmem RX and TX netdev
 unregister tests
From: netdev-bot+sashiko@kernel.org
To: almasrymina@google.com
Cc: kuba@kernel.org, dw@davidwei.uk, asml.silence@gmail.com,
 ap420073@gmail.com, sdf@fomichev.me, pabeni@redhat.com, kaiyuanz@google.com,
 bobbyeshleman@meta.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, horms@kernel.org, shuah@kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com, daniel@iogearbox.net,
 razor@blackwall.org, tariqt@nvidia.com, kaifengw@google.com
Date: Sun, 11 Oct 2026 03:38:22 +0000
Message-ID: <179168990244.434549.3313221235274785716@kernel.org>
In-Reply-To: <20261010025532.839559-5-almasrymina@google.com>
References: <20261010025532.839559-5-almasrymina@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 5 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In devmem_bind_rx_unregister_check() and
  devmem_bind_tx_unregister_check()…
- [Medium] The new tests need /dev/udmabuf (CONFIG_UDMABUF) and debugfs
  (CONFIG_DEBUG_FS, for the bufinfo assertions).
- [Medium] _dmabuf_attached_devs() (nl_netdev.py:390-408) collects the
  'Attached Devices' entries of every dma_buf in the system, not only…
- [Medium] devmem_bind_rx_unregister_check() (lines 413-439) and
  devmem_bind_tx_unregister_check() (lines 444-466) do not use `with…
- [Medium] _create_udmabuf() (nl_netdev.py:384) passes the hardcoded
  number 0x40187542 as UDMABUF_CREATE.
- [Low] In both new tests, the only check for the behaviour the
  docstrings claim ('Verify RX devmem bindings detach dma_buf…
- [Low] _create_udmabuf() (nl_netdev.py:379-387) closes memfd and devfd
  only on the success path.

--

selftests: net: add devmem RX and TX netdev unregister tests

This adds two tests to nl_netdev.py. Each one creates a udmabuf, binds it
to a netdevsim device for devmem RX or TX through the netdev netlink
family, and then removes the netdevsim device. The tests check debugfs
dma_buf/bufinfo to confirm that the attachment is gone, and expect the
netlink socket to close cleanly afterwards.

> diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
> index ceb44c8e1fec5..bad230ee9dcd2 100755
> --- a/tools/testing/selftests/net/nl_netdev.py
> +++ b/tools/testing/selftests/net/nl_netdev.py

[ ... ]

> @@ -366,6 +370,102 @@ def page_pool_stats_ifindex_check(nf) -> None:
>      ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.info.id')
>  
>  
> +def _create_udmabuf(num_pages=64) -> int:
> +    """Create a sealed memfd-backed udmabuf fd for devmem tests."""
> +    if not os.path.exists("/dev/udmabuf"):
> +        raise KsftSkipEx("/dev/udmabuf is not available")

[Severity: Medium]
Will these tests ever run in CI that builds from the net config fragment?

The only related entry in tools/testing/selftests/net/config is:

CONFIG_NETDEVSIM=m

It enables neither CONFIG_UDMABUF nor CONFIG_DEBUG_FS. So
_create_udmabuf() would always raise KsftSkipEx here, and both new tests
would always skip.

tools/testing/selftests/drivers/net/hw/config and drivers/dma-buf/config
both set CONFIG_UDMABUF=y. Should the net config fragment add
CONFIG_UDMABUF=y and CONFIG_DEBUG_FS=y too?

> +
> +    size = num_pages * mmap.PAGESIZE
> +    memfd = os.memfd_create("devmem-ksft", os.MFD_ALLOW_SEALING)
> +    os.ftruncate(memfd, size)
> +    fcntl.fcntl(memfd, 1033, 0x0002)  # F_ADD_SEALS, F_SEAL_SHRINK
> +    devfd = os.open("/dev/udmabuf", os.O_RDWR)
> +    req = bytearray(struct.pack("IIQQ", memfd, 0, 0, size))
> +    dmabuf_fd = fcntl.ioctl(devfd, 0x40187542, req)  # UDMABUF_CREATE

[Severity: Medium]
Is 0x40187542 the right request number on every architecture?

The uapi header defines it as:

include/uapi/linux/udmabuf.h:
#define UDMABUF_CREATE       _IOW('u', 0x42, struct udmabuf_create)

0x40187542 is the asm-generic encoding. Alpha, mips, powerpc and sparc
define _IOC_WRITE as 4U with 13 size bits, and parisc defines it as 2U.
On all of these the write bit lands at 0x80000000, so the request number
becomes 0x80187542.

On those architectures udmabuf_ioctl() hits its default case:

	default:
		ret = -ENOTTY;

Nothing catches the resulting OSError from fcntl.ioctl(), so both devmem
tests would fail instead of running or skipping.

> +    os.close(devfd)
> +    os.close(memfd)
> +    return dmabuf_fd

[Severity: Low]
Does this leak memfd and devfd on the error paths?

If os.ftruncate(), the F_ADD_SEALS fcntl() or os.open() raises, memfd is
never closed. If the UDMABUF_CREATE ioctl raises (the ENOTTY case above,
for example), both memfd and devfd stay open. ksft_run() catches the
exception and keeps the process running.

A try/finally around these calls would close both.

> +
> +
> +def _dmabuf_attached_devs():
> +    """Return attached device names from debugfs dma_buf/bufinfo if available."""
> +    path = "/sys/kernel/debug/dma_buf/bufinfo"
> +    if not os.path.exists(path):
> +        return None

[Severity: Low]
What happens when bufinfo is missing (CONFIG_DEBUG_FS off, or debugfs not
mounted)?

Both tests guard every assertion with:

    if attached is not None:

With None they run no assertions at all. ksft_run() then records them as
pass, not skip.

The tests still exercise nsimdev.remove(), but they would pass even if
the dma_buf stayed attached after unregister. Should this raise
KsftSkipEx instead of returning None?

> +    with open(path, "r", encoding="utf-8") as f:
> +        text = f.read()
> +    attached = []
> +    in_attached = False
> +    for line in text.splitlines():
> +        if line.strip() == "Attached Devices:":
> +            in_attached = True
> +            continue
> +        if in_attached:
> +            if line.startswith("\t") and line.strip():
> +                attached.append(line.strip())
> +            else:
> +                in_attached = False
> +    return attached

[Severity: Medium]
Does this count attachments from every dma_buf in the system, rather than
only the udmabuf this test created?

dma_buf_debug_show() walks the whole dmabuf_list and prints one block for
each buffer:

drivers/dma-buf/dma-buf.c:dma_buf_debug_show() {
    ...
		seq_puts(s, "\tAttached Devices:\n");
		attach_count = 0;

		list_for_each_entry(attach_obj, &buf_obj->attachments, node) {
			seq_printf(s, "\t%s\n", dev_name(attach_obj->dev));
    ...
}

The parser collects entries after every header, so the result is a total
for the whole host.

This has two effects:

- ksft_eq(len(attached), 0) after nsimdev.remove() fails whenever any
  other dma_buf (GPU, display, V4L2) has an attachment, even if the
  kernel detached this one correctly.
- ksft_ge(len(attached), 1) passes even if this binding never attached.

An attachment left behind by the RX test would also make the TX test
fail.

Could this filter on the inode of dmabuf_fd (os.fstat(dmabuf_fd).st_ino)
or on the netdevsim device name?

> +
> +
> +def devmem_bind_rx_unregister_check(_nf) -> None:
> +    """Verify RX devmem bindings detach dma_buf synchronously on netdev unregister."""
> +    dmabuf_fd = _create_udmabuf()
> +    nf_priv = NetdevFamily()
> +    ef = EthtoolFamily()
> +    nsimdev = NetdevSimDev(queue_count=2)
> +    nsim = nsimdev.nsims[0]

[Severity: Medium]
What happens to the netdevsim device if anything between here and
nsimdev.remove() raises?

The ip link set call, ef.rings_set(), nf_priv.bind_rx() or ksft_ge()
could all raise. ksft_run() catches the exception and moves on, but
nsimdev.remove() is never reached.

NetdevSimDev only cleans up through remove() or __exit__ and has no
__del__. So the device stays in the kernel after the selftest exits.
dmabuf_fd stays open, and if the bind succeeded, the dma_buf attachment
stays live too.

The other netdevsim tests in this file use "with NetdevSimDev(...)" or
defer(). Could these do the same? devmem_bind_tx_unregister_check() has
the same pattern.

> +
> +    ip(f"link set dev {nsim.ifname} up")
> +    ef.rings_set({"header": {"dev-index": nsim.ifindex},
> +                  "tcp-data-split": "enabled"})
> +    nf_priv.bind_rx({
> +        "ifindex": nsim.ifindex,
> +        "fd": dmabuf_fd,
> +        "queues": [{"id": 1, "type": "rx"}],
> +    })
> +
> +    attached = _dmabuf_attached_devs()
> +    if attached is not None:
> +        ksft_ge(len(attached), 1)
> +
> +    nsimdev.remove()
> +
> +    attached = _dmabuf_attached_devs()
> +    if attached is not None:
> +        ksft_eq(len(attached), 0)
> +
> +    del nf_priv
> +    os.close(dmabuf_fd)

[Severity: Medium]
Does del nf_priv actually close the netlink socket that holds the
binding?

YnlFamily.__init__() stores, on self, a partial for every op that refers
back to self:

tools/net/ynl/pyynl/lib/ynl.py:YnlFamily.__init__() {
    ...
        for op_name, op in self.ops.items():
            bound_f = functools.partial(self._op, op_name)
            setattr(self, op.ident_name, bound_f)
    ...
}

That is a reference cycle, so refcounting never frees the object. del
only drops the local name, and self.sock stays open until the cyclic GC
happens to run. That could be during the next test, or at process exit
after ksft_exit() has already printed the results.

So the step the commit message describes, closing the socket after
unregister and reaching netdev_nl_sock_priv_destroy(), does not happen
at a fixed point inside this test. A failure on that path could be
blamed on another test, or show up after this one already reported ok.

YnlFamily already provides close() and __enter__/__exit__. Would
nf_priv.close(), or "with NetdevFamily() as nf_priv:", be better here?
The same applies to devmem_bind_tx_unregister_check().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010025532.839559-1-almasrymina%40google.com
