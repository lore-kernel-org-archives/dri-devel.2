Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC414CD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 09:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3460A10E78C;
	Wed, 27 May 2026 09:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l3U72lyK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FFwsBfiF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 252B910E76C
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 09:48:22 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64R8mkbq2153150
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 09:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XcXJ7ussJcL
 Vp4gCSciGOlZ9khVs3DX6bYIjdliO3uc=; b=l3U72lyKO3Zth1RiZcs+XjeutDP
 CJBJuASGP1GRtUkawoTwkPYm1OjiFBGxyf3gamXVztM5AZ6FO22Ci3s0KjQ3ylaZ
 eekjp4kPVvhdoImWd3kXlCu759eOEuqSEbpkMTeELi97CAruKRhHrDlxHVSBG0qN
 Ed7xRSIT1NicwVnQuD9IOVKi7wAw+fJ3L2idBxSyULkLNo9UnOJc52qMpgFm9+VP
 ipO0ntALN+E5T4Q0lTt/tELNJuu9f4oxdVytlm2Lpcuz22YcY+d1yyVPcCfarN7E
 0vXAzMZGBOYJD4BGkumTLyKEF8R/2mBL1JFANPl5xxxIQbc2nG4y5CGog9A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edu6rgts0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 09:48:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-514551d5f2aso24324151cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 02:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779875301; x=1780480101;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XcXJ7ussJcLVp4gCSciGOlZ9khVs3DX6bYIjdliO3uc=;
 b=FFwsBfiFbhfQniqmKIacLAGEnjeLxESJmuYhA1oggvxQPaBh3g6NPKeI6J9I1I1fka
 vqPOAESpnpDcO8A/0CfYJQXDzG+s6174srnW2EDi0yASKT9yRqj+MH4TXYxGqAC9kxbF
 KtcW8hYj+Gr+EvGjsvU0XTrlNODDaaEA6zqKF2QZ2BlclxrAS+ntq3sw6IS6Q7ujEzIn
 FaX7oC5e5PwuWwmAx373dngUhQBrgabhoG/+nYVvnLraAiNEUdPBDGO2bM7NUR+q5Ykx
 ZwDDXcqb/RRjhkPRP3ndIALsO/h4Ifhb3RKfJKsIz6QxOdaShN1/PmpkY9M4luSwsOtW
 7DvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779875301; x=1780480101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XcXJ7ussJcLVp4gCSciGOlZ9khVs3DX6bYIjdliO3uc=;
 b=rflZTtPizwSlQ74LAoVNB4Ng3zliczASyHO5RNLfPmoQ2R0+/HLbmOzFz6PRu3B4kh
 8iBHlqSGlOj83NgoRJeNkGFH6D44UqY8N56jY13VkfBNCqZoCv1iOx8iC5pbwy07E/OI
 UqOij3ZkmaWpMiDJSsFeGIXDJgSE1FmHMxVmAT4W6rfkCOLVxJ1c5IHR/RFi9L9Ig4bW
 Wy4PEJDDrNyu4GxaRemU+yOypD1dD520ABc3nLculQ20thUJK5U8x7xnov87cJRQ+O4M
 TQnmwir76NLxF6yG1We5riFiciKfQwM8wV+ylEUDRp3A7Os+w0zTaWk6cf1NCvnlZ/TV
 3wYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yWs3lqWLoWMVqI34Rh9HvC5CGxgVrbMEqP8+42YymdeNatEatI0uySp6jm6+IF5KSZlB2U2sVPe0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCQrgGn7dI78oRbZVjHM9r+f8JcNUQZvanhFTRHLRW8EL71Y87
 g5EAyH2zIRf9/xsuFv0Ukim4mqhHmdZ0l9Rgaf0qSy/pxNbe8uXnSQsP7YzBw6LgoZqeG9q9zd4
 ETJrg8I4vLOjuhTGCva+zs+xHhHNL4n5c18OXYVDVjVDDPPjMiZeMawFckkY0btekhECYeiU=
X-Gm-Gg: Acq92OGrknM516Q8bNaPBPnFiddmu7eEoaBYLmOfIe2Mr049rP/xrdmCYAhSD+rdVOw
 ZoBYW3qmcMzIYZCqOREVmczHa7bzfTMeLBVfnJlnP0DjKXJTnEbXXvoF9uWAOwhDYrVK5BUavhf
 uAlWZrTpohyTtR2PDRiN0CYg1Ou7dlOFn5C8Uy+aZzErndz20m8FauKwXd3HhUt+GgvZ+9IWkW+
 fqJcjbqDf8GuF6uhAm1O+TBTmg3U1aYzbnixiAng+Pc4phv9tdLccYBINpMl2XxT17dNCKDz6Os
 d+c6iTBGSI1fiafn2KEplMKxk4NTv83s1AP3qGtEf4IabOp74DLrB/hx3ZZdLz+kNIm8AHpw6Eb
 a+9TTtT00D1dfnAIlIZfYmMJjJuK7qQVefIRELOuF3vJ6LraAmggojO0uHLxgY0SgckAjR2Wvbr
 Sc/Xk9yfZ/ZeyCEcJcTtzM73Dg2gaO2vAg5xXr
X-Received: by 2002:ac8:594b:0:b0:516:dbcf:96eb with SMTP id
 d75a77b69052e-516dbcfa7a4mr268621611cf.52.1779875300522; 
 Wed, 27 May 2026 02:48:20 -0700 (PDT)
X-Received: by 2002:ac8:594b:0:b0:516:dbcf:96eb with SMTP id
 d75a77b69052e-516dbcfa7a4mr268621291cf.52.1779875300008; 
 Wed, 27 May 2026 02:48:20 -0700 (PDT)
Received: from shalem
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68a6fb31611sm544001a12.22.2026.05.27.02.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 02:48:19 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Helge Deller <deller@gmx.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 3/3] fbdev: simplefb: Use __clk_disable_unprepare_counts_only()
Date: Wed, 27 May 2026 11:48:11 +0200
Message-ID: <20260527094811.116977-4-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527094811.116977-1-johannes.goede@oss.qualcomm.com>
References: <20260527094811.116977-1-johannes.goede@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MoJiLWae c=1 sm=1 tr=0 ts=6a16bde5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=MIOsnmlco-pcipCrOVcA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA5NCBTYWx0ZWRfX3HMMdz/RkACB
 fIuUOGcmlLKW1E+jID8VxG7tDfe9LQO+yBDF4W1DGOni5jVtYBXodMHCboG5oL3pGhO+hKr5LI8
 2BEpLh8rKN6v7vSdn/B68/EuezlpDlA4TOnt2Fg216vuDh/kLHFDO94JHJHXeSjALdWVT/hiZ6i
 cNyEBBdsuvchtd0ojnjnWDs6eXzZtVxKbLuilsd8lErdXXjc8zHs88zju0BpaDnteUt5R4V4WL2
 Iaxe1nYsJvxyqxhXVQgRp8S6/Zf4NQFm9qk2aAuITIYssc/8PtwrNHKq9FBIVHGXuT225o5aWE8
 NtTW45DJxNxR5yXyrDhCryLBPfnQOkBHUyVZqNQVY/QSpeVYL9EjskyhvmH46pZE33mXvraIQ45
 Eh5779mKvLbaHTgixdQGxJ3dpfLoXfoQBUlHqIiZ25S9qmo2IL208puf+fwOi4d5uYan8FhuL9Q
 I8YOkCsuQtmOJ1/hJrw==
X-Proofpoint-GUID: NAw2WnR0qNuGMFTC8h71CyIptRP8x9Ja
X-Proofpoint-ORIG-GUID: NAw2WnR0qNuGMFTC8h71CyIptRP8x9Ja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270094
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

simplefb_clocks_enable() calls clk_prepare_enable() to avoid clocks used by
the framebuffer getting turned off while in use.

This requires simplefb_clocks_destroy() calling clk_disable_unprepare() to
balance the enable count. clk_disable_unprepare() actually turns the clock
off, messing with the hardware state before the real display driver loads,
without any knowledge of the proper display power-off sequence.

Sometimes this leaves the hardware in an undefined state e.g. on some
Qualcomm platforms turning off the DP clocks at simplefb_destroy() results
in the following error when the msm display driver tries to re-enable them:

[    2.980181] disp_cc_mdss_dptx3_pixel0_clk_src: rcg didn't update its configuration.
[    2.980272] WARNING: drivers/clk/qcom/clk-rcg2.c:136 at update_config+0xdc/0x100

Resulting in a non work display output.

Switch to using the new __clk_disable_unprepare_counts_only() function,
which decrements the counts without actually turning off the clocks.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/video/fbdev/simplefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 60e5dcec201f..b1e0dba6d127 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -303,7 +303,7 @@ static void simplefb_clocks_destroy(struct simplefb_par *par)
 	for (i = 0; i < par->clk_count; i++) {
 		if (par->clks[i]) {
 			if (par->clks_enabled)
-				clk_disable_unprepare(par->clks[i]);
+				__clk_disable_unprepare_counts_only(par->clks[i]);
 			clk_put(par->clks[i]);
 		}
 	}
-- 
2.54.0

