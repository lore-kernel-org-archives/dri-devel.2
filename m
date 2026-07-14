Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E95C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82F110ED43;
	Tue, 14 Jul 2026 13:32:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CmGEWkHQ";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4478610ED43
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:32:52 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-84536ecfc5bso767765b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 06:32:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035972; cv=none;
 d=google.com; s=arc-20260327;
 b=nXioQ4kGORcsODPVV1kh4++qCIJCJ3Mb4nTZsw6mFuTiVVNIExAf1JwSs5RRl3RLBI
 eYysFqnTv3SjmBISul5005MfMBtq8VvlMGX9GVmKslrFY+TXpxD0jRYZTNXV6r0BKWx5
 MxNVuzbBkgEfH1dN48sXdESdsip2nOVKxVh9OBDau6CipNtVYS0Q5f0gs1vCWj7HBYVL
 M4kvNh9uzM2JTEdbRjaf5heO8JVtwv8hZOZedvY6Zb6V6PYm3OBb9TE2xMx7B2MauAq/
 h4WgxtfqUifmh/8LihkIyD7j0qRLiKeD3/skHmppgRjptlA2nQaoPFMUb/YrGXQgrApi
 Zcbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xMYgbeZWEkYZKWpJP/1b9kbmlPmh5Bba+PqXdvA1L9g=;
 fh=OS+R+2xuASKi35ILcKY3H25UDG8W9QImqNsCotyv9Dw=;
 b=R738PfDT2iYz+3W9XlDJvPDSJV4HEQypmkwZGszsVJA25t9nmNMllShhDlruRld5hO
 p+DT0hoLoAw8R9bOs8HrmZ+kLYX01+JyTAwxcDagPbvDkKY2FzX/3fU683UBaLZjv6hI
 b81CGg7T409t9H7wJ3P0/+WCe/OPIwpDehexgcE0E32lKGCLs6U0KbYvrQqCiE6hERu8
 hksdTNJ13yqMBMfOSTOmtbQ9ttOv9r4ulxt9bCdARqu1b76B/y4NLY5vaHM3ieO8IHtP
 7+st9czkuO21ymwrVHotoO+dkSjvoby4coAbc8AKEIlsTgIveypZ22K4quXggGfINzLz
 mNag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784035972; x=1784640772; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xMYgbeZWEkYZKWpJP/1b9kbmlPmh5Bba+PqXdvA1L9g=;
 b=CmGEWkHQ6AeTM3NHnUkBeAv/2NkCvA5QJ3LI7kcDAVcSUkYjL9ptwnW/8i7dAIlCD1
 c9w84mdr6H5lyzdRsldn4iH4Pikerngo9bYrSzALdoeR0HI1XT4MvSJ2CNZL08dUrAIM
 bskoevcCFnsScErXVFHSRwdqx+AiHjcFx4kpzD8ila+F/XdzRf2WmUlkP+qVn2X8GrqO
 LYBCjA8gTSt4db/W3StqwoK+qnjypwMYJPseJ843edIn+CiCVugt3v/0BYOqmm0HcvXf
 cGDanCadcUvmxG6vuw3cDLXjVDTfGS9dZKZuCnVeJ7Lvk/RdUtf6RgzRZInNNQCOwpJz
 VudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784035972; x=1784640772;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xMYgbeZWEkYZKWpJP/1b9kbmlPmh5Bba+PqXdvA1L9g=;
 b=oHrndBnngfLyWC8VxiFoAbPVSKMw3SuCp4aB/fPJk8eNjzBBERmeW+ua6MHapXRu0q
 G/XlXaIE4s6ioFA3Et9jg+uWfxBFwA7TEqK9wMUicReKgdYosXz6P1YsHo74IKfp91Ww
 RkOi+x4kj5hkEgfYe3wqIJWTdgV6l/Rgt2l+L6KDw4JxialTfRjxCtHwJXniasCSB0x6
 ao5IEektHg3Rv4BqY2zvN1HRkHJwqrOXPpm0OVGeREmWDfAjQPXDNk70XKGquSWf654R
 vMztyOsabl46/BkOGZnshJWdB/BF9VadI7DTnaznXxTboBdf9lKnYJNIV+N4xnN4ibmh
 9c4A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2Q68XNjuZpxsRylcBmeA6Ph5JchuOPUS1H2SXTeV89bUlXgSUk4cAsD8fLCqkMQ1gW898r0oaVrg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNQWpQ9mlwbc+Co/8BX4amoRsNjPKqrJyhjdmBWUY2nZ3bxFhO
 GEFILoYmWT34hEghn62rJXYSVISQJQ7xIeT3jluMvahef/lJtrb37tM2S6ZNTF5h8xYEpLiqQ74
 mouMTql6sAcsG4JzbIZGpALdCxnyhGM0=
X-Gm-Gg: AfdE7cn0fQgm5bNl7Igk2LejB3bcJPZS2RJLnfUKTEbc25nboJmQt/hGo8yffh4TU1x
 6gdXIXsXXAGBmM9I/K4ONzTIal8tmR3OOci7LsOzmYP1mqom6XEAtJTY5MJwsbJli3adn/ms8rD
 0YbYP5xAO9W4I/zEnUpa++E91RJp2YLhajSUDmGbGzes2QYyl1jdDr976bATMI+mYJn0J6e4b1p
 O6rurBOg7ukFHfYQWFu910GxgPlfR7yoRjZxwUxfyps4oyRM7n+Rdice5Ia6HlVz1GlpgHiH/Ys
 EOTci9tdsvirIX+Tzits1YIZNttHIQ==
X-Received: by 2002:a05:6a21:398d:b0:3c0:9c19:65c2 with SMTP id
 adf61e73a8af0-3c110a7780amr14294440637.74.1784035971780; Tue, 14 Jul 2026
 06:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-7-clamor95@gmail.com>
 <akeHfV45fs_wabFl@hovoldconsulting.com>
In-Reply-To: <akeHfV45fs_wabFl@hovoldconsulting.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 16:32:40 +0300
X-Gm-Features: AUfX_mybrBIYYttKuc4kdlGjodzpsKD3b6Tkn0zZS6Q6ac4kDrP0-C3ai8FD94Q
Message-ID: <CAPVz0n1groC-4MxU-sjyPEDHYWqAweyBmVNC+iX4mVa_D3SnDA@mail.gmail.com>
Subject: Re: [PATCH v5 06/14] mfd: lm3533-core: Remove redundant pdata helpers
To: Johan Hovold <johan@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, 
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-fbdev@vger.kernel.org
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

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:57 Johan=
 Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 17, 2026 at 11:00:23AM +0300, Svyatoslav Ryhel wrote:
> > The lm3533_set_boost_freq() and lm3533_set_boost_ovp() functions are us=
ed
> > only in lm3533_device_setup(), which in turn is only called by
> > lm3533_device_init(). Incorporate their code directly into
> > lm3533_device_init() to simplify driver readability.
>
> Again, this isn't needed. Why are you removing abstraction that improve
> readability?
>

Adding helpers to wrap custom regmap wrappers seems redundant. Regmap
operations are pretty self explanatory without need in one-time-use
helpers.

> Johan
