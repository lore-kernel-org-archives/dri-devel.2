Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B635A606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5S28U6t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DF8010E044;
	Sun, 22 Nov 2026 18:10:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A364010E044
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 18:10:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A494560D76;
 Sun, 22 Nov 2026 18:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3891F000C0;
 Sun, 22 Nov 2026 18:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795371021;
 bh=57AAn+2X+JfN1t49EdhGIIeqroEnSzaXZ3Fam/Be9EQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=A5S28U6tJKZD5nGStMrBsjXrxhdVSKR8fMlNmLmN7wtO8gUtHbqvoWDxA8amshQB5
 Gld/duw2gMyBUK8TAu1/N/XjBq9TkHs6wox7Claz7Xf+WZA8EBTdhBh+2z8Ie61ncm
 NUECE1L5STVwOM+uRE5AFeVyZPlIJFqUZGaF+AJK94vhe+PO1KVPOEgSsp57M5+/Np
 Dtoy8U/7/M4/uTNmqKHGxBn/OIXAKFQ/yZO2ZXyEjNakGm8RyfBED07d1NZjHv6hZ8
 AnkdUt8UXglVCjIa/1/iLskVpmP+gpO37IlVtv6eFwAbD5jN4ReQ+jc6Agpb32POeQ
 RMS256mquwcbg==
From: Chen-Yu Tsai <wens@kernel.org>
To: Samuel Holland <samuel@sholland.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, 
 Andre Przywara <andre.przywara@arm.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261119175437.2520400-1-jernej.skrabec@gmail.com>
References: <20261119175437.2520400-1-jernej.skrabec@gmail.com>
Subject: Re: [PATCH v4 0/5] drm/sun4i: update DE33 support
Message-Id: <179537101807.635199.7504313693116992864.b4-ty@kernel.org>
Date: Mon, 23 Nov 2026 02:10:18 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 18:54:32 +0100, Jernej Skrabec wrote:
> This is second series out of three which aims at properly introducing
> support for H616 Display Engine 3.3. Previous series [1] reorganized
> driver so proper DE33 support can be easily implemented.
> 
> H616 DE33 support was actually introduced a while back, but it was done
> without fully understanding hardware design. Issue with existing binding
> is that it considers planes as resource which is hardwired to each mixer
> as it was done on older Display Engine generations (DE3 and lower). That
> is not the case anymore. This series introduces new driver for planes
> management, which allows doing proper plane assignments.
> 
> [...]

Applied to drm-misc-next in drm-misc, thanks!

[1/5] drm/sun4i: Reject fractional source coordinates without scaler
      commit: f240bdee7ea178fe96d6d8510b9a9fac4d50ed88
[2/5] dt-bindings: display: allwinner: Add DE33 planes
      commit: 6fad6c7a66e9584ac60863cb54b9c6c637219d74
[3/5] drm/sun4i: Add DE33 shared plane driver
      commit: a1d012f31f6fb0563d122caec24be4f33359083e
[4/5] dt-bindings: display: allwinner: Split H616 DE33 layer reg space
      commit: daefcb60c18cc4e9651c6699077304ed4f2744bf
[5/5] drm/sun4i: Switch DE33 to split plane bindings
      commit: edb16093db0f7262c07155d1bc3467921616a1df

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

