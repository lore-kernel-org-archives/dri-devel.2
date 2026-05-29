Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9114BCD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 21:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB9C3112553;
	Fri, 29 May 2026 21:47:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="HD6BpZec";
	dkim-atps=neutral
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com
 [209.85.128.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A3A2112553
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 21:47:05 +0000 (UTC)
Received: by mail-yw1-f226.google.com with SMTP id
 00721157ae682-7dc93d02916so23387997b3.3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 14:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091224; x=1780696024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tq+GBjnPPjbqnz/T4O2Nzq6ksTXv9aG1Rt9H0ulaXnc=;
 b=YqlLFyFBTrygUWzVOgD6sukhkOphKI3PlcllXSNW2/fZJOvqokeOm6CJ+L5qmxjmnL
 V+Ml8GZex2wEVgsQjb/I3A0gnfwdFZAQaTJ+vi8mcmoYxpUn+mtdKQR2uIkgQOngjCzu
 y3iLYo+B7p0sFfoU6JGXGzHfXKW3pu6obKL8fsBQOT+DrRP1fgu73be3gUfKi6f79keA
 5aY3UlhnK9lwLmnvGSRYCbECGr5i2OlMXT5XUzKfisKCF91Afbph7pGK/jgIQ2NgZf57
 PzQEkNPLaCTQDv3qUPS0iyOGOFu7V22XFclHxpdIXOUzPUDUMtW4Eke9VVOkQNMDTsjp
 HJDA==
X-Gm-Message-State: AOJu0YxkgPR5Aw+GqTSBknXB7alm1P4wY4EUWUV7/cJ8Yo+AcGLaSUoZ
 qjtbsNN8zkdPch7arSNyaywsN/DrLAnts7uNc42Oqqr7vId22Bo6XAwuL5TH53fwq4nq343vmKh
 BbYmdrXgJgZaP2yae9sSZ/Kh0aM6Wz2zUNoQH/9zL8TJiA53BORh2cOgZLLwMCeRlZyc+X7Q7TM
 NHi0VkSpJDaIzD2oQEAywPPFwt4rpXMpi3SOSjvmceiu2gDBz/6A5cfYin8DvDYc8GyAJH6+yFh
 p7lzKfA55oVLhsk3MwO
X-Gm-Gg: Acq92OHtnkM7kzdi3PswpeIZnZcAWgvjLWZR4kNrLRGzilFsoQmUE9Y6ihOs8l0coHE
 +y2K0kx8Li9BmALwQC7MoOu5nqgj+tZMXDlv9jKnDDsXQuGAM4+T79H9dzH2QBONe44/c5wvHHE
 +YBrUaUekVTILUDvGHrwiHFG2vSy2Adidl3y/rsDWGxE24URjRVqX6WcVdm+d1zIfl9sdzu3dVP
 S5wp5nBgSfJyZnvBknJbj86Dvw7g6SHShXYbKmhF1ctmzFtcjW/8nPi3f79TfkjDOah5lBbx9Z2
 /1BrmDIl5K6ZKp9N6gdl9+6BPPzjxeQmLKHs/avlLfFlHDw7judSoFsMSalxpUQfO5YFQ7BUcUo
 zZp02gmDq+MnIOTVemnani5YsRdkB71Cb9t8ZHBDT5hy6kgfs68djfF1XAn0O9QuG5TXVJTRSjZ
 y4WxxewXOeQ0ncgRUcT4GA1v9KChRNZGHSg/b6of2UBPRcbd7vV7m4v5AlbzmRHF4dYxs=
X-Received: by 2002:a05:690c:c50f:b0:7dd:89dc:3da7 with SMTP id
 00721157ae682-7e05a286762mr11344617b3.17.1780091224317; 
 Fri, 29 May 2026 14:47:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-7de6757c96csm1855377b3.4.2026.05.29.14.47.02
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 May 2026 14:47:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5aa607bbfe2so324407e87.3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 14:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780091221; x=1780696021;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tq+GBjnPPjbqnz/T4O2Nzq6ksTXv9aG1Rt9H0ulaXnc=;
 b=HD6BpZecG92lzpwQzL6cXV2CMbB7hFv8Cl7ste5tfMZz6F+ZiO1aWXNzh0SXVmYTeA
 GdPu9IPOXN/XvaMq35PpXPqTRF+Ja+eL0jkwKc1h1VuVAnZF9W6vqSOgDXLbFzQpP3IM
 5eElj5PLzsiqW31RNBojnu9IGcmjDkXK6fXuU=
X-Received: by 2002:a05:6512:b19:b0:5aa:6289:e0b5 with SMTP id
 2adb3069b0e04-5aa6289e364mr128713e87.35.1780091221638; 
 Fri, 29 May 2026 14:47:01 -0700 (PDT)
X-Received: by 2002:a05:6512:b19:b0:5aa:6289:e0b5 with SMTP id
 2adb3069b0e04-5aa6289e364mr128705e87.35.1780091221210; Fri, 29 May 2026
 14:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260521223756.627311-1-maaz.mombasawala@broadcom.com>
 <20260521223756.627311-4-maaz.mombasawala@broadcom.com>
In-Reply-To: <20260521223756.627311-4-maaz.mombasawala@broadcom.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Fri, 29 May 2026 17:46:48 -0400
X-Gm-Features: AVHnY4LL6vqPnMiPVnpGB-g3MfJPsPcbYkKZmEJIs9zBJFskvvv0NSKtg3JJ7Cw
Message-ID: <CABQX2QMEfeELvPX-_x6KZadyaEO4h8mgfA9yHBxPkGQYJLihYw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] drm/vmwgfx: Reserve ttm object before resv usage
To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
 ian.forbes@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000f444770652fbc88a"
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

--000000000000f444770652fbc88a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 6:35=E2=80=AFPM Maaz Mombasawala
<maaz.mombasawala@broadcom.com> wrote:
>
> We hit dma_resv_assert_held warnings in several places, reserve the ttm
> base object when it's being used to avoid them.
>
> Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_bo.c   |  2 ++
>  drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 12 ++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/=
vmwgfx_bo.c
> index 9c7a73c0b0dc..6817e0b8ce99 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> @@ -55,7 +55,9 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)
>                         /* Reserve and switch the backing mob. */
>                         mutex_lock(&res->dev_priv->cmdbuf_mutex);
>                         (void)vmw_resource_reserve(res, false, true);
> +                       ttm_bo_reserve(bo, false, false, NULL);

We probably want to check the return here just like you did below
because if the reservation fails you'll hit the same
dma_resv_assert_held warnings.

>                         vmw_resource_mob_detach(res);
> +                       ttm_bo_unreserve(bo);
>                         if (res->dirty)
>                                 res->func->dirty_free(res);
>                         if (res->coherent)
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_vkms.c
> index 7b8163b5e501..da6ccd5e318e 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
> @@ -131,6 +131,7 @@ crc_generate_worker(struct work_struct *work)
>         spin_unlock_irq(&du->vkms.crc_state_lock);
>
>         if (surf) {
> +               int ret;
>                 if (vmw_surface_sync(vmw, surf)) {
>                         drm_warn(
>                                 crtc->dev,
> @@ -138,7 +139,18 @@ crc_generate_worker(struct work_struct *work)
>                         return;
>                 }
>
> +               ret =3D ttm_bo_reserve(&surf->res.guest_memory_bo->tbo, f=
alse, false, NULL);
> +               if (ret !=3D 0) {
> +                       drm_warn(&vmw->drm, "%s: failed reserve\n", __fun=
c__);
> +                       goto done;
> +               }
> +
>                 compute_crc(crtc, surf, &crc32);
> +
> +               ttm_bo_unreserve(&surf->res.guest_memory_bo->tbo);
> +
> +done:
> +

Is this an extra newline? Lets get rid of it.

z

--000000000000f444770652fbc88a
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIEqI
l0Un4FIVtg5xDj+IACbP/Y4C19NGfU3OEE7yaawHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDUyOTIxNDcwMVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAGDRWUKRvGaAiIfajSaCu/RJqWUjLjNN6vFoqV0T
pjeygLQQwjwpi+PndpWkuAcBQii64NLGPuKUdqBxu8djyJOHOEOBAVHEMYb30voC4dXuJ3GVKT9e
hBK/yZdH9EGLsXtfHRdI3ec78D57zBQ2xWNH8Twd07d5YMZxsq6CgH36TsWb8DwIRcu39evFPB+x
4sOKc9+AgfyDv6iUZkBtjyvjGU5uX79m7uAw7QJxO7NbPTpdsx4aw99NvdM9y8GqP3Z26iYc9D4J
qoWmiZ8D3UGTYlnjnfM3sTjqm2xukKs2wLEoxgcU5Ql2AWMfLGAuqFS7tKkh+5Rbfc6QDRPQHac=
--000000000000f444770652fbc88a--
