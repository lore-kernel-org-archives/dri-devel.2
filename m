Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A32FC61DBE
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 01:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E8510E2F5;
	Thu, 27 Aug 2026 01:01:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="V+/BOV3h";
	dkim-atps=neutral
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com
 [209.85.221.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA4810E2F5
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 01:01:54 +0000 (UTC)
Received: by mail-vk1-f227.google.com with SMTP id
 71dfb90a1353d-5bfa99f8ef8so381201e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 18:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787792513; x=1788397313;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BwPkuobYyNCNil8BllTiiGkpmt86fYAObN3poOOAYCQ=;
 b=UJN1Gue7EZshrjxdxeh8fI60A62b487cLTxXYPW1D2u4e6/70l6qpTxONctHpqMgc7
 Zz85l2QHV8eD8pAMyjzrOT7UeeAvlc+wEI/jLIH8qMl7odXy/FTk8MeMEybMIj3Xju3T
 oRZZCGSAToM4+OLnsovqdDsl8441D/mxPGB9jHA/pIarBUuVW0VJl+TFDXlYi5Zr3V35
 V3Rbr6d3BxaBf2P9GZ7HuZxOyBbKCiRNqEW4AYXiAjSQQdjE8TfFwahWDgnh0KqpO6/m
 SKx8zBjSB79PBijsD55U1eqEqaGcV/vFGK/pcQNQmLUt6/1prWb52pzkzF//1EPNCEWu
 8KRw==
X-Gm-Message-State: AFuF++nQvAYjaEQKLnYg6JXV9jk3B9MLOFCzDdId7nBouYdAXEDE4XpN
 tUMFhKExu3LdVbsYUjmrXDnz6eV5ocgOsApb9tVZIsAg9E/0sDEBkZjzNwmelxx0zJovZeK8hoS
 /bqi6am5wFj1AyMkzY4o6bcybVz4ZIN22mAlIYBjwKjZ77+Nj9Rq7UIjvvszOR852yO/fpZskUi
 iiSH6s7ib/r74eHIeKvjezXCtpAdrOLnXmlY0cNj0++Z/ijkn1QDMAWuu9P3g5PDzylfSKiYcgV
 uN7YeyOUYmyurqNx3tv9x8IT3GV
X-Gm-Gg: AR+sD13x98FcgN6150epJYq+ihFDQJmUYAOKfMHYWUcnAtOaXYf11WThIGJJakW/FEL
 5OHbu8MBfQ7CcMVzyncIUnfQr1qydppiIvXKUADPToO/Paz2l2RD7V3Zfars6/aGWPraHccZVux
 x38p9Ay0bh4kIFX8t73OtI2YDV8LHXB3IadhtJ4ufGFrW0ivCFuTo/C/rxEnNT5W+xUesXq3MEP
 5gD/2yH6LTA00g5gwPq9qsQ9Qlif8UM7B4QDdwkI6ljXSTBWD4jk3+gz+++1y0t3I+c94VjetzU
 RxlRC4FxIPpfIPhnu+KoL2ISVzGMrGk+oBlPIC3FluYfm/yX8J2z6zmDnkRXTMgPNT3pdBWCYne
 +pkROXLE9olXmTLm+R73VQdmBn2qx9zIWTW6EklaxfBoHvdUqbFfyUdj6+5kJziY3PTsV5eZ/lz
 pCiRW++fzOkbtfYABK5Ei1DT/A/bylmwddocS0pxB1
X-Received: by 2002:a05:6122:4b19:b0:5bd:8dd8:146e with SMTP id
 71dfb90a1353d-5c66e7df7d2mr882957e0c.4.1787792512651; 
 Wed, 26 Aug 2026 18:01:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-5c65ff5ac2esm1087562e0c.3.2026.08.26.18.01.52
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Aug 2026 18:01:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90cc9140539so5365586d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 18:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1787792512; x=1788397312;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BwPkuobYyNCNil8BllTiiGkpmt86fYAObN3poOOAYCQ=;
 b=V+/BOV3hpi55s6JlqI2k0fzROfTMQj8JLkVZSh3SVadGEdMpIvOEb73dXlZcAbH65w
 h2qMpt+Ou0gVrSHq73TZBVsaJFdbK/5CX40qE8ULmhwO2Mojkx7kAxtnlA/51hO9Qfqg
 FGExJ+cVPbcyR2zSCVOxfVFh3r66vY2xlHSHU=
X-Received: by 2002:a05:6214:508f:b0:8e9:cd74:87bb with SMTP id
 6a1803df08f44-90cd44bb184mr42733886d6.18.1787792511528; 
 Wed, 26 Aug 2026 18:01:51 -0700 (PDT)
X-Received: by 2002:a05:6214:508f:b0:8e9:cd74:87bb with SMTP id
 6a1803df08f44-90cd44bb184mr42733176d6.18.1787792511015; 
 Wed, 26 Aug 2026 18:01:51 -0700 (PDT)
Received: from [10.211.247.235] ([192.19.50.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cd73e387asm3906536d6.28.2026.08.26.18.01.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 18:01:50 -0700 (PDT)
Message-ID: <194908f7-fde4-4136-b535-86f21c27d967@broadcom.com>
Date: Wed, 26 Aug 2026 18:01:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/vmwgfx: graphics memory not returned,after all GEM objects
 are released
To: Jellis Onsea | AccessWeb <jellis@accessweb.be>, zack.rusin@broadcom.com
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com
References: <66c0b5db-bea1-4608-be8f-bae437760d97@accessweb.be>
 <9ad23800-db89-48f2-a960-6c2fa11ee6d5@broadcom.com>
 <363bcf88-1f13-46c0-9dbc-aa21102ab397@accessweb.be>
 <55b08fb3-cc29-4c2a-bbe5-26742de77614@broadcom.com>
 <b0b0caf9-ca76-4f93-9495-d386d313fad1@accessweb.be>
 <7af1cbb9-bb99-462c-a3e4-c70d8fbd2dcb@broadcom.com>
 <5d110271-9a0d-4ba7-92e9-286ba557c16e@accessweb.be>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <5d110271-9a0d-4ba7-92e9-286ba557c16e@accessweb.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

On 8/26/26 7:17 AM, Jellis Onsea | AccessWeb wrote:
> Hi Maaz,
> 
> Short version: mesa 26.2.1 is running here with 3D on, and the leak is still there.
> 
> Setup: one boot, 119 h, a single kwin_wayland (6.7.4), mesa 3:26.2.1-1, kernel 7.2.0, renderer SVGA3D.
> 
>   TTM sys+mob    0.36 -> 16.73 GB
>   objects        1948 -> 10365
>   kwin_wayland   holds 8484 MB in 4894 objects
>   free RAM       4.9 of 31 GB - we have to reboot today
> 
> It tracks rendering, not uptime. Idle nights (02:00-07:00) in this same boot:
> 
>   22 Aug  -0.03 GB       25 Aug  +0.00 GB
>   23 Aug  +0.02 GB       26 Aug  +0.04 GB
>   24 Aug  +1.88 GB   <- the one night an automated GUI test run was active
> 
> The surface warning still fires: 1168 WARNING blocks at vmw_surface_handle_reference in the last 27 hours. That is a window, not a total - journald has already rotated away the earlier part of this boot.
> 
> Correction to my previous mail: "four times during session startup" was wrong. It fires in bursts throughout the session.
> 
> We have not tried "drm/vmwgfx: Return gem fd handle for scanout buffers" we run distribution kernels here. Say the word and we will build it.
Yes please, can you go ahead and try that patch, it fixes some errors on kde and might fix this issue you are facing too.

> Best regards,
> Jellis
> 
> Op 21-08-2026 om 04:09 schreef Maaz Mombasawala:
>> For the 3D-enabled case, could you try with mesa 26.1.8 or 26.2.1, both of which contain my fix.
>> Also if you could try the patch I just submitted on dri-devel - drm/vmwgfx: Return gem fd handle for scanout buffers.
>> If you still see issues with these patches, let me know.
>>
>> As for the 3D disabled case, I can see issues on my local machine and am working on a fix.
>>
>> PS - Your emails are overly verbose and narrative, could you include only the actual problems you are facing.
>> If you're using an llm to write these, please make them more terse and human readable. Thanks.
>>
> 
> 
> 


-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
