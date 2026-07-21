Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FA8C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84BA110EAF0;
	Tue, 21 Jul 2026 18:07:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PNvEhFP9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2378910EAF0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:07:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E554442E6D;
 Tue, 21 Jul 2026 18:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000011F00A3A;
 Tue, 21 Jul 2026 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784657235;
 bh=RHcGoloNYmYwH+aPEyfH+QAtWnrh9cY7GdbPjNJEb2I=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=PNvEhFP9645lghGJsCG8GgCfsizcixDocQTZP/Jk6GkO1SWpREEYImH6pjG10Gl0i
 qj/FMGwx4brGfBsMKCXRYjtv5+vDX55HWlMdfuL15LlTQgzc0BEsba3ImS0cHxT0Us
 lYqa1cl1tfW/f5herNlKVyqbQ/VV8Dj1qN/CFOPELPW2TmxWjl8apxqdgFMhO/vi0z
 +3GXyZBMFYqUQD8HpTQJqzeJIP66baWdBGSAe3lwxkBv/IaAAclBbW2jBPmiguqhy3
 8fiffwJdgqX1Giiidq+xUoXUjrIjedRr6SnaLTrApnjuYdkZ80JCIctPla2k754m2n
 +xQyCICMamqMw==
Date: Tue, 21 Jul 2026 11:07:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
 sdf@fomichev.me, razor@blackwall.org, daniel@iogearbox.net,
 almasrymina@google.com, matttbe@kernel.org, skhawaja@google.com,
 dw@davidwei.uk, Joe Damato <joe@dama.to>, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 1/3] net: devmem: allow rx-buf-size >
 PAGE_SIZE per dmabuf binding
Message-ID: <20260721110713.325d36ba@kernel.org>
In-Reply-To: <20260708-tcpdm-large-niovs-v5-1-34bf6fac941b@meta.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-1-34bf6fac941b@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 08 Jul 2026 15:55:04 -0700 Bobby Eshleman wrote:
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 5f143da7458c..70b902008bd3 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -598,6 +598,13 @@ attribute-sets:
>          type: u32
>          checks:
>            min: 1
> +      -
> +        name: rx-buf-size

rx-page-size, we're modeling device pages.
rx-buf-len exists in ethtool and is something else.

> +	if (info->attrs[NETDEV_A_DMABUF_RX_BUF_SIZE]) {
> +		u32 rx_buf_size = nla_get_u32(info->attrs[NETDEV_A_DMABUF_RX_BUF_SIZE]);
> +
> +		if (!rx_buf_size || !is_power_of_2(rx_buf_size) ||
> +		    rx_buf_size < PAGE_SIZE) {

we should add a check: min: page-size in the Netlink policy?

> +			NL_SET_ERR_MSG_FMT(info->extack,
> +					   "rx_buf_size %u must be a power of 2 >= page size (%lu)",
> +					   rx_buf_size, PAGE_SIZE);

This must point at _ATTR, the _FMT is unnecessary.
-- 
pw-bot: cr
