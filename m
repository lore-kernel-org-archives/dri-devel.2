Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AECC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A361A10E78F;
	Wed, 16 Sep 2026 08:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kdrcA41Z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22DDE10E78F
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 08:39:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0075241A0C;
 Wed, 16 Sep 2026 08:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8D51F00898;
 Wed, 16 Sep 2026 08:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789547995;
 bh=HsXMM28LKRD2B9m0WnoroXOQzAFeaF5T1p/+DaZIXWc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kdrcA41ZU9sS7uGGKY7YQcoMW2JCZ/yshFi3n0b7HX8hX2MDfyd2HV3NH3MHkBg8s
 /RnvdDYZAuKhCMrdigmsQ9xpQzNn6WQi5FH7eZYldcradr3S+KTgNq9SBvgpro9kwM
 UxrShG8pJnNUwr/uXQXNXscZR5zaeqoDhOsI1Q5vOyNvL48qrJglOfGFmVPV/f4N/l
 MNX/wrSiAsT1TB7uZKWraGXBZDZZvcaH45HEUOlQDBgTl9tuCYvQNkC8Vasj3BkILC
 NkL5BoPfWqyvdxV+YaRSfZwTn6wZW0ynlmmERzbb/Ecet40g4ebdHLejGLm99cledN
 WuK41m+AS9z4A==
Date: Wed, 16 Sep 2026 10:39:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 mpearson-lenovo@squebb.ca, abel.vesa@oss.qualcomm.com,
 sibi.sankar@oss.qualcomm.com
Subject: Re: [PATCH 1/4] dt-bindings: arm: qcom: add Lenovo ThinkPad T14s Gen
 7 (Mahua)
Message-ID: <20260916-careful-imaginary-otter-f8336b@quoll>
References: <20260913201835.250085-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260913201835.250085-2-srinivas.kandagatla@oss.qualcomm.com>
 <20260915-nimble-wakeful-stingray-5beaed@quoll>
 <9c09c1f5-cffc-421a-96df-753b294d63cd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9c09c1f5-cffc-421a-96df-753b294d63cd@oss.qualcomm.com>
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

On Tue, Sep 15, 2026 at 02:41:19PM +0100, Srinivas Kandagatla wrote:
> On 9/15/26 11:47 AM, Krzysztof Kozlowski wrote:
> > On Sun, Sep 13, 2026 at 09:18:32PM +0100, Srinivas Kandagatla wrote:
> >> Add lenovo,thinkpad-t14s-gen7 as a board compatible under qcom,mahua.
> >> The T14s Gen 7 uses the Mahua SoC (a 12-core variant of Glymur with
> >> cluster2 / cpu12-cpu17 fused off) rather than Glymur proper, matching
> >> what the platform's ACPI MADT dump reports (12 enabled + 6 disabled
> >> processors).
> > 
> > There is variant with X2E and X2P processors, and on top of that touch
> > and non-touch display. The first will be differentiated by SoC
> > compatible but don't you need compatibles for the last part - display?
> 
> I only have the LCD variant in front of me
> We could follow the Gen 6 T14s pattern (which already has the LCD/OLED
> split upstream) and two variant SoCs for v2:
> how about something like this?
> 
>   - items:
>       - enum:
>           - lenovo,thinkpad-t14s-gen7-lcd
>           - lenovo,thinkpad-t14s-gen7-oled
>       - const: lenovo,thinkpad-t14s-gen7

Yes, assuming the hardware has actual relevant differences between LCD
and OLED.

Best regards,
Krzysztof

