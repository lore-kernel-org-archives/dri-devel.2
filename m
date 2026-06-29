Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68834C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB93D10E8B6;
	Mon, 29 Jun 2026 13:17:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yej7WL7p";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gyjh0CWl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87DD210E8BD
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:30 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATD3o2578972
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jusjjSJwJFuIT3xoYc/Wmu34BYtQlfiUmQ5CnQZ7+xQ=; b=Yej7WL7p4t4mQCtb
 i1gbX7UFKfiVRKf6aRt6AWv22qYY2xkoa9qG9WOEwS2gOyKSFCfhXt5Ov84ojTql
 BiSv77B0t+0KXcwM1Iv5lU4jpmj73z1bykhQb1v6fLh9BRjE9wAKw+Agri1M84wI
 2ASvnHmwsEvwB+o5DgsDG8TiyuI3Sqp090b6yu4lI575F3lQArWEi5Hpt5zH465U
 6htM8LS7//mcZhXVZUJJ6ecmeoN+N38XrXJeAo++M/kHv3OtBUL2oPhHZP0RRSAc
 FQIINtkudbGacdBMw29XkU6vKEj0ozbm3BoeI3dO4s2hadmOx5jim+4ueHC8M6M2
 6mTtdA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7hg8y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:29 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ec235c7c66so30291526d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739049; x=1783343849;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jusjjSJwJFuIT3xoYc/Wmu34BYtQlfiUmQ5CnQZ7+xQ=;
 b=Gyjh0CWl0bXRYepxT7CtkXMEYnAMeLkA4SsjJbRV8KqwASH72cGGS8VYLpy0vA6N1W
 CoeLftWMNbARmjlT/Ryu52TQTWitE6uVWpQTgweYblTFOrrgDItT/iuAt1Y0x6e0gN7N
 GlUtkBPAWFNsPz1aBXjqYrCp4SK5nmIivCv4Wd/+KzSg2xW0coGPiBcR/i8aJtkvBYEr
 8hA6A2vYtKRrUtExADFPI/cJiPDDKrrtmVHDJrjBdtuh/qhRaD5IuzC3D08fsOCZUh7p
 D0L4KpyHidGKBmc+YzKuKgpr1alunIkmi+zj5ZAkH+W9+9Pj8wcYkUSdNKKiNpR+cIzh
 dEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739049; x=1783343849;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jusjjSJwJFuIT3xoYc/Wmu34BYtQlfiUmQ5CnQZ7+xQ=;
 b=JCu/dEpNdiqYAaf6L2POLS7Uat+Kf03uZdjjIfJZIB4IR4tAWF5W44LrIEb/Fsju39
 s5lYwfutVlqqXZM/OKF2ke+ut+KtAURwhPpxx8dC8WmUekBhsbMU4GZkimoCUolq4WWb
 3x1pwpLmHGIk8vj9jqnUWxiqE4wiqlN6004O+pSr+wCBMQOV8b+B2w2jVxVPBE14+Z5+
 fOKoVKZitR/rk1ylw4TxSGedyluV7FtRys8PEKDUT/hJNj6qx8f0IJtH+8zsHbbb2CYw
 2vLGvpwzw5cVi0Cx+L5eNQFN7zZttIBOm3QLuRzfYtnweUJxcJibxD4rMrMpQJDsOwv/
 OSaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZR3QimCtFY+q63j8l6xLesrCzPTDtbtJlw+TfyaiGzUYsvfF3nrGNuCXS2lbHiaZ3dYMwLQ3Veks=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMLEhvxAsbx/lWHM73s2S/LKfC1dERgR+LWBoURRCuLsYu7iY7
 /ODNm16O4ZEoP6+/eMdbNGxDQsaH5EZqWv8uP7aPinS6zXgAeaO5j5V/jF0QyzdRXI3QqZDNPxh
 FBH+qnqZ7f6hz5YowpvRyzcDzGrNjgLvtuowESZAxdFLt/hiAQcQYteZb4NwNuwhq1w6I23o=
X-Gm-Gg: AfdE7cnCoPDUAV2L6yqNyzAS7xyn9wzG58j2HHYEwhPdpDWzWbYOi4KOcQLccT1KNTa
 Tn/4bJEp7ixwovcTQL7CbvWIWQpjBfrJRhGohw6QaskkTqajuWFVgOvW4DOwS2bX1I+zRNiGHJy
 RbpLCkMtzCdnkVDAImDHtXpe1gMZqXAub+FUtYpYsK4/p/D+ZQykwSjlLzp+a8UNg2W/sN6MP8b
 Bl/nVJDEMZVc1Wn/KgmbouGF6Kc1FAilT8f9Nz7f7a9sHLNmGIEx9VQKifK3UNWHKvAC+yZwvjL
 mbE2sobgXZCdFYxYqCyCVJ4mOFyb8u+nuIBL5vB3IhrPebrNBMq6FciaH2vnKmaBED6HTLwOVmp
 MuVmGSNAYQ0Sn7pirdNKWnxDwU41Qjz3tbhHuBjoeJ8zW0MDZm/orHbXA9CQUjvL+TGVoEUy9xQ
 ==
X-Received: by 2002:a05:6214:268e:b0:8ee:9f8e:e910 with SMTP id
 6a1803df08f44-8ee9f9e3296mr125452106d6.28.1782739048810; 
 Mon, 29 Jun 2026 06:17:28 -0700 (PDT)
X-Received: by 2002:a05:6214:268e:b0:8ee:9f8e:e910 with SMTP id
 6a1803df08f44-8ee9f9e3296mr125451146d6.28.1782739048081; 
 Mon, 29 Jun 2026 06:17:28 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:17:27 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:29 +0800
Subject: [PATCH v5 11/25] drm/msm/dp: move link-level teardown from
 display_disable to display_unprepare
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-11-1d882d9012f4@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
In-Reply-To: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=2662;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=UZK+i8p/CNPfHLt8Mk2BsBISLw97recIVNrtzpulGWs=;
 b=OlhG2IwLeUdxLdXNkQe5yrC1xAoADYnbXOkAPtk7vqJVHIN7QRHbqCvVloFPSVBecBygAYN7S
 XDabucAoJDHCc9EXCCnlZ4aQqhFZUADKbFugFDS0kwmTGWkFbGS7vsf
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX6N27eGIcWS0n
 rtIOnkoUQmuvkq3+8vTHevZnIkymcfshuIY6XH6vKUtI9DBPGIycJKPbr6LtFtmLcL4+DhF+DJh
 UARyVtno41XdHg7W3/+ICWX++6SHlgE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX7wRVojLD62G6
 ssYzYDFU5K88uh7KXiUxs2xEBNgJgCvOVS+mtDMcqOKSES+ggLy88wcP6fkQQ3VngkOIP27fduO
 wuq1qqvxGhwbhad+WjJr8mX2XG+sfNmM5r46s6LZNwB7sFdzjaZNvKOih4PxPs9df/2afNEB5Nc
 7NP3YNdmcB9oYD8j9S1WJ7oPIyqkbipZftZ5HHbcReBSwVVvOTqWSHS6nBGRPlFV6VK9EBMyoPV
 YrHlCtoOBEv2IfNCHRgHbxgUzXaARW/DhZf2XJhEFJG1MLIkEeY1y86qhDZJiga5Y+fSvkgZli+
 RPy42ctYNYFLnU7HxgpqyRkZOgeRLVTCLTMuBvD+7T6ACoZFmRfUrGH34lu8uWZN+ZlJeEpJVoU
 J9Ffd61hwLuyq9wfmcH/rNxPRidjVApkd6ZfpXDw5rV/Gu+kMTt+++BHwZaSpHG7Fz2FWf5NOoD
 rI1SR3hZ1J3caFymY3A==
X-Proofpoint-ORIG-GUID: 8l-jf4O9s6d8tCrDgkDGwPi9BZBhO_Vm
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a427069 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=a95-bzEMD9sxZBs1_CcA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 8l-jf4O9s6d8tCrDgkDGwPi9BZBhO_Vm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

msm_dp_display_disable() currently mixes stream-level shutdown
(disable VSC SDP, off pixel clk, clear power_on) with link-level
teardown (PSM config when sink_count==0, off_link, PHY re-init or
host PHY exit).

For DP MST the same link is shared across multiple streams, so
disabling one stream must not tear down the link. Move the
link-level steps into msm_dp_display_unprepare() so that
display_disable() handles only the per-stream sequence, mirroring
the split already present on the prepare path
(display_prepare_link vs display_set_mode / display_enable).

SST behaviour is unchanged: atomic_post_disable() still calls
display_disable() followed by display_unprepare() in the same
order, and the cached dp->panel used inside unprepare is the same
panel that was previously passed in.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1af56c84b82e..1680a67284a7 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -731,18 +731,6 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
 
-	/* dongle is still connected but sinks are disconnected */
-	if (dp->link->sink_count == 0)
-		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
-
-	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
-
-	if (dp->link->sink_count == 0)
-		/* re-init the PHY so that we can listen to Dongle disconnect */
-		msm_dp_ctrl_reinit_phy(dp->ctrl);
-	else
-		msm_dp_display_host_phy_exit(dp);
-
 	msm_dp_display->power_on = false;
 
 	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
@@ -1533,6 +1521,18 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
+	/* dongle is still connected but sinks are disconnected */
+	if (dp->link->sink_count == 0)
+		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
+
+	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
+
+	if (dp->link->sink_count == 0)
+		/* re-init the PHY so that we can listen to Dongle disconnect */
+		msm_dp_ctrl_reinit_phy(dp->ctrl);
+	else
+		msm_dp_display_host_phy_exit(dp);
+
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
 
 	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);

-- 
2.43.0

