Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512CCCA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 883EA10F808;
	Fri,  2 Oct 2026 09:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZGcZ3TRF";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D93EE10F806
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 09:16:25 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-4885a1480a2so4417286f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 02:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790932584; x=1791537384; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j8FmFOHYSHqj+TvFJEfarN2rwBXQ1VT7J59Vq32Ksb0=;
 b=ZGcZ3TRFF+zvkr6wp0njC6YWfyb7Vb317zcqhE/FLjU0NObnc/BH0eCa14pVJlWSI3
 8v7ogBcvHSCJ+r4jDuZodgkMqIhAlhqpvJj7lbRCq8NotH2/8HxSVnJxbA1dwWzjFMKV
 jVWTmizV9l7hMxn7KaQUBesDl1RkcjkPIpol/69Q+W9Fj51Bk2QjO6NfVEVykxmGb9Ru
 wuBFR1cfz4kbwJBjdl7aVPNaiEpNXKF7L0wWW+DURXGBptmmLd7u43lYBiidlE4NfpH4
 7WFvDC+QKaP+YVo6jg7QauTDIh8grZ905TmItqErlw3rOEArM5uNtn99iq2sY2mdbnq9
 1VoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790932584; x=1791537384;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j8FmFOHYSHqj+TvFJEfarN2rwBXQ1VT7J59Vq32Ksb0=;
 b=aULETG+Qkcokcp3vbR8j5lx79vvNBaAaiqGWv54L8GDWdMKqpqgq29gmwgNV/fLG1O
 kHVRDbRZrPiiBsMxLqd/D4VTqjjvJKL4xfUBVr9hvydMzDZRfDEleXtpOju9xwzSX18s
 LQ0TZvJupx5mldgW5tZM38JZMoX/ZaoZWDzGYLFkrN3e5ELKRdI66e9sVtty9kS04/bb
 gOnqSXB54nFafYut/LtG0Bd7LxsHMnPn0iYewYflvvAM/XaOX2++JqhcOivrpuNmmrtL
 L1phKxwcuvQyHuAHZ1mCk3gtC40z0MkZc+BIqUF6n1ElyfNUspQyvAXrEwRvw3br38vq
 8hog==
X-Gm-Message-State: AFq9FYJXAlOsZbEhE85Ykt/GBVEOIvB4MzL+BmFcTv28xrHxtOvpjVsC
 VM9E/vpPZkpz+wYl4oAe/4BfoXgmePoTY3huJ8/UvjmocCtcUEoK6cJo3xUA+j4lftI=
X-Gm-Gg: AYBFou3mbjM2RigC/23Dc2hRmg/Geyg7ciX8MKd/TfUtobQPaDj97VPKMh8QzfRwygz
 CZr+5qPL/CYAKu/zgQVFocv77Q5Bk63HYOOwwQ9w0cn/j85RkaPkpyfcdO/sPxTZ6ctxTkasWLI
 Lv7M1DuCnJ4ynajBEHXyAMnuIa3OqHgHzpHxrz0whAun7qRo0FxHv3s6jDx+mgh4+gNBRvshZGa
 87x+ebkv2CS5ZryeOEZZ7Wd3URCew5ssLKuz5ywd+JatgV5tUJ2+QEy6x5+K7fAsWOjPCNCXAIq
 PIw93BX2gnBMcgaL9tYyprS5nthAhKnz6AHUe+LkauUBi9zTaiuuC4ZZK3OJToLYGHUIjGqMR+e
 y92AATLVNgVvkoPmaj+8VU5D24o9NSBGqJqmjhVhJ1HEimIWWbMMGZ75KK+kJQu3cnxH1mmDmh0
 A/iKrFzZVPqpe1mKXGYUQ+f7qIPUdnv91jVAz+MBNftRf5kz8bs2IWJePMGhP/bNof4v7vRBDMs
 /BYNDKBA+D5H+BQdVqh
X-Received: by 2002:a05:6000:4816:b0:488:79e5:cb2b with SMTP id
 ffacd0b85a97d-48b127297c5mr3802494f8f.43.1790932584104; 
 Fri, 02 Oct 2026 02:16:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f9ad6sm4461292f8f.40.2026.10.02.02.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 02:16:23 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Nickolay Goppen <setotau@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260924-qcom-novatek-nt51021-panels-v5-0-f5eaf5685c9c@mainlining.org>
References: <20260924-qcom-novatek-nt51021-panels-v5-0-f5eaf5685c9c@mainlining.org>
Subject: Re: [PATCH v5 0/3] Novatek NT51021 DSI panel IC driver
Message-Id: <179093258297.2282096.1579513931131957273.b4-ty@b4>
Date: Fri, 02 Oct 2026 11:16:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.1
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

Hi,

On Thu, 24 Sep 2026 18:08:13 +0300, Nickolay Goppen wrote:
> This series adds support for Novatek NT51021-based panels
> for upcoming xiaomi-clover submission.
> 
> Although according to datasheet, the IС has three power rails
> in the use case of xiaomi-clover, all of them are wired to one
> fixed regulator.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/3] dt-bindings: display: panel: Add Novatek NT51021
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/7d2dffd72625784945b8a467b6d47fbed6fe7d74
[2/3] drivers: gpu: drm: panel: Add BOE NT51021 driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/94e45e3ad539291bdddb3cbf8f1803d42786c70f
[3/3] MAINTAINERS: Add myself and Ryan Brue as maintainers of NT51021 panel driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/27282474cd58e274bc866fb881643cf93a1c01c5

-- 
Neil

