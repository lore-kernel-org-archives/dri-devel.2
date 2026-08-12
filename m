Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0F5C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA9510EFC8;
	Wed, 12 Aug 2026 13:06:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oZFTGg3Y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E42F110EFC8
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:06:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B3B3443961;
 Wed, 12 Aug 2026 13:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195E61F000E9;
 Wed, 12 Aug 2026 13:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786540016;
 bh=MyS7PpaRGETcm8MpjUovEWvngHvq+Nobqa8lnVwmUPc=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=oZFTGg3YMVCuZfkath0YRWZOpWweDiNeyQt3/w/ORte0cHZyXdgjwuIG3e4OEnPxL
 Yqp6uupuCFAI1snXkA0hJiQfWS8rHuU4T/7eWXQXBgivqKDMxFhorLikDvuirBr8zq
 G4/936rx/B1bsznpMQieN0Hzg9lO96d1RlQKnAKqtUxYOkO60/na6RQZzIgcouQE9w
 MiKN6+QcFods927UMYN8RAPSIGpwTgumezJKboy+DiT2Nc2nXbmtQymhLWwxNGMDKO
 +/XushZ57XX0ZObmaXTklklyD6Z+y8etl1wY53F4h8joYXquTeEE3SALwUYnY9TuHS
 GqB4cwHaXB1GQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, danielt@kernel.org, Levente Szajko <raedrimhun@proton.me>
Cc: jingoohan1@gmail.com, deller@gmx.de, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260805135027.43890-1-raedrimhun@proton.me>
References: <20260805135027.43890-1-raedrimhun@proton.me>
Subject: Re: (subset) [PATCH] video: backlight: Use sysfs_emit() instead of
 sprintf()
Message-Id: <178654001483.1417099.6589190686367824325.b4-ty@b4>
Date: Wed, 12 Aug 2026 14:06:54 +0100
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

On Wed, 05 Aug 2026 13:51:39 +0000, Levente Szajko wrote:
> Replace sprintf() with sysfs_emit() in the sysfs show callbacks of
> backlight.c and lcd.c, as recommended by Documentation/filesystems/sysfs.rst.
> 
> No functional change intended.

Applied, thanks!

[1/1] video: backlight: Use sysfs_emit() instead of sprintf()
      commit: cf1a12e0804515e0ed8b3f50c1c32f7f425bd660

--
Lee Jones [李琼斯]

