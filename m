Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FC3106FD9D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:38:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 346C510EB31;
	Fri, 13 Mar 2026 08:38:07 +0000 (UTC)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com
 [209.85.222.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9B4910EB31
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 08:38:06 +0000 (UTC)
Received: by mail-ua1-f44.google.com with SMTP id
 a1e0cc1a2514c-94acb3d6cceso1063325241.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 01:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773391086; x=1773995886;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G6Pa9aWTkiMBPCI+D/MHSkr4FjR8grbvwp7DSGWc+Yg=;
 b=oYriz86giLC6r9xH04qxCdp88l1wHTPxqxFlYPbmpbypArb9+Le1undOD8CDRygMW4
 SnNCLbF375J9K8QLaNVLZfSWO0m2xPKXQurCPTraobw32/uCaPma2Ja1axJ+Q4WeCTC6
 CeDIpatrJVZEVFuiFf7aH9N19bP2y733iaxR9q7ahUO3Jgf4r+RFiaRBWMUKi+SwYQTM
 0FEyvVfGFkz/zRz7GfsPeUv4Ee0wE47Su9Nvw9DWe4+sdhmScUxFg6z4DgMjrNC2jrF6
 USqPJKh7YFxj9NCF/K6mNwrPAdkSQAS+StNriikmcYGWBDq8vIpKwIoN/gEeemiEbi5/
 o8TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKzC7IyFJw3cMypwOYrNGnJvty03ppI9n/YDKEasZNx7nhuqCapPM9jdCLQu/Fq1AUZohgmtEBNzg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMP2TVZOOSZ3kLGqdjVW302ZOQ63nhj4UNgJdwB9UWR4kq8RWm
 gdFZTfBxyFsQ5YLDaRBfVB3AkEuObJ90W+zqv9eOrjNt2Gw9s2vzKdNFM5evTYsTNPU=
X-Gm-Gg: ATEYQzz7mUnfdYgUPQgxuI8QVRAvc02fe9W0Dmde8ihEH5UuYB+CtIIj4fiNnjp9iWX
 XtQgEWNDAA1DG5axLN88RSisPOKvgU39Z6zPbN0Fvnj1LmekMaKicZV02sO2O5TkHcEdoJEpTj9
 N5Q8t5IJsedlTTmHoykUq5d/hNamksWjIoCSzhmJIhDrHEDh7F9OrAQKEQW2MZEOTtE7MOrUlZB
 T832w7ShIT/zrrAQmBIbMvhJYjAhj8XiJ8sIGnES9uP3lFLCxJYbg5YaGJQXAxFwln/YjrukEKh
 d4Jy142wnF9jgt6InMYYcFp/QBow9bZWHLZrVSVq0N+qKrLlvLU4AlxSxzI5nMFG5NnWHyybYCl
 7PT0GJQbx2GB7REW2GHyiSqVKKjgu1EdL9D4F5225E+7pF0ZogbVlHDrI1G4bVFbR4MGfYxeIbm
 aAeFrhjn/ewDttbhbJePor9h134k5QGcFNebdr/BFSxawsemrpcLdbwTeUHu2oc+W2XlqVHHDOf
 gU=
X-Received: by 2002:a05:6102:442c:b0:5ff:b684:f7c5 with SMTP id
 ada2fe7eead31-6020e209c34mr1097090137.8.1773391085541; 
 Fri, 13 Mar 2026 01:38:05 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com.
 [209.85.221.170]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-601de74a80asm2944983137.6.2026.03.13.01.38.04
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 01:38:04 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-56b65ffbda3so327306e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 01:38:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVPoBlDNQ2SOLMWzyw5l2EDqgwxZaBpSfW+n5zsoh8DbNM+Mo1sftRSEPtWoUUGrYueJjholnTGcy0=@lists.freedesktop.org
X-Received: by 2002:a05:6102:508c:b0:600:a2:1397 with SMTP id
 ada2fe7eead31-6020e5345d4mr1072589137.25.1773391084694; Fri, 13 Mar 2026
 01:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdXrYTGQkjC1Sr4NjOcsRyOw3_eEj9m5MVVo1GWUuCxo3Q@mail.gmail.com>
 <20260227095742.4449-1-phucduc.bui@gmail.com>
In-Reply-To: <20260227095742.4449-1-phucduc.bui@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Mar 2026 09:37:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNA=wTksUEmnW7NQ=XCjMBuHDyJy-XqZh4yRxECNFuwQ@mail.gmail.com>
X-Gm-Features: AaiRm52euRkRYote2HVmfk03rr0AuE-oJu0RlS2GkMnI_IuORuzmIExqtJcu-Vk
Message-ID: <CAMuHMdUNA=wTksUEmnW7NQ=XCjMBuHDyJy-XqZh4yRxECNFuwQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm: shmobile: Fix blank screen after resume when LCDC
 is stopped
To: phucduc.bui@gmail.com
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, 
 laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
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

Hi Bui,

On Fri, 27 Feb 2026 at 10:57, <phucduc.bui@gmail.com> wrote:
> > What do you mean by "deep sleep"? s2ram? In upstream, s2ram behaves
> > the same as s2idle, and the LCD works fine after resume from s2ram on
> > my Amadillo, with and without your patch,
>
> > What am I missing?
> > Thanks!
>
> Thank you for your feedback.
>
> To clarify the "deep sleep" context, I have tested both s2idle and deep
> states using:
> - echo freeze > /sys/power/state
> - echo mem > /sys/power/state

OK, same for me.

> On my hardware, the issue is consistently reproducible in both cases,
> resulting in a completely white screen after resume.

TL;DR it depends on kernel config.
With my .config, your patch is not needed (but it doesn't hurt).
With your .config, your patch is needed.
Unfortunately I haven't found yet which config options causes this.
I will send you my .config by personal email.

Your change looks valid to me, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> Regarding why it works on your side: I cannot be certain about the
> specific differences in our hardware configurations. However, on my
> setup, the debug traces clearly confirm that the LDSA1R register is
> reset to 0 after resume.
>
> Video demonstration:

[...]

> Detailed Logs and Configuration:

[...]

Thanks for this very detailed information!
Since I did the investigation anyway, here are my results:

1) Using commit a75cb869a8ccc88b + debug info:

I get:

    >>> ENTER: shmob_drm_plane_atomic_update
    >>> ENTER: shmob_drm_primary_plane_setup
    shmob-drm fe940000.lcd-controller: [BEFORE] LDSA1R: A=0x00000000
B=0x00000000  MIRROR=0x00000000

Same as yours, OK

    shmob-drm fe940000.lcd-controller: [AFTER MIRROR] LDSA1R:
A=0x00000000  B=0x43a00000  MIRROR=0x43a00000

A and B are similar to yours, B is just a different address, so OK.
In your log, the MIRROR value is truncated, so nothing can be decided.

    shmob-drm fe940000.lcd-controller: [AFTER SWAP] LDSA1R:
A=0x00000000  B=0x43a00000  MIRROR=0x43a00000

A and B are similar to yours, so OK
Your MIRROR value is truncated (I don't trust the final zero)

    >>> ENTER: shmob_drm_crtc_atomic_enable
    >>> ENTER: shmob_drm_plane_atomic_update
    >>> ENTER: shmob_drm_primary_plane_setup
    shmob-drm fe940000.lcd-controller: [BEFORE] LDSA1R: A=0x00000000
B=0x43a00000  MIRROR=0x00000000

A and B are similar to yours, so OK
Your MIRROR value is truncated, but different from zero!

    shmob-drm fe940000.lcd-controller: [AFTER MIRROR] LDSA1R:
A=0x43a00000  B=0x43a00000  MIRROR=0x43a00000

Your A value is zero!
B is similar to yours, so OK
Your MIRROR value is truncated (I don't trust the final zero)

    shmob-drm fe940000.lcd-controller: [AFTER SWAP] LDSA1R:
A=0x43a00000  B=0x43a00000  MIRROR=0x43a00000

Your A value is zero!
B is similar to yours, so OK
Your MIRROR value is truncated (I don't trust the final zero)


2) Using commit a75cb869a8ccc88b + debug info + fix:

I get:

    shmob-drm: LDCNT2R=0x00000000 (DO=0)
    shmob-drm fe940000.lcd-controller: [BEFORE] LDSA1R: A=0x00000000
B=0x00000000  MIRROR=0x00000000
    shmob-drm: >>> BRANCH: DO = 0 (Direct write path)

Taking the new path

    shmob-drm fe940000.lcd-controller: [AFTER DIRECT WRITE] LDSA1R:
A=0x43a00000  B=0x43a00000  MIRROR=0x43a00000

A is now set, too

    >>> ENTER: shmob_drm_crtc_atomic_enable
    >>> ENTER: shmob_drm_plane_atomic_update
    >>> ENTER: shmob_drm_primary_plane_setup
    shmob-drm: LDCNT2R=0x00000003 (DO=1)
    shmob-drm fe940000.lcd-controller: [BEFORE] LDSA1R: A=0x43a00000
B=0x43a00000  MIRROR=0x43a00000

A is now set, too

    shmob-drm: >>> BRANCH: DO = 1 (Mirror path)
    shmob-drm fe940000.lcd-controller: [AFTER MIRROR] LDSA1R:
A=0x43a00000  B=0x43a00000  MIRROR=0x43a00000
    shmob-drm fe940000.lcd-controller: [AFTER SWAP] LDSA1R:
A=0x43a00000  B=0x43a00000  MIRROR=0x43a00000

End result is the same as before.

Without the fix, I ended up with the correct value for A, while you didn't.
With the fix, we get the same results.

Using your .config, I get the same results as you did.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
