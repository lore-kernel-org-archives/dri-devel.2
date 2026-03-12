Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB56106FD9E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B122010EB1F;
	Fri, 13 Mar 2026 08:25:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KDIX9vSc";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C3610EAA5
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 18:45:10 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c7382731edfso907076a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 11:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773341110; x=1773945910; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sFJtbHiIPHYN7z4aj/uef3SDbnRhOt2FSyOQIkrlI8Q=;
 b=KDIX9vSchIKE7OgEkKgNRB1vVoCKnNQw1LAxPGDN8vJUL/FrgiWx49jvhrCA4B0e9P
 bO3ahdfMlxPiQyRwJbz+NlpJmmSielKv+vUjbLntId5raBb2Tain7m64vS1s/gQFgsCd
 QFX4zJF77pw4m2jQdjFsD+zVbTpmFsyE/sLtYIIYykVK36/jESK8dKoLT6I0631erIkN
 D7RCtF1Nng9ivjfDuJNlyYKaP0Oc1GoKi25JrlAYHkfS9Sm0lX4ECYy4il+EdC+PXJ+d
 uaNfeDF/pp6N71PFuGO84F+/U8Y8z4j9OPtUcCs4Vr3OSlpoEKNoTLHAqwi5jdNyXu8w
 hZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773341110; x=1773945910;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFJtbHiIPHYN7z4aj/uef3SDbnRhOt2FSyOQIkrlI8Q=;
 b=eBW1n6ZDJaw3BdTAQ2BJCg4TscX+twLOwjsUQsqFgwbe5RdiLdLAn/NHXXmW8ib01L
 5v3AmH4yKJXOg75MJuQ3Bz3YHJOGnuSrFTJThE5758KxH/EpeRZR9umgdYlfhsIiRIYN
 x1m+mQbr18eBXiJfpfsmHyVs6qcwZdTHjD1aSnZTWNQYS+TP0gXPbCGnv8iPR4ProG7o
 Hi60pH5LZIGp9ZMYdzlbaL+EIa738/4Oj9xWNf2j3bIlzb0CjCfC/+z1GmQHbbKfT0sO
 97PYxi0fvaDLN3XId4ha6EQ0K5dNXZQt4mlElKr/1qOlECds95MWbtACM+umAS3Tp/T+
 9eiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP0Slb+GIcRCLEoO2a+neOxiiS+iS6I2zo7YY7PSfxhZ3Atpo5ZsRQNW9DvNApNEfs6GyKHeq/kpE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtitQ14ljRDvRR+/Kt944yQ3tP8ugKQPUqkjA8ZSYVmEGE+wCu
 gh+GsOpLklGw2fwPH35YpjSP2+E1ZdB7FmdRsSJiiJJ32wP8fTBk0xux
X-Gm-Gg: ATEYQzx+rRl6S6RWG0KNTRyL5EPYTPiVzqLIberN7aCRtt91pBIIpsqafbHkT0Hmdb8
 C64JpeX6KguMtAGnLN5TBbMe1zwNr3g58+1R+PHU9NoR3dsdt61H1qFLukEvfTWLo2IzGD0ZqUK
 ym0WCgUQuOYYRcmM5mBJVSfkLC5DkxWrytGLbbueRt4gj0oYr0nG0sdnfa4oilASy1CwZP6d39S
 CWt/0Jfi2GAoQejVeH6mgzQ3g0gm+v94uho1SLF39T5oPvps5DumdCR7dL9YeYrmkj2yzFUHDDD
 XcmP07oTzB/5yklxyhsUiuUfqJHmUWwLHN+UduECKiXedbnI+9MBn0VSYRALqrETSzJNn51a7WY
 QQOj6EaJuVr9D71k8+rOmJA2LNxRLwgNNKvGW9RrlrqowzK/ZY9Q6SYtmfc+myuU1FR1kNZMZXf
 tZsFD97qQnmRY6pBbX0+81oRIoJ0FI1pdB0pTrh9J0cCZj7+/SbUt2/VPQs1Z0
X-Received: by 2002:a17:902:d58e:b0:2ae:4732:2859 with SMTP id
 d9443c01a7336-2aeca9bb13dmr4301835ad.3.1773341109758; 
 Thu, 12 Mar 2026 11:45:09 -0700 (PDT)
Received: from eric-acer (36-225-72-126.dynamic-ip.hinet.net. [36.225.72.126])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae34cc49sm64519825ad.52.2026.03.12.11.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 11:45:09 -0700 (PDT)
Date: Fri, 13 Mar 2026 02:45:05 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Gary Guo <gary@garyguo.net>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] gpu: nova: rename drivers to use kebab-case convention
Message-ID: <abMJsUpvcUrITCVi@eric-acer>
References: <20260310062443.2763230-1-yphbchou0911@gmail.com>
 <99af9d88-05a0-4dcd-85f4-9d5fe9ee6744@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99af9d88-05a0-4dcd-85f4-9d5fe9ee6744@nvidia.com>
X-Mailman-Approved-At: Fri, 13 Mar 2026 08:25:02 +0000
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

Hi John,

On Tue, Mar 10, 2026 at 06:34:51PM -0700, John Hubbard wrote:
> On 3/9/26 11:24 PM, Cheng-Yang Chou wrote:
> > -    name: c"nova",
> > +    name: c"nova-drm",
> >      desc: c"Nvidia Graphics",
> 
> hmm, as long as we are fooling around with names here, I see that
> this should be "NVIDIA Graphics and Compute", really.
> 
> Obviously that can be done separately, though.

Ok.

> 
> >  };
> >  
> > -const NOVA_CORE_MODULE_NAME: &CStr = c"NovaCore";
> > +const NOVA_CORE_MODULE_NAME: &CStr = c"nova-core";
> >  const AUXILIARY_NAME: &CStr = c"nova-drm";
> >  
> >  kernel::auxiliary_device_table!(
> > diff --git a/drivers/gpu/drm/nova/nova.rs b/drivers/gpu/drm/nova/nova.rs
> > index 8893e58ee0db..1fd454c7e0df 100644
> > --- a/drivers/gpu/drm/nova/nova.rs
> > +++ b/drivers/gpu/drm/nova/nova.rs
> > @@ -10,7 +10,7 @@
> >  
> >  kernel::module_auxiliary_driver! {
> >      type: NovaDriver,
> > -    name: "Nova",
> > +    name: "nova-drm",
> 
> Well, but now it is out of sync with the file name: nova.rs.
> 
> You should change both, or neither, I'm thinking.

I think renaming the file to nova_drm.rs would better reflect the
driver's identity now that the module name is nova-drm, making it easier
for readers to associate the source file with the driver.

Would that work for you?

-- 
Thanks,
Cheng-Yang
