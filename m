Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5502B606A322
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EpSwLiwZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE92310E475;
	Mon, 16 Nov 2026 20:50:33 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B63510E475
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 20:50:27 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8b6b22be970so1420424b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 12:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794862227; x=1795467027;
 darn=lists.freedesktop.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=itpoRBF/1k6lXJt+7gBQZf0XsZd0eRgpwFhim4ck9gw=;
 b=EpSwLiwZ8cbl8dQgGW7rzC0lVrOKPUIEHFIVfhaeK4Fq6kdscq9SE480xKTpxlkEd3
 e++ZdjXtmslrAYlathXJD/qEuS1iAambRsOlB5IIW/HsZYbpa2tKd89ItiiPOXRgrC6R
 IHLcP3hH5POl8P/Hd7oU3jEOccZ6fRtXdE89L0gZhaeMyI1MxRUeF4rABxn+h1Kfsrqq
 UPEvR080de3y0j4vA1q16dc5f6AQbg1TId3hjR6SJKRbxUES5PEQAlmi5eB8OfFA3Elv
 WXhm8LDMo8hkpET8/RAbgT0X8HMPNLFsa8t7v2xL28rVyc1kk8Pn38lpX+rpeyhvTB+X
 10Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794862227; x=1795467027;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=itpoRBF/1k6lXJt+7gBQZf0XsZd0eRgpwFhim4ck9gw=;
 b=o3lZL39BZdPc6CQ3xkV5Wzp/MQ+pj57eYn93trRQTsBVkxrzV7uFWLqJmiLI9dJJFw
 3BQikXTetVvHymi5c8b+RQfGSI7/WiusgmS/+qASxS2PZV7YjeBWrpHGm/3DoqE/QjdO
 GqU2FhCplYujRpbtReFrq901wZ0Gnf+okCmJrbPQHLMOmbtXA58OQn1ESeQd1HV5V0HV
 VomOW9/C9cau81WxrRwfbW6gErTaBwQwC9hwh/f62X+FJzvp4Ozrgfu1Lb78Nr50Nf86
 Z5RhWOrhjCxAJjeiwnKneP18MVNOe4GKyDoAZzY/e9KmNCSuA+zCe/5ZvcpRJ7xBxjLF
 5Rpw==
X-Forwarded-Encrypted: i=1;
 AL+hErH/T6KdC23Vv0RvuVDn2nG6hdWc43CQnDwS9Dq+Ocu7i8ZDGAwI8mfNbxD46GweJi7ffnxVFSJaJiM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9f/yy9yG60ITweRWKWLmWYVdb9JtbUEy8Hfr+yaqhvdkA0HGue
 MsT2HBmX+1DiRmGY8OiMer13ZSz/A2J17+2UjSVhX3K9OzI5jCBhqpjabVFAvp1r3w==
X-Gm-Gg: AYBFou3NLJhQVkNrUaXpNbCe3YF0SeV8XWSQl5j6Wz3pBimlmzj+dqmHo1xg6qE3dgk
 AJPEOBPYhR0UKgtbWEJw/pPFPF74jJKdTM37oxhFdBStxFuYR5eT//48y2VIPWlJU57IJWubXMd
 UlGA/592R4B/RrJ/8kdWRZjP2JS3cTwGyOr/073d+Odr0tWBI1T2/fZErsbaKN0M/Gj8REXshoC
 rLMCWXE7NrpFAaj8RXoS9FeuooO5v7GosUh/NNnM7IHruI8BwJzJw5ajUC8LLDMm0VDr4P+EK+n
 rd1QyWSLc6lDi57dgSd/7CqCr9Ax02AJHge8LmD+Nm0XQhhGYY7wbtog1fBieEGka70iRWK8inK
 KOYrwQPvt4nJrSiulDJZPKJVdDaompWVefHJHxGxilOItXv60jmjI8IaHbD7l9UdjkSEBSLfAXz
 h8JepR9oqujdtrbJ+FLXHMk6/LHN9IslIQvwgNPUsKYa9Hrv3g9rac8ljZrQ9/9rqbkrhLt/yuT
 RZTgYmQNiGrEmgL67RCvFGuIiIxWUW/NOTx7pekTPcx04h5lpWTEcKJUJNDJbt5IQ44PhYTCZ/W
 yPVPTJ7Cfe/Hj/sbF77psRscOl3kEU1ey3QcyF9q4/iL3w01yRUTrKlQrUFNnUR3
X-Received: by 2002:a05:6a20:ef03:b0:3e2:4350:1528 with SMTP id
 adf61e73a8af0-3f7a51ba2ffmr9092719637.7.1794862225898; 
 Mon, 16 Nov 2026 12:50:25 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com.
 [34.127.79.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc18c847asm4527944a12.28.2026.11.16.12.50.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 12:50:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 12:50:24 -0800
Message-Id: <DMWXK2VTL3XP.MWW7ZG7Z6HUF@google.com>
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, "Alex Mastro" <amastro@fb.com>,
 <dri-devel@lists.freedesktop.org>, <iommu@lists.linux.dev>,
 <kvm@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Alex
 Williamson" <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Josh Hilke"
 <jrhilke@google.com>, "Kevin Tian" <kevin.tian@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Logan Gunthorpe" <logang@deltatee.com>,
 "Matt Evans" <mattev@meta.com>, "Matt Evans" <matt@ozlabs.org>, "Mina
 Almasry" <almasrymina@google.com>, "Shuah Khan" <shuah@kernel.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, "Vipin Sharma" <vipinsh@google.com>
Subject: Re: [RFC PATCH 0/7] vfio: selftests: Add peer-to-peer DMA selftest
From: "David Matlack" <dmatlack@google.com>
To: "Samiullah Khawaja" <skhawaja@google.com>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261111192411.4133780-1-dmatlack@google.com>
 <avYjFfqr3T/U7lvn@devgpu015.cco6.facebook.com>
 <DMTK99TDM9AM.SAM3Z4COP9WS@google.com>
 <20261115231946.GB1239159@nvidia.com>
 <CALzav=efnA_ABCZVicX0QeTmHknaEbMeWOy8cS+zHYVhm5z+iw@mail.gmail.com>
 <avtI--OIZu5E5sma@google.com>
In-Reply-To: <avtI--OIZu5E5sma@google.com>
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

On Mon Nov 16, 2026 at 10:24 AM PST, Samiullah Khawaja wrote:
> On Mon, Nov 16, 2026 at 10:02:56AM -0800, David Matlack wrote:
>>Looks like GPUs and NVMe can do both as well.
>
> AFAIU the memory BARs for GPUs would need initialization. The internal
> VRAM needs to be exposed (mapped) to the BARs.
>
> Do you think we should have a P2P device "setup" step that can be
> implemented for various types of devices?

Yes, I think we need something like that.

I've been prototyping a new optional op in struct vfio_pci_driver_ops:

  /*
   * Set up a range of device memory, accessible through a BAR,
   * that other devices can target with P2P DMA and that the CPU
   * can access through mem_bar->vaddr.
   */
  int (*mem_bar_setup)(struct vfio_pci_device *device, u64 min_size,
                       struct vfio_pci_mem_bar *mem_bar);

vfio_pci_find_mem_bar() falls back to calling it when the device does
not match any entry in mem_bar_descs[], sanity checks the returned
range, and then runs the existing memory verification on it.
mem_bar_descs[] stays around for devices like pci-testdev that need no
setup.

For NVIDIA GPUs, I had an LLM work on it and the setup was simpler than
I expected, at least on Blackwell. BAR1 comes out of reset in physical
mode, where BAR1 offset N maps directly to VRAM physical address N
without going through the GPU MMU. The LLM confirmed this on by writing
VRAM through BAR1 and reading it back through the BAR0 PRAMIN window
(and vice versa) at offsets from 256MiB up to 178GiB.

The nv_falcon implementation only has to:

  - Wait for FSP to finish booting, which takes a few seconds after the
    reset VFIO does when the device is opened.
  - Make sure BAR1 is in physical mode.
  - Return the range of BAR1 that maps VRAM (the size comes from
    NV_USABLE_FB_SIZE_IN_MB), staying clear of firmware reservations at
    either end.

With that the P2P test passes with a ConnectX-7 (mlx5 driver) as the
initiator and B200 VRAM as the target.

A couple of open questions:

 1. The prototype allows .mem_bar_setup() to be called before .init().
    That is enough for GPUs, but as Jason described, mlx5 device memory
    has to be allocated from firmware, which needs the command interface
    and therefore init(). Supporting mlx5 as a target would mean running
    .mem_bar_setup() after .init().

 2. nv_falcon does not support Falcon DMA on Blackwell yet, so a B200
    can only be a target for now. That requires a driver to be able to
    probe a device that cannot do memcpy. I am not sure I want to go
    down that road.
