Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEB0CD342F
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 10:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62EF710EA38;
	Tue,  5 May 2026 10:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b/iKkehi";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3766E10EA37
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 10:05:18 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so17135305e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 03:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777975517; x=1778580317; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Od3JvJ9Kbs1kRGL91hyMQAVh/qreeoBuXtzdq1EUEJk=;
 b=b/iKkehiZfItEPBP9qG6MEa632+ijgxEHSQbN6/9D8YcM9p0HzslT+nOsp83BkGdMn
 MDQU4Bf9x3GMf0GN1QIxNo3MS8D63OAOC3FgA7VWrsN4LPiCclqR02Pcy5p21oC6AdAT
 vZb//xla9VPU0uvaJT5xztOCsKx+ryRL9hE+2VRYUGYvS9bdoLOHA1mAnHXomht4kJXM
 j8k+nOllrwB77iqtSCI8FnHxQCPU1rwug05UEWdC5zmqA2xpPjNcqMefm8y7bTnK9mlw
 reelDsP+BSbFE7w6Lshl+CTK5GciAazILp0gJ+IjejpsnYpff6RFhN7nOpCDhQqcxrSb
 HPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777975517; x=1778580317;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Od3JvJ9Kbs1kRGL91hyMQAVh/qreeoBuXtzdq1EUEJk=;
 b=KkoryJfhPJ0pEVw4uZh9zGm+8+YXV3vaosCkjmSkn9hRMIdsvqzJdMlWUpiLGLfcoB
 Cm37xfXGV4/XFEmiByxR05phIQ9y0qwVerpGD5CHNtJgVHrcmtvhaXPHRVBVp2ENvH6m
 Xc2NknpwPhzovcDoQr5C2Cag16UbtIszkP1PQJsSnUdd6DsFUmXIMNcxgCbC2aJt6WEV
 RBm2izhDPu/IaoCArRT7QApu3NkfOl5CsvQlbU6vaM0OSCdIumVJwJ5RWz1RWG60NRqY
 y0RMHm9bTtc5YGwbInDzaiASYyBRqp2FMT4pFALz8TWN4NR4/MZpnQ87ZAPBZd2xV8JM
 7yPA==
X-Gm-Message-State: AOJu0YxMo4it3wr3vINa3ftET2IwDJB3s4uLgT8z44gCbqgMirkpcGf3
 +Lru5Q6t1oFtZLU0Fj7IFDo+XZ+vyARkspeqVoa5b8xgoU5YdJ6Tbl+6LDOi9d76wpw=
X-Gm-Gg: AeBDievBenA6iMWLWLwLz/MTYeqfJ8tFymlYHCO1AAPjohZiwWkXDHmdV4QS2B70XwD
 KAnQDd8RqdrYQ2dI9njQfEPOPx++AdKEnRE3G5FylrYgKfsmzUShPXy0Z+3S3vTImi6rsfs5SJm
 x5EUrmrjj+AcfCAGMgYz84vpJz8o5G/6lG2/rvqvPLXtS5FcQwD1sdtJUiuMTWghldU/+UuJBth
 gF0fXBoDBPHFYuZEBlYupvWVXiyqf9WnzuuI6vOrj2tJxQk+krKh+YHqKfRr+22bTol1j0GpPdW
 S9K/GLdJHvxemBiZiGzcGqrD+yCpKrafGLz/ysCb76QDqmGC9PJQ1pGOty+2AdL8dEeuBZSZnXU
 Kn2z5KACvIY5EFCfVe6JYo3SkGi8pVkYNuC8OyiQnA51CrgqMDSvRnZRmwFnv0BL48PK9rq8/L0
 m+xGa3Ce71WiuasRMuaDRBRm1T7oMr3nklWbh1yQWXMuWhYYG9fQLNSXA=
X-Received: by 2002:a05:600c:5308:b0:48a:5565:ec3d with SMTP id
 5b1f17b1804b1-48d03b401f5mr164650075e9.22.1777975516588; 
 Tue, 05 May 2026 03:05:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a820c8556sm381856295e9.4.2026.05.05.03.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 03:05:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 William Bright <william.bright@imd-tec.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260428-imdt-dsi-display-v2-0-cf7294b5d7d6@imd-tec.com>
References: <20260428-imdt-dsi-display-v2-0-cf7294b5d7d6@imd-tec.com>
Subject: Re: [PATCH v2 0/2] drm/panel: Add support for TSD TST070WSBE-196C
 8" MIPI-DSI panel
Message-Id: <177797551566.290023.13794122301752818284.b4-ty@b4>
Date: Tue, 05 May 2026 12:05:15 +0200
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

On Tue, 28 Apr 2026 16:17:23 +0100, William Bright wrote:
> This series adds support for the TSD TST070WSBE-196C, a 7" 1024x600
> MIPI-DSI TFT LCD panel module based on the Fitipower EK79007AD
> controller. The panel is connected over a 4-lane MIPI-DSI video-mode
> interface and uses the RGB888 pixel format.
> 
> The driver is a simple non-configurable panel: the EK79007AD comes up
> with usable defaults after the power/reset sequence, so no
> DCS init sequence is required. It supports a single power supply, a
> reset GPIO and the standard backlight framework.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: panel-simple-dsi: Add Team Source Display TST070WSNE-196C
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9f5beca48f1a70a730c05bd62fe70295a1a36839
[2/2] drm/panel: simple: Add Team Source Display TST070WSBE-196C panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a0732f5d5803385d8eef16b049f5cdded45bfebb

-- 
Neil

