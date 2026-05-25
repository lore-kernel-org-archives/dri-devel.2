Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C98CD5BC0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F135110E324;
	Mon, 25 May 2026 08:00:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="quJDKDCs";
	dkim-atps=neutral
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A1910E324
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:00:12 +0000 (UTC)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-38be5e86918so115160441fa.3
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 01:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779696011; cv=none;
 d=google.com; s=arc-20240605;
 b=WSJLrCBmWIPA9eK/naAj7/SGytjcxMyWCTi5EYA7ANzDT+EuZCITWCpTll9agZhdI/
 3OVRdB4ga/iTRJsJNtztmqhzGUj8nkCYexy+NOdcISsx47Tb4Ejvum2IhY7fSftnKqe3
 XK/0O72T7fEORCgWaXMEeue2B+nBE8zku9x+QLahD57sh3QErEYcIPQDKk1E7lVnPPkY
 ChgK233bd/CC4ywnaOCIwtGddBc+HCfx+ydweCoHaaakIySwCdw4ZyMj+CtTYPjStJn4
 w+9eKuZf2NBoBhdaavYnzMhyRSSKd6HewHSmNuu5r3pNwz0ecJv89vQuPKpkWFnPENhb
 /FQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T6m6iM56WTZ+JdCiQdR6E29EVcPgbbg9SGsS1j0BH2s=;
 fh=Q1Sjz9z2Nc/Dck+fwlMJII6u83w9iNVwgmG7jSRG3pQ=;
 b=VelZlE+7ZYXkFv1c1XBsVrBjkXozWjGDsbczIX/ube0aNTpiDXUHkyYOVjOk2nMy6h
 MFvruieqv3X8+YwM+E+JdDdgmC9P60ot4D0un6+X2IJ5d0Y7y4+fUEc8EYlTBZQkO/MP
 6ucsWjM1EpUX2Xbsj4Mv2G3OAZuJfycin1kZ5K1OcNrGcZYafW38SfpGCjShSQ2yU0Qn
 MZjSRpZS+TRFxK8C0ts6twXD4IjLtf8FMu9WvwnRfERnSaQPZ94R7fzpRPpHnlGoJQxx
 aJyELWOicVStiYW5hhPgO5etNlGwGuBJn7IWPGep+LmHvOpmSOE5MI8jJoqBoRkQnk58
 Awdg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779696011; x=1780300811; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T6m6iM56WTZ+JdCiQdR6E29EVcPgbbg9SGsS1j0BH2s=;
 b=quJDKDCsoOCIoMpXZpCqgaqTpJECtaoGnmzHYsUE4RnL/WvdGD8z/SAJ6gR6jQ3EZy
 jT3lHgxpaXkccOB2PjFoWPikU46qQ5zCttu3bUMKhjNpDrD5SxtVQql/t6mq8Em0/z3M
 RUXH8mytDC9jM1UMXs4dZa+R7jUezIwJ2zxxPjutyp/38CfhXa91JruDLJENIE/2CFhe
 Gmu6/VmZVEOFI5VbwWYiJQ695xzfr6SXQyU0o/JhCwBFET/arKkJ4YDlziu3sFJ3TDsq
 eLlxbCsOshC5mYZwvqMlGUy90WE96yyaWTGpTvWlii2Lc0LmnqEoS++TjozECsaM/KyA
 xPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779696011; x=1780300811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T6m6iM56WTZ+JdCiQdR6E29EVcPgbbg9SGsS1j0BH2s=;
 b=qWHdzPomaMl4oYUoqgJs8ELCwzJYnifL4XWtw8Yds3+ck5X1HxYl2mLf1MN4MDt67z
 O+VQVXSKO3X78zBG/A2V9Phhcr4TN3BrbO8HYy9ksQSCETt8glOr9Qj1nnM7Xd4/PhET
 eOcaF7s0CfmNVy0Ii8YZZiMm+e3/84gutgikhNszc61FOXb8rkEzEN0osIJsz4vgct1g
 L8yjFS+cOwIZ2+vhWF7VmbnJuTSeE3x/qi7MabH87lpiA6rxlKsbSSaOBW+T8v9DGPso
 UX1GptAVmr6XQG5zWFuHuKKimIVlR1PljB/80OTbsOQ6vX/zriL8eDzL4owvwlPJeKx/
 7S+Q==
X-Gm-Message-State: AOJu0YwBo5lOu7fK0OwL8X76hEsl8NUGnRWcTDMBUmK7J/i5lgwkQzM4
 2KPNtGm0RGvWeDTXUTdSsl+M0O8Ra8IdbJmE3JoeQRCu4cKuGaG1ilIlwGln/CHn8+WGhBGS1nR
 zUsqsJyfyHoBNJ8D4838zDDwPDWqypOc=
X-Gm-Gg: Acq92OFMuOVqmdA8G3zwbA+nmROnDUV+OeSMGUBw2Jr5dE1WdeK5uxVjcAcMo+r/71d
 8JPBvEZ9GoTxalJhZvEa6NWB8486DZwZzZ68y7QpEYAqapxQRievo/A1OQgDbyfB73+ZHXoB7xn
 44jcCYtPrgXMM/nlLQXtLhac0+y45Y+MC6WPy6d3wrkaq5zgyBWXn1KTuRF8x/frVSSj6bzuSz4
 3B3UIjtaHgyHRK573JH3FEQuCsyDhxp2iVwuYVnaFYq8WphSh1AlEBMfUTdtLsyQRWD/uA8zKJ8
 RPqGsuw9RgkcRRd+KIRifJrTmEjyYCTrjQ/KEe8=
X-Received: by 2002:a05:6512:6399:20b0:5aa:2a4e:5b78 with SMTP id
 2adb3069b0e04-5aa32326a7cmr2764426e87.17.1779696010275; Mon, 25 May 2026
 01:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260405124006.2688556-1-yiconghui@gmail.com>
In-Reply-To: <20260405124006.2688556-1-yiconghui@gmail.com>
From: Yicong Sito Hui <yiconghui@gmail.com>
Date: Mon, 25 May 2026 09:00:00 +0100
X-Gm-Features: AVHnY4LOOtNbQLXnMNNX2tNFsKMqcodAOfoENJSZIUXBhFGKZEj9I4nr5UlNZpw
Message-ID: <CAJ4mek0gEHeDDAwrFcZQ3jHKVXkKXxgkL9_eknLaY=P3BcSmAQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Fix kernel-doc warning for
 dpu_core_perf_adjusted_mode_clk
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, 
 jesszhan0024@gmail.com, sean@poorly.run, alexdeucher@gmail.com, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, me@brighamcampbell.com
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

On 05/04/2026 1:40 pm, Yicong Hui wrote:
> Fix the following W=1 kernel-doc warning by correctly renaming the
> parameter crtc_clk_rate to mode_clk_rate in the kernel-doc and using the
> correct separator of : instead of -
>
> ...
>
>   u64 dpu_core_perf_adjusted_mode_clk(u64 mode_clk_rate,

Hello!

Is there any further feedback or progress on this patch?

Thank you!
Yicong
