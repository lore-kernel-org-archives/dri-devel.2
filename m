Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2D8C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 23:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D9BA10E179;
	Thu, 23 Jul 2026 23:58:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MXaR9Jgq";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5371E10E179
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 23:58:18 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2ccf2360620so12455855ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 16:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784851098; x=1785455898; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o9MA5hxyHF+TVODI4Fw4gloLACgAEZ6Zp8N9Sn3aTq8=;
 b=MXaR9JgqHyAwgBgI5uxluPBQTKH+C8X2MUokzS9xVfsgFymPgbXoqJeRxx2jgcV8Tz
 69DjA+PFGVi93Em+mBpTLlB72myx5hqukVAekeH530a7L2XulCqSNVPfRWJ64OWzNcQS
 NWTailxog+Vrjxes3mVM9Od+mb7NyMq5Jins/9k2DpTByIikncR9lUohKA6ozUP6JVa4
 Phaz32Zbj0OXVxibMj2M7VBjPC9YBVgjH3zzdn9zyVbDHjwZ+qA0trmQhlTzZUortxG/
 NcJdnMEgTDFD5LgNjG7JLth2r2ujipOMMyCk7GjCqXEqcaGkdu32YXPUIuI+lvb6+djU
 +9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851098; x=1785455898;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o9MA5hxyHF+TVODI4Fw4gloLACgAEZ6Zp8N9Sn3aTq8=;
 b=V+y20QDFDgnAQQDLPOTG3UflLfVogHaZo4P1kIvuqQrLbVs0VWouG3X708zbxfeI8m
 1eZzsDoHsQ6z1Wf7FOLL1JSAI34PUoOHOAAzWVyNfJexde+qzyA4g5gc39pAJ53SEGBc
 BlVHTFUSADjviypd1x5m96KdjSOaIWoDU84Bei9wPm7n0g7T/0bvuPtTGM3Jyu6hIpKY
 jPgWfaH3MsbrgbVblF0KF35KB/CSVz5UImapCeV284eT6lUoqp//2+2mhhFUEPe/Htsq
 lhoRmnhAzg1Fo20UBq8LNTVAFGtO/0/mrtNsGPZF96+GRZ+CeZqbXX56nuNk3f2BFW/7
 5QkA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpw29HVNkkb3KTwxtzPdsE5RBKd5jJy4L2FLI/6HSqffdBKL1l0O/WgzWSmOKEGRtksLBY0EBRsYyk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQwyxfsoAetPgZ5SIvxZnZWTS8iJglGsshJX3KnXm0n2zcg/yd
 d1aZmEodGzW8yuHsn/ZbsM29mPmbGUgNZxn5aic6xy3woWi7iXdHb5Ay
X-Gm-Gg: AR+sD12Qc52vJ8z+dcudr414RBJ68ENPPGUzNAUb53dWjQgA05kI6SWnUkVSYe8J2Ah
 +xg4oRZRm4/Qy0DvTLP7MLkFM5KdLN4+QgBp2OqFlv8iDo5p2d+XAeNFTfNC1e4r8Aj27pVH01h
 zXqIairGM0dynbpNMmVAaFr6L00ZX0bLxS+EHdLoNKgvUSB5+1AR7zvJMzOUMGMXD6c6wYFvCsN
 3gbrws7X4y+J3yVZyzvG+xv0EuLginmz7XK3eiaoE/KcTOF1I1KjGXsPVMdtYnISNVl0ujIvlB7
 ABsJTS0/aj0T1doXwAN8BwCGvkAzciz4FpFXuYpOa/EnnJeYguY+aOl7mPb+ADefxOUgZyjDBVM
 XNfqzS0mZqtOOpen/Xhfw6oRpt7xdI/vyNJsI1gzItX/BsE5RRrlDO6pzrXYmQ2Cp/AXNvxSPQE
 zOQp/rPul2TeeqkCU7pISLyA==
X-Received: by 2002:a17:903:1b07:b0:2ca:b8fd:f31 with SMTP id
 d9443c01a7336-2cfa6b77a8fmr64729945ad.15.1784851097746; 
 Thu, 23 Jul 2026 16:58:17 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:9::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf8f3131b0sm41548075ad.62.2026.07.23.16.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 16:58:17 -0700 (PDT)
Date: Thu, 23 Jul 2026 16:58:14 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kselftest@vger.kernel.org, sdf@fomichev.me,
 razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
 matttbe@kernel.org, skhawaja@google.com, dw@davidwei.uk,
 Joe Damato <joe@dama.to>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 1/3] net: devmem: allow rx-buf-size >
 PAGE_SIZE per dmabuf binding
Message-ID: <amKqlqgfZipKjrii@devvm29614.prn0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-1-34bf6fac941b@meta.com>
 <20260721110713.325d36ba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721110713.325d36ba@kernel.org>
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

On Tue, Jul 21, 2026 at 11:07:13AM -0700, Jakub Kicinski wrote:
> On Wed, 08 Jul 2026 15:55:04 -0700 Bobby Eshleman wrote:
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > index 5f143da7458c..70b902008bd3 100644
> > --- a/Documentation/netlink/specs/netdev.yaml
> > +++ b/Documentation/netlink/specs/netdev.yaml
> > @@ -598,6 +598,13 @@ attribute-sets:
> >          type: u32
> >          checks:
> >            min: 1
> > +      -
> > +        name: rx-buf-size
> 
> rx-page-size, we're modeling device pages.
> rx-buf-len exists in ethtool and is something else.
> 
> > +	if (info->attrs[NETDEV_A_DMABUF_RX_BUF_SIZE]) {
> > +		u32 rx_buf_size = nla_get_u32(info->attrs[NETDEV_A_DMABUF_RX_BUF_SIZE]);
> > +
> > +		if (!rx_buf_size || !is_power_of_2(rx_buf_size) ||
> > +		    rx_buf_size < PAGE_SIZE) {
> 
> we should add a check: min: page-size in the Netlink policy?

I played around with this adding:

Documentation/netlink/specs/netdev.yaml:
 definitions:
 +  -
 +    type: const
 +    name: page-size
 +    value: 4096  # dummy value, to pass ynl_gen_c.py checks
 +    header: asm/page.h
 +    scope: kernel

Generating:

+static const struct netlink_range_validation
netdev_a_dmabuf_rx_page_size_range = {
+       .min    = PAGE_SIZE,
+       .max    = U32_MAX,
+};
+

... but the dummy 4096 is kind of annoying. ynl_gen_c.py can't know the
value of PAGE_SIZE but needs some value for its arithmetic checks (e.g.,
confirm min < max is true).

Should we stick with using a dummy value, or should we add a patch
teaching ynl_gen_c.py to allow value-less consts (skip the arithmetic
checks)? 

Best,
Bobby

> 
> > +			NL_SET_ERR_MSG_FMT(info->extack,
> > +					   "rx_buf_size %u must be a power of 2 >= page size (%lu)",
> > +					   rx_buf_size, PAGE_SIZE);
> 
> This must point at _ATTR, the _FMT is unnecessary.
> -- 
> pw-bot: cr
