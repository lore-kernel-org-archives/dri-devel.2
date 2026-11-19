Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D08606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HUlUxbux
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F57D10EF0D;
	Thu, 19 Nov 2026 17:32:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E28410EF0D
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:32:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D602841A6D;
 Thu, 19 Nov 2026 17:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56301F000C5;
 Thu, 19 Nov 2026 17:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795109522;
 bh=dWOqVlQrDMo1jk4gcSOpGcbX7n3Zd69ocOnoUDk8YzI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=HUlUxbux7Jbt48w+1T9O49pg9fuSGa7KkSN6Ru2P3XJJQFOiYyS9V2Nt4kfYF0QtT
 MTCvdl+gQxnAcpUSVq/6Tx9xbIak12AWz+Fepo1XMUGYeA96/V0bz5K2pT2COS4sLS
 Xm02UOsgVBiSjmDvsjCGHmRyleo+9sNPg2/JXlo0cSAIm1YmFoOVwjjeOyKg3WqzEU
 Bq4x/lkAVF6wsQ+wf628q1QD0LLotjfpDzcZtlXyw2TQQFVq9LOrUcxDCSgHh5aio0
 PV6NjSnhDZsww7U/guq5V0I4xZX/t51qkQq28EihT7t2GGXCng+ImHSOaTmBiZDbJR
 JlGg6OGKJaiXQ==
From: Lee Jones <lee@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>, Petri Karhula <petri.karhula@novatron.fi>, 
 Manuel Ebner <manuelebnerli@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261113114552.895592-2-manuelebnerli@mailbox.org>
References: <20261113114552.895592-2-manuelebnerli@mailbox.org>
Subject: Re: (subset) [PATCH v2] backlight: cgbc_bl: Fix kernel-doc
Message-Id: <179510952067.85896.410495559913801385.b4-ty@b4>
Date: Thu, 19 Nov 2026 17:32:00 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
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

On Fri, 13 Nov 2026 12:45:52 +0100, Manuel Ebner wrote:
> This comment describes a struct as a kernel-doc. Format as such, fixing:
>   $ ./scripts/kernel-doc --none drivers/video/backlight/cgbc_bl.c
>   Warning: drivers/video/backlight/cgbc_bl.c:29 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
>    * CGBC backlight driver data

Applied, thanks!

[1/1] backlight: cgbc_bl: Fix kernel-doc
      commit: 7f124d0893d69cb702b333c47ed56683abec5c6c

--
Lee Jones [李琼斯]

