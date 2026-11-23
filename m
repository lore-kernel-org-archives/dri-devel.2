Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF93C606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9R06Iht
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEDA610ECA4;
	Mon, 23 Nov 2026 22:27:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D3A10ECA4
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 22:26:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F69542AB7;
 Mon, 23 Nov 2026 22:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31CE1F000CA;
 Mon, 23 Nov 2026 22:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795472819;
 bh=yYD5vZBdnkFtnUsJ6D8rbr9QKv09GjSrmbmfhpJgdAs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Q9R06IhtsuQiCDcfXLA76ThniV+03fiA5vFBcWrHH4yVDSdtp+HXHCSKoBqMXfwQU
 btOLOtabBXNbseUBje7KPsBlzOzN3tUjmPrwPGR8TqgXI/khlEQfCpnVSAgTy2ZeUs
 pFtsks7RftbWpnaIA6iDYUCyRrDrtUQZmzUMxLpLeHBcA3b6E1uDdUr4j/aYVDzu8o
 qRjk38WKdd6V5hAmspUEx5oo4SbD39zK/zbJb9+bgflt6ruMTr7TFp70suKteeTbTk
 qIDUUvrr9T/oiAjh6meFEyf8yKBH+pgJMIMguuRc3F6zB/SKXz0soJD4GT5ZNH/mN4
 Ix3m3RYTe9p/g==
Date: Mon, 23 Nov 2026 16:26:56 -0600
From: Rob Herring <robh@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: vigneshr@ti.com, andi.shyti@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, aaro.koskinen@iki.fi, andreas@kemnade.info,
 khilman@baylibre.com, rogerq@kernel.org, tony@atomide.com,
 jmkrzyszt@gmail.com, sumit.semwal@linaro.org,
 christian.koenig@amd.com, phasta@kernel.org,
 linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v3 1/3] dt-bindings: i2c: ti, omap4-i2c: Add DMA properties
Message-ID: <20261123222656.GA3008799-robh@kernel.org>
References: <20261120185915.150228-1-apokusinski01@gmail.com>
 <20261120185915.150228-2-apokusinski01@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120185915.150228-2-apokusinski01@gmail.com>
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
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 07:59:11PM +0100, Antoni Pokusinski wrote:
> Document the TX and RX DMA request channels featured
> by the OMAP I2C controller.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

Missing Krzysztof's ack
