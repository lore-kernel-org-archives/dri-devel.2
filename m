Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041D0C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C5C610EC17;
	Mon, 14 Sep 2026 08:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LOzNGon8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA5910EC17
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:48:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E479960142;
 Mon, 14 Sep 2026 08:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706A01F00893;
 Mon, 14 Sep 2026 08:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789375729;
 bh=jZUIFmbwxbzCEEkgCiDNyixcvcXixfsRcRUjvZ4XL+w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LOzNGon8pFlQ6RLB5X+awVAUI8lwhy5q2EhXX9/u5xtYkzuR+PQhCJqrdMbN2P+Gj
 6AoiizMVlJX5K3eoBT6+zrtTRzVk52F4tw80pZtXBi9ra5Efnpma0rMQ8OfDJbMTdL
 liQvPtt6H1jcK8ECj5uHP4qgb3CvanmrYD0zZAr/N8zNFUis2uphspfysx2WdNfkw+
 j5rBURLQ7sd7sADnYDnRmkKAlStkWiwrV2PvL6gurCpKKof6PNqpeIikQ5zM23V84w
 MeQ7to8KK6oWGQH6y86ZqQ325VPyRIjRdaaN5+wH1kAszP1g3FA31aaif9xF7mEXaH
 x0mBIXyNUsqog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/ivpu: Abort pending jobs on file close
To: "Karol Wachowski" <karol.wachowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914082929.892437-1-karol.wachowski@linux.intel.com>
References: <20260914082929.892437-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 08:48:48 +0000
Message-Id: <20260914084849.706A01F00893@smtp.kernel.org>
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
- [High] Context and job cleanup is skipped when CONFIG_PM is disabled, def=
eating the purpose of the patch.
--

commit e999c7cb2698f3a8d3e0b1deb6b6b334895bbf3e
Author: Karol Wachowski <karol.wachowski@linux.intel.com>

accel/ivpu: Abort pending jobs on file close

This commit modifies ivpu_postclose() to explicitly abort a context's comma=
nd
queues and signal all pending jobs. This ensures that any in-flight jobs do
not keep running in the background after the owning process exits.

> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index 0f215392d42de..4c73dc8b3aafe 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c
> @@ -393,6 +393,17 @@ static void ivpu_postclose(struct drm_device *dev, s=
truct drm_file *file)
>  	ivpu_dbg(vdev, FILE, "file_priv close: ctx %u process %s pid %d\n",
>  		 file_priv->ctx.id, current->comm, task_pid_nr(current));
> =20
> +	if (pm_runtime_get_if_active(vdev->drm.dev) > 0) {

[Severity: High]
Does this skip the newly added job abort logic entirely when the kernel is
built without CONFIG_PM?

When CONFIG_PM is disabled, pm_runtime_get_if_active() returns -EINVAL.
This causes the condition to evaluate to false, completely bypassing the
context abort and job cleanup steps.

If an application submits jobs and closes the DRM file descriptor on a syst=
em
with CONFIG_PM=3Dn, the driver silently skips this cleanup. This appears to
defeat the purpose of the patch on those systems, as in-flight jobs will
continue running in the background.

Could this be exploited by untrusted or unprivileged userspace to launch
long-running jobs and detach from them, causing resource exhaustion on the
NPU?

> +		mutex_lock(&file_priv->lock);
> +		if (file_priv->bound && !file_priv->aborted)
> +			ivpu_context_abort_locked(file_priv);
> +		mutex_unlock(&file_priv->lock);
> +
> +		ivpu_context_abort_all_jobs(vdev, file_priv->ctx.id);
> +
> +		ivpu_rpm_put(vdev);
> +	}
> +
>  	ivpu_ms_cleanup(file_priv);
>  	ivpu_file_priv_put(&file_priv);
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914082929.8924=
37-1-karol.wachowski@linux.intel.com?part=3D1
