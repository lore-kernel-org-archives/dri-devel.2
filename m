Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A499D606A331
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EozP57ou
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 170DA10ED07;
	Mon, 16 Nov 2026 10:10:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6721D10ED07
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:10:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 905E962375;
 Mon, 16 Nov 2026 10:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607351F000C4;
 Mon, 16 Nov 2026 10:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794823837;
 bh=fkWCz/8JupYMan3nETw3vXIG95rQOXH/T65s9KBE3Sg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=EozP57ourVAjGji3+BoIddbIMHSGeDTda6i1rwnwM+tTYVDc6qqwSLBOAoAkLqI6H
 +8w9nP2fRx/gVZ4+jH0cywGxlltGZwSKd7ftgOjswJ19omkFwikljg945b+GNa2ZzO
 V4muu/W4wYLe344a8//BtLqjaUoUVS9NCf99yyGogFDlDWDZdoe3zZiEus/JcV8D22
 E7vwtsYOOqzC9il5JySUp8EZ/Yk1lkzbwqGX+mqVLKDthjgRwV6jtA6AwRT1Vzy9Y1
 1gnoHVYlQ0s41oyJFELbxcoXv9MqGkSrSgJ0Nn2r1TT7tnUzJg4ptT19HZrQhtxZrj
 nhD/3yhyjsjQA==
From: Srinivas Kandagatla <srini@kernel.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, ekansh.gupta@oss.qualcomm.com, 
 quic_bkumar@quicinc.com, quic_chennak@quicinc.com
In-Reply-To: <20260618-audio_fix_clean_v3-v1-1-ec1ee66fe455@oss.qualcomm.com>
References: <20260618-audio_fix_clean_v3-v1-1-ec1ee66fe455@oss.qualcomm.com>
Subject: Re: [PATCH] misc: fastrpc: map ADSP remote heap into remoteproc
 IOMMU domain
Message-Id: <179482383503.16873.4208702948702896080.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 10:10:35 +0000
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


On Thu, 18 Jun 2026 15:21:21 +0530, Anandu Krishnan E wrote:
> On KVM-based targets the kernel runs at EL2 without a separate
> hypervisor to manage inter-VM memory access control.  In this
> configuration the remoteproc is assigned its own IOMMU domain, and
> any memory carveout the DSP must access requires an explicit mapping
> into that domain before the DSP can reach it.
> 
> The existing code calls qcom_scm_assign_mem() to transfer ownership
> of the ADSP remote heap carveout from HLOS to the DSP VM.  This SCM
> call is only meaningful when a separate hypervisor (e.g. Gunyah) is
> present to enforce inter-VM memory access control.  On KVM-based
> targets no such hypervisor exists, so the carveout must instead be
> mapped into the remoteproc's IOMMU domain via an identity mapping
> (IOVA == PA) using iommu_map().  Without this mapping the DSP
> triggers an SMMU translation fault when accessing the remote heap
> during audio PD static process creation.
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: map ADSP remote heap into remoteproc IOMMU domain
      commit: f914df45c32280850dd7aaaaacb1b356087e5a09

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

