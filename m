Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D73606A89A
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 05:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ExsJ8bGE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DE1B10E6A0;
	Fri, 13 Nov 2026 05:56:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8930510E691;
 Fri, 13 Nov 2026 05:56:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 67C54461C9;
 Fri, 13 Nov 2026 05:56:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794549401;
 b=jtOaF+kD/9zy5soAL/aDdBYDvVhNDiUIq6mo3AZuzYgmga70eKqLe7ieh69D2kcwWDUR
 LXvoykP2cAHhV2XS8EYpA9g3ajzXdQeMyFl24hyF3TcYXMCD3PpxzqJJfdmW+A9M2tmSH
 2FQm/d31k8Bb7Zsrb8BdqMrHTXlt8XoLRQRq+2hxt68MxR5MOvsQYmQPlFyTduQfKd9gO
 eR26um3pQt4rSAwEte4TWFfn2NihiDWuTc3QsUo4FNrlkFu608BgC6cB9ZC3I/TolMkzp
 pCPXlEYcSKhg/1EmF9pQfQkv1WF62boe0kfRG2gmVBbI9AKzFLOJgC2ultw8AtRZw8A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794549401;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=CyYKJ2XHN0ueROsD0D37/Kxc+UdXNCVk/iQdBfNPhlw=;
 b=Ya/JRpJ4iFSJ6EGlAnPwJyE9ROUmaFpYNfB7rkcldYc3+OJTUtrXGUXEoz77ghDrLmJh
 XIgvpN/4YKGP4/s2d5V4ZJFfzp889tokpFIC/8Z/x3Ss9UjibNj/pE041AkJfdv3HT/q5
 Kb/UuapGZmkpXaPRSJX8lAjXejrNIS99kMh5vqCVi4orGzjHyZL0g0DdffCsToHDyUmqk
 X68hPj346YreJAOBM9Kue2ETYnKZqGKrQyi0tn8RQwCtxHpTcolycYGHwPOSXgbXP/11n
 JxLCXigBAgHcJ4U6FawQbLZtR4bbGwPA845/7UjXK3VJbADkynEyCtE7O/YTN5vJDaw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 16D8D1F000C6;
 Fri, 13 Nov 2026 05:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794549401;
 bh=CyYKJ2XHN0ueROsD0D37/Kxc+UdXNCVk/iQdBfNPhlw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ExsJ8bGEuE0fOPN7Z1gtV4Em1L9cG55je6op+acuOTDt+RsJ7avhqhY8kCoZeRb1G
 R9srCujnrALwpsP1RbZzn1hZTrMq7oN2i24vRN8ncqvfkcuGBOV9lV6DkB7bK27DSG
 LA0EmdFCpA6VJagAjAjnT/GbtSW7QrN+kzvwlVIw12016SQKBX7+N8di0YHKbc4coB
 OHQR3QAai8p0oMvtVTuz7KFAudzQbNNrAm75z3CGGQEvUawq9mdH+mEfQLK4LzVMZp
 zvmzXko7z4JshWHtMQV52tRoLF0QAroa2KV1cDwqDtKDBrGuZwFYYSuezSvFJMJyKl
 11IKxWLQ//MHw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D46384761A;
 Fri, 13 Nov 2026 05:56:37 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Fri, 13 Nov 2026 11:26:39 +0530
Subject: [PATCH v3 6/6] drm/msm: mdss: Add SM7250 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-dpu-sm7250-v3-6-30bdec59d204@brar.si>
References: <20261113-dpu-sm7250-v3-0-30bdec59d204@brar.si>
In-Reply-To: <20261113-dpu-sm7250-v3-0-30bdec59d204@brar.si>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, Ishu Brar <patches@brar.si>, 
 Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794549395; l=935;
 i=patches@brar.si; h=from:subject:message-id;
 bh=cuDZuz9tdcvui7XRO0ZIEMGONp1eurphXY1/XMpNa0g=;
 b=muggCIjN8bodXEgemPdTxGK2G/6jAMX88u65805W6Xm9DYqpCJIR7aKU6IdH3xCc/NNd1ERi/
 mzviZBk2Fe/Asqr8RyPIa19HLkUaxjtyKJ+zlzYixKHdrIK/BSHeM2B
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Endpoint-Received: by B4 Relay for patches@brar.si/default with auth_id=1189
X-Original-From: Ishu Brar <patches@brar.si>
Content-Transfer-Encoding: 7bit
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
Reply-To: patches@brar.si
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ishu Brar <patches@brar.si>

Add support for MDSS on SM7250.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Ishu Brar <patches@brar.si>
---
 drivers/gpu/drm/msm/msm_mdss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index e69b122f2687..f619052bbb46 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -562,6 +562,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,sm6350-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,sm6375-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,sm7150-mdss", .data = &data_76k8 },
+	{ .compatible = "qcom,sm7250-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,sm8150-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,sm8250-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,sm8350-mdss", .data = &data_74k },

-- 
2.56.1


