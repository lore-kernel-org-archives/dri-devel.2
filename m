Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE89C982DA
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 11:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F28610E214;
	Sun, 20 Sep 2026 11:05:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ebHO/mPk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CD7910E214
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 11:05:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E20643F04;
 Sun, 20 Sep 2026 11:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706091F000FF;
 Sun, 20 Sep 2026 11:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789902306;
 bh=di/BbTISvG4/OjzNVLYs/I24TNETqXYR65gNhidz4Xs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ebHO/mPkO+CtKbNjfH/qXxVV0WNhT8BZht10185Ju7NJNOWXS0bXtDJo31kOEXwgX
 nraZxF+uYuYlzeUUSMDmjW1wQu9qN8AEjGT6ZIJNpjejrtlxyPOyhuGZ3fZJ5uMUml
 U39LV1DPJU2voqqcsmhRXmRipZQKb6t9CevZFYDYVsxg0SulanKQAkNEMz+Gkd+QR8
 arkEqGIPi5b2MDEzoV0vAdCrd0Dr4lh2f7GDnBEGU6DUIFsge6qSU6510kZZOvDhzB
 Dn9R8S0W5Gm+88mxyrWPS0/BbI4wwgkY6JVv1T7iN08Y52EoXWP0Qi3Eyo/WzblnQ8
 1XoRDfB9v+JZA==
Date: Sun, 20 Sep 2026 13:05:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: Add Truly
 TFT320240-229-E panel
Message-ID: <20260920-thoughtful-brawny-snake-b06d43@quoll>
References: <20260917110517.1053556-1-alexander.sverdlin@siemens.com>
 <20260917110517.1053556-2-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917110517.1053556-2-alexander.sverdlin@siemens.com>
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

On Thu, Sep 17, 2026 at 01:05:14PM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Document the compatible string for the Truly Semiconductors Limited
> TFT320240-229-E 3.5" QVGA (320 x 240) parallel RGB TFT LCD panel, which
> is driven by the panel-simple driver.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

