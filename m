Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C5606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EmyjtgLt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FFA510E09A;
	Wed, 25 Nov 2026 23:35:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C11F10E09A
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 23:35:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2BD0445CFF;
 Wed, 25 Nov 2026 23:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB701F000D2;
 Wed, 25 Nov 2026 23:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795649710;
 bh=YyWbETJT4I8eCtorWLX5GpUCh/yG43sJOaCPF6vW89c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EmyjtgLthjcOn6jSfi2j8xZ2wgiRuFHi51PAFfXwX2TErp46W669gpKxApoO6l4WH
 Zp1Z0uNLca1lUlcNCYziuoULUfUhBIHZgzHZKM+E1D4CSVQnx/k4CaAwGHNeL249sw
 N0zkB0a8UwXG3J0H/n/f7LHlOL4VUg6QfsMdp10wwT7/8e7mc3us3cYQT3pbY0vN/N
 vwMTJbU2CQstbApz6U/PpCClksH2z+/EzPlXwmDlGJFnLbInIA3rGNETVO5mDYhQ5j
 eyrRVbo8jwdjOGbo0J9nGPsdgNWDBZKbmgJi3UVDn/yDL+Sbk3DgfXK9Ekluc2cRnS
 AJuOKwZHrbANw==
Message-ID: <sashiko-outbox-234407@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/imagination: Don't wait for a running META to
 idle on a hard reset
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261125-rbrue-suez-pvr-reset-recovery-v1-2-2cea8b163e7e@gmail.com>
References: <20261125-rbrue-suez-pvr-reset-recovery-v1-0-2cea8b163e7e@gmail.com>
 <20261125-rbrue-suez-pvr-reset-recovery-v1-2-2cea8b163e7e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 23:35:09 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/imagination: pvr_fw_stop() called with hard_reset=3Dfalse
  on boot failure
- [Medium] drm/imagination: unnecessary META slave port read on hard
  reset
--

commit 1ab35810cce4163d613799da01f5a15168d56036
Author: Ryan Brue <ryanbrue.dev@gmail.com>

drm/imagination: Don't wait for a running META to idle on a hard reset

This patch adds a hard_reset parameter to pvr_fw_stop() and the
must_wait_fw_idle() callback so META firmware stops skip waiting for the
Garten wrapper to report idle when the firmware was not asked to idle
first.

> diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagi=
nation/pvr_fw.c
> index d620141b5df03..d75fa3e4c5759 100644
> --- a/drivers/gpu/drm/imagination/pvr_fw.c
> +++ b/drivers/gpu/drm/imagination/pvr_fw.c
> @@ -976,7 +976,7 @@ pvr_fw_init(struct pvr_device *pvr_dev)
>  	return 0;
> =20
>  err_fw_stop:
> -	pvr_fw_stop(pvr_dev);
> +	pvr_fw_stop(pvr_dev, false);
> =20
>  err_destroy_structures:
>  	pvr_fw_destroy_structures(pvr_dev);

[Severity: Medium]
Should pvr_fw_stop() be called with hard_reset set to true here and in
pvr_power_fw_enable() when pvr_wait_for_fw_boot() fails?

Neither error path requests the firmware to idle before calling
pvr_fw_stop().  If META is running or stuck during early boot, the Garten
wrapper stays busy, causing pvr_fw_stop() to time out on
ROGUE_CR_SIDEKICK_IDLE_GARTEN_EN and return before asserting
ROGUE_CR_SOFT_RESET.  pvr_fw_init() ignores that return value and tears
down the firmware memory mappings and kernel_vm_ctx while META is still out
of soft reset.

[ ... ]

> diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/=
imagination/pvr_fw_meta.c
> index 41f5e9ddc7f0e..19baea23c4340 100644
> --- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
> +++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
> @@ -562,7 +562,7 @@ pvr_meta_irq_clear(struct pvr_device *pvr_dev)
>  }
> =20
>  static int
> -pvr_meta_must_wait_fw_idle(struct pvr_device *pvr_dev, bool *wait)
> +pvr_meta_must_wait_fw_idle(struct pvr_device *pvr_dev, bool hard_reset, =
bool *wait)
>  {
>  	u32 reg_value;
>  	int err;
> @@ -574,8 +574,10 @@ pvr_meta_must_wait_fw_idle(struct pvr_device *pvr_de=
v, bool *wait)
>  	/*
>  	 * Wait for Sidekick/Jones to signal IDLE including the Garten
>  	 * Wrapper if there is no debugger attached (TxVECINT_BHALT =3D 0x0).
> +	 * A META that was not asked to idle (hard reset) keeps the Garten
> +	 * Wrapper busy; the soft reset that follows stops it.
>  	 */
> -	*wait =3D !reg_value;
> +	*wait =3D !reg_value && !hard_reset;
> =20
>  	return 0;
>  }

[Severity: Medium]
Can pvr_meta_must_wait_fw_idle() skip the pvr_meta_cr_read32() call when
hard_reset is true?

When hard_reset is true, *wait is unconditionally false, so reg_value is
unused.  Performing the slave-port read anyway polls
ROGUE_CR_META_SP_MSLVCTRL1 for READY_EN and GBLPORT_IDLE_EN; if a hung META
processor leaves the slave or global port stalled, pvr_meta_cr_read32()
times out and aborts the hard reset before ROGUE_CR_SOFT_RESET is asserted,
marking the device lost.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-rbrue-suez=
-pvr-reset-recovery-v1-0-2cea8b163e7e@gmail.com?part=3D2
