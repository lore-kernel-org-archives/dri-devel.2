Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683CD606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hBbFa525
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B672B10E09F;
	Tue, 27 Oct 2026 03:16:05 +0000 (UTC)
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com
 [209.85.215.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A72310E09F
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 03:16:00 +0000 (UTC)
Received: by mail-pg1-f228.google.com with SMTP id
 41be03b00d2f7-cc4be0e5351so1209080a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 20:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793070960; x=1793675760;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vcMzYXM5+gaf2CTPQI0XuREV4OxjZWsWUv3S0ZwqH8I=;
 b=lTOHYiJ6fHWO22cxOSK6kehiIbtA75pALagPouGE4X8jOUzONlWO53hPQUe90VVk5x
 P1vlA2CnQoMPI3KgU8myvs6GPc7V78VlHalaoxGZJrJeC90BkPVejJGAKlBLdG6pmsKU
 ieSz/N56PLMf2txnKvBY2xJSOsATHLLBkcqR7zfYEhKRHfHgOzwYaFFdjXX3g5lVm6c9
 8SUqeuDUdJj+BqJUqIpnoVwDCUqq26BcdCNzWpgMqq3kE0QWc5s+DggUG2Dg2FNK/x5u
 r25fKtM1EvHZgHauwJ25r19OH/w/zc4j6YB25uuHsP1aMM8OgZOKx1+TtzSRO2KXf0LA
 vdhw==
X-Gm-Message-State: AFq9FYJDnKPHQT+LjxGlc4I6NWICK6l5rb5D5vWFhPKZYgil1NK7QX5P
 +BhuX85zsNGKAKhOoeVNkb4mL2Yb8SD+BAhDP2tlkMfaE2OdWSZ+z8gt7MXwLyPMuMR74qvthy/
 jeQwEeNNb0r/0jnv0TQjXw9/N+ij3LTpuvqS7OvG43SUi9SAKAol7lXEVsnQGnOrNW0hdm/iE26
 U/dNIiHCiIQ+04AU79bgWUDFnS/e18EtZoDj+yA30i7qxX3afXqhXSGiCFHd52NOhSI/1XOOGGO
 +oJHkamf3Kmp2L+izba
X-Gm-Gg: AYBFou2FqqiTsBVR7dGE8X8ShlzzCGJzR6oiPwQoXwLr80Xfw6zGmlYIKlUC6pSi+tm
 e/o4c6dN83FOwheReekpK2X7KL3a6qk4GBK54q74Rd2U9mIuHmwGFWLQwtVHjYmU9FBcDzPs2+0
 wVswIiwWgO0OEJW1CDKg16787OZRTMKyFmamqrN44j3PedDCLS58QMXJeCpnOZlOz8lUeRkxj7s
 agMZG80hyLtbYyF2C+T0VGy4jzOXIvorJ5XneEYGCloAnW8hzrl86lSZf0WvekNp0YXYWJH7QTa
 GOEUetv+Y8VlMElYL9ttRuvBJI6NE9wy4gkt6gbij/UiFQ3I23ZY25+bpQ3F05bwLNQIeOoiJIL
 C854DGrkjMp4TW5tmsxn3TCFrgNNuPEXhx95DrFxXTZZIvRHKuH7wj2JL0Wx+4cSgQumwMWUbp2
 S+mnslAPAPtieIMkwJ3Ghi8v87AjrnN9+h
X-Received: by 2002:a17:90b:1652:b0:3ad:68f7:dbcd with SMTP id
 98e67ed59e1d1-3adeae80c3fmr6987766a91.55.1793070959823; 
 Mon, 26 Oct 2026 20:15:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ae407e4ce3sm1139215a91.6.2026.10.26.20.15.59
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Oct 2026 20:15:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9197553d398so90401226d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 20:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793070958; x=1793675758;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vcMzYXM5+gaf2CTPQI0XuREV4OxjZWsWUv3S0ZwqH8I=;
 b=hBbFa525jVqKAUQQ7C12WUZpFzaTtoW9kn3hHIKQx4Ct603ydz6jNPxwQfeGm/DwWI
 RioiBgUZLHVbaTiog5jOvsdPtADeAhsHIqCIHt7vVqoDdY0UWfDZNMCbLrr7ScR/93QR
 pjF/haj2fLS883Xn141S9dacme+kyTe3Kt5Vw=
X-Received: by 2002:a05:6214:4888:b0:91c:6c93:4482 with SMTP id
 6a1803df08f44-91c6c934827mr36407706d6.23.1793070958462; 
 Mon, 26 Oct 2026 20:15:58 -0700 (PDT)
X-Received: by 2002:a05:6214:4888:b0:91c:6c93:4482 with SMTP id
 6a1803df08f44-91c6c934827mr36407406d6.23.1793070957857; 
 Mon, 26 Oct 2026 20:15:57 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47a69853sm90478946d6.6.2026.10.26.20.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 20:15:57 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 maaz.mombasawala@broadcom.com, Zack Rusin <zack.rusin@broadcom.com>,
 stable@vger.kernel.org,
 Zero Day Initiative <zdi-disclosures@trendmicro.com>
Subject: [PATCH v2] drm/vmwgfx: validate backup buffer size in command buffer
 processing
Date: Mon, 26 Oct 2026 23:15:33 -0400
Message-ID: <20261027031533.2241918-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vmw_cmd_res_switch_backup lets userspace bind an arbitrary MOB to a
resource without checking that the MOB is large enough for the resource's
guest_memory_size. The dirty-tracking bitmap is allocated based on the
MOB size, but later accessed using the (larger) surface size, causing an
out-of-bounds write in the bitmap that corrupts adjacent slab memory.

Add a check that backup_offset + res->guest_memory_size does not exceed
the buffer size before allowing the backup switch.

DX shaders and stream outputs never set guest_memory_size, and both were
allocated with kmalloc(), so the check would read uninitialized memory for
SVGA_3D_CMD_DX_BIND_SHADER and SVGA_3D_CMD_DX_BIND_STREAMOUTPUT and could
reject valid binds. Allocate both with kzalloc() so their
guest_memory_size is 0 and the check only bounds the offset.

Fixes: a97e21923b42 ("drm/vmwgfx: Hook up guest-backed surfaces")
Cc: stable@vger.kernel.org
Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-34068
Closes: https://lore.kernel.org/all/BYAPR01MB38301CFC012E873340F77E3D80662@BYAPR01MB3830.prod.exchangelabs.com/
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c      | 8 ++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c       | 2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index a9136a6523cb..0156aee84c9f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1718,6 +1718,7 @@ static int vmw_cmd_res_switch_backup(struct vmw_private *dev_priv,
 {
 	struct vmw_bo *vbo;
 	void *info;
+	u64 end;
 	int ret;
 
 	info = vmw_execbuf_info_from_res(sw_context, res);
@@ -1728,6 +1729,13 @@ static int vmw_cmd_res_switch_backup(struct vmw_private *dev_priv,
 	if (ret)
 		return ret;
 
+	if (check_add_overflow((u64)backup_offset,
+			       (u64)res->guest_memory_size, &end) ||
+	    end > vbo->tbo.base.size) {
+		VMW_DEBUG_USER("Backup buffer too small for resource.\n");
+		return -EINVAL;
+	}
+
 	vmw_validation_res_switch_backup(sw_context->ctx, info, vbo,
 					 backup_offset);
 	return 0;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
index 39811cf19db1..033157efb1fc 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
@@ -597,7 +597,7 @@ int vmw_dx_shader_add(struct vmw_cmdbuf_res_manager *man,
 	if (!vmw_shader_id_ok(user_key, shader_type))
 		return -EINVAL;
 
-	shader = kmalloc_obj(*shader);
+	shader = kzalloc_obj(*shader);
 	if (!shader) {
 		return -ENOMEM;
 	}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c b/drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c
index 52c6cfa163da..34d5b71fa42f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c
@@ -284,7 +284,7 @@ int vmw_dx_streamoutput_add(struct vmw_cmdbuf_res_manager *man,
 	struct vmw_private *dev_priv = ctx->dev_priv;
 	int ret;
 
-	so = kmalloc_obj(*so);
+	so = kzalloc_obj(*so);
 	if (!so) {
 		return -ENOMEM;
 	}

base-commit: 8ef66514d7b993c9fb96a5886f001e3556610c1c
-- 
2.53.0

