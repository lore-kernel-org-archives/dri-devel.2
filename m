Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19FC1061B13
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3504E10E41F;
	Mon, 30 Mar 2026 16:02:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hHrnOzRl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5617F10E41F;
 Mon, 30 Mar 2026 16:02:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0CA5A43A16;
 Mon, 30 Mar 2026 16:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AED5C4CEF7;
 Mon, 30 Mar 2026 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774886521;
 bh=koYo+yLuvebxKhVW/TeuYKONtZdgfhNP1zbiYBgdN+0=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=hHrnOzRlD+pU/+xEAq1NZ/mJxtudoV0WsTuTrqllzBoEsm/0BiSnq1Js5BCqVGMtP
 Nsb2ple72fNmeZL+UCrj2nwPbdqQg4kCeE5JmRhHOKgXQYqpwaIUHQPs+jagnxxlwv
 uwlETPwL/bTPZqZrug7Mf8GSltD08VSDwId0aEyUO6q/+pEeNYK/R5iUuoNBjmFrOY
 blz6yyw54BlqopIKV/2iittVUsG/BBgQdii5/zE35p/FK+40ErZC0gWw/GsfxcSVl6
 7QLhaK/ylDDbhP3IAEelnOgXhVw2LOxWzQmHm7JCyf+Lua6hzcE0oqQZuP5vWUa+mg
 XOI9OD5BfP+TA==
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
 Conor Dooley <conor+dt@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: display/msm: qcm2290-mdss: Fix missing
 ranges in example
Date: Mon, 30 Mar 2026 11:01:21 -0500
Message-ID: <177488647743.633011.6769674149013868210.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325122209.147128-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260325122209.147128-2-krzysztof.kozlowski@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Wed, 25 Mar 2026 13:22:10 +0100, Krzysztof Kozlowski wrote:
> Device node has children with MMIO addressing, so must have ranges:
> 
>   msm/qcom,qcm2290-mdss.example.dtb: display-subsystem@5e00000 (qcom,qcm2290-mdss): 'ranges' is a required property
> 
> 

Applied, thanks!

[1/1] dt-bindings: display/msm: qcm2290-mdss: Fix missing ranges in example
      commit: 88bdac5443e5269bb39c4968d5ee0becbffe3f82

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
