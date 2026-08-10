Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5245C5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED7210E6D7;
	Mon, 10 Aug 2026 07:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s0TYwEvc";
	dkim-atps=neutral
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D62A10E6CC
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:07:36 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-39c7ed5410bso5618051fa.0
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 00:07:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786345655; cv=none;
 d=google.com; s=arc-20260327;
 b=pGukM8jRycxBd0QAv4mC8jznvmcIxqElKQJmLLlCd3sioARQ1KnMm7tNSfYQNFhKTL
 w1BE92JNbfp0H7ffHcpGtYOlPDqGAwuXd+SCr/nl/mZFnFAs1vucEtHox5RjF8tCz7mA
 axIryFRdUVboLuR22B2FlG1BFkf1n73kk8acHc1WglV0dpel5x0hXYoLD5sLFGw08w+w
 Np8CdSjQXe6QGE+jInyKyIxi3rg9RDhaSLPzuE3M3e2cGJSpmuQfv1GKhtIQBOQ78Y0e
 1OAT5N2WPNPhsbEB9s2MSzMv0noMKuxCL2AOZdpeRNqFNGNZW0uS9n/ZDRkFZdO+t46X
 r/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t0itK36weHoU2jtoEAt96DrFUj7FEsHjlM30gbeY12U=;
 fh=1hQyGlGc3MVhy0+tYL5eHDrWOpbCVPVxcVrulK57UKc=;
 b=AirutVqYgXVCdHfKB02F0aIkR9QmF2DZ7jQ6Fbs4qorOToZlNROKsR36zfaHSkbCsb
 IiP3hIpUM8vpGK9/FmzLTrVU4e8bGGwQZBiBxBDkVl9kgR072I//K1dt+uaaGgolTAPf
 Vp0WlJYj0u0+ta2XYuheRxYxuV5IogoZbo36S5YznatpLpyfvZKMa6+nrgK8trPG3TWi
 SNj/YM+8cQoNFi6FZJrvjoVinAphAlIcmeeOELdt9N8dtQy3v7nE4KGsSj3eeH3XrL6X
 UO3fGr0g8b1ERsgAXeP+rdYIFJ7h/R7iwQaEAn8eBp0wPkipUhS8wOvihuZx+esMNceL
 I5JA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786345655; x=1786950455; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t0itK36weHoU2jtoEAt96DrFUj7FEsHjlM30gbeY12U=;
 b=s0TYwEvc5pGY7ehUJZ+e0XFVWdKcPzR5dIbuAJb8YIn2X1n4pxJ4UMs92dK3S2Dow5
 RnySe+uGLbR6ATL0Hleope3Z6YCVnlpY+UEA635Ng4RdXt7gHcll16X6WE11GEughpC9
 n4YfjApMGM/6SLOkDUPa805674SKjYrNKfjDKA4cLpZEAMeD2SJZe/hwOVlp6c6rtvyy
 nY2tnTHuePME7d718ODPHr5nml7q+x2TjburkzWAi4Jx7p7S+BJE1xB0FT8BfMPjtjH1
 rtTHcScQjxAIX7vpebKgX1BEeele865SRwNcKHX9tQqjsKURxWYAjq2UQea+KD9RNVww
 sSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786345655; x=1786950455;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t0itK36weHoU2jtoEAt96DrFUj7FEsHjlM30gbeY12U=;
 b=gXWXcC2VzN+WuGC5e16utvx4Trh2Ra9LXgCoZYwMAU9t/YF8ytvsWfhbaeEQ2kOIKY
 nec/1n54Nh3hYLKR2zwN0J1y7l1OYG6e4ABUehTYRHzx7ULfBI5VfyBIfo1yvlwrsx/v
 3PCp3Us0DaV7VERfb3AcBIITRwKq0lXEaEw7ZRdqkn0Do4uLALqKCAyIZRaLtREMPt9p
 +7zq7OpnTQGxC9ZD9Fw5bxfCDP52CRHctluWLvUfOAoTFyK4wB1uOZb61to5WZc/IGC9
 WlPqQ3g+uDt2lutqiHoRsmOEdJBL08xu4gTjfLBGvJRug6Ih1rExVKx/beXhdQtONw5a
 Ee+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoftrzgU/kTydP3WMO3uG+XE9L7vhXtNaf1SFJjdwkuOykdZfqclcQAl+ReT2y25epR8JvsTnU/vSU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvxJ9et7X7Bms7JNz2COArual6YSBD5kKO/DHhVjjhsZZBFWYg
 MRvDHIa3HgR+HWya3zZzJ1BANlFPPbu2hEVZrbbVSdjeYkLfUqb/DIEogE6thuvmmysZ45Nzu1I
 g6tWu/88PJvWO1JMkaEUqtjBa0W2P/gU=
X-Gm-Gg: AR+sD11gGsdLPT3QVfxADLwRPEdNnsvnItSUR8V+tr6AISryJhNBd8azURGTQI2FowU
 Ga5dNVacO8+XhOwYqz2DzWjX8hAFUFuP3l9EbGfqCxY37glPbWQ1CqZJycUrFPgkdyx9x7BQOsh
 /xslh5A5orWx6UG3BkFpCzru6hvPBedCxHB91oePTgWPI//vhmHYFOM66xg77PRui6g7lGONR+F
 3nL7ySxHAX3ALfTgqc0eaueAdG31ssXdiesSCjhpYB++YxAthvycbIn01h+n86xoTPdRGYxvwSc
 O918nBk5vxotRXFZRJlJ3FP30NDtqv7KTAuOimNeMrqrpFTAvouyzrgoBfPFys5xf4Gnobva1Rv
 IlY2nQEE5JaRtOtP58EUjFtPp2jkB2WXy2byXrFl4vgAfO8WNmH/xBJEmiRZAm0FJI7PlYlsL7z
 E2Wkk4+6wLwIWWq6t+RRpwkiC0CI3ndHm6pQd9RPA+uA==
X-Received: by 2002:a05:651c:c8d:b0:39a:cfe9:247f with SMTP id
 38308e7fff4ca-39fbb301b83mr46526421fa.31.1786345654462; Mon, 10 Aug 2026
 00:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260809053253.14537-1-amballip@gmail.com>
In-Reply-To: <20260809053253.14537-1-amballip@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 10 Aug 2026 10:06:58 +0300
X-Gm-Features: AUfX_mwVA-ExyPEAQSrd3nXoSIktRzqRF1T8EbwlfOAr0G0N12s_EaUlhji3NvU
Message-ID: <CAHp75VcFkgrcBKJcvm8Br164MA8jM1xRKahBuZ-WPgEBwfi5Fg@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: Fix wrong controller name in fb_bd663474
To: Preetish Amballi <amballip@gmail.com>
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

On Sun, Aug 9, 2026 at 8:33=E2=80=AFAM Preetish Amballi <amballip@gmail.com=
> wrote:
>
> The file fb_bd663474.c is a driver for the BD663474 LCD controller,
> but the comment header and MODULE_DESCRIPTION incorrectly reference
> 'uPD161704' =E2=80=94 a copy-paste error from fb_upd161704.c.
>
> Fix the comment and MODULE_DESCRIPTION to say 'BD663474' instead of
> 'uPD161704'.

LGTM,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
