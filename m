Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3590FC61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82ECB10E626;
	Thu, 27 Aug 2026 13:03:47 +0000 (UTC)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD7910E626
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 13:03:46 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-782df51b4c1so1488061137.3
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 06:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787835826; x=1788440626;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WzKYk3/+V+rOzh1rTxaW+egKeE53pqTO5dJe7JNkRn4=;
 b=AE3Yqkcmsj2LbXyPGVAZz53pUyuxLHNHUnUJfHX1LFe1I6fcgnco/tSICqqiSGHwXs
 MUbF0yIibwG9tOxlbPyFLSKiyVk5zOaRX+Sbtb3Kx9MdoUPCNMXANali5grFs2Kzb6iH
 l2krjY4Y9TrwOgtGMvPbSPti7yF8UQD9Zs/NuGOI1StojHKGErjzI4cWyIfYEMs1IRdg
 YT+KEJrFX2cqHjZFb018vBs4B3U4R0/xuWdnnjtLbksQ1wfT8vXZbuSyQm9CrXI+zLuA
 8fLib+QyN6aAeCrlWqsgT1eOCO7G7mm8r4uHqLP4YpHJu/5Q/98rBGUly2ClQLauuibI
 Ah6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpL4kuMeKnaF7tXoJs81K1O+ktpLhUhLmxE5/c4l8SUhQ+jchntThLM1/nbJWJ3Nj40Do5GEwRH9MY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l7k8hbRKwQJdi3x2Ybx2dZLct4l2YQefd6A9ymHWXfWXd+MVTu
 +V5zp8/jsrCJGOLBrgr+n9nPZHuDtu1FD88PwJBECgexKG8J363NKBxFfCsd1LRt
X-Gm-Gg: AR+sD10wLGMpvfFUtsuqc/6MGDAZo+BV0d9TEzmfys5+s2yS4hlV0750gqS5ecP3NwO
 JxA71t0cGnSTPRWsDiJSZWp/vMJcAnEw3rrSzUNM02e5AzetAEJXLmm5LFX3w1G5ZeyKnQi6jZc
 soewlSeJuddBDk1chrQ4MjA4Xzg59sM+rkn67VHX1YR7FuL8sniURC+3W7G4sCV8LRuOxejxHAa
 P7wqNyrbsGMqGnBwmeDRaAP4KszLR++nzeYsSXeI+mk6IBN+AGf1ZilyDcg646vaVz7Wb0lgZ0d
 cSb7a7XU8NnlRhFBQfic7h2YLtUbnMxIordF1OJq7fwgHgQGmOy7ZEb34Ejzxg4KH7kPERDrnXQ
 YSSSQyyPh6O9rTcHLPaqE8mKR13U6BlfkLdzou4oP4D2CO9/VGntASs0iHWPBPldyE3O8Uj4CQw
 cUqJEhhKnnRq8851SgWZSPe2ElTh37YM+1igbrWWz5HDOX5qAfg1Ij36VLwkbkZjijJd2ns0rlG
 1tXEMuZBS3BI7nI71nPjAyeXw==
X-Received: by 2002:a05:6102:6892:b0:778:4fe0:8297 with SMTP id
 ada2fe7eead31-782c1b0191emr6463414137.11.1787835825515; 
 Thu, 27 Aug 2026 06:03:45 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com.
 [209.85.217.44]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97cbde09650sm4863197241.0.2026.08.27.06.03.44
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 06:03:44 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-782df51b4c1so1488034137.3
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 06:03:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1H9ttAtFJTKacvBt7y1PnXrP4mK3vrSGloF+x5TkjUUef56DGwRHcYZuB150goGSz9AVpjvDP6zw=@lists.freedesktop.org
X-Received: by 2002:a05:6102:8499:10b0:782:e392:2ba6 with SMTP id
 ada2fe7eead31-782e392308fmr3427230137.9.1787835823964; Thu, 27 Aug 2026
 06:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <f2Kf9GYn1lKR5S1dbvGVtykMxK1RlgP5z8sW@bugs.sh>
In-Reply-To: <f2Kf9GYn1lKR5S1dbvGVtykMxK1RlgP5z8sW@bugs.sh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Aug 2026 15:03:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUPF3vzpTQWWJvjPmrHahXcdo_USyWX+LxK9bHppuc1tQ@mail.gmail.com>
X-Gm-Features: AcwNN1X2bkBw8SIWU4yTCrO5AX2qiaKB8yFkpoNbbPhB8bGMcoiC2Ojl7dqCiOA
Message-ID: <CAMuHMdUPF3vzpTQWWJvjPmrHahXcdo_USyWX+LxK9bHppuc1tQ@mail.gmail.com>
Subject: Re: [BUG] drivers/video: use-after-free in _copy_to_user()
To: co <co+c25629c98ba36ebe@bugs.sh>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
 Petr Mladek <pmladek@suse.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Song Liu <song@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>, 
 Oleg Nesterov <oleg@redhat.com>, Andrea Righi <righi.andrea@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
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

Hi Co,

On Thu, 27 Aug 2026 at 14:43, co <co+c25629c98ba36ebe@bugs.sh> wrote:
> We found a bug reachable in:
>
>     path    drivers/video/fbdev/core/fb_chrdev.c`, `drivers/video/fbdev/core
>     crash   use-after-free in _copy_to_user()
>     commit  843bc34db94b
>
> Config, environment, the sanitizer report and a C reproducer follow.
>
> == Notes ===============================================================
>     If you patch the bug based on our artifacts, a tag would be
>     appreciated:
>
> Reported-by: co+c25629c98ba36ebe@bugs.sh
>
>     Everything in this mail is validated by the reproducer below.
>
>     We also hold an LLM-generated root-cause analysis and a candidate
>     patch. The patch passes an A/B test: the same reproducer panics the
>     unpatched kernel and runs clean on the patched one. Neither has had
>     human review, so both still require validation before you send or
>     apply them. Available on:
>
>         patch.diff  https://bugs.sh/b/c25629c98ba36ebe/patch.diff
>         report.md   https://bugs.sh/b/c25629c98ba36ebe/report.md

Thanks for your patch, but both links are almost empty:

    No artifacts published for c25629c98ba36ebe yet.
    Request them from co@bugs.sh, quoting the bug id.

>     This is an open science project. The code and the full set of PoCs
>     are not public at this moment, as we intend to disclose our findings
>     in an ethical way.

Please read Documentation/process/submitting-patches.rst

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
