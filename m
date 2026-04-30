Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB62FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 13:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 358D310E9C1;
	Thu, 30 Apr 2026 13:35:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MRPygyba";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 900EE10E96A
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 13:35:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C829560142;
 Thu, 30 Apr 2026 13:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D49AC2BCB3;
 Thu, 30 Apr 2026 13:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777556115;
 bh=2EQxsIUqtXGo3JVpBUdlMzZL+gQi0+EkN8r9+hEvm/s=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=MRPygyba4u+C+/DVn2ifvMHMM+Hr7XLKMg5B7N4RhDaIinR3PstEO8SyQNvKSdWaK
 WtweTqZElnYq7RzJqMVcz2YDf5fAvkPx6qq/cmY/8eZeb8Vndq860AnLQA/pmSogKD
 lIYHgIEsU9hPchFQz6j1UIE4aRAdGjimf7g4eb6Tu7K8G0RMIJo/Y6TPuBcQ160WZB
 KFDmIJX0Ldjb3UuGWd+8CnU8P3CE8FPVguXpUJmoVgBvo4nrnd/LLKgIM5AlZIQJhQ
 RA1vA1mLo9QbRKJH48Ydm+6Zzb66+7xi0AgDiWhCtm7XnUipLUkKkgjI87/HyLLT5h
 XzwbSx200Xigw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Cc: Karel Balej <balejk@matfyz.cz>, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 stable@vger.kernel.org
In-Reply-To: <20260328-ktd2801-pm-fix-v1-1-007cb103faeb@dujemihanovic.xyz>
References: <20260328-ktd2801-pm-fix-v1-1-007cb103faeb@dujemihanovic.xyz>
Subject: Re: (subset) [PATCH] backlight: ktd2801: enable BL_CORE_SUSPENDRESUME
Message-Id: <177755611273.2593921.12572770318849795486.b4-ty@b4>
Date: Thu, 30 Apr 2026 14:35:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
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

On Sat, 28 Mar 2026 21:42:16 +0100, Duje Mihanović wrote:
> Boards using this backlight chip do not power the backlight off on
> suspend. Enable BL_CORE_SUSPENDRESUME so the chip gets powered off by
> the backlight core on suspend.
> 
> Tested on samsung,coreprimevelte.
> 
> 
> [...]

Applied, thanks!

[1/1] backlight: ktd2801: enable BL_CORE_SUSPENDRESUME
      commit: f37f5a2ac9d3737617c08f0dc7270b42e9cad907

--
Lee Jones [李琼斯]

