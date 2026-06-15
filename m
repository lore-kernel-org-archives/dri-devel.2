Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FF9CD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:12:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AD8110E21E;
	Mon, 15 Jun 2026 07:12:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U2Fe33t6";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF5C510E21E
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 07:12:32 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-bebac79fff8so360487066b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 00:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781507551; cv=none;
 d=google.com; s=arc-20240605;
 b=DqmT/Jwj09+puuhHc4EV0On6tabqkBMwkS67XnQ+AeN+ycdRkZo21wyoaf5Qcw0pqi
 1rXYBQ0Z/pGK3zbu3SFdRqPrXm/DGjayCmv3TufhAGsIzL8PYphmURf1UfmIzngbs5iz
 Wvy7i29vPgv5espEyGFtAWDIuTuq+Uch1tHsd0rUiIgMuVsQ8YRWqO3lAGti7X5SCDCl
 UkwW4GwJNnsRb/OBsKEICTlw8CnwYW0mrtZFRUl9YWHHTcZsSUUisXchbtVaRtOB3e/p
 d3V+gYChL2pKzBSyfMr8YnM4zi1uTv1uoRRWddWTwU5BM7sVnHVBojWzYyI8rV/z7z5R
 6PRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FzhraAC351YoE/9WyaNWJaPNFlY7jKFOVa/EdskiQPI=;
 fh=nqY+lOlYz8akb6mRhAqtz90ZKQNfYSHOU1jXJZc1WJk=;
 b=Eq+QO5Ownm0cqoTut2za0Dbf+UQHMH2bvIdcgy+5/4d068vypInyO7zWm6/BieF2j8
 F4EUmStWhOVaBwI9KwqyTTUIE0hgfZ/gBzwCtBwAMKTdGF8tqeYWhl9qKy9LRil7cLP+
 H6aoBA3xqjGn5Y++dS6c2OXFRFzw7Azr+zod6QfTg+XJwY0Xyuu+8pUd4s775VKXKC/t
 ii9TRlxiRaxetc2d6U0/E3oAVF/NymCmyU0t68duT4vMqdW48yo38D2wn9BLEOFKhVn4
 UbaAaqDCWl3fZdEeXofktPz6ZZ/4J++dYdOpm+kc8g3uQGqTpH8PSFGIpNYixyLHAGvK
 paQg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781507551; x=1782112351; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FzhraAC351YoE/9WyaNWJaPNFlY7jKFOVa/EdskiQPI=;
 b=U2Fe33t6y/URmHTYaC4dl5e/evB44eoGmODdKgXmxLyCYnbY61/9rlLVuvPucUZl5G
 ybWsE4ORj4vx2xdRXMwgmAj8UUxAHEdxJTBJG+PAt+FWwwofhsvxDLqZqC85mdCRccPl
 UAhMQ3x6rTXqIK7SLBCSRqJl2iBpNcMti3J9HXBnZHc9amUNZbv7kF03tJmLtmRIPfd0
 eV2vQb6iKp0KIVK6a+Ji3ohFSaQOhWNOYtBuELFYqr4l97HFkl+R2b1GG+9JobVMzRUx
 VJJuPHcBBF5pWUtGal121dggD2V7lGawzC4pZbFYTxLo/TJ0K7lmzOXB3cfukVcLdLUY
 34cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781507551; x=1782112351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FzhraAC351YoE/9WyaNWJaPNFlY7jKFOVa/EdskiQPI=;
 b=eF0U6dA+JZDFJILyKaZB283huOvEk7s+7++WgT2yltW7oKna58LnjSYcBwAvDpq4ir
 t/wzn6ZQ8iEYCIapkn+/8antx/vOBHCIwlgJyyccsryIcDHE7dtND3Hgb+MMSkeWfF4P
 QwuJfz6XI1P3IkP3x1JK09wmXFyshlgCuxYpHy70I3Ps7hCYtrqb8c6ubop9IkYfbZnC
 4PxYMVq8AwAqvVMfb1hK/g7Z7ftDB6sNncLJFUvf4tL6alHmh/xND1m9Ap7YGPHfhra/
 RSmxBgZeyekTMjMdoC40pmUkusjXnvoFN9LbkDbO1eFpYoDgkgbfenlYFVT0QpXhf5Yq
 IHbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8daazE7b2AXdgMlNGlLhKLj68H8hg5Tl2zYBQeCOtSrmEszTSBmfpedx58hL0/PAX7g8wM7fILMC4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxC41Gq2XcXe9jYmIi5yJeojNNZUOPZ+URCdFyEVfgCpQI6NHa
 9UqZg32cEvomLwF04vlQxRcJjqnu64d46i0T3rJypKvg+l3TCx9Gs/5KwUDpuGWtptikCn7VuMn
 zQcBouuZyZS24eHbMc2QG3yRH1WP51Bw=
X-Gm-Gg: Acq92OGg7x0mBJ7NfuYr3lnF7QMWKExobDarwDq9VhFcX/24z2z9wO12+RKIUpoVgN2
 tx/VQc0smA8ngucSBycc2esi71pi/j8ev+tx3NOfN66iSc2N4if7Q9ErKwPj1mKdOCRjpo05b2P
 Qz6IiKULseBi/F6v//NKw5FvIonS5yA/PrKepmSQnZ/CtIDnH2r7y7/jYnHVko9vjXB8FNOF23a
 McL+W+DDjIASBYgjdH4ISZZOHmNPpsUSkQj/a2PZNFL49F6tYs89fCqhfJJDgfjCx105RIJbEW9
 OoRM9Z39pxHqnxpfHjh2OqvTInFO3gJwwP2aRiXYUE4eHO/pVQXdXEi9hFVFj+VUL26uKEHBqJq
 2g4m5jHzQUBJgIG/qmGBCVxigDCeLEDsnLLMrGQupOzdhmpUNHmMOVGRkrzEsGgOzqVf8
X-Received: by 2002:a17:907:1c9f:b0:bee:426:87ec with SMTP id
 a640c23a62f3a-bfe2a21eb9dmr597482466b.23.1781507550955; Mon, 15 Jun 2026
 00:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260614201551.20542-1-reeveskeefe@gmail.com>
In-Reply-To: <20260614201551.20542-1-reeveskeefe@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 15 Jun 2026 10:11:54 +0300
X-Gm-Features: AVVi8CeSC29eIc4U_npHh4CvhBaUd3ShetIXEBLYi-0z2YrMYKXv9Qbr5BF-IPM
Message-ID: <CAHp75VfkVQ0JJd4+ceniNnij8t-PXsrNOfof4c6NDWf3KW2s=A@mail.gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: use %pe for backlight errors
To: Keefe Reeves <reeveskeefe@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, abdun.nihaal@gmail.com, 
 error27@gmail.com, chintanlike@gmail.com, namcao@linutronix.de, 
 niejianglei2021@163.com, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
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

On Sun, Jun 14, 2026 at 11:16=E2=80=AFPM Keefe Reeves <reeveskeefe@gmail.co=
m> wrote:
>
> Coccinelle found two places where backlight registration errors are
> printed by passing PTR_ERR() to dev_err().
>
> Use %pe instead so the error pointer can be printed directly. This keeps
> the behavior the same and just makes the error printing cleaner.

Oh, nice! Now
Reviewed-by: Andy Shevchenko <andy@kernel.org>
(for curious ones: you can also see my comment against v1 of this patch).

--=20
With Best Regards,
Andy Shevchenko
