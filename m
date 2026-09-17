Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E50C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:10:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7277310F1E5;
	Fri, 18 Sep 2026 07:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LWsBhdiL";
	dkim-atps=neutral
Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com
 [74.125.231.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A6ED10E732
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 16:02:21 +0000 (UTC)
Received: by mail-oa2-f12.google.com with SMTP id
 586e51a60fabf-466ccbd4773so383778fac.2
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 09:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789660940; cv=none;
 d=google.com; s=arc-20260327;
 b=ZlhOLtDBtTYRbL8w6Vq5Snd39wRXNFwaCtVjhj+/6taCunE3LAaBErG62uv/bBMJCI
 gbUnuzdfCd1kNHyY6oRydR+VsU7NgjITIf5vjabdqSXYZuvNzg0qVMdhNAg142fGxt02
 argiJ9oq3V5MAN91SBwe0C16kCAng+Hm0Lx1BI6Fl5/9/glv5QTlZJ/UhM4c6CPgJOue
 UPkz2txiVHIKpCDV3637cFjxPK9iphO3wHqI9cKcZC3JrCztlkt0RGO3zt0rBn1Roqhb
 r0ubgShSS4c4FmCXFr4vYByh5O4V9vcK2ZbHzcQAy/tBJIsEfI8SH3S8/7lc89yWsHIZ
 SYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=b0tUvCCKxWiukowbms3IQFy9J4GEYM5tWNQBQqifKDQ=;
 fh=rdVGboUKQTe2PQPC07+N7izNoR5Mh+KRwIz2BQB2NMY=;
 b=H7xLQwfdHWK8Z181ifxnO6VOFLZfGC87wjS56JpZPeh0efH9XJaZb1cs90i2Udb1kj
 FJv+rjXj7RUHDUcLvIvxpEgdTcAgUibRqI0YkEs9QWdo21YAMaYUgMIj6NZZSDA4HTe6
 VNmtWNgzxQCU4wp8BAZqr1rlzZxpADkmy7bP2YaHQCPEQgLHiZzQOhh/LHkYH3wEWJ0+
 qi72V5ZyNMDHdlcBzrUwY1esOVZepbMZaNLo1b/BvLOrGxTE+1Hm6c41Dui6Ni98ruVW
 auME9sct1GJ0z1afjHQU2uqACNYR7K10kb6wi2NyblDrAsA+kOrCiMKnYEjRlHkOvh1u
 BwVw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789660940; x=1790265740; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=b0tUvCCKxWiukowbms3IQFy9J4GEYM5tWNQBQqifKDQ=;
 b=LWsBhdiLK8yh6NTuSI/A5O5L5v/cSnZmUGq6ilHgEB7v57K+K0pxvllIpBW1MJwzKp
 NPN2DnXSfUxzBg56RYDYMuTS7vGVu//B8uGoyu1neDMdjLHb4i8+jp58lqYbd06H3j/n
 4ZkFX2RwgV/mVD1DK6QXZzj5PAhbv/uuTcgylJm2T1p64/kL4lvOXqgUbMvUldwoRfT1
 4/xFzmiYtpARm2QyOSMI3lM7u7/aqhrDWHpl+6P5g0Fss6R4jUfzn/RRXBf8bUJIASD1
 3g95I+kEBI48V/FX4TUf6/m17FZ0tQh95+ljWsZT6nZ0M+2DDe7rBGsoQfgvzr6Utr46
 Hwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789660940; x=1790265740;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b0tUvCCKxWiukowbms3IQFy9J4GEYM5tWNQBQqifKDQ=;
 b=LSxyZyQRPxdEBGR1BDog9V0MJj1uYkATM0V4qSQG47crTgwYcNWQRhEpoza06bYVpO
 EUfcTGqp2AjDZ+18MrktmL6PjuKFN1DSTWJqBLyNXjYjfehiIv4i6+2UQUGRUFLrvE7W
 ngyFdooXhjFM+XlqerUL0Dzb9tqLozVD/w3SrgZSW9Y6PE152lUcfPHoPf/uIcDvmFTg
 s+CfvLVpmJcdeV9vaNtJqtii96pI1VlNrhyZWcuPVUCYODn/pW0Jy7WMBjv5eZkHua65
 XnioWmN0vcHcNwAwXHUi+TCZeRG412EP92W3kTbd+mkEQqMrG/V/U9tDEkb2cc4QIPgO
 wcqw==
X-Gm-Message-State: AFuF++m7Xr3OYvWTNH/QEOwdv7S4wt8E5HBriP/1+doY89Q/NnYKyUha
 /xoqGSQCtPt1e5NNSFeCUkTXhq8wc08TyH7SRKxO3W+yg1Xndx+DC1saZ3iOE3hyvpfnIeEKb8v
 2o+px06co2bTfeeKvGwxCOl6Ftstd5C4/bCNP
X-Gm-Gg: AYBFou1HfQ1Md7RtSMaOZFI2cxPZBxr3Cm9p2FKZJtA2zSIa68imIe1CtZ6WjI8aAZC
 HftSFXTONmSEmgoj6TpulRMu3fHK92OtZWa3qpfixn+YMJuzPr/mlSU/XwPuD/STYPje6Y/r6kA
 9mfZcbm4YtT6niWbY0T/bovIwtVCJ7g/h4QLtQDV1zh4+ensyqYTVvkIBFlNKRCAsyTQryOYrz6
 M03rfbMZLzABWFkoS0b3G1/e9H8Sn+A/S63CsaorE8mk8mRQoB2LVj0Syy3lImt6IJyHQggN+Sm
 hb3PlCXdn4df92U/Ue4gq0to9oHhXE1vr9vIVZrFCYNi+2xNjsGvREWaCCUHMl9lHkITpDNtnCK
 CApAjH53q3cMu84VIdH7qqGTT8IkE2yCf1FiGhmIPr+/GMKiFYyGUzFDo7UE3Ocl/iREP0FSo5C
 0=
X-Received: by 2002:a05:6870:b3cd:b0:483:b752:633f with SMTP id
 586e51a60fabf-48477b05245mr7431722fac.36.1789660939885; Thu, 17 Sep 2026
 09:02:19 -0700 (PDT)
MIME-Version: 1.0
From: joao 222 <joolucas64@gmail.com>
Date: Thu, 17 Sep 2026 13:02:08 -0300
X-Gm-Features: AcwNN1UP5qZW-lZHKgUX3VxHAPiIZeCzJeooFsndOnyuIJ9kqDLDoVeL6w4tAOU
Message-ID: <CA+irm5xWBnH=2VwWz-YTsWc_kMK7x9tskdNYzmQjejn21fQnnA@mail.gmail.com>
Subject: [BUG] drm/edid: Samsung display reports 1360x768 as preferred instead
 of native 1366x768
To: dri-devel@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="00000000000097724b065bafe859"
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:10:00 +0000
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

--00000000000097724b065bafe859
Content-Type: text/plain; charset="UTF-8"

Hello,

I would like to report a Samsung HDMI display that provides an
incorrect preferred mode in its EDID.

The display is a native 1366x768 panel, but its EDID marks 1360x768 as
the preferred timing. The EDID itself is structurally valid and also
contains a valid 1366x768 timing.

Display identification from EDID:

- Manufacturer: `SAM`
- Product ID: `28744`
- Serial: `16780800`
- EDID version: 1.3
- Manufacture date: week 1, 2020

Relevant timings from the original EDID:

    DTD 1: 1360x768 @ 60.015 Hz
    ...
    CTA DTD 5: 1366x768 @ 59.7895 Hz
    CTA DTD 6: 1360x768 @ 60.015 Hz

Because 1360x768 is the first detailed timing, it is treated as the
preferred mode.

This appears to be incorrect for this display. Selecting 1360x768
causes visible scaling/blur, while 1366x768 produces a sharp native
image.

The important point is that 1366x768 is already provided by the
monitor's EDID with the correct timing; Linux does not need to create
or add a new mode.

I tested this by creating an EDID override which only changes the
preferred timing from the existing 1360x768 timing to the existing
1366x768 timing.

With the original EDID:

    1360x768
    ...
    1366x768

With the corrected EDID:

    1366x768
    ...
    1360x768

The corrected EDID passes `edid-decode` validation.

I loaded it using:

    drm.edid_firmware=HDMI-A-1:edid/samsung-1366.bin

After reboot, DRM reported 1366x768 as the first mode:

    1366x768
    ...
    1360x768

and the desktop selected 1366x768. The display is sharp at its native
resolution.

The same general behavior was reproduced with different Linux
distributions and hardware, including a separate NVIDIA-based Nintendo
Switch system running Fedora/KDE on x11 so it does not appear specific
to one desktop environment or compositor.

Current test system:

    Arch Linux
    Linux 7.2.6-arch2-1
    NVIDIA DRM
    GNOME / Wayland

Would this display be appropriate for an EDID quirk to correct the
preferred mode, or is there another preferred-mode handling mechanism
that would be more appropriate?

The underlying issue appears to be that the Samsung display is
providing an incorrect preferred-mode declaration in its EDID:
1360x768 is advertised as preferred even though the panel is 1366x768
and the EDID already contains the correct 1366x768 timing.

I have attached both the original EDID and the corrected EDID used for the test.

Thanks.

--00000000000097724b065bafe859
Content-Type: application/octet-stream; name="edid_raw.bin"
Content-Disposition: attachment; filename="edid_raw.bin"
Content-Transfer-Encoding: base64
Content-ID: <f_mu5pu56p0>
X-Attachment-Id: f_mu5pu56p0

AP///////wBMLUhwAA4AAQEeAQOARid4CiOtpFRNmSYPR0q97gCBwAEBAQEBAQEBAQEBAQEBZiFQ
sFEAGzBAcDYACiUhAAAeAR0AclHQHiBuKFUACiUhAAAeAAAA/QAYSw9EFwAKICAgICAgAAAA/ABT
QU1TVU5HCiAgICAgAa4CAzPxTYQTBRQDEhAfICEiBxYpCQcHFQdQVwcAgwEAAOIAD+MFwwFnAwwA
EAC4LeMGDQEBHYAYcRwWIFgsJQAKJSEAAJ4BHYDQchwWIBAsJYAKJSEAAJ5mIVaqUQAeMEaPMwAK
JSEAAB5mIVCwUQAbMEBwNgAKJSEAAB4AAAAAZQ==
--00000000000097724b065bafe859
Content-Type: application/octet-stream; name="edid_raw_patched.bin"
Content-Disposition: attachment; filename="edid_raw_patched.bin"
Content-Transfer-Encoding: base64
Content-ID: <f_mu5pvvkb1>
X-Attachment-Id: f_mu5pvvkb1

AP///////wBMLUhwAA4AAQEeAQOARid4CiOtpFRNmSYPR0q97gCBwAEBAQEBAQEBAQEBAQEBZiFW
qlEAHjBGjzMACiUhAAAeZiFQsFEAGzBAcDYACiUhAAAeAAAA/QAYSw9EFwAKICAgICAgAAAA/ABT
QU1TVU5HCiAgICAgAVoCAzPxTQQTBRQDEhAfICEiBxYpCQcHFQdQVwcAgwEAAOIAD+MFwwFnAwwA
EAC4LeMGDQFmIVaqUQAeMEaPMwAKJSEAAB4BHYAYcRwWIFgsJQAKJSEAAJ4BHYDQchwWIBAsJYAK
JSEAAJ5mIVCwUQAbMEBwNgAKJSEAAB4AAAAA5Q==
--00000000000097724b065bafe859--
