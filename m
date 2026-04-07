Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56DAFD5F85
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 07:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8599910E532;
	Wed,  8 Apr 2026 07:09:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arduino.cc header.i=@arduino.cc header.b="DduO+mLD";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71A5310E0F9
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 12:52:03 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-488c2690057so2701025e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 05:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arduino.cc; s=google; t=1775566322; x=1776171122; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MLG70cZPHbMVCayA98g50Pt9/HRyo+CUlZFeaApT25E=;
 b=DduO+mLD6F171fZ4qHXcqmp0+hhBTEWRFS8Phql5FZPCrJqwF8R58qC04wsFBHSw3J
 phFDyV5nXfNOpfmaWbKeTY0bKpLTScjknbWe/tdKqjZeFZ/p4AbuxL27ffk1Y8Q/Ynlm
 HfNWOchk3nuufwt/fc3pW+ilv1VgjFceVFUgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775566322; x=1776171122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MLG70cZPHbMVCayA98g50Pt9/HRyo+CUlZFeaApT25E=;
 b=N7YkNJieBIjiEGJ4R4I+IAq4/1Y3T802iaauO74HIdafW1p5Cp4eEBAoEN9ADIRzKl
 84S8IAyrNGfxxltXH7hyhwSefF3+pM2Jj2w5aqYdKGpUB23+qljC2IjgUQ4Y/TchzRWb
 FpahNDIeF+7NCUqxYBOOs466cW/LhykkmNwvv2Bac7gAsG9FnLjq6df8tlZ+hGwd9HEL
 C+LJq8sX3wPAqAW7NJ6retPlBJpX7msoro/UW3UeJm2f+6epmDeo19A9w8E1ZDlU1zCB
 JNxPVwHnqdzXASt9qXcHyYTDEGQmU9f6X6KagagwkOhcywGJyEbQgCGCrLMPkV2+o8JT
 zPLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4faUwG0ngf5FcWtMGTN4WmySjcvVPq8DVezQ7pYSDm0CkppHqAUH5ee6pwUFI/IlCT83+4Oawzuc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7SvSD5kKUDu4+ZcT0/95rrWBNYNtZFCXTzvmcdlENaG8a2Yg3
 gp9FKKSHhQkj3uhmlGv9rGTQJYAKwPp2FkzXVc7yT5wvxU/nAdb3WC06y2hoQrbNxZggEFsZk/3
 eXH3m
X-Gm-Gg: AeBDietxa91bXO69/6U7HnyUgPQOelRgVyCV3PSoVJTNTioOQPTKkNOpQ19uDy29/XZ
 QUDAUBmfOqOpChniG+JkzZC34qFp88G+keWqxQiOQuCBsJRXd9g/wfrMLjNUqmUoBf7e3WYMhbe
 01HpUjI2FNQ3BqBM798q3BAX0yYziF84D3rMS+vac6L0KdXbE7r3K2GVqeGXSFr3QMr82+pM5C/
 eTfPHu4u4xfRSuG/T1lWaTnfzd8xu9DKCdgli9uLpPZ6fXueVaDzLNr3QhKgvNMXZerwRVvspdb
 P7T7BYkyP3VZ3Uqm6kdkVk/ji0HCcOY+wydLmMHuRCV/BfTIWG9fkTgFnxbP9UWDxJ8pGNzRNiA
 Tn9D9LamfrVCiuacJJ/9rF9U0ffcqjlT/vUb8XubiZ3QCCpvu3xyYKiIDsJz4fR5l1VnAtAaFgR
 Ud6GmDS2/mvbw5DF9V7tY/hBLAp0bcWfEenTjIsh13lxIZZGxAQtMPNYzj
X-Received: by 2002:a05:600c:3b18:b0:487:12c:e7e1 with SMTP id
 5b1f17b1804b1-4889970dccdmr220831905e9.11.1775566321939; 
 Tue, 07 Apr 2026 05:52:01 -0700 (PDT)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48893f39027sm365288315e9.2.2026.04.07.05.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 05:52:01 -0700 (PDT)
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
Subject: Re: [PATCH 13/19] drm/panel: jadard-jd9365da-h3: set
 prepare_prev_first
Date: Tue,  7 Apr 2026 14:51:59 +0200
Message-ID: <20260407125159.282144-1-r.mereu.kernel@arduino.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401-waveshare-dsi-touch-v1-13-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-13-5e9119b5a014@oss.qualcomm.com>
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

On Wed, 01 Apr 2026 10:26:32 +0300 Dmitry Baryshkov wrote:
>From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>Sending DSI commands from the prepare() callback requires DSI link to be
>up at that point. For DSI hosts is guaranteed only if the panel driver
>sets the .prepare_prev_first flag. Set it to let these panels work with
>the DSI hosts which don't power on the link in their .mode_set callback.
>
>Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
