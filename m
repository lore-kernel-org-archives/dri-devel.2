Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539FB606A883
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dDG+8iPL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6369410E149;
	Sun, 15 Nov 2026 06:45:14 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E31AC10E149
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 06:45:07 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-55d30c054dfso4165611cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 22:45:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794725106; cv=none;
 d=google.com; s=arc-20260327;
 b=HLBBn/7lvvm2JAU3H/WDaEhUBoDM4K3yv4QJ+diPV1zlhLVVAhGNLm2nc3iszvcBf3
 j6GrEmqxQ46b8JqLSy3lIvT9qCa6sawIZZ5JRYAzdeE/yLE1VGsu74FmlBdi5sqAJgpe
 omIGO2ZzPwgltnuHJSDpak7QYOiyEGHkt1v4vi7oslfbuC8HApIcvXyheeXtmYMkRKgY
 2PVHqgMQa4RMtjFXKF2C2uxsRYcyHimUwzh7W8at/Fe6BBS8VDB0r9pcdgFWSfBuR9Bd
 0TDSi52TWpGnB/tn3G1Jlvcwcir//3LEQY6W+JYpJWe0gG+JvXEdu1mEjCTXW9XikbcY
 +pHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=BonwvJOwzyfOZwsDa4VZnjPDHnDoIEr1GLr5/tnXVZY=;
 fh=j7xExkkPX21qiotLhKvqViJacg0/xAgfqxJTG/CUz+E=;
 b=cAapTUpZcnQnREN6G9lpQSw2wlb26CdvGgErwD+tEzgbNynPS30eH+qcpis18lfX4p
 DpzFvvlXUqvz/9rwKFpFk+a1aj614O74s9UV6Jbmj2l1wR9UKwyGF4KfubqLQ5vGT/NQ
 WgmvQwL2sDEfe2HghUXaeFsoMZK294TPE1w8YNsIDSZ20u/fS/cvmbFs32jR7YDMTr5P
 gxWKP8BpXgKvKACCa+ku+pUxN8zHwMgBoKkIaUG9Ka11aRsFSCJsf4zGGODdSct+SwM+
 EWjcIqZKR84X5M1bbsxyNFvXJFXgh2bC6WuoZc0fAcoD12xhIxPmbvIreKN2Y6Zmykfj
 76mw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794725106; x=1795329906; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BonwvJOwzyfOZwsDa4VZnjPDHnDoIEr1GLr5/tnXVZY=;
 b=dDG+8iPLUW87hC+27dBUkMVkczmsh+J96mxOAO91KGBZqozihsl2wu1BZHl5Vvft1Q
 T1jPkT9nFiN3h0mpEzSNf2Z/4mu6txB4I49W8pnNJcDg010/RrqDs5jGbR7crzhE8qtT
 B69HFNTEF/LO4Y+mZlW+memTdysm8rL5o8Gw9uZVQKaPj6dl6hj4U3svrgtdljQdfBcZ
 SK/2DiQj4mDqoB8vD888IFKwGvb4wom9H5+rZmkQ91V8cnA645/VkjBn9MlY+T6n8J6o
 2oPnZ/bYJMbfzTr/lgYzMBX2a1snd0bocEcTJEl/wZWNkjaaXqf6QebjelVHMuuwGyR+
 gJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794725106; x=1795329906;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BonwvJOwzyfOZwsDa4VZnjPDHnDoIEr1GLr5/tnXVZY=;
 b=yr1PFpJF7Vd/UnUA8wtCYTDnhBJB/B/FuFYeXL/m0oVra0s9MGRrpoEOoD2i9bqaeR
 ESkdQv/dvxebhCQA6WK2VKSsj+HSELJeP9cRzE2R4kzjwEEFOemBcBamHTQtwT3+kzfk
 BBBJnfV6jeKR8Eh6xzJxPSa0Fq0XNOLyovKXf/Bs7Vs84nCLtw0TdX3Z9MaDcMBRHOpd
 YVU69Ja002BIaFw7q94AIFs8VoDzWpnRcSLveQPF6xw7xvTSWGZTe4RDvLcm+KRN/N2Q
 4UjAi/jLWbvHDobrDpfcx7/LyiQdMKp+Dg5+OO/D7YJzqu2ypFPpDGHfa1ek9Fm/aZTD
 5leQ==
X-Gm-Message-State: APuU4Z/1pdFbNBDY0n61FKFG3EVdn3J+MndfuqvWBtkNhuCcY2GXfc8V
 TpIc6TwL+GZFAVKq1W+0C494PhlJLk4hNphk0effZc/RAOrSvg5bZxv00OKbU2513sBjcY8AP3s
 +91f0UopDxlmC8wGkZZn75oFbFUN84Do=
X-Gm-Gg: AYBFou2CVokfaQg5597Z/iU7ged2zzxrpO/Ox7OdPGEC3QpBnStGLE1xBhAtgcxF/j5
 LVL3pWtcxafvFFtKeU2NznzhdCZ7nNM77xkdqQBNVhk8gq1xSWMS9cQxmQlEZ9X0UK5ug7DfWW1
 EOJQpAK4jBrqKTaBgDsP+j/vMCWQJLPqrmHcgCgtwZYDb7iYBYc5m/7XIRKbGKFCNHBrcTazMAH
 xkim+PSM6oddGwYIW4NgKxepdisucZenPABHx9JgBqhIiX5T0qOZWuXYoqaM7IZR85Dx702Mt3O
 1T2IEpqLU2BZ50tzJvCuX+lJiyAlWYB9XoyliY0cx2e3DkNAWFL3y3H5vw1hQ+BoELfmcX+A+TC
 pGdkwAxB8pORDYg6H9Tel0/7pFpNbvFY0gur3iWXUHKFxTL/+XkACgr+KZnAgQpotq7fH
X-Received: by 2002:a05:622a:307:b0:535:1f7a:e29c with SMTP id
 d75a77b69052e-55ac7d51618mr121069271cf.37.1794725106624; Sat, 14 Nov 2026
 22:45:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Alex Guo <alexguo1023@gmail.com>
Date: Sun, 15 Nov 2026 14:44:54 +0800
X-Gm-Features: AclHuK815p78pa1VLVdaryG8ubT2Fe63Q2Vuh_MREkJ7uBfmIhWNdCuxkpU-f9M
Message-ID: <CAAi4Z-eivBb9rX=xOwm9EcXBaM2T693r6FJ5649B=QxVEE_T4g@mail.gmail.com>
Subject: [PATCH] drm/kmb: Release the DSI device lookup reference
To: anitha.chrisanthus@intel.com, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

of_find_device_by_node() takes a reference to the DSI platform device in
kmb_probe(). A failed probe leaves that reference behind. Each retry
while waiting for the bridge can take another reference.

Tie the lookup reference to the display device's managed resources. Drop
it on probe failure or driver removal. The separate references taken by
the DSI initialization code are outside the scope of this change.

A similar issue was fixed in commit 7c6daeaf0a72
("pinctrl: nomadik: fix possible object reference leak").

Fixes: 7f7b96a8a0a1 ("drm/kmb: Add support for KeemBay Display")
Signed-off-by: Alex Guo <alexguo1023@gmail.com>
---
Build-tested the affected driver object with Clang 18 for arm64.
No hardware test was performed.

 drivers/gpu/drm/kmb/kmb_drv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index 7c2eb1152fc2..f6d02893035d 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -477,6 +477,11 @@ static void kmb_remove(struct platform_device *pdev)
        drm_atomic_helper_shutdown(drm);
 }

+static void kmb_put_dsi_device(void *data)
+{
+       put_device(data);
+}
+
 static int kmb_probe(struct platform_device *pdev)
 {
        struct device *dev = get_device(&pdev->dev);
@@ -515,6 +520,11 @@ static int kmb_probe(struct platform_device *pdev)

        of_node_put(dsi_in);
        of_node_put(dsi_node);
+
+       ret = devm_add_action_or_reset(dev, kmb_put_dsi_device, &dsi_pdev->dev);
+       if (ret)
+               return ret;
+
        ret = kmb_dsi_host_bridge_init(get_device(&dsi_pdev->dev));

        if (ret == -EPROBE_DEFER) {
--
2.43.0
