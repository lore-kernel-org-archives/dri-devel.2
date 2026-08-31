Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589A5C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7596510E90E;
	Mon, 31 Aug 2026 14:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lnNIutSJ";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE17410E90E
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:29:24 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso27663525e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788186563; x=1788791363; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lEgwtiy+ojxDd7n5w12jJGzsilFfHyW+JCyjrGne4zQ=;
 b=lnNIutSJC+k/9o+kIT+VBvYnJFcOv4+N8kg17y0PYWHokxEGUMS94HYbYg/oPvbHfs
 JQ4M3Fj9wEqimveKz1AbKL9khMC8r2XBm5M2P3eGNpahNVJfLyTt8kxNtD4IIRUqsmyY
 n6T5YjVod3bD5z0lk2oKTiwZRd9BprZWH1H569dTPtOmzTVo32gtE2bk97d0IJeeY4e+
 evYMFAWWG4WiMUJo6/tw7VEB/TFr/ax2cmL4GrJhsS4FqI2VeRmXxISRzxPMabqds952
 gksae6PlVIxChpQBAREWcmc/ubw7U6Bhc1JWBKfoNQoVRdvIB5EGtiXnZW2BprGt/ntO
 fxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788186563; x=1788791363;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lEgwtiy+ojxDd7n5w12jJGzsilFfHyW+JCyjrGne4zQ=;
 b=p6p4EbzpOsD3XxNrBrkWHrrlMBIqY4IQpbhTYLRIi1Dl+HtLXd3B8WdXjRhqlTz/bB
 jJFGoriNB2radiy3Lv4UYnDK6/47bkwMX8a9KPrV6UElZJl9EhdGyVoC1Nn4TPrRlwve
 UL/AM7YQjB3v/fYXDaB+pj7/MAZDuSWxPi9PoM2vPCqFDBi3aPQegHNqPNb1haSm1ZOo
 93dFjjsfVhtow7ThD7JuKyBK22mvZBfAOO/3+bhhMASJXCXLBTaSuWId9n2O5Hxq/ppJ
 vG5Wus2lscHLpjbXuSiDvAqVVA+/sJfoqL9JRp84oNfbo+j68Lz7oFrlqwSGYge2gW96
 8RAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBp0ktAT+NqNXnrgmNp6SZRuJoYDg813zuvr9vbHU1rQWzh50LrFKqxzQ4fc64TrvOauMAqS058iI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++moPWp0G7Am/fmi5FdcSIjykLKE2OxdDO5yr+Mtcekx1AA39zTN
 h9R+9SW5CTAdkeL0rjPoIEZMjAzyZI+KxcIKOcWp33GHGu9yplw7OvRUl5FCgxbIsr4=
X-Gm-Gg: AR+sD10+iCv9LfBxS5932OWpSDMdRU6K2HPyPGcps9UVj5vtlERBB51kAZmWYh2OLN5
 Ny8egfiUP2FOtJZo6Xt4xeZpPgIYlM4nS9JXYbCpJxrH/bqCbkN1K/m0myxuHdHJ2KXW+qVF5Qk
 OnhutxQKm3/us+OVbq+wPWssu+aW4espdLiYtN9hQ2a3C7nybVtIK4BBoEGeN0xiyKQz4s/iP+X
 3SsDR9wfQ96FMkK+xv40Vd/NqmkIn1a7XwE3HhNP3XN+1AAH6lygXYTPsFscBz3D2JuNzNcJxvb
 R7zx8m6q5HH2UN12RFEvzq6GrcIiHzcAlbaDitmpIrQhv60gm5OUT2WYWNgQIFx72xFiTBGMskO
 TnqBAahFGPz1vMLnUqDubEHarobjwO9fDqCRgYf6MUNbLq4xTSipfNsHTovwf8/hxprn8B1daXt
 goUjSUKwAC6fYkO20qQ1NSmtAFfBSqCpEwScM4ES/7z/fZ4tFRahA9Ogj3LXS4uRJLhOEzG5IbJ
 0Q=
X-Received: by 2002:a05:600c:4453:b0:499:8777:ccba with SMTP id
 5b1f17b1804b1-49b91c486abmr352107395e9.12.1788186562939; 
 Mon, 31 Aug 2026 07:29:22 -0700 (PDT)
Received: from arrakeen-2.home ([2a01:e0e:1005:fa8b:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ccea87e1asm145266605e9.2.2026.08.31.07.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 07:29:22 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Yedaya Katsman <yedaya.ka@gmail.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260818-topic-sprout_panel_warn_fix-v1-1-ded1e8d5f121@oss.qualcomm.com>
References: <20260818-topic-sprout_panel_warn_fix-v1-1-ded1e8d5f121@oss.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: display: panel: samsung,s6e8aa5x01: Allow
 common properties
Message-Id: <178818656131.2615924.10826235312502503975.b4-ty@b4>
Date: Mon, 31 Aug 2026 16:29:21 +0200
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

On Tue, 18 Aug 2026 16:00:56 +0200, Konrad Dybcio wrote:
> Change additionalProperties to unevaluatedProperties to allow
> inheriting properties from panel-common.yaml, preventing this warning:
> 
> qcom/sm6125-xiaomi-laurel-sprout.dtb: panel@0 (samsung,s6e8fc0-m1906f9): 'port' does not match any of the regexes: '^pinctrl-[0-9]+$'
>         from schema $id: http://devicetree.org/schemas/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml
> 
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] dt-bindings: display: panel: samsung,s6e8aa5x01: Allow common properties
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/c3fd78f0f3624fff3dcf55d89326f90000367596

-- 
Neil

