Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE31AC55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 12:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D159C10E2BB;
	Sat,  8 Aug 2026 12:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pATfPEMJ";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5317410E2BB
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 12:39:49 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4954a2dba6cso349845e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 05:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786192788; x=1786797588; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/7Z80X9FpgglIlhnFzOdLw8386r1jX4AyfOgEB2R9U4=;
 b=pATfPEMJcADoPle5hfvSCQaVf4ChMrW+Hal8XBqvUUYMi6Ao4t0EOT+44PlUNZcP4J
 14Qnj/Polv+mhiheBeuKeAWPwMM5vn7Wy+ThgwtSzQ3Ks6QTwqHdbsHWnDS2JE+b8Bhq
 EA592JGcuCJ2VQ36uwkaS9wXCNxSInFHhYKQWKl9RssyPje81HHmylqhhFTZ/gFFcG8x
 Z86Oea0/bf1YTFNiioMZmksgdeTDF6/7BFeku6Xp9Jh0B6GeR8ABqr7GyR5mj3rtnLyd
 VvH8vNkYtzVWDn+NfHEJ3RZ4ayMoeWDZihDkX4UlKZgiRDOyp9HMv8lXn/kMtG2AMCJs
 rBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786192788; x=1786797588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/7Z80X9FpgglIlhnFzOdLw8386r1jX4AyfOgEB2R9U4=;
 b=QqsID5iC0gjd+/mdgaJab/RYxMQMjpqQTR9sJIjvh1TBJNuUsuXSzbE8Fzo3TWXRYn
 w3mk9G4IGDSfRpXKtVYMOU7tCVlTXeFmkujiJsvjOQ6kqYr+2uAj9ZLyUrQ1d2zmzkuP
 rTXctGzSZ/ZhCshz8mGBSTyxeWC300cfOLm6iHhHL8mqh7RKmIzwHiUjTDgbR8jndi6L
 pbcxg408lSypVgTwtJdT0eM6DLCaTK0ibcQnRXlj8nDpGfIpuOf8MPckYtGQBFCCGG2v
 bdwyGZb+cVT5P8RJsM1peNc4v8hGnPMCfH9RNkKm/NnqgTJ8cCF3o1bNw/LxxGsNx8Y9
 JosA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3O4Ims1bNfzvRc6rdYfrqTfn04x8EyOvmhfagXDW3Y6WfO87rcky0mb1FveoCJnJ/kxZzPUr0US4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1LpR29aCx2eCM77OT3tYRxo7OxZpl9gEj8QEAryvBupMjdoB5
 cyqUCWHOTjI9z5xBKtUELJxE4ZCZSLUwAmIcRvGdzvw5UseG5U0dENvqoz0yVI69
X-Gm-Gg: AR+sD13RwQEY/scMTc6KtiYWHVftG8IFc2jqSeTiT9ED9AQZra1VGlft5NZTYX1gz41
 ZuK2psYPOH+8BBj51nPglyR+wqQy/XWPrMNcRdZeXarheLJG5j+2XpXfYAVTEuvkvAVHgHIMUCh
 hyeqkV/4wWXp3P+JIESVKP+7OujxFk5t1ZHgU1digkP0uCPs4Qk+3t5QnG7mf7KPzbGwz5qqZIs
 S38cTrOXh+ftaCPB1d6mm4QBZfhljbslvjwvISJSUFaiXfEVGjnH/k4L4G/m9R8mWlYEL9VhBIS
 x/d/QruvYVyW78epPXDhV0ohw02nt7xz/8C28bU6JGlGtuvBt6sjBZw6zqEtKaapKmnAogMGVBH
 oPT6r9N4ly1a6O1IJLuLSsOWjtzc0+1xDfW2b851le5fE45QvzRolVNT/Z6V1cJoPqMmt+RQFj5
 6DAUO85ylFvcV9XsDpSddVuYAdyoFTFVlgbSmunzgiin1zQHB3Pfb9MRkfuwP0KGh9dQ7zQTwco
 Ba1oM7gXgZtQ+hkF5reJ1mXSDuez6y2HV5TuTLQNsGxrazm43qcnxOgkuQziUOMFcpYXg==
X-Received: by 2002:a05:600c:4ecb:b0:499:59a1:96f7 with SMTP id
 5b1f17b1804b1-49959a19770mr126652915e9.1.1786192787600; 
 Sat, 08 Aug 2026 05:39:47 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8E20009911270F4BEC2300.dsl.pool.telekom.hu.
 [2001:4c4e:1b8e:2000:9911:270f:4bec:2300])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995ea2e038sm115426525e9.14.2026.08.08.05.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 05:39:47 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Igor Paunovic <royalnet026@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Alexey Charkov <alchark@flipper.net>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 7/9] accel/rocket: add RK3576 NPU (RKNN) support
Date: Sat,  8 Aug 2026 14:39:24 +0200
Message-ID: <20260808123926.23903-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807211629.1573228-1-gahing@gahingwoo.com>
References: <20260807211629.1573228-1-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Jiaxing,

No need to apologise - you found it, and you found it properly.  Diffing
an ordered trace of every register write against the vendor driver on
the same board is the right tool for exactly this class of problem, and
a 12 bit versus 16 bit field in a header derived from another SoC is not
something a reviewer was going to catch by reading.

I had gone through v6 with the RK3588 side in mind and had a list of
comments on the poll path in 7/9.  Most of it goes away with the
polling, so I will not spend your time on it.

One item outlives it, because it is not part of the poll machinery.  In
rocket_core_init(), the new multi-power-domain attach returns without
unwinding rocket_job_init():

> +	if (core->soc->multi_power_domain) {
> +		struct dev_pm_domain_list *pd_list;
> +
> +		err = devm_pm_domain_attach_list(dev, NULL, &pd_list);
> +		if (err < 0)
> +			return dev_err_probe(dev, err,
> +					     "failed to attach NPU power domains\n");
> +	}

The path immediately above it shows what is missing: rocket_job_init()'s
own failure path puts the iommu_group reference back before returning.
If the attach fails here, the scheduler, the ordered workqueue and that
iommu_group reference all stay behind.  Since RK3576 still needs the
attach in v7, I expect the same shape to survive the rewrite.

Smaller, and it may disappear anyway now that you are splitting 6/9: the
commit message says nothing changes for RK3588, but struct rocket_core's
clks[] grows from 4 to 6 there while the two extra names only arrive in
7/9.  Either a line in the message or moving the growth to the patch
that uses it.

For v7 on my side: once the poll is gone, the only change my hardware
executes is the job_lock move, which you are taking out of the series
anyway.  I am happy to run the series on all three cores here - probe,
multi-task jobs, all cores in parallel, a forced timeout and reset, and
runtime-PM cycling checked against a bit-exact oracle - and report what
I see.  I would rather send you results than a tag that covers less than
it looks like it does.

Igor
