Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38ED0C982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F2D710F268;
	Fri, 18 Sep 2026 10:02:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hr2R9JGF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B689610E0C8;
 Fri, 18 Sep 2026 10:02:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C794860A59;
 Fri, 18 Sep 2026 10:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978421F000FF;
 Fri, 18 Sep 2026 10:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789725725;
 bh=TuKf+se4/WQhc7yjH9EKqYLRLWGTVuMIsQ21THLKRXk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Hr2R9JGF/xDMykb6xXJ/HY2vNaL30WQN270YcxZWsFioZ+5jNX5otawhZ4HtttciR
 foJIpz69Ij082Xs1NJZ34AUBeedRwe3iOb+knGoCJHkfWJRFbVtZK7V9FzuqzV/kpR
 Zs9tRpThIWo7B2Ywo+nGT37X/h5Qe6+qhJ9DsRG0WYuV8qfgosMzceChbch8Xt5mRz
 TFYW5ygTEEzs/JkYfRvRL/iR9Mo16+wyVBi11KB4rifB4Kv1kHU1R9Mg/NGrz3uwvd
 UK9Ybbyf9woUgYX0HpulpVpHQCROT1hQ66BlEUPSEKD48YiMruzGl+uhlWOdvmum8P
 UNeJMPdCVKuhA==
Date: Fri, 18 Sep 2026 12:02:02 +0200
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
Subject: Re: [PATCH v2 01/19] dt-bindings: clock: qcom: Add MSM8952 global
 clock controller
Message-ID: <20260918-liberal-significant-crow-f1e66f@quoll>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-1-798c2602dde1@mainlining.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916-msm8952-initial-support-v2-1-798c2602dde1@mainlining.org>
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

On Wed, Sep 16, 2026 at 05:22:06PM +0300, Muzaffer Kadir wrote:
> Add a device tree binding to describe clocks, resets and power domains
> provided by the global clock controller on MSM8952 SoC.
> 
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

> ---
>  .../bindings/clock/qcom,gcc-msm8952.yaml           |  56 ++++++
>  include/dt-bindings/clock/qcom,gcc-msm8952.h       | 217 +++++++++++++++++++++
>  2 files changed, 273 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8952.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8952.yaml
> new file mode 100644
> index 000000000000..274dde633e17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8952.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc-msm8952.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller on MSM8952
> +
> +maintainers:
> +  - Muzaffer Kadir <muzafferkadir@mainlining.org>
> +
> +description: |
> +  Qualcomm global clock control module provides the clocks, resets and power
> +  domains on MSM8952.
> +
> +  See also::

git grep "also::" -- Documentation/devicetree/bindings/clock/

I asked you month ago here:
<e3fb3794-ca7a-4794-8036-b69e563aaa57@kernel.org>
to not work on old forks.

Old fork which you should not use is postmarketos, lineageos, whatever
Android fork kernel, and whatever other tree which is not upstream from
kernel.org.

Best regards,
Krzysztof

