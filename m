Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC70CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 694D110E11B;
	Tue, 29 Sep 2026 07:43:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OgUpGNhR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A3110E11B
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 07:43:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A3E3560A5F;
 Tue, 29 Sep 2026 07:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7DB1F00893;
 Tue, 29 Sep 2026 07:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790667795;
 bh=2AQZlRf6FiaJItjF/uilrmdoGec1thZc+JcVpZC4iDU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OgUpGNhRlWTt2AmHVcVgoDq4ae6hlmFlOlKxX4MoKNK+Vmv6ZhZajVQQal2WF+5uN
 tTHfGRb1B5H4eCYtnm73efUZDs3HIPAp4SmA3jXTDnjt5/8/2/u1QAimScMRz621xj
 3jTYGu+NZYY3zr209x3e7rG+e/OPFLzZ5Tf3czXkss/i02hbWU+dtQWk8JOqXp7cm5
 ssa2/NmacMEkq3btnDOVHjwHTGq47tzICLbP8F84OMZRmuqNBOBkVqgvPxrTc17l9K
 F/QkO2euyuUFobJYlF0LkHvrpLAgRo6SrpHogjpLwNyjAT7eSwe5TsbxtscEUcwEuS
 +YSSTgJT10PMA==
Date: Tue, 29 Sep 2026 09:43:11 +0200
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
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 03/11] drm/panel: s6e3ha8: Really assert reset on the
 failure
Message-ID: <20260929-electric-unnatural-gorilla-db20de@quoll>
References: <20260924-crosshatch-panel-v2-0-08d5c7bf72fc@ixit.cz>
 <20260924-crosshatch-panel-v2-3-08d5c7bf72fc@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260924-crosshatch-panel-v2-3-08d5c7bf72fc@ixit.cz>
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

On Thu, Sep 24, 2026 at 04:01:31PM +0200, David Heidelberg wrote:
> Due to incorrect implementation 0 == asserted, thus when driver fails it
> needs to assert reset.
> 
> Minimal fix for stable; the polarity convention is corrected properly
> later in this series.

We do not do fixes for stable. We do development which MAKES sense. If
you change this line here and in the next commit you change it again,
then this dance makes NO SENSE.

Fix it properly.

Backports to stable are something completely different than mainline.

NAK

Best regards,
Krzysztof

