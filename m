Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62239C53200
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9738810F3DE;
	Fri, 24 Jul 2026 14:24:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lkjGVVSx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C41610F3DE
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 14:24:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E656600B0;
 Fri, 24 Jul 2026 14:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7341F000E9;
 Fri, 24 Jul 2026 14:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784903061;
 bh=qVSKDC8t6hmFB8d5DchFcQsD5mrGgiBdRFoTRem4F7Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=lkjGVVSxy6IrXFoXa03Qc5UwKMemlqWxJ6ZPceECyfTcXzQItRF1XlPzBRA5nYTvl
 iUW8wEAy5VCEYzUbl2aLzXuuKIhM2meRLuK//wd/koBq2qLW7/8XkGmBRBLnKyqzFe
 2BTpcGi5T6qt9fRPdQXkpnvPp+H/vZJChl8pBerTc6O7MOclrjZm3kphetNpFKidTu
 sK+cfBP/XGEayroxUzcEBT63urFbsAWhOBcoIP6KchBQY3ch8GcYgwctpMMkOiTH9o
 ET2PImBCKiAiVNXbBU+AvuC3EIdMjD5Otn8DXC5fqpZR9zV5wh6kfPr3MoK8NT9YbL
 FMKd0/Iw1zC7A==
Date: Fri, 24 Jul 2026 07:24:19 -0700
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
Message-ID: <20260724072419.62778bbe@kernel.org>
In-Reply-To: <amKqlqgfZipKjrii@devvm29614.prn0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-1-34bf6fac941b@meta.com>
 <20260721110713.325d36ba@kernel.org>
 <amKqlqgfZipKjrii@devvm29614.prn0.facebook.com>
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

On Thu, 23 Jul 2026 16:58:14 -0700 Bobby Eshleman wrote:
> > > +	if (info->attrs[NETDEV_A_DMABUF_RX_BUF_SIZE]) {
> > > +		u32 rx_buf_size = nla_get_u32(info->attrs[NETDEV_A_DMABUF_RX_BUF_SIZE]);
> > > +
> > > +		if (!rx_buf_size || !is_power_of_2(rx_buf_size) ||
> > > +		    rx_buf_size < PAGE_SIZE) {  
> > 
> > we should add a check: min: page-size in the Netlink policy?  
> 
> I played around with this adding:
> 
> Documentation/netlink/specs/netdev.yaml:
>  definitions:
>  +  -
>  +    type: const
>  +    name: page-size
>  +    value: 4096  # dummy value, to pass ynl_gen_c.py checks
>  +    header: asm/page.h
>  +    scope: kernel
> 
> Generating:
> 
> +static const struct netlink_range_validation
> netdev_a_dmabuf_rx_page_size_range = {
> +       .min    = PAGE_SIZE,
> +       .max    = U32_MAX,
> +};
> +
> 
> ... but the dummy 4096 is kind of annoying. ynl_gen_c.py can't know the
> value of PAGE_SIZE but needs some value for its arithmetic checks (e.g.,
> confirm min < max is true).
> 
> Should we stick with using a dummy value, or should we add a patch
> teaching ynl_gen_c.py to allow value-less consts (skip the arithmetic
> checks)? 

Let's stick to a dummy one for now, but maybe something obviously dummy
like 0 ?

BTW did you add both min and max checks? Cause the only risk with using
a dummy value would be that the policy will be rendered inline, and
inline policy is u16 so 64k wouldn't fit. But your sample above has a
max of u32_max which forces the out-of-line policy, which is what we
want.
