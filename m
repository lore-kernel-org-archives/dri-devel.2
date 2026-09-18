Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A382C982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B623410F16F;
	Fri, 18 Sep 2026 14:40:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="TiRJRy20";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA08B10F16F
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 14:40:12 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f9c60b9so55630866b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1789742411; x=1790347211; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NswcxVnJHltqSQeVprb1zCpwdatT8Ku5jmJgLkP1CTk=;
 b=TiRJRy20VkmPM7q6BQZBNBVhnEDHkZZsf7c/Dp9yWKrnDvS17JDcYECS7yuawRJRSL
 x1rLEpFTIhOTO9fQfTrhCZKklHYHrA2MXVGhyy86Z5V3JzCKlxgNRL+810e2Mfvzvj3o
 jXfyuUhtsuIiW5bohKZhJq4asZvNHab0Dc1NdERSoXK7qHW08oMYBq1G7bgynuohkzqa
 AbqXmeOQhEvgGZ1Y6ai7WyWo3aCDETXZxvUZ48f+myBgwCy+4e7/NbkRSP30yvR3ScMZ
 k6Ow+j0HTL9UdMQO+Opd6LhnzCY12YK/Zqos062d6oenwuSDVnrGF2uXpdeQC7N3rjSg
 beqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789742411; x=1790347211;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NswcxVnJHltqSQeVprb1zCpwdatT8Ku5jmJgLkP1CTk=;
 b=lH+vByk5U2j+lfAHuR51XrXpJA87H6ut8P49X8oa2EVSi1rCgAVIxKTKzMFfLnurDB
 SCtuR80GAVVDyqSp+XIkVqJhp12S1PfLHzhGhRtSy3n+ODDLqxIWh9XHIEVWeLS7BHR7
 9N5b5u/bp4niLA6YxD8AoQSN6bnhXTmSmaK8KvHijTxgfhpGcX8XRWvfKQuMFMILcB9y
 76P4gXLIJYm9VSLHTNFiy8WJVVaqnVD3rzedPYn8KfbUzYEUHSzhQCdPBKLFxayZHRO/
 Blg8y5rtosqVJrwb45rPEKZPj+a8Zkkbx+vc/hZsbQO8MTb8lKAFS2lpACYZFnaZQe2v
 RtZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+I2Ntd5VZQ+WezB+msekiyKQdlDiwIresRXvVwtx9Qk4bzN9PRtSgDVYA+nUVbN4uSom3rEkq/hw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++myvy41zUg2LgiRV9tCEA8ZH47cseGJp5xnpeQpqepquINiJL58
 P7cyK6PevYDlp1CDfiOtuuniS9gKh7xTONwnRRCTb8lSfM9vHbc1zWaXDIgLHU7S2W4=
X-Gm-Gg: AYBFou2JkUpglmNdQ9RpqfAWsILA8WkaamZBEk84IV/v/8Mlvp/BFpIQic9V8ziT0TJ
 UfaSBLfRvLQXoUVytFH4M8D4IWKBMdfeIGIJoaYHkiXOwJpjgIpW2KwAh8g/g172/CSAMtyx8ba
 M/b5ZaTDIax1QX0npE9rHr2agtdny/p5ai+8wvXGIAgyaPXQft7S2SedGJ8p4kfMk6v/ib/ikEA
 TvfLrzOnu0WWkG9MSjHszj+fwyTwwSra+UBp2ybiYJXzjZVF286cODAijV+duH+7Jm12S8qrwM4
 u9Y99mwtXLeHhEWnUOJj5g9woWbLVqLRMRLmq9XZrSXsTQDMio7ASKTfhVfKquYGTeJ6oSSPVhO
 JmXjJRPU9BPtvEnDvUIu9gvqGKVBTVXdhFYuQGcJAx9y09jBobCf7gqLyj3xAejlb+bkolpJfte
 /6NaOCdVZibTprnETMAIpCzlvqlu/+i0ycBDEcKUaxDrr/mrKUde67nMBn5YrHoFTZfU+9u1GQe
 HQQE4w6GnbvxvfgFdJov4RJy81j/qVXtw23si5AutVCMUmU5jMpvyefWna1HsU=
X-Received: by 2002:a17:907:940e:b0:c25:f7db:4bee with SMTP id
 a640c23a62f3a-c2a16599060mr289750966b.20.1789742411235; 
 Fri, 18 Sep 2026 07:40:11 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a1b7a369esm64244966b.9.2026.09.18.07.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:40:10 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 18 Sep 2026 16:40:06 +0200
Subject: [PATCH v2 3/4] arm64: defconfig: Enable Novatek NT37705 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-fp6-panel-v2-3-6695c4008920@fairphone.com>
References: <20260918-fp6-panel-v2-0-6695c4008920@fairphone.com>
In-Reply-To: <20260918-fp6-panel-v2-0-6695c4008920@fairphone.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789742407; l=791;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=3l/OQDwilslojwbD5BIFc247psV75whhicTp80W21k0=;
 b=2eQL9cFuNTxwCukWgu2TjmmlCNjhR6F0B1X3ayynoF3nwFPzUq2NjIk7TXGfPbqRIFTes6+Wk
 HPbCfn9gLI+BWPQNPwdbR2gfL9qAb8MskNf5dl3aQMt1aV9uYhBn2gb
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

Enable the NT37705 panel driver which is used on Fairphone (Gen. 6).

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6ec8d3a69c98..1d4afc733c8a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1023,6 +1023,7 @@ CONFIG_DRM_PANEL_KHADAS_TS050=m
 CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
 CONFIG_DRM_PANEL_NOVATEK_NT36672A=m
 CONFIG_DRM_PANEL_NOVATEK_NT36672E=m
+CONFIG_DRM_PANEL_NOVATEK_NT37705=m
 CONFIG_DRM_PANEL_NOVATEK_NT37801=m
 CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
 CONFIG_DRM_PANEL_RAYDIUM_RM692E5=m

-- 
2.55.0

