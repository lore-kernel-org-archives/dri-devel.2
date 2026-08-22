Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6E3C5DF9C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C01110E4AB;
	Sun, 23 Aug 2026 09:27:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l+TQGpnw";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D38510E3D0
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 09:17:49 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso17135935e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 02:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787390267; x=1787995067; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t6ZdW23XPQbuspc71nQ6IOlPWvgfeZGd9xc03sJ0L8s=;
 b=l+TQGpnwc+AwbWzwnpFp098sdkb0mVkYRXrhnk0IV13TcfbRHeR4drdRoKnibvjLF8
 Pv3zTaVvL/KlVEt1UwJPVfTocgNLCc8jFlG0wMZG1wPlbiH1yAcbmKLCk7O1KL0p/lQL
 xJJhyRWCWVPBtxSEkZMlHQGcT9ucUO/n259vrUQHFz919cXGx98r4Y0Ndx5CI2vpWScW
 9Zr2uxF3SS9X8Il7vzkZA3jg9woApUBb5APBxiShGMwbknqGjle+uBsOuFG5GhM+fqwF
 naYQx35EvdzYrNybFMErQ9iPTcpraWoPkdlQzNoQthBwFh4JNGWbGk5z3ktau+o4wZpz
 MZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787390267; x=1787995067;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t6ZdW23XPQbuspc71nQ6IOlPWvgfeZGd9xc03sJ0L8s=;
 b=eB5nWjj0kcbBYL5b9m90cuFEGJvWktFvaZ2AYRf6t+f36De2y9nQuvMqHUp3A/zyA+
 8X1AgKpappx/eEnt+EQxSl3YMlp9sOyqRQnGyFg/A4y+qB26zcud7ECme8W0ZAoR5prr
 /DU2JzdV2RmX/PbRzfE1wUi2biE6VUZHVWCah3tKvT+edfguLriGpPEG5o5+graVN9Xn
 g3ab48IbjIJ1EBZPHSV2Ub+8PIVS9NDZUR6ox9JYC5uswktn4FHGC4ZiYkLJ7AZljKHO
 eFiZa1OkixBxSXqi630AG/yNvnNLy44PYJrM0TfAdjOBzmkl3k4+bfIK98g9RU1+qHsc
 xJZw==
X-Gm-Message-State: AFuF++mRHmaKBc7QN5NZX24t5jSknizHR7H/5AUq2b/YQIdzn67PqsBR
 0a6kpaZXeLi8+xxX9OlhtcVZCPRMyBmWvIJMws4WnHsVDbSifxOrIYSl
X-Gm-Gg: AR+sD125kqP1bo85aisTh19JqIbKzmuJ45ko6Tch+pfZBuMtIiDFpudFI+OB/cYSb9K
 pTHhNr5E7GAfx03wZBobvSIpMrPllnCqh1nrRCSErcgz6aRdffw8kpmjcr98ivGqL5hT8cxh0Bw
 KXv5AIjM/ze/UpPkFrOH9jA3gajf7Zcx4bQvOAnJZaHFAj3mTBvu4JFy2Z/v0tnQiTXezIb2M0o
 iK01EoYlvJt3K9/ixMwDFNefPvf5OkXFOZy/AjDmJm7YD9TnrM6ZKDkvYBWWq+CPgCo/Py+G26n
 bVpKuWZocKDeei8VqDCsRC1bDpI5TElhQ+ibyadkd8+Uf+cahA0zFX2KFpE+AbUQOWrqNcsqCcs
 Lf24aAsy4iZ6DIAZPg3P44sAALRGU7d+/F1kBzkOKBmkyFvgGxj12IZowPfvG+vZklN+LRhXVeD
 uEHL0sG+wLLc6vd76WAJPGUBdhPdzC/2rMGeOuQ9wEb3p69w8KjHuwFvEy/L6QYmNZ3Jq/0GaMo
 gOWeP8iQrwbjcDQ1ANVNv+BXUd5O+l3
X-Received: by 2002:a05:600c:a087:b0:499:86ce:465e with SMTP id
 5b1f17b1804b1-499b8324b09mr179506975e9.4.1787390267548; 
 Sat, 22 Aug 2026 02:17:47 -0700 (PDT)
Received: from cachyos-x8664 ([2a01:e0a:899:6110:90de:8744:7ad5:471e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b78df1sm1539550f8f.10.2026.08.22.02.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 02:17:45 -0700 (PDT)
From: Julien Le Bourg <julien.lebourg8@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Chuanyu Tseng <chuanyu.tseng@amd.com>,
 Julien Le Bourg <julien.lebourg8@gmail.com>
Subject: [PATCH] drm/amd/display: Restore self-refresh fallback in DCN21
 bandwidth validation
Date: Sat, 22 Aug 2026 11:17:15 +0200
Message-ID: <20260822091715.6692-1-julien.lebourg8@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 23 Aug 2026 09:26:47 +0000
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

[Why]
Commit b96150a70696 ("drm/amd/display: Should support p-state under
dcn21") made dcn21_validate_bandwidth_fp() call dcn21_fast_validate_bw()
with allow_self_refresh_only = false. This removed the fallback that
re-runs dml_get_voltage_level() with dm_allow_self_refresh when the
first pass finds no voltage level with p-state support.

Some eDP panels advertise high refresh rate modes whose vertical
blanking is too short for a DRAM p-state switch. For example the AUO
1920x1080@360Hz panel of the ASUS ROG Strix G733QSA (Renoir/Cezanne,
DCN 2.1) uses a pixel clock of 800.01 MHz with vtotal 1111, i.e. a
vblank of 31 lines (~77 us). Such modes can only be validated through
the self-refresh fallback. Since the change they fail
dml_get_voltage_level(), dcn21_validate_bandwidth() returns
DC_NOT_SUPPORTED and the mode is pruned:

  [drm] Mode Validation Warning: Unknown Status failed validation.
  create_validate_stream_for_sink: Unhandled validation failure 24
  Rejected mode: "1920x1080": 360 800010 1920 1968 2000 2000 1080 1090 1095 1111 0x48 0xa (ERROR)

leaving the panel with 1920x1080@60 only. This is a user-visible
regression versus v6.18, where the mode was available.

[How]
Pass allow_self_refresh_only = true again in
dcn21_validate_bandwidth_fp(). Modes that support p-state still validate
on the first pass; the fallback is only taken when no p-state capable
voltage level exists, which is exactly the case of these short-vblank
modes.

Note that the issue addressed by commit b96150a70696 ("drm/amd/display:
Should support p-state under dcn21") (atomic_check passing
while commit_tail fails, because sr_exit_time_us differs between
DC_VALIDATE_MODE_ONLY and DC_VALIDATE_MODE_AND_PROGRAMMING) is a
consistency problem between the two validation contexts rather than a
problem with the fallback itself. It should be solved without dropping
modes that have no p-state capable configuration at all.

Tested on ASUS ROG Strix G733QSA (Cezanne, DCN 2.1): 1920x1080@360 is
enumerated again on top of v7.1.8 with this change.

Fixes: b96150a70696 ("drm/amd/display: Should support p-state under dcn21")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5628
Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Julien Le Bourg <julien.lebourg8@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index e82f2d531211..ceb7ca312577 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -2336,7 +2336,8 @@ bool dcn21_validate_bandwidth_fp(struct dc *dc, struct dc_state *context,
 	/*Unsafe due to current pipe merge and split logic*/
 	ASSERT(context != dc->current_state);
 
-	out = dcn21_fast_validate_bw(dc, context, pipes, &pipe_cnt, pipe_split_from, &vlevel, validate_mode, false);
+	out = dcn21_fast_validate_bw(dc, context, pipes, &pipe_cnt, pipe_split_from,
+				     &vlevel, validate_mode, true);
 
 	if (pipe_cnt == 0)
 		goto validate_out;
-- 
2.55.0

