Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD194CD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 20:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF9F10E16F;
	Sun, 10 May 2026 20:32:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CMaFv6qC";
	dkim-atps=neutral
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B26C810E16F
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 20:32:13 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-8b45dff1eebso36229746d6.2
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445132; x=1779049932; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GH0BIPUR5p8mIEZWyU6SEUzThcS+ZdasVBlkjfRz1DA=;
 b=CMaFv6qC+M7GVUsNae4DLtlP+03hU1o8GqHIqGy1RUYOWjqfLhpmB/vdW0+q17fa0m
 2Idf+r7kjDC7zMSUwc6D1jFcIA2gv9U4FSpaQi4SJHx7wN29+HmHC+rie3p4cL0qPu79
 1O3DZ2tVp7gstv1y6nqeQydmWK/m2Acqm6L9asBj6lvqQkiMwnexd4c/OigmsZp5L+n/
 i3IAHsVibc0fLYFywPTjZf/tO+7ZuWQBLrWNrRfZRjgZkWq8LywAdvcaFfg7TmGFzhlT
 Am1S+RnVnoZsSJwNb7NGVlkpjHO8168lDrnzESuPqi87OIuH0EPgcZ4L7T5xB+zPH7BI
 749w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445132; x=1779049932;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GH0BIPUR5p8mIEZWyU6SEUzThcS+ZdasVBlkjfRz1DA=;
 b=b4y2QJjyf44RpmqvCQ3X6W31tlqH1DRkiyNwF6pNnPivvssDFBBa7hrcKwQgmQ7GXk
 ssAHVRVXiNhgkpCmjVVxwMSMa8p/labGRn0AShS0c/PsIngaf5MY5Sa6m39tFiCljvRO
 L2dDkNQoaNvQiyqCw0dhONZkYGzD45DKExi95w0wLhtMkjo7tXPyKyf0ZwF2pofWy5ZM
 yxCST3qNXPZxHAIyMGon26n5I5CJtA8boIBw6XytwyefW+RLD5Xa9PhZNKK9TfWDE4U/
 xhqDkyKJk45b8nnbbwSYuAACj4XWpwE1p1McSNKTl7ExOaitV0jGMUWYJuMdsXdtP1QQ
 y6JA==
X-Gm-Message-State: AOJu0YypFAbOY7VOU+I7qNd1QEYlOJYAZcLhv/G8G8NWRtMPSvyj8OdH
 tcgHOumxC5N/+LjUv7dANICZK4mLRF+0l/3ZNRMeIYkjcZ6xyie+Ms8FKRg0V28XMTohjg==
X-Gm-Gg: Acq92OGsfLhPm+QBCPn+QFUQb7DJMnCPqupDzv0/Ls1kOobbGWJcq1OBL/QilWJ5sAN
 Kr1LQXE9WAH4bbyrOH8Lq8ytnXnapPkakd3NJ5hBNfz41qTE5hadScR9C+sSkfoSep1lCfzaJ5A
 lvZIOUlAe48ELkze0jXzqD6qNb9vZ/f3mgXSy3VqOsqeiumhK1GPUz22zVB+ZqYDtS7d8mr8S7H
 VEYqA1xNEJHL0JAQp/TtD7WkVQaJaisNmq3Ow4v7PaZN5MzjZ5IC5jvbRkkgGBw40HDg7kQoIPy
 1z9aUwnoNiCsU7AWT7aP9YDQKzo4mr+q1eeH9dub3v+ZePW2aKZXi5exGt5LeQYeRu94rNVSHy3
 gW1/dyLVlGvRbY+GMHi0SDL1Rrx3tKIahT77cWsCTeTYkHzMXFFC2NxUwJ4bGzdFpBrSTn7sB1l
 ZG1V14xD0Tnhi/X6V0OX3B7xapbNizHDXzUmr06w7NsxFY+fw8dXjhjTVbWEueCjvFFOhLvT1Ef
 wsgg70jtfimclo6H1SCBXDWNun/WTvLxLKD47E=
X-Received: by 2002:a05:6214:3111:b0:8ac:ab13:8f15 with SMTP id
 6a1803df08f44-8bc41cc2ea6mr361413956d6.7.1778445132299; 
 Sun, 10 May 2026 13:32:12 -0700 (PDT)
Received: from
 TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net
 ([20.63.37.123]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf3addb3aasm76968056d6.10.2026.05.10.13.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:32:10 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, lyude@redhat.com, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v2] drm/dp/mst: fix OOB reads on 2-byte fields in sideband
 reply parsers
Date: Sun, 10 May 2026 20:31:28 +0000
Message-Id: <20260510203128.2884846-1-ashutoshdesai993@gmail.com>
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

Three sideband reply parsers read 16-bit fields as:

  val = (raw->msg[idx] << 8) | (raw->msg[idx+1]);

and check bounds only after the fact. When idx == raw->curlen,
raw->msg[idx+1] reads one byte past the received message data into
the following struct fields (curchunk_len, curchunk_idx, curlen).

Affected functions:
 - drm_dp_sideband_parse_enum_path_resources_ack()
   full_payload_bw_number and avail_payload_bw_number fields
 - drm_dp_sideband_parse_allocate_payload_ack()
   allocated_pbn field
 - drm_dp_sideband_parse_query_payload_ack()
   allocated_pbn field

Fix by using a single combined check (idx + 2 > curlen) before each
2-byte read. Since the check is strictly tighter than idx > curlen,
no separate step is needed.

Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
Changes in v2:
- Drop separate idx > curlen check immediately before idx + 2 > curlen;
  the combined check strictly subsumes it (Lyude Paul)

 drivers/gpu/drm/display/drm_dp_mst_topology.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 9416a48804c8..6e7896193772 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -925,16 +925,13 @@ static bool drm_dp_sideband_parse_enum_path_resources_ack(struct drm_dp_sideband
 	repmsg->u.path_resources.port_number = (raw->msg[idx] >> 4) & 0xf;
 	repmsg->u.path_resources.fec_capable = raw->msg[idx] & 0x1;
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
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
@@ -952,12 +949,9 @@ static bool drm_dp_sideband_parse_allocate_payload_ack(struct drm_dp_sideband_ms
 		goto fail_len;
 	repmsg->u.allocate_payload.vcpi = raw->msg[idx];
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.allocate_payload.allocated_pbn = (raw->msg[idx] << 8) | (raw->msg[idx+1]);
-	idx += 2;
-	if (idx > raw->curlen)
-		goto fail_len;
 	return true;
 fail_len:
 	DRM_DEBUG_KMS("allocate payload parse length fail %d %d\n", idx, raw->curlen);
@@ -971,12 +965,9 @@ static bool drm_dp_sideband_parse_query_payload_ack(struct drm_dp_sideband_msg_r
 
 	repmsg->u.query_payload.port_number = (raw->msg[idx] >> 4) & 0xf;
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + 2 > raw->curlen)
 		goto fail_len;
 	repmsg->u.query_payload.allocated_pbn = (raw->msg[idx] << 8) | (raw->msg[idx + 1]);
-	idx += 2;
-	if (idx > raw->curlen)
-		goto fail_len;
 	return true;
 fail_len:
 	DRM_DEBUG_KMS("query payload parse length fail %d %d\n", idx, raw->curlen);
-- 
2.34.1

