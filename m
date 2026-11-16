Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18E1606A33D
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n9LaP2nI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3072510E447;
	Mon, 16 Nov 2026 18:03:31 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E3110E447
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 18:03:25 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c4d427836e9so499835566b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:03:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794852204; cv=none;
 d=google.com; s=arc-20260327;
 b=fDVG1K+ejIlk15qfPWmGer6FalC6eXsi9ebODIcHGQ6uHmDlFQO/s8ELOZuacnxxpu
 KxU4T8G1rujnmnme/eduoXG4z/5ZCkBdFEXPT5eLWUcPoLtc42UUNtWRxfo5PeALtNd/
 aSjchUno9r19G8+s561aNzfr2jO6mxC36y1rNhB0AwewLF7GEBgrgLRkmEyIUweWZj7n
 9cC366qniL4hyI8yj0mjp5KHghu2nRVjtVev2StVN4bn3ugEjdpo2VFp7o3qQwQGMnjl
 enBh1R6WNQbNneBA4E7pqPskH9NQ3M393QXUUrWxcBkidCUs5pQ6MEYAW/BLIBgSs6qE
 IjuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UsEi7nj+gIWpohML70hey3/GRg+ovwcWW0/uBKwbaX0=;
 fh=UwGKJdq4dupUukV8uN7sTzaFHGySaObqHsV6fFwPex4=;
 b=B35CLKDr2MUgsnlu73eqGN/b+bodEWna9BfDpRW3ZlplO0WFEccFWpquf6+e5jgVsr
 u6po+pAMnHPzTCSZqEINTOmcmrsclFx8pYqek4A3bkCFJ5ABaR9eeg5xJYJlxzkvzyJ4
 ZvPCgckmuCa+Gy6KsKWSrojMkd98q/8xKCAN/J2nOAXcK5pBOJdfh8y1Jw58y8TNIQwG
 ROrXn0nJyLQEHX98xEQO0OOHocEB6CdN5jlMt1apCqVJYncNtLjCLlAca3QnrRRypLht
 2LTxYEoGwcwahKDdorAMSE+HhOw6BPtV6mIplS6U5VSAX6Oc3TJtT30pvea8Jal/9B/8
 c+gw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794852204; x=1795457004;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UsEi7nj+gIWpohML70hey3/GRg+ovwcWW0/uBKwbaX0=;
 b=n9LaP2nIWtV1JlwObq2Qn3x5SaQLad0y5f8o/zf5g7npZ994yVAaE9pLjKCBlfADTk
 VqzKWkYyOGMF9SyDYZYqHdZEG39Gbo0KsBxhsMxm/tQgTt0sx2b/GhhMSewODHbPEolQ
 uURpfO1lSKQf41ZNCDxmmZbxXyuORVmv9RUed+z2qhsoYnm3jK13CP4hvj7EZguSPs8K
 jmGCHRGOITAvWBbGTk3m4vM4aSj63mTzSWnWnMyq+y5ySdu8ksXud2lQ2Ew/s6FpmIwI
 Eapa0tm6ZNJaYSFHZjAKPYN4LaKeNbaRdOYez/mlOwvgX0Uy9VKgaE8vjhu0LaKCEf0B
 YQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794852204; x=1795457004;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UsEi7nj+gIWpohML70hey3/GRg+ovwcWW0/uBKwbaX0=;
 b=XYYse10hs0wsLPQET6LwoyKoRs1Gc8gvem30yfqNvbod+o24aiU2xDz9LsbHo9UL4H
 1Dzsr9PhiYCvZaBV8yGQuWl27onKc1Ch4GbjsnM3sJQ8XjEal9YZXtWg3GxXtvs9CtVr
 4qbEktuHCOGjZVuBqP+Mmc01kcX9IS6Ie9unwkX/o2MRy0Jly2dfCHG+S9+F1xwEJJkM
 rBz+kzIwsj3rZAEPMXx6Fh8SZfsiJHryN9CZxTDls8YDFQIjG8UNts8fRXTTWe8l/vtA
 Zpb8+ykVD8YdKZg3XE5x8JnCtjSQWJKqKMneO0kexLjZxizoS6BNKJcjpsZ8VJxKKsoz
 VgGg==
X-Forwarded-Encrypted: i=1;
 AL+hErGw3de1GKGuIGEdFGbKhIO3E4WRs/IYIzb2HcV9ZS1IMEh6otTYpzPhHhmUh3vOT5dRk1wwlR/YHhk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z95y+Lr2sP4mzXrnTNec0D/nBRGfyNWHiuF8vL7gcTWRHDQsBDG
 POTKYf8H09jY8MatSIG6YFJ3C8F+W0CmwACWz8f+MMUoM6yzujTCPItgZUXqBRHdBnDp59mH0Km
 yCMUIGZRUKzHsPdiYp3LHaU8pLx+SE9iwJPAu4UZq
X-Gm-Gg: AYBFou1GxuEsKenww02KOuUfu4kNWSbgM+DyFqfN7XN6LbV49A26kex4iCGlKCQl4uR
 v7GG8GySsq4/pCYVY6Cfjej6cpdzcn8RM+ce1x3Cutt6Y0DWpBv62N2UJR7gSed/I7TskhexRck
 uLTRWs63oKmolAx5VJNUn5ZQFBnHYagg7BA6dXJVTK2cPCnBMKjdKXLMc5tQW+Dil1huoWtFZr8
 YLeIOSroa1w7NUakELUP33hxOaP9aPcvYJu/vRuWBsYqWEXPubyG30+zKu04ziILpNNgsMrjmzY
 9uGKITZgJw+imB959wgZDjuryXSdJxuvDb5DFasOaykDxWJxOEG95GOxokxBpOHZdaRU9AaqVT6
 PCiFP/qafbP3SUXy+xD/PBK9Rn5XHWVofcyAr1LUNCC7NQUbhGumzerpZOOY=
X-Received: by 2002:a17:907:ea92:b0:c49:cdc8:10cf with SMTP id
 a640c23a62f3a-c50963df2ccmr868161066b.40.1794852203026; Mon, 16 Nov 2026
 10:03:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111192411.4133780-1-dmatlack@google.com>
 <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
 <DMTK99TDM9AM.SAM3Z4COP9WS@google.com> <20261115231946.GB1239159@nvidia.com>
In-Reply-To: <20261115231946.GB1239159@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Nov 2026 10:02:56 -0800
X-Gm-Features: AclHuK98Rk-099iLtslJwrWtAxHkQR-ncmpykOH17KTcOCuNGBfykDUUL8uCEbE
Message-ID: <CALzav=efnA_ABCZVicX0QeTmHknaEbMeWOy8cS+zHYVhm5z+iw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Mastro <amastro@fb.com>, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
 Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Matt Evans <mattev@meta.com>, 
 Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>, 
 Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 3:19=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Nov 12, 2026 at 01:47:03PM -0800, David Matlack wrote:
> > On Thu Nov 12, 2026 at 12:35 PM PST, Alex Mastro wrote:
> > > Hey David,
> > >
> > > On Wed, Nov 11, 2026 at 07:24:04PM +0000, David Matlack wrote:
> > >
> > >>     Is requiring userspace to re-issue IOMMU_IOAS_MAP_FILE the expec=
ted
> > >>     uAPI behavior?
>
> Yes. Even if we wanted to the locking is doesn't allow trying to do it
> automatically.
>
> > The way I designed the P2P selftest support requires 2 things:
> >
> >  (A) initiator: A device that has a VFIO selftests driver.
> >  (B) target: A device that can provide a memory BAR (vfio_pci_find_mem_=
bar()).
> >
> > So far I haven't found a single device that can do both. But you are
> > right that theoretically a single device could satisfy both
> > requirements.
>
> mlx5 can do both

Looks like GPUs and NVMe can do both as well.

How would we implement vfio_pci_find_mem_bar() for mlx5? BTW for the
target device, by "a memory BAR" I meant "a region of a memory BAR
that behaves like normal RAM". Sorry that was not clear.
