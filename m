Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CEFC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E5610E6A7;
	Mon, 20 Jul 2026 06:11:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lVtcxryq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hcNNsX/8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C14E10E6A6
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:46 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66JNsXrX849171
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /ZkQwyBXdXdbZK7rkpR73PpIwuDrFdUuinUJFVkWC24=; b=lVtcxryqsDSsnTjw
 PFLn8Hjh6OcJfEqBoiCVvv+nGxsOl4OI1D1jZv87n6+T3jMrGzFtNfIQ7cNHS6Lg
 1/5hTl/LjOF/j0JcQrfDMiMLhaBmKLrN0IB6fiSFHj5nSQKBzWnWHcVw27PqBnRW
 xWP3oeb5gHJ0u9Br2B5lozei+GMb4K7NHabGR03ZWYR1n/0US1/xHSpP0KIVdIOH
 6BdhTkTApxN1kz+cWeEn67XBWixlYzsgZHfLE6DKMLBP2qDLiM7++BgYbwmLzWhV
 +sP1AIJqB21jPRqrDiwIfUPlkLD+OMXuYw8hkrDvXIqlbKobqKiA2Ze7QbxtyU8C
 d8/oCg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2dc4p51-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bff5c7035so83805541cf.2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 23:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784527904; x=1785132704;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/ZkQwyBXdXdbZK7rkpR73PpIwuDrFdUuinUJFVkWC24=;
 b=hcNNsX/8rL5517EV2R5iVqy9kLkTvuMZuzZSBliTSCXjmlp9cUSCT6PB3hVf0xdWWk
 G4wAi469iYw+m0R/sTfXfEZ8AMtbb7IycN27qupfPzZS8eQmhJwcJ0QBA3qRUIGAjvGG
 wv6VneJJj3YhFxRkmYgwwxl03OR8w6ssHx1SPBtC27sn8bkD1OXzCjCPYzqr/PCmggzW
 xkJKbOBT4qsznEhqwgof7QKrjlhZzdhRDkX5n5GlTq+iEKKm3u1keI7okn8dfsh9WrXb
 5eex5daWRCRfAfrbOYGi1cRUMepM3nHe16ldTOv57c0zuVfaTnUuRdrQFp9OIT9gF+Uq
 gwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784527904; x=1785132704;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/ZkQwyBXdXdbZK7rkpR73PpIwuDrFdUuinUJFVkWC24=;
 b=mqxehL2PXeOwwuysW9NKl26SUTSD/DumMe/tKsjt1oZKWESu9VDvs3kJ2yvebStL91
 vsVqgLBEKojiPMkrfFqfWELFptTLtMXL5WlDG8pwBCqyQhYF/NFCDyPn0i3xjMapXGPD
 hIWZXzlWpYUTIZsnWKU85k4anYwgzWqtY0UwWigiVAZasvriDyjrPnZ88KyuuPFq+Cdx
 PU4nLYBYegJUsGwDHvUavIA14MzFc0VQVI8t6wA0uYEnM+dPK/vEoGHSjQ2qCN8Qin4e
 LOxCvHU3YF4f9UR3ccXgq3y0Q/9qviBcMPe4ZZZRcJRYou9FKdCu2h9KVh7RjeTT1fCX
 mVhw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZrwQTz/S7TcC22EIgZnwcOtFauqmZbReKy/G5x82q3T7Ir5/BLRxpxvOP1ui/fOM5jaZ1/jQ4Tkk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwpfOi5v1YfFbhINPwWvythj+TyVlIsOKVYYxX93dGyDi1ieL0s
 3ZnuXHFNGL+kf7w+8/JDp2SmLTRiyq+xQqlYdli5Qt4wQE4712aSCOSD7ELjJNxDiAgBUXbXTMA
 9PsvC9P/6/e3TRcYx1fQQ9kGEina/4D9zzV0tK9Webo5VtBqmsl7mPhy8Ne7hZ7pSO9LpFmA=
X-Gm-Gg: AfdE7cmZ8dsZVMMhA2Bs1g/vBPXAFl6Rt239GjeZ84EkyZfcCxJ5/PN3jtPMcK5hOHs
 BTwFAd/SucmKOcPD1Z47OH451W61+pbXmHUTRcV4h1ykha5gnHmnq0JRCoCKsYZ6w6foT9j4gRZ
 PIQVQHkfaiUrezaULcrU1xwxJPT86xJ7TWHMyZxKC5bylA2CyHERtF04/G4U/y3/zhFP3SFZGKA
 IscghbPInq5CWeVfgjzF6FUjM9OhuCcvtJ2RaTBoIj8BlhBW6ReB7jj55SsO+pY4vvjl1x8tFuK
 yO0Ez0tJeGDa2XA3AXSPonAaurJRLNpwIPdhcxSUmAu7u9m3RX8/2hSOTO6ojAYF3uet73/IDMk
 Yj8d4yM6VM9gJvMPQrVHCUGkU/rvcjZ1cXKlMX9j6SOUx2bzKtJmIWvutWeclUcg=
X-Received: by 2002:a05:622a:230b:b0:51c:19af:6330 with SMTP id
 d75a77b69052e-5213b33bbedmr123147091cf.36.1784527904658; 
 Sun, 19 Jul 2026 23:11:44 -0700 (PDT)
X-Received: by 2002:a05:622a:230b:b0:51c:19af:6330 with SMTP id
 d75a77b69052e-5213b33bbedmr123146921cf.36.1784527904346; 
 Sun, 19 Jul 2026 23:11:44 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90778588a39sm84793216d6.20.2026.07.19.23.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 23:11:44 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 14:08:19 +0800
Subject: [PATCH v8 12/15] drm/msm/dp: simplify link and clock disable sequence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-dp_mstclean-v8-12-bea261bf4e7d@oss.qualcomm.com>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
In-Reply-To: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784527840; l=1745;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=4C6nVgcTW+thgRB8rInVDfxhuZ+n5lTL6ENDh+EIJeo=;
 b=B3Syo+/mknQQIe6IKqp1uzBpQ264ooLumBdU8/54Wne+5QjAVw83eN+GHaa4TpsIhnA/d0AH3
 zIBzEJZJwZ+BKLSCAmv8Qynmfnfh2V/7dS2rLnlKt6QvMljmJ42YTlu
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2NyBTYWx0ZWRfX655SRhIr+c6x
 pXCZGeJgfeoGTXsv5mNFbkrMVYWQhICadTX4M0d0cLdGbUXjYL3eSNSKCu2IJqj6dA/tvYle98M
 8CQ/UXhRwIbDd0KhuzA+E9szGNNtpc4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2NyBTYWx0ZWRfX2xdimRWPgPJB
 J93JVymgWGorQ74tbfDOYuVPO3p40lPXIR+rEvYMdtqpHsa1hj4Fo8bvpRJuo48g7gUyvzK1WyG
 D6yh/EbDhvBR7Iyvej9+SVFNqJHd8RwUNtUWacIt0GIGZzLiJ2uCdNHawJlRiEAPZGDo2nQ/46V
 MsXQJ6wlmNWR9OLjr8sXLiZE2OBsyNbiiAVejvVyFFdqC+9fr9lJqCem5fcAKYzmyX2pNbaVxLN
 cdnanmAvCwe6XAYa1JLT2mfI5wqm4zZ6Aqdg5X3gVhgUF6V2GCzSfNwG0HGBuPPVkDyPRo3LkHj
 JIoE0c6sVy3zOnevXwYZVgXGQ07VTQfcRiRdVveEMaUHXsYBYEu4xVfCursfVWyweD2zgO9kFr7
 fI3Zv9IFumwlWG7HaLQmzFdLHlPNpMrYDFgKv1fGZmmPwZYMUgoa+gvZorcN/7rG9IdUzRwXAQF
 wU3zG9IiERPCTWS60WQ==
X-Proofpoint-ORIG-GUID: qnGq8YWyXZ_59zI0tBzWwg9Q3NpVphaV
X-Proofpoint-GUID: qnGq8YWyXZ_59zI0tBzWwg9Q3NpVphaV
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a5dbc21 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=FrCxesj2aA1etRkkIm0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200067
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

Move the common disable steps out of the sink_count check to make the
flow easier to follow.

No functional change intended.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1ecd700a474f..d1a3a6f6c303 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -718,27 +718,19 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 
 	msm_dp_panel_disable_vsc_sdp(dp->panel);
 
-	/* dongle is still connected but sinks are disconnected */
-	if (dp->link->sink_count == 0) {
-		/*
-		 * irq_hpd with sink_count = 0
-		 * hdmi unplugged out of dongle
-		 */
+	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
 
-		/* set dongle to D3 (power off) mode */
+	/* dongle is still connected but sinks are disconnected */
+	if (dp->link->sink_count == 0)
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
-		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
-		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
+
+	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
+
+	if (dp->link->sink_count == 0)
+		/* re-init the PHY so that we can listen to Dongle disconnect */
 		msm_dp_ctrl_reinit_phy(dp->ctrl);
-	} else {
-		/*
-		 * unplugged interrupt
-		 * dongle unplugged out of DUT
-		 */
-		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
-		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
+	else
 		msm_dp_display_host_phy_exit(dp);
-	}
 
 	msm_dp_display->power_on = false;
 

-- 
2.43.0

