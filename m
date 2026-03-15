Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FF2F30271
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 16:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7250E10E2A6;
	Sun, 15 Mar 2026 16:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LgLDdw+Z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FDC410E297
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 16:19:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B337E4037D;
 Sun, 15 Mar 2026 16:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD90C4CEF7;
 Sun, 15 Mar 2026 16:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773591576;
 bh=h5Z6I40xCkxuo0L+Pz55mKrVb/ARpUeKbuqHsTWX90o=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
 b=LgLDdw+ZqkTckA4mFvt+6o+TVZxNlHTnrRpgkJVdELZWwNb0bXItkkBGKWECemanf
 /OZXW2pM1zl0ssQ+jNtwbGHUkVcioPlEuuOxzugyjzt/NbtFyTTNRG/2BKFpFHktPQ
 bOkcoMwVGRsjQ/Aq/8iaAKtt84HeDoMZhTwSypKZVD88YyXVLB39Pd0sfkm+OGsIar
 RiHtb+WJIbPNIRdd2Xjx0jvWE345dBEEEy8VvYdV4uOEfCqgOpkdbjHUYrGyIiCDog
 eFad/cQKBY4/TxEyvfb2lGjN/RZlQy4XnIguj6UN1cL5QLDOjxRwglOKK0X8/B38cM
 BfC8UE+JoOjqQ==
Date: Sun, 15 Mar 2026 11:19:35 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org
To: Pengyu Luo <mitltlatltl@gmail.com>
In-Reply-To: <20260315144536.515032-2-mitltlatltl@gmail.com>
References: <20260315144536.515032-1-mitltlatltl@gmail.com>
 <20260315144536.515032-2-mitltlatltl@gmail.com>
Message-Id: <177359157560.309332.9206480782210457963.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: Add Himax HX83121A
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


On Sun, 15 Mar 2026 22:45:35 +0800, Pengyu Luo wrote:
> HX83121A is a driver IC used to drive MIPI-DSI panels. It is found
> in HUAWEI Matebook E Go series (Gaokun2/3) with BOE or CSOT panels.
> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
> v3:
> - remove '|' from description (Krzysztof)
> - drop description for reset-gpios (Krzysztof)
> ---
>  .../display/panel/himax,hx83121a.yaml         | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx83121a.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/himax,hx83121a.example.dtb: panel@0 (csot,ppc357db1-4): 'ports' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/display/panel/himax,hx83121a.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260315144536.515032-2-mitltlatltl@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

