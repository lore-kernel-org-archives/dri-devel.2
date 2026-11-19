Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C56606A331
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OC4v/Hmy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CD+/mkB6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64D901120B0;
	Thu, 19 Nov 2026 08:24:47 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1AD41120E5
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:36 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6vWaA330673
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZizpUZVQzhsb5CtBv/UTg8HHKNryTN52kcnOFyzHuG0=; b=OC4v/HmyKSQUQQop
 ubk/w8BDd6LIRUUUnHE3bxpBs/2jebgXtWe4qV+5KyTJ7+ERMzfkYrQ2Lxnq3EVg
 GjqSZW7SR7fKtp2VPaRlJOAg8kB57EVQ2mcLe+fPgRWddI3S9CQUtW1++kkDYloi
 U96lR/TyNNHhpZOb2ROqxfLQpbXk3ErAkYBGzh7TN5YDSMA2vkDlfnMQAidHCENq
 4xLXX+k0fsRe6EXbW38xEJ0L7rNEpa1SYVCUN8GM3B1XlFjxkA7Y9kCY0weN+aYV
 ByjEB0kZfhK/Iw4WorxXXjSR0p844vwcGotufZet5v6jWBkliM6Sh3IP2I2lmg4j
 tuCZIQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1fpnkg6v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9495dd0f07eso393079885a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076675; x=1795681475;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZizpUZVQzhsb5CtBv/UTg8HHKNryTN52kcnOFyzHuG0=;
 b=CD+/mkB6BzFM28o+Cldi0ds7D6mRCBOLqXO6ZuCkWX0zN6CNSUpCDfifCjKXRYOKok
 rgn6yDMuMnF+pX6tiC7gGeXs4f1IZrae3+9h/hFNDBLBBuePvLrPcZ7FvjM/02Uh99Wg
 Z/FvMRozlVeycYJe3qK+VxautYNdFhXKPdsR1Dx33DQ3lc7rA5c726Hf8/9HyIAxSvFk
 7QL0PsVfTc4DRNtnZslpkPQmfjE9KGynSofUEiLaZFwBwK2g7NLwraDsMP0GU8rC0xMX
 138RvWIlH2gufBhLXJiAVVEMl1NuAqpABLDgtIeWmrr1d1nk5oejxhF3xA2CLx0UPSCN
 tfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076675; x=1795681475;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZizpUZVQzhsb5CtBv/UTg8HHKNryTN52kcnOFyzHuG0=;
 b=hEKN0WHdG6g1yD2HBKlMKF7B7fQK/nU0DxZ6MitbW6ldN+nLSHwbqZYeM9+exro1N/
 W4+7uxJUruTyKdUZvj6IByzuh3IDobbtZF9VA98ny3nDOqciB45CKDaz4ZZyqi9faAT6
 pNeXZyVYdECsa4ONOEUquBr94uODPkFKnyajWjJJzcdcZcwmAENWxAfsukRUrTIBb7GC
 1Uh912aacUq6Sy/AMBk8sfLPWKWnKMjQOlpv4NFaYEta/COx7kbWySxK/WVd7J3iaFNy
 TaQnIRIbTbYOl7hk8lxsmYy7ycA+VtJ3A40k/guHyu6sFTvo35IHJzZbQBrLXXvEehyA
 +8RA==
X-Forwarded-Encrypted: i=1;
 AL+hErF+ayoNZ60d3EDhIgva/t/2lM369ICRXzP+L5spYM3htlGI4N+/O7EubifcwObWKq8sqhn2q5KGkrQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8xGFXgc8tDPDoCy5SGN4fXIZqil43ES9SofR4/XzRuOcA7Y/Tw
 iLUjuf/8KLzy7KRkxWPqh/dGeYIidmn9o/uY8BuWNE1rmUtDxxxcHFxcCD3z3swppjTeHtKjFx/
 AjQe5Vd93IC4zYAOh+6KS4fnYpvojiJkU9csMbn7wul+iGND0lOIyKM20C3e3MAlOroY/8M8=
X-Gm-Gg: AYBFou2osfMcmZEiRr9rMqvk8HThgOCqKg0YPhkU1MCUk0fGb5q7i3BJaxh+EKvZEwM
 Pw7BOWp0YrPiok5jNaGNXTL003FlUobruJuJTRxn6NG/cz7yqjqB1LLmlS9xTyAkOND9Cm+EA9X
 zJO6v5ahfYiP7lqLlTt90P8Vk6fW119Vsr81xJkRzrSAIzzr8hLh6vedFxUm8mnCEEU9H6/d9PF
 AkqTwnm0T12oWEgzP1O25kav0lwIDYnS5ANRmCP3EkAVC7erNf4xWlf4Qlx8Oadh6yQlDUmixaW
 Bonx1B2ZNjI/DhfLcZU+E4VZ+w6IfOxiiKF5yYpgV9iBk7r0v9Epuf7QP6effG5zMDIt5g9l+P7
 EWdsUDG/WLPa7SPTdqQPZFKUw2D5RbTLSIEchseVx6gRB40U8i2EqI/qB/0CWQswis2mcIWhYRM
 nnAIxtATy9migzMkHWBXcYqXOyFIM1u/l1DKOA
X-Received: by 2002:a05:620a:838a:b0:93f:571b:c72c with SMTP id
 af79cd13be357-949995d3f1cmr927291185a.46.1795076674751; 
 Thu, 19 Nov 2026 00:24:34 -0800 (PST)
X-Received: by 2002:a05:620a:838a:b0:93f:571b:c72c with SMTP id
 af79cd13be357-949995d3f1cmr927287685a.46.1795076674249; 
 Thu, 19 Nov 2026 00:24:34 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:24:33 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:03 +0800
Subject: [PATCH v9 01/29] drm/msm/dp: skip sink requests while the mainlink
 clocks are off
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-1-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Joonhoe Kim <26rote@gmail.com>, stable@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=3144;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=2XTNsl8lmVUl+PZmxcq8gZzokrje4+P8fvNMDoxxIAo=;
 b=m8DovmvBxfsp/x5F3vUoLSaBfCNBQ8QCKr+XM1XWqDYYy90o70kCJXWDe25/sicszbL8FwV+2
 Sdmb5IADIXiDnQsUO1dY5FzR0ouQrzO71s02lyoHaIb6R55HbfatwEd
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: AxL3gt19XdRHgmy8q9p6UY70UqyDlDtE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX0O5rTjPA5FY7
 DIoXqu3dngDpL6tr4keJszWxjfRIjcLx64WWbNDLG8SWa4UIBPZL0rGZAzsd2QA2Bkj1IMUvN9J
 o2SZqr+E5XOs7YTAw3+FNQPVuIbAY84KIuaskHGkvuA8YJn3KK2kIHyO61ZLyNzj18EQyMgjmbP
 3pPpp6zQgwErWvve4AaDQFhZEVRrvpxMEN1BYkweGy4Cbgcz8G2nKehsPSLKueC+CCOuklEscKp
 V2/+stMczT9xR1Hm9FzNa/utreXLfmIDP3n5xxcpq6WDwlZHNImz3oU7mE9w+T9efiGhVh0cmXe
 3GCbZwigCce6YDyuME+LHacs2BFzHzDQqfK222++QdXmdFeBEqRGuscm7O53ljMFS/sOKeYJ+z3
 WsXJOrBCYh3bGdj+ezOOaVqIfIIyzPfUdZ074iQsw4ysIedzCyniPC248f/Fx7hvDPzqUn2FisM
 6o9wcupZXgMkQ5WZt7w==
X-Proofpoint-ORIG-GUID: AxL3gt19XdRHgmy8q9p6UY70UqyDlDtE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX5L4HfCeP+QYs
 jePOXPvT5ePU3RG5w4YGabYDCTvsnvWkmEBAUVZhDXs1q5PuM103DysWHE6JuRJAzI78MU6t/Wa
 h4YSpKFyhvUkxvm5inuTrmtBkwmxxwE=
X-Authority-Analysis: v=2.4 cv=PJ6aavqC c=1 sm=1 tr=0 ts=6afeb243 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=gFHGZmHKE-3D3zYqEJ4A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190033
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

