Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C446BCD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 16:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5CB410E0E2;
	Sun, 10 May 2026 16:50:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="ong2bcbv";
	dkim-atps=neutral
Received: from mail-106117.protonmail.ch (mail-106117.protonmail.ch
 [79.135.106.117])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D328B10E0E2
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 16:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1778431839; x=1778691039;
 bh=1dC4b+FKcQYpdMr+yXIc56zeMpCxVojI23Nfc1p/7Mk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=ong2bcbvCkNNAmc9si5lwFE4QJls8mayJnivKL3Dl9D3pP9eqW+cGbw+RUZKWTq1J
 lxid2i0k5RgLrpZPiLSbl/p3ddcFGpRQyAbJEsYS3o22wpMC5psmEQtCEHNtn54LCy
 58xDmuNVUl+O+rPWB5Djc7ItvowH9l3rDKqb9f/iaGMxquCzXz3Q8sCExy2tg9bZgX
 vYSc0+kXIMXF4T7VMF+FQaur5iLFgySbD0Xx+Oj4VQxI0BknEq4FEd+g4MecRc/ten
 hTMxE5BnI51FqoroD2n0IQK5Oe6FrXmRMeA60samxyPbqOOh9l5rNYwah7AN9o5/TD
 QQOO6PC9Dsscw==
Date: Sun, 10 May 2026 16:50:35 +0000
To: Robert Ancell <robert.ancell@canonical.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH] drm/fourcc: Fix descriptions of 32b float formats
Message-ID: <_2rLKA_pzxUiQcw_7TDdbDeq9igGEiON6u0vYqnYruw-YcNXUgMM94Ry4rGVelyJeFRdQ4ybLkeFWiVi5tZg04pApJFAHI_NSwtUq2KYb_M=@emersion.fr>
In-Reply-To: <20260503235327.92428-1-robert.ancell@canonical.com>
References: <20260503235327.92428-1-robert.ancell@canonical.com>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: b004d5def8404df1476c58bd028c7b7af4ff781e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Reviewed-by: Simon Ser <contact@emersion.fr>

I've pushed the patch, thanks!
