Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B132DC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 07:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20DFC89954;
	Wed, 19 Aug 2026 07:26:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kYjdRC71";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2ED989954
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 07:26:08 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso818522a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 00:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787124368; x=1787729168;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AVGY6Up5GdAj62b5bZd0v0FXpSOWgb2LDMT8oCViwwc=;
 b=kYjdRC71AzFEXioQ7p1yDeL6SvZOHyZfcV0jduRCw25Y+4igIpnvuZrsj7mNOVCAnL
 F2iYAyymwvmVGWL3bqhc+ITgiWVjDoyamUmT7clg0gBBYen2FGvzv/7cwCHj7/fY7fV/
 WPra3N4Ms+JEW3R24ApONQWzMPfn3rV1bkIAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787124368; x=1787729168;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AVGY6Up5GdAj62b5bZd0v0FXpSOWgb2LDMT8oCViwwc=;
 b=XX8y69p2zm8l/tl4t4qndJupeSMEl1LGi85AJSwaoscty3/9QNTRvPamh42uizLy20
 o1L2W9b8NqUllEVuCJtvF13x3T1fhp/2vctjBpjIC7w4CNSuMCyIKCt03CI6Ixqs93Pt
 rCXOmLT3tzD6YmcO9Fz1hZDxbykb+bwOp26SOnYQKj75WGbK4TMa5swr0EKw10vBWAe7
 ptkkSvt934QRW2qg2PwuiYNjV8UuT+o6xBKI87eEnWkPQ1lLgA5v6OyLyCuVUk+DZ5mV
 aL9Q7FWmCjdyju9C2JhbODUhPU9Gq4TMBVuBiblt8vk2//l8oD+LW4MpJ2VaZ6cccZVi
 X4Qw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpschZKF3m/ZcAuywe8Bhrx4bvwxgV3bOUm+c6pd5qdBvSEwlMURVUsriNz1czjVluZhq/IS3y8zv0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVjxrD7Qtc325JPf4ZDEbfnu0gLO1B2wld9jbcSRXdhUVqLNN2
 llTOF0OhG5bmzVf74ak8Wk30zZhRT75+tdLOHQzmGHwum0lFCUXwhfymWSepoFvnpg==
X-Gm-Gg: AR+sD13FJFK2dqE4GkGcFf1buK2xBVOex+yNOzqA/L+dxU7dPOvXURwrLXu+Z0VualS
 VMoWpVNHVfA/J59EyMwa4CiRbKKf+ENWB6JVYxGQY+SnB6jfshKa79fj1hNTK25p2/cf88epbiE
 f9BwJaAuNvVjWS1ChTA9336oxEuVj7FXfyCDcLRZ0NVBY6XXi9NzrzY8kLg4oU0EEpXR3weGVxe
 bnQnKpH35S5GIR7lc8wh/QoLOA95meaospy7ozNVbeoxhbY/FpBCClbO6FXwWyrQ+q+5nnQeUle
 YDPUPhW1L+3b15X62eB5lGfVWN+AKyHp1MwxlncPTst9GQxAcOLDbTxbgXnjqnZWSpFNslBZwns
 AzAJQaGHUhTpkgAhZ5ex2JQcXplEF96yphrNwBfSNvsb9d+TFot/CfAdIuY0bJ0Y7rJO8j+IaC6
 YScNzdwyBQKqKiUgoFz6GsyOiIFM0RqARW89sp0t2m64I6fYY/MU/wGKIskfzkV+ZMwfFFJv45j
 KvVHJ70i/kb2NIWR4/uBpOmX3MxQg9HJakmjkRgRs1kspE=
X-Received: by 2002:a17:90b:57cc:b0:381:a766:efcc with SMTP id
 98e67ed59e1d1-395810e93a0mr5159464a91.14.1787124368191; 
 Wed, 19 Aug 2026 00:26:08 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:201d:8:fc89:e860:bd52:2181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957f9ab8besm1588671a91.6.2026.08.19.00.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 00:26:07 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Icenowy Zheng <uwu@icenowy.me>
In-Reply-To: <20260812154829.671777-1-zhengxingda@iscas.ac.cn>
References: <20260812154829.671777-1-zhengxingda@iscas.ac.cn>
Subject: Re: [PATCH] drm: verisilicon: fix cursor offset field update
Message-Id: <178712436551.483858.6257003457851836320.b4-ty@chromium.org>
Date: Wed, 19 Aug 2026 15:26:05 +0800
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

On Wed, 12 Aug 2026 23:48:29 +0800, Icenowy Zheng wrote:
> The 4th argument of regmap_update_bits() expects a pre-shifted register
> value instead of the field value when it's used to set a single field,
> however I forgot this when writing the code setting the cursor X/Y
> offset fields, thus the write operation doesn't happen at all (because
> of the non-shifted values being masked by regmap_update_bits()).
> 
> Fix this problem so the cursor is correctly clipped.
> 
> [...]

Applied to drm-misc-next in drm-misc, thanks!

[1/1] drm: verisilicon: fix cursor offset field update
      commit: 6575bb5d0d3c7db0d7d293428ecc07cb38e46ecc

Best regards,
-- 
Chen-Yu Tsai <wenst@chromium.org>

