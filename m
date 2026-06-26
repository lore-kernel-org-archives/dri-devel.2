Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5ACC43602
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 11:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30C7310E5E0;
	Sun, 28 Jun 2026 11:42:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NRvfH3u8";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4164410E261
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 19:53:53 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1363fe80fe8so2839770c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782503632; cv=none;
 d=google.com; s=arc-20260327;
 b=poFZnHFCNzayxqq6DJOBv4lz2j2KUplbde9H74T/R3AbqsSTn4GtDGIT2T1PAX4tiv
 bgzzQf79STIfFeXe5wjJHH9PYzd6Vm5m/UHP5JDbZzcl0JkKvAUQAlpEPRD8t9vUZoGw
 kgzYL9aGaP5SQcPJ5pZUGygDiNlI4ewxqQaVCiQPFMFXP8+err2cfuO5DmZyy0r6wRoB
 Aqd7Z7nBJuzedjBkr/q6xXwH+Oz9fyaZAUv1GZ0xCzCWHpAhtfLm5m+DP3ZyMHuel5gy
 Ql5Ts7fRFt1Li6qQ165tWKJ0c7s8UEm6xaCSRg+05bCSJUG7xMPBnq91uKBKq2JDCR6a
 KdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WHIpLp9HI+rPAwCzsNS6avOzV6ru9OowfuhFK1lFRb0=;
 fh=NVdf2cEPp+vcRT5MxnApYu2RXnwD6WKcZL4sJXCpc6s=;
 b=ZsQzULvFoN1zEnWV0aRjcln0PzDQOtVQOatYO/vnW8NnL42uJkQhTs7dkYTR9yBnO7
 kDjWg5zgM89F6iKip28SJszUWThSElRt0ApidvbVd4kx97pqTKd43/K4odyUEP9d1ipw
 ihSvodZ7AWFjbr1TY8Iz8J5yNO+ZdsKR+ncsssItnBFjjWtJFPCjQVeRHt2w2CPVnrQI
 7ibpqmX64gtKLVXfbVufza233SyyCDeuKNiOP/4BBKeiYKEQHpIKE/1PO3cfvbaYOcHl
 4bsx3s+6uXpDgfvE5LhNDCQUS01AJBKQGf3aKbBE6+XlWtJ/cVCk0ndvaJMsT5Hsc00H
 srYQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782503632; x=1783108432; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHIpLp9HI+rPAwCzsNS6avOzV6ru9OowfuhFK1lFRb0=;
 b=NRvfH3u87A3k6tlH6mprKxelpYDiGM1Q1CGnVfe/pnUcNWi92sTgJXInlI3RREUJrG
 8E5PQhq8q6u3AJ2iJNInhnnH2AFg9j8tPEFHpORZaCuCx60H7cHBkGKAr7kjc2/sSrSG
 1cZRigCPcBCZO9yXhmxe25bZGJtG39I4jhDEszhuGs+W2q8SV1vVamXUGHgmACEw+Q5e
 GmjPGDU0xEfiPivAK6HiPjyLYaVKowFuhw9FNgNVEvIOuEgk2JZVLQfUFOUeef33jmJW
 WPsXYa+fuk29iBMaUbm2wZoM36sNbPQMPs6pCy2BqPwVrnygzeiOsfPmh4eBdgtaYIl7
 lPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782503632; x=1783108432;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WHIpLp9HI+rPAwCzsNS6avOzV6ru9OowfuhFK1lFRb0=;
 b=BCpyiwgAuJgTo6ICl+Gq4SfdWUlNMYAY4gOI2zriWuwfAHuBbsfjk8nuPyJmrsBqrg
 mloHwvi+QQ5LcgH9X4RALGJogyQqFJJJlUnJ1SrbG71df32vtgTMCbMaE3afQEtFauoA
 DCHUakQ/UDNWr0LuJZHtYs58KmpCY0Xs4kMhXZ9TEo5NUEXDl/F6ksKufjK2loe3IKOQ
 f5wyEXBViXcco09PQ8FGsdEzYQBdx5SmF65Jgm0PrB5YPWC6SCrqaGvZBMhIRSbFIgg7
 YUNXlkTOgIVDQw82wu+G84Wv/0XBaXvvZAFdjpytMd+qYPHCEwH7N3tCeBvSo/KeKktB
 +a3A==
X-Gm-Message-State: AOJu0YwT7Xw13Gr80Kt8hSlIN99HYdWloajUtw+x+hfWjUfsSvowwTbe
 5Ux/+7WvDOcmVtXuBReK+imRMgEofzGYP0n+X8YfY1Q03Z3GjxaHtBHMTyiuQA27/ludLJWX69e
 fV+5dpfSYD6PO3RsIlhi+/hiY2Azjgog=
X-Gm-Gg: AfdE7cmfEAT+BfsRwk4m3cWjLMSm9KmYVJTq5ICxoiN0sg9V/jhdlDEMcXAc12on/Fm
 4jaDyBco8qSisSEOHqL+Xbx2QaVbBz13PrAJZaJvZqbTxblfdx/NIXypeiPUkgascRdfbL7CQJ3
 2/L2mKELk3l0nPI4cMOi5IJQStKF0TuAmjAPj4GoBD30x5tdh6Yi7NRKa+/jzLlLFNecyCldYBW
 jB3IEIlJU8kdPrdcIMeDbLVc+qQODc+5lgXyogKBwbyt+SidcX/kb13FZU6D3jdRR+7Gcr5ptlj
 8e7fKDInjc5TnykOrg+pjaI+01NwgD5gfNTut3e1gp3qtkCTtXfS/Ty+5StEyTo=
X-Received: by 2002:a05:7022:2528:b0:136:959a:abf2 with SMTP id
 a92af1059eb24-139db9e5eddmr6574649c88.2.1782503632436; Fri, 26 Jun 2026
 12:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260624100326.413699-1-piyushpatle228@gmail.com>
 <aj5MNiKSCiEDvDzL@raspi>
In-Reply-To: <aj5MNiKSCiEDvDzL@raspi>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Sat, 27 Jun 2026 01:23:13 +0530
X-Gm-Features: AVVi8Cc8J5b8utQLMkVEyLYbA13emlJ_chAaoJA4TJ2pE9djj-ndQ8odlJXm0ws
Message-ID: <CAMB+xkbpqNbYpQH331aiXxEhkp6mZTcfkCeELyeS1qbiLTN-9A@mail.gmail.com>
Subject: Re: [RFC] drm/imx: upstream direction for i.MX95 display support
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, marex@nabladev.com, 
 daniel.baluta@nxp.com, Frank.Li@nxp.com, shawnguo@kernel.org, 
 tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 airlied@gmail.com, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 28 Jun 2026 11:42:36 +0000
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

On Fri, Jun 26, 2026 at 3:22=E2=80=AFPM Liu Ying <victor.liu@nxp.com> wrote=
:
>
> On Wed, Jun 24, 2026 at 03:33:18PM +0530, Piyush Patle wrote:
>
> [...]
>
> > The current dc/ implementation is a multi-device component driver with =
one
> > platform_driver per block bound via the component framework. The downst=
ream
> > i.MX95 driver is a single monolithic platform_driver mapping all blocks=
 from
> > one register base. Unifying appears to require reconciling two bind mod=
els,
> > rather than only adding match_data.
>

Hi Liu,
Thanks for the detailed reply.

> I think that upstream i.MX95 display controller driver would also be base=
d
> on the component helper.  That's something for sure.
>
> [...]

That answers the biggest question I had. Knowing that upstream i.MX95 shoul=
d
follow the component helper makes the overall direction much clearer.

>
> > There is also anticipated divergence which is not yet upstream (i.MX8QX=
P
> > prefetch/PRG, LTS and tiling modifiers, and the downstream i.MX95 blit
> > engine), although mainline dc/ is KMS-only today.
>
> Just want to point out that I sent out v5 patch set[2] to add i.MX8QXP
> prefetch engine(DPRC + PRG) support for KMS.  That changes the driver's
> mode setting code a lot.
>
> [2] https://lore.kernel.org/all/20251027-imx8-dc-prefetch-v5-0-4ecb6c6d49=
41@nxp.com/
>
> [...]
Thanks for pointing that out. I went through the v5 series together with th=
e
downstream i.MX95 driver. Although the modesetting paths are diverging, man=
y of
the common display blocks still appear to share very similar register
programming, with most differences being SoC-specific data such as register
offsets and tables.

>
> > One question for Liu Ying is whether the separate-driver plus shared
> > helper-library approach is still the preferred direction, and where the
> > helper boundary would be drawn (which blocks/ops are shared versus
> > implemented per driver).
>
> Yes, separate DRM drivers + a helper library approach is still the direct=
ion
> I want.  I think that the drivers and library would sit in the same
> directory drivers/gpu/drm/imx/dc/.
>
> The purpose to add a library is to share code to reduce overall code line=
s.
> I'd assume that shared blocks or common part of slightly different blocks
> should be covered by the library.
>
> [...]

Thanks for confirming that.
Based on that comparison, my current plan is to prepare a refactoring serie=
s
that shares the common implementations for ConstFrame, ExtDst, LayerBlend,
FrameGen and the FetchUnit base through a helper library, while keeping the
i.MX95-specific blocks as separate component drivers.

One implementation detail I'd like to clarify: would you prefer the shared
code to remain in the existing dc-*.c files with additional i.MX95 match
data, or would you rather see it extracted into separate helper source file=
s?
>
> > how the component and monolithic driver models
> > would be reconciled given the differences described above.
>
> Like I said above, I don't think upstream driver would be monolithic.
>

Understood. I'll treat the downstream monolithic driver as a reference
and follow these plan for the upstream implementation.
I'll start by preparing a refactoring series for the shared blocks. If the
approach looks reasonable, I'd be happy to post the series for review befor=
e
working on the i.MX95 driver itself.

Thanks again for the guidance.

Regards,
Piyush Patle

> --
> Regards,
> Liu Ying
