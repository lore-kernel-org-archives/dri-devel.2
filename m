Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A32C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7BB710F90F;
	Fri, 25 Sep 2026 07:30:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eJuC4NkO";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C2310E960
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:44:37 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-398c066106cso1032596a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 23:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790232277; x=1790837077; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lbB99fzKqqncd9v0PrpyQHGW/pl7V8ppi+GHfHAQQBo=;
 b=eJuC4NkOEPqY3kYYu1NXFhqU9E+hrefJ97e0cXgbyU8DcGzM2bdJufAuQ9B7MsiS0U
 PDronVwK55YOjMjIrsrkpB2IrppxFFLl5RethLrovdy/YLXNCLDIpPfaWjGgWD9A/qkP
 xAtmDwbE3sdGWEduMCdS8/GeRepDom5RbOwxBnQ0oLfXEHzx1SDpDWcdMkgeu2OSduz7
 qc0hiyJOh2G04qvR4uwUAl9xdqhd1dgwqXX5JUJx68PDwBMCMdPEn7rynMjjH+XaSG2o
 GZQphP9jf1tn/4MmsRopnSyWJQ9RTKtlx5mZbwFZorkxUMl6jdwR9GikrC2hKwsxI7Ba
 FsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790232277; x=1790837077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lbB99fzKqqncd9v0PrpyQHGW/pl7V8ppi+GHfHAQQBo=;
 b=C3dq1mczGD7CQ0DrlnAI8nERfyiDmhXo2vneUZvXQklrClB4uwDxhDePQjIjvN7pTy
 GakBeD130AvPNCQ6MwzB1yvwAXduKQgGv0cmeDDlYvZfgJWjejCrRnVckRlGD+QeBvve
 AoBt+s15Hp2S0VfMMUqoB3mRN6H8+D6JADKhlHOnBrcYfnckubjTlNnDiM4g7hO4v2LQ
 nPikhLOi0zcOdwn4bJrhjmn2Q/JWd9O2euYiSBmsVvwnTzzh7tASdsumiYcqKsQFVU3V
 bBq9Wk4aCC8yLkhhKleGxw+VEXeUnVpAWs+QKI68wSOnieL2QrMy68XvZm04jEK4HfYf
 9Aqw==
X-Gm-Message-State: AFuF++kUENsS8VxDaVwIFDq3/a16V8hoEG+dWxSu2AoGasIubrgl5NVX
 gKU6Ta+UNOR9hFpQLGJhz6AMtTHLn8n56F0ybMGyzJZSjfeNOCMz9q0F
X-Gm-Gg: AYBFou12vwGQDncwFPQs72JgQeFWD1vyiO8DieCvKyQKKQ/kJ2sMLlWJHyBbRwumjQN
 wBE1gzEOMbZMQGmRBzydhvtOKqZXN05CuSyuYQkw8SMfzbwLNoJ9SDdCDYWwgxBnIg0pSfF2iZy
 AfrXHGrtC8xsgeze2jsIzloR0qBIeoYq69qJmYkx2vYu9R0p5V/3pDpoUp7lxW9CwW+ztWebqEh
 fzCijjG23+/syd+MPcw4Eqb3L7+6IgawJa7lbRYwVbrvtTpAOBMCA7L4ktgq0ob3mIOBeyarsKJ
 NbRnvLNstnh9GoPD5YS3aeW+8buBXmEEoG5h+ZF8gQiazbhyQDbsbCE7rwUECSJDEnbsMTmzGbY
 Q7lCiTLiKKn3SpA1qujb9eqXgXlfE1cXRJuZS8Ow8XM2j2U0y02GpDDhyxxOHpXjcdtwq1HC7hs
 UdbHWIwjWCUH+seN1TGHg1UMtDOc8EpWTn45zugxw2dQAFWUm2haw3E3NfTWP24iPLdJEPctHb+
 r6Cr+qVZ5ltat+v2aMje8k1OKykGF8G5xJxpjVkVLGawxZRYWlZ9KjcKLwc2HI/G3PywcFYD8ln
 NdtnrI6Ygw==
X-Received: by 2002:a17:90a:d603:b0:39e:6c68:1550 with SMTP id
 98e67ed59e1d1-3a098969ba9mr1148247a91.24.1790232276784; 
 Wed, 23 Sep 2026 23:44:36 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0972efa0bsm2960830a91.8.2026.09.23.23.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 23:44:36 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: jani.nikula@linux.intel.com, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Hui Peng <benquike@gmail.com>
Subject: [PATCH v2 1/2] drm/udl: reject short USB control transfers in
 udl_read_edid_block()
Date: Thu, 24 Sep 2026 06:44:33 +0000
Message-ID: <20260924064434.2541959-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260924064434.2541959-1-benquike@gmail.com>
References: <20260919223511.3889061-1-benquike@gmail.com>
 <20260924064434.2541959-1-benquike@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

In udl_read_edid_block(), usb_control_msg() requests 2 bytes into
read_buff for each EDID byte, and read_buff[1] is stored into buf[i].
Currently the short-transfer check tests ret < 1 instead of ret != 2, so
if a short USB control transfer returns 1 byte, read_buff[1] is not
written by usb_control_msg() and retains the previous iteration's byte (or
uninitialized kmalloc(2) memory on the first iteration), which is then
copied into buf[i].

Change the check from ret < 1 to ret != 2 so any short USB control
transfer fails with -EIO.

Tested in QEMU against Linux 7.3.0-rc3 using dummy_hcd and raw-gadget
emulating a DisplayLink UDL USB device: on the unfixed kernel, when
usb_control_msg() returned 1 byte for an EDID read (short transfer),
udl_read_edid_block() accepted ret = 1 and stored stale read_buff[1]
data into the EDID buffer; whereas with this fix applied, ret != 2
correctly fails with -EIO and prevents EDID buffer corruption.

Fixes: 5320918b9a87 ("drm/udl: initial UDL driver (v4)")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 1/2 as requested by Jani Nikula.
- Added testing details in QEMU on short USB EDID control transfers.

 drivers/gpu/drm/udl/udl_edid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_edid.c b/drivers/gpu/drm/udl/udl_edid.c
index af4cff2a7c51..b7c462436573 100644
--- a/drivers/gpu/drm/udl/udl_edid.c
+++ b/drivers/gpu/drm/udl/udl_edid.c
@@ -36,7 +36,7 @@ static int udl_read_edid_block(void *data, u8 *buf, unsigned int block, size_t l
 		if (ret < 0) {
 			drm_err(dev, "Read EDID byte %zu failed err %x\n", i, ret);
 			goto err_drm_dev_exit;
-		} else if (ret < 1) {
+		} else if (ret != 2) {
 			ret = -EIO;
 			drm_err(dev, "Read EDID byte %zu failed\n", i);
 			goto err_drm_dev_exit;
-- 
2.55.0.1082.g2b9226bbc0-goog
