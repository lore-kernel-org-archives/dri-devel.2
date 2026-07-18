Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A637EC4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 13:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E304F10E110;
	Sat, 18 Jul 2026 13:59:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BF7QStXp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 271CA10E110
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 13:59:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B422B43243;
 Sat, 18 Jul 2026 13:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEC11F000E9;
 Sat, 18 Jul 2026 13:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784383163;
 bh=t/GHAD1tXbWCh1Sjgw2GnkkHZW0uxSYB7JLBpm5hi3A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BF7QStXp8ot+pcTc5qELUKaw9UtfINqSsxICJOwKl4vuR9NJobTukEbgAJ5/1C8bF
 P3MEefCsGZraQ9zcLTnjdbYyoquBWzQM4xfZtkMMD8//sP4zfJXCttDePjaKy6rC4/
 WABN/4JqUQJF6sJAzGFxz1PGXQ7kNcmAQYPdBJOlNTG4TRha/M9dwuJ38mDQh6tvEa
 7Edyp64RIvoLeQxz19J/hUaUrX20IFAjApfcB35KRThDRpa/gfq1vqGhppK2lfTbu5
 er7BDlE2JZaS2NfAUC67ul7vcdBk0cmkbTGMKCOol0Halc0Uxpul3ZXdIEfs4rxBHp
 Vlr0p8SlaM6zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/v3d: Idle AXI transactions before disabling the
 clock on suspend
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260718-v3d-pm-axi-transactions-v1-2-4ecd7729ed70@igalia.com>
References: <20260718-v3d-pm-axi-transactions-v1-0-4ecd7729ed70@igalia.com>
 <20260718-v3d-pm-axi-transactions-v1-2-4ecd7729ed70@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 13:59:22 +0000
Message-Id: <20260718135923.6AEC11F000E9@smtp.kernel.org>
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
- [High] Hardware quiescence timeouts are ignored, allowing the driver to c=
ut the clock while transactions are still in flight.
- [High] Direct assignment to the V3D_GMP_CFG register in v3d_idle_axi() cl=
obbers existing bits, breaking the newly introduced read-modify-write undo =
logic.
--

--- Patch [2]: [PATCH 2/2] drm/v3d: Idle AXI transactions before disabling =
the clock on suspend ---
commit 586b3ea31f7f24c40a5d3a66c4418d7273686a72
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Idle AXI transactions before disabling the clock on suspend

Currently, v3d_power_suspend() removes the GPU clock without first
quiescing the GPU's memory interface (AXI). If the clock is cut while the
core still has outstanding AXI transactions in flight, the hardware is
frozen mid-transaction. That corrupted state survives the power cycle, and
the first job submitted after the next resume will cause a GPU hang.

Link: https://github.com/raspberrypi/linux/issues/7443
Link: https://github.com/raspberrypi/linux/issues/7488

> diff --git a/drivers/gpu/drm/v3d/v3d_power.c b/drivers/gpu/drm/v3d/v3d_po=
wer.c
> index ade8e932fb9c5..f608e6d5516a1 100644
> --- a/drivers/gpu/drm/v3d/v3d_power.c
> +++ b/drivers/gpu/drm/v3d/v3d_power.c
> @@ -56,8 +56,15 @@ int v3d_power_suspend(struct device *dev)
> =20
>  	v3d_clean_caches(v3d);
> =20
> +	/* Wait until V3D has no active or pending AXI transactions. */
> +	v3d_idle_axi(v3d, 0);
> +	v3d_idle_gca(v3d);
> +

[Severity: High]
If v3d_idle_axi() times out, it logs an error but returns void:

v3d_idle_axi() {
    ...
    if (wait_for(... =3D=3D 0, 100)) {
        drm_err(&v3d->drm, "Failed to wait for safe GMP shutdown\n");
    }
}

Does this allow the suspend operation to blindly proceed and disable the cl=
ock
while AXI transactions are still in flight?

>  	ret =3D v3d_suspend_sms(v3d);
>  	if (ret) {
> +		/* Staying active: undo the GMP STOP_REQ from v3d_idle_axi(). */
> +		V3D_WRITE(V3D_GMP_CFG(v3d->ver),
> +			  V3D_READ(V3D_GMP_CFG(v3d->ver)) & ~V3D_GMP_CFG_STOP_REQ);

[Severity: High]
Since v3d_idle_axi() uses direct assignment to set V3D_GMP_CFG_STOP_REQ:

v3d_idle_axi() {
    ...
    V3D_WRITE(V3D_GMP_CFG(v3d->ver), V3D_GMP_CFG_STOP_REQ);
}

Does this clobber other bits in the register, making the read-modify-write
undo logic here write 0 and fail to restore the hardware's original
configuration?

>  		v3d_irq_enable(v3d);
>  		return ret;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718-v3d-pm-axi=
-transactions-v1-0-4ecd7729ed70@igalia.com?part=3D2
