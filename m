Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1097CCD342C
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 02:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B872710E243;
	Thu,  7 May 2026 02:32:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z6FBUlTh";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DC9B10E243
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 02:32:38 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2b788a98557so2223095ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 19:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778121158; x=1778725958; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e5t95QU7BUXyKPxTLVHhF/9f2P0zpBdP+DhDzgoGykQ=;
 b=Z6FBUlThmgb3qdttM+l8dxJNMKUujHFbI2BcRtsYVuDNFYdLdbWi6d34Edi5c6Lquo
 xyYQ7ycI7zI6H2DJE2pk8d/BFvfa9BiJ8XebTSN6zl+iWTvaflm/wms3oaDNN5A8IBhf
 huyMvMQExS85p8lGOcqoIcBLXqJimVmp2zZwr//9QyX+1tSBI4XW5krcGbCGL+IYxn+U
 dkMQtzoMZEUVuEzdQ7gvW04gZyBpOW/MKRw4yhuRVdyyYp6vt0268z/W5ze/1fflaWf3
 m+noGYEF4ydi0zIP7S4FiwSFvzIxwsVrzN0EbWQa7MJ4JuVWjnv4LgOtonVO8P0LMqAd
 SHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121158; x=1778725958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e5t95QU7BUXyKPxTLVHhF/9f2P0zpBdP+DhDzgoGykQ=;
 b=aq4+IFeHQcCLetjTuzj/YagNd1UsCAXowVkW7BOr/bIo/0X/hDgwneGpnVfxbYUeNf
 Z+1zgzsHWLcdMX2SQB0Pu0BnMBdGwlnFXtlxM9Z9XhpJ0eGXNUDS9BU30cp7vCvAhust
 Qtek8dHs0iiDuFs7YJz22iDBMN1op0c80BMr16+dTOD5vaVjfm1xj4GWq7FtVgyxFOCt
 TRd42YQZWHMPaAOQYQvX4uHAE2Fl5P7TpDXhce94wU8Z3ABQHNI/3j0T3srf4mJGUlaq
 ftrYjaRGN2t9cHyY3I9Vn2a+63htXfREIBedslrgUxBScjyXqqkfAzkYzBmZhFCOPQrW
 ii5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/n8/KuikVOe21c+hkJNcfPppZw096qiq/xxb4YIsI9VQ5pYaGFC1SLtCT3pHMIIaCnbhyCNxqMSmo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoIEsdoMUPCOyD2H/x12sl/BGLpJZMWI2i39x13mxDKCkCJ9ss
 oMGcwe0Uyfc6zPOCkEuAYe24CBoJOJKFYU0/ONcycaNqfg4TZl54uLcz
X-Gm-Gg: AeBDiesSxFkxiYJvXqvzjyTNF92KKzBCHtogsUQlcyj+cdr2xAyia94v29UGoqwCecS
 zz8pZWb2W4OJ32p8AYHFIVkvcPV8Y/VJXr8b38R+1EAocpj6c1mBnOcIy8EGeqvSs5pe60+eqPH
 rzjguN2OtOtdnrBGcUeotdsLMffTRTgvMh24EbKBF8BcD5rsu/wj9yTfUeFckXX8G/enyt1s1LB
 ddpIGv29mDvrYb7GCBGJJ1+ozYJJS3g80pkd9lnjBWT0nzM8K6yogLDPntI9FjJ/IX8cC+5p5B+
 Bx6VWoPWjwMmX0IlhxHPCHVW3UvrI8jvgtYel7XyUDXID8XgiQhQrF+Ys2N1l3HU4FIaIQlQsjE
 Auyp653CB2MUXYNdWo9/8bHofDlzW7MqEKoktOj8V2qKQNOfvDCsh0eWbVub35dFpfHIR3ep+RT
 8z0cXSSs66bzMLJE9ECAxse0rHzHirUIBwIPWbfsPFQKgazJFoLJ/nCPrS57VZz/zAzYKVoPRdT
 49cPJP4QvKS6oUA2O9hXlNdqjBpJN8rpxbBFgTNoQhrwQ==
X-Received: by 2002:a17:902:f707:b0:2ba:bfb5:9cc with SMTP id
 d9443c01a7336-2babfb50f2cmr6888245ad.26.1778121158118; 
 Wed, 06 May 2026 19:32:38 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net.
 [211.23.39.77]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2babadef9e0sm5985525ad.63.2026.05.06.19.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:32:37 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: conor@kernel.org
Cc: airlied@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, onlywig@gmail.com, robh@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de, zaq14760@gmail.com
Subject: Re: [PATCH 1/2] dt-bindings: display: mayqueen,
 pixpaper: add pixpaper-426m
Date: Thu,  7 May 2026 10:32:34 +0800
Message-Id: <20260507023234.3655616-1-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506-clique-safely-6dd507d0593f@spud>
References: <20260506-clique-safely-6dd507d0593f@spud>
MIME-Version: 1.0
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

Hi Conor,

Thanks for the review.

You're right on both points.

The new panel uses the same DT properties as the existing Pixpaper
panel, but it requires a distinct compatible because the driver
selects a different panel-specific initialization and update sequence.

The second example is also redundant, so I'll drop it.

I'll fold these fixes into the next revision and wait a bit longer
for any driver-side feedback before sending v2.

Thanks,
LiangCheng
