Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24013C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821D489C0D;
	Sun, 28 Jun 2026 11:59:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XpaIKeKT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F6989C0D
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 11:59:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 941D66001D;
 Sun, 28 Jun 2026 11:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D191F000E9;
 Sun, 28 Jun 2026 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782647977;
 bh=Ec/1EgUyeblFn5CvjsGxH9SVLHLUsFH4ukZ+JaBfMLw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XpaIKeKTBTlksPqpzADDcXND8KZQt5s6KtN/TrHjmio4bolLlBlEA1a6+x9eDDrT3
 70g2cXYKLeOyekAgQX/kdSHQZ6r1MoT6oe49N7UfT2tzwsS0eU4gTYaxAfj/xhAk4b
 c0uS/AMwK1118tjlIDHf+B+PIFliXSBgxXrDLaB2AMn2B3VKMKOPRmi41uZfjaMjlo
 w8LflTzbRPY1VPpix0PUG+0p5KrbPYPQ/372vpdwh/2WC0xM/YaoyhMjSUdMbpBkpw
 R/szxLGsH/6OB17wYfde2tBcdhy7pbOTAD3csQnS+UxcWyYvcyR3vRLlkkVenKvq1p
 po8smY9SmE+CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] accel/qaic: fix GEM object refcount leak in
 qaic_attach_slice_bo_ioctl
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260628115119.44215-1-vulab@iscas.ac.cn>
References: <20260628115119.44215-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 11:59:36 +0000
Message-Id: <20260628115937.20D191F000E9@smtp.kernel.org>
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
- [Critical] The patch incorrectly adds `drm_gem_object_put(obj)` to the su=
ccess path of `qaic_attach_slice_bo_ioctl`, dropping a reference that is su=
pposed to be owned by the `dbc->bo_lists` list, introducing immediate Use-A=
fter-Free and Double-Free vulnerabilities.

Pre-existing issues:
- [High] Concurrent modifications to the `dbc->bo_lists` list are not prote=
cted by mutual exclusion, leading to linked list corruption.
--

commit bc2c1f25fbb00a819fac019aaf005f851bd75d49
Author: WenTao Liang <vulab@iscas.ac.cn>

accel/qaic: fix GEM object refcount leak in qaic_attach_slice_bo_ioctl

This commit attempts to fix a perceived GEM object reference leak by adding
a drm_gem_object_put() call in the success path of
qaic_attach_slice_bo_ioctl().

> diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_dat=
a.c
> index ef0351b6dc9b5..46842d4a0848e 100644
> --- a/drivers/accel/qaic/qaic_data.c
> +++ b/drivers/accel/qaic/qaic_data.c
[ ... ]
> @@ -1084,6 +1084,7 @@ int qaic_attach_slice_bo_ioctl(struct drm_device *d=
ev, void *data, struct drm_fi
> =20
>  	bo->sliced =3D true;
>  	list_add_tail(&bo->bo_list, &bo->dbc->bo_lists);

[Severity: High]
This is a pre-existing issue, but does this list_add_tail() race with other
concurrent list modifications?

The dbc->ch_lock only provides a shared read lock via srcu_read_lock(), and
bo->lock is a per-BO mutex. If userspace issues concurrent ioctls on the
same DBC with different BOs, wouldn't they simultaneously modify
dbc->bo_lists without mutual exclusion?

> +	drm_gem_object_put(obj);

[Severity: Critical]
Does adding this put call introduce a use-after-free?

The original code appears to transfer the GEM reference to the
dbc->bo_lists linked list on success, with detach_slice_bo() releasing it
later via drm_gem_object_put(&bo->base):

detach_slice_bo() {
    ...
    list_del(&bo->bo_list);
    drm_gem_object_put(&bo->base);
    ...
}

If we drop the reference early here, couldn't the BO be freed while still
linked in dbc->bo_lists, leading to list corruption during later operations?

Additionally, if this put drops the final reference, won't the subsequent
mutex_unlock(&bo->lock) operate on a destroyed mutex?

>  	srcu_read_unlock(&dbc->ch_lock, rcu_id);
>  	mutex_unlock(&bo->lock);
>  	kfree(slice_ent);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628115119.4421=
5-1-vulab@iscas.ac.cn?part=3D1
