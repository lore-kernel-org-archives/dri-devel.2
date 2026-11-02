Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E660A6F6D
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QSrMxbh8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 876ED10EE73;
	Mon,  2 Nov 2026 13:40:53 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EF4F10EE53
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:40:45 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so23106265e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626844; x=1794231644; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=64ks28F3gpyY9hLkkjB/gzIZc4tlOYmHUcdUS0mZjiQ=;
 b=QSrMxbh8dWYKdwldDGjy//xpG6Bc2A4EH883x17AbFbTXUo8kmxCoCxj4QMpzK4YuJ
 ezdbBOi17dhFZh8ajX9PLWoxT6JGaYHjkGeC/z5eOjYmfO+ZHlCwMrcbqXcESnFAIyXC
 Vx9I9OEsq84Pti5w20FPwPh+oAen9fz0H5DsF+hPb3ZtCYPi52vv2SbUwiSft501VELb
 V1Lfca4g4tQP7hEy+o77TkuXP82d31f2OkKKytofcMCD5zASNbQtD/02oLuhvxaJrwQE
 jBwI+av/Vp54lOC6kzl54/NIfyqs4upoEbZ3FUQqi3bCLmHq+L0frVJkA6ENt+ipEBkj
 XjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626844; x=1794231644;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=64ks28F3gpyY9hLkkjB/gzIZc4tlOYmHUcdUS0mZjiQ=;
 b=QhyLdSHEl8uh/pix07nmGvdKeq8IRFRK14V1zGCgYQPEOPRJIW+L5vVQWojW1H750C
 n7CUIxr7kDHdZ2vu9+e0pVrfzslW65uWJA1EUkhaTe3TeWDZ5ub8VqGwR+9Dkrmv2sJ0
 dWAtSVFk4W8Tq/a0CG9/wdVJWt31B/9j/AsY8wKza4YMQMTDBcIkQpTS6oguStxWM6d6
 O68YWDFBYmSTY547/J6KeKtoBQlAoyKo/eGfyjHADfMzWIRQdllZsElzogp0heMsejgo
 mmFm0rdNb6//WpULh+U2aABqMdhwxwNNAfAgVjWinsJ9/NwBlmMZywKD/dIliu/kkFwA
 wOwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMGhRatNKnMMbkk/4XKUxxiKXEIuLBm6VPbJ2xxKMrZEb5FblsI/zGbtX20f2aPozEBjjNb5uB9ao=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJvogkYagoTCZkwMmw6c1+8Ve1hnzn26Tp9D+AH08YsqpocMhI4
 THX4DBHbqCYU3TMsXV/oqIhr/Urs/dm/A+66Ty0mESnnnt7JC1QPzJxA9MDmA+byN2s=
X-Gm-Gg: AYBFou29t/kzU2U/b4W8DOfoO45gZHrhcDUOiSz8Pt/BnhMzjQoHNHjv2HsRZ8sDxgE
 uY5T9yAedrbojevuVE4w9JHe0jMoWSn1pucUegakz1EIoCNKmNMenF/78ugCrldqJqxw7XkCI4L
 X/W/06EB02lnsrmMzqDpEpMc4wFbL/o6iBp0k6EL3ZuKiXmZEpq6BTehvjw5+9oehaCtWQucImf
 +PqReNUHuafNvL9L/BK68knxScbWs+BDksZLL9JNLxTNasV2LHy8yRTwNrNCUiPi4HRRy+ySFTp
 AsL9dyAr7zBC02gPb3mUJKzmShPEhwql/Czu8KuHUsDwy8au3ebg89WEUf3hPhfI77g+AFVBqBu
 zfbWb6vTnE9UsC/BHd3aljFK9wa4G5gdSrkuVamcn08P65aphShpUshjWOklutsIzhBRjwtXVj/
 6Z+HS8iUoZssx4iqSGLtnkRZzxw/WafVR7zXoKPby9HQHp6A3zP6sH8xVW+ubjZy2ZNaC4nd/1T
 OkfNr+yaaynLMs1puQfYf04vNjBR14cvIaHzqvHKRXESO0fEOZEOT8YUzMnkoOZRbQp1LYTW7xP
 NnXcxmppp6b0WBjtcnVX4Kv4dUysu9t7ducAreMvUhrVOfauWg==
X-Received: by 2002:a05:600c:6214:b0:4a2:9cda:57cb with SMTP id
 5b1f17b1804b1-4ac151a9077mr246967155e9.1.1793626843602; 
 Mon, 02 Nov 2026 05:40:43 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abea533a1esm189194605e9.1.2026.11.02.05.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:40:43 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20261019-sdm845-hdk-v5-0-4aa7e22cd0ed@oss.qualcomm.com>
References: <20261019-sdm845-hdk-v5-0-4aa7e22cd0ed@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 0/5] arm64: dts: qcom: support SDM845 HDK
Message-Id: <179362684245.3310106.2514816704767701626.b4-ty@b4>
Date: Mon, 02 Nov 2026 14:40:42 +0100
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

On Mon, 19 Oct 2026 12:18:02 +0300, Dmitry Baryshkov wrote:
> Lantronix HDK845 aka Qualcomm SDM845-HDK is a hardware development kit
> for the Qualcomm SDM845 / SDA845 platform. It uses the modem-less
> version of the chip (SDA845) and provides a rich set of the peripherals
> and connectors. The DSI panel is an optional addon, so it is being split
> to a separate overlay. To (hopefully) ease merging, the overlay is split
> to a separate patch as it depends on the panel. The base DT doesn't have
> external dependencies.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/5] dt-bindings: display: panel: add Truly NT36850 WQHD panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/79e6e49d681714aec69bdc24a4d1cb592aea4adf
[2/5] drm/panel: add Novatek NT36850 panel driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/cf022beccbd43c27b1e9a4b03ace28bd39504d7d

-- 
Neil

