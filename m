Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE6ACC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7624310E9B8;
	Wed, 14 Oct 2026 11:23:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92BE510E544
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:23:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2930843548;
 Wed, 14 Oct 2026 11:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52521F00893;
 Wed, 14 Oct 2026 11:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791977025;
 bh=QooNJvZrHXjDChSNfFqlc61ppEAorDR71dFglXWbyrg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CELtARTOZSN8fV3+WqxfhAbWiAeJC3hYWtKhciBMMvcALavpFPYmv+l4ab1E5Wwfg
 vWb/wSabYbBum70rckxtKZUl0LEw2D6SdL9ZkAApTfgukR9WZhOeaqwXREtOn8X+iS
 aIkJFApKYNA4mWd8/AO5B8dDxloFWE4/IZHvQ2qSbec2sPtdIg4l68omSFLF7e7Ek1
 WpBuzo9SWUDtxCHkK5JyQy/Rdybj2/iSWps/2ZVRsTh1rpe0Br3Vklglh292QE35N9
 Np23/8O+awpBtZ1dCAryvI6SNv7GaSqV76OArX7VvT6lfPEBL0516SMp06Hs/MXGrC
 L/sKPfhNMWxTw==
Message-ID: <sashiko-outbox-171197@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 08/13] nvme-pci: add SGL support for the dmabuf path
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <86fb4caeddaa58fafad106548f82950782ea04fd.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
 <86fb4caeddaa58fafad106548f82950782ea04fd.1791975048.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 11:23:44 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] nvme-pci: uninitialized rsvd bytes in SGL descriptors
--

commit 4bc1a46f0097646789808ced4d50802904a06015
Author: Anuj Gupta <anuj20.g@samsung.com>

nvme-pci: add SGL support for the dmabuf path

Add SGL support in addition to PRP for dmabuf-backed requests,
building the descriptor list from the mapping's sg_table.

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a0506c93fa16e..79b3c1092e4d1 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1223,12 +1223,18 @@ static blk_status_t nvme_pci_setup_data_prp(struc=
t request *req,
>  	return BLK_STS_IOERR;
>  }
> =20
> +static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
> +		dma_addr_t addr, u32 len)
> +{
> +	sge->addr =3D cpu_to_le64(addr);
> +	sge->length =3D cpu_to_le32(len);
> +	sge->type =3D NVME_SGL_FMT_DATA_DESC << 4;
> +}

[Severity: Medium]
Could this leave the 3-byte rsvd array in the descriptor uninitialized?

The NVMe specification requires the rsvd field in SGL descriptors to be
cleared to 0. Since these descriptors can be allocated via dma_pool_alloc()
with GFP_ATOMIC (which doesn't zero the memory), or reused inline from the
iod->cmd struct, does omitting the initialization here leak prior payload
sizes or physical addresses to the device?

[ ... ]

> @@ -1239,6 +1245,142 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_=
desc *sge,
>  	sge->type =3D NVME_SGL_FMT_LAST_SEG_DESC << 4;
>  }

[Severity: Medium]
Similarly, does nvme_pci_sgl_set_seg() also need to clear the rsvd field
for SGL segment descriptors to prevent uninitialized data from reaching
the controller?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791975048.gi=
t.asml.silence@gmail.com?part=3D8
