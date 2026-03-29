Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6736CFB3CE2
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6F9610E1E9;
	Mon, 30 Mar 2026 09:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GP3ZO4rJ";
	dkim-atps=neutral
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09EE310E0B8
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 12:40:43 +0000 (UTC)
Received: by mail-vk1-f175.google.com with SMTP id
 71dfb90a1353d-56b7043c97eso1443807e0c.1
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 05:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774788041; x=1775392841; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c0kEe1Rl3NUbuO8HBz1EskGI0OnkWpimiV32NPIfJZY=;
 b=GP3ZO4rJpTyKTXxM4LeHTY1aNoRkSJzWWSBqPNpb4VE2EMrPFgebXe7itrsim7KUrT
 dtFg4O5QlxEk/B96Cwcrd9X6AtBiNJtc3hwC5XYwrdh1jrNc40HGnmVE6O5T1zaSwEKX
 NnzJVsAzOFrPshapQRnmYU2pDaskg/+t+oGuAXs1VN5hB+GJ6qIKXOFBIAdz7p4aJafs
 ARrLokPw3X3lOrzNgXO+0lS7bcIr+Fhkeb8UPWfU0TcWQpAvZHyAz1O3YT2HZpAE+AiQ
 tQZq9SmM2yswbQjHPh7W9qHtyNVgzZRpZ0R59aW8k1j+oEYN3yh+3W5KHy6jFmBhznS3
 T7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774788041; x=1775392841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c0kEe1Rl3NUbuO8HBz1EskGI0OnkWpimiV32NPIfJZY=;
 b=HwLDu6CYxnATQcDjXy5DCdUqnDMjf9gSV6rW5OqhFxfyBwCZPoNWTwOCdq7ji20Vnu
 QghsOr99xWsGRigkB3mxVfzdXpGGZsTXZKaFsw59PHsi+nXGUvnoVbINVUlXSRN6UEMt
 NRBbVs7KIP4Lk+vMSilGLaCSaA/HKvG/gsGsEe72I3rRoWmQ0xwDtPQMRQ29KY20lbcW
 RgfClnRpx8mHCFir9wtoUAsizHXInL2tDMMNnc1AVQiTtY3Ysyeg/qWEnwmzr3qTjow6
 9OAdqNX9ql2tszG0AdmtQ/Si5bVKIclk1QWX7EqgJWLeNperJEStCQZ2AeQhW06+Uj56
 vo6g==
X-Gm-Message-State: AOJu0YxdakFBNu1b5NvKxxRiuAL0rxpba+71lIEj7bo4RBkJlW0xuNPB
 BBUWurac3SHGGJHo5fH+eJqoL+hoH1fJ/Y0xxDG0utIDrB+gt7/2oaXOlCiXmmkr
X-Gm-Gg: ATEYQzyNv1tpbHCu6AeHU83lwPADqx1//YAjLhcX/i0vp4QMRvzkYAMjmsklUb8DPRZ
 7pFN+Fg93dDlPKAki9jKE1qSiOYQY5Rbrk9v/5kKVgoTlHk5Og96FAn1UAXwTnXLnDUjDMaDj/F
 PXBYB8qPixqtCtHV06trDDQl4/ciBX2t2k0AHpml90NthfEdHCUj+U6v/A3qFSo4SSeRg0hobZL
 fGHdYAGOiMLBZwGhnYEJ1LBfLe1uLViQpBND2wHmQZJjnTFHcrLWcswHws4pHN66w2q8gech5Za
 QvxigEHqZ82Lo3qtsRajbERoiAnsCbyV6w/HxPWrQSDZUaGYluXb5/oXp8Ma5V6W9jqwiNY8DdY
 E2eKZSP+QOsbbyKFH+PFACtNY89vVzyTwFc4g4ZD2EVvOEkh0FAg9mdm4oeg/QJXNRCxTxGNDFp
 MQLhepnZNT+UsN3Kw0Wab2gXSFnXh9iWgl2n45qLs=
X-Received: by 2002:a05:6102:3e12:b0:601:f3e0:9e90 with SMTP id
 ada2fe7eead31-604f92c16b9mr3270529137.30.1774788041413; 
 Sun, 29 Mar 2026 05:40:41 -0700 (PDT)
Received: from msedek-pc.localdomain ([200.28.217.234])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-60512a5afa9sm4914557137.6.2026.03.29.05.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 05:40:40 -0700 (PDT)
From: Miguel Sedek <miguelsedek@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 Miguel Sedek <miguelsedek@gmail.com>
Subject: Re: [PATCH] drm/probe-helper: signal hotplug for force-enabled
 connectors on HPD
Date: Sun, 29 Mar 2026 09:40:35 -0300
Message-ID: <20260329124035.10525-1-miguelsedek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328152550.20222-1-miguelsedek@gmail.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 30 Mar 2026 09:06:21 +0000
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

Withdrawing this patch. The root cause turned out to be a userspace
script running SimulateUserActivity in a loop, which prevented DPMS
from ever cycling. With DPMS working correctly, the HDMI link
re-negotiates on wake without any kernel changes needed.

Apologies for the noise.

Miguel Sedek
