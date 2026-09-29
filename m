Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43759CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 819A710F043;
	Tue, 29 Sep 2026 18:51:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UuHvziog";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A4110F03F
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 18:51:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1707843FFE;
 Tue, 29 Sep 2026 18:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F361F00893;
 Tue, 29 Sep 2026 18:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790707884;
 bh=msHud40OIqSpq3f9V3YZxbeDa6wD/0SM5+Ku3Otx2Tg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UuHvziogyqqoB6sgRjWKmHRCY1ChY4ksOWiyPrINoQti0aErTuaUxVVS3UTwG1F2P
 RVzDVUSyxibpT07QGGrXXtss4Silcc1mp9BMPDYiDXaEcp2K92/wrFl0TE5eF9jiln
 Zz+7iFjzrlQtM4OAP9fP5StTCM+vGYju23G8UmKv3Cs7cNjX96iORCi7ssIvsJe6NZ
 x54zK6+65yz3zz5rbtn5w7iBcAXeAsJgG0VEE2F0MrvgOe8IXDZHdE6XJx0fWr9ryz
 cxKz6QPitnCK4eghbtB+3bzQAPxnnSvFbsBfqh8pUJZhHB3KsI5d3JN14sef3lgzPd
 r0B/JSwpcBshg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Simona Vetter <simona@ffwll.ch>, jason-jh.lin@mediatek.com
Subject: Re: [PATCH 6.6.y] drm/mediatek: Fix potential NULL dereference in
 mtk_crtc_destroy()
Date: Tue, 29 Sep 2026 14:50:56 -0400
Message-ID: <2026-09-29-daily-reply-0013-re-mediatek-crtc-destroy-null-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929031902.88182-1-artem@trailofbits.com>
References: <20260929031902.88182-1-artem@trailofbits.com>
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

> This one addresses CVE-2024-53056. It skips command-packet destruction when
> channel setup failed before packet creation.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
