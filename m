Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46299CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B9C10EC5E;
	Thu, 18 Jun 2026 14:02:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cEPPBwoO";
	dkim-atps=neutral
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6929610EC5E
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 14:02:00 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-39983214844so5402421fa.3
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 07:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781791319; x=1782396119; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4oNfXFLkcb4dBrCrqAlUfROybHTH5OrCY5Zn4tZayg8=;
 b=cEPPBwoOKPEQ71Dn6walq6IuTAKfoz8xGt0a6eQPuxaNwH3RKN1EzqeIabOVYw6L0+
 FdBQrv8W5jI6MBHuixBQQ2X2XcA4SEhJT2h7VavJo73ERdAZn7S0YTB0WoY1lPHDrKL0
 DxlquwjNV8DHKa3eejIWN6H/CYSKHhucT+v+zpLqqhtccxgJ5ydbsQG6oCdXfznxDlPd
 a9PyS3pWxCVUfivwcM/qL/r/1o/uGa7zpbA8dAmkhHWS04APcsrjbgTfMEcI9iW7lrWB
 NNitPO65D8eXmW9tLydqNtstTlijP2BqRxViHh4jnZsfMX0NPIStg//5txj2Xzvuc4qp
 +cJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781791319; x=1782396119;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4oNfXFLkcb4dBrCrqAlUfROybHTH5OrCY5Zn4tZayg8=;
 b=DSscTMs1OyFHh+zOH0StU3DdE4EAZrCGPYUPZuUvSVC6C5iN7jowPtWriTAcAKYVEz
 vcisEHwm0XbEI2y7saim/sOCkdyeLfaLH3JCnnXXzS6HfRoJNPj5dkrHz/tYLT2GxI7l
 TWAAnvl4xwxKc4f9/FbwjQf81Lh/U10FAp0XwR/YCt3eyy30EDomDH/4tTcw9U4XcG3m
 G7CMrJsYRLviasi75axyKzV56Q0D6OThdhkCDcWD6xpiiqnrFNOXrGR4hIWjWkCYFOzE
 Fzf9tpVLyBcOQwFSMLnO0vLKq4D9etQwq0ZZEmOglS1d1RuTyvl/Jy5vqim7n2aIbbd9
 prag==
X-Forwarded-Encrypted: i=1;
 AFNElJ9abto5bAuBE6AntAaBFZ59xfpyIHyohJV7sQ5dmdLL3N0MDgHXOPS8VbmoGdWcSBXaVOz3tNeWNpI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+IN3O06DIaC6lFaefsondQZMsz6SDn4lhl6M0eRmF5+NP4hc2
 36TfKQNgO/kv4IEuLtyctIjPWrCkRi/W0V54+8ClFkdBmv01Y101nwn/GHk+S5d4NOoSsUuca8S
 yIlTACk8=
X-Gm-Gg: AfdE7ckL9XQxTK6+RTN/JD8sTtfnRmrNGSNLYYmlP1XlIThbxZcetyD3ohS2GOLFmYz
 ONyAmd0T3r+1KYLxp2h6Hr9xuv+ocKVX10uv/6w3GBrPpVYtyXBF/L9MPpdIinn/nQahbS+XJ7X
 t728+5PH631eZ+NJrk/1xxkgO0Ja8TS9iswi9xSb9h7m/6HlkWVg2o+61ZerXfzvKbWR7CgN1pz
 4JPi3nPFFbGf/KQMvClM5f2fsHKSNHjw/uWUFesmi7jz0OW/BJAiNzcT0/pRoNOG0bTjaJ9aFjk
 h0lluI7BLwPRHnn4KRd5C6GpyAGi7GmfKuYozx4/Z77HE+4X8IVswRdQWrSr5AOyJeavmR1HM14
 LP4Mpd769AXBx3OZGy+yIyN42QAszQvuR32CreorowkqvY+6f4GDtyBHSW4uH5cdLRA7M354o/+
 UKjy5Z+AtG4V40OJ3+WvtKlsScvuwnQkORPzw8mylkeiMb
X-Received: by 2002:a05:6512:110e:b0:5a8:6793:e701 with SMTP id
 2adb3069b0e04-5ad4703a6ccmr2818410e87.33.1781791318307; 
 Thu, 18 Jun 2026 07:01:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4620b3ed0d2sm27901309f8f.22.2026.06.18.07.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 07:01:56 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260608162622.403713-1-zhengxingda@iscas.ac.cn>
References: <20260608162622.403713-1-zhengxingda@iscas.ac.cn>
Subject: Re: [PATCH 1/3] dt-bindings: display: panel: himax,hx83121a: add
 optional bl supply
Message-Id: <178179131647.245596.13953179203081214548.b4-ty@b4>
Date: Thu, 18 Jun 2026 16:01:56 +0200
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

On Tue, 09 Jun 2026 00:26:20 +0800, Icenowy Zheng wrote:
> When the backlight is managed by the panel controller IC, an external
> power rail might be powering the backlight.
> 
> Add an optional `bl-supply` property to describe such power rail, thus
> allow disabling the backlight.
> 
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/3] dt-bindings: display: panel: himax,hx83121a: add optional bl supply
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b817a59c2afcfbf1594b9be6c4136d9d7d613eee
[2/3] drm/panel: himax-hx83121a: pass the panel pointer when creating BL
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/ae8dbbe8955d7470dd41e101b852fd1a70f62930
[3/3] drm/panel: himax-hx83121a: add backlight regulator support
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/98b46e693b912eef0e6d497327489113845cbd15

-- 
Neil

