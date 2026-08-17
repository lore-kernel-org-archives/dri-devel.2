Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A0BC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 828CF10E6F1;
	Mon, 17 Aug 2026 09:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Ij+TIChh";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2D7F10E6F1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 09:39:40 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so25569785e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 02:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786959579; x=1787564379;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dtk6e7DXkab0Wi6uKJ4HjHzWIAKxI0jK8NztSrr+wKk=;
 b=Ij+TIChh8CQgsviPjkg2zLvkUiL5YbeHpKuCDsfURf2g/Z2U+/2ZGXbFj0E4MlYtJ7
 fhbzelojXDx8ZFHHQ3UWIjg4yNPfrjegZ8oUbphCn73UUSGaWMa1mG8ge3gahDltnVCb
 K7NE5dBn2jVyMLWY3NtXFXKBJNYv4ZAhOCxgGd79IKew/Z5bc6jg7dBeO7Wlb9QM2Z1f
 bXjoFI4FULz5aBYMTDcrw7AC6alHg//Gab1MygJTzylqFAszS0wBlHfoSZxVf+dB1o15
 hNKh66W5Pxh9ItJvNhUP0sExQPj1TK1YNaMxJ7jCTedz9UckB0my53K9bmXTV8skQYyH
 1jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786959579; x=1787564379;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dtk6e7DXkab0Wi6uKJ4HjHzWIAKxI0jK8NztSrr+wKk=;
 b=KBJ+2/FGcJeMJmLO8vBRkxenOI8s8/Khh7JDw6fp1n26F01o8yq8d8j8l/ygcW0h4z
 MJaoZJGHLqc11ZfHW0fV+FooFkFGo09I5fjw/VYhBOox3whNVy3MvDVDzL4XydPq8XUg
 spwh9h7mdb5tGOamT0RfFzD+EipPIYh3JZmToJEpqJCfbf6JagVfWabbPD+co7pgwJD9
 MEv/xIzmS3X46z/vT/sqozxB2WJw4Y4OOzTjWhP85FTiOsAeWEFU6nERe3eRDoocz4w3
 DKhv9xnWq1Gt+b7de5afAg9JiQNZEO4ZQO+pDCYfoH4Hsz13bvBfid0OcYP1F5vGPQjU
 WNOw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHzux4JqKREJ67KBJqQQG/OEfGA5SscXhpcjPbPgdUdM8iZ9xd1ypaK48DywTvT8zZkNaaoYGs/d4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhOpsW8LwnstuVmAKDJrBlHX8Ub3TP3akiKmC8OBrjBq4t+VbG
 BZcRDI6K+EghEyAIJCc9K48BlNbeU/GmdL0CMecINMWFGhOxMJM72ZWw3RLTdbL3Idw=
X-Gm-Gg: AR+sD12ULIy1pkdzSHttRwPxUmo4+9uX7KKG8j8YaKAsaH1opGvKTsWWXvV2N4d7geB
 QILdPld8YmyJ4NDFVx211SK4zLIQpvlq0kD3upaCiutU2Bn1BECKfFY46SuQXQwRiHeyC498kR1
 6wL+wb742eH+//7SW0GKQAOCetifE8O9le1MvjoelUz0IFfBbx0F3X17aKfmMw/1itt4wan02tI
 12sRARDn5evgcpd7kWXh4+jWO1SYcdguJHQs3RXDD5oIaSrQ1QPLN0Ps9hZwnBbAhQasOd34uZk
 FqRTwzzQBuz0wBkU7afjrGlLWerJwRaHfDJ38OWG+2JTXxke5eTIHUBMKmnUQSgqY7lZQZyVWst
 v1jy0jkQnA6MrC8UENG3lj31vPvGUSNL5xtR4nEtgTOqnCqohZsasKENwjmY0dXqeddapGOL0cb
 nqZF1UD6mmndwcm/X7uYanUhBF+Nn14cyMa7gC8CzloZ1juViQ1xuiOc24X7/w4uIYlFBRvMrJm
 4u0qZXSHrknYQS9ZxcR/vH+ae3zPC1elrbon25mMwW0Uh1OnCEYatxCcLoxTqOPn+A8q4Yh43FM
 VwlEiPjsDq/WH6i/26/3lFMvLcWTuSCpVBJd9g4aqQdbiw==
X-Received: by 2002:a05:600c:4f12:b0:499:491e:4b0d with SMTP id
 5b1f17b1804b1-499879c627bmr387093535e9.19.1786959579385; 
 Mon, 17 Aug 2026 02:39:39 -0700 (PDT)
Received: from aspen.lan
 (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610ed6dsm169142985e9.8.2026.08.17.02.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 02:39:38 -0700 (PDT)
Date: Mon, 17 Aug 2026 10:39:36 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 mfd@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 04/14] mfd: lm3533: Pass only regmap and light sensor
 presence to child devices
Message-ID: <aoLW2Lo7LDD-OcWF@aspen.lan>
References: <20260731113632.158440-1-clamor95@gmail.com>
 <20260731113632.158440-5-clamor95@gmail.com>
 <20260815025203.2618cf8f@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815025203.2618cf8f@jic23-huawei>
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

On Sat, Aug 15, 2026 at 02:52:03AM +0100, Jonathan Cameron wrote:
> On Fri, 31 Jul 2026 14:36:22 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > Instead of passing the entire lm3533 core data structure, only pass the
> > regmap and the light sensor presence flag to child devices.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> #for-iio
> (I didn't read the rest on this one)

... and it looks like I overlooked that there were backlight changes in
this one:
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for-backlight


Daniel.
