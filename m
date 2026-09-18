Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AB5C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 23:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F39010E0F5;
	Fri, 18 Sep 2026 23:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="V2EUdGow";
	dkim-atps=neutral
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com
 [209.85.210.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89BAB10E0F5
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 23:36:06 +0000 (UTC)
Received: by mail-pf1-f227.google.com with SMTP id
 d2e1a72fcca58-8699f9fd466so511750b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 16:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789774566; x=1790379366;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ntk2CWh32Ga1v8+3feA2R++RUDSg5e9QTrLv/pF7Lgk=;
 b=q3YUhFGY4T87WReLp7/Y68yKHc6oQaTv1qcCyJgYf/EAAOohH7ke9DPslKpsYbYMA3
 uq/o+2w6z9ZU4YYWHtzghxX9mDmybMVJpi3HEsF3lgUPfB224Kyw2712/qByDFUM4CKy
 iFWCs5ptLMP0hcBcMD54/SgonfPunxHVR0ijN/c86EubCx9MITqzFpDkWfMWz9GZ6T+d
 ylSvni8yFUAS7RqvgoC18l8Z8XEMt57vM/Y0rMWQrGVLMnqqpvoTXLzkiAfBN0FV09nB
 K9jVWZxtDhhxw3t/O4SDBk7Y9GmwpGznmhjN8fpmoghp6cwMA6sungO3YgtH/oQZ/Sjs
 Sdmg==
X-Forwarded-Encrypted: i=1;
 AKwUvByMJerhsaoCGfXjRZ6yeMr9S5/rsRkY3+TY0jGAJzo9fOO4iBso+aug3p29Z6MTYQu5ST1Pt7/G3uE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lwo3uqWUKFHpfLhPdEVzqSYIneDb8jFNc18JvuViB2ppd4JXTo
 564GkC2GD83l7V1hzz0TJLAPRyIgbxklty4v+gwpOLJe9VxzT5v4UbfZfJPiAkcMbGc9zrrHIOX
 reuqvdjZiJXsEfSzKlfFOAJ90ebaurqkVKZn+5OY4N88LHjJalHfDew+zRbc25fd2kSKGwxB8aJ
 muZlJWO52gHL9cY+P0yPY0weqzRojrT1uHL7Fed3xW9xxCGmgIWUUOggixbO4hTPI78Oah7pyde
 V1V0RttHJBU1Zo/VffPFEVGN2Je
X-Gm-Gg: AYBFou2Bb91wFKamsW+agQtq9meXWcYW/KnNmXi1aoCiDfuQvzW5k52G5NHbW6TAa9T
 VyYRAeB4XA3++B1ck3trKe2wOZ1rss+lmpxo0DRUFo5kfKExPtUAxIOzNqrviN21k3u+xyOH4fJ
 FkjImrvpPizMib0zDIDOvPuqeWSwlUGy8AuHRUSoPQXZlS0aruOmnE7x7ybjuAhvrAeTXTBFgjj
 UdQRsFnnZ+85iMkBSe589HmhWeBOBx5Kek2xUtDUekaZH7azLi/56nEzvvAqtxXyF18lF+QLMj2
 /bAha92hEAklD0U/RaP743niBjiSQaswrbRp8GkTVlMxBcOwFbaVVFJoc+3Mt0qFeFA4xOZoFg0
 zClSesFARMMMFcAtN22eulov9WXwSZLYBr6G/Hpcyl0l8qPRcgRCNEqFDHzGavHMHlFqvzfef/k
 IhPlthnSIQD9dz3nHyaxK+nxVkVPwUW5K6N9AgZfe5CKg=
X-Received: by 2002:a05:6a21:482:b0:3dd:a196:539b with SMTP id
 adf61e73a8af0-3dda196542amr1918074637.61.1789774565767; 
 Fri, 18 Sep 2026 16:36:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-cc72acebf6bsm358927a12.2.2026.09.18.16.36.05
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Sep 2026 16:36:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39deda201bcso659269a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 16:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789774564; x=1790379364;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ntk2CWh32Ga1v8+3feA2R++RUDSg5e9QTrLv/pF7Lgk=;
 b=V2EUdGowarlemUhhuqBHHvqBHGjDSbOzK+kKxuNRIBBvKMjMaTlX8ak1fXpFR9XspH
 jVIm5KyYz14tH7JiV0hL0hOre/RoCAKcwc0usAdRegjKsgVPJsSnLm/4LPkFaKJdIAJV
 bmVrlZEDOwBZiZqwfgnxkthHG+SplQIitSEUQ=
X-Forwarded-Encrypted: i=1;
 AKwUvBykwjc9QHCl1IE4h6boMA/8Crc2j0ZFBpuPNCXZgfpz8sCHfOzRLE5arzonJ8cf7aua4icqqjpx4pI=@lists.freedesktop.org
X-Received: by 2002:a17:90b:17ca:b0:393:19a3:4f1 with SMTP id
 98e67ed59e1d1-39e54cb43c7mr7837835a91.6.1789774563822; 
 Fri, 18 Sep 2026 16:36:03 -0700 (PDT)
X-Received: by 2002:a17:90b:17ca:b0:393:19a3:4f1 with SMTP id
 98e67ed59e1d1-39e54cb43c7mr7837811a91.6.1789774563362; 
 Fri, 18 Sep 2026 16:36:03 -0700 (PDT)
Received: from [10.211.247.235] ([216.221.25.44])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3311ad4esm1741803eec.5.2026.09.18.16.36.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 16:36:02 -0700 (PDT)
Message-ID: <ac49be70-f10c-442f-a4d8-54075ffcf8d4@broadcom.com>
Date: Fri, 18 Sep 2026 16:36:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vmwgfx: Fix GEM_CLOSE returning -EINVAL for
 PRIME-imported surfaces
To: Claire DuSoleil <claire.m.dusoleil@gmail.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
References: <20260917181312.12473-1-claire.m.dusoleil@gmail.com>
 <ac19e380-e93d-470d-841c-7bd3f2b0b86a@broadcom.com>
 <CAEcBvW0+SqM2zHbaDS+JycXxc-ztzvixKtHVSVQby9viVH=+eA@mail.gmail.com>
 <CAEcBvW10sKwD2+Ro6o8Fq_9oLwsedq405f=gjQ+OMbY72=+VFA@mail.gmail.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <CAEcBvW10sKwD2+Ro6o8Fq_9oLwsedq405f=gjQ+OMbY72=+VFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

Disregard my last message, I had not seen Zack's email.

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>
