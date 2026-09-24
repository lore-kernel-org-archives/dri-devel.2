Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDF8C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51B210F5C3;
	Thu, 24 Sep 2026 13:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lRnhP+iO";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F7DD10F5BC
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:59:31 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-488780459e2so176433f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790258370; x=1790863170; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tts2aH+0naRt7JQ1fJiXvGThSzsg6pVhDhZq99ElXD4=;
 b=lRnhP+iOq2hq2X4E4y8tyYiyF/pqECZ/9NsPSQTfI1yP87aCUmBKaCKnoTLox3uzQU
 ioBCehalI9f83fY9MPDc+TbVMrBUm5ZJbbP5GDZLxyPv18DfpwXwqYLN3Bk9gTbKXQKQ
 DQot1PRLFNJSK6hEJ5ntT0WvFRXOKDi3sE1rYc+qShfYy+Xs0M9+tmbvp4E9G6QA+15M
 hjR9wE6mq6RQwElZrysdHNdenHgxkg9mdQQ1jreoSyYUdKn4fqZyj0PIXEWSUnKS5ROn
 hYF6mvV/UD8lVb0p47lraFsiHTEpIctfw4x8qeg5A1HrWH1cz+xKZthOSfNirhc/kBOQ
 Ho8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790258370; x=1790863170;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tts2aH+0naRt7JQ1fJiXvGThSzsg6pVhDhZq99ElXD4=;
 b=MeFvJoVdM42NbBih+fwWGkVBP26ImIzPmjPlYAgL6mxA3YXAbCL4OAAyc+Sc5bRO8x
 vzvuNfsJIbpoT4Xmbunnylsf+0WiT2lsGWa1yuvyI9K+5iGh8uEevJNJ52B0M7TY6afj
 JB71FX+u/9rtHjxfPHRwdSHHT7gfj9B8Np9rohpqTx/kV/O2sYD5o0TRTxqNlB3w5Ttd
 zQdqWzIX7cyFXdG8T4waKruCxU+XvjlQQln6yIA6JFwFuZI6BYLCtxGeCX1mBiJ30cK9
 8zNudYgwHRlcyfjxkS5WCKcRjXd3hOXwBzIhvNzrFCr6BvaR+JX+NJdEEZVqEbYoeyL5
 XwHA==
X-Gm-Message-State: AFuF++lHeBl1vmHbUw3rIsx320QVgWRiH6Jo4UF5yhEXvd9mh+aspc2S
 W5oe1XpMVRdjthMPa+9l6JXcxNCNPIjsbZzzabZOhS/ReLZZa6XodvC2SQDGo4Bcnxo=
X-Gm-Gg: AYBFou2CUZ0alsQms1BVekpX0Dmx2xLMs8hI73Kd7JxjP0afYGbqE7ihWyPI2te1QVx
 H+meSni8wBNVTG3gYEXMdYJobRkfJEKyBhcerR5eWMIqUWqlGDjXAlVnpo2txwrbQU3dOVppj83
 0EpUS8YPFy45Qq0SySnUhii3GFo2NHrwBYEZAA8PoCvyjiElrehXYKEl2ifNeJjnsHXKrVxiHWU
 bRx2liy4cwi8GmbawyPj69RXLh3d7692egMw5fbLrtcRv9hVkv62geNnzR7RfqFiHIC3BORsImb
 imv/O9Eydcd0TAKI3F1/+1HM2VCKkMHFCggnA/4kJvKSrMMztjelwSXpYUVuJNFwCPwQ/LK/qK8
 sBG029pEymILkNuhju2WNheaDH6LF/iCQXgoNJ9Bi77JRSUo/HdWgXNRGjtFMF6H1tl/Eb/HHzr
 mL9HpIWnhaxQT2qsoru3phXF/k5Cc4Hf3fFK1+Q++8+0OKPhSx3Rch/0/RRlBs04L106UUfoi7O
 19fRQiZiwOYhmttcVeu
X-Received: by 2002:a05:6000:250e:b0:486:f770:787 with SMTP id
 ffacd0b85a97d-48871769a22mr5154051f8f.31.1790258369629; 
 Thu, 24 Sep 2026 06:59:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886876c500sm15799213f8f.19.2026.09.24.06.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 06:59:29 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260917110517.1053556-1-alexander.sverdlin@siemens.com>
References: <20260917110517.1053556-1-alexander.sverdlin@siemens.com>
Subject: Re: [PATCH 0/2] drm/panel: simple: Add Truly TFT320240-229-E panel
Message-Id: <179025836882.3234093.130291455472831294.b4-ty@b4>
Date: Thu, 24 Sep 2026 15:59:28 +0200
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

On Thu, 17 Sep 2026 13:05:13 +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Add Truly TFT320240-229-E panel support into panel-simple driver along with
> the required DT bindings documentation.
> 
> Alexander Sverdlin (1):
>   dt-bindings: display: simple: Add Truly TFT320240-229-E panel
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: simple: Add Truly TFT320240-229-E panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/001a7baa873891b7558f6b91e36136bb8fc66fc3
[2/2] drm/panel: simple: Add support for Truly TFT320240-229-E panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/45b46cd3c477a2e5ed547450a15dc80f0593f418

-- 
Neil

