Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92817C531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F057D10F446;
	Fri, 24 Jul 2026 16:39:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bEbcIs5x";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C8D910F438
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 16:39:58 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-845c92bc464so549368b3a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 09:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784911198; x=1785515998; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hhTRsMUDFAKZh60GY3lXmo5DTZVRrbo+NNX8ufmzfOc=;
 b=bEbcIs5xSNF5MqHLcyAqiDuSvPMwdbiZCa8rvsxf5xq//Vfiuiu4TPquWajwybxnOO
 Uw6kvzQmOhIkIANdjV7arOw7Q7sKxqT2+gGqeiqGvTNLqhudzzGw7MmBXYRc+26AuaLO
 2FwOAK0n5X2fdDu42fBoXxi3N+lFQrRebupVRtY3VtkuJiiYaSIaPeu4gk4k8fQXTmCG
 z8y+KUi/cuCTfwEaqU8NfanZm1zfxUI8W1npUlPXkj/eVkkjJRwdEXYhHPNCokC/2YZr
 J7+wx2iG70DoYFY2n2TCTWE7um5xm5XZEGjikZGvkxnV4ddB99At5od0OqTN9r83i4nO
 nyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784911198; x=1785515998;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hhTRsMUDFAKZh60GY3lXmo5DTZVRrbo+NNX8ufmzfOc=;
 b=eYrjgQGjk/JHlMyXic1MBM//GbdfGPjna6ZIWh3wADfuZTCtSNWVEkbq/EqERhZKAC
 gsfYegKTFPRKiGCmJcGTuT/ECf5IFaF/2FwWvE46Vx81wXJBUpDFGoR06f+daE5oerIH
 uKqWIG6qpe0vIv7BeS8lXZb2+otKjwlXttIJfcY+yxjtRbW3zAJ6aeTPQ2b10nB+z1iW
 FqLwyr1pSJp+bWdPOZwv69S+dLfClCfREuv1OErZzKo1+JK9ZVFn50DqkGNgfw8P/akv
 hpXnfgFVQT2zAVEhLXUX1s+HCir6ke4in+v/tnHKXWDtVK+rN7kctuS5TcuUXFatOgy2
 MSIw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrY6XDHqm7WaqMrTruNTPdv4b15ouAg4GZBh/7vbfTOvhcXL6HzveedBqKAyoLv+Nm9nH0HN9tVzQY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcEeJJRc3RjTPzHA4PpsLqPvYIuhOCMfbu49WQ2QmzgLOowX00
 4igEOrUDYdRGew2rBXkM3IIRu7HtqCmvSgDj6Ev5F3jnxTv1dyVoP0BS
X-Gm-Gg: AR+sD10HgCsWl6IkjnMqXFped0zbymFz14xwXwQW3nEe4CCYSOlVemWuBVo5EJHOzN/
 xGZ9iIt8zmynYAd5NMAZ8RP96t4TeisC5xjV1z06mszm9s6zEUQx4aFvrHcO+CMRorW0cyk/ndu
 0oKkYeS0NTQjnA4M0MTUhnYCYU7T0fg+oolGPQrnh6QYtAyth49zKLy6BFIc1rznlWTgaF7Jwsd
 X5TW1hwg0VNMOxbJDd7dOJu67MT5cdNbXAbkZV5N0efT+Soq1MgMM3PczFGE60Q0Vriltd1+81l
 0gIVgGEcS8bk5IFjQMfQAAD0ShSSLGzy+c7iAfDMYqPou87TBVd+Wn8f+g2DGQMp33KDFl9+O9Z
 9FUXOyHejfZFpg/bZENSFf0Ow/RAJjH+ZZH5J5NY+f6qauKjnbL3P3As13v2j8XNOl9o418MLq6
 UFbvdvaGpZhKuk9wsJOOhl6sA=
X-Received: by 2002:a05:6a00:430c:b0:848:47db:a0ac with SMTP id
 d2e1a72fcca58-84e2b8aa987mr8703690b3a.27.1784911197498; 
 Fri, 24 Jul 2026 09:39:57 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:70::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e5341d8f0sm163841b3a.44.2026.07.24.09.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:39:56 -0700 (PDT)
Date: Fri, 24 Jul 2026 09:39:54 -0700
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
Message-ID: <amOVWgJ3BAJ8I/4+@devvm29614.prn0.facebook.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-1-34bf6fac941b@meta.com>
 <20260721110713.325d36ba@kernel.org>
 <amKqlqgfZipKjrii@devvm29614.prn0.facebook.com>
 <20260724072419.62778bbe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724072419.62778bbe@kernel.org>
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

On Fri, Jul 24, 2026 at 07:24:19AM -0700, Jakub Kicinski wrote:
> On Thu, 23 Jul 2026 16:58:14 -0700 Bobby Eshleman wrote:
> > > > +	if (info->attrs[NETDEV_A_DMABUF_RX_BUF_SIZE]) {
> > > > +		u32 rx_buf_size = nla_get_u32(info->attrs[NETDEV_A_DMABUF_RX_BUF_SIZE]);
> > > > +
> > > > +		if (!rx_buf_size || !is_power_of_2(rx_buf_size) ||
> > > > +		    rx_buf_size < PAGE_SIZE) {  
> > > 
> > > we should add a check: min: page-size in the Netlink policy?  
> > 
> > I played around with this adding:
> > 
> > Documentation/netlink/specs/netdev.yaml:
> >  definitions:
> >  +  -
> >  +    type: const
> >  +    name: page-size
> >  +    value: 4096  # dummy value, to pass ynl_gen_c.py checks
> >  +    header: asm/page.h
> >  +    scope: kernel
> > 
> > Generating:
> > 
> > +static const struct netlink_range_validation
> > netdev_a_dmabuf_rx_page_size_range = {
> > +       .min    = PAGE_SIZE,
> > +       .max    = U32_MAX,
> > +};
> > +
> > 
> > ... but the dummy 4096 is kind of annoying. ynl_gen_c.py can't know the
> > value of PAGE_SIZE but needs some value for its arithmetic checks (e.g.,
> > confirm min < max is true).
> > 
> > Should we stick with using a dummy value, or should we add a patch
> > teaching ynl_gen_c.py to allow value-less consts (skip the arithmetic
> > checks)? 
> 
> Let's stick to a dummy one for now, but maybe something obviously dummy
> like 0 ?

0 sounds good to me.

> 
> BTW did you add both min and max checks? Cause the only risk with using
> a dummy value would be that the policy will be rendered inline, and
> inline policy is u16 so 64k wouldn't fit. But your sample above has a
> max of u32_max which forces the out-of-line policy, which is what we
> want.

Yep, u32_max:

+	 name: rx-page-size
...
+        checks:
+          min: page-size
+          max: u32-max

Sorry, probably should have just sent the whole patch instead of
replying hunk-by-hunk.

BTW, how expressive do we want these policies? For example, would
absorbing the power_of_2 check into a policy be valid in the future? or
is that too bespoke?

Best,
Bobby
