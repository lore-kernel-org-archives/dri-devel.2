Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B12CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC33010EDB7;
	Wed, 24 Jun 2026 07:47:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=digiscrypt.com header.i=@digiscrypt.com header.b="RKSTPsc5";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE44410EC1E
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 17:20:45 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-842338c18e0so133820b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 10:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=digiscrypt.com; s=google; t=1782235245; x=1782840045;
 darn=lists.freedesktop.org; 
 h=mime-version:content-transfer-encoding:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=LboUvQxDAcNW8auFHhQm/qvp/9k1RfCH5bsvLJJqQe4=;
 b=RKSTPsc5YeSJz8LVhuxn2hiPlGlb3aC/Nav+tq90KYa0qa6Hqw5lSE+ArUCzBsbAgd
 2XpzFnkUUU7ZBiMSwKwmrX5tl6ulm8lRKsASVej+N+II8pukLxVKRR5YmOJd2VLeS+fq
 YD62kea7+oK20if87wdzBvUDZFe/xxoQT4y7lVJD/DW0bY+DPvefc/qsjw1m1rscmqfW
 M1BIKY1fu4zirys9fmu+gk1psiISI5p909LUOMk5sC5bA4H42rQOnCsg6mWw4Was7U0q
 h5tdGy2r4C2subDvRpKNNDC7OcW8NUwtlI51sAtvC77JojHB8qHg5L5ZzDn/W5gYhSHq
 9VHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782235245; x=1782840045;
 h=mime-version:content-transfer-encoding:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LboUvQxDAcNW8auFHhQm/qvp/9k1RfCH5bsvLJJqQe4=;
 b=IX81dVresPgqIFu4eHGjnV3r3jBjtW+Q9gfr1PTioVrcQAsJKL0il/+qRK8dyw8LbN
 dxPzHd4ZviFAyY+kw4EsI6HMrUNK2p0leMu4SqSx8DuL+6xjFacBXs1Hf/uTDukdp1k9
 qszisN6RdUn6UZ25jBmLsleDuEBG7jGFg46zAK/i1L2y30haewOYfUHNWZj5Dhp8iWm4
 Yn1MgwN5fJbnrxVToN27UqNww9gr2yEd69gsQMaoGpnr/0xG3TZyKNisS42cyT8xf520
 T+QBlTUe3QOE5EL1gyCP9pU9koQa8YdKvrFynMaEy9UZbZ3G5a7WaXVxzgF4B4Ap5hrA
 Bn2A==
X-Gm-Message-State: AOJu0YyPqxVxGjZEpuxKfPlX55cNWruG9lfdwoje7FT1pFq7E+paPrZ/
 0eOROZ2J85a7NE+Eb9CJPWjikGJCM6AUBWmSBnTG/3Xm/9smcWEp7rfKWDgpmmVr5vzkm3+8RhL
 ASh36D85P0i8=
X-Gm-Gg: AfdE7clIQK9luGsXXacKE3BdxTizMzS8fBKMAlSFblwBhdq7cEaPiXkMKk8hjUcV1Qj
 SDC+NrWH5HCodI1kXWJkPB0jpNsgQ4mgypr6AtaeK1/CrWMPqtU227Rbn9G5EJeoFF0OkgEg1/w
 atJiUd7MrKBIl/B3Tk9TFMYeBo7Onupjsj9WlsM3j25kOy98xRyVT+Fc9Oa1Hwx4dViGVGvQ0xz
 FaSEVWfPGF7py++r9GBICkM1A6u9zglHnKXLkPXDtkztjOClmpHavHkBSLYFFhGk7q8njV9JifO
 kpOlKo7vatvyVT5OeRMKHxd+1GSP1Xvp6TNtstNYwIXqMYvb4aoL+QYIR+XBne/hA0fxpPJ2s/n
 q67liFLunVwycpoKrcYMD/0AmUHm8dlQM/89rLDx72ALZzXkbmf6xs+T3PhlkQ6oN7eY0f7LsJ8
 K2wNFa+TEdxrz16qfAn1ZqcbwqrZuqMkGHeYHf8EWU9I1NtPw2JtdD3EEz+sin44q2SYtDnK2+P
 UPptQxQ5iSbQzXKmuxI0rqP/XKQTTHzjPgR61R/k+wFd5wOjPHxxQ==
X-Received: by 2002:a05:6a00:1706:b0:842:48ae:1d6c with SMTP id
 d2e1a72fcca58-845a2773ab8mr19201b3a.24.1782235245085; 
 Tue, 23 Jun 2026 10:20:45 -0700 (PDT)
Received: from 3.1.168.192.in-addr.arpa
 ([2401:4900:1c07:46d8:110b:11b8:fb24:5255])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84564ea72d7sm11118820b3a.46.2026.06.23.10.20.43
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 10:20:44 -0700 (PDT)
From: Naveed Khan <naveed@digiscrypt.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/edid: check DisplayID tiled block length before parsing
Date: Tue, 23 Jun 2026 22:50:41 +0530
Message-ID: <178223524141.58041.12138826976759023373@digiscrypt.com>
X-CodeOps-Marker: 8af7ea76b89c4f899c01c1dc7aa87d3d
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
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

drm_parse_tiled_block() casts the generic DisplayID data block to
struct displayid_tiled_block and unconditionally reads the whole
fixed-size structure (tile_cap, topo[3], tile_size[4],
tile_pixel_bezel[5] and the 8-byte topology_id), but it never looks at
block->num_bytes.

The DisplayID iterator in displayid_iter_block() only guarantees that the
block's *declared* length, sizeof(struct displayid_block) + num_bytes,
fits inside the section. A DisplayID extension that declares a tiled
display block (tag DATA_BLOCK_TILED_DISPLAY) with a num_bytes smaller than
the structure payload is therefore happily handed to the parser, which
then reads past the declared block. When such a block is placed near the
end of the last DisplayID EDID extension, the over-read runs past the end
of the EDID allocation - an out-of-bounds read controlled entirely by the
contents of the EDID.

Reject tiled blocks that are too short to hold the structure, mirroring
the size check already done for the VESA vendor block in
drm_parse_vesa_mso_data().

Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
---
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 404208bf23..b4298012eb 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -7575,6 +7575,13 @@ static void drm_parse_tiled_block(struct drm_connector *connector,
 	u8 num_v_tile, num_h_tile;
 	struct drm_tile_group *tg;
 
+	if (block->num_bytes < sizeof(*tile) - sizeof(*block)) {
+		drm_dbg_kms(connector->dev,
+			    "[CONNECTOR:%d:%s] Invalid tiled display block size %u\n",
+			    connector->base.id, connector->name, block->num_bytes);
+		return;
+	}
+
 	w = tile->tile_size[0] | tile->tile_size[1] << 8;
 	h = tile->tile_size[2] | tile->tile_size[3] << 8;
 
-- 
2.52.0
