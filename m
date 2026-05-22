Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A50CD5BB4
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1586010E60E;
	Fri, 22 May 2026 14:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GMuXFtmW";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47FD210E168
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:07:23 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-367cbac9cb1so6541811a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 23:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779430043; x=1780034843; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=erBAyPrO5roYO8QCyIMfGlSqzNtYHdtfH7kgf/9D/qI=;
 b=GMuXFtmWaYx61jPlexBCGs9S12VzKW07XgkB5A4cC8tQnPqWCZdAFdYNEgooAW71Pz
 7c8oYVQ4IKUOQ255Wx3OkVoq92L1saZqHcgDFIuuxLWlI0ZvVJI6GuulVW2utYdVHUuu
 RYk+o9jp/K7euTugrBhPHD1ocoqItL3fAD6bqEB8UJ/znVIaGcOliyPRBle3X97SHcY3
 Mtzjw2lsDZXR3mZjt2u72PEwXU1eMMP7vZywauR0Q/wvrSr7T8GT7f4b2P16ltywzF6g
 lUTzkVqZguoqyqLtetzVxOnS9RPBa9BJ8DCbVrzKs/3SIBGqOr8ZQc1KsTcmPd01UXwp
 rCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779430043; x=1780034843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=erBAyPrO5roYO8QCyIMfGlSqzNtYHdtfH7kgf/9D/qI=;
 b=Tqz64ef3kNVjzVK7PIWkldu4DDkKJZG6iywSo4hzf42syYaV7Jhz2+RPMuYYQgN05b
 InfkH0VbhZwxikElkJYcr09toBfyeElvaLMJYUO2xdeo63zcvZM+ECDYaJApexYHErCj
 lCkWnzSfSzqK897yZ/yGMIWkO9RAVlzH3Ub0MVXJkWKK9sRwjkJOKWtxsbzVL4Yiw3WR
 ymaQhhgNYwUL98Vip7JwYnNELCPy3852VASnMmm6GmQUcI6UVtjWbxXQTv1Lq0HggoAa
 yjxqt59qxkI6o65J+H2Dt+lGyB95SLQedB4HFRZX+YT+QOwGuHL7mBmt2fo2kXP3aggJ
 tiiA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8oe9VblNWmpf9hmAT4xTkDlIXMZjJiEmTxfYnxYPSsdDkdDDCBr5oMClc6n3NITRGCk3Zrppe5AZU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXU8NDOgFefC1hZI/Aaxd01ArH9E3cRn2Nym2wJz9vh+Y0sMyP
 WkMbUb+Jn+MMUwLc/bvS/u7T69hJX76ahOaodaZZHkl9R/BYny9FWMEJ
X-Gm-Gg: Acq92OEMD1p/GJcxoSOFKtxZ8PuUvar8vrSkDDWH1b6vEUOG6ubHHV5htkagxjyK4iq
 zZE/CFBE3I6Z+ay1tzeSLIF5dzCfcpRWfVv+l2mdv19e67w0FNanTdy479dM6TMDT3qHguUMkjz
 4N18bvM/dQD6pLTaqY3B/7Fz3AOQe/Y88c+WbiOM411Hd5bFDdxzWXojv8hi/Asdm/Z3weAQBcT
 umoqYkxJGPaIWnDTwXisu++AkfKIziiEJGEAHBMihaGBZHSs4WlZtBH1S4rMKyeGckIE9dvGhDW
 eVV7nbqh6m+1axhTKIeEnHyY6a4g8pwPSduUIPk8wzMtVnaAVw5K9wXQKv3G/z4f6qABh5gsA7G
 bkejwENRkUqA8x4Rte+PpxyR2oSJPC68ahwlkgwY6i7IWXi+JeVm+7b6HYfAkkCLP5it1nw7PdG
 MOeHNxfR2MAO4vlJzNBGxdKHobH3g2fj/nV6sDqH4KA2G5SqObs/FmrtpfHzHV4mQZxA==
X-Received: by 2002:a17:90b:5188:b0:368:ea0c:1b75 with SMTP id
 98e67ed59e1d1-36a676dc303mr2283228a91.6.1779430042774; 
 Thu, 21 May 2026 23:07:22 -0700 (PDT)
Received: from radxa (122-58-25-162-adsl.sparkbb.co.nz. [122.58.25.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a7212aa06sm428572a91.3.2026.05.21.23.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 23:07:22 -0700 (PDT)
From: Graham O'Connor <graham.oconnor@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Graham O'Connor <graham.oconnor@gmail.com>
Subject: [PATCH 2/6] firmware: qcom: scm: Allow EFI variable access on Radxa
 Dragon Q6A
Date: Fri, 22 May 2026 18:06:41 +1200
Message-ID: <20260522060645.4399-3-graham.oconnor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522060645.4399-1-graham.oconnor@gmail.com>
References: <20260522060645.4399-1-graham.oconnor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 14:41:04 +0000
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

Add the Radxa Dragon Q6A compatible string to the SCM allowlist to
enable EFI variable access on this platform. Without this entry,
the SCM driver refuses to service EFI variable requests, preventing
the system from reading and writing UEFI variables.

Tested on Radxa Dragon Q6A (QCS6490)

Signed-off-by: Graham O'Connor <graham.oconnor@gmail.com>
---
 drivers/firmware/qcom/qcom_scm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 6b601a4b8..4702ad898 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2320,6 +2320,7 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "qcom,x1e80100-crd" },
 	{ .compatible = "qcom,x1e80100-qcp" },
 	{ .compatible = "qcom,x1p42100-crd" },
+	{ .compatible = "radxa,dragon-q6a" },
 	{ }
 };
 
-- 
2.53.0

