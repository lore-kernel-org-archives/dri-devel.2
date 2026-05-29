Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8D7CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 13:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E315010FF63;
	Fri, 29 May 2026 13:45:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GrssdrZ8";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9163110FF63
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 13:45:41 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4905e190c71so66675435e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 06:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780062340; x=1780667140; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/hmESmRQ7oEDRaIT7qrXfWDnCEYcDZdHNx/MwGQONMc=;
 b=GrssdrZ8G3yaoQdozo0sjgHF9sdOg9yAN9y1YYXgxq/WC0h9c+mgG3id79giKd/+Hr
 0O2goj3MT0JUmvKm6LDjG2WiUL9qLl/XKBb2UZe0U1Ocq6E8xwc320TxEbCN0SdhCmY+
 kEPTfojx/xFvm2fY87u173Ku3Ik7zzMeWgZAIxQj8ve26L/9jPaTTHkEn5tSgQaLPyPF
 lFd4IQsBy7qwVLs/FC5PIT67xt3zGiLoovTZ/3HNI0xbjK9ZQ2MxgMn8J6DmuIYVVuOh
 kLy5uaRAfQrW/RsA1zlNn6X55yz1kET22N+UFdA4es/5DQSR3jDlSRRB6a50c9C30eH8
 yq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780062340; x=1780667140;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/hmESmRQ7oEDRaIT7qrXfWDnCEYcDZdHNx/MwGQONMc=;
 b=nq6PG5ES6wF+jjYklTV98X0LJhXERGEpvu1RGnjkLc1YS0xt+8DWmImzkGhLRq13/F
 FcmRsGfdL/l22xw5GicmSRdxqvVOxs/PJyi6IM+6Gzrj+eTt/oeBTOVDosv2ducg2o0u
 2xAB3kbOLP7tHw5dRjGWruf/Fu7e3LwPpij6hx4rycDckgoojCGlrKTab3bKsrYKLAe9
 Hzj3e95yjDbiwuzUaK25UBVW+7kecqFzzsH8HbDikOqil6oBaIBJOIQhOGhJsQgrFDCV
 ht2ZZ1YpbllkGX+6xxi2922ESIYhqj9sizkreBsjBQld31Kj+sw/0Cu1PGNBvqaibruK
 wImw==
X-Forwarded-Encrypted: i=1;
 AFNElJ94dAVqdsTORYG657bnSGeEQpksmze8SCNPvfpVAtqHUCpp4lesQc+FVfxRfEivXXm7Z+TK4aC2zX8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/fERH8MxC6Kgbw9hU2BdXm8uIS4htoUOUFSUm+VglB2TyPoQg
 EW5bHpSIF/c32EBD8y6zCHy32NhW66ZIhNiM09SlOv1CKO/ExWgTKaAo3V2ssfC5is0=
X-Gm-Gg: Acq92OHP9O6kDm6q4PAfUxBtpvoZ6de0tRkYg8wOeKCvohKitBqfi85xvYayR8AXUsL
 cUoUbhFIXwEo1dwBkR0ELNrOxMr5TG1ijV95pD/WPE3CdnPMKr1qb5P1P/yyHFJFV1uLjFFr5B4
 KCIW/VKdnHrAmvP1Nt65CjdeA9RBdHy2x8WfIG1cFOuHLSsgD6GRVKj/Xfx5na8pqoOomDd82VN
 VgwvwKIqo+S3Z3xK90EDgtGkdN7QPOtupZjWPNreyjRu30GbT65+nv9Ze4/HExk1Vz7zm6uac1o
 qukH6NcbgfYW+VsfzGTx+rYa+DC74s1vvzYDgsm3/YT6LjSF5q2jJeIRX1VA+dlgfHjgrCYInGo
 efU75pL+jGTvnY8SOWEsIVDFEzFHSWZc+6hOqwMFeprU50uQqdZwZNwc931mPSHuVsVw2Iwe/dX
 FVrjqXMqLNWm8CiJdRAwM+zUuJf1glE9jUyJ6uXd3XHt4eIaDn8e2ZZ8c=
X-Received: by 2002:a05:600c:c0d1:10b0:490:5e2a:f924 with SMTP id
 5b1f17b1804b1-4909c07755dmr41345005e9.7.1780062339885; 
 Fri, 29 May 2026 06:45:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6eb3adsm41387165e9.11.2026.05.29.06.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 06:45:39 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Vitor Soares <ivitro@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260522161105.277519-13-ivitro@gmail.com>
References: <20260522161105.277519-13-ivitro@gmail.com>
Subject: Re: (subset) [PATCH v3 00/11] arm64: dts: ti: k3-am62-verdin: Add
 display and peripheral overlays
Message-Id: <178006233854.3611686.1401419911890133047.b4-ty@b4>
Date: Fri, 29 May 2026 15:45:38 +0200
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

On Fri, 22 May 2026 17:11:04 +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> This series adds device tree overlays, expanding the hardware support for
> the Toradex Verdin AM62 SoM. The overlays target displays, cameras, audio,
> and peripherals available through Toradex carrier boards and the accessory
> ecosystem.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[03/11] dt-bindings: vendor-prefixes: Add Riverdi
        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3764568dd2e621850c8c2a34dd8a88096ae73e72

-- 
Neil

