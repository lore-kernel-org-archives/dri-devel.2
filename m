Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0274EF8D765
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 18:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6652810E20F;
	Thu, 16 Apr 2026 18:21:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UAE6Fg+g";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 825B810E20F
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 18:21:08 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b9c6f1d1282so1136737166b.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 11:21:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776363667; cv=none;
 d=google.com; s=arc-20240605;
 b=K54VlphbhwX8D+It2ZPjXsE6FO0w9+/OyIhbZlQmRZq7HtXTtNJZC2B5MgopxYu0yL
 mMrTN+h6+Q1nvipUFkvSpmttPZL7njZcX1gmRIaKXIvL6ANapzYIOLscNDuxOwJdXamU
 ASZD+lnN3VYRE3Iq36yfwsVXTaZnjcNBonSXt3SoWYD+rT6eFuwVc9DEox99NNsB4ahE
 3bVjPXdXAHhbM7A9w2yvPf5giWlOyHwd2nWf68UcvfJJ6dEqkYRKdQXVn/yzFS4W6fKS
 HVP8pJiVPMlPaLKPt/7TU3N7YvOPsxodkrr/oBEk88/cAoW9LRnbdi57eV6wMv78aBZw
 c6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=axbeRxqT1s0AditMUtuRbScbflsIyHPPu8lfF8iZ5eA=;
 fh=8zT9MI0Au2xqIeimDbhVdtqNSzxXRU7fZxfPjEhrTWE=;
 b=Rbig5fJ5y7t5twbucJsCBG0tnmzCU0TR+Az04R9ECmmg2NSoAeoUtB+mN4FIqwkzuj
 u3BkCumdQ04sHG0OUyFalodYP+JKP0aOUaVwOXgZVyOSymfOohZzT7GEKX54tQylK/GX
 p1cHdXWqdzrYYsBuHoyAxx7lpye8oYeoRtSoOp6eL8uL9uNJAZR4koVRu+uofYl5YIun
 Rnv4zgWDm9NyLl7bNb4HD9xjCv6wHbfcZwNalUFaQydhMvFJPltqCnv6+uCdJD16g97X
 2glkIlzhJtv8ZpQpb28cBudDqQyKET8Mn7JyBd3H9od6pU3TLKHR0y+z44KhPGh9AVlF
 yQ+Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776363667; x=1776968467; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axbeRxqT1s0AditMUtuRbScbflsIyHPPu8lfF8iZ5eA=;
 b=UAE6Fg+g4VuHi+mWqd/I/ix0L3MxRKEWlfggj6keY3Kma420x9bJYFZj4+bxfyhvGz
 1hEYwGgMMqZq3up5N3KH3Z8td2UDWqz7mq2AfvY3g9OpkIBfm0cWY5HyqaSQutDrAezZ
 y3rWqdmGa4vdnk8TyVxQd4MXE0zJlg5RBHVvnQeXXp49xTtrAIkuvIkovi7ne6egM+uF
 tnmQiNYd4GeNuekfMx4ryKYuQPv+P0gU1Prx/900UAz6zoGHeNW5rHhF8RQmpGf8i5lA
 4SOmPdSjtSGo3CDi6vu2AhlUttuzFBnLK6VtecOsHkJ0mxKRHtkoq+aEJOOWQFrwdU/U
 WPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776363667; x=1776968467;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=axbeRxqT1s0AditMUtuRbScbflsIyHPPu8lfF8iZ5eA=;
 b=iiUKISzZGDgqLQ7MokPg7Qnf/0orh6Hvj6RxPUcYuLJ7XUJ8s+dH/tyotACchLapPH
 +b/aElesXTNZlxB66zou80bcLx5cAmSRtLU8om+B/DwwhtxfDMlfy0SNDyDv3ekWu+Jo
 B8InupKOV6cTzBRnCzUVxzsVvou4xNJexgqUY/yKk8LJ3cRYl/Iib2C7KRINLkXBvALm
 YJFqivGiwFevaPljNWDJ1QPt5BHs91An3QA17Af7Vo3YLH9KJWMGHU1RwOkBUw5l9AKh
 nSeVSRcyQormqG7GganRdzzGhBoIuEyNovmM69jv1GAdAQo6iLRyjAYYsL2Pt7p/QPNC
 NKVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Zowwme3WAlr16hwEWv8ve4XUVUl5XwN928AOVxTPjPaBQVVVKS+lW7/Qtod2twW1u0KJofe1Q9kw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwhMXO1wfNYkK9YqFQtoWr1TQqWLThqsCypQQ2gvfwiVHbM/pxO
 KJ6F1UTaexeFvHS/wuIa4Gf0KpxpRCgPMXeC3niaiOieuYDBmA74mmcEc3wq11Zc73MdHmspm3W
 XwGovGex/aqFSd57TZiWNdXrHVpBMAMM=
X-Gm-Gg: AeBDiet3Ara8BPGkDP2hjLXzkoTCxMuIgnhIBIXoy1hEkEctfzsDHlRCUh1YI4oHwzQ
 Md5KNdmeGYasvGnuLlp+2bAvZqzSCOJagjq6NWOSA955nuTbl+0Vw8F4Xah8mQNXrxiqmGfo60z
 uze1yLrEP8QYBWipm9xZQJ7zSTEobz6dsIhspAu+kmIMhX1Kv09NzhJeBHy2WhGpeUX9bmrkSSg
 zvQMjcIod/DBQMx615JtCGOi/bwYDlmLyRFFtm+dwjgn70imueOaMg5+j65cSVqU/lPecJ8GQe6
 fvtvjLBo69juZ8Ab1sXjABbexv1E6JsTDPSdsmP40myOrcSna3rbC92PSAluoMlzk+yl0C4Kx7/
 drs0F2Bo5G/fkuUDruA==
X-Received: by 2002:a17:906:5191:10b0:b9d:ffb1:17aa with SMTP id
 a640c23a62f3a-ba3dbbb5f29mr24027266b.24.1776363666733; Thu, 16 Apr 2026
 11:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260416164643.153765-1-sachinkumar905846@gmail.com>
In-Reply-To: <20260416164643.153765-1-sachinkumar905846@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 16 Apr 2026 21:20:30 +0300
X-Gm-Features: AQROBzCvDnFVFO9FhekHLkJwL2CmVDwz0QoG_VeE5ZobTgU6bLSZcij0D7r5CgA
Message-ID: <CAHp75VeFZ7PDV_tT8tDibQk-VPkFFHsxiAHOAx-9Xp0N1ijvAQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: clarify TODO comment in fbtft-core
To: Sachin Kumar <sachinkumar905846@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Thu, Apr 16, 2026 at 7:47=E2=80=AFPM Sachin Kumar
<sachinkumar905846@gmail.com> wrote:
>
> Improve wording of a TODO comment to better describe the
> intended optimization. The comment now clearly states that
> only the changed display area should be updated instead of
> refreshing the entire screen.

...

> -       /* TODO: only mark changed area update all for now */
> +       /* TODO: Optimize to update only the changed area instead of
> +        * refreshing the entire display
> +        */

Wrong style.


--=20
With Best Regards,
Andy Shevchenko
