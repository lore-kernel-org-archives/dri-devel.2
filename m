Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507CCCDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F2C10E9E3;
	Tue, 23 Jun 2026 08:25:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZkQLfsZ0";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FEE610E9E3
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 08:25:05 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-490c0c92cffso36598345e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 01:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782203103; x=1782807903; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqWt0bI44jas3c/HR//JGgX6WMjaPFSRIYH+iY3eOF4=;
 b=ZkQLfsZ0abQzxhJ/FkRb8Qhc0UT19VMJfSP2ho8s2QtyVh1rpvGNxUY+Ym4EGjflOU
 dNXfEDHKTMMNZQPiYd2xjBXhEQYKxOd87BxkyqYkqvKQfLZNYIRTE7PsVGo08hiL8sq1
 vi+UIodFP6hiJ6UOhG4S3RyqOOiF8nG8DMZffVh42rk4+AYOxMfrIOVEB1J9pEXnS0jf
 LsPFVfOuOx6kRpQJHIrUjM2jA5EXH/d4Ip3wCm3AkVeIjX3vZxBMZY39U+iXS7IHVcMO
 wXtJ8wyNDMYmdL8t8+HeMXED+qfcubE1T/Du76stv0MlOALHvRGx/DKI5KuF+CMw/Vvy
 A4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782203103; x=1782807903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XqWt0bI44jas3c/HR//JGgX6WMjaPFSRIYH+iY3eOF4=;
 b=pG6Em/E5vdysBFHFPa7jA/++Sr14bUc32IT5zM4p11MKfTAuOaxiozBf/WEUN7RtaQ
 eBbK+z13TmHXT3UpKNnN8h6nm/6uV0i4WvJjAm+4XOY2wuxu6pO6Kf32bgb4Hfic1DxH
 9CRDhxx7c3nkJ7k9SIvacGggA3tGdHbkyv51NxQohC9ArAAI0Tryt/+czm8wwHgnKi1Y
 OJjQbJv5ffZhbSLWqDLrb8iJAb+Ns2L6wCVPtEQOYmwR18bidO3tsn76DKEbTuF82AJl
 3qNq/JvyIm9AI4VV1eFJZRhqYP+RphBxoL7rpBuo9IjtKzyeksBqWH0ErLcENiKBErUw
 t1zQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zg3RbsxDHTuljNSSM3R8wEFTBpTuQA63wzC7szg95oDGtbQjS0Eod9lbzGyzBKAhwHVRWW/oRl3k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjkP/3OSNNvB1BBI5gEi4GnXFhZt0CcCw1wpVvL7D+dLUmudEm
 I2TsLFT/cABO8yivG9/g0zYjfztZs5QnN0sVMzqL4S7/p3c5sKcTQAC6
X-Gm-Gg: AfdE7ckXXPf2GPMhWJ9vMEG59xbhlooJK/72QLiHGQAERbRslyp3XGPIblmHCw/0edC
 9uX8cElnph20KvqJUlXwcFPz4bUi+Cy5FS0hibqZJ+17LxCq9wDkARtWMcRkG80/PHK1+lNAL1n
 69E+o9jQ8+6NrABaHJ57FxOYuzBT3xhFgwoHYDGqPD8l90tmbJpeRSxHHIRbvp4pw08c6GwpWjq
 qNQLuzepERZ/pt+9i117Kwx+RE6/cXSGW8y0N1A8lXAaOTCkAvC+O6ARwjVkuxU4m/K7vQqcJ7J
 Tnr8vleqwg4Pc+rlpls52Ohzk9QpfqKrRqh1LxELTrabspcji5uaPxcoDvtC3QxxlruiupXGIzt
 nHMqE/hvdw4U7PAilZtn154N2VJk5JNCgVjgeL06FxDZNA9rvV7SPbjYFpDdZ5NEom1kPazmOnL
 lBkTHuzfONLsw/DkqE+iRbZ43AmYV/4MhxuExSKqRQVUMrBaHMNA==
X-Received: by 2002:a05:600c:348f:b0:492:4636:87ae with SMTP id
 5b1f17b1804b1-492463687d1mr271367215e9.17.1782203103276; 
 Tue, 23 Jun 2026 01:25:03 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4924923c862sm262149435e9.7.2026.06.23.01.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 01:25:02 -0700 (PDT)
Date: Tue, 23 Jun 2026 09:25:01 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Hu <xuehaohu@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen
 <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Kevin Tian
 <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com,
 praan@google.com, kpberry@google.com, sashiko-bot <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH] dma-buf: Split sgl by largest page-aligned chunk
Message-ID: <20260623092501.17bef195@pumpkin>
In-Reply-To: <CAPd9Lg9+d=Rw4230FdcMFd0VYfyhXhD=eju53iURR8c61iXsWw@mail.gmail.com>
References: <20260621222130.1667453-1-xuehaohu@google.com>
 <20260622091344.794e0d74@pumpkin>
 <CAPd9Lg9+d=Rw4230FdcMFd0VYfyhXhD=eju53iURR8c61iXsWw@mail.gmail.com>
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

On Mon, 22 Jun 2026 17:26:10 -0400
David Hu <xuehaohu@google.com> wrote:

> On Mon, Jun 22, 2026 at 4:13=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> > =20
>=20
> Hi David,
>=20
> Thank you for your review. You raised many good points regarding
> optimizations here. I'll switch to using 2G as the max entry size
> (`SZ_2G` from `linux/sizes.h`), and remove divisions and
> multiplications. I'll also replace the `for()` loop with `while
> (length)`, and drop `min_t()` in favor of `min()` by casting `SZ_2G`
> to `size_t`.

You shouldn't need a cast at all.

	David L.

> I'll send out a v2 with these changes shortly.
>=20
> Thanks,
> David
