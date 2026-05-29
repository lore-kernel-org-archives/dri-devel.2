Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59793CD6E4A
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 05:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E90D511270F;
	Sat, 30 May 2026 05:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="larpEfAk";
	dkim-atps=neutral
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com
 [74.125.82.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33CE11122F5
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 17:26:59 +0000 (UTC)
Received: by mail-dy1-f196.google.com with SMTP id
 5a478bee46e88-304e83724bfso1653776eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 10:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780075618; x=1780680418; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUW2sBne+Sxe0sHajD5BpUUqGczKXbh7gDG8g1//2Hc=;
 b=larpEfAk4ZrZbuWZ7CbSwvF5zvXFGUhr8IAmlRaEKAIzlvkgFaTR+WBFc2vWdtquV/
 dI2PIYfcp7uD3JPZJKhjpSywZmXkm6Z/vkXpedJ74j8oEHBzpUbpsKHpXH5Dvx0TdyCd
 jsyLM8TyOOmdqXUWzBjcE7UXsNnHl1Sb00ZZI30FmlZRFCC1TJL/BKMp/34F1HUvsFIF
 bMgvB2iwLR1j/drrqoHaaqZKt+SZkSTXGJ0hEw4b6bG0NdRQbWdzeOOayZmWtyXPx8kV
 zJ+iIHxp9nRH8MXFOE2XSUH6p0uuNne0Am/weEIBoDbiKlSvADBUcbUf/uUyDy6HSdW5
 ZDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780075618; x=1780680418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rUW2sBne+Sxe0sHajD5BpUUqGczKXbh7gDG8g1//2Hc=;
 b=I2vuUqwEN0yjUpXLzJ8wrFi4d9edzB6BYgTjFteIKfQ65si63Pc8rCb79dxmb4SXnN
 H0t9Vnc9Zx9dJUYK/VfxolfrxStumQbQ3SmzJugM5xldhzGHhTsCnr1vP4QTG9us/h+s
 hKJozUUpdqfx82NBCRn6oVUULiO1OXTEvk0IpGaeJTZ42OrRXHhoQ10/EIHr7Ro+Blj2
 pRdNgm2fzVCT1hCFE6SVjyfE9C/sgmMQJyZD3It9gmOJA58mOTSyxzTEWKuOFvgy0QJN
 okiLOMGN5olNOSvenRx2S3fRygLLHr+P5duCbQg1dIhysMw2Vzp+LDjXyIPVDhc9Cj1w
 UgCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9yEO6Xd3CA2Uv3oYQbooQ8YLHo5+pdxan8e+wZQzo/sVLwI0ezXcRzyna7QGR09/Jl3jWEx5hOtg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzwby503wUTPKTs2tfakUwQWCwYc+qTW8mA2M0KkXaqwqpV6q7l
 W0x7+jjlqctFPQwQEXWcYSe9mM/SmoCq3DEArlRKiNZBO9OWTgzfCbqT
X-Gm-Gg: Acq92OGeXO84bD54XNgBecdHcqPHXYmhuD2cmExe7Gj8zJQB9V+mvs/AxqRcDNYaNRL
 Olz9hJFcXr5qdUwM7sMmsQkgco1Hntv0Kws/4KHD2M/wxNRsfxOeIi4GnkghcrJAIINWtzazcMl
 Mw51AZwP5CJ3kBym9rFlznTkuusNGGdX/gdnrKlA1CrR+GAZXeHQsyUtfl0vpgIk3M0ZBdfEeLV
 TbEhg3W+/hhzszauJMgD6dzHH7rcz6hQ6jxuY5iw0nHauOgDKJ1rL+v4uCML5vUQahsulqC0KYX
 wvpRwhTiCjkJanGckiAKq5HNtQLjaR0xQ4oNhtVzU0hVf1h3ihEsXWP1BzxqdHsfIaXMQItWvIt
 nYyro0aCX+7R7VdJEKombeY66cRzPv0Da7AVQBtzrvoadvGmgWmXpxtDJ649zgqd+gAP3TvRkQw
 SUc7VEHQbIREkEkCvb+SGFJfnblbA/objP
X-Received: by 2002:a05:7301:580b:b0:304:5a9c:6479 with SMTP id
 5a478bee46e88-304fa4ec8f6mr378329eec.9.1780075618178; 
 Fri, 29 May 2026 10:26:58 -0700 (PDT)
Received: from zhanwei.. ([192.227.223.214]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed53d06asm1785614eec.14.2026.05.29.10.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 10:26:56 -0700 (PDT)
From: Zhan Wei <zhanwei919@gmail.com>
To: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com
Cc: raag.jadav@intel.com, corbet@lwn.net, skhan@linuxfoundation.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zhan Wei <zhanwei919@gmail.com>
Subject: [PATCH v3] drm/xe/hwmon: document DG2 fan speed reporting quirk
Date: Sat, 30 May 2026 01:24:49 +0800
Message-ID: <20260529172449.41504-1-zhanwei919@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ahm680G_8mf_cjG9@black.igk.intel.com>
References: <ahm680G_8mf_cjG9@black.igk.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 30 May 2026 05:55:09 +0000
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

On DG2 the driver always shows two fan channels, because the
FSC_READ_NUM_FANS command does not work on some cards. OEMs decide how
the fans map to tach channels, so two fans can share one tach line.
When that happens, the second channel reads 0 RPM even though the fan
is spinning.

Note this on the fan2_input ABI entry so the steady 0 RPM is not
mistaken for a driver bug.

Signed-off-by: Zhan Wei <zhanwei919@gmail.com>
---
v3:
- Drop the dedicated Documentation/gpu/xe/xe_hwmon.rst doc and the
  index.rst hunk; add a short note under the fan2_input entry in the
  existing ABI doc instead, per Raag's feedback.
v2: https://lore.kernel.org/intel-xe/20260529135028.20763-1-zhanwei919@gmail.com/
- Drop the code change that reported a single fan on DG2; document the
  shared-tach behaviour instead, per review feedback on v1.
v1: https://lore.kernel.org/intel-xe/20260527115311.13398-1-zhanwei919@gmail.com/

 Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon b/Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon
index 55ab45f669ac..0da739d9a816 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon
+++ b/Documentation/ABI/testing/sysfs-driver-intel-xe-hwmon
@@ -251,6 +251,13 @@ Description:	RO. Fan 2 speed in RPM.
 
 		Only supported for particular Intel Xe graphics platforms.
 
+		On DG2 the driver always shows two fan channels, because the
+		FSC_READ_NUM_FANS command does not work on some cards. OEMs
+		decide how the fans map to tach channels, so two fans can share
+		one tach line. When that happens, the second channel
+		reads 0 RPM even though the fan is spinning. This is normal, not
+		a bug.
+
 What:		/sys/bus/pci/drivers/xe/.../hwmon/hwmon<i>/fan3_input
 Date:		March 2025
 KernelVersion:	6.16
-- 
2.43.0

