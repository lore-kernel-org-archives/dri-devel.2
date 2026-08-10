Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944F6C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF7DF10E87B;
	Mon, 10 Aug 2026 13:54:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TaYBIyYU";
	dkim-atps=neutral
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com
 [209.85.161.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE9210E87B
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 13:54:34 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id
 006d021491bc7-6aca0f482e5so1206089eaf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 06:54:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786370073; cv=none;
 d=google.com; s=arc-20260327;
 b=H+BkQt/GZ3usek2C9BANNCPVTiz3P2ksYbERivKarRgtasRQd0Ony66vrG6txpq3dr
 rqFVv4LAb5sUJeUOHYL2NaDGjeLKsgMCJurMRu288gd0/ze58vtnK8oeBbm1WonnmiT4
 05xXGuUq8HjQZXcJ16zqOli5faCKrnshp1pi9ach+z524yfaVKV9Dc3OGNILMKQhWHlg
 JbWKGsvDjIUF78Y83idsM/9S3ncSqxr41N8Va86UCRJbwyPOAs+SVCS6EoIutW7LuW2I
 qczeppqyv9x7CHCqxd0++I8kRG+5q+EYGSMqgVhXq0L4H40w927br2v8e82WdRgPMxOU
 bFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=p9xyAn8Lg0NoyAHqpv5vJx0s8xXpgjfKFjqU6aFd+h8=;
 fh=ce6h220KaPc5JV27yVH2SaO74quuljgZBCQYz/akth4=;
 b=BvLl8MYYBH4K8fcfGNd+n5OBWdAaiWM2X1rHo3iZ3SNoW0U/2aXtRLoF7kFgXYtmzF
 l2sABVddS+rq1fFhreWBvOXy2QcUkKhc6yND9C5qFkPzBluEzoQI6w0LF8Fgz6848gZU
 P004/qBVCKVffakDXDHMPhcWx7NQz8HVuiM8fUM6m6IntsKx90DOc7JUPgnHNdJQh84K
 YQmCa4r+k0ptd0akeq11T9XBuXbhnkIKLGfaYEt2XowxdPExH0kSZ16qZSBa8cwvbwtQ
 NeUi1ZLDxCp6FENVK/uDFw+nDHzAylxnTE5Md4sJxffYlz6W0E83kgrBxTc2XjIgA6ZB
 fQMw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786370073; x=1786974873; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p9xyAn8Lg0NoyAHqpv5vJx0s8xXpgjfKFjqU6aFd+h8=;
 b=TaYBIyYUVelSyZa/0P5wPw614sHWxzNjQ7fbq6FvlUkvTlb6G8uGYaqP0if4vIAVC8
 1aMa3M5fJfbUvE/N96mhwgfAdPCoeUFGQhQONXpW9cZPAVat7toY/jeoFOmds+BA6Rt8
 4ieVu0EF3G3fy3ab46496ETyCzMT+FjD8bJeXt2LIOiYKcfdkzTvAMEHJCvhsIAEE6dV
 6AFXQC9BMIGgPZ49um/XxNgm08+dOCWWhLZd2oP9cS/yL4neZv3wOGCEY/9J/XhzDZTF
 617HeNhKE+M08yGde/9KtnM5QUpjpVzHcee7qjGmo1wQe53YQ/cGVhsGU2OOA1IuNQF7
 VR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786370073; x=1786974873;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p9xyAn8Lg0NoyAHqpv5vJx0s8xXpgjfKFjqU6aFd+h8=;
 b=hNhPE5nHxeHo4lwiN9f4EQ5xEA+OoJhIrkwYKdQ693nPyCRReaLnbray5nWdvofug3
 9LqAIumsLbXXwZgKHLQbmdDvkn69VuLBSjVY8xTjGZ8oECzyMUdBqlv8EtuwrX90v6ha
 4b95RntNC/rRhzYkP55mqL7bmMuWFSZrkjd16ehIKm+mlc0iLrMWw9EbK4oN9db4hwjx
 kgapfx6YFm+SoqxeFM252arkbeoBYGNrIFpYXJ0Jvfri2H12/h5y8zqITGVeVJt8hrmH
 4HxEKo16v7x26Sr5HpKi0Z6RwdiLCDHQEf4NB9otfZ2oTTlrCt9c+xBUQoe/RuACFILb
 JGAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqjNmb3+XC9Cbk5aB2L0LGsKhe+WJ9ySq7KyJyNxhvugG2LI4Nuf1gYrfZsT0fTzPw+tHZ3GNjRzo8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5qjeV6GtT3UUZmIWeAFwGnDeIRNHTgp29guzPTH7KPlvZfjD+
 t5bMVqxE81XDreG78IBqqrHa0gCQ+1VDT1mZjio/FdUdOufUFItId7633DJA6WdgJb1haGooZm3
 KoShYOyLGS1dWYnwSKpfqmO+s2an1i+4=
X-Gm-Gg: AR+sD114mn5QCfrgtICA5crQdLMr3aL9oAItFdsFB0D3ocZQZnuAkdG9DlCWjSFJjh0
 Zkr6aU8hQra3f4s2TCdIrq5RFDVXaIug33u5FYE1vfz3umN2i80SASZJAcw+hToNFRX13bSm4Lw
 bxqsoGh8/82rCLPRxadBgYxNJ5h5v2t8ZA/toRTAVq1vL80Qs3Rcc6zOIkDDOU7797/f/TF4HVE
 xcuvWQjosCYgvWXlNx66elIGZaHpXP6kbkzpPusUY5XeH1Ljjs1+zjG0vMqClO2NmSrvRyWU0eE
 6EdTASQLAXE1mInVQVEwpxkDqGo4QU9/7Okg2EMBRZ0r0xKLsmml4xNp
X-Received: by 2002:a05:6820:61b:b0:6af:eac8:3d92 with SMTP id
 006d021491bc7-6b020d07120mr16152598eaf.0.1786370073399; Mon, 10 Aug 2026
 06:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260807182724.51018-1-edu042sjroy@proton.me>
In-Reply-To: <20260807182724.51018-1-edu042sjroy@proton.me>
From: Nathan Lucas <nlucasgit@gmail.com>
Date: Mon, 10 Aug 2026 07:54:21 -0600
X-Gm-Features: AUfX_myUu-ArGszJDp2Cn1wiukv0NiNHLNsp-_BYLWCFlqUSwVDuG8CV7uE0xUY
Message-ID: <CACNCB+=r4dAU4+WF2wGzsedbP67ZztWb8xE=CHgAf92BUhmxzA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix BT2020 YCbCr limited range output CSC
To: Satyajit Roy <edu042sjroy@proton.me>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, alexander.deucher@amd.com, Ilya.Bakoulin@amd.com, 
 dri-devel@lists.freedesktop.org
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

Hi Satyajit,

On Mon, Aug 10, 2026 at 12:50=E2=80=AFAM Satyajit Roy <edu042sjroy@proton.m=
e> wrote:
> Add a separate output CSC matrix for BT2020 YCbCr limited range. Scale
> luma by 219/255 and chroma by 224/255 while retaining the appropriate
> limited-range offsets. Keep the existing matrix unchanged for full
> range.

I submitted a patch series about a week ago addressing the same issue:
https://lists.freedesktop.org/archives/amd-gfx/2026-August/149741.html

The patch specifically addressing the same matrix as yours is:
https://lists.freedesktop.org/archives/amd-gfx/2026-August/149739.html

This issue also affects DCE as the incorrect matrix was copied there
too. The full-range matrix that was retained is incorrect because
it has a limited-range offset for luma (0x0201).

Why did you use 8-bit normalization?  Other similar nearby matrices
have been derived for 10-bit quantization with 1023 as the denominator:

COLOR_SPACE_RGB_LIMITED_TYPE
COLOR_SPACE_YCBCR601_TYPE
COLOR_SPACE_YCBCR709_TYPE

and in DCE:

COLOR_SPACE_2020_RGB_LIMITEDRANGE

As an example, COLOR_SPACE_YCBCR601_TYPE and COLOR_SPACE_YCBCR709_TYPE
both use 0x0E04 for the R-to-Cr and B-to-Cb coefficients:
  Round((0.5 * 896 / 1023) * 8192) =3D 0x0E04

Your matrix using 8-bit normalization:
  Round((0.5 * 224 / 255) * 8192)  =3D 0x0E0E

Thanks,
Nathan
