Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D90C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 22:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D57810E052;
	Wed,  2 Sep 2026 22:22:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H/0PMuaB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40AEE10E052
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 22:22:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 015B644516
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 22:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC191F00ACA
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 22:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788387774;
 bh=PlnA7pZPe6iWSdjPc1ZWRfK3KN/vULI5guFytatqI0I=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=H/0PMuaB5u3sU0s5hGkJY/59TXNSJ6KMAwYT7jv6DQQk4TtUUnWB6gwoPXSKB5Rsj
 r4Z49dhd9jT3aUGdIDvQvSx2jXHh7nmrk1eL/pVGRW57SrHoOUVySaQI4c4bHmzL7Z
 Lpf+YhzuvGrgZx5m29WGHGdkKMAoHVVd1k/uwxdCbqJjjqbvhvx8hv2081gBeqk7mp
 a8QaMrjXU45MrqQNdtkCKMiBWIty0Rv59P9hLA6tFE1wHkHHHXi6u2YKUKXyhXZZoI
 O5SHXVF3IUdMPgLdpJHyA6hgRNjg3euZjqaR8SWtDF8djMZTXYPUabNECvqHEqCuGa
 8s62cWc4bBdtg==
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5b14d1f9315so1584415e87.2
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 15:22:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvByLSfXxuCKgbZ9vKvr2q7LAL2oUd5s1aIsEWKBIYz//eJFnr3tU9xHhkOv+vXaJXJZNmZaBkGWcej8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ljmoG3DKy8OdjHUfRht/YDRbezCghj7EnNq3iZlCask8PPZ5/g
 +UTKS0rkTLVdcqiacqkG/6JoqRQbi3GQzdp2/JEbC5FE5qJYJrHOOko6JW6JoDo7h+Hws9FwQP0
 ZUmInvNQ1Zuf5SSWQC5S4wquIKlupuEg=
X-Received: by 2002:a05:6512:31c4:b0:5b4:5846:d925 with SMTP id
 2adb3069b0e04-5b60869986amr2881504e87.21.1788387773462; Wed, 02 Sep 2026
 15:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20251222-drm-panels-sony-v2-0-82a87465d163@somainline.org>
In-Reply-To: <20251222-drm-panels-sony-v2-0-82a87465d163@somainline.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 3 Sep 2026 00:22:41 +0200
X-Gmail-Original-Message-ID: <CAD++jL=A5QWEfNXnmpKFMju8X1BQ8CsxMuqhia7mfMFbUaFfHg@mail.gmail.com>
X-Gm-Features: AcwNN1VW1RszHvTzjuJbWoFCZNyLdzuqFUCfNXCFY75SAWSdMQrzlNz5Nhvn0yk
Message-ID: <CAD++jL=A5QWEfNXnmpKFMju8X1BQ8CsxMuqhia7mfMFbUaFfHg@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] drm/panel: Add 5 DDIC panel drivers for 14 Sony
 phones
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
 Casey Connolly <casey.connolly@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Simona Vetter <simona.vetter@ffwll.ch>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Martin Botka <martin.botka@somainline.org>,
 Jami Kettunen <jami.kettunen@somainline.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>
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

Hi Marijn,

On Mon, Dec 22, 2025 at 12:32=E2=80=AFAM Marijn Suijten
<marijn.suijten@somainline.org> wrote:

> This is the second version of a largely reshaped series that brings 5
> new DDIC panel drivers (4 Samsung, 1 LGD) that are compatible with 14
> Sony phones:

What's up with this series?

I am officially a fan of these drivers and I liked the work done so far
a lot, is there something in particular stalling these from rebasing
and merging?

Yours,
Linus Walleij
