Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3E9CC6B15
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 23:15:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F101010FA37;
	Tue, 13 Oct 2026 23:14:54 +0000 (UTC)
Received: from fout-b7-smtp.messagingengine.com
 (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1BB610FA2F
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 23:14:43 +0000 (UTC)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id 659D61D00227
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 19:14:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Tue, 13 Oct 2026 19:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1791933280;
 x=1792019680; bh=BfT8I+4X0EvfXHOtm9zaYTGk87UVsMlOoDqZWyOcRIk=; b=
 0EVG/xXmG4xFAnGQvEp7p9+nI5oCbvCOGPo0m9m1HQ7+TUvtVeWxdikmg/kUccXI
 5nICBYx/Ia4PNsiXlUTcLbH6IzouuKVFiC1ATZJu1SN+PnzF0vXw+jqamMGNMEXr
 T93ETssjM2L2W7/GPIckPnvJzuxabM1F5WrLYFwUB21B63vkz1GkLQNtnIEclrdE
 dx6M6PVmm3TgRXjgliHaaaJCvqvCaFbWHJ3/h6Z1nUItOQlqGUATMbDda9BTwzaQ
 EGyoPpvqy+uLPAA7RGRrTtm3Nr9kJIAgRmbYE0Es7SjcFqEO+63KntYhFzj028rt
 8HiEjYitnSK5xrK+YvT5EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791933280; x=
 1792019680; bh=BfT8I+4X0EvfXHOtm9zaYTGk87UVsMlOoDqZWyOcRIk=; b=A
 lX601BcW1lEMRGp8EYJ3S1ssOLkMOlGaNRNsmOGujoCNBEZ3+AFFhV6K0Xls72ib
 iIUwu3Cg1jIKSda8Fjn2+5N5FoARDH/71x0V9vcDk3m/8KnKbHNmF3n20gzysHAg
 K5f8Hq1amL8Z3Jjm5VfPrtUYp1XKKPsJCDT1fzEwQulbbcOoIN/Y6Kg1mvyStD08
 fj9WH7XCYqhQrZfwI8VUTpzx5y4Y2MhGfAD+C38dSkvG20ETLF5qaghe33xhvPKH
 VCXwdreJTxHJQ06wjdqNEGNtoOfF9WQ1sfTlWCOobKzHjspfIjBvKRxvI+UwO/ae
 fMGbmY6M0s/nMvvBnkLyg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791933280; d=shazbot.org;
 mf=PGFsZXhAc2hhemJvdC5vcmc+;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:rltbAjPTPKKplFei8a0RaeW6nHkVPl973P/M7HwyQYUD4FE
 QKXRboIsyi3Xte9vOmJNqYQnkKGLheu2+7ijP6WAcG095liquHeOXQhC+Z2RENPQ
 ePZj587adq+wpgqxYcFBX6odz41qYwblPmHW5XslRHz0gUOF+abCm6VLOYSNlR3d
 gR42jG8scODws7E5hR/EFr1uADqDBcHURZicM7D21p0C8lUDFxq4FfB5iTjzBGAZ
 AtbC/vP2cNkTn9xemnI6jgIHoeeplPI1/owGhAYWXF2rtfYUSlMSY8xZgr7h3nIU
 V/yCdR7mL58uNWeSGrQ0Y3MBPz+JZ7GeMZyYitg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:yj2hg5XECtiDrRWf6tVAtzWA/VAk25ipXaFmKMAMJoQ=:/Y5Fw9qT527KKbqhfYxFQrG2THQF07fCNcRmTBxREDs=;
X-ME-Sender: <xms:YLvOar0jndp1EZXuvyDQwSQqg48z96gtWomiDUzYf1l0Ud-LufedFw>
 <xme:YLvOarsMCTEbRpCiYhTnKjRxv3Q1Udi9fYcaunpgEhi8wBmP_EaLhb_AUbjnKOC_6
 zY6q4yttqtURLoaiRhR5slgeMi18CpSYQRmALLGv6hlZezInlYszFU>
X-ME-Received: <xmr:YLvOav9ScE9TuQHTNmwPdUZNWhuxAUYakgayqrEjAKt6kqMXvXlG201s8FlirQ>
X-ME-Proxy-Cause: dmFkZTGh5K968C2Cl84ptSi+4y/RZ/kVjRI/KuhQFT9EdVF+wlBRkUV3+MnA4Bw8USczqh
 K75Ks9fzzqoUpxb7GlBjbnkhjHyFx4/Ig31C73IxKiEP0jiid6Tlem7NohMXSaR+5FMEhK
 ifHB8gtzfUTonlinprF4mw7WPTut7T/J1hPsQXDLSJK0xqaYcZbKfDVq23wYMjW2iywqpO
 ZIPaJ4ce5Zm6PCb9LkghPIarZYc8Qnu+WxwoCZiOXCKojQi16QdbuVc39mEboH71fqwON2
 cQwxZsIGEE5+oDvRemv0bEM6otLHIcNZE8FD2rvXxw3NzcIK91ZKa9ZQuG1p86j7bXidt1
 t7ubkWXzpAYDrfzWjAFljuURBOW6RXtnWNGOyYANw2vWhzFDvDgBp7rQW+14hrSRu9nGGy
 rJqicvJhzEDZN2zANvtDoFKc5wv+Q5VWtD1Cmb5zy9gVwDRaK6VMjyODeR35hnU+xtxmnT
 KzN6JsQ9kTzTfDcZRPPuXpWzmy5APVHtGIGOS/0ATIsGX3MVwj0yI06nAbv5Az/EcLeVEE
 GHA9pnHgKZLxVpBHFIv0N5LUk7BUhTpSuWc/9KnYJn+xqv6LL4VcovBg48Fx8dF5RIP2d2
 /qAvt05wPDZsASFWUG9rQAP2lIzRGdoy274y2WTrSRIFX4/prD48X1kLoJow
X-ME-Proxy: <xmx:YLvOanQXiij28d1Ogiv1vBA2cxU1mfJQvCTMtER-G-Zv-2Z6t69C3Q>
 <xmx:YLvOatDQyFhjuH7mc5gf68EkeTQvMw_k7UC4gJI8YF1Ag3uJ303Zgw>
 <xmx:YLvOaga8LBvCnDbn7aPdLf6Vp0BfjSbEpEQKTutWLgjOqGK4mrJ_LA>
 <xmx:YLvOamKDraQyYN3qvx7soqb2cvTKXGJXdFWE5z79zNgZ14vZCV7pJg>
 <xmx:YLvOavXOAGVypv9RKCwtf0rHtb3dTvfJeHqU8lJ_C5q9HP6Av_d3YR5c>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 19:14:38 -0400 (EDT)
Date: Tue, 13 Oct 2026 17:13:43 -0600
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
Subject: Re: [PATCH v8 9/9] vfio/pci: Revoke a DMABUF on request from userspace
Message-ID: <20261013171343.2363e9e1@shazbot.org>
In-Reply-To: <20261006193643.76330-10-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-10-matt@ozlabs.org>
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

On Tue,  6 Oct 2026 20:36:37 +0100
Matt Evans <matt@ozlabs.org> wrote:
> +#ifdef CONFIG_VFIO_PCI_DMABUF
> +int vfio_pci_core_feature_dma_buf_revoke(
> +	struct vfio_pci_core_device *vdev, u32 flags,
> +	struct vfio_device_feature_dma_buf_revoke __user *arg,
> +	size_t argsz)
> +{
> +	struct vfio_device_feature_dma_buf_revoke db_revoke;
> +	struct vfio_pci_dma_buf *priv;
> +	struct dma_buf *dmabuf;
> +	int ret;
> +
> +	if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
> +		return -EOPNOTSUPP;
> +
> +	ret = vfio_check_feature(flags, argsz,
> +				 VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(db_revoke));
> +	if (ret != 1)
> +		return ret;
> +
> +	if (copy_from_user(&db_revoke, arg, sizeof(db_revoke)))
> +		return -EFAULT;
> +
> +	dmabuf = dma_buf_get(db_revoke.dmabuf_fd);
> +	if (IS_ERR(dmabuf))
> +		return PTR_ERR(dmabuf);
> +
> +	priv = dmabuf->priv;
> +	/*
> +	 * Sanity-check the DMABUF is really a vfio_pci_dma_buf _and_
> +	 * relates to the VFIO device it was provided with.
> +	 *
> +	 * If the DMABUF relates to this vdev then priv->vdev is
> +	 * stable because this open fd prevents cleanup.
> +	 *
> +	 * If it relates to a different vdev, reading priv->vdev might
> +	 * race with a concurrent cleanup on that device.  But if so,
> +	 * it points to a non-matching vdev or NULL and is unusable
> +	 * either way.
> +	 */
> +	if (dmabuf->ops != &vfio_pci_dmabuf_ops ||
> +	    READ_ONCE(priv->vdev) != vdev) {
> +		ret = -ENODEV;
> +		goto out_put_buf;
> +	}
> +
> +	/*
> +	 * memory_lock(R) is taken to stop vfio_pci_dev_set_hot_reset()
> +	 * from getting it and then blocking all devices in the dev_set behind
> +	 * this revoke's drain.
> +	 */
> +	down_read(&vdev->memory_lock);
> +	down_write(&vdev->dmabuf_lock);
> +	if (priv->status == VFIO_PCI_DMABUF_DEAD) {
> +		ret = -EBADFD;

Kind of ugly to special case the condition in the caller that's already
tested in the function.  Why not return an errno for this purpose?
Thanks,

Alex

> +	} else {
> +		vfio_pci_dma_buf_set_status(priv, VFIO_PCI_DMABUF_DEAD);
> +		ret = 0;
> +	}
> +	up_write(&vdev->dmabuf_lock);
> +	up_read(&vdev->memory_lock);
> +
> +out_put_buf:
> +	dma_buf_put(dmabuf);
> +
> +	return ret;
> +}
> +#endif /* CONFIG_VFIO_PCI_DMABUF */
