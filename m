Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBBB606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ScWHPfKE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D34FD10E469;
	Tue, 27 Oct 2026 19:01:04 +0000 (UTC)
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com
 [209.85.219.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1476E10E469
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 19:00:59 +0000 (UTC)
Received: by mail-qv1-f100.google.com with SMTP id
 6a1803df08f44-91c79a9a739so2865156d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 12:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127658; x=1793732458;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UNDt5QHmATN+Q7T46RVnb1ercfz00zNQeEN7liGBcJ0=;
 b=0XFirHy/lcTCujCi/kOkPbkvqaICIZsjcz3yHerVkiICkYXpwepX7E78xQ2twTEXee
 2l2wSieHWErGTF9KNuq4hHpAjPj936WQ3MVuw5kz89rphGoqT+l7c6XVr0+HMwq2jq1U
 TsOeAdzR2gUJzFDRXAwC6gYJuF5WsKSVSQsskIIUiQn65Nl3mAQHY/sAhkWq+jjvnkWd
 CcUCE1VzBRt9RPG9xEvfE+8Lu5GXogCewekD/M2LjxLB+o5AWlUueaphOYo/QzS6Px0d
 Bsmfs8gg8jgr3eA6QXGbtvtFHkTHquVpDj82vmvgrmADVLxgXbgJ0igetfYguRHZwZ4C
 DAHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgwtMehnei8DXAE1mxd3Ui7J1OI1boedQf3UETc2z9brT0j4veRjf/+Hn1TYs2pJBbwU5yGhmBI8k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLq039euhd8g0f3yWDLMzHrSQT27XAkYuW7o/RC0sp2qYl0BO42
 h7zsgg2Wqz80LXiYCVWt3rVPnjW6hE5FMA0OmXca1VzLHl47Y2jF8sW5aFV8twp+5409xh/3YSx
 I6nH/KdApDZV/V7UcLgZvAkD5qn4epCpqGCgjNQY4WQ1UO1oEKJkwI8BxPy2L9ZRyhxf6IHELlZ
 wK04KgfEemqEZyLmA1DCFV6ljeqVWN03OaWCxtwQ98eQDsTgyPcuL90dVsL17cbapqAqsowwH4T
 3CbuRZCB8xzofnVI8FS
X-Gm-Gg: AYBFou1WuNcA0PZmWHg3xdBLe7hMdoY0D2ZEaTYOey08Yo9GXVXT2tQd1dOdkkrrI0Q
 E79RlfK8xyhxRDwRKi+1Ed0mkmSZurx42B8gc9mYxjkYzN2rE4co4a4G34gJfwd1xLSukCMayNw
 5KWjKNCjU9mIGSEE9ltcc2GVcVKjZPSOYHt/6a70zZFQHRK0UAU4WSb7te+jjHAujZgsJuV0tD0
 vfqdbXcT5fbDN7e7BvKKUHIugSwsu/MZ2Jk5az6/0z4oTq9HUrZk/pFIA2mmDIFnYhG/dXY1chu
 KB2Uw1uEb/negiZjo38q9KTIOmVrRTdk+/VtSoqLBT6pwPvTSjXC2zKFDt9ax+8CXv8FsPPFQd5
 La80OpVUUq2gTRUNjIZo+TTuCgq9ErnKw4iiaIngoEhs/iP8UhDwwRYWshMa6cVre9+00q/NHLf
 cKtjeICKnP4EdAFUJzS0feBhgnUNvIkl/6
X-Received: by 2002:a05:620a:448a:b0:93c:b721:b10d with SMTP id
 af79cd13be357-940ef7ab6cbmr1691743585a.8.1793127656062; 
 Tue, 27 Oct 2026 12:00:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-940f0674580sm157307985a.7.2026.10.27.12.00.54
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2026 12:00:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-3ab25af70b5so460781fa.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793127653; x=1793732453;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UNDt5QHmATN+Q7T46RVnb1ercfz00zNQeEN7liGBcJ0=;
 b=ScWHPfKEumtGU4oOjYeaGOdqsqsMHv2xt4X0MKJq5xoVJkZne3K7He936kdw3xkjfS
 HUf35IFoaMDx4kwl445KTdNrldztNYIK3d2oQTBY5jsd+JTPLrWGoDO4rZLRdgKSqKZ/
 WUMJjtts90Jn8vEpbscGsSg6dGVjcvlqdwDjk=
X-Forwarded-Encrypted: i=1;
 AKwUvBwzF+OOekY1KhdqqDU4CS3FipnQpabqaAG2NbBPgnNlEybzhrjHic/NwwF7xAnvn4aKAwZmTQrvVfE=@lists.freedesktop.org
X-Received: by 2002:ac2:51d0:0:b0:5be:5b88:30c with SMTP id
 2adb3069b0e04-5bfcad8265dmr119780e87.28.1793127653527; 
 Tue, 27 Oct 2026 12:00:53 -0700 (PDT)
X-Received: by 2002:ac2:51d0:0:b0:5be:5b88:30c with SMTP id
 2adb3069b0e04-5bfcad8265dmr119775e87.28.1793127653030; Tue, 27 Oct 2026
 12:00:53 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAL1oBhpCSzXmPDRLeyJW443ocXyZizkFnzDLQz44BRPPTv0reg@mail.gmail.com>
 <CAL1oBhoT+F+On=d5m=Jofmee81kPsFv5mc8z1-rst1krCX71EA@mail.gmail.com>
In-Reply-To: <CAL1oBhoT+F+On=d5m=Jofmee81kPsFv5mc8z1-rst1krCX71EA@mail.gmail.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 27 Oct 2026 15:00:40 -0400
X-Gm-Features: AclHuK_hQLqVB3XwReNoiY8bdvYnulnaVzHnTIxU28G5SIXV-3XyxO4eaoNRtIg
Message-ID: <CABQX2QMQcQRUCjFOLtanOY-BsL-MQXwqLwkG1ZHEnW6GvLCXjw@mail.gmail.com>
Subject: Re: [BUG] drm/vmwgfx: GB_ONLY cursor updates ignore legacy Xorg
 hotspot
To: Tomas M <tomas@slax.org>
Cc: Ian Forbes <ian.forbes@broadcom.com>, dri-devel@lists.freedesktop.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000d997d9065ed71088"
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000d997d9065ed71088
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 5:32=E2=80=AFAM Tomas M <tomas@slax.org> wrote:
>
> Hi,
>
> I found a cursor hotspot regression in vmwgfx while testing Slax
> with Linux 7.2.9.
>
> Environment:
> - VirtualBox 7.1.10, VMSVGA, 3D acceleration disabled
> - Debian 13 userspace
> - xserver-xorg-core 21.1.16
> - xf86-video-vmware 13.4.0
> - Hardware cursors enabled through normal driver autodetection
>
> Resize cursors appear displaced from the pointer position. For
> example, a horizontal resize cursor with hotspot (13, 6) is drawn
> 13 pixels to the right and 6 pixels below the expected position.
>
> The theme file and XFixesGetCursorImage both report the correct
> hotspot (13, 6), but VirtualBox's VMSVGA diagnostics report (0, 0).
>
> Code inspection points to the GB_ONLY branch introduced by:
>
>   eef295a85082 ("drm/vmwgfx: Restore Guest-Backed only cursor plane suppo=
rt")
>
> In vmw_cursor_plane_atomic_update(), this branch passes only
> vps->base.hotspot_x/y to vmw_send_define_cursor_cmd().
>
> However, xf86-video-vmware supplies the hotspot through
> DRM_VMW_CURSOR_BYPASS, which stores it in
> vps->cursor.legacy.hotspot_x/y.
>
> The position calculation adds both hotspot components, and the
> LEGACY and MOB image paths also include both. Only the GB_ONLY
> image path omits the legacy component.
>
> The attached patch uses the same combined hotspot for the GB_ONLY
> image and its position. It fixes the displacement in our VM.
> Additional tests with custom cursors, bypassing the cursor theme
> and window manager, confirmed that hotspots (13,6), (6,13), (9,9)
> and (7,11) reach the virtual hardware correctly with the fix.
>
> For completeness, this setup also encounters the separately
> reported zero SVGA_REG_CURSOR_MAX_DIMENSION issue:
>
> https://patchew.org/linux/20260830151619.2452307-1-yunfeng.li.nb@gmail.co=
m/
>
> To make hardware cursors visible for these tests, our kernel also
> has a local workaround that retains a 64px limit specifically for
> GB_ONLY when that register returns zero. MOB validation is unchanged.
>
> Could you review the hotspot fix and consider applying it upstream?
> I can provide further diagnostics if helpful.

Hi, Tomas.

Thanks for this. I have a series that's addressing those cursor
issues. I have a better fix for the vmwgfx-legacy-cursor-limit.patch
issue so I'd skip that one, but do you want to send
vmwgfx-legacy-cursor-hotspot.patch with your signed-off? I can also
create a patch in my series with it but I'll need your ok to include
your signed-off with it.

z

--000000000000d997d9065ed71088
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIJ6W
JPKxV2fhSsuBc0VGOpzLMaV4AuzfUkP5tLFmdBfwMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAyNzE5MDA1M1owXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABkwK4ODAefGkcvOkkx7KefphxDsvHoO8y42nU+U
m88roe5lQ6k+9IaCWnQ+DywfylZUaytuh63Y70hnuxUZ44GuNAi+k6FOTdynz0uM/13iCjj8JXCl
PtJcyHw+KmOCmcRYcQXfDozFR2mEI18pWpcPJ/Y8DXdHojol1Wa/SLw2hqU+ADcGVq2OoZ7sCg2O
qjXSbiWN/AhxmlsKX3UGo2PnEu36+xqCvE9y7dXIhOhAyvvppAvCoXDr0EF+lhWLXh4fvyXdyqio
yCT7iw8FumvmUPLLU+jwX+ZezrInca9X4i7ie8KEIuC4mh+lGzC/t2CZzpkeyf4VdJawg1vLwcM=
--000000000000d997d9065ed71088--
