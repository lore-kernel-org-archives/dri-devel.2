Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E8C606A322
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=neat.no header.i=@neat.no header.a=rsa-sha256 header.s=google header.b=kVR2A30O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB3B3112037;
	Thu, 29 Oct 2026 07:58:57 +0000 (UTC)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E7F10F55A
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:53:13 +0000 (UTC)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-679a2297c55so4972097d50.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793109192; cv=none;
 d=google.com; s=arc-20260327;
 b=ZgTYhMVzFofYy07EyTlKRN1oQi4p6VB76cdl3Ya/JkFPD639DMpKNhnKXsHxcTh+Jz
 yf4ovNWAvRQ5Zx/8GT6CJUCbA32r8v584PCf1NFcMm/klIQmtyjGMkYviJh2UvKF7hQ7
 /R50OG2/gTL9tCv+jiklYnqpV08/JqXU7MDEEqJUflOlq106NBiaLvRv08RuO5zdx6BT
 cQSNFy+O2E+qwJ90u6r2nswHNHIXaQ7Jx1nZiM/Uv8BwVMopqJ/ZYwhGt/EzjZmns8vI
 pb/h4zrBbb4NEG9NLqw2ZREMba43Lhu/caiC4u25uxej6f2nSG79jipo1WDB1jy6kfql
 pgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=C/QHwPFaYMgxwOdflsCg2rHPFq6Z1Jx6heGTIKTaV+Y=;
 fh=pkXQ5unmuMCr4N21m4RSlNryCOzT33bYWiB2d25e8jw=;
 b=OZCc/oti/00dN7P07S3faBdMQSDNHCQ9xsD8Rrj/1re/4N39th9HQje4k09lGNljPf
 kI67KV/rdz697br1v7FBE6tLyrw66CQ9/DFKCkZH6uqbupi8awwk/Q74Bo+Mw8Yauyow
 T744fBQMLu9b+ObttwZTS1dqxmIJJsQXZ/vtavwzWSxSRopHVTldYTwzJ48jHB/I8UdM
 Eu8cA1NhLy8+rQGE88RR1j/JWfABvsWaa7J/Qt1YcwuTXGtSTYKMLlBXSZ7RquohPoOQ
 okr82wVWJ0T6AUBY+XnPNK57WEKLKx4i34G26OgrNS/UXCeopnEZtlb87v3MebcV4u91
 re3g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=neat.no; s=google; t=1793109192; x=1793713992; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C/QHwPFaYMgxwOdflsCg2rHPFq6Z1Jx6heGTIKTaV+Y=;
 b=kVR2A30O7DTzC0CNJMFExJtQGDLSfE/nVkFwMetNrVqU2pSI43xgp5rHgYLAQL3FJb
 PGbuoF5lsxPK0b1rwbRRIGKkWlIKtRgqRtoiyZWO09/aOXeMl4cpcIvVenH/1VDaL/GL
 YbYCzu5Ae3wQe8oBxUIU3IJ5TMFMHX9DqLZKoD0wahYiXTIqevSEONQ7Pmy6YxCJY/6U
 Ypi0vo3VKP6RHp7Y4VJIwCpfUxHR7nIFKkTpd6XE97bHNuylAYOc/Rb6dJvl9dd76eRg
 sZOwL2KyDXwefVoBXOnsGl9sZZl72FY2Z/uTzl2vIFjxwr8nhgNfPApGSJ3hpAlD2X1L
 KyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109192; x=1793713992;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C/QHwPFaYMgxwOdflsCg2rHPFq6Z1Jx6heGTIKTaV+Y=;
 b=YQzLeZHO6Y6l029YIFEf7USXs1zzrqpXEfqVYc5ZREvHS7lNeTAs2aoc4EouIQCLPq
 r7SwPb/UmMPuugiVuBtsPEOiHnDPwagg54U8c24io7NpZBfEzqGvM7XCm5TUWBlfR+FS
 TZSs3xuqg892WIdWcODCidcjq4QT9I5M5GtE7tdwlu2zh3r5XEhfIcJYaY8GdYYRSMyv
 WbqXmVuHTyjPnwzFe6Nz+ukRR4hnlsxZesBiS3T4uV0QAKgbarlzzEVQR+iA1fYJZibO
 uOCBnXXSfjrD3BZVGllXrEJSFujPKJm1dTQTdOqME9rt+kVtNSbn9bt29jnPxH9r5p2X
 0EgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBiUqr7BEGtlAcWqclGg9q6F9kZAcohGf/DcOz8jbOSA2VK0Ze85M6GJHAiki10VjeYWLSwNCQj2A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKqsvIN0j60EJgXdIZ1MxRKJhOreayhwMHggETuMfnjldQLijCw
 M3OUXm0S43PFKsE3QoeBvpdBokklbfKSo2o12yjwq875DSJ+oVQCNI9Z/zsLtWn65yRKUMlkCws
 c/gORkqYk3aAGFN8xHiHJYAoVKEBnMhepu6zRXHpXJGCXhHWcENOmv9RnMBMcskJLNefywjakW4
 haEfXOkT9yJz1O39MWYcLYmRs2tZBFM2BpIh53yg+vYN3CNzQnyWJMUXFeG5gzA2A9S5A9OgnNH
 PwWN0NkWGb93doGsUYSyezx0N3N6o3hMx+R/N59oewuAvTtU3ExVr5hnW+HQzTZbPn6ApGxSAXN
 wA==
X-Gm-Gg: AYBFou2QYBx1XZB2SXnBv12GSvA1XUAg/JuddNTIXtoZ6AsQ6VhGhmJXD66Ys3aSK7c
 zudOd4G4pjYmd8mong4q5W338YbecbYbTOI7B+BnAYXS/1YoSL+3GP4dD/0fUUOLacgdk7GC49a
 M9SuliEfke0wyVcNLXYaNoRueRs2FV6FY8vjkTvbtHhnj89SNTqjlr7Oo8JRE9dZ6FBp6jxN1BT
 WAG+XN9YiQ1+z6E2wcMMOOEgaGJF8WOILBfEJB4XEyDcRoNxW7NyQmHsh0Fci20LS3iAeYpfygq
 lSsh8/dUrR+1E4tG1barLJEDPpU4tgUsP7qj2X3T2JiaJ3Cnz2CAKsUfGQv6D7GScwKbLcbPrBX
 CmJRexF/3zxKGkT+ovhvPzbUmYNseK4ZNoXrCJL1d/3v0VRnNEx2eK69I
X-Received: by 2002:a05:690e:1905:b0:675:6228:2fdd with SMTP id
 956f58d0204a3-67a45193dcdmr8073792d50.4.1793109192290; Tue, 27 Oct 2026
 06:53:12 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026164028.78792-1-lucas.tanure@neat.no>
 <at_4EgWZFghkRHzH@collabws.localdomain>
 <a8b9450f-af4b-47bf-b7b1-3b326ed52dfc@igalia.com>
In-Reply-To: <a8b9450f-af4b-47bf-b7b1-3b326ed52dfc@igalia.com>
From: Lucas Tanure <lucas.tanure@neat.no>
Date: Tue, 27 Oct 2026 13:53:01 +0000
X-Gm-Features: AclHuK_nxwMrSebAhzH6BzwzfF__ms2hub9Qe_tDk-dxbFBTVEwwSaw33DD8X-Y
Message-ID: <CALt7t=Ef9LS5vNOZq7JGZ1n-L5rgMk7mXBGE66jicfdkqAC35g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] drm/vc4: hdmi: enable scrambling before the TMDS
 clock starts
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
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
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 1:07=E2=80=AFPM Ma=C3=ADra Canal <mcanal@igalia.com=
> wrote:
>
> Hi Cristian,
>
> On 26/10/26 22:23, Cristian Ciocaltea wrote:
> > Hi Lucas,
> >
> > On 2026/10/26, Lucas Tanure wrote:
> >> HDMI 2.0 asks the source to set TMDS_Bit_Clock_Ratio in the sink while
> >> the TMDS clock is stopped and to start the clock at least 1 ms later.
> >> vc4 writes the bit, and enables the scrambler, at the end of the enabl=
e
> >> sequence, long after the PHY has started, and clears it before the PHY
> >> stops. A sink that samples the bit when the clock appears never locks
> >> a 4K60 signal from a Raspberry Pi 5, while laptops that follow the
> >> order work on the same sink.
> >>
> >> Patch 3 is the fix. Patch 1 is needed on BCM2712, where phy_disable()
> >> was an empty stub upstream, so the PHY kept running after disable; the
> >> Raspberry Pi tree has carried this since 2024. Patch 2 fixes a
> >> pre-existing race in the scrambling work cancel that the fix would
> >> otherwise make easier to hit.
> >>
> >> v1 was tested on a Raspberry Pi 5 running the Raspberry Pi 6.18 kernel
> >> with the same change applied, against the sink that showed the
> >> problem: plain enable at 4K60, 1080p60 to 4K60, 4K30 to 4K60, a sink
> >> reset and a sink power cycle all lock with zero character errors. v2
> >> and v3 carry the same code; the hardware test of the final form is
> >> still pending and will be reported in this thread. Mainline was not
> >> booted on the Pi 5. The BCM2711 path is unchanged except for the
> >> enable order; I have no Pi 4 at hand.
> >
> > While converting vc4 to the common HDMI 2.0 scrambling infrastructure, =
I
> > ran several tests on the Raspberry Pi 5 and didn't notice any (obvious)
> > issues.
> >
> > Hence, could you please verify whether your problem reproduces with a
> > recent mainline kernel?  If it does, could you also give [1] a try and
> > report back the actual behavior?
> >
>
> I suspect you didn't hit this on mainline because vc6_hdmi_phy_disable()
> is a stub, so the TMDS clock never stops between disable and enable.
>
> Best regards,
> - Ma=C3=ADra
>
> > [1] https://protect.checkpoint.com/v2/r02/___https://lore.kernel.org/lk=
ml/20261014-vc4-common-scramb-v3-0-c68d58d959a2@collabora.com/___.YzJlOm5lY=
XQ6YzpnOmQ1ODUyMWJlOGIwNzJjNjNmOWRiMDk3ZmFmYWFkNDliOjc6YTM1MTpiMzBiNzY3ODAy=
MzBkOGM2M2U0ZjRjMTY2MzE5ZjVhZWZjY2QxYmRjZDBlOWI4MzI0MGYxMjkyNjQ1Y2NkNzJiOnA=
6VDpG
> >
> > Regards,
> > Cristian
>
>
Hi Cristian, Ma=C3=ADra,

Tested on a Raspberry Pi 5 with the Raspberry Pi 7.3 tree [1] as base
(pure mainline panics at boot on this board). That tree carries
vc6_hdmi_phy_disable() implemented, so the clock does stop on disable.

1. plain rpi-7.3.y: 4K60 never locks.
2. 7.3 + my patches: all lock.
3. 7.3 + the 7.4 scrambling infrastructure + Cristian's 9 patches: same
   failures as in 1.
4. same as 3 + drm_connector_hdmi_enable_scrambling() moved before
   phy_init() and drm_connector_hdmi_disable_scrambling() after
   phy_disable(): all lock, zero errors, picture on the panel.

Ma=C3=ADra, I also tried 3 with vc6_hdmi_phy_disable() emptied again, as on
mainline: same failures as in 1. So the stub is not what hides this.
Cristian did not see it because his sink re-evaluates
TMDS_Bit_Clock_Ratio after the clock is running and forgives the late
write, as most TVs do. Ours samples the bit when the clock first
appears and never again. So to reproduce the issue you need a strict
HDMI input.

Happy to send a v4 on top of Cristian's series, with the two helper
calls moved and patch 2 dropped since the common helper already cancels
synchronously, if that is the preferred order.

[1] https://github.com/raspberrypi/linux/tree/rpi-7.3.y

Thanks,
Lucas Tanure
