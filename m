Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339DE606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9q9srRB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 941FA10E3C3;
	Wed, 28 Oct 2026 13:35:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D18C10E618
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 13:35:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A4F5F600C8;
 Wed, 28 Oct 2026 13:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2431F01825;
 Wed, 28 Oct 2026 13:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793194532;
 bh=c8ZOqCD+ppJxTo1p0bWKbH2yGrrudBvBUxK/CGdH3b0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J9q9srRBKUrtrxv5nn/ABKBFDnzXjq+LLGSkAZHrIUuv+pQ+f1qGwqalJhBqmFSAk
 tIXD5o/3O7MI2rSNPRn82fGFux+XwiGhMVK0KnZOUOeMLHQsLRJ90nLdrFmLw9rpm1
 yLMImuwqn+pYgjwODZNwrIL+TUmGKaBvv48Z/95jh3LjE2Br8a2W0/8vG/j2nX6JSX
 mC5Uokup9h3N6BNqiXMD2ip7N86HbPKgFuIt+r4IC6VCAO66hHnL8BZ71TtXVgguEv
 AwA1X+olh9n/0bN7/6IWoR6Mroi6p8L2mpjHvnzIxtnFS1jZqTTV0rOrIDTAEp3lZl
 1yE6Hg7HX3ZBQ==
Message-ID: <sashiko-outbox-187927@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] drm/imagination: Limit access to the META firmware
 interface
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261028-prep-meta-fw-arch-independent-v1-4-73e116f02172@imgtec.com>
References: <20261028-prep-meta-fw-arch-independent-v1-0-73e116f02172@imgtec.com>
 <20261028-prep-meta-fw-arch-independent-v1-4-73e116f02172@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 13:35:31 +0000
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
- [High] drm/imagination: wrong default wait_fw_idle in must_wait_fw_idle_b=
efore_stop()
--

commit 00700f5214fca29e9b17f38e573b7f84347d02b8
Author: Alessio Belle <alessio.belle@imgtec.com>

drm/imagination: Limit access to the META firmware interface

This commit restricts direct access to the META firmware interface by
routing all META-specific checks through struct pvr_fw_defs callbacks and
properties, removing pvr_fw_meta.h, and guarding pvr_rogue_meta_internal.h.

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
on success and -EINVAL when the feature is absent:

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

Previously, pvr_fw_stop() checked:

	if (PVR_FEATURE_VALUE(pvr_dev, layout_mars, &layout_mars_value) =3D=3D 0)
		layout_mars =3D layout_mars_value > 0;

Without the =3D=3D 0 check in layout_is_mars(), when features.has_layout_ma=
rs is
true, PVR_FEATURE_VALUE() returns 0 and the function falls through to return
false. When features.has_layout_mars is false, PVR_FEATURE_VALUE() returns
-EINVAL without modifying layout_mars_value (which remains 0), so
layout_mars_value > 0 also evaluates to false.

Doesn't this cause layout_is_mars() to always return false, making
pvr_fw_stop() poll the powered-down ROGUE_CR_SIDEKICK_IDLE and
ROGUE_CR_SLC_IDLE registers instead of ROGUE_CR_MARS_IDLE on GPUs with the
layout_mars feature?

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

The kernel-doc for struct pvr_fw_defs in drivers/gpu/drm/imagination/pvr_fw=
.h
states:

	 * This function is optional. The assumption is that we must always wait
	 * for the firmware to reach idle; implement this function and return
	 * %false to alter this behavior.

Neither pvr_fw_defs_mips nor pvr_fw_defs_riscv implements must_wait_fw_idle.
With wait_fw_idle initialized to false, calling pvr_fw_stop() ->
must_wait_fw_idle_before_stop() on MIPS or non-MARS RISC-V firmware
processors returns 0, which skips polling ROGUE_CR_SIDEKICK_IDLE for
ROGUE_CR_SIDEKICK_IDLE_GARTEN_EN before asserting ROGUE_CR_SOFT_RESET.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-prep-meta-=
fw-arch-independent-v1-0-73e116f02172@imgtec.com?part=3D4
