Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276F1606EE99
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWm6nHXV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 288BF89130;
	Sun,  8 Nov 2026 20:22:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8B2089130;
 Sun,  8 Nov 2026 20:22:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 64C1241275;
 Sun,  8 Nov 2026 20:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E2E1F008A4;
 Sun,  8 Nov 2026 20:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794169322;
 bh=9wWfl7qFXktxy6CwpQ9crdCxWT/JDIqEgzRZ9xiVYpU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oWm6nHXVL6JiyIJakBPNDCG6+CYzRsw7y0IsjKcoRWvyvmdcxcVC911gwYblQRGWk
 IfXpjZJy4DOmdvgFC0FYhxrRwukSZRmb+q8oPKAiv2FTl2yKhjmg2rp0t7nDj+tkR3
 7fQuSl9jyQk6MG9+Fdt1dPxbrn4235i2e/fMTDgRCTERbBLC28ajGvDP45CDgKxW5F
 pg3W2NycLDCKPbdLgaDSUD/CLBz7f2/SF3mbLJQ7z6ps1oauESFZQ4i6jzAQRIExa7
 7PgK/aOJN6VJXNL0jrfirm9v6R2h/xkVIpyeOExEg8NntzOBGkdQ7zuwINhnRt9LCf
 zbvjnU6dELbbg==
From: Bjorn Andersson <andersson@kernel.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
Subject: Re: (subset) [PATCH 0/5] drm/msm: Mahua GPU support
Date: Sun,  8 Nov 2026 14:19:18 -0600
Message-ID: <179416929263.628393.17995664438358337927.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
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


On Fri, 25 Sep 2026 02:44:31 +0530, Akhil P Oommen wrote:
> This series adds support for the Adreno X2-85 GPU present in the Mahua SoC.
> It is a smaller variant of the Glymur GPU, with fewer slices and smaller
> internal memories, but it shares the same register layout. As a result,
> only minor changes are required to enable support for it.
> 
> The first couple of patches fix an error I introduced in the earlier
> Glymur series. I incorrectly assumed the X2-85 was the GPU used in
> Glymur and used it in the compatible string. I believe it is reasonable
> to correct this now, considering that the Glymur DT patches were only
> picked up recently.
> 
> [...]

Applied, thanks!

[5/5] arm64: dts: qcom: mahua: Support GPU and GMU
      commit: dbd5d59091f2f633b46f38afe825b5795b011c2b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
