Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB40CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8E310E8C6;
	Thu, 18 Jun 2026 14:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vwics7vS";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B2610F311
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 14:01:56 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c07c246ad7bso81567966b.2
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 07:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781791315; x=1782396115; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERYEJs276ODTVX1gyq4QIfcbsTkfe5OyvTObXUbWdmI=;
 b=vwics7vSYldSVKe0epCSIRpRK2M1+tIGZ748OYdCsk/DD0BkKxiatYcxGCaxiz9V2q
 8UnDciiB19qsdRhi03pnK8BOYCFHiZxXNu41v4j3HUCv8ekC0IOaJwF5gYcK7NgNx3lk
 vfKgJbfHBdh1CF1bmEzkUVDfTbBD2hXKsBS1KsonVHoYbZITKRomUpr7kI/7kpIBIP4p
 sbPaalEGW/xYbLwx8VK22LX0bx24TGWJeCwcM0eCkpHECYPIKaW/wZp2nJvOvtPeWsli
 do17obNpYn7HuY+17WMk06tz9GTauqB3NjmqJEhihSBbgWEhxjHJvv8pJxYPWUCYPlVW
 DIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781791315; x=1782396115;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ERYEJs276ODTVX1gyq4QIfcbsTkfe5OyvTObXUbWdmI=;
 b=eYar0ry56UDFKMTE+hiZfN9RLVislhszLuOFhziTTwyYuw329RamIzfsjNjLU48Xlm
 nBWfyJ3MyoaQ8fJdHuY3qxkUwND7LxHwmE1F7Ch4dV7pZ6+qQue275lBtAxrrmGOauSU
 jQXxPvffrPvuWurtYl2lCVkk90C7f+j/QfWuQVZBccVzBweN2Y+K66qfgUBAHE3DzRcW
 wmfAUlXJZZ9qRCOkvWAx8jgtlKQsZ4tTAjzyzgefaglOfXXjEtBfkxNdWlCynZUjkXx/
 VAjNGnIHqGUXELdjIuaQSXn3jMi6vh1YnO7syNgJaUa09+43NZkiTsqrnHSMF8wxTQyR
 5I1g==
X-Gm-Message-State: AOJu0YzE1jipjYMDv+ZK2bEyWnDsLeIhdZW4+477okyItocRi8hZ/jgO
 zjxIOFondlHTdL5x0bHC0kWjxRB1irzk7qxWTXLRzvJWPpYG/fXwBLzpowyN44UqNePbopwkswD
 6Q4Now9o=
X-Gm-Gg: AfdE7clnwbzhPqkLFK4W1Ze63Wz/HZvlWYqwIhDS0pANS/i+qXsQUDyKKqCgnXfwUZw
 kYrasaCwuuEVP3z7xiLNzK+3WKnEp+PrYq0+T3L2/yioIWRwNUh8k87358RKUdVjZH9vwEJ0V17
 k/5n3ZUxdnxkXpGGv0CBm7kKQ/I1Hux46xSGls6DUGb5qLYflPUkBkYQWXzCLJXRwlZKH275m65
 MTSnQHezUeKsp9sWZOBS03JBcTLXQ6tsSmJAlbHNiCqnv2S6dClfx1ycSCxakOkVmAOO+OtNHb6
 USjj5nTL6feeU8Hn2HYgMRy3YC8QqJz5H4G6LOPFaOguPVcrgnQv5ZnVVT8xsQ5TUifEzlfV6+v
 N7i1i6wwLEAMr3TWndSUnMC79MC5B/yLALIe15fOB0UNVqnJ6iSsgNvZsAVGH/0cGWW/CmYMEeI
 QtVS5+YBmFCm8uh0Hv4sSfssaqKJBiAHcUCg==
X-Received: by 2002:a17:907:268a:b0:bfa:e08e:3f1f with SMTP id
 a640c23a62f3a-c07c67b1757mr134600966b.24.1781791314977; 
 Thu, 18 Jun 2026 07:01:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4620b3ed0d2sm27901309f8f.22.2026.06.18.07.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 07:01:54 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaron Kling <webgeek1234@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Teguh Sobirin <teguh@sobir.in>
In-Reply-To: <20260607-icna35xx-v4-0-64de514add34@gmail.com>
References: <20260607-icna35xx-v4-0-64de514add34@gmail.com>
Subject: Re: [PATCH v4 0/2] drm/panel: Add panel driver for Chipone
 ICNA35XX based panels
Message-Id: <178179131389.245596.536714771652652273.b4-ty@b4>
Date: Thu, 18 Jun 2026 16:01:53 +0200
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

On Sun, 07 Jun 2026 15:11:43 -0500, Aaron Kling wrote:
> This driver is based on the one by Teguh Sobirin [0].
> 
> Due to [1], the AYN vendor description patch has been folded into the
> AYN QCS8550 dt series. Which means this series depends on said series
> and it must be picked up before this.
> 
> [0] https://github.com/AYNTechnologies/linux/commit/4c5e76e974db7cca853619ca138eecd8f004622f
> [1] https://lore.kernel.org/linux-arm-msm/c7fb3f89-6574-4761-9ef2-2fdf6d4801b5@kernel.org
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: Add Chipone ICNA3512 OLED driver bindings
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/392313ce84a8498164137c6941d5c6a3f7740f1a
[2/2] drm/panel: Add panel driver for Chipone ICNA35XX based panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/f747473a838ecc25e842e3c60ea95a5175be932e

-- 
Neil

