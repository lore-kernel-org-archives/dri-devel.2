Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909A9C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7E2110E039;
	Mon, 21 Sep 2026 10:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rbleU19k";
	dkim-atps=neutral
Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com
 [74.125.228.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 655FF10E039
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 10:36:34 +0000 (UTC)
Received: by mail-ed2-f35.google.com with SMTP id
 4fb4d7f45d1cf-6a6056be4d2so2274671a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 03:36:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789986993; cv=none;
 d=google.com; s=arc-20260327;
 b=HPyau484iK0uu5qyUilHgN9eULMz41aCwaa4PssoFRExXrux+asTHtu56JhE7J6ihy
 g3T2GLL9KxIXJLCoNZ0Hm4SnKoybBfdMd3Kj4QS7dL8dhgKtSCud1BD8AhDehje2WiTW
 Gb1aaipi88b1vCUltphy303BCQUzuY4NjcR2athHh7QtOEC2HNTZ+VxjM9Hz1bPG0xLQ
 0nQS8nfIJ/kscRmEhwnipNsvZmcCqkbFlme+QQ0tE/USyN2AIr0LPCiUJG7UcAnEpXTF
 t3Nt7tzXdsjMd9gCS+iif735tkLNo9CLaakBtZPuO8uFvxwWgvTB+hCpFH90xRgAnUxk
 bcjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h/tDLQ7kiHFPBmC66BABbwtjlpncgEgg8G3PARGPN7c=;
 fh=1ElE25ED25QabBvak+uLT1/ZwM9sCHcWW9ohHORMhD8=;
 b=FpfKbLVmM31qhlyWQpyr7unnLzfOQqEC+nopM2ujPCfzDlUbeB04vjPd2DAk5ISFl2
 W2/KpHxFLn/noYx3+kIZMSjniT4+8DrtK3zPBFanXFVT9r2BIFyk9xqY4uvKVurB+i33
 a2/QoL4SOAIzwute7NZFpOsaT1BHqpYbpGgRFG3cKPHnjOKnaaj4fsXjTBZeGcx0D24z
 OTZIXM931b5HTzoxXXsGCiDbqAvi+yjCEggLfnBZLPYzIXWDH8PKsNU5LkdQoJI8BJSs
 J1f1D5c69Ju+czPXXmQt8MlIYd9dBYbORofwBkxGRiETjHftMDoqsNeHHJ1Ie2RmGqMO
 YJ3g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789986993; x=1790591793; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h/tDLQ7kiHFPBmC66BABbwtjlpncgEgg8G3PARGPN7c=;
 b=rbleU19ke3Q3Y/QYut6NsSq5tA14KkcSYnnu91xugcQli39/oqcesZZCk3RWgF/QNu
 wDq7RBudj1FD+K/gfiowcSmknFl7lhiWC4dwdgfQN1J2axsm2BZVXlzEBGKp2mJ+fX/t
 IwxgHQyVN5ZgeujxTma9uvab3LGdX9l4p+3AIXOwMn3174pEmc4X8qqUuNSFB+vyLCwG
 Fjlquf+kIQDApKVu7j1Wuc5pF7qWClu7i/n+Dr/66T8TUoZ/bOr7ovO6MhL0rWoqjoPh
 aKSYs+oxyXH5YPcWdslJcAm4MxpJWJG8XIv1MxFSNV2am1GBU4sUshQE8hTy2xBU1mcl
 Rzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986993; x=1790591793;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h/tDLQ7kiHFPBmC66BABbwtjlpncgEgg8G3PARGPN7c=;
 b=hLiU5HV2seH3fEgwJiAk5I+HG2I7SswQOKF7ud1AyigOmoRaLBvOxONjIp8VTaT330
 IIVg2mOOOm9kUrqdIWAllxMTZOIrUhdB/vXYYY9D8kqlVNELZ3swRpdIsDCcK2EZRLXM
 sWVYtRu+0NmPK6MK1/EqJysESJB6ri5zGabO0Hx/Rsuv1q5oOAD67Qmci6+XDtSgAYMD
 TMi0O5SWnXEBbKqhsIuw3yC38wg2MuO/6j0mJnm27d1gghIa++4yKTDilaCzryEVZhlL
 /A/cXOKcnkkzRCxeAdpE9GJQRVLpfo/93vw2F0M3fvzduBAyDbhMJL4ByzNlyaiwPBSL
 iycg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIbFlZO75iKxzj6xK5tWWUobW3AccbMdxVsRpF9WXXpumwwTU1zN9HJ6KdfSegY/cMMQV7DUyCtns=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kgq6jS0Vr4GlPlAqcJnsRlP1Nm2jZ3BZF7A7VT9B73QLGDgSWc
 yGiNttJEKsqhZ81QaMeaEz6P020M0VnDSUg2fF1BKBZ5PbkWAq3WfGsTPdck82aDh2OzUeqTrUP
 onGi3MzG12pGWKkC08sONTli0Fg+1sJo=
X-Gm-Gg: AYBFou0cqlnFp4yJ1u4k7Tz902tL0gXEzmaCBl5GTlq9RzDjrPMo65pui8KcZzJAIAT
 QnKR6MW3uZY6ccZasAxWfjul/NAlLKaks+pRuQFJ4kG+CVauDrlIrpbk+R+bY1ffI+3SnYE3EEI
 2hVY2OSoI1a1naHWLH0E8n+ZLwDvnWXMcSbv5FIa+2f0ASYDRZeYFlJxo+GtOg2BJE/kht+9LGK
 VflWONQ7nq58fTuthb5U1CIA2VKLp0Ql2EBFgG6brpxaGakl0x7CqGk9L/qjfQXXuxeDZi8LQXV
 boO8HuYyDHRq2wTLVHt5wWgfyjlM9t6mkX9VUl/85n2g/VO9s7HwMg==
X-Received: by 2002:a05:6402:4547:b0:6a9:f88b:14dd with SMTP id
 4fb4d7f45d1cf-6aa4f97d7cfmr6238277a12.1.1789986992392; Mon, 21 Sep 2026
 03:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260918175736.355305-1-l.scorcia@gmail.com>
 <178998607025.21155.9680834242820851509.b4-ty@b4>
In-Reply-To: <178998607025.21155.9680834242820851509.b4-ty@b4>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Mon, 21 Sep 2026 12:36:20 +0200
X-Gm-Features: AcwNN1VQ6S9fCy63ty823Nyxcerwh9XF-bIr0lhnPcmyyBWQe3Ulp9EvTrhD9Cw
Message-ID: <CAORyz2+E9LY+6sb+0G-deR8ZVZK_xu+p_hvp8aKteVVhHpeBRQ@mail.gmail.com>
Subject: Re: (subset) [PATCH 0/4] Add support for the mt8167 display pipeline
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, CK Hu <ck.hu@mediatek.com>, 
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

> Applied to v7.3-next/soc, thanks!
>
> [3/4] soc: mediatek: mt8167-mmsys: add routes for all display paths
>       commit: ae0968038f994d6e275f5dc94a27325ee751fe58

I'm sorry Angelo, please revert this - I'll post a v2 with the
corrections spotted by Sashiko [1] later today.
Thank you

[1] https://lore.kernel.org/linux-mediatek/CAORyz2KEfzcJ_2AphkPU6o-YhLAqudCXVdY+LDoynUx_FsTMJg@mail.gmail.com/
--
Luca Leonardo Scorcia
l.scorcia@gmail.com
