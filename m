Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D11606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jePkFgnE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KBeh/nbB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 343E910E413;
	Wed, 11 Nov 2026 14:25:36 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BEE410E413
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:25:25 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABEKWvG3510916
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=QHCjyWnjJaKib08TgPofPSfS
 5d3rT38/26nHs0v//to=; b=jePkFgnEVX0RULsrw7zmearAUw+XslMLC+QTiA2O
 o60WRQj0rvP3SnpnYwb+u0ng7t7hYvWzxKPD/o+kBmTC/A9uTqERoqWqhXnaedWv
 r9vgws8gvjJ8fDVqkcyYlAdg/A57SaHbLAlitobIXU6jQwEubzovDYEb05eGTBg1
 XKEm3Pl1uSUQGtJva7dqwXd+D5syugIMtQrST3tvkxyZCeuNpB8e8r9W0q1neT6o
 4dsHbdp3vow2qJoGgko3MDouSocPSajvW7k5Lew6FoJOv5YYB3/JUviR9hkP39Ch
 IZhHMLFKeBKURT2hVkWgsxcq9/JHOBkgMRMcveJqouttlA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt1u80nu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:25:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cbf2fd504so620157685a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 06:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794407124; x=1795011924;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QHCjyWnjJaKib08TgPofPSfS5d3rT38/26nHs0v//to=;
 b=KBeh/nbB4NMU844ykeCcwRYf/p2VU7mX+UnyZfPdQ+QXqyZTfLKK0o6YriqD0rkwi8
 tsbq4vUb/Ie66cR2LxSxG8iaceUSWlex2/2CINZRsee9yTLUYIVBPMcw/l2q0Ezk58R6
 nIMw7cAnIuid/J23iiL2WyNBuQQEor3Gk6XbtURh5xWrbi+WdJPc0pADSZQA9/2owuap
 jZ5x70YqCpXYELv9j6pdt96sDjpY6sO/SMegleM0zGjzMAoF+d9ORFrBPkWzEzSXBcBr
 kGDGX8X+wxkTLl0m/hI4zzjN7mZzX4ykLgRLknY8nBRJ9MdT5kldCyLmd7UsmDaMxTnV
 APJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794407124; x=1795011924;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QHCjyWnjJaKib08TgPofPSfS5d3rT38/26nHs0v//to=;
 b=ucZZpR68spV+2wgk5Q58BBosZ9rjGSnJpn/V+DSpUADUfRCbOq72QwUDJzXlWAIjfv
 sNTZoMJyM7jOCM1gEA1RLKhAh91XD2MCKGTt7z328oEfnXYcX+JpVL8RFwkz35KrWvZL
 nOgGwpa/ONmKTfxak+/XeHxBy9n0f72lObQrsq6QImoVWpdYC9BqtVwogrRaPCvWp59q
 3KIlDDNo6shDgqlH8XGLxIhx2cS1XNQkUMFQtK/hFIMlhF1gNPVrvWDsEV4cO4GTdU+L
 saky0i8HVZ8NUHeYJ5ODEHvn/bLBU2N/r/NLZJ7KWG6w1HI1xnPYMgFl97jF7dFUctuC
 Bp3g==
X-Forwarded-Encrypted: i=1;
 AL+hErG9lh2GqD3jkpSE7uMs+2OGBs671pJHpbuEGGPQ4TUOq32hC94ABg0TNRh6rUxddNFRcfiIstSgwk8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/wQ20vAEOLirtmEALlx1bi3pvf0qS1zCeVXWj2tZPZUaq/P12f
 D3miCBN7uDp0Tax5OR1KbrkFBkJ+4AsrWqvfzHCb2feNO/K56fWxcO5unCpqeyt28urcqV/g486
 FpYCDHuEV87LP0mZyI6g5YrlxtxHNoq6TngV80hGBQdUmDFazqmPucs5qY8MaxzeGp4QuT6g=
X-Gm-Gg: AYBFou3itclInQgLjBrRnYvQr7Y834qb3+8umHTz3mI08yyoQ25jebJsWhTNuXYjq9f
 lOCFkmRFliohItCfueDw+HEsdm96vezSZJZZWL32FNPwqnbMM5t8cwCMERNREx2EJJRpA3Mxojm
 58JBNPlbRxT+vLPPAzeq2MnRLBGN0/xpYl7Da6wc60UilpPaB2yW2yOcWHfiFi4RsTkGMj39lD5
 j/FvoBvpN5YwTYhPIP5AfxwqdtcfBfxhb9BjBEkQSP/cuVihPujsRVWNSGRkzFR0rYJZS6cnQSD
 I7dVbse1YJDEhgHlZUeMSCqCrVgETgNFUmtJY3UHZkb1D0+g5XDEz820EAczGJZxGICXXNucfCh
 LhQ9dXyG6z7TO9mGr2Vk0rlg2ODfx8dvRhSfxsXiQ86tTDOpowuqJ0sCieYYrPINmgcfzbOLt9I
 N2rPdLBb+F/aLs52fjPcMZvuE/2YKMne707NnkARrA+gSlEilOk31lnzl/XkUd+A==
X-Received: by 2002:a05:620a:4711:b0:93e:5daa:67a4 with SMTP id
 af79cd13be357-947afd6c994mr406652185a.29.1794407123485; 
 Wed, 11 Nov 2026 06:25:23 -0800 (PST)
X-Received: by 2002:a05:620a:4711:b0:93e:5daa:67a4 with SMTP id
 af79cd13be357-947afd6c994mr406648785a.29.1794407123071; 
 Wed, 11 Nov 2026 06:25:23 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c15bc4a69fsm552820e87.84.2026.11.11.06.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:25:22 -0800 (PST)
Date: Wed, 11 Nov 2026 16:25:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Joonhoe Kim <26rote@gmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v8 01/29] drm/msm/dp: skip sink requests while the
 mainlink clocks are off
Message-ID: <ldg46pmbkt2ntfpmhdgu7hq6va7ljck7o7pua6rkkkuij5b5c7@dqhf3ozkjoom>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-1-d040fb33db5f@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-msm-dp-mst-v8-1-d040fb33db5f@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NyBTYWx0ZWRfX1hDhZMjXv1n+
 cCdhz8H09muU2d2fOggf0BkYMyq1GoEyZaMXcxHm/M+0k5Re8pRf1ZFfUpktzercyFipRlIDrtE
 QwEJQa+XGxzX2K/D8R3MT5TcGjFLLPY=
X-Proofpoint-GUID: EHw5uqH9nsy7aVlffTGF4AfkMymVDPzf
X-Proofpoint-ORIG-GUID: EHw5uqH9nsy7aVlffTGF4AfkMymVDPzf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NyBTYWx0ZWRfX2VVRyD70zZoG
 DAkSYGwfdtDVEpQ/4Kp9x7iFbRNW8G0Devz6OLFLb6grreyYiOAEjGZjk3cmFpGyYLKTKZzs1Wz
 YGfDhP+5O6igf3jhiK/Ppw6oRXr+QDh9dYAgS0sosW+3LHPiwVUmZg2rBLHPhGNRXWa/1XIBUjR
 NtiTh7Z3jO8oGmTksHdk22golUpTpz9axFhy6jGedQAIgS6KZEUilMQKCYPdhoYtk2FwMql9rpF
 EaLuQ6YOLMP8XTt8PbOqNyfdsVJhOfLR0/AMnOM6tUJJultXliIv5oOpZlrMVkvwllOdavWlmKR
 w8Lhws018069eG6MkYCQMP1rBGpqBgdi9BI3JLsQ0pHSBgGYoZa6JR3lRxJXbW+B/EJZNsy69H0
 Or9TCGEIGh+aqm7lzfjwE2BbnDzaXVZcKHLKbEKxAujiyp+7S9SNPbXkOlKF8fz7wxNVlPHR03r
 aYvcQD4e25IpU1MhV6w==
X-Authority-Analysis: v=2.4 cv=LvcHWXdc c=1 sm=1 tr=0 ts=6af47ad4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=_QjLU-fBZjFD5OgerkcA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_03,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110057
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 12:54:22PM +0800, Yongxing Mou wrote:
> msm_dp_ctrl_handle_sink_request() programs REG_DP_STATE_CTRL from all
> three of its branches:
> 
>   DP_TEST_LINK_PHY_TEST_PATTERN -> msm_dp_ctrl_process_phy_test_request()
>                                    -> msm_dp_ctrl_off_link()
>   DP_LINK_STATUS_UPDATED        -> msm_dp_ctrl_link_maintenance()
>                                    -> msm_dp_ctrl_push_idle()
>   DP_TEST_LINK_TRAINING         -> msm_dp_ctrl_link_maintenance()
>                                    -> msm_dp_ctrl_push_idle()
> 
> That register lives in the mainlink clock domain, and nothing on the
> IRQ_HPD path guarantees those clocks are running. Disabling the
> boot-time mode for the first modeset from userspace turns the link
> clocks off. The sink answers the link going down with an IRQ_HPD
> carrying DP_LINK_STATUS_UPDATED (DPCD 0x204 = 0x80), and handling it
> walks straight into a write to an unclocked register block:
> 
>   [    4.572532] [drm:msm_dp_ctrl_off_link] disable
>   [    4.573756] [drm:msm_dp_ctrl_link_clk_disable] disabled link clocks
>   [    4.823194] [drm:msm_dp_link_process_request] sink request=0x80
>   [    4.823199] [drm:msm_dp_bridge_hpd_notify] 128
> 
> The board hung on 3 of 3 boots with a 5120x2160 SST sink attached over
> USB-C. On the hung boot captured with drm.debug=0x100 the printk ring
> ends at that last line, the drm_dbg_dp() immediately before
> msm_dp_ctrl_handle_sink_request(). In the RAM dumps CPU0 is still
> running pmic_glink_altmode_worker, holding the bridge chain mutex taken
> by drm_bridge_connector_hpd_notify(), and ctrl->link_clks_on is false.
> 
> Bail out when the mainlink clocks are off. All three branches need them
> running to do anything useful, so gating the function entry costs
> nothing: the first one resets the controller, which its own comment
> notes "will need DP link related clocks to be running", and the other
> two retrain the link.
> 
> Everything else reachable from the IRQ_HPD path - the MST ESI handling,
> msm_dp_display_process_hpd_high() and the video pattern test response -
> only talks to the sink over AUX and keeps working as before.
> 
> Reported-by: Joonhoe Kim <26rote@gmail.com>
> Closes: https://lore.kernel.org/all/20261108011501.4466-1-26rote@gmail.com/
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
