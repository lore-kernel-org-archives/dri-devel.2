Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E30DC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C98C10E365;
	Tue, 14 Jul 2026 07:23:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Uq/VITh/";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B5CF10EC0A
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 07:23:58 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-69c5fda04a8so5866973a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 00:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784013837; cv=none;
 d=google.com; s=arc-20260327;
 b=nkHAs19k8G5J1XKfIGD7DhxZyeSiUrzUnPceIVDkz5f+TpY/lG6ssZzdz35gDgmA9o
 RBqZjIphP+ZUD5hkwrcDuaDnhKMhiTAVYAmXG21IuAB+marZ8Z2Q6NNsfIqodeS45mDt
 4MYtOP47W5OYZ20bvSY4SbbqaS9tfZhDaT+LsE7PwzOPukWpBZgqZSx1LyXj5qUI9YgC
 02YeGhkJpTn38Tfk5p4VWRAAit81TOM8dSNk8A8U+3KnQNsDpoc2zK9Oi6t527JSfJrq
 aQ+B9W22x+JxnRvmYUXdRuwWoW2Q0dFG18GYR2VrZipQ/2qkhpfkm10G6j7TTlPLO5W0
 ixww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4otLa0osIIgCWg6PJhWGRKAbFh1CF4DbrLX8uzqDyWU=;
 fh=jS8viB+7gmYHL9Vx26Vm4iNVwFx22X9OzaGqIXIfxAY=;
 b=qSBplCDFU0mVgv9gs3NLHDoNG0E4DAyPAYyWiGlnFh89S7/cC5TcsUNpJ6V9Kx+71F
 FbOBsVc9k0GZmk55lWszgDUkatfjVZhyHvfkhI88YGmeRox2MF/30kfS3ZIhCgDoh2Oy
 EURAh8ouCKQlRV5tiV2K1Ry8Eu6JRCKuwhAVJaceuM4NIPKVOxu3y//0iIlsuD4Ck/MI
 K8r1sRJkuje8bStvJVnl+103zGoMRBmaWIj2L3gs0CjMXQR2VZAGZLIh7s5bOvhPSQUi
 s3Eir8sRoLbhP1f1tFNxilB9YvlXvNIKeawqoyG8EvGUTalS1+KVB2mb3NvM9HEbN316
 /U+g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784013837; x=1784618637; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4otLa0osIIgCWg6PJhWGRKAbFh1CF4DbrLX8uzqDyWU=;
 b=Uq/VITh/q/+VpId1HdYfKW9ktugJgJ71BeBgVVrLnhR6ewU6acWmflZrzWR1yXYG4J
 XBmPfZN+drXf4wjwKNSvqy5ykq4nLEH7CC67duIehucAokiW3Z+Gb7gGytxC0Hzw6bJX
 VigSrwWMmV+2+NvILB7swA7BdpKUUZN1hqqvS5tyQ5f702yoev8IFDqUyYkCQpYL44ZN
 hKn2S0aOgmHpE7R4llaShqeFH1BKy6qUg4rnHh2dLgD+WFwwfgSvljGuabiSV9ZTSbMO
 ogj73jrGFIvBY1KUUnIONZK676YEoZpCmPOc/ud7IKJ+GS3TJmclxEY1iLp9D4RqLp/h
 dTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784013837; x=1784618637;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4otLa0osIIgCWg6PJhWGRKAbFh1CF4DbrLX8uzqDyWU=;
 b=Y3LrVJ7Qyp1fsyVIz5bVW+9CBbcQk0gk3uWbNyVD5Ek+j43yYwzyqaK83thghA8fy4
 WDNeJTF7owDgJ8YWzmS4QNf+MGN6TCW2SZGjbc+EpD+5ZAVdVMAfwPQDFGQVNUIHhzH/
 stB2Hs2Vx3bWKNhnEoEWcHjkO1irlRaZMH3tUcDhmy+xsniFPiKrl2BpWsJywkFUMg2z
 b+7Z4QSnYe0UEFTGe0tETfKvfSlDIixY+Afmz2u8SMrHhPy5CwvysuK28c3UiqRFgTrc
 vwwvJ9N91SL1crjL7dPytiikI8KhjwT5+vR29JmG+lEVTX4+ISY8IT3dCsCgGqR1hd70
 AIVA==
X-Forwarded-Encrypted: i=1;
 AHgh+RokbvSAVyGyQ8fEz2yClgGQZtkJNjKy6RxQZmL+GUWJmP8IE3EuqFdji7vpkGhsS4QX7veM38vcEzE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRuoNPHwjvlUex5AkBQQ5PHrr7hMigTnNqUKj57SI8sVZGpxOW
 NV8/gSCSRR47TN0h8Zmb+0tUGVhZj1w2NklxFbFN6Hm38EHk7hc0RKmAMozSzJuRrJgAQF0DCKW
 dHUKIrTVsFPIAjy96um2xDyZPHmNGdGU=
X-Gm-Gg: AfdE7clhGfDpRrQF3RkmukpyNq4W4QX7ZD3T5z9mVWeB9blupDJYeQwk65tJY+reBz5
 d48uZcU/EfBQfjtxeUB1keFnxkXTEXfSKcstqQtCrZmzfD4+menCEqVE1KXG/k7JDN6qwlivRFp
 teW0MzMxNkpLG+IN2L1OIOX9DctYHi+8eGXwEDKmnJwku1ym8oVuB0yNs/2LOrQ7FWaqgQ0a/yo
 WWZoYb+Te7IN8CWBbFyxz1kuFUDtPUpV3hTwOh5mm4/qxTcFd6CHpmj5ZLZACR3Z0M9vxWD55Wd
 EiJLwQ==
X-Received: by 2002:a05:6402:e94:b0:698:c13e:179a with SMTP id
 4fb4d7f45d1cf-69cd2a001acmr1004913a12.10.1784013836409; Tue, 14 Jul 2026
 00:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260713120840.17427-1-linux.amoon@gmail.com>
In-Reply-To: <20260713120840.17427-1-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 14 Jul 2026 12:53:43 +0530
X-Gm-Features: AUfX_mzvXnkQt9N3uwj4z53r62LfKGSebrr5Wzfs3imVuOH5yaZKNS9xAf_UWqU
Message-ID: <CANAwSgSz+e483m9VKkFZzSKzB1Tsd8kS20UcB3ON-cZ=J8gX+w@mail.gmail.com>
Subject: Re: [PATCH v7 00/19] media: meson: vdec: Fix lifecycles, race
 conditions, and stability bugs
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "open list:DRM DRIVERS FOR AMLOGIC SOCS" <dri-devel@lists.freedesktop.org>, 
 "open list:DRM DRIVERS FOR AMLOGIC SOCS" <linux-amlogic@lists.infradead.org>, 
 "moderated list:ARM/Amlogic Meson SoC support"
 <linux-arm-kernel@lists.infradead.org>, 
 open list <linux-kernel@vger.kernel.org>, 
 "open list:MESON VIDEO DECODER DRIVER FOR AMLOGIC SOCS"
 <linux-media@vger.kernel.org>, 
 "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Cc: Doruk Tan Ozturk <doruk@0sec.ai>
Content-Type: text/plain; charset="UTF-8"
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

Hi All,

On Mon, 13 Jul 2026 at 17:38, Anand Moon <linux.amoon@gmail.com> wrote:
>
> This patch series addresses a collection of critical race conditions,
> memory leaks, use-after-free bugs, and resource management issues
> within the Amlogic Meson video decoder (meson-vdec) driver and
> associated components.
>
> The primary focus is tightening session lifecycles, safely synchronising
> the V4L2 m2m framework callbacks, hardening work queue operations
> (esparser_queue_work), and correcting buffer validations to prevent
> stability issues like KASAN out-of-bounds errors or stream-on timeouts.
>
> Summary of Changes:
> * Race Conditions & Synchronisation: Fixes multi-threading and
>   execution races across stream-on, stream-off, job abort, and
>   teardown pathways.
> * Memory Lifecycle: Eliminates memory leaks and use-after-free
>   vulnerabilities by safely pinning, canceling, and sequencing
>   device removals.
> * VP9 & Buffer Hardening: Addresses payload handling bugs in the ES
>   parser, properly tracks ongoing buffers via atomic counters, and
>   prevents invalid memory writes.
> * Platform/DMA Adjustments: Adjusts DMA segment configurations,
>   canvas handling, and buffer sizes to match modern hardware demands.
>
> Note on an outstanding issue:
> An execution deadlock occurs in the driver workqueue path during high
> stress or long playback sessions. This stall is triggered when the
> Amlogic hardware internal video FIFO buffer becomes completely full.
> When esparser_queue_all_src runs, the capacity validation check is
> tripped due to a design limitation in how buffer exhaustion is handled.
> This blocks progress and leaves the workqueue worker waiting indefinitely
> on a core mutex lock.
>
> The resulting hung task call trace shows the worker thread blocking
> on the internal lock:
>
> Workqueue: events esparser_queue_all_src [meson_vdec]
> ...
> __mutex_lock
> mutex_lock_nested
> esparser_queue_all_src
>
> I have tried to address this issue, but the underlying deadlock persists
> under extreme conditions.
>
> Any feedback on this new appock is welcome.
>
> Testing was done using v4l2-compliance and active decoding pipelines
> on Meson platforms (like Hardkernel ODROID-N2+ and ODROID-C4) SBCs.
>
> The v4l2-compliance tests passed successfully via:
> $ v4l2-compliance -s -v -d /dev/video0
>
> Pipelines were validated using the following GStreamer script.
>
> [1] https://gist.github.com/moonlinux/08295ba1f17ce7155550773f2d2cb6e5
>
> Previous changes:
> v6: https://lore.kernel.org/all/20260530094326.11892-2-linux.amoon@gmail.com/
>

I will review Sashiko's feedback. I will look into these suggestions and
work on incorporating them to improve the code quality

> Thanks
> -Annad
>
Thanks
-Anand
