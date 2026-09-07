Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B35EC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B0FF10E695;
	Mon,  7 Sep 2026 07:38:51 +0000 (UTC)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com
 [209.85.222.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3C4410E695
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 07:38:50 +0000 (UTC)
Received: by mail-ua1-f52.google.com with SMTP id
 a1e0cc1a2514c-97e96666dd6so2008041241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 00:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788766730; x=1789371530;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9lmypLEXa6TadsDuPofomJEaEW0deGm4lNyHfP7S4tA=;
 b=hsY0Ugs/6K6xD4aGWq3JJdo5268Im8iWfMxZYLTEUfc9q9CjTpebZpzZFFkKIFD8fD
 XnI2mcF5doOQG7ZV8p1x/d6fkfes/7FyImhtxWbLtWgM7w93qZtNZHTS/THFuSRDFcSF
 mQG0LyEnE4n9bDQz7qiWWRjQ4TMuKhZrdUvNYRoQDovkm05XgzPntxRnWUx86KE5We7B
 ddDgYORNrzOjtBh7KuJaOEqNa5ihUmXriFMoM1O9/KQborQPDj7mysSYiY2wupikIIL1
 3hNIRR5O8LNduL1TJFAxQFwTnATSZ5cm1SIaHZY5ndXYxLdpSue96nsw3b7NWPL3jmA+
 aXVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx47oa9H4djXfDrtJ3HULHmXOV3qiF0FpbQdEI7cRNYohze1hwE2Op6OMmHUf0BlwjWWIrPFiwqC5s=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k/glwDYcEV0OlTp3f/KhNmNIa6gzORzVgLMAwIw2bwTwDQQw4H
 J09tk/PuZXG0tUNmFbCHsG2mzO2vWlzZDR5qkt/uzR79VLzI/yk+dMl/7HM9utWC
X-Gm-Gg: AYBFou3GbvZc3CBRzFpofwZj74J/dFWUWSzI9ZIbEV/I1HrT35vHfFKKra+cAioAd9j
 PDSZwr/rJndy/626LdkMabU6WDbqECoLeFH/UCzYj3cY0PKEFQSN4XNwrEB9dZwsrFKyiYUsha/
 j1s1i/dedxj6gzWUHg76xApa3Kmsz9HiYKQz+iLPt7IWFQsBfWWygciCetXS9tnNc731gx3UVv8
 J4D9xF5kCJ5KYEATg/CKUBPEavb4RK2BeUcWapKJ3mLdUWyhcWnBNwy/VXMuPpvDtp1KtoYRm4q
 6LYbhlWhc1gaiUDZRoWh/Rm2YbYsT9mTnh+slnNRRQNVakKj+SMjr36fX0m2NFnkWPBVuIdzrRS
 ET1QiXp4lmiby6jRsneoAJMLybY9YSiUXM0YllmDFjoAgCwB3BTaJM5pX3QSQGLXlyU7gL+m0Iz
 nu4A0R4NS++kMmzPcxg6PBFjFNu8Ys0+rdF67ihAYwnTZZkE+837YgaA/Xw64C56xmFkerThdKF
 uiZsb1wuXRTJgBPQqC1AMKkLw==
X-Received: by 2002:a05:6102:8023:b0:789:5fc6:3693 with SMTP id
 ada2fe7eead31-78a4a6f8278mr8083869137.6.1788766729666; 
 Mon, 07 Sep 2026 00:38:49 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com.
 [209.85.217.47]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-78a47ae301fsm6394957137.7.2026.09.07.00.38.48
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 00:38:48 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id
 ada2fe7eead31-74ab99038afso2221588137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 00:38:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBx5LRePKANZBrvllKCUV/WO+xO4eD4NIHWLbaxCi4SmQ6p3iVST5oQFu/D/6sWkbKNLEmdVt7kQzwQ=@lists.freedesktop.org
X-Received: by 2002:a05:6102:5803:b0:785:a48a:e3b9 with SMTP id
 ada2fe7eead31-78a4a6a93d8mr8633268137.4.1788766728573; Mon, 07 Sep 2026
 00:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9ty9kjb1bKFgjgBS1tgM3zP2tK+5qTFzT9-0t+1jykBDxw@mail.gmail.com>
 <CAMuHMdUG7_7GDPhs3H7kiarqSYR1_gMD1onYu9Hzem-_a-ookg@mail.gmail.com>
In-Reply-To: <CAMuHMdUG7_7GDPhs3H7kiarqSYR1_gMD1onYu9Hzem-_a-ookg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Sep 2026 09:38:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVyFiywZJyaRCRjdkVptfiFOk=wy5+sQ4Mb_BgF10Q=7Q@mail.gmail.com>
X-Gm-Features: AcwNN1W0aE5OZzjNu-7U0GJ53E9ptLdW1F38nK2hxhqmN1mAIYRx2w1qul6NQfw
Message-ID: <CAMuHMdVyFiywZJyaRCRjdkVptfiFOk=wy5+sQ4Mb_BgF10Q=7Q@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 7.3-rc2
To: Dave Airlie <airlied@gmail.com>, 
 Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>,
 Arnd Bergmann <arnd@arndb.de>
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

Sorry, forgot to CC Arnd for the uapi breakage

On Mon, 7 Sept 2026 at 09:36, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, 4 Sept 2026 at 21:52, Dave Airlie <airlied@gmail.com> wrote:
> > amdgpu:
> >  - Fix for drm_amdgpu_info_device with mixed 64 bit kernel and 32 bit userspace
>
> This commit contains a "cherry picked from"-reference to a
> non-existing commit in upstream (it does exist in linux-next),
> and mentions a discussion between three people.
> It would have been better to include a link to that discusion:
> https://lore.kernel.org/20260820045438.3974-1-yogesh.mohanmarimuthu@amd.com
>
> Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
