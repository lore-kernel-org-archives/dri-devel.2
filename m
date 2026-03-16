Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B036BF506CB
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 13:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C23810E07F;
	Mon, 16 Mar 2026 13:14:49 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
 [209.85.217.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81B0D10E07F
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 13:14:48 +0000 (UTC)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-5ffd76e4c89so802406137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 06:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773666887; x=1774271687;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+36MhJBSl35eE6xuK7IokZVVTyDXo3UUbxp5wEXrbos=;
 b=nM0F8klIntFynnzuKYptq/gUHKQ6D7Xr9b+AsmW1Ob78tdMmMBYXjXKimjlO/zOjQk
 5t9oCBA9CstKCZAX5u8sKptekvhUxuad8EWIDn/48LYcU1cCkUrXGZTIX0yAK3eNou90
 pyFRTKX1RBFslK+U5kNLVpNxKRDAhyAUdmQVdO177GjYeBuy2230Vz/hEO01t8aIaKOp
 8wtRWzSNh/LZRCO84KX89uUKOR2IfDB2eF09ASeY1AdKl/en8CA1Nscxxy97t60OSIhY
 NBlf4lQNoZxM7GpXKRvgByx8pQ+3sevO9+IYyyWKkUxqdUMgt0TAlzZkVJCEteWgeo0w
 ZrJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzlNLUVtLksiQb/Pfqi0wXcPH8o9wIqKV9kXej+Xb2N5TFDjQ42mQtvY2yXFjcDj6j4IgE0RuqA5o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzluM9P/pE3/XI+tTflS/kmJap3jtEZsMxRIv8WhdtdTGXnnST
 JI5PPLRgqxtypBYYWFFulrcQXjENgM7zCEOeCF4Mpxtonln/iUXsufqRa7tar7Ck
X-Gm-Gg: ATEYQzzPIGfpivxL6EOJ/jmNzjnUWqgeNSkxiYe8HFLw8dqZBB+c3DP3WHl023sq7h3
 4cKgXIEfLkYvvGSqlRm5XfWwDDVokFDnMlI3R1ZNoYiNTjqzHjOXeVIjsegHH0ieKXb5LAMG4Ab
 PEa5FBEyCliEYoEOe43W+BtYyUqxUBy9v6LhSLeq/Y1lZog5Iiypx80DF5NJL5ZzDTC1mmG/87P
 QOvu6137rmggaEuATJRUoB9kkhPb8Rp7XSKIXh/WI4VaWkRTP7mWqPjPycYLzQ2BiXTMHijgzxR
 zk79AcFCOAFKp1b/Yh9kKxoSjvCHaOebJp7PeEmrqaKM9ebdg6Wb4dxIycroblp+dRAhQAaE50k
 SF/eAiCHCM+088ssLItJrQsASdCzCm2j81MPeepeKMlOIEPk+WBaK5LzX02tXqDEX1PBdbahUSm
 7pOq/zEIAJVBXtyENhvkE8w8JaYE0i+FXQ00rWeh6Ie5chsrhaMXVE8qRQgkdSF4VJ6ZY4s60=
X-Received: by 2002:a05:6102:c50:b0:5ff:1e61:b303 with SMTP id
 ada2fe7eead31-6020e2824e5mr3985990137.17.1773666886573; 
 Mon, 16 Mar 2026 06:14:46 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com.
 [209.85.222.48]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-94ecfc4e9bdsm5753729241.1.2026.03.16.06.14.45
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 06:14:45 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id
 a1e0cc1a2514c-950d235b500so270203241.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 06:14:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUryp/muGZ2fKSdayVKEFAyHugttiApTEC4fZvYPSZ/dI/9mtMXB2im45cPOQz3n22Tg6wB2LoJYUk=@lists.freedesktop.org
X-Received: by 2002:a05:6102:4192:b0:5ff:1cc2:aa94 with SMTP id
 ada2fe7eead31-6020e4d0d32mr4644483137.26.1773666884844; Mon, 16 Mar 2026
 06:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdXJQmfU0p=yk1kROTm=ZiiQoUHZQpw5kj813x=RWCS1fg@mail.gmail.com>
 <20260316112540.8636-1-phucduc.bui@gmail.com>
In-Reply-To: <20260316112540.8636-1-phucduc.bui@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Mar 2026 14:14:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUBwNtdhZYnA3+nwe-CEmrUdPu_K7923uMY5qi9edbkbg@mail.gmail.com>
X-Gm-Features: AaiRm51t8uL0ZGlIo9FRuR1UhJ93R9SWSZBixMMZfa7Gkr4ku4NExUwiqJiqfiA
Message-ID: <CAMuHMdUBwNtdhZYnA3+nwe-CEmrUdPu_K7923uMY5qi9edbkbg@mail.gmail.com>
Subject: Re: [PATCH v2] drm: shmobile: Fix blank screen after resume when LCDC
 is stopped
To: phucduc.bui@gmail.com
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, 
 laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de, 
 wsa+renesas@sang-engineering.com
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

Hi Phuc,

On Mon, 16 Mar 2026 at 12:25, <phucduc.bui@gmail.com> wrote:
> > TL;DR it depends on kernel config.
> > With my .config, your patch is not needed (but it doesn't hurt).
> > With your .config, your patch is needed.
> > Unfortunately I haven't found yet which config options causes this.
> > I will send you my .config by personal email.
>
> Thank you for sharing your configuration file. I noticed there are
> numerous differences between our configurations. After further
> investigation, I narrowed down the main cause to the following debug
> options:
>
> CONFIG_PROVE_LOCKING=n
>
> CONFIG_DEBUG_LOCK_ALLOC=n
>
> CONFIG_DEBUG_RT_MUTEXES=n
>
> CONFIG_DEBUG_SPINLOCK=n
>
> CONFIG_DEBUG_MUTEXES=n
>
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=n
>
> CONFIG_DEBUG_RWSEMS=n
>
> CONFIG_DEBUG_LOCKING_API_SELFTESTS=n
>
> CONFIG_LOCK_STAT=n
>
> CONFIG_DEBUG_ATOMIC_SLEEP=n
>
>
> These options are enabled in your configuration but disabled in mine.
> Enabling these debug features introduces additional overhead, which
> slows down the resume process. This delay unintentionally provides
> enough time for the hardware to generate the Frame End interrupt,
> effectively masking the issue on your system.

Thank you, that explains the difference!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
