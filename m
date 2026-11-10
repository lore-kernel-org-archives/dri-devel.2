Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C1B60A2602
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 06:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnQtlg8K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADE9210EDE4;
	Tue, 10 Nov 2026 06:03:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C643710EDE4
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 06:03:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8241C42B0F
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 06:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE921F0089F;
 Tue, 10 Nov 2026 06:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794290604;
 bh=A3QVZs894CF3Zo/s67tqg+DsBT/VsojaDWbCi5nSrXw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hnQtlg8KOSX0KSNn7Qm+fdchN/a634hAk2bf/Zl90g0uETOxkD0xQuSChhB4hSaDX
 D5X7mSPnDCKstj5CIeJFWC95sKvL0O1dmpnVzFfv5Gs9LxEqhpcoyt6O13r1NIH/uS
 2GpFomUBRnSWzqfCGTTZ5YnpNitx1IO+v++TAKptDDxUxXH5Izg5Go6KBBy7qAJFQ6
 TxrfCF3CP3t72d/3uqD4hSAjK4b10VKjiv23cUqkDKM5Xg/e9ghTAfcPuxoVQ8R7ZF
 94DpC+yQ9zc/NjazhUy4gVP7vb++5Yks2PGP7tmUR0eaXshmAFCFWT+V5mTp0kB+fr
 P4ydOKdrV5JBQ==
Message-ID: <sashiko-outbox-206389@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] drm/panic: Do not use un-escaped URL as format
 string
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110055810.483002-1-sashal@kernel.org>
References: <20261107051705-failed-6.12-6596aae25585@kernel.org>
 <20261110055810.483002-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 06:03:23 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] drm/panic: data corruption in drm_panic_get_qr_code_url()
  [1]
--

commit 6107444dfad860987491c5c76fe37fcd55bcb9ae
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Do not use un-escaped URL as format string

This commit passes CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL via a %s format
specifier in drm_panic_get_qr_code_url() instead of concatenating it
directly into the snprintf() format string.

Link: https://patch.msgid.link/20260911124540.279841-2-tzimmermann@suse.de

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 0aa87eafdacd5..7dedf18f9ed0c 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -502,7 +502,8 @@ static int drm_panic_get_qr_code_url(u8 **qr_image)
>  	char *kmsg;
>  	int max_qr_data_size, url_len;
> =20
> -	url_len =3D snprintf(url, sizeof(url), CONFIG_DRM_PANIC_SCREEN_QR_CODE_=
URL "?a=3D%s&v=3D%s&zl=3D",
> +	url_len =3D snprintf(url, sizeof(url), "%s?a=3D%s&v=3D%s&zl=3D",
> +			   CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL,
>  			   utsname()->machine, utsname()->release);
> =20
>  	max_qr_data_size =3D drm_panic_qr_max_data_size(panic_qr_version, url_l=
en);

[Severity: Critical]
This problem wasn't introduced by this patch, but can concurrent debugfs
writes across different DRM devices corrupt the global zlib stream and
buffers in drm_panic_get_qr_code_url() [1]?

draw_panic_plane() only serializes callers per device via
drm_panic_trylock(plane->dev), while drm_panic_get_qr_code_url() and
drm_panic_get_qr_code_raw() operate on shared file-scope globals:

drivers/gpu/drm/drm_panic.c:
static char *qrbuf1;
static char *qrbuf2;
static struct z_stream_s stream;

CPU0                                    CPU1
debugfs_panic_write() (dev A)           debugfs_panic_write() (dev B)
  draw_panic_plane()                      draw_panic_plane()
    drm_panic_trylock(dev A)                drm_panic_trylock(dev B)
    ...                                     ...
      drm_panic_get_qr_code_url()             drm_panic_get_qr_code_url()
        zlib_deflateInit2(&stream, ...)
                                                zlib_deflateInit2(&stream, =
...)
        stream.next_in =3D kmsg;                  stream.next_in =3D kmsg;
                                                  <-- corrupts shared stream

Concurrent writes to per-plane panic debugfs files on two DRM devices
simultaneously mutate qrbuf1, qrbuf2, and stream, corrupting zlib state
and kernel memory.

[1] https://sashiko.dev/#/bug/linux-093f9782-c6d2-4cc0-b04c-5ef4dea5d6f9

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110055810.4830=
02-1-sashal@kernel.org?part=3D1
