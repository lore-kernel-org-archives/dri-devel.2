Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7977FF4953
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 07:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0509310E39E;
	Mon, 30 Mar 2026 07:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="ENi2yuHD";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A288110E391
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 07:03:12 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b98133bdc4bso496526766b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 00:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1774854191; x=1775458991; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bWosBDrmj8Wsu71M4ypLSluM1xAKCMFb6dnCW16nodk=;
 b=ENi2yuHDK7mY9UOrshzklmdQT6JJmcAsy7KX8Yrey46m9EYCYz4iuj64BJB5dg4DD/
 g6mKrt31nz5RKuT0hhY5CUjskY531kCkS1nQeg1W+uxdxDT3zYx4pqROzyOJjDkuKW4i
 WflM6ZR7uVt0bKqyQpzg48y7xF2Ex030zJEEWCoVCbmCg/QkbQ5nsnEmfzh+TJUUVNY9
 YXWmmFdLGFxqlCxKIn6hHXW3wAOLB7fL9x5IRpQtc8jvSO1hnoFU7giny3ZXL27cEYje
 5vKs/bBGltV61O3M6RCE8GMfz8Sa0G3GZ1SwVs+spHYuInj7JTIVk+NE5WXVc5YdQoHq
 bH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774854191; x=1775458991;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bWosBDrmj8Wsu71M4ypLSluM1xAKCMFb6dnCW16nodk=;
 b=Yv9rPxBzx3F0DaSb7OKvSVufVS9rguq7DWwP1db2kWwk3zJ+87fA7ewT19sPbyo/mp
 N/3EYRfHQ/6Mlvo3XUTdKiKUqGp5QuGN7zPL4C8SrV4LyF7ooTQm1GWCw7SL7xG4Gs13
 7sxvwI1NMvH9XjywvPjad6O+WWu1P4mgVgwgk/JtJbKdNU9AK0haDDInYgQewHvNk7Ju
 g2Ot4377WE8JJpPGC+5L55QV7bJkENTr/U7TQfUkJK51X6FjBHKwxQqQANS9ohn7pf8K
 +sozWMy9GxMhEYj84CG4InEcspVVgOQzWCKo6VejmL1vw8/XgZYC8eUn67rL2MLKiXCy
 ICIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrXZ2ZDkX1rQ7DRPux+t9vHID3rZfITsHUF1gqdcIlouOlgepAAwHRSUTG0FEOwS2gbThHpNdDySw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLYT95jKWjXKQcaQ8JQRpfRlseZb6L1gFvfkBvxMw+LVgiLq96
 jfcgPonIgaGTOPd1zR4qdp1yQhFTMeVxebVGJrBlcjXKQ3Go+XXgdvvhyQd9c5W2GC8=
X-Gm-Gg: ATEYQzz+5JOEfyvZIPC7eOzk75Kh1gv26D5exxW8hRhRNUfR0aWEroM+SNeCGc/Scjk
 XMrBiMVEzZ/51854NgFPIe2AUb7b8fBz7n/wEFuE98870BQajGgzKhjPduER332KMj/VaI6aytb
 vH9yuUDNSLK0IdZ48SOCktV7Q6OjHt9tPunPzF4tlrDrWFQJLTv9U9R0XTnwAGRKsiamRUUaF1E
 A9nilB+7sQTUFKKWfntKYI0Ycy/UXlRkOY/Vc/bmxJDe+yX38iCIwo+nAWuK8gVZ0rX5GGKW/L8
 0KcklgH1ykQMj0c/5rVsPLPSHlFJIT2vL8u3e1eI56MtAU8zQsloQ5IBAHXoDtg4lkTedlNLPVM
 zLcaxeXwAv6/1p/f2oeA+XEd1HSCltp/hAyyiIK/cOl3v8qlsxlwV89nDBdnj5tHyQH914EnAEl
 YidaV/xyVZAGY+HBIHgvPhuOje7MlAa70sOuOQaIfGqNQzcTMDJJVeG5d2puq1qMh9CIms
X-Received: by 2002:a17:907:9411:b0:b96:e593:fd1e with SMTP id
 a640c23a62f3a-b9b4fa20b47mr665678666b.0.1774854190784; 
 Mon, 30 Mar 2026 00:03:10 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7b225d4bsm251242466b.60.2026.03.30.00.03.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 00:03:10 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Mar 2026 09:03:10 +0200
Message-Id: <DHFXAUS2IMD6.38B0MDH2UNFLG@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Luca
 Weiss" <luca.weiss@fairphone.com>
Subject: Re: [PATCH] drm/msm/dpu: don't try using 2 LMs if only one DSC is
 available
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 "Abhinav Kumar" <abhinav.kumar@linux.dev>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Sean Paul" <sean@poorly.run>, "Marijn Suijten"
 <marijn.suijten@somainline.org>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260317-fix-3d-dsc-v1-1-88b54f62f659@oss.qualcomm.com>
 <177463970794.3488980.5641186548018992630.b4-ty@b4>
In-Reply-To: <177463970794.3488980.5641186548018992630.b4-ty@b4>
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

On Fri Mar 27, 2026 at 8:47 PM CET, Dmitry Baryshkov wrote:
> On Tue, 17 Mar 2026 17:30:05 +0200, Dmitry Baryshkov wrote:
>> Current topology code will try using 2 LMs with just one DSC, which
>> breaks cases like SC7280 / Fairphone5. Forbid using 2 LMs split in such
>> a case.
>
> Applied to msm-next, thanks!
>
> [1/1] drm/msm/dpu: don't try using 2 LMs if only one DSC is available
>       https://gitlab.freedesktop.org/lumag/msm/-/commit/b9699dd86276

Hi Dmitry,

I don't see this in -rc6 unfortunately. Will this still be sent for
inclusion in v7.0?

Regards
Luca
