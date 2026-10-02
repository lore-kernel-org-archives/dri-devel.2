Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5445CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E4D10F80B;
	Fri,  2 Oct 2026 09:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vmIa2pxZ";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97B1610F80B
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 09:16:30 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so56347565e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790932589; x=1791537389; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uyzeELAx9pVH5pCQHDGoYs+swgzoejgakWVx8elkkIY=;
 b=vmIa2pxZbWK+z3eYKbYJqO4RZvNjqZX7Rs/jPs/zlug1B32axyXIkH4ZaNdGfqnR/h
 A3fX9W05Na7ApJ3mMYS+zvCYQmpW/gA/kOPyIVO6o8rGoFzXj5TwQkli4ixdAGMiX6gK
 WtRY4lHRQHpJ6mdA4JUbJWif+dpICdWMDxMF4nnDNMcfmh98UY/YbZYFlFoY2d3LbUZo
 UgAZx62GcEO2DSpHkP1DOYbp/tev7MRu61QnxVs/S30DXDtKMz8susitqvJXGr8OG/07
 HCHzFfcJCko3aUDZWmLUFJkmS7km/d49KLqcB7av+mYX/2PTYyHY9pcSLAvpKTnHJI10
 xbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790932589; x=1791537389;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uyzeELAx9pVH5pCQHDGoYs+swgzoejgakWVx8elkkIY=;
 b=j6kX9gS77uIWuqUPSpdtQ2kVwYcnylkrqCxC97vvaoiwbWFJatwndTYbax1ACg/nfE
 qHwbDQavIrn2fA1hhWtbF7gn0tS8Di9Jcd/q/OHsoY5NBW5XpOvT/tL6a8E0p86R3NcN
 M8N/ys+EKvT76vP6nOyT3pPS3EuIkNrmByZ2NdL931wSPCFhDohGiARTgEeRfrsb7M4q
 Oy+ImQJfkDUuXBR8EaM6NUMVWR5JEoKDybr++UEwcAnYrrDg4sXPQJ10p2cD7ty0tB9m
 cqfoujEq86kLwN3BGE9fUFCe1ltNG9cEmM1fyTBBLzaG4dDwsmMLJ56mi1ndXuFZ34z7
 nCfg==
X-Gm-Message-State: AFuF++mrr61YsrkP+OvF1DtffGZPkTOWgL+EDWmsIvGYTW0//ozTXYBy
 N4Qu+F2x3vDGABmaXkmnPdofs4TThKbvdYcIu3ah5pgrZhQ2MsoyNdAUAIgeZSKSp13sZk8SIyh
 insQZ
X-Gm-Gg: AYBFou2p0HeOcRtzFntSTvUysi/F0mbbDLB+suJoMcgw7rGQwkbG7z3fQzcSOHw36dW
 4l/CObDos2qdrByPtX5wjHJkYrDsZnPaQ+KYaYX1q2KGR39Zbl2mEMsMBAZlG3Ehd9S+SsbxCOU
 oPQtRxxGFqq0/YQv8R/bR07xm2oqyQMGrQuDyC9wGDs2vwuA3XngHQ2KbNAVUMR/DnHSVx57Vah
 RDT2LduiO7Kz4fwYzhymTh4Z/wp+LT5B8fbChRJjU811RjZNxqaNmRb0p/WzPDvbtVwpdCBFUOM
 WayUP8hXbM6Ea9C1yihF+KEVMxxbLUvUmvqOO55OAsu/A3RGvFApE9Of3A5jnbq0Vix5k61bn9p
 0GDQu5g5gWOVCTT0EVmAVMaje81xs2DdH+3HNuwp70XYC0mUjaXzSbo838Z19G9BCSoV1C5EABh
 qjvJyuQQeUvqOma2D+OrCHTmjg+f7vxbw9cxKQ3nVHdKYQoOVsRy5wds8AcXu5wtE6oZ4P+GUyj
 cQWoigMaEwP9lXLpEk=
X-Received: by 2002:a05:600c:34c2:b0:4a1:6425:be69 with SMTP id
 5b1f17b1804b1-4a16425bff3mr5735255e9.17.1790932588885; 
 Fri, 02 Oct 2026 02:16:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f9ad6sm4461292f8f.40.2026.10.02.02.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 02:16:27 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dianders@chromium.org, jesszhan0024@gmail.com, 
 Hsieh Hung-En <hungen3108@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch
In-Reply-To: <20261001004940.110776-1-hungen3108@gmail.com>
References: <20261001004940.110776-1-hungen3108@gmail.com>
Subject: Re: [PATCH v2] drm/panel: ronbo-rb070d30: Ignore DCS errors in
 disable()
Message-Id: <179093258722.2282096.3857794392092899182.b4-ty@b4>
Date: Fri, 02 Oct 2026 11:16:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

Hi,

On Thu, 01 Oct 2026 08:49:40 +0800, Hsieh Hung-En wrote:
> If rb070d30_panel_disable() returns an error, drm_panel_disable() skips
> clearing panel->enabled. unprepare() still powers the panel off, but the
> next drm_panel_enable() sees the panel as already enabled and does
> nothing, so the panel stays dark.
> 
> Always return 0 from disable(). A failed ENTER_SLEEP_MODE is still logged
> by mipi_dsi_dcs_enter_sleep_mode_multi().
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: ronbo-rb070d30: Ignore DCS errors in disable()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/00efe8a685658deb7033d68fcdbf0a7e6796352e

-- 
Neil

