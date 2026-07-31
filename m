Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85A8C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 15:17:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3261C10E213;
	Fri, 31 Jul 2026 15:17:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TDIx4ZLb";
	dkim-atps=neutral
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F46A10E213
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 15:17:46 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-752a7f4d4b5so598835137.2
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 08:17:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785511065; cv=none;
 d=google.com; s=arc-20260327;
 b=UMsPDVDiEAHaYU0rswG9cF4JejGtHLtA09t/RxkaoNvfyJc/CmXRqruAHO5V2GBAzX
 fNYV1A97NdRkjCm6UOibD3V1sGisiTGGhVRVzblmpOynoH5qw5utW/vS5yugvIKQMt29
 We9UzxPPapQd38TZwbFu12LqvLb7J+xsSGCUxRCbAdiFI28dZA5JosQ/2e5HFFlN/Fzq
 x6UH32BF8c40Vr5fdRW/VBNsChemO/5haSLa3M+aDCQDqS72iTD1LFN78bK5GtZw1MNU
 40+e3RAJcxeeJWUH2+eOQuzje3swiTxyeJ53fX1tkp3efyPQpfcofN6YzOd7YThZ9XTF
 A3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KGP6YYWa3E46HVm4iujdsDlLjDhR2AjMoL5m0l3+/TY=;
 fh=VWWz0rL4Nlo6OksYgu2EJd9+XKxyCwU4v0eBB3QLJQo=;
 b=JHoIoxZz+R8gc0gyXx42/52SB9MYSC/r0Ai/+ArFtSVCHVaZu0dHV+5yvfgxJz3wdA
 4fNSD7r/2gU0TjTyvu0oGyFRnT5fwpAvMDpCBXEX2AcwqvGOXauU7YZ1PCA4fAG+brWw
 ciKKTaaeJxsXPp0+zfvp+dwovV0H+4ZGP1C0r9F/f0y3nur0oML2dn9N3T10uAP6C03u
 vzXsd05sxuQ+KPYPtIqN4Mcntr3YVNEQOC2gLJ2IlftHq0cNGAz/f8+GFBnXU4tT5pZj
 +bIslLHjg4dnhOoFksGUDwmmQWBtxF/yhVfSJN2EEwARo9yoNoQnmSq/jcJl7VGS4ZOm
 GjWg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785511065; x=1786115865; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KGP6YYWa3E46HVm4iujdsDlLjDhR2AjMoL5m0l3+/TY=;
 b=TDIx4ZLbGNCywHxoTGRLxo2kGzeQ4/rwptye0Mbm4XCTWVZ85ItyDBljIWWy6W9aLr
 5uYRLL79No2ykTZjZOn7E1WyeU5/7d5X5wFksQdGjgscaZwYJKVzx1eIyNx6tJ1qv/Bs
 HHCLvdShSQsQofZ1eLdNONV8q9GQQaz0t7j3ANHXVC9lN4usfZi6IC25bPQK/k7p2htx
 Mn2b2YlG6t4XW5JTMmy/ksdBymUjDIJp4CR7PGquzeGTRBUQmjiL3KgyYHOn6QlS8WfU
 lLVZ28iCXxDHjLiugB1Htcsy+276VOzMHaXsjs/7hJEFBGgiTRF0l7wJYA7IE0ShBXxN
 BU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785511065; x=1786115865;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KGP6YYWa3E46HVm4iujdsDlLjDhR2AjMoL5m0l3+/TY=;
 b=Kp14oDyuKm1+lxoGOjMfKgSQh8Qlgxub4JMnKY4cj/NvzrGVaY6wF2fRptpJLxysve
 15ABx6itQdcpMklV6UDI3aJg7OiTPEyTDYuCl7nAToWLYfSou+ksWjyZ+Mmks377QSd8
 1vg9DJIhRpTSx9UnLiiFiisSzXg4tY2lPU82S86TsamnTHZp1PTQzivEX5EPpXMYSlac
 c03hYusmWD5AjikJPJFLjd99aVRfpsYq7Y/yOerCSr7GjxW2L4JkaY0YBdnyiADePTPG
 PY+UofzkckiGZ/JrWiFszYVZDmxlmJHleDIUcpwdtGcJiQclZTncPTYzcEgckQBxbBUR
 n5hw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2UB6Hz3rM1773eRuS+OLI3bzEy+vUQ1ckKbMpd/bAlHr8Hfw1DtcVEOBzq1CoC4U9gYcVPnGEBLg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZSKhPS9xIkj9s6MYNeMrJacSXKyBkmfyHYfuFlVl/Jjgkri0x
 f0a7VtT1ReRIkALY5dpXCsx3eQQQl9P+PA3+hZSX7O0RNS0mhCWZRXe1m1Vj9WviOBeClUnYMrf
 UKvW5OSYAYAdns1OjBY1oiKNqHxQM39s=
X-Gm-Gg: AR+sD13p8UvJCUmn6F4FFU2kOdCxEijeHNQnS+0C9f7bfG7L311G2+N3XcG7mxJwJm3
 i9lyc8qBYjk7sY1gHmvIyxiBbY2r0nrqjdmDshaoAy4Fb+AMTrBMD42oqUHi8GSlKBbro33Yd1X
 qLBXjTjzMqdjr0ITAscVYGZzC6vGjOeICF6Gs1lfdec6pO2/yogILOqVI5uFAx9h3vvm7q1bVO8
 eQbvhZqg9B4ceb5SPvEN9NuQkkg1Syfw0ySGu2im1MUSiMqLsq8OCU2uYL/EcBWJfPm81T0ErfI
 Bz0H4aDoMarKSZZCv+I+Gro8KRn85l59uU4hDXHHMh+MBPzjsxpzvhBzLKP7UVqU7Ym3wwS6B9s
 =
X-Received: by 2002:a05:6102:441a:b0:738:1ef6:51b9 with SMTP id
 ada2fe7eead31-75b22260dffmr475318137.5.1785511064843; Fri, 31 Jul 2026
 08:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260705110221.153481-1-mdshahid03@gmail.com>
 <20260724122254.121935-1-mdshahid03@gmail.com>
In-Reply-To: <20260724122254.121935-1-mdshahid03@gmail.com>
From: Inki Dae <daeinki@gmail.com>
Date: Sat, 1 Aug 2026 00:17:04 +0900
X-Gm-Features: AUfX_mxZnAVCtLemF1RKBEDkqKNByd4RYkTmPt_s3OtHb2BMMIen4YexrgB9y3Q
Message-ID: <CAAQKjZPwb00MePpUTmKZbn67jXp=UWX7m81evttd29L+9UcVxw@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos: vidi: use memdup_user() instead of kmalloc()
 and copy_from_user()
To: mdshahid03@gmail.com
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

Hi,

Thanks for your contribution. I will review it soon.

Thanks,
Inki Dae

2026=EB=85=84 7=EC=9B=94 24=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 9:27, <=
mdshahid03@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi,
>
> Gentle ping on this patch.
>
> Could please take a look when time permits?
>
> Thanks!
>
> Mohammad Shahid
>
>
