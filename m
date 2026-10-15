Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA3FCC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 993F710E275;
	Thu, 15 Oct 2026 14:28:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1BB110E275
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792074521; x=1823610521;
 h=from:to:cc:in-reply-to:references:subject:message-id:
 date:mime-version:content-transfer-encoding;
 bh=j/jbYAs5tD3HK37L89Fufo/qeFxxEKCG9o1b/8mIHvw=;
 b=iUlarVQ9kkLGtJVvV2+KJDvsn8Z6ZpknilJ6zxCgvgOLD+Xkf7je4xZE
 UTDBreN9LTL4dBR7KRqfGWo4U0tCG/N2nM8m73N4Q7Vq9bEKfWrK4JSWR
 RhJePSkb6knspnvozlNpLtAsva3NPFeI6xSsgrdKoOoCmgixi3kp1PWfm
 SEQIiV8zK8t82A/JM1/7MN6eD5OJ65giLsPhmbNrPnjYI1e358spGdcO1
 ctWuU14ZKjzvEWL9rmO52jTZHlTDkACGOzc1HVKMylPA+uGinlwwSySht
 d/TiuHXq6uGqd6FZ7+EXyX2D6f7DmOUmFdXvfsTvuOhv+uPHaRY5CNrOJ w==;
X-CSE-ConnectionGUID: 7nimnsc9RCyAivSvhkWYvQ==
X-CSE-MsgGUID: RSJCtFfBQA6kYABpSfUwPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="732074"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="732074"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:28:35 -0700
X-CSE-ConnectionGUID: 8DOHapCLRomW6llBped0fg==
X-CSE-MsgGUID: LBKVZ8oSSgSr4XnN4Fne3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1955281"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.130])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:28:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>, 
 Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
Subject: Re: [PATCH 0/5] arm64: dts: qcom: Add Microsoft Surface Laptop 8th
 Edition
Message-Id: <179207449898.13793.6897763208667873901.b4-ty@b4>
Date: Thu, 15 Oct 2026 17:28:18 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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

On Tue, 06 Oct 2026 02:50:26 -0700, Gopikrishna Garmidi wrote:

> This series adds initial support for the Microsoft Surface Laptop 13.8"
> 8th Edition. It's built on Mahua, the 12-core variant of Glymur with
> cluster2 fused off.
> 
> As on the Surface Laptop 7, the keyboard, fan and platform profile are
> handled by the Surface Aggregator Module over UART. The rest of the
> board is close to the Qualcomm reference design.
> 
> [...]

Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

FYI [if applicable to your patch], as per Linus' policy change, also
fixes are mostly routed through for-next unless the fix is for a
commit introduced in the most recent cycle or is clearly a regression
fix.

The list of commits applied:
[1/5] dt-bindings: arm: qcom: Document Microsoft Surface Laptop 8th Edition
      (no commit info)
[2/5] firmware: qcom: scm: Allow QSEECOM on Surface Laptop 8th Edition
      (no commit info)
[3/5] platform/surface: aggregator_registry: Add Surface Laptop 8th Edition
      commit: e93536b1fcf775356b06ddc845461e64d4c87313
[4/5] drm/panel-edp: Add Sharp LQ138P1JX61 (Surface Laptop 8th Ed.)
      (no commit info)
[5/5] arm64: dts: qcom: Add Microsoft Surface Laptop 8th Edition
      (no commit info)

--
 i.

