Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20F9606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=QY9J35Rs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB8BA10F81C;
	Tue, 27 Oct 2026 21:17:52 +0000 (UTC)
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com
 [209.85.214.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8036810E4B0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 21:17:45 +0000 (UTC)
Received: by mail-pl1-f227.google.com with SMTP id
 d9443c01a7336-2e608cd460eso1385975ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:17:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793135865; x=1793740665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VhwStqBc0JsG88BacH2y24XzBET34vQRSMUTxkJ0j4g=;
 b=pPqpvdq66ClKp2duB1l6pgr4YRFm5ofbbMmhgci74gaVmGleh949gc3vvMJImQBcW4
 e+iQde3Cw8mlK7ZLHgshVyANQK3VchGk3jt0lIWX3L07Rbukk5nV/TYn5bXY00FTfjJQ
 4fV7WmZw1VduzvGcnhNBOr/2PyMkjSnpuXi/xgarTedSnFfV+8ikvUAOwAaYQXeccnQe
 EOdWaXouaJjWkv7Ob+KMHgg8ET2pbsvA+bsiNYbEsCBOlabIqhduZU3Zszmg4W4uwHmx
 rDK1mD1TUpNJJhGFnBuPA2URtRCy9JWraTbOwYIrKzW/+G7+12E2l26og3oYw1F2jr3M
 yXHA==
X-Gm-Message-State: AFq9FYJHHBI/KyPR0FZYmJVng+B8OEiGDeD6M3prWorWoPHUj71T0z8c
 4jUWuMvqRCFdwsKgFN3ryuX/Tlu+Pp4zfRUJYVJD8oZOAIfzq0iOEd8MtJaQ85CyJf4nSp5YILX
 KTXmJ+HjGyVS5S9dr3yl5UDX1E8KMWJmENINw1nlsHc9V8DUBWsrIq3SC6Zeyp7YhGw+LbSa41/
 +YNKXxLPo0sbS/HgBbtJrOxcDstSoIwTIe5eTTHTD1FAVaA+7E935frDXH0tqRivG6tSDo7Ut0q
 qXjsCwavP/jkuizPxfl
X-Gm-Gg: AYBFou17ZMvpg7402u73j7EE08jvFQ25AV5uUoQDIuq18dlOq84bee7J1EDvxp09AH4
 cd+Z3HTmC/VlK1n97ZLvZFtwqlIX+gBbdgg/n1zxaVWsIGs7ihPkiN0MNQ/z9XjnIxx8npSazRh
 MARD6bJLRUhLhmtjI7FbnGCNFqv5fmeymLU91eArlI5pPl6n7JBX9TVnh41icktUnEs5Ku+TR7Q
 o/WldYM5d6Nb2Kz1A1ZIVmtKMzplheOUHFDR5GKn/XafhQPcm2H5C1PBwab46A6BaYfMq/kl4gA
 SGDDrYqYrqRC4H9d71hMjrkoZxAnHGIi0zTtUHkdBvIytpgziaGRKdCYw43U3jT4ARwn8A1KZgY
 CJCevJAO5AH9lbRACay01eerLIHXUMYL3OPW1V2GvzJk3QMjBEZtxAMaE4T6NtYbwOGW4hG6tb6
 7Eey8dfXcl8W/KyTHMbHQuwtOiuvF64cBx
X-Received: by 2002:a17:903:37c7:b0:2e6:5ef:abe9 with SMTP id
 d9443c01a7336-2eb0044af73mr3968655ad.37.1793135864931; 
 Tue, 27 Oct 2026 14:17:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2eae6babc12sm697125ad.31.2026.10.27.14.17.44
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2026 14:17:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-351788121cfso1138630eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793135863; x=1793740663;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VhwStqBc0JsG88BacH2y24XzBET34vQRSMUTxkJ0j4g=;
 b=QY9J35RseLeAhgBwnuNrzyrJ/gMbIz13dxPIsEaqLT+lAsBpaVWbeOKhkQyycsHuIv
 wgJz+7YXyYqNlxPCDdT3ci5KwmDWli1LXfKGELt93lltxCIaNF0tBcBwOlbZCf2qenOC
 5svjUag5OnAG2Lq7BrJcS8IgXQs+d7JRUTMaU=
X-Received: by 2002:a05:7301:78c8:b0:366:dbf9:32bd with SMTP id
 5a478bee46e88-36a20406fcemr723451eec.9.1793135862683; 
 Tue, 27 Oct 2026 14:17:42 -0700 (PDT)
X-Received: by 2002:a05:7301:78c8:b0:366:dbf9:32bd with SMTP id
 5a478bee46e88-36a20406fcemr723426eec.9.1793135861976; 
 Tue, 27 Oct 2026 14:17:41 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8c576ebsm35760859eec.3.2026.10.27.14.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 14:17:41 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 maaz.mombasawala@broadcom.com, yunfeng.li.nb@gmail.com, tomas@slax.org,
 Zack Rusin <zack.rusin@broadcom.com>, stable@vger.kernel.org
Subject: [PATCH 2/6] drm/vmwgfx: validate GB-only cursor command limits
Date: Tue, 27 Oct 2026 17:17:25 -0400
Message-ID: <20261027211729.646988-3-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027211729.646988-1-zack.rusin@broadcom.com>
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
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

Guest-backed devices without cursor MOB support define cursor images with
SVGA_CMD_DEFINE_ALPHA_CURSOR. SVGA_REG_CURSOR_MAX_DIMENSION belongs to the
cursor MOB register class and reads as zero on devices that do not expose
that class. Applying this register to GB-only cursors rejects every
nonempty image submitted by KMS clients, leaving Xorg without a hardware
cursor.

The submission transport also limits the command size. A 96x96 image fits
the 40 KiB FIFO image limit, but exceeds the 32 KiB command-buffer limit
and causes a device command error when submitted through that transport.

Validate GB-only images against SVGA_MAX_CURSOR_CMD_DIMENSION and
SVGA_MAX_CURSOR_CMD_BYTES. For command-buffer submission, also bound the
whole command by SVGA_CB_MAX_COMMAND_SIZE, including its header. Calculate
the image byte count in 64 bits and keep the register-based dimension and
MOB size checks for MOB cursors.

Fixes: d5ed8749168a ("drm/vmwgfx: enforce cursor size limits for MOB cursors")
Cc: stable@vger.kernel.org
Reported-by: Yunfeng Li <yunfeng.li.nb@gmail.com>
Closes: https://patch.msgid.link/20260830151619.2452307-1-yunfeng.li.nb@gmail.com
Assisted-by: LLM
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 23 ++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index 942d07079ef7..14490ead99cd 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -778,8 +778,27 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
 				 "surface not suitable for cursor\n");
 			return -EINVAL;
 		}
-	} else if (update_type == VMW_CURSOR_UPDATE_GB_ONLY ||
-		   update_type == VMW_CURSOR_UPDATE_MOB) {
+	} else if (update_type == VMW_CURSOR_UPDATE_GB_ONLY) {
+		u64 image_size = (u64)new_state->crtc_w *
+				 new_state->crtc_h * sizeof(u32);
+		u32 max_size = SVGA_MAX_CURSOR_CMD_BYTES;
+
+		/* The command-buffer limit includes the define-cursor header. */
+		if (vmw->cman)
+			max_size = min_t(u32, max_size,
+					 SVGA_CB_MAX_COMMAND_SIZE -
+					 sizeof(struct vmw_svga_fifo_cmd_define_cursor));
+
+		if (!new_state->crtc_w || !new_state->crtc_h ||
+		    new_state->crtc_w > SVGA_MAX_CURSOR_CMD_DIMENSION ||
+		    new_state->crtc_h > SVGA_MAX_CURSOR_CMD_DIMENSION ||
+		    image_size > max_size) {
+			drm_dbg_kms(&vmw->drm,
+				    "Cursor dimensions (%u, %u) violate command limits\n",
+				    new_state->crtc_w, new_state->crtc_h);
+			return -EINVAL;
+		}
+	} else if (update_type == VMW_CURSOR_UPDATE_MOB) {
 		u32 cursor_max_dim =
 			vmw_read(vmw, SVGA_REG_CURSOR_MAX_DIMENSION);
 
-- 
2.53.0

