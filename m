Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCF7CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B730910E285;
	Mon, 22 Jun 2026 07:09:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iAKImDvu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B984A10E285
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:09:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F2B986001A;
 Mon, 22 Jun 2026 07:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6725B1F000E9;
 Mon, 22 Jun 2026 07:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782112166;
 bh=w+Qkw+CT8ntP1xFexDsK/VSda0zWkEdq8nC69Ohb1Bo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iAKImDvuKDMaxU/SI6sDK1a3HEstkHe4k/f5w3N4lv2xneX9DIE/XncmtH4iPKfwL
 +jGtp4OXdp5zS+Er15t3080lx+9FNCQAVUhtBA3I7uVMkamVOhQaicbJJpd0CBbkHl
 9SOmHuhyugy1QgaWSOgwnTaCH6bkYUin8/Nu+4Z1dNYRk/OVY+IwCl7CIVHkskedGk
 9vsnLq+yCnUZJy42Hnkh62x/HCcfszek2Baon0QBf6fEgg4af9WxEEaaAcPepKYSe5
 9rREZZXSPaoz63PdGOdOj1dY63CO4pDISeb5R8fUJ/ot9HiJ/yIxZovs06L1l1/bBr
 1P8Od/ekFXLEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] gpu: host1x: Correctly parse linear ranges of
 context devices
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260622-t264-host1x-v2-3-ff7364d9ff7b@nvidia.com>
References: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
 <20260622-t264-host1x-v2-3-ff7364d9ff7b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 07:09:25 +0000
Message-Id: <20260622070926.6725B1F000E9@smtp.kernel.org>
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
- [High] The `struct device` objects embedded in `host1x_memory_context` ar=
e allocated as a contiguous array and freed synchronously via `kfree(cdl->d=
evs)` on error paths and teardown, violating device lifecycle rules.
--

commit a5e361c6f75f05af608f6d934522d035e2ecb31b
Author: Mikko Perttunen <mperttunen@nvidia.com>
gpu: host1x: Correctly parse linear ranges of context devices

The previous parsing of the iommu-map property assumed each context
device has its own one-length entry in the device tree. This patch updates
the logic to support linear ranges by properly summing the lengths.

> diff --git a/drivers/gpu/host1x/context.c b/drivers/gpu/host1x/context.c
> index d50d41c205617..52ca663902ad1 100644
> --- a/drivers/gpu/host1x/context.c
> +++ b/drivers/gpu/host1x/context.c
[ ... ]
> @@ -34,7 +34,16 @@ int host1x_memory_context_list_init(struct host1x *hos=
t1x)
>  	if (err < 0)
>  		return 0;
> =20
> -	cdl->len =3D err / 4;
> +	devs =3D 0;
> +
> +	for (i =3D 0; i < err / 4; i++) {
> +		u32 length;
> +
> +		of_property_read_u32_index(node, "iommu-map", i * 4 + 3, &length);
> +		devs +=3D length;
> +	}
> +
> +	cdl->len =3D devs;
>  	cdl->devs =3D kzalloc_objs(*cdl->devs, cdl->len);

[Severity: High]
This is a pre-existing issue, but allocating struct device objects as a
contiguous array and synchronously freeing them can lead to a use-after-fre=
e.

When host1x_memory_context_list_init() fails later on, it jumps to the
unreg_devices label:

unreg_devices:
        while (i--)
                device_unregister(&cdl->devs[i].dev);

        kfree(cdl->devs);

Calling device_unregister() drops a reference, but does not guarantee the
reference count drops to zero immediately. If another subsystem or userspace
holds an asynchronous reference, kfree() will prematurely free the entire
array while those references are still active.

Later, when the final reference is dropped, the kernel will attempt to invo=
ke
the host1x_memory_context_release() callback on the already freed memory.

Can the individual context devices be allocated separately to allow them to
have independent lifecycles managed by their respective release callbacks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-t264-host1=
x-v2-0-ff7364d9ff7b@nvidia.com?part=3D3
