Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8DD606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=TdwfbkAt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 103C610EE26;
	Mon, 23 Nov 2026 14:10:24 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 371C410EE26
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:10:17 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c513a854320so550310366b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 06:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1795443015; x=1796047815; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bJEOq1+L8/8GmBV4uj6XcrIU9Gh8W1k/LOiRCQoroC4=;
 b=TdwfbkAtOjmITzHxM4vZgbTBY2Qc1bazRUST2j1SNBkl3b6wRdVTXyw5cxXbW9r8uO
 aQCburr5FUugnGmVtAXXtkkvMkeOZATnIYtcuFU5/EsAwo4Oav4v4xZ80ChjDmBHPKAD
 j2n0htTyOo45AS23x3uQnPLK7st6nCc0rt5kkJClZt5SUesnCkH1iR5TM2fM2Z0mnia8
 IxKBhc91uQd6Fc+vmcDuFwsXRlynO8RICTtNFeVJDUTrEHczDwY3DisiRJxFEM29kDkw
 HrsW4U3BNFeKfgunpJM2rlk+tFI3bVW550E8+rzqrr5VF3gqF3wQGmU7TtO65hWaNR4w
 IqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795443015; x=1796047815;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bJEOq1+L8/8GmBV4uj6XcrIU9Gh8W1k/LOiRCQoroC4=;
 b=fb5v8352+g6NJjCnknREqHLXdTUWbTCFi+vU8M2koFLNaP2Q81JJpRkMXO4duUKJDu
 jYbtQayhC6cWIf1ko6djkz0tJf4vlgJcpZU9g6DlJVWEANXfvLmGJThVvlk/HDAiQgBI
 7b60axXz5/+2/eF7eIE7QWUELysLTT2O1j9+KeCGlf97xXIPna6GdX+Tr2Wc8f+uFa0M
 5at7f3qJhnOTMCE/DyUDf7YWZvpb4hRWe0wBa76o0orbzQY6s9q6pFJQOzlPj0+svS5q
 rlFRi+JnPeIHh9hvqFUBPQu5HIzhM/aDFqxaLLjBb9KV2kz59EO/ivyGReOFEvF6PBDZ
 rP9A==
X-Forwarded-Encrypted: i=1;
 AL+hErFhYWVMKxKJFu4drC/LV+M5Z6Kf2HTdMrOEy8CFcLY/Jh5GLj9C+JBRVXvaLpAomX++46rL7zEPQGI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/mkrlHA5LuCRAPAOENGrVt5rPirEjMJnTMMGpWUFCHl6BMdCRi
 apekZdX8ILHLcFPATOOjUISocqA03jthEsTTE5xNp89d6QStvwF0DKOPMWha/9qnCy8=
X-Gm-Gg: AZFdTZeW6vt39lNdlqxcGK1eH/nFrE/P3ihXxeEf8F1TvfA30ulnLmFV8yenUGHv/hj
 uMPpyP4MFNJrP2YfrrFbiudE1mpGp8CdhY6ci5IxGC9xuLfKcV0g29E5dsG90NsBUfSrAhbtSwP
 gCSJp2kfuF2PkhndQXt31rvoeP3rVujTctBxtx1GTc+lZij1rdJKV8XxSq/uG5+zTe91cIQ+byg
 QKUSUcOqxru+GP7C97C+GYBuGaPtWDoXoydnxiE6uS3iis0tYiWe6r7PnJsKHaajILGXe8MMDIt
 jWltCFK92rqFzxHRzGf/DktlI7Ie7AN1o3T4V03IiZNynIEF/P9MoxoM5yb2JFgEfrLgFLBsP3+
 YJLsesJHYshkK9GqUH6/mA2Y0bK9oZM7N3slxpJ/iIAbDS5R8IeHGG/5LeD2p9Z1l+0PQajSYoK
 FHEP7XmHLKKS+8goM59/wWGeoySpNUDcuQ9Lda85NQVBIFruZqDnzloTCxbJCnh0cAE1s3gUwZM
 hrZGHDnHAyIGo3BaC9bbY20zfAHSR95uKWknTUAaDAD556Ti9dv3RArAKG4hLvNs2deyyqmZV40
 2ZfRf5cjs05crZNcY7pzReBgqYfqj/NUv0qgN44Fpr7AC9AcpAMbzYESQrpz34RhsM95tPo03A=
 =
X-Received: by 2002:a17:906:f8d2:b0:c50:bf14:8eb1 with SMTP id
 a640c23a62f3a-c513a84d84emr736801066b.14.1795443015398; 
 Mon, 23 Nov 2026 06:10:15 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6780esm424259066b.17.2026.11.23.06.10.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 06:10:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 15:10:14 +0100
Message-Id: <DN2NFI28DGN5.OX9A1W6IO927@fairphone.com>
Cc: <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <kernel@pengutronix.de>
Subject: Re: [PATCH v4 3/3] drm/panel: add LXD M9189A panel driver
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Michael Tretter" <m.tretter@pengutronix.de>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Rouven Czerwinski"
 <r.czerwinski@pengutronix.de>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Jessica Zhang" <jesszhan0024@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20260218-drm-panel-ek79007ad3-v4-0-8ec448bf3ede@pengutronix.de>
 <20260218-drm-panel-ek79007ad3-v4-3-8ec448bf3ede@pengutronix.de>
In-Reply-To: <20260218-drm-panel-ek79007ad3-v4-3-8ec448bf3ede@pengutronix.de>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Michael,

On Wed Feb 18, 2026 at 10:12 AM CET, Michael Tretter wrote:
> From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
>
> The LXD M9189A panel is based on the EK79007AD3 DSI display controller.
> It currently supports only 4 lane operation.
>
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> ---
> Changes in v4:
> - Fix typo in driver name ("panel-lxa-m9189a")
>
> Changes in v3:
> - Change maintainer to Michael Tretter <m.tretter@pengutronix.de>
> - Fix error code if regulator is missing
> - Request power-supply instead of vdd-supply
>
> v2:
> - use _multi functions
> - remove unnecessary dcs_nop function
> - calculate pixelclock with timings
> suggested by Dmitry Baryshkov
>
> - rename functions to m9189_ prefix
> - rename struct and c file to use m9189
> - fix commit title to mention m9189
> ---
>  MAINTAINERS                              |   6 +
>  drivers/gpu/drm/panel/Kconfig            |   9 ++
>  drivers/gpu/drm/panel/Makefile           |   1 +
>  drivers/gpu/drm/panel/panel-lxd-m9189a.c | 243 +++++++++++++++++++++++++=
++++++
>  4 files changed, 259 insertions(+)

<snip>

> diff --git a/drivers/gpu/drm/panel/panel-lxd-m9189a.c b/drivers/gpu/drm/p=
anel/panel-lxd-m9189a.c
> new file mode 100644
> index 000000000000..68019e1e43a9
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-lxd-m9189a.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Generated with linux-mdss-dsi-panel-driver-generator from vendor devi=
ce tree.
> + * Copyright (c) 2024 Luca Weiss <luca.weiss@fairphone.com>

I was just randomly linked this driver, how come my name appears here?
I've had no part in this? I don't even know which device this panel is
for.

If the driver was actually generated with
linux-mdss-dsi-panel-driver-generator from a Qualcomm dtb, then this
copyright header wouldn't appear, so I assume Rouven just copied some
panel driver (that I generated + slightly adjusted) and adjusted it for
this panel?

Regards
Luca
