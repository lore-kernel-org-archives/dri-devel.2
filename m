Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D20606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=UQtGOfhN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C3AD10E44E;
	Thu, 29 Oct 2026 17:18:00 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F8A1121FF
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 11:46:49 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-8ac9d666d4eso18392417b3.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 04:46:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793274408; cv=none;
 d=google.com; s=arc-20260327;
 b=qSVeI0knVHh47B4A4uKOqUPVpy9H/X/BMtM3X3G4ScIsnSBYD9CUuoav/cIGGikcHP
 QKvyEESuEoDS0hx6kmmPCP9SVxcDUtVDCkOUd72oTruLn/nDX2kgLVsNE/qwTGDOxGQS
 LOYlktVoj/GvNdzOv/5KrBy7Lg8K22PMSa82fP/c/4/+PIu1ER53nohfsucTg8hLhK94
 s8ldBbQpGHMEISSi2ZGy3CUuNOFZfsfxwlwjM9t23u7Yl/w3B44Fpi/s4HYEEnr16TWk
 Pfgp2w5jJ4BrWDDdNzoEYJNSMR0sC4Y/mxAyyPX+FLAoEOGMoaWtFLotvFfJfySu7Yoc
 mX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=riFBiDySsld/0Y1PSfvBfA5dP3L6lbgdUG897qeFids=;
 fh=o2X+YuKg45y/C/sEYQyxNGTzQHXcR59YfmYqh6Ds/R4=;
 b=JP5n7KrVX1rBgxcwJ9EirLuwcLBIOrLxZi56I/qX8gbcTZB8KTeGQcHkkP8XeqXtNb
 KHRpTralI7qc/O+odCd4vF3r3lrCjzYHlHo9jR6s6/mjGcDUoUIgvoF14vN2nfa5y++N
 cYK6t1ssnrYzmzYo0oz4aiW2Vn+JizKxEccM3BMUN/TD4Jd6Dol9meC/1hk50NhBHbo+
 I4/an4FBQsmyRJzcf/LNDj+CEVPwD/yjxiAXkXl6FK91FZDHqt6WGg//TNU7OK4wdAKQ
 ZSzDwA29druqEcV0QbQZovWDPYYHugMG1WfO+fF9VynLXEVf98RRMVgN8snQY72bicur
 UUeg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=neat.no; s=google; t=1793274408; x=1793879208; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=riFBiDySsld/0Y1PSfvBfA5dP3L6lbgdUG897qeFids=;
 b=UQtGOfhN2QoF5HyZLRGTL7mjpNnozNLC1cL0v0MbUMN9POihc6zYRsg4V1NUzcmrNY
 xxGYbsYKCiyXwy6fQUyLYcePNzNL20/jkfNG2i5CRtq3MRqTCw2T8OO9OOfJJjay7HrE
 ic6Dl9LLKMNAaqpaUbgqEnaMobQDSwcq6SO8qSN70IP357bnFpTsLkhWPDftE4WNiD/V
 u8B95hZL5cJL1GMXoIfMknp0TC+UK69dwPcglJmm5Ab2UHIiAfpTUGV4tSUxvllizkRz
 YXY/c8xA5H1QbaBHohPQTAiJ1IkhxhfbABxDlcJrSaBMqjw0TMqR13+VdTatjd/XQwY/
 0VKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793274408; x=1793879208;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=riFBiDySsld/0Y1PSfvBfA5dP3L6lbgdUG897qeFids=;
 b=QWIOBSs5hHWftk4ccF+JuYGs8sR53GWYxsdK/zmpS0gc3rckeVGS3NqySnAACuVKWU
 oS8qbMw2vfW3OmjroHsJjTWGg+QmihbEVRqpqw1MPK3om5BJnhuv2+4jnbdv77NiAlEs
 SCYo1RHNAjYSHUUCIPDNayJTlG+aqNPRGeb2/UJA3JCW5LM1PxeudVQUy9eEvvKxtJYB
 Ye23bwtzLIfyyf4fkWXL2pwBMAvXN3Elfq9bJCzZ/Jsty/4Cu+v5w/KUgxIHJEpvhE9T
 yb62ths7BaEHptUOY3iNHL9JAOEtqlgiFTM2pDxGmizzeZUuCc4jxPkAus+/dNO/5QDc
 pyfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+eQGUY+g9sY8bhUajZ1ZroRmR1a+5+oIv/Z67i+R6mlO/dh3rqA+VEx52EMubYey8Uxkfr/2wt/Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ8YkAf7VT6LBvbGMHngobvvFQKiqTXh2Awi9F80ZXBR63KZXhx
 i4LgZvuaFb2dRXP+6fcNgJOBcXk6YFUTEIDQ+VNOiMHX9nwEXgV18N3/4tsPVciqgtc+VDD7xsJ
 rLYXwTYqXhYZX9ZRh6XG+5fab3R5B1jU2kGtUUjcGTt1jPC70/0Vr+EaTwfGv1u+wHQEtxCsrjO
 IC/IuNBNYZPWWEg+sWWDdZwFmQpm3HkZtkuK3LCnSNtQxWtUzK8iC5bwzZWNy9X8dT2zPCqgwqI
 z+hOzDwetsv6CXaNhd+5BH4ha/zlS90DOm1TqUNdOOiAY1x24w+LUgDdvREpnsjKH5/8y4Hp3XT
 1A==
X-Gm-Gg: AYBFou2OK7oqhohaDFvHXrrd03BjlXHZOdYWb8+ob3TFKWu7OrHBssKXHRPIP/EsBX7
 s83Lj1DI1f2BE51vVgWTgnmohcfWR5xsFXCx17B8gk73KwdbQ0MtYEvJZ4rRZPJ6yGCbO3o3ytP
 I1EGzLAe7ZTqxUMq7Y1QGX/jL+3c/ZtcHmuBS3+osj3825CbJgfvdR1e779w0P5uqfyb9O1qpui
 d5sZOAm+1Oo3yoUj9OI8KGX8OIDYpalfapcnoxpl5SFXbvlCFJHceSNUew8Sdz+6TOshFW0haeu
 WmAYcYlaPtEucNgdPPkRMlbHWPWlAvgVZTZSPl4DkmzajiRmJK8CYEOhC4Sn6tSS/BZ3DgvaH85
 JKTVYplHghpiYjDJ9qHzyZzdOzk3WR5e5bZeSQbgHvYxu5nFbQWmkyHqA
X-Received: by 2002:a05:690c:ec3:b0:8b1:9c2:87d2 with SMTP id
 00721157ae682-8b1b5c83536mr37789387b3.73.1793274407861; Thu, 29 Oct 2026
 04:46:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026164028.78792-1-lucas.tanure@neat.no>
 <at_4EgWZFghkRHzH@collabws.localdomain>
 <a8b9450f-af4b-47bf-b7b1-3b326ed52dfc@igalia.com>
 <CALt7t=Ef9LS5vNOZq7JGZ1n-L5rgMk7mXBGE66jicfdkqAC35g@mail.gmail.com>
 <a054e9e4-304a-427c-b78f-973fd06f1199@igalia.com>
 <f534555a-b62f-4bf9-96cf-ebd74b4b30f0@collabora.com>
In-Reply-To: <f534555a-b62f-4bf9-96cf-ebd74b4b30f0@collabora.com>
From: Lucas Tanure <lucas.tanure@neat.no>
Date: Thu, 29 Oct 2026 11:46:35 +0000
X-Gm-Features: AclHuK8RskCuC8Hdfkuek5FOUrJUlV6Oh_eeADhyjfk2iiUYXH6Ab5jF-a3wR7k
Message-ID: <CALt7t=GBa=9G-qGfTLohrcJaNApE_=Pc3TMD0jjTOiDevOP-kQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] drm/vc4: hdmi: enable scrambling before the TMDS
 clock starts
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dom Cobley <popcornmix@gmail.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 29 Oct 2026 17:17:59 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 8:19=E2=80=AFPM Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> Hi Ma=C3=ADra, Lucas,
>
> On 10/27/26 3:58 PM, Ma=C3=ADra Canal wrote:
> > Hi Lucas,
> >
> > On 27/10/26 10:53, Lucas Tanure wrote:
> >> On Tue, Oct 27, 2026 at 1:07=E2=80=AFPM Ma=C3=ADra Canal <mcanal@igali=
a.com> wrote:
> >>>
> >>> Hi Cristian,
> >>>
> >>> On 26/10/26 22:23, Cristian Ciocaltea wrote:
> >>>> Hi Lucas,
> >>>>
> >>>> On 2026/10/26, Lucas Tanure wrote:
> >>>>> HDMI 2.0 asks the source to set TMDS_Bit_Clock_Ratio in the sink wh=
ile
> >>>>> the TMDS clock is stopped and to start the clock at least 1 ms late=
r.
> >>>>> vc4 writes the bit, and enables the scrambler, at the end of the en=
able
> >>>>> sequence, long after the PHY has started, and clears it before the =
PHY
> >>>>> stops. A sink that samples the bit when the clock appears never loc=
ks
> >>>>> a 4K60 signal from a Raspberry Pi 5, while laptops that follow the
> >>>>> order work on the same sink.
> >>>>>
> >>>>> Patch 3 is the fix. Patch 1 is needed on BCM2712, where phy_disable=
()
> >>>>> was an empty stub upstream, so the PHY kept running after disable; =
the
> >>>>> Raspberry Pi tree has carried this since 2024. Patch 2 fixes a
> >>>>> pre-existing race in the scrambling work cancel that the fix would
> >>>>> otherwise make easier to hit.
> >>>>>
> >>>>> v1 was tested on a Raspberry Pi 5 running the Raspberry Pi 6.18 ker=
nel
> >>>>> with the same change applied, against the sink that showed the
> >>>>> problem: plain enable at 4K60, 1080p60 to 4K60, 4K30 to 4K60, a sin=
k
> >>>>> reset and a sink power cycle all lock with zero character errors. v=
2
> >>>>> and v3 carry the same code; the hardware test of the final form is
> >>>>> still pending and will be reported in this thread. Mainline was not
> >>>>> booted on the Pi 5. The BCM2711 path is unchanged except for the
> >>>>> enable order; I have no Pi 4 at hand.
> >>>>
> >>>> While converting vc4 to the common HDMI 2.0 scrambling infrastructur=
e, I
> >>>> ran several tests on the Raspberry Pi 5 and didn't notice any (obvio=
us)
> >>>> issues.
> >>>>
> >>>> Hence, could you please verify whether your problem reproduces with =
a
> >>>> recent mainline kernel?  If it does, could you also give [1] a try a=
nd
> >>>> report back the actual behavior?
> >>>>
> >>>
> >>> I suspect you didn't hit this on mainline because vc6_hdmi_phy_disabl=
e()
> >>> is a stub, so the TMDS clock never stops between disable and enable.
> >>>
> >>> Best regards,
> >>> - Ma=C3=ADra
> >>>
> >>>> [1] https://protect.checkpoint.com/v2/r02/___https://lore.kernel.org=
/lkml/20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com/___.YzJlOm=
5lYXQ6YzpnOmQ1ODUyMWJlOGIwNzJjNjNmOWRiMDk3ZmFmYWFkNDliOjc6YTM1MTpiMzBiNzY3O=
DAyMzBkOGM2M2U0ZjRjMTY2MzE5ZjVhZWZjY2QxYmRjZDBlOWI4MzI0MGYxMjkyNjQ1Y2NkNzJi=
OnA6VDpG
> >>>>
> >>>> Regards,
> >>>> Cristian
> >>>
> >>>
> >> Hi Cristian, Ma=C3=ADra,
> >>
> >> Tested on a Raspberry Pi 5 with the Raspberry Pi 7.3 tree [1] as base
> >> (pure mainline panics at boot on this board).
>
> I recall encountering this issue a while ago and spent significant time
> bisecting.  The faulty commit was d87773de9efe1
> ("clocksource/drivers/arm_arch_timer: Default to EL2 virtual timer when r=
unning
> VHE"), introduced in v7.2-rc1.  Reverting it restored the normal boot.
>
> Note this was later addressed via commit 94f39e4c017e
> ("clocksource/drivers/arm_arch_timer: Workaround bcm2712 broken EL2 virtu=
al
> timer"), part of the v7.2 kernel release.
>
> Which is the mainline version you've tried?

Master at 6b4b543fa187 ("Merge tag 'parisc-for-7.4-rc1'",
v7.3-16411-g6b4b543fa187), so 94f39e4c017e is already in. The panic is
something else. I had no serial console on that boot, so I have no logs.

>
> >> That tree carries
> >> vc6_hdmi_phy_disable() implemented, so the clock does stop on disable.
> >>
> >> 1. plain rpi-7.3.y: 4K60 never locks.
> >> 2. 7.3 + my patches: all lock.
> >> 3. 7.3 + the 7.4 scrambling infrastructure + Cristian's 9 patches: sam=
e
> >>     failures as in 1.
> >> 4. same as 3 + drm_connector_hdmi_enable_scrambling() moved before
> >>     phy_init() and drm_connector_hdmi_disable_scrambling() after
> >>     phy_disable(): all lock, zero errors, picture on the panel.
>
> Thanks for testing all this.
>
> >> Ma=C3=ADra, I also tried 3 with vc6_hdmi_phy_disable() emptied again, =
as on
> >> mainline: same failures as in 1. So the stub is not what hides this.
> >> Cristian did not see it because his sink re-evaluates
> >> TMDS_Bit_Clock_Ratio after the clock is running and forgives the late
> >> write, as most TVs do. Ours samples the bit when the clock first
> >> appears and never again. So to reproduce the issue you need a strict
> >> HDMI input.
>
> Yeah, that's probably why this issue went unnoticed - most displays are p=
retty
> tolerant and don't require 100% spec conformance.
>
> >>
> >> Happy to send a v4 on top of Cristian's series, with the two helper
> >> calls moved and patch 2 dropped since the common helper already cancel=
s
> >> synchronously, if that is the preferred order.
> >>
> >
> > As your patches are fixes, I'd prefer to push them to drm-misc-fixes an=
d
> > then Cristian's would rebase on top of your patches, as their patches
> > will go to drm-misc-next.
> >
> > Are you okay with this plan, Cristian?
>
> Yes, but sadly I will not be able to reproduce the issue and confirm my r=
ebase
> will not regress.  Hence I'd appreciate if Lucas could recheck this after=
 I send
> that series out.

Sure, CC me.
>
> Also, Ma=C3=ADra, could you please let me know when you apply the fixes?
>
> I guess I then need to wait for drm-misc-fixes to get merged into drm-mis=
c-next
> before I can proceed with the rebase.
>
> Kind regards,
> Cristian
Lucas
