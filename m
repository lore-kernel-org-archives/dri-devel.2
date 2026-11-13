Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A7C606A321
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqlwZJjH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 778DD10E7CA;
	Fri, 13 Nov 2026 10:35:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C18610FA50
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 10:35:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9EFBE61597;
 Fri, 13 Nov 2026 10:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551C41F000C4;
 Fri, 13 Nov 2026 10:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794566140;
 bh=UerP3CLloOzIBHQJLyt3oTTjvTEtdcx5/xHOh7RUlH0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lqlwZJjH/SxiImumqQDPqzBpG6eSGITEoRZ0RajCgq0OLV4FLm0JPWnW2kVduuDdg
 Lojs7Qo4rEWxiSPWBlb4JYOy8WQmjObsKc3WwdaLj5Szk7SVEjmSpRYb8tYBIIku+r
 KFrgM2ZnXwYmJonm7FPo63Y115zegwZCOEos3/iQhUjkTFW1diTDz4MY0NXJJaaQXt
 A0mAxvR+NqaVCEWMmrhyvJwafJ0Rmg7XCgTyTmswA8DXFJTIyTSImlEWJteK7lZKyD
 Ro+z3aXLTfALUJjXmte5iAntYtHzzWZQ2KvTCeMv5q5SSX1/OxZ0jKglGS6TfmzXtz
 buNGOPEgXrjPA==
Date: Fri, 13 Nov 2026 11:35:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luo Liu <Luo.Liu@cixtech.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 wuyi.shen@cixtech.com, cix-kernel-upstream@cixtech.com
Subject: Re: [PATCH 1/2] dt-bindings: display: add CIX Sky1 DisplayPort
 transmitter
Message-ID: <20261113-mustard-parrot-of-downpour-6ceadb@quoll>
References: <20261109103010.110911-1-Luo.Liu@cixtech.com>
 <20261109103010.110911-2-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261109103010.110911-2-Luo.Liu@cixtech.com>
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

On Mon, Nov 09, 2026 at 06:30:09PM +0800, Luo Liu wrote:
> Document the CIX Sky1 DisplayPort transmitter. Each instance sits
> between one of the SoC display pipelines and a DisplayPort PHY, and
> exposes the DP register block together with the RCSU block used for the
> link setup.
> 
> The controller is described as a DRM bridge whose video input is linked
> through the OF graph, and the DisplayPort PHY is referenced through the
> generic PHY framework. The RCSU adapter port, the video stream and the
> maximum link rate are described by "cix,adapter-port", "cix,stream-id"
> and "cix,dp-max-rate".
> 
> Signed-off-by: Luo Liu <Luo.Liu@cixtech.com>
> ---
>  .../bindings/display/cix,sky1-dptx.yaml       | 108 ++++++++++++++++++
>  MAINTAINERS                                   |   8 ++
>  2 files changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/cix,sky1-dptx.yaml
> 

Feedback from Sashiko looks reasonable and I do not see it being
responded to. Dropping from DT Patchwork.

Best regards,
Krzysztof

