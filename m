Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A34CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B01B0112662;
	Fri, 16 Oct 2026 07:35:42 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB45710EC2C
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 22:13:30 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-93e64d52949so550469085a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:13:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792102409; cv=none;
 d=google.com; s=arc-20260327;
 b=BuhvyNmERi/prBbsdhDeyQg1V5Rfn3oB0My8rFEQmIB7l4vORoIzyBVyuyBUbsGCYX
 Tn68y4hG5dgkpw4N4cVevs+hLM7Uk33+ExFEcyOU940jHxFTvyGXPLlhaWGF49EQWUy3
 kJ/blXDKsJ58Lri/Th5NuE+oYySZ7tEKEOC8drL/eIaJ5YvA0eOlqLAMuaLmI9kmm+Jw
 IJyMnPj1wJ1UNzwjc9U9KkgDj9pkjIN0MBAa586yET1L4D5/OK//Dr1MEWnYy66c4QGH
 TXfzxDvYA0i3P+uu/QH2Fp4NIqI643qdqBT87MGJkQpiEugiN3kmiY2kM7tzMkz7K8g3
 vzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JqYDkfoISzLBDwQQXR6LTyNMTE+33UYdnZftkKh0VAI=;
 fh=iNdS+R3NFOOsSuPFyl7u1Qy9cwWGACALzX9tjb8gvfM=;
 b=eeor50lID3raHWKEAykB9e+iMyWZogTnnjvLnnFWFGWXFUTjpCL9Xtl3V0RiPQU44p
 JCgY2Ojp2DtlunNtoQFX67hdYjEu1NLsfcxIb9+MH9ajWpoAqW89/PgbeBQihj3yiH0h
 XTdu0kY+o49sNybbwTfePvEN41CxfdrNi1uzaUIYqhssWZTfCU0L7yDi/xNi+C7Iut/z
 /VIRaGc3sLSsnmwrr7jPnQRkLHUl1sOhc+XACB3Jqcrpx/JHsGJXC2xd2BXjGOOAHC6T
 QEVpSnTF8I4qpJQfHr5EgCYigWd0F+8BJaAoXR/riqcI7s5dB9JpsfhoipgxC3OsmRbo
 UvEA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tototo.si; s=acc; t=1792102409; x=1792707209; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JqYDkfoISzLBDwQQXR6LTyNMTE+33UYdnZftkKh0VAI=;
 b=hieu4mAHgK+32CCIpnXCJTszN5UJBdKq2C+atPipykD3xQ+6XHhjLOH4/+YdsXjW6J
 GT1TrYcv33nr/nVrkLVzIILAvuHBzQ0Jpw5CW8/IMR1UNA2fofNvh4ug9UW/pn8GyDP0
 pPQHVyPgCioyD2yTLRW9drjC6qGlcVPzXq45eby2dmTgbsAEm9YI/PSICcGmxQzeNPKL
 Zn4VNKClvd4oaC8oLv5ze/4I8Hbtq5KgPWkcBiBYrAMunBEV2mFM4xHlh5SWM2HWq/B5
 Gwd0nH9I+RbwuOEqsQ6BCJAucL4aTCmlqq9t4xrt16g8JLgoqFWTz7qURuZ5dNPTAXCu
 X7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792102409; x=1792707209;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JqYDkfoISzLBDwQQXR6LTyNMTE+33UYdnZftkKh0VAI=;
 b=zVDfFCiZ/dxW8nz8eBKGbwWg0+K7AlQNXiMBA1lFOE6A2/gOMedyvFM2iGBNJmTvsx
 lce6BDE4kQXBqA563PsGiEf9eB6ipceYbM1HHLZ+Y3uGI0keOSBEZDd5ev3Am75o1uED
 nhA6zGAFgV58wr0UBB/AY3630O+EfwSsqyKy1DQ8OQww6C11DzuA4BP46FS9K1YP8Spq
 HymcpIirfS5dNOaKvb0t9ChKcz42toUBLAd6hPu0uGiWOHTyrPk1chKHJ20RTyReSNf5
 2G71iwaAaR9lAI9FFMvay8l2LI4fHk+IB6drej2nMCQV57o01g+hpoWWUQSzcrFIBY15
 N2Aw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUMic0PyYIFnepKn/9TdHsFI8ob5GIK8BWpnxz74xcR5ELJBkQfc+wKXYkL31ACCixAP42A/wZcgM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK8FEUO8Kzo5jzL4Jc7bianRGakAwSmmvNQ2aZGxNizVnHCakzX
 JCRR25BwfrtAFe9RqGahliZJVSG/KxrjFkJzpFGDldhb3/krRrhuDLfF/Taa7T8rblxhBq8B//i
 ptlgGP+MvOEKoHlEXBy/tM/I2ZUVwkPJzyV9ZMQW4Yg==
X-Gm-Gg: AYBFou05QbjSssGxVBM8LtQLLEGxq+CCPIXTr0YvJByhGchu6sJLuhG76XbmjU+1wfX
 2IEj0QjAx6j9WHzUmOb5ZEZEOSEQYFTf28odL33X5dBo7ktDk7KvKa0qW+lyWvsRvgQC8eQmbP0
 DTV8pVKAgmnjn9KSA2PmorgRBzsUJZR6VizlNgqxvBULNZzj6d0k7g/EXZDOGBg34RbY6xqL/Pl
 6EyRlbB7Fi0gFZr08cTl1RtLSjeMfDWNAaOTzvByDLyLF4CTv/cKmPYjteBHRhK22jKxk+FC/cs
 Go7egWRpkzaZHMrvLVeWKfqngobBljoNM2OW8W70hYInMyVIXc9MwX9Rq33MvrsX0O0ItrjAKd2
 d1zme1zIl15zy8QDFPag3vTPiIAXpVEdJQOicAVgErpmr
X-Received: by 2002:a05:620a:6301:20b0:93e:c12c:f123 with SMTP id
 af79cd13be357-93ec12d0765mr2319680685a.79.1792102409418; Thu, 15 Oct 2026
 15:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <586d0b39-40c8-4f3d-a786-c1085f87b858@linux.dev>
 <E1AEF567-3705-4AE7-B409-6E6D70C505AC@linux.dev> <atE25_ZrIQct41wt@wunner.de>
In-Reply-To: <atE25_ZrIQct41wt@wunner.de>
From: Vasilij <vasilij.kernel@tototo.si>
Date: Fri, 16 Oct 2026 00:13:18 +0200
X-Gm-Features: AclHuK9I0yDPNPLitjPqdTfv5HCtW4bWJD7j6t3Cj0jJn68j6aocr7GGsKF-5Uw
Message-ID: <CAC=+NRGqTxz33PZL9dLPfbFbQDNvxyp3PXBSEQEmkh_Vbave5A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/appletbdrm: Add suspend and resume support
To: Lukas Wunner <lukas@wunner.de>
Cc: Aditya Garg <aditya.garg@linux.dev>, Aun-Ali Zaidi <admin@kodeit.net>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Kerem Karabay <kekrby@gmail.com>,
 Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 16 Oct 2026 07:35:41 +0000
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

On Thu, Oct 15, 2026 at 10:26:15PM +0200, Lukas Wunner wrote:
> I'd love to, but both v1 and v2 have sashiko findings that nobody bothered
> to debunk or fix.  (The fix for v1 consisted of removing a callback, which
> triggered other sashiko findings.)  I'm neither an expert on this driver
> nor the tiny drm library, but I'd like to help improve Linux Mac support.
> Please help me understand whether the sashiko findings are valid.

Thanks for looking at it, and sorry for leaving the findings
unanswered. I went through all of them; in short, the v1 finding and
the first two v2 findings are valid. v3 brings back reset_resume with
the error path fixed:
https://lore.kernel.org/all/20261015-appletbdrm-pm-v3-1-47377176619a@tototo.si/

v1, "memory leak of suspend_state on reset_resume error": valid. If
appletbdrm_get_information() or appletbdrm_signal_readiness() fails,
reset_resume returns before drm_mode_config_helper_resume(), so the
state saved by drm_mode_config_helper_suspend() is never put, and
fbdev/polling stay suspended. The USB core only logs a reset_resume
error and keeps the driver bound, so nothing else cleans it up. v3
logs the handshake error and still calls
drm_mode_config_helper_resume(), the same way udl and gm12u320 do it.

v2, "missing reset_resume breaks reset recovery": valid, and not only
in theory. v2 dropped reset_resume because the device was not reset
on resume, but with the current t2linux 7.2.11 kernel (which carries
v2) the Touch Bar is reset on every resume here (MacBookPro16,2, S3):

  usb 5-6: reset high-speed USB device number 7 using t2bce_core
  [drm] Initialized appletbdrm 1.0.0 for 5-6:2.1 on minor 2

Without reset_resume the USB core unbinds and probes the driver
again, tiny-dfr loses its device and the Touch Bar stays dark, which
is the bug the patch is meant to fix. With v1 (reset_resume doing the
probe handshake) on the same kernel the reset still happens, but the
driver is not probed again and the Touch Bar works after resume.

v2, "suspend_state leaked on unbind while suspended": with
reset_resume back, a reset no longer unbinds the driver, which was
the scenario sashiko described. What is left is the device going
away while the system sleeps: then disconnect runs without a resume
and the saved state is not freed. As far as I can see udl and
gm12u320 have the same gap, and drm_mode_config_cleanup() does not
free suspend_state either. v3 leaves it out; I can drop the saved
state in appletbdrm_disconnect() in a follow-up, or it could be fixed
once in the helpers if the DRM maintainers prefer that.

v3 is tested on the t2linux 7.2.11 kernel: 7 suspend/resume cycles,
the Touch Bar was reset on each resume, the driver was not probed
again, tiny-dfr kept running and the Touch Bar worked every time.
(I went through the findings with the help of an AI assistant,
Claude; the logs and tests are from my machine.)

Thanks,
Vasilij
