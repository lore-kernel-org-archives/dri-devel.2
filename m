Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25276FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 20:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80A3510E872;
	Mon,  4 May 2026 20:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kYc1bz9Y";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF42610E872
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 20:48:19 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-449e96a8a80so2603989f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 13:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777927698; x=1778532498; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jF8Q6RoPGmOljbJrevjIunF771/iJgvq5ngDUmVs95E=;
 b=kYc1bz9YcXsG/d5hrDhGNxgge+urZhYpKg2/+rY82KmpDV0vvIutgu+YZvPBohVk7t
 W0XvbUI4RzSKULtpkzzhq2UFIgrs4ANcUivEBot4EmLqNKjzxuDTIF4I5IJjZ45Q/Lpt
 asuzRdVWbi1HUpF+nW6vE8UhdPlVymi0PlEAwngIiXBxR7usXNFfopKatURT+RrlAcSY
 aEDfLb1pc70x0IBfK1QuBGrJvCRmzS1l58On1GfPb6VKgyXds9FTa0svl/Iuvb33GdIV
 BaZ4MskLN8EaqQKrLDc8A7e2ICpxTKm7V0yENYRlDnW41+Yvd2YGwIqabSX6Dyb2Xa/o
 NICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777927698; x=1778532498;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jF8Q6RoPGmOljbJrevjIunF771/iJgvq5ngDUmVs95E=;
 b=oCKXH+NFx8wKMbXQ5qdt79N5K2OvkDElvQUTlr/Eso+6u8C3A4rBgUxc8J6mbAkyay
 gW53tlo1urY21xzfDQXmEMA15eU7cAmDTN1TTBIlSqO22s74rUC76Csto6IXyeVtKjG8
 8wn3Z9QU37DX+3F7uDIuQ5Uo4Q4rmBZAcFsZBrVlD+Xs9Scg9yOUVUABO1CvAEJ14se+
 Q5R7elr2iXirN/xVJHTzFvL2+1h7/zrDB4NB6Hge+F+Bcqgm7v3L1K2Q9z3eR44egHVT
 NDytmZZwnbyfyiETajhUTUcX06r/1sI8zjFKhLFWPdtr+y+h2Si1lmg9ka8pG/ujmf1h
 VYpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Slb6uYI7vpnI46VJCBPiMIUqLguVIcydrmk9d6iAPVuQMpx5k4A2PF9kCOBAjyO5V8xBJnt5+cvo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIMnEXnE5gee18w4Hw1LsHxVrnwNNkh2dAEZOMuO9Gaa947Oi/
 P2jBMcwdHRLHJR8VePuP/gy7iYMUvPVAxILIftzfe/ac6y/9oTk4SUfo
X-Gm-Gg: AeBDietlfQjqJcPs/neJOqBzXNck5vGBf281jtezqFrB2wFyLy9Q2TcpnDCrrVf5z6F
 A3ZI2ti8pC5XU8BUp78MVb4HYuAKU628DhGNh3DTNxko8menl4WYCPbMsk3IM6ol0zaqzQW8rLx
 BwmqLKFmcGrg2+xB+z/I5T3tpyyUPRwSuO+QL6+W8bMMBShoU7JcLoHNJz0d4wubQtwjaNLyy0e
 ahtmzS40lgcLTRS+hsRUvcjv9CC982OEXP+kfI/ikluU4dkRhE44EmMOOSD/YC1PdFCL/67cv6v
 Im+IOjBk/+0HWiFYk02PP2eEnhbuY0oL1GV2OeRw1JIqQXrCwinotKQPUSyspk6CTiugoc/j4Vs
 jGziFlbjYs31cXEHP6JvAvbFPdnOJs58etIZXyphaJUmFcbhaaTmeAgtsGMQvKP+WGAD4QwTPif
 XsmMmIBkBhRyUB+MChlUmvtaH/BjxsXt1n10doSmZVtaT/VWgtVHXvHJdEfPv1vgewjZzRmdgRj
 JTZOmRJ8VK2h+RGTDLV
X-Received: by 2002:a05:6000:2586:b0:43d:7b7b:ab76 with SMTP id
 ffacd0b85a97d-45003fc719dmr750576f8f.10.1777927698004; 
 Mon, 04 May 2026 13:48:18 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:f99c:d6cf:27e6:2b03?
 ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4502865baddsm38791f8f.3.2026.05.04.13.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 13:48:17 -0700 (PDT)
Message-ID: <05dd01f4-186b-4358-b90c-36dde16036c7@gmail.com>
Date: Mon, 4 May 2026 22:47:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/exynos: remove bridge when component_add fails
To: Osama Abdelkader <osama.abdelkader@gmail.com>, luca.ceresoli@bootlin.com, 
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Hoegeun Kwon <hoegeun.kwon@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
 <20260423200622.325076-2-osama.abdelkader@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <20260423200622.325076-2-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 4/23/26 22:06, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe fails after
> registration, and drop the manual drm_bridge_remove() in remove().
> 
> Check the return value of devm_drm_bridge_add().
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> Fixes: 576d72fbfb45 ("drm/exynos: mic: add a bridge at probe")
> Cc: stable@vger.kernel.org
> ---
> v3: add Fixes and Cc tags
> v2: devm_drm_bridge_add instead of drm_bridge_add + goto remove_bridge
> ---

Hi,

Reviewed-by: Raphaël Gallais-Pou <rgallaispou@gmail.com>

Best regards,
Raphaël
