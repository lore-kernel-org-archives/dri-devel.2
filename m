Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57B4C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 490C710E432;
	Mon, 17 Aug 2026 14:11:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WSEYdoWE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F3D10E432
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:11:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C3F1C4402C;
 Mon, 17 Aug 2026 14:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911711F000E9;
 Mon, 17 Aug 2026 14:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786975906;
 bh=JjzPEck7JCRddLMV3TSmNGS28fMIN/3Iw861gkn7Ttg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WSEYdoWEvGA9byvBKkrdDVhWA/h+rvuWblbDc/wPaInl5g4tJgean4fDT1sa3bMu+
 SdhHQ0qLFP8bKv/WyFItVOaDcUfZ3GWe9uNsdTrb2FSTSFQnTOSQDB4Al8upKNjRXq
 Frz4FNGaY3bDmX2CNwkMUfiB0czMVUQbe4p/7YQ0tPmt8nQAc66XjZUsCcN1+5E7SF
 jFDkhgyEDinJcCT2mFKowv2GkC1QTY6mf6Wr/4ED8OkOCxaTUqxpbvB3TI2rpVuZMA
 pbER8o50zq3ZY1uBtRUYsrdm/gUdMUNlTrqGUY5U6/7EhxJmGC1l1leB+VKA2wfPaU
 T/dX2XzGromOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] drm/rocket: Keep scheduler allocation in
 rocket_file_priv
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260817140110.148873-2-89897892+HMTCT@users.noreply.github.com>
References: <20260817093009.22359-1-royalnet026@gmail.com>
 <20260817140110.148873-1-89897892+HMTCT@users.noreply.github.com>
 <20260817140110.148873-2-89897892+HMTCT@users.noreply.github.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:11:46 +0000
Message-Id: <20260817141146.911711F000E9@smtp.kernel.org>
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
- [Critical] Deterministic double free in rocket_job_close() for multi-core=
 devices.
--

--- Patch [2]: [PATCH v4 2/2] drm/rocket: Keep scheduler allocation in rock=
et_file_priv ---
commit 3f1ce60677689fe14af070b96e041b01b9fbc718
Author: Triet Hoang <triet.hoang.dev@gmail.com>

drm/rocket: Keep scheduler allocation in rocket_file_priv

Keep the scheduler allocation in rocket_file_priv and free it
unconditionally in rocket_job_close().

Link: https://lore.kernel.org/all/20260817093009.22359-1-royalnet026@gmail.=
com/#t

[ ... ]
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index adcc792541ec1..ff1d9e802024d 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
[ ... ]
> @@ -525,6 +528,7 @@ void rocket_job_close(struct rocket_file_priv *rocket=
_priv)
>  	struct drm_sched_entity *entity =3D &rocket_priv->sched_entity;
> =20
>  	kfree(entity->sched_list);
> +	kfree(rocket_priv->scheds);

[Severity: Critical]
Does this cause a double free of the scheds array on multi-core devices?

When the device has multiple cores (rdev->num_cores > 1),
drm_sched_entity_init() internally assigns the provided scheds array to
entity->sched_list. Since the patch additionally saves this same pointer
to rocket_priv->scheds, both entity->sched_list and rocket_priv->scheds
will point to the exact same heap allocation.=20

By calling kfree() on both sequentially, are we freeing the same memory twi=
ce?

>  	drm_sched_entity_destroy(entity);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817140110.1488=
73-1-89897892+HMTCT@users.noreply.github.com?part=3D2
