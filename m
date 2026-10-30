Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A27606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LCXqM3MR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0311B1127C2;
	Fri, 30 Oct 2026 12:09:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E8DB1127C2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 12:09:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4AA59609D0;
 Fri, 30 Oct 2026 12:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CECF1F00A16;
 Fri, 30 Oct 2026 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793362156;
 bh=e/ifG3aJlgeryqjmhfgJsERZbxd/WJ6aLHD7syJgljY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LCXqM3MR/ZIt2paBuHsNpEyJ2YAbBtXoJVoSL2kmhSkpHerihlzO5jP7kg3NpyZNI
 9dFoxwwuDSGS8TI8OKIgW1Ko2OuX93Eb04SdiMzbYIfLxMK5DeSx9iA4cK4Uzx7I0k
 R6I2nkE33bjHOZKR0egB5nVDqt0OFelbKFn6DVW418lvJI4B6VsYJ3Na4CejKYfoYp
 E7LqHQ/Iyj+5nUH1e0c+/Q7iowpmUNhcJqV+7MmbttR3E+rq/duRTVUbXAhMgg9W6U
 DKds7xr0/3kRf0H42LAryDxgFNcZPOLsTLA6x2IAWCsP2LcMdgQu2SY9ZKRQsehhvk
 kzCfCDk5DUKJA==
Date: Fri, 30 Oct 2026 13:09:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Icenowy Zheng <uwu@icenowy.me>,
 Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH 2/4] dt-bindings: ili9881c: add compatible string for
 Mingjun MJ070BI30IA2
Message-ID: <20261030-arrogant-nano-raccoon-b67b70@quoll>
References: <20261030-mj070bi30ia2-v1-0-a0f65b65c290@iscas.ac.cn>
 <20261030-mj070bi30ia2-v1-2-a0f65b65c290@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261030-mj070bi30ia2-v1-2-a0f65b65c290@iscas.ac.cn>
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 01:44:13PM +0800, Icenowy Zheng wrote:
> Mingjun MJ070BI30IA2 is the LCD panel used by Sipeed Lichee Console 4A,
> and its initialization sequence seems to match ILI9881C controller.
> 
> Add its compatible string to the ILI9881C binding.
> 
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
>  Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

