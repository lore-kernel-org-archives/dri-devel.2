Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF929C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 275CA10ED22;
	Tue, 29 Sep 2026 07:39:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iUzdntVT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0FB410ED22
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 07:39:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A8BCA4054A;
 Tue, 29 Sep 2026 07:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7251F000FF;
 Tue, 29 Sep 2026 07:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790667565;
 bh=kHczxQIhar+3hTedxOPpdeuURuyFZHYgP2oSr202qIg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iUzdntVTNNaa7QriEIAQl0CTMAZghah28bwQeZqG+C6lKgkdL3AOeJjVcHSUcBgqf
 XUryiy5cfEBzqUW05v1B+9a4/gy+SDqtqjHjlAoXPnS2E+uWmT1J/uYoL4JhU26v6m
 QGeOVdqyI+m+TwOsuHYlFDfcMsVUGdxpk9LsAhgXLH91Fe45ll81tyUGzuYM/pQlr6
 WLYG0vuSR69+VkiGYsK1uravZ/rM/Z7X6DizwCTsy6jJyzLZ3XPHYyoq3sGLWiaPzB
 9PBcYeGjPT/MzC/SZYtf/PLfAYFl9Vmj9uktHX6w5efjopuC6mznbLdWju39s/1oen
 KIlD7cloe/Fig==
Date: Tue, 29 Sep 2026 09:39:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Petr Vorel <petr.vorel@gmail.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 01/11] dt-bindings: display: panel: s6e3ha8: Adjust to
 reflect the DDIC and panel used
Message-ID: <20260929-eager-heavy-ibex-2c959d@quoll>
References: <20260924-crosshatch-panel-v2-0-08d5c7bf72fc@ixit.cz>
 <20260924-crosshatch-panel-v2-1-08d5c7bf72fc@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260924-crosshatch-panel-v2-1-08d5c7bf72fc@ixit.cz>
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

On Thu, Sep 24, 2026 at 04:01:29PM +0200, David Heidelberg wrote:
> S6E3HA8 is the DDIC, while the panel used on the Samsung Galaxy S9 is
> the Samsung AMB577PX01. Introduce a compatible reflecting that, adjust
> the example, and deprecate the DDIC-only samsung,s6e3ha8 compatible.

You need to explain why. The difference in panel might completely not
matter if DDIC is always used with that panel. Why do we need more
precise compatible?

Best regards,
Krzysztof

