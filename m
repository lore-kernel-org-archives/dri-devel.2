Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B8606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lzGln/yR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 803FD10ECB8;
	Mon, 23 Nov 2026 22:30:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC43F10ECB8
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 22:30:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9FDB043C2E;
 Mon, 23 Nov 2026 22:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DB41F000CA;
 Mon, 23 Nov 2026 22:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795473005;
 bh=Vonja/PWgylse+6hBXyJmA35GVq/syIKCdpb3rN0/Ug=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lzGln/yRz0K8gY3hSZwX2LcHlzexYk9HaYmvAPnNhXpSPS4+QBaa7uf/ly9tyKVCQ
 GoFTfFuDI1Y1q5tacn+dbIwATPLdJkVCLKFmgvbSYN4owZLfj/xf9spP7YNyUGiVxl
 j1O5Z3ubd7CMwP2nZXMGRB9YhmTEpzbUqYmFt4cpH+fuplUeeTk/1PjYExrHG7uHOr
 m3g95Ns7YbKow0C6U69Ac839inaU0aaEqE0FyFB4hxTL9Fvg5uOeiVZv0y1B/jAXY1
 FFU1GvOaTFof9Z5A95t5tASH7cW4jneouftkDHQQFGakpcDV6woZUryvaQVSU54pfY
 LfKyqWOAL35xg==
Date: Mon, 23 Nov 2026 16:30:03 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 David Airlie <airlied@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: gpu: arm,mali-utgard: add mt6572
Message-ID: <179547300234.3122395.932903973826023560.robh@kernel.org>
References: <20261121-6572-dt-mali-v2-1-1c3925ec7ad1@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121-6572-dt-mali-v2-1-1c3925ec7ad1@protonmail.com>
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


On Sat, 21 Nov 2026 19:55:54 +0200, Roman Vivchar wrote:
> Add a compatible string for the mt6572 Mali-400 MP1 GPU.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
> Changes in v2:
> - Pick Krzysztof's ack, resend
> - Link to v1: https://patch.msgid.link/20260810-6572-dt-mali-v1-1-fb908627bf23@protonmail.com
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

