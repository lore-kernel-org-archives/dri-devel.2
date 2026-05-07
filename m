Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4B2CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:25:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A020C10E276;
	Thu,  7 May 2026 13:25:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DtftW3QB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F2710E276
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:25:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E0C00419E1;
 Thu,  7 May 2026 13:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA82C2BCB2;
 Thu,  7 May 2026 13:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778160343;
 bh=KH+/lr31F6Z0z+vUx680aRlaO0mvzZuASV171zsRe8M=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=DtftW3QB/Z/jretElAvHJ7PrQmnYEsr3qOnEDjSuXYLSiPGkvRl/dSVlsxnl1s7LV
 9mwoVb4hK3ZqbQMqHxRnUp6fQPFaPVYWzxEXtIGX9bRhX0H0Sxa82RLI2ZaqGcB/gL
 +qAZAVkIYjfWiHyVlqH6pD6XX8cophk8g9bW2lNnxji1XxaajwNKGIl341796pImal
 aK7I1OyFgQ0U4pqr+KFu9Nfuys4nAwLQohcMQTXdBcCrWi6DduD0LQF1r8stq7Cz56
 mtix+wc/TC1PDTcPmr6aqpXwap2mv5xxJf09FbyvxfASlLFYZB7OlxR1oku9gfTEvb
 TCkVxc7X7nUiw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Thomas Richard <thomas.richard@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260427-backlight-cgbc-remove-x86-dependency-v2-0-da9f2375a34a@bootlin.com>
References: <20260427-backlight-cgbc-remove-x86-dependency-v2-0-da9f2375a34a@bootlin.com>
Subject: Re: [PATCH v2 0/2] Remove redundant X86 dependency for the cgbc
 backlight driver
Message-Id: <177816034168.1867063.1520145469415761822.b4-ty@b4>
Date: Thu, 07 May 2026 14:25:41 +0100
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

On Mon, 27 Apr 2026 11:40:32 +0200, Thomas Richard wrote:
> For this second iteration, I just added Daniel's RB tags.

Applied, thanks!

[1/2] backlight: cgbc: Remove redundant X86 dependency
      commit: db8e26c435698222b333cafcbc043dfdf083d591
[2/2] MAINTAINERS: Add cgbc backlight driver
      commit: acea35b567d0f610d533ca661f4106ac12583f78

--
Lee Jones [李琼斯]

