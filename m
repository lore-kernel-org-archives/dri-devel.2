Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A340C88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E27F510EA15;
	Sun, 13 Sep 2026 20:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xx4mQpDa";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC5F210E664
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:10:42 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccafb74fso590071a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 01:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789200642; x=1789805442; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eSYO98oHKaatdSJA86Zv/zyqDt8H9puU2z+h8TsbVQM=;
 b=Xx4mQpDa3yPCu3Fud9DGI3kgVQ0S0Z2Du5WVdN2eWKLx5lJyqNQhJzGpziC8n7ex7V
 ydz1e+/T7ec+wBaqxQm2EVdmVp69SB8eGb1tvBVWOtjxEtlQ1oYSzLwqmatH7Kz9k9og
 EcS83jylefThNAHdYpcY0TAydGe8nVSlkvmanYPISu5wen953sQOcdrG1PEVoEo9EcsS
 5Kbo2HPCy9Fhi17+cm5Q9/bz4U6nje7C/ez4PVAOgBtakqKSFgP/79m6OZwk0rSwa3SM
 NuGBy8VC1WdZN7lX1LtDViCf+eu9oBoMRxbcxFr7IYIYy6v+Ioj5ZZJKhJRIZw0iNcHR
 PqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789200642; x=1789805442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eSYO98oHKaatdSJA86Zv/zyqDt8H9puU2z+h8TsbVQM=;
 b=DiA/5Wzc2aouQKVv/RB9T3js2rfjDyXiSCfXUaTDXhLm0F/HLJIB05mH/KMAEJIELk
 iVBV8TwRDjCCkvTurTdCWePKqy1sKQqmSTg4iSYDQtKbXIND5qcFjjNCxVsh2A4OMEk3
 dHg6b2199oEkFuUGPLS8w/mRRwDkApBblKnweReb6R+vLXhvyB6wYjHS/11H3YeiGXuR
 7AS4ZLNshY91WCICmIiSJNfw55DmIu4jS90JnDSZgMnhIe8mpfZu3haLomLSZ4EN/BUz
 /6ORtYpwE8nggKa+9+J+lX3KOeIdw3qG4bwYFveDqMr/KB26VARJMPNlXm8Ql4nPDiOE
 4ttw==
X-Gm-Message-State: AFuF++kx96i11mDE6XFthyRRzOs0QD98t6Xn/0niBWWJ2mBYJHu6k5BS
 evaNLbIzovF7MQauWruIlvGUvNyzy/Zl4lSJXvKvwpMwjsCfcQYjFGNzNiPfmxqugEI=
X-Gm-Gg: AYBFou04n0ARiqyqZrLpIzNy3+16zf/p0imahiqHgBJC5gwYMuI8Je63hEU44GZXuK4
 OCYICEGxsePaK3AMEdb0Reh9sKbqPJryDEemrRx5FUC/fAjTBawhx9zbJzGbU/15qdIAkFUfpRa
 CuLKFtLAtdxJSSJBHc/Fk8GrgboIlxec4FupL/BCsWDW3WUTIdKNl7RDH0RV3BoOiVd66xJDP3r
 bD3GzWwmW9XIP1hcjAaKoiFbMpA4xebtNydgOPJqiTmIVpdlur0k3WPdg0yQbZ1g0JNk+W0p8b6
 eD9IOR1rfqR8LY1gEmph+7A4jPp6kVdUKBSwsQ0TM8TdtIA9yUwJSPewo00NwcVFYJfyKWGDEDD
 0coP0dwwjR9sl2AepG6CfQtDYsbDNd+HM1Ue7qLsDNB//H8Zzn+tDEP2v6ET4YrynLMJ6spnDnD
 3fP7p/b0wYCA3NqS2OzSBVIr5AUjJkCMT/6PVGUN07Y8feqN2U8rP+JXJIRBnDyIVsMHoea+wsm
 NQTMvNIt7l/ZzEggrVPDBAvkQ0Ubc4nRFqW2AVj5Hr+2r/KF8Bl3RnGlEAAE5d74cIaAD71GOCa
 Xq0YbMi0PCiNicKrSztadMLJTmV63psRL+nBl/P1QQpx
X-Received: by 2002:a17:90b:28cd:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-39d9b983602mr13970959a91.0.1789200642156; 
 Sat, 12 Sep 2026 01:10:42 -0700 (PDT)
Received: from 0xiviel.ip (122-63-135-80.mobile.spark.co.nz. [122.63.135.80])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39db7ae6d25sm982474a91.1.2026.09.12.01.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 01:10:41 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: Min Ma <mamin506@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Eva Crystal <0xiviel@gmail.com>
Subject: [PATCH 2/4] accel/amdxdna: bound the command error payload length
Date: Sat, 12 Sep 2026 20:10:10 +1200
Message-ID: <20260912081012.2274075-3-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912081012.2274075-1-0xiviel@gmail.com>
References: <20260912081012.2274075-1-0xiviel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

amdxdna_cmd_set_error() computes the length of the region it scribbles
over from the BO size, without a floor:

	memset(cmd->data, 0xff, abo->mem.size - sizeof(*cmd));
	if (err_data)
		memcpy(cmd->data, err_data, min(size, abo->mem.size - sizeof(*cmd)));

abo->mem.size is a size_t and sizeof(struct amdxdna_cmd) is 4 - the
struct is a u32 header followed by a flexible array. A BO smaller than
four bytes therefore turns both lengths into a value near SIZE_MAX, and
the min() in the memcpy offers no protection because the underflowed
value is the larger operand.

No such BO can reach this function today. Command BOs are created by
drm_gem_shmem_create(), which PAGE_ALIGN()s the size, so mem.size is
either 0 or at least PAGE_SIZE. Zero is reachable - PAGE_ALIGN() wraps
for sizes above ULLONG_MAX - PAGE_SIZE + 1, and nothing rejects it on
the share-BO path - but a zero-sized BO cannot be vmap()ed, because
vmap() refuses a zero-page mapping, so amdxdna_gem_vmap() returns NULL
and the !cmd test above rejects the BO before the subtraction. This is
not a fix for a reachable bug.

That leaves an unguarded size_t subtraction feeding a memset() length,
whose safety depends on a property of a different allocator and on
vmap()'s behaviour for a zero-page request. Compute the length once,
reject a BO too small to hold the header, and use the result for both
the memset() and the memcpy() bound.

Signed-off-by: Eva Crystal <0xiviel@gmail.com>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 163b5fc..c24bf1c 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -152,6 +152,7 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
 	struct amdxdna_client *client = job->hwctx->client;
 	struct amdxdna_cmd *cmd = amdxdna_gem_vmap(abo);
 	struct amdxdna_cmd_chain *cc = NULL;
+	size_t data_size;
 
 	if (!cmd)
 		return -ENOMEM;
@@ -173,9 +174,16 @@ int amdxdna_cmd_set_error(struct amdxdna_gem_obj *abo,
 			return -ENOMEM;
 	}
 
-	memset(cmd->data, 0xff, abo->mem.size - sizeof(*cmd));
+	if (abo->mem.size < sizeof(*cmd)) {
+		if (cc)
+			amdxdna_gem_put_obj(abo);
+		return -EINVAL;
+	}
+	data_size = abo->mem.size - sizeof(*cmd);
+
+	memset(cmd->data, 0xff, data_size);
 	if (err_data)
-		memcpy(cmd->data, err_data, min(size, abo->mem.size - sizeof(*cmd)));
+		memcpy(cmd->data, err_data, min(size, data_size));
 
 	if (cc)
 		amdxdna_gem_put_obj(abo);
-- 
2.53.0

