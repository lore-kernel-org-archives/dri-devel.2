Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63257CA9EBD
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 16:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9950310E0FA;
	Sun, 11 Oct 2026 16:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UG4Ncgef";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B5410E0FA
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 16:48:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 60484410CA;
 Sun, 11 Oct 2026 16:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BA51F0089E;
 Sun, 11 Oct 2026 16:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791737312;
 bh=OB+vfzKm3XNV92058admPw+IuQBNMelZc6Sdfj/R7KA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UG4Ncgef78z6L7ILZ7TQ1RPPyLE0qNZvsb4F0QZRgCQFKo3t09cvI2Bu9V2agY/i6
 orVJ+SqxmTanRhPOzy92QDO2jkNu9x4k7jc+RSryOEGhnqton99L9wccMcWDCXsYzt
 PHLXFTPQsJR70NM3TeA4fTdro/LBtDVSk8f4VrdesLZ6DUHXze+tr19DZK1R/uKzXl
 6danHmRqiQXTxhYLIqc6hZxJ8aJ+BERCwSA+llpsryNoPXGwmU+hc/wFw2d6v53yQR
 lDbdtTAAWkg8I3ZyczzdyGGQVSREG8z/msZA8n2MdfcuS7oOb9p4e09D9XGP2HuEde
 kWXkkhK/gCihw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>,
 Min Ma <mamin506@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Eva Crystal <0xiviel@gmail.com>
Subject: Re: [PATCH 6.18.y] accel/amdxdna: Bound the sync_bo flush range to
 the BO size
Date: Sun, 11 Oct 2026 12:48:09 -0400
Message-ID: <2026-10-11-1-daily-reply-0002-amdxdna-sync-bo-6-18@kernel.org>
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

> amdxdna_drm_sync_bo_ioctl() passes the caller's offset and size to
> drm_clflush_virt_range() on the BO's kernel mapping without checking
> either against the BO size. The ioctl has no permission flags: any

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
