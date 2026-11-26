Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0431606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yGOm6lTS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7589E112829;
	Fri, 27 Nov 2026 08:29:12 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A87B3112701
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 20:58:22 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so4871980f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795726701; x=1796331501; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=35h4zBjbR7gM1F3Ki/dOQbia67MOOWg2rYj7xt/yKT8=;
 b=yGOm6lTSVhkf/MeAFu3KYeB2LuijV83vY/rRcp1oCGwsNE3YdPEGdAl2b/XNHH+QoR
 EUO1rhRP6wIKhSc/6XPB+0vsUBFcpICv/wCvrlueqkuqynNGIZA++MvjTzzNzB8AlMz0
 EOZjICEPdXa2XS8o/VzG9Y3heVAYL/QjNmFqQKPTiJP319ZkCEhp9ON9Ql0tTSKs28Em
 KHSX0TzInk8SS0oFO0SRn24/SIgCveactxyamN3+o/kYK33wxIIHYck/eoEUOhwAoh29
 uSqrLKZln00tCGY497Xh0AH6u8cM7aYrz9+ldxYCGIsr37kBZ3P7kczfZ1AftRYXPHJZ
 Ks0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795726701; x=1796331501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=35h4zBjbR7gM1F3Ki/dOQbia67MOOWg2rYj7xt/yKT8=;
 b=gTkV4uaSlZSJ9/e0B3a9cew1Za9ZZuIN6+TNCi/RLlaJVh9KxQNXYGEczvRdzPeFSa
 Ac9R3j9Cnh3IYasflemOSfRIsbvfainSpMwMVdEM1VNb6Hpwhvkh8U4tQyUWzLCF4Qv9
 MkI0HHHMHhxduo01JHyF66f14/R8e+5D1d7FtzC4RLirZBTrYVlIEYs6UqSSnP/Byxex
 IuM4n15mXzObuCxSeaYsk6VD2PJA99vIu8Dsk2aNRS5V66v3f944IhUahBPBt6U195oZ
 9lkiaDs+FUx5pqmEqY21D24Yb5M/nK6Ydvbod1+5qYoXtMSnKUnvTLJA//M4m+WFHeDV
 r75A==
X-Gm-Message-State: APuU4Z83wXzyfFxm+r4HpR9R0kz6yJ7SXhIHLCJ/ywGhPMufW5udKkIq
 HnzxU6uSZ7EAuXkMYbTjca2sMcHaGvYuQqQCoRtjUPMbhQJh2X9c/lhX
X-Gm-Gg: AZFdTZcOxza5nAFJwusN0Ak3GXxDh2APRRiEchJ4J16CRR3Iv4qgj5vHf070+Veu+Ug
 jQR32XNPN28pwhpRgkNUGCMAaLsZVc6pNrp3rjyN5gFopuUiEZ7RSX2De2SJH2ff+roJRs5JXLX
 QBp3H+E51ybzLk+amZCMgTXVWSU+K6rV660PpYXSXg8GEVTeoO2J0zLxzcKwiJqo8trlEifrRkj
 VP0wMTaFrIx8J11cz9k4WwpSc6U8o+Bu0z7EoTbu3y1GhdD5wd8yPN2y+rQemb0nHc762DzCko3
 k/jQLrTum6CvDnxtE3WPgYAkGLbIMmPuslGKUq8gE/3wnxfWAqyXaJLItvKy+NgJT+rh1jgobb3
 yKbvnOQArndrAXtoUDMU24Vadxh4SvcfqfMhxFEuI06BTn7AJ1i1Ap4rurDnNelAVS8/o9OZDNh
 rUmKr1M2CdmaL8jCar0F+mzYfT6T3Mjcc+bc73nqnSLgORnFqrc7YaEP+EBmi10Vyt4ZMNfgteP
 9INtb+cU4ZdNBWJu3jVeDCbcX6+JQgiVd7tNgTD8vxxd7xBLu1IrFUgxioCDaAI2LHUlhEYZi5t
 Q+PaSB/1XWH8VrUBX9PiFMYsCXubnLJ4k9qKIql//H5AiTcac8cZejQ72w3k9iCJ2fFGR2Ejo2+
 OyKo=
X-Received: by 2002:a05:600c:64c8:b0:4bb:68e5:b952 with SMTP id
 5b1f17b1804b1-4bb88819be1mr422243895e9.16.1795726700975; 
 Thu, 26 Nov 2026 12:58:20 -0800 (PST)
Received: from localhost (2001-1ae9-5b-ad10--33.ip6.tmcz.cz.
 [2001:1ae9:5b:ad10::33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb85399d52sm611178075e9.6.2026.11.26.12.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 12:58:20 -0800 (PST)
From: Arisa Snowbell <arisa.snowbell@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
 Arisa Snowbell <arisa.snowbell@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/xe/uc_fw: select the DG2 HuC blob for a load by the
 GSC
Date: Thu, 26 Nov 2026 21:57:57 +0100
Message-ID: <20261126205758.49845-6-arisa.snowbell@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126205758.49845-1-arisa.snowbell@gmail.com>
References: <20261126205758.49845-1-arisa.snowbell@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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

The GSC loads the whole DG2 HuC binary (dg2_huc_gsc.bin, the one i915
uses), so there is no legacy CSS image to find in it for a DMA load: parse
the CPD header for the manifest version only.

This enables the HuC on DG2.

Signed-off-by: Arisa Snowbell <arisa.snowbell@gmail.com>
---
 drivers/gpu/drm/xe/xe_uc_fw.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_uc_fw.c b/drivers/gpu/drm/xe/xe_uc_fw.c
index d0ea05923..05f51378b 100644
--- a/drivers/gpu/drm/xe/xe_uc_fw.c
+++ b/drivers/gpu/drm/xe/xe_uc_fw.c
@@ -137,6 +137,7 @@ struct fw_blobs_by_type {
 	fw_def(BATTLEMAGE,	GT_TYPE_ANY,	no_ver(xe,	huc,		bmg))		\
 	fw_def(LUNARLAKE,	GT_TYPE_ANY,	no_ver(xe,	huc,		lnl))		\
 	fw_def(METEORLAKE,	GT_TYPE_ANY,	no_ver(i915,	huc_gsc,	mtl))		\
+	fw_def(DG2,		GT_TYPE_ANY,	no_ver(i915,	huc_gsc,	dg2))		\
 	fw_def(DG1,		GT_TYPE_ANY,	no_ver(i915,	huc,		dg1))		\
 	fw_def(ALDERLAKE_N,	GT_TYPE_ANY,	no_ver(i915,	huc,		tgl))		\
 	fw_def(ALDERLAKE_P,	GT_TYPE_ANY,	no_ver(i915,	huc,		tgl))		\
@@ -555,11 +556,7 @@ static int parse_cpd_header(struct xe_uc_fw *uc_fw, const void *data, size_t siz
 	if (css_entry) {
 		int ret;
 
-		/*
-		 * This section does not contain a CSS entry on DG2. We
-		 * don't support DG2 HuC right now, so no need to handle
-		 * it, just add a reminder in case that changes.
-		 */
+		/* The DG2 HuC has no CSS entry, its caller passes none */
 		xe_assert(xe, xe->info.platform != XE_DG2);
 
 		offset = entry_offset(header, css_entry);
@@ -661,6 +658,13 @@ static int parse_headers(struct xe_uc_fw *uc_fw, const struct firmware *fw)
 	case XE_UC_FW_TYPE_GSC:
 		return parse_gsc_layout(uc_fw, fw->data, fw->size);
 	case XE_UC_FW_TYPE_HUC:
+		/*
+		 * The GSC loads the whole DG2 binary itself, so there is no
+		 * legacy CSS image to find for a DMA load.
+		 */
+		if (uc_fw_to_xe(uc_fw)->info.platform == XE_DG2)
+			return parse_cpd_header(uc_fw, fw->data, fw->size, "HUCP.man", NULL);
+
 		ret = parse_cpd_header(uc_fw, fw->data, fw->size, "HUCP.man", "huc_fw");
 		if (!ret || ret != -ENOENT)
 			return ret;
-- 
2.56.1

