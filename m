Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D14606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Djp6KgM/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66F8A10E058;
	Mon, 26 Oct 2026 07:49:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9158410E058
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 07:49:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DAB2600CB;
 Mon, 26 Oct 2026 07:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CF11F01825;
 Mon, 26 Oct 2026 07:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793000975;
 bh=tGan54VoAnB4BE1bGQWN3/UB0AMHIKWY02TwZZSb8dc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Djp6KgM/ed2JB1GYRGErLaSBWyk2umqHkL8Qd/t3iZ3KIQyMH6wf/SZcOl/F2nvnm
 J08z3u6soNcscjlSljFsrWs6jyqderjJuFXv/LlciGkUiS9YEcnwijYS5Py3Q9pAwu
 5bzhC5Ss5o53wBcVQrBHXM+T/1fFyG6FzDtDj8up7fgb9EzaTeYsGguzFoWm3A5Mdz
 kQcxdWEhC+PHL5MtK8b5dR/4RhmmD/3Bfil48gkj2uelsLrQDnV57mcsLKCJGorOM0
 Q2hbssBt6WxooFcoe9hM9jjebnDbKqSAs8zh4kX5GjMY1LopHj+IACG3uZoTLwjQLC
 n/FTqA94ydnpQ==
Date: Mon, 26 Oct 2026 08:49:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tomeu Vizoso <tomeu.vizoso@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, "Andrew F. Davis" <afd@ti.com>, 
 Randolph Sapp <rs@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrei Aldea <a-aldea@ti.com>, Chirag Shilwant <c-shilwant@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Tero Kristo <kristo@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Oded Gabbay <ogabbay@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Robert Nelson <robertcnelson@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Markus Elfring <Markus.Elfring@web.de>, 
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Suman Anna <s-anna@ti.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, linux-remoteproc@vger.kernel.org, 
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 02/16] dt-bindings: remoteproc: k3-dsp: Allow a second
 sub-mailbox
Message-ID: <20261026-illegal-gifted-rooster-047a1a@quoll>
References: <20261023-thames-v3-0-3ab40aa17157@tomeuvizoso.net>
 <20261023-thames-v3-2-3ab40aa17157@tomeuvizoso.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261023-thames-v3-2-3ab40aa17157@tomeuvizoso.net>
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 08:39:27AM +0200, Tomeu Vizoso wrote:
> Allow specifying a second sub-mailbox that could be used by the firmware
> in addition to the first one, which is taken by remoteproc.
> 
> This is required by firmware that doesn't use rpmsg for their
> communication with the Linux kernel.
> 
> Assisted-by: LLM

Drop

> Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

DCO mismatch.

> 
> ---
> 
> v3:
> - Initial version
> ---
>  .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml        | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> index 278b88b7f906..d6319c8e96f8 100644
> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> @@ -51,10 +51,12 @@ properties:
>  
>    mboxes:
>      description: |
> -      OMAP Mailbox specifier denoting the sub-mailbox, to be used for
> -      communication with the remote processor. This property should match
> -      with the sub-mailbox node used in the firmware image.
> -    maxItems: 1
> +      OMAP Mailbox specifiers denoting the sub-mailboxes allotted to
> +      communication with the remote processor. The first is the one the
> +      remoteproc core uses and should match the sub-mailbox node used in the
> +      firmware image. The second is optional.

Instead list the items with description and minItems: 1. Don't repeat
constraints in free form text.

> +    minItems: 1

Best regards,
Krzysztof

