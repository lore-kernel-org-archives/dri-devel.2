Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06582CA5FE8
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D5C110E71A;
	Sat,  3 Oct 2026 01:34:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QWBVo5vz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B0B910E71A
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 01:34:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E4EA60D86;
 Sat,  3 Oct 2026 01:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF9B1F00893;
 Sat,  3 Oct 2026 01:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991245;
 bh=kiWlmf76r121G/pYU85rdFP9iRBT8FegZkXAbJdLH2Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QWBVo5vzkdSILk1ZBaWx3yXgQGE3oe7Esc/V/BxyUs9zwRejelSJpXVMwg4tOe+nT
 SRejc8k1fhpkCV4zXu6n/bs0li9hepZDP7q46Vn9+nKox17Zwe8wNsxbWSLDs0QD6A
 sAgET7UFribwAMLZgZLcAxtpnZph+844UcnzB2gEpxiZEu89RQXPPdN6hnNiVlDGas
 EmGGLpQXBchDu6aizSOckQjL5ThKDOYYW6m3CHBaRoM/w4DLR67vuzwUCfZOX/DYjE
 AGpKbRwbiMk7NTJo7sPwa0mBNZuP3BR/IUQOJTLD55yr+YDaYe6RqL9kf0UObplspm
 7SAroYK2E9SUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/panic: allow overriding panic QR code URL
To: =?utf-8?b?57qz6KW/5aayIMK3IE5haGlkYQ==?= <me@nahida.im>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261002222021.149450-1-me@nahida.im>
References: <20261002203140.121165-1-me@nahida.im>
 <20261002222021.149450-1-me@nahida.im>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:34:05 +0000
Message-Id: <20261003013405.9EF9B1F00893@smtp.kernel.org>
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
- [Medium] drm/panic: OOB read due to missing null-termination on panic_qr_=
url
--

commit 4020ffafa052ada60c700fa2d64b78e9eb01e839
Author: =E7=BA=B3=E8=A5=BF=E5=A6=B2 =C2=B7 Nahida <me@nahida.im>

drm/panic: allow overriding panic QR code URL

This patch adds a module parameter to override the DRM panic QR code base U=
RL
at boot or module load time. It exposes a getter function for the DRM panic
helper to retrieve and format the configured URL when generating the QR cod=
e.

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 9fe97c4eda6c8..463544f71c537 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
[ ... ]
> @@ -49,6 +49,15 @@ MODULE_LICENSE("GPL");
>  static uint panic_qr_version =3D CONFIG_DRM_PANIC_SCREEN_QR_VERSION;
>  module_param(panic_qr_version, uint, 0644);
>  MODULE_PARM_DESC(panic_qr_version, "maximum version (size) of the QR cod=
e");
> +static char panic_qr_url[256] =3D CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL;

[Severity: Medium]
Will this array be null-terminated if CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL is
exactly 256 bytes or longer?

In C, initializing a fixed-size character array with a string literal of eq=
ual
or greater length does not append a null terminator.

[ ... ]
> diff --git a/drivers/gpu/drm/drm_panic_helper.c b/drivers/gpu/drm/drm_pan=
ic_helper.c
> index 8913c3d22e8d3..b0ea0b4e8edef 100644
> --- a/drivers/gpu/drm/drm_panic_helper.c
> +++ b/drivers/gpu/drm/drm_panic_helper.c
[ ... ]
> @@ -609,17 +609,20 @@ static void drm_panic_helper_qr_exit(void)
>  	stream.workspace =3D NULL;
>  }
> =20
> -static int drm_panic_helper_get_qr_code_url(u8 **qr_image, unsigned int =
qr_version)
> +static int drm_panic_helper_get_qr_code_url(u8 **qr_image, unsigned int =
qr_version,
> +					    const char *qr_url)
>  {
>  	struct kmsg_dump_iter iter;
> -	char url[256];
> +	char url[512];
>  	size_t kmsg_len, max_kmsg_size;
>  	char *kmsg;
>  	int max_qr_data_size, url_len;
> =20
>  	url_len =3D snprintf(url, sizeof(url), "%s?a=3D%s&v=3D%s&z=3D",
> -			   CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL,
> -			   utsname()->machine, utsname()->release);
> +			   qr_url, utsname()->machine, utsname()->release);

[Severity: Medium]
Could this lead to an out-of-bounds memory read during a kernel panic?

If qr_url points to a panic_qr_url array that lacks a null terminator,
snprintf() will read past the end of the array until it encounters a null
byte in adjacent memory. This could potentially leak adjacent memory into t=
he
QR code URL or cause a secondary crash that prevents the panic screen from
displaying.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002222021.1494=
50-1-me@nahida.im?part=3D1
