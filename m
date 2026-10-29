Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BC3606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 06:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrzjCp8e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A5CB10E795;
	Thu, 29 Oct 2026 06:35:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53F8210E795
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:34:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ECC184336D;
 Thu, 29 Oct 2026 06:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA48F1F01825;
 Thu, 29 Oct 2026 06:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793255696;
 bh=CocfEAtZoZ8hXDbtZbwVWbae2AotZFcalk+tcoZRQ0g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JrzjCp8emiIXV/c6+bS/pvvShDyrCa+SeRfgTRKDOsIJElXoDt5VIphGcZmh1TEOW
 jq+xw0T3g2XaMHm4+V2msZKmORjAfFJPrgUbi5/erBVPyGlU06iVIqShnUiknqj+rh
 Iuiy3acZG/Sryi1NMcrcMM6AwbJGBijgjN0L5QA8pwjEs4iycRjMrz8S4CGgKSUGQ5
 DJtEqCvgfPfrRGzsBw5rYmWwKEImkL11uAQw0DrgTLRp2ntPKr08gCGmZH5x8CmEjV
 iqJrYrm5kkhua5CA3no9WeqPCZNxITMhGhEt20EE4U6ECDlL2+PpXVqQLgClgYBHJa
 zCtqI2YpBdQVA==
Message-ID: <sashiko-outbox-188824@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] drm/imagination: Limit access to the META
 firmware interface
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-prep-meta-fw-arch-independent-v2-4-b9f5d69b7a52@imgtec.com>
References: <20261029-prep-meta-fw-arch-independent-v2-0-b9f5d69b7a52@imgtec.com>
 <20261029-prep-meta-fw-arch-independent-v2-4-b9f5d69b7a52@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 06:34:56 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/imagination: inverted PVR_FEATURE_VALUE() check in layout_is_m=
ars()
- [High] drm/imagination: wrong default in must_wait_fw_idle_before_stop()
--

commit 37bd66d7d521adbf18d35a370cc34ba7ca02c2dd
Author: Alessio Belle <alessio.belle@imgtec.com>

drm/imagination: Limit access to the META firmware interface

This commit abstracts META firmware-specific operations behind struct
pvr_fw_defs callbacks and properties so that pvr_fw_startstop.c no longer
accesses the META firmware interface directly. It also renames
pvr_rogue_meta.h to pvr_rogue_meta_internal.h and removes pvr_fw_meta.h.

> diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagi=
nation/pvr_fw.h
> index 4b25291135b69..610406668bbb2 100644
> --- a/drivers/gpu/drm/imagination/pvr_fw.h
> +++ b/drivers/gpu/drm/imagination/pvr_fw.h
> @@ -184,6 +184,23 @@ struct pvr_fw_defs {
>  	 */
>  	void (*irq_clear)(struct pvr_device *pvr_dev);
> =20
> +	/**
> +	 * @must_wait_fw_idle: Check if the FW stop sequence should wait for ha=
rdware
> +	 *                     to report FW idle before proceeding.
> +	 *
> +	 * @pvr_dev: Target PowerVR device.
> +	 * @wait[out]: Whether the FW stop sequence should wait for FW idle.
> +	 *
> +	 * This function is optional. The assumption is that we must always wait
> +	 * for the firmware to reach idle; implement this function and return
> +	 * %false to alter this behavior.
> +	 *
> +	 * Returns:
> +	 *  * 0 on success.
> +	 *  * Any appropriate error on failure.
> +	 */
> +	int (*must_wait_fw_idle)(struct pvr_device *pvr_dev, bool *wait);

[ ... ]

> diff --git a/drivers/gpu/drm/imagination/pvr_fw_startstop.c b/drivers/gpu=
/drm/imagination/pvr_fw_startstop.c
> index 98ca2692239d0..9a617f78256ed 100644
> --- a/drivers/gpu/drm/imagination/pvr_fw_startstop.c
> +++ b/drivers/gpu/drm/imagination/pvr_fw_startstop.c

[ ... ]

> @@ -199,6 +197,30 @@ pvr_fw_start(struct pvr_device *pvr_dev)
>  	return err;
>  }
> =20
> +static inline bool layout_is_mars(struct pvr_device *pvr_dev)
> +{
> +	u64 layout_mars_value =3D 0;
> +
> +	if (PVR_FEATURE_VALUE(pvr_dev, layout_mars, &layout_mars_value))
> +		return layout_mars_value > 0;
> +
> +	return false;
> +}

[Severity: High]
Is the PVR_FEATURE_VALUE() check inverted in layout_is_mars()?

In drivers/gpu/drm/imagination/pvr_device.h, PVR_FEATURE_VALUE() returns 0
when the feature is present and -EINVAL when it is absent:

#define PVR_FEATURE_VALUE(pvr_dev, feature, value_out)             \
	({                                                         \
		struct pvr_device *_pvr_dev =3D pvr_dev;             \
		int _ret =3D -EINVAL;                                \
		if (_pvr_dev->features.has_##feature) {            \
			*(value_out) =3D _pvr_dev->features.feature; \
			_ret =3D 0;                                  \
		}                                                  \
		_ret;                                              \
	})

Prior to this change, pvr_fw_stop() checked PVR_FEATURE_VALUE(...) =3D=3D 0.
Without the =3D=3D 0 comparison, layout_is_mars() returns false when
has_layout_mars is true (since PVR_FEATURE_VALUE() returns 0), and also
returns false when has_layout_mars is false (since layout_mars_value remains
0).

As a result, when pvr_fw_stop() calls layout_is_mars(), layout_mars is
always false, causing pvr_fw_stop() on cores with the layout_mars feature to
poll powered-down ROGUE_CR_SIDEKICK_IDLE and ROGUE_CR_SLC_IDLE registers and
skip polling ROGUE_CR_MARS_IDLE before asserting ROGUE_CR_SOFT_RESET.

> +
> +static inline int must_wait_fw_idle_before_stop(struct pvr_device *pvr_d=
ev)
> +{
> +	bool wait_fw_idle =3D false;
> +	int err;
> +
> +	if (pvr_dev->fw_dev.defs->must_wait_fw_idle) {
> +		err =3D pvr_dev->fw_dev.defs->must_wait_fw_idle(pvr_dev, &wait_fw_idle=
);
> +		if (err)
> +			return err;
> +	}
> +
> +	return wait_fw_idle;
> +}

[Severity: High]
Should wait_fw_idle be initialized to true instead of false in
must_wait_fw_idle_before_stop()?

The kernel-doc for must_wait_fw_idle in struct pvr_fw_defs states that the
callback is optional and that waiting for the firmware to reach idle is the
default behavior when it is not implemented. Neither pvr_fw_defs_mips in
drivers/gpu/drm/imagination/pvr_fw_mips.c nor pvr_fw_defs_riscv in
drivers/gpu/drm/imagination/pvr_fw_riscv.c implements must_wait_fw_idle.

Because wait_fw_idle defaults to false here, calling pvr_fw_stop() ->
must_wait_fw_idle_before_stop() on MIPS or RISC-V devices returns 0, causing
pvr_fw_stop() to skip polling ROGUE_CR_SIDEKICK_IDLE for
ROGUE_CR_SIDEKICK_IDLE_GARTEN_EN before asserting ROGUE_CR_SOFT_RESET,
whereas previously skip_garten_idle defaulted to false.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-prep-meta-=
fw-arch-independent-v2-0-b9f5d69b7a52@imgtec.com?part=3D4
