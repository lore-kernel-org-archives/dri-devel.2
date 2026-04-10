Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6632E99046
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:06:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 861A610E89D;
	Fri, 10 Apr 2026 07:06:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ECWB2cGO";
	dkim-atps=neutral
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57BFF10E00F
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 03:41:37 +0000 (UTC)
Received: by mail-qk1-f180.google.com with SMTP id
 af79cd13be357-8cb20bcff5aso148743785a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 20:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775792496; x=1776397296; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oc84VNSkcWZZsnzjTmO0R+FA4pK9rFcbo2uFSa1A1Ms=;
 b=ECWB2cGOrGLiBFj/+qXI3lIuVTfmJuE5TjOov0fzQ1YzwhMpctIReN/DispNUgdRtx
 gJ0vjhGCdBsZUBri8m7K8TWYIZSaxvG7cadC0avy2sGTvceIWLVBkP2V18p2eFCa8bQ+
 91vm1MtjJPP2y3lUw8u5hLZ1gtW3oEGaMcj+o6Pj1b2ccQNmpr4aU/z+JEhxItldnXaK
 yAk6YllDiCc8Al4BtxzmOla2qzi6buw2hA6hkRfGrrZfuGZTsViXzC2hvzyoAy8haRCW
 Ntr04L9eEPEfA972Yg44DqwG7QoCQTVPPvhx7dsvxQqKS/C5XF9JZ1WBo1yDRjTq/X/E
 Gm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775792496; x=1776397296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oc84VNSkcWZZsnzjTmO0R+FA4pK9rFcbo2uFSa1A1Ms=;
 b=RdQR5/uyTS7Sua+CDyiXhlKIKY0xn/ZDA8e1oh4T9BCdDZZMEi4Mgmsm1jioKAim29
 AzL9z1fV5VqVlgglc5/JFDUZzO6TjPRqBefZumY/sdS8gy8jdZwcaKfjmkUQFsO/qUaO
 o3JIunLjBadG65fKC10bjfaAe+b3lF2NuANnX7NwbO79vwTrlqNRH89LdtvpAl9eIJ8n
 6kd9+aCBb2KqG1e2a+9Dwec4qoQxdBpEtNRyGBR0bIklpoarBKIK7qhRFoFjY1PGCnU8
 qrLFkWASNnq4+wshox4Us0l7Qhm3Ut8xh2u557vK0cQ0o/Cz8G5Ku359pgUx+xLvjPo6
 kNLw==
X-Gm-Message-State: AOJu0YzYA7XK5F3iAIQVA2Ii5D24OdM+1C94V8RXyYqrodg34annDz6m
 q+aGoiMazpVvUjIcccmzGWy2bumWgQugDrAHS9OgJlj949dXekGmuGQnE4HYGESae6jNNA==
X-Gm-Gg: AeBDietdrjLu30gLBWQ2ZEyMa/kWXJt4gP5upuMws50hWQFHQRCPJlcG9TWPQuEiuDO
 zzE9EIXLsOQ9QQaf8tKV9kkxJ8p7P1ZWQa5e84jaGTJSG2oWaDnjKk2yLy7LKkKKBlIsJXGDRx/
 mx4mug03XG+TRGcux4vu/QwrYH1DWAf92ChYXuGwfnvQ+Pzq64Z4x6UR4yNkphbnkkvhHjrfZVV
 ndk3SkAeAGmiauGCGovnHdGK2lgVJWfoE81jliJ8F0jJ47NXKcfRjTiUsaFAYF+mGKUTiFdYYC6
 gowt9voqs4FCCeYdsSFLqVQI+GQywcitUx85o4gNHN36yyZRD4hUMW/G43E0gBe805O8sW0u5iD
 xvipAwbRQls29QnnpwlZlTRMw0UYBV5dgoeETZqq/a6ihd8cGxDWS5Gf4g6wy8ELs6SIzgPLCxR
 3uSlVG/Mug8vTF6Pp1INrKPVXI1D3zAz6iMsuUsl+6z05ksvS5zWU+j/04nD8+i4TY3Z9PRXfqe
 IrJn4fCBbfRsxhRk3Z4PLA534OUN3nMzbMBD1g=
X-Received: by 2002:a05:620a:4622:b0:8cf:f5b3:b878 with SMTP id
 af79cd13be357-8ddcf1b8347mr216319085a.36.1775792496039; 
 Thu, 09 Apr 2026 20:41:36 -0700 (PDT)
Received: from
 TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net
 ([20.63.37.123]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ddb9351afasm109911785a.36.2026.04.09.20.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 20:41:35 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH] drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply
 parsers
Date: Fri, 10 Apr 2026 03:41:23 +0000
Message-Id: <20260410034123.2433769-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Apr 2026 07:06:48 +0000
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

drm_dp_sideband_parse_remote_dpcd_read() reads num_bytes from the raw
message and then unconditionally does:

  memcpy(bytes, &raw->msg[idx], num_bytes);

without checking that idx + num_bytes <= raw->curlen.  raw->msg[] is
256 bytes; if a malicious or misbehaving MST hub sets num_bytes larger
than the remaining payload, the memcpy reads past the received data
into whatever follows in raw->msg[].

drm_dp_sideband_parse_remote_i2c_read_ack() has the same flaw and also
lacked the post-increment idx bounds check (noted with a /* TODO check */
comment since the code was introduced).

Add the missing bounds checks in both functions, consistent with the
pattern used throughout the rest of the sideband parser.

Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 170113520..9cef6c576 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -873,6 +873,8 @@ static bool drm_dp_sideband_parse_remote_dpcd_read(struct drm_dp_sideband_msg_rx
 	idx++;
 	if (idx > raw->curlen)
 		goto fail_len;
+	if (idx + repmsg->u.remote_dpcd_read_ack.num_bytes > raw->curlen)
+		goto fail_len;
 
 	memcpy(repmsg->u.remote_dpcd_read_ack.bytes, &raw->msg[idx], repmsg->u.remote_dpcd_read_ack.num_bytes);
 	return true;
@@ -907,7 +909,11 @@ static bool drm_dp_sideband_parse_remote_i2c_read_ack(struct drm_dp_sideband_msg
 		goto fail_len;
 	repmsg->u.remote_i2c_read_ack.num_bytes = raw->msg[idx];
 	idx++;
-	/* TODO check */
+	if (idx > raw->curlen)
+		goto fail_len;
+	if (idx + repmsg->u.remote_i2c_read_ack.num_bytes > raw->curlen)
+		goto fail_len;
+
 	memcpy(repmsg->u.remote_i2c_read_ack.bytes, &raw->msg[idx], repmsg->u.remote_i2c_read_ack.num_bytes);
 	return true;
 fail_len:
-- 
2.34.1

