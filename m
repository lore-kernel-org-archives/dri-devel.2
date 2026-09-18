Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F89C982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 06:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F1D10E80D;
	Fri, 18 Sep 2026 06:25:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MvniT3Qw";
	dkim-atps=neutral
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4419810E80D
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 06:25:24 +0000 (UTC)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469e211a0so477035b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 23:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789712724; x=1790317524; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jt5hpx2+UWES+z68ivJ7kyasbH+hZp5tfP7Ph5RVZI8=;
 b=MvniT3QwghHMF9jQCTfD4rDPk04X6WXrlBL34CWrf7u5llF0vU1TFudiVaawioBWvQ
 LKTYRYMCZBkZJEXovSG1QSr+PRpyX97vTQ1wvSlDD+V0KkOUHFjY7ErZz5c57T28nMIB
 o+uHlxMLU34FfeFM/FWRoPAWpbt1xbNGzOn2WVsDUeAAo3QxgsI7HdoOLsOteWzP3A1V
 rxTP/8ITzeZfmynhMZQeyL1mJz4RywFpmra+Gz7xXrw2Vp4Tbzc7BPh8SLA+sP3selmG
 A9Mxa/QI8pDqCm1RvZhnPwJUh0irByfOW1UIMqpUlcO/SSXBwN+uz7k4jRhoQOQ5hYjw
 4TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789712724; x=1790317524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jt5hpx2+UWES+z68ivJ7kyasbH+hZp5tfP7Ph5RVZI8=;
 b=bxOcbYgwW2WBiuFWim+onzv61N9qXlEbcy+hpEP+z6VQH6GZI57ONQ7x357KjzCeJk
 J72BP7cWBrgpekdi4UzhT3NIMJhRt1hJLw8G+LCOaywvPLW0MMe09jkIHyNU2uAjTPv8
 dZJwUV91KvPz/WbjghcoyuB3aB7sAQWYYb1eUc2sCfm1LgffEUx573UDv0d6aP5fuqzE
 LpzOEjQUQ9yhAh9zf0j35Beyl5nbpK5oEskUUxNgiIakRSKdp4dlBUhk8ygXaIDkcfCs
 JJEzenGapxbBbiFAVqr7NLuxfIGCbEA/klNrDPpmFNRJ2RvkZqLtXeF/L3thGvJl6XmD
 GaOA==
X-Forwarded-Encrypted: i=1;
 AKwUvByLH25g6JzXTsvvS7RPtfmMIbEgEYiLVFpqjw8QMMlCuJE4VWMWb9gZ1rBJ+r1smUQ1OS6XFQppMVc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l/j59NDDa6LRE3vA7ulNzKuU3rJkm3IASu13yPTDH/rB9B2xGY
 XZq1HBt5JToG/KbvfYX9bFNhWzKWSQfZ7DH/PkN8jKkEVMX9WClOOOBz
X-Gm-Gg: AYBFou29iHAVvBfZ61s/ZWHLYOf2OkJvY3iHLhGMwm68bi/ak2d9Em1na6TDDXeqn94
 mfN12WmI5n7vRrgCSQnOTHulDQ+9uwD6ldsZVvTUOhttQzvI2s0J3br27nx0HllXlG8VObAoABg
 pCjYUQFJw+TBbVtvCGMZCXhzF0VrWNt+9ptc6Mm8upr0zYWvm3s8e07oniuSH7wFJjMPuZ87u/M
 ahmOHR5Om7e5hpP9bMzOgd+hLzBk99un51brqZ6YoCZnoQ3Rt/RRVli+vKD8tguSp07xHK75y7U
 nvw0Rqdv85faMQnGGIKNRNHdLR5QhevVsZMhtHFQzfNwmBXV+XStRXBf7lA3lr94z3gpb7QBReD
 j3jQZv3s8acDuZactTXbOtt0ZltufUtgoF1GTP3BdXn4cse0+iy3HOGEcVaOFCQZT4Ue9p7g3qg
 vaOPw3x9MQFQLqtQ4+D9NLYnWepD/uDBHipIFiE1RsU2H8rXbgxVp0gdvOentAf8C9FtIGYMbX8
 UNRXD6WqYwvOZOtjjj4zehSA4U1gAS7R1Cs1CC8XuVsKinFZn1F1eQCElP/PPFw3hISLcm0fkO0
 /vNSfLWBSM4=
X-Received: by 2002:a05:6a00:2d26:b0:857:72f8:dc99 with SMTP id
 d2e1a72fcca58-874dddfd214mr3036061b3a.26.1789712723672; 
 Thu, 17 Sep 2026 23:25:23 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower..
 (125-227-154-99.hinet-ip.hinet.net. [125.227.154.99])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-875dd9e08ecsm311788b3a.53.2026.09.17.23.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 23:25:23 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: Devarsh Thakkar <devarsht@ti.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>
Cc: LiangCheng Wang <zaq14760@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH v3 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
Date: Fri, 18 Sep 2026 14:25:18 +0800
Message-Id: <20260918062518.1824876-1-zaq14760@gmail.com>
In-Reply-To: <1f59a88c-b0b0-43d7-ba2f-4c50aae87ef4@ti.com>
References: <20260529-bar-v3-0-5c2ac1c751ee@gmail.com>
 <20260529-bar-v3-2-5c2ac1c751ee@gmail.com>
 <2bfb73e6-dca3-4d93-af04-3c644929dd19@ti.com>
 <20260616083921.4066690-1-zaq14760@gmail.com>
 <423c3dca-9589-488d-8462-c3d51f05ee4a@ti.com>
 <20260617020926.114947-1-zaq14760@gmail.com>
 <8fcfab0f-6b98-478b-be4a-c5b810fb3524@ti.com>
 <20260731035705.3198816-1-zaq14760@gmail.com>
 <20260916082924.956116-1-zaq14760@gmail.com>
 <0a13ccb8-8817-4223-a4a2-0de594ac8c71@suse.de>
 <20260916094453.1062125-1-zaq14760@gmail.com>
 <f4c6feab-b1ec-48df-81a5-888444b243a3@suse.de>
 <20260917025644.1262504-1-zaq14760@gmail.com>
 <CAFOAJEfnDrGTg40h=R0mfZasroPkrSsmbVmmMA91O9uOzu_gYQ@mail.gmail.com>
 <0259fb51-acb8-4b07-a6d5-2fe25fb0de9c@suse.de>
 <CAFOAJEe_7Cqo_=NWPGyYBTu3mD3CjPMC92ZZR6qHPjAhQws7pw@mail.gmail.com>
 <1f59a88c-b0b0-43d7-ba2f-4c50aae87ef4@ti.com>
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

Hi Devarsh,

Good to hear from you, and thank you for picking the fixes up.

> Kindly let me know if we are aligned on this.

That all sounds good to me, and I am glad it is moving again.  I will test
v2 on the PIXPAPER 4.26m as soon as it is out and send a Tested-by.

There is one thing worth settling before you post.  Back in July [1] you
wrote:

  Certainly. I'll exclude the pixpaper-426m support patches from my V2
  submission so you can handle the review and validation on your end.

That is still what I would prefer: the 4.26m is the only SSD16xx hardware
I have, and its binding is already acked, so I am in a good position to
validate the panel and to look after it afterwards.  Unless you would
rather it went differently, I will send the panel entry and its binding on
top of your v2 once it is out.

Please reshape the three fixes however v2 needs - they were written
against your staging branch and the driver has moved on since.  Two small
requests from my reply at the time [2]:

  Please keep them as separate commits if you can - git am preserves
  authorship; if you fold the first one in, a Co-developed-by with my
  Signed-off-by would be appreciated.

  I maintain the existing PIXPAPER MAINTAINERS entry - would you mind
  adding me as R: on the SSD16xx one, so I stay on CC and can retest?

[1] https://lore.kernel.org/all/8fcfab0f-6b98-478b-be4a-c5b810fb3524@ti.com/
[2] https://lore.kernel.org/all/20260731035705.3198816-1-zaq14760@gmail.com/

Regards,
LiangCheng
