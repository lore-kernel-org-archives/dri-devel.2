Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9E7CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 19:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB6910E15E;
	Mon, 28 Sep 2026 19:31:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cVvjom1U";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FC2310E15E
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 19:31:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 18C0643F3C;
 Mon, 28 Sep 2026 19:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A9C1F00898;
 Mon, 28 Sep 2026 19:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790623904;
 bh=286xF3v4g4VkJV4InXRiw/By35Qg9oOY3ehPiYz153w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cVvjom1UoGrA2bqJJbCnXjnwQkYEv7k2rs1C/tSJh0FUb4zrWfpCI03kIPSJKwszr
 mhbxpnL9SuHjuX7B6zJ6CtzDPEC6DOfxMtKCRhsRfHN8FJ65RzmrnI5WkzZMxvle3/
 Vhe14YBeG3cI39X5zw0kSL8foaRQKzOCiQdBry4U1ATBGjNN4vHMaKbD/6yEKyqbl9
 oDmGBmSQL012fOd3u5Zaq8Lj8dD80F0z8RQjgn+ILK5K/+Qhjy8p4z6NkAIJuwbPzr
 fzX560Hp8ZgxT+DWp5nvUUTSQxqqBs0NTphUGPBhWSCP9c1NxsIXVOmGkeyA0PhEh3
 sMM1eNiOSCj8w==
Date: Mon, 28 Sep 2026 14:31:43 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Abel Vesa <abelvesa@kernel.org>, devicetree@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 linux-arm-msm@vger.kernel.org, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: qcom: add Lenovo ThinkPad T14s
 Gen 7 (Mahua)
Message-ID: <179062389959.407554.7248677417170944121.robh@kernel.org>
References: <20260918120515.595782-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260918120515.595782-2-srinivas.kandagatla@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918120515.595782-2-srinivas.kandagatla@oss.qualcomm.com>
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


On Fri, 18 Sep 2026 13:05:13 +0100, Srinivas Kandagatla wrote:
> Add lenovo,thinkpad-t14s-gen7 as a board compatible under qcom,mahua.
> The T14s Gen 7 uses the Mahua SoC (a 12-core variant of Glymur with
> cluster2 / cpu12-cpu17 fused off) rather than Glymur proper, matching
> what the platform's ACPI MADT dump reports (12 enabled + 6 disabled
> processors).
> 
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

