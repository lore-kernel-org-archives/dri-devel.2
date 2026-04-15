Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8C9FA0C26
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 03:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2647B10E03B;
	Wed, 15 Apr 2026 03:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="ZUypafw4";
	dkim-atps=neutral
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com
 [209.85.160.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1027410E03B
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 03:58:10 +0000 (UTC)
Received: by mail-qt1-f226.google.com with SMTP id
 d75a77b69052e-50b69bf5638so68728101cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 20:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776225490; x=1776830290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BANB/iieo/1R0HSfYtGTIvn5A73RnuZ2+gO22EyqIKU=;
 b=ma8h1XHOmDtnYJsNjX3PNfRv6RqeoUaY/kxfGRjRT0WrremBkrDWzTZyY8Gvz3CYU4
 dibTCO7m3a1aSr0ssdT8Dwcj9TNlWCNtQSjM1vi5wdRh5FTDpmF2HYy/SZfjii+BbliY
 y8uWt9NyI+nx6c+KQXSkrfedVGi7H9355sNmPcBI5zPKzGnWGxnWPNjXHl6dxY54IOWK
 3/37jKPl+NmDObLt1+DDYFJHQZ81ywQGalSJ39YPv5oJIQKjAFvF9jM/XtYUV0aAlNZy
 0P9YeORHG9VA/6b0LxgMsMLqfibVxCl3xVZJE26NeSVQJQOgXaiIVggSyPFa79Uj6obj
 PIrA==
X-Gm-Message-State: AOJu0YyyHZcOUsji1gOrUXpYwv75Qu14gnV+c0oHuY724gR89eSKTVHm
 tQ0BoSMmCZhRG7RCLxtQAOS/7UminN+YthZSFekjJSIgqfmmJllGW/1dnObvP3ANxwoKuy65i3O
 TxXDNI43sqcEXq6rHhsu/XpPTlAjuehUmXBd3mxxhqG9fGeuJfLG9shEZn0fH1lJ5/AxJuuAD2P
 aZZi1oQV3HtF8SFOEHO/RzSo1RFPiv2+e7EfnAjiCZCFQtIMcxkA4iev14FSYyD26YwGO8MZtyc
 k3gBL/CGnSXiEPnnupk
X-Gm-Gg: AeBDieso7aJTWOeGQqHpvolYI722sQB7mIoYLkcgidwY1POOxFUShOWwlTUcRL7g8Ta
 6HdsypM+ZT9mh/CehcjS0LqTyrR6Xwk/gpPbazDRb6c6d8G+WRxg+vIqYqPjVwP/x3qWbk5bPyf
 VHTeSxglNy/jfBkMMcIsc4QQU8dHb6R+WaQAJOl5x5SmjSEQWp2oEqxFRoBW6AI6LMzWNsZQVE+
 agxdr26KhJB/8usK+f49bZf9f/13rHuj3OtBvSj1WVNeV8jNNaZ3Bry8I0MOvCBILKmn+nFVZeU
 0j7pX1p5fkjhhot9rw2XwalsBbVqtNsFQ+rpPNMl1bEPbsUjJQbzBXBmBFBvCoQ7VPCl1EowkyG
 eOE9FvEsjCp2h0HXuY5xDhH1vAqthqYKX5+zDW5R8qS8M+tymHAmDuUhoaTkaO4EP2n88TYfHaS
 qp1JMnz6DTJxDxoIHmvtWULdveqTJEPhActztuVk/oe/zI03r/P3MX1wCl41EHyU3Y
X-Received: by 2002:a05:622a:5910:b0:50d:a5e8:39e9 with SMTP id
 d75a77b69052e-50dd5bd9b74mr297175201cf.20.1776225489377; 
 Tue, 14 Apr 2026 20:58:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-8ae6c95f866sm319026d6.10.2026.04.14.20.58.08
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Apr 2026 20:58:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-59e0abad4fbso4265751e87.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 20:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776225487; cv=none;
 d=google.com; s=arc-20240605;
 b=ZV5qFpNSboGpnvQmpe2AYeJEADGr9rFWDiIMzzx0X7xPE4Y+hDYbYzPTU9Al4CRVEw
 bijXupgPllCTgSi/7XEhv9ritd4DKQJiqd/IHy7cPc9W+M67ely8R8PtIsmo/p2RSG++
 eUidDbdzaIkjAvXA/55wdonrS3gq5v/sNl+8gEG5+y8Zh3oz+lCb3FAnrMxqOCqZEKxV
 ruUQNnFEWtjTiLEor006LIQ0y3jc+cbP40w8iDUloRz59+aF+LT+tOB3WfGlHiMm8J1p
 POppSxDpxxUPV6rq2aS6CyVbaQ4O0AZ0nte0oqZB2BPbJzNuEr/js7KXqS8yUv4fHUxt
 GHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BANB/iieo/1R0HSfYtGTIvn5A73RnuZ2+gO22EyqIKU=;
 fh=C8L4Ny/oMoH2FLKj7MTKKcp0UPsC4jwKK82I1KzYgTY=;
 b=cyXw1CL1EnvrB7NDQup1xGzjqQX8Dh5Sd8wtFn+lusfPatDsMD7JnhI46NmgGAlIWJ
 56ceQLlHylDm9NPf8CVVR9Iyv/5bDNLQluBPisakeGAmbSRrjDS3L6BGuVLm1dMVdUAo
 tdY79/iBxaqY1RT1rwKY9D3STnHyhgC5363LQ/3xnrIpdCQEde4Tv/zP3s4FHbMbfZgF
 cIR20m1vWw4fktgGHAx/gqaJ8sGVZUy3FI75k8JEaYy6/i57+p+r3d3Xs/u2K0g31pSo
 NX0f2G5wfCe0mYtjo5jSDVRApIGRFWpeVVGLK/ZTQ6lMTVcs5TVtZ/LDWcdG8FXOQ3DQ
 zL/g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1776225487; x=1776830287;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BANB/iieo/1R0HSfYtGTIvn5A73RnuZ2+gO22EyqIKU=;
 b=ZUypafw4BaPxtZBmd4LyNT1GG2Y6JMnGnEDpnm01JURkh75nkW7Ow0TO9l2NMgnyZy
 L6L0qFFDqu4Vfr99o1wV6zsG5EJsd4pRulsqDqPFiXcOhNjK74kINGP0IaVKGaLxen7X
 lXFkT8oYp68Iym0Zkf1NibXKOzi0cOwEWEZO4=
X-Received: by 2002:a05:6512:3ca0:b0:5a2:82d2:c50e with SMTP id
 2adb3069b0e04-5a3ef90d3e7mr6043560e87.19.1776225487536; 
 Tue, 14 Apr 2026 20:58:07 -0700 (PDT)
X-Received: by 2002:a05:6512:3ca0:b0:5a2:82d2:c50e with SMTP id
 2adb3069b0e04-5a3ef90d3e7mr6043553e87.19.1776225487006; Tue, 14 Apr 2026
 20:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260414200819.88506-1-ian.forbes@broadcom.com>
 <20260414200819.88506-2-ian.forbes@broadcom.com>
In-Reply-To: <20260414200819.88506-2-ian.forbes@broadcom.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 14 Apr 2026 23:57:52 -0400
X-Gm-Features: AQROBzA4Q_r3WIxWye4EL8OmPLWUUGztgqweUVJLdLwilbgTwOuILdnor3LxGq4
Message-ID: <CABQX2QPeCWGHRfLciRFPwBdLtmWmmiRiXcWrL0Z6Zagsqoqkhg@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/vmwgfx: Check for cursor plane changes earlier in
 prepare_fb
To: Ian Forbes <ian.forbes@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com, 
 maaz.mombasawala@broadcom.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000003ffc4c064f77b958"
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

--0000000000003ffc4c064f77b958
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 4:08=E2=80=AFPM Ian Forbes <ian.forbes@broadcom.com=
> wrote:
>
> We can avoid extra work if we check for changes earlier in prepare_fb.
> This avoids mapping a number of BOs.
>
> Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 21 ++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/d=
rm/vmwgfx/vmwgfx_cursor_plane.c
> index 125080c2a018..4f009aa586ac 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
> @@ -588,6 +588,17 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *pl=
ane,
>                 break;
>         case VMW_CURSOR_UPDATE_GB_ONLY:
>         case VMW_CURSOR_UPDATE_MOB: {
> +               if (!vmw_user_object_is_null(&vps->uo)) {
> +                       if (!vmw_cursor_plane_changed(vps, old_vps) &&
> +                           !vmw_cursor_buffer_changed(vps, old_vps)) {
> +                               vps->cursor.update_type =3D VMW_CURSOR_UP=
DATE_NONE;
> +                               return 0;
> +                       }
> +                       if (vps->cursor.update_type =3D=3D VMW_CURSOR_UPD=
ATE_MOB) {
> +                               vmw_cursor_mob_get(vcp, vps);
> +                               vmw_cursor_mob_map(vps);
> +                       }
> +               }
>                 bo =3D vmw_user_object_buffer(&vps->uo);
>                 if (bo) {
>                         u32 size;
> @@ -617,16 +628,6 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *pl=
ane,
>                         ttm_bo_kmap(&bo->tbo, 0, PFN_UP(size), &vps->curs=
or.src_map);
>                         ttm_bo_unreserve(&bo->tbo);
>                 }
> -               if (!vmw_user_object_is_null(&vps->uo)) {
> -                       if (!vmw_cursor_plane_changed(vps, old_vps) &&
> -                           !vmw_cursor_buffer_changed(vps, old_vps)) {
> -                               vps->cursor.update_type =3D
> -                                       VMW_CURSOR_UPDATE_NONE;
> -                       } else {
> -                               vmw_cursor_mob_get(vcp, vps);
> -                               vmw_cursor_mob_map(vps);
> -                       }
> -               }
>         }
>                 break;
>         case VMW_CURSOR_UPDATE_NONE:
> --
> 2.53.0
>

That's going to leak if ttm_bo_reserve or ttm_bo_validate fail.
cleanup_fb will only be called if prepared_fb succeeds. So, you'll
either need to skip this patch or create local unwind logic for
vmw_cursor_mob_get.

z

--0000000000003ffc4c064f77b958
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIE4X
jdp+ZO2bHFr0jTsaYN27DqbFGJiYDZnBz/Cs1XeIMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDQxNTAzNTgwN1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAFEgJpZRB/ovGNGVA5aTo15MGscAvzgYnTF9RbaX
/L9nX50u16eJHe2OZPhm7Ukc3KlMnMUwZpMiZIhT4YRwIL+g5cGWgMerrsDMdWcg+Gv90xa5DYwX
ZHER811i0KWSD1yy/lV2vPmzTNp4Hnz9VkpzwbH/XkhwsLvXVQSNkjb1wGU9Jv2/jTGPsxgCdTil
yHVEagNph5A7lLDlOySsavUm/k1slCVfLz5VQ6x7s3CueMtAL/Nf/Ft/DqrP5d5IDFYwWjs+NwSh
uFCh0Jk1udaBpbi6gYXul6zx9fBSP7RPxAS7//HTQqFcWevERG5EQv6CyGOUo8SDNEJSSMgDgzo=
--0000000000003ffc4c064f77b958--
