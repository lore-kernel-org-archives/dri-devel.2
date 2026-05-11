Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3DFCD37AC
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 14:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 124C210E7B5;
	Mon, 11 May 2026 14:43:46 +0000 (UTC)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com
 [209.85.221.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DC6C10E7B5
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 14:43:45 +0000 (UTC)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-57513ac61f0so1278149e0c.3
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 07:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778510624; x=1779115424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=st99TRUJvP9iusm7HufBndg1A/dlmXWO+RvQR75PMEA=;
 b=tHr6IPY9+LfJa2IQluYWwQW1K5mdsaB0/8a/VYbDGzvgd3qWtNIz+41+GfQKV5haD6
 RAl/Lxs9+kX51+ISchjZooeYj9AATpEpYYYqvfR3GiTch7PsNNGAluFKPGjsQVH0WlGY
 BPWDix9czAQgmJY2GPh2OIhIeaDe7soJWJi0jE+QlIFXlzxeoEAFkV1pck2bsrCkS1lQ
 2hvQH3XgngbO3tPSkFhIhnOsFsNhIjZwqK+kQgcnllHXGAWcOsqAVWbRvMG/QWasgNHs
 ximYIDIRB+YUPoJSzRG+KfarY20wpau+X7MxRR72ybyPNG58GocPjlt3k0ohJknl66Lj
 qkJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8TawvgBL/vAIi3cT1XoI+qYFh5MuSBKTSwnY7bq+/WUhC5fPWWLWAOyxrO+5QMnoNB3H2M6DMgjaU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvJIbvXJL1n3IJmifNVME477O+P0oOT2KK2rw9WnUmnMFfQnS2
 ij5DFl+pmhDsFZsnmsSqd1EzcIt/FaMZWfkS+Vm+G6PV2mw1vYORiv0+Ivy1mpIj
X-Gm-Gg: Acq92OH7MgvJ88ch3IcsOKOr8wyZG60HCmQ4szBX7GCsStrpQ3WgTZyn+b9nm4pRwNh
 FXpVjY8UJzzNJ7RroVx5h5rhSp5EamAEPe5GxBi0bNgnmMthgXVlXowu6S8uC4dNgnSThyiY06q
 buIZgRmk3SlFK+j9w+EYjCKfoBjLN14bLjMaRtDgXxAw8SKXIxrLeQYOFUTmoK9Lu9cWvEL8fBD
 7Zgw59zGRXJ1m9GL/uH2OA/Z+a4ZyYwyT/ToU3u+HDDdtP2JnfDP04sDJtP1DnU6o+Kp8wmfxsd
 xvEkJDGckNg4uPUVzWHlWqM7oidv0tGQ1d1uGfa62im5BeJcEzBMD5ZoPCwdfm12eawcIlJSxCc
 jF8NPSQmUb4UGMAB99lqTETaY2dkB4aIq90NAZomDaga2lMOvJ7gDVOb9gDVEYJVVXTu7gcI0aG
 QpLg4P7iH22Yk2yYtmPQd6/2D3xZeXFDOloIkRxht22A+gsOH1dob2LGoOABzj
X-Received: by 2002:a05:6122:d28:b0:56f:1c32:bd07 with SMTP id
 71dfb90a1353d-57599081e26mr4089717e0c.2.1778510623893; 
 Mon, 11 May 2026 07:43:43 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com.
 [209.85.222.53]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-575869f2d08sm6644044e0c.0.2026.05.11.07.43.41
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 07:43:41 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id
 a1e0cc1a2514c-956995b5bb6so1222654241.3
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 07:43:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9Tgq4Mq5/6bTvukCinR1TxzpIWzHNSP/b3RhGbYkIKW0r0LKeZ7n5mzlha3W1aIkmx7bXItE8fpcU=@lists.freedesktop.org
X-Received: by 2002:a05:6102:8553:20b0:632:3bd:65ad with SMTP id
 ada2fe7eead31-63203bd6cdamr2502747137.3.1778510621097; Mon, 11 May 2026
 07:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <caf5e011a5b3fbdbab8c50d064bc8342212d5cc1.1778505897.git.geert+renesas@glider.be>
 <f46eff18-4a5c-4c25-a0b7-71cdbd444014@imgtec.com>
In-Reply-To: <f46eff18-4a5c-4c25-a0b7-71cdbd444014@imgtec.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 May 2026 16:43:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW_YbjCfhe=Uf+fPjCiwf6272aNHaOjd8B1HUrkeLJrvA@mail.gmail.com>
X-Gm-Features: AVHnY4K1p3Sxqu1LsvDjBrECNKZ4-7U0HiQ3AWU71iqzjSPovIWm8-sLEWk57G4
Message-ID: <CAMuHMdW_YbjCfhe=Uf+fPjCiwf6272aNHaOjd8B1HUrkeLJrvA@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/imagination: Warn or error on unsupported
 hardware"
To: Matt Coster <Matt.Coster@imgtec.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Adam Ford <aford173@gmail.com>, Frank Binns <Frank.Binns@imgtec.com>, 
 Alessio Belle <Alessio.Belle@imgtec.com>,
 Brajesh Gupta <Brajesh.Gupta@imgtec.com>, 
 Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 Luigi Santivetti <Luigi.Santivetti@imgtec.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Hi Matt,

On Mon, 11 May 2026 at 16:06, Matt Coster <Matt.Coster@imgtec.com> wrote:
> On 11/05/2026 14:28, Geert Uytterhoeven wrote:
> > Revert commit 1c21f240fbc1e47b94e68abfa2da2c01ed29a74d, as it stopped
> > the driver from working on various Renesas R-Car SoCs.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > DT binding documentation updates were reviewed by the drm/imagination
> > maintainers[1][2][3], DTS additions were reviewed and/or acked by the
> > drm/imagination maintainers[4][5][6], and firmware is available[7].
> > Note that the GPU nodes were not enabled in board DTS files before, as
> > not having suitable firmware installed under /lib/firmware could trigger
> > a crash, not directly related to drm/imagination driver support.  This
> > was fixed only recently in v7.1-rc3[8], so board enablement[9] is now
> > unblocked.
>
> We will freely acknowledge that the sequencing was not ideal here. This
> patch should probably have been sent before we started accepting DTS
> changes for those Renesas platforms. However, the purpose of this patch
> still stands.
>
> We're not saying we never want to list all these platforms as
> "supported", but we don't want to mislead anyone into thinking the GPU
> on these platforms will function in any meaningful way just because they
> now have DTS nodes. We were originally convinved to allow these DTS
> nodes to be added since it would facilitate active development on these
> platforms, but this does not mean that we as a team have the bandwidth
> to do that work ourselves at this time.
>
> Our main concern is around the UAPI: we don't know for sure that support
> for these platforms (which are significantly older than anything we
> currently support) can be correctly implemented without UAPI changes. To
> that end, we don't want to back ourselves into a corner where the UAPI
> cannot be updated at a later date.

Automotive life cycles are long...

> There's a similar mechanism in place in userspace: the user must set an
> environment variable (PVR_I_WANT_A_BROKEN_VULKAN_DRIVER) to use
> platforms for which we don't promise API conformance, but just like in
> the kernel, this is not a compile time option and any user and/or
> developer can enable it if they know what they're doing.
>
> As for "it stopped the driver from working", no it didn't. The driver
> never really worked on those platforms, at least not in any useful way,
> and certainly not sufficiently for any non-developer user to benefit in
> any way from it. The only change is that the user must now acknowledge
> that this is the case to clarify that they shouldn't expect much (if
> anything) to work. Just to be explicit, "firmware boots" is a loooooong
> way from "ooh pretty triangles".

AFAIK, it's working better than just "pretty triangles", e.g. glxgears.
And people are working on support for more SoCs (both newer and older),
for which patches (both Linux kernel and MESA) have been posted...

https://gitlab.freedesktop.org/imagination/linux-firmware/-/work_items/13

> Would you prefer a different approach to providing this information to
> users, perhaps a purely docs-based solution? I'm not convinced that
> would be as effective at preserving our ability to mutate the UAPI for
> these as-yet-unsupported platforms.

One can wonder if it's the kernel's job to block the use of this
hardware by default?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
