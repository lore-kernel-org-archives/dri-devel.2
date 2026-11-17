Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC51560A2624
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2fw/OIp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9D7810EACB;
	Tue, 17 Nov 2026 01:05:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EDC310EACB
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 01:05:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7565E40AB0;
 Tue, 17 Nov 2026 01:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D931F000D4;
 Tue, 17 Nov 2026 01:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794877521;
 bh=TFVgaovpCdXFCchb47lWtFAHAaVIAA+TVCN/Y84x+Zs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=n2fw/OIp+7K0K/0LTKt3hgFIyaYyNVus6Wx40R3oGdx8Pf5FCjjTgV961RfiJ6nCh
 9F46RmiMp7Sl9TTSB1xtv91d3vIbCBBQWIFch37Uf/SDXZ6ML/VLWNJuwcrJo2v6fX
 RdAcKZWOVFYW/NccbvWZ68wp0mLPTiOkSUTldgMmkfymidzHc/DS005zyA6DwbHUAr
 R6nKyJqM8+zjObqKMcRlLkwOKDu583bjMGe/FfsvD5QnGPTrV+BMcGOHQQCiNXdYES
 L/XLenuwketM1zrwJyn13JC5mnu17L8A1XLNSx9FiMS5eWSCliUtt1J7acUKWDuCxA
 gbaJTEEQFRb1Q==
From: Bjorn Andersson <andersson@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v4 0/4] Add Novatek NT37705 panel driver for
 Fairphone (Gen. 6)
Date: Mon, 16 Nov 2026 19:04:50 -0600
Message-ID: <179487749299.432567.493550995991347090.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009-fp6-panel-v4-0-7c3819664778@fairphone.com>
References: <20261009-fp6-panel-v4-0-7c3819664778@fairphone.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Fri, 09 Oct 2026 13:24:59 +0200, Luca Weiss wrote:
> Add bindings and a panel driver for the NT37705, and then enable display
> on the Fairphone (Gen. 6).

Applied, thanks!

[3/4] arm64: defconfig: Enable Novatek NT37705 panel
      commit: 1ff72de9902a955b8446bba2c56942028c1425ea

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
