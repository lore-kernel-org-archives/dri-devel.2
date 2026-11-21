Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABCC606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pbbFkEVv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E90F10E62B;
	Sun, 22 Nov 2026 17:14:32 +0000 (UTC)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DBA610E008
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 04:14:34 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-15dd124bbe7so3522745c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 20:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795234474; x=1795839274; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y2KKhwdxNB1TSs7gh9qzf2mf3Ng/63JJG6Lmx8wv1zw=;
 b=pbbFkEVvQJXsDDGvwoSLmRTWY53UKE9ummXkqZti9qAteaI49Oc2+UCJXhLjFK8C/w
 13SUtnM/CVDYBN6k21bpji25yl33lA6sI7g3fT2T3MiuDFN7UP8RnZjIbgQW8tm/5z2V
 TOguo1ZQ1/66x8nCBIN3QpN3hcKdd+7dTdCFzpZG/D33XoeCFdqwx/XvqFyI7T8UtAGN
 uE7/TPomjMUYIHP8TRIKHzro2Kxw5l66tOh5jiDAXEgI//RARMhqgbqQLTmmmmfjH3D/
 MNamQjJp1DrvdAcPOL3FN2Q9fOA6i40AsmjNA1yKbtqixF2RbbdixXiMRVuqbYAM7fOl
 e7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795234474; x=1795839274;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y2KKhwdxNB1TSs7gh9qzf2mf3Ng/63JJG6Lmx8wv1zw=;
 b=zfINaahSnRMrYLL/lgrEci6NmJnFfQAj5PaKOlAEkRczbMwUI6VuN2PwDuSth4K5i2
 pap1pJqjq9r9ZGoqCv2xUOX569UrzJudMNLznvDM+h0zzDFopbKhrxCPZCJ96PRV4MB4
 7rRjB9IMUL+HQgnqaBJHWiZ/Scir8BXmSOSb+pwbnWixzwiPlQUGDNfJFTiU6ckSkxz+
 fIXNsx3ATrCRdtUm7RtsT/dNdDSlqODXLns9hPoEwmeKHVc+agQdC/xGsIA1r/YOol2t
 caFK91VYlwNqjILJ54lxTJDBEwq10EmTOB5gJd6UeiyhpKSlgaspi3ZvVW7GBosuQU5y
 AD7g==
X-Forwarded-Encrypted: i=1;
 AL+hErFaZ+FAoPQfKI+y3O0TQcrTbqekJLldUar8G038kxT1xsYS08dWcTkY8a5SF8aMky4SWlLXa0w4Heo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9qEXIV7mICIjPqU69nBi+RNYCSWCMo1b7cLJM70PziKL6Sq4n8
 ZKUp7HttJzs/c3+DVyszzp9BYnXgOEvXRRY5C8nOnNLE7UQRkkADpCRW
X-Gm-Gg: AZFdTZdOuDsy6sn6EI4YiR/53surRJtgycQwQ+rfPlCIY8ghokR3BzcAPPDgnpvXU/B
 DsoAPe6K/ibuHVJBrquS6ff2t8WnQYbHg4af/1wfrPcNdSnRNDj+rLHaLyJA14Yj/GMtlpJkxPA
 h3k9KEwQs+VEI8Wy9yD0noAEUzxR8u99EstUjhbL230c+iCKIDwEXd1aE3xRR7oKKecVcwmd6z7
 xQqA0tKH5/IiuQd44ptYk8Sdx4EJVgRzKc7FgT5hlgGw+kFcx5SRJtAxU4wTEBgxRC89nHFj9bA
 NRX1xh8pplFC0YTdsehRpKx31gROhtmWih0FtuEPOwmxWu/0QUo+Laz6cr2zOfcEegg5QqfhmQK
 FvhbSjwrOkFg6ZoP4WA3PqmCoHBN6rXLtT2Vxxml/lB880rxXGgg0eiK0o3oB3b8OALUEYxw+sA
 EWSutdSb4h+Pyu1UZiDP7GL9nihJwXK331e6ODoYKzFJ2lwNM0vvlRcjPCTXi4uBa+7bkeVEE3m
 4EtgedpSm9yRHZFwYzm69L55QRw+Ta2vF94/Vl+bxvnmfLdF/jTTN6oy+Ofkzncc2IYO0iuTbo+
 518NPBG2ZcvD+DZ05pMn
X-Received: by 2002:a05:7022:7f04:b0:166:af48:a2ba with SMTP id
 a92af1059eb24-1b5566fdfc3mr6201058c88.0.1795234473722; 
 Fri, 20 Nov 2026 20:14:33 -0800 (PST)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5566c1142sm10379603c88.2.2026.11.20.20.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 20:14:33 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Huth <thuth@redhat.com>, Weijie Yuan <wy@wyuan.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH 1/2] drm/amd/display: Document the union in dc_probe_status
Date: Sat, 21 Nov 2026 04:14:26 +0000
Message-ID: <20261121041427.1743954-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The members of the union in dc_probe_status are described one by one as
@u.bandwidth_mbps and so on, but the union itself has no description, so
kernel-doc reports:

  dc.h:2225 struct member 'u' not described in
  'dc_probe_status'

Describe it, saying that the member holding the result depends on the
probe type.

Written with Hermes Agent, an LLM assistant; the author reviewed it and
ran kernel-doc on the file with and without the change.

Fixes: 52771a3254ea ("drm/amd/display: Wire probe commit path into dc_update_state")
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d3c484f45333..debdd69bbe4e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2207,6 +2207,7 @@ struct dc_probe_latencies {
  * @valid: true if a measurement was latched.
  * @measuring: true if the hardware counter is currently running.
  * @type: type of the probe that produced this result.
+ * @u: probe result; the member holding it depends on @type.
  * @u.bandwidth_mbps:         peak BW in Mbps (DC_PROBE_PEAK_MEM_BW).
  * @u.latency:                min/max/avg memory latency in ns (DC_PROBE_MEM_LATENCY),
  *                            stored as struct dc_probe_latencies.

base-commit: d0f871bfb831705d9f55479f5b2b40f636ea7b16
-- 
2.53.0

