Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A153C606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtJDGtCq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D28910E0F5;
	Fri, 13 Nov 2026 08:41:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C75B10EC26
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:41:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7C6F162608;
 Fri, 13 Nov 2026 08:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093A11F000C4;
 Fri, 13 Nov 2026 08:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794559310;
 bh=LwTB4Po1Iiga1rVbkoh2Jk5GPy02LPtdQZHEI2HXwa0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=gtJDGtCqxMPFfFesQAZfE5Xdh5QRm9Ze56OSmfLY1KVbzIZIfzZMgACHzBjNCG6V9
 P5BtZHGQgbSnFH2gwHvX/Fn/jkXNg4pEIQmnE4v3ye7Z+wyv1UfXsFWSPjgrNR3GAz
 8leKU7aqSxuAebMAue6iPt9wvYIEjMcJO7yzzSxJuXSTkP+vDljnXbaxWwYb6eyKs8
 eoY97V2Afb1YSvpOPY7/9t6mLWT96w4KzaNTyZF4xuOsYWw9QHWeA5RoR9/OmsAhvp
 3y5+wL2nN8o9V7Qa/MYsT+9Eoz2LyxzaH5LPK63OKEbURezYWg0bbr751oaBnB7KV5
 F7jjvNk0tdYSA==
Date: Fri, 13 Nov 2026 09:41:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org, wsa+renesas@sang-engineering.com
Subject: Re: [PATCH v2] dt-bindings: display: panel: Make DSI panels port
 optional
Message-ID: <20261113-unbeatable-acoustic-scallop-251311@quoll>
References: <20261112150650.137216-2-krzysztof.kozlowski@oss.qualcomm.com>
 <sashiko-outbox-211417@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-211417@kernel.org>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 03:15:35PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] dt-bindings: display: panel: ilitek,ili9806e: port made optional
>   for SPI panel

Ack

Best regards,
Krzysztof

