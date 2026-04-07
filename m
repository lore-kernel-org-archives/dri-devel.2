Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FC3FD5F8F
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 07:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A22710E55A;
	Wed,  8 Apr 2026 07:10:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arduino.cc header.i=@arduino.cc header.b="RV+fQ29e";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E4110E412
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 12:51:41 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-43cfe71e5d3so4396625f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 05:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arduino.cc; s=google; t=1775566300; x=1776171100; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MWfccEFrjalT/iz3u7SOUElkguUlZhU5FGjm0QzY0lg=;
 b=RV+fQ29eo3xJtcAwDYzDjq4oh1I3IWK/y+OgQpKprLTJ6SaG13p7EhJv+0HYaNsB5s
 lL0+f//kUCv8OngIybNcENJ8M5hp7aDTFLagLJZQS+wvFHwXBSM4Q6HerMlFVw1VAy+A
 VZoZk8SYmo273aFlBSbpDtyFeW6Nnfoc1S6BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775566300; x=1776171100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MWfccEFrjalT/iz3u7SOUElkguUlZhU5FGjm0QzY0lg=;
 b=nVOO7ONxDJ/f6rWuDZLSf8FQmXmDcd0il1CRSd0sKntxzKdp/4+1z9I89uwmN8uxAR
 3PbuaM9t1iouepjlzW3Ib92RmdZn4+jhCgNj7hdcZ6npPqMiYQX1PFj0teOXvte37wEc
 wh2axQ5+b/NSlr5CTQciabdRhomuuej3FBsyqQSzfxvk0SJ1sxsnKfGiNBZkusSLPpi8
 hkZnpNXfZzKZG/gSXVp/SJgO31q7WqO2zdshCbl0v1OczFla6+d1XEkl6buSfBj1zHIJ
 /Uwfn18cg51rkVMKEN6R/ig3h1Ex38Vxj30sr4wtjW/oFD2wDohxY33me4UhVYO77LXX
 Hx3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnMJZSVk6zUCVeHeqisSgNDliGoMjKzi0Q9QitxyphxOYaAV6D3Ik7vscS6R7ZJEAKnT7As155flg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywet6LyYoTln+FKIAkpiYR2hcAYVq4zYYX2UITHMIJFDZIDbCQ8
 T+7Qy7k/vGZGHfTgZR2SjTPkuvHO1NDlAhf6/R5LsqfMpy3J7D6jdeEOXwMb5wbHBcY=
X-Gm-Gg: AeBDiesokxBGajtWp3hl7x/eyhs2Mehku+M8jppWh3MfKnZp4Eg0EPExeAhkryYWq3a
 82IQoGlsP9tn2yb3OWG8HqUWtOY/xBZ1c5ApS1bm3ai7IgJpzt2J46GiPglT7YbdEhkB6umHkq3
 PMqPNVkb72GpbMqPFrnT0MZF/KQkuM3lWJsku6TtLYBMeSZHmCR70GyHIUjy+1H6bfZcy60YeOs
 b2LFKveG9CwrhkCPdgPh/mWXnkJRKVeNbHOp1MR17ZuGQB9L+SImHLF8aXwPmZphx8wXnzbZQ1E
 pg/fr8wgvHE57lPSWIpbefyVmOft+MTCiVBccdJr/KFH87gOEL3zWDzufmZ0hVApgnrQSXKEr/y
 bktAYeYgtC63bD8LDrQGfzDqWZOtGEJYLO23qUUUODOq8WE1iyB4uA8EtZ1qo9KnTBZfUU74UBJ
 m1DtrzOqrrB95CgHhXc/hSkLzH1brRSGBR8B1fGbHRMM6ivYp/SaOJIIS1
X-Received: by 2002:a05:6000:40da:b0:439:bd70:610f with SMTP id
 ffacd0b85a97d-43d292ecc9amr23145975f8f.44.1775566299767; 
 Tue, 07 Apr 2026 05:51:39 -0700 (PDT)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f843dsm48085402f8f.37.2026.04.07.05.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 05:51:39 -0700 (PDT)
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
Subject: Re: [PATCH 12/19] drm/panel: jadard-jd9365da-h3: support variable DSI
 configuration
Date: Tue,  7 Apr 2026 14:51:36 +0200
Message-ID: <20260407125136.282109-1-r.mereu.kernel@arduino.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401-waveshare-dsi-touch-v1-12-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-12-5e9119b5a014@oss.qualcomm.com>
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

On Wed, 01 Apr 2026 10:26:31 +0300 Dmitry Baryshkov wrote:
>From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>Several panels support attachment either using 4 DSI lanes or just 2. In
>some cases, this requires a different panel mode to fulfill clock
>requirements. Extend the driver to handle such cases by letting the
>panel description to omit lanes specification and parsing number of
>lanes from the DT.
>
>Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
