Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B78CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 17:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2307A10F480;
	Wed,  7 Oct 2026 17:24:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="Jh+Z/MuV";
	dkim-atps=neutral
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 417F110F480
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 17:24:46 +0000 (UTC)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-cc7d154ec4fso966203a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 10:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791393886; x=1791998686;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mRA5fERdyUYnwy22fOI6p1B+EOijNg+KQn05vW/uAE0=;
 b=Iv7+Tc5KbPpwKzpHyj+8EEajHUt6sO5FMlSRLwsiwT8gX7potCoWbQ1GOz6URRLVW1
 DQ/3QvOb2YvOn3wn0ZI5I2dAN8zW/N9eZInytxjrqGS47TMByMQrKhl/9lFmHdFCr95+
 q5EOwV+G23X962zFWu7LJCdt4UDwfONUl7ZVtykpQqyWi6T7B9dcK79VthWMkMOvK8wN
 x5usAM4zOciUBPX5V8pVOMBiyIlkjTDq7GR7BGqHQUpHnRe2Mj1oUkWfRhOUfGXfH6Xs
 GkIyqt102p0an5BSTxLybDnnYthZ2wQsiOOSQLcA4Gko+qEWcQ5O11tE8Fg5Y6HKvi3C
 7VYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEs8wZX5EuS87B2nLJHhLAqCqN+03cL7S/A2mpZTNNfnRAVYuD7MzMYkOE4RyuNjTlBnTE1PfHdi0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKaTyj/FmYSPDROU5L+Ax8uy1XPtC2cbx1rVZn0W7dqJkey9zim
 oYlOg+KVWdPOpJEIZw7XPk7oWH1StlgE4P5yoVZ8YD1rdAhBfRbfhc1Giu/czkK80hsahMhbtAC
 qSt2F8PacQTD/49PFCV2yt/SVwCYaq978uFFl/1pHpcYHmvQJyYJ6ZrwDn+yl2S15pv8FHTZlMJ
 1S8xW7nD0L+ZERPOU7ohmxBX/MpOWHPUNSRZsdrsdTOrcebg49+pb/rJAxqyKpIylkYbhCp+CQO
 FWICmDnhvW8fZKiNgXq
X-Gm-Gg: AYBFou2gPdLQnzfPgqGMti5CK/2nuB9dEYTMbvXD3AtXVXCzh+N85Nt+3RSUpA03SQz
 L4NVhIIPhLW+e1yUSJIXXBqO9icL0onqo7sxuPbR3lBdoq5o7AI0Fco3o+K0j866UMLAY2OHHWu
 GoCpHaUzd3rHaxGvF9X2lkGBUYWd/2+srvsTsiJYRSq4YIXgJahfqUdO1S0k6aiUNjxRYbzR8jW
 XYd2mcyonkcO/CFb7d3oqxSXz5mRuKtgmoIeaigEb+4n0ahyuu6y2JLsgDOQD2iU0bxvI7nm2iZ
 PVQiLwDqE5Euqjmc83FWvmh2sl3kkhIClLOhe5kloX+UKq80z/AgO16zOY6UbodwOBGBUsZvRMG
 MevIIhsteLmpJk0dzYoTE5+64N0nuKuQwgN3inxHXEf9bwYnAZDHkFkSD/Ca1WK/ZEIJUf4WBRh
 CQZFO5sAdLmFHaTiOfXrQkWBG//F+ulP9Eqjw=
X-Received: by 2002:a17:90a:e7cc:b0:3a4:b0f3:6597 with SMTP id
 98e67ed59e1d1-3a89e9effb3mr2654525a91.0.1791393885397; 
 Wed, 07 Oct 2026 10:24:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a89dd9b0dbsm471763a91.1.2026.10.07.10.24.45
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Oct 2026 10:24:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso8351794eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 10:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791393884; x=1791998684;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mRA5fERdyUYnwy22fOI6p1B+EOijNg+KQn05vW/uAE0=;
 b=Jh+Z/MuV4NL89FCRNogqzjxamfEcHoe7SmWj97lw+0izDaNYiP6uvgdhhfcmP5x2BE
 yad10vcVghyzEZqSRS26V17LrWYV2MHFOocU2ycj4EKcu5+zXvMe7p5IXh4UGBjUGTFi
 euPqqHUp3XJs6Wb4F0yuqEF79dr3ioSoWnZMM=
X-Forwarded-Encrypted: i=1;
 AKwUvBxCOo/StzR3TLADt/FTiyV4wvmQLYKqb4fyUPyb1rl4YnwjL1Kwg2azYp51kaSOCNmnIk90g/oHbJY=@lists.freedesktop.org
X-Received: by 2002:a05:693c:6391:10b0:34c:d1f2:b552 with SMTP id
 5a478bee46e88-3515da5dd21mr2968914eec.4.1791393883118; 
 Wed, 07 Oct 2026 10:24:43 -0700 (PDT)
X-Received: by 2002:a05:693c:6391:10b0:34c:d1f2:b552 with SMTP id
 5a478bee46e88-3515da5dd21mr2968887eec.4.1791393882356; Wed, 07 Oct 2026
 10:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260923135012.1823971-1-qwe.aldo@gmail.com>
In-Reply-To: <20260923135012.1823971-1-qwe.aldo@gmail.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 7 Oct 2026 13:24:27 -0400
X-Gm-Features: AclHuK8Rtk0VCGvLWwuukn9V5BNplvYIe1zYZb_CQF7GhcBv2ea2umqr_KEADvI
Message-ID: <CABQX2QOhT_wzq=EVE-cqjAADYKOvM8t64nxyDgB-Q8-k+89X-A@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: close TOCTOU on guest_memory_bo in surface
 reference ioctl
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, Ian Forbes <ian.forbes@broadcom.com>, 
 Maaz Mombasawala <maaz.mombasawala@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000001bcb71065d4364ec"
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

--0000000000001bcb71065d4364ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for the patch. Just a quick note: I'm not a huge fan of patches
like this because they attempt to fix a potential issue, usually at
the cost of introducing real regressions, which is not a great
tradeoff. Especially nowadays when writing code has become much
cheaper, patches that don't mention the type of testing/validation
that has been done are going to need to wait a long time because they
trade the part that's cheap to reproduce "llm please fix this sashiko
bug" for the expensive "run the full test/validation tests". However,
lacking proper fail/skip lists for igt in the kernel for vmwgfx,
explicit testing instructions, or a public CI machine is our fault and
we need to fix that.

On Wed, Sep 23, 2026 at 9:50=E2=80=AFAM Aldo Ariel Panzardo <qwe.aldo@gmail=
.com> wrote:
>
> vmw_gb_surface_reference_internal() checks srf->res.guest_memory_bo for
> NULL and reads its buffer_map_handle and buffer_size outside the
> cmdbuf_mutex scope that protects the backup pointer.
>
> A concurrent surface eviction can NULL out guest_memory_bo between the
> check and the use, causing a NULL pointer dereference in
> drm_gem_handle_create(). The post-mutex reads of vma_node and base.size
> race with any concurrent backup change.

Thanks, the locking change itself looks right, but the description
needs adjusting. A successful eviction keeps the backup. A concrete
racing writer is a backup switch, e.g. from
SVGA_3D_CMD_BIND_GB_SURFACE: vmw_resource_unreserve() drops its
reference to the old buffer and installs the new one under
cmdbuf_mutex. So the unlocked check can see a transient NULL, and the
reads after the unlock can see NULL or return another buffer's offset
and size. The new handle keeps the original buffer alive, but this
ioctl holds no reference to that other buffer. A further switch can
drop its last reference and free it while we read it. Please describe
that instead.

> Move the NULL check inside the mutex, and read buffer_map_handle and
> buffer_size while still holding it.
>
> Fixes: 14b1c33e8429 ("drm/vmwgfx: Add new ioctl for GB surface create and=
 reference")

afaict the unlocked check and the reads after the unlock go back to
the original ioctl:
Fixes: a97e21923b42 ("drm/vmwgfx: Hook up guest-backed surfaces")

> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_surface.c
> index bd05637..fff4402 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -1718,15 +1718,21 @@ vmw_gb_surface_reference_internal(struct drm_devi=
ce *dev,
>
>         user_srf =3D container_of(base, struct vmw_user_surface, prime.ba=
se);
>         srf =3D &user_srf->srf;
> +       metadata =3D &srf->metadata;
> +
> +       mutex_lock(&dev_priv->cmdbuf_mutex); /* Protect res->guest_memory=
_bo */
>         if (!srf->res.guest_memory_bo) {
> +               mutex_unlock(&dev_priv->cmdbuf_mutex);
>                 DRM_ERROR("Shared GB surface is missing a backup buffer.\=
n");
>                 goto out_bad_resource;
>         }

This touches the same lines as your "return an error when a shared GB
surface has no backup buffer" v2, and this branch still returns 0. I'd
treat them as a series and just rebase this one on top of that patch,
keeping both its ret =3D -EINVAL here and its surface-reference cleanup
on failure.

z

--0000000000001bcb71065d4364ec
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEINxZ
Pv1ePkB1fJHwbRMFJ5N7Qa+Hubfs5Fy3QWDEwpaBMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAwNzE3MjQ0M1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAKXWzvScZ1la5WIwpbKbEZ2xGJfIVdOvfNOzb27s
qNaGlobSDkF9nHZR+jU5R215V0Kk/1uRJYSpR0ynmv30CzrZcLew8gSuH9S24WXJpR2zJgpT2Kzo
OXWlxEIFlumG5zBxb85ZPMzvsCJXMWwsVa41Rr2AvYMf50r7VjWXiNmbOaaqaEcfp0LwFBlrPgPg
Y1ttE6lRGbkWkkarm6WcSuPpl3k+bJ/S/9ptVgTGCei7SxhSZXxYR5BEQcQ18g90/pHBd/LKE/xb
6bdI9EDfepjir7PK5OrFOXT+n19lW1s/YaeLOoCdjC/V4chwUgRcj91MDCkypDsaqklRlaDwUQY=
--0000000000001bcb71065d4364ec--
