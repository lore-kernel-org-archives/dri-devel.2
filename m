Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC49C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F5710E2F2;
	Tue, 21 Jul 2026 08:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CNSRTYB0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B3E10E2F2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:26:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5F23F43C2C;
 Tue, 21 Jul 2026 08:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187AC1F000E9;
 Tue, 21 Jul 2026 08:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784622388;
 bh=VPisdqhkKdwwGJuwDR74GB72txaBKs2Y+6YK82UT2Lk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CNSRTYB0nzUgy/2mK1+MNGgmtnoMgiNsWbvfOHzlSlNb+k6HTbqk3Bx9BgW58cE1h
 Ep39nj+DundkCddOkCsA52FTq05HrvknOUATatB0pR5qevmDLuS4LXzw3YYkROL3Kn
 UYauns9Sq4CXrC9vhkWE0l4ocPS2t3KApRNgQVyObDwrpBMAacuhB3+KKHqymWQ4rM
 5EeKqBgDZ1aSooLtPKujy1hFCZR9Javw+X14rtA4aIIz9dGNChPs/MED4emo3rSU/z
 EEzTQZLCMEYxib9YJBWbnq74AGhdsQFlN0nsHApmHB4j2yDEYrwZik+BphYdiCGfsP
 rU9lm74PJsE5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] drm/xe/xe_ras: Report correctable error events
 to userspace
To: "Riana Tauro" <riana.tauro@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720082208.2648279-7-riana.tauro@intel.com>
References: <20260720082208.2648279-5-riana.tauro@intel.com>
 <20260720082208.2648279-7-riana.tauro@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 08:26:27 +0000
Message-Id: <20260721082628.187AC1F000E9@smtp.kernel.org>
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
- [High] Missing bounds check on the hardware-provided `component` value be=
fore using it in the `BIT(component)` macro, leading to undefined behavior =
(shift out of bounds) and failure of the deduplication logic.
--

--- Patch [2]: [PATCH v5 2/3] drm/xe/xe_ras: Report correctable error event=
s to userspace ---
commit 5a086f0455803475a13c848290347fe3571d79fa
Author: Riana Tauro <riana.tauro@intel.com>

drm/xe/xe_ras: Report correctable error events to userspace

When an interrupt indicates the error counter has crossed its threshold,
this commit reads the current counter value and delivers a drm_ras error
event to userspace. It also attempts to send the error event only once
per component.

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index ed609912fda14..cf85075d62667 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
[ ... ]
> @@ -241,8 +293,10 @@ void xe_ras_counter_threshold_crossed(struct xe_devi=
ce *xe,
>  	struct xe_ras_threshold_crossed *pending =3D (void *)&response->data;
>  	struct xe_ras_error_class *errors =3D pending->counters;
>  	u32 id, ncounters =3D pending->ncounters;
> +	u8 sent =3D 0;
> =20
>  	BUILD_BUG_ON(sizeof(response->data) < sizeof(*pending));
> +	BUILD_BUG_ON(BITS_PER_TYPE(sent) < XE_RAS_COMP_MAX);
>  	xe_device_assert_mem_access(xe);
> =20
>  	if (!ncounters || ncounters > XE_RAS_NUM_COUNTERS)
> @@ -256,8 +310,21 @@ void xe_ras_counter_threshold_crossed(struct xe_devi=
ce *xe,
>  		severity =3D errors[id].common.severity;
>  		component =3D errors[id].common.component;
> =20
> +		if (severity !=3D XE_RAS_SEV_CORRECTABLE) {
> +			xe_warn(xe, "sysctrl: unexpected severity %s (%u)\n", sev_to_str(seve=
rity),
> +				severity);
> +			continue;
> +		}
> +
>  		xe_warn(xe, "[RAS]: %s %s detected\n",
>  			comp_to_str(component), sev_to_str(severity));
> +
> +		/* Send event once per component */
> +		if (sent & BIT(component))
> +			continue;
> +		sent |=3D BIT(component);

[Severity: High]
Since component comes directly from the firmware response in
errors[id].common.component, could this cause a shift out of bounds or
truncation if the firmware sends an unexpected component ID?

If component >=3D 8, BIT(component) evaluates to 256 or larger. When this is
bitwise-ORed into the u8 sent mask, it truncates to 0 and the deduplication
logic fails. If component >=3D 64, this will trigger a shift out of bounds.

Should there be a bounds check against XE_RAS_COMP_MAX before using the
component value in the BIT() macro?

> +
> +		ras_send_error_event(xe, severity, component);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720082208.2648=
279-5-riana.tauro@intel.com?part=3D2
