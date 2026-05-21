Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9446DCD5BAF
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 20:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05DD110E250;
	Thu, 21 May 2026 20:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M5f5eqGv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC46610E250;
 Thu, 21 May 2026 20:46:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 01C4C60172;
 Thu, 21 May 2026 20:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949791F000E9;
 Thu, 21 May 2026 20:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779396394;
 bh=gLygPlXA9zpesWB7c3xrHmVnj9UJD76Jx38c6ojWHvw=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=M5f5eqGvavsSQMvYmggCSUSdS9W0sW2PKLKo3OkFyr+HqRkZTOUb3QCegTl4qsiDY
 sRYKRxn0Ppu1fVRtqgdpHK4yHqJT99NBHxkhSQpqyRQQldR0dS2/E7ISazZiRK6aYK
 SdglK6QHxhUk8ifntU6CksiYATjh6Vd9HX5xhH66egI1nWsiq3s7npcfz9vfvNJgKV
 jncxIa3thoRvmO1FpgxIUtsrFdVD0oQiqMBIxARkXTQiDAc28sguEX8PRQooHbUyod
 eC/PWaCFcuObLJmirrz7BkFnxJFy/e66sstx8u8G2ymtCCu1R26H0maGCv07SsyBzZ
 STc2KEF9caTjw==
Date: Thu, 21 May 2026 15:46:33 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, freedreno@lists.freedesktop.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>
To: Jun Nie <jun.nie@linaro.org>
In-Reply-To: <20260521-sm8650-7-1-bonded-dsi-v4-4-a4dd5e0850f1@linaro.org>
References: <20260521-sm8650-7-1-bonded-dsi-v4-0-a4dd5e0850f1@linaro.org>
 <20260521-sm8650-7-1-bonded-dsi-v4-4-a4dd5e0850f1@linaro.org>
Message-Id: <177939639394.2297482.6216353377976107855.robh@kernel.org>
Subject: Re: [PATCH v4 4/5] dt-bindings: display: Add Synaptics R63455
 panel support
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


On Thu, 21 May 2026 22:46:06 +0800, Jun Nie wrote:
> Add support for the dual-panel system found in the virtual reality device.
> This system consists of two physical 2160x2160 panels, each connected via
> a MIPI DSI interface. The backlight is managed through DSI link.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  .../bindings/display/panel/synaptics,r63455.yaml   | 125 +++++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml:26:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml:55:14: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml:55:14: mapping values are not allowed here
make[2]: *** Deleting file 'Documentation/devicetree/bindings/display/panel/synaptics,r63455.example.dts'
Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml:55:14: mapping values are not allowed here
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/display/panel/synaptics,r63455.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1659: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260521-sm8650-7-1-bonded-dsi-v4-4-a4dd5e0850f1@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

