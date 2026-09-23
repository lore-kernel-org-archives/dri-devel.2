Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48172C982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC6C8961D;
	Wed, 23 Sep 2026 08:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RvJuHdxS";
	dkim-atps=neutral
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com
 [74.125.230.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C3E28961D
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:07:30 +0000 (UTC)
Received: by mail-qv2-f12.google.com with SMTP id
 6a1803df08f44-91064d2d54fso393126d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 01:07:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790150849; cv=none;
 d=google.com; s=arc-20260327;
 b=XB55nRPjiFG69ohG41VtIANzRxdSlhMemyFEalJ/9xCXG8LP+4ThAhaP077+o7rSRs
 rYKNaBSLZ6fJAX5GtJuymGCqYuDB/fvCFrTg/CjZcPxYssfiIRKSkd1/WA8zaQnf1eaG
 xOgULfqfXHRpVl0//Dix852kCZTGBVZQ3u2VZuV1KcB85RvUasx5fR3DROK5DThPfJD7
 cG9sIHihvb71fp9S8uSyC1YDt4NKVpKVFelSgLo84Ccg7L/+ZQVG8RlftayBfKXg1mWu
 04FuH0s+j3VA3zKspKSXPt3hrrKpCIR71E4CwWTDh3FCBVWPed2Wt6H612j9b4YlMm6t
 fTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=X6tfoxJ5bpmB6e0WP97I+GLmoZutAadx7RSvw4hqVZ0=;
 fh=KiNDuoeTW/Yr1lmA70LmnjWn6ksNhz0am0tMS5agvDo=;
 b=lWXfIGXOoW0o3vwIee3icFnqpgEMTzes7EBkXl3mHt2ISQM+eKNZ2gowd0ScfLIURi
 hdeD42V5k7qoloA9rbfRv29Evgp1Ugfm2uO7vjahw+EaU+3xNLASP5EsnvUO7+il7m0i
 62eteep7tHXH/agZCnaU9hdzbD100Q4HU54HyJSz8s0Sfx6cp4wjzFcXqBT0tnCER6tc
 qPZzAIs7noJfGJY2Q2P2dB+Am+Gl0D24BApWZO9GDfX8ENUaRqiZ55IBEjrFA+YcD4qn
 SyWXKhLFm4hjr4kR1DlJ/z2sU9ZexNb8k5ZefSBXhuzedxTWfaUK8kgQwT9epf3yG3vI
 vYBw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790150849; x=1790755649; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=X6tfoxJ5bpmB6e0WP97I+GLmoZutAadx7RSvw4hqVZ0=;
 b=RvJuHdxS4DzPLW74CvaE3ZUuO+Mi05YFW5wrE0Di1VXmFX3yKiAIaluwbrDcBqNJLk
 qdfeVaeqLw60CLx5XiI1x/+3Bj/Rjs2FIIet/tNKq4PBs4Z4rX7YBRRMIC7isk/YYfv3
 YsBt1dTi1pMthGIHjpYezy0TYnYzzypg7gNm+ZYMTCPRVXpfUXWDaRX4bDjRtu2SHP1u
 Ea9YL/y6pyMNU4yDovDtDPYfBBUfehja6cfUpfaAIoNRR0PNIq8PvVX00zxC1bkYagtq
 VOOckLOoiU8XuL6n514ZmJoJBKcBj+orG2QSSdd6AjRWMK+7zAtYvGc2J3B7lirxjoyi
 c6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790150849; x=1790755649;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=X6tfoxJ5bpmB6e0WP97I+GLmoZutAadx7RSvw4hqVZ0=;
 b=bSCiEzFKWyY8VXcVDqutJ6B77+xC7ZuhqwHzYfee0cBw3QY37vZYBm5C5rg2sRLB3W
 4S57uXFFQctX0SPbEGik7mVa/oO4GfAlFZcPncsTsF+DdwS+H2ThlZUgaJgcWVTaJmyo
 xL1LGBI3a326iTArJpYR2mQ4r3qeoGWEUyfw6SixF4WOIpumzRKPAxVrT4thUv8wzKMa
 2hBpxrE+pDZSSaOLE6tlIF7bAwDSdFzEuKyRLWKNKlyPWxj5/EP8S4Da4Idp4Wbb3iDT
 qKFTmPDmVhIttbeoHzX6q5QOfG1RQ8Lv8FvCM6QbUQr+994jUTklWuSkryDHIKd0uxA6
 lVUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjzuk/9BJrvKNgYOMQfsVOxCMhBf1PKhewgqVkpEmU+/yK/WSkb6EJA+wqut23L3uRW2dyiNfjKKw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kRLZOg1OlwbFlKvzsf+UPqkCg6fy8dc/VJJsVNJWEXLqylZPal
 5xTEMjUh5bPz6MoY+1ejpf5ldVvxcDxat8UhpoPWBsI4sGX+RVdmD+kzmRskt54aayQwk9fXbPe
 NKSD56kSF6RNdvjpZcsRyPZ/045vZRhM=
X-Gm-Gg: AYBFou0//qh+pDTStdauOI4hQFajLbIuRmNv1+i8zOCoSn7edFOQPTWkzsbdnKIU5GY
 ioCnTLiNraT4deBClGCRCCkX8ZPdu/nMb6ACsCl5yN5zM2B1DNzdKkD9fOwLCsL13O3K3BFb0gp
 UOOEsh8Kz825sIuZ32yGDEK7v9GJLavg9DneBrWRrVV66MKivneGtmKruhFOTvLFp9jy77puYzm
 6eAFghKaTCUCfpgSFy9/nuIyS90D0s6XELrGEgRce91GU3oENiYRfQMNMJk+9Vkt7Ib7tctR9Da
 JepWGU3oj4MaPm7VjZS1D9c1ejd3BbcPqIgVXggakycfqyPkcrFiKDm0YGTn6kOl+jtZv5LrKLq
 tOYcRwRSL+g==
X-Received: by 2002:a05:6214:4886:b0:90e:8be9:c384 with SMTP id
 6a1803df08f44-9140c4244d5mr29354756d6.27.1790150849428; Wed, 23 Sep 2026
 01:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <CAFOAJEfgXY7cfLvizuxbS75CJd7mF5tewxp+PH=EhTtpy+aZXg@mail.gmail.com>
 <32f96551-358b-4874-8fd1-a685b02853e1@amd.com> <arJwOSq6-oSywTK6@houat>
 <08e47991-0d72-471f-9955-0b4ebbcffcdf@suse.de> <arJ0huW356NjqpGR@houat>
In-Reply-To: <arJ0huW356NjqpGR@houat>
From: Xaver Hugl <xaver.hugl@gmail.com>
Date: Wed, 23 Sep 2026 10:07:16 +0200
X-Gm-Features: AclHuK8xgDnVa7N6ARRpfcYEwFozCo04IqFUVuiW8m2XtM8bq-AsJWi-i2VQJfk
Message-ID: <CAFZQkGz9O8dZfmxEC5Fcpa2mRHXde+FFwu4JVz3fvKTzHT49LQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
To: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Mario Limonciello <mario.limonciello@amd.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, Simona Vetter <simona@ffwll.ch>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, amd-gfx@lists.freedesktop.org, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, 
 "open list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>
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

> Couldn't we make a sysfs write trigger an atomic commit then? That way,
it would always go through the atomic commit path, no matter whether
you're on a "legacy" compositor or not.
That could cause stutter.

> It probably would, but it would create a precedent I'm not really
> familiar with. Hotplug events are kind of separate because it really is
> a hardware event most of the time: you get an interrupt, and report it
> to userspace. And it's largely outside of the properties space (except
> maybe for things like edid).
If there's any property changes, userspace does need to be notified
about it. Whether the change is caused by hardware or software doesn't
matter.

> If we start having the argument that a property changing must trigger a
> uevent, then it means that we can expect *any* property to do so
For anything modified outside of the compositor's control, yes.
The client cap avoids needing uevents for the luminance property
though, since backlight control is exclusive to DRM if the compositor
supports it.

> "the compositor needs to be in control of it" can apply to many, like
> color formats, positions, tiling, etc.
If there were other APIs that desktops relied on for controlling color
formats and similar, we would indeed also need a client cap for those
things, until definitely all software is ported away from the old API.

- Xaver
