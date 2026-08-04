Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D977C55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4FF310EBC5;
	Tue,  4 Aug 2026 20:37:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HxFYAvGE";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E484010EBC5
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 20:37:31 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-69fc2261f2bso359687a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 13:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785875850; cv=none;
 d=google.com; s=arc-20260327;
 b=Mh0INcIUopEiv9qy974v1rLJFttTsY4zcmGzadkQw9hsDzwUFaoK13m39Rs0Su1Vtl
 UEpVdit9l2xzZ5UApj/FbLJWiGWanshx5Kvk1DtTpGsBHnQ/TtxWIih0Uj5Ym3xj/Qsv
 p2AfFCiBg5Is8sFdgpuqklte/oPnybPqWbndSE5LRKfFydHalL99sxzbkQp8M2ajUYFq
 xVNYJOs1HJAz7ifP8D19EnlPElhL/2H/yvbvutEx9CuuB7SeUKj1+dati84g1j4SfpyL
 1W3dVXrAaqDe6JNRL+3n0zYW0/8jVpDu44XRdXP4aGmfTufYlqIisW9xHOvHW8lHu5RY
 eG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K8Nry9JZX0+jkudHxKcPqQRdC9OkvdOyv4wLmj940zo=;
 fh=+4rdPau01z9ZhYkTymxGHLRmmBvJClYS4VtEtt8w2jY=;
 b=FrO+8I1GFd0wSRzGHdX2kOJQPFDWYm7e1VeRA8ScBg8u3iph+o9yrbKbsZxjjSPnU4
 L/rd/+OLTLVQNVPPC3e7RSPwGZuTYjSsW8Sd9bpnsDOLELP33syF/1O5aGzVvmwKV6Jq
 IwG+B4Ny/FJON4FYreQZQ2rjUCjMGmlO/PUxlujJrt4L8jOKkUxR58Ize5asmziD+7o/
 S7tWB2k4qlqjBCh5Rs/QTkLB1W7Xb/ZPKV8hIPXU1wsaY9+jyq+PQ9afbahFR5//bFNw
 njqpVHVZ1d4Pa8FmkFASF43zDb6EGbv+vURe/w1KE1lRzKX9LFETSLpJQ+/4BUz9n6Sj
 SrRw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785875850; x=1786480650; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K8Nry9JZX0+jkudHxKcPqQRdC9OkvdOyv4wLmj940zo=;
 b=HxFYAvGEI5yhcIGP1zZnwCWrLV4vG8oFib7CHU5pzyIrqQOgowB8F5Rb/YPCdZLOHS
 E4HViBee3Cu6cAkh5gAIftwiO91K5GWp5X+UBMb4MTYIHEn5xj0Aq940wHpxFOz0l3d4
 fgJ3NhFoPjII/sJwku4Px4kDe41t5zcvT2W6bXo2zYQlxsFgng3QEYztbG3uBhkehuF/
 WP7uBWGNnK8fL2BCS2TK6KKZtp2RyKv+Gh1vy+7PtA1ADBbVamV/8Lrdx5O4G1YuR0Ru
 d7kmUR7sVSxuAM3tiUxV0icbcN0MglRivHxgNGwNsNL5SK5sN8M/11opgvuOWlt69eSx
 auGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785875850; x=1786480650;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K8Nry9JZX0+jkudHxKcPqQRdC9OkvdOyv4wLmj940zo=;
 b=ToyVkV61O+UfC4udo/LKf/jgTXzdE8PlKBl4IS37Tqam4PRtbY3z2qyvXa7QgtrjNC
 TC3kjCzgfyZso6BLI4hsPsyWm06DcFAXrBgTv0/oEA25+H0e5S+4Y7E8AXbCDdsHH8fo
 LTgpjC7vlEfY6ZuKNC2iAx0eecU1U7li+yzlk1/vHTeQURUMtUqmlM0cTTepST81Bqsq
 PoZCR01UAjbFQ3n2AiXvlo/BPJZV97Y+axde2QNPTd5I5Ih/TvUNSsYBVgyRLZ+4lyBE
 bOI4yNGNmPKpJAV02hUwySc6A2ZZLhs9a8UDSZONQPUpbj+ztnftw2LyOaBI6jwl1MdX
 i6wg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpjZ1KBePZ6FVIVwT5lY+0jDpMw4FGNGlWE2h0dlSGKvjDs7xcYi7EwwFh9D9IJhWE8UoH4lGdzYY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5jENd3TfRwF5cnZ91WkECp2pH8RqI/8bGIszS80GAvVxEuNxa
 qjL5rm+ev82xRDkxV+igwMi33LnYJ+TbS2umnn8+/ySxBuUUdWYPGtOtcy/dAiw8Jmh8vRDmH7W
 ZnZ5cR7bcVfis7UjC1x83p9gdbex25QQ=
X-Gm-Gg: AR+sD13FgGfvsDE+Hi7he3VZPfxUjF7jvz1XiGp/OICsJmFE0aie+ErgP8y9aezan8n
 Y/htQEFW7H5nb1aYEGOf3QRjREMtGEDGzhwcMTvv4Uid4wL32CmRTvPw73nr1wVucWCeoSYZE2W
 hdNMvkhzGKFxpe8o/W8F2LWItOXpssnYAxdBGhN/lYargiDfpCzOkROh+lgBITYO+PwuW0A3Qun
 54Gk+5F9DTVyUEzfSufzmXCGom/by6oihTeTxEI9VLkMVWOmD7w9Ckyi0Yq0zV8RyTZbNjeFO7Q
 sNBW3fuay4fQmWK/ZXoagHXJgrLRi1OfBhtF62ornBKW
X-Received: by 2002:a05:6402:3506:b0:6a1:44c8:edc4 with SMTP id
 4fb4d7f45d1cf-6a14f15d5f7mr779529a12.12.1785875850152; Tue, 04 Aug 2026
 13:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <CAMuHMdVrmpZibxnP5k8wCr_Jpx2WzAe1bcUt9k_hWrreDs_-Eg@mail.gmail.com>
In-Reply-To: <CAMuHMdVrmpZibxnP5k8wCr_Jpx2WzAe1bcUt9k_hWrreDs_-Eg@mail.gmail.com>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Wed, 5 Aug 2026 00:37:15 +0200
X-Gm-Features: AUfX_mxvS-q6d9SV5M7tSXzAAroVFKsSN0D5MKV2-5EaFu7n2XqTheS2vhlCf9g
Message-ID: <CAEUXW=EAYTxdwyvpVFDLqof+wNGD-N3hRDRYve2Ou40ZA5R3fQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Helge Deller <deller@gmx.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>,
 linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
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

El mar, 4 ago 2026 a las 15:59, Geert Uytterhoeven
(<geert@linux-m68k.org>) escribi=C3=B3:
> The standard location for configuration that is not hardware
> description is under /chosen...
>
> IIRC, real Open Firmware used to have some logo configuration, too...
> Yep, /options/oem-logo on CHRP LongTrail[1].
> And it's even documented[2], but fixed to 64x64 monochrome.

Thank you, that is the answer I was missing. I had written the "a bitmap
is not hardware" objection into the cover letter as something to defend
against, and /chosen turns it into a matter of putting the node in the
right place instead.

v2 moves it there, and I will post it shortly: the node is a child of
/chosen and the kernel looks it up with of_get_compatible_child(of_chosen,
...). The binding now says why, and points at the oem-logo precedent. It
also puts the node in the same company as simple-framebuffer, which lives
under /chosen for the same reason.

Thanks as well for the references, the CHRP one was new to me.

Max
