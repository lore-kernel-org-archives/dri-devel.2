Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725A0CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D535C10E071;
	Wed, 30 Sep 2026 15:52:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gca6jdSR";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 563F010E071
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 15:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790783535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RFU8URWKTSV6gu/ogdffHhx8mfCXrnRrbyQhdu1z3o4=;
 b=gca6jdSRokjivFekRj1ogfL6OXRJNNWV/bMEzgxdQf35BMiJRzrjKYmghgiAqKPJ59VSFF
 SWjGj9gz0JXPRLiqvsqyhabdabso5b79qS3KWmhBLMCzNAh4NacRpVipH0nlwsByP29bYN
 6nrzD6UMk7J3G6+vO93cnocV+A96hro=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-rnoYqAPsPyew9dz59P-52w-1; Wed, 30 Sep 2026 11:52:13 -0400
X-MC-Unique: rnoYqAPsPyew9dz59P-52w-1
X-Mimecast-MFC-AGG-ID: rnoYqAPsPyew9dz59P-52w_1790783532
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e635a6002so63396955e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 08:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790783532; x=1791388332;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QBXo7CJfd1cvgAIpakqjsUb7YInVtLPKngVCOikL9co=;
 b=s9fsr7CS/Dh9m2qVH+ljWdtUY2I4BNc78jHpFqCfbic1yTeD9PZTzkJ/P6tLRQfdTw
 AJB4vpfx1CgwkWktFJNdZeK6zvfCgwlsoX19C3aerpO2a5uNzpqwazx4slvrt8c0elhC
 07qxhBWUu4i7rTSERl9TYQsUEHZedbWiyGQrithOEuwRrqNo4NbRmJNNdV2kcC15o9OP
 j3I2/0s7BvuutUHpuRwZMibXs0RPV6gzAA42Npnfxb4kkjPfz0cbGaBoDzZtfw1hMfJa
 dIz+b3mSGe72oklEqo5h8YDe0bpOIaFQrVI3MMQNtJHQ78FKd2pHnXchDEjFowEEcS1J
 asKg==
X-Gm-Message-State: AFuF++nCUluTYbPa6tQW/nfZlII3wH6h5lYs1rZ+5a+fyW0g1gHkbPKD
 Kx96qaNfbYhepO0ypX3geDgZJCgJzLO9GgRH75G6H+TGm4Nahm7dr9eo+r6njynGizur3L2K2wP
 BBCWwIpNDQtuJPjU6LJ3a0VeDxNBXEpSMiYHUv++LwYFD157ul0oJ+e7tf2zItoIkWVOrww==
X-Gm-Gg: AYBFou0dKdrz3AuARzK32nQVHHAp5FDNxmLcWM1nzX1OjBqftX9wxIqCW2cgdUQBSBi
 Z6E5YEVgUF2tSyAmQlhJRMFDOU0WbCCWwlbOrJxR3VmAG6s2GQeisqzPYTOzbZv7elzHXvbD9G4
 9NmKxJS1BuFeLvR62bcoZ67niBTRg8lpFI7JxsfBfT0lYZNoZjhO6bRe3u8b8gmFeOMPGT2FhXw
 FBIGq0Ha8TxwwDBUMssykxaQawwaCtkkGHt05ShSdwj0boXNHkkSW0oClAFlgQegk2yhUIDdYHG
 MCp+88HydR7bDu/E+FfsBmYInqKtQb1b3a7RUL7lS+xyFx1iGLfgrOYc7uIQ6O3M2VTlS4cHmfS
 Ox8D9Vyl4xH72Lgv7mgugph0rgkQ5ul4h9jK0lieBBtRDj9C3hHda4cezBsWiuhpqkg==
X-Received: by 2002:a05:600c:4fc9:b0:49f:c331:39e4 with SMTP id
 5b1f17b1804b1-4a01aff3ba9mr31642045e9.7.1790783531782; 
 Wed, 30 Sep 2026 08:52:11 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc9:b0:49f:c331:39e4 with SMTP id
 5b1f17b1804b1-4a01aff3ba9mr31641665e9.7.1790783531291; 
 Wed, 30 Sep 2026 08:52:11 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01e662383sm7878545e9.12.2026.09.30.08.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:52:10 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Fabio Piparo <holofermes@gmail.com>, Melissa Wen
 <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org
Subject: Re: drm/ssd130x: stale pixels when the GPU renders into the
 framebuffer
In-Reply-To: <a9f52cac-e8bc-4ec2-b452-0fdcb32c4713@igalia.com>
References: <CAB3Lz5ZuAJcgKpx0L-O3a-1psk+vwBMeH_Eux+OAgaYcyfFm6A@mail.gmail.com>
 <1f383114-e367-4b67-899b-14a393fece94@suse.de>
 <20260923160049.1741651-1-holofermes@gmail.com>
 <4a5917cb-d7d8-489a-85c1-a217b442a355@suse.de>
 <cbf22c0b-b36e-4bec-8461-27dfcb171d7b@igalia.com>
 <5cf16665-40a5-4321-a0c8-98af1d0263a0@suse.de>
 <xlv1pkxvdvs0.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
 <a8814ebf-1d6b-4f71-8f53-77b7476ba0d7@suse.de>
 <a9f52cac-e8bc-4ec2-b452-0fdcb32c4713@igalia.com>
Date: Wed, 30 Sep 2026 17:52:08 +0200
Message-ID: <xlv1jyo2enyv.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bc3nv8S_lDT87BIr3JFxJhRlAaKaNdRXYHNDTJpo2uU_1790783532
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

Ma=C3=ADra Canal <mcanal@igalia.com> writes:

Hello Ma=C3=ADra,

> Hi,
>
> On 30/09/26 05:32, Thomas Zimmermann wrote:
>> Hi
>>=20
>> Am 30.09.26 um 09:48 schrieb Javier Martinez Canillas:
>> [...]
>>>>> I have a patch implementing begin/end_cpu_access to
>>>>> drm_gem_prime_dmabuf_ops, which fixed the issue. However, I'm not sur=
e
>>>>> we would like to support this use case upstream because, as you
>>>>> mentioned, dumb buffers are usually used for software-rendering only.
>>>> Before we fix anything, I think we should talk to someone with
>>>> dma-buf/PRIME credentials.=C2=A0 As I outlined, the ideomatic pattern =
is a
>>>> producer-consumer relationship and HW rendering into dumb-buffers is n=
ot
>>>> supported. Those buffers should have been allocated on the v3d side.
>>>>
>>>> IMHO we should write down these rules in the PRIME documentation and
>>>> (soft-)enforce them in the implementation.
>>>>
>>> Yeah, I think either drm_gem_fb_begin_cpu_access() needs to also sync
>>> exported buffers (what Ma=C3=ADra is proposing as a fix) or there shoul=
d be
>>> documentation of the rules for cross-devices buffer sharing through=20
>>> PRIME.
>>=20
>> This specific case only happens with v3d and only this driver can know=
=20
>> when to flush caches. If we flush caches in begin_cpu_access, we easily=
=20
>> end up paying the overhead on all systems.
>>=20
>
> I believe that's the main issue. We would pay a reasonably big price to
> support this uncommon (and maybe even wrong) use case.
>
> P.S.: To be clear, I wasn't proposing a fix. I should have called my
> patch a "hack", because although it works, I don't believe we should
> support this use case for the reasons stated by Thomas.
>

Yes, I agree with you. Making v3d to warn as Thomas suggested seems to be
the best compromise.

> Best regards,
> - Ma=C3=ADra
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

