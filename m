Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85599C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E538710E45A;
	Wed, 22 Jul 2026 14:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q+ZhzryJ";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 385B110E45A
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:23:10 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso48245525e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784730188; x=1785334988; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6DyMgDBLdlc4MSAJ/0qjv0HubLavSr5g1w/PqV6qWLY=;
 b=q+ZhzryJPJgc8cLF9k70voAq9ZTC+/mkhVv/SPEWjfIvHe6Yp5CYKzykhr3yh7ncT4
 wBkNYz0ulW3hsjTKcI2QE4h1OT2hO9xaSKI/e+hkrA59UKZ2Bgwqc9Z03a9hYL5N39Cf
 xa8pe4uGtchj40wZsvAXDohVy4VDCUkvttCl1bMcu6V7ZI4/HOhuWQGk/kuspGkTPNgg
 pvEib1pPY2WX/U8ilicHWi/GA23fOuPaC0ilGaOw/Zf09SRv02nBQ0j8gn2hdloFrY97
 YVGXXieCwam2RMi5dMFzQTXfabzG68qUqZ/aH7bCl8B69kM8HaLan/A508Oo8fvr9nWs
 22Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784730188; x=1785334988;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6DyMgDBLdlc4MSAJ/0qjv0HubLavSr5g1w/PqV6qWLY=;
 b=Gf3w8Vxj1tliYLMJqrxwxaF7UBd6aiAdMFQ+PqiBHo67QZAkTH6DPAPA3svuGC2NR/
 hUh0PWFPhI6rQ10kNh3J3+BrL85txinNyGwYHLR2ewZdHsIWIOleH/36W4S4ppoOru69
 lHKxVIjECDa4OchODuBpil5+eLnErkp+hUBYWUySmQqm8OlUW2nJMkxNxGojEvb5Tekd
 7LNyA3BrO81CzavvruZDzHo447VkkapfGkjtF18Gk4xHiCRswQE55JPI99TrbFSuOizR
 6q8YZ5ax6WyDxHN2jlcGWBKZc+FK09oDjyvUSZ3L8MgQZ97f8JQapMEh0Mj7DYOsPswm
 NHgg==
X-Gm-Message-State: AOJu0Ywz5dqbhdEBfX5VMaIlYmebBO4TqrnHwoD2fGPuhfYnV5jhMsxH
 IOCysCprUSJxdjMd6ohIPKFoce4nKAO/rEOTsbfJeo6CMP+f1pld65xEb1ZZ2FmnRok=
X-Gm-Gg: AR+sD10lp4iTAPlDNGrAGuqVYVK/SQE6EoxO9aM2gt+dCACgTEW+GFgFcIagwk4xrI2
 D04ulgokUKW3/yT3YfnfMaTu9EAO0ShsmDfKMFvGPg7WI60Jyq7pXCtRlsJsEJbVD5fHv/aI1zq
 QNr7pH40YgOCJyqSOSQWnFpyS/p37tfFgZq3wLYYv7jSlABrlAOU0IgMMOTRFGzfu/TJdRTN0fD
 5+LwTzT8d+nZ1oqzVkoLaAmLj+33NzvEYAOKgyricjDeXUuZWVbb2sw4EWySnJs7rF5W9MOjCNQ
 iq2rYojJhTJBrtHCke66jeBN4ZAQOmDlMDi5FMp/kWEr9CNU1sXduG0j2OhfMWMdkwKX6GPV3h7
 qntRrj+DtYpdGdOS45GsL3jj5iQzqhfG5YwNH040hwyioYnU1s51Fs12l+Bc0aD69D6vWygxfwe
 qPSsJfqEok9EF67suPHU1WVlY=
X-Received: by 2002:a05:600c:19cc:b0:493:b877:fbc with SMTP id
 5b1f17b1804b1-4954a402fcdmr294673445e9.21.1784730188436; 
 Wed, 22 Jul 2026 07:23:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c8760sm138527875e9.14.2026.07.22.07.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 07:23:08 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linusw@kernel.org, dmitry.baryshkov@oss.qualcomm.com, 
 David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Cc: jesszhan0024@gmail.com, upstream+drm@sigma-star.at, 
 Julian.FRIEDRICH@frequentis.com
In-Reply-To: <20260713082213.75759-1-david.oberhollenzer@sigma-star.at>
References: <20260713082213.75759-1-david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH] drm/panel: ilitek-ili9881c: do not fail probe if iovcc
 is absent
Message-Id: <178473018784.1921106.8982509983996002656.b4-ty@b4>
Date: Wed, 22 Jul 2026 16:23:07 +0200
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

On Mon, 13 Jul 2026 10:22:13 +0200, David Oberhollenzer wrote:
> Commit 4c95b2b7d49e ("drm/panel: ilitek-ili9881c: support Waveshare
> 7.0" DSI panel") adds an additional iovcc regulator that other
> Ilitek ili9881c based panels apparently do not have or need.
> 
> The commit goes out of its way to make usage of this new regulator
> optional, dutifully testing if the field in `struct ili9881c` is NULL
> before touching the new regulator. However, in the probe function,
> it unconditionally fails if devm_regulator_get_optional returns an
> error.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/panel: ilitek-ili9881c: do not fail probe if iovcc is absent
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/fa989f2cc351aec3643350489553c9bdfb3adf9f

-- 
Neil

