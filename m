Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B856606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BB/nN4or
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD5B010F015;
	Sat, 14 Nov 2026 16:24:54 +0000 (UTC)
Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7822B10E7E5
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:14:15 +0000 (UTC)
Received: by mail-oo2-f8.google.com with SMTP id
 46e09a7af769-860f8b7b943so448623a34.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794586454; x=1795191254; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dNTZCO6CVD9uiA7Rqib0iVTPKHOWhKLny7CTKnD008c=;
 b=BB/nN4oruUEscgOmtIuuvJKKxNFkdgsWmbvJHicxEYsho6EaX90XqzclA3+bdh3tbS
 DzWAQpjwv2X/M1ayw7YlirSgohwI+etlF1N1OgQaJ/fsvY/ikVA9JFPrPdBnSXiWJLoC
 wo2Om3nIzEfBbf8209BF5rQfNn99ho0mbSav94aKijOMKEwCFME1Ldn+8L+p/vr9OpnV
 ZPcjGyHdEstecFoYpkX4tEBWk+TbUuT8RZfxXwjSvDQBbG6nnodMK7+z9bw2gXANEyMQ
 pmv4X08poMYi8XWIsJE8JKjYyz2zwb4DD0txvVtPhdlJRl5lCaoVnsfzgLFZKdqoKqKo
 lTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586454; x=1795191254;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dNTZCO6CVD9uiA7Rqib0iVTPKHOWhKLny7CTKnD008c=;
 b=Gg40ox2PJ/tsaHB0RYf5shTTlrIyFhci5lOfVC4s3PkXFUBvmIgwNWhzV/VSwHkxZS
 BsP3o3omhaUcnMjuO3oztwyBrzwoYBH4eqfBNpma0K0kKdvBBTyHWwYzvGXAmeA1lMOr
 eO2qczEptB5Pxgwa849orPK2p0027cnSMGDYPaW1dCf8Z3lft7TrqTEhWJPZrwsPszzd
 IyrWhriVvWhvU6v8Ca31tO/mNCrFb00DJCzShf69//3hNjK5tg5+cH37S8ETVe07oBLV
 NZRn/L2r90ny7m5dhUZ63iPBfVvPW22qwMH8jR7Y2MEYkTsVthlp9FMbkuWj++cXIVwa
 fo7w==
X-Forwarded-Encrypted: i=1;
 AL+hErH5WVzIyOzbRqKzgAL4i5AE70dFAEdRPrl/mM3p2tcQ2fnu56+TMiFmhvBCtqU9hpVd/pDMblLlZKg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9z5BAZrXXoKUnejgagouR7iC2YEP1QAfTQmrNcPDxYdtMbZ2JO
 6nM6qllQ2zNyl2/Gya6u1qkP/LK+UyOljak1hIjvdrKRfRpwTJUnx6W1
X-Gm-Gg: AYBFou3/eCfejsAqCveYNNTkVdjluXf5bvL8Jix+sq5Ye8//Xs26H+0EnIXz4IohKxL
 MIeqLZbFTzdqEl+YqJKqTxDZHCSJnF1FOvUS3P9J7ixFyltG0Rkv/sfQY7oIYgsO8JVIalfSs7Z
 /TrO36D9+lqSQQG8emvNFXuOF0bhSHUHjOAk3xsD9HOl6oMGs7ANzGovQwX7GXWriLw85Xwy4B8
 0vlu/9pDknnC5sJ3MBFIHRhQuWVE38cGZLJUnkdgDDpDvzz6J+mujUTpAa3XYbLbxfN3xc+Q2Ic
 Hi/rz9uXaC09PY1VYmntOMT8vYnpGUasS10aiU/Ge4BVaqvWSj3/q/obAzA9PzLvP7QrCLLKjND
 xMGIJBxZOhYVQ7jydvSNCctOYkMbABfyA9DSnwkyOgLxJFl7soLSVzdEyhg9ANxnggkiZVve4VH
 AvUf0uJCnzkHJHqOL5cBdAhmKbwANnh22q1jy6ohvLyyiXQGbOp18tLCDTWVrYGXv7I8LdTC9OL
 JYnuZwJ3vmEkOhOGJwTrM0MD/+PX7BE8NulUoPk2uKygHAUbm0tyDDjL+uR/FdftQ6jV61ZY+iX
 hEMy14KfhmuARS4TAO4mj7SgOt3h4XHPZUEEzfNojmbqRkcqtpmRHQSIYa92swHWOL75+So+lBL
 Qr/N6OtfP1Fd7JVQ/Pik=
X-Received: by 2002:a05:6830:3491:b0:85d:6045:52cf with SMTP id
 46e09a7af769-862898c8b4dmr2468232a34.12.1794586454518; 
 Fri, 13 Nov 2026 08:14:14 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net.
 [64.207.253.118]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8628813346esm2668473a34.17.2026.11.13.08.14.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 08:14:14 -0800 (PST)
Message-ID: <36b0b778-a5bb-4b85-b36d-d4408c3ca6fa@gmail.com>
Date: Fri, 13 Nov 2026 10:14:10 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: display: panel: Make DSI panels port
 optional
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Selvaraj <jo@jsfamily.in>,
 Jagan Teki <jagan@amarulasolutions.com>, Ondrej Jirman <megi@xff.cz>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Cristian Cozzolino <cristian_ci@protonmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Nickolay Goppen <setotau@mainlining.org>,
 Robert Chiras <robert.chiras@nxp.com>, Alexander Koskovich
 <akoskovich@pm.me>, Marijn Suijten <marijn.suijten@somainline.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Chris Morgan <macromorgan@hotmail.com>,
 Barnabas Czeman <barnabas.czeman@mainlining.org>,
 Heiko Stuebner <heiko@sntech.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Arpit Saini <arpit.saini@oss.qualcomm.com>, Michael Walle
 <mwalle@kernel.org>, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Danila Tikhonov <danila@mainlining.org>,
 Jens Reidel <adrian@travitia.xyz>, Michael Srba <Michael.Srba@seznam.cz>,
 Shawn Guo <shawn.guo@linaro.org>, Alexandre Mergnat <amergnat@baylibre.com>,
 Alexander Baransky <sanyapilot496@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Cc: Romain TISSERAND <romain.tisserand@gmail.com>
References: <20261113084236.53336-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20261113084236.53336-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 2:42 AM, Krzysztof Kozlowski wrote:
> DSI panels can be placed under DSI bus directly and some of the Linux DRM
> drivers will work fine with it: mipi_dsi_host_register() adds device for
> such panel and DRM driver does not use OF graph to configure lanes.
> Examples are Samsung Exynos and Allwinner DRM drivers.
>
> The Linux panel drivers affected here do not use OF graph, either.
>
> Requiring graph port for such panels is tying the binding to one
> specific implementation of Linux DRM drivers, e.g. Qualcomm DRM which
> requires the port.  That's a mistake, because:
> 1. It prevents usage of such panel in DTS for other platforms,
> 2. Places the constraint (port requirement) in wrong domain - the DSI
>     host needs the port, not the panel.
>
> The port is not needed for the panel hardware to operate thus it should
> be optional.
>
> Suggested-by: Romain TISSERAND <romain.tisserand@gmail.com>
> Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com> # renesas r61307 and r69328
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Acked-by: Ryan Brue <ryanbrue.dev@gmail.com> # novatek,nt51021

Thanks,
Ryan Brue
