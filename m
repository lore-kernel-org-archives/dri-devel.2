Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328E5C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CF4610E875;
	Mon, 13 Jul 2026 08:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dfh6dTLQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B11410E875
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:54:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 89937600AA;
 Mon, 13 Jul 2026 08:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E511F000E9;
 Mon, 13 Jul 2026 08:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783932865;
 bh=8yzZREdWATD1G3YfDklpgIfhCrTVBYhEq8Pd5yEPdCI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Dfh6dTLQyCnsZzD1qH9uXdIJEIS8I1bpc49rzhH3n0r2HsLgjvh6T2y/XTgiRBSjO
 7H6CUqqfzlxtOh7vkqRG7SEQ8KXAjPXtJHZs2W+l4Iho6N3lbSsrKqwDjoAVZfCrxi
 CRzB6F5gJeEM3+n47n1sacqRgY7KHKElMaOGgvmiJORo7CRgryvGNvblPtrtK1BVnc
 eaMuJr2YzT0VGehLF8QZWBX1K4n5CZGTNflH7oWVuR35UQD+u9ySkOl0lrr7F9gb1T
 Um2mRlhkKqI7cERoE2/2zmawTJmLCQ10rvMyJLIEH62JSWyONXgDB9zi7y8mNkZWSQ
 9meq9tE46Wetw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/4] drm/xe: Handle PUNIT errors by requesting
 cold-reset recovery
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713083939.251872-10-mallesh.koujalagi@intel.com>
References: <20260713083939.251872-6-mallesh.koujalagi@intel.com>
 <20260713083939.251872-10-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 08:54:24 +0000
Message-Id: <20260713085425.15E511F000E9@smtp.kernel.org>
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
- [High] Unprotected modification and TOCTOU race on `xe->wedged.method` wh=
en declaring a wedge state.
--

--- Patch [4]: [PATCH v10 4/4] drm/xe: Handle PUNIT errors by requesting co=
ld-reset recovery ---
commit ee614ec29f76518d52ca16432516d10ff5da4e57
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm/xe: Handle PUNIT errors by requesting cold-reset recovery

When PUNIT (power management unit) errors are detected that persist across
warm resets, mark the device as wedged with DRM_WEDGE_RECOVERY_COLD_RESET
and notify userspace that a complete device power cycle is required to
restore normal operation.

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 3d39bb95e94d6..cc2a0e59dedf5 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -194,6 +194,12 @@ static void ras_usp_aer_init(struct xe_device *xe)
>  	dev_dbg(&usp->dev, "Uncorrectable Internal Errors downgraded and unmask=
ed\n");
>  }
> =20
> +static void punit_error_handler(struct xe_device *xe)
> +{
> +	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
> +	xe_device_declare_wedged(xe);
> +}
> +

[Severity: High]
This is a pre-existing issue, but is there a race condition between setting
the wedge method here and other threads declaring the device wedged?

If a PUNIT error causes concurrent GPU hangs, the GT hang recovery worker
(Thread B) might call xe_device_declare_wedged() concurrently with the RAS
interrupt handler (Thread A) calling punit_error_handler().

Thread B could read xe->wedged.method before Thread A writes it:

Thread B in xe_device_declare_wedged():
    if (!xe->wedged.method) {
        // Thread B evaluates this as true

Thread A in punit_error_handler():
    xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);

Thread B in xe_device_declare_wedged():
        xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_REBIND |
                                        DRM_WEDGE_RECOVERY_BUS_RESET);
    }

Since the read-then-write of xe->wedged.method is lockless, Thread B can
overwrite the DRM_WEDGE_RECOVERY_COLD_RESET requested by Thread A with the
default method.=20

Could this cause the device to fail recovery by missing the required cold
reset, and does xe->wedged.method need synchronization?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713083939.2518=
72-6-mallesh.koujalagi@intel.com?part=3D4
