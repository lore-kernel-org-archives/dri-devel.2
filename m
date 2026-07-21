Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B16C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A98910E2FA;
	Tue, 21 Jul 2026 08:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eRX09FZv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22C6C10E2F2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:26:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0BBD843C2C;
 Tue, 21 Jul 2026 08:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26941F000E9;
 Tue, 21 Jul 2026 08:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784622388;
 bh=NB7qfUsWpqsGUBwgkmUbcVZib1AiT0VCXSOuorX/VTA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eRX09FZvu+MH4RES2qXMkwhCCrDbPDi7z+ynE+DVwxRB41hEHQ0pwqdhobJAZk9FO
 wn4Hsjn+RCOXeSethLA7zTdUZw3WjglRKG2DVxF4Wpp36neBk0OoTi8yQtb11vdxn3
 wN06aRWz7zXzAtaiiWo2Y/NF74JPLrOr70oAR8w5Cc6scHpxGNOo8NvQmOxPhnCcHE
 zm5LRUOssivgDvW/gqowpkcxr5gDogJbOVMS76yJSVu/sFESVRR8PJzhU/YJ5iVvWg
 ITj7HucLaJnnHfRVIjCdfRR5BUGFAcC2ivNbwlqZFuwPy3fhKqCsxRGawxlKF60XT2
 OmcScWMpYjyHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] drm/xe/xe_ras: Report uncorrectable error events
 to userspace
To: "Riana Tauro" <riana.tauro@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720082208.2648279-8-riana.tauro@intel.com>
References: <20260720082208.2648279-5-riana.tauro@intel.com>
 <20260720082208.2648279-8-riana.tauro@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 08:26:28 +0000
Message-Id: <20260721082628.C26941F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Synchronous mailbox commands injected during an active pagination =
loop disrupt stateful firmware communication.
- [Medium] Unvalidated firmware-provided `component` ID is used in the `BIT=
()` macro, leading to out-of-bounds shifts (Undefined Behavior) and truncat=
ion that breaks deduplication.
- [Medium] Errors of different severities for the same component are incorr=
ectly collapsed, masking critical hardware errors.
--

--- Patch [3]: [PATCH v5 3/3] drm/xe/xe_ras: Report uncorrectable error eve=
nts to userspace ---
commit 51a0403024c186a2a443b450caaf0da16723e651
Author: Riana Tauro <riana.tauro@intel.com>

drm/xe/xe_ras: Report uncorrectable error events to userspace

When the firmware reports uncorrectable errors, this patch delivers a
drm-ras error event to userspace for each affected component. Multiple
errors for the same component are collapsed to avoid duplicate events.

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index cf85075d62667..462cbb548f07b 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -378,6 +378,7 @@ enum xe_ras_recovery_action xe_ras_process_errors(str=
uct xe_device *xe)
>  	enum xe_ras_recovery_action final_action;
>  	u32 remaining =3D XE_SYSCTRL_FLOOD_LIMIT;
>  	struct xe_ras_get_soc_error response;
> +	u8 sent =3D 0;

[ ... ]

> @@ -421,6 +422,12 @@ enum xe_ras_recovery_action xe_ras_process_errors(st=
ruct xe_device *xe)
>  			xe_info(xe, "[RAS]: %s %s detected\n", comp_to_str(component),
>  				sev_to_str(severity));
> =20
> +			/* Send event once per component */
> +			if (!(sent & BIT(component))) {
> +				sent |=3D BIT(component);

[Severity: Medium]
Is there a risk of undefined behavior or truncation here if the firmware
returns an unexpected component ID?

Since sent is a u8, any component value of 8 or greater will cause
BIT(component) to be truncated to 0 when bitwise OR'ed with sent. The
condition !(sent & BIT(component)) would then constantly evaluate to
true, bypassing the duplicate suppression.

Also, if component is greater than or equal to BITS_PER_LONG, BIT()
will cause an out-of-bounds shift. Should component be validated against a
maximum value before using it in the bit shift?

[Severity: Medium]
Does this deduplication logic unintentionally mask uncorrectable errors if
multiple errors for the same component arrive with different severities?

If the firmware responds with a correctable error followed by an
uncorrectable error for the exact same component, the first error sets
the bit in the sent mask. The subsequent uncorrectable error would then
be skipped, and userspace would only be notified of the correctable
severity.

> +				ras_send_error_event(xe, severity, component);

[Severity: High]
Can calling ras_send_error_event() here disrupt the firmware's pagination
state?

The xe_ras_process_errors() function retrieves errors using a stateful
XE_SYSCTRL_CMD_GET_SOC_ERROR command inside a do-while loop based on
response.additional_errors.

However, ras_send_error_event() synchronously sends a different mailbox
command (XE_SYSCTRL_CMD_GET_COUNTER):

xe_ras.c:ras_send_error_event() {
    ...
    ret =3D get_counter(xe, &counter, &value);
    ...
}

If xe_sysctrl_send_command() releases its mutex between calls, injecting
this GET_COUNTER command into the GET_SOC_ERROR pagination stream on the
wire might reset or corrupt the firmware's internal cursor. This could lead
to dropped errors or an infinite loop reading the same initial chunk.

> +			}
> +
>  			switch (component) {
>  			case XE_RAS_COMP_CORE_COMPUTE:
>  				action =3D handle_core_compute_errors(arr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720082208.2648=
279-5-riana.tauro@intel.com?part=3D3
