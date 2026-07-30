Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2156C55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 23:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F2C810E112;
	Thu, 30 Jul 2026 23:33:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ongFUhSb";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 633A310E112
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 23:33:19 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cede6375caso43115ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785454399; x=1786059199;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dg+/alpKqQYpNCx1oouhanYFhK3x1/3K8PlW/VCS3GE=;
 b=ongFUhSb09N9QAJCl4/7LGTqbeLd5bHua5HkMd0U0x6nYiIk0wjEqa4k5F+JzR6O0u
 E433aK95PNLO34zGJIcALlt8jxn37a1kn9tqy9BJGHUHXH3Z3Xjr++Srp8ghj32UsmQP
 v06TUpyo3jbu+tVCEvhhNZEED+FUtYu0gCmQDWO8ijwPYA/LC/7EZYjSibThQI1rrgQr
 bJsl7jwrYaBQ3aWis9Kr+9xaHAWNmbSFnO54pzmu8K0yPShXfubt5hCzIvQi+y8IOxlv
 9WlyI+uZca4RatNXks30gm5W9KzDmxu6gK/jPCydx+qp6yLpUJrHtatuZWJ8sZrsbkzH
 3+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785454399; x=1786059199;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dg+/alpKqQYpNCx1oouhanYFhK3x1/3K8PlW/VCS3GE=;
 b=Sgjvs/Yz4hdefHEyVRwm4O46OW4hrlt3o6AeMcI2oGDxfO9qn/kOnPvuExX9G0TjwH
 ivLwyvoB5uux4sTz3K5DE+LGV47aq14baPamrZAr4TU1T2KsmuH3m8QD2qMxxJZdu6DY
 8QRp5Fg14/ie+iL8LnSeHD3RII0aKWdDNdcDqZbqd2yKJLqn4GkumMou51ge1CWX4njm
 TQ19/lBrEYK4/0XwUS1Pr9LVPT4n5JdbScnMF8eI/dKOR7KMVFbsTCvhApffnbDdFzpR
 CkCf6kz0PiSPgbeRaEKj/Uj6o/NAVThfYoaO5LyUxQWhy36DWO5hQEnqzlYEsODBNZjm
 t5rw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+pSULkXFBoXgPmdvwAfDZkMNZif2D30ckjHoaaDKNWXzkI2G3tsQFxqvo1GPha88ng579D9VtHEY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxuX6eoMNIPym3eNninIyaE6VtljfBhFAbare3MqvuQX9WagpfU
 c0DFVbibjqFecqXpjAH+bFhZjdTW0iClu0IKZCTZD9t9nlknHjJtskrncicPNqZ7jg==
X-Gm-Gg: AR+sD104iVt7s3T5lyif4mZTZPCBhtsA7ErWBozB3lh1iqBDh8DbNT5ZS7cKxHx1moN
 VtF8Q/tjMimA26sPCQKDwRluDXAc3nqL6FMGvZAEhaO01HeD7zt02vZ4mX1jzK3y2FC/qXdh6cI
 UeU/ynwxq14vgxTLG6YiZa9OpMwNJNZhLMTg9g55vtZiniCydG6L/kezhMK014rDwF4/EH98lTp
 PceYRZ82YX0OzWu+aTHMxqVdUX/rqNkAgNV/v/x7wCCD36hj+spDVhnpa0W0yP5v6iFlstSenz7
 7GXESxtLvYvQzAu/i1qdKsD23OJS5A1Spbi55OvNI0LuoXsNbCT2ym+Fd6lrDWNCCB9gfd6SA0o
 TBv3gGvRZU/G5+ecYlD5k0UVoe0oTXbO4jl4SQeFwx3rUihddX+KOf/OWP1RmZaubDOtln/aQUQ
 3A2hDUwpUabygWZGrxdQ4YxteS3T+Vhr8nK8E5XqLvVjNFI5IdoiLONT4qmVijBFPHqTKSERStJ
 hAW7d0gs4BhgUChPA5gvac=
X-Received: by 2002:a17:902:f2d1:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2d041127ae9mr3387895ad.2.1785454398363; 
 Thu, 30 Jul 2026 16:33:18 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com.
 [34.124.168.21]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e72643a12sm39399784c88.5.2026.07.30.16.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 16:33:17 -0700 (PDT)
Date: Thu, 30 Jul 2026 23:33:10 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 8/9] vfio/pci: Support mmap() of a VFIO DMABUF
Message-ID: <amvfNhagavtGqZ-W@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-9-matt@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715174737.15287-9-matt@ozlabs.org>
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

On Wed, Jul 15, 2026 at 06:47:31PM +0100, Matt Evans wrote:
> A VFIO DMABUF can export a subset of a BAR to userspace by fd; add
> support for mmap() of this fd.  This provides another route for a
> process to map BARs, in which the process can only map a specific
> subset of a BAR represented by the exported DMABUF.
> 
> mmap() support enables userspace driver designs that safely delegate
> access to BAR sub-ranges to other client processes by sharing a DMABUF
> fd, without having to share the (omnipotent) VFIO device fd with them.
> 
> Since the main VFIO BAR mmap() is now DMABUF-aware, the new mmap() reuses
> the existing vm_ops.
> 
> The lifecycle of an exported DMABUF remains decoupled from that of the
> device fd it came from, i.e. the device fd could be closed with DMABUF
> VMAs present, meaning a fault on a VMA could happen concurrently with
> vfio_pci_dma_buf_cleanup().
> 
> To deal with this scenario, the fault handler now temporarily takes a
> VFIO device registration to ensure the vdev remains valid, and then
> vdev->memory_lock can be taken on it.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Nice note on locking, enjoyed the lock dance!

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
