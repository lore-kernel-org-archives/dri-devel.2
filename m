Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A69106F309
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B8810EA40;
	Thu, 26 Mar 2026 09:03:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mD+9Hh3L";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7EDE10EA2F
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:02:42 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-486fb112c09so7018735e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 02:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774515761; x=1775120561; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59XUKTpWPiWuJ0qGTQSg3OcQJUTrCTmU700lEtiKVbk=;
 b=mD+9Hh3LKnFQpl7t+AkLDgHly6agVqDirqr6uwKVJAd1KMQ9+6zLYEt8a6Vh5A2EVq
 PANebqxkzfMbKXsjDqStqhGRqEbb1xI5evurrvnetQxWf1Y2zWIBJb08S9JEjLaW7H9w
 X8z3yYCu4mmTsTMYQSROi3XNDvHNbmnWAgMRNuZ/H0FDj48rmwa1muZUmPF8oQFgjmlQ
 qqlyDuHVbuSnyCrEKHPGEfAwmrYtGjo52S0qfw4ecnjc6Ltn6zjsQ2kX5x3oIJIEfZaS
 fasj8Os0qPvIN7+9ba0TrNXPYTeM9mPll1MPWhXh+/AuR9RR6QOwIAUR6evuvsRe7GEY
 ygQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774515761; x=1775120561;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=59XUKTpWPiWuJ0qGTQSg3OcQJUTrCTmU700lEtiKVbk=;
 b=FmgdEW5GRt+65TvQ51WhYgnGdl8SOUMGuslesjxwlObhyYTqcKf/7mrdspZso73XGK
 rv/MRuXhKFyE5YuFICVXH/gSF1XDdNI+J/iyTfmWhHKlZ3c7h3dnz9tSxUdWwpAdL2O5
 Zd4AtNZ9/gFfB++jjvevpxKBbQEqagnY3OymTuquvSziZrR2llP7HwmiUjY/vXUW5KpT
 b9vBoj8pUWc1YKkS4KgRr29GTFqX00vUsFPk74U8P1Olosb0w/67ioWix9xZ4boYAHyh
 aRLDQ0AS3FLUr0+voLoma21OUGJnOdyM7J6jAUyJ0antD/XvahLwu+Z1L3pxM4RYzvem
 +nvQ==
X-Gm-Message-State: AOJu0YznjARGKPaBWCwajYCFpFXM4cXM2zxYSAQqPWIKFn4iXsKrqgIQ
 b1bKCprqn/OzG/Gapqhtl6oqRe8eGQyM8qR1lvehFveFJSsUducoGHTK5F0hqncYfrM=
X-Gm-Gg: ATEYQzzKxi+bGD3+6lZcqIinXhqHiqgU2qkHJixvnGPqcd2rtdO/keOldfLwDTOFBsj
 N8HiQQf/rY8/UnzxcoOk/4iQ0udt7p2oPl1Yb9mIigEyMLi+82JiOPDqG9AD/Dlb8w3bvimAKnp
 /mWvBRsiS76BZWdSiuFJhh9yi+6vqyrfHm4lSUAhcM13DmvMMYesIkKsRfMSPAEImi0tRzt8zIq
 LFc8H7EXSqIx1oYRO97HvN3iMQ+bDTRaRhne9B8B1inNFvyaKQ0iu5Q75tNSNm3xJl/QiZDwUeh
 OOmA9UI/ZQXPBXuLFUEO0mKmjaKXju7pbVNfQbuNMf7VbXOfnpsCWw+zLU8zyfNwzPcENB5EEGA
 tswiO0MTJ+U9j+K/Zo+YPb4YTZ8T3pjDCdEiX+Qq97+i7KHfD0xvnRv4DalW3WHJHqQN/Rz3AMe
 DA6kPTyIV/gmFky13QdV9+7bxdqzreTUCUEijxRdmdcswq
X-Received: by 2002:a05:600c:5488:b0:487:2432:f7ed with SMTP id
 5b1f17b1804b1-4872432f804mr906285e9.8.1774515761105; 
 Thu, 26 Mar 2026 02:02:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf069sm6213436f8f.22.2026.03.26.02.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:02:40 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Val Packett <val@packett.cool>
Cc: dri-devel@lists.freedesktop.org, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
In-Reply-To: <20260217070121.190108-1-val@packett.cool>
References: <20260217070121.190108-1-val@packett.cool>
Subject: Re: (subset) [PATCH 0/4] Add support for hx83102-based Holitech
 HTF065H045 panel
Message-Id: <177451576040.103892.16399746050578598756.b4-ty@linaro.org>
Date: Thu, 26 Mar 2026 10:02:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 17 Feb 2026 04:00:08 -0300, Val Packett wrote:
> This 720x1600 panel is found in several Motorola/Lenovo smartphones.
> It will be used in the device tree for the Moto G9 Play (sm6115-motorola-guamp).
> Fully tested on it, including brightness adjustment.
> 
> The initialization sequence is based on leaked documentation found online :)
> as the sequence included in downstream Android DTS was near-empty (I think it
> relies on the bootloader to do the bulk of the initialization).
> That documentation is also the source for the exact model number (as it's the
> same vendor, same controller IC, same resolution, and made for Motorola).
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/4] dt-bindings: vendor-prefixes: Add Holitech
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/c122ddd573a90363d18d5f08aefc48f98b40c3d4
[2/4] dt-bindings: display: panel: Add compatible for Holitech HTF065H045
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/896e7b8c1780734833abaa795fad7eec0cae8125
[3/4] drm/panel: himax-hx83102: Add support for Holitech HTF065H045
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/cc72a4734829648465d52484620951199d2ab1e7
[4/4] drm/panel: himax-hx83102: Add support for DSI DCS backlight control
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/987170d0b8da06a399d867c609b5689f3e8dfdb0

-- 
Neil

