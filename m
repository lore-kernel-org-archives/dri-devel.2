Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B61EC5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:49:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC5D10EBD8;
	Tue, 18 Aug 2026 15:49:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="e/LVkZOz";
	dkim-atps=neutral
Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com
 [209.85.221.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEBC810EBB7
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 15:49:10 +0000 (UTC)
Received: by mail-vk1-f228.google.com with SMTP id
 71dfb90a1353d-5bf959b820cso439415e0c.3
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787068149; x=1787672949;
 h=content-type:to:subject:message-id:date:from:mime-version
 :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dkVUn/mgrDAVs1y9qEcWeBHMi8rHw4nUkP8B2Y/tRnc=;
 b=aRuZ0GZ9Mf393briRPWSEPHjcffgHvcd5zeB6KRGiAleBdfeX8I3fukm3MxzxF/aiC
 GcLGLVxjK9wnwczVLomWKGXgGan0C9Qxe3KZYAjYrHuNKdYpiIyoMg+Xxh9Io1Qs9a4z
 LzKtUx0pFkswesQwfOVuKKMnhhMi/Sgcwx3sk+hqip5AUoE7Xh3ujW8Gu9J/2cRapshY
 UInIG73NMwCgPDy45vuVuMLhgtAqq4nf+LHrPFHQ0Tqzs17mUM8m9C3P+ElLvolWH7yE
 tKdn6PmOEeUWwFBkS37W4Bmia5HcYhp1vNtp0ncHeOf2kzq97+AZA5oBc+4m3EoqxZP5
 HiGw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFiM3Ok0BbQpQl1Sf1IN4ElCBrYM4jDmYo95sFZ06A1N+k4Jlcoe0IgWNcJ6jRVy5URchLA6I0mpo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFVEE8gozxwi7CO6SvOBjEWnehYMp6Cn2geoB0N4VCubfPmZfg
 vECsGsWzWVVoQHTYJz6UvrjkCy4zuANJ5hZyHGQ6wU9U4p2as0nudHIs1fZdhkVJSzjZ+RvFn70
 QPkK5kd89eBcQ+mTAHx3QTiGJ8izC34qe4HzbJYP94IYN2Scn90DcU5eRlwHuqZUuPmdkWozDam
 K+qC34+YLrINuTTU7pmkVaQE/Np7peLw6lVD72CSDGe/v1AmOELJ0Y1OuZU+nONPaFYYoYUjzTZ
 NxKKl3/MG1lO/Jbcb4w
X-Gm-Gg: AR+sD11MAtlvN6II6yk5Ek4LT4AKfBwbNDCw2jxxeLWiWFlwkJyx06dJY/eGGlib9E6
 BH+rmiKte5LjZLSp5U8qCpb5mLQYENcfMJVQsdprACY/U7b5YsxU5H5ZxlbJT266YWR5oxakTgD
 knjvwmvxu3bqB1nAVAG3lPNJ2qrSpPYlne/rj6Fy7bmnW1PhHiJxI0VXr+98AyFf/qI7gUk7j6d
 DQFZ06mmxfrWT0dGtvN2K/7o4cIlC7wEQAQdY+JgKgRtjWU52j1uB3Bp5s0nO6z6dSAM1Zkk6OX
 xUli0HmFyvG6Bgm/BTiJ1dExLDCw3kZcdAFhg7y75RWIx6SGvJM4xHOIjoZbWIgonYyDm3ssoKQ
 hEm7SXz6CgcrlxgJjp9m3wLHdbuEkyGwSBQkU9D0h8aKG1ORbw5SI759iJBK74gShUTnAMIrMz7
 7iKBBalSqIhskvhBbORSDdLzOc3YGVA1y0
X-Received: by 2002:a05:6122:6091:b0:5c2:cffc:2c55 with SMTP id
 71dfb90a1353d-5c59178bfc2mr9380652e0c.0.1787068149541; 
 Tue, 18 Aug 2026 08:49:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-5c5c74ca444sm1230396e0c.0.2026.08.18.08.49.08
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Aug 2026 08:49:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5aeb72bda2aso21491e87.2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1787068148; x=1787672948;
 darn=lists.freedesktop.org; 
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dkVUn/mgrDAVs1y9qEcWeBHMi8rHw4nUkP8B2Y/tRnc=;
 b=e/LVkZOz18cw38MjFgoYioFqYY/SynQW5JFJKDVBVqHgwll93oWdOfRBkNuPKI9GV8
 xU5twhN2QA0ZOsD9yfTgfvaBis3M59rqDQDWRX1QIQsYAMP+Aq3HLt+yijIu5n0bXmLs
 2j38TM8X9QAGoMc6/uegXAgCStmCPMCW0EzLM=
X-Forwarded-Encrypted: i=1;
 AHgh+RqURsvb/ZeQ9JBtfOIvw2AO1rvSWc6qh8ALQSdnlzz2YDGZ6SQZAFuYjBNznf0GSypZE4o6g0Jav38=@lists.freedesktop.org
X-Received: by 2002:a05:6512:1310:b0:5b0:eda:de26 with SMTP id
 2adb3069b0e04-5b45915e3e6mr6472441e87.16.1787068147723; 
 Tue, 18 Aug 2026 08:49:07 -0700 (PDT)
X-Received: by 2002:a05:6512:1310:b0:5b0:eda:de26 with SMTP id
 2adb3069b0e04-5b45915e3e6mr6472414e87.16.1787068147031; Tue, 18 Aug 2026
 08:49:07 -0700 (PDT)
MIME-Version: 1.0
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 18 Aug 2026 11:48:54 -0400
X-Gm-Features: AcwNN1VLor3Fo14iYVXfQ4fxz4zLqfL55p_sK4U6xCJsLIrfuzV2PWqqmxSVcR8
Message-ID: <CABQX2QNJwu7jAHo8vjJOs97yyfLiSMtZVb0sGEsSH0Uz8dxB=A@mail.gmail.com>
Subject: Abandoned patches fixing real bugs
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000280d230659543ab3"
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

--000000000000280d230659543ab3
Content-Type: text/plain; charset="UTF-8"

Hi.

Lately I've started seeing a lot more abandoned patches: a new
contributor sends out a patch, it gets reviewed, issues are found that
need addressing, but a v2 never arrives.

In one situation, I received a patch for a single line change that was
fine, but the description largely hallucinated 5+ paragraphs of text,
suggesting undisclosed LLM usage. I asked for a v2 of the patch to fix
those issues. Then, independently, I received a bug report. While
investigating it, I realized that the same change I had seen before,
the one for which I requested a v2 that never arrived, is part of the
fix for that bug. Now I'm not sure how to approach fixing that bug. I
could:
1) Grab the original change and rewrite the commit message,
2) Add the original change with the hallucinated commit message,
3) Submit my patch that includes the same change.

Option 1 makes adding a Signed-off-by feel a little silly because I'm
almost certain the person who sent it didn't write it. And what if
they did write the code but wrote the commit message when they were
very drunk and a month later come back with, "Why did you commit this
change as me when I clearly didn't write the commit message?!". Option
2 has the same problem as 1 but also breaks history by including
hallucinated/incorrect commit descriptions. Option 3 just doesn't feel
right, even if developed independently.

None of those feel particularly good to me. I'm inclined to go with
option 1, adding a note like, "Maintainer rewrote commit message;
suspicion of LLM usage." However, I can't ensure strict attribution
because I don't know which LLM wrote the original change and I can't
prove it either way.

I'd be interested to know how others deal with abandoned patches whose
code needs to be merged, e.g. because of a security issue, so waiting
months for an update might not be an option.

z

--000000000000280d230659543ab3
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIFpL
B5mfXgPDtpyCZWlWjNwqiIatACg20xynXGtX6YjfMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDgxODE1NDkwOFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBACt12u+Yn0Q84T74AU9TTNCAONIFH7fFxLnR08Os
KB2jb+4VOzbmRmgifiPRanlUmUXfX9Kp4l5/6tcAm8DdpSyQN+CXq9cWo31AVJJ835RGmX+OzeW4
MV+6rMkB5H9xny9jc4vRd2d0D1nNTQCcvToegymA9IMfIpfIoZl/ibpc2DQM5B7ItM68H8RtFMmf
2JuXzAb0cCUP/ciDGz7teI2rc7bZZZEewPyGaR7v4DUTBQGu+q5hFzaKxc5hg5A6D1n9IZcctrYL
itHDyWvbCKIluWFfRVbAMM6gi4E3umGzaHMPSUhSnKlaH1/GQ1GTnX5WHAYsaRUmNVN8Xgc+d28=
--000000000000280d230659543ab3--
