Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AAAF5A8A6
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 18:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66CE210E72D;
	Mon, 20 Apr 2026 18:21:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aZHQpFQU";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F2510E72D
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 18:21:16 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12c8ed67dccso94918c88.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 11:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776709275; cv=none;
 d=google.com; s=arc-20240605;
 b=HlpUok2Sn37mLu7S5RjKYsgwB4DhEQtKHulghHjp4USPM011zGIflvVDAeWuq/T5xW
 o9Qy0NLXsE9mPKr7onYfPhau3pu74bLQsswRU0y5mMQIP6scYURVJBkcE90alRyzP7KD
 u+ZB6fS/tzFLDv81FNwZQpSh9Y4eM5RWOs+bDB2ubo3o7ZRLngal9QBYSv4iBq7rNiYr
 mPllqknN4arL9zI81kg6ayWkq3bmkOKWG3lAo92N08DBvRSFgG5fJqJXMKWEluLb+ovZ
 2xuzUzXO7wXkhWIIldUXnFA0ytZTUvJKJZWIOlUbp/XrE67wlQY5dRvg+017L6SNHOUg
 EEiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TWm5NOdSkDWXCTDQ39KtgRftkpjW9CFNT6pF4PMa11c=;
 fh=CmNCYjsDjYhnLp3OqkcwGn9JuieGWEsrjgRGrpxRNhg=;
 b=X2lCmWj37GzHSTKWG5yMri1f+TWv32ohX+3AgmSexLM9lRk3bxhfYI8tUcKFMehb/l
 ADCdmCYsBrqc7yFPjD1sxY2d62UffKVZ7/xLHGiV6R+3vr6eb8kBgywV7dONah0rP1JF
 HB1/VJAEXzc3zvxs8HBMfYuZKbi+2m3u+hETfk+zXWxKbOFG7jZgE5y7VKf2y5auFQeM
 PFgdXcoimCmS7h/5AzD7+9lcV2MO+yICwxyQo+YcjDXLfJxrJC+BgGC20E8bhAxzrTxL
 71Fhkd/A41PBctwsQyL+bfzJ0Si3I3FTK9yA8Y+pRNKWFXJy4nBj4cDZHQTvBX3z5tJt
 oGoA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776709275; x=1777314075; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TWm5NOdSkDWXCTDQ39KtgRftkpjW9CFNT6pF4PMa11c=;
 b=aZHQpFQUYG5/5XVhI92OkjlM75ZtYqsBkIDh2nT4Y/aPYfuKMVZLxqbZl89WKxlRMY
 XJsukio0HXARWSKYjT5FWODmZXpEQ4HHTec71PMX6ypbHECvAT5mbtMEkgaKiR789WVG
 7lb536G/XGZnoBf3iaosmZNA3GPrgx2Jy+HGNmemLXeKx0+drbSHbPBqTITXOOuqtTfk
 gshjWAtvUd5fbjjPYiSMaUKORAuzablzf8o0rxiS2D88u6Edv7lTEb9r7dexi56ll21w
 V9xNnZobRKyGagvabhUThHVeX0jiOB5L0epQA5RoFNnvCy5H/gXU2OpT8WuGmsl5/PHN
 k+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776709275; x=1777314075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TWm5NOdSkDWXCTDQ39KtgRftkpjW9CFNT6pF4PMa11c=;
 b=csEgrrRdbLLVT5ODqczKgiuCJXAIh22m941aSPF+z57cenlA8Pb1WU/UQUMoo1d1ck
 fkPq7ah9iKE1YtzRVhziVMT/cgMJltcdE+E4xf5QFTW8SvP+YEuis0UYLnHi/ZCZIuoZ
 iwIi2F3BNkQcga9sr6R/c8bfTs1Og9taJodeJMCKCcAxBa5Ah730keueTiEH0jlJUYuG
 7pjUPCQVkHcOoqxZtDrDbq+z3TiZix7pueNoR+hHfhO+YKv7F61aZtUj8xr3lS+cQ/K4
 BOuI4Pc9ZNLq2cptIQZKrq+uUFvAp4bhNEqJmpOEMOM5tea9d+fm6jHqmeTpoAeKjYnU
 qgXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dd//vGa+oBaqVIlxx+JC2U93MuEZOQT8lQJQ+Wgg1nA+91wNFMziZq6JyJWmYutDrXrbxwgD5J/U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0estSzlaiviKZKj8fDtGCa2+qZyiZEkhRePhJ9ASsJJKjwBBG
 OYTwtgqhIf6Pfgbb9NKFomAA5MDz4yz3bEc/Zki29xna2NwD/eMM1vY9Wt64JUbbT9lw9l9mdkc
 V8Wr5er4naeHbYM9RUgIrqTusZUWkAnI=
X-Gm-Gg: AeBDietNDr8aWmW3p6M378+OCYLJ12+EdbVWaFKBywQczz6xDvyxiLJK/n57hhsWxTG
 nyptME7NhoF2TgJVI5WM6iNunkmT99BN9CwjPe1M7w6t3nb/2s1MGDgkdLL1AykL5XXRskTKAZk
 Jw8CtNaNxNI16k9mRbwWw/JbkUPogDGU4DhsWcJSCCbvDcqXe2Y25eFGch9+QJvqKWCVFXLHEtd
 YD0OfJYXfSq0k33bSl3HewWXoloVeTueIqR2lV1agJmpbWozU8ydQlisT7Ltc9eCxLnmGN0QS+A
 0gNjk45reNZSGuOoYQeVvfyKpsnnljMk5z08Um+Pz/bE2TNOwzmpgpkm0VhUBdknMN/JgDZr1LF
 zmxUXO/sZKxlldYU=
X-Received: by 2002:a05:7022:170a:b0:12c:8cd7:d463 with SMTP id
 a92af1059eb24-12c8cd7dbb7mr529196c88.2.1776709275276; Mon, 20 Apr 2026
 11:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260401044238.15201-1-den.demchenko@gmail.com>
 <ef9f7a9da9de1fbda178e6ee4c92bbb9d4faad92@intel.com>
 <3b1385aa-1588-4d72-b632-b47f95f24f78@gmail.com>
 <a3208885cfc0652807367cceae6845c111857d10@intel.com>
In-Reply-To: <a3208885cfc0652807367cceae6845c111857d10@intel.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Apr 2026 14:21:03 -0400
X-Gm-Features: AQROBzAdYQpnQUe7LcB_3vEs37sK_0EZZYPWXoEUN_4ZIPRhmdnGlLtuA0Eyg5Q
Message-ID: <CADnq5_MbzvTU5m5e_d7nR0tr1BXu-6B7LrbAwGZenWA+Uc2ZNw@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: Add quirk for YUK monitor 0xaa01
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Denis Demchenko <den.demchenko@gmail.com>, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
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

On Wed, Apr 8, 2026 at 9:29=E2=80=AFAM Jani Nikula <jani.nikula@linux.intel=
.com> wrote:
>
> On Wed, 08 Apr 2026, Denis Demchenko <den.demchenko@gmail.com> wrote:
> > Good day,
> >
> >
> > Gitlab issue opened:
> > https://gitlab.freedesktop.org/drm/amd/-/work_items/5134
> >
> > Here are the requested logs:
> > EDID: edid.txt
> >
> > dmesg: dmesg.txt
> >
> > The issue is reproducible without the quirk and results in a black scre=
en.
> > With EDID_QUIRK_FORCE_8BPC applied, the monitor works correctly.
>
> Thanks. I'm fine with the quirk if the AMD folks don't spot anything
> else missing on their side.

Works for me.

Thanks,

Alex

>
> BR,
> Jani.
>
>
> --
> Jani Nikula, Intel
