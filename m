Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ABB606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=TWEelBMh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KUDv68Fo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D599B10E859;
	Tue, 24 Nov 2026 12:29:47 +0000 (UTC)
Received: from fhigh-a8-smtp.messagingengine.com
 (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2557A10E859
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:29:36 +0000 (UTC)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 283D814001FC
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:29:35 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
 by ams-compute-02.internal (MEProxy); Tue, 24 Nov 2026 07:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1795523373;
 x=1795609773; bh=J+iQqSqFu8ueiPUdhw6/IPHt38Wy3NcZWlRtWxtshi8=; b=
 TWEelBMh0FTDWndXG9h99WCIweikG7I9a64OdBJD6D8p6rTFf++aZEzYjoSAxRPM
 T5M5H/csms73IsuXbHLTt69hYF/+iY1k7GUIN+MiQt5+xVZAH//bdBsdwUlr7mcz
 KelIFq4lj+hgJ0ejjXl7rk7bQtHr5+3IyEJzP5e/nF+zV9vk2U5iQkoD3+jBxX5U
 xjjEMzzSVv4A/XtfzUQbhIcwO3v5PwbcM4t3zztayQGAzIqHXeLIjF+6pu4l95HW
 jkvLHTcA/cPSaat4jdUrs3Obbf3r3nf6V38fmLC9w04o4nqr4Byv5oFfCHVKiR/V
 +aYCqD+AZ/gXfUYk3Ldtug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795523373; x=
 1795609773; bh=J+iQqSqFu8ueiPUdhw6/IPHt38Wy3NcZWlRtWxtshi8=; b=K
 UDv68Fod38e+iYYgw8toeJiJUuw4XjFHfwHGTR+pdrsB8yGySCsv1zfspHUbT62T
 /uzAusTwehz/G0rZ3aMw/sGrvO+4pQs2TGeDcAXzbo7te8ifjZ3CJBJZCvkZFqgR
 OsjFpkmJG5sIpb+WX1e59OO1rgpj089a8u3sOGS0nE1XXFR5tj6T+Y2cog3Q4DHn
 WTT5rEEeQpEDykibCaAQPio/9jLuQzWy43kHa1EjIzxzmaWozj5OPkcqNdNER6EE
 99Q33YtcI+jb95ruYbrA0oV7gpxr26NLcYsXmm1gvdMa2zXQy6t59VlbS+L4zpZy
 xqWogkW6uYQwIQu4d5Flw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795523373; d=arndb.de; mf=PGFybmRAYXJuZGIuZGU+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm2:rsa-sha256:lY03dE8i/1qb2VaIoxDG+l0NBK72eJ/6QzSXQ99vFSF7wZa
 ClBk5lH0wAlEDGI+YT0tTuCGvERfDx+HU5kUwUiVL9AiAvmg8O0qVkrhL5otwP3i
 C8VlL5nrc2QvpG+onPkRyUoO7fvBKonVuobzdzOhqxPZ5srqDWYiuqFNE9ZWo0+L
 JL+Cce6YpbYzSKSB8jronvaSgsE1zSFDN9KlKZQfZHFl1eL6HkYu3GLDDYuxyl7g
 EMF8j05BYkHaZQQT7iUx2v69JiMUkUU8sx9SESR6z0gKjDiuSoQV5j4E88CY2xn5
 9AtHh6YYJaqbgaeCtkF7A8o4WpJ804ReaZds6ig==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:WklWg/MW8eQ2MC5Fb5620cULF/sXGGKTHSpZE+gN7+E=:1G/CnskwFv+RglCFqnhH6hTuGBmU+PO8HsO4U9eyme8=;
X-ME-Sender: <xms:KoMFa4je0nlSUfARc-BbSGPmD_m37zoRcewAW8qSjSqz53R2Umj1pA>
 <xme:KoMFa73DpUPor78uez-FOBwOouREIecSOpsizt0EUiJvHirbz_FhzTgdYe8-yNGPV
 4ydVibVJnVkzI64KKdOYcsGwJ592D-wN5X2Bo2J_RXKlnvEa8yRSpQI>
X-ME-Proxy-Cause: dmFkZTE5BLTcSGrx6CgjWnbPMN13rozf/SDKrWFoLpRqU+yKgbciJ0ge7kBDE2fY2sfQN+
 dYqCoarEUp+JyTD1ThRBIffIKGasaCVL7hzDEcyDhYkPOPaJR9DavnqIQMMEoZRB5/t5Fo
 XuWHcIxMMntMm68AfbFfebl+haspdDOvLCj+e10OH62hXQ8wKlt1LmoFCNyCp6Y0woAsWM
 8k1aKOe+FQKKC2dtACH17kAvr2/gbwjJeL6gGo+QsEeA2YuZK2Rehx03jsZZDjVQJZCWT8
 1fCchFq5COOwPV89clN8+uQH9+qfeaELGEoAHYpUaNFZwJ+cABoVdBOCYq8zEBayScEPIL
 xFGcfASXsTVIDaTnXK8ub2eSv8N3ybby1JA1P25GPGK/MxxAXu9sgxcfudTnK1R5fMNzgU
 jkoLfl1BktkCU3HsStjfvdpc2+v6a6hESwZV1Fw6hWLeJ6Vnc7wPFQr/V3dxeR20rEEIoa
 ninV5aKR1tzLJfdAjRW+V4z/yS9tYurBgBWRtLbXKpijFt7tKvyQv0h44cnOZM7w8ktIFR
 ztku7545OaSmYa/Ut/V8taN0bPe1Pp9PAExn+g6XCZF3hZ1yLMaKQEPLR26Z9J4ANuba+C
 NJ7okr7oitgeTH1RXnVrm0/POgYM7J2CCDUMzAC+bmtvVFbj9PLhPrK4lN3A
X-ME-Proxy: <xmx:K4MFayPViB16_WZ2dCpDhxyQAzsWaJTSuJpQ3M0jMv6vurzBaeAmrQ>
 <xmx:K4MFa2-pBjKEuv56_x7SPNdV7ehGE-Ykqm4FC1DEZHCNdFXySgzrMg>
 <xmx:K4MFa0FHJFFPm2gNHLRkeMLjXi9WOmehEHCPsWT5Njot11LFXsIKWw>
 <xmx:K4MFa1jN1PSXcGnwRmSLGGolceQBLkWvPBxwOnxlPz5YT_GRVPpAYQ>
 <xmx:LYMFaww01QexLMy5bkvonj3UxkCjJQk4fCczS5DjiPqM1_lK2Nf8PA7E>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id E7AD832A009E; Tue, 24 Nov 2026 07:29:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: AthCWVl4bt_o
Date: Tue, 24 Nov 2026 13:29:09 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Abhinav Parihar" <abhinav.parihar@oss.qualcomm.com>,
 "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
 linux-arm-msm@vger.kernel.org
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 quic_bkumar@quicinc.com, "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org
Message-Id: <6db57a38-ddf9-4345-996b-82db8a790b7a@app.fastmail.com>
In-Reply-To: <20261124120604.2640046-1-abhinav.parihar@oss.qualcomm.com>
References: <20261124120604.2640046-1-abhinav.parihar@oss.qualcomm.com>
Subject: Re: [PATCH v3] misc: fastrpc: Add cache maintenance for non-coherent
 platforms
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026, at 13:06, Abhinav Parihar wrote:
> Some platforms using fastrpc do not support DMA coherency on
> HLOS. On such systems, explicit cache maintenance is
> required to ensure data consistency for RPC argument buffers.
>
> Add cache maintenance for argument buffers when operating on
> non-coherent platforms:
> - Flush input buffers before invoking RPC to ensure CPU writes are
>   visible to the DSP
> - Invalidate output buffers after RPC completion to ensure DSP
>   writes are visible to the CPU
>
> Introduce helper functions fastrpc_flush_args() and
> fastrpc_inv_args() to perform the required dma-buf cache
> operations. These are invoked only when the device is not marked
> as DMA coherent.
>
> The coherency capability is determined using the "dma-coherent"
> device tree property and stored per session context.

The dma-mapping abstraction is meant to hide this from drivers,
why does this driver need to know?

> @@ -1078,6 +1086,54 @@ static int fastrpc_create_maps(struct 
> fastrpc_invoke_ctx *ctx)
>  	return 0;
>  }
> 
> +static void fastrpc_flush_args(struct fastrpc_invoke_ctx *ctx)
> +{
> +	union fastrpc_remote_arg *rpra = ctx->rpra;
> +	int i, inbufs;
> +
> +	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
> +
> +	for (i = 0; i < ctx->nbufs; ++i) {
> +		int raix = ctx->olaps[i].raix;
> +		struct fastrpc_map *map = ctx->maps[raix];
> +
> +		if (raix + 1 > inbufs)
> +			continue;
> +		if (!map || !map->buf)
> +			continue;
> +
> +		if (rpra[raix].buf.len && (ctx->olaps[i].mstart || 
> ctx->olaps[i].do_cmo)) {
> +			dma_buf_begin_cpu_access(map->buf, DMA_TO_DEVICE);
> +			dma_buf_end_cpu_access(map->buf, DMA_TO_DEVICE);
> +		}
> +	}
> +}

This does not look like an appropriate interface: the driver
should not have to worry about platform specific details
of 'flush' or 'invalidate' and only access the data between
'begin' and 'end' here. E.g. if there is an iommu or swiotlb,
the buffer may become inaccessible again after 'end'.

Can you change this to have separate loops to manage
ownership before and after the access?

      Arnd
