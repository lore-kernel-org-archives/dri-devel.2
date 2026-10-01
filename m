Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF5FCA5FCF
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C3F210E3CF;
	Thu,  1 Oct 2026 16:55:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="RDbD1u1U";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F07BB10E050
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 16:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790873729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ISrpw7olzbmQQV5EJd9ZLesu4XLFhm7z/OC3rYuai2k=;
 b=RDbD1u1UfX6Bi73LrX9CI+zfgG6XhKOljIJZC1+t8hrdeWy2XspQF2xvFR9z08V9jOb7OB
 Wi4Gp/4c4+yrZOCokokTW48hrDkDiqJST9wEahpMthn1Y6CmSXP14W3cEf9N69o2bzoHm3
 NatQzC+SH/VMy4tYIxKAP4xFFXXU5RU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-ihDAxkbMPwCavCW4LsB2Yg-1; Thu, 01 Oct 2026 12:55:27 -0400
X-MC-Unique: ihDAxkbMPwCavCW4LsB2Yg-1
X-Mimecast-MFC-AGG-ID: ihDAxkbMPwCavCW4LsB2Yg_1790873726
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49ff43a1ecbso40109175e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 09:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790873726; x=1791478526;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ISrpw7olzbmQQV5EJd9ZLesu4XLFhm7z/OC3rYuai2k=;
 b=Y6p2ieOvG5l8u6Icgt2rDNp2WKv8mGNWIoFdSqoKFkeadvirJGbAIEsXafHmjOMX03
 Sr5Mj6N4Tl054jJ8VvaqbW6NnfquheIqf8/jQZCMdaKGZ4uI9JuM7NIkJYkzv1WJu13g
 lsheZICvb4Q7s/RHj9L/gpwjiDzIbFD3In+stPI9GuQ0BAU1kBZ8BvjslyZ3xrM9/4lZ
 5t3gqvcmzGTOv25xqGVROp5PaFi3+n9D1Vjteiy9tV9Ejd5y4vn692qsiP3nknJD2VRF
 usYqcb94SYtod7O8NR930PIX7WqBxC6C1AbGUc4VVu8Z2wYMYnyrwhMwdmMGEJR9HCDJ
 narA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzs5JHTrv02ivwF0NdJ0nxuddE88Oh/MtVJYcZhAi3c9KA/dkcfLQeMZGaBX90wnXYUr+PoVAtbUC8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mmt4P1C9DlklU32RwV5Ch+FX8M39IlGjE5ymq4VDLNh4WbbGHH
 j2cudgo7LuFZy+vuhKV2GzF+DJXZpYeNJXMF6EnM+eHhMovgLH/97pzdrEu669P88BDTs8NkeKL
 tbtfzcYCIp8IdXYw9C5GpPRTetoh5ebblBLdyyHUbrFPG7myKcG5sDPcAK+s0UTCJ3YZjwQ==
X-Gm-Gg: AYBFou2xpcarlvoUhp8+7hQoFo6CjE4NioXhlYr9mNfH8sRb7C6vbFFRY48+N0cLz1/
 THwAxBpTkLQs2XevYanjlZg+ZSD19ifZTDNqeqssGxDNUL3Pz5kp/WhKaGhESV7+1y1oB18h+b7
 mtUyiFZXZxcEVjZW1FwHXquiMYamkAguFAtjP5h5eD3VwQ+ZeDOGplGwCjcX70g1aK94tr6G84J
 D3Hlcm4+P+L3M9UmaYDsbvEm8idbYlWkUgvgCETkI7zo7BsBbW3nvp+kTHIfn/TfbEpbqMzD+Bx
 qa6PmCG/Ytnuym3bg8Sn70U+9w1k3zwkU1uYL186UtwFrAEkci+ShbVXfetG+KSyuZ9XstQyJuM
 0ubGjgMeVhplSo72ztqQqW3hmka0EktxOJ4C8S9ebCcsFbTvd03H73rJ8hUWGsHr1Aw==
X-Received: by 2002:a05:600c:3508:b0:49e:6683:d23c with SMTP id
 5b1f17b1804b1-4a02744dcbemr5195755e9.0.1790873726332; 
 Thu, 01 Oct 2026 09:55:26 -0700 (PDT)
X-Received: by 2002:a05:600c:3508:b0:49e:6683:d23c with SMTP id
 5b1f17b1804b1-4a02744dcbemr5195345e9.0.1790873725892; 
 Thu, 01 Oct 2026 09:55:25 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a02752aeb3sm4607165e9.0.2026.10.01.09.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 09:55:25 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Maxime Ripard
 <mripard@kernel.org>, Xaver Hugl <xaver.hugl@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, David Airlie
 <airlied@gmail.com>, amd-gfx@lists.freedesktop.org, "open list:INTEL DRM
 DISPLAY FOR XE AND I915 DRIVERS" <intel-gfx@lists.freedesktop.org>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-xe@lists.freedesktop.org>, Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v8 00/14] Add support for a DRM backlight capability
In-Reply-To: <d0889653-e835-4a22-b385-85cb19ee13a0@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
 <CAFOAJEfgXY7cfLvizuxbS75CJd7mF5tewxp+PH=EhTtpy+aZXg@mail.gmail.com>
 <32f96551-358b-4874-8fd1-a685b02853e1@amd.com> <arJwOSq6-oSywTK6@houat>
 <08e47991-0d72-471f-9955-0b4ebbcffcdf@suse.de> <arJ0huW356NjqpGR@houat>
 <CAFZQkGz9O8dZfmxEC5Fcpa2mRHXde+FFwu4JVz3fvKTzHT49LQ@mail.gmail.com>
 <ar6GxMRwcsTX8IaF@houat> <d0889653-e835-4a22-b385-85cb19ee13a0@amd.com>
Date: Thu, 01 Oct 2026 18:55:24 +0200
Message-ID: <xlv1fqypfjib.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WcsInVWPSpGA0zpmZzqNn8nXFjVTkCZH44kMuAjB0AY_1790873726
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Mario Limonciello <mario.limonciello@amd.com> writes:

Hello Mario,

> On 10/1/26 11:18, Maxime Ripard wrote:
>> On Wed, Sep 23, 2026 at 10:07:16AM +0200, Xaver Hugl wrote:
>>>> Couldn't we make a sysfs write trigger an atomic commit then? That way,
>>>> it would always go through the atomic commit path, no matter whether
>>>> you're on a "legacy" compositor or not.
>>>
>>> That could cause stutter.
>> 
>> Is it really that bad? I mean, it would be only in scenarios where the
>> legacy API is being used and I would expect it to become the standard
>> pretty fast anyway, no?
>> 
>>>> It probably would, but it would create a precedent I'm not really
>>>> familiar with. Hotplug events are kind of separate because it really is
>>>> a hardware event most of the time: you get an interrupt, and report it
>>>> to userspace. And it's largely outside of the properties space (except
>>>> maybe for things like edid).
>>>
>>> If there's any property changes, userspace does need to be notified
>>> about it. Whether the change is caused by hardware or software doesn't
>>> matter.
>> 
>> Yeah, it turns out we already have a precedent for this for HDCP so it's
>> not too bad I guess.
>> 
>>>> If we start having the argument that a property changing must trigger a
>>>> uevent, then it means that we can expect *any* property to do so
>>> For anything modified outside of the compositor's control, yes.
>>>
>>> The client cap avoids needing uevents for the luminance property
>>> though, since backlight control is exclusive to DRM if the compositor
>>> supports it.
>>>
>>>> "the compositor needs to be in control of it" can apply to many, like
>>>> color formats, positions, tiling, etc.
>>>
>>> If there were other APIs that desktops relied on for controlling color
>>> formats and similar, we would indeed also need a client cap for those
>>> things, until definitely all software is ported away from the old API.
>> 
>> I really think this series should be split. We obviously need to address
>> this, but it's kind of decoupled from the UAPI itself, and is only
>> relevant for a small subset of its usage. And yet it's all we talk
>> about. It'll be easier to merge in chunks and decoupling the legacy API
>> handling from the new uapi.
>> 
>> Maxime
>
> How would you feel about a (temporary) Kconfig that lets you pick which 
> API to support?  This would effectively mean that we can get the new 
> UAPI integrated without worrying about implications for the legacy API.
>
> We can then get compositors all lined up to use the the new API and then 
> bikeshed the compat between the two to let us drop the Kconfig.
>

That is indeed a very good idea IMO. Just depends on !BACKLIGHT_CLASS_DEVICE
and ensure that no existing user of the sysfs get affected by this new API.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

