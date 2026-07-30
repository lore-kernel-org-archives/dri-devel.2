Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FD3C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C4110ED1D;
	Thu, 30 Jul 2026 01:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f3Lm+xBT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B294D10ED1D
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:54:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC12E600AA;
 Thu, 30 Jul 2026 01:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741751F00A3A;
 Thu, 30 Jul 2026 01:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785376442;
 bh=akXGrPuPHGIyTqdAu9V2oztUlVlcg4agYECDBAHjvig=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f3Lm+xBTEmHB7AQRvuol9aLdnZ+rweOB4NxMxMVjvbizDGz+7tgubPz6zrsx7WFLl
 CjE2UcRly4ycmvKVs625StSezWi18XHf5QLx+DbJbJ1H93QISmJ7O9MIhorj7aPooh
 IWWjspIlFn/VvvZLV2AD4hEAgQPqUvG+1H1Mx+yzCJm95UVqtSmUmFqkL4xA3u0dbD
 ePRQMcnMxwD3PPxrGIXBR5Q+3q80R8Uji430lJeZR6NsUIvAsZgyU89w/OXPm7d7T5
 s5iGj4YTV4dkmYb1Efd1wvseYnQPZ4t5uYrJA/6Q2weUhKNXfKRWcWi5KpAo9yMyNA
 ZCOnM5ATK088g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/log: Fix division by zero when scale module
 parameter is 0
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730014440.66323-1-oushixiong1025@163.com>
References: <20260730014440.66323-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 01:54:01 +0000
Message-Id: <20260730015402.741751F00A3A@smtp.kernel.org>
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
- [Low] Concurrent modification of the global `scale` module parameter caus=
es a data race.

Pre-existing issues:
- [High] Incomplete fix for division by zero: lack of upper bounds check on=
 `scale` leads to infinite loops and out-of-bounds memory writes.
--

--- Patch [1]: [PATCH v3] drm/log: Fix division by zero when scale module p=
arameter is 0 ---
commit bb9f2bc713acbd6b1874a441b5a5e50842c6a233
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/log: Fix division by zero when scale module parameter is 0

The scale module parameter can be set to 0 via kernel command line, causing
a division by zero in the rows/columns calculation. This commit clamps it to
1 once in drm_log_register() to prevent the issue since it is read-only at
runtime.

> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/=
drm_log.c
> index e3e02c84a4cfe..b8289e89ed748 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c
> @@ -421,6 +421,9 @@ void drm_log_register(struct drm_device *dev)
>  {
>  	struct drm_log *new;
> =20
> +	if (!scale)
> +		scale =3D 1;

[Severity: High]
This isn't a bug introduced by this patch, but does the lack of an upper bo=
und
on the scale parameter leave other issues unresolved?

If scale is set to a sufficiently large value (e.g., scale=3D300 on a 1080p
display), scaled_font_w becomes larger than the display width. This causes
scanout->columns to evaluate to 0 in drm_log_setup_modeset():

	scanout->scaled_font_w =3D scanout->font->width * scale;
	scanout->columns =3D width / scanout->scaled_font_w;

When scanout->columns is 0, it causes an infinite loop in
drm_log_draw_kmsg_record() since len is never decremented:

	while (len > scanout->columns) {
		drm_log_draw_new_line(scanout, s, scanout->columns, prefix_len);
		s +=3D scanout->columns;
		len -=3D scanout->columns;
		prefix_len =3D 0;
	}

Additionally, an unvalidated massive scale can cause out-of-bounds memory
writes in drm_log_clear_line() due to a massive height calculation:

	iosys_map_memset(&map, r.y1 * fb->pitches[0], 0, height * fb->pitches[0]);

Could we validate an upper bound for scale here as well?

[Severity: Low]
Does modifying the global module parameter here cause a data race?

Since drm_log_register() is called during device initialization, multiple D=
RM
devices probing simultaneously could concurrently check and modify the glob=
al
scale parameter without synchronization.

> +
>  	new =3D kzalloc_obj(*new);
>  	if (!new)
>  		goto err_warn;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730014440.6632=
3-1-oushixiong1025@163.com?part=3D1
