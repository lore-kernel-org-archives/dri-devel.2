Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBCDCD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 18:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89D1510EEB2;
	Thu, 18 Jun 2026 18:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Pzd9ApkQ";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F38A10EEB2
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 18:54:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781808881; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eLsJONgQB7mlV51qQo3iPV1In82KGGGdBNMVuWhYMRlnD+xd6eUdRbqYCtjrKNPp9EcO+MIaTijgo8LZrSNCxQlPQXfVVssE/gn84iYAFeq+HZyoKdzYQPH1G/g5p8JSsFx2TrgSjC/I0Mr7GHGH7LMOIsWqVEvHPKRN0/YIMK4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781808881;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6U2vsnDoMQqT2ncVs5Tg7NhOdUBLlXq+U06ka+M4MXc=; 
 b=QPwQf7bdE07fu+QkX2s/x20ySzaNp2zJOGUNURlFjhAI7N3DXrkeMM73amirpOw2ilEWVnxjuy60q9sn6zv2WvU58/ATNtK5ajDZ0gqpJTIXon9n440Hp0QyfvClew6/1CGsdUMRFPB8KXTV9Y4pbeFJG0/JTxc1m1mWewmIz1I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781808881; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=6U2vsnDoMQqT2ncVs5Tg7NhOdUBLlXq+U06ka+M4MXc=;
 b=Pzd9ApkQI0a0cmhO9Kbxj5TGwq+Vljm4juXf+VzHnK9DNwLq2h/uu3utXf7LoPrT
 enAka5KAJfgo8XkHsWOQSht/h5r7Xt0vk/V/fW5Rs4lAXOfHeLd2toExJ6ahS30Xu4U
 UIGDyCgC0cP4RLPay5fes6nE/1vEw8wDS31bogSw=
Received: by mx.zohomail.com with SMTPS id 1781808879173202.04730720142072;
 Thu, 18 Jun 2026 11:54:39 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH v2 0/2] Make HDMI state helpers handle odd max bpc requests
Date: Thu, 18 Jun 2026 20:54:22 +0200
Message-Id: <20260618-hdmi-max-bpc-fix-v2-0-7b67f489b0cc@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOwQ6CMBBEf4Xs2dUCBpCT/2E8tGWVNZZiWwmG8
 O9W4OppM5uZNzOBJ8fkoU4mcDSwZ9tFke0S0K3s7oTcRA2ZyApRiArbxjAaOaLqNd54xFLkIj2
 VRV7lR4ix3lF8L8jLddX+rR6kw4+zORy93rErrDZQ0hNqawyHOmmcwcD9Ybvwg7Tsg3WfZeaQL
 pn/i4YUBRZUNZqULrPyeNb2+ZTKOrmPJXCd5/kL6RH6XfkAAAA=
X-Change-ID: 20260608-hdmi-max-bpc-fix-703019763834
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

With the "max bpc" KMS connector property, userspace can arbitrarily
restrict the upper end of the bits-per-component range. This is fine and
good, except the HDMI state helpers never considered that max_bpc could
be influenced by a userspace setting, so assumed it'll always be an even
value from the HDMI standards.

This, unfortunately, is not the world we live in anymore. Patch 1
corrects sink_supports_format_bpc to return false on BPCs outside of
what HDMI allows. Patch 2 then corrects handling of odd-numbered max
bpcs by rounding the loop start value down to an even number instead. It
also adds a KUnit test to make sure nobody breaks this again in the
future.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Changes in v2:
- Use rounddown() from linux/math.h instead of the bespoke rounding. No
  functional changes.
- Note: switch statement in patch 1 kept as-is, as 14bpc is not allowed
  by HDMI it seems.
- Link to v1: https://patch.msgid.link/20260608-hdmi-max-bpc-fix-v1-0-6e8dcebc7274@collabora.com

---
Nicolas Frattaroli (2):
      drm/display: hdmi: Only allow BPC values of 8, 10, 12 and 16
      drm/display: hdmi: Round odd max_bpc down to even numbers

 drivers/gpu/drm/display/drm_hdmi_state_helper.c    | 12 +++-
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 71 ++++++++++++++++++++++
 2 files changed, 82 insertions(+), 1 deletion(-)
---
base-commit: 24209d838338d162bb25aadfd637b11747a357ca
change-id: 20260608-hdmi-max-bpc-fix-703019763834

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

