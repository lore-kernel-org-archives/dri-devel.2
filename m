Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E261606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXFzBaBk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6E0112953;
	Fri, 27 Nov 2026 09:56:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE7E112948
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:55:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CB65962647;
 Fri, 27 Nov 2026 09:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29EE1F00933;
 Fri, 27 Nov 2026 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773339;
 bh=A2En8s7gc8e1QOJN7yIgdC3ZHh4VMZbn4LZ/89SawUI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=bXFzBaBkeIRUYbu8+mXSz10ZllCcdt4P4XlnsrtU1HXd6d/Pnu1Jxa3qNoQhwD4bw
 cXZp1DSA6S3KPaKg9PbC31Di1Tu33jO48BdvMubRnrJYWF66Sh5+2B0cPBxm7d7aYt
 P/Nb3nB1JvisGQkTgNi1aiisYlhcbCiYdy/lk16mYAGXh2EUZnYBd6pRm82dYkIfrt
 fBBVEvq3FaQw+79AkHj8sj2pR9wEZno9iW3yMHf3xoQQMoylW8ctn7KaTqDGaPiM6g
 1KnZCL6oNj7jHXsaxmK5AcMv6TSeG8/fB7vSA07kkEttKXHtiGRE34V5+37lytadwV
 wDNSfv3R6RjwA==
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
In-Reply-To: <20260805060940.41414-1-jianping.li@oss.qualcomm.com>
References: <20260805060940.41414-1-jianping.li@oss.qualcomm.com>
Subject: Re: [PATCH v3] misc: fastrpc: avoid duplicate DMA mappings in
 fastrpc_create_maps()
Message-Id: <179577333662.9695.16850584437035345885.b4-ty@kernel.org>
Date: Fri, 27 Nov 2026 09:55:36 +0000
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


On Wed, 05 Aug 2026 14:09:40 +0800, Jianping Li wrote:
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

