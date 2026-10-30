Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB66606A321
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhq2YO61
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 692AF1126E6;
	Fri, 30 Oct 2026 09:56:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F211126E6
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 09:56:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C07D6025F;
 Fri, 30 Oct 2026 09:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F79F1F000C1;
 Fri, 30 Oct 2026 09:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793354173;
 bh=2pjemkGxowj+xCRFsgpE+Sr/MpR5xg7sVFs22RMEq8s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nhq2YO618uskoVNhmXFuHaT9We+/yoR5HgkdFi+c9uZVNh8r5JMVg5uFp5TPQR8XC
 981UpFx5tUSW28zHJQWqHnrcjzVuGzdqM5cdwo3kh1/lgOdpgHBd5WzFg9IytfWmob
 93v5/OgJ3bSlSVL527nymMR0QKBZG0kAw92wjokeMajVC6QOlHVj/XzvfynzCZiF21
 JgR1k0w3mj/CYnk9nrgIDLsWnlAbNEg54GrJq06yObJ86AlWXZWim8ofvNdJmXhcvd
 VqyydmsJfEwFmVHZ5+6l6QFUcNBH6W1hYTji8xOQS2gl7fwY4MTdU+wSLOZdQ2tKdG
 47XvemLlAsPmQ==
Date: Fri, 30 Oct 2026 10:56:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hermes Wu <Hermes.wu@ite.com.tw>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Pet.Weng@ite.com.tw, 
 Kenneth.Hung@ite.com.tw, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: display: bridge: Add ITE IT6162 MIPI
 DSI to HDMI bridge
Message-ID: <20261030-jolly-mantis-from-betelgeuse-2f0db1@quoll>
References: <20261029-upstream-6162-v5-0-8369f9e5afe6@ite.com.tw>
 <20261029-upstream-6162-v5-1-8369f9e5afe6@ite.com.tw>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261029-upstream-6162-v5-1-8369f9e5afe6@ite.com.tw>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 06:12:30PM +0800, Hermes Wu wrote:
> Add device tree binding documentation for the ITE IT6162 MIPI DSI to
> HDMI 2.0 bridge chip. The IT6162 is an I2C-controlled bridge that
> supports the following configurations:
> 
>   - Single MIPI DSI input: up to 4K @ 30Hz
>   - Dual MIPI DSI input (combined): up to 4K @ 60Hz
> 
> The chip also supports up to 8-channel audio output via 4 I2S data
> channels.
> 
> Assisted-by: Claude Opus 5.5

Drop the tag now, rules changed.

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

