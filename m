Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C0F606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/+3jpkU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B248010E231;
	Tue, 24 Nov 2026 21:07:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4108310E184
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 21:07:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E9F0628BF;
 Tue, 24 Nov 2026 21:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E051F000D3;
 Tue, 24 Nov 2026 21:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795554418;
 bh=EOcUz1z9MRlpObt/9oXs3kNZoy+9Pi0L3SMSms36Uro=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=E/+3jpkU7aMu4JJ/L6N5sWVKzRdUqtGLt/wHNnIZRYQdZ6SuEddR2jPXA/We4KshD
 fb8hBOpoO4yNaftt5HcqWKnXaRjm7u2Lkgs+1mnv7ImzDteyUm1hTVDcJtF3IUn+Es
 fSTL2jYNZ3CgwRo8rJYV9LQYbCd1dquX4bwC82O6Z9yoqhaGzJrggkSjH6lyvAXVF/
 Mzueu1mm2gyM4C8PyxjnB+jR4JxneU5zHa4+/YNeH5iquSmWqWtq7h9RiUoFsJErZ4
 sqHH2iGLnUEZ8kgdidLGhPxTAfa3YNkx68KqBd6ep/0scP3oOrSCQ+wlbONGJmc3RV
 2w2J4t9fBEcrQ==
From: Srinivas Kandagatla <srini@kernel.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@kernel.org, 
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20260701-master-v2-1-566bf8b7bd16@oss.qualcomm.com>
References: <20260701-master-v2-1-566bf8b7bd16@oss.qualcomm.com>
Subject: Re: [PATCH v2] misc: fastrpc: fix context leak and hang on
 signal-interrupted invoke
Message-Id: <179555441675.417176.3239253132321821842.b4-ty@kernel.org>
Date: Tue, 24 Nov 2026 21:06:56 +0000
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


On Wed, 01 Jul 2026 13:41:25 +0530, Anandu Krishnan E wrote:
> fastrpc invokes work by sending an RPC message to the DSP and blocking
> in wait_for_completion_interruptible() until the DSP responds. If a
> signal arrives during this wait, the syscall returns -ERESTARTSYS and
> the invoke context which holds the in-flight DMA buffers and
> completion state is left stranded in fl->pending.
> 
> On the next syscall attempt (either auto-restarted by the kernel via
> SA_RESTART or manually retried by user-space after EINTR), a fresh
> context is allocated and the RPC message is re-sent to the DSP. This
> has two consequences:
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: fix context leak and hang on signal-interrupted invoke
      commit: 3f645f6884b5c753eea253cab37521a432c69105

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

