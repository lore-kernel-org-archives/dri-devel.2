Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E55C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:36:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A374710E974;
	Mon, 13 Jul 2026 12:36:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bl/X/ES9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B539410E5B9
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:35:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 69FD843220;
 Mon, 13 Jul 2026 12:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB271F000E9;
 Mon, 13 Jul 2026 12:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783946159;
 bh=0zQftI8gXC+XES+wMoyUMPji3VVBgZY1MuF+lSepCsQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bl/X/ES9mKCRcfWnYjfivGM3DoI84jXSk8+gCDlk+lOzXlfVlH4qgKCh1w+0oZmlN
 /1KaLH09nws18FS1yV6Gfsv3hx15aTV9eLm+w5gaHw5VxQqihWL7ImPJoVtBFojhMu
 dZRcmn8HFbJHYrtTUKAOdUBJ842/Li9EbYC0+DxxcZlUM3D2XEKFcca9ZGKPGl+Zpc
 Tpo/wQueYgBo55bHxFR/UAQBBzhqZgnAjxmdGm+4ltTaO3hHfN3Rd/BQwrWmiXn/cN
 klTcEPDbbltMRc0FEq2JLRR2GLKCC/pn472+WvTEODjQj2WUI6AJ/GN5ZB/gEBdI1x
 WjIsS1UumGILw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/19] media: meson: vdec: Fix m2m device lifetime
 and cleanup path
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org
In-Reply-To: <20260713120840.17427-2-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-2-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:35:58 +0000
Message-Id: <20260713123559.0CB271F000E9@smtp.kernel.org>
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

New issues:
- [High] Moving `v4l2_m2m_dev` allocation to the driver core introduces an =
exploitable Use-After-Free (UAF) during device removal when file descriptor=
s remain open.

Pre-existing issues:
- [High] The `amvdec_core` structure is improperly allocated using `devm_kz=
alloc`, leading to Use-After-Free bugs when the device is unbound.
--

--- Patch [1]: [PATCH v7 01/19] media: meson: vdec: Fix m2m device lifetime=
 and cleanup path ---
commit f97dc3a43da5c78cbae7f710eb7770593a75ff3e
Author: Anand Moon <linux.amoon@gmail.com>

media: meson: vdec: Fix m2m device lifetime and cleanup path

The vdec driver was incorrectly initializing a new v4l2_m2m device
instance per session inside vdec_open() and releasing it in vdec_close().
This design is faulty because the m2m device models the core hardware
engine and must persist across multiple sessions.

Closes: https://lore.kernel.org/all/20260520045905.6ACBA1F000E9@smtp.kernel=
.org/#t

> diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/me=
dia/meson/vdec/vdec.c
> index a039d925c0fe5..6ae3471155a87 100644
> --- a/drivers/staging/media/meson/vdec/vdec.c
> +++ b/drivers/staging/media/meson/vdec/vdec.c

[ ... ]

> @@ -1105,6 +1106,7 @@ static void vdec_remove(struct platform_device *pde=
v)
>  	struct amvdec_core *core =3D platform_get_drvdata(pdev);
> =20
>  	video_unregister_device(core->vdev_dec);
> +	v4l2_m2m_release(core->m2m_dev);

[Severity: High]
Does releasing the m2m device here introduce a use-after-free if a file
descriptor remains open?

If a user unbinds the driver, vdec_remove() synchronously frees core->m2m_d=
ev.
However, if an application still holds a file descriptor open, it will
eventually close it, triggering vdec_close():

vdec_close()
  v4l2_m2m_ctx_release(sess->m2m_ctx)
    v4l2_m2m_cancel_job()
      spin_lock_irqsave(&m2m_dev->job_spinlock, flags);

Since core->m2m_dev was already freed during unbind, could this dereference
cause memory corruption or a crash?

[Severity: High]
This is a pre-existing issue, but does returning from vdec_remove() without
waiting for open file descriptors to close lead to a use-after-free of the
core driver structure?

The core structure and its mutex are allocated via devres (devm_kzalloc)
during vdec_probe(). If the device is unbound, devres will automatically fr=
ee
the core structure as soon as vdec_remove() returns.

If an ioctl is currently blocked waiting on vdev->lock (which points to
core->lock), it will attempt to unlock a freed mutex when it resumes.

Additionally, if the asynchronous esparser_queue_work runs after unbind, it
will dereference the freed sess->core.

Could the driver synchronize active sessions or use a different lifecycle f=
or
the core structure to prevent this?

>  	v4l2_device_unregister(&core->v4l2_dev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D1
