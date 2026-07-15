Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162BAC44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 506AD10EFAE;
	Wed, 15 Jul 2026 18:13:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="N7TXkPN+";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9321D10EFAE
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:13:14 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2ceab75934dso53819555ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 11:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784139194; cv=none;
 d=google.com; s=arc-20260327;
 b=OFmuDVN1x3m4eVSNH/zqk4KpsQwqnn+MlsZbvfmqmKQxyH8zAN8AvOPkb2PMKjP3A0
 yMsxT7jJpkFcblR9ZFhP2tr4fS0pJEfaRyx6vZz6W/PtB6YfaC0LVM34vyzMDJgdp7HG
 fA6+/TskHD5q6Lr+51qv85bHjH+6vOwGUicBvpSH1Zg1luCrrlMnATscpWRqBETQvKVs
 Ye9tS7e1GEKoGbgdcnTGQkg2F5kqdfoBAGwqJZfyqxUEfyTYHEOECjyQLW5kpORiWJ8j
 ygh0ZVGv/hp+8OCDT0A0AYcaD9muUnfCpSnbpr9ujrzcRF3a/Hc2eU/oLu2lQbNAtR7s
 Q+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6lt2EBngzvD4m9jAx7MuFhujRmAqHqzLhBgtSohJdm4=;
 fh=o7Vq3MdcmAgh0Ng2CH5zJFfQuvWtmrXzt0h3wYIlMeU=;
 b=nhN2y/NU4OnzVb7efaZUU9TzbQzxyIWio3H2BcFIBbhIldkXCs34iBwtQX50vZsXFO
 xIbj06JZQK5haliLiS7cAwoF/E1GGRhD9TPPHLswJei2d4Z0K045ebV6xrsvvMR8HcVY
 UjSLlCKY3OgeBftRD9au1/tsMrf+VNnrFbXgQN52KlKiWzz3zyazKkrVYgZ1s9KG67pd
 2FOGWbO9SZ7NCwrPe1r7ejPzJ3eYlnFp+EKDjqfaltUT+66lgaoQxmonFkIG+GR7RfN0
 Kg93Iero9K008h+F1r30Iky3avb4uS+E1mJOWMH4+ON+We+5kQl9y08wzLbWfgFaKAKB
 1hhw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1784139194; x=1784743994;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6lt2EBngzvD4m9jAx7MuFhujRmAqHqzLhBgtSohJdm4=;
 b=N7TXkPN+vWgvDsukWT7TdSPkxFxpFG1yFJAHyBvzG06g8/xHCgngLH1dSREbuDVzN2
 ctEqcvcy7B5WaaQ6VL1EymjMVbH3Pc9P2oH1LB/TOrE9VgAuXp7HxH8rJ+kinuIy3+p+
 cQwIwPykNxJN5XfbGHYAi3ZmNmItjCueXulu3bCJuSlkd0ikAUxqKY1uaPfrhmGo+46t
 dOPXBh465gWmXSkZ5tXgjiosoYFMd9XmYip9Eo7nfwAcOPdExTLwx1mib2yFN0DPj5pR
 6usy/aIOJ7Wj7F1LqU2mnLwc3Uel8mh3ZxlDGXlBOpnYX+/yyf7jnNnbUNXs5+5LQZVw
 uBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784139194; x=1784743994;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6lt2EBngzvD4m9jAx7MuFhujRmAqHqzLhBgtSohJdm4=;
 b=bqIahQBzkFT5uT1GDHQDWdbBWruPMBkaHwsV+Xk/h23RkmCXZ1ADXjv4/k5Rlsc/wC
 8TBOZDPzWlYdXKuTdmGkD3kfRkq+2ZDSSzDkmQQpYeV4VCxoJRkM7qBpHRv/Jkg8xdAY
 z/dWmO3cJIRp7zEbY+l7vH1+ivG9xkM29HQsO8TrgEb3GtDlJFL6P/derBZc2OrL548u
 NcUkARb4TiLhUimWixvLTyk0cWCQuH8fQX4Vb6bxd+fPE7ZFaw8vMb1GjnqjNISox4Fa
 Jfn5BDJMJmfVFLCqfh7n5u7pZPVehGhjutnI4AtakENFAcBgFUXqwR2Yva8vLdkkCEUJ
 M7gg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrCXUH34MxhDjLZd5Ai0TOxv1wI9vzr1kOWHpEfTG2M/ILt8ICKqBtka2Xx/4jWSpb2pONbSEqdBPw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywh5QOMnKbBJ/o6D1DGd9DFz4R/70x+OEw/yv0yKyE0fzZO2E9W
 7b8kcKcz3n8Ms22bOjel1sqUbGUqVNNBs8OtWHL6QgUGLgTinxy+V0RQpe2sEp/Zx4t/iQkctXC
 vyT+e9L1t1Zn8Un59+ppcowxdKHkkskjoGBpz/RkW
X-Gm-Gg: AfdE7ckv9XWr9bnvCH4cN3Vxhwt7nXr3FsDCmm2iKpvUaFgIcjUS+5Nnuv3/OV7xLke
 WxaF7g/ltMjL8Cuge1Nd0XuAmWqpbMX+Y6gDgCJXbJVC2vQUMPwQ8FTYuS3iXdoEz/qWtdtt93W
 yxK8NbmmUDinp3guJ2pMIMnJu2HTgk4bSSdYwATOn7hqUYyRn9vSIA2pqfYM9z9AXEBglYLYq/+
 7t3yCYeFwK7azZc4Eek3J0xVsDwz7b7EQurBd0zIIbtkPXPvB6YLMufRSv8U9VFpd3N5P7X
X-Received: by 2002:a05:6a20:4308:b0:3ba:cd5b:3dc8 with SMTP id
 adf61e73a8af0-3c36c1f1e9dmr3992057637.31.1784139193430; Wed, 15 Jul 2026
 11:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260715174737.15287-1-matt@ozlabs.org>
In-Reply-To: <20260715174737.15287-1-matt@ozlabs.org>
From: David Matlack <dmatlack@google.com>
Date: Wed, 15 Jul 2026 11:12:46 -0700
X-Gm-Features: AUfX_myjzByVJrMRsslJCPDuFhCRYahAX-J5d0Fnwjil213_UwTGXzV50T-Uvqc
Message-ID: <CALzav=fH7N+ionUnELqw5ZaGrPmgp_w6kxoCtoY8fMmZY_S4zw@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] vfio/pci: Add mmap() for DMABUFs
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>, 
 Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jul 15, 2026 at 10:47=E2=80=AFAM Matt Evans <matt@ozlabs.org> wrote=
:

> This is based on v7.2-rc3.
>
> These commits are on GitHub for easier browsing, along with
> "[RFC ONLY] selftests: vfio: Add standalone vfio_dmabuf_mmap_test":
>
> https://github.com/metamev/linux/compare/v7.2-rc3...dev/mev/vfio-dmabuf-m=
map-v5

It'd be great to have this test upstream. I'm happy to review it when
you're ready. Looks like it just needs to be redone to use the VFIO
selftests library and kselftests harness. AI could probably do the
conversion pretty quick :)
