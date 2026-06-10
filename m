Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C3DCD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3255710E9E8;
	Wed, 10 Jun 2026 14:38:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kqi/QFE/";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F51210E9E8
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:38:51 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-304ddfcf72cso7218888eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 07:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781102330; cv=none;
 d=google.com; s=arc-20240605;
 b=I9lRLPljEVSJH0XISY5Vf33B8xStDKbxczYdLTlbzQ92+q2xc+l+k5I6fhqnM3OwBA
 +x4/8hMBL9d+92ElNzyIXPA6wlddbnyZq8nQCwJl7e+tGY7nhCvEJrG8M40rCaapf87w
 l3HrIt3CN8njedokr0fnWeQX4SbC0u1nxvwSR0gdq1Fd8L9qnenhB0ORjBs/7ksNhTqf
 5gxmPn7kYo3PvEb5Hn9ulumynaaJ1Cr1WaAgohZA+l3d1i0vHDTnfDy2IDaWT9kEMOnC
 hRpP0ffffvmIBFmExgij6qZ4fBKhRhEDxQLzG0hWVCFl64YnTOFZO/y333lkKMMGdp9E
 vb1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xEmfQD66YljQgfpm6pWxKEM84AHfr3eAJ9XCpH6lBeM=;
 fh=iKbzkH9bd5U4bf45WNijaJvrPZlsDH+B72GejKtjloI=;
 b=T0rZlhjrQqyQuv7jaT39IvcMNl1cMedqMs2Zw1+FwFowHvjfPzr3+kIMlP3RbNLUkR
 3MJBxuDPZcwbtGw0ReBct8EGVq5QZIQXNOcqvjp0fX86QGY2xgxizUppXj2O3xkHCQC9
 xU7tOYVOoSOCY+qvUHyflnAoY+fnKKURT+X1KMWRpK2JQPA0MpsVMkZWK1zRSguFdx1Y
 JxHBtAI4faliX7XHpmNHyVKobUL16yp2Chv8qvRMmLZ5dZIdOc0vHiy0vGxNSpQrA4g4
 /zfOsT4+cFrU8fm6UEvsdNOtiZuFPRVU7PJXF9oRW9FWUvsuu/I7EdQBuVDgWwHWjc0f
 R7AA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102330; x=1781707130; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xEmfQD66YljQgfpm6pWxKEM84AHfr3eAJ9XCpH6lBeM=;
 b=kqi/QFE/ANIAvc442LHiadKnlvxHAgMgGkfMsCr6ht8eXFz23hTskVRb5H+nlTOviQ
 cBAJ3FBpl6UDepSzZ+RkQCEUzh+8bnNyNu5CcyxSTr+8oDSWm7r24dzDypYXf7YfLi40
 9yg5QqPxHyajerTPHcGfC8JnT7gyyOT9DJ4M1NEG0W769207G6z3q3MSz5qxWyxw01Ma
 /H5ZdybAfxybGGjvUH/kAOnFKlNT1gjAJfexGiciDQyKu2CPgSEYA+0XJbuaK+13it44
 yMf/Tc+BW12bpn1YXKaP9mhzSUIm3K4uv5MjXNUK9Xx5cELPmQXbSrm+zkTp/8D/vh/M
 1a1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102330; x=1781707130;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xEmfQD66YljQgfpm6pWxKEM84AHfr3eAJ9XCpH6lBeM=;
 b=pWLdXUyPDAOHKT3VxvUA3Wmf9Z24bR/kcNPuqZTBaUH4QNRFIyDpiR5/6l0Wfgefug
 dlj3dKmnQdvQuKT6/6x1qa36sbFvrKMQkjNlUngXqvWlZ4k8BW72uxtiEAmhchNNjl4c
 Ipoy7BKckVnhm4Rzc+YQDDl+baeEK6KcbD5gnEk/1ajD/DICC+GMWsY2W7SbSIbcNKh4
 bhTHmzzNULNbwVxnXu2WiVjuI/JnWpWEXJJAdt3cIwSM90GptyltbM5yWpSB4mcdiTUU
 KtvzYJIsBPWYphzNQa76CeFoH4i6RAr+RRTTI814WUvLHvA6R0Ry/YUQFAa11C9vgSe5
 xNyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gTKQeQw3Jd7TkT+dUqo4ggYcYuEz1+VDkc/Lra9dU6jjXKJuZLKCaCZImxGcHBlLOX8NVoV+GXf8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjC1oOk4bxDq1Kb4yCimaTiIn9HrrOHZcDK2es3EkiESMYIaEv
 uZPge8jcnU1Brwms34Req2dWM2Ih7wxI0Dlcbzr9+JcaFhWzL0pn6r6sR3bhDE3dY6CjwJ2IC+j
 FOhHxUmpRdF1DXydH/gHKYRlbLpCiqCw=
X-Gm-Gg: Acq92OEbl8FsEQr0i3teIutTIclKW51d8MQzjgD5xvxhTeCimYWg+HRx3jmS24ejc2i
 gQ42AW0jbTDmNjl50Df999mxPJ/NlhIyNy9X9jAIA1wxKMpJV6C9O9shyI/UVY9t2OWw5fdml/N
 cEVgpHsWP16wJKDj6uGDFO0ysszreNOiI5lLhfhzF5XrSORTVYhPvl2QqQr9DnZLfvsGA0sN/t4
 QjTq5bl0LZ203EuLqU8Cf4pH8axJQUGWIX7TwtW/AmFmt0zgGe6zpnE0YkcE4r8FJTjFoQyaqV7
 VsYSpk3A5V0V+UdjtHc=
X-Received: by 2002:a05:7300:cc0c:b0:304:e6f8:7cc9 with SMTP id
 5a478bee46e88-3077b1cc840mr15721596eec.20.1781102330361; Wed, 10 Jun 2026
 07:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-8-clamor95@gmail.com>
 <aihl9yIqN3adKWLr@ashevche-desk.local>
In-Reply-To: <aihl9yIqN3adKWLr@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 10 Jun 2026 17:38:38 +0300
X-Gm-Features: AVVi8Cf09c5dRYmH0R9kJGLjsyEz3GTJujrRgluMHRMUhIaWopJLSUHlJiMgJFA
Message-ID: <CAPVz0n2+27QVeWNgPm3PH6V2Ceuym6sbMtUrh7hSHe9PcRmfMA@mail.gmail.com>
Subject: Re: [PATCH v4 07/14] mfd: lm3533: Switch sysfs_create_group() to
 device_add_group()
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

=D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 22:14=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Jun 06, 2026 at 07:57:31AM +0300, Svyatoslav Ryhel wrote:
> > Switch from sysfs_create_group() to device_add_group() including device
> > managed where appropriate.
>
> This should use .dev_groups member of struct device_driver.
>

Specify pls, device_add_group literally uses dev_groups, I don't
understand what is wrong.

> ...
>
> > +     ret =3D devm_device_add_group(&bd->dev, &lm3533_bl_attribute_grou=
p);
>
> This will make Greg KH very grumpy. (For the record, original code as wel=
l
> but it already is in upstream. So, thanks for trying to address this, jus=
t
> needs a bit more of work.)
>

In the prev iteration YOU asked to me to adjust this. I have adjusted
and now you say that this is not appropriate. I will just drop this
commit altogether.

> > +     if (ret < 0)
> > +             return dev_err_probe(&pdev->dev, ret,
> > +                                  "failed to create sysfs attributes\n=
");
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
