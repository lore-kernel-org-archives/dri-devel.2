Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF05EC43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 21:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB92210F0CC;
	Wed,  1 Jul 2026 21:07:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TQHxpVkP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C27C310E411
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 21:07:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 47FC6600B0;
 Wed,  1 Jul 2026 21:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBB31F00A3A;
 Wed,  1 Jul 2026 21:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782940056;
 bh=sfG7s89mfvljYpVWOaNelZwNwYWXPtSU+euAa/rOwBg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=TQHxpVkPsNmamdUSK8oPd9dm5DS5uPpgVkAwzNTKuIbqMZZ8ZnWnsm6AMKtb1iS1y
 3Cz4zryUD0GoJhSmJTWhCOaj1OOXIcbCQB+WtRxB9vDegQwGJqR48js2hxU2fT9QEK
 6vOF8hBRdxLT76ATSgb6X2K9KKO72RF9dXSfYpa+MNH/s5Pm8YM5E09HSJeRwfEqJ1
 LY16ji3IAKaYOd0zr7F4atjLAyrkoIo+uvPK0eZOHlqHIf/iK5dBz1M9Xoy8PgyHq0
 fZnTzCc7c05K4YnyYnrz3WV3GsMShP/aKJzTe2rhL0NxwZH8UQ4TejpjZa81if9YuS
 RM1SLLJILhtDA==
From: Srinivas Kandagatla <srini@kernel.org>
To: linux-arm-msm@vger.kernel.org, 
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, 
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, 
 dri-devel@lists.freedesktop.org, arnd@arndb.de, 
 ekansh.gupta@oss.qualcomm.com, stable@kernel.org
In-Reply-To: <20260525085340.2734738-1-anandu.e@oss.qualcomm.com>
References: <20260525085340.2734738-1-anandu.e@oss.qualcomm.com>
Subject: Re: [PATCH v1] misc: fastrpc: fix channel ctx ref leak when
 session alloc fails
Message-Id: <178294005408.13032.9633451619945550985.b4-ty@kernel.org>
Date: Wed, 01 Jul 2026 22:07:34 +0100
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


On Mon, 25 May 2026 14:23:40 +0530, Anandu Krishnan E wrote:
> fastrpc_channel_ctx_get() is called in fastrpc_device_open() before
> fastrpc_session_alloc(). If session alloc fails, the error path
> returns -EBUSY without calling fastrpc_channel_ctx_put(), leaking
> the reference. Fix by adding the missing put.
> 
> 

Applied, thanks!

[1/1] misc: fastrpc: fix channel ctx ref leak when session alloc fails
      commit: c48eabae708407d4f26eeb81f9fe8215741b78fb

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

