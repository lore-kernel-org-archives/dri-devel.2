Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6F4C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 02:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C0D10E27E;
	Thu, 16 Jul 2026 02:09:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="C5luYaQI";
	dkim-atps=neutral
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B592810E27A
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 02:09:00 +0000 (UTC)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-664c6304683so2620405d50.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 19:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784167739; cv=none;
 d=google.com; s=arc-20260327;
 b=b6VG2T2UYxcdEHjhFAHpqgmbgnmCRNM4DQxtOp+aBfvlwgyhPa7ys0OePzQikalSBe
 cvlRLA7VjvHGtwLZTqgJAJ5YRal0cjzstkLDcrpJElBPOVhWsqdfGA0VmKjJQxcSWuqJ
 TYbmmaNbBJLjYIaxnciT1UspExs/0bNweG/6lt1qIm8M4mFFF1lkMggLws9n5ron7YLT
 2puiAglSyT2LK90+9OomOy5Ko3sajMoNJJ6VFv2eQqek3CSht3aJrra92j+TwqL5Ytv8
 FQGKAhVyGLaQankaR47PUYHsPmDkBaSILPuz9X9WesCGv+sgPdYZZY9mLSC4S26AqGyI
 zuiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tII59+nJn0Y7yFeQ2yo7nNurb6NAgKIZTZuMeMT6aYU=;
 fh=MA7Bfw+oA7CBotW02vZfVlaqv8xRb90ZGtTpER9M3Zk=;
 b=olumrO8oZ8Ku7D2ROMMx6FO9yCvnYEgjY9GE8dHU4LWU6gFCQiBYbrlEhWvYcZSghI
 vF7NVO5HB0oZ5+j3X7ywT3XE4G7sgGTyExpDalBCe8KsCdH4T/EGiEt4hrOO9nZ3n9XZ
 vWo7UU4iH3XMUdu+P1X1j2GdL9NeZc8Zm62p5Pb+cnsYXxt4SeuYxP/lP/FtxSvdst1C
 ODA5vR/TL/ojKMqMxk3jIljRlVL2g5yhvhliBGIiyuDZQE7tgvYNzaEHAM9B2IOUM9U9
 XXzprnxwcR4zDKojjD08OT+AQguZejX+Frk2E19jlsbzYHLWvVlp+C/QuCpEZJh+rMOt
 bSmA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1784167739; x=1784772539;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tII59+nJn0Y7yFeQ2yo7nNurb6NAgKIZTZuMeMT6aYU=;
 b=C5luYaQI3Py/qg1086ez3H7xctygQUadKJw5drsRb6MLsLn5BFy7geell/Snp3xJFa
 liDXUPnX28dEnF9f6DOReKL0LmIQXwOer9GEclVxqBBQ9X1fHIkIQb3acXf7H4O75AgU
 ijra68S/E6IbyszvR2GCtwRDSZminTNayXMSr6O5kpl4B/T+pk/XJ/fnMu48sXdVhgp2
 h52FOsKu/8z2kkZSdBKm09L3aO6zMFjigYIxpIKZ1J193mn2IvFPxvaEF/O+fVG89HKr
 TRiT2tEwwzlb5YanHWTcXuN0aY4IR7jTCcrWJ7Sy73oJCbiFyDsRj5ABgBlbagyso3p9
 +u9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784167739; x=1784772539;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tII59+nJn0Y7yFeQ2yo7nNurb6NAgKIZTZuMeMT6aYU=;
 b=X2vN5zJTHcn8fTsqCjQzaMdvy8g0UfOiFW3euQ8Bdcwl9ctPBQTpfoLOkBALF6ipVL
 YeefiQNGeC0bXrmZVTrw7M6dVwKSbkXmU504r72tTEv4KykaViBP6N5CJTeAFEULNir5
 1T20pGot2Vj8VsTwElW+r1tdijTv8u27qz5EJm/dDXDEl68rpp92mSR2q8tamjuk59v2
 fByWcRRiDkXYt4jMj3q21MIJNZ8s+4zQC4dcg18SJIhgGtELAifESbyZi06PQXCyRuYr
 O6lA85enZN+m0nfjSoDC/M0rBpGxB8SoXD5OVMf9snVtHwghemHFPmfCNqkZST+ivJT2
 2+aA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpfc6s8NqzB/sPCusmWSgPyXXMWNUdMFNPtrJEBop1waUDpJxEEPudd9OdI0vix6HdL4uA/Ri6Z2Sw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1ncpD4UdkltaytpLNz/feU8TY6R/9+AD0QWrbj4kVTuYr41C9
 RM6Frt42QCccAepcjw2TFdVKz8x/Bu//QOYtNhzRTDQUIX8Pe/PZ3U8QvZE5rZRxIxPEqSrKTWi
 vIg2BW/muiTFoNzSg8sUldc+LmUU63U36k9wsdW+YAg==
X-Gm-Gg: AfdE7ckL5TmirznJoQm/FZehVWQ7Z+/nn3lJBlBSye50OHPXU19h+ynjoY4etKXGe+T
 +ZLDSBskV69hzulFc1kuXAz6jFxb2WRNXPVHg9sayr9q+VFt839wvdpOoOd9/yCMJY3ebcVRmNv
 O/AmMoSo4W68303sd1F6hW7sNyLXKu7sr9lL6KsJ0TuU31BPsbxEepa3bc/9vYAnu2G1K4hHr9n
 sCXTK667+tDX88+bF/7LNAPBhzTtTseG7tI7iFbs3Wr+qTXduUOhTIIX0+EBDXDBvbu3s+7VFMK
 LpMYmI2qy9XZQaiWPR0nMDPD2f1kJtwt9WBag28=
X-Received: by 2002:a05:690e:1507:b0:664:e3ed:52c3 with SMTP id
 956f58d0204a3-667d7ccc0c9mr12122195d50.73.1784167739455; Wed, 15 Jul 2026
 19:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260714-radeon_32bit_fix-v1-1-42a99945f6e0@oss.tenstorrent.com>
 <11218edd-ae58-4966-8172-27b2435eaa1f@amd.com>
In-Reply-To: <11218edd-ae58-4966-8172-27b2435eaa1f@amd.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Wed, 15 Jul 2026 21:08:48 -0500
X-Gm-Features: AUfX_mysHJnJfe86rmMYRqwDkQW-fetcdx0Rb9SLA2is7B-buYGz3xeLKn1HoLU
Message-ID: <CAEev2e_gnmhYw_mV8zt2AnkY6Hj_F165veoAPaXhA_ej-5RUUg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: allocate dummy_page without DMA32 on fail
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Christian,

On Wed, Jul 15, 2026 at 4:15=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 7/14/26 18:03, Anirudh Srinivasan wrote:
> > radeon fails to probe on platforms that have all their memory above the
> > 32-bit range with an -ENOMEM because dummy_page_init calls
> > alloc_page(GFP_DMA32), which would fail.
>
> Unfortunately I clearly have to reject this.
>
> The DMA32 allocation is mandatory for radeon to work correctly on some pl=
atforms.
>
> > Allow this driver to work on such platforms by falling back to
> > ZONE_NORMAL regions. dma_map_page called subsequently would catch any
> > issues with the device being unable to DMA into the mapped page.
>
> No, it doesn't.
>
> It's just your special case that dma_map_page() is able to use some IOMMU=
 to remap the page below 32bits so that the driver can access it.
>
> The problem is that we have quite a bunch of cases where this doesn't wor=
k correctly and eventually result in all kinds of trouble, including random=
 memory corruptions.
>
> In those cases it's better to not load the driver at all than to later de=
al with corrupted data.

So this platform has an IOMMU, but it isn't enabled in the upstream
kernel at the moment. I am able to boot up to framebuffer console. Is
there anything that isn't expected to work in this setup? Is there
some test I can run to verify this?

I should look into whether the IOMMU on this cihp can be enabled and
then try this out too.

>
> What could be possible is to add a special quirk for your platform to not=
 allocate the dummy page as DMA32 in the first place.

So some kind of a whitelisted set of PCIE vendor/ID combos (with
working IOMMUS?) where we fallback to non DMA32 ranges?

Regards
Anirudh Srinivasan
