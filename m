Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2DBCCA464
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2536210E8E1;
	Thu, 15 Oct 2026 18:22:53 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7BD610E8E1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 18:22:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792088559; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bbVzvl59kOMXmCBp5lS8ZfOreMqHu6N7R4T7Cgm8WDP88Eqy/rc+mihirCULmWF1djmI8XORzWT7P4VtY+mNLI5F1MwfPCesxWrSz/oHl39aELb2hMw8SGZg8ZtqazmMSe5y1cV+af/qwNzt0dhczCih1W8u/C90xC4MDPHNTKo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792088559;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=I79K5aa5qQeXc/3T5QF2OfAWKCWhMO8LxZ/7KmoZpiw=; 
 b=Olg2vI3KIgCMlAGTlPe785spFwxIqwJ8DVCNcenbwNWxCvUccShDPrkVvnIBZ0tokmXIg+ALAya7L56g9FFUQ6zIWc63u/wyEFsNzN84YctXH0qb0chYpxeLFcYDsDjcCiWd1nYMxEEcc+t6eRAFBnJ+AGc8eeL49f8TiJB+dUU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792088559; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=I79K5aa5qQeXc/3T5QF2OfAWKCWhMO8LxZ/7KmoZpiw=;
 b=Q7ApbRuaoT+YDgQLwJZdrDSOw03uOrYs19Q65ZoDqO51YTeaAPYSjsqklRY5k5nP
 LTt5i2lCa9heZWFEpekqg3u7eQU/mONIeKsJKSueZo2fWAy99GCZViTWc+k/xEhjmH+
 KsPlA/Ts2XU/bn3oI1KBz5we7pENlqUVtzVe+rxc=
Received: by smtp.zohomail.com with SMTPS id 1792088556967817.0091812413211;
 Thu, 15 Oct 2026 11:22:36 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH 0/2] Two small perfcnt fixes for Panfrost
Date: Thu, 15 Oct 2026 19:22:30 +0100
Message-Id: <20261015-panfrost-reset-races-fixes-v1-0-bb74c1786a0b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBBFryKzbsAEFexVShdJ/GmniygzVgTx7
 p22mwePz38HKYShdG0OEmysPFcTf2koP2N9wPFkTqENg29955ZYi8y6OoHCGDPUFd6NQ+lL6Pp
 xymMiCyyC32D/2/3v+k4v5PVbpPP8ADjHmFF+AAAA
X-Change-ID: 20261014-panfrost-reset-races-fixes-6f5f2459dc9b
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=sAKIIcZBMRT+whOaJSV103iMZeILabuC08FAYSIpbKs=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBq0RnoYmV6H19fPB2fNEZeNI7KpU/Xev67wWvGH
 Gx+DjRtuemJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCatEZ6AAKCRAOJn5M7lND
 PenYDACYn4BqADHBWPYKAQzJlgTH5GV1AWH8/+GGuPDRfc68KdcZAX6gMb4I6BQSulFd2Vega2V
 2TyWuH3fGLfQ5tQU6RKPs3jfnHeS4ptLprXDkuKTTKCzV4z0s8YjeJte+MrFpgWmS+3MFT77y8I
 z5rvJSvu6snka10VFP8QY6n74JO2A0mIewWq66bItAIRQWvgmocjAwsDxRj0hb5TajNUVtl/8Ph
 +hY7gRUnxZx5s6c35dwBDrNy0tNyshAeDElrw7EsXX/LWMkejTfZfloyXjlXbjAdFQeIbk6PQKR
 yFoh8bmu6Y5OOsa1ttGNFHRhPq+RxsKymd4gU/SQuhjnZuo7a/lNWEMiK5KRsCW7oHy3PedRRj+
 scZ9+jwEBv/s93iumjEGFtj2efoMaS5hLOgwcsrIuku0lClvxXlwczcv+8y8DhUP8lSWa3EgXmS
 us/v+j1mUQ1wxdf8phlkWkVI0J+8H4wVcYireuLwpkTEsinu5iNLUGaZVK+TmJNICcW8A=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

To: Boris Brezillon <boris.brezillon@collabora.com>
To: Rob Herring <robh@kernel.org>
To: Steven Price <steven.price@arm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

First fix makes sure cycle counter is enabled when starting a new
session. This is required by some profiling frameworks like
Perfetto. Second fix deals with a recently-introduced race condition.

---
Adrián Larumbe (1):
      drm/panfrost: Fix race when restoring reset state in perfcnt

Boris Brezillon (1):
      drm/panfrost: Enable cycle counting when perfcnt is enabled

 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)
---
base-commit: 9944dd07f3cf7b6c19d65c2585147887ca06677c
change-id: 20261014-panfrost-reset-races-fixes-6f5f2459dc9b

Best regards,
--  
Adrián Larumbe <adrian.larumbe@collabora.com>

