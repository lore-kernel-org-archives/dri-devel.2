Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2424CD5BC0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 011ED10E404;
	Mon, 25 May 2026 06:21:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l/LptzVf";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF7710E2E4
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 07:32:52 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2b9ec9443c2so47466575ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 00:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779521572; x=1780126372; darn=lists.freedesktop.org;
 h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+KRTw9/sBNPjfGJSKTyHrcZ/0neRgH4YHpK/FuxGf0=;
 b=l/LptzVfFxN1IWDFEl+AbkoXfrhb2VSg0nyUMdoWKlRpV9ejRiIN5PhQD+WLBSMOy+
 F9R/9b0XSGe25nnTV93spA1SbvUIof2UXeky9RYbhsXe3Z94zN+agYEdEVAzIthlVIEN
 Gh6vUeORx0Xnl6DAU6Y6ND28qVgaChLq9TpBJk2IaijpqUjM6QMANSig2yfDZdD6CZN2
 5dfuiVh61MdZEtSgkdKTx3IWeoO0poZwVZSZGm5MY99h7kxBdJjQyJvFPg7JdxKBoCQn
 Abq+8wOJYY0EuEiyycQ2YH0alz6wgCoH7J9Tw/xIYEqOuNO2kpdrY+gFnNOI7gAZBcWB
 72VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779521572; x=1780126372;
 h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H+KRTw9/sBNPjfGJSKTyHrcZ/0neRgH4YHpK/FuxGf0=;
 b=SDeSH0+/uVOo8R/NwZsQ5LS7jSDzr8UrOxnp3gtB4iibBK4ZUmAkYrOoVyWDfZxlx3
 XMW8aisJV5DXDIMhHFa0TuzDO01PjmW3b6MB5gYAWS8zunjMtPLe4IuFaMf6cYlN7adR
 HGqO201T4dwf1ioEr4rsQ9ro3pxNzSy1/oJ0wJvhGPuD4MbDEM3prsBhIKGbOhYjpSe9
 2hGiZ0xScRj75ZmAE04XEhZVQ3C3ktxuQc8Rtj326TPCfZkFaqEl9vk0yx6uD1S8dQp1
 0TPKAPDSZYQ1oE0fsCqRX2pzzCygNzY8WrPUuSWfjFVLgmQv/Qrcl+6fsYXL3pQHEQvI
 cJEg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WfwIloe89gKlvz5p6WZMk7ylAPnoMFWDyG2Rli7OzabRwp7sxykhC9O0BoUWmJnc7O0L8eywYnVE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1C/lzTvYwGJgzdgcHHpxVljTdjvVycbX/Fj2btzFuWYaMFTiA
 y/M3sVg4j7o6w+KJY1VekeNHx1wXF5mLdF2omhaTsS+WRtgDomVT7A6s
X-Gm-Gg: Acq92OECdhSp6Ge1cPEov6w/mpDm0O4b1mzhUkh/171G3rUkSt000OVcIiLCq1WlGpR
 Gx+tZNZw1MVseo5WNmshjg/A5q4+WB4HZoWlrMXc4eVuvVQ5UpmaNgewkNvgVkhB8uvN4YTZD/p
 IDw8fDSfDtGxyNtII3KzDq69/tZBcwd/CBkA2ZZF4dgnSsh3h5Oi63+LQxLg1hMdp9yRUKg0W8j
 9o9IMzGOrVhAK8Xl/Sf5NEqUugJK02FezkqSxPoVXqRKzGaujT0jtVhLKZzpbc4CMnJU8rUvOgu
 HVSsY1oXH7Lku+OVF7gRl6S52wWZGXgxA+aSiymYydqlDUI7kxeAUZDhYKe/wtd1gmxtCjXC4fV
 KrU3OUUffZ7KUCglh1wLSUe5ArtD28uQR0laib+WYo78mdIni9sRJ8U0HvYt+rQZTHaYKj3jrbG
 Lbfqpvtf9utvjauEwgilufMmt9fmf1AyJI7RchorWOK/6DBHchz/+gMvUXTjF91UNioXCy/SGCM
 jlKuMFcDY+FhOOOO7V7zbc=
X-Received: by 2002:a17:903:fa7:b0:2bc:ac76:c1d0 with SMTP id
 d9443c01a7336-2beb088e3ecmr52736095ad.17.1779521572418; 
 Sat, 23 May 2026 00:32:52 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([103.129.134.214])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b387dsm38101085ad.50.2026.05.23.00.32.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 23 May 2026 00:32:52 -0700 (PDT)
Message-ID: <6a115824.a0bed9bd.3c0137.9edf@mx.google.com>
From: Shuvam Pandey <shuvampandey1@gmail.com>
Date: Sat, 23 May 2026 13:17:33 +0545
Subject: [PATCH] accel/qaic: Protect perf stats BO state with bo->lock
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
X-Mailman-Approved-At: Mon, 25 May 2026 06:21:20 +0000
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

qaic_perf_stats_bo_ioctl() validates each BO by checking bo->sliced and
bo->dbc before returning its perf stats. These fields are changed by the
detach paths while holding bo->lock, but the perf stats ioctl reads them
without that lock.

A concurrent detach can clear bo->dbc and mark the BO unsliced while the
perf stats ioctl is validating the BO. Take bo->lock while checking the
BO state and copying the per-BO stats into the temporary result buffer.

Fixes: 4ddf4ddfceb4 ("accel/qaic: Ensure entry belongs to DBC in qaic_perf_stats_bo_ioctl()")
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 drivers/accel/qaic/qaic_data.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index 1e4c579d2..1d74c2ec3 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -1834,15 +1834,16 @@ int qaic_perf_stats_bo_ioctl(struct drm_device *dev, void *data, struct drm_file
 			goto free_ent;
 		}
 		bo = to_qaic_bo(obj);
+		ret = mutex_lock_interruptible(&bo->lock);
+		if (ret)
+			goto put_obj;
 		if (!bo->sliced) {
-			drm_gem_object_put(obj);
 			ret = -EINVAL;
-			goto free_ent;
+			goto unlock_bo;
 		}
 		if (bo->dbc->id != args->hdr.dbc_id) {
-			drm_gem_object_put(obj);
 			ret = -EINVAL;
-			goto free_ent;
+			goto unlock_bo;
 		}
 		/*
 		 * perf stats ioctl is called before wait ioctl is complete then
@@ -1858,7 +1859,12 @@ int qaic_perf_stats_bo_ioctl(struct drm_device *dev, void *data, struct drm_file
 						    bo->perf_stats.req_received_ts), 1000);
 		ent[i].queue_level_before = bo->perf_stats.queue_level_before;
 		ent[i].num_queue_element = bo->total_slice_nents;
+unlock_bo:
+		mutex_unlock(&bo->lock);
+put_obj:
 		drm_gem_object_put(obj);
+		if (ret)
+			goto free_ent;
 	}
 
 	if (copy_to_user(u64_to_user_ptr(args->data), ent, args->hdr.count * sizeof(*ent)))
-- 
2.50.1 (Apple Git-155)

