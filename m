Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C514CC9830D
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 00:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04EDB10E4A4;
	Thu, 24 Sep 2026 00:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cKUjZt/t";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55F6710F249;
 Thu, 24 Sep 2026 00:21:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 785136021E;
 Thu, 24 Sep 2026 00:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6959C1F000FF;
 Thu, 24 Sep 2026 00:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790209277;
 bh=erfixCGc04ItABZY4UtzABRXVPZWrXkdfNMP0O5k3A8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cKUjZt/takBa/iKxwVIrnm9O1YjZ63X9aG51go8lot8ycD6xEncH2a2JrP0RRePSu
 IGe5jPUuTHG6ws8zlNgLT/pDY7DTUcVvNVx0+1fg0OFja9QmCEgzEynz58cA2ytw9S
 4hTd0liSd2A7mlWA/Lp2JUX4kGtL9r+T+TATPvBrkY8ivaXLGaHhye+NArD9+xjKJC
 aCKkHEi1HxV0VkH8fRbZPZgV2cabgaRhiKnio4M7fgP/hs8zEM+AgnpTEc79g4G3C+
 9+gBnm7K7XkMX9KViUAJEKMJwNghIbe+M9/Riewgzauq/Httoy7X8aQ7oeplfav94X
 8Q3LoC7u3ahoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Johan Hovold <johan+linaro@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH 6.1.y] drm/msm/dp: Drop aux devices together with DP
 controller
Date: Wed, 23 Sep 2026 20:20:59 -0400
Message-ID: <2026-09-23-daily-reply-0010-re-drm-msm-dp-aux-depopulate-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922200127.27433-1-artem@trailofbits.com>
References: <20260922200127.27433-1-artem@trailofbits.com>
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

> [ Backport to 6.1.y: the source change is unchanged; refresh context
>   around the older DP bridge layout. ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
