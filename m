Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A625C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 14:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EA7110E17C;
	Fri,  7 Aug 2026 14:52:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kFL7CzCF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA3AC10E17C
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 14:52:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ADD95600C3;
 Fri,  7 Aug 2026 14:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456851F00A3D;
 Fri,  7 Aug 2026 14:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786114337;
 bh=NMj03f3vlcxIYDjhTjBW7klXjUhx+RbE9FV3YJY+Dbs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kFL7CzCFRJyUGymHtNEONgfvGwR14aj3zP9MfhDFTziJEPDBNwmvEXiOchxo1z++7
 5sX6dQLT9KDPM3P9FfRapoZLkvr2qLsieumvzlqubQkXqNQj18a7llkrWVa4c3fxcT
 vgWrk/xydet6ho8a3J4OMaVo2OwJNJW0Q/SoVuM2PHcJn2HQ/pvbV8JVb74+XEKhFs
 BFZxbulL5JI+MYGkF95BY3gRQKW5YAiVh+/f9BrzTvBn1zJKFSto6ETOrPj6hAwoDX
 9ZgNWpWb1KO+nqbbc+OY+Zm+jvxj+qcAbiTt4cLoD3VaijmkXWqZVZfREMdomoSxnV
 66JEhq5+QxOTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/amdxdna: fix usage_count leak when
 autosuspend_delay is negative
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260807143200.2500342-1-lgs201920130244@gmail.com>
References: <20260807143200.2500342-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:52:16 +0000
Message-Id: <20260807145217.456851F00A3D@smtp.kernel.org>
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
- [High] Deadlock during device teardown due to synchronous runtime PM resu=
me while holding dev_lock
--

--- Patch [1]: [PATCH] accel/amdxdna: fix usage_count leak when autosuspend=
_delay is negative ---
commit 31ff9d16b70b74f4b276ff67df887f4acb154424
Author: Guangshuo Li <lgs201920130244@gmail.com>

accel/amdxdna: fix usage_count leak when autosuspend_delay is negative

This commit fixes a usage_count leak when autosuspend_delay is negative
by adding a missing pm_runtime_dont_use_autosuspend() call during driver
teardown in amdxdna_pm_fini().

> diff --git a/drivers/accel/amdxdna/amdxdna_pm.c b/drivers/accel/amdxdna/a=
mdxdna_pm.c
> index b1fafddd7ad59..7dcedb7c105f2 100644
> --- a/drivers/accel/amdxdna/amdxdna_pm.c
> +++ b/drivers/accel/amdxdna/amdxdna_pm.c
> @@ -73,6 +73,7 @@ void amdxdna_pm_fini(struct amdxdna_dev *xdna)
>  {
>  	struct device *dev =3D xdna->ddev.dev;
> =20
> +	pm_runtime_dont_use_autosuspend(dev);
>  	pm_runtime_get_noresume(dev);
>  	pm_runtime_forbid(dev);

[Severity: High]
This is a pre-existing issue, but does calling pm_runtime_forbid() here
cause a self-deadlock during device teardown?

If the device is in the RPM_SUSPENDED state when driver unbind occurs,
amdxdna_remove() acquires dev_lock before starting the teardown chain:

drivers/accel/amdxdna/amdxdna_pci_drv.c:amdxdna_remove() {
    mutex_lock(&xdna->dev_lock);
    ...
    xdna->dev_info->ops->fini(xdna);
    ...
}

The teardown chain eventually reaches amdxdna_pm_fini(). Calling
pm_runtime_forbid() triggers a synchronous resume, which in turn invokes the
driver's resume callback. The resume callback then attempts to acquire the
exact same lock:

drivers/accel/amdxdna/amdxdna_pm.c:amdxdna_pm_resume() {
    guard(mutex)(&xdna->dev_lock);
    ...
}

Could this sequence cause the unbind thread to hang indefinitely waiting for
xdna->dev_lock?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807143200.2500=
342-1-lgs201920130244@gmail.com?part=3D1
