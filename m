Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E11BCD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 055D510EEA3;
	Mon,  8 Jun 2026 08:03:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=compal-corp-partner-google-com.20251104.gappssmtp.com header.i=@compal-corp-partner-google-com.20251104.gappssmtp.com header.b="wvW4DEw1";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF7410EEA3
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 08:03:19 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-36d8b644473so4011316a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 01:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=compal-corp-partner-google-com.20251104.gappssmtp.com; s=20251104;
 t=1780905798; x=1781510598; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zanz85K4/8TxlrNE73/GXv5T9BKiwYgHbBpZhaDMKjg=;
 b=wvW4DEw1FETy+j+fQspwWF6ccpyBmNVyleeqt1O4bjFmjoponIPA7o+NJuGZYG7NI1
 boZwkcYHW94W2adV+q8azobbbJMMN0DRqfo1BJA+JU41iQw+zzv7q08Hta8v7jYPq25O
 Qo8l9OasF6wY0CroEsOIPXSjQm/QetXeUzwJ47g3c4D9KG43uQKLqZrCUDY/+OWslpxH
 VNEeDMxwTSvmznoDnTxpuT5vDIGFhTcp3X+HbGlbxYrZkkoEapGQKoy2VC8UWxEdzD/u
 bJtyDi8secGCRmGE6iIF4khgN2IHWum8Q0ixs9yZ76OxIXYUDVYLYvtag81hO9KVH7Tj
 Sphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780905798; x=1781510598;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zanz85K4/8TxlrNE73/GXv5T9BKiwYgHbBpZhaDMKjg=;
 b=oHu6rmkLs8Jw4ASkG6yccPOdFcWXgwb1JX+lygjdurismDpI2qcSGS1JGXswmOl67N
 rvLEu8FcZuKErrdNENLQc27Kz6ZoiltJOiw3Fi/8gC8NLewiBy7KUjh0cugi0Q5vKKsa
 49Ilwj8E085ElliaJNLrhN+lugKSzT6UoWazWKKsuPgVEoftSeZWIzByR+bpAcLk8UEv
 EblpW1RswMqs+LouOXKTcxzYIKJEKEtaO0JKu6EL6mm7JcNWJhoaDERsrNmXvxVp6jM/
 vrrNVjz65CFj1jnjDOSTiddo3hyP4jbb5lqTjeVofEZRVrk4Of/5ocMfPTLWdQ25T/cm
 7vfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ94IOTHkK6QXj/K/0qCsboL7CWkyk4QL/Vo7flvg3BfwKmWXTCdX5cxgjkYH6bgXPRBzpbEUEuHqHg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSPY5om5jwYrZsP3xz5AcjaUE1JGMlR34FOOvt1bV6K8K0udC7
 xxTxaGjR/mupyGOZBD0CWk55vMr3O96tTvl0dC0h5TBahbtzxZSOHZNtBAqDIdnR9h4vZmLgjAa
 pCXC7
X-Gm-Gg: Acq92OHmLyVKscsPNZf0qhS7+7isj3hL32CTXeXlzj1Z1u6cwA8JY1ZqVRQioGto+xX
 Eqg1j9VtvmQUcVTa8fRKt4EeJWnNTyiQRAZa0HfdfByrXXwkoC+F+yb4p0/B+kZHrds25RufVu9
 ZybUJvYu8idt2HxPxe557kjcvTO7cygPf/LiKzfYLtmVUfr62Zb0LUqIpfYO/xUb6/bQ69DQr8Y
 1fZf/trTvv/PbFbnHkTym5d2ZsvOFxMOj2i7erA2t957UHuaj+45kvlkjW4VZEvXIFkTP7O8v1N
 fktcSqJkAHIq8EdAkrtminyAFiFiWbu4Tc0ZnRrzkUG6XC67Agm+OhcEQg6grE00YCP1PS9HHiX
 bP7y8YSEmJnGl5UMYZoDEgmk2ViK0dEN48SH5X1VZqsGb9JRqIEKqcWgXYI+WMGRAFM+kOQp8ZU
 2ZzJfbxXL6ovBrFkynIjy3yB2wHSlDnbeFi6RkDH/JztXTtdRZ5gOHuCmMOefZKTHAyWgRHBsmm
 7vWlDSD2YduO2OrbKmUQbx4xJsG1aw7dH7cX9jZ97UBpQZ0/t409TJmtw==
X-Received: by 2002:a17:90b:3fd0:b0:36b:293:68d1 with SMTP id
 98e67ed59e1d1-370f0772017mr14940764a91.16.1780905798576; 
 Mon, 08 Jun 2026 01:03:18 -0700 (PDT)
Received: from terryhsiao-Latitude-5490.. (36-231-165-24.dynamic-ip.hinet.net.
 [36.231.165.24]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f68b03ef6sm15262168a91.0.2026.06.08.01.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 01:03:18 -0700 (PDT)
From: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
Subject: [PATCH v1 0/2] drm/panel-edp: Add AUO, BOE, CMN, and CSW panels
Date: Mon,  8 Jun 2026 16:03:08 +0800
Message-Id: <20260608080310.15126-1-terry_hsiao@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
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

These patches add support for new panels from AUO, BOE, 
CMN, and CSW to the panel-edp driver.

Terry Hsiao (2):
  drm/panel-edp: Add AUO B116XAT04.3, CMN N116BCP-EA2, CSW MNB601LS1-8
  drm/panel-edp: Add BOE NV116WH2-M30, BOE NT116WHM-N21, BOE
    NV116FH1-M31, BOE NV116FH1-M30

 drivers/gpu/drm/panel/panel-edp.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.34.1

