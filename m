Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56E3C88E56
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 09:02:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E483710E05B;
	Sun, 13 Sep 2026 09:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SqGlnhW5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A34B10E0B8
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 09:02:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8861460DBB;
 Sun, 13 Sep 2026 09:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989E31F00893;
 Sun, 13 Sep 2026 09:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789290137;
 bh=+QgNccPks/y5EiUIaW30j5t0+tXeWFsnPvbGtZbENV8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SqGlnhW5et2E74vIhmPM8wAsQ3mBbGzl12yVa0lpWYSM03XO26ERPdeYvcg4C6u51
 DBzPjVne51Rj21eL3qrVxlGUSVakh9ozHXr2ndeW3jhglB5g/4QihRIlJc9zAf+Ioe
 RynUuR9tn9INyJgpv4khUwMb+1IjaT9ZImnnJn5vmlUK2QFvuN+hyx3XxMgQwZKjOg
 YQD1VyQmey39ZN3r3yGQGRr9eC/JQt2boly6YoAgai1OpGyGifuOmS3SLwgzPFr6KT
 IWKwqnulOD99EgD1jbF4FO20ZJlDTUqF/5CbXuYi9A91zoKoPg8VJLzWjBTQ8aCutb
 Nfw6IPfTUF8HQ==
Date: Sun, 13 Sep 2026 11:02:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Paul Sajna <sajattack@postmarketos.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] Revert "dt-bindings: display: panel: panel-simple: Add
 lg,sw49410 compatible"
Message-ID: <20260913-succinct-spiffy-chimera-32b06b@quoll>
References: <20260911-topic-lg_sw49410_revert-v1-1-c9385a9e1926@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260911-topic-lg_sw49410_revert-v1-1-c9385a9e1926@oss.qualcomm.com>
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

On Fri, Sep 11, 2026 at 09:36:48AM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> This patch had been applied before the review has concluded. The panel

"Commit foo bar had been applied..."

> needs more specific handling than the one provided by panel-simple and
> the intended compatible was supposed to contain both the display panel
> name and the driver IC model number.

You miss subject prefixes. It is "dt-bindings: dispaly: panel-simple:
Revert something".

> 
> Moreover, the other compatible that didn't make it in the end landed in
> the Qualcomm tree some time ago, instead of the one this revert
> removes, so it's not even used.
> 
> See the link for reference.
> 
> This reverts commit a74c2e55ab66519ffa2069ac9ae83cd937bff4c4.
> 
> Link: https://lore.kernel.org/all/20260614-judyln-panel-v3-2-07f4134441bd@postmarketos.org/
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> Paul, please resubmit your bindings patch with the proper compatible
> and let's get it merged.

lg,sw49410 is already used, so instead new binding should be posted
moving this one from panel-simple.  Revert does not solve anything -
changes one warning into other one.

Best regards,
Krzysztof

