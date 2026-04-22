Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0248F94CD9
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 07:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E823F10FE8E;
	Wed, 22 Apr 2026 07:05:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tm0DYXei";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12DF910FE99
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 07:05:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E495D60018;
 Wed, 22 Apr 2026 07:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13ADDC19425;
 Wed, 22 Apr 2026 07:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776841532;
 bh=AlSwSDDgeC2hF4Q929lxXrzS9wWZ7U+8Ajj4sHAJpTE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tm0DYXeiKP8RKdgpE0RxD+0PgxkKswX4FJoL2B8beXJ+RB9sd5AD0D/cU5W65VUNO
 a542dS8zGBpm3SdvK7zosVQmi+1aC0/VRLw43puOF7mNDWZ/S00dBXHtBxSEekcBJX
 oSmS2z98VsFpCBseVSVgTZ+vGH8+Ak93sEoOcxEp8T0tThgjGZIXXmHd2Q8ZTfAQ/f
 me1FZzVto49G9r86XYOeRQf9F69tWD6ZX78gsxowMbrBhWDHVN8waphqJIBfZbSbi2
 9EqOtn0huLwpXm0WYbbVXF92O+aG/LGtTE6MCe+YtOukTcTXsuFWqXFKSPMIASYWvj
 RhOznfX//y16g==
Date: Wed, 22 Apr 2026 09:05:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Teguh Sobirin <teguh@sobir.in>
Subject: Re: [PATCH v5 1/2] dt-bindings: display: panel: Add ChipWealth
 CH13726A AMOLED driver
Message-ID: <20260422-resilient-puma-of-excitement-02fee3@quoll>
References: <20260421-ch13726a-v5-0-f7f6f4f30e05@gmail.com>
 <20260421-ch13726a-v5-1-f7f6f4f30e05@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260421-ch13726a-v5-1-f7f6f4f30e05@gmail.com>
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

On Tue, Apr 21, 2026 at 12:38:37PM -0500, Aaron Kling wrote:
> The Chip Wealth Technology CH13726A AMOLED driver is a single chip
> solution for MIPI-DSI. This is used for the AYN Thor bottom panel.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  .../display/panel/chipwealth,ch13726a.yaml         | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 

I don't get it, you use b4 but still drop the tags (b4 gets them
automatically). Nothing explains reasons for dropping the tag, so I skip
the patch.

Best regards,
Krzysztof

