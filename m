Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5670C55175
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 22:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D76DC10E217;
	Sat,  1 Aug 2026 22:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jcbyW9US";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E4F10E217
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 22:13:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 81BCD43A78;
 Sat,  1 Aug 2026 22:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1731F00AC4;
 Sat,  1 Aug 2026 22:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785622420;
 bh=j10OoZVS7Iup1R4hlOXe0TgbrZKyvcYv8zUr346kSZc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jcbyW9USiszr3tsIYDwcABUlXW9RzwZZ8xka3mLLSAoilDiQucNJXvxH9HBbrGh1+
 t79kW7u2dE3+Cbdfz32lVPOgzhG3hLHt9rqzhYO0k+mSx6p4L6KKaeVPCDqMHXJ37x
 ENzzrC+BSnHZGo1f38Ov8A4m4vqDc/qn0oUR9Ve8/AeG7WhqWTz1/7TJkIwfi7ICev
 xdWGyXWqRXBoLQ8PS99VFztoCefPGw0jWiQLs64Kchmj5ZSNM909sVx6FPkYozZ5fR
 WJ669+8/eoFXH0hZwjZ1HH+tUXEvhIZyNTj/ywlxHEBJCrt8A+87SJdQJRICXmAK6R
 1u4o9V1nlG+pQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>, achill@achill.org,
 akpm@linux-foundation.org, broonie@kernel.org, conor@kernel.org,
 f.fainelli@gmail.com, hargar@microsoft.com, jonathanh@nvidia.com,
 linux-kernel@vger.kernel.org, linux@roeck-us.net,
 lkft-triage@lists.linaro.org, patches@kernelci.org,
 patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de,
 shuah@kernel.org, sr@sladewatkins.com, stable@vger.kernel.org,
 sudipm.mukherjee@gmail.com, torvalds@linux-foundation.org,
 Miguel Ojeda <ojeda@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 6.18 000/675] 6.18.42-rc1 review
Date: Sat,  1 Aug 2026 18:13:28 -0400
Message-ID: <20260801154223.stable-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730181717.95457-1-ojeda@kernel.org>
References: <20260730181717.95457-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Thu, Jul 30, 2026 at 08:17:17PM +0200, Miguel Ojeda wrote:
> Having said that, there is something going on a bit confusing: commits
> "part one" (4a9671a03f2b) and "part two" (ba110db8e1bc) in mainline seem
> to have been merged into just the "part two" above in this -rc. Is that
> intentional? I am asking because the original removal of the `lib`
> folder happened in "part one" in mainline, so I was expecting to have to
> point to that one above, but it doesn't exist on its own.

No, that was not intentional - part one got squashed into the part two
backport by mistake on my end, which is also why the `lib` removal has
no commit of its own to point at.

I can revert and re-do if there's interest in that?

-- 
Thanks,
Sasha
