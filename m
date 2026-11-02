Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD8160A6F5B
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Q5VIPY1z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F257410EE6D;
	Mon,  2 Nov 2026 13:40:47 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA38810EE57
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 13:40:41 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so25672065e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 05:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626840; x=1794231640; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8K5TXnmWR8LIG5Tp7mnH1kUMA0OkWMON+TeHwvlViVY=;
 b=Q5VIPY1zvQBqV3589DqU30Bv2XeM8Po8RrZS+2Toe7dxLHcg6V+EW9/mWUPtxpz7+S
 KduYSUCtS7JlKuDFyVQO7JhZ6XewgzBnVHCjXmJX7I2vNcotQQnBfX7asUN3p4v9wCpW
 qSf8YvMnXTgcifvqfvP1QsS+yiK7wvPAGmEECCJfG41Yx8JfYD9mmOkklg56q7W86Pyy
 AuEWJ0DgxYuNnHVXFTXkubSHcJjEuwOTIMWjDNnuUN+eNAONWMBtkMD+q4rE66Zf/eFf
 ypUWs6rb/3rpuiSJ2MlPYuzOuC5TdIAA5f0jAenYghB1rdnUl4QYXhaFlpbtYAHz2sqf
 T8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626840; x=1794231640;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8K5TXnmWR8LIG5Tp7mnH1kUMA0OkWMON+TeHwvlViVY=;
 b=e81Fbnmu2oojByuiW3Vcd5F0T2/KbwXoItmFpdzsdX0drNs7mDDxaSHiHs7fANeh/G
 XjmlWPJvcyIZB6gFLgiZZ5xiLZrjyz/pLxX5/gTQxIzC4Z0vD/OUQhTeEI7PDqTv8mgr
 TDpE6NraOra8DLPqCLm7//9L5TJf3exgWBM22Wda7eZRZWWZH6cv0kgzmU+jk957GFN7
 3o0ESozyTNsU1GwZHhvPc2wMjyujzQm2tlhS/69Yf5J8j0etLWaQIILeY89mMY/XQueN
 24y3PArZv7SxhRw5Ck34tC/VCq7xbWddKDrGPd5tX0UIYrCXk33RPQgxFpuo+MkgB6st
 zQeA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSPGGlui5GkWrPBxXhx9My9Id+xnpMf0cgm2WSvPm6tkD72pizPVZ/cptq26pgYGWjrpuTg3SVaEQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK+C0u5QKfqJtA4yKmK6v2yol8Z8m9Rm4XcJmwV+Zp8JXDjS6Hd
 PeSLp+TPpCOTXZ6puAhoOQQEQ+sTeB7t9gVfUurlNMv0RUiHHx2mCeyQhxU8D5LyUII=
X-Gm-Gg: AYBFou02NIz9IzIHuIVLKUZ8DHM+iTE3mxgacTKG4oXfUX9IeMA13RylVuGeolLLPIf
 ZQVwsYqG0FnwgrhQhEH10tAfMU3FcURIzR9ZpMOL0/WFSjCrIWVk3JY7+/sheVRecx5wD5hKPcM
 xXfQ15UWhIPR5YwjWarkdKUN9kQWelbzDCsMkS0kJBwFd5qC6Mn2UIG9o8DejU+6ZaqnvBoR11s
 O68hEyZZJNHj/OgM8jQDV1uOLBCKx/vrPXw/8K5vTdarrnhhQk9frSjv2yy6Uk0p7j4vLKuVvwN
 B4tpFB92KrBCVZLqc1Cf0euI+3tr/K6JsON0lp8sAzo0iYj0bwdRgPP4XDufjlnueVUQtDNgFAY
 4TtpWGbSy4oTTZ5UHj1RYgECC5lkqTF996H7EvzqvgUYjSmT64qs1RXM5lzx35vJ8V62BrnOoV0
 9byCBHQrwBPxAkH2ykyGKQtxzCjMmgc0PbFDH6mH1J76Oly/2m+GI4KcAmBPaU9ZcV+337qWcj9
 yXoaP7RM557WK+aFIQLEcGGrM8Wqb8tETyxvkQhsfKhRtsGyE8qlBB1kJ6/a1FS6j4Cz5s5G+3m
 pjveDzQQjbyv29ACDPTOIJjgkssa13WK9YjCbgZW2yb7fHueeA==
X-Received: by 2002:a05:600c:3b2a:b0:4a1:fae5:f2e2 with SMTP id
 5b1f17b1804b1-4ac14fbdd04mr230324575e9.4.1793626839961; 
 Mon, 02 Nov 2026 05:40:39 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abea533a1esm189194605e9.1.2026.11.02.05.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:40:39 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261009-fp6-panel-v4-0-7c3819664778@fairphone.com>
References: <20261009-fp6-panel-v4-0-7c3819664778@fairphone.com>
Subject: Re: (subset) [PATCH v4 0/4] Add Novatek NT37705 panel driver for
 Fairphone (Gen. 6)
Message-Id: <179362683894.3310106.5892756542563969007.b4-ty@b4>
Date: Mon, 02 Nov 2026 14:40:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Fri, 09 Oct 2026 13:24:59 +0200, Luca Weiss wrote:
> Add bindings and a panel driver for the NT37705, and then enable display
> on the Fairphone (Gen. 6).

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/4] dt-bindings: display: panel: Add Novatek NT37705
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/8ddbace1197498d7e32d36db66641b7e1dff868e
[2/4] drm/panel: Add driver for Novatek NT37705 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9ffe0df0262b573c276cc17089d15a08b9b4306d

-- 
Neil

