Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260D3E99046
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0585E10E899;
	Fri, 10 Apr 2026 07:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pgi5chsd";
	dkim-atps=neutral
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6414310E05A
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 04:00:35 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-8a151012558so19035766d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 21:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775793634; x=1776398434; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=40je6pyvB78AE8C7RBxzyLMhGBsBo98AwoJUcXd6tRE=;
 b=pgi5chsdJATFJTtfOQ7Mynm7/sOCSTi80ZijeVE3An8HWZOAxERrXLIPt0COuS/M+m
 t/oC9hQE3AHOFffKx7gzjqm55grEj5Rnpcy8TM2tuw7ESHWUyY9EyG1IAm1pHN7trvnd
 LdRrH2fL8dqgCfLBwUTCjQQAcM7bWQ51H5wea0fSiaI3XTa4gBYkM8CXblNaND/tpWZq
 QnpcNgAVc08IFYtMOR2biyrEW1js4s2yDjr8TmufpGpnKVMUWX4gYMPahjrXKAF7ACkI
 whweVKyA1rxqwM3G+R17qvm4OsU8W+VgbvJphI5uQyTjmaxQpJxt9RSS1a5mWS4dTqUU
 nFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775793634; x=1776398434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=40je6pyvB78AE8C7RBxzyLMhGBsBo98AwoJUcXd6tRE=;
 b=IqTL1XQTtbExQI2nc3F/uKMIsOgJrNJY4cyY1o36Y6eKoQG677PBxLHBIHlelhASDH
 b4X28EL/Mv3PhuJswriukiNc8VZOdDefZxE1748hVLkRZlQaRlYREU2qxqYZ5vtYYiKd
 dxw4U0BRoagRE39fuAJ/zpy9uxaWaZOHFl/R+m34sGSnHj4IDWub72KgimHN84mRqoMd
 XcPgE42Ro0FurhnbTQ3b/qi3lGreI5f2gdkoBGpdFwIeIbDFqmCGQYWnaz4lQHgRlk/i
 xY9+lwDEsHx4nEpTj+76eBfVJFyd258+RESWs1CBNwzQWvwkh80gFbNuUEr0WKbNLdqS
 /brw==
X-Gm-Message-State: AOJu0YyelXJ9LQd6+CvOvHcKSrETp0JAJQWEYkH9kg8Gz77oJHmnuU+B
 Ic56fV6dCY9+FW5xYFr8zFEhdPIBcltQy10M9scurENNxnyQ/b7vP1z8gjI2ZbwWvBrR0g==
X-Gm-Gg: AeBDietmcHIdxgsPPfdPP5PGltJt4RcOTqmTj6wUF19XTZiGT4f2mqHDTujQNfG8h9w
 7sLjgGYkWOTpor44hF4worztKQC5GUfJzYaJLGe/ZauS8hWAHAyn7VtNhoQtC3iA00LOsgNrHHn
 oc0QLZIL5OdD+5zdj1r2f5vwYS6G/07xNZkBO47bQqOLxr/QmK4PLUK7ApMhoNb4TSrOtzLYi0N
 6G/+OsBYUk+i13VFIHWfTidsH8tMiQmrQhZPQ+ZHsJ4RWbW9iGjOKHjmwosmfK+enaCYbZ25D85
 5eQkVD9U5kmQGUB+1lwUDXjYBd24dpLZI/rr9lliRWhrcOsZU05DA4q+8JXIpp9buNmsHJtIJKS
 MzVrJPJVTnW7GvwG1iWHoVqcg/EPjyTds9LcT7LnMXV/4ZOkNLw/SdSXEzLlmbv+6WwpktfpO1b
 3M1Mbes1BFxLoOheJug9uXG1thmhYfaUuAONHMAwtaZqTCff3Upb9iyGC3hwMSEl/V+RrSVAHhv
 Mn4nxGvgrk25vw8h5hB9s7fYxNM
X-Received: by 2002:a05:6214:c4e:b0:8ac:8938:ee55 with SMTP id
 6a1803df08f44-8ac893902e8mr7757046d6.11.1775793634061; 
 Thu, 09 Apr 2026 21:00:34 -0700 (PDT)
Received: from
 TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net
 ([20.63.37.123]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cdda1csm14132946d6.43.2026.04.09.21.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 21:00:33 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH] drm/dp/mst: fix OOB reads on 2-byte fields in sideband reply
 parsers
Date: Fri, 10 Apr 2026 04:00:26 +0000
Message-Id: <20260410040026.2436280-1-ashutoshdesai993@gmail.com>
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

Three sideband reply parsers read 16-bit fields as:

  val = (raw->msg[idx] << 8) | (raw->msg[idx+1]);

and only check bounds after the fact (idx += 2, then
if (idx > raw->curlen)).  When idx == raw->curlen at the
point of the read, raw->msg[idx+1] is one byte past the
received message data, reading into the following struct
fields (curchunk_len, curchunk_idx, curlen).

Affected functions:
 - drm_dp_sideband_parse_enum_path_resources_ack()
   full_payload_bw_number and avail_payload_bw_number fields
 - drm_dp_sideband_parse_allocate_payload_ack()
   allocated_pbn field
 - drm_dp_sideband_parse_query_payload_ack()
   allocated_pbn field

Move the bounds check to immediately before each 2-byte read,
using idx + 2 > raw->curlen, consistent with the fix pattern
used elsewhere in this file.

Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 9cef6c576..f2a7dbc5e 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -931,14 +931,13 @@ static bool drm_dp_sideband_parse_enum_path_resources_ack(struct drm_dp_sideband
 	idx++;
 	if (idx > raw->curlen)
 		goto fail_len;
+	if (idx + 2 > raw->curlen)
+		goto fail_len;
 	repmsg->u.path_resources.full_payload_bw_number = (raw->msg[idx] << 8) | (raw->msg[idx+1]);
 	idx += 2;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.path_resources.avail_payload_bw_number = (raw->msg[idx] << 8) | (raw->msg[idx+1]);
-	idx += 2;
-	if (idx > raw->curlen)
-		goto fail_len;
 	return true;
 fail_len:
 	DRM_DEBUG_KMS("enum resource parse length fail %d %d\n", idx, raw->curlen);
@@ -958,10 +957,9 @@ static bool drm_dp_sideband_parse_allocate_payload_ack(struct drm_dp_sideband_ms
 	idx++;
 	if (idx > raw->curlen)
 		goto fail_len;
-	repmsg->u.allocate_payload.allocated_pbn = (raw->msg[idx] << 8) | (raw->msg[idx+1]);
-	idx += 2;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
+	repmsg->u.allocate_payload.allocated_pbn = (raw->msg[idx] << 8) | (raw->msg[idx+1]);
 	return true;
 fail_len:
 	DRM_DEBUG_KMS("allocate payload parse length fail %d %d\n", idx, raw->curlen);
@@ -977,10 +975,9 @@ static bool drm_dp_sideband_parse_query_payload_ack(struct drm_dp_sideband_msg_r
 	idx++;
 	if (idx > raw->curlen)
 		goto fail_len;
-	repmsg->u.query_payload.allocated_pbn = (raw->msg[idx] << 8) | (raw->msg[idx + 1]);
-	idx += 2;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
+	repmsg->u.query_payload.allocated_pbn = (raw->msg[idx] << 8) | (raw->msg[idx + 1]);
 	return true;
 fail_len:
 	DRM_DEBUG_KMS("query payload parse length fail %d %d\n", idx, raw->curlen);
-- 
2.34.1

