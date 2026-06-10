Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BEDCD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00C1110E9F0;
	Wed, 10 Jun 2026 14:41:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cCIetF3f";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB0AC10E9F0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:41:08 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-304d0ac5e3cso1741785eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 07:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781102468; cv=none;
 d=google.com; s=arc-20240605;
 b=PFTtu0h75pXPF7thTk3y/KSMVNxwOwWNH1Z3wvFKDGhQeWvMn6S6SXoqzeAsBKqXfT
 tUT7gjXv47eEsuk/Z2jxmH7s6TQsw3fJ7W78ucu/zpEZHpQubV7iq9pIlqqy9Ztwf6P5
 n9BWAicifGvxuFccqYUyS0lkg39jKqD3KglHqVcpRGpM7N7LMCjWsE5F7Iq3G70zE/OZ
 GQiU3ehkdKfqsJmjERGuox75Yyt40xp4K+p2eIAyLZMwyJHz0/oqmIWQpcXgAGPk9Gjc
 Fjs18TlMOXil7Mx7X2ENpOv6q2wE+m1zIfl7XgB9XDK7GYnU5RKcOa0Dhwu1bNoKiYbe
 1+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pji6N0wT5lk6iw8ewt/c1NaXvzId0tCzXut761rthuw=;
 fh=krDq0gCdAJ5qkZCXh6zsBaXNepPZA1ysKsASVt9Z21A=;
 b=IEmDYhvlu+6e2WBsX2gfK4tGZ67SLoRJwTt5oNuXLqrwrtAEV91ZYkV4/Hk1+uDFrd
 awsz5XU8rg6gDIfCzD8+J0fOr87KYAINegUp/X3zFd1P3vv3R1uKLcc1C4AqFVSbJh38
 JDOqSovk/+IXcLLVkF/21T5TboH6HZrkO/yM24D6BrhYf907fiVwTcCKlxzRuS4mjUAL
 +BugSNSXWS5744Gd0dkBmQ9JclnwFYZ5iOLYKmngHuCi3DZuU4jwY2r9j96FwaX4B2vk
 c6S5QKsX/Y342N/SVzSvvOikKCIgjMoQJxYNEo9UQSVpxyR9LeQJxr6aT002HmN70Sdc
 +DjQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102468; x=1781707268; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pji6N0wT5lk6iw8ewt/c1NaXvzId0tCzXut761rthuw=;
 b=cCIetF3fDBibz+5b1O3+Tyed8LLlcQgXMOdHNwSl6xMVONF0PVm3I08BGVSUvpq09y
 EuTMl5YpxliY9VrdTljyRLs8O40BNaZ5/hmhXcM1CTjWDPDvI0meIHxIw96ZAsXpWo2d
 p7mPuJCILCZtft6t9bmSmuFOQCqz6bbQ94OoKO952zcKSj2osWT5xixpEY8NaDPJYlnb
 njyH3KxEVBwSNkxtUpphxw5tdSGe8sGP7K8+H73uN2BJdOZxjW8EXwOxgc7a2h7NyKOb
 AKjm6FBCrhx+iC5CpMn+G6zDN33N3LHYYokbkd3xxUUvLxmW6doDJ4Jp5pvAlnpy5T3A
 vmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102468; x=1781707268;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pji6N0wT5lk6iw8ewt/c1NaXvzId0tCzXut761rthuw=;
 b=UZdDIuna9DEMJyR4BA2OlQdkk+Usj9EPhQoXA6ZaKec9i84otncDo6V31pUklgED/P
 3ruiTQEH6fq5ejT6Nmos5Ek00OcULiA9nTVabsrVU3VH0I57Bg0gTko5obUytWBlvQ0d
 Pi60JbL4sw1fmEmt7Uz5G+0f7X7f3JQZVvHx9DqRDUuXwyos4bTRvJJSyDZcofIg4SSG
 3WzK5grvkk9Xlu0TgQJjz/Wmy8nIUUQD2IkPzarQ3jACWeTUBcnLgVQKuYjC+NjjCBER
 goriDYfWC95H3QwpLxqEKn6KqCMA3BHEbIUbEK2cgkVRkmdWZO395ddSiGFNaNGF0FZp
 zsiQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/N5AH6BYT9Q77P06OJd9rqvS1X5wZW9h0p9IrhT4dgu4NJeexFlyLmJcabuBqqhGcKwNcV5LPsrvU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSKjg6Lg0HLc2xfh9GToNfLlpkj3nx5dyOE/ASLSfhSU7XQnuK
 /bzNb81kXH58rGvwlWQ4vu/x+Y29JcxS5x6naRWldS0Tign6BsoTOoe96tuNfPzqbeBcEyAX+TF
 7HTlcPZJ8IkKX+c8E2B/dP6icU9wE5xM=
X-Gm-Gg: Acq92OEp+pZLaS0pZRRNILNJ0mWOuFYMY404De2FS/UlHGyA192n8FsLioMVSCk7Noe
 dRBO40SlCe2hHDfXBefcccnJMEYUl+ixpVfTqFQbSTsHbC3OhO6+pRUFKqafCDEDbjZkHIDkvyc
 i3Ppf/gE8zsl7bX9uHEzdY04cTKh6EzTqIBm/5U9PJXFq8Z62boVN5HFEoulqEzBfHsg0YUuave
 xsEueTFPgpYoAGMzJReWWbMiZzbIP3RY+FpKVyIYHJFrqFLd+b5/wjwIsfYm5DCdfpDTXAcZO4P
 vG39bTSqjIoEOAL8/7g=
X-Received: by 2002:a05:7301:678e:b0:2de:c5ca:c1f3 with SMTP id
 5a478bee46e88-3077aeef992mr17016589eec.4.1781102468242; Wed, 10 Jun 2026
 07:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-11-clamor95@gmail.com>
 <aihm315UtdqJclhh@ashevche-desk.local>
In-Reply-To: <aihm315UtdqJclhh@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 10 Jun 2026 17:40:56 +0300
X-Gm-Features: AVVi8CcyvQrrDJA2ZF-oz3jxiSwxgRbJF6e_otLwcACmPvI2rKDir5j4hVf0fFQ
Message-ID: <CAPVz0n01ymfYGH+_MgfHvWqzg+tczLi8E-1q=rZ5cHu+uJrpdg@mail.gmail.com>
Subject: Re: [PATCH v4 10/14] mfd: lm3533: Set DMA mask
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
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

=D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 22:17=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Jun 06, 2026 at 07:57:34AM +0300, Svyatoslav Ryhel wrote:
> > Missing coherent_dma_mask assigning triggers the following warning in
> > dmesg:
> >
> > [    3.287872] platform lm3533-backlight.0: DMA mask not set
> >
> > Since this warning might be elevated to an error in the future, set
> > coherent_dma_mask to zero because both the core and cells do not utiliz=
e
> > DMA.
>
> Hmm... I am not sure about this. The entire kernel has only two drivers t=
hat
> do that, and thanks to their commit messages one of them pointed out to t=
he
> commit from 2018. So, if no other devices suffer from this, I think it ha=
s to
> be a better way of achieving the same.
>

If mfd framework warns that DMA mask is not set then this must be
addressed. Why then there is such warning at the first place if mask
can be just skipped. Then warning would be just a debug message. What
is warning today can become error tomorrow.

> --
> With Best Regards,
> Andy Shevchenko
>
>
