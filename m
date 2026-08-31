Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D27C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 432E610E90D;
	Mon, 31 Aug 2026 14:29:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RPKOy7eO";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0958A10E90E
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:29:26 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so35209205e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788186564; x=1788791364; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=42dtUqvN0sDvzTs9n0Ajnz+iSZsJQO3TYWIEYeQ7is0=;
 b=RPKOy7eOWArrbPn8sZBiUGSrlkH3GgJc9l/9xTkpO8HF+b8NIDfo2KgpvGSFwSWsOc
 nr6iJQgsW9E83/Y/4EMFnksihkqYDIB9mRXK9VC/ZjCg4Z+JnLTkKoA7J4jDWUAT5mL7
 w43ZirN3hgTnuurXB7vG9wKs1VSjKIjUb7nUqButNqVC2T6hKWNpHXlnzy0IfdnCghG1
 frhW6CwcpFtykNd8FjH9GyRhuV17nEMA/0UFgLYeholV12blr1Pj+4HI84qQutKshHec
 tvj8VbYwWL6T1WrReSm1cmhEFl0eHVxSytrnIsAFhAd9ttBSzbXE/J8zaaSXIZAZh4/B
 Ad4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788186564; x=1788791364;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=42dtUqvN0sDvzTs9n0Ajnz+iSZsJQO3TYWIEYeQ7is0=;
 b=i052psD3Xl9ddFadNcbu21LS2vpXRVwn8UPy10d98dHVYvezuo3Ch+vt3Rcrf/yX4u
 jHxhRc+MgiEgX5JnI0rOSeZrvmTJMh7zm8TjTuVDWl2i+lCXObeAWgfRx8Kp4cyyK0Qd
 NhbqJzaqiX9bVf0VTLht6wLsQqFCfWCtX7qC5TNQx7EKggN/73tpSn/Opg/16BBFA7Ax
 hIRTTiLgYOyA40gasVxiuzrnmiJzfC73QbC9rZnrHZ2wzetVlblhrN/w8VQ737XHxCBi
 zi6qe6jj20Pds2FMQ9auxtQsZ0qvFMVjydnjijCqZu/ZqdfGzvAYt7qtZ+Trb0AMf+dB
 XZTw==
X-Gm-Message-State: AFuF++nuVi8WPGp2l5YKneaXp0gwkFKuGLQJ9KSCcP02/XCJalg2vT1z
 gjamzCpCz0N2h417gc5wfzUucsKKdAWYmVI6xgECZD4RcshbwJlI1YYtLs5B7KQmLmE=
X-Gm-Gg: AR+sD11vHXyXeGqVTH/wIk1LjqJX2hTaty7RhIVuExgQr9r7XczV0ZMMydcXugPth8W
 qwnLURRSE7lBvKnkqCTwn45EuWEONbA23eViUwJGIIgbdEZugckhwPPawBGyi41JYul/1N1h7/D
 o0LXpGV8Jy6mNTw3UKEyOuuFQvr4ReIMLW9/rTwnnXAVXJiFrKqWvFKvEljOAUiButpNWlzCoVp
 65lJ0LeGvlCICYTApmRRsqUr7G7Thqojgh9nXOGdFyEzZ7hb0p76YY06hRYylCAhn0w7QYJhA56
 NmXOClENdT77G6CzKi25HL265M1fFqY/ftsWEBjTcUP0ce8bj2RoGMtGqo/uEtjl955Mz9ujnTc
 qNiubYZK9mAbb9SbSMykKDziPUI3fl5NUkAXizTN8m3eGOAzNnxec65n4c7nMfwi/r7pdVJmPX/
 9/caC138kF6LKVJPOWJL3Om2C9xAogT9aVeZj/mDtiQ/AE1iSGQZydB+7k/pqPuFO6K9nXKnaOO
 s+KfCZWMpG06w==
X-Received: by 2002:a05:600c:c0cf:b0:499:726b:7375 with SMTP id
 5b1f17b1804b1-49b91c51e62mr367747135e9.14.1788186564317; 
 Mon, 31 Aug 2026 07:29:24 -0700 (PDT)
Received: from arrakeen-2.home ([2a01:e0e:1005:fa8b:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ccea87e1asm145266605e9.2.2026.08.31.07.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 07:29:23 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaron Kling <webgeek1234@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260808-ili7836a-v1-0-07a7becc5636@gmail.com>
References: <20260808-ili7836a-v1-0-07a7becc5636@gmail.com>
Subject: Re: [PATCH 0/2] drm/panel: add Ilitek ILI7836A panel driver
Message-Id: <178818656303.2615924.4877103512503955677.b4-ty@b4>
Date: Mon, 31 Aug 2026 16:29:23 +0200
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

On Sat, 08 Aug 2026 14:01:13 -0500, Aaron Kling wrote:
> Add support for the Ilitek ILI7836A DDIC.
> 
> This depends on the Retroid Pocket dt series [0] for the vendor prefix
> patch. That series depends on the AYN dt series [1] to apply cleanly.
> 
> [0] https://lore.kernel.org/linux-arm-msm/20260808-rp-qcs8550-v1-0-a5a365ba3dc5@gmail.com/
> [1] https://lore.kernel.org/linux-arm-msm/20260727-ayn-qcs8550-v9-0-e3db456e10e5@gmail.com/
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: add Ilitek ILI7836A OLED driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/1b59be32378e9ff5e9d1fc1168e46362701c751b
[2/2] drm/panel: add Ilitek ILI7836A panel driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/8a78143d94bbc9ed471d57599563bee0757493f4

-- 
Neil

