Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F433F4487A
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 09:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607F710E058;
	Sun, 12 Apr 2026 09:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BR+WU5l1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93B8510E058
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 09:46:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5283D60172;
 Sun, 12 Apr 2026 09:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7715FC19424;
 Sun, 12 Apr 2026 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775987191;
 bh=nPgSbCNxr7x931h3Kp36EpB/gWK7CWRUP7ZCwnb0Im4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BR+WU5l1bsDh9dHDmIEbIZs5PR8yTvQuDAkPxyTBNZtBw1cgQYgEWNz8xUVTuA86M
 zMzCkWf4s1sNwdO1hD19umdcJPIFuEBFTb6bu4uLWc1siF9jya73jHhdqqY1J9UcMO
 rIU6BBQFvic0LVRAd3UYVWPjxyv286Sh84UcYGeEfe0rhZvlVwkJOuBMRkgZ8MSvrk
 ycGlShq6QBTHKoggRFiJDu2R8MD43b7U00FpwHUSWvWXpkhieJPzxlyKkp8bCakn5Q
 UCExx+kb3RKDWx9DKX1MoUl04CkD5Ix38XIPVgP64G6ZefxrPgNEOouF57A+S5A3vq
 psC1ZoxQaYO9w==
Date: Sun, 12 Apr 2026 11:46:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>, 
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 04/21] dt-bindings: display/panel: ilitek,ili9881c:
 describe Waveshare panel
Message-ID: <20260412-towering-limpet-of-sorcery-eca955@quoll>
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
 <20260411-waveshare-dsi-touch-v2-4-75cdbeac5156@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260411-waveshare-dsi-touch-v2-4-75cdbeac5156@oss.qualcomm.com>
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

On Sat, Apr 11, 2026 at 03:10:24PM +0300, Dmitry Baryshkov wrote:
> Describe Waveshare 7" DSI panel which uses ILI9881 as a panel
> controller. This panel requires two voltags supplies, so add separate
> iovcc supply.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

