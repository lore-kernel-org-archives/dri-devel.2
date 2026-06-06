Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37FFCD8C85
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 21:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E86AE10E8BC;
	Sat,  6 Jun 2026 21:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QbapXxOc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD7EA10E8BC
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 21:50:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D98240AC1;
 Sat,  6 Jun 2026 21:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7911F00893;
 Sat,  6 Jun 2026 21:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780782613;
 bh=l6BkDN6Y+qWQQjN1sRss8gaiA/XXdY/yCVrtLS6eiIg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QbapXxOcp1fGApB7Ub17LC+NwkK7DSlUwQPP7QGnzJ5xntnLPH2V577yAa0NCt3AN
 uMkP30A9ESOXfUU7+GVUGTyQ9+wy+mXlBrtMWik8VM7RwH248GQuizaVXDQw1ybQSi
 uYdu+1NUyDdd8Mpp7pz34Dqkr4w5n68pWU3WwXU1gtjXHGAsDgqlN5zOfJe07xE97O
 SCKd33dFTp5brQjFYSUfZFJLpYkAh9YaBcT1yKUftB62pAp8iy89XsqYZIWgTf7VEJ
 KVvrYgvvOI2rZsmHOWJj7iknCXM2DhCiZtgFbuhIRcNv2zsnOK3EjEUnMhy+0hIKpw
 dYRj5s5+iE3uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Validate max_fclk_mhz in DML2 policy
 builder
To: "Danila Chernetsov" <listdansp@mail.ru>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260606212503.140638-1-listdansp@mail.ru>
References: <20260606212503.140638-1-listdansp@mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 21:50:12 +0000
Message-Id: <20260606215013.4D7911F00893@smtp.kernel.org>
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
- [High] Missing bounds check in `insert_entry_into_table_sorted` allows ar=
ray out-of-bounds write.
--

commit 803110810943a93ffdbd8a40adba9348d5b58b1b
Author: Danila Chernetsov <listdansp@mail.ru>

drm/amd/display: Validate max_fclk_mhz in DML2 policy builder

This commit adds a validation check for max_fclk_mhz to prevent an integer
underflow and out-of-bounds array access when all FCLK entries are zero.

> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c b/driver=
s/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c
> index ab2964811c5bc..938faa6272c2c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_policy.c
> @@ -157,7 +157,8 @@ int dml2_policy_build_synthetic_soc_states(struct dml=
2_policy_build_synthetic_so
>  			num_uclk_dpms++;
>  	}
> =20
> -	if (!max_dcfclk_mhz || !max_dispclk_mhz || !max_dppclk_mhz || !max_phyc=
lk_mhz || !max_dtbclk_mhz)
> +	if (!max_dcfclk_mhz || !max_dispclk_mhz || !max_dppclk_mhz || !max_phyc=
lk_mhz ||
> +		!max_dtbclk_mhz || !max_fclk_mhz)
>  		return -1;
> =20
>  	p->out_states->num_states =3D 0;

[Severity: High]
This isn't a bug introduced by this patch, but can the subsequent state
insertions overflow the out_states array?

Looking at dml2_policy_build_synthetic_soc_states(), it calls
insert_entry_into_table_sorted() multiple times:

    // Insert all the DCFCLK STAs first
    for (i =3D 0; i < p->num_dcfclk_stas; i++) {
        ...
        insert_entry_into_table_sorted(p->in_bbox, p->out_states, &s->entry=
);
    }

    // Insert the UCLK DPMS
    for (i =3D 0; i < num_uclk_dpms; i++) {
        ...
        insert_entry_into_table_sorted(p->in_bbox, p->out_states, &s->entry=
);
    }

    // Insert FCLK DPMs (if present)
    if (num_fclk_dpms > 2) {
        for (i =3D 0; i < num_fclk_dpms; i++) {
            ...
            insert_entry_into_table_sorted(p->in_bbox, p->out_states, &s->e=
ntry);
        }
    }

If num_uclk_dpms and num_fclk_dpms can each be derived from the 30-element
input array, the combined insertions could exceed __DML_MAX_STATE_ARRAY_SIZ=
E__.

Inside insert_entry_into_table_sorted(), elements are shifted without a bou=
nds
check:

    for (i =3D table->num_states; i > index; i--) {
        table->state_array[i] =3D table->state_array[i - 1];
    }
    ...
    table->num_states++;

Could this write past the end of table->state_array if the total number of
inserted states across these loops exceeds 30?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606212503.1406=
38-1-listdansp@mail.ru?part=3D1
