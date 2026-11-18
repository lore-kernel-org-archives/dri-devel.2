Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1520606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PmfRG322
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB5A310FEFD;
	Thu, 19 Nov 2026 07:53:04 +0000 (UTC)
Received: from mail-oa2-f8.google.com (mail-oa2-f8.google.com [74.125.231.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C532F10FFFC
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 20:09:07 +0000 (UTC)
Received: by mail-oa2-f8.google.com with SMTP id
 586e51a60fabf-4adadd37264so453323fac.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795032547; x=1795637347; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:subject:references:cc:to:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/RRjWL641RBXdzvfFkW2sLfC2on1rvjj7bWT9M3oy9g=;
 b=PmfRG322xZepOlMj2jkKnDExr0lQwNqzWwwbaPPNAeblIEZObsS+rLtwgVIlJW7K7M
 zMbE1JxthJ6xq/yKFLdPBEtnjIQ5lzf/0sEXHUP9ojU3PpF3PlAANVaIx58yasz/L+bU
 1kOuH2t6de4KVVbtxbh+E172E5ou5adRp078O5OO39wTPN+4Y9A9Ay4UCBRHbjyYayXZ
 Vaaf48VHddoRKYzPsD6SH76QFyPJUyOoyn+FWB2dvP9bSSS87eQ/LiyFhWsjD7QtB7tl
 Ia/bPi1OXfMJFdR1V5NKKVQa9HcQ/d82EKGt8uwpZydddTznp1+vNrn5KgMbR7Dq/5No
 6Cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795032547; x=1795637347;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:subject:references:cc:to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/RRjWL641RBXdzvfFkW2sLfC2on1rvjj7bWT9M3oy9g=;
 b=dX6sE22cMhof6XqDdDucE56mrQimslP15ne/lIZkLNK2FAysrojSmjlKD8emIx6JMR
 MFq6a+KPAXQjMUoBWpT/wo70P7CQHRHE8gGEk3DdK9wmo5FQfa0L7f46vvkqw6LQRsZR
 JY2b3l+tkzNrm11skD0gYCSmpZ3u99IRWeJppj8rKBPryOcaCAAENkLjru1xUggFxOpj
 7QhGeip2WhOuv4TWObSiVuA4cjp4G74O/MVnc8kbOT0msalcMYGQ+E2jTrfGmuhIhKsq
 57yRJlsiwHyVCRTsuhJU1CQadc+kraINhZprc5J/YCgMQD2953UwfZPBt/hRfCiO+gZW
 ZXAA==
X-Forwarded-Encrypted: i=1;
 AL+hErFopb6mrEvpNXyV9Ct5QYZeZpadUkUHqNsx/cOpfFQIzo3cXfN+d/AO/oe5n0plgaiZLqVUBeJvGjw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/4rn42Zb+lCsfUzHCcbwbgFPBD49i2F2vep/5RumbDgpnHbOmF
 KAafLFFsOWaIsdKuBiz4WsCZRX2t+DcjAO1kCBCvg/afv5Bj0A0pLu5W
X-Gm-Gg: AYBFou3S3Ycv7EmpDzYcvDHSJeHN1vQH4auijYsDC/uCQICFn1vocHExlCXkpcTz7Lr
 +namZ15fEPp5yrelPjgRpnn84TyTq/hetD88phQ9CAy5A2GvDkn3t0PdNDeie3/lcJQSB3l78Oa
 QfipJEmljZWgy2txQITs9+P4rt9mH1CjOoajXHkKP/61upYZq73YP/VEcRaSkAqm31Ov/TuAJOi
 0AIebSYvL7Pg9JjudMnaKzzK8C6OGK7DaNsd5T9qPl6cwuz082MneQ9tWoI658/YU9dTUEKFo/A
 2N8C3e3ZPngyua5F+cp6F4G9VZJwyX/sGu9RJRoWdP1yzlb//ZpiSUpyGkMJ71h4rXoVX9VBxXP
 yxNMnqfqHCo1nm+RsR5F/7EzR9M3/PMgDwTU/VtWTJyRivSjh7wQOv+0o9IlPQNpbae+x361HoB
 Sz8tnoZa6YSFYYzGnYyYlsXwLywBp2OfO9I7VstXEbg0L+leBAbHV4gA0qM3wk3AMpQmoVnXJWY
 3uVkTcQRVKX+1a65j+MZZBRPqkhDBWv/bT3Mr0j7CHi8NtGGNiAIvEqsXb21BZdn70++K+d6Kne
 HH8+frHvIXWrHjmzo5lt4PqUlaFVwat4NWlKt9qZuOq9A5L1C82BWxXf2FC1Vy7i4Ww6HGyr+yW
 f7c4xhsO6c1y7RrAWLXlYXrHj+bdyBUxd4FlFFCJ2
X-Received: by 2002:a05:6871:5311:b0:49d:e1d3:e6e5 with SMTP id
 586e51a60fabf-4b75d550969mr3282678fac.43.1795032546658; 
 Wed, 18 Nov 2026 12:09:06 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net.
 [64.207.253.118]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4b7437258efsm3148235fac.5.2026.11.18.12.09.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 12:09:06 -0800 (PST)
Message-ID: <b662ae67-94a2-4e71-9578-d380ba19938d@gmail.com>
Date: Wed, 18 Nov 2026 14:09:03 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: rva333@protonmail.com
Cc: airlied@gmail.com, angelogioacchino.delregno@collabora.com,
 bisson.gary@gmail.com, chunkuang.hu@kernel.org, ck.hu@mediatek.com,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, p.zabel@pengutronix.de, simona@ffwll.ch,
 stable@vger.kernel.org
References: <20261117-6768-dsi-fix-v2-1-6654a072884e@protonmail.com>
Subject: Re: [PATCH v2] drm/mediatek: mtk_dsi: do not enable HS clock in
 pre-enable for LPM panels
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20261117-6768-dsi-fix-v2-1-6654a072884e@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:53:02 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026, Roman Vivchar wrote:
 > Only enable the HS clock in mtk_dsi_bridge_atomic_pre_enable(), when
 > MIPI_DSI_MODE_LPM is not set, and restore mtk_dsi_clk_hs_mode(dsi, 1) in
 > mtk_output_dsi_enable(). This is a no-op for non-LPM bridges.

Tested on MT8173 (Amazon Fire HD 10 2017). The Novatek NT51021 panel on 
this device sets MIPI_DSI_MODE_LPM, on v7.4-rc3. Tested with repeating 
blank/unblank cycles, and verified the init commands complete and the 
link ends up in HS video mode as before.

Tested-by: Ryan Brue <ryanbrue.dev@gmail.com> # MT8173, NT51021
