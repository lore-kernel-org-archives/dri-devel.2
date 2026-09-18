Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E460C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE20210F4BB;
	Fri, 18 Sep 2026 18:36:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S5eMFjf7";
	dkim-atps=neutral
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A27E410F4BB
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 18:36:57 +0000 (UTC)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a605c198fdso1613722a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 11:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789756616; cv=none;
 d=google.com; s=arc-20260327;
 b=F0yRVXuWaZ6GCrwzC8YPtgicZhQu/vuOygAyHjFa1M7t88YmR1hNfN/OVO9yqLbDIL
 cSZRJtKooTsjSGX/snJff4oy18qkrdXfHGeypBcjaCNvD2idTXrQ4wove8QF/lbusvcR
 lI6mQSlWUev2THLHxTiGM4Slers9wi3+OTzzAl9DxrBVP3rewX7VTXv222oTp+jtTz1O
 /xPbSp7K2XVF5GVhLKayEM8CS5kCM+WQe2m/cNVlnyBgvH0eDLH85DkejA/XSphxmoKs
 9VqH27Hi+zyMLtHO7zkAgYd/KwrZn5qssinNgbyL+jJCV/2uSJiNh1eW0k2zsVV2K25I
 TWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xkCUHEW8BaYz+mvJmpvhPzJPz+lQKTKEiJB6NksDW9o=;
 fh=CJVB6E2pXXSbKtIC6x+wrVFme1y9haTpsNhjQiPjfjA=;
 b=MNVAWyJAUgNiX1vVsqTPQ4k3HXT0NL25PBdliAclNxnIXATQkn7xDgT2AK2kaKzbiE
 7NRYoh+8LYEaGfQjhfOlD4mf6Q4Al4E9FOJWk+lae2+Qm0wYr9olWFXlHTyhqGH9u4jm
 YbqQj/EPsGAUQfwq00n+0n5Vnz1bKkadCkjuinZpeA9fkfSauHJ6YavjN66r0i7UMipR
 QJbxJauwlQkGfSzU2CsxeZOC0c93xTs78Y3TvR2MvhurPxY+DtKhCacqksrOzkk7HpK3
 EtkFnG04qAVWoI01sy2chyZZDrNscj8skv/S06Ub30adtyS4lYoFRScEGvno7jZCrOwP
 6cxQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789756616; x=1790361416; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xkCUHEW8BaYz+mvJmpvhPzJPz+lQKTKEiJB6NksDW9o=;
 b=S5eMFjf7SE+05G5CQLHnI5lGpX0GJt8MjysyXj3YH1OeHZsZ1L5PHOejM5em3HkcXj
 TJKspQj51IsJL66Ju0U/t+LF4OVL/+0HgEvC9jLA0A5ASy4AiU+vZ4zyt365u/zexm0a
 cUYNWBxhlT/lCEIE1XmV0+aBqAK0LShXulEJRVMHupVrYOYFzkohFSTCYl9MnfhiIwcj
 haw+AbAvdsQg1VXmME9Yhs93lEh5B8ZWKmFw6/zWy+DFSPUF5pisKDXByNO0/3LkvaFh
 V8R0AnYW6wsiX7OPO23I7YrmKHMqrJARNID/fmD2N8DrAk5tgwGcLzyi38vy2xsEcd84
 XrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789756616; x=1790361416;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xkCUHEW8BaYz+mvJmpvhPzJPz+lQKTKEiJB6NksDW9o=;
 b=oD2Bz9enkeC6DQ4OcZxrPzAFGcgp2fLORF3GAzpw8PE/Vfgbr/0JDX6YJbg1+J2+JE
 ndIhZmOHSMMsL6UnQTcJ4i2v1BxqV+Z6aAzT5l2CZQLZXLuGtoyT3xIlU2bwZJbHjZDF
 FqFCZn3r7iVB30xIHPh+omw3yZ3/3LTnzrCnUMEENaM/zMnJt0Pa8I3xhBtb6ibCYy9w
 zAvZnnO+bb9We3p4Ul8QMp3EUxrGjgtAMMgRcLezCiyT3OmgjSPnk9SXpnlrkxivzDvX
 +Cw8/kmxQ7FMjd4njJviPHgGt2UbD5ZospKCK7XIBoCvUavyk1d1sHQuJtc9UIt70/yk
 D2JQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUSAWQn0a4ahPjgDp8zo6s/X14ky0QCVKkqSDb0SxcJ9KZBypkRoGn6dHzUhaN2lmiubbq7cqEZtA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mrRvWhYXx8j3KUmHo0qSAikVcYE3kHEQFEhkrjrK2QD3YTOmZW
 1vTthZgY8gxilmuVbrHclDM6iOESsURBU4m7q8Hpw9HqqkLTu9kA8Wq+zS+9SvZ1rpBFCE58C/M
 E8v1LnqByfEgo9LseJN7eNmEPBX0oRa8mcFut2x8=
X-Gm-Gg: AYBFou2mD/jSrm3/GHHMwE1bP0Y02U7glVC+ejAk5o1YAqwyS3yt7zoKKNXjcu7ttCe
 0VaFvQBzMKND1zFT5r9ilJLilSSyGlcyWb/bszUCzOfS6Lw99/LXZkFAKVBBvZhG/7/Juzj2225
 P6y44OF5SbmnUlUjJeKcYf6lJF20pFdKKenV/mbrAXOfTyGihZKuoo4unG4xmt6BtTwHYDa40dr
 6vYjm/hX1bdGUdSZUz9i00GFKREiU9p9Ux9eVCTjQr1eRmO3x8lZsslqEst+yxmlN/mI6KWdEqn
 Xv8dXtbmfAMlT1ev18/5isUpKki4yp/EDGMt0Pphxo5W1AgnTajTQA==
X-Received: by 2002:a17:907:1c0f:b0:c29:d62b:fcfa with SMTP id
 a640c23a62f3a-c2a156590b7mr346464966b.2.1789756176118; Fri, 18 Sep 2026
 11:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260918175736.355305-1-l.scorcia@gmail.com>
 <20260918175736.355305-4-l.scorcia@gmail.com>
In-Reply-To: <20260918175736.355305-4-l.scorcia@gmail.com>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Fri, 18 Sep 2026 20:29:24 +0200
X-Gm-Features: AcwNN1UQFOY_vCJJJdBRj6O6gZ3zFhbPbxWCZbiFNcjPHyL_aMs2Ld1pz8hUFJk
Message-ID: <CAORyz2KEfzcJ_2AphkPU6o-YhLAqudCXVdY+LDoynUx_FsTMJg@mail.gmail.com>
Subject: Re: [PATCH 3/4] soc: mediatek: mt8167-mmsys: add routes for all
 display paths
To: linux-mediatek@lists.infradead.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, 
 Jitao shi <jitao.shi@mediatek.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
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

Sashiko found [1] some copy-and-paste errors in this patch that are
worth correcting. I must have checked it a hundred times but they
still slipped in.
I will send a revised v2 after waiting a few days for additional reviews.
Thank you

[1] https://sashiko.dev/#/message/20260918175736.355305-4-l.scorcia%40gmail.com
-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
