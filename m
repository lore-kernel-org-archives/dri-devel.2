Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48F5CD3430
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 09:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A28A10EA10;
	Tue,  5 May 2026 09:28:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="C8EcI7gb";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF6AD10EA10
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 09:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777973279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+2vLygnSuUxUZp8qdKozIdga2LwEG2v114+MzBN2x8s=;
 b=C8EcI7gbvpGg355chz4Z9RzTAO5P5BhKnEby5N7rt3FOTqxl/Aefshp/Eftmdos2CTDlmU
 9Zz4bvrnqqeIdMqFvfyzhG4QyhhH0TsS38Ituk20fmuKuQbQAwUfm4uqMfQG1l3/KDVYCY
 ISpSvQGxh4oh655H32DMTdfHzp60uYA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-jJ-_45drPZyRLtwI-160Aw-1; Tue, 05 May 2026 05:27:56 -0400
X-MC-Unique: jJ-_45drPZyRLtwI-160Aw-1
X-Mimecast-MFC-AGG-ID: jJ-_45drPZyRLtwI-160Aw_1777973275
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488d3eec9bcso30369465e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 02:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777973275; x=1778578075;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+2vLygnSuUxUZp8qdKozIdga2LwEG2v114+MzBN2x8s=;
 b=eB3UrAJtEucI1LE9peJvzzoL5w3Cv8x/tAT4XfEEh++MiYKmoJ4T7Z5CFUm67vcON9
 RSmCLExuGerxrucSZDALf/HN7M/O00c9ylItsRx65xdKG9WvAXHrwSugO43oIQ6nvnzR
 U3Ie3DLSt9JT8mOVq4WeO9Ilw7M9wOQa+Af6vkgvDDN1Lc6xmGYU/Af0ggtzzPKvLdKf
 GKgSQALZalPg822CFRgZnqgGdjkXZWT5/tzGCmGqTZk2LUjGMJzaC1T4LpK5beE3TZTy
 XzG5Bs2g/CSglZS04vcGxh0G4Gw2ceky6PSOeObN/LEunHehRe54RjG+Po/xfdbSGThH
 kPcg==
X-Gm-Message-State: AOJu0Yx0dEwTvxfVZrSYs7vMEc/T2YbWPH9DgAd955me/lSNjjLyWr1K
 pOrNlM8ETdfMr9wju0Y7jZUsbRskUTAbW/zfZCM9rklEMAdHbsmyV9vgQQf3q8CfaAOUlId7cL/
 9e5/y7ZTTCnous6OGzXjSw7aNIsO1EYiXI1XENkoNIIng3YgFUorJ1OKHnLhlZXlbyzPb8g==
X-Gm-Gg: AeBDietnFSN/Y+OkC4YlvYD40ojp8vVU/EIA6XpwCmThAZg/xPk6eGQ6XRQe6nvSxv3
 z4dCrKyosYPPDSB2U8pLrbGegYAZpYe6Y/frFFgIUuohdKB5qKFGIJtS3MPGkyZhTRzyo6EXUcv
 Tf00lD7kO8c/8GaUbktVqXmcb0U58p54QnxhUQBd6RItLsA0xmQ7KqwqIYMBzeRt2cAkeR+0yKp
 sg1oiKEGv97SnKLRPl+lnJqMFeS+fIDK0oY8JsTocSsXk//Nbca9S0mqKQhJJ9p90NisMAGEHEG
 aj7d7XuUy0y1ERnOUcNgjRzZuDbI+aYKF68V1SghhXZ35COVEfFDh+uRjFaGzBw0wjDHPjpGOrQ
 c2lwf4qDOau9rdNcGMIDUy7Mvd/LCgStcKeu7RcmQXEBJwtG51w3TApPh/c7HeyGigk5rfnjoV6
 bJZp8Kka85AWArGoY=
X-Received: by 2002:a05:600c:828a:b0:489:5022:39a4 with SMTP id
 5b1f17b1804b1-48a98638119mr216071955e9.9.1777973275332; 
 Tue, 05 May 2026 02:27:55 -0700 (PDT)
X-Received: by 2002:a05:600c:828a:b0:489:5022:39a4 with SMTP id
 5b1f17b1804b1-48a98638119mr216071515e9.9.1777973274896; 
 Tue, 05 May 2026 02:27:54 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81b99127sm378772205e9.0.2026.05.05.02.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 02:27:54 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/5] drm/sysfb: Support basic power management
In-Reply-To: <e5414c41-85d6-47b4-8372-a51f55bab0e6@suse.de>
References: <20260408120722.328769-1-tzimmermann@suse.de>
 <87340gq2ey.fsf@ocarina.mail-host-address-is-not-set>
 <e5414c41-85d6-47b4-8372-a51f55bab0e6@suse.de>
Date: Tue, 05 May 2026 11:27:52 +0200
Message-ID: <87fr46kxyf.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8_AOUmjLvkQ1gKWaTk-3-2brNle74L2fFdOppOnmkF4_1777973275
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
> Am 27.04.26 um 09:37 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>>
>> Hello Thomas,
>>
>>> Add callbacks for suspending and resuming to the sysfb drivers. The
>>> helpers store and restore DRM state across the suspend/resume cycle.
>>>
>>> While most hardware loses the system framebuffer setup on suspends,
>>> some systems do retain the configuration; notable emulators. Adding
>>> PM support makes it work with DRM.
>>>
>> Interesting addition, I wouldn't had thought that the state would be
>> retained during a suspend/resume cycle. But I guess that makes sense
>> for emulated devices.
>
> I only discovered this recently.
>
>>
>>> Tested with vesadrm on qemu's bochs device.
>>>
>> You tested with vesadrm, do you know if would work for the other drivers
>> too ? I guess that there is value in adding these to all these even if it
>> might not work outside of emulators.
>
> Agreed. The drivers currently do nothing on suspend/resume, but pretend 
> that hardware is still running afterwards. Since we haven't heard about 
> problems with this, we can also try to suspend/resume DRM state 
> correctly as it won't make things worse.
>
> However, I only know that it works with vesadrm.
>

Got it. Are you planning to merge this series then ?

> Best regards
> Thomas
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

