Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E65FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 13:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5875810E162;
	Tue,  5 May 2026 13:40:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gJgL3IsT";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E301810E162
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 13:39:58 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so51164925e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 06:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777988397; x=1778593197; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q9i4xxSn9eutY7AfcA0LT9wjkxwL7STvSRkjGv2EmcA=;
 b=gJgL3IsTRnNDH2/KAvcPv+pSleo9f29DQR+5t9iv43xCipujvmvTTpRnjbcCstZtI0
 yYaKr4qR++Sd/wn8MZYg6INEHcqwlmwWoOgre3zjZUWotxGaWCawS5XTy6P9Yc2ofMJG
 iwvdAWBTcstuZqtxbB0/X/lXKwAzntGMtsVRsINyd/yEfj9ORkCmmctoIqF5m9eCs5Ef
 wchm0RkWFP14HpcsES1pRpBkk6cxnsDqMiABlV3xAsIZigoVk6aA+pN7gZBxNTlfLjSs
 P5xdOvitypfoPEbhdixo0LpPP7y+J6n6ghb5k1DS7hlrP+yyAQ6+YbIsE+YpTeBzhxdv
 NBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777988397; x=1778593197;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q9i4xxSn9eutY7AfcA0LT9wjkxwL7STvSRkjGv2EmcA=;
 b=HAvJ7Z2WA++ixFTzY3iqYk7JR4AFgCNRmTqvvSgoyjB1uGb+HIPK9mUWS3g/DYXTle
 AjXn5pZWDhVlryYj04z2hmm2Cjse3ltiTwB5u0i0n5MMmO4VFL5B0UZz6g6j9gsV5XZa
 S7snUSXQlMSr2HdTepQWuRB9FVnkat+AdLVsOGTwdyN/2EDcgLgNszZeChtt/q2Gta36
 cK6uUHRXN0UrXRjfU1bxtnKZQB8jTcmKlNjnMeRez6/ZmoHAOHWhfgMyZ/6oaEY8OTpz
 RbrCtXAonh6EsKqQScD7cyFm8heS1YnO5JiDbMKp7VkuJzNrwCiydXNIkIs60HKQgTT7
 bCDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Yt8LW+HGZ5bglr5LQpaI7aKCp+798YLKLWJF0N3B2NUAhfkYGqoPylorb9EY0b6DuURBhQ/sS6kQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx05GgZQPRb5EIZtmDHdILfUL4I5tzVTrvZ/k0kz35Q9VrImxt5
 nGmA2tuEgiR/Kv6ukTG6/btO2SBeS5XDTKIWqRNnG4HfwfGaSR5rbgZMGt1SwrPOtOw=
X-Gm-Gg: AeBDievwIeGSn9ip2fydfkMkLb8/nKi08LS4Z5c9+D390sJuU7T3/Fze0/9tSd+s8kS
 hq8NwH1cWMyr+1cQ1TpuAFkLGSXyTcXGEf+z9yJlS3Kxet1Az67FbHoeWeFbVLkvC0OpeoIomPN
 U84BNV2h4fmHmzMrn/fmPrTqoHY8ZKIZDQCmocfCjjyL3XLmsS3iqOsRAXq8ndxNXdmpHBo0iR4
 m+dNOOJf1ieW1PrG0VC0lO0Yoe6vfvNDEwqgNTENBJvdIyqGtvanK4mxeyP0KzR9eVll1OkE7Uk
 JL8LA0LFJ47898QI5fOwRXruHh+WtYaTzXxrWGP7IWyRv3h+OuVbvuB7ZJPMZZV/unosE5j/s2F
 OVHXBByKl85PdB/Dx03xPYapfuWE4WqzWiNwgWWEeRS3b++tPxl1Vqv4QMazwKRSD23bnFMhnHL
 XR/vTs1/2kRhq5mFR+xUXt5/U62D5XSu6ZE7NiZeih2bxWpoUOYxiLxmM=
X-Received: by 2002:a05:600c:45d5:b0:488:d6eb:e63c with SMTP id
 5b1f17b1804b1-48d18be7d40mr47830475e9.15.1777988397154; 
 Tue, 05 May 2026 06:39:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82301b7bsm474114715e9.11.2026.05.05.06.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 06:39:56 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: jesszhan0024@gmail.com, Chen Ni <nichen@iscas.ac.cn>
Cc: dmitry.baryshkov@oss.qualcomm.com, linusw@kernel.org, 
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260429080527.1456732-1-nichen@iscas.ac.cn>
References: <20260429080527.1456732-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] drm/panel: focaltech-ota7290b: Fix error check for
 devm_drm_panel_alloc()
Message-Id: <177798839638.721826.3094234345503819306.b4-ty@b4>
Date: Tue, 05 May 2026 15:39:56 +0200
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

On Wed, 29 Apr 2026 16:05:27 +0800, Chen Ni wrote:
> The devm_drm_panel_alloc() function returns an error pointer on failure,
> not NULL. Fix the check to use IS_ERR() and return PTR_ERR() to
> correctly handle allocation failures.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: focaltech-ota7290b: Fix error check for devm_drm_panel_alloc()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/71fa1bccaa957b0f51c1e1bedff2541741ec2b0c

-- 
Neil

