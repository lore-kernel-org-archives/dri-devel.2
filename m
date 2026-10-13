Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90CDCC6B15
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 23:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AB9810FA31;
	Tue, 13 Oct 2026 23:15:01 +0000 (UTC)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 531FC10FA31
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 23:14:49 +0000 (UTC)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D8C807A024E
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 19:14:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Tue, 13 Oct 2026 19:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1791933286;
 x=1792019686; bh=2DfpwWFq1HOra+MrNUUfPOhw7Qi6lGgc7bfsPMNOQOM=; b=
 rw10vX/3EztxiCLfuAPaQYIqpIQOR8P+AcSB4BcUl7V14lz4tRwDnSJ7JnodaO5r
 mGDDOk8WPjj10H4xxzr7hMCvXrMk/T4k4immzjUjXshPjjZfERoDDmamE/SsPRGM
 fK3tAzpTuxexxoO27IxwBtKb9Q8Z5DLHHYXgXqtJew08YfwGMZW4LNy9zApp+e+p
 OJA+ahQwuJASMmX+3P2g4tk6vNkK1hswUOYHczBfYTaSZwoQRmPtRqCTijI/f6Hu
 KPyrPYHjBcvN1EyeY4MPOUf7gLLaB23xmMycA68ywKPBtk+TyZia1tqkGSVHcCGb
 jqWpQsFHBTeKZewgS6ocOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791933286; x=
 1792019686; bh=2DfpwWFq1HOra+MrNUUfPOhw7Qi6lGgc7bfsPMNOQOM=; b=u
 Gs+/jBZ7hZPKJuAGnY8LVLfwEHA9aJ+94581k1+GmS3gmwfgeDX+Gf9QIEGEgzFo
 XQ5YzbJd30nlrFr5CjBpXCQ0RuwkNgfuQOKBUm/whRlLYzB3Lvl7Hni+wGcagHIn
 t+23a4z+8gZd6izV0xEs5v4fap/IUtIfrPPdtJBMiNmE4QyPk5D+Ry1ThuftF4jL
 CJlhi5vdQ30FXAkVFXs516U7wAH660Oc/rttfLE+0PCIfFcGrtRHPhWK4VjtqDiZ
 V3XlOrV5Lecw7IXlkaaFq9eo3o3kUj4tzGSsYC/t96RbwkFIBtJ7lDAc/ioyhV0K
 s+4jcXkdb2iEVgUmxbMXA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791933286; d=shazbot.org;
 mf=PGFsZXhAc2hhemJvdC5vcmc+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:10ZJaL30BG8f5RDa/4bNFPkIQFM1GfDoeSBNm2NA/k27IM2
 1yx/KBHRk37eHS9/ClJ9UccjzjTpTKcysUGT8IQ7UQUkHcFzhsqfENfQJm7Kzngl
 hzVESDxKGX+kdRKkGyQXOlungpLiFsjGtS6nOnYzgkA9g6zGdoa+XGqAm2AuGoEd
 iLEYd/oL1IwkuqfNuksEKyuffyMJiU+zm9iTntCLggaRrcwvGY1KHA5GsNATy+gb
 LKkZNCJKTJM6xyaaP9/cia+ydvj08VATGfQ9MeZynRJZJ5/3TTYx+OLJULWXc4D6
 xxU/4DuVMd9GRGy+nUGk8wMygkt/3w0vXwq73Sg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:kkU8cm0X3UdsSi7fY2qIUOqaXcxT0ngc1PD+8exrdjc=:eRPoX+cvghqiMrqus0n9Qybh3O85l6XeVOQrj+10NLw=;
X-ME-Sender: <xms:ZbvOapUWIsZr6AOj_Zfzu6erFKgFZ9Rrddg4U-qc-5J0DbXhsdRDSw>
 <xme:ZbvOarOC8hnDZmdJQX8hUDpVx62QilWUPO6Ng4d3gyA968anCZMXkBVwL_SF6j4sy
 7ENNO8NPi41DFQKnFQO-pmW-v13b7YZOOit7IPOoKr3B4zML-w5>
X-ME-Received: <xmr:ZbvOapdddAsoEMwNyAkA6ojg51ws4TwIs_IFtfMPnKtokUA9c7lkz1pgR9zr1g>
X-ME-Proxy-Cause: dmFkZTGh5K968C2Cl84ptSi+4y/RZ/kVjRI/KuhQFT9EdVF+wlBRkUV3+MnA4Bw8USczqh
 K75Ks9fzzqoUpxb7GlBjbnkhjHyFx4/Ig31C73IxKiEP0jiid6Tlem7NohMXSaR+5FMEhK
 ifHB8gtzfUTonlinprF4mw7WPTut7T/J1hPsQXDLSJK0xqaYcZbKfDVq23wYMjW2iywqpO
 ZIPaJ4ce5Zm6PCb9LkghPIarZYc8Qnu+WxwoCZiOXCKojQi16QdbuVc39mEboH71fqwON2
 cQwxZsIGEE5+oDvRemv0bEM6otLHIcNZE8FD2rvXxw3NzcIK91ZKa9ZQuG1p86j7bXidbN
 bTt2lMDWBc72Ycb2zfdXeYr8tOieQM+emlz06TGu4mwTOBMAeH/bYdIObNhlmvQ2NOcZYg
 cNBGBqigPaupTMhTkhD4IQvoWYJDI65SwzwWtAutEgzZaUxZFmZM2BpiWjda7sWrsvqhw5
 lIABPrgE0lVg1eFk7slpb+3GC9Ky2XqeIL2mFEfGwGbrUAA7idIENWnzP9BdjZQsHQANAg
 OlAI8UpCeKEqrMIqXOTeSw2mGhTQO70D9PZIJlMiQKs2t1auwCWngeSkV/diVoEF/CJ3NJ
 ULSmsbW8OmioGjZ9Rk9TYwK3D/Q2NqIexOsljbhnaFsvbSEMAQYIRW+SeQug
X-ME-Proxy: <xmx:ZbvOaiwq52t9HXF6eFHOfjMuIJSTZinnngBmNRUCGkZpzp_CHbwIxA>
 <xmx:ZbvOaigZ23ftU_khOfV2sY_5E0-WRVOj-6qE1INLK2lpQ3r_CFWIbA>
 <xmx:ZbvOan6ZFMQv-gzYsomTliFhUsTlIHdulpOZLmDT1GMrydK3irnLLA>
 <xmx:ZbvOanqfABu8eeghP49yPsMuBtSSHbEyHh4xNHB62iHrK8VvMyzGww>
 <xmx:ZrvOak2eHEpA6LjkO93bVb5sV_XQt-KzJ064oJW3ignpTMxNU8LM3LRs>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 19:14:44 -0400 (EDT)
Date: Tue, 13 Oct 2026 17:13:52 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Kevin Tian <kevin.tian@intel.com>, Pranjal
 Shrivastava <praan@google.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, Alistair
 Popple <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v8 7/9] vfio/pci: Clean up BAR zap and revocation
Message-ID: <20261013171352.1c467040@shazbot.org>
In-Reply-To: <20261006193643.76330-8-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-8-matt@ozlabs.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

On Tue,  6 Oct 2026 20:36:35 +0100
Matt Evans <matt@ozlabs.org> wrote:
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index cb0e4865d110..986852b1d44f 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1337,13 +1338,18 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>  	 * have NoSoftRst-, the reset function can cause the PCI config space
>  	 * reset without restoring the original state (saved locally in
>  	 * 'vdev->pm_save').
> +	 *
> +	 * The zap is done after making the device accessible in D0,
> +	 * because a DMABUF importer could access the device as part
> +	 * of its revocation cleanup.

Nit, s/zap/revoke/

Thanks,
Alex

>  	 */
>  	vfio_pci_set_power_state(vdev, PCI_D0);
>  
> -	vfio_pci_dma_buf_move(vdev, true);
> +	vfio_pci_revoke_bars(vdev);
> +
>  	ret = pci_try_reset_function(vdev->pdev);
>  	if (__vfio_pci_memory_enabled(vdev))
> -		vfio_pci_dma_buf_move(vdev, false);
> +		vfio_pci_unrevoke_bars(vdev);
>  	up_write(&vdev->memory_lock);
>  
>  	return ret;
