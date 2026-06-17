Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF9CCD98EE
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 02:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD8710EDAD;
	Wed, 17 Jun 2026 02:09:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mYOkZHLQ";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5813710EDAD
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 02:09:34 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2c0c1e0d00bso46892385ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 19:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781662174; x=1782266974; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6fa7wxuUI6ROWGGgOqGoPbRsU6ZtyWphBnp0BvsqR0=;
 b=mYOkZHLQEnDw46YYDCxV+HNHnxnm7Dg99N88RRCVjfbNbkoL8pHegr3XPyiJMZsJzJ
 CcVDaFGSK7zrUiN2YBOS8/0nNwq6qx74rrLfOj/7BAnrxrESFMN0Ey19tRUsAVwaNCrk
 V5LGSoFW+cwVvPkOU6bqqSComxeQDYpXnJsxuEZ1z+GcQpf0tbyCHxa/KUsFPhHP5Eed
 1q7rn2QcYyimtOMDDKSJtuNfnGCffP/RhETiHOQXFZ6XRQqhhm5WvZGhvbqnPccAcF+2
 hc4kIk9QnWQDkPvvFL4H60YQRaaPxFtGNAEXTKV5jihwYywnJvt8tm+SPXALk+u24QOg
 4KgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781662174; x=1782266974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j6fa7wxuUI6ROWGGgOqGoPbRsU6ZtyWphBnp0BvsqR0=;
 b=Twe2ftevJQLF8zaIAwvc72QGCHLaA9aDIi1lCrzr5ZM2yQUFYZd4kPMEi4TZqht3XQ
 xHiT7w6TAsvsLzZQ/8ZzEyaLq8yMH1/S9clgn6R70r1t4sLpkIDuBp3+SkZ6CTWKoVfB
 C90nAArJa5eiW9txkV56zQOVQxssLT5gna28jM6rxfGf8KEe40xsadKh13+gJwxO3w45
 TMZLxEjruj/OpA0nPtatBCe9qr+9CsxAdg+Pr5n1RaOG1rxldGV63q+g3KxoDaJwD7FW
 Kf8rfPSpOgBFhCaUGGl5H8Sva5pQkX6qb7937uHQq0495Tnl66fee48FnazYWOEXpT4i
 qvIg==
X-Gm-Message-State: AOJu0Yw8RJ8DDv0rCDjh15q9zyZy6maA80Axl9eFm4lbWU/CG1BpInS3
 Gz7FnOATOg1xM2Xm42LeZM6sxpMDOimZWE8EghrN3SOOXxIpISV5ID5U
X-Gm-Gg: AfdE7clLHJAvBwKv31iS9JDPEka8/PB6Gtaqxw94vChugFFHqza4+9msfdhc6DbnNyh
 Z+InPOef86NricPv5kA05DxcV9vUrhCw+HGPkPRg1QNfiAmKM3JdJmOymKPZjqoqCMGjyYTatC3
 iDdYPt1L5C4G5UjZt/v4MAsWUU/bDSdqnxufJnGeNeqsz0Ylz3IcDk62FzGX36akxDZku56IHlh
 YLT0smGq9TlqeaL1s1QZK/CfVHj9Dm3YdITEV7xIo+5cpzXLsgE0L9jeA7gNBN6R68nt8vzVXrx
 ffO3a90So8PnwbALDTV3LefEr5fJSSUISar2OB/tAK2FcuubRSgVwcWoG9mX+3c8hPvBQCOt3bq
 DL4bmFiHlToneUgKyHa535W0TTOYWgmF/67FudMacmNLEX+2lYsRRYWcwFhhyVJFpWwjDm0Kfid
 pjJTZZ2ghy5GHiEjmiFim17z+GZlOs4QR3u3AwlR6i8FX5kIOfIRqeiMlwGGd/VB1nEzL3bYdwj
 F5SK/pXB5p0YnfDt0Q62sjt
X-Received: by 2002:a17:902:f785:b0:2c2:33a4:aaa2 with SMTP id
 d9443c01a7336-2c6bc25d4d0mr16653095ad.35.1781662173785; 
 Tue, 16 Jun 2026 19:09:33 -0700 (PDT)
Received: from lcwang-Precision-3630-Tower.. (211-23-39-77.hinet-ip.hinet.net.
 [211.23.39.77]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c433369c8asm148322735ad.73.2026.06.16.19.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 19:09:32 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
To: Devarsh Thakkar <devarsht@ti.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 LiangCheng Wang <zaq14760@gmail.com>
Subject: Re: [PATCH v3 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
Date: Wed, 17 Jun 2026 10:09:26 +0800
Message-Id: <20260617020926.114947-1-zaq14760@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <423c3dca-9589-488d-8462-c3d51f05ee4a@ti.com>
References: <20260529-bar-v3-0-5c2ac1c751ee@gmail.com>
 <20260529-bar-v3-2-5c2ac1c751ee@gmail.com>
 <2bfb73e6-dca3-4d93-af04-3c644929dd19@ti.com>
 <20260616083921.4066690-1-zaq14760@gmail.com>
 <423c3dca-9589-488d-8462-c3d51f05ee4a@ti.com>
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

Thanks, that sounds great -- let's converge on panel-ssd16xx.c.

> Yes, I will be adding SSD1677 controller support in V2 of my series,
> hopefully that should help and after that it's just a matter of adding
> panel entry for your pixpaper panel. I can share you my branch with
> ssd1677 support once I have it ready.

That would be very helpful, please do share the branch once it's ready. I
have the PIXPAPER 4.26 hardware here, so I can validate the SSD1677 support
and the panel on real hardware and report back any quirks.

> additionally I can quickly add boilerplate pixpaper 4.26 panel entries on
> top of my V2 series referring from your patch so that it switches to using
> standard ssd16xx commands and ssd1677 quirks wherever necessary and you can
> then validate and modify.

Thanks for offering. If it's alright with you, I'd like to take the
pixpaper-426m panel entry through review myself on top of your series, using
your boilerplate as a starting point, since I can carry the validation on
real hardware. I'll credit your help with Co-developed-by/Suggested-by as
appropriate. Happy to arrange it whichever way is easiest for you.

I'll also follow up with the 0xF7/0xFF test result so we can capture the
correct SSD1677 update-sequence quirk.

Regards,
LiangCheng
