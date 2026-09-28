Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D589C9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C33D10E00F;
	Mon, 28 Sep 2026 13:17:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OI5CR+2m";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4874910E00F
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:17:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A20260052;
 Mon, 28 Sep 2026 13:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685C31F000FF;
 Mon, 28 Sep 2026 13:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790601424;
 bh=FSxc54jncYfYWdC33L6funQ4SZkqHESMbz6mSZqHJvQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OI5CR+2mSG2xRuY4trWxN0y1B4w+qGlCh2z3jb/NF/jlPrlAU8NLtXRYCqyOBigO5
 B/C0o+ifZazuI6rATYOAIZUFfzVeez7ecOWkCZqmk9GrLXdFGWNPk8NjA+jj0QhFFq
 Fwr4duscWPENHQ2tfO4JlvxUEwylFaA2tv2wTkSYNwFEC/pZ4avM4WlgqBUiD/6AZN
 sFxmj50EPbQjWUN8Yc+nMS04kgMP2BCt+l5rXLVDtErQzVqTvnwBvVxrrPOyC2EYHn
 i3IXaHBj9wyGYCLUkaH1oXUR06sw/GINoXTWQV2M6sTKfigBZd7zcvTqFeA9Ck1KMb
 TjK6f7MLFUNzQ==
Date: Mon, 28 Sep 2026 08:17:01 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, devicetree@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 dri-devel@lists.freedesktop.org,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 1/2] dt-bindings: display: faraday,tve200: Use a
 level-high interrupt
Message-ID: <179060141842.3905299.18293784781944970746.robh@kernel.org>
References: <20260921-gemini-tve200-fix-v1-0-8be03ac2a8f7@kernel.org>
 <20260921-gemini-tve200-fix-v1-1-8be03ac2a8f7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-gemini-tve200-fix-v1-1-8be03ac2a8f7@kernel.org>
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


On Mon, 21 Sep 2026 11:15:54 +0200, Linus Walleij wrote:
> The TVE200 vertical interrupt can remain pending after acknowledgment.
> Using rising-edge triggering can leave it unserviced when no new edge
> is generated, causing vblank and page-flip timeouts on the D-Link DIR-685.
> 
> Use level-high triggering in the binding example so a pending interrupt
> is delivered again without requiring a new edge.
> 
> Fixes: 8b17e80d9e46 ("drm/tve200: Add DT bindings")
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/faraday,tve200.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

