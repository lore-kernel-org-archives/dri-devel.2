Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912C9CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 16:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F21B810ECC8;
	Tue, 19 May 2026 16:02:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lckpbld1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B77210EDB6
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 16:02:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 18819403B4;
 Tue, 19 May 2026 16:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA56C2BCB3;
 Tue, 19 May 2026 16:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779206521;
 bh=QnU/9Obgk3bCr6ljz4AYAVYwV5j66hhtuadJ9EszmvE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Lckpbld1bDdtrIq5eU2rk8nak/U2Esue5D5EgI68H6zFGgmA9drg/CO8Kkb2oCbeX
 8ziZk9ez4kjKSD5L6sPwTwtGvUlYs1zRx18nWM+TllBIF02pt7ej+h0lKSyXDJO7Sk
 xGEJbh2Nv1OJwifdTMmiAOOIfhDh1xF2I15+kognSuOpZqj4PqlL/PkVzHOsEUk+/q
 nXtfxGbCbI05jynrWK4BhauwuJlRnCQCIiYC6hPCa5zvN5BMVgCvUo9jkuIMWpGNop
 DVweRQe1G3R/WwSJPoKzHSLzgyzhCW5hNvPE4JzKeJOBUNg+TlQbbiQMQ0HvJr6Ebq
 LRDabTd/mpQaw==
From: Srinivas Kandagatla <srini@kernel.org>
To: linux-arm-msm@vger.kernel.org, 
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, 
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, 
 dri-devel@lists.freedesktop.org, arnd@arndb.de, 
 ekansh.gupta@oss.qualcomm.com, stable@kernel.org
In-Reply-To: <20260518203507.3754994-1-anandu.e@oss.qualcomm.com>
References: <20260518203507.3754994-1-anandu.e@oss.qualcomm.com>
Subject: Re: [PATCH v4] misc: fastrpc: fix use-after-free of fastrpc_user
 in workqueue context
Message-Id: <177920651904.51472.16101417820040799306.b4-ty@kernel.org>
Date: Tue, 19 May 2026 17:01:59 +0100
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


On Tue, 19 May 2026 02:05:07 +0530, Anandu Krishnan E wrote:
> There is a race between fastrpc_device_release() and the workqueue
> that processes DSP responses. When the user closes the file descriptor,
> fastrpc_device_release() frees the fastrpc_user structure. Concurrently,
> an in-flight DSP invocation can complete and fastrpc_rpmsg_callback()
> schedules context cleanup via schedule_work(&ctx->put_work). If the
> workqueue runs fastrpc_context_free() in parallel with or after
> fastrpc_device_release() has freed the user structure, it dereferences
> the freed fastrpc_user. Depending on the state of the context at the
> time of the race, any one of the following accesses can be hit:
> 
> [...]

Applied, thanks!

[1/1] misc: fastrpc: fix use-after-free of fastrpc_user in workqueue context
      commit: b01bf21ae7e7c4c7cd4f1c8419bafc1e04c008e4

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

