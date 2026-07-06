Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3540AC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FB3910E343;
	Mon,  6 Jul 2026 17:30:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wd6dZxqf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B627310E343
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 17:30:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E69056138B;
 Mon,  6 Jul 2026 17:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3FE1F000E9;
 Mon,  6 Jul 2026 17:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783359020;
 bh=Odrk/M0uzEm06cV07YV8KYxA41sO4LNg6nGCO1QYWbA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=Wd6dZxqfLTij3E3ieK9/A/CoDuen7mpydkFdkhqPhOg0DaeBl60WQuThd6GsVfabH
 IOaX4v5EHfYicBSXFw40C0eLYNv0OIl/Fr0GxAqLfg9R7uMk3YATC7VxRyoZNSUnyx
 LMaGMJgC5cRSjkR6USf/b31dzx1lvebBQ+ejbtf3icth/WsE97fPukMT/F1o/+jrVw
 iX0yhdUXUzHEjHJISW+32BRRxMjke6TBaCSckth2NXTu6EUzXgDsIyoidO8NqLhpou
 XiFPb2Tyihcxn86x4DlE3lCGN/j+O4EAvTyjE4wOm1zqNn1gGcqxTtUVJpMOjOQI+i
 xqNbsUC+zHPyA==
From: Chen-Yu Tsai <wens@kernel.org>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 jernej.skrabec@gmail.com, samuel@sholland.org, 
 Wentao Liang <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260607030950.83636-1-vulab@iscas.ac.cn>
References: <20260607030950.83636-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] drm/sun4i: fix refcount leak in sun4i_backend_init_sat()
Message-Id: <178335901812.4027169.1529206377701282403.b4-ty@kernel.org>
Date: Tue, 07 Jul 2026 01:30:18 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sun, 07 Jun 2026 03:09:50 +0000, Wentao Liang wrote:
> When sun4i_backend_init_sat() calls reset_control_deassert() it
> increments the deassert_count of the reset controller, and must
> pair that with a reset_control_assert() call to decrement it.
> In the error path where clk_prepare_enable() fails, the function
> returns immediately without calling reset_control_assert(), leaking
> the reference count.  Other error paths, like the devm_clk_get()
> failure, correctly jump to the err_assert_reset label which performs
> the missing assert.
> 
> [...]

Applied to drm-misc-next in drm-misc, thanks!

[1/1] drm/sun4i: fix refcount leak in sun4i_backend_init_sat()
      commit: f7a56ff6240e6fd0cb36a3c0a911a1cd54789ce2

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

