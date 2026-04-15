Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0627DF9D0FB
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 01:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 554D510E002;
	Wed, 15 Apr 2026 01:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="KMxgbmCh";
	dkim-atps=neutral
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D497910E002
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 01:08:17 +0000 (UTC)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-358ed696623so2736305a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 18:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776215297; x=1776820097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YA01/1FSYmvJMtxY2DJ6U4MtwgH58zijorlJqnB9ic0=;
 b=OVTKODrSQ39N3UagaCflIU5CXTulvTrOKS43EMKdSXkTrQu1TZIF3g26va1YnLLOhL
 uMXf5NID8Mh+llnfItxDf3UZAmP36tN94LhvjgkDm9cREEoAy8paDIzMUxRYQKSv645x
 zFhW0lPbmDvRcIaXGFWsnn1LNBfE83IHU2nD47BngWhaLJO5VaF2nHAPb1FE5KbjArwc
 jtniIyz0Dwfj7npY+wN7kC+I6vGrIUP9cMLwaM+5+o5nTtcvOUdwnPgr+Ku9YqHOxNY/
 AVXaueb1jccb6zFzu3tqqLLLaPHl3pyt2he25ntp40VztMbR610st8FWfQZN2P9RaDK/
 u2VQ==
X-Forwarded-Encrypted: i=2;
 AFNElJ+ntBLNcR2Gv2G8Y0WMHusc6W+GE1wZZPNywtq8AINX50wathJDGYeWnqSAOOYuF1Fl3UKr/WGp7MY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyv9j68V+vTGst72Eob0C8paEdMXPhynMTr5cjzkCRU4eJkVw/5
 eYAEDIQyvqtYkWJXqsDz6dtWyfCsGnzIA4Ebc/GEBtTkUUhT1fNC2rdpbtlhGTYF7fGVmwKLn3W
 86XCT7YmbW8PdY9LIWilJFYt2v/7HQ+ELR42JxWxPxIHEnJkoKfidzN3CpSjyvSkGq9OZhzfM7X
 IYEIE/f7xq2+izHezzJj5gPswKzYUR27rOd5ITYiuy8dyFXeJ6ytnyi3hZTRy1w7G+L6SFbwlxs
 RZCTMqaskNAMgrjKSJK
X-Gm-Gg: AeBDiespGzHimNu/9fm6AyHeWJu27ol2ZMjL2NJq8kpkw3en19mjxkuiFQxiFb7ozpQ
 /McH1tVeKpXP2de5JUCtyKpEexIWWkDoeOLe+aiz7cX+z+Nm2RpCCzEnqqKiDrUItuOGVT6FFhr
 U6h2cpDwjqrfFoMyaHGNEnrSSaJhAFBJh6598QeBCDRjKoFAUYhaIhK5gxWPeUOZBKfQHYJBBBw
 UAsC8FIykTM5tH58v3kUo+SdLLlezgXenMxUjpT2dfPnXwZ1KPAZGVJn4g+EdtKOTCq87g3HeFw
 bUExvVb0kBMLBduJKpnvOw9fhT6gAXzE6axUYGWqgvc/729T8JyOxu+pKTT1jL1kv2ee5ege8sL
 rA5GL6N1pWqOBqCOKOJGGpK2Y9CTIVx6TindVHN3mSHbbhD4kl3WgB3uaSFHGHlVWzh4lPk3BoL
 2BZLHBDqsDNAEZau+LtwkvMDofgeRTVBvZwLf1uGyu+3aM00RJGzam75PO2QxBOLqC
X-Received: by 2002:a17:90b:3c10:b0:35f:b572:ece9 with SMTP id
 98e67ed59e1d1-35fb572eef3mr10176184a91.5.1776215297142; 
 Tue, 14 Apr 2026 18:08:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-35fd30867b3sm5778a91.2.2026.04.14.18.08.16
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Apr 2026 18:08:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-59f8dc94e84so3166872e87.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 18:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776215295; cv=none;
 d=google.com; s=arc-20240605;
 b=XVYGF6Ifl0tz8RCAo8UfflecIssxKrmBMuvBK4fjGT0+Oz1phZQwnmYj7sg1ASBRGJ
 GuVHFUQuW20kWzeHnefpdNEh8z5eE6YqffUHLVJFuubcEMH1oDSdxol9z1d6cGhJ9cVR
 6oZTdG9UJp+eLGwZN5TF6vCQRlDzW7x9zkIIIqYHL1WlB4ptiJ2ldmjRacDTFKdkIpRq
 ZYpSgM2YvIAamZC2TNv+o8gDUBfSx97oCmzT0xyVg1fEbLsqbJgdOR0hLRp7/N+4NAh+
 vO+IFm+unqlQP2hZEu86/epGV7zEylcZVRUMjSSOAFm+0HaBmRi8IwNW+IsYgHxGlO7O
 LRxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YA01/1FSYmvJMtxY2DJ6U4MtwgH58zijorlJqnB9ic0=;
 fh=iLlfaT6R7PhmIkZREK2c9OQHIrs2zrPgM2wG6Y1pKaQ=;
 b=lsR/JoNad6T+mP6cWse0bondE5cmB8QGb/JhtJ3DRHOZLp3/XvzzUbW2nkigBs8wOO
 y3QM5H5YlvMASxfAzvndTs9ijcWxPgk4KhsLt9TFDlFfXa8O/1q44rs7v6xuZZ5D2gGp
 KOtBLePHH+I0fIiOfXbEjMXXug92G178BTPRw2Man9XNKC28M3x6ge/RDkl2tRuJ2iV7
 XCO08wRomzba5Kkep07QI8zxIjl1NoiHZCKAE+osKnl9OBdbWkGo7DviHLT0n9zEw614
 ukUKWlaQ7zX825K7YbDOVBm1Vedc1QTnTTZFZEwRVB3PLU6psriJwDGE25b/5wRzaDKE
 EJDA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1776215295; x=1776820095;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YA01/1FSYmvJMtxY2DJ6U4MtwgH58zijorlJqnB9ic0=;
 b=KMxgbmCh9apqzTj1QGJB7+XgJMDzU2wdGcFRa4YjCnwHtnbHfqYESJF0/MOWH1O8Po
 ya909NWtcLg15ST5XcepykIz7If+txt4I2HNo0bMKp4VhlBRamrNSBggtDP8zmLa3f7j
 9J68xoqAcGKyMYxe6wpRR0I16pLNSMh9hjQ0o=
X-Forwarded-Encrypted: i=1;
 AFNElJ/VnCIAROXsQ8bXa2iAzjBq4WfP2ukKAUaDQkEa/HjOWuwGnQpXWMomuBw8QF+6da/I4c6Y1JYcbNE=@lists.freedesktop.org
X-Received: by 2002:a05:6512:3b28:b0:5a2:c210:4631 with SMTP id
 2adb3069b0e04-5a3efb281d6mr6506452e87.24.1776215294984; 
 Tue, 14 Apr 2026 18:08:14 -0700 (PDT)
X-Received: by 2002:a05:6512:3b28:b0:5a2:c210:4631 with SMTP id
 2adb3069b0e04-5a3efb281d6mr6506440e87.24.1776215294435; Tue, 14 Apr 2026
 18:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260414105529.9883-1-popov.nkv@gmail.com>
 <ecf4cd01-b05d-4f51-943a-631cc4b27331@amd.com>
In-Reply-To: <ecf4cd01-b05d-4f51-943a-631cc4b27331@amd.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 14 Apr 2026 21:08:01 -0400
X-Gm-Features: AQROBzB9xDYvxtGn-vVFYidT-0afNkRbq08eF7asqpx7x2PE8EMbH6-BtwZ2p0U
Message-ID: <CABQX2QMH2XFcuz00DQQWU4uKw2B8OzE4rCE5=8LMXDg4t0AqWQ@mail.gmail.com>
Subject: Re: [PATCH 15901/15901] drm/vmwgfx: fix NULL pointer dereference in
 vmw_validation_bo_fence()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: popov.nkv@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, lvc-project@linuxtesting.org, 
 stable@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000baa194064f75593e"
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

--000000000000baa194064f75593e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 9:25=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/14/26 12:55, popov.nkv@gmail.com wrote:
> > From: Vladimir Popov <popov.nkv@gmail.com>
> >
> > If vmw_execbuf_fence_commands() call fails in
> > vmw_kms_helper_validation_finish(), it sets *p_fence =3D NULL. If
> > ctx->bo_list is not empty, the caller, vmw_kms_helper_validation_finish=
(),
> > passes the fence through a chain of functions to dma_fence_is_array(),
> > which causes a NULL pointer dereference in dma_fence_is_array():
> >
> > vmw_kms_helper_validation_finish() // pass NULL fence
> >   vmw_validation_done()
> >     vmw_validation_bo_fence()
> >       ttm_eu_fence_buffer_objects() // pass NULL fence
> >         dma_resv_add_fence()
> >           dma_fence_is_container()
> >             dma_fence_is_array() // NULL deref
>
> Well good catch, but that is clearly not the right fix.
>
> I'm not an expert for the vmwgfx code but in case of an error vmw_validat=
ion_revert() should be called an not vmw_kms_helper_validation_finish().

To me the patch looks correct. This path is explicitly for submission
failure and does BO backoff plus vmw_validation_res_unreserve(ctx,
true). The backoff=3Dtrue branch skips committing dirty-state /
backup-MOB changes, which is only correct if commands were not
committed. Here the commands have already been submitted; only fence
creation failed. So I think unlocking BO reservations without
attaching a fence, then letting vmw_validation_done() keep taking the
success path for resources is correct.

iirc the same helper is used by execbuf, and the shared-helper fix
correctly covers both paths so this is probably not only a kms issue.

Untangling this code would make sense because it's confusing, but
that's not something I'd expect Vladimir to do :)

z

--000000000000baa194064f75593e
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIJbU
+Ul2Ju230MA3piovGJ+/oE+VmOysjBq8WgmmmKaMMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDQxNTAxMDgxNVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABBa5jgr3/OuBTC1lDJjNPgvsppmGdM6Q6JA3BBA
uLZ6K0OwXUJYVyai2eFDJKjM0Tlk+hyn1bYrW1WvfXBkfvl90BYFFMOH1VvqtTU7ftdjfbsJL9ej
0owoDkug41eKCVHoHVl91rcIS6D3G6y3t6BzuKqhzdNYs7Kyj7wRoNHw2YHC1ySM98dQRa1wXqwM
ugK938rLCbH0S+WUDpM/OWJW6LmhnSGqZ6fi9GYOk9CA435iROfAWVEN3GtcJsQZa1DvN4j+EeN/
kuRHfWzW446PPVl5SPzLXYW+mZH9WAHKdyDysRalQm1kdYqIeTIVnCBgD4mFOm799BYuQFkPfXk=
--000000000000baa194064f75593e--
