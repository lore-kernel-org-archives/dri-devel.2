Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB61CD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 05:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA6C810E1BB;
	Mon, 15 Jun 2026 05:40:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dApx1DFA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6358310E1BB
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 05:40:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BD4FC6008A;
 Mon, 15 Jun 2026 05:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8071F000E9;
 Mon, 15 Jun 2026 05:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781502023;
 bh=oVTv/3ou6eR5XuLEVtIdX/3BAp0B+266W+IcpFKpsNA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dApx1DFA+fLTeSiE0bZBg6hGVnXoGtF/B6BhcP+9xp5azw8naWOGEjZmco9jUvyUj
 moxe+gABu1eJpuGEHLu3cmZ88c0fyLBwdKSZQmq0CxeR0sL2dIia6BRE7VYBiCjvC5
 x4o5FK3LlJw/yJ4HStVQS+hgqzh+CvKYGXd9w0K+02PDbrpdg18D8N0ABhTFPsZ0gj
 cO/y6Exc3hZTSUKvJWQMuAfGpHMwDTZaKPEoIWvbOZ427NNpvj92qWOmTVK5qwpwiQ
 vU8Z2nejoqkdh2fCexBmJ5YrIwDOo15X3cf6zVU3/3uaj4gKM0/BoAYQ1lq9zF92At
 0xHusHTN64Zmw==
Date: Mon, 15 Jun 2026 07:40:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, David Heidelberg <david@ixit.cz>,
 phone-devel@vger.kernel.org, Amir Dahan <system64fumo@tuta.io>
Subject: Re: [PATCH v3 4/4] Revert "dt-bindings: display: panel:
 panel-simple: Add lg,sw49410 compatible"
Message-ID: <20260615-jacamar-of-angelic-aurora-1e4cba@quoll>
References: <20260614-judyln-panel-v3-0-07f4134441bd@postmarketos.org>
 <20260614-judyln-panel-v3-4-07f4134441bd@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260614-judyln-panel-v3-4-07f4134441bd@postmarketos.org>
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

On Sun, Jun 14, 2026 at 05:08:01PM -0700, Paul Sajna wrote:
> This reverts commit a74c2e55ab66519ffa2069ac9ae83cd937bff4c4.
> 
> It isn't actually panel-simple-compatible, and we knew as much by the

This is not a separate commit. Your work is non-bisectable - this commit
leaves undocumented compatible.


Best regards,
Krzysztof

