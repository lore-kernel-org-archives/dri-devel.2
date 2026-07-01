Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D348C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8A4E10E3E9;
	Wed,  1 Jul 2026 20:39:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S28tKo1j";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC5D10E3E9
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 20:39:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1EE3160138;
 Wed,  1 Jul 2026 20:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FA61F000E9;
 Wed,  1 Jul 2026 20:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782938372;
 bh=/the5eZJbF98hP/D8p+N3EBSs0nvSErM37y6I0tK2pQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=S28tKo1jzZ0l8GvahhZZWEpckiOS9XDAaDZiVZ/NMgmpbWjK5XnQmctnykAbl7+xv
 g/8L/nuLXz2U5AR+k/JdlEIrgamrmErGtmoYurVvNL3gjnaSne34KovTIPwB/MKCLT
 /0lsZ0m0hgRBQcEKLYEJPavYskH7evo6jA+AC+UlXneEEscr/jpzNqcI06qs1By8SJ
 XmcEPGJY113tSiJhtQx4lS9MJ9Awn7WwCpPaB7OlQ+zBSJdihU6rI2uXZHU3Lpk2GD
 FaNVW0SYJtUjA25lqwfQJLxDsyZsV9ZY0GFKOcRy3wAZJ+bJ2f14AS824xYtRwPSpp
 vQ1yTuMP3AgQA==
From: Srinivas Kandagatla <srini@kernel.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>, 
 Jianping Li <jianping.li@oss.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 ekansh.gupta@oss.qualcomm.com, quic_chennak@quicinc.com, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
In-Reply-To: <20260609025938.457-1-jianping.li@oss.qualcomm.com>
References: <20260609025938.457-1-jianping.li@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v8 0/4] misc: fastrpc: Add missing bug fixes
Message-Id: <178293837074.11817.1152479238333767830.b4-ty@kernel.org>
Date: Wed, 01 Jul 2026 21:39:30 +0100
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


On Tue, 09 Jun 2026 10:59:34 +0800, Jianping Li wrote:
> Add missing bug fixes in memory areas. This patch series fixes multiple memory
> handling issues in the FastRPC driver, primarily around the Audio PD remote heap.
> 
> The Audio PD uses a reserved memory-region that is shared between HLOS
> and the DSP. Allocating and freeing this memory from userspace is unsafe,
> as the kernel cannot reliably determine when the DSP has finished using
> the buffers.
> 
> [...]

Applied, thanks!

[1/4] misc: fastrpc: Fix initial memory allocation for Audio PD memory pool
      commit: 36090f35ca19c1422bd56f03cdc3b5703ca18a15
[2/4] misc: fastrpc: Remove buffer from list prior to unmap operation
      commit: 902b8ec9dd1098cc133cffa8be0b6378544f27ba
[4/4] misc: fastrpc: Allow fastrpc_buf_free() to accept NULL
      commit: a4f06f06c20a72b2ee96fd964ce93a18e321bd0a

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

