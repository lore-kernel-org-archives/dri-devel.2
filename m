Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52BB606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N1y55w+u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038C010E8B1;
	Thu, 19 Nov 2026 20:15:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A8610E8B1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 20:15:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8EAC445FEB;
 Thu, 19 Nov 2026 20:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3961F000C0;
 Thu, 19 Nov 2026 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795119304;
 bh=ZFP1KdKJOpORb419ON5uvKPl/QdtChge5ZGA23yIqR4=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=N1y55w+ukoBuAaoIpV9697PFKD+LkkgqSjniDb3jEnYmGlW1Nhh1myVpSZ54jiBzh
 Iqwn65mKganneME9L2Sbw3782RiZqNxud+QbippqCanl4TS6j/FYmmmGdyEbiZlZvX
 HUJuBBOOoKcpZGVa/5TL5PjoWwprsOONZ86FWUjYNNadAmhaQBU8FRD+dZq4JfIe3w
 ySOKFgCnUhU+5ioEIdHpDno1FVBcbYfn7nYUiVHmrEAXZ7VQd+iCytSEAmyMuY7eye
 emgkueK5KBrBi/lVNPDMPHfuhS5YHeN1+hFKClfLbO2RaJ0OCNTFwYpErjgDSJCIjy
 azvX+rkEu6BhA==
Date: Thu, 19 Nov 2026 14:14:58 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org
To: Hefei <3066883572@qq.com>
In-Reply-To: <tencent_C97CF8588D7C3312CE3D51FCDEA1E68DA70A@qq.com>
References: <tencent_C97CF8588D7C3312CE3D51FCDEA1E68DA70A@qq.com>
Message-Id: <179509880891.714790.13159454991217439265.robh@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: display: add VIEWE JD9365TX panel binding
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Thu, 19 Nov 2026 10:48:01 +0800, Hefei wrote:
> Add the device tree binding for the VIEWE 7KF82 720x1280 Jadard
> JD9365TX MIPI-DSI panel.
> 
> Signed-off-by: Hefei <3066883572@qq.com>
> ---
>  .../display/panel/viewe,jd9365tx.yaml         | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.example.dtb: panel@0 (viewe,7kf82): port:endpoint: Unevaluated properties are not allowed ('data-lanes' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/panel/viewe,jd9365tx.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/tencent_C97CF8588D7C3312CE3D51FCDEA1E68DA70A@qq.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

