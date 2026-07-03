Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A79C43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ED6610F6F8;
	Fri,  3 Jul 2026 08:42:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ot1jt4jB";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD2AA10F6F1
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 08:42:23 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493c2c0b9a8so2353995e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 01:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783068142; x=1783672942; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5y/LlnctUnWczLr55nRli7oZ/AlDp7FE9PGkSlaB9s=;
 b=ot1jt4jBmmM5EUQsdbk8JgWksyh/TJky4j2Pp9sVwZd9KO1Y7rG00Rf9/7FWncKa+n
 HNOuJ3QGA5FbhGzcBLBqNN+THRg08O4Oq2g1oPZ7YWVGY1VvqrIshTsRYaMDl7rTG9nS
 kJ7QxtSL2vWRV1MHlUVm++gcc0I0pEMuDhRYLHD7VDOf6tSyFobdgUElamGJvfdjD8gq
 m3WjI1IdCJmuDeXWe+5UWDHSTIULcMB6/GPj5PGnuju5X6B9veZDt8meEx+zugGslGYL
 fqq8Pfa+vo7nOIc/rVDtNSVy9mxOJ/onJDvEL28+KikJ6YEJl/isHnt09cYqiKQdO4Aw
 3/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783068142; x=1783672942;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d5y/LlnctUnWczLr55nRli7oZ/AlDp7FE9PGkSlaB9s=;
 b=tBVu376E0GUwU6ZO6dF0evzNkH4StgGOG0M2uJdZQ1aX5hbjr1XngKsYz4UM1fQnQs
 oGGNJ7Sz/h5y7fkTGIhJ4rBQY95NcfMo2XOl1yDqLuSfbzJ3exMZadKLviRKj8qM35vb
 G4rYQbL1zZ2LhJr0OWOhPfmlB22VlmMFFalfJaIrw/CPebzn99wgzvHmN7TCfrHs/R6N
 k5zp1WEkxy2+8s6rNJ8cttZRnC7j9OwiFy2gJlLpmXppWsQzMzxqxaZ1QV4RB+BvvO5A
 RXZ36SC/sUaSk2mazRMamQxo76jCNY5dcQF9RlY+FqRAmOeQGqBmHfqJLsZX5iWjN32u
 65DA==
X-Gm-Message-State: AOJu0Yw2iasGFjqQvwCslJPmTUc91fFDyQE/s3bTwMGfcvjyYiUSRRg8
 EvNXTRs8KAHH0GEDk8Jx6boMZh2fjug8gqrgvb0n/fso/QnnvscdqoT23xrn6kMncKo=
X-Gm-Gg: AfdE7cm2HyQ3/gK5yENtn4WrnNczR53LWniZLw7ykI2/eu90L4GpbYY5Is1q6JYqt4U
 T4Sp4923aywyN1xYLKXIcOpcy53Jydcc+5fRNN57VS64z/oeHmz57n8nvD9utER7DAueIuVQbaa
 OwwSG9GsG8jrXRu19a5IinTK/I2zSYrVXrYpCtLA1QFI4VA0b9MHGCUyipp53OOEkjcdnehrE6z
 vKGH4QE/RRSHh6238VMUyX813VHGCAvrZYeYT/m6n+piAke5OX14GjcaZy7Ue32J7akWS8irMdO
 5L/XV2skKX2djR/19C1RAMkeAqETMXFfOsed8giJ8gc7vMRh3mbb4Hw6Sx/8FwGs386eD9zSSOH
 3Dd/wUuLEVeeSFbxH2GqAniwONgZLmW4JkpPlQc2adK1fzR5XZiTrCKey+5nVXdQ/HJkqcu7Yi3
 +Do4rnloGqIEDw4qDWwarbQc+wM25wHYJ2Pg==
X-Received: by 2002:a05:600c:705:b0:493:b962:4abe with SMTP id
 5b1f17b1804b1-493c3dfacf0mr84107845e9.36.1783068142021; 
 Fri, 03 Jul 2026 01:42:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab27dsm30001575e9.4.2026.07.03.01.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 01:42:21 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Conor Dooley <conor.dooley@microchip.com>, KancyJoe <kancy2333@outlook.com>
In-Reply-To: <20260522-topic-sm8650-ayaneo-pocket-s2-r63419-v6-0-16edddda9951@linaro.org>
References: <20260522-topic-sm8650-ayaneo-pocket-s2-r63419-v6-0-16edddda9951@linaro.org>
Subject: Re: [PATCH v6 0/2] drm: panel: support the R63419 based dual-DSI
 video mode Display Panels
Message-Id: <178306814096.3165305.17752151699717315900.b4-ty@b4>
Date: Fri, 03 Jul 2026 10:42:20 +0200
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

On Fri, 22 May 2026 14:51:23 +0200, Neil Armstrong wrote:
> Add support for the Renesas 63419 based dual-DSI video mode
> Display Panels found in the Ayaneo gaming handled devices.

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: document the Renesas R63419 based dual-DSI video mode Display Panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9c04ecc893f07d001e484e6c420af19a970f755c
[2/2] drm: panel: add support for the Renesas R63419 based dual-DSI video mode Display Panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/1190fc8d7b8a9cebea8dcbd2e544e43990ae81d0

-- 
Neil

