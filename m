Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4819C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC36010E2CC;
	Thu,  3 Sep 2026 16:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="DC+bwtac";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6BD510E07A
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 16:44:02 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2d6d28aa26cso102665ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 09:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788453842; cv=none;
 d=google.com; s=arc-20260327;
 b=ZXERZ7vrtS3ekl4r6Ip3Y+gK5PD37JZTsGugCOOJfGhTD3PKtS0IZX1wNo7u6cs/EW
 buKmRgr598S5YeDtBlUrYenArifMyi6Q7M/qzcoTEpJWPWWtQC+8cJaUdVLgeImZvJD0
 Ql2/PtgZMb5xKkELATkd2TNHYaFN1LHLZ4IXQ1C5hQv0Hjs+k1QukIf5DmZKjGfk6XoR
 uXIhzL12MGCBqpV4Cy/XijYaQEP4XGUcxmB5YjIHuMODC6aiV2MB6Yz/DJNb3hKmrvS6
 IIARLm/ca5TnkzBfUW8LcNH0colVTqCwQDbAWXFhQL9yrIpWH8yfaa6l8w+VtUXB5BVM
 g1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yXvf0AeS7HHK1WbUNCGtVoEYnWuibX1ahJk5lCwo170=;
 fh=dEkZNg2yt/Ju1RCWYj6rg0YHf3WojvDx2O6mzn+8BsM=;
 b=lqz7nHu5XLvXdpj/aMRX/79LJNj0PD3HyDC/kZOmmxxu3eyjk9NJQ/co0v3RRt/C81
 PpURQyV4nkNvmSeqsY6o72R98pZeF1UnNG1SRO0nXBj8MIGUC4eNQvr5z179RwxhYkbv
 bsSZFkIwvb01h2N6YsdctyDuBhFAmcRBwFMb0VDoVEWFOWANYTYN23oUanBmyRwZEuOD
 NBTqt9jwEnBJPyX2dTgI3lJ3+j7Rn/XRDmQq3KQD22i20L/nwe2KxLjWZ8E60eB+r2hs
 wHK3zqx3tTqBxIhi5LoOj3jOKJmcfk4sMwd61Y+YSWvcPKqRkm0oiqRxhIpVCl2Xpd41
 2TgQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1788453842; x=1789058642;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yXvf0AeS7HHK1WbUNCGtVoEYnWuibX1ahJk5lCwo170=;
 b=DC+bwtacnjhx641ckrMaDZ6e9znJ8RGQo1PVvBADIHXy9X+eLcEc7XyWqy8wN5qNul
 LbZ/JEBwOvs6giWyO/DfOouOuxwnBvDpNTNyeZq61R2qGfA6z7X1TFgplJErTHDf/Qq/
 pPIXTRB/YGT23kjYaY98zCPvF+EFzAmZA1sM1gi0xZDGm8+Q8N6y6yfxadClc0eXqhbF
 /A+ZWDA7e3gvPl3rg8y3Pzrf2li4v/2YZi1hpX6exLHyAutVVyrYRxhzA0ajS6ueiEXN
 A55l1TgMoQG7r+oqfT0Al0ekjXqp+shHoDSPizwylWCx+DUJMwvTB9eBB5iGkwS+1DLw
 TWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788453842; x=1789058642;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yXvf0AeS7HHK1WbUNCGtVoEYnWuibX1ahJk5lCwo170=;
 b=GxLutNw4he0mrsU9elu5XDn5hqLTl82dTBXuD2pN5NzucNMT4QAsucky7/SzoaCyIy
 4awVZw8i6SAAeZWrKoHt9IJqkEHQ46qxi7yOT0nxaBV+MbkISJqyfAVSDGV6kuMO7AgS
 MOeJnI3/AkSqTZ1N9JhYmAlfOfmDzhvJ0IWfmvqtNvFlVyZuRTnmo/HaOG2j54izSpMa
 GesKsYcVg0lwz+x7IdheDErtOvCD6hqYs3kemW0p6YaWsQnOS5zG3UAbGPthL0z0CgEa
 PRQqtw8T9gqV+wNJBGHkxeWTzSg+S+7c66fv2EaDCQL7nC+GnWUPFbmU7y+najnfwM7a
 Kxvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxx7I1DuXpqEJ1MtOodLMGKIVnEg+dExpmE3VpFOtDvSRjSvA3U5hgQg0Fbd+o/LKwr41zcib5XcFA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nedTgJcMHti8Ay3ZKGJVHxrfAYduIiC6dYO24GdZXKw4+kGVsP
 RdxwsBqlgaTAatbVCm4fwAAysP97P7mDr6n81M7BsIQQYmlj4mx5ATLtKQf6xlp2mRERc82TQck
 EJTba1iEmaNC9FyCMRm5u3m9i2mloV9g9X5eV+XDR8g==
X-Gm-Gg: AYBFou0fKEHch8Em/vj1Id2nL+1EyI9Gh1tPvr2xLUlzTiIM2AyGi2gsTt0XF99ne2u
 PRL5j5ggdOBs/B8+/wE6t1KaXSUxGdb3KxXV3ml2oOjKmhu66Jw1gnZ3kCfUEJ5eBF50ZGDxAQW
 c62e5mOM1ESpcLPLG5JNl2gtj4xFAo7Ks8B+6pJZkwPxj/0OQR6pEUzMQw2Pb0uo12/UgYG0eKu
 CpbppfcPQVzgo+JVZW3iFs1hF3RCSet3QmhlCzPjFOHGiySkVvQccqC3oUoRWZ3zJ+p+cBx3Mxk
 UIEl2xGYjKOU6UKpmPdwJDxSbIUY9OS19YR7cZcYm/d1QRdMVhzHtW8=
X-Received: by 2002:a17:903:22c8:b0:2d7:5ebe:a588 with SMTP id
 d9443c01a7336-2db126d6e31mr3116575ad.13.1788453842239; Thu, 03 Sep 2026
 09:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260811003921.1398292-5-jerry.zuo@amd.com>
 <0102019ff114857a-259b7f40-8202-425a-bfbc-71bb92acf184-000000@eu-west-1.amazonses.com>
 <CAPj87rMSYC0wKP66p5Q5uOL+-Fb04-gYJFcRxdxxZ2-_du89GQ@mail.gmail.com>
 <CHXPR12MB9992200C6E9ABE2BF4CB8EB53EE5DC2@CHXPR12MB999220.namprd12.prod.outlook.com>
 <CAPj87rPsEUKEtOMzpvwnAJ1AHG=TyhLVu75kByPLwqbJ5yK1sw@mail.gmail.com>
 <CHXPR12MB999220E41E57B2B63AE08AAFABE5DA2@CHXPR12MB999220.namprd12.prod.outlook.com>
In-Reply-To: <CHXPR12MB999220E41E57B2B63AE08AAFABE5DA2@CHXPR12MB999220.namprd12.prod.outlook.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 3 Sep 2026 17:43:50 +0100
X-Gm-Features: AcwNN1W2hsX-YARDywex-CoUx_eIKtoYa8nwDrda2bO7bDfKoVieE3xEJy5PT2s
Message-ID: <CAPj87rPFGmudizy+rRv9F+i0h-L03GwzFVxpxe54uzCgq14Exg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/amd/display: Add HDMI ALLM support
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>
Cc: Derek Foreman <derek.foreman@collabora.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>, 
 =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
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

Hi Jerry, Harry,

On Fri, 14 Aug 2026 at 16:41, Zuo, Jerry <Jerry.Zuo@amd.com> wrote:
\> > I really think the burden of proof for implicit semantics in KMS
should be the
> > other way around: do we unavoidably need this, or is there (currently) no
> > other option at all?
> >
> > I don't think ALLM falls into this basket at all. It's nice to have for gaming (and
> > mandatory for gaming VRR mode), but there are plenty of different scenarios
> > where having it on or off is a legitimate choice. For instance, should desktops
> > imply ALLM because they aren't going to smooth your text into oblivion, or
> > should they not because you're probably not going to read text on a 49"
> > display? Should all games imply ALLM because you need the response time,
> > or are you maybe playing Myst on your TV?
> >
> > I understand the attraction behind 'we can just stuff this in the kernel and it
> > will dtrt', but hey, that's what people thought about Broadcast RGB at the
> > time. Or colour model/subsampling selection on the wire. Or or or ...
>
> Yes I agreed. content_type -> ALLM doesn't clear that bar, and I'll drop it.
>
> I'll submit another v4 based on below soon:
> 1. Keep only the case we have no choice about: set ALLM_Mode=1 when
>     Gaming-VRR is active (VRR_EN=1) and the sink advertises ALLM, per spec 7.6.6.
>     This stays in the driver.
> 2. Remove the content_type == Game heuristic from both the modeset and the
>      freesync paths. No implicit ALLM derived from content type.
> 3. No new implicit semantics, and no DRM-helper "default" either. If a
>     concrete need for explicit ALLM control shows up, it should be a proper
>     (ideally generic) property with a real userspace user driving it, not
>     something the kernel infers.

Here's a Weston MR which provides the same user-facing API. There is
per-output configuration for ALLM being always enabled, always
disabled, or enabled only when a game is present on screen:
https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2189

Would you be able to re-send this series with a binary ALLM mode and
linking to this Weston MR?

Cheers,
Daniel
