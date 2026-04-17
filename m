Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B470EF43699
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 12:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4BDD10E036;
	Fri, 17 Apr 2026 12:18:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bRjPIkEH";
	dkim-atps=neutral
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED6210E2AF
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 12:18:11 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-6058a955e04so431204137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 05:18:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776428290; cv=none;
 d=google.com; s=arc-20240605;
 b=PByyHwMr01OPNLB/40Oj/62dKjUvYoA14MiksdBmEvxDlykftI6QZkq3N1FTzDW3Kc
 Fav8nkvqgQjJtcvL2C2irFG+HxWiY5IDp++pZniFMZ56KiTyeeovxPAcq0uD0RExgyse
 hHHzsOMEGyNwcmabhZbNtwA4OjEZhu0UlV3rHhlnRu7YX+z/MaUZadZqibYETmlxJ1x7
 Rqz+7fqyvkFSXmeOXJ2AQgPlKemqRloSLsBPgstfGjLW1OdoCcPBq+R3IIHoDxAdVWeW
 5IQKJSWZbpuelKKDCdLtKPzJ8C9632cZHSYbniUhqoFWdV7HAmPTc/+Z5pKSEo6tvFWW
 98ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cDMhKxQZOBW41kLl446l1EJd+PVPbWKyXfIiDzkTED4=;
 fh=ZwZdrWf1KuHrT7pAYG5Sl5wU7S++jwKQVV3HfilKfQ4=;
 b=b467Hcff6Goqr9QsF+AIK7HlNy+X+OIGugqnO1cv1WwH2R2jeXryhhj/NQ229I9a4D
 3a1ZI1WXxaWToH+LLLMs3ttxrpbCPVuE7vPxxveqrttDftHjnWYtW+IDPx6EplCAScJb
 zz2zqdbpfEf/zODox6pEjva0KgxT+b3swh3+SRJQu5ABEnrlM29rVX+OUsERiD4gz2m6
 5qw+mDmbZ3Y/GVGqMkxtJLFwECev7BzI1C+mE9ER32+66hByOAuBcE2l4jk8uV2VDkgZ
 jIRtuwMQmhAOxK3t/XuqSYKXoUD0aRgWzMCMK5d1xXM8NZzdVp9N4jXhC1ZzuZGrkLZ0
 hrWA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776428290; x=1777033090; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cDMhKxQZOBW41kLl446l1EJd+PVPbWKyXfIiDzkTED4=;
 b=bRjPIkEH3YZ6zkrUU0L0mCtsbhdFrJVBkeldrhNPs+m0yr4+QpHPn95+YAuGQQ04yL
 iodv7FtvR6Rv5Yt0ODWguCFw33fI9xk8/IEzw3mWn0f6N0yRb+fJv0hyC6GLZ2k1I9Ol
 93fGeDfWVegZoaIE45zD8tur3DkV8ck+gjzYTbYJSDH3EhhaJNndY72DDzZXlyKVtTd8
 UMEvRzz6CUYx0bOmLMvjmci8puDEjDy2wudHvYBHwCgMf1gub7mB910kpCA67xudVmaO
 xMFFUDARZFvbSSJublaHazTHjkbnnJtuA1R4YEnxmH6wYVCpnbYhkOT+t2/mISqFrgIR
 CsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776428290; x=1777033090;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cDMhKxQZOBW41kLl446l1EJd+PVPbWKyXfIiDzkTED4=;
 b=iR5f9spjJ/3I8R/xP4TMWXBfF+PZ+RmSKtCdGwBK1Tf7hB7A5Xmp7YjqKhq/w0L4uA
 CQZKTtI3nB+yBVdiJ7Xc5vnbC5bJ/bHUQ79GIydDmkdeF4Pchmz+wxRdMc81RZeNuq0E
 gnYxBRFRcR/fYIKbPWeVcTi5zoveB/PkLfqUQ39Qda7W1MhTSOibC/lepBseeNU2Qf+e
 bH+vDocDqvuwmyOC5myEI0ZjbT5biuwKz1NW0QKoypW4/MH+s49Fi+URElmD5ynZvCFs
 lSBGwKKXPQSemXLMbrw9+iJ9pw4bZuJEw+ytlutl7jnsUBM1tHWaJBtG29YK3LziCn+6
 pR6w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kNlKrFq+1yvXLJdODcQ0TV9npb8hg9Z4/MkJ0xmWGgsW9WHQHfT5ZbuURX3F8USLUP/U+f/ZsLd4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxep2barzFbZQSXDzdxB96vcrjl0SFCSys7xNBccRWtVB1AchYn
 S+hlz/o0tCsGK8SrlfCZJ6lCgIdHS5S4Tub+PiEsz7PLDXvHv0VEgqARGPdwc78aZpkKBPTDiWo
 MTpP5U+lJvy4+HpD5viO5utOnJXX10/k=
X-Gm-Gg: AeBDiesXX2cK98N6kOe59l266DPSEoOfY3FZnD+1e4j66n3nF6Cm1NJMUPblR2hnaIt
 4iwRTs7IeCCUdKClz/60GLxjvOwnWoqVhNj7LmAAARqnS5IR7BR6dSPKkbPikuZ57g7x7lDRL2y
 ndj0npVn5ddwqpHcSjzCfsLJOAoGfa4nBSst4+/kFGRJY8CGTjRfFSj453oJ50D+egpqaQEQQPU
 O3UaoON5f7iw6ri/eAXW6UJL7LWJMfFxInHgW2rwCHxeA8DMMrpbxndDejHkj+hxgYNjJcIoK2f
 SMDFHn+5qZe9i0Rduw==
X-Received: by 2002:a67:e703:0:b0:602:afbc:ae78 with SMTP id
 ada2fe7eead31-616fb89ea6emr791230137.2.1776428289898; Fri, 17 Apr 2026
 05:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260416-hpd-irq-events-v1-0-1ab1f1cfb2b2@oss.qualcomm.com>
 <20260416-hpd-irq-events-v1-6-1ab1f1cfb2b2@oss.qualcomm.com>
In-Reply-To: <20260416-hpd-irq-events-v1-6-1ab1f1cfb2b2@oss.qualcomm.com>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Fri, 17 Apr 2026 20:17:26 +0800
X-Gm-Features: AQROBzDTVswzyUjJ6xkXYjkzbvzXgr8nk22CVU17PBSoxKtVUOrPnYmdya4d4B0
Message-ID: <CAH2e8h4rLZB3E8Rdwy_LtfwtwAKZCOgL18fRFVqGBx32Cm2N2Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] usb: typec: ucsi: huawei-gaokun: pass down HPD_IRQ
 events
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Adrien Grassein <adrien.grassein@gmail.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
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

On Thu, Apr 16, 2026 at 7:22=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> Pass IRQ_HPD events to the HPD bridge, letting those to be delivered to
> the DisplayPort driver.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Pengyu Luo <mitltlatltl@gmail.com>

Best wishes,
Pengyu
