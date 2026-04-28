Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9584FFF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:34:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F4910E329;
	Tue, 28 Apr 2026 11:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L8kw+96p";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fOc8l2xN";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A36DF10E327
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:34:35 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SA2tLH984995
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=2oN/nRVkS1oynahEcEXi/uXH
 8DKUZjrkBQc+KfvDpf8=; b=L8kw+96pOMOVax7PWlaDruPRyzLmzLYh3AeAI6QO
 fyVNNqXU3NM3UuPaZACAPDa3U7yYhuo6rFLULi6Rwjc5VN7u4L7mRaPDVA6OgZ1P
 ELLpDbuCnLDtmN3w/hqjpUUBKmDGy3th2/uoIbjAs1JbIG5T9r2eOSEK2RtzKj1K
 s2nPAsQ6d1+RCo9itSHV7K8IAERvKzj3wniAxh2fjXK2QmVjGxmlhSH6MF8yD1a3
 jPg3ZdN1th9x9GDF9jYVaZSiixaq/19K32+zABtKY5kRZuY8jvTJDMikVMBJpm+O
 khuS/apglHSXVxJqMQLEKxgpjnhxsO31KoWx8Jbp9sfDzg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttt2ra8h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:34:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50faf575af4so67194221cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 04:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777376074; x=1777980874;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2oN/nRVkS1oynahEcEXi/uXH8DKUZjrkBQc+KfvDpf8=;
 b=fOc8l2xNJNihZL9/z55/wLd5PfBSnaBgEkeW5grbsB4jVcMprrn2qTlgxWWiROMGe0
 4ts+b8Eu3JtiHQX5BQNH1woDhr3seS5tDIRQ1kHckOt8/sMNwYC3dYiqnWc3SLr2eSeA
 ZEeeZkwXOrnlpRDXwS23UoMDBn1r0bjuvToCmFLFeQKapefSXCmuGGcrCDwrqvQU6PGk
 xuxoxsXHVM2G+WcU+WQg2/oJpA2JDEZ6OqW299boXvEz+pY+nZcZnd2tBnWs6Rdz8qgm
 oJrb/xhGWpHbPtWBJonojzAaJRm9RwSP/umk5jJDP5JSzJW0/yA5m9ljTrfx/8XkJFEq
 UXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777376074; x=1777980874;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2oN/nRVkS1oynahEcEXi/uXH8DKUZjrkBQc+KfvDpf8=;
 b=PogYGRrch6kVbcGTgf+kPfLunD3ymJMhcsZcipUETZ64fv3Wwkr1oY4X3wfwookvTJ
 S8piuquQhSV3BRfBoYj29yjzaFI3N4melgS99ipOGAy+NkA/p6HAY1oJkyUmvKF9Zb15
 uEP9kObps95L4js7Q/MgHvBeUOqe4RWFP5Rb/gbCin3UXl+iF9lSiKIEg4PoDgoOdSCj
 23Cggmar6Rsdu/Q8cwNz8At2dvrCrXWn+9ZbuShxLCc9/JMqNf0dnSo5YF+11N5JxDMB
 rosMlzOuSpjOV7/5yVUY/kus5s8//57jr8Onw5cbECK/XwCmJ08PP62Jm9/cwN8/dbN4
 hiKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+15E3SXa+tN176yionObkN+4+71LOB0P6YmZtIJiw11O2ZpaAmGKBnMfrgljtsu5aGkdeuaylkO4U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxlvshX+dZ3k9qlLlcwO3V9j2bByMc9FAXuIdBoWo0Sj+upk4o
 BNTk7Xb1uCXiE94GCDSb26TGT81xdg0MEEdixq1lB/ZGe75mp532TXHARCkNKBSyPH1zxouM4Dm
 kXx3x4dXT8psdhHpkIbcZQpy/airK2e2L0Lwx8ONMRRHAY76hsH1CvL6CwMkqj41L65H0Soo=
X-Gm-Gg: AeBDieseX+PT0Zhva3Qg+aeeazRqV0l6iX3qEKq7m7/oB7NfY12GOzk3iOmEBSDLa1N
 n746ckPQ823mr+P7+tyQKE1emHZOV7fGjkILP8E3ZqYMfmFMv5dTICm/uZGg68fdmx8l4qoPlOI
 ms8a1AlTWOPZWaRSfyWydXU+kC4LjgzURMEMF0/mMuLCinVPeJQQszMZ0mzmpX8Wz6jGn1jzcAZ
 MVB/Ah4nxnG38dLbzDko0TWOUX0C+yywNNo/PUe32+nNZiWs6Lv2nWcKf4tTOa0S9Gm2EuXssz7
 eIgcBSx848E7YSanTuQ2U5Kgk+GcxFbVqh2OmDjLOmLgo1S++9Y1DckhB9LcB8/mAwGtov/O1I6
 /Ou6Z2vt8lYibvBOlH4HS/gwuezvR+hTFvAVoglcUCtnW+BUMY8SjaFPyAva0nTNCq+w4WmAxeg
 KWB1UCTnen/ZtFTf+1a2lK8xhTAkFovk9Pi5I1ULI80p/mjg==
X-Received: by 2002:a05:622a:4a8e:b0:50f:783f:31a8 with SMTP id
 d75a77b69052e-5100e19a66emr34473241cf.28.1777376074066; 
 Tue, 28 Apr 2026 04:34:34 -0700 (PDT)
X-Received: by 2002:a05:622a:4a8e:b0:50f:783f:31a8 with SMTP id
 d75a77b69052e-5100e19a66emr34472571cf.28.1777376073577; 
 Tue, 28 Apr 2026 04:34:33 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a74640b51esm540937e87.77.2026.04.28.04.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:34:32 -0700 (PDT)
Date: Tue, 28 Apr 2026 14:34:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/11] drm/bridge: adv7511: switch to
 of_drm_get_bridge_by_endpoint()
Message-ID: <6xeo4ctvhpvnas53uptyzyo3uu3ooydchqbv7u3eradrcb7r64@meatvyekusg5>
References: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-0-4300744a1c47@bootlin.com>
 <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-8-4300744a1c47@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-8-4300744a1c47@bootlin.com>
X-Authority-Analysis: v=2.4 cv=HbIkiCE8 c=1 sm=1 tr=0 ts=69f09b4b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=8rJAFfykPjGPsRQMFU4A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: hd20zFFITzrx8E8_Bn0dnSJSSrU9-ac4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEwNSBTYWx0ZWRfXyiKBUvy9QFvp
 oeT/uhA02VUY82+ExCw8rhBFOvh14j3H6Y2OHFZAWpjCIGnhYzxE6UrxEKcXWRot9CP9UUVsZKH
 KKFA7Aqk0VpHT5iynVWu6YQi8rFjozz7iB4t1Qh1zi2pytS5WMYzqbdVDQSL4XRVtd3oATLqf3g
 f0lepOLoBi2oedBD8kFu36+YhvQQesISKGNQv6PaZchDQT10+iHeQo7Txw12BGuewwSxO3EDs8J
 ohN3eAgJ569DkBZk7Si46MYPf7w8+2YZag/6+XkWRJgDuNrQpaqHlDKaAygu7O87gfXTfPo1Xf4
 heoRFJdGwkmjDnJJqxhu6jPT6TMd5+BTLfXMiR7HfO7anGswyFFJmQDQ7xSjXVeFLsgNGVsHGJE
 qfMfS0zjXtcZ4HvRu4zr2sLW3+sq4HozWDI3T8Dir1msFfYYAdFYWo3mW/XFfMnTccbBeyj/0AT
 Lty+pbpO8cxG3bD2KJA==
X-Proofpoint-GUID: hd20zFFITzrx8E8_Bn0dnSJSSrU9-ac4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280105
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

On Tue, Apr 28, 2026 at 11:15:54AM +0200, Luca Ceresoli wrote:
> This driver calls drm_of_find_panel_or_bridge() with a NULL pointer in the
> @panel parameter, thus using a reduced feature set of that function.
> Replace this call with the simpler of_drm_get_bridge_by_endpoint().
> 
> Since of_drm_get_bridge_by_endpoint() increases the refcount of the
> returned bridge, ensure it is put on removal. To achieve this, instead of
> adding an explicit drm_bridge_put(), migrate to the bridge::next_bridge
> pointer which is automatically put when the bridge is eventually freed.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511.h     |  1 -
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 11 +++++------
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
