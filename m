Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5434AEA71A4
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 02:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94CD110E02D;
	Mon, 20 Apr 2026 02:19:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RLgR8U8n";
	dkim-atps=neutral
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB89A10E02D
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 02:19:47 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-652fcd5a6d7so2900364d50.2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 19:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776651587; cv=none;
 d=google.com; s=arc-20240605;
 b=GEBOgK6rtbRJXAZd1RQ7sEF/z5AGHjYHjkmIGCa+PN6dSDw6cxym5TXVKZYhtf3UYR
 snOvSUirEUMZfYkzsM+SaG9js4T/dxWcRdEp9E76fnD7Sb1HYRh3mMcWLsWN2Rcmcfam
 UTFyNe9gzLwQebDAdBUC+VRCjGR+wL/VCbJ9DDwdb/s+BJkWQBl8Iw5m9TdVrsTWr89G
 J4HhPKumwKlrTmkm/fNkZxdqOW0p8SJfdR7kfZEcLMcGUCGLBmNErZcN52D1Berlspkd
 8peAGOeZ2uzJILBxR6O0TJQx8/tRXyU2NPonpygHWnwiIpjUEQVJtx5YZPWcfugQ37Hi
 YBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Mn2XEI38VK14s4TDNjxRsEErkOLyfZwZt+XdGzTxUC8=;
 fh=0P8os1TCXDsC33DqTmclo63NAYLG2GYCKBcvaDmvnX4=;
 b=HKODiuHZGbderw8qXkXcCajdkuc6wSW/aBo8zZIXLTsqJTBic4T/9Z+iu+tYA9914/
 nwOCN4Emp7d96G5QtMQZHm16goA4kxbqMEtkHIazHPkDsRCFNWnxT4okNQgsMwgHQ/CL
 NYy0Zx84rdnxxKxBlQYHxWqnzknkGwrioOKPb7BVL7TqmiydadK/gdIuxOh1Efe6LKAI
 WFKN7DK7VQoBeOXFOr1iehUbshhbCdpoPLia0X8J4yEmGzJkOJHgFR5JD+UbFvSmuBDq
 HShzCFHTzxKRDhZWFws/hdZaAezMLTKHeDZ3Ah+PEEBDKSB0MT5RLCJ9KiOjOPu73v8g
 ECqg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776651587; x=1777256387; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mn2XEI38VK14s4TDNjxRsEErkOLyfZwZt+XdGzTxUC8=;
 b=RLgR8U8nKj2NGdDTD5U10AhiajvcaN00zZsansMkkk+SldhFGZ5ZsVIWNHqj887X54
 JofAbbbnMLMu0AzYTKSVugtUy67w2nEy4DcOjczWD/r3/h1hEYNzAzIscYUX2C+Ycg/1
 769aXr57vI3C8V8bpx8xzlgew7GPiX2SIzpZxrRklDITXgKUaOzTGUjnsxFZHmNWPxti
 upABBc90MgBc2VVIh9RISZdy+k7Rg3ZVDn/8aDeD0Nr2X6FWSK3zwUeNt0dFM5Hxmt79
 pq2brRpltNJORAd7B3BYPtNubGXzn1o2pP4n1cJVNy+4pY9OY/byPwvZ3t6UXsjz/BUv
 /Gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776651587; x=1777256387;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mn2XEI38VK14s4TDNjxRsEErkOLyfZwZt+XdGzTxUC8=;
 b=qEE+Sx46/QBks5FXNoerbeCBzzL9z7+pEn+NcKqhy6eWAR/K22Zpz+1/rArNXZlFii
 8khw+ZJ7SNcYob0aDnSZty42V9YfZeO7NWYgMy2mlid5UbGo3J1rvPbTmvZO6sP1LmzP
 ocNCastkr4ljLzyVjy/2d6NL0lcAFwVBgbEj3BbiI4FU4VMKLCLze0OTL2U/GNQumLy/
 4q9ahLGFaUR2UQB8pnYS+QuXu9dEQkCTPJgVenZDJ31GQK3ZnhRMTa+Wj1gsOi/3WTPM
 KWzcP7vqCvzLxK/P3zKByB27G2sJnzSUQ62sseqvxlt5kIpEppqQlXQuBUV6AW6uJ89H
 9HYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0xjT+5aa9EXCmvmn3VSDK96cxgNl1T4yMwg1VrQaelcMyh//cpeCVOUZaDtqrrkYI3WZgCmxcEVU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqzjmLae4W63XGnf31B9WyUMwFShFQbVEAKnJl6TJTri2XSe7G
 xauWXuRcsAFzFK+U/L/dpLcw+9qNo8Dfo0uHeMiZIDmfYZVwe6rKUKgA8PjfNYs4WSJf7HvyCMc
 J17JggbeQdx+ZUtRwD7SYI5H5a7kgoCg=
X-Gm-Gg: AeBDievRckvNxj+xToCAra6VTaxe3axOG37F2yS9CtrHlsc6Iy1Bjn4i5qcXuKeMoL7
 JoxTVGUt7g/UgWSVXxCx1skb/bZGdJSA5rST+uItvXO15A8exHy3i4P94tWt0sKHOTybuguVuvz
 Ujaz0dCWUtj7n4d3N91vCMn8G7X8f7ZrffE6flHI+1VQcnnsqp8QfvDLsR5Nv5EHTTMyqDHDPUu
 Xd8Qs0n9uBJS7bjATmj6aM1Uq7+sTCX6Ge1AGiSuRQqlFsu7XzQ6zaC4HjsmzK4FnNXjkX1V0mS
 Ulb2MhrcXvsmL6DAjyIW
X-Received: by 2002:a05:690e:484d:b0:649:ef06:161d with SMTP id
 956f58d0204a3-653107f8e3bmr7151345d50.12.1776651586801; Sun, 19 Apr 2026
 19:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260419122134.97529-1-lgs201920130244@gmail.com>
 <aeWHyhp43ZbgXwFe@lizhi-Precision-Tower-5810>
In-Reply-To: <aeWHyhp43ZbgXwFe@lizhi-Precision-Tower-5810>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 20 Apr 2026 10:19:35 +0800
X-Gm-Features: AQROBzCNElVyi3SqTu0MlhOiyhEx1DKejewgDVxgHgM7RX0rIbL7rJ3aJmlWlyE
Message-ID: <CANUHTR8FaXLX+Nbeb7+sWRF9jQ5SoBgWc2y_LVD38KE7TqsxeQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: imx8qxp-pxl2dpi: avoid of_node_put() on
 ERR_PTR()
To: Frank Li <Frank.li@nxp.com>
Cc: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Frank,

Thanks for the review.

On Mon, 20 Apr 2026 at 09:56, Frank Li <Frank.li@nxp.com> wrote:
>
>
> Please fix
> DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))
>
> If (!IS_ERR(_T))
>

You're right, fixing DEFINE_FREE(device_node, ...) is the proper way
to handle this:
if (_T && !IS_ERR(_T)) of_node_put(_T)

This is a better fix than handling it only in this driver.

I'll rework the patch based on your suggestion and send v2 later.

Thanks,
Guangshuo
