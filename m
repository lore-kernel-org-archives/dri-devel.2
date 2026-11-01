Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F4A606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L8nFT6yY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DADB10EBDD;
	Mon,  2 Nov 2026 08:04:12 +0000 (UTC)
Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com
 [74.125.225.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A1710E3B6
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:25:57 +0000 (UTC)
Received: by mail-wr2-f10.google.com with SMTP id
 ffacd0b85a97d-48dea979eb9so1238209f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 15:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793575555; x=1794180355; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2fmwcgE6DPFC2W7yOeJbjLdJRykazNfLohJWxFt/Qfw=;
 b=L8nFT6yY4WzPwoZNg3r6Oowi+L/1AaUQY8wqDyBwJFCbgxccbJjwu/ymQvkyMEIY4B
 dNDqr7U72Vk1q5iKZySyFh57bO+8yEV7/6XcsfS2b+MYOxYGUFFgQ2Q0WTGeQ6w5ItTB
 esuDr99EIYmupPkfsGfHJ+dfUrMLEd/bQ/UIpoi4kxYdmHRp80fQKSWJ2j6ZGXl0sYHg
 D17emftocY3nSetIWgu8VvQX0oaTBgxbsOikr16F2XXGVoy/PtFkGQY3ROYtKFbbDIwE
 +zLSyfv8dZgWaOdQjombqCl8MONYYBXlJYBzcSWHI152n8VSIpolHbfKzokF/f9J4Z4I
 LYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793575555; x=1794180355;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2fmwcgE6DPFC2W7yOeJbjLdJRykazNfLohJWxFt/Qfw=;
 b=hhHtnN7EDf+0z01CKn848u1KTZoXRNDfaKkeDxQSm2VBcQJjFwlLrFSk9KtGQbF2tw
 wH0hO+vuzyOJhe+rt7P9wTlfbxuzq+mFm0QfR48l6hdvFtWGdVdeMUemkpjVcwZssTMW
 EL4vHxD8jErbdgRRVAuzPLiKR2TT6sz9pU1K4vOaQgXO85xiN8oNKKS3d3y45iURFhI+
 y16QkpwqtTzhKdILrYPZQvFl0pkq7jKHDp+52fcf61S8SBeu5EIV+NRZZ4Unk5FbvZkx
 F2j3avwCPyeGy4/SgXK+jLm/OOTFZGQpDEXlI+gGn59+UgiuftMoTomLfyDFL36ZQqXC
 F5WA==
X-Forwarded-Encrypted: i=1;
 AKwUvByTfak9yMziksR43UmeQ3oV2+Dp59zd6kgp1oqYOHO8Va+phy+FWYtTPYCRed9qFN2+WVNCGMxVVP4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJG1GwOP+10cGeQ0AX3Ie4/Hd7Uy4dcmAtHrs3i1cbr8WvgIkr2
 ZEZN3nk+8ZmEUtoBd6PDK0G0cPVPwD1wmns+7RpPpfSJKgN/XOv3nhkA
X-Gm-Gg: AYBFou15X2Kw4jDN6KY/+2pVjJwr4UQpDgPeIxx7nOQ0n1tfX2ODOP6sMQO8hzBIlAh
 HAvrPjGONOmsbsPtidJvhlYDMFTl6bkDjblQ8UEUJts8iIW1rz0V0YYi4iYx5WAXKCLf0+yr+r9
 agJ5Ifyg5LLs4rEuwMqpxwOBurTIGrmncqFd7cQvtZOWS7Bs9YU+6bTJl2QoRU6f1Hu55A0IhET
 CuM8QL1TVbC7SXxASzRyVWWDgeCw241zYxnWOMnttjPjCHZ8TaSAJG4EIp3zEa1zXbmbKwncBpZ
 iNPPCPPVfeEfxOG19+GC31AA+A6ieKYSiCp5EpmFAXfiFwJaQ7WakbDBapyXNdukwjVKEQ2l8JP
 RXyX40rck49Yv4cofCQMSNsRBFgxs8XlwhgEBHxhlsRAnJSJkg3j9XmmK1FEx2f9KWOZw7EspOO
 HT+3iS6N/MeF2GwrMdox2j+QJaagTJ2f+LsNgo4Qu70vg+h577Rhv4YpLh2PDs46h64WsJW9wKy
 UAeCEf7WPTLZ8+ee8h978ykceaFp+MAabqEvOhdN8bokETZgzn4wzz0fv39W7gd5SQ6++lSiQv4
 Tq3I8lQ/V27+hvqe1cQjfYfJLGbg3yh8OwUjPwmqvCxqjyocR+aylM7u
X-Received: by 2002:a05:600c:190f:b0:4a2:1a:a11d with SMTP id
 5b1f17b1804b1-4ac1275c26emr179844595e9.0.1793575555586; 
 Sun, 01 Nov 2026 15:25:55 -0800 (PST)
Received: from [192.168.1.7] ([31.94.68.191]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b9b54dsm16274246f8f.47.2026.11.01.15.25.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 15:25:54 -0800 (PST)
Message-ID: <8eb61179-c5b8-41df-a466-8b5c388b6b41@gmail.com>
Date: Sun, 1 Nov 2026 23:25:52 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Richard Lane <richardlanedev@gmail.com>
From: Richard Lane <richardlanedev@gmail.com>
Subject: [PATCH v2 3/3] drm/amd/display: report synced displays to PowerPlay
 for MCLK switch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When driving multiple displays or tiled panels with identical timings
(such as the two 2560x2880 tiles of an Apple 5K iMac panel), Display
Core's program_timing_sync() aligns the CRTCs into a timing sync group
in hardware during dc_commit_streams().

However, on DCE < 12, Display Core leaves
pp_display_cfg.all_displays_in_sync unset. Because PowerPlay is not
informed that the streams have synchronized vertical blanking intervals,
SMU7 prevents MCLK switching at idle or causes modeset underflows.

If all active streams belong to the same timing sync group
(timing_sync_info.group_size == params.stream_count), report
all_displays_in_sync = true to PowerPlay after committing the streams so
SMU7 can safely downclock MCLK at idle.

Signed-off-by: Richard Lane <richardlanedev@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 74cd88d8d580..b4531383437e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4777,6 +4777,16 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
 	dc_exit_ips_for_hw_access(dm->dc);
 	WARN_ON(!dc_commit_streams(dm->dc, &params));
 
+	if (params.stream_count > 1 &&
+	    dm->dc->current_state->stream_status[0].timing_sync_info.group_size ==
+	    params.stream_count) {
+		struct dm_pp_display_configuration *pp_cfg =
+			&dm->dc->current_state->pp_display_cfg;
+
+		pp_cfg->all_displays_in_sync = true;
+		dm_pp_apply_display_requirements(dm->dc->ctx, pp_cfg);
+	}
+
 	bool frl_stream_found = false;
 
 	for (i = 0; i < params.stream_count; i++) {
-- 
2.55.0
