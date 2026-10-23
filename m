Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98F606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDK81P6p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E5810E526;
	Fri, 23 Oct 2026 00:28:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C97F711293E;
 Fri, 23 Oct 2026 00:27:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DA291601E4;
 Fri, 23 Oct 2026 00:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5354C1F01825;
 Fri, 23 Oct 2026 00:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792715273;
 bh=Oi1PI4bdB5X5fw3LU6m2xc6UWlSgbkSjWc+vLKvtDhQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jDK81P6ps6MyRwbWFq53ZdpzajUKx6XmWAqNypT43Jg40RhimSe6fYjQRK3GLIuk7
 6J0YlCShWGE7RGMCMiMDnpfw5jNh/EcfquPWL99XJbYYVFCwiOcI9t1jByn3AXdC25
 vlZyAmxPjBsIW384/STH623rqC4LF0PEDO8dLDgA10wNUbWA/xmYZ5s5xBuQbryAkb
 hGXPWdKbkx7foyBhmfpPqwU/2xuVwzmCToi39J21yLcW8cqHagG5LFYoXjFrOy5HkF
 H96L6KBq2YPYYTCYiPbcVQ2MIHg47NyDnXbAq0xGNRF5OXLkjlPvPztXiRYgnkybOE
 CMgAmxIkAdMjA==
Message-ID: <sashiko-outbox-182172@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
To: "Alan Previn" <alan.previn.teres.alexis@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261023001827.170645-2-alan.previn.teres.alexis@intel.com>
References: <20261023001827.170645-2-alan.previn.teres.alexis@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 00:27:52 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/xe: unreachable branch and wrong log in xe_device_probe_earl=
y()
--

commit 9d8c24e19d32b177027b35cc906adcdcf29823ef
Author: Alan Previn <alan.previn.teres.alexis@intel.com>

drm/xe/survivability: broadcast dmesg when engaging survivability

This commit adds dmesg logging in xe_device_probe_early() when the driver
encounters early pcode errors or when survivability mode is requested.

> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_devic=
e.c
> index e1979bbcf7bc6..49df992253a9a 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -702,7 +702,8 @@ static int xe_device_vram_alloc(struct xe_device *xe)
>   */
>  int xe_device_probe_early(struct xe_device *xe)
>  {
> -	int err;
> +	int err, pcode_err;
> +	bool survival_requested;
> =20
>  	xe_wa_device_init(xe);
>  	xe_wa_process_device_oob(xe);
> @@ -726,20 +727,37 @@ int xe_device_probe_early(struct xe_device *xe)
>  	 * initialization is complete. Until done, any MMIO or lmem access from
>  	 * the driver will be blocked
>  	 */
> -	err =3D xe_pcode_probe_early(xe);
> -	if (err || xe_survivability_mode_is_requested(xe)) {
> -		int save_err =3D err;
> -
> +	pcode_err =3D xe_pcode_probe_early(xe);
> +	survival_requested =3D xe_survivability_mode_is_requested(xe);
> +	if (pcode_err || survival_requested) {
>  		/*
>  		 * Try to leave device in survivability mode if device is
>  		 * possible, but still return the previous error for error
>  		 * propagation
>  		 */
> -		err =3D xe_survivability_mode_boot_enable(xe);
> -		if (err)
> -			return err;
> -
> -		return save_err;
> +		int survive_err =3D xe_survivability_mode_boot_enable(xe);
> +
> +		if (survive_err) {
> +			if (pcode_err && survival_requested)
> +				xe_err(xe, "Early pcode err(%pe), survivability requested but unavai=
lable(%pe)\n",
> +				       ERR_PTR(pcode_err), ERR_PTR(survive_err));
> +			else if (!pcode_err)
> +				xe_warn(xe, "Early pcode ok, survivability requested but unavailable=
(%pe)\n",
> +					ERR_PTR(survive_err));
> +			else
> +				xe_warn(xe, "Early pcode err(%pe), survivability not requested and u=
navailable(%pe)\n",
> +					ERR_PTR(pcode_err), ERR_PTR(survive_err));
> +			return survive_err;
> +		}
> +		if (pcode_err && survival_requested)
> +			xe_notice(xe, "Early pcode err(%pe), survivability requested\n",
> +				  ERR_PTR(pcode_err));
> +		else if (!pcode_err)
> +			xe_notice(xe, "Early pcode ok but survivability requested\n");
> +		else
> +			xe_warn(xe, "Early pcode err(%pe), survivability not requested. Consi=
der xe_configfs\n",
> +				ERR_PTR(pcode_err));

[Severity: Medium]
Can the first else branch inside if (survive_err) ever be reached, and does
the second else branch log a misleading message on unsupported platforms?

In drivers/gpu/drm/xe/xe_survivability_mode.c,
xe_survivability_mode_boot_enable() immediately re-checks
xe_survivability_mode_is_requested(xe) and returns 0 when it is false:

int xe_survivability_mode_boot_enable(struct xe_device *xe)
{
	struct xe_survivability *survivability =3D &xe->survivability;
	struct pci_dev *pdev =3D to_pci_dev(xe->drm.dev);

	if (!xe_survivability_mode_is_requested(xe))
		return 0;

And xe_survivability_mode_is_requested() returns false both when
survivability is not requested and when the platform or VF does not support
survivability mode:

bool xe_survivability_mode_is_requested(struct xe_device *xe)
{
	...
	if (!IS_DGFX(xe) || IS_SRIOV_VF(xe) || xe->info.platform < XE_BATTLEMAGE)
		return false;

Because xe_survivability_mode_boot_enable() returns 0 whenever
xe_survivability_mode_is_requested() is false:

1. In xe_device_probe_early(), when pcode_err is non-zero and
   survival_requested is false, survive_err will be 0 (unless the redundant
   second call to xe_survivability_mode_is_requested() reads a changed
   configfs or PCODE_SCRATCH(0) state, in which case survivability was
   actually requested). That makes the "Early pcode err(%pe), survivability
   not requested and unavailable(%pe)" branch unreachable under normal
   execution.

2. On integrated GPUs, SR-IOV VFs, or dGPUs prior to XE_BATTLEMAGE where
   survivability mode is unsupported (and where xe_config_device_is_visible=
()
   in drivers/gpu/drm/xe/xe_configfs.c hides attr_survivability_mode), an
   early pcode failure will have survive_err =3D=3D 0 and survival_requeste=
d =3D=3D
   false, falling through to log "Consider xe_configfs" even though the
   survivability_mode configfs attribute is not available on that device.

Should xe_survivability_mode_boot_enable() or its helper distinguish between
"unsupported" and "not requested", and avoid calling
xe_survivability_mode_is_requested() twice?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023001827.1706=
45-2-alan.previn.teres.alexis@intel.com?part=3D1
