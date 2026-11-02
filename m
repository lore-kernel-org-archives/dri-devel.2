Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0197F606A333
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=p9y6yySR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB5510EE58;
	Mon,  2 Nov 2026 13:40:43 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FFCB10E623
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:40:37 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so19336035e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626835; x=1794231635; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Md2bnpbIvy2X912Bc1LhqLaDZUJHkR+XqT7pG6E7/w=;
 b=p9y6yySRslfFI9JRuo0kerxsGYjj53ySemysrIQ5rBprj6RbKpoZpR1Ixo7gbUfAXs
 +f3Dz62p/IMfsWGbGapxgRLynQ0JGJmavWsb528+achB/HRrreG/97slhm1/a0+nXZsq
 1h7zZnHH2+otDrMj6ZepQ9XP9VZCl62izbGLY0LFaXulpLLUOQYavyP/ReZCK1i+aoc/
 O1L3+tXNeNvf+Vbhsm0q3JQDfZSvN4lLPvUUKgYUyDVvslT6C0nPrOPgKl8sHlUqGm5J
 RSHOAVR5xfDZvKrx/zk3IXYMazexBb/fHjWhvk2SrVHSiCzmV2hOpDc+rsQNrYa9EDgC
 yWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626835; x=1794231635;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3Md2bnpbIvy2X912Bc1LhqLaDZUJHkR+XqT7pG6E7/w=;
 b=oTUsHS3oFfJGcymDUzrujd3WdyiTR6KXRALAWq6xgPixlpA6bxOS5KNYXQGiHzu+xo
 Gr1+HN9OSngpwvdjv23lVoEumP79b6jmk8vEcZFOxwAKujtfQdTIRgqBEIYmbSgc+BNo
 BxgSXuYTP00s3Czs58sU/RTS1ehyCoQTQzTBL3GYmQNoONrRYRA6ATnxn2gsFbaP9E3E
 LuAPZ2WIW6+suEEafxCTolPV6S+FHdXPJBP8iArMElpHwfL3NR6teBUIgQn4KdFafjUi
 L8/R3ihfeh3zVQsemWHpA/3IXpJddmIh//gNDM3KQp5fuLLsyCSO5r8iRVQ8Y0Mye8d7
 IQ1g==
X-Gm-Message-State: AFq9FYJwoCybASoKNOnhksCSOS5yvbWY2iFtQQuh7dQAFyOsfwSs7kHI
 O92XGnKT8PJV3vyecLV+Nxsk3AEZ6e4Lg2+fuEe0ZfNtruKvyJ6tn0o0gaRJbbElyfI=
X-Gm-Gg: AYBFou2iGL/ZPJg+GX8XTcNbaPWfrzIcNAZqYO/OsTMVQMkAvsXoT70HFNr38Ah6Yep
 sa7OG7Y9G/Bo+6g04YlpLdQjINodk6DANH2LN+N3zDyddJpXUjyqMTzBPh719BTxK3fTgJwEw9+
 5/jqDZd9yZ3KpN11fik8La8GsVn1mNqascLRWT9NFILSuZu+dtEQ4UWxw+cOmcde/xyoJKV5+BF
 bZj6b2OYwcMDoywixUuyY14EcT/apUytyPyHeBl5xp4ikVdLzUQh3BxkGlvLva/I7SDweqktQtm
 WxSXQdVbHUlpzc8GgoA2+3zOTFLCeLao9M+jINUQ8/hr+PWeXDBn1eD4VpEO7PawMm+ZP5m5kD9
 JwjUp+l0CUqjNtq9mnV8CKbFU3/yRIn4rh3upYj6lOXeMqhcQrNqt4hoi6jA6KQLJcWSHfOx8Hz
 ak6Em6FNSY3Z81VpUwDtgqfq51DXHJDNBMI0BoVfdm64/2yXfA0zJu7D7Fw9vqupOuDkSZ7CN8R
 T4mGTRZXKXYVvCtTDRL52CmjezokjjRbGuWzPsF8omYkOPTd+4n4sXi/Nf88WN6vI+Gz7J7+V/3
 1184Rk8vh1sr0GcmOu+4wEBzFTJLt/b1LEYtkb+cl/rADaeYXA==
X-Received: by 2002:a05:600c:a4c:b0:4a2:967:dfb8 with SMTP id
 5b1f17b1804b1-4ac1765d7d7mr233451845e9.20.1793626835401; 
 Mon, 02 Nov 2026 05:40:35 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abea533a1esm189194605e9.1.2026.11.02.05.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:40:34 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20261006-panel-himax-hx8279-vddp-v1-0-50d884b42aae@baylibre.com>
References: <20261006-panel-himax-hx8279-vddp-v1-0-50d884b42aae@baylibre.com>
Subject: Re: (subset) [PATCH 0/4] drm/panel: himax-hx8279: add VDDP supply
 for Startek KD070FHFID078
Message-Id: <179362683429.3310106.6925209959908507351.b4-ty@b4>
Date: Mon, 02 Nov 2026 14:40:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, 06 Oct 2026 15:25:00 -0500, David Lechner wrote:
> The Startek KD070FHFID078 panel has a VDDP power input, which feeds its
> DC-DC converter in addition to VDD and IOVCC. On the MediaTek Genio 520
> and 720 EVKs, VDDP is switched by its own regulator, and on the Genio
> 1200 EVK it comes from its own PMIC LDO, so it needs to be described and
> enabled. The existing Genio 1200 EVK device tree also turned out to
> describe the panel supplies incorrectly, so this series fixes that too.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/4] dt-bindings: display: panel: himax,hx8279: add vddp-supply
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/6ebc6210efd3502c8ce2b1b2740ad61f69188df7
[2/4] drm/panel: himax-hx8279: add the VDDP supply
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/dabbf2758be8f05c3757bb4727f2e48fba4ca66f

-- 
Neil

