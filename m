Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFF3606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EsOJgKbc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5478510EE48;
	Mon, 23 Nov 2026 14:18:02 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39C5510EDA7
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 12:22:33 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-3282db206d3so9651052eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 04:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795436552; x=1796041352; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VkpezA87wsH4BygJMCDh1GwoGufvYHw4wQvZr1AYzhM=;
 b=EsOJgKbcON8NyebCjTIUAOXNSVxJjPv2R68PiDhLrnM8u5ZX/XXnkZPvZC2Epr4EnK
 /xLUg0Gc3FcVFy3vIqAwfE6XlEMAqZa2q76++214E7z0ss9DyKJC1llMxCWkpj2Z09NY
 y8oZpLzIHS7FB58AIW/4c6HcP9G9x9IFdNbm3fcqTJhbzPjUo7cNXH49Xqdkrsh7iB/W
 nF5VKsaFnfIh0T0DlYB6mklmNh3QdG8/sTEO2FjVvbbgdyGoL1CjYe/N9VuNaMW0qVgL
 AUmJ6/f1pgpKj9lNE+g4WrcNxylpFx5gV/F8L+LODVSzhFPTtX8v2fPdF+RVyM47Sp/l
 zV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795436552; x=1796041352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VkpezA87wsH4BygJMCDh1GwoGufvYHw4wQvZr1AYzhM=;
 b=ozPR+FVAqxXW0ToZbHq84Iql8spquWgILJcdDY81vTYiaaFp0tjwesbXxAjvXuOyOC
 bMOeCi3r6k2u1lnGtv1UaA2eUSZN9dlBIKM3O1Qi3ZJLxCGZA+YGpPAidPHqPOt3qp6O
 0lnYlcY+TdQTSv5+9JbCet1g+TP5mh/A+Lv2Nvn6IwTRKEwmbYg8hU8oE5ezmYQTlvQM
 sWMDytwEt2lyfoZ9sprsUNvFX9pX/ASob8pgcNTMe78JdQxxPYtnGDNQIu8IGsJy7Zoe
 LFHsNy9cUlWbQxEYCnzYfdxudOnuh8GiThBjw3ahdyfJ9s5xSoyAK5RiO18n0NnZAv5X
 uAGw==
X-Forwarded-Encrypted: i=1;
 AL+hErFPj1XZZiwRZ2iHH5qRm/vSUV4UQazxKdrVQBZklMBKxOk84+1H4lLT0UdSYKYmuKdiwCHwh6qVe6U=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8ASO+1Ge1EC71DIBOMm9TtQ2qwrZok1LjFFG81bdIyKeN+usut
 xQ5R8dYOrEVOkUkNOsDlyTCOeO6oWXdoohSVeYnGQDz5Uw8hDo9u4zum
X-Gm-Gg: AZFdTZfyeRm9ct6iDPD/hL9SamVBec7C3zd5xn3V7cXoUCQGj3FgV1IUhi8Rlrvj6Y4
 fNaOJPNOdGSHZ6NksxXrzLhITvps31/nsBVrE96s376gR88v9GcoNM2Bk32it0rOIaK4Jmujost
 Z0ifVDa3z0PyU+4U3UmfdBZgBwUyFNkelBcogIx/pG6pJ4DHm2nSbQ2eCQ2AsHkXyvIxBRI0M16
 FM8WcYJWIymn+xXU9LE/EyUe69slisBRyplsemZ7HxhKlaf35aUiGVyJm1reDZBjSAMNylBTtj/
 2Qd1WtLFdhYhS0kdNlGSZTMTGUunkjNcClPrEj92EcBQ9GyPSQsbeG0cCGKPEXaRXwlhVb6uwOO
 y/QeovIVVUJfbNUBiVph59Rb3BcwdpfLfyOH1b97y5f5zC4hoBuyXjHfE7upBNMflYtYd1vWFJw
 tYvbgEdAa4OCktxzuPCE0l3o9tjGIozwRpaXzV1MJkMjhwJW0MDCHvoNktU9o26Fgtj1VKiY685
 JV1R9xhnJWqeiFEO4VRRvJbD+bWYYJZPnGkXISzhTXXhK/DlGGP0OwIqxfgN/Pi4kHdgjMbPjmj
 N1RAO3d3H6AWmDXK89Xo
X-Received: by 2002:a05:693c:8083:b0:377:678:2309 with SMTP id
 5a478bee46e88-3856ef47a98mr12431705eec.15.1795436552292; 
 Mon, 23 Nov 2026 04:22:32 -0800 (PST)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-386992b404bsm25173398eec.1.2026.11.23.04.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 04:22:31 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Huth <thuth@redhat.com>, Weijie Yuan <wy@wyuan.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v2 1/2] drm/amd/display: Document the union in dc_probe_status
Date: Mon, 23 Nov 2026 12:22:25 +0000
Message-ID: <20261123122226.4101191-2-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123122226.4101191-1-takano32@gmail.com>
References: <20261123122226.4101191-1-takano32@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Nov 2026 14:16:40 +0000
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

Fixes: 52771a3254ea ("drm/amd/display: Wire probe commit path into dc_update_state")
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v2: the AI disclosure moved out of the commit message, as Weijie Yuan
suggested; no change to the diff.

Written with Hermes Agent, an LLM assistant; I reviewed it and ran kernel-doc
on the file before and after the change.

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
-- 
2.53.0

