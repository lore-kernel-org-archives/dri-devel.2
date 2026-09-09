Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D992C79FBD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA83110F223;
	Wed,  9 Sep 2026 17:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eXr77W9F";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3574910F223
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 17:27:01 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cc4aa0220f2so407262a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 10:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788974821; x=1789579621; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BxkJmMQiuFGLIVhYvP7iekSRoJyyqxrT2LFSLJP0a4Q=;
 b=eXr77W9FZU/WDQSwwer5PHFdDAVm0iNiWNEQF4p7vCek8EopwKxAvFqqDamCmWBljo
 lzarOJ3AToDSmsNKco0877+oYu3hhR4zI0lWdXE3uQi25h3N3hYdLBJEe+9l3ktVqRAh
 8LE7+Y0FpDcRqxhWYebw0QEq+AIga91NLsE05M4tMmQbL+6Oppplk5ibvpjG7/lQsWWY
 tXQDGTDxYA2wDEYFZQ4PO+gnIlndmGKCiC1OLOFL9eAQZDsbLUHAgFj9p1/7jkbgPVWF
 31NHrjuK77MRkVVypLJVR4EYnFna7jxi5aZBN62BUACmfYzur9VNxIqcb5/oL0sxv6db
 j5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788974821; x=1789579621;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BxkJmMQiuFGLIVhYvP7iekSRoJyyqxrT2LFSLJP0a4Q=;
 b=muXH/FnaIfx8wvFZbEbnIxL7BlQ9+2AV+6U7kUkhwfjaWmNppxS+k3JmZQMLbFv7Wc
 +R97MazYTIr15LCJ3ihzYOwdNnsuxIptYBMEKeTrdH2Fvkm5B61BF3t/LhWBl/uWzM/x
 Z4MYgZSKxRn7RE/ayIxnz+EVmYPvkpkK9VrL9araOFvt3jH6ybquOckP/Vh7iIpNHixa
 z0WamUDYt6i7kfB7zOqB2UrrYzbUE93+my3h5qs1W/Jb6KgJhbppoj6ICn4E/xaMhCkW
 C/tQALJiybHQooRMFUVLXqS7SbPK4J0dl5PrLDPBPI/jxt+KXSIlOZr2ZAeKywChgLSF
 pVww==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+S66WrH41xe9JtVN4srf0u3/+dX31V1jQLrUI7bATArI/NspoZEUkx0Y3DtzthbRScoI9Vwa879c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m1puILkbVQoQ94sdW24nddnxkCtJDVKjTagP7Hh7WE1sSqJE4Z
 iXxfqm8BwkOfEuX/paCgFrAl4GjAMHX7BL/eYGIes3Vkew9J4JcYLyxT
X-Gm-Gg: AYBFou3vso3jmVeH3gpQLOar4WWblLKStYm/wqB0uqFAquw4uOdEKgLHUymTjCXL8OG
 HodQnWO/jBl+cJso9J6h5wCCnWSosw4P1ng/I+LIto7K00RPJr3EUTbWTh7W4EZVXh2kHC4fqbO
 VSA7AxHAoYkLEcjm9pP5pEMwQ10LUysP7x4UPe+4M92h2VAw0HJ6vm4SJd6DDFBUMENO+drMSfc
 gY9Z3bjG9A+taioh8Ud0mi9bsEpiuyf9rEdwpfLpwgCbXz6QuhdDeaWhtHz9hsjzTpUhzA3605K
 VnNOpr19s6kAliwUNYgEmp0Clj3In8sEqJtdBTeKv+fmA8OppQ48NudVITpG9tbja2obr2rz/72
 Izdjl3pHoLS2Z3+qRkKv2GSr2VB6w7QWCNsnZB8A60X4RvAX6lPaJNUfPNAl5HX4d941/v72Llv
 i/+E/nUN+qAzA8fiWgiWsgu/f8H6vnSkeh4frvVF287sBP4kQYQlMfkX8WEP3BhUAaJbbdaraM3
 regzufghbfnY5nMkLA+/A3PnWx+Dcg/kSsUSd170m7N0B4yUMSI
X-Received: by 2002:a05:6a21:9d84:b0:3d3:af85:eb98 with SMTP id
 adf61e73a8af0-3da3a16a579mr57975715637.26.1788974820346; 
 Wed, 09 Sep 2026 10:27:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2d43:5153:5c50:643e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm52422943eec.7.2026.09.09.10.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 10:26:59 -0700 (PDT)
Date: Wed, 9 Sep 2026 10:26:55 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Arnd Bergmann <arnd@arndb.de>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Pavel Machek <pavel@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, 
 Support Opensource <support.opensource@diasemi.com>,
 Sebastian Reichel <sre@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com,
 linux-watchdog@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-sound@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev
Subject: Re: [PATCH 00/14] mfd: unused driver purge
Message-ID: <aqGWjAuGXq_JHvxk@google.com>
References: <20260909132153.1596191-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-1-arnd@kernel.org>
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

On Wed, Sep 09, 2026 at 03:21:37PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> As part of my cleanup of old platforms, I had a look at all drivers that
> may have become unused because the last platform_data or DT definition
> was removed, or because of unmet Kconfig dependencies.
> 
> These are all the mfd drivers I found. The first ten in the list
> actually turned out to have been unusable long before my series, and
> I have added explanations on how I determined this in each patch. The
> last four patches are still in use in linux-7.3 but become unused after
> my series [1] that I hope to get merged for 7.4.
> 
> Somewhat unorthodox, I took a shortcut here and remove both the mfd drivers
> and the corresponding subsystem drivers (gpio, hwmon, iio, input, led,
> media, power, regulator, rtc, video, watchdog, asoc) in a combined patch,
> to simplify the interdependencies: removing just the mfd driver would
> leave unselectable or broken drivers in other subsystems.  I also have
> additional patches for each of the other subsystems, currently a total
> of 300 patches, many of which still need better testing or proper
> changelog texts.
> 
> Please let me know if you all think this approach is ok, or if I should
> explode this further and turn these 14 patches into 70 individual ones
> by splitting them per subsystem.

Sounds good to me, especially if Lee makes an immutable branch from this
pull so we can all pull it in...

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input

Thanks.

-- 
Dmitry
