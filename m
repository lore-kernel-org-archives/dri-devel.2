Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4FAC98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D47910F931;
	Fri, 25 Sep 2026 07:30:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VU/KBHeX";
	dkim-atps=neutral
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D5B210F36F
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:30:15 +0000 (UTC)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so1224450a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 00:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790235014; x=1790839814; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I5RaZ9J/BPAqTVFwFZkJAJ6b/KARjI40wHk0bzH3x3U=;
 b=VU/KBHeXmbjOV8qmsdWp2pzYO35rtNWOMYnzTBbatm82KfiRu1Z6W+ZzCMSRf8lBvR
 DaXSO5SnTbvXdNk+/CkYsgabkLQJbE8Qgx8d3E5RPN5WAIKZm/jYPqi3qlAGS1Btgz1e
 ezDWicAIvth995OuTjtaxM4s7WzYypIlYbglYsYYuP9+grIqOUW4mhDeowLLzL21WM5d
 UxyoGukWDd+AF4Rj+2loxUVqBzbP26fwhLuh1BksFutPXsEmCIKe4/2vUN6+8Z65SaWD
 NveOED6VgSPc/rzt2pouJ4Su0IYfa0RKtDGaoiH7/eav0/L4tp9aBCYVL/VuvpOLUZ5U
 jdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790235014; x=1790839814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I5RaZ9J/BPAqTVFwFZkJAJ6b/KARjI40wHk0bzH3x3U=;
 b=wc+U8uW0YntNs1mOCQ/wiMqnPq+iP8DSg7sO1i4qwn9NDkp36BjkhtI37e37NlgP64
 pDKVPqHeeLODB32JYSSKs518AfxNrPzAUMnY303hw+44dEBESZFKGngMU9OFMPXYbgLb
 9o5bq5o73EVa7P+3qgqIwIhl8gUMUtLo9bdbMnLweONlzcHSXRGStXmkwtVk63phVyQo
 G7NCyhOukT1uLdLozjJBWPZhffRZgQmZiupRyC+cXko5huOjTBETMYcMTUbXjUKpMG8x
 +sf6vSvKFGmTjBtWLJ9YzaKG1qU9GQ4WCWHRK9dTRf11H+1I65MBy0WwepveM0OvM58e
 Rcfw==
X-Gm-Message-State: AFuF++kub9ffj8MxHYCbGlcgDPWO16Jlv75IMHb3jw5wAjoOV44k6Kvj
 CQfgqnPX79nrcQEW0qj+Dqomg7jN3ggzu57iKGe+dSmMxf7DCg4Lp8cr
X-Gm-Gg: AYBFou0d2Mvb/ys5az/nEhVKB0W2zMvWxs+Cyw4cH+ynLDwdXBiO1YFPdqXQ9hpUKtV
 AGFaMnkn6aOOuerSXQfAWTDMPm7TXm79TCTBfRaNWqHd1ZuNiCqJYPg5XS6Xzo1OHu+rXT+CXHe
 I2COvMSGVZ2YGQK6JvlARJjBMfvEPOnKBxr8PVFM7mpNqbbDCB+vjxdP0GFv54BnO2mr1n+qQ5s
 c8aHpEYKPoWgJyKSv5kmYmVsk0BQ7OUDP3CCOvTvwWTCNSBbVPIzzprCTEpbd7sqBVwhTPhTKB5
 IkGB+Coy2Oiu3k4z7E4CMyXr47ukgC/qeTlv7OQJ8AqXiStWi2k8p/u6Rdv65Dd0psjaxJAU8eO
 kGQ0L/WdgV0fIkxvDMuuqMnShlP197nQ5BeIdc66VFkbvQL+4ivkYTmDcpb1R3QYYaNRJ3lpnFh
 XzHOVTi4zk4cXf0A+P7u384kTab+CTeCcvIcA4E1c+Qacf6CTgF7bY2zsa1bGLpbDDwjR261e1b
 D+X0RUBDzO9c3x1uTCzK7zSJeZhXB0CWveZssefXSye1EajG5nMSMEwlZpLS9d8wnKButvqdSTk
 3SucVtewjA==
X-Received: by 2002:a17:90b:28d0:b0:39e:6a81:c920 with SMTP id
 98e67ed59e1d1-3a098724784mr1301143a91.19.1790235014279; 
 Thu, 24 Sep 2026 00:30:14 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0972efa0bsm3184726a91.8.2026.09.24.00.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 00:30:14 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: jani.nikula@linux.intel.com, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Hui Peng <benquike@gmail.com>
Subject: [PATCH v3 1/2] drm/udl: reject short USB control transfers in
 udl_read_edid_block()
Date: Thu, 24 Sep 2026 07:30:10 +0000
Message-ID: <20260924073012.2742968-2-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260924064434.2541959-2-benquike@gmail.com>
References: <20260924064434.2541959-1-benquike@gmail.com>
 <20260924064434.2541959-2-benquike@gmail.com>
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
Currently the short-transfer check tests ret < 1 instead of ret < 2, so
if a short USB control transfer returns 1 byte, read_buff[1] is not
written by usb_control_msg() and retains the previous iteration's byte (or
uninitialized kmalloc(2) memory on the first iteration), which is then
copied into buf[i].

Change the check from ret < 1 to ret < 2 so any short USB control
transfer fails with -EIO.

Tested in QEMU against Linux 7.3.0-rc3 using dummy_hcd and raw-gadget
emulating a DisplayLink UDL USB device: on the unfixed kernel, when
usb_control_msg() returned 1 byte for an EDID read (short transfer),
udl_read_edid_block() accepted ret = 1 and stored stale read_buff[1]
data into the EDID buffer; whereas with this fix applied, ret < 2
correctly fails with -EIO and prevents EDID buffer corruption.

Fixes: 5320918b9a87 ("drm/udl: initial UDL driver (v4)")
Cc: stable@vger.kernel.org
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- Change (ret != 2) to (ret < 2) in udl_read_edid_block(), as requested
  by Thomas Zimmermann.

Changes in v2:
- Split out as patch 1/2 as requested by Jani Nikula.
- Added testing details in QEMU on short USB EDID control transfers.

 drivers/gpu/drm/udl/udl_edid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_edid.c b/drivers/gpu/drm/udl/udl_edid.c
index af4cff2a7c51..2120e363b6eb 100644
--- a/drivers/gpu/drm/udl/udl_edid.c
+++ b/drivers/gpu/drm/udl/udl_edid.c
@@ -36,7 +36,7 @@ static int udl_read_edid_block(void *data, u8 *buf, unsigned int block, size_t l
 		if (ret < 0) {
 			drm_err(dev, "Read EDID byte %zu failed err %x\n", i, ret);
 			goto err_drm_dev_exit;
-		} else if (ret < 1) {
+		} else if (ret < 2) {
 			ret = -EIO;
 			drm_err(dev, "Read EDID byte %zu failed\n", i);
 			goto err_drm_dev_exit;
-- 
2.55.0.1082.g2b9226bbc0-goog
