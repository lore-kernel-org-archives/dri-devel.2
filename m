Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFBD106F30A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8AF010EA47;
	Thu, 26 Mar 2026 09:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hsVzTege";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B85110EA26
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:02:40 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-48700b1ba53so7035605e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 02:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774515759; x=1775120559; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jp6nK707lR0sQhfEiF0g4y0avkKejqhVvDLLu739Ryk=;
 b=hsVzTegew27GlelycF+gaECtKosGzM/i7WE0bPhuVje0bXa3yujl6Yb9b1JLa7Dptk
 9Fv6FcJL2ttn4Cu6E6A9Ez4FYF34O5rZikGksri+SFiTTih3dguZg4VG0VOl5jOuc1nQ
 UvxDIr+fYGoWx2dVPAWDoNL8vqUNa+XaDGtvjTYrsBgqNr/GPYobkXCuGIGqRf4Sl/Tm
 aHCaKqaWKtvflRygKl+nsm0b0yO5mPd+9CVuB9oc9c4Bw7p6P9jfz9BkJbPh1DIzc/HC
 mR6kHWxf438rMyQ/Wn+uo1bXvLqBGbwJuYc4V+/7RJq20o0RrCKS5sy6U4aR2kXg2HFS
 S6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774515759; x=1775120559;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jp6nK707lR0sQhfEiF0g4y0avkKejqhVvDLLu739Ryk=;
 b=GkRXA0iNj1vIr8Qmw/YvNp4mmwuvP8qjINwUXiWfYBUCIH6cRl58MLz0nBuec6352d
 /Rv3q8qguJs0SccvGHNQlcSYOcoyNOpZnOKuIV3tSaRQJKHpzRiuNNzGeyKgOuIzLABk
 hq4WQrt1/3R5BhUQ5WjT279/QKYQbtnVPewm6NvlYqSmqAFyHsgdFRFthFeLed4U5Jgw
 HbD+2doM4nZTxRbQuyjdkrXxgif5NAOd+dk3Sr7OUG27Baz5ZSKBKLiBpqEvRw1yKacj
 b/xyKZqzJdH7WlkieJuBW+89aKol439BfO8kUs/c9YXWzboigSYI1gue6dTjuweybjvn
 icsw==
X-Gm-Message-State: AOJu0YyiIuw1Cfk7k22X0Lu3d2k2KS5qG/Fie0stSSOiZ6SkhzcBB69P
 A4hZBpZyXfG1XH/FD8q5Zan+n5BYWD0F3Yt4jwW1FJy7N+cB7onGSNrGenF3NKPxyHo=
X-Gm-Gg: ATEYQzyFlLnBmHiaZhFNVIc9T6N4/kicsysBDjCPpTohwIVHnl1ksHXLQ9cbnWURAxN
 PNuS903xte3RCvCV+tfF+4TkP9sPAgBGZ2A1KBvQyWWbgczNy3zM96MYDru9mL14WTXb1LQSlY4
 La/QhiwdoG8HhlUJ6F4bxlvshztOTs6XSNM77Oz0cCXIGoWV0R1PcypKr2mIbQaE7UD5qbL0NKn
 hZah50OjjRqRikS0Y0qPEL/MG6yGFwGIXds6Ieuz23jJCot3P//0qP2p9iS8ZAqW9zOZ4iFqHMO
 q6ddyGperFqc7JeZmIfqt/OSNgr/iI1Qh5vuv6+7Oc5UnPWSXMT1CtmI6A8L7fKIunLaeyu9jIW
 g9Oz/rOBEOLDyNDog0eDuwANQrgfSLv8+x3OELG/SyCz8InXZI7yKAWqlxc2JIWGjT9tnurhstu
 6Pzh0DhVEp03PFkzKd3NxGRApM3dzTi2Ay6TmWZCy3wqWr
X-Received: by 2002:a05:600c:154a:b0:485:3d3e:1675 with SMTP id
 5b1f17b1804b1-48715fd6119mr102350425e9.8.1774515755186; 
 Thu, 26 Mar 2026 02:02:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf069sm6213436f8f.22.2026.03.26.02.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:02:34 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260316084040.728106-1-mitltlatltl@gmail.com>
References: <20260316084040.728106-1-mitltlatltl@gmail.com>
Subject: Re: (subset) [PATCH v4 0/2] drm/panel: Add Himax HX83121A panel driver
Message-Id: <177451575453.103892.12895641333944069200.b4-ty@linaro.org>
Date: Thu, 26 Mar 2026 10:02:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 16 Mar 2026 16:40:38 +0800, Pengyu Luo wrote:
> Add a driver for panels using the Himax HX83121A Display Driver IC,
> including support for the BOE/CSOT PPC357DB1-4, found in HUAWEI
> Matebook E Go series (Gaokun2/3).
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: Add Himax HX83121A
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9f96a50d61ecb0ec07c4133b99eed99b72108887
[2/2] drm/panel: Add Himax HX83121A panel driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a7c61963b7278cbe2c27e35ce93f3787a0d5b5bf

-- 
Neil

