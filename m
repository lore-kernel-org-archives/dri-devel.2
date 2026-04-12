Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F79F3ED5C
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 00:04:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8CE10E25C;
	Sun, 12 Apr 2026 00:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AjYI4fzg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UCQ/w15O";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F25A310E25C
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:04:11 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63BNqYVh1593565
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4bBhn8y5QoX8YFD0onDk9WKnGAIfy83P1OsGlUnrCOQ=; b=AjYI4fzgpQYs8gZD
 TFvkAz41eDAdG/a8MFChS6Wnzj7VlqamxIW2VNXKOXYyPvLH/h8GG5AiRzuMKp5o
 oytOQoDk25YdQJXDo+fQw5S7KfBOrt6qdZvkZnB6wTcUGrZutrZIPwEPPclvRP/p
 CWnjGf3zm4F5FFrAluDjs+6adWYnzXxz9BchavmkL3WN3BhBNKA3spIZtlVq6YJ3
 pF6h6MY7fRUhpVA0CyStDWmH4ZmXO5zqImTBQVASD6/W7nyu+Eedr0MhtxuM5n4c
 KtLZBR2sR3cJ7HO5TflfqVNic78uHShXsg0lkiQupSPz4CmwuXly3ik1YylH1rdO
 +wg4BA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfewkshs5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 00:04:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d8e4c29caso81712601cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 17:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775952248; x=1776557048;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4bBhn8y5QoX8YFD0onDk9WKnGAIfy83P1OsGlUnrCOQ=;
 b=UCQ/w15OG+D+9/6Nx4OVVtlXdPEJtDN40k5uaIFdHicNlW1PxxFbjMO6LtRm1KIR+L
 SCPge7p5HVHYOunjszlQ29DmFE5e8yjw1eDEWFEkWgcm9/+zs14YJxJnwPfvp4r639Zk
 OJIEbhfH96MDZuCjrqEjpxUg1P+a/AT1NYyCgxN3ryKbEefCEhRjTANfQjAZvqgQ8Bo4
 z3ko/8Tnocphv8785/CprWhmYGs8eBp6OX9XW+T0NhFmtFY/BqtmMsvwWNTF8FZsuFUm
 e2aRc0UkjEIJ+4lOTQGLihBvqGIKkE5JxHODUrFXcyVFe2SvFqr4NYmCNa23iQslB1XI
 SICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775952248; x=1776557048;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4bBhn8y5QoX8YFD0onDk9WKnGAIfy83P1OsGlUnrCOQ=;
 b=HAg8R5hPi5am8NnqODSF130F/ywbcBKIPzyLdhbAHF2w8/z/KupA0vMfKmUrY5FjZM
 6eiJR5prIAIpoFY1aSyezA67jBwEUgY2Grw1HIE3+ZFZ6+zhONbDk0irph+Pp/E1Tyjc
 HUC6h7oZB/e2gM9l0LBgpPC+o6WmYDebfHKIWS+ArwBGZEJObSrURZx6eDRBYgUbM9n9
 caka2C63HjBpvEBo9TnMBRaWHbfYMNUykwQHc1dp4WkOm/9af+XLkbPvQW4y/54BSAn9
 mT57gFLv7Ljc8SvmPAluYZMMo59ihnOILkWiVsaMBHpsttuYZD4ILIJexV8c03kgTlg4
 BHaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDaBuDnyy3uIcnVcbWUJA4KTO12RoFkM/54bUPZD3zCvvY1mIYTYqSTiXKbhhimuFFQm2gXgOkISk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHTXPvo/q6QQpHJjmoyKF444MSHtapfJumvu+Hs5l6tvzJZnCF
 pMiDLSgdrqAO50sF9rBg6nJRa0AMHXGSv0F82paCzJqxEHG3K7jQkff09MNV5mC10ILnU5wFo5v
 TQEKv38Ne7/ktOO2l9n/7jLhUE19EDhAD/uoriaIXTJXLuGtb/U45VFak+1kgBRMcy3Bz/FI=
X-Gm-Gg: AeBDievGY3syJdSMKmia/0SkFemnSaRCwKfCE2XCpww5VejMLGksTxh+n368bIWoKhF
 bbO6BoomfNPLmc1lpvdwf2q+iWtxSkQr0EbxJiBjigYMSjuyVGst3wH0t5D+zPr7TkHf+df729Z
 O189Wn2gq/6tMeisI5nWExWY/3pAVkjzrIn3qN9sHcI03XiLj9L54b9RFczi68Al5vUQ0w25gO6
 fkc4fxPkiaTVoJYtigAHkslrTYduh9FJ+4Pa0SSFEXxGPHULg6+Cdc+B3oF2fhloAMu2B3FjuIZ
 L4BD6t+KO77vKNdllOYE34Y9Md/UbdG0CaKD719mMtj4fhXmBIXopvVRmJV9mEuc4SyEcSp8oqi
 rc2gbc/XwOUerPbARqp3sQkoDm3899c3g12c0U8p3bwDJWu7x0Ex5DxeB10d/U15oxiZz3xL21B
 r0XTU+S6CEaMOQzoV/ktVyRFG+Igtw8hC8dj8=
X-Received: by 2002:a05:622a:6183:b0:50b:4d80:ccbf with SMTP id
 d75a77b69052e-50dd5b77576mr128422481cf.21.1775952247967; 
 Sat, 11 Apr 2026 17:04:07 -0700 (PDT)
X-Received: by 2002:a05:622a:6183:b0:50b:4d80:ccbf with SMTP id
 d75a77b69052e-50dd5b77576mr128421981cf.21.1775952247488; 
 Sat, 11 Apr 2026 17:04:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeefb849sm1659077e87.60.2026.04.11.17.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 17:04:06 -0700 (PDT)
Date: Sun, 12 Apr 2026 03:04:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 13/39] drm/msm/dp: introduce stream_id for each DP panel
Message-ID: <mswfgwuu3x42s7edcyk2vunc2bsmqciam47nunwv3r4uylx57y@wwufxwng3v5d>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-13-b20518dea8de@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410-msm-dp-mst-v4-13-b20518dea8de@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=bcFbluPB c=1 sm=1 tr=0 ts=69dae17a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=_QCUP834chF64JV95vUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDIyMCBTYWx0ZWRfX2lVwbesz0Yxe
 6AxUs7uuOKudzBN1ZmBXac94da8+1ceQ/AvSP4qfs8qDbzfvo/XBNIhhvZK6GjY0Fke6If5mr1w
 1GL2EgMoSSA6vMVDY9r71CGO09uSirWfE0tBABfH/jqovoiwk2C7D3DaHAwWFD2PGUWcy8zHnSl
 ccHbsqPaZoBATUH6e5Ktj2w3jWuqJN92JTxM9HM6oVQHV7gjPtUV4wzqeksrIjimX+rhEZhP2nm
 +0jRUdSIprtx6vU0+VVmVpWP4xzyVEyUKSxFCkPa+7qFEm6bKtbZ/cPIWspGa4qm9xprjAJ2izl
 W4w9AEFXDh+OPZub4yChGM6FiPC2ZaH05uCoMNQ7LC4IlRQAcDrh3CR7hmSBh5G3Qs9KXJ1Vdqk
 za0BCu9j2cYMHi6P73CYwG+WfknmZG+jhBDip8ciH1SWiRF0uMeRpNqYYrYzwIa3e4QI/SFPUNp
 hDQrmv8Ox03BAFRwB8A==
X-Proofpoint-ORIG-GUID: aw9ew7GOhbAHieJpj2PiKHhsXL1A8OT7
X-Proofpoint-GUID: aw9ew7GOhbAHieJpj2PiKHhsXL1A8OT7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110220
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

On Fri, Apr 10, 2026 at 05:33:48PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> With MST, each DP controller can handle multiple streams.
> There shall be one dp_panel for each stream but the dp_display
> object shall be shared among them. To represent this abstraction,
> create a stream_id for each DP panel which shall be set by the
> MST stream. For SST, default this to stream 0.
> 
> Use the stream ID to control the pixel clock of that respective
> stream by extending the clock handles and state tracking of the
> DP pixel clock to an array of max supported streams. The maximum
> streams currently is 4.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 57 +++++++++++++++++++++++--------------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c | 24 ++++++++++++++--
>  drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
>  drivers/gpu/drm/msm/dp/dp_panel.h   | 11 +++++++
>  5 files changed, 71 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 120ec00884e5..fb6396727628 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -127,7 +127,7 @@ struct msm_dp_ctrl_private {
>  	unsigned int num_link_clks;
>  	struct clk_bulk_data *link_clks;
>  
> -	struct clk *pixel_clk;
> +	struct clk *pixel_clk[DP_STREAM_MAX];
>  
>  	union phy_configure_opts phy_opts;
>  
> @@ -139,7 +139,7 @@ struct msm_dp_ctrl_private {
>  
>  	bool core_clks_on;
>  	bool link_clks_on;
> -	bool stream_clks_on;
> +	bool stream_clks_on[DP_STREAM_MAX];

drivers/gpu/drm/msm/dp/dp_ctrl.c: In function ‘msm_dp_ctrl_core_clk_enable’:
drivers/gpu/drm/msm/dp/dp_ctrl.c:1937:9: warning: the comparison will always evaluate as ‘true’ for the address of ‘stream_clks_on’ will never be NULL [-Waddress]
 1937 |         drm_dbg_dp(ctrl->drm_dev, "stream_clks:%s link_clks:%s core_clks:%s\n",
      |         ^~~~~~~~~~


-- 
With best wishes
Dmitry
