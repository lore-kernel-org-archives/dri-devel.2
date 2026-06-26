Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C008CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:00:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 956C710E372;
	Fri, 26 Jun 2026 12:00:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z4Fb04Qm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 425FB10E35B
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:00:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9416960098;
 Fri, 26 Jun 2026 12:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CE21F000E9;
 Fri, 26 Jun 2026 12:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782475229;
 bh=BSiJ35d9X+22B034sLT2uyAuV5PW8RmMuocyOolkHKo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z4Fb04Qmw9k1dZ2td+vQxEepPh85aL4vxCkfIE5Z5yASVjopS9ThmmDoaM66wFl2J
 CAbvIemob2CjFjECToJlbuvYEsOHoXwukDQuFPDW07aCx87WmDlyNPjK5aSFBLAhWm
 qCEM3WIfhTrrQtaEd/UT3qf+D9ChoDzLUMETZYrBfQPLhAUKUwwwh8xjn8RP0c4FJ4
 UbOtQd3uM1QLCEyRDFmaH8EuletPYrECdoLvJatmoiRNG82PmDNJlyYpqksebF6AoY
 usStUCT7eCT2IvSGGy+qDT9BtE7Ska26/ZuaERlmBkcfRJiW/gDnG/6Oumi3H7UxM5
 0Utt22w6iSeFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: accel/qaic: qaic_attach_slice_bo_ioctl: success
 path missing   drm_gem_object_put
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626114359.32938-1-vulab@iscas.ac.cn>
References: <20260626114359.32938-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:00:28 +0000
Message-Id: <20260626120029.18CE21F000E9@smtp.kernel.org>
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
- [Critical] Reference count underflow and Use-After-Free (UAF) due to prem=
ature GEM object release.

Pre-existing issues:
- [High] Concurrent list operations on `dbc->bo_lists` are not synchronized=
, leading to list corruption.
--

commit 9afead81ed2f91d5b21fa630783b8bff00c9912d
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: accel/qaic: qaic_attach_slice_bo_ioctl: success path missing drm_gem_o=
bject_put

This commit adds a drm_gem_object_put() call to the success path of
qaic_attach_slice_bo_ioctl(). It attempts to prevent a perceived GEM
object reference leak.

> diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_dat=
a.c
> index ef0351b6dc9b5..46842d4a0848e 100644
> --- a/drivers/accel/qaic/qaic_data.c
> +++ b/drivers/accel/qaic/qaic_data.c
> @@ -1084,6 +1084,7 @@ int qaic_attach_slice_bo_ioctl(struct drm_device *d=
ev, void *data, struct drm_fi
> =20
>  	bo->sliced =3D true;
>  	list_add_tail(&bo->bo_list, &bo->dbc->bo_lists);

[Severity: High]
This isn't a bug introduced by this patch, but are the list operations on
dbc->bo_lists safely synchronized?

Looking at qaic_attach_slice_bo_ioctl() and detach_slice_bo(), they modify
this list using list_add_tail() and list_del(). However, the only shared
lock held appears to be srcu_read_lock(&dbc->ch_lock), which allows
concurrent readers. The mutex_lock(&bo->lock) only protects the specific BO.

Could concurrent ioctl calls for different BOs on the same dbc corrupt the
list?

> +	drm_gem_object_put(obj);

[Severity: Critical]
Does adding this drm_gem_object_put() cause a reference count underflow?

The original code appears to intentionally retain this GEM object reference
because list_add_tail() transfers ownership of the BO to dbc->bo_lists.

Later, detach_slice_bo() explicitly drops this list reference:

drivers/accel/qaic/qaic_data.c:detach_slice_bo() {
    ...
	list_del(&bo->bo_list);
	drm_gem_object_put(&bo->base);
    ...
}

If the reference is dropped here during attachment, could the BO be freed
prematurely while still in dbc->bo_lists, leading to a use-after-free
when release_dbc() iterates over the list?

>  	srcu_read_unlock(&dbc->ch_lock, rcu_id);
>  	mutex_unlock(&bo->lock);
>  	kfree(slice_ent);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626114359.3293=
8-1-vulab@iscas.ac.cn?part=3D1
