Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B80CD98D5
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 430BC10EE78;
	Thu, 11 Jun 2026 10:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="JQZ5RQXx";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8033310EE76
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 10:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781175589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OE5i5Cs1x/Y1/tYzMUIth7XXWL2BCwQTkDQ8GlOHrbw=;
 b=JQZ5RQXxJXFjeIuUWy3FD0d3RyH99GGuJxKPjQAaFwJD1Aja9HGPCt9KzxRhnrCcj8d+3L
 tTbBwgehNPH/95FDLdfXJjMORDGZWhliIp0kcBX5peB4xfu9nefxSe5apBja17v9Gmn6xS
 X84JZdtj0zl1KaUEgxXupyezT+NqtR8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-lgCak7OANtqAhIXjP3FNpw-1; Thu, 11 Jun 2026 06:59:48 -0400
X-MC-Unique: lgCak7OANtqAhIXjP3FNpw-1
X-Mimecast-MFC-AGG-ID: lgCak7OANtqAhIXjP3FNpw_1781175587
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4601daf4c65so4750724f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 03:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781175587; x=1781780387;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OE5i5Cs1x/Y1/tYzMUIth7XXWL2BCwQTkDQ8GlOHrbw=;
 b=PMm+CP3tRqZoCC9qvxTo3UyIbdJekdQ1Utz5/El3tYfxhjE6iADjnBIiQNT6V/Cq3O
 kSa4cCapm8iQrWMd3pd7ZWyiqW8hDDj46wCr7+fhbOhbCSx93Q95x7y15F7462L7d60b
 JGN/ffEpK+poEw4eLpV/hMCYO8FgILiFSCOVW5RqfZiyH5q5w/t6VheVa8u/Mr6PJBuI
 ms5JPSUtgRi8TWkHFnOoC+6Lrt6roT8s40L0Rtrwjmyv9Aot5a8ySr0T4dfHBN4mbE9S
 zpw1A4zoseGOGv42RwAVf8m/vI2fkIyPToOVtaWW3Bpw9pT2xUyeipXNK+q1g81qs9g8
 AbMQ==
X-Gm-Message-State: AOJu0YwfDsmmY/UfWjt8Th91KeTi9d9RcmVX+JIWoCLOB4a1oFFgPens
 zghRDBYccV82azSGbObU+tU+hSl8DU5nwfeIoOBqp4eekouezq5Gx2BN6cE+sowuJkR8q4WUOzf
 QD32SbuJ5lZsCbKmIVAxJplVmeVm6f8RdUTT0gvhDUCNOM9InX5VDLMNgAJZPTwkAEs7Fag==
X-Gm-Gg: Acq92OEfhIoi2lWOBwp3Aj+woqGsa6SgF2A4vvwgsbXirKe78Ei3Gt7xdMddBcmwPxh
 k23lfaNJNdCNqwwFONbXSc7/9iiIxacAJ9m4lP69ne73NHsrhgb9yKIvVr4My6DRCMe5fmco+na
 pvokiic17gFs/xOGA3tOOYo7jS3n6nLdYSo0EPEB0/6GLIrRpSvvzAZ/DBa281p+CEVc7g1YpL6
 oyRYxa0vMojR7aXaZnewAN8sJkbL6lhoeYpAPQHpgpybdDxQTw3XHJSSfzCU1M2CkHta7FYWJpm
 dYRi2da6PX1QDvmHLDAFyDAUxer7lL+aWCSLFoVRWk6JaH7XBgkhB94tFu4S4kXk0JLah59c+mV
 Ds6XrR6OSLQ59n6eNtuwPN3znPg1NEkQFtwTseYP8Bc1Prj+nNCkM3xBDO6zFjA20X4TSPLTw4v
 eup8ginvP2+woAP+o=
X-Received: by 2002:a05:6000:710:b0:460:1c5b:f25f with SMTP id
 ffacd0b85a97d-460677b1af7mr3240544f8f.20.1781175587128; 
 Thu, 11 Jun 2026 03:59:47 -0700 (PDT)
X-Received: by 2002:a05:6000:710:b0:460:1c5b:f25f with SMTP id
 ffacd0b85a97d-460677b1af7mr3240484f8f.20.1781175586716; 
 Thu, 11 Jun 2026 03:59:46 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcde3sm81947989f8f.1.2026.06.11.03.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:59:46 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklkml@zohomail.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 dmitry.osipenko@collabora.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v5 01/15] drm/amd/display: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <45aec54a-ec80-48ed-9bcc-84e7bccc11eb@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-2-tzimmermann@suse.de>
 <87y0gl5qw8.fsf@ocarina.mail-host-address-is-not-set>
 <45aec54a-ec80-48ed-9bcc-84e7bccc11eb@suse.de>
Date: Thu, 11 Jun 2026 12:59:44 +0200
Message-ID: <87mrx15om7.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s1kT7LRrDLGwXPugV4NO0Bv1O_EYLf5nY6KzmnDVbyM_1781175587
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi Javier
>
> Am 11.06.26 um 12:10 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>>
>> Hello Thomas,
>>
>>> The mode-setting pipeline can disabled damage clippings for a commit
>>> by setting ignore_damage_clips in struct drm_plane_state. The commit
>>> will then do a full display update.
>>>
>>> Test the flag in DCN code and do a full update in DCN code if it has
>>> been set.
>>>
>>> Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
>>> to ignore damage clips") introduced ignore_damage_clips to selectively
>>> ignore damage clipping in certain framebuffer changes. This driver does
>>> not do that, but DRM's damage iterator will soon rely on the flag.
>>> Therefore supporting it here as well make sense for consistency.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")
>> I don't think that a Fixes tag is correct here? Your patch series
>> is changing the 'struct drm_plane_state.ignore_damage_clips' and
>> the changes make sense, but definitely isn't a fix in my opinion.
>
> But shouldn't we have added this test in amdgpu and the other drivers as 
> part of commit 35ed38d58257 ? Sure, these drivers don't use
> ignore_damage_clips, but it's still an inconsistency wrt damage

I don't think so, since the original scope of ignore_damage_clips was for DRM
driver of virtual devices (namely virtio-gpu and vmwgfx). These do per-buffer
uploads instead of per-plane uploads, and so there was a need to force a full
plane update if the framebuffer attached to the plane was changed.

Your series are now extending the scope of ignore_damage_clips to be used by
core helpers and force a full plane update when doing a modeset. This makes
sense to me but it wasn't the original intention of the propery and that is
why I don't think that should be considered a fix.

The only patch that IMO is really a fix for commit 35ed38d58257 is patch #6.
Because is true that the plane state ignore_damage_clips was carried over
when the state was duplicated.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

