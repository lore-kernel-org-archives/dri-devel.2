Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4FFCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 20:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A518A10EA03;
	Wed, 27 May 2026 20:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=shazbot.org header.i=@shazbot.org header.b="RNYOFR4v";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="SYR/FQvF";
	dkim-atps=neutral
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 547BC10EA03
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 20:53:36 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id A26A0EC0077;
 Wed, 27 May 2026 16:53:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 27 May 2026 16:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1779915215;
 x=1780001615; bh=TzsAIWJKWxLMYgzdxaWg1KgQLd4L0BjlB8TYvo0b3Wo=; b=
 RNYOFR4v5bWL/PM5DIyXR4qJ7Z6D92QH4Cy3LppgJ2E10MJO0PuwTaB/1ZS4mPXs
 HCy0NsxoHbYMZFe3VwIxnIk7UalNGjMCyXkVRadKJ/QJRllBlcvLK0US9bDnRRwH
 6klEt3FAKvTL2P4spELYW/PugDCje8LL0Ak2B8lpWgrlMieFy0qqty5mthOK6YVr
 Rhf9Iewhj29R21KaCbpTOdDzjPQiJ0CmO+Rk7JOctajA/BmSBddG/tAdkJT5GGtW
 zBuDNHNOx3392bRIFbVn1Ult5hkbN35Ha4jR+7jPRHGfTjrPROxBLy/cGuNVSNd3
 ViIUKxEjTTS2UcxD0OILWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779915215; x=
 1780001615; bh=TzsAIWJKWxLMYgzdxaWg1KgQLd4L0BjlB8TYvo0b3Wo=; b=S
 YR/FQvFC4ejpPKA5OBsG13goMswKVWLYt6j6dBBPa74VeBdvIyoCVVHp1jCXiqIU
 07UC5auhDx18L36o7Zewh5c80pfPFKlgetlVnNkUbmTCcPGme4t6P2IrLyA3FYl1
 2nYaYTArJB2lHcUyoxswLCD9xVmvtAiYlF2pFMU6So7MkExYpS+C+rzrlorO0HIl
 jBiU6PuyZz+kIvrGRvD213X+hEG3/+Rg7HED7lIYZvRy7Gjz8NdPcJ4wYfnRIUlS
 fw2ts1qxs9BqHIwWUkgLiWw72+YfKObWsWa7EzK6/QVHc3wQUozvmjRXvnBdLVNX
 seAoShWn6kLhUu2+63EhQ==
X-ME-Sender: <xms:z1kXamIPytd-cXsTONJm-Aj97UNRY8erds7YIJI34uyND3oBSi-Z4g>
 <xme:z1kXaltoxOt0GRjv_2UhRNeWXGOr9itEAPa_TWXD4vrODN9l-pRVdYFbvyClNSOc2
 GPZWW5WX3-vmnTuTB94M_xbapRKUN0E3HboovE7EYH_6QzzUvDDZg>
X-ME-Received: <xmr:z1kXamU78RBBOF3LItIWluXvjTR0m2VhE8TZFi-BcVnUEXTlyLXxbu9UCZA>
X-ME-Proxy-Cause: dmFkZTF1K9viltT52o4ie7G6CQKxrNMh36y//trnUnjN2k5DDgIcr7l1e0mhd521pVUDS/
 uUGjEBHMKe4uB8HMHx4OURBWT7vcgWNK/HbH2TS03Hxbg5FeReRt7to9/tAI+ydT7I1l89
 uhh7qF0gDk2T40TaUxMNHZxuF+GSXmiNNkylKLwO+IpzgNQ4v74oMtPuQDE3B0Xiy58k/H
 OdJyMun/gxHDWJd4SGLl8Pb+k54CNl+UmtkuZYH5bsrFwFICfdDCJITm++6BzDRZXY9DKa
 O8KAQIwlIxQ9/B+BwQfavF8kkeajVFD2pGqmPEYauMUdU+iLblknNkg8eCzti1XGaihJVh
 qVoc+YvwS0sBtLpk5V9sfF412d0n5bBVYaDlaUJ5lgZULolELwh4cY5u+BDy6Xjz92ZTQS
 dKE81COvd/li6hW7NzXrkCXp91IpDu7+2BgrEgE3Zh8JU6ezDH5h+sMjmvg/x7QvHfxIne
 lDFoJF/TIt1qrWIKqoxk5000z2TjniOuWIRbKYzld7HeHhtoTa7+acr6e0auCJQRsK+tnW
 Tlu41x61PoLJ2LbQGxryv42A/1+Mnbsx6dlJNiQ5ZutWsX43E5IDzh+73DxHGwzuwVnJLu
 qICs6bhUv4aZw/7QiJNSkhBaWYhcMLlgqC3xyqr3DgShx8Jfvzey4VBaL0zg
X-ME-Proxy: <xmx:z1kXaoJn4vy4awOhNB-9NU295v8QIWTpScmh081UN1PvO8WAuPNszA>
 <xmx:z1kXaj9mjlGWSi9WlnN52HuUcbRJ0U3AjtMA6XsHuhhdoMeuUEryYA>
 <xmx:z1kXauNgGG1dViSVnY4M55iBNlOuBJ70jXTrL4WK4i9NlB3auC950Q>
 <xmx:z1kXan1Orfv6sdp6Dbaq5FokGcKR6AgKbOBN6YPa_wJKAhs29pTzjw>
 <xmx:z1kXag0SGdBPokUwULyB2T-XuxcA1UGmGMn0kcLsKDgBKz-bZMCPSAt_>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 16:53:33 -0400 (EDT)
Date: Wed, 27 May 2026 14:53:32 -0600
From: Alex Williamson <alex@shazbot.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, Christian Konig
 <christian.koenig@amd.com>, Bjorn Helgaas <helgaas@kernel.org>,
 <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>, Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 alex@shazbot.org
Subject: Re: [PATCH v5 1/4] PCI/TPH: expose the enabled TPH requester type
Message-ID: <20260527145332.30412ea4@shazbot.org>
In-Reply-To: <20260526144401.1485788-2-zhipingz@meta.com>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <20260526144401.1485788-2-zhipingz@meta.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 26 May 2026 07:43:53 -0700
Zhiping Zhang <zhipingz@meta.com> wrote:

> Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> requester mode without reaching into pci_dev internals.
> 
> This keeps pci_dev::tph_req_type inside the PCI/TPH code and provides a
> !CONFIG_PCIE_TPH stub for callers.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  drivers/pci/tph.c       | 12 ++++++++++++
>  include/linux/pci-tph.h |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 91145e8d9d95..6c4492075ae9 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -174,6 +174,18 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
>  
> +/**
> + * pcie_tph_enabled_req_type - Return the device's enabled TPH requester type
> + * @pdev: PCI device to query
> + *
> + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EXT_TPH.
> + */
> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> +{
> +	return pdev->tph_req_type;
> +}
> +EXPORT_SYMBOL(pcie_tph_enabled_req_type);
> +
>  /*
>   * Return the size of ST table. If ST table is not in TPH Requester Extended
>   * Capability space, return 0. Otherwise return the ST Table Size + 1.
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index be68cd17f2f8..fe572737b409 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
>  #else
>  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>  					unsigned int index, u16 tag)
> @@ -41,6 +42,7 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  { return -EINVAL; }
> +static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev) { return 0; }

nit, s/0/PCI_TPH_REQ_DISABLE/ for consistency.  Thanks,

Alex


