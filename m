Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982B1606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UFQzJW4u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0F4410E6AB;
	Mon, 23 Nov 2026 20:22:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA39A10E6AB
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 20:22:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3BB2D60DD1;
 Mon, 23 Nov 2026 20:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A161F000C0;
 Mon, 23 Nov 2026 20:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795465321;
 bh=4uPGLAnAcPx9aw8ELBEXzJcU/YTR28Mt6fI9wiOkEXk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UFQzJW4uga04lxqsn02e+WFFyKwD0SkIuQNMv72T1zd39oTGEoPXUqele811c3DBc
 j39Mvz5Kb25qqT0fn60zBv5cXv4SEWr+dnS6vqjhAePNYoL4zhntOxXCLqDKJiI6Oh
 g4flffywo+PrrgPS+E5CYC+JP343pbctY1OoeRL6j5bd98ze6cWn7TM4+QsCBspv7Y
 TQCRvwbozIWAcFM4u8z8rF4/A2YPWsxO/PxD8YfqV9OZnu4FpE6i7faMoSelOm3Xl8
 lMWHY5exkT1f3Ep8079xlIbWKlKTDZ0/oy8Pmz1ahLNNof5i0WrhW/WGOUmHW5A6vy
 Xw+zvSOR4VgKg==
Date: Mon, 23 Nov 2026 14:21:59 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Gerard Marull-Paretas <gerard@teslabs.com>
Cc: dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Alex Lanzano <lanzano.alex@gmail.com>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, devicetree@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] dt-bindings: display: sharp,ls010b7dh04: Add LS013B7DH01
Message-ID: <179546531526.1777962.3727881292046293374.robh@kernel.org>
References: <20261122093426.72677-1-gerard@teslabs.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122093426.72677-1-gerard@teslabs.com>
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


On Sun, 22 Nov 2026 10:34:26 +0100, Gerard Marull-Paretas wrote:
> The LS013B7DH01 is the 144x168 Sharp Memory LCD of which the LS013B7DH05
> is a thinner revision. It is obsolete, but still used in products.
> 
> Both are electrically the same, taking the same SPI commands and VCOM
> signal at the same resolution, so the LS013B7DH05 compatible can serve
> as a fallback and the sharp-memory driver drives it unchanged.
> 
> Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
> ---
> 
> Notes:
>     Checked with dtschema 2026.9: the steps of dt_binding_check run by hand (host make too old), yamllint and dt-check-style --mode=strict.
> 
>  .../bindings/display/sharp,ls010b7dh04.yaml   | 26 +++++++++++--------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 

Applied, thanks!

