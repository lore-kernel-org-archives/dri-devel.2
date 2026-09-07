Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70193C79FAD
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C5210EA5A;
	Tue,  8 Sep 2026 07:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rTo4JCOT";
	dkim-atps=neutral
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 576FF10E051
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 15:01:18 +0000 (UTC)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a60591bb18so181443a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 08:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788793277; cv=none;
 d=google.com; s=arc-20260327;
 b=qWoig3eNe4mkDRKO9k8wzfzHK8o8qhmxcSLTjbl+0v5OG5eVX3RzYNM1W1inW2YifL
 HuxQfoxQ1GEC8/JwTxbVIcBwQl/K0Dxh5qicvfn1H+WLOGiuflxJzbx1T2tFzDDNeWbL
 mqlNHNFIqY3BDykWM89BJ4U5RMYswy3eS0xxaGXTshTI7E/A13sL2xstDgcb+4AjNnjN
 6lg3JyDIViUYmQr74pWmkBczoX8huUsHwvOJRz5NXEjXoQ1m4SHzKDcxAvi/Ka2HaanX
 InEpcYMy8AAE+mc6TT4y4GLSksNlDOeLxxWdMjEkeY1t5sv7Y8hoiJnNsuesX4Bg3/b+
 BZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=C/5SbezyWi1anxyCL1WLStNOIqEcreSWVvPab6/As70=;
 fh=c/HoroJRM8JUPzZ3fvzBnvQ+Jd2uZPQI9tAV3SepEEI=;
 b=Rfx1hPUC6aE+vMYOiATut7CLF16UahhLGdUQaNdrO6K+Urv4n4UA0oLLLrau/HeIMp
 QodhN9dzg6309nj2Wl3mbFk9efiLwfkzPH2GhfqW9wDxQU4xqG0IJhZ0bX1Ph3MuUhyZ
 QR+EaMS9cyR+oaimNRh0D4tLUtTHKscVMvQSw6fx86/meVCpeNgyrcbmJcsMcAc84LTn
 l+5gUuAfARJBKtBu2PNm07uPXZKECPyEMvTs9QogZgLj2tBh9jUYqMDKEbKPQaXfbDjE
 H+ojFYf01NYHDLseU2PpG14f3o6xdjTehgJLgQeQd0q2CksyE1ZaxT7rZh/B+I5zzrmD
 fwxQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788793277; x=1789398077; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C/5SbezyWi1anxyCL1WLStNOIqEcreSWVvPab6/As70=;
 b=rTo4JCOTrwxmKcf05e/C3YVuQUlBYgjET//cvjCpR0N8paT4Gkb3GS1mGVLDLXUiMk
 po/PK+f2s/eF36cHjvtv4XXuJgZklyKU5M/bB+/95bbsPnAv/SekdMPhbJ93tjaR7NDi
 +QhR/UbfYC9dPJmFcvBZuQ4XYSnXhmCrYuVTOF/QEO6SJ6Lh0gJq88z85qCYmi9Y2QzK
 Blx0m6IR4DL/b/7LOUrl+XBP1VSkyQPJPoa09xbIBI0gRDhkHf1UruRrtvA0JlXQsN3E
 tiw6uuEpVn02rUUHgs+W01dbbFGCPhAuJ4RSkXLxIMgIGT3mHWkh27C+SVMg7ofMmJo6
 cx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788793277; x=1789398077;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=C/5SbezyWi1anxyCL1WLStNOIqEcreSWVvPab6/As70=;
 b=WlM07TBIENTDnvHnCHBbKHlaDxr8UIToZAc7r6r2ywA+5ouEzW0/TBOsOui+98bsJj
 xdAx2Izu2teaSixUlLCB2HZP7syAJEK+ohZR92FDfJdEQZP4v0n48qK+KHn31TLK1vCr
 +LhQpej0GNsWK06Xrf8zovB9AWU3pg4MguSaXJRUupIVN5sgSqrP2d83zUlHWT504Ej6
 wCYYFiqH7B0tS88iDuWOwLffMYvVqjE5SeXKhafbHp8AiG9qKJ1yI7nYdPkj7z86D8dR
 Xruj3xkWtb4dJgrLHAqr4pO+9cmtQIhI5tymD7hzl4pQ/uPTVezClQ5PU0beZPxxawlH
 dM7A==
X-Forwarded-Encrypted: i=1;
 AKwUvByVdUZYl1697hkzzFS4dE/LDvI4+7m/sQ8qgV2OzccMoZR0fTTUxcPXnlypc9rH4QiS1DnRnpL7aO4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lyJsaqdVyHAsd9LsX/I+lVA2xZGvXJWD8wcbRCVHIdiIus/VP3
 k+6tgKTsoXMhdHYCqSKlGogqjhrK5b9oLUv8r5rwaN+CWxxcHWMpagPNbRKAHYLculXMquVbcHK
 oH3SxA/GfNZtMvUq7pkoUHQ4lHwpPDQ==
X-Gm-Gg: AYBFou2YrF7JxW8KMq8cJoexnokutr0WOfhCLSPUnTJtYslvKWo+jHd/iIX98ANC7cT
 USM8J/c/1ZLVxBNBBZJA/JKCruHfxcxIGUZMehMrruW4MSXLOcIx3LZA/Lx3f6c/ogfg/ACyzyL
 3s4kEvk3WAcmkQIL1BVSKv5dk38n10u6hzCICBfnGUwR1ZDGUrzydI43Q4dPl1gz4ocUu3DNlnL
 FYmE98BZmMkVWf4ppHUSRmdNKlI/dpKkpGkEHaOsOjF8p8VLo7owjjvd1QRfrRoQpbiTfn62yW+
 Wj+t3nBnryf9qhNcpxKsZ3Cgr8mRNc5NbVIrmzJAeEzCdB3/vUjn+CA9ei17dJmlqjViGalBWrO
 6Eg==
X-Received: by 2002:a17:906:c155:b0:c25:8b1e:3750 with SMTP id
 a640c23a62f3a-c29044392d5mr61538766b.12.1788793276384; Mon, 07 Sep 2026
 08:01:16 -0700 (PDT)
MIME-Version: 1.0
From: Danilo Machado <danilomachado2002@gmail.com>
Date: Mon, 7 Sep 2026 12:01:04 -0300
X-Gm-Features: AcwNN1UiCuTQvo7sl7tJPmxlZo-IKKg34erNkbCORKYwkqa5XlsrWnMFLo27VyM
Message-ID: <CAJ9xWr+xGevB00DzELbFK+LLGTn7Oj_ZbJ7OBN05+kHe-D-vNQ@mail.gmail.com>
Subject: Re: [BUG REPORT] AMD Radeon R9 380 (Tonga) - HDMI no signal after
 suspend / regression tracking update
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, dri-devel@lists.freedesktop.org, 
 linux@leemhuis.info
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:43 +0000
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

#regzbot back in-progress
#regzbot monitor https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389
#regzbot monitor https://gitlab.freedesktop.org/drm/amd/-/work_items/5123

Hi Thorsten, Alex, and Linux Kernel Maintainers,

I am writing to update the status of this regression after checking
the Regzbot tracking dashboard:
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/CAOnW2VTGBP=MMWM=W41uPDLrzTVHM1sw8P1myvftnNk0vEMMFw@mail.gmail.com/

The dashboard currently lists this issue as "fizzled out / resolved:
inconclusive", but I want to clarify that this bug is ACTIVE,
UNRESOLVED, and actively tracked. The lack of recent email activity on
LKML was due to ongoing technical data collection on Launchpad and
GitLab while awaiting upstream feedback.

Current Status & Verification:

1. Launchpad Report (#2142389):
   - Status: Confirmed (assigned to maintainer Timo Aaltonen).
   - Heat/Users: 220 Bug Heat points with 44+ explicitly confirmed
affected users across various AMD architectures (Tonga R9 380, Polaris
RX 400/500, and recent Vega APUs).
   - Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142389

2. Freedesktop GitLab Issue (#5123):
   - Status: Open.
   - Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5123

3. Technical Summary:
   - I have executed 3 full git bisect routines on hardware
testbenches, isolating the regression behavior between kernel
transitions.
   - Recent user reports confirm the same black screen / no EDID
handshake failure upon resume and DPMS display wake-up across multiple
Linux distributions (Ubuntu, Fedora, Void Linux) and kernel versions
(up to kernel 7.0).

Please re-open and maintain active tracking for this regression on
Regzbot. I remain available to test candidate patches, kernel builds,
or debug flags on physical hardware.

Best regards,
Danilo Machado
