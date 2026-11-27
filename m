Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66954606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JWjyXYBZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0005711294A;
	Fri, 27 Nov 2026 09:56:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37727112945
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:55:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1AE804519B;
 Fri, 27 Nov 2026 09:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D851F0089B;
 Fri, 27 Nov 2026 09:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773342;
 bh=ACxoQP1MF+GzFlqiKuoUajC8aDkgrIQRATa/Cgcdw18=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=JWjyXYBZFLodQ2ukOB716EuV2QW6f1pXKynVGgFfPt5HmZeFFlhyjEvpc43jJVJCm
 PnOC5fU/YFjpdraX5ojxPK0AGcuV/RVDPp6sR8jbR8kd22rMPVUGXnRbI5jbO2/Cvg
 tLn9mz3lwbmbI2e64+gjagae3S4BSPuVyWixHq0EBv+tHtyJ5f+Zx+H+3s48TBsDYZ
 3Ucfgr63uKDX3zkX0fmckQjYtlC+LcpncyBl8urhMyr5qHZbwbLwbpuLsdOP5jcOrR
 6BwmeiCqwEY7aBf2Q5veA7ud9lRorvUBQpllYTR4cRHtxlmB28HhM3An0qHeD00em/
 A66Ms1ZzG3Mjg==
From: Srinivas Kandagatla <srini@kernel.org>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
 Jianping Li <jianping.li@oss.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Ling Xu <quic_lxu5@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, quic_chennak@quicinc.com, stable@kernel.org
In-Reply-To: <20260914104019.492-1-jianping.li@oss.qualcomm.com>
References: <20260914104019.492-1-jianping.li@oss.qualcomm.com>
Subject: Re: [PATCH v4] misc: fastrpc: avoid duplicate DMA mappings in
 fastrpc_create_maps()
Message-Id: <179577334009.9695.7128272976897775662.b4-ty@kernel.org>
Date: Fri, 27 Nov 2026 09:55:40 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Mon, 14 Sep 2026 18:40:19 +0800, Jianping Li wrote:
> DMA handles passed as invoke arguments (scalars beyond nbufs) may refer
> to the same dma_buf fd as an input/output buffer argument. Taking an
> extra reference for such DMA handle maps leads to duplicate mappings and
> an unbalanced reference count, since DMA handle maps are released
> separately when the DSP returns the fd through the fdlist.
> 
> Fix this by not taking an extra reference for DMA handle arguments
> (take_ref = false) and tagging them with FASTRPC_MAP_DMA_HANDLE. As
> these maps are borrowed references, fastrpc_get_args() re-validates the
> map via fastrpc_map_lookup() before dereferencing it, so it is not used
> after being freed. fastrpc_put_args() only releases maps flagged as
> FASTRPC_MAP_DMA_HANDLE and clears the flag to guarantee the map is freed
> exactly once.
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: avoid duplicate DMA mappings in fastrpc_create_maps()
      commit: d943eec5a618cef0e2ba77b799c6ee27fae873dc

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

