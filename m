Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E9CC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 12:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C8510FA45;
	Fri, 25 Sep 2026 12:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UWttT2gq";
	dkim-atps=neutral
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com
 [74.125.230.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C32DD10FA48
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 12:52:47 +0000 (UTC)
Received: by mail-qk2-f12.google.com with SMTP id
 af79cd13be357-939109f067fso110864885a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 05:52:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790340767; cv=none;
 d=google.com; s=arc-20260327;
 b=lM1c++o723S8oD2t+1BZF3HQdr4Suln0iGJ5y3PTBdLIaoH+wUEsHUJh1PAsPwaUIu
 g7xBS/ggMYmxG+Ev3O0CHsmukbF94A6MDsJk61XtpiaOa3IZgECNCh4s/7dSY77J6iLe
 0mpv6d3xSAG/euo5Mzd0JvtUQbq8ThJ6qWDtq24qGNinyf2ebgh7qlhwR48Me4jTdIuX
 RAizdQasNFqU2vkaGYbyVeNHMDeb5JfkjFTGP2QzfgiIai0dIXjs4FNyZYf9vFJ2ilxb
 pH9XMpCYd09AeBgteYEZ+lSGdJGWSikhe5epWfzPJ2W1UgtFYAsKNKhJvZa8SUCcdC/f
 qUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9LWDCzcn0ysfmdsUdgkxA//1tZg5vvX+0Vm1HrB/0WM=;
 fh=l+WxGjGoLlp4sUPNrRYZDt2rt0grJf44T/svYUOsdfQ=;
 b=dYxA8GtkLixrvH+RRgFr+ePNDTZ+aB2iZZOZ60k1w+teU0kQrD2PJEMKtftmETGYxW
 HapF9gHPjlj184P3NeNZhBJgWui7Hs1mfY4hAaQhgJzBNSka0yPtZVKziJoK92NvGgwd
 ku92Cj2asdBtkapJVJOjTqk1Rclkgx3VYBrE17jJWKMsfh9ACcIhYdc8dGTOU2mESolO
 LLlqX3zUR2mRoOxJJ5Xo7CFsuFCe26armuItXGs02CQcIBIeLrsHgRHxpDwGCYSJ1h6f
 beIaWRIYjGnCvo85jxDJVjLseB3F/uEcCGwMxDvpUITVn9xTSCjeHwQX3m2Ul0cl5qkn
 f3Pw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790340767; x=1790945567; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9LWDCzcn0ysfmdsUdgkxA//1tZg5vvX+0Vm1HrB/0WM=;
 b=UWttT2gqZVLPbAc3FiQ6UUGZWc71HKtC/B9fYuDd5qL85uSR+/wc9OtTujQ9mTJw0W
 UO7LxC4yuGDfZ7UcyjXLpjhi4WO407347tRmvp8U8YJHROJ82XEugNWIy44v/suliVg3
 isYdQHw3bbfMqgLWvrwNMuPhuv6dmwWOUxfMrguj7ZpSeijQAK/w5BUQxEkoHvTKPhcx
 4zD/CxDAJBPgk1NydMPyLO344UYulyWFzYtET5Ub5pxal42wOLsn+W83zwZL+zqgEudx
 SQqG3A+NNqNNTT33p9INoEh4yc3DklM22rw6iR/P93G2drzEtFJ9N8vXBPZl+QLjF2On
 1mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790340767; x=1790945567;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9LWDCzcn0ysfmdsUdgkxA//1tZg5vvX+0Vm1HrB/0WM=;
 b=lEjliMhKICeIlnHU9eybz+S2XGjFj59rGEJDbaU9FZiZr1UUx/jDiqYP3/1KbYGOwP
 H69wKk8couyb/J3WF4aJ5iSO1ePyk8MSUHpwFGgkQ1XiaQzY0TU0HXJHXfRb4oPvndeR
 6nB5sTI4sdSpSPmkJZ5lYiBSXkgbDsbjeXKPousx/PwfG6Cdz3GXxWrdCU820Hs17JC6
 5OP2yQ0uJ+rb1H8K+xmY07ivPRjsV2uiY0xxsb3K//zUrC5VJmv0XyqOWfN9eFgXLqiA
 3s6I76T+OEXlOj0BXSaYfjQ5PjEGSVFC65GSKSARxh2mCxZ3Us2wcd70vq2xUB0qxh1m
 X3Sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBztgplM/FubB5ypjG8T0gEhd4KtRxfNZ/Hwu821D5xzRoV771/Ej6/LXyt2okh8UJPeLSconyPGNMc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ma0uGjJQb6WWCTdX1sbbH1LCEEYRLAhCySFs2tfHiX3pnVKhwW
 ZcNWWkANJbMmwrZu6Qj4jj9F4YEPDd6YhJzfSows2BUTt6frkoL7QIQWpOdUBAKvwIjPsKNC0Tz
 ek0cAPj4aL16LM0pAzy8jesJMaNS1D4Q=
X-Gm-Gg: AYBFou0ML2Stj7kodO2QQ/q/AbSDehLmd5eS8TKNPj3JsvUEzhN3IXAzJGCp1YcdqCY
 BhCSkZJCnbdpoVFx8ICsx9unv7HyeNcBq92XejfqqGWAHnrTZQ9Ez80nenmPwnrc5x3s/Ba9e+d
 xqB8Iq4kGoPifjS44FijL6OZpBBYx2zHLu+ulj9ZX1ACNZt9xb5q2jZ8v3tAJe/qZ/paNotxlmS
 1qyxrwzQiZt4Du9E8ftFzihyuthkWeplkeOC0z2Z+8w8ntUYFVGOgHpO1zKvteWP4YXa/5VIa4C
 vy/g6kZE6m95KnB1eBGII0tO2mKJMUP0qojs1x2x1vqKA4ZqLQNIbH4hbA==
X-Received: by 2002:a05:620a:8389:b0:93a:3d22:3122 with SMTP id
 af79cd13be357-93c43cc7043mr442767385a.3.1790340766713; Fri, 25 Sep 2026
 05:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <20260908044035.62093-3-mario.limonciello@amd.com>
 <0fb724cc-ac12-4502-b338-1c4f310f043a@suse.de>
 <CAFOAJEdFPrwHZV5y1E_u_Wd6oE_viPsPztxYW6PRZHJ-zdPFMQ@mail.gmail.com>
 <ff86caeb-4388-4660-b3c0-ddc42bc274e3@amd.com>
 <b60d3430-ca99-40b6-aaa0-7b8d481ebda6@suse.de>
In-Reply-To: <b60d3430-ca99-40b6-aaa0-7b8d481ebda6@suse.de>
From: Xaver Hugl <xaver.hugl@gmail.com>
Date: Fri, 25 Sep 2026 14:52:34 +0200
X-Gm-Features: AclHuK_7Zf-6pQcm6muMqKFw6mcOuy1gYopDSlUKmT8vyhgjq4Te-A38Cn1BR-c
Message-ID: <CAFZQkGzUuOh2tGa_otw7yDUd9rSne2PG5Vdte-hwhLZEDf24dA@mail.gmail.com>
Subject: Re: [PATCH v8 02/14] backlight: add kernel-internal backlight API
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, Simona Vetter <simona@ffwll.ch>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, amd-gfx@lists.freedesktop.org, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>, 
 David Herrmann <dh.herrmann@gmail.com>,
 Marta Lofstedt <marta.lofstedt@intel.com>, 
 Mario Limonciello <superm1@kernel.org>
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

Am Di., 22. Sept. 2026 um 14:05 Uhr schrieb Thomas Zimmermann
<tzimmermann@suse.de>:
> > The whole design here is to put the compositor in control.  For
> > example if compositor wants to enforce brightness to be a certain
> > value when certain content is being displayed.
>
> And as I mentioned, it might not be that easy. Sysfs has been the entry
> point to backlight brightness so far AFAIU.
Yes, but this doesn't remove or break the sysfs API for old userspace,
it just allows new userspace to handle things more properly.

> Did you consider treating this similar to display hotplugging?  When the
> user plug a display in or out, the DRM driver sends a message to the
> compositor in user space. [1]  I think it might be possible to do a
> similar thing for changes to brightness.
Notifying the compositor after the fact would not be ok. All the other
display properties are under exclusive control of the process that
holds drm master, backlight being different is one of the problems
fixed by this new API.

- Xaver
