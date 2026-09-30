Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33051CA5FBE
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 658CE10F215;
	Wed, 30 Sep 2026 07:48:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="FR0/fiO6";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE87310F215
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790754532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pviGC6S/LMOC86vdrAq/0RuOAXfRrJoOrx8zjTUH7O8=;
 b=FR0/fiO6APx2zhKJkoJOFDNizBJeuEhoxDI7NlXRIDJyp7xVT9DJR5UI921xnvuXaVN4OU
 WKSUeSvUnW9V8+9Qc3hxvT/72oKzBgNQE4eBLl2PYlxIwDCYxDprxoiAARHE2tzYB09H80
 DE+vBqyu4AlwNjucWirt/Ci+110L0CE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-sPTCdYk-Npi_Dn1MFSSFPw-1; Wed, 30 Sep 2026 03:48:51 -0400
X-MC-Unique: sPTCdYk-Npi_Dn1MFSSFPw-1
X-Mimecast-MFC-AGG-ID: sPTCdYk-Npi_Dn1MFSSFPw_1790754530
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a0023f2b97so16048445e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 00:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790754530; x=1791359330;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QqPP3IOK4pr0d4Fr/4esg8OYlXTOWf1fN8IGm4ALWs8=;
 b=muHr2/Jr/U33xK2xgmwlvzn0lfIie//KlfR2rPzIpYHBrIH13xnBvTQA7jre2qB2Vl
 0SOJEbW5R4kW4nGLYYyp+Fk+ghMHBqdDHhmBbL4MCDEsEDKYq5+PVzCmdJI7Enf4QfTP
 mS3DhgoYOkdjSvmvV6ICyC5sgNZAZ2m/rnTeHGnNFcBjEiWefdWmAColAtPdsDfBhphA
 gr1kCc3X+4fnE8QaAVng9EdS48hFfiXNXmaMCJjW/nCsGv7LWahUj1Bx4UtONtF0vz5S
 LRAM+p473LWu7V9hDmzTJd1b2bjrHuP5n/vj0iIzBR/AylyBpAwgknOjE7Yd++rQT/33
 nY4A==
X-Gm-Message-State: AFuF++nCxZb/KdZuTuqEWwFkuNqJ8I0TEVkQwsr24hO/y6/gbd2KZcUC
 tuGUA4ZizZoVMqS27KDhAGmoWEoxXry3S/t6nByDXjGleYd+BP3LfknNwWPq11uvV3mDDjXzAKl
 xGLEq6pvUrLa0eaNmul6V+/r9FMG5qc6tJtpYHi3nEQHW05ZUd2bxcTgFkcvV18qV7yHGTA==
X-Gm-Gg: AYBFou0yhR3MuEv3aNv7820pZqlxsvxwYqgUjlXPPJOJVBG+DhWafmSEN4NU9DVorLi
 lOBh1QSK7e7bTJ0WoYjUFfGusD+CyIDCaYDz9NcLXRjgAy3XeuS+NWwgtm+s1qo9vHiBbsqfjQU
 uUACk3OlOItDhWC+tksdEFChH2iFdqegPfrPkmZqhF/W9iJgsUTbUaRFprGPk21GLGuD901Zfr9
 zB2HvUnjTnzJEBYu1y5Xw8wbo5MF5oAy8qe8fPVU8uZcEYR4G5OqXis/yLnB22ankqASm7VWnZ4
 +HhwPrhYRfQpg0UKB9spKtu5tVU73+vrWm+5s/rf/5CMtPu0O2S8g+Z7xj2az6AGNsZbEgqKQCT
 VngDlIZk0kcLkBttREIltRD+LrlF9UZO4QNU7HTpxs3XxuOrTZ6D53yF70L3KL24c1A==
X-Received: by 2002:a05:600c:c491:b0:49f:fe48:d177 with SMTP id
 5b1f17b1804b1-4a01b11c7c0mr7374675e9.32.1790754530042; 
 Wed, 30 Sep 2026 00:48:50 -0700 (PDT)
X-Received: by 2002:a05:600c:c491:b0:49f:fe48:d177 with SMTP id
 5b1f17b1804b1-4a01b11c7c0mr7374365e9.32.1790754529540; 
 Wed, 30 Sep 2026 00:48:49 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029edea4sm1526458f8f.22.2026.09.30.00.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:48:48 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, =?utf-8?Q?Ma=C3=ADra?= Canal
 <mcanal@igalia.com>, Fabio Piparo <holofermes@gmail.com>, Melissa Wen
 <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org
Subject: Re: drm/ssd130x: stale pixels when the GPU renders into the
 framebuffer
In-Reply-To: <5cf16665-40a5-4321-a0c8-98af1d0263a0@suse.de>
References: <CAB3Lz5ZuAJcgKpx0L-O3a-1psk+vwBMeH_Eux+OAgaYcyfFm6A@mail.gmail.com>
 <1f383114-e367-4b67-899b-14a393fece94@suse.de>
 <20260923160049.1741651-1-holofermes@gmail.com>
 <4a5917cb-d7d8-489a-85c1-a217b442a355@suse.de>
 <cbf22c0b-b36e-4bec-8461-27dfcb171d7b@igalia.com>
 <5cf16665-40a5-4321-a0c8-98af1d0263a0@suse.de>
Date: Wed, 30 Sep 2026 09:48:47 +0200
Message-ID: <xlv1pkxvdvs0.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ARPeTohC3N1ao1e_kK38nbHo86TaiO6xpeC0ZQlN2Bc_1790754530
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hello Ma=C3=ADra and Thomas,

> Hi
>
> Am 29.09.26 um 23:50 schrieb Ma=C3=ADra Canal:
>> Hi Thomas,
>>
>> On 29/09/26 06:04, Thomas Zimmermann wrote:
>>> (cc'ing v3d maintainers Maira and Melissa)
>>>
>>> Hi
>>>
>>> Am 23.09.26 um 18:00 schrieb Fabio Piparo:
>>>> Hi Thomas,
>>>>
>>>> Thanks for taking a look.
>>>>
>>>> On 14.09.26 10:43, Thomas Zimmermann wrote:
>>>>> I assume you write these frames quickly one after the other? As i2c i=
s
>>>>> really slow, you might write to buffers that are still being=20
>>>>> transferred
>>>>> in the background.
>>>>>
>>>>> Do you read back the status of the page flips? DRM should tell you=20
>>>>> when
>>>>> it has completed transferring a frame. See [1]
>>>> The test renders with the GPU: two dumb buffers allocated on the
>>>> ssd130x device and shared with v3d over PRIME. It runs at 10 fps.
>>>> Before each flip it calls glFinish(), then flips with
>>>> DRM_MODE_PAGE_FLIP_EVENT and waits for the event before drawing into
>>>> the other buffer. The same test drawing with the CPU instead comes out
>>>> clean.
>>>
>>> A number of things come to my mind.
>>>
>>> - Dumb buffers (from ssd130x) are not meant for HW rendering. They=20
>>> are generally for software rendering only.
>>>

This is another thing that likely needs to be documented somewhere, for
people to know what are the limitations of dumb buffers.

>>
>> This reminded me of an issue I recently saw involving GPU rendering to
>> dumb buffers when combining simpledrm and Panthor. It had the same
>> symptom: this trail of glitches.
>>
>> After investigating that issue, I noticed that, on platforms where the
>> GPU isn't DMA-coherent, when a shmem GEM buffer is exported via dma-
>> buf to a GPU for rendering, the CPU can read stale data from its cache
>> when later accessing the buffer, which manifests as rendering artifacts.
>
> Exactly what we're seeing here. Thanks for the analysis.
>

Indeed, the issue is not specific to ssd130x, but to any display driver
that uses dumb buffers.

>>
>> So, the GPU writes reach memory, but the CPU blit reads stale cache
>> lines. drm_gem_fb_begin_cpu_access() only syncs imported buffers, and
>> GEM dma_buf_ops have no begin/end_cpu_access, so nothing invalidates the
>> CPU cache before the blit and the CPU reads stale cached data.
>>

Exactly, this what I mentioned to Thomas yesterday over IRC yesterday,
since I noticed the same while reading drm_gem_fb_begin_cpu_access() code:

https://elixir.bootlin.com/linux/v7.3-rc1/source/drivers/gpu/drm/drm_gem_fr=
amebuffer_helper.c#L473

>> I have a patch implementing begin/end_cpu_access to
>> drm_gem_prime_dmabuf_ops, which fixed the issue. However, I'm not sure
>> we would like to support this use case upstream because, as you
>> mentioned, dumb buffers are usually used for software-rendering only.
>
> Before we fix anything, I think we should talk to someone with=20
> dma-buf/PRIME credentials.=C2=A0 As I outlined, the ideomatic pattern is =
a=20
> producer-consumer relationship and HW rendering into dumb-buffers is not=
=20
> supported. Those buffers should have been allocated on the v3d side.
>
> IMHO we should write down these rules in the PRIME documentation and=20
> (soft-)enforce them in the implementation.
>

Yeah, I think either drm_gem_fb_begin_cpu_access() needs to also sync
exported buffers (what Ma=C3=ADra is proposing as a fix) or there should be
documentation of the rules for cross-devices buffer sharing through PRIME.

As mentioned, allocating buffers through v3d and importing into ssd130x
(or simpledrm) would work correctly, since the v3d driver already sets
bo->base.map_wc =3D true.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

