Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD87CA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A2BE10E4D8;
	Sat,  3 Oct 2026 00:47:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VrauKjbT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kl2KHkyz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6077C10E6FC
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:47:02 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Ne4Cv2928154
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FNKPeOeJtdaJwaskI61OzrmziGwa6U3Z+vrqhZPHVsU=; b=VrauKjbTTwYXqkVD
 TsdUCpjaYl08YKzc+LMrbrTusxasGKlMI8KZEjsZEMGW6hef6LdA+Gh5jdKQyh1N
 ILTbVCUZaHlFqJoz7BISXOIkRM4crqQoXc2otqT5r3LEGss1jmAn5zX9sNwUjp77
 Q4kxSQdoyMN59H4FrwGMsIZFjvH0LcgMvGFCBfjyDuzERSdsh/T5z5bis/Cf60Am
 ilyfbaczWYfgAxmLW+Ediub9EQ8nsKFBacLoQBNgtUxykw27gV0EQ5g0K4Pxg/Mg
 LM8GdioevVYJIFJXWZV2veIVcwQt9xOb/X3yGuySmIQ3SVkwRHnKT85YCZafrlue
 gS82Gg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20nfvvtx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:47:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93c58ee2116so27159485a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790988421; x=1791593221;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FNKPeOeJtdaJwaskI61OzrmziGwa6U3Z+vrqhZPHVsU=;
 b=Kl2KHkyzPgB4takjfb54suu7eNmeR++Zfn5p40Dj/wWfR8Y+mAcd7u0u059ol75xS4
 N6GQXCDtK95zUZeoYzfA05yfh98yRI58FTO9HzfNM1rZPMEvInvKXp0ydgzsHZOXsvzE
 xSlmqDWnRgx7p6ghbB23hUVRUZml3d8NRJzqwIlhpRi9H3KmzC1aOOyLb9RxmXi+R5LO
 vKstoUZwC0DRgxGUtPe58HYoJ7VIkGKDfeXvo0bll7vUnO2ThIAR64qPEzYmm/YE1X4S
 oFYP65bJO++wsNwdCo9LTcg5DqEEDu57xq2aR/+GF8rDjwv+I1oxwoCwgl74rvmZLdR/
 14UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790988421; x=1791593221;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FNKPeOeJtdaJwaskI61OzrmziGwa6U3Z+vrqhZPHVsU=;
 b=b4P0r5sjHJ3xsdadVHPLc3waGtXY+0huyQJZ2Y7Fc+hLYNS5f/hvmWzPulPtYF4pRY
 7mn82HWbXoukapT5Isu7ccSdZkJgUO6Uiu67foZqEhtqYFdhfw4bSo0GViaOoOm8W358
 NHRwRK3StaZs4yvx7bHRRhmsA5LJZNTx3SrAvXKhA/jteeW4g3K9j2CtRRfB3ULZYlTv
 AXu7iZmnTnhnQBQM8TtLDn5Z0t+MIj2NR/ZqZJGLKpCKuzfAo6jM15rthGTWfVJhMsSK
 o1LfnS7Eh+oTbsuSzlx79jxLb06pV5FqippHUBKa0rts2CqXJEAa2ZUCfamSdxYPidJT
 cJYQ==
X-Gm-Message-State: AFuF++m2TUXbVuB2NvQiR4TgtXe5VqKP8nkWimqEWsccQtWZCFUFNjuz
 gwOfJbDQYM1UaWEkD3EQ8WpgwXq812lTZYEWF2ywRbKVd5O9w6idfnYO9kl5B3UdqKdEqmWi+jo
 s5c4pBBd+S4O6hbKLC7TtangSGRx+VMdH9vw4fRwu9CPzTbWAzDu/4y0j7/sqC1kjDLl5gxORQK
 MCOaw=
X-Gm-Gg: AYBFou0rvmbapPhLsBJrwhWdujRim5OE5RlrK3MnSjkge+k++bH6+gjv1ssZzmmVO04
 bSk2ms/w/QjrVRj56luZKaDJGfFBP3gXXeUGadb+IJG3FcyghXlN/Z/5lUpsVEiEVzwnWpq0f8P
 yJzKdgr6IVi03G1AHLhrWq/JRFuEukDGrwOd9mZ4cS5LSzQsIP2bFE55QIkiKZInr6+tYKqakU4
 7T5uaDG/Ib663NVnMOZEuu9pYmE/UOY+jxK0EdGIrT2KZ/VJoxE62Jm6uduzcRmk3T+UxWHMLwO
 dy8RN3sP6GpEq6pODJoIbdGihvFL6IvvRZeIMr3S0qkSND5wn0GRYpMuLoBdIO25N0x7ZlzgVf9
 JHLMzMUWIBV/UvVzv7sm7A/X4aFNkFlokIbe+SKfxFWhYWjB+Ixy3cxIpa+lcyuHFrM1WaOhYjX
 uY6GCwN9FD0xaY
X-Received: by 2002:a05:620a:4397:b0:93e:516e:a8d2 with SMTP id
 af79cd13be357-93e516ec2f0mr203570485a.4.1790988420938; 
 Fri, 02 Oct 2026 17:47:00 -0700 (PDT)
X-Received: by 2002:a05:620a:4397:b0:93e:516e:a8d2 with SMTP id
 af79cd13be357-93e516ec2f0mr203566685a.4.1790988420385; 
 Fri, 02 Oct 2026 17:47:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c71911bsm1160748e87.11.2026.10.02.17.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:46:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org, Rob Clark <robin.clark@oss.qualcomm.com>
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Connor Abbott <cwabbott0@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Fix GAMMA LUT for sm8750 related DPUs
Date: Sat,  3 Oct 2026 03:46:53 +0300
Message-ID: <179098834067.3641559.16830029168243411653.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930152645.22194-1-robin.clark@oss.qualcomm.com>
References: <20260930152645.22194-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KhuaEGo5x8WAPWQYPGMfxrIsXCGZgy3L
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfX03pycLyJ2Mr0
 tvAgQsOpWfDgrzq5P9EsgyGXCgjTDvO8QKGUUlHg64g5LCnGLq3eOjAx30sBkhnE/oiX0CUD0EM
 dxbc9+TOXvJyVEaMgaughI2TvldtvC4=
X-Proofpoint-ORIG-GUID: KhuaEGo5x8WAPWQYPGMfxrIsXCGZgy3L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfX7c3X7rznfDDb
 qEWjpf74DKB/zwgXcHjDXyU3W7++L/KNzqgoEYJcNDM3nvj5wQq3JrfKeX/h12wWWfxOK7+Wl+I
 hgIvf3rHuira9pM0EB6eVm0JcDIKjwB3IA9H7O4Wa3veu3dIhXuyOJ4iQPd32FzENHdf1QGmnhi
 o40Jgka+EkmWccAHV442xK+MC4bYcwpRFcTJszL0O5nCJxpVVAkAIRh0RgV9FR6FxaYbiC48eGV
 sG/pecj4hQJIRfMGw4+cSIkKIma4PApTqyhzs3u1o+D5+2vERf+RkSNnaohMGaRc7sITQiq4izq
 dlKvqeWij+76b7WEuHiFjoqPbpaf4b3YW41WCKd1BrfCE5eKQu7Q8Hw+C+WgdukQ83qgkHDOhS+
 ma6cNjLVgh0Qj7752jiLOlxCiHEf7sOVVAovDCT3LY6Iwpt04oh4TP+DvFtW/rOLPxzze+/sNm0
 P3SxkOdt1fn6M14fuDw==
X-Authority-Analysis: v=2.4 cv=f+jdl+yM c=1 sm=1 tr=0 ts=6ac05085 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=e5mUnYsNAAAA:8
 a=9kEJn9js-EPfIvdKjyYA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030002
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

On Wed, 30 Sep 2026 08:26:43 -0700, Rob Clark wrote:
> Add missing GC block.  Fixes GAMMA LUT on glymur/knp/etc.

Applied to ttt, thanks!

[1/1] drm/msm/dpu: Fix GAMMA LUT for sm8750 related DPUs
      https://gitlab.freedesktop.org/lumag/msm/-/commit/3389406e6a03

Best regards,
-- 
With best wishes
Dmitry


