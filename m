Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D792C98328
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F1010F8D7;
	Fri, 25 Sep 2026 07:30:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qi9+YSvz";
	dkim-atps=neutral
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85EF110F375
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:30:15 +0000 (UTC)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc4bdf8abaaso1273944a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 00:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790235015; x=1790839815; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6F8IvUZIEGfXb52LcJZy68sW3q/eTCjBvXuldSNAIWg=;
 b=qi9+YSvzcRm51aLs+OfXHS2/AKxFfJ1q/MsENyT+1J+aY0RsS49b1H8pyvvBhSuqa2
 AbFWQ+PFBJr62dvXnJqNGc73uOFQUletdaSDOdsfbiwXouDdml/7DyjsOVdBeg2oshx4
 il+2sg4OVLrtgor30cgoce8TSTP8xYxagyxXfZF4W80Znclzau8ar6s37LLMub3vw35T
 RcFH8IG/eVOc8a5cI5qibiAxQOvIAGoelNl0p5K+3pYqCpwDoBiDcGnEaNuqwdyvExrv
 rW+rSgdYMUu8qkS01VMyv8CF83uLxVKmbxrWINVrV7smlquh4XO6k4436zyBNcL0AThq
 43RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790235015; x=1790839815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6F8IvUZIEGfXb52LcJZy68sW3q/eTCjBvXuldSNAIWg=;
 b=AHPthZZOOdAh2Wrdi/jXK+f/XT4flws2wWOd4YHJINZNFrEESItGpDb/aTwutJsdRE
 r6vgtyVFsXwkWKC5zFO8nnY0uEtrPdsGNJnxTa9Hf3pf+saBnNHeAYTGp2G3njx0GVAm
 yJRuKnZC6Z01AWtDs9Msf6pQjmeTmXGdr4jiQCt6zX22i/MMgzCZtrmuAiSv7t9BlySJ
 e2SIMemVC4Vw3B0+N6+EtTyXC5bFMR+Faj1dLMh2SdINWDc3mxhM6/KJvaZ6wWFm1l9i
 mCQGLXKvcaIJmtB4dKJcJF+m3puMvCSVE2pJsBgKROTyIqoCmsWqaSzwUdfjG9beLtBP
 16EQ==
X-Gm-Message-State: AFuF++kuxhmzm2QMtMf6t5ZGzKuMJm3yNwqDT9cexHmtbn7PDs1y+60e
 u/4jZAvoqCqHlVle5YPRX4e95GqZmIf7xiNsGYaCW0eiupsZZKhN3Wd2
X-Gm-Gg: AYBFou1o9GN3pD8+3lb3ENSWc9IUfd++jFfu1O81dI6aUTwWxO4ZCZvxKp0dK013nLi
 utaGjZ7aQRb/zPodL/c91IT6O740PGhOdd9fWUeo7/yzAD/1nJ0xdH4+qNTcAvXEyIdoGPg76cC
 ZlIkpg/kwG8Zg1+/2vv/tCTI6sc7E1w9txn+20TI5TPuuIkIra+jUediia7qC0D1bBcd01GQEZN
 032RvrPXmtUJtAM6UB1uvxD1lmS3+51dqWD4fNBlj5OLXQLLZcw0RCB/MBHO+cphBDmnYL/+Qa0
 ksxYE7eZXzlLaXoNuvoJHzy03DfkA8TeEM517o6mjx47zrwPL31uuQ8iApPisXQH7sgHCR6kD4o
 U1OTWaNhUeb4c8ki47OIpZ9u8jiZ0aa/zcXMsEW8lniXfsWc11dOYHUasoNELKMgrlDF012IuJk
 Lmj4g92CEv22PGp2sOFmQoQLUe9pA9VFXNXIUpokWWhJfRcWXiKnbm66lP9PDvjQGWTJp7Vejyz
 kQtBe6behqYWyphDEDpQPKRUYYQG0TqVCcEblq4JaVqM+JsWNPz+nCtyuDMSnFST1sct6q/go8A
 zztnr5+ZNw==
X-Received: by 2002:a17:90a:ec88:b0:398:bacb:1137 with SMTP id
 98e67ed59e1d1-3a098b4b35cmr1393507a91.19.1790235014790; 
 Thu, 24 Sep 2026 00:30:14 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0972efa0bsm3184726a91.8.2026.09.24.00.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 00:30:14 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: jani.nikula@linux.intel.com, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Hui Peng <benquike@gmail.com>
Subject: [PATCH v3 2/2] drm/udl: clean up USB resources if drm_dev_register()
 fails
Date: Thu, 24 Sep 2026 07:30:11 +0000
Message-ID: <20260924073012.2742968-3-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260924064434.2541959-3-benquike@gmail.com>
References: <20260924064434.2541959-1-benquike@gmail.com>
 <20260924064434.2541959-3-benquike@gmail.com>
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

In udl_usb_probe(), udl_driver_create() calls udl_init(udl), which
allocates USB URBs and DMA buffers via udl_alloc_urb_list() that are
normally freed by udl_drop_usb() in udl_usb_disconnect(). If
drm_dev_register() fails in udl_usb_probe(), udl_usb_probe() returns
without calling udl_drop_usb(udl), leaking the allocated URB list and DMA
buffers because udl_usb_disconnect() is not called when probe fails.

Call udl_drop_usb(udl) when drm_dev_register() fails in udl_usb_probe().

Tested in QEMU against Linux 7.3.0-rc3 using dummy_hcd by simulating
a registration error in drm_dev_register(): on the unfixed kernel,
udl_usb_probe() returned an error without calling udl_drop_usb(udl),
leaking 8 allocated URBs and DMA buffers; whereas with this fix applied,
udl_drop_usb(udl) is called on error, freeing all URB and DMA
allocations.

Fixes: 5320918b9a87 ("drm/udl: initial UDL driver (v4)")
Cc: stable@vger.kernel.org
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- Add Reviewed-by tag from Thomas Zimmermann.

Changes in v2:
- Split out as patch 2/2 as requested by Jani Nikula.
- Added testing details in QEMU on drm_dev_register() failure cleanup.

 drivers/gpu/drm/udl/udl_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
index 1922988625eb..239a6983f49f 100644
--- a/drivers/gpu/drm/udl/udl_drv.c
+++ b/drivers/gpu/drm/udl/udl_drv.c
@@ -97,8 +97,10 @@ static int udl_usb_probe(struct usb_interface *interface,
 		return PTR_ERR(udl);
 
 	r = drm_dev_register(&udl->drm, 0);
-	if (r)
+	if (r) {
+		udl_drop_usb(udl);
 		return r;
+	}
 
 	DRM_INFO("Initialized udl on minor %d\n", udl->drm.primary->index);
