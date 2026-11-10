Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901C606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FoEFLwST;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=km1ZHy+Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2533410EDA3;
	Tue, 10 Nov 2026 04:54:55 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 791DC10E2DA
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:54:43 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4A2Bd3268147
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b0APUxkvTPgI0ANhjuYFxN+VuatDRUzGZ3XDlAXWiZE=; b=FoEFLwSTGj54VfGz
 xJMwMhTumAgiVj2HcJJRXvLB8+sFSIiMsy0B2ovn/WTPBVO1l6YetS46Z2GFCb5J
 XRHQ8AEB472rB7LbMQRhifMVnoQtAK6JcRYAm05bduusR17p41gWEPP1EUcFeSk+
 PHYpHqW1xyXH6caV+5jlwFqDFlcbDhyO+lGqDYJUIJZLNeIWIPnZpn8wxFlPrAQy
 U2leU5R2K7QfVPtAq7xr9a6tZYP3hjVNEX4x7dXuDG8NP/glZYG6Z50RybskPjBh
 aNb5qA9KKZIxMBQMBqP5sDFWTVX0YJmgWfcuPFM0QcUSjTWoyYzh7l3ztmuVDLKv
 JxDCqw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hue0quba4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:54:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e92aad34aso425740885a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286482; x=1794891282;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b0APUxkvTPgI0ANhjuYFxN+VuatDRUzGZ3XDlAXWiZE=;
 b=km1ZHy+ZJJidsQzhTrdN1wzD1vRogA2GlP1kxC+FB9KzgCSdKL3Z9C1jbAm5EP312k
 CIPZb2HV2d6D/tADrKWGKxoap60uYnHLP9xKcnkLCxIIuSy8tuunVGYJZvmgQAv1viq8
 3yog+CIrJhCEMhg/w7a5J/grK/eG2xWlyRrcvU2aZxRlcnB9RStFRMeSK7E1/+DI6cT3
 BRyZ/HYczHwpKZWvL4hAIvRlypMYYQjH7lhq8sp8C+/uLuPeLO0QVMF0kAdvulBsf1+w
 m/6EbQX8b5L1v8t1Fq43REwXU/NKBXxKlcxJ7wT4Y+zkhNF8nHusFiLaw+16JjocYyOa
 wbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286482; x=1794891282;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b0APUxkvTPgI0ANhjuYFxN+VuatDRUzGZ3XDlAXWiZE=;
 b=GmjlTVli+y360KUAgLBZgONJmR3xJt5O3qREewdOeRmbTPGBgSNcdoT91hwbw5ZSOc
 eOi9eYbAgrmExzfgxxY1LZQia/DLlYs+HTaD5mgy3PFQ7VuqzNazd23zHoSSaHQyQtBN
 i0UfhzxnVMhy0g43XB8YDsnP9vH1I3p+ks8YgrRE19Ce3VUya816FqtkTBSVg/r9iVsm
 jbaWJCmIjCTICwM0LZXIzqjFVGGwvUSdFJwj7N3sakOvlEieX8dzDduzPWcghuODa/uM
 3+eft7FmyjQfTgKf1ktxsNQOm3nMUA4zU+5hWEBa4Xe1aP4tNL4HMoGU/P8OhEVDTR+Y
 e7OA==
X-Forwarded-Encrypted: i=1;
 AL+hErHMYULzwKvmbzSnTZi6fdZuFOLwQJC1iEgJqVUMMu1lmXPpDO7NDIYm8lT0XwpK1ysbd4wSvymgz8I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8fRO42CdE4/YVfNfdK/L00H0R1YcLQSy1XKT9FQmBlcjPrlZ3V
 dGZee4iuvddVTeO94OZm3omplQIv7hYGiG+Xt9Y1wJXIUBxBGUTUPGd6AJg7+hyK4TBdkUxRraG
 7TQ0OovtQU+X3Pth80ikwuP4gwfH8baM6CdZR21n1tHfxG1SB61xtqu6ze8MrjDoPml2tkis=
X-Gm-Gg: AYBFou3QkUWIS8VSKaFArfPdehqQaonihJRwT83RvgkZ5ESG4L531+MZHmHhxOLix/n
 6suIK4neAD+oRkCNaKb9XSC2z9UFE+rO6dM8VDiQPvoCaDqse6UsByaKjGXyedFBccLSMEjR1Rt
 0mVZyY6TTQN4F0QE3WEUGvFBPnntO0kkIK49/2s/tv4zQnl/h8Zb9SQcP8vcrILICBK7AffhF5X
 0XODh5LZboORMTvac3yafnTUSShDD9vIxxHqVsXrVs4mwCRC+9Sp9tDaZsIpY+V/VOWC5Emvpna
 GEC+iyHJrYWxQuwyA57sxq27xRhRf0X2ZfcpYZob+FqVhjVv1mez3rZMUuX/TNygdxy0WqsMNgk
 zY9/iPPMgOpG52HvVd4/EtvxkgrE2O/wDb133nJZOlMMJmgtO/rKRAWQVIkpHM7OHLbR58d8uqC
 URVTv/vI/xw2pG9A/3kG+fPqTDdZVE3I3IC8pA
X-Received: by 2002:a05:620a:4005:b0:93c:2c0e:7ac with SMTP id
 af79cd13be357-9479f31225amr241386985a.53.1794286481760; 
 Mon, 09 Nov 2026 20:54:41 -0800 (PST)
X-Received: by 2002:a05:620a:4005:b0:93c:2c0e:7ac with SMTP id
 af79cd13be357-9479f31225amr241384485a.53.1794286481200; 
 Mon, 09 Nov 2026 20:54:41 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:54:40 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:22 +0800
Subject: [PATCH v8 01/29] drm/msm/dp: skip sink requests while the mainlink
 clocks are off
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-1-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
In-Reply-To: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Joonhoe Kim <26rote@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=3077;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=hT9291PUkSkajfmAeKZ+I+nNpFsKsuD4le8SAcshPD8=;
 b=DRb/t45pYDIi5C9EkFbmqMtY2Eu8B3Rc/4wjmSbEHORPyc3xoudi1H3qM3F8wKSVKjqBpvg6+
 F1ohlqUSHVPBdTlPy9dSCviDLeH9Go26kJsvQkKKEa3Nuhdr5TwbavG
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX0r6eVKJKdMrO
 VfV9CdWUlrNeIAcqXQZ/unbV3RkvwWXCCLjojFSL+hUt9Dh4LsdlDz8sboiuiHoW9brToaW7TCR
 CHrD4O2MHXTg5VUS8hAphf7ltGAKEVYMjIeVXF5FDO31TPGXD3kYABxwEljz2ivwMc8dB2Grpw0
 hcBNE7zL1w22b1wVMz6JFuAJ30Ej7ixy9j8EUt/ln3HkMHeR4a9XuUYU05EUAQ28cTDyHF9AQBp
 JzQy5xlf5XBMvYCfwaQm2hKSuwKc4ex7ypV96QloK1NvDikNjtEEtOcfWSPVAIwAP/21l43ir3m
 3y0Ia0xZI1rhWu6CcLGa8IXKUXeeUwi0DjZWr0nmM/j+EO0BmJuzFH5etwrxkF3UbIOWaZsnooR
 2lCDH0Vyd3u6wM6m1RqFmJEZQaYCfVmsAzk6Zs5QpnfAHw+kdV+OiTEe1+gBjBzSAbj7Z0Upwdm
 GifGkBgq6YV7rqmqW4w==
X-Authority-Analysis: v=2.4 cv=DZuCOftW c=1 sm=1 tr=0 ts=6af2a392 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=gFHGZmHKE-3D3zYqEJ4A:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: xwW_WpDpI2d5fY63u-Frbu9MYuCet8s-
X-Proofpoint-ORIG-GUID: xwW_WpDpI2d5fY63u-Frbu9MYuCet8s-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX7xLc3gMeLNEJ
 FnOmmJEs2i/LJhs6mqDnilw++kekixbo/cCqXMr8mqGZWoXgXSGz9CVGErwP1WXSffmRhveSK9s
 ckPjgtnkvmIUjuR+sx+y9WmCURBlFcM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100019
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

msm_dp_ctrl_handle_sink_request() programs REG_DP_STATE_CTRL from all
three of its branches:

  DP_TEST_LINK_PHY_TEST_PATTERN -> msm_dp_ctrl_process_phy_test_request()
                                   -> msm_dp_ctrl_off_link()
  DP_LINK_STATUS_UPDATED        -> msm_dp_ctrl_link_maintenance()
                                   -> msm_dp_ctrl_push_idle()
  DP_TEST_LINK_TRAINING         -> msm_dp_ctrl_link_maintenance()
                                   -> msm_dp_ctrl_push_idle()

That register lives in the mainlink clock domain, and nothing on the
IRQ_HPD path guarantees those clocks are running. Disabling the
boot-time mode for the first modeset from userspace turns the link
clocks off. The sink answers the link going down with an IRQ_HPD
carrying DP_LINK_STATUS_UPDATED (DPCD 0x204 = 0x80), and handling it
walks straight into a write to an unclocked register block:

  [    4.572532] [drm:msm_dp_ctrl_off_link] disable
  [    4.573756] [drm:msm_dp_ctrl_link_clk_disable] disabled link clocks
  [    4.823194] [drm:msm_dp_link_process_request] sink request=0x80
  [    4.823199] [drm:msm_dp_bridge_hpd_notify] 128

The board hung on 3 of 3 boots with a 5120x2160 SST sink attached over
USB-C. On the hung boot captured with drm.debug=0x100 the printk ring
ends at that last line, the drm_dbg_dp() immediately before
msm_dp_ctrl_handle_sink_request(). In the RAM dumps CPU0 is still
running pmic_glink_altmode_worker, holding the bridge chain mutex taken
by drm_bridge_connector_hpd_notify(), and ctrl->link_clks_on is false.

Bail out when the mainlink clocks are off. All three branches need them
running to do anything useful, so gating the function entry costs
nothing: the first one resets the controller, which its own comment
notes "will need DP link related clocks to be running", and the other
two retrain the link.

Everything else reachable from the IRQ_HPD path - the MST ESI handling,
msm_dp_display_process_hpd_high() and the video pattern test response -
only talks to the sink over AUX and keeps working as before.

Reported-by: Joonhoe Kim <26rote@gmail.com>
Closes: https://lore.kernel.org/all/20261108011501.4466-1-26rote@gmail.com/
Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
Cc: stable@vger.kernel.org
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index abd3dcdad03c..32d4d5743eb3 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2321,6 +2321,12 @@ void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl,
 	}
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	if (!ctrl->link_clks_on) {
+		drm_dbg_dp(ctrl->drm_dev, "link clocks off, skipping sink request\n");
+		return;
+	}
+
 	sink_request = ctrl->link->sink_request;
 
 	if (sink_request & DP_TEST_LINK_PHY_TEST_PATTERN) {

-- 
2.43.0

