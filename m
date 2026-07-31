Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11ECC5516F
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 23:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0954810E23D;
	Fri, 31 Jul 2026 23:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X7NKCP8e";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F5A10E23D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 23:15:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0A79143722;
 Fri, 31 Jul 2026 23:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAE91F00AC4;
 Fri, 31 Jul 2026 23:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785539744;
 bh=So6Ub7VcEdURIC9Cw1Po+tU+Mmci/s0GtxtldO16gnA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=X7NKCP8eGnSgR29+BXGYD2BtwXHJ/0jdqD+vQXsyaMkPow6unBAkKM/UiPhFBf1ty
 I8FlbywNJ+hbsORmA8bnJRnkyNQZ9SkSO02v6Sy0lYgt+8DT2AkJcqPe4C1sHD2OYS
 sLpi/u+vdPVRomEr+M8XJG8lNp/yKsCed1LfDIFlNcbLcoiHDc+MR9PvvBXOvIY7C0
 6ntSW39bny4CgjaA1JFRHekq9zfDTj0wDeibcsr2dl/7Z0Kk87lQrGmEtmAAAYwmhZ
 mPXfD426+b+brRL+JN7wJDlYcQrX3LSz61xMGkFkGZ8uoiJA42oIzWUaahLOTDbkP6
 IPbM/iikIOelg==
Date: Fri, 31 Jul 2026 16:15:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
 sdf@fomichev.me, razor@blackwall.org, daniel@iogearbox.net,
 almasrymina@google.com, matttbe@kernel.org, skhawaja@google.com,
 dw@davidwei.uk, Joe Damato <joe@dama.to>, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <20260731161543.1021caed@kernel.org>
In-Reply-To: <am0bHSeJqcgdm3vn@devvm29614.prn0.facebook.com>
References: <20260724-tcpdm-large-niovs-v6-0-7975f62cdfbb@meta.com>
 <20260724-tcpdm-large-niovs-v6-3-7975f62cdfbb@meta.com>
 <20260729191649.55ab7942@kernel.org>
 <amvEJVio9XtCn+YT@devvm29614.prn0.facebook.com>
 <20260730151433.6f71258e@kernel.org>
 <am0bHSeJqcgdm3vn@devvm29614.prn0.facebook.com>
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

On Fri, 31 Jul 2026 15:01:01 -0700 Bobby Eshleman wrote:
> Meanwhile, do we want drivers/net/hw/config to workaround by carrying
> something like SYNC_FILE or DMABUF_HEAPS, or wait and see about the
> udmabuf kconfig change?

Let's enable SYNC_FILE for now and pursue the UDMABUF change in
parallel. It will land in another tree if at all, so we'll have
to wait a while before it propagates to us.
