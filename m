Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D80AC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6352810E474;
	Mon,  7 Sep 2026 07:36:54 +0000 (UTC)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com
 [209.85.222.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8AEE10E474
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 07:36:52 +0000 (UTC)
Received: by mail-ua1-f42.google.com with SMTP id
 a1e0cc1a2514c-97cad2f51edso828256241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 00:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788766611; x=1789371411;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=r71PWtF5lxEG8yZB3mpAEnjiknr+9LGf2snMKlbVdJ0=;
 b=eyj00QGBZzh8uHF668s2pN2GSjcLggc0mHIGDJzpKZYWmKm+TDnrUtAcLMWSO1/xAN
 x3y0mKH6CT2Gb+T2tE4ZQdGrxBDtQnb5YNQBHl4ZHmSlxZtpyf2IMj1wh4gRgJLNyzWs
 dSuaLIyzZ7MYHiXz5V2WlnHTKO338ct9gTghRCC/ku9RqRXTCH5oLDw2X9jjX3/CXTNm
 JI/mL4Pu342GS4z8TG/+5HHh73i4NImbDVngQlVo6w6YcJozKCnV+0SCHrAL7wcazUwx
 kIQuG3O5zTeLq8+uRWMpFNnl6gElb8Y0lsfiyLxR0vSnQ2gO4BRUoVEgCsht3bOZxvlb
 PK9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQfWynVRTTOVw5yVjdE+MP4BkcI1z+wjFjytxq5nDiauCCA/slsiqAinvdAuFESdjb34XafISDAfM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lQF1x4sw2L6Km7gpRbpLE88dEFnikfQGxW5TDChn9+yehDzN4Q
 ZC9Mm/4nDmuVyKIBGlLDQV5lpdWqmOD1j6DavVasbwCFoMKKmIjrf6IGMl1cgs89
X-Gm-Gg: AYBFou0lZTZAxYbHnucCYfWzaQfsuce+h3hbyVERriG18ohLl1I7iXa4giurcLclcYb
 zMpR5Tcke5OzoopKsjelB9WF1XOkyClMVoqgoA1YlxEqxBztNtrjdtwAfVcruX4NYasaqz5gNaG
 1l6U2iiqtzgzGCbY3xLBhgeqlBhUGeKIKLblEWuZb4tCHQU/QUp4TtOMFu3A2WGM9kTpOGWA7dO
 zhdt8aGOL/TSkudCHoBKkLKjP5k+QggMQGKuAfAKfMeGnDYwAoLevBZkF4wqubZUyY1XqRLtpSO
 Ja1Ee3w7IZROe5kQrH2PmI9t6oawUs8ni1oi6c37Od4m3b/eWZARaPwenMaY1us10Tw5QXFhSzw
 Z6hgEJb0+tialgFgggtubv10tmxo76E9a7G/UA8KClY9yKJCBhUurHHHzgxLhI/pjvQ1k2TgMMK
 kuLTy0zgn5Q1NeGM7Ml5DZWJrDleyb/kd0vf7afOMQtK0Y2UJsUqr7wPg9kfraqozJ6PKM+1Gut
 M5qWbV19OVDRDOmnWrmwm7XbQ==
X-Received: by 2002:a05:6102:6b01:b0:785:3211:f5e4 with SMTP id
 ada2fe7eead31-78a4a6c8a04mr6750547137.4.1788766611386; 
 Mon, 07 Sep 2026 00:36:51 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com.
 [209.85.217.54]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9808eeb22e5sm6865578241.12.2026.09.07.00.36.50
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 00:36:50 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id
 ada2fe7eead31-782e0fc1e55so832767137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 00:36:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBw5Je6tha5Y5hWKAsnVbmNNBJV+qtHFQQLc0MBR1TNmbqMCBXDNH7JpqrtdfqRgwb3xkYjXiAGp+i0=@lists.freedesktop.org
X-Received: by 2002:a05:6102:5e86:b0:78a:8a0:7116 with SMTP id
 ada2fe7eead31-78a4a6f61c1mr6350849137.6.1788766610006; Mon, 07 Sep 2026
 00:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9ty9kjb1bKFgjgBS1tgM3zP2tK+5qTFzT9-0t+1jykBDxw@mail.gmail.com>
In-Reply-To: <CAPM=9ty9kjb1bKFgjgBS1tgM3zP2tK+5qTFzT9-0t+1jykBDxw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Sep 2026 09:36:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUG7_7GDPhs3H7kiarqSYR1_gMD1onYu9Hzem-_a-ookg@mail.gmail.com>
X-Gm-Features: AcwNN1Xh1E1drhlmxpdW-6B-oSys0CxIfVnacGZNB9MW0x38Cq66CbRDiOO3eRI
Message-ID: <CAMuHMdUG7_7GDPhs3H7kiarqSYR1_gMD1onYu9Hzem-_a-ookg@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 7.3-rc2
To: Dave Airlie <airlied@gmail.com>, 
 Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
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

On Fri, 4 Sept 2026 at 21:52, Dave Airlie <airlied@gmail.com> wrote:
> amdgpu:
>  - Fix for drm_amdgpu_info_device with mixed 64 bit kernel and 32 bit userspace

This commit contains a "cherry picked from"-reference to a
non-existing commit in upstream (it does exist in linux-next),
and mentions a discussion between three people.
It would have been better to include a link to that discusion:
https://lore.kernel.org/20260820045438.3974-1-yogesh.mohanmarimuthu@amd.com

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
