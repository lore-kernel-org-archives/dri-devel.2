Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C663CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 22:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A1F10E499;
	Tue,  5 May 2026 22:27:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="RqDm8/VN";
	dkim-atps=neutral
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com
 [209.85.210.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E6BD10E499
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 22:27:59 +0000 (UTC)
Received: by mail-ot1-f98.google.com with SMTP id
 46e09a7af769-7dbd23bc684so3540354a34.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778020076; x=1778624876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B2hbQneUJWNpYNXnzo7++xJZc6uJ9kixg0kEf8k1k0U=;
 b=o5w3JvodmTMMUP0vAtSbOk4xK0txdht47JFKzBDE6DGZvEETbvV282iZkFBWXU0w0c
 OL0s33g9k2Hp8rMjiatSEpM8EWTfxskfg2DWZfoYyVay5VoGnzU7uSRx+LZYhEyO93Lq
 zQR2OEEo346gJ553c2/BYo8Lz4liT7Tejjy46c1wTyKCb7BFWtRze/m9NipffvrZ1MDa
 p8jQZjVW5M1QuVPCOaC4iwXhU8ZyD1WrlyU2uEezHUhezzWMzFb9U7g2GKKyYFx6mqbP
 3zu+EOFCKCcofEpM2axlhmBKx929dur2kXEvby601xM/IMr+qkEXSoiP8D6zsLyipIcD
 n84A==
X-Gm-Message-State: AOJu0Yw/4Sb0+ddenIWx8PPCA9CrlXkYAVvE/reOFXNAT2n25n/Xk9Ye
 dr8kdf02KWiC/sK/C3EiNKa3XIK32/po0E2X/5NK+KA3o3gpEpRNFafNhaNJtfUH3LN5FH3fLKk
 zxSvAlYbzWAga0d6B/4FJC+Oh1qtcAN+LAmZBVva0N/6Gv6OE7KpazCHcNny6MfiSnZgxOR8NoS
 oCI+glMtc3wPZRO1oIWDZ1Eymd4L1IU+B7rZdVjyt7Pc1nHErsKagHMIATxRclAxgzX4at2Qwm1
 1huY5ABCrtXxHRfee6Z
X-Gm-Gg: AeBDieuGV0ooRTQY/VnhYZgToEhPgCXGAEKSsBiXWD8fcULpYnsYdcS8mkbc3M8AIcR
 09x6yilmmdKsH7IA7PrKI/5G1hGr0OIY+uwtGVSMx07Wcm9HGjxlAYFWKyP15S8xv2HBPzcD/+H
 nw8e/p03IO/c2HVYPV7SiUe+KgPEya81tqGEhjArbK3ceP89uXJ66d4NI9FkexEmT1svQaKDv0t
 7Zw3P931/Uhzc7jFg+KvA7KPxK21xp3N6jfpuapF33j8l6BdzLiV3Dy8uOH9QSS8Lm0xL/T+2Om
 GRbeMX5r88UXHggJBEpJ1TeKnTmJHxNGlKE09NBObA9j/P7mc0csO5JJEGQAD+9UhhFzi5dd69o
 ITWjpBDVc62C4vSp1Ux4cM49xvnNn5cVivZP5Qg2/f42vgCGgGbkIhgsZvXCcueFOUKRZeNSG07
 tC79cWjCWn/StWdA/JF5hFtfZXQA8JUPnqAgeGGpgEij7CzI8eHOCtreMwK5dPD3zUAyE=
X-Received: by 2002:a05:6820:c8c:b0:68e:b81b:d81b with SMTP id
 006d021491bc7-69998d0db23mr451317eaf.31.1778020076417; 
 Tue, 05 May 2026 15:27:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-696894ce108sm878458eaf.16.2026.05.05.15.27.55
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 May 2026 15:27:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8bc140520c7so13627016d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 15:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778020073; x=1778624873;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2hbQneUJWNpYNXnzo7++xJZc6uJ9kixg0kEf8k1k0U=;
 b=RqDm8/VNXm2OxW4Joq/nc/EBQCSIouJ7jkW2bvikwHzLnKh1df9VRyxwSqTc8MWwhC
 7sWe9Fh3+UlCpG72pzNklt5lACuuHjYVEC3YVlg1MHRGZULluFtYHSZTwGh+eQimgyyp
 Ozu6i/9W27f0pRybmTPsBZJyEMMAtE5ty9pes=
X-Received: by 2002:ad4:5d4a:0:b0:8ac:a553:529d with SMTP id
 6a1803df08f44-8bc43df5d35mr11704246d6.23.1778020073380; 
 Tue, 05 May 2026 15:27:53 -0700 (PDT)
X-Received: by 2002:ad4:5d4a:0:b0:8ac:a553:529d with SMTP id
 6a1803df08f44-8bc43df5d35mr11703676d6.23.1778020072755; 
 Tue, 05 May 2026 15:27:52 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b539aa6f5fsm162692886d6.21.2026.05.05.15.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:27:51 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: ian.forbes@broadcom.com, maaz.mombasawala@broadcom.com,
 Zack Rusin <zack.rusin@broadcom.com>, stable@vger.kernel.org
Subject: [PATCH 06/12] drm/vmwgfx: validate DRAW_PRIMITIVES header size before
 division
Date: Tue,  5 May 2026 18:22:27 -0400
Message-ID: <20260505222728.519626-7-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505222728.519626-1-zack.rusin@broadcom.com>
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

vmw_cmd_draw() computes

	maxnum = (header->size - sizeof(cmd->body)) / sizeof(*decl);

where header->size is u32 and is taken straight from the user-supplied
command stream.  When header->size is less than sizeof(cmd->body) the
unsigned subtraction wraps to nearly 4 GiB, producing a huge maxnum.
Any user-controlled cmd->body.numVertexDecls then passes the bound and
the loop dereferences decl[i] far past the end of the kernel command
bounce buffer, producing an out-of-bounds read of kernel memory.

Reject undersized headers up front.

Fixes: 7a73ba7469cb ("drm/vmwgfx: Use TTM handles instead of SIDs as user-space surface handles.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index b07f052474d0..2410d53a75aa 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1571,11 +1571,17 @@ static int vmw_cmd_draw(struct vmw_private *dev_priv,
 	uint32_t maxnum;
 	int ret;
 
+	cmd = container_of(header, typeof(*cmd), header);
+
+	if (unlikely(header->size < sizeof(cmd->body))) {
+		VMW_DEBUG_USER("Illegal DRAW_PRIMITIVES header size.\n");
+		return -EINVAL;
+	}
+
 	ret = vmw_cmd_cid_check(dev_priv, sw_context, header);
 	if (unlikely(ret != 0))
 		return ret;
 
-	cmd = container_of(header, typeof(*cmd), header);
 	maxnum = (header->size - sizeof(cmd->body)) / sizeof(*decl);
 
 	if (unlikely(cmd->body.numVertexDecls > maxnum)) {
-- 
2.51.0

