Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C21CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8358010F80A;
	Fri,  2 Oct 2026 09:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ECLBzt2H";
	dkim-atps=neutral
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com
 [74.125.225.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C517D10F80A
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 09:16:26 +0000 (UTC)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48afe3b2383so2206053f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 02:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790932585; x=1791537385; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iG1cG8IPx/QY/i9xckK9bOVlJmPgmj7TzAkhOyUJ5z0=;
 b=ECLBzt2H3YWq1FcQqCpKt+CJn8Oc/h4qlaI2g6L2J7f9QT/eRklflsh+3d2sbb+pbP
 TMjMNCMHeEdaF1bJFBB+ieNY4/D5usdvgdqo1cSRSsozXqb+9dAm3UkBdm83iyaJWDw/
 sffrKVNacslcDUo9WM+z6hvShlDziH2v3O/6VIay3M9YqQUD/8lUeYgR9lYUPo2yVbdj
 vM42PemJNVjfdkpgaXRdQGpXm5gaEnujTvc9RT5FvopA8vmOU4iiyT/TxSTT+rRRHVXG
 VmAwZnAvyOKmm8gsv9mzTeKTOnEPq79bacc4V0PPbyEvF+zd8i8k+gey4zQhrS3r31ge
 VMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790932585; x=1791537385;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iG1cG8IPx/QY/i9xckK9bOVlJmPgmj7TzAkhOyUJ5z0=;
 b=0wRKwI5JDtdM9FVGRhJvxooGbierboShkv89TFH/HEq0lz5hh1Z2VvhN/XRLWuxeVf
 49jdJ3I+gIfoFNoq9ahNGu7Nh7R1vSLzMkYECdxLKo730VeX/zzllsajD2S0Y4nBHa0M
 HjXogEYm1TQDr5NJTgNB2e/3KvnQn3Tw57alenzrU7E3JT2L+3Oj1bpn/+Ia+Ju0Z9vN
 ydEgw0SlJR7mB+udxGcjgzhy30AbTv832adjNAGIm9pX/nvQ84t6TTaR8kG45ocM7rs+
 F9wRQK2geRZlDD4vXKohJjfpU9rLbxBM0zqW+A4FHu94CJR3S+nn7cG7z9/+X21CaOVW
 RXOg==
X-Gm-Message-State: AFq9FYK9l0+9WdDmi/tlLVY8r4J/DXHUNFNUrlmXZ59gKy0zJgKGn0c4
 VYgGYjjK+5lGe655Pkijpe0Gt+ygPYRtHbqtvYpxikED36ts6zdoERdrtJLtFVYPD50=
X-Gm-Gg: AYBFou2oAeCRejf2FYFBaS+pAEwRcuGjVbVwsq5r1tDmI7MekxhAd8i9L5ECAxo4BI5
 y1rfbnGOGGzrdbUbv+1uA+Kqj4BOQi+/agwSuemumlZpZ3RCQ+bh26oYagorl9QI/rUkJKx+CWq
 kAiaOzuGD5CQXQ+Y6qoi/vEGQ07Ej9YCfNVa8MpMEzNve0XNj0l7tNi8EiaOsHJLGi2os6rSTX7
 KluSAcZuWm1ggY48M/aikSGp0C9hkXGzPAZrkEl3HuDMccP9OEk5nmiYoUFDc5tqEQu32MXI8EG
 zUmjs3I1yy1ivjPjfY8HEhbOrWfp4c5B2b17mY26K4GZTukI/d/y2Uf5+DrQ1Awmjvia8+uPNIa
 b0MrgANDSpIhiRRJjnURr/NCpxqwJHWpngFJkafVlDbgEqGlPqSIb1CXUIn3eQc3/cTE8Ll5EHj
 SjDYovPHuoNIFebIVeV3olx/d7I/be3CwIiN3B+TrzWH9wiGBm03iEFL5BHJ06QGBmpDB/MiZ92
 9oUT9PUtHoYXNDC6qo=
X-Received: by 2002:a05:6000:310a:b0:487:1ac0:32af with SMTP id
 ffacd0b85a97d-48b1275b416mr3767187f8f.51.1790932585085; 
 Fri, 02 Oct 2026 02:16:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f9ad6sm4461292f8f.40.2026.10.02.02.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 02:16:24 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaron Kling <webgeek1234@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260925-rp6-panel-v2-0-19c425e523de@gmail.com>
References: <20260925-rp6-panel-v2-0-19c425e523de@gmail.com>
Subject: Re: [PATCH v2 0/4] drm/panel: Support Retroid Pocket 6 panel
Message-Id: <179093258419.2282096.16342679843740464292.b4-ty@b4>
Date: Fri, 02 Oct 2026 11:16:24 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Fri, 25 Sep 2026 02:08:18 -0500, Aaron Kling wrote:
> This panel uses a Visionox VTDR6130 DDIC. There is an existing driver
> for this ddic, however it is currently hardcoded for a panel used on
> several Qualcomm devkits. This series sets up the driver to support
> multiple panels, then adds the RP6 panel. It also adds support for
> rotation as the RP6 panel is mounted sideways.
> 
> This depends on the Retroid Pocket dt series [0] for the vendor prefix
> patch. That series depends on the AYN dt series [1] to apply cleanly.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/4] dt-bindings: display: visionox,vtdr6130: Add Retroid Pocket 6 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/4cfc23733f15d75a787bcb370c6739cd954e74d5
[2/4] drm/panel: visionox-vtdr6130: Add panel orientation support
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0de9104a85cb6efb624e6afacfc252855fdde8b0
[3/4] drm/panel: visionox-vtdr6130: Modularize panel config
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/628e7bff43c7ee3234a309fc58741eeecf2477eb
[4/4] drm/panel: visionox-vtdr6130: Add Retroid Pocket 6 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/74b7c75f7d442cc00fa759c22f746abaa70f264f

-- 
Neil

