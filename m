Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30471606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOXrHncf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CEFC10E5E3;
	Fri, 30 Oct 2026 17:24:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACBCD10E5E3;
 Fri, 30 Oct 2026 17:24:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2FF7560627;
 Fri, 30 Oct 2026 17:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B404F1F00A02;
 Fri, 30 Oct 2026 17:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793381078;
 bh=ucmDNmRp4I0EnV1O5xCh+/IyZLsHQI/BklU8qdOxZyM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fOXrHncf2LyStbkhg/Hfm44SOT4pjvF10K7C4GfLJtcGaWo0iYVLdF9A+aoYeYf7F
 QTGEZqePrerB6DR64rXpLi3VjeApBLwUpxxbxAvIhPwlhhBfve2RLpVkUjIsYZmc1L
 o01tt/O/Mn07TcIKvDkfGjPW8Cy9o7L64TArepl3mifeoHT0e8i59+2BqMK522SjsF
 MlT9OoHv4Js14BuvNSPZ9R89NfxTcVRfWxsVtPbVoUOAHZs3FEZn2Ghpo+z/TEvD3G
 ef0Q7jpFSv41Frzj8cLnF+ZEyY+pb8wGyvahfi8jv3UzlejF9RqQSufkRgY90Wp1wr
 BmZj0w3Lcboaw==
Message-ID: <sashiko-outbox-191334@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
To: "Alan Previn" <alan.previn.teres.alexis@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030171738.674775-2-alan.previn.teres.alexis@intel.com>
References: <20261030171738.674775-2-alan.previn.teres.alexis@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:24:38 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/xe: duplicate and false logs in xe_survivability_mode_is_req=
uested()
--

commit ba1b85f1f1a898ddfee38c1e881310a987970b44
Author: Alan Previn <alan.previn.teres.alexis@intel.com>

drm/xe/survivability: broadcast dmesg when engaging survivability

This commit adds kernel log messages to xe_survivability_mode_is_requested()
when boot survivability mode is requested via configfs or when PCODE_SCRATC=
H(0)
reports a boot failure.

> diff --git a/drivers/gpu/drm/xe/xe_survivability_mode.c b/drivers/gpu/drm=
/xe/xe_survivability_mode.c
> index 45d44ebe288b4..3eebb69728c3f 100644
> --- a/drivers/gpu/drm/xe/xe_survivability_mode.c
> +++ b/drivers/gpu/drm/xe/xe_survivability_mode.c
> @@ -412,13 +412,19 @@ bool xe_survivability_mode_is_requested(struct xe_d=
evice *xe)
> =20
>  	survivability_mode =3D xe_configfs_get_survivability_mode(pdev);
>  	/* Enable survivability mode if set via configfs */
> -	if (survivability_mode)
> +	if (survivability_mode) {
> +		xe_log_info(xe, SURVIVABILITY, "Boot mode requested.");
>  		return true;
> +	}
> =20
>  	data =3D xe_mmio_read32(mmio, PCODE_SCRATCH(0));
>  	survivability->boot_status =3D REG_FIELD_GET(BOOT_STATUS, data);
> =20
> -	return check_boot_failure(xe);
> +	if (check_boot_failure(xe)) {
> +		xe_log_err_fatal(pdev, SURVIVABILITY, 0, "Boot Mode enabled!\n");
> +		return true;
> +	}
> +	return false;
>  }

[Severity: Medium]
Does logging inside xe_survivability_mode_is_requested() cause duplicate and
premature messages in dmesg?

During probe, xe_device_probe_early() calls
xe_survivability_mode_is_requested() in the condition and then calls
xe_survivability_mode_boot_enable(), which calls
xe_survivability_mode_is_requested() a second time:

drivers/gpu/drm/xe/xe_device.c:xe_device_probe_early() {
	...
	err =3D xe_pcode_probe_early(xe);
	if (err || xe_survivability_mode_is_requested(xe)) {
		int save_err =3D err;
		...
		err =3D xe_survivability_mode_boot_enable(xe);
}

drivers/gpu/drm/xe/xe_survivability_mode.c:xe_survivability_mode_boot_enabl=
e() {
	...
	if (!xe_survivability_mode_is_requested(xe))
		return 0;
}

When xe_pcode_probe_early() returns 0 (for example, when survivability mode=
 is
enabled via configfs), xe_survivability_mode_is_requested() runs twice back=
 to
back and emits the log message twice. Also, "Boot mode requested." is missi=
ng a
trailing newline.

For the check_boot_failure(xe) path, enable_boot_survivability_mode() alrea=
dy
logs the exact same message once boot survivability mode has actually been
initialized:

drivers/gpu/drm/xe/xe_survivability_mode.c:enable_boot_survivability_mode()=
 {
	...
	if (check_boot_failure(xe))
		xe_log_err_fatal(pdev, SURVIVABILITY, 0, "Boot Mode enabled!\n");
	else
		xe_log_info(pdev, SURVIVABILITY, "Boot Mode enabled!\n");

	return 0;

failed:
	xe_log_err_fatal(pdev, SURVIVABILITY, ret, "Failed to enable Boot Mode!\n"=
);
	survivability->mode =3D false;
	return ret;
}

Logging "Boot Mode enabled!\n" inside xe_survivability_mode_is_requested() =
not
only duplicates the message in enable_boot_survivability_mode(), but also
reports that boot mode is enabled before initialization has happened. If
xe_survivability_mode_boot_enable() aborts with -ENXIO (when
survivability->version < 2 and boot_status is CRITICAL_FAILURE) or if
enable_boot_survivability_mode() fails in create_survivability_sysfs(),
xe_nvm_init(), or xe_i2c_probe(), dmesg will falsely report "Boot Mode
enabled!" before failing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030171738.6747=
75-2-alan.previn.teres.alexis@intel.com?part=3D1
