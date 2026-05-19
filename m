Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C0CCD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 16:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6A810ED9E;
	Tue, 19 May 2026 16:02:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GwrYU15d";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE42810EDB6
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 16:02:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2ED2360215;
 Tue, 19 May 2026 16:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C6AC2BCB8;
 Tue, 19 May 2026 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779206522;
 bh=H6jZ26cdR6c1FE51+ZuaH/BzQgAqaYpLufrEPC0KbOk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=GwrYU15dST8GtVPgjFaJ/IZ4FBZrSitau+ioN9iJ2dk1L9AYdwUb9uBYR+wlun/6r
 xKAjq0WLhsZug2aqjVO7YE4QF/sgUmAFGyD9X2/UEwzvwTe+U3D3dQaaQGWnq35/wv
 HdPNFVQHfnsrB4HsmdCKZeHUFKwAku8NviQcRh4CkXa7IpQeN431nrA+T2LWniQcis
 P2peDayiGnVDTY0qXEAKxAma899THBPeEH6Mh825RI1hcaLNkGfE7Q2YNr8FGwix1k
 O0SsWEc5f+lCWwLbfrZJxHK8MxT0Wnyh1T9JKAogtzL8y+NDOarmgqNj02Mug32hPa
 9RYC81IKEqOSQ==
From: Srinivas Kandagatla <srini@kernel.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Junrui Luo <moonafterrain@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>
In-Reply-To: <SYBPR01MB78819393A1F4FA658B2AB076AF042@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB78819393A1F4FA658B2AB076AF042@SYBPR01MB7881.ausprd01.prod.outlook.com>
Subject: Re: [PATCH] misc: fastrpc: fix DMA address corruption due to
 find_vma misuse
Message-Id: <177920652114.51472.15795921379739203667.b4-ty@kernel.org>
Date: Tue, 19 May 2026 17:02:01 +0100
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


On Fri, 15 May 2026 17:16:03 +0800, Junrui Luo wrote:
> fastrpc_get_args() uses find_vma() to look up the VMA for a user-provided
> pointer and compute a DMA address offset. When the address falls in a gap
> before the returned VMA, (ptr & PAGE_MASK) - vma->vm_start underflows,
> corrupting the DMA address sent to the DSP.
> 
> Replace find_vma() with vma_lookup(), which returns NULL when the address
> is not contained within any VMA.
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: fix DMA address corruption due to find_vma misuse
      commit: 03f669db42e9804f8e6f1e41dbe6dc1f22b7757c

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

