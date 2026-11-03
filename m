Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F04E606A32D
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HwOJ4x/c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE83B10E7DF;
	Tue,  3 Nov 2026 10:14:33 +0000 (UTC)
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E7710E7DF
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 10:14:27 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-677af43eed4so2976159d50.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 02:14:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793700866; cv=none;
 d=google.com; s=arc-20260327;
 b=NuTZpyImMiZm7iYGBC3SeLaEDO0QgsumaoJ3te/fiD/S9+04FJyNVUHXxIo00JPQxZ
 JYjO4Gp8NqDmTTIlLxaalAbt++iqNmi0evzYHvp850qhoH7HAYnn2iWU4z/hvy3lj+Cy
 43hx/Aw9tKTgaw3yDby0dN5kPw5K1YSBHbU2gnVkCv/XeOiHESyCYq3roRLOI4MGoWSH
 W4mSur6ti3saxKNzmMaIr8XZQEAM4inZQM9WmQHpNfNsfKbZWwYqZyfgQliDZIOa8UAI
 XYNt5o7BkWyUPfdfKPVQCy4gANsZ3/1DC/9HYKtI76EIlhgU90PSyLvXLu3NFR0yux3J
 XDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T0nLcBf0nBf5qf4iyeI6J9rVyuEJhrxTvkxTb0mnCyw=;
 fh=Jwpg01RgoV9nTyj4mAt7Kv37wy1wCYaqeOvnVTKMJbs=;
 b=s8NVlka5QTZWCimCer1EjBinFUuOhazSZUJ24z32Ec8B5Q3MuifuuGD/xL51nl8iMd
 4UyqtOetW1xwHuCUNDGCmlnrFHqrnjY52CB16o08Vd1ZqFsjlEsN35nDrAvMXKQfDIPr
 A7LvGymzH1gpb1yQjdYrHwzTj2TM5D4n7Rd/eBaTtbsjLX7CCsrImEOea2JK581Lf8gE
 N9jHB4ShWHOSAsW/rVLuqHi/3/ia2+6mQ/ewHwSwMDDbfdJpMP9vrEcsibFJUWWS+UOu
 uh6b1xJPr1FPVkPI9BGzk1QLhodEb5vpaFQgWYQkvlsJMT8s2NH0VG0ssYIGrS9LaX8T
 1ltg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793700866; x=1794305666; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=T0nLcBf0nBf5qf4iyeI6J9rVyuEJhrxTvkxTb0mnCyw=;
 b=HwOJ4x/cfP7+QFlYSeUw6+k8Vd873GD/TdSxPX/v9Xn+VR/XXQISfWaZS41rq7oJxx
 okj2THsKBBeEsWqCAwkWyjcj7Y73rmLRR9dQ7cmLF/xZIF/vVXLs5cTmzFu/YN2p1lNR
 cGmD5MAz4V50eT2LFGWAKdDLGm8vR+W8FXBT+rvsE0+YbKGQM5gIxCgzcfRzgRO8SpnF
 /eYquCuyeSbsAY8N+O6sZxi8guXRWxiZTNWSueUhAqnsdG4FteDCoTgxaQITT5FB2BNT
 MxX7xzraXadSdkITMX0T5d8gmAGQXGjVUV5FDFjlc/htqR2eFxTGe44hA8ntBnzju7Hy
 xsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793700866; x=1794305666;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T0nLcBf0nBf5qf4iyeI6J9rVyuEJhrxTvkxTb0mnCyw=;
 b=U2kJByKwc3nSjbb+dQX9J/CRqTeBqu46IfSZ5trlMXazoUBpf2t+uFkX79d93sZIDA
 axLt6k5Z+l1xKTylB2kHKyy2RuP53HoxlxHuT5RPqIdkytJFQ8DG+/m4JDTHK6kbLX6O
 wq4a9Uqe9YBau7DyfDdOD4Ixela64YOPezmMaTVfd9H9/QjQL6E5qIEhsVeQmwF4+OKK
 ExkEKygf+ahFBXO2B4eSdQYKWqOW21RRHZgLFMM727ba8xyPYumRSWrZX2rEW030VXMd
 Mm/iM+2lB4DdduYSgLB4bFAYOBDyXr3/FauQ+F0sSG1Q9DCId9/GjTwaSnlXvYvOKGNV
 YqFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzio0O8gtWK6F5svBOGcy/AR01ucyLS+Wr77mYaz9dCpKwGlT/47rMdBmkMDtd5s2fXelSEkhfAftc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9QYmKtm37vPfKJtds7u91pC/EJCYIXGFzTCet5bi0Ky1dh3uHa
 q40jeyXdoVi65hw4PHw0M2xBKTCCY6Z7wsWEh+4dhqt2vRDEtl1/PentK6ibUneY6myeuvbo5mZ
 tc45uc+Exh5ZTxkcYDJjk8uRjTkvtLAA=
X-Gm-Gg: AYBFou2K3IADgD7+o8+XrO48Y6I/Jvy3xTEvcnB+0gl+D3cjNMX1Z9EY40bdnOJ1izM
 sFssWcff/qK3qCGiwZiUgNcAzPSIpCy/7C+SHWBdSPLfAIpW+3T9aV5x/jDbXvmYyaHT18ECLk/
 QZxBvHZNN6saxZA1Y6ildy4jRXZ3A+940+xv23tpcudqfnKdqCqSGWbf47ZWyK4FPkbXNb/aan5
 yQoSXAidoTLvmNGynW73rJQr8We9s59q9FTD9jsSnVj7mE692bavKimLIBGVsXz3teVOBYbeVJY
 FDPmtUdUxwooq/A1k39eDmJqVaWQSGQVqOYMXJPfXjpfPhXqMXLXs/yHE/jKH0TRZpuTt1xU4Bf
 0p2rJvEEmt1P8had4FIezFk3bHxV8CfGqEiEMD74=
X-Received: by 2002:a05:690e:4011:b0:677:d849:d9a3 with SMTP id
 956f58d0204a3-67ba4c8086cmr12954187d50.1.1793700865796; Tue, 03 Nov 2026
 02:14:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101152723.1430312-1-sidong.yang@furiosa.ai>
In-Reply-To: <20261101152723.1430312-1-sidong.yang@furiosa.ai>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Tue, 3 Nov 2026 19:14:14 +0900
X-Gm-Features: AclHuK_U0G7GWmHau4YutIqd0VEplz-5mJn3f7hxfE6UCdEZn8Z63QHq9vzTxEo
Message-ID: <CAKbEznv0ApgORxJO8BQY+XeDC94dqHz3GmdojwV7E7bdOCwo4Q@mail.gmail.com>
Subject: Re: [PATCH v2] accel/rocket: Report per-core engine usage through
 fdinfo
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sidong,

> +
>  static int
>  rocket_open(struct drm_device *dev, struct drm_file *file)
>  {
> @@ -86,10 +107,19 @@ rocket_open(struct drm_device *dev, struct drm_file *file)
>         }
>
>         rocket_priv->rdev = rdev;
> +
> +       rocket_priv->engine_usage = kzalloc_flex(*rocket_priv->engine_usage,
> +                                                elapsed_ns, rdev->max_cores);
> +       if (!rocket_priv->engine_usage) {
> +               ret = -ENOMEM;
> +               goto err_free;
> +       }
> +       kref_init(&rocket_priv->engine_usage->kref);

How about moving these lines into a rocket_engine_usage_create() helper, to pair
with rocket_engine_usage_destroy()?

Otherwise LGTM. Tested on RK3588 (ROCK 5B) with KASAN: the OOB from v1 no
longer reproduces, and drm-engine-npu* times are accounted as expected
while running benchmark_model with teflon.

Reviewed-by: Gyeyoung Baek <gye976@gmail.com>
Tested-by: Gyeyoung Baek <gye976@gmail.com>

-- 
Thanks,
Gyeyoung
