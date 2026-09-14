Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397DDC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 406D510EBE4;
	Mon, 14 Sep 2026 08:07:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F3XfDGpu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C29E210EBE4
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:07:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AB8B4436A9;
 Mon, 14 Sep 2026 08:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9111E1F00893;
 Mon, 14 Sep 2026 08:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789373255;
 bh=IzPzHT2O9FcOj6iMVx+MrnepZgj296Jj/Ts9i8e4R0M=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=F3XfDGpu7a5ak5OovQ9AvQpAc2X8WC82R8M37ob14XYX6u+HiAfDNrBK5qxDI0cEa
 VmDY4Vbs0fqVAbi4fXPPt+ouX/C+zcv0kK9c1sR0Kc35Oe7jxyAQK+H58so9b4Mm55
 X6NBjnYUeb7QaVqfi1J9oowExKPK8yE2VLZRxQofldmAx1tU7Rr/MaeV9sjevLf9NK
 mBR6T9ma9oKERL6zMN26F08UR8DKqu22jloHmpDgxtbNmsLUPB6+ybfeOKjNNILfKy
 19KYK/ip4i0VtdmqHw/JJ75PCQqhz+vBsnv5/oBPf9lR5kR59KxZR5CtuUlHtZJReL
 iINyFzJ1VNUIA==
From: Srinivas Kandagatla <srini@kernel.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>, 
 Yifei Gao <gyf161023@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abelvesa@kernel.org>, 
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260811225102.1077841-1-gyf161023@gmail.com>
References: <20260806235056.456341-1-gyf161023@gmail.com>
 <20260811225102.1077841-1-gyf161023@gmail.com>
Subject: Re: [PATCH v2] misc: fastrpc: fix double-free in
 fastrpc_map_attach() error path
Message-Id: <178937325340.257763.18070145219812711052.b4-ty@kernel.org>
Date: Mon, 14 Sep 2026 09:07:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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


On Tue, 11 Aug 2026 22:51:01 +0000, Yifei Gao wrote:
> map->table is assigned right after dma_buf_map_attachment_unlocked()
> succeeds. The two failure checks that follow, the len > map->size test
> and, where subsystem VMIDs are configured, a failed qcom_scm_assign_mem(),
> jump to map_err with map->table already set.
> 
> map_err manually calls dma_buf_detach() and dma_buf_put() and then falls
> through to fastrpc_map_put(). Since that change the error path tail is
> fastrpc_map_put() -> fastrpc_free_map(), and fastrpc_free_map() already
> unmaps, detaches and puts the dma-buf whenever map->table is set.
> The two operations therefore run twice: the second dma_buf_put() drops an
> extra reference on map->buf, and dma_buf_unmap_attachment_unlocked()
> dereferences the map->attach already freed by the manual dma_buf_detach().
> kref_init() sets the refcount to 1 with no intervening get, so the final
> fastrpc_map_put() frees the map synchronously and the redundant cleanup is
> deterministic.
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: fix double-free in fastrpc_map_attach() error path
      commit: 2159430fe26068ca3c89557ddd2d5eb17a5a8cf0

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

