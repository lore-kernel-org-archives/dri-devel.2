Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CAC60A2635
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=B42/PdOJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6166A10EE53;
	Mon,  2 Nov 2026 13:40:56 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8094710E623
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:40:48 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso19166235e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626847; x=1794231647; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cQaT9BYgRFn+zEYUt83O8GM2Oamgt2XfYK8NkH+VikI=;
 b=B42/PdOJwKy7QAtELCdUqFpHHgW/R2TAv4Bhu5nmbfFZCeuyfQ5J0yT351UZscErwY
 YYvQ8Q/Kkv09X/GN96Z9K2rhYAkGhytYFHr/9Z212jDb+6IHfPjuFqSudVYU3K09mVha
 UjXkB8sCn3pwoOmB5W/xFukBHUBJl3SulkHXhQMAQwGIHUFS63wn/XFYQlHg8Gb1VEaU
 lScG8Hi9UmoeuTxutl3kd1b3LeSfBx2o0DQjaAQPRLMhHkBKHD6eA8ruQwzMCARUDjIx
 Fo+olLqWMRQXTrJmKPstbjwATXYbyvJKYl6WCLHT17RVBvVD0GjKcEZCGiUotQ8QUnza
 hlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626847; x=1794231647;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cQaT9BYgRFn+zEYUt83O8GM2Oamgt2XfYK8NkH+VikI=;
 b=HFZIX1kBsSosYxq+ME+CIEmeEYf9dQx4s7GZXQdUFGc08fXROfvNnxHK6cb17shQbZ
 sMOwSXKmitPU/120MnJ5PetFHH7z0zZw4csTmYfndRt2ERB7PMOY02RCbhfp0cYPKY9b
 jbcaor2FvuCMEe3tRiJHGJfOSyKWbTLuLvGSMe/jjiLhuXmYNHxafXtruNme/5aDtiOO
 Qls8P3+EatimfHLUcShRO4si+q7myT6EBA9g7+AuR3CehC/LvRBZu+R8VQ/4feGoexia
 lwH/pO+AybxECOK6aoH+7FurXXbeY4InKHPh5wQRPr/OAewC81KOWfxiU4Nf4k4wxGqB
 H9UQ==
X-Gm-Message-State: AFq9FYJm9YXbfB3RV4xMX7uMK59zgi4z4XHmgl/ov7rhRegZGK3QHZuT
 FB8kTuTEmnQ6KiCSsAifrdBFJyns724QzC97ffjxym3KeNJQVucQ1wq/DC6D4nF/pz4=
X-Gm-Gg: AYBFou1YUJvLSupXfJLWRq+m+jFdH/3d0X1o/YtCH2En6gdehL1wGM7zLuUgYyEhNHA
 rWpfhM2igPQhyizcgWzS6vI2oxbN4qiHQzlSjM7PbQ5U3KEB+i7NyDfX02e8dZTsbnDfd2lAI8K
 LuwWRM6wgRvfE5YI9Z84XpFKDuUl+x5nPzOPCHbWVZs0ylZO9HlTUt+E8IkY46Oyy+USJqiwqKN
 MVcuvYeF9/xisaSfqJ1dndz0aSPLagxD69NI0tT/8ryjCCzHGgZ/RRa48a9H8edOAop8rBCybRW
 RkEiZ9Sx2282Njt86Bkq6EzDCpj5CCodGpmzDLnbBZeP2WsIkHYi5iKaO7p1MfUxldSYTtFpC6q
 PHnjrlDIrPoXanq/Ra/rGH4RoYqxSL7AqpAEh4e8BTjdij9DyEQ5B7xaFxzT4105AsZSaqCOAt4
 8Sas+Oge5TD/maTJPpjPYCE+Uj3Yum2X74oKJbp144gSHwwc/4YYe/GWSYNlU7XcP55wsHGtgcu
 o2lMmXwoLJfHN8ks45n2Mxp4qoPuIZzIiCecK0eR5dsDCl6H6ceyoX4Skkhw8tMlCo40pkqEnDq
 3wFi3m+zVKC5m+cdwjTTx6kfqT+mWFNIztI/RHcN3b49NQV+4R04+7tTOuNHGEtBe3JqSjg=
X-Received: by 2002:a05:600c:470d:b0:4a7:9006:b176 with SMTP id
 5b1f17b1804b1-4ac17471285mr229234705e9.7.1793626846731; 
 Mon, 02 Nov 2026 05:40:46 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abea533a1esm189194605e9.1.2026.11.02.05.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:40:45 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
In-Reply-To: <20261022132259.240717-1-clamor95@gmail.com>
References: <20261022132259.240717-1-clamor95@gmail.com>
Subject: Re: (subset) [PATCH v4 0/7] drm/tegra: Add support for
 Tegra20/Tegra30 8-bit CPU interface
Message-Id: <179362684510.3310106.12424997423646231725.b4-ty@b4>
Date: Mon, 02 Nov 2026 14:40:45 +0100
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

On Thu, 22 Oct 2026 16:22:52 +0300, Svyatoslav Ryhel wrote:
> The display controller in Tegra20/30 SoCs features an 8-bit SPI interface
> that closely resembles the MIPI DBI Type B protocol and is referred to as
> '8-bit CPU'.
> 
> Add DC parametrization options needed for fine tuning by bridges.
> Add 8-bit CPU interface in form of a bridge linking to RGB port.
> Add 2 DBI Type B panels used in LG Optimus 2X which work with
> the 8-bit CPU interface.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/7] dt-bindings: display: panel: Document Hitachi TX10D07VM0BAA and LG LH400WV3 panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/46011a636fd729c99781533e265297748b5a0b0f
[2/7] drm/panel: Add Hitachi TX10D07VM0BAA MIPI DBI Type B panel driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9fe804e2a3001fd024c0809678d09c5e0ed359ee
[3/7] drm/panel: Add LG LH400WV3-SD04 MIPI DBI Type B panel driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d87ca1becbb095b6204cf657508c91e5e995d9b5

-- 
Neil

