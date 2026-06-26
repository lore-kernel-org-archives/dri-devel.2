Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0E9CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D225C10E38C;
	Fri, 26 Jun 2026 11:31:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S15SzWps";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C7EB10E38C
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 11:31:43 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso4536875e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782473502; x=1783078302; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3V7IAVFZWmnU0nMqKkIZzyiPJmKtXEMD/AnbFuh2C68=;
 b=S15SzWpsPu5kUb2jAi43TUFYLFzNEchVQQBl+n93z5CYXCwe9nmvaQzNx5GiuacAry
 1skRfVrGauPMjDNXsAroZtdNm7dpogsEE09mdNDR9jXIio1T8zpwbrY+3PqdoM7Ux/Ec
 1PZ+CMLcRhvAR0MjS0yIePk1DlHxge5f/cp437tYUanaVBTvzV2MT+/ldHAvsh7giG2V
 sPa5PXeXw5wd/UrKoohHeGz8PaDC3F77JzmU2JfSCoh73jX42C5oQW+9Ak1cYyhDXoYt
 Op17veah/PYwnGLV4uWUJoBhYTwRluuFnUijV6Dy8n6dBwKxsMeFE/KyxXgHfeMjUmPg
 k5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782473502; x=1783078302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3V7IAVFZWmnU0nMqKkIZzyiPJmKtXEMD/AnbFuh2C68=;
 b=ZuJDWu4trhCteJMcFdanKxex4oX5yOdi7YMMYty/n90ii0Vdd+yCnfb0XWTtueJx2O
 GP6YD1jlGsg4KyQGosz8DP4JKwzCK3qXPrLNFSUpMtyqmDvlKmkruZzxUFE3ywhYe1qp
 BNs9Un1c/zo3J4gW5l0NMGwOdlSiUE3RZNSw6Rlyk2fduazdX6AcIUKezRUHVQFz3gGU
 Luahv1ASaYC3Jvs07F2ZD49DPSASdX4+TmUqjftXGAZRh+ZO3btBGkevoJndCr1ms+6z
 Ynqk1ASLl6WeNrPKBkleZ+GPTDpxjBr0De/+6ugWT4elJhQgIdPKSXhuGxi176QSHhBh
 jcwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LEBmY8FxiGvGfWjEHlGdOp7lUjO5oURknCWIwdFEj9LBcOE122jMWl3WBCpKJXWTDJjWFjLGVkCE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8mrbSF1/KH3rsgCeCeQZw2MDUyyMgvVuTN6qIYPRqq+MlZ55V
 PVJ0k6BcnW2kxjuvUV9IjNNSdkSexw2wtl84aSnuLb69PpRxg0ecz1Vr
X-Gm-Gg: AfdE7ckC6+lJuwJLuiXKctef7LHjfVWfYsP00YQrdJMZePN0ikvnNspHmBzfvRVU7eO
 GuWge6oeAt74ZnCE+elerfh+cDM23N0Cd3Pxh+mxWZm8VRPU5eMrs19mZWov+Hk4u/9kKsZRZu/
 pKQKJGUhmFQWARkLaZ9cMZ/EKiZyVPSyeyOXZw0Yj3rpyUk97x0sPd33hL/2YFCu5j1AXwTt5yB
 4wRmYh3B4llP0fVXRgw/Xisirsmn438ZVTZ1B3IU1z8S4Put6QjyDU4fgBxYTie7tGokPyALksp
 TEzjoOC4RhEHTod0y4L/9HbrwM1+3Dxl/FypDWn2TP4h0BwzSvSb+Sbih9gyDzI2lQsjQxsLtpo
 gTxYDEZCmQtlpcalhK4ps9pgQHeIUZlS58FKzYwuDhSSDutxKFXmW+HGLs6zUFsUwEszWBdaoXp
 2xUzzV2s3ZjeggQ/1gZ3eLgftb23OutX6IYSI+fwZHEP+IjgDIjw==
X-Received: by 2002:a05:600c:3b29:b0:490:e5c1:b8b9 with SMTP id
 5b1f17b1804b1-4926fac56a2mr6382035e9.0.1782473501473; 
 Fri, 26 Jun 2026 04:31:41 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee0189esm25128520f8f.9.2026.06.26.04.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 04:31:41 -0700 (PDT)
Date: Fri, 26 Jun 2026 12:31:39 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Yousef Alhouseen <alhouseenyousef@gmail.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf: udmabuf: avoid list copy size overflow
Message-ID: <20260626123139.7d6ec6ec@pumpkin>
In-Reply-To: <06bddfca-d868-4043-ac6f-28ca103fff02@amd.com>
References: <20260624125242.11232-1-alhouseenyousef@gmail.com>
 <06bddfca-d868-4043-ac6f-28ca103fff02@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 24 Jun 2026 14:58:58 +0200
Christian K=C3=B6nig <christian.koenig@amd.com> wrote:

> On 6/24/26 14:52, Yousef Alhouseen wrote:
> > UDMABUF_CREATE_LIST copies an array whose element count comes from
> > userspace. The count is compared against list_limit, but list_limit is a
> > signed module parameter while the count is u32. =20
>=20
> We should probably just drop the sign from the module parameter instead.

Does anything sanity-check the module parameter?

	David

>=20
> I don't see an use case for negative values here.
>=20
> Regards,
> Christian.
>=20
> >=20
> > If the limit is raised too far or made negative, that comparison no
> > longer bounds the count to a range where sizeof(*list) * count fits in
> > the u32 temporary used for the copy length. A wrapped copy length lets
> > memdup_user() copy fewer entries than udmabuf_create() subsequently
> > walks, leading to out-of-bounds reads from the copied list.
> >=20
> > Take a positive snapshot of the module limit and use memdup_array_user()
> > so the multiplication is checked before copying.
> >=20
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> >  drivers/dma-buf/udmabuf.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> > index bced421c0..b4078ec84 100644
> > --- a/drivers/dma-buf/udmabuf.c
> > +++ b/drivers/dma-buf/udmabuf.c
> > @@ -469,14 +469,15 @@ static long udmabuf_ioctl_create_list(struct file=
 *filp, unsigned long arg)
> >         struct udmabuf_create_list head;
> >         struct udmabuf_create_item *list;
> >         int ret =3D -EINVAL;
> > -       u32 lsize;
> > +       int limit;
> >=20
> >         if (copy_from_user(&head, (void __user *)arg, sizeof(head)))
> >                 return -EFAULT;
> > -       if (head.count > list_limit)
> > +       limit =3D READ_ONCE(list_limit);
> > +       if (!head.count || limit <=3D 0 || head.count > limit)
> >                 return -EINVAL;
> > -       lsize =3D sizeof(struct udmabuf_create_item) * head.count;
> > -       list =3D memdup_user((void __user *)(arg + sizeof(head)), lsize=
);
> > +       list =3D memdup_array_user((void __user *)(arg + sizeof(head)),
> > +                                head.count, sizeof(*list));
> >         if (IS_ERR(list))
> >                 return PTR_ERR(list);
> >=20
> > --
> > 2.54.0
> >  =20
>=20
>=20

