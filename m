Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63548C55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 23:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA37510F0F3;
	Thu, 30 Jul 2026 23:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="XPdyF4t7";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D4010F0F3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 23:43:20 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2ccdf36f63dso58665ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785455000; x=1786059800;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=45rkLKaqdLBM9DjpkbwhGyUvtKXILeitur9eOChkeqI=;
 b=XPdyF4t7YWyCqR5yL4zlEJjV8N2C/l+nGBLtZURolmJX/AeP2OTQuQZdrvAVEqluJs
 ch20DkziyVSDZpQZq2zeln5vvympzIqZA2ckC9d4rQHMBkP6qY86nFsXfwLqGROIeB8s
 YI1nKXSSd2qV11pNz8ZStZHUxvFSRuj5ntUZ/THnW9vMxjL/gK8C1AYV52QFLuW+cgXS
 aUXPJ50vHiRacEP1rjE3jAfjuz3VyRg6e2bs3cw/dmUutiuXuhz5RAY17eJgV4Y0CeF8
 gESZeKxUg2H1oGYrXQTwhXVTX3bJfD60YXZSMhHSfyikQuERN9/ELWoICHiwhSuPFe3Q
 DUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785455000; x=1786059800;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=45rkLKaqdLBM9DjpkbwhGyUvtKXILeitur9eOChkeqI=;
 b=O9hn0LgpM1zPYgn78OH8F9jB8oRPAC5ELBlxXOQDNbYFUNV/cUmS8difCsFcjtlgrW
 glUhbJPiv2UAa/3kLFhpt+jb77nMU0QMt3YZy0kDqYp3AfCRf/XRvTgXIAp5LL/5lCvi
 H2Kg+LbOREsQewYMTGYvcIPEe7DTNNh8SYwE2bF62ble4jrsndALR2yWJwpAfOYx0BlE
 tB71X5NI4I+xboT3Rz2lAoWlMA2N7C+neTDTnHOkhPqEV1UMNREKjiUuTZEvMT1nxcIp
 HmnUQFmUejemWbtXdriMIt5vVL0jIIOlIUMqe2D5wdYi8NrrXoiAz00JIEkf3vcjp8Mf
 x/SA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpstBOOdP1vqgjaq149lZaFYRM03UTfOxz+UmXRyTQG8J2Pi9VasEj18op/AievSr5EC15mWlELMWg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPZczy0AbrGHEoDAXx2h7RfDlfWZhydBybkkOSmEqeSeGsqIs+
 XVHPMCXyl2SjDh+0B33TxPDTtsHfsZTq72grcWxBbmmAiS1bz4VBYIzoqxmzkxvx+A==
X-Gm-Gg: AR+sD11CL3QRwp4FkTMKBhsW1s5aN3V84+zgENcPj2eiclWBbD4pcCdSeVnDGn0POR+
 cnKMz/yQ0+AEFZOlWnPS/0ORgju5IV7OLpCdZkFg7OZZK30xrqjDmc8vAnpirTMyLPxUaTab7Uv
 6e8IkRvfZj3KYaxD98AqeoSM3TjAZWV1yaXMyilaDKosVjEyrmZJJr9iNPLNspunGDj4TI4iHm0
 CUNsWGBfUkBRdKJHdzdfzDW6HXZ+OcSsHwpqzJZJA3fF6/Q6YzaKQn5zbWRI8p+gIeH16Lrop2k
 WVlpznk4mCVxdyqyytnPTf0gEzXDWTquovrE8CdbLmyUsl8P//+bA/9LDxig4L7aUTAYzmxKmao
 C0mUaZQxpA0mRkKMpVws3tERPcywfJMtK1zQkIF6ZAss5zmR8cNpCuvhvqdSovr573+u+Luk/YO
 WZE8aPMEk1jNeBwqVt1/OHrupt6eXSsGFyCPltjqARJyUZ94RgwRaJwVfCXq7aKNpHlq7XNncfF
 4ghPF7SOnMM7LLvTMxoojQ=
X-Received: by 2002:a17:902:f647:b0:2c7:b1e7:501e with SMTP id
 d9443c01a7336-2d043d582c9mr2482505ad.3.1785454999087; 
 Thu, 30 Jul 2026 16:43:19 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com.
 [34.124.168.21]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7271f010sm29587416c88.9.2026.07.30.16.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 16:43:18 -0700 (PDT)
Date: Thu, 30 Jul 2026 23:43:10 +0000
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
Subject: Re: [PATCH v5 9/9] vfio/pci: Permanently revoke a DMABUF on request
Message-ID: <amvhjtQEjAZI0tJl@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-10-matt@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715174737.15287-10-matt@ozlabs.org>
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

On Wed, Jul 15, 2026 at 06:47:32PM +0100, Matt Evans wrote:
> Expand the VFIO DMABUF revocation state to three states:
> Not revoked, temporarily revoked, and permanently revoked.
> 
> The first two are for existing transient revocation, e.g. across a
> function reset, and the DMABUF is put into the last in response to a
> new VFIO feature VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE.
> 
> VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE passes a DMABUF by fd and requests
> that the DMABUF is permanently revoked.  On success, it's guaranteed
> that the buffer can never be imported/attached/mmap()ed in future,
> that dynamic imports have been cleanly detached, and that all mappings
> have been made inaccessible/PTEs zapped.
> 
> This is useful for lifecycle management, to reclaim VFIO PCI BAR
> ranges previously delegated to a subordinate client process: by
> revoking, the driver process can ensure that the loaned resources are
> made inaccessible when the client is deemed "done".  The original
> DMABUF is defunct, and BAR resources can then be safely re-exported
> for use by new clients.
> 
> Refactor the revocation code out of vfio_pci_dma_buf_move() to a
> function common to move and the new feature request path.  Note: this
> now only calls dma_buf_invalidate_mappings()/dma_resv_wait_timeout()
> on the revoke path, whereas vfio_pci_dma_buf_move() originally called
> them for both revoke and (unnecessarily) un-revoke.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
