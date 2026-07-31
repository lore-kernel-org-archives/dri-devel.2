Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56394C55173
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 20:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF5E110F3C7;
	Fri, 31 Jul 2026 20:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k5byKkIk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 472C110F3C7
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 20:12:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C036E600C3;
 Fri, 31 Jul 2026 20:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3653C1F00AC4;
 Fri, 31 Jul 2026 20:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785528730;
 bh=gOsd1WK/jYVoH+aRTsIWYKLjrnNYrDBxquT/JXt33EI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k5byKkIkYSnlauNrsElbL5UMPvlC9RLaYPySz4V6ctzTLqGM4FiDz2ybltzK6TGT9
 KQP46jTlfzR0SrTOypB1/UmBl6dzGSxGQ9e7IvntRzp1XRfdMRTOwa5kcG6AO43PCB
 S0zr2pr35+NIOm4VL3KAJ6tMbKvQElDZou6PuLS9bqY01cNikbAD7eURHmR2UXXmGM
 4cGmHwHsJ+HDv8idK3+cyAswdaLH8MHrckLsg70j5Hc0dQZu2mSoBspfPtR8WTaJIU
 BdL/3HgJPr4IacSI7q5HJav6jWvrxCftoLKIXmJq1adA3KLJZsswtIwxZvnI6rG+tF
 qwv6ImQ7cU5AQ==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH net-next 3/6] hv_netvsc: Remove GPADL teardown
 special case for old Hyper-V hosts
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260730201123.1767-4-mhklinux@outlook.com>
References: <20260730201123.1767-1-mhklinux@outlook.com>
 <20260730201123.1767-4-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 20:12:09 +0000
Message-Id: <20260731201210.3653C1F00AC4@smtp.kernel.org>
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

Pre-existing issues:
- [High] If GPADL teardown fails, the receive/send buffers are mistakenly r=
eturned to the kernel allocator via vfree() instead of being intentionally =
leaked, creating a guest memory corruption vulnerability (DMA-after-free).
--

--- Patch [3]: [RESEND PATCH net-next 3/6] hv_netvsc: Remove GPADL teardown=
 special case for old Hyper-V hosts ---
commit eeed9aa2167381d7fb4f1e329217b52e4689eb18
Author: Michael Kelley <mhkelley58@gmail.com>

hv_netvsc: Remove GPADL teardown special case for old Hyper-V hosts
   =20
With the overall removal of Linux support for running on Hyper-V
hosts earlier than WS2016 and Windows 10, the special case handling of
GPADL teardown is no longer necessary. Remove it.

> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 4d319c50955ed..4295b96b43127 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c

[ ... ]

> @@ -733,14 +724,9 @@ void netvsc_device_remove(struct hv_device *device)
>  	/* Now, we can close the channel safely */
>  	vmbus_close(device->channel);
> =20
> -	/*
> -	 * If host is Win2016 or higher then we do the GPADL tear down
> -	 * here after VMBus is closed.
> -	*/
> -	if (vmbus_proto_version >=3D VERSION_WIN10) {
> -		netvsc_teardown_recv_gpadl(device, net_device, ndev);
> -		netvsc_teardown_send_gpadl(device, net_device, ndev);
> -	}
> +	/* Must do the GPADL teardown after channel is closed */
> +	netvsc_teardown_recv_gpadl(device, net_device, ndev);
> +	netvsc_teardown_send_gpadl(device, net_device, ndev);
> =20
>  	/* Release all resources */
>  	free_netvsc_device_rcu(net_device);

[Severity: High]
This is a pre-existing issue, but I noticed a potential DMA-after-free
related to these teardown functions.

If vmbus_teardown_gpadl() fails inside netvsc_teardown_recv_gpadl() (or the
send equivalent), the code attempts to intentionally leak the buffer rather
than bugchk:

drivers/net/hyperv/netvsc.c:netvsc_teardown_recv_gpadl() {
    ...
    ret =3D vmbus_teardown_gpadl(device->channel,
                               &net_device->recv_buf_gpadl_handle);
    if (ret !=3D 0) {
        netdev_err(ndev, "unable to teardown receive buffer's gpadl\n");
        return;
    }
}

However, because net_device->recv_buf isn't set to NULL on this error path,
execution continues to free_netvsc_device_rcu() just below, which ends up
unconditionally freeing it:

drivers/net/hyperv/netvsc.c:free_netvsc_device() {
    ...
    if (!nvdev->recv_buf_gpadl_handle.decrypted)
        vfree(nvdev->recv_buf);
    ...
}

Since the GPADL teardown failed, does the host still have this memory mapped
when it gets returned to the kernel allocator via vfree(), leading to
potential guest memory corruption if the host writes to it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730201123.1767=
-1-mhklinux@outlook.com?part=3D3
