Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286D6CD6E5D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBF68112AB7;
	Fri,  5 Jun 2026 07:25:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="KMqBRlPv";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B49112A89
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 06:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=hh
 1/hiDRwY8ni9d+4XGFXWtoB5e80mJgmHaxa8O9s+o=; b=KMqBRlPvC5XzELSJNh
 PWIpr8Z/Y07lr42zLpqlaKGuZ/3K5ZQ44yvrCDjfw5u/zuEkVVWUd4C66N3qnK+Z
 dXFqzTxWMYVCgSOGkBsmgy535q09AwfL4TbOydGDYm26z3/oWUAJ1ArLDousNrNi
 i/jAdC+l2QeV5VuqD8j49gTgU=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wD3PzMqaCJqy4QbBg--.19265S2; 
 Fri, 05 Jun 2026 14:09:48 +0800 (CST)
From: wangdich9700@163.com
To: mripard@kernel.org
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 wangdich9700@163.com, wangdicheng@kylinos.cn
Subject: Re: [PATCH] drm/connector: add CRTC state change callback to HDMI
 audio helpers
Date: Fri,  5 Jun 2026 14:09:46 +0800
Message-Id: <20260605060946.435082-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260604-adaptable-myna-of-courage-7ffeae@houat>
References: <20260604-adaptable-myna-of-courage-7ffeae@houat>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3PzMqaCJqy4QbBg--.19265S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFWUWr43Gw45Xr48GF43Awb_yoWDCwb_uF
 n5WrnFgw45GF97Aa13KF1IvFySgw1UAw18J3s5tF93Ar93XrWUKF4DZr9xur1IyFZ0y3ZF
 kr9Fv3W29r1S9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRROzs7UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/xtbCwAxIl2oiaCxlHwAA3l
X-Mailman-Approved-At: Fri, 05 Jun 2026 07:25:26 +0000
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

Hi Maxime,

Thank you for the feedback. You're right - showing the driver usage is
important to validate the API design before merging framework changes.

I'm preparing follow-up patches to demonstrate how this would be used
in practice. Here's the plan:

1. DRM driver side: Show where to call drm_connector_hdmi_audio_crtc_notify()
   in the CRTC enable/disable paths (using i915 as an example)

2. Audio codec side: Show how an audio codec driver would implement the
   crtc_state_change callback (using HDA HDMI as an example)

I'll send these as a small series (framework patch + driver usage examples)
for your review. The examples will show:

- How i915 would notify audio when a CRTC is disabled while the connector
  remains physically connected (e.g., user switches to "internal display only")
- How the HDA HDMI codec would handle this notification to prevent silent
  audio breakage

Would you prefer I send the full series now, or would you like to see the
example patches first for API design review?

Best regards,
Wang Dicheng

