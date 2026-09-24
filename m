Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874CDC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8FCB10F5F4;
	Thu, 24 Sep 2026 14:28:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cAanq/HC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D8910E391;
 Thu, 24 Sep 2026 14:28:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B880443C51;
 Thu, 24 Sep 2026 14:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010121F00893;
 Thu, 24 Sep 2026 14:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790260110;
 bh=IL6ClCwIjkZWXa+/sikAWRTuWWNCeUnK+ge6atvO8+M=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=cAanq/HC3J8+Nv74HWHMMsnf0HUL2z8Yx0G3QNxBFsbIJXebsZOfmmG+sNEdqzh+G
 yhzVjJZbm4dPGZFF1NpUrCnE4NXRu5SAmuyHWYfH1Qw1SnIlH/sdao7pzGHPcjdtso
 hhh1ah6O8YA9dzpCrnTkeCCZ74NP14gr62drZeCVEybtrl0JLnx3O8ikowIk3TdeW2
 IQPmDqkmQ76fHJpzkKiiYzpN5sD7jS+f9jUf+7oMRUMtRlRXx1qH8l8d3hMowJ+Jf0
 vhKdEBC1+V7wAqzLHB7OhZy7p2zEWkPk7yi6zn8uSo3DhwifnZplpvIiJUK6JIDQSw
 c9g3Tm7I8atOA==
From: Lee Jones <lee@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>, 
 phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 iommu@lists.linux.dev, mfd@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-9-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-9-798c2602dde1@mainlining.org>
Subject: Re: (subset) [PATCH v2 09/19] dt-bindings: mfd: qcom,tcsr: Add
 compatible for MSM8952
Message-Id: <179026010074.638531.9042726679993021271.b4-ty@b4>
Date: Thu, 24 Sep 2026 15:28:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
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

On Wed, 16 Sep 2026 17:22:14 +0300, Muzaffer Kadir wrote:
> Document the qcom,tcsr-msm8952 compatible.

Applied, thanks!

[09/19] dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8952
        commit: 319633b06ff2bfc2a7a60d2cfcab2e681a343b27

--
Lee Jones [李琼斯]

