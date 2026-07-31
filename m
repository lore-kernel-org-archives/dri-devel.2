Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C172CC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 15:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2271C10F2E0;
	Fri, 31 Jul 2026 15:49:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EDo2zc4H";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF5B10F2E0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 15:49:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E04A407A2;
 Fri, 31 Jul 2026 15:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175DD1F000E9;
 Fri, 31 Jul 2026 15:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785512981;
 bh=hoGJaPvEENrM4dJNVffBB2N1uYxUhOKTy9iMhCUzZY4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EDo2zc4H+vYFI1jZZ2HaF44M4TtKIWSEgX3GxJZpHYMTjaEa5HcGQX0CQPPVQfynk
 WmSswxWnddE0awa8VducvcIV/uAnEJ8dWbV+WOEqbnifPUc/x6sARl1tqxOHmqiSXO
 ARfdEy8uV64U7ccsDYp0hb0XtMEec/RvC8buwbFWwJzIYv3AW/RLFvo3fuPwLgj063
 RZe4Spd/IvrgnVWTIhFLsjxSNP7eIGp9i3ylcPQKbm9SxtMbtCGWmBDkiV8Jp+x9Rv
 aOJ7GpN2iEoJ7lkHUUBHiCB57brnheTBcbKq1W60pgmID+Z0TB2qXcu3MQhJtWf+I5
 c0Fgk7kSbquzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/1] drm: use drm_warn() in
 validate_blend_mode_for_alpha_formats()
To: "Leandro Ribeiro" <leandro.ribeiro@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260731154232.37020-2-leandro.ribeiro@collabora.com>
References: <20260731154232.37020-1-leandro.ribeiro@collabora.com>
 <20260731154232.37020-2-leandro.ribeiro@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 15:49:40 +0000
Message-Id: <20260731154941.175DD1F000E9@smtp.kernel.org>
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

New issues:
- [Low] Missing trailing newline in drm_warn() format string.

Pre-existing issues:
- [High] Missing NULL check on the return value of drm_format_info() before=
 dereferencing it.
--

--- Patch [1]: [PATCH v2 1/1] drm: use drm_warn() in validate_blend_mode_fo=
r_alpha_formats() ---
commit e7f907e9d21d7af4bbeb8c955471b68c362de2e1
Author: Leandro Ribeiro <leandro.ribeiro@collabora.com>

drm: use drm_warn() in validate_blend_mode_for_alpha_formats()

This commit replaces a WARN() with drm_warn() in=20
validate_blend_mode_for_alpha_formats() to prevent fuzzers from stopping wh=
en
drivers encounter a pixel format with alpha exposed but no blend mode setup.

> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode=
_config.c
> index 3bcc7bf0900c4..cff347c723ef0 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -869,8 +869,9 @@ static void validate_blend_mode_for_alpha_formats(str=
uct drm_plane *plane)
>  	for (i =3D 0; i < plane->format_count; i++) {
>  		fmt =3D drm_format_info(plane->format_types[i]);
>  		if (fmt->has_alpha) {

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for
drm_format_info() to return NULL here?

If a driver exposes an unknown or unsupported format in the format_types
array, drm_format_info() returns NULL, and this line will trigger a NULL
pointer dereference during plane validation.

> -			WARN(1, "[PLANE:%d:%s] pixel format with alpha exposed but blend mode=
 not setup",
> -			     plane->base.id, plane->name);
> +			drm_warn(plane->dev,
> +				 "[PLANE:%d:%s] pixel format with alpha exposed but blend mode not s=
etup. Please fix.",

[Severity: Low]
Should this format string end with a newline character?

Without a trailing \n, this warning message might remain buffered or get
concatenated with subsequent unrelated kernel log messages.

> +				 plane->base.id, plane->name);
>  			break;
>  		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731154232.3702=
0-2-leandro.ribeiro@collabora.com?part=3D1
