Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003DA606A321
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ecfe/3SR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64A8010E55B;
	Sat, 28 Nov 2026 09:41:02 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D254410E11E
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 03:27:16 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8b67f25e6e1so4269853b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:27:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795836436; cv=none;
 d=google.com; s=arc-20260327;
 b=BV1g+/tVeIUAk4kXreZ0JI0lN1VByi5tgrsO3WDYYiI8b7xXTTEZzka/p47nKQWIyp
 DQNRR7uDZHo9FfKQgOc/ECW6SBalOdX++2RR54rsMmSY8IgfQZKcioWZFeeHzLuA76QT
 zhcG/x0R0FbKss2cmxNLcuqKOorTpshitIuQwm4WP4tz5VdOb2ctsFPKvmlpl6Qyunqo
 38mLnxa1/PXQU45ovyx1sn8OZ1tkm708dUQ0EfpiuELCct5XpIr9DG6ea/5TJbIexgoQ
 RC9zrKTQxHu9mN0M9KDzCg/c03k1xehNVP/X/vRAxlKg4T33nXeKfLZs9vrMTQ0ESYxG
 EqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vBHWdp137VAn7lA9+DpI0GObYR6F1NE7+wrNWZtHzuM=;
 fh=rzWVVC5eWIydkilLa4gJVEsC+cjFXSi5TuN6j91B14A=;
 b=HeqmjIowp3krcgLj7q/gj0WN5m457X+c6Q3ECGs9U6GW/6XfR4AC0hGVVgTcd7Rxw5
 xfFDM9ARD1B01zTghS6nL5DQTtQTuJXKH80Fg68blHybjafftgBRkpqM6oRJ6SCaCm2u
 NgaP2rIVOVlyBSD9x43mBRtWwsNUWQuiIuvgokkFKDZw49po/lEDcdOZRcAPU8lqP7Z9
 dNlOTQnXIbXMe4McOniiX/+ban7tcydoqZ33GdNusp3arENYkaFV866fJ1IHB/OJ8Igs
 XiCBV6d8s58DuVyg6USLzOPObuuZKLaQ55vvbosRRcZuPLgsDnEgDRjUviOWWHFfhLrN
 XOEQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795836436; x=1796441236; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vBHWdp137VAn7lA9+DpI0GObYR6F1NE7+wrNWZtHzuM=;
 b=Ecfe/3SRcfuEbNkx0YvOAu/7kT5n5O3asQfOCGzPzTZhiw/m+I8/m7PYPW/AeHKAfC
 ucg/BiBaI0AriQtz2g3uP4P9ftbUQwZDNVWl9/vzb7X3+5KGvI1AGTtJE152QoVV8uQ1
 Aqjthz/hznF/pmT6oAfcuKQLpRpqAZwkRjKHZS9naFi4jzURulDN/inF26WsfDRkP/fr
 egSyOCQaSktYjN78O0BSYmFnk8kuvT40R8+REcDyvA3pJ7My2zOqaTkGYdFGPf2Jo+ug
 qbkn6CdK9RpdEGX2yz/XdXTwYgVkQSo+3dEHVvPAprmEtCNifd3eRyvoAXjC93zSYQ/I
 n3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795836436; x=1796441236;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vBHWdp137VAn7lA9+DpI0GObYR6F1NE7+wrNWZtHzuM=;
 b=VEbcW+G9wtg9j0yDDOczDfXkM0+PEKpsdYCsOoSPxOzhECqUxAOn4qhhiVsREkGQ71
 rSfuVpwASgh75aaJPGnptuMdmIxnkx2w7AORi0NQokG2F8NwXX+zyQshiBvsYy0yZdkk
 q/uqMPKBnMt78AZlRJY7uilUTb8r4Pfqq3PNCIhfBzsBOSU/fupbJRNY0D97u6eY1rn3
 Jdlfxh8fBYJXg/Vi5JyqcxEpaZn+ZRfA/i8guUuanfrCbRtFXd+vYwQg4G06V9eejezP
 lGlsOf8yi4TZzpBL799T5AYQewQUF3Ypjt767MTgJXgA5wUAcEx5RDi49F9M05c1AoPZ
 6SSw==
X-Forwarded-Encrypted: i=1;
 AL+hErF14GvCJQ8bbhyihOJ0pPcmvFeQUjtk5kclUMC4xcTDjEDabI6VoIjmh1G/K3nkc8AgL8y7p2QFjnA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/MqbZn/2SbqJUACfsX7GCN6bNI9lrRTVyJYQgShFEXYNKY9Ysn
 Cv5DHWofbI2uRJ2ALLMC5CFx7Zf0aTpIPay7b9UPhy15HmiIXFaBJ2YioRXentKIb/4t462FKrk
 hmGB9SnF86HNaCZ4/8JuApDurS0GbJVU=
X-Gm-Gg: AZFdTZe2KOHvxhgLTzAQlG0UxEQnPvcMQO/MZNmaFLr6Pk2cITRx3abOlslgZcrwBQi
 kNnM0MOZqR5Sq3Cvk1OhjGONqEPBLYxW3P4Iw58FOc7Jo7UzYPPHrGpVfI4/XpRt9eDaX0JMjWF
 6qhEzd1Gm/jx6/MdhM6l7qxb6B9Ql1MIKHmDR4P0Jxy9h+4BXsj/Rt1z016UuOlkRNg/mO2QO9Q
 T8b5fpQKq+i8oaxXsPn/7Wp6wO8ysGVgL9a3hcgz8BuTBydQcAe5jo6FSnBlnyqV/RnMKnJA3+B
 ZNASCyxBxP/e0SLqsdcLEAd5GejI2jzQ57ThECNqeNS5OMqcKYZ61LZl6cxqDJWbggU/aNtn1P9
 WYspcOs7vrx/SAL+wesGd6Say+BxT6g39z9qazO2WEbVNPW0mhdjGeiT5/SZF6FWoPOtKnOhGmu
 ke2KOnWWMkOzH28WS7xwyVFzFH1tso1PxfDCiImZtcJQkOsFbXimdAlMUfj2AU8sxa4tuSN2g4
X-Received: by 2002:a05:6a21:3b8d:b0:3e2:13e9:fbdf with SMTP id
 adf61e73a8af0-4014d4587ddmr27430610637.35.1795836436206; Fri, 27 Nov 2026
 19:27:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260707093004.987846-1-phucduc.bui@gmail.com>
 <avRbEGoPh3bqR93f@ninjato>
In-Reply-To: <avRbEGoPh3bqR93f@ninjato>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Sat, 28 Nov 2026 10:27:05 +0700
X-Gm-Features: Aa3M54p5j-n2pabLvPLN9nW_rTRNPtSo4v-MXvotIWyiblkPP7zdfuetqXMVZyQ
Message-ID: <CAABR9nFt8LDyupBiri3PxDTERAQM0qs+cRcM41TRo1gQVAu+fg@mail.gmail.com>
Subject: Re: [PATCH v4] drm: shmobile: Fix white screen after resume when LCDC
 is stopped
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 28 Nov 2026 09:41:00 +0000
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 7:09=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Tue, Jul 07, 2026 at 04:30:04PM +0700, phucduc.bui@gmail.com wrote:
> > From: bui duc phuc <phucduc.bui@gmail.com>
> >
> > The LCDC on R8A7740 may show a completely white screen after resuming
> > from suspend (s2idle or s2ram).
> >
> > After resume, both Set A and Set B registers are reset to 0. As the
> > Frame End interrupt is not generated while the controller is stopped
> > (DO=3D0), the hardware register switching mechanism is not triggered.
> > Consequently, Set A remains at 0x00000000 even though a valid Start
> > Address is written to Set B, resulting in a white screen.
> >
> > This is a timing-dependent race condition. In some configurations,
> > debug options slow down the resume path enough for a Frame End
> > interrupt to occur, which can mask the issue.
> >
> > Fix this by priming both register sets with the Start Address while the
> > controller is stopped, ensuring a valid base address is available
> > immediately after resume.
> >
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> > ---
> >
> > Note:
> > It was originally posted in March and has already received both
> > Reviewed-by and Tested-by tags. I'm resending it to bring it back
> > to attention in case it was overlooked.
> >
> > Changes in v4:
> >  - No functional changes.
> >  - Resend.
>
> Still not upstream? Who is the person to pick this up? This is a
> valuable fix we surely want to have.
>

This issue had been around for over 10 years, and it took me two
weeks to track it down and fix it. It's also been about eight months
since I sent the v1 patch in March.
Hopefully, the relevant maintainer will consider picking it up.
