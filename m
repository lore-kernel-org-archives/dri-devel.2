Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32150CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 18:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C8A10E0F3;
	Wed, 30 Sep 2026 18:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W1Xbue40";
	dkim-atps=neutral
Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com
 [74.125.230.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2171310E0F3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:46:07 +0000 (UTC)
Received: by mail-lr2-f34.google.com with SMTP id
 38308e7fff4ca-3a76cdef66fso18098691fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:46:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790793965; cv=none;
 d=google.com; s=arc-20260327;
 b=W80hPQLit5itiMVPMQ2ekPDAlYTV/4MeJclV/8lQQfn5KfH84vQwA2E5ISZsl83rrH
 DywBHyNGBbZpr13SQdH2kJARKegyENXC/4KeJZ3Bnut+9eTWBLkkKGgnTlEfANpaERFC
 zV7x3vlJPRc2KWeOPQFt2V1yjIdy2f1B4HwT6A7LjCHrnezMBoqHxHkzIOsypCU70eg+
 l1ZXc/XQdVohqgW7bt9sgSmR6xxalJKUF1j2VNlgiiG2dJ88YP/3xRDlcuBXUUeNhhOU
 V53ra+56hYqZuP34HO3uoFI+r9Epd32fFVbzjcDEw4gT7HjIzXWONhhRDxP6qRoYPGtP
 kcAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=C0sTSUPFP3WcGZK6vMxgDpZXBfQkv2kI8Yja+uUe4WE=;
 fh=obzKCSZ+JL6Hc/Y+mGcvOzBPMIpEGB3wnrzOMSzd0M8=;
 b=YrJNCsA+68tgnpMmShJzulL7XDrdggUOI7rZ7tD4WuEn0hZ6vw/Do3hpOGDwGPQff5
 WLdgK6C04Pbdccz6BSuVMDw2B8//32oWIBLJS6UhRV5OxvPx6iw1SzRr4pnXJNkZCXz3
 yfGnlv9oM+xYpitx4WyuFdcL441HrHGI97oEJpCA9pM7h1vWiYt/34E3JM1wFKVAX9Mv
 AfnAkLHBT4F7QWZTF5EQcYYIs/n7kYfEepIZkBvg/RgIZK2ELQPQp5e4tGtk5+UK5o/t
 8IeE0eHRDidlGMUNeZlU7GgO9ZMViAt1AOwt/vnXigXwmaRynPuNopolX7W8Vs57+w6h
 hdKw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790793965; x=1791398765; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C0sTSUPFP3WcGZK6vMxgDpZXBfQkv2kI8Yja+uUe4WE=;
 b=W1Xbue40Ya9I/Kn8z8wrpUejh6sm1yKLDCz6K5ibSyOkEeANNcGRorWJzmPJlmju3I
 FWsXlawF8nzlRZsUmVh0niCyECVlgmDG/oB0LZTmsQcinsI5tUS+d1UqG52EGzt8ruOP
 1An82hbKR5VxRcJ8e6psiqC0t7iKby3oi8dZuOj0kECjPNeVt4VwPjsN5Adie5vEnzA9
 BfC4HLsPN0mx75L9SZ90gy0t4LooLKbCc9zCc2xdHtDGaTINNfe3rXXWZoCgzvftul1t
 wiLBLgf3yWgdUatKKs+dVN/SzAUhGuKWuTQVrPYtSu8OnLGQDVdeDrJmwcy1YjfsfTVx
 WfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790793965; x=1791398765;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C0sTSUPFP3WcGZK6vMxgDpZXBfQkv2kI8Yja+uUe4WE=;
 b=QujQYCc6U5xY8zZYO4x6xmq85BACvXhCz86IFaTjkJEcV2qYnmrlShBicq5DmuVIIt
 dxuJF91dohw/GuN+5eadtlzk0u2bW3lxh+o3Nng4SHhlZxX4JIAK6sAQwgXgZ6ysYIYr
 ny5PNh4LIBTT42l3BeeaccZfBWaDV917gJrddrV0rRSK6yBvGhGOF7zNINI4W0mRGNBJ
 OgfYrOkUag1gDk0ahoLEpgpw87zj3J8u0KZgdokSfy2x4kyo0byM9NnyT2p2zpx9fJ/F
 7IlJ9DWUz/Lirshc5syjErGynmX7I7MeIYeg34tofk2nZYnvixIUOtbGFRTp6P8VSEx7
 6Vdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0feObB268XOEV+ysC5Brc40tjCSdVOnLEfBJ36m6XvHUmzqpWe/prE4iNLdPAmoWCPZSV191fhoU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK2GXYeMy5P8hvZKxZ/2SGj65HTLzfV9a73EPiqTZPsyVEezg19
 FOw55kaXiRB5P88MmHkr/+bphALXVFYVhyZlK2aUACUJq5+8H4PObUy5CLAo3fQVrfI0YX+lql/
 LwMshMmXqDG1TzF3SeWh5fWlL0NN+zCA=
X-Gm-Gg: AYBFou1m4Q+pSly+h6cJZVEAng+uiyRNyDxN5NzKnQUVgugGh+LwUebbsmlloOYjx4Z
 YenlIaNDpFG4dpoSZEyEpjmGqnESo2QgY2K1oStdwfVSlBxir9ib3RqR5oZJfN8x/ze5FQfgXNX
 qESN+uTU35/o2cg5eq19rM4+Zy8VrV8rzMswWPnuRu6c7jzvZ37JnYhVBlnZeUGtrxiGuVOoSIe
 WZAiMUcRM0HOpK97sOQrrhjNA1F+l3j4morQQj5bTvPUI7/FjnlbSwnBx3dn24w3poIEESkV2Vb
 eNchINFUA9gLO51mYF0fTCmR/ncWaxm6SVhv/V/mrn9KRhGZphITew==
X-Received: by 2002:a05:651c:41da:b0:3a6:4917:db4e with SMTP id
 38308e7fff4ca-3a779241155mr6817061fa.17.1790793965026; Wed, 30 Sep 2026
 11:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAB3Lz5ZuAJcgKpx0L-O3a-1psk+vwBMeH_Eux+OAgaYcyfFm6A@mail.gmail.com>
 <1f383114-e367-4b67-899b-14a393fece94@suse.de>
 <20260923160049.1741651-1-holofermes@gmail.com>
 <4a5917cb-d7d8-489a-85c1-a217b442a355@suse.de>
 <cbf22c0b-b36e-4bec-8461-27dfcb171d7b@igalia.com>
 <5cf16665-40a5-4321-a0c8-98af1d0263a0@suse.de>
 <xlv1pkxvdvs0.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
 <a8814ebf-1d6b-4f71-8f53-77b7476ba0d7@suse.de>
 <a9f52cac-e8bc-4ec2-b452-0fdcb32c4713@igalia.com>
 <xlv1jyo2enyv.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
In-Reply-To: <xlv1jyo2enyv.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
From: Fabio Piparo <holofermes@gmail.com>
Date: Wed, 30 Sep 2026 14:45:38 -0400
X-Gm-Features: AclHuK-QRx518mRpvY6iicHx6fnv3-E4GDXSJSOwPQTCYtv3X9y-9Ek21YcdVts
Message-ID: <CAB3Lz5Y-N4Tyecu19PMzeTseDrJLvU3ik+sBQcLWdxAMS+jxog@mail.gmail.com>
Subject: Re: drm/ssd130x: stale pixels when the GPU renders into the
 framebuffer
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Melissa Wen <mwen@igalia.com>,
 dri-devel@lists.freedesktop.org
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

Hi all,

On Wed, Sep 30, 2026 at 2:48 AM Thomas Zimmermann wrote:
> Those buffers should have been allocated on the v3d side.

Ah! Now I think I see what's happening. Some context on where I'm
coming from, since I think I explained it badly.

My program opens the panel's card and lets Mesa handle the buffers.

    fd   = open("/dev/dri/card2", O_RDWR);        /* ssd130x */
    gbm  = gbm_create_device(fd);
    surf = gbm_surface_create(gbm, 128, 32, GBM_FORMAT_XRGB8888,
                              GBM_BO_USE_SCANOUT | GBM_BO_USE_RENDERING);
    bo = gbm_surface_lock_front_buffer(surf);

On a Pi 4/5 Mesa hands me dumb buffers from ssd130x with v3d drawing
into them. On a Pi 0-3 it goes the other way, the GPU makes the
buffers and ssd130x imports them, and that works fine.

Reading this thread convinced me that what I was doing was wrong for
my use case, and that my program should own the buffers itself. So now
it does the producer-consumer thing:

    gpu = gbm_create_device(open("/dev/dri/renderD128", O_RDWR)); /* v3d */
    bo  = gbm_bo_create(gpu, 128, 32, GBM_FORMAT_XRGB8888,
                        GBM_BO_USE_RENDERING | GBM_BO_USE_LINEAR);
    drmPrimeFDToHandle(fd, gbm_bo_get_fd(bo), &handle);
    /* AddFB2 with that handle, draw into bo through an EGLImage, page flip */

That's clean on a stock kernel and stock Mesa.

By the way, I found one other report that looks like the same thing,
from March 2024: https://github.com/notro/gud/issues/22

Thanks,
Fabio/
