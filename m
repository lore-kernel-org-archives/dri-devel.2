Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D0DC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2DC910EB26;
	Tue, 30 Jun 2026 07:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MQ8ISaVF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A6BE10EB26;
 Tue, 30 Jun 2026 07:22:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0014A43D76;
 Tue, 30 Jun 2026 07:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAC11F000E9;
 Tue, 30 Jun 2026 07:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782804167;
 bh=15o4K5qq7tiiYrARQISBqxgVYHpa/9wf+7SjLZ2Y6sM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MQ8ISaVFYbFlEc3zyzDgHvYhw+iQtIDneEJqEzkupZhIm79ia7yr70OVW/Ox4QP2o
 G9NFInht/TzBZRHDeTM5uhfLWkPcK2qfrMNBRf/3uzYHG2FzAuJRf9x/mxwpSEdOlq
 kc4c/wgz5MuiYBeV4BdQOPh1nnsVBX1pauxgE75XrNdeIITHg1vxCXtURjXnDBE6U1
 W4ejAxge/0m0iQMA3O9a6A2My+1q2zYMNL00kVqIgOLqyVO3a4OW+k/ALHY4O9QhAU
 onNWzkiNe+GnY/KThuYCiW5nTuxSk7X/y6jbyUeyZD6VKrUTsaIZw4bsE3Pi8UEma6
 qOdBXgXQPz6sg==
Date: Tue, 30 Jun 2026 09:22:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Matt Coster <matt.coster@imgtec.com>
Cc: imagination@lists.freedesktop.org, 
 Matt Coster <opensource@mtcoster.net>, Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Frank Binns <frank.binns@imgtec.com>, 
 Brajesh Gupta <brajesh.gupta@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: gpu: img,powervr-*: Remove Matt Coster
 as maintainer
Message-ID: <20260630-electronic-lemon-oarfish-ccaeb6@quoll>
References: <20260629-goodbye-v1-0-3bab53a80c53@imgtec.com>
 <20260629-goodbye-v1-2-3bab53a80c53@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260629-goodbye-v1-2-3bab53a80c53@imgtec.com>
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

On Mon, Jun 29, 2026 at 04:47:30PM +0100, Matt Coster wrote:
> I'm leaving Imagination; remove myself as a maintainer. A separate patch
> leaves a personal forwarding address in the .mailmap.
> 
> Signed-off-by: Matt Coster <matt.coster@imgtec.com>
> ---
>  Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml | 1 -
>  Documentation/devicetree/bindings/gpu/img,powervr-sgx.yaml   | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index 91e4ff61b394..a6bccb600a57 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -8,7 +8,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Imagination Technologies PowerVR and IMG Rogue GPUs
>  
>  maintainers:
> -  - Matt Coster <matt.coster@imgtec.com>

Next from next-20260629 does not have these entries, so maybe it was
already removed...

Best regards,
Krzysztof

