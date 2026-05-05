Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CC9FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 14:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3803710E05F;
	Tue,  5 May 2026 14:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pUNzQr+I";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC9CE10E05F
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 14:10:26 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so12240525e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 07:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777990225; x=1778595025; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6MZe1ybGVBCmTIv5/w6ZroHfedrBg8qQBo9KFDThLQ=;
 b=pUNzQr+IQQNnP2lIXduakD4ew9a/n8WY7KJq1DJYdzFTzJ5rsYrYtnL5Bf2OZPgvPb
 5kuqAh0stqUj+k3Q6SXG9hMEhpXAd9rPWOrA7yxNYs7neVuC4AwdGpLb21N3NhXDWK+f
 jfiaN5tcdU5ijIwK3g5RPAqOMNir63SlaaWT7Kh9s7mUoPQPJU6fhHtf2aHZ6oHcOOj3
 YsyshaPSmyMyQ1lAgO8gKFv1TOkBQT2pw5aBVCb+bkSMKiEffup8J8SfLTM82QYyTKvO
 9dqigKqYtqHoSI6aNvmQQywRApzrhYDr0bUNs9zW2fYIH86TO5puuO8/ISiVsRf8Xtgv
 eO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777990225; x=1778595025;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X6MZe1ybGVBCmTIv5/w6ZroHfedrBg8qQBo9KFDThLQ=;
 b=Cu52VZNvjvpq1J17Xg7Ygs4R+cBi6aQ4/TjiBXDUN1iziibnXH1Xd4g+GNFO+B2rvY
 B5HO3H+BuPbNsQEK/oH7f3v60oaqE9Xc5uF41VChzPPIS20IJ0c8+EDvGLnmmxTrPPFk
 rmDpPXsTsa3cNESFv6jEDr8Qe6EufWwIw93j16izDasDmOAfo+ShocX+C/RLh3YXz14P
 LeHTPgbPSf1WYeOA53PNak2Tk8gWgA6efuso9wuG3PP3qn6G0k8pF2oHN/RXniISWHRx
 sC2/jJasCerKeZrXxmiYsiyhAJz7f5MqiQMCu33Zdka4YE1dzr3j8wEmBU5Q0tSu0HWb
 vY3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ95ZXwguuq5vLVshHJxrUX0F5fO4t8kMGPiuD8XGj87dovojkltGBnG+KYtyAQgLFFnoUuGa0WDqws=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzp/3SLxNItGzYMOZnOYL97Mnytb604RBGtJt9Qgas2yUWe0TBM
 IE1haC7VpQHI51+Om0jCjwz/UXobsi4wa3HnxAGecSU1jcQ0hyk8fwmYvD2or0lkgws=
X-Gm-Gg: AeBDieva3MGy/C5TeA3Fc9YMowvORoqIMLwfBEdErkYq1GSpv3Znyvn3BL2tcQlDE/z
 wVX29tjbC9AHvIOA5eT2b4j7rXPbrHi4gxn3ssZjrpXFY+WXx/DuqdeQXo0s4ofoeM0JU9+Q+h3
 eYcLpYEIAhjm7t7Scv4W0fkgF/7S+FgLrBhzrJQvttOaAlPpNx9sgiJTIgqfOZDsr7w2ToYqM9K
 G8XkvS5UxP+wzHgpgfuoyS8T21VHiG10njpDRsnmv6VfKqH1qPc0OaCC6YJr2WZzHL5icHXX8zL
 D7bu2r0LEUuuVHWJzh9bsUbGk4cQA1tK0P/7FgZcYznDo/0GsKN8cEwqgX9IUw90dIbWGL+fLBN
 kqXz4h21+6UuGz47DK78S49cPwZBMLwicJ5oM3E0pl+RFAiG8VnUQiVlDiChdtoXgad6NOWHwOs
 O49wkroCg6DewZQZz1YSDcONCVa7mvBZCU4YgnKSNxcT9INf7gLDZWjkE=
X-Received: by 2002:a05:600c:6298:b0:489:1f3e:5f6f with SMTP id
 5b1f17b1804b1-48d18ade677mr55583295e9.12.1777990223873; 
 Tue, 05 May 2026 07:10:23 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82307f7csm409279785e9.12.2026.05.05.07.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 07:10:23 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Heidelberg <david@ixit.cz>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 marijn.suijten@somainline.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
In-Reply-To: <20260505-panel-clean-up-kconfig-dep-v2-0-9cc31d6e6919@ixit.cz>
References: <20260505-panel-clean-up-kconfig-dep-v2-0-9cc31d6e6919@ixit.cz>
Subject: Re: (subset) [PATCH v2 0/4] drm/panel: Small Kconfig cleanup
Message-Id: <177799022301.801510.9046759541579593814.b4-ty@b4>
Date: Tue, 05 May 2026 16:10:23 +0200
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

On Tue, 05 May 2026 15:53:39 +0200, David Heidelberg wrote:
> Inspired by looking at Marijn patch. Since Marijn patch is not merged yet,
> appending patch to my series.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[4/4] drm/panel: Enable GPIOLIB for panels which uses functions from it
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/ae3aa8cf5fd5ccb428a814e7eb38ae33ad1cfa34

-- 
Neil

