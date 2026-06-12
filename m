Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF2BCD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 06:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F3E10F2A4;
	Fri, 12 Jun 2026 06:45:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IvsEKtxw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B056010F2A1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 06:45:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8344743FD9;
 Fri, 12 Jun 2026 06:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DBE1F000E9;
 Fri, 12 Jun 2026 06:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781246719;
 bh=+5IpYshApii4IKiGZyWZ+dz3SHGPGdPyQdxJvvkBw0A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IvsEKtxwmYHcH5fF6WtIO3D9noEUvd7vPkM4Cp5Y9X6da4Lp0Jocb+qDd9fQ3IxIe
 5TqCqYohvOH01H35QCEtCsTJmHr6NqTopyBVempxnsLO5Z3LCCc/sS7CouV1mwhwGX
 MF5yVL4+wHu8fNbcFQPuEX9tRLagQqVR/yp2BpaRj7soWj9NsPQgCM8ucx/MkYbKLd
 ZZh8HCAGrYENnJKFgiT/v2KhNMzcXLeKkV61csRjRM9Q8EZ/WRk3W8hvibJk7p2Xdz
 EJR5JuQpGnnucSApFV4Vu9ucO1miyPz+1sZFN6xccJeloYnTJUnSU5dQPba0tXdht6
 k6XyCllVVgZlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] gpu: host1x: Correctly parse linear ranges of
 context devices
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260612-t264-host1x-v1-3-8d934987de67@nvidia.com>
References: <20260612-t264-host1x-v1-3-8d934987de67@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 06:45:18 +0000
Message-Id: <20260612064519.20DBE1F000E9@smtp.kernel.org>
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
- [High] The driver synchronously frees the dynamically allocated `cdl->dev=
s` array immediately after calling `device_unregister()`, while using an em=
pty `.release()` callback. This violates the Linux device model and leads t=
o a Use-After-Free.
--

commit 46b291569da04e8306d82ff644615dfc60ee956f
Author: Mikko Perttunen <mperttunen@nvidia.com>

gpu: host1x: Correctly parse linear ranges of context devices

The commit updates the parsing of the iommu-map property to support
linear ranges of context devices instead of assuming each device has
a one-length entry.

> diff --git a/drivers/gpu/host1x/context.c b/drivers/gpu/host1x/context.c
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
This isn't a bug introduced by this patch, but there is a pre-existing
issue with how the cdl->devs array is managed during cleanup.

In host1x_memory_context_list_init(), if an error occurs later in the
initialization, the unreg_devices error path unregisters the devices and
immediately frees the array:

host1x_memory_context_list_init() {
    ...
unreg_devices:
    while (i--)
        device_unregister(&cdl->devs[i].dev);
       =20
    kfree(cdl->devs);
    ...
}

The same pattern appears in host1x_memory_context_list_free() during
normal teardown.

The driver also provides a dummy release callback:

static void host1x_memory_context_release(struct device *dev)
{
    /* context device is freed in host1x_memory_context_list_free() */
}

Could this lead to a use-after-free? When device_unregister() is called,
it drops the initial device reference, but sysfs or userspace might still
hold elevated references to the embedded kobjects.

Since kfree(cdl->devs) is called synchronously while references could
still exist, would userspace interaction with the sysfs attributes for
these devices during teardown end up accessing freed memory?

>  	if (!cdl->devs)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-t264-host1=
x-v1-0-8d934987de67@nvidia.com?part=3D3
