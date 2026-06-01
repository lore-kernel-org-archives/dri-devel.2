Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D171CD6E4C
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 05:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C644D112DA4;
	Mon,  1 Jun 2026 05:37:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=quora.org header.i=@quora.org header.b="TvQ5DTgD";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30C52112DA4
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 05:37:14 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2c0c2a68d01so5965845ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 22:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780292234; cv=none;
 d=google.com; s=arc-20240605;
 b=feSD24b3Y6IsdiKdIVilGT2ux2w5chrbVRIrwjM1DPIz8aUH5vV25whZ/Ak6Nd4lYI
 CfI8hkTlRAT73ZtPAPVrmvzC1zXH5oHVeNBt8d3S9BJF2xOzthJ3oJ1XQYcuS+ejCi6d
 CkOCtLlNWue5R/zg2HgbBqQ2S0pTuZdXvo9t7VY6Y3V1BENErzZM/amYp6LhOe4dw/I0
 rVH4w5RNQtS4nrurXhVkUVTrntpXN1hBj4cUpW20t6usS7ZipzPWOAwysdWmXScAaXwM
 lAI7lhlWyyCr5+UMaB4pdfyU7TDWZZJq5F20qPwQ2BPFY5ihhITMhd8plLo21bGnPhJL
 3bZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=eslW/HkD5jbBXL8zxtx8xmInlZtajgRjIhBQBw7205o=;
 fh=Lk7h+Yh3DgHMKo0LTPjOvJublTtt8G22NU8olCyFB/c=;
 b=RuExMDrHZGIZHIjv3A1oqw8oILWOQ8EssVskdamgamvs43ipqmLYhn7FmuBWBMNGif
 sKRQ8Z0FnOFh6iZGH1KIuoRQPgXSZ2h1Sl+I74Dq2nR3tD9azNJ2JENBd40eI5bIDDt5
 reP0XQk6PPJYL8t6n6sNdAXrcToB0mqVQI3zmMqVG7/5KvgAxk2KFi6K1uww6GsIeO4x
 pQtJKN21mcBebpGIuUbenTy68PfXlelLMAerx6ei9zwtYnTcqUwayvSiv3F/cwOhv6iu
 ZtkeeCgdL9uyRO4lTZdYHe8wO2yeFdezWM5Rnj6alQNG9e+6J1CoyoAA24MLpQiKbvxj
 PMBA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quora.org; s=google; t=1780292234; x=1780897034; darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eslW/HkD5jbBXL8zxtx8xmInlZtajgRjIhBQBw7205o=;
 b=TvQ5DTgDCiEBM4nk8prwJ4YbY5LsAQLnupsSQvxzbbcOein1WuXNQZiaIiFHJ47uao
 Wig0TtRctVwrY+yzklmAJ22HlKHnPidnW90SkXq11L83ZHvrmo7YhUFtSf+r0PTPS55q
 j8ozY8HO6b81B/4hdtM3gYuXfd7dywG79Fq8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780292234; x=1780897034;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eslW/HkD5jbBXL8zxtx8xmInlZtajgRjIhBQBw7205o=;
 b=fCBd10xxRKbADdWD6WQeZPjrvalWyG4QKc2UPftKPiFgyR8s8peyFMKvPbbBRZLUHK
 DPldSugtOwY7d+b2n+BBJoFf8DmDQNv0aRbdnk8muknErufKfjp3EAedmWma1m2uaR2m
 efo8YMDlzFbl+OHJSlBJG3WTotj8Jl5+IqBacr9jZwRMLKOtQFHY9XkvXRJFgHEbiBne
 IILniyCK0GZCMwJWddUreoIjMgg1zIKkY040DvFevmRPxL4bDUYkRYkhbLyh3B+h245X
 9phQRt1pyRADGhxYwnipHO0F863T1erk3eDkrYfB/tSX048DFACwBd8yUxt+jpj8V+Mh
 0zfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8lGgAHA21E2SZvapXRq7wYySKnLPrVdolLTsNOviPxrVrG9Y5ZEf1LIO2MqEWcg24uHMJ8L+FwSak=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOS/tqpfhFe9q2gwu9KZIIrzHMivxEuhXjL03JcVScwTQD+bxU
 rCI4rPYColW916BWDlgZceQUBjiGcnnnznYLidddfieRPW8BNW02MVyPRv6rVihDMtKQUHMX3ox
 NgiT5puIcseiO8TQTB4U8lGQb19PZ4aXO5OS1S5QMrA==
X-Gm-Gg: Acq92OEdaUIBZguvN/aoENbOs+79Yg5Yd3zGwDvE6Ute/VRONxbYr3jb5B6BSWHiJcQ
 1D2f5dUftl0sO+Sp17vwfWM3WnXY5AcxB2n7d8cGFWPEPe9M8dC4WZbQDM21CEPrZ1nCCY4CM+I
 i7Slo+uVkc3ua5N3GvOdRGyCcGeGH33vxdmKjHXdFERqsZdRXSSkUQ5g9waCgabWEKtv9Q93F6d
 /FXYOSlxqyrIxNRX58DTKRbORuJG+vBb/SFBte7EDjdeofwJBjBa5M2U90TzpoCxGTdNwmHkkn4
 7VNNm+b6PArn+aaNH/Mx4DcC1AUrw6ZiM74DDPW5dYZmy4ekSAdzDqTpmSEY3tKzJdJEjAMaZw+
 KfRFeG9qC0HSJs5SNYLhTA9r71Pmnc4jlTJgKUqDm87k3ZHzdvoZixiOKZ+2OvaJnrY2/2GK8iy
 4T1ju30F+6ujQEv/JR+YC6KmZKL0OHTfyfj3NRlviYkqhZty8qtrl0s4A7g+w=
X-Received: by 2002:a17:902:e5cf:b0:2c0:d9b7:b7b0 with SMTP id
 d9443c01a7336-2c0d9b7bbb8mr36123795ad.31.1780292233725; Sun, 31 May 2026
 22:37:13 -0700 (PDT)
MIME-Version: 1.0
From: Daniel J Blueman <daniel@quora.org>
Date: Mon, 1 Jun 2026 13:37:01 +0800
X-Gm-Features: AVHnY4IP0HTVY8LRw5LOMcaMhl6NZI623lZ6qA0x2tLfv2WUrSLnXjbQXe9AaTY
Message-ID: <CAMVG2st2udHCUHZ_2j=jNmwTAVi2Cvda0qGgH4tDZHwsGVfLKQ@mail.gmail.com>
Subject: [BUG] qcom: x1: GAMMA_LUT corruption on DPMS wake
To: linux-arm-msm@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jun Nie <jun.nie@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Federico Amedeo Izzo <federico@izzo.pro>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>, 
 Val Packett <val@packett.cool>, Steev Klimaszewski <threeway@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Since Adreno X1-85 GAMMA_LUT support was introduced in Linux v7.0 (eg
Ubuntu 26.04), when waking from DPMS-off, palette corruption is
frequently seen; this manifests as purple banding. If GNOME night
light or similar is enabled, the visual impact is greater.

Further, on larger panel monitors or laptops eg the Lenovo Yoga Slim
7x (2944x1840), a second INT2 block is used for the right half of the
screen, which may remain totally blank on wake; major usability
impact.

Intuitively, the symptoms feel like the LUT SRAM clock isn't being
driven soon enough during the wakeup, thus state loss may depend on
silicon binning/variation or related. No such symptom is seen in
Windows on the same hardware. I found a workaround supporting this
mechanism is to activate the GNOME night light and adjust the slider
to update the LUT - any black right half of the screen always
reappears.

Please can someone with X1-85 Adreno insight check the Linux clock and
power domain behaviour around GC_EN, Layer Mixer, INTerFace and INT2
on DPMS wake? Happy to test changes; this is a stunning platform
otherwise.

Thanks,
  Dan

Link: https://gitlab.freedesktop.org/drm/msm/-/work_items/89
-- 
Daniel J Blueman
