Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E7ECC6B1C
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:14:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630B810E986;
	Tue, 13 Oct 2026 18:14:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A763B10E16E
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:14:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1ABF460A60;
 Tue, 13 Oct 2026 18:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708231F00893;
 Tue, 13 Oct 2026 18:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791915270;
 bh=LNVLi5zmlfp86OAwSzYMPd0Re5zD+rl60i3RO7+XpcQ=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=HSJqNOwyNhIEKIAKsEVFrPeFsCFiftEWzfq//EyRCnogXt8e9jBVHXNWPEgILsAXY
 i9rUufdT3Cp0Sep8FdDNKzVpA/xhP/EsINdk+1GU41OrWf+45BJM6uXjdoo/0jbwa0
 xuog5f9ifjfOEWSk11dT+AaLa1mXtW2FWyQT6qSXYoPBJIkFee7T3x2MuvsnAP+RUn
 0Zg5r1odyJt4TY7q6+GlXoEci8zTFvUcalYv9qzlv8RI54ZuHS46Y9RtM7povsXBlg
 V3asBf2XEGIj9XO5b0HJx/C960mQUeikvkrINAaw8TeKqyMYyFrNHtnasXDy56nEsM
 ESZpr9wTBy1sg==
Subject: Re: [PATCH net v2 4/4] selftests: net: add devmem RX and TX netdev
 unregister tests
From: netdev-bot+sashiko@kernel.org
To: almasrymina@google.com
Cc: kuba@kernel.org, dw@davidwei.uk, asml.silence@gmail.com,
 ap420073@gmail.com, sdf@fomichev.me, pabeni@redhat.com, kaiyuanz@google.com,
 bobbyeshleman@meta.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, horms@kernel.org, shuah@kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com, razor@blackwall.org,
 daniel@iogearbox.net, tariqt@nvidia.com, kaifengw@google.com
Date: Tue, 13 Oct 2026 18:14:29 +0000
Message-ID: <179191526900.434549.14504153399122952528@kernel.org>
In-Reply-To: <20261012174300.2338784-5-almasrymina@google.com>
References: <20261012174300.2338784-5-almasrymina@google.com>
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

Critical: 0 · High: 0 · Medium: 6 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] `del nf_priv` in devmem_bind_rx_unregister_check() and
  devmem_bind_tx_unregister_check()…
- [Medium] _dmabuf_attached_devs() (nl_netdev.py:390-408) collects the
  'Attached Devices:' entries for every dma-buf in…
- [Medium] The new tests in tools/testing/selftests/net/nl_netdev.py need
  /dev/udmabuf (CONFIG_UDMABUF) and CONFIG_NET_DEVMEM.
- [Medium] devmem_bind_rx_unregister_check() and
  devmem_bind_tx_unregister_check() create the netdevsim device…
- [Medium] The detach check is what these tests mainly claim to verify
  (RX docstring: 'Verify RX devmem bindings detach dma_buf synchronously…
- [Medium] _create_udmabuf() (nl_netdev.py:384) issues
  `fcntl.ioctl(devfd, 0x40187542, req)`, which hardcodes the asm-generic…
- [Low] _create_udmabuf() (nl_netdev.py:379-387) opens `memfd` (line 379)
  and `devfd` (line 382) without try/finally.

--

selftests: net: add devmem RX and TX netdev unregister tests

This adds devmem_bind_rx_unregister_check() and
devmem_bind_tx_unregister_check() to nl_netdev.py. Each test binds a
udmabuf to a netdevsim device over the netdev netlink family, then
removes the device. It checks debugfs dma_buf/bufinfo to confirm the
attachment is gone.

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
Will these tests ever run with the config fragment for this directory?

tools/testing/selftests/net/config has CONFIG_NETDEVSIM=m. It has none of
CONFIG_UDMABUF, CONFIG_DMA_SHARED_BUFFER, CONFIG_NET_DEVMEM or
CONFIG_DEBUG_FS. NET_DEVMEM depends on DMA_SHARED_BUFFER:

net/Kconfig:
config NET_DEVMEM
	def_bool y
	select GENERIC_ALLOCATOR
	depends on DMA_SHARED_BUFFER

The existing devmem tests use tools/testing/selftests/drivers/net/hw/config.
That file sets CONFIG_NET_DEVMEM=y and CONFIG_UDMABUF=y.

On a kernel built from net/config, the skip above fires every time. The
regression coverage for "net: devmem: unmap dma_buf synchronously on queue
uninstall" and "net: devmem: detach TX bindings on NETDEV_UNREGISTER"
would then never run in CI for this directory.

Should CONFIG_UDMABUF=y, CONFIG_DMA_SHARED_BUFFER=y and CONFIG_DEBUG_FS=y
be added to tools/testing/selftests/net/config?

> +
> +    size = num_pages * mmap.PAGESIZE
> +    memfd = os.memfd_create("devmem-ksft", os.MFD_ALLOW_SEALING)
> +    os.ftruncate(memfd, size)
> +    fcntl.fcntl(memfd, 1033, 0x0002)  # F_ADD_SEALS, F_SEAL_SHRINK
> +    devfd = os.open("/dev/udmabuf", os.O_RDWR)
> +    req = bytearray(struct.pack("IIQQ", memfd, 0, 0, size))
> +    dmabuf_fd = fcntl.ioctl(devfd, 0x40187542, req)  # UDMABUF_CREATE

[Severity: Medium]
Is 0x40187542 correct on every architecture? The UAPI defines:

include/uapi/linux/udmabuf.h:
#define UDMABUF_CREATE       _IOW('u', 0x42, struct udmabuf_create)

and the _IOW() encoding depends on the architecture. On powerpc,
_IOC_WRITE is 4U and _IOC_SIZEBITS is 13, so the command works out to
0x80187542. mips, sparc and alpha use the same layout.

On those architectures, udmabuf_ioctl() falls through to its default case
and returns -ENOTTY:

drivers/dma-buf/udmabuf.c:udmabuf_ioctl() {
	switch (ioctl) {
	case UDMABUF_CREATE:
	...
	default:
		ret = -ENOTTY;
}

Python then raises OSError, and both tests report FAIL instead of SKIP
before any binding happens. Could the command value be computed from the
architecture's ioctl encoding instead?

> +    os.close(devfd)
> +    os.close(memfd)

[Severity: Low]
Does this leak memfd and devfd when something fails partway through? If
os.ftruncate(), the F_ADD_SEALS fcntl, os.open("/dev/udmabuf") or the
UDMABUF_CREATE ioctl raises, these two os.close() calls are skipped. The
descriptors, and the memfd pages, then stay open for the rest of the ksft
process. Would a try/finally around these steps help?

> +    return dmabuf_fd
> +
> +
> +def _dmabuf_attached_devs():
> +    """Return attached device names from debugfs dma_buf/bufinfo if available."""
> +    path = "/sys/kernel/debug/dma_buf/bufinfo"
> +    if not os.path.exists(path):
> +        return None

[Severity: Medium]
When bufinfo is missing, can these tests pass without checking anything?

The detach check is the main thing the RX docstring says this test
verifies. If CONFIG_DEBUG_FS is off, debugfs is not mounted, or the file
is not readable, this returns None. The callers' "if attached is not None:"
guards then skip both assertions, and the test reports PASS.

In that setup, the test would still pass if net_devmem_dev_unregister()
stopped calling net_devmem_dmabuf_binding_unmap(), which is where
dma_buf_detach() happens. net/config does not enable CONFIG_DEBUG_FS
either.

Should this raise KsftSkipEx instead of returning None?

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
Does this count attachments from every dma-buf on the system, not just the
udmabuf the test created?

dma_buf_debug_show() walks the global dmabuf_list. For each buffer it
prints a header and an "Attached Devices:" block:

drivers/dma-buf/dma-buf.c:dma_buf_debug_show() {
	...
		list_for_each_entry(attach_obj, &buf_obj->attachments, node) {
			seq_printf(s, "\t%s\n", dev_name(attach_obj->dev));
	...
}

This loop adds every buffer's entries to one list. The before-bind
ksft_ge(len(attached), 1) check can then pass because of some other
buffer, even if the devmem bind never attached.

The after-remove ksft_eq(len(attached), 0) check would also fail on any
machine where another dma-buf has an attachment, even if the devmem
binding detached correctly. Examples include GPU or DRM prime, V4L2, a
parallel test, or a binding left behind by an earlier test.

Could the parser filter on the test buffer's inode, for example by
matching the ino column against os.fstat(dmabuf_fd).st_ino?

> +
> +
> +def devmem_bind_rx_unregister_check(_nf) -> None:
> +    """Verify RX devmem bindings detach dma_buf synchronously on netdev unregister."""
> +    dmabuf_fd = _create_udmabuf()
> +    nf_priv = NetdevFamily()
> +    ef = EthtoolFamily()
> +    nsimdev = NetdevSimDev(queue_count=2)
> +    nsim = nsimdev.nsims[0]
> +
> +    ip(f"link set dev {nsim.ifname} up")
> +    ef.rings_set({"header": {"dev-index": nsim.ifindex},
> +                  "tcp-data-split": "enabled"})
> +    nf_priv.bind_rx({
> +        "ifindex": nsim.ifindex,
> +        "fd": dmabuf_fd,
> +        "queues": [{"id": 1, "type": "rx"}],
> +    })

[Severity: Medium]
What happens to the netdevsim device if ip(), ef.rings_set() or
nf_priv.bind_rx() raises here?

nsimdev is created without "with" or defer(nsimdev.remove). ksft_run()
only flushes registered defers, so nothing removes the device. That leaves
it registered in the kernel even after the test process exits:

tools/testing/selftests/net/lib/py/nsim.py:NetdevSimDev.remove() {
        if not self.removed:
            self.ctrl_write("del_device", "%u" % (self.addr, ))
            self.removed = True
}

dmabuf_fd and the netlink socket also leak for the rest of the run.

Also, an NlError with EOPNOTSUPP from bind_rx() or bind_tx() is not turned
into KsftSkipEx. Kernels that have the devmem fixes but not "netdevsim:
support devmem RX and TX bindings" would then report FAIL rather than
SKIP.

defer is already imported in this file, and the other netdevsim tests use
"with NetdevSimDev(...)". The same pattern is in
devmem_bind_tx_unregister_check() around bind_tx().

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

[Severity: Medium]
Does "del nf_priv" actually close the netlink socket that owns the
binding? YnlFamily.__init__() stores partials of bound methods on the
instance:

tools/net/ynl/pyynl/lib/ynl.py:YnlFamily.__init__() {
            bound_f = functools.partial(self._op, op_name)
            setattr(self, op.ident_name, bound_f)
}

Each partial refers back to self, which makes a reference cycle. Deleting
the local name drops only one reference. YnlFamily has no __del__, so
self.sock stays open until the cyclic GC happens to run or the process
exits.

The commit message says the tests verify that unregister:

    "cleanly closes the netlink socket without use-after-free or page
    faults."

As written, the genl release -> netdev_nl_sock_priv_destroy() path after
unregister never runs inside the test. That is the path fixed by "net:
devmem: detach TX bindings on NETDEV_UNREGISTER". A regression there would
show up later, or not be linked to this test at all, and the test would
still report PASS.

YnlFamily already has close() and __enter__/__exit__. Would nf_priv.close()
or "with NetdevFamily() as nf_priv:" work here? The same applies to
"del nf_priv" in devmem_bind_tx_unregister_check().

> +    os.close(dmabuf_fd)
> +
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012174300.2338784-1-almasrymina%40google.com
