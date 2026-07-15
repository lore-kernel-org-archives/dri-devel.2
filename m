Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95CFC44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCA6E10F015;
	Wed, 15 Jul 2026 12:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="T6Uu3n//";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5651D10F015
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 12:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784117293;
 bh=kZ8B6PqVpKRnm9lEDxPxgNuLZ8wfBWvlNO08Nmm7Ex8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=T6Uu3n//rD8pkulKNPFoiFvcZ/NQpewYDcs1bjwXmZFtyP0kx9LBrxViHfvfFfcGb
 AsLapHGpPWgEU3soGCwi6on+3r5E3o/LgGbZwrgO8T6lTLwhlu7bYAI+bADjjzMjtf
 iZ8L57qkTlo+w1LE7BOvVERBPdNaAawBe7VxqfzgseI/mLvfqubLdwlQ46/BT8LdYi
 hPJFN27QEebjbnW+loTRjE8UtaQ2X/rE6CyGO6WZ08UHobUrPwC/AEcMeVVRXAFenZ
 Z5zy3ZIl9JawjQBu+xbhZrf24Mv82E9o+qD69sW9t6oj06ThPjLYLYMQxg5LNhQmtD
 hOSunbO3wYcOA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CC1EA17E0A4E;
 Wed, 15 Jul 2026 14:08:12 +0200 (CEST)
Message-ID: <f54dd723-de91-4166-9645-9d8d8cc3aaad@collabora.com>
Date: Wed, 15 Jul 2026 14:08:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/11] drm/mediatek: mtk_dsi: Enable interrupt at
 component bind time
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
References: <20260715114916.19690-1-angelogioacchino.delregno@collabora.com>
 <20260715114916.19690-6-angelogioacchino.delregno@collabora.com>
 <20260715120436.A9AEC1F000E9@smtp.kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260715120436.A9AEC1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/15/26 14:04, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Unsafe IRQ enablement before clocks are enabled leads to hard lockup or interrupt storm.
> - [High] Data race on `dsi->irq_data` can lead to lost wakeups and hardware reset.
> - [Medium] Unconditional return of IRQ_HANDLED defeats spurious interrupt detection.
> --
> 

Pre existing issues aren't even really much of an issue.

This shall not block this series.


