Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4630CCA9EBE
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 17:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882DA10EAB1;
	Fri,  9 Oct 2026 17:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XDTVl/8Z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEFF710EAA8
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 17:10:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6969D42E4A;
 Fri,  9 Oct 2026 17:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6957B1F00893;
 Fri,  9 Oct 2026 17:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791565844;
 bh=C9JsI/6wJG4T+ggUBIVnC01WngD4K2YbeltQKR7jvZw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XDTVl/8ZElnPShtbJWWGn4xE7vTpc/qnZ07Y1HJ0qdEHQ+snST4gHg4ebMmvRdw4A
 Sf28Xos5nEcLFoJa+mxgOgLuL3MyAWO/kfu+7NDz94riLY3gdwIKC8FhHstrbklyMA
 M0IaPX2x+UwsymiIZldBNSsZxCStoxeoF0zQPhmBLFY6/Qa5SuHAJkD3XAu87I77kp
 1k590VLGTfEvp/4sOgT0Gq8gp8drRrp/Vg98VesogTZv0qfi2rJpxNn8P72awnmGPf
 j2yGCSJKfBG7zqD84uQ8kfOPNg5PeZXcYRbmzXvU1GiruP5wUBhun1il9j83gKMiJp
 YHwfzMnPH2rnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>,
 Min Ma <mamin506@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Eva Crystal <0xiviel@gmail.com>
Subject: Re: [PATCH 6.18.y] accel/amdxdna: Bound the sync_bo flush range to
 the BO size
Date: Fri,  9 Oct 2026 13:09:50 -0400
Message-ID: <2026-10-09-1-daily-reply-0013-amdxdna-sync-bo-6-18-holding@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009032616.432392-1-0xiviel@gmail.com>
References: <20261009032616.432392-1-0xiviel@gmail.com>
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

> This applies only that check: an offset at or past the BO's end, or
> an overflowing offset plus size, returns -EINVAL.

Thanks for the fix. Ideally a maintainer could ack it.

-- 
Thanks,
Sasha
