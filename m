Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444DAC982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD2D10E629;
	Thu, 17 Sep 2026 07:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jM0LTGhB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QkIhIpoh";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 445C810E613
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 07:57:06 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H611SQ902553
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 07:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=lfK6O+zMpXERRjdHBmWSSBz+
 u+TgGQ6sE1UUefUkAxQ=; b=jM0LTGhBqiZQnAdmmU7SC78sQ8UqcSYZ3ZbnQ0dA
 6wkCDrx/J85u7IpNx38bKy08RqCQ6AgN8mcdVpkVRirISdRMDIj0g1WpfbnEuzCg
 TZ8OZCOXUCtFHaR/j9Ai5/NYaD7d8/1TgGfKXqh5MwBi0Zp0gBII5d+16RQLsSuQ
 yG9BJJgPkTdq8mIAauUOs129Za7ePO0Q88tf9Z1c6nl5CDennYGDFw5QksFeLhPN
 RrCF3xp8ccVMnU8qhJlL+if98S4hjsdhSydJzNfCe4c63+yrlOUCbVpLTPuuIFSQ
 tdm+RjSYmQTHn4EIsonAuDPuvJNc9I6gTj1X4IXw14si9w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy2d392p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 07:57:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-939f248907fso53385585a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 00:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631825; x=1790236625;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lfK6O+zMpXERRjdHBmWSSBz+u+TgGQ6sE1UUefUkAxQ=;
 b=QkIhIpohIgJfHRxIx5umW/ESLi7bplybnDdQLrRw+55F6ap+YCM5S8qODDSaYUk9Jh
 FBljzthg76tIMzRTy8RkODfz18NylYBEa28hFuJT3dL4DrANxV0jDdI8ebL1tbRJ2I1w
 xDx4dCKxbJuAoTo43OqbLDMKD1lHk/92hgueemSNTS/1Jx69Sy49GZkxdoZoCp9V0IYJ
 Sql/KDRDTHcyMGdN5/Sti4zfX9JeQz/BjvTGKqia7sNkR4MrCSZQIoYw6tw37g3AAvOu
 y+aHTpFsir8dQjxt9fS2lw3c4Ypl/6JjSlGN7aLj+GEK4tZWJP2c+599lJLahBWtOR1Z
 M7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631825; x=1790236625;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lfK6O+zMpXERRjdHBmWSSBz+u+TgGQ6sE1UUefUkAxQ=;
 b=t5bqtqNT+B/WOT00ClNfCVki+MEzHGxcuN52L79JP+t42pefFhFuLf1xDKUlYX34Kq
 EwLI2pbd+ulbvF3+Pp0qMBCeLthliiQjHC/wfAQ0AEGTmAaSMY0fWIBqslbYGRJAdPhn
 hJpbivIWiPugiL4pyf09p5D7Le8noeY0YquIdh1l4HVSeqrBSpeKsqwSFIjkjBXFte02
 faMA0WSn5NppRD6QNxB5DWjYeN7ApU3UX+8DUuFKTe7G6ck+Ufafjm0B5H2Vs4e6yaYX
 uQNmnGiIcg08/jrzF/xGjpMD2O0ottbT7f1rdgyV5z9RrtaBMcLFxRC5CWjW8TTPmPyc
 OTLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqu0SQafmVzPzxX8o9P0KNT+pvhxsqcvCrsXy3ufPlniB1aB+0PCnOKDmvrPVGIqdIGoeP6WHZaeE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nDuhb2aVG+DsLb+GGp7QH5yrXqNUhrPwnsh8PM+0E+igCDREgT
 PJA5l1DlT92HODNUuF2NxdBqoVpsGX1bCvRNKeb2PuHGY71FhfTSKEnJbwa10YDb2banptnCtNM
 P8ziNmWCKEbCd+e4lbV4rCRtVgW6axRA2N3a8mYFF5ozmBTgc/2opUkR8EIXrs9fRadNxgbA=
X-Gm-Gg: AYBFou0ywRZXOQHGApcfmIDL8RSr8Bxe30RHSp3ahp01QCa+pUwrEAB+dsxnBf1pmI+
 gIKZFmI+Dr9h0WIRuQuHqAA5RNkYNJ5ZTshAn5Pb6umBDQbH/1Ft8UcMGIaDrfvLMOjQjh9gZDC
 ga1PhZ27ImM9IoDB8e+gFa/RHJYHUMZGV46n8EmZNuiIXuPQ+fivHfi90KNYAMoSNnyZlWj0HI9
 QmW+DqZ64Y4NQY2pljeocMQa2cghlkKe760sNkSsPrN8v985NrdUR+oCyXyhw6D46AX1gXaTkBg
 5/UVoHwT/bahtt4H/pkqDAPkypWfaK4vbNflVvAFMVxcH6MTVapzn+9eUiLmv+kO5BWHtx9/s6a
 YPouSSADyGPyn3pxTxvNaixxZEreo6NcelVmzGw0LjE5V7Sk5LgAy/zF0GAV1m+vaSKTOyx/jBu
 Ba2yhv9ccDULqB
X-Received: by 2002:a05:620a:8008:b0:937:675e:2903 with SMTP id
 af79cd13be357-93bb77a2402mr929854485a.14.1789631824656; 
 Thu, 17 Sep 2026 00:57:04 -0700 (PDT)
X-Received: by 2002:a05:620a:8008:b0:937:675e:2903 with SMTP id
 af79cd13be357-93bb77a2402mr929851685a.14.1789631824173; 
 Thu, 17 Sep 2026 00:57:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8b57e7f5asm1576430e87.73.2026.09.17.00.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:57:02 -0700 (PDT)
Date: Thu, 17 Sep 2026 10:57:01 +0300
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
Subject: Re: [PATCH v6 01/29] drm/msm/dp: move link-level teardown from
 display_disable to display_unprepare
Message-ID: <rx6n4haa3y6m2ky7hretbkynevvvo3yj4so3nxc356ir5dqjtc@44ank4nkueiu>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-1-c91d35d6fb9e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-msm-dp-mst-v6-1-c91d35d6fb9e@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: qiSCTITltyn5EPZEgbFl2QCqGbuHoSBJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNiBTYWx0ZWRfX4J8iVHW+g+LP
 zCSLQiw2Vm0lxZYAAi3mn61ba/p0WsNMbDu7tyjLEPzR7WP/EYqQdIIpEEU8fKYPnl1JSt9Ft8P
 xwWyIEELluhB8ORtv2N+0k1GgY5Zm0Q=
X-Authority-Analysis: v=2.4 cv=HbeB3SE8 c=1 sm=1 tr=0 ts=6aab9d51 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Ull_tw8qIylx0EAJJFQA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: qiSCTITltyn5EPZEgbFl2QCqGbuHoSBJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNiBTYWx0ZWRfX91adY4pQneXN
 I2GqCmmTBDKH4fCjRUnqObx/DRnnU3cANTbwVCfxr+5udNnFkSb1PdTb91B14Lnzk3NpNHP+qCs
 Eru3/G54q81em/blordlppLMQuH6H19k8WykKW7rgeh7LsSxfVe9aEfXZB8JBA0RUMK8uTyIGhW
 ADHFPqMVBSadID+2RRPN+99Pre03TS82AcbeKp1vSBPNJTXf3Aq7J6LsVbJObJ46+qhe3E/nVK6
 OVatOiNCC082IYM653+lqmoz0SigW/6H7D3hVUU7V4SbTKdeMmAJtzTyLXLBexv5AxTyLynF1He
 miNAO78KDJNrTeR2RuZv0vWoL9e5E+pRmgZJO4EbLwIVo21TR3nqQF0kyyqRgi1l9sjlloe1Riz
 6X8xA85PMMJK6pSbF7bUkvoTxxTlaHEJy6OrzgQtcrb7CWCTdYs0+W/psG+Zsco2BbnSDJaaWVS
 pTESmaiCH8K+nuiLrdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170106
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

On Mon, Aug 31, 2026 at 04:17:18PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> msm_dp_display_disable() currently mixes stream-level shutdown
> (disable VSC SDP, off pixel clk, clear power_on) with link-level
> teardown (PSM config when sink_count==0, off_link, PHY re-init or
> host PHY exit).
> 
> For DP MST the same link is shared across multiple streams, so
> disabling one stream must not tear down the link. Move the
> link-level steps into msm_dp_display_unprepare() so that
> display_disable() handles only the per-stream sequence, mirroring
> the split already present on the prepare path
> (display_prepare_link vs display_set_mode / display_enable).
> 
> SST behaviour is unchanged: atomic_post_disable() still calls
> display_disable() followed by display_unprepare() in the same
> order, and the cached dp->panel used inside unprepare is the same
> panel that was previously passed in.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
