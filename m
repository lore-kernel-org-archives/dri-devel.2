Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AB6C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 179F510F29D;
	Fri, 18 Sep 2026 10:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A0rPo6nq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E5E10F29D;
 Fri, 18 Sep 2026 10:03:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BDE0660A5F;
 Fri, 18 Sep 2026 10:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898D51F000FF;
 Fri, 18 Sep 2026 10:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789725789;
 bh=m+kqKJnO8xx6EaG+eu2tJnKPZxO0X2dKDXSpHvQ+rhs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=A0rPo6nq1WqCyyKQA0jpNXoAt9ibIizz+aqA0zFGxiHaue7h0djSha/rygE/IO/iD
 /e4a+bOMqhs+m94aE+dWjY3Wt4fHqi22vcu9ES0XXf6B9SQj5cGTtB5Urrvk05DEcc
 6N5BUEoKRKNJlWcWWbAWE8dMDDd9YVjXjw522XVSDCqAtmYSPupGZ4N/i7EYfOoFKd
 TZZ+1ZVpqsEjj/PXsT/BmAim3P1R8rhO7v/CTZF3750i2EqUz5+M0/+YXIK5rSfe4+
 u/pdsqTE+v3QuHWHM0I9dMs7peaYjvyNDpXdYHGwWOI4zhdkM1HhWTXo0+4mlqcMxY
 jJDPvHksi45nw==
Date: Fri, 18 Sep 2026 12:03:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Muzaffer Kadir <muzafferkadir@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Lee Jones <lee@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 David Heidelberg <david@ixit.cz>, Dang Huynh <danct12@riseup.net>,
 phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, iommu@lists.linux.dev,
 mfd@lists.linux.dev, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, 
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 07/19] dt-bindings: arm: qcom: Document MSM8952 SoC
 binding
Message-ID: <20260918-complex-bee-of-serendipity-cb6157@quoll>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-7-798c2602dde1@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916-msm8952-initial-support-v2-7-798c2602dde1@mainlining.org>
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

On Wed, Sep 16, 2026 at 05:22:12PM +0300, Muzaffer Kadir wrote:
> Document the MSM8952 and add General Mobile shamrock to it.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

