Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E78EFA0C26
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 04:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A22C10E670;
	Wed, 15 Apr 2026 04:02:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="Uvk+ZQar";
	dkim-atps=neutral
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com
 [209.85.221.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ABCB10E670
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 04:02:09 +0000 (UTC)
Received: by mail-vk1-f226.google.com with SMTP id
 71dfb90a1353d-56a9076813bso3076667e0c.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 21:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776225728; x=1776830528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R9W+Z0h/YBBr++LWPyH6qIXUx6e2r49TM61f5f9RoiY=;
 b=InIBWoBk/C85kHFXQTtG9ptwJHeBk5Xn4p+djlHFQu+glppNJoUtTgzHgI/rax+rE8
 iKK16vJlElQSZoX6YXq9/iN2WphPHjTJr8Y1LrHdxTKx4D5Mu0ZGI/UsggAimdBCKjlM
 mkwlEfqwSx9igAVx7LnMmp7wKg7x18iz7KlkwKpqwqES5rfrrzzEtDnz+dCFpGtTxRc/
 +/2qsvOt85anVyOkf34BDXEzOicJ/DnIeM/eeCFm/0fPMbaPZtCUhcBFqUrEcRerFpTu
 9KSo2fVfkTrqMYqyoWXheseP03Nf/XTTadLF8y3cshXOBYPJDLay2/3RL4kO4MeHoxUb
 4rFw==
X-Gm-Message-State: AOJu0YxyETduqKRJh409zPMmjpD6Eunem6f/aASwWrJrgMSjjkfWPfcE
 Cd3F1C4zDx7NkatjpM9H4b1UCqR+g4/w+KAfXCvywBxSAVg9gGAWGaykZOlh4KkHFJp2m+TxnM9
 R+m0p7keGuiI1QKleI7tFub6+iqOzijt++NsR8lI4Z7mUuVk/iAMGEStqHQVZS2RWJiOiEya5OD
 mKgOXhVHuGh+HT/LnObYW48tOBMqZlQ1Ql4t6SJdnPcs2CNzUMGh6nNzT0tCvg0Ms5uKZ1RmBWQ
 hBPRDq87vv3wTHv9cqm
X-Gm-Gg: AeBDieuGpqQYQGZUTVevqDvdu1GjuKuqlUIZpT+mvTtCj1MMyGtlfPuP02x/5YEidGB
 YBoO/+CRpesdOemzH/Cb1PMxmTBVSvYcZiYoMJ4U2iGIRzw28D3EEagxNY7l9oi4j8AzjrkTypO
 ++zaQ5DWojT2Ud1xI5uIodXicCSnx4iLxaDEThS/xZ6C2/T4HPRWa3En1y00jgbZxGel1lQdhOM
 Ggr2oYym7DrE7t3bhbj4eJnPbeYDz33oPM05o2GtrnJK4w+g9TiNx0GQI5PagPNmGgb0bG7tZHW
 PEUkvbNiumgnAsU4emoFSZ7swKoKso6uECqIvsQxT71zRhm1oQrzQhhS1tFfgty37/U8ZKE/CWJ
 b/kxS1tZu6OQLFdbgngu5ihCrcfevgN/t4aUVSTjshbqkwy52UiLktY43WUTOdaj6ofSznGDY2N
 j+kEC4/JFDAHOS3uWIViMFNAOZy0Xi8TFtFXJB8dme88SS9liBiCXAsAJkEqReuvne
X-Received: by 2002:a05:6122:1c07:b0:56e:e68e:9fc2 with SMTP id
 71dfb90a1353d-56f3bc864fcmr9204348e0c.10.1776225728041; 
 Tue, 14 Apr 2026 21:02:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-56f89dacc1asm67600e0c.1.2026.04.14.21.02.06
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Apr 2026 21:02:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5a409cef179so232006e87.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 21:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776225725; cv=none;
 d=google.com; s=arc-20240605;
 b=IcMFK772TkpOw+kJtrUIlVXgwD6jwpsuedDhLA/sm1YX0reFrEetrzQH/iPtyozB9/
 GN6i3Hwuf9ricXwtQCpWMg4T9QcMhxF4k3zes00M6gQ9crcq1unBJgeBRpesBR4sxMd0
 0bDjjJPo9+iFMl3ICUCJpLvEVeExOeHEmWyyH8tzrwDrODP/qy/39lC4Gi/A8B7bLmQX
 2TDhUQkk7rYGns1RofhHNH671/mbmuSJAZbxn8jED80S9EKSUyWEfZBbSHuYX84iOzLs
 sKd55V3mRKIZwNGZcuf6xErsdH+azlB0SBWwZiR1FnjZvl+KKaZV9KOxJXszRLph9eWV
 7bAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R9W+Z0h/YBBr++LWPyH6qIXUx6e2r49TM61f5f9RoiY=;
 fh=C8L4Ny/oMoH2FLKj7MTKKcp0UPsC4jwKK82I1KzYgTY=;
 b=QBj8EXn6bf0HJ9zSgRhGtK+SqcqrVVJyauBsq/GLuIhXJMy/rCTitZZ8m44W0eXyyM
 ahNKujO6miCJwHzVbxhsrfhxvurPWKc6nB7IiZbYgah7ZLyOoAuV1BjJI2T+NfUGSje5
 04wHG6yaPlre7vAsiyZtkIE8YJWKA5NrQLqkPdYFraN+ozUzGMFUc9E5auxL0sJRB+lv
 2weC/7/Afz22eI5RkqZLfbzmhvpF+F2EPmJEJfrjTvi73syTx5rj2zJe2SOMrZ23Hrlj
 8y0sKi9Ea6rD5fCLaz5l03r77RbUj0tEuoyrm2Wndql4+co3wIiNDCYZ8r3yjEO269D+
 sFzg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1776225725; x=1776830525;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R9W+Z0h/YBBr++LWPyH6qIXUx6e2r49TM61f5f9RoiY=;
 b=Uvk+ZQarjzKdch5C1sd655l/IxWVMIGjY0WC4gFvr/5tWMioPEHpxD9ZqFcGVbd7GD
 e4s1IvCocwxG6WvuXGaOM3qXUM6bmA1d1l1ICRg/m4beKXy03ooZmMD8qhR3E3g0925d
 WEWhtRvqzEvoxtjp+H9znBRa2zgoQq6ONwUQg=
X-Received: by 2002:a05:6512:12d2:b0:5a2:c453:3658 with SMTP id
 2adb3069b0e04-5a3efe92a0dmr5380804e87.43.1776225725338; 
 Tue, 14 Apr 2026 21:02:05 -0700 (PDT)
X-Received: by 2002:a05:6512:12d2:b0:5a2:c453:3658 with SMTP id
 2adb3069b0e04-5a3efe92a0dmr5380800e87.43.1776225724761; Tue, 14 Apr 2026
 21:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260414200819.88506-1-ian.forbes@broadcom.com>
In-Reply-To: <20260414200819.88506-1-ian.forbes@broadcom.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 15 Apr 2026 00:01:52 -0400
X-Gm-Features: AQROBzBGypBww_A5aRm_Wogojp41jK7M_2DHb3N8iZHvzRBBy5sgmqRm73gOlwU
Message-ID: <CABQX2QP_N49mWN4LJOD=fGpFqDte9KU=U-adQ7N3ZEvPmxGtuA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/vmwgfx: Store cursor source mappings in
 plane_state
To: Ian Forbes <ian.forbes@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
 maaz.mombasawala@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000006d0234064f77c77d"
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

--0000000000006d0234064f77c77d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 4:08=E2=80=AFPM Ian Forbes <ian.forbes@broadcom.com=
> wrote:
>
> We aren't tracking the map/unmap sequences correctly for the cursor
> plane's source buffer mapping during atomic commits. Instead relying
> on ref counting in vmw_bo_map_and_cache to paper over these mistakes.
>
> map_and_cache is not thread safe and requires the BO to be reserved but w=
e
> shouldn't reserve, or map, in atomic_update where we incorrectly assume t=
he
> mapping is always cached.
>
> Under stress test like IGT's kms_cursor_legacy the unmap at the start of
> prepare_fb can unmap the mapping and the map_and_cache in atomic_update
> will either need to redo the mapping or will crash because the mapping
> was removed while in use.
>
> The best solution is simply to move the mapping to the plane_state and
> not duplicate it ensuring the each mapping is local to each atomic commit=
.
>
> Fixes: 965544150d1c ("drm/vmwgfx: Refactor cursor handling")
> Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 84 +++++---------------
>  drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h |  4 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c          |  1 +
>  3 files changed, 25 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/d=
rm/vmwgfx/vmwgfx_cursor_plane.c
> index c46f17ba7236..125080c2a018 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> @@ -112,10 +112,12 @@ static void vmw_cursor_update_mob(struct vmw_privat=
e *vmw,
>  {
>         SVGAGBCursorHeader *header;
>         SVGAGBAlphaCursorHeader *alpha_header;
> -       struct vmw_bo *bo =3D vmw_user_object_buffer(&vps->uo);
> -       u32 *image =3D vmw_bo_map_and_cache(bo);
> +       bool is_iomem;
> +       u32 *image =3D ttm_kmap_obj_virtual(&vps->cursor.src_map, &is_iom=
em);
>         const u32 image_size =3D vps->base.crtc_w * vps->base.crtc_h * si=
zeof(*image);
>
> +       WARN_ON(is_iomem || !image);
> +
>         header =3D vmw_bo_map_and_cache(vps->cursor.mob);
>         alpha_header =3D &header->header.alphaHeader;
>
> @@ -132,7 +134,6 @@ static void vmw_cursor_update_mob(struct vmw_private =
*vmw,
>         memcpy(header + 1, image, image_size);
>         vmw_write(vmw, SVGA_REG_CURSOR_MOBID, vmw_bo_mobid(vps->cursor.mo=
b));
>
> -       vmw_bo_unmap(bo);
>         vmw_bo_unmap(vps->cursor.mob);
>  }
>
> @@ -469,9 +470,16 @@ vmw_cursor_plane_cleanup_fb(struct drm_plane *plane,
>  {
>         struct vmw_cursor_plane *vcp =3D vmw_plane_to_vcp(plane);
>         struct vmw_plane_state *vps =3D vmw_plane_state_to_vps(old_state)=
;
> +       struct ttm_buffer_object *bo =3D vps->cursor.src_map.bo;
> +       int ret;
>
> -       if (!vmw_user_object_is_null(&vps->uo))
> -               vmw_user_object_unmap(&vps->uo);
> +       if (bo) {
> +               ret =3D ttm_bo_reserve(bo, false, false, NULL);
> +               ttm_bo_kunmap(&vps->cursor.src_map);
> +               ttm_bo_unpin(bo);

Minor nit: if ttm_bo_reserve fails then this ttm_bo_unpin is going to
be a problem because unpin requires a reservation. Minor because
ttm_bo_reserve is unlikely to fail here but we should still handle it.

z

--0000000000006d0234064f77c77d
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIKuC
rGDcmpepOEZBq4ioUJua0GCqbQoMiZrplP48aP4jMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDQxNTA0MDIwNVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAElVwT0MsmvWyuEbhXDvH0LHlUHLep5PcJ0fHAfm
apz6wZYOy2CfflcGksz23kKskIXVEEIOKiFQb1MMu5ITRCEIi3FHcawZHiShd/ewLVhIA+rGpQPZ
+WRzRRBHwLrvgHp33iBIARs91ToIpQfaMlseRe0lGBU3Uj6GD8T/jERlQkRgf5P79z0LtG03XCJS
hP0uUlZrgYxdrBsd+QrJ9C/5NlyE+EqoECrvp6LPmWxt/yTvbd/N6q19XBOHYsMiJDWU4CzBS4Qd
8lKI5ETGIJ+4FDZ5S6Ulhlg+YmTZdvfLSvtQ2xNLcU0X5Oo246sGOspF3d8O0JbWl4S5P2qWTUI=
--0000000000006d0234064f77c77d--
