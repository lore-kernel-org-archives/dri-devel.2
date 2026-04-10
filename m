Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D59F45A0D
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 21:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9206B10E1C3;
	Fri, 10 Apr 2026 21:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JXTTppZX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F33010E1C3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 21:01:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A43460141;
 Fri, 10 Apr 2026 21:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C6BC19424;
 Fri, 10 Apr 2026 21:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775854898;
 bh=8k+cK41OdLbgiT4F2k1zDjLX7TALCLcSSuKKXuBD5b0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JXTTppZXN+vGmdnk2DXTuCGh1voIkYp9YeyZ5p3j2xv7T9htCXGGteKGaDSydEDRt
 eSJweeepxWIhcwsawv2pX61JdAPCdNZW4Sk/Z+fL1frDE92WQkAZL4n3XQ91I//bIe
 c4nNwR+Ta2Prra1N8RHrMtMixyGTe1fbG9qvaFHDQCZqr+tOebuJcnAyoG5Yh//g1m
 5U/VMXemnaVONazS2wcmdGOnOBR7XH73+PsznIuBo9PUNgPhv83ucaM3PR8ad582vj
 Hnm5tlIE/eq5+zWthQuCd3yk+B3T4o8Kwc9c7cqQDtnrbc50plLiIOgudNrv7OtJQJ
 C5p9QDil4hnJw==
Date: Fri, 10 Apr 2026 23:01:34 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Aniket Randive <aniket.randive@oss.qualcomm.com>
Cc: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com, 
 sumit.semwal@linaro.org, christian.koenig@amd.com, linux-i2c@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 naresh.maramaina@oss.qualcomm.com
Subject: Re: [PATCH V4] i2c: qcom-geni: Avoid extra TX DMA TRE for single
 read message in GPI mode
Message-ID: <adlkwQZ_9iR6WkA0@zenone.zhora.eu>
References: <20260410101949.2315058-1-aniket.randive@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410101949.2315058-1-aniket.randive@oss.qualcomm.com>
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

Hi Aniket,

On Fri, Apr 10, 2026 at 03:49:49PM +0530, Aniket Randive wrote:
> In GPI mode, the I2C GENI driver programs an extra TX DMA transfer
> descriptor (TRE) on the TX channel when handling a single read message.
> This results in an unintended write phase being issued on the I2C bus,
> even though a read transaction does not require any TX data.
> 
> For a single-byte read, the correct hardware sequence consists of the
> CONFIG and GO commands followed by a single RX DMA TRE. Programming an
> additional TX DMA TRE is redundant, causes unnecessary DMA buffer
> mapping on the TX channel, and may lead to incorrect bus behavior.
> 
> Update the transfer logic to avoid programming a TX DMA TRE for single
> read messages in GPI mode.
> 
> Co-developed-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>

merged to i2c/i2c-host.

Thank you and thanks Mukesh for the review.

Andi
