Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4358EFD5F8C
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 07:09:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A9810E537;
	Wed,  8 Apr 2026 07:09:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arduino.cc header.i=@arduino.cc header.b="Ieu6IhqZ";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B24C10E0F9
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 12:53:06 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so9310435e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 05:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arduino.cc; s=google; t=1775566385; x=1776171185; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCVkgvU8wrx3yykBBPWnaa5epvqaL9BLmZRlWagspkE=;
 b=Ieu6IhqZx7JvW8LDDRF1aGPKBYAn2O4GEu+mn6vJJEzQrS+DDLHLZ4wL/HqyP9DgPu
 Jcr5pmRo/n8Ym+26GiQ2CJD+uTaurd+Ca58PwRkv5VA8ggoadr4kD8IxgOpL75qJqy3F
 iWRcj3rTyyagZek9wB/JpnUPHumdkH8j8aoTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775566385; x=1776171185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RCVkgvU8wrx3yykBBPWnaa5epvqaL9BLmZRlWagspkE=;
 b=nheGpGE2wmQ0bX94jeGsC9jcB0osTOp6tSwIHEMgrarppHq48T+oW1JtYYJCfq1hT1
 ozYZMpicgYEd4rZbCSIxBVTYxbIvjRyIi00ClZWHaP2+TiLlkJlHtYevLdr1u9y7FDsc
 uDW4Ap45tKK+JsdO8iuvt7W//qCNlNPOKeGMUI1/pDkdHN/EPOrJDvMz2jWF/pHTa2nh
 ByXITCcbvykhqk9Hmc+4K8Xy6iwC6l+3k/20DeVuA3k0aSV75I1qBqhAhpY4y/ARoW34
 /zKsmESjVrBvh6SkDC+KCgAUn0rgeEr4dnvlFOoECDLZRLleyHkDTFl44q1DVxhwXGHd
 ndVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4rvR0y1DvECfZGuQIQWR5SWwUs5b6r0yvj4TXrfuHlCzaHNCLBsxq1yLgpS4H8QJuqrLL/9yq18E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+S5+PvbR0R20i83IKHsrBgb2gAUr2HHfFiVj7tIhOf4iyTVIF
 u84/bVOAlr6klx+6HArb4yy5z0lF1rAU/I/9XJqfKkBN0QSDmocYXm2dBJZxGnU1/2A=
X-Gm-Gg: AeBDietOHPONkPe6+2+d80h0DkUuKE08u4AvP5vTwp+8s9w9m5go1me2eTWP6LIKbai
 vbDTo1pTSylZGH8q+W3Aoah40hgNYO1TvIPl0WyvRkGOitJFi+xjwjZyT25nBodITsTTaSuyT4R
 gtLmmPhrM04A7NdEaMrEiG2W6nJIX1reTaTObPBVEEsEBI5hkF9wUa2A30j6SIXjFT5bjbg2V3B
 ud5+AU2kIWqp7d+LjKMZDaVmw1+ctbl1nmUpY1yG/if3MaJ6oD+Ei0Tkasib5/VJNk1hoXd6VOU
 6a2nyPcL+Mrb1zLmo5CztQ8S3SXeGIM65uSWu2Fj+rIGlMkEIWAv2l6fGeeH3j6ltR7+RR6GdSR
 Cum4OnB4HEgvBx4nK/TbGRg87py7wIyeiTq4NMLndS/OjqPrzt8UP58aIH0sHYY7K50bdCDG4K6
 iwODYLXfkbonttFZ1A/p9XN7+ZaZ3R1EiaVhEegIhPpbfWYdN5k0LIp+INr/YYzfujydM=
X-Received: by 2002:a05:600c:c8d:b0:486:fb69:4960 with SMTP id
 5b1f17b1804b1-48899794fe6mr225654285e9.19.1775566384726; 
 Tue, 07 Apr 2026 05:53:04 -0700 (PDT)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488a8ddfde7sm416273855e9.5.2026.04.07.05.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 05:53:04 -0700 (PDT)
From: Riccardo Mereu <r.mereu.kernel@arduino.cc>
To: dmitry.baryshkov@oss.qualcomm.com
Cc: airlied@gmail.com, brgl@kernel.org, broonie@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, jagan@edgeble.ai, javierm@redhat.com,
 jesszhan0024@gmail.com, krzk+dt@kernel.org, lgirdwood@gmail.com,
 linusw@kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 megi@xff.cz, mripard@kernel.org, neil.armstrong@linaro.org,
 robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
 yangcong5@huaqin.corp-partner.google.com,
 Riccardo Mereu <r.mereu@arduino.cc>
Subject: Re: [PATCH 14/19] drm/panel: jadard-jd9365da-h3: support Waveshare
 DSI panels
Date: Tue,  7 Apr 2026 14:53:01 +0200
Message-ID: <20260407125301.282253-1-r.mereu.kernel@arduino.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401-waveshare-dsi-touch-v1-14-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-14-5e9119b5a014@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Apr 2026 07:09:52 +0000
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

On Wed, 01 Apr 2026 10:26:33 +0300 Dmitry Baryshkov wrote:
>From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>Add configuration for Waveshare DSI panels using JD9365 controller.
>
>Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
