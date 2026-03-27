Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A9810BA43D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 08:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 139E610E348;
	Fri, 27 Mar 2026 08:54:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fHTloUF2";
	dkim-atps=neutral
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD9AA10E348
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 08:54:54 +0000 (UTC)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-5673804da95so826633e0c.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 01:54:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774601694; cv=none;
 d=google.com; s=arc-20240605;
 b=ShHsEtrZe6vaOcAkIuv6kMogXGETIVQvQR059TKss+EFRquz+subQ60H2sWK17uBKB
 qrnp5clk7FK69WfpKB6Pq3Gh4Mr5ycuUK6ZKOvbpNfAr9Tm1OrYlcJrlSmXSwnETUJ9y
 K4KGw1iLKgLcmOj37NQQsZsixPxsfc3AnxZJpO8QCnKaK8Ap6xdgWNFKIaz9KC/l7H7a
 DQbiOY2zLFSe/gXnAwi/dWAKb2xEWw+Qju6Zr1QI3a5J+XnC/vzdqOKM6jthRPQzFZSU
 yEkNUZ91Tgc8c2ch/eIbTX8WJIhLlRidi4crZ7WZ2NuM/Cha0ESMzqEdwxTXCL3w46b4
 7f1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T7/LugWtiulNbRqHbjrDrHDNUr/Kb287tL6XhNh2/Yo=;
 fh=kCmjhmQ1IdhHEtJ2zd0FrlgLbBj78OBcGHIfPtP2vfM=;
 b=A3LcubDKeSlQnRNrxF7bvpEe/FLlDMqFYI+6c4f8whKJ+9mtz+BhfVeEWR2Nhbk+xn
 xfzW95r4W+lrBMgIEFvj61Hrw+c5wUINAgPVgxZEFmM/SYxe+L6ydPboQ6w1r2DYcm9/
 BbG2caau4rMlNAvZnONAG/uVd4P0zzZ8MyzcvYC+jPF24McPr6NQDMjaQcDbpv/+Ug2M
 D0DxXYIRlAEbBeRaCt1UOalCQCGLKg781EbUZAwDl97k+hCQgGYrl67rrO+7boLcicT5
 RCGW+npjRGAgAKqmj06uL6hRcE9wMeoHXOKgBQ1Shv7GjX7igbBT6o8CC5Wp4z+hCiKn
 eGBw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774601694; x=1775206494; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T7/LugWtiulNbRqHbjrDrHDNUr/Kb287tL6XhNh2/Yo=;
 b=fHTloUF21GZCrUl3iHOeIMGbeyoID8IQ8hkLZjn/c6rAsyvlVQeIn6hMIrxp2h8WFx
 hns53TNEZPTQVPE9qIc2XTOxC24dQD/6GUGaHQJumOAPE6tNSEE9YQfAO62TsCohpwIM
 3LYZeWATMpMEPamHkFXFmfVsFcJOvaAFJuCgV6EU3rRZCOB1KG7JyY30ybimnc5ezhP2
 jR1BCSuqr3TOUSfIT5kEumJek2ugjf34dyOcJDQI+LCo73gUt0yZnt2MEEnOQNpcillY
 z4gj1l7AtM0sdsl/LEaxEYmRMp0E4li7a15aVBuxm3GnWREldJD3sNUa7+psovmwBdKX
 aB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774601694; x=1775206494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T7/LugWtiulNbRqHbjrDrHDNUr/Kb287tL6XhNh2/Yo=;
 b=Z8huMIVYaE6PrSp2zyk1TckGm/tXg0K3G+1+rgXhEcUCevKPLUgEs3VMQFdoq6PFEN
 fQ2zc0fTNc894sQLARvCn6aB/i5A7MgU4dFb0Xl0jWym8aA26JF258WiXXz4xXynuRVQ
 TdNMnotCj6doK/AkJTmNEgcxIOniriRXAY6Zvp/bTw93iDDJMjg75Gq2X1vyAMqYMUS7
 cfVexVxd6qGrUWxoFkBszcMnQ2FFigWoTkIyn9ayowYNwTs7AeBqPTKLiQUEl5J3S3Nz
 zCoJgqVMlYYsSsR7qLdCnKqw9yLMVaQhYWmJiNGaaVIqmVx2Yao9MNJQ/u18+avJ1OdS
 iIGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX4uisd7SVJgz0EpdIPTnPZcVggYI/spST1/1n5cA0rax4C0jTcyvKXwbmrQ2dxFCz+BiV41ylJcI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTRTgpSRhw9Me7fb9Dy3FoLljloaRyHRuVxVP6JTj9XCiKMv0R
 QxJOnPxMNmrUDOzh/pcuMxTIMpLUepAzBa8G3IdDwS+Cokox+Q6jkwAg2rF9rlp2sk3MNk33RbX
 UzbNKZQG6AhKz9TeuAiTpPFh+oSAR7EU=
X-Gm-Gg: ATEYQzzeHriDfrxufQWnInfzDvzXzc8PK6iNHpla6JHFCDhjxBOGOyqQhCnL8J0xzag
 yE/4+KpFmh+ACkEolY20L4Z3wZcbzSaymDbxjc8NzKaYbC+Wo7pTZzDSt/0e3seaeANK2NHojOC
 koS8jCwG+Zsv4mhfGexLPW0DuS+G5Wem43d4OwnJOD8q6vnQKrfo5h92TNsnhkdLQUW5mJ6dj5c
 Rl5F1YUnf4lwKaCQUKQBYEUoAC/X67R0/rXwGyAXaf8NdLnGwY9479yq+5t0LSZpH+2sGBTgtL4
 Afribn5m
X-Received: by 2002:a05:6122:e202:b0:56b:da56:b261 with SMTP id
 71dfb90a1353d-56d4a4fb92amr503443e0c.5.1774601693586; Fri, 27 Mar 2026
 01:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260326-bridge-v1-1-c0c44b53f7b6@gmail.com>
 <DHDEL0VTRYDP.2D45EP8E07Y08@bootlin.com>
 <20260327083404.GA2993961@killaraus.ideasonboard.com>
In-Reply-To: <20260327083404.GA2993961@killaraus.ideasonboard.com>
From: Amin <amin.gattout@gmail.com>
Date: Fri, 27 Mar 2026 09:54:42 +0100
X-Gm-Features: AQROBzDFlUzYOMqDS-iqKRxv8JNsRUoTNReh_7bD9RMr7xj5BSJFZudRHBuQdZI
Message-ID: <CAHfa7xXeRaGw1ADFsuT2dcqkY+KXb9w_vi4tq8G6ehOS9r7cAA@mail.gmail.com>
Subject: Re: [PATCH] drm/rcar-du: Convert to of_drm_find_and_get_bridge()
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

Hi

Thanks for the feedback. I did reference commit 7282066e55347 (Luca's
earlier conversion) but I should have been more cautious since the
patch I submitted was a bit too simple/"dummy".

To answer Laurent's question: I did not test this on hardware.
I was working through the deprecated API TODO  list and made the
mistake of treating this as a simple find-and-replace.

I'll send a v2.
Thanks for the patience...

 Regards,
 Amin
