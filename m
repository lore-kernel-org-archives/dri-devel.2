Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAA7CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 20:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B1610E550;
	Tue, 26 May 2026 20:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VDHMnvUR";
	dkim-atps=neutral
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9229710E1A5
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:53:29 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id
 d9443c01a7336-2b9ea536877so67582495ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 01:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779785609; x=1780390409; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yxIT7vt3ErfESGZT3T7ofhfg9gFiPb1sBgulwy6efJM=;
 b=VDHMnvUR4Pfed338VIi0TVbg2wLbKrveqMJiceF8SjTF4WuAsiVeRika5zeCpTuUJ1
 qHdp5BOFnsS+BaYbbIcaWrCs/BYft0nmLZv7CucA2YiuighNM+X8wwY5Nh8/QL/VvCf9
 TEvhXnARhiUD8hQWCpr5Mk+Zw8pIEyoclB8HnhDP15wjxCR+XJeYS4FJ0k3lxjP/cGfR
 1oaPbOueu8zXMMBmNhW74jGdMtlxNlQjgywBMS3gDDp7V9YGQ4lIVF20dJZdvrVodZQh
 bFViR9WnxOoGSip6UYPvXspLOCP+ImpSDcNrg8iqoNFpSqnj2SeP05XbxVggqwR0KS4U
 LIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779785609; x=1780390409;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yxIT7vt3ErfESGZT3T7ofhfg9gFiPb1sBgulwy6efJM=;
 b=U9mNLdZNiRRsKWkPb8AUeGI8xUwy+Qbu472BeMWWTIBxHQZeLUMFRLsi+oRY8O+Bmw
 eR+tWfaXRWeDqpnUcKn8KkePaQeJerS3HMCAeSNMO4D+6jNWkiCLV7L32+V43/w4h3P+
 bmbrpL08dmBUR9HBDdw7b+JZlysQ1jxNzcsK5QfDPREgUffhBJtrbqyf8pFKe+JjfGMm
 QHiSnkPcuqEMQHGxUp0ES6tB+JboYw28BIeO+Vg8u0mhXUAv6IFllUF0yH4iYMUfFYD7
 HuVp6N8h4s1P5yQ1TMfqKC05lxSN6NVeyOy80u3kjidQj0akniVdyMVlvhYJxrTIc0j0
 Sj6g==
X-Gm-Message-State: AOJu0YyqHXw7mTDl2m4A+A3Q9jNp40u4hepOKhcEBxBIoN5cX1igqEbs
 Rr1B7cPUPnvQgSjHLOgIByy1GaqhlOqjYO0IvoSGvm+0U3qyHgjEg91z
X-Gm-Gg: Acq92OFD9hBAbMmnorgLjFXRxBkBVtbz2r5c5Q8AP32NNV5lhWC8BwegnmKDNHaJz1G
 060nSasPbwiNm3Y0nVvClzAoZhuTAKY4tH01rMngoDdQJfFhgQTc1rR0DeRpCdQ7ycClZMX5iMb
 nk1WX7TFRqknceog9Y5muxrkDgZaAzgjUZhpwn1kD3f3IGjdpfiuyXRYmcoSx2q7cC+YURSbLVv
 9Wz75I+7jIAamzLVNvXenvGhD6n2ivxgre2jAHOJGQ91wkGr6wSBpUO3QEvFf5WkXCAMHihFR/c
 pWC7I+4kyrlI1Jbf8aeBfFNt4IhFZiWPuTXHVvTSa/jHi4MgcdxmRPvwmC76MrZ3piNsIhV/UKi
 rvgU2fIbqo3cBo1BhIX44gLJ5CbBZUdUyraAv15bwlGukT4fk2bh9/wfUmdSyUfqJVJlMVP6xhP
 m+AwcYvHQFnJ7Ne/lip6AF5kX4t7DT0CmeThzvM48WaxRGlZkTYK5td56Onmg0+TM0neI1v85UD
 pNWXJvd4Q==
X-Received: by 2002:a17:902:f605:b0:2ba:7617:a755 with SMTP id
 d9443c01a7336-2bea23e2544mr196620185ad.25.1779785609086; 
 Tue, 26 May 2026 01:53:29 -0700 (PDT)
Received: from KIPREYXIAO-MC2.tencent.com ([43.132.141.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56d68adsm139302765ad.32.2026.05.26.01.53.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 01:53:28 -0700 (PDT)
From: Zhenghang Xiao <kipreyyy@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org,
	Zhenghang Xiao <kipreyyy@gmail.com>
Subject: [PATCH drm] drm/gem: fix race between change_handle and handle_delete
Date: Tue, 26 May 2026 16:53:13 +0800
Message-ID: <20260526085313.26791-1-kipreyyy@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 May 2026 20:30:45 +0000
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

drm_gem_change_handle_ioctl leaves the old handle live in the IDR
during the window between spin_unlock(table_lock) and the final
spin_lock(table_lock). A concurrent drm_gem_handle_delete on the old
handle succeeds in this window, decrements handle_count to 0, and frees
the GEM object while the new handle's IDR entry still references it.

NULL the old handle's IDR entry before dropping table_lock so that any
concurrent GEM_CLOSE on the old handle sees NULL and returns -EINVAL.
Restore the old entry on the prime-bookkeeping error path.

Fixes: 5e28b7b94408 ("drm: Set old handle to NULL before prime swap in change_handle")
Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
---
 drivers/gpu/drm/drm_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 8afab57fc055..189b990cc78e 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1065,6 +1065,7 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 	       goto out_unlock;
        }
 
+	idr_replace(&file_priv->object_idr, NULL, args->handle);
 	spin_unlock(&file_priv->table_lock);
 
 	if (obj->dma_buf) {
@@ -1073,6 +1074,7 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 		if (ret < 0) {
 			spin_lock(&file_priv->table_lock);
 			idr_remove(&file_priv->object_idr, handle);
+			idr_replace(&file_priv->object_idr, obj, args->handle);
 			spin_unlock(&file_priv->table_lock);
 			goto out_unlock;
 		}
-- 
2.50.1 (Apple Git-155)

