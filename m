Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9911BCD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 07:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0B6F10F415;
	Fri, 15 May 2026 07:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KVQsGyhy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B912610F415
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 07:04:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 261ED60252;
 Fri, 15 May 2026 07:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46380C2BCB0;
 Fri, 15 May 2026 07:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778828642;
 bh=VHpZwYfNEozDI+mmX5fvgkM6Qsp2KkrAn2XfYL3rH+c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KVQsGyhyrGGTy+Ynv5DH6pAAqYEA2jCqX1HE6J2Zy+bU/rKztBgV2tbXgEYOy+3y0
 RvPkZml7s+M+u88HySPw4RVc1nVqGJB/ZyHCuOJ/iYrMtgQiL6Fs0VIA5+PNgLukyJ
 F/iJFdLCnXIA4O/XcNADnKp2nG8cV9mWwqYgPy0xqxQDIDT5Nx6tXch8lsHc9hwW8S
 UAHV2bm10zN8DzRTGPpiYFp0R8E2suFrFyv1RH7tA9FG7v/YZ2jcFhsLiYT/Nwg5iL
 egx3sPx+4I8kZoMc3y2likVcrd+kWWsIqCjO9LMEnsjJgpHlLqxXepTN+lrQXzQNPU
 WCbql5NIOsSYw==
Date: Fri, 15 May 2026 09:04:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, 
 davem@davemloft.net, neil.armstrong@linaro.org,
 maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 jikos@kernel.org, bentiss@kernel.org, luzmaximilian@gmail.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, Douglas Anderson <dianders@chromium.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 2/7] dt-bindings: crypto: Add x1e80100 inline crypto
Message-ID: <20260515-pistachio-mongoose-of-engineering-dcd29f@quoll>
References: <cover.1778822464.git.harrison.vanderbyl@gmail.com>
 <14cd42e3d3af4b2591c9dd8dffde11ef18666751.1778822464.git.harrison.vanderbyl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14cd42e3d3af4b2591c9dd8dffde11ef18666751.1778822464.git.harrison.vanderbyl@gmail.com>
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

On Fri, May 15, 2026 at 03:41:47PM +1000, Harrison Vanderbyl wrote:
> Add compatibility string for the x1e80100/x1p42100
> inline crypto engine.
> 
> Signed-off-by: Harrison Vanderbyl <harrison.vanderbyl@gmail.com>

This was posted, please do not duplicate work.
https://lore.kernel.org/all/eggp3un5ufbw2mjamxmpfccq3cs2luxabpa2sucofydzoak4vg@hy7mx3rtqfko/


Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets. See also:
https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830

Best regards,
Krzysztof

