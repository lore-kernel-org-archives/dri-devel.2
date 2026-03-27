Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EE810F286E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 19:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AAD010EEB6;
	Fri, 27 Mar 2026 19:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vk8fiRlK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VXER9PYb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5247510EE9A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:26 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RI2rkK083491
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0NBxv3dflNkSsz+AAfBWMPtCWgCqTxo64qisEz+A6Qg=; b=Vk8fiRlKvmwobiiR
 dSEK6OBj5xWrUpLiZtvx+0TO++e2CUWBB+bs7JHZVsruoA6CVh3QZAVUuiuQysaH
 Af7+/PUBD8fqqoFBx7VqOR/8iRbWVRW4PXFPsueG8iK9+ZUh1oMMwgVxEXLoGWB0
 Q6R/y/nyKcXZEv0rdyx384ec5uJF78Cqd34hGuJki2/Ege0mB7DZHTac224qs4fM
 8yOtBKEHp+tZcRzPfooQnA2UA9JoM01itTK9dvs0nP4CubkFKxwbj90B+DdX0VKl
 4fg3i4k0aKz59PmL/Mw1LnOenIq2jmO0x9eBAW59OI44CNpCnNf7NFi4JXPyt/jd
 D7AQoA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5jcx39u6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:48:25 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b220c72bbso86268641cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 12:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774640905; x=1775245705;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0NBxv3dflNkSsz+AAfBWMPtCWgCqTxo64qisEz+A6Qg=;
 b=VXER9PYb/2EDft+5RgNQZbCBv3BfLE1/5Q79QAM1zxkKTN8oAYxlO9V3wTTw3vTa2K
 G29kKfoUs1rKRoi2iqyYX2OY0gPpYOVW+UqlQP0CrTYhE0/2PjvZ03QcgcBA4IsF0GXm
 jzHhfFY/N6uE924GdTHrDCbUjNgC/PS7sPYiHJyfACmSiuZgsO2Qz+EdYmo6BS+SzS2j
 DxY8kC9DCQVxijU5Sa0eFd/9J8u23Jb/pTjr+wPVKJz99R/o8bP+arBPSSsuA4rusBU+
 vgR6kMyiZqiryNJVSIQJ17Wyk7dL4wbuGLKZJN3xokUaPUBW2dCM3jhpVs+pmWPxP7tq
 SK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774640905; x=1775245705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0NBxv3dflNkSsz+AAfBWMPtCWgCqTxo64qisEz+A6Qg=;
 b=WsWh/SLoMOlHpS6CzJfGFQEInzctMFdak8MbRbuWwwRiR15mvygM0apOpE45eUf3Wn
 OePabtGvaHDtYSIt7q7XqTQKQCXavWSHbmdhgVzLwGTEijmnKObYqxSwjmE5Bfp9tLqn
 /Og9iNpzTc1vlweT8+QpvWkDdutQGDyCzJTCpeWUz7Sc2hZnDOa1hlPreJM7b0vAF25u
 7iPQZ7oVsZ/WL4kvrqZTMQa9+u2IQfQQrNM5NttFon09b89C/IDXtKVK8+3N9TLfFbGB
 zviLsCowykivRa5dswQZjfFOLbEnYEtYNnNlzGqwNxo5X77vnaukcMYuqVyp/VJ0rtsU
 mW0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqje6dcpVyQytep0tCWkAXTFyOE03Q+XJT1x+TsK4biGeZhIIGRgOLNEk2q7vuvvIbTXwCUNf5Caw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6vHpkh3We+6iDSmmqEspfYl22e4J+RJBEUVf0vapIaFce7Jqe
 6dS/waRkDji7x+FrcUVXrtbSXO/LYTad6ehODOwbvXvSvW9k9mWmCZ+xc3se/M5GX7DD6S2i7x6
 1wucJqEZq95bwlNybMLoXK1TieA4GFOtO0KJnmcCJxuL0KNHMu2psDFjLSlp6eeUKO6lR8Hw=
X-Gm-Gg: ATEYQzxkb0GJURCcQ1RK1/ySoDUgMb0MM6hmabRR9rDBTPRBQ/obp9xXOTF4w8jyzNs
 koTx5f94ie0J5cn3QfDwZpaBC1hridzII42400+T7aJiOWxTZqIvItqVTEOCEmwjYr4C880YF68
 ThQUEJWUq66yKDIOI9uRWsHvpYC/nDaIkPl03ta94g7Utmh7kYyaC6bPKdHA8sxh2Gj8b0402k1
 1iHkGdcjnk9N0iqrR8z/5HzwLc1C2hiUrsXCsOfD48XhtTFP/Hjs3BAdLC1dReSl7CG9umN54z9
 0+2Ljm+qFOR5cfmQqWe+4wltD3CCjDb0SGjWfA2jaFvmglOUYmhoX7VT/ustkUXOe1L70rJ59vJ
 6wZ+yxQhDkPQKBOuGQ0hPSjgaQu7eml3MZbn1epx7H7pvLObEralVVmHkd/NrPW62kmUdYU+B6c
 EziTkc/UpM9xJs6AWzHaiMzdgPT9Unhe3q
X-Received: by 2002:a05:622a:1e0b:b0:50b:3ff3:f4a7 with SMTP id
 d75a77b69052e-50ba38c9968mr50882791cf.35.1774640904826; 
 Fri, 27 Mar 2026 12:48:24 -0700 (PDT)
X-Received: by 2002:a05:622a:1e0b:b0:50b:3ff3:f4a7 with SMTP id
 d75a77b69052e-50ba38c9968mr50882521cf.35.1774640904405; 
 Fri, 27 Mar 2026 12:48:24 -0700 (PDT)
Received: from umbar..
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c837130basm275211fa.12.2026.03.27.12.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:48:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Pengyu Luo <mitltlatltl@gmail.com>
Cc: kernel test robot <lkp@intel.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi: add the missing parameter description
Date: Fri, 27 Mar 2026 21:47:53 +0200
Message-ID: <177463970820.3488980.16274935490994243926.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309100254.877801-1-mitltlatltl@gmail.com>
References: <20260309100254.877801-1-mitltlatltl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NfTrFmD4 c=1 sm=1 tr=0 ts=69c6df09 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8
 a=LJNnJWuWgWF8sx2EOesA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: FGsoeKQEOFVnAztymx3y8LN-_C2jeoCe
X-Proofpoint-ORIG-GUID: FGsoeKQEOFVnAztymx3y8LN-_C2jeoCe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEzOCBTYWx0ZWRfXw1CwXJCFJNna
 KEd7ElmC17Y10TIfDO+d+58/biwdqmkoE9ORh3J/D7vq7MbzCnuDU0i31yFW2YOn4n3KtBtty5G
 e87uKnJ8CJpBHCjq+CfxmmOaawKSA94LcXJjzcK6RD0tAw+3uA5RQ37E8slBftlkEXGiHsFAdV1
 6h5e2ZFGDxAAZ04R6yaMOl3/Ix1h545nGzZPdRfu3zpqj7N1X8uC3VHXuciP1qcIScKY7S1FNcv
 NDFQtB7YfLwfdQhNUmZcFdm/iMxbzvWRGYuuSSrjVhyqXh0SQ+dahjcHB+mfTrGzOY7UPsSSc6X
 iQbhzQP2PCyjhNZKpa2j+7IwzCoJMd3WUPAuOM0lZ44UtFpA3okThtF2mHrfBKqPV+QsoywG9jz
 /0IXrW889plgFRWWMYJyyRvfaiL7sUZNu89UV1znKPKuYHJywbTHUQq02264+Jx9xNhuV9pBK3W
 A4t0B9RiL2rqttbiYfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270138
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

On Mon, 09 Mar 2026 18:02:53 +0800, Pengyu Luo wrote:
> Add a description for is_bonded_dsi in dsi_adjust_pclk_for_compression
> to match the existing kernel-doc comment.

Applied to msm-next, thanks!

[1/1] drm/msm/dsi: add the missing parameter description
      https://gitlab.freedesktop.org/lumag/msm/-/commit/958adefc4c0f

Best regards,
-- 
With best wishes
Dmitry


