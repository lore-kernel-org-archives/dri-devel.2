Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63BDF3ED4F
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 14:02:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6894910E211;
	Sat, 11 Apr 2026 14:02:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lfHU50fY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3290A10E211
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 14:02:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B0A9A42AF9;
 Sat, 11 Apr 2026 14:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5576CC4CEF7;
 Sat, 11 Apr 2026 14:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775916127;
 bh=HifjkcugVN1bUR9aUlAaCwwsoa3LDIAOA2z2Ky7FFFU=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
 b=lfHU50fYbMJVnv5moMPuvMFtO2ZbntH9O+ewCs5yyesb/p8nrUXixKYEIAUYN9P7Z
 j547ednK4t31ex6305byYUhlFuEc+W0XU9IsjIbLU8SIUkkyu73ohUGtFQchYLevDy
 SHHMn932dZyV2lOfhshssweJDAga297XOaR9ps20oy8JbNBu/TWzVLgnRtqmTDvfEe
 GyZBks3pvlkPhUpX+3E+7MftcJUQkpgbRfx1r8NQ2cE//FkRiDGnOn7iVb5JKLB3k0
 +eWrYssGh0RvMLK8RtpikZqNpQ4+9G7sXD7g3a/iBW41hB0bPgQa8K3KA3zXSCOygS
 UWLXuhdQAUGOQ==
Date: Sat, 11 Apr 2026 09:02:05 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 Ondrej Jirman <megi@xff.cz>, Maxime Ripard <mripard@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jagan Teki <jagan@edgeble.ai>, 
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Conor Dooley <conor+dt@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-5-75cdbeac5156@oss.qualcomm.com>
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
 <20260411-waveshare-dsi-touch-v2-5-75cdbeac5156@oss.qualcomm.com>
Message-Id: <177591612547.2802023.3418602345377561200.robh@kernel.org>
Subject: Re: [PATCH v2 05/21] dt-bindings: dipslay/panel: describe panels
 using Focaltech OTA7290B
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


On Sat, 11 Apr 2026 15:10:25 +0300, Dmitry Baryshkov wrote:
> Add schema for the panels using Focaltech OTA7290B controller. For now
> there is only one such panel, from the Waveshare 8.8 DSI TOUCH-A kit.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../bindings/display/panel/focaltech,ota7290b.yaml | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/panel/focaltech,ota7290b.example.dtb: /example-0/dsi/panel@0: failed to match any schema with compatible: ['waveshare,8.8-dsi-touch-a']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260411-waveshare-dsi-touch-v2-5-75cdbeac5156@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

