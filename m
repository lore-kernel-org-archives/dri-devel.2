Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3A5CA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6677810E6D5;
	Sat,  3 Oct 2026 00:03:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jzlOieA2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LyrztWk1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 613B010E5EC
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:03:04 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Ne6gE1503863
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=UYl7rUnBPLsCQuW2++FZMG
 zexo3/dnPWluINOMY+sz8=; b=jzlOieA2zbTJCghbHSHqpALY/DXtNpO/Tv0UWm
 i/n5akSbkGhzui+kh+7HeCN6tR7G0a/+MrT3Uh7VacbtuaWiDfjrsoHLkqEpsVr5
 jiSUjpjMTDz4HhZofvIavTeFKVHVHFRqsKjO9fCpb/zLj5ulpwBoAnwzke/cFYbF
 /UzK6lJmGvy6vfULzKGxZGiPF9EN++UXiHwoxCxYNJkEZ/UTqOEWSfLZur2L+cTS
 UvDKWAGxnCH+qWDz53u2IPhVjARApOk9Zj+quXaaaL6iAvKJFgcXhS2j3zn4yNNs
 JWZiuPSrsLMR3VFVClaiGe+ciaIubLOpINGaH2l+dAmOLp1A==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2n2rrayt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:03:03 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-988bbb0ed9aso58452241.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790985783; x=1791590583;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UYl7rUnBPLsCQuW2++FZMGzexo3/dnPWluINOMY+sz8=;
 b=LyrztWk15fKpYYn4bh6T2R2awkfVOuQD2wUF8DrgvYR0pq72lZUUDp4qc23XGqCrtw
 JPktK8OMhezWpeKmwQKe9z/MiOof89g6VSfsVFHm/yDV1XhyU4TZhqYzLMXlnzA7GRuB
 G+nzLTQ6M2nkZGgQ+sY567vAh2JqEBTtbMKdGT4mE7gjWTeo6nlnj4NHKQJ0th9p821q
 Wj6kUWewcAPl4DQJKu1RannrjcYcycX7so6I2iVj0D2rgmPlr85BzRt0TBaGGbuuNJ4+
 3ZZqkXLRcdf/1kQIMRXJpUoXmpbIFrZjlF+D103rYIllg9Lq6r8tHGju9iYhfq2PeuUg
 AyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790985783; x=1791590583;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UYl7rUnBPLsCQuW2++FZMGzexo3/dnPWluINOMY+sz8=;
 b=Xn8tk1yjVznQGXj9HxXPTbwycWLMfgUPqzO9u4mKgv1qG3wUY/oxQDDmPD4ZC10XoL
 f7Liglfa1n2u6eplg7FBfYc4DqKmjj8rnD8w9lKeKIO7DMTjFJKxP7TSE2XOAJEA0WHZ
 odvN6/bQ7Aa1EunbqxP08LYItayQ97LnC0y+eH+Cq8Rt3Kn8dIgcXhL1MrvjDal5AyID
 dVdrikRR/h24o21qI6NmUaanw1pJWYYLo47YBBBFYAZeqtwK/AwO0SmjbIz9Ep9MVG+/
 jxjVd6U709Izh8ectQA7JrfbQXa0/MYTbsnd4EkoiA8bEiM6vcv+S6LIMhT2k8uK+Gva
 w3tQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxML7CiOj8dmUxvsnXKcazR7/IBb+xoKu2gWwNmPPCu+anz/Sf7bLSNU7LgRaKuvSxxNqXff/7L5dU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL5ZhVjN1sX5o6uOT9jg4ftQk15Zf/nR5OzlIWzyWIqx5LJ22AE
 Ke3Z//XCu2u8pqU0HN6Ggvq8ZYw5Dgpz2UNKnR5njzbuSP7Gs1Ul0d02NxqpYnpqX0c+qmJJZLs
 PLf7QdSRlhuk58HuHk1i5w2BnNlReEZPRWCQMsE/TDmljguPoy9T0qRLzZF7VDQag6NUk7ak=
X-Gm-Gg: AYBFou0ZcrQ5byKx7FFl8i8y1aJregazhqtC03Xl1gl2zUevx1R4fSo/327lszbBGr1
 3lyvRSGd2kn7pjVbQopVsusph+0AD30HVAACbINC9PxoBFfWvOtBb6XT7+QjogHtSmSW748Z03M
 7N6h0BmlntDlGa1apswGDCLWaN3KQ5XYZoEkC9aBbRdFyQ/Qo7uEm/4Z1bRl5b82MBH3ssnjF9v
 eWkbI5ZP5K782XNjimMCk9Ib8JUWhq2VPzLIbZXi88dUdxaqKfNPpgN1B17HTqMyyXjU3Owu0Jh
 9+5ZBwDdjAm8Zwv9FxRmegYYYhVV9hq3Em7eXC9yTquC9oC4Q4kVUSyUTlhPsX+WRHJSS886B+3
 MpBzEEYz2uOQGwEoHoOQYQPaTvl6n7SWqKQ66t8L4vShYmxm6PWs3lXMTTJWVi4Nu/MHFGIgRqy
 SHm0cdPVYAykdd
X-Received: by 2002:a05:6102:418a:b0:7a7:ad9f:53e2 with SMTP id
 ada2fe7eead31-7c0f1adeaabmr1313728137.1.1790985782685; 
 Fri, 02 Oct 2026 17:03:02 -0700 (PDT)
X-Received: by 2002:a05:6102:418a:b0:7a7:ad9f:53e2 with SMTP id
 ada2fe7eead31-7c0f1adeaabmr1313709137.1.1790985782097; 
 Fri, 02 Oct 2026 17:03:02 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e2f7b4esm14234531fa.14.2026.10.02.17.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:03:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/5] drm/msm/dpu: enable quad-pipe for DSC and dual-DSI
 case
Date: Sat, 03 Oct 2026 03:02:58 +0300
Message-Id: <20261003-dpu-quad-pipe-fixed-v1-0-6a6a00917b71@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADJGwGoC/yXMwQqDMBCE4VeRPbsQrdjSVyke0uxotwebJqYUJ
 O9ugsePYf6dIoIi0r3ZKeCnUT9rQdc25F52XcAqxdSbfuyMubD4xN9khb168Kx/CA9W3A3DdXa
 wVJ4+oA61+phOx/R8w201RTkfL9NQiXcAAAA=
X-Change-ID: 20261003-dpu-quad-pipe-fixed-4adc8e47fcea
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jun Nie <jun.nie@linaro.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=CB7TT1T8j14Q4FhQymiBR2ZXNhb0URD++uaqz/WDp0U=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEYzvoCt7nCZ6n0xqzTkFn31aUEGmgcqvVG2n
 VdWUhbxNniJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBGMwAKCRCLPIo+Aiko
 1VFJB/0UOoeV+HtNAiE80sGXuK5ZPP407S9pJEHtD2lKLDH4sJRzX9MCfy/+0XnNTDyomYPY3Yz
 2j2oxoaYoYMilCvr68ia8F0R/F+r6ai6zEaYhGTgElisQr10OahII9UjYNU5Al1M+13sP4wnZut
 8E7X9+qaS4lrSf8XfLY2bCd1fazX29IRP9E4MRrWCKdCWfkDICK5NuZ/tdyrf24xfxkw+N60vA3
 9jlYNS8HEGow1uIfZs1INsEyzfSMBYKdQdysAcXrwzEn1YSAeaqSFMIyNt3yGTjUzF9srBQgzfg
 93k+24hh5E6yEWY9kSVtlBVl7KnCoWEPN7w0+uVOR5Qi05ke
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=d/VgWhjE c=1 sm=1 tr=0 ts=6ac04637 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=0EwCbC_-MHmnvNcu6akA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: 0QgJKIh_pQ5maBnGWV-M3CuYhRDOpm7k
X-Proofpoint-GUID: 0QgJKIh_pQ5maBnGWV-M3CuYhRDOpm7k
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA5NSBTYWx0ZWRfX5VO0DvDBbblt
 MjyEF82Y5grr3Ip+4G70BT49RWAfCHbY8oUNqWubwZUegT1fwb6hJtedeNpHjF6MsYwtc+drFyf
 5vQN0vnFz5tmh3jsGng5bw7a5LgT+KU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA5NSBTYWx0ZWRfX+KW7lR7AR2XA
 3zv7uuUNO2MVVVE6HI1ueFwNhcDlJSL0MbqJTSPLjokjTTOldqZevGZgfbB9WfZy9lnMoCbO25n
 1P86Isdk7pBk1rvTNTVp5dJhVo8Ni//aGYLf7HtkIbbPFWot2uJ1RFyJtABabk03NG5vRJhol6X
 VF+faIGvT8fz2ZlREisLA0eGcCav8/VoZjbEuYPzQMTXKsFnoTQlI9b/pDx6PqmU0KdVrDPLbTM
 QgsI30kz9pE7/xXb6EIfJy2aW3BuIs0lzkQnB7LP9hN1wnOiem9ArVnx5IOKU8LnMCwBI02Nq0r
 awhO2X3bbktKS+4Q+cLRb4WaVcBHoMH9z9L0ocfmFrDu8cPaRyGmq1SpYSMXE9GoWflqOyiDleg
 bAC7aKvF+RFY4MhxEOktCumSNWyBnPmfLU+hTsDW+FlvWHSCYnQBkcgvCo762/eR1rgMuzfMiPE
 ZPf9M9M0EJEsuULP+Bg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020095
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

This feels bad, but I ended up picking Jun's last remaining patch and
reworking it until it stopped producing issues in my hardware lab. This
patchset is based on Jun's v21.

Jun thanks for your previous work.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (4):
      drm/msm/dpu: don't flush a legacy CTL after its interface has stopped
      drm/msm/dpu: don't count the cloned writeback as an interface
      drm/msm/dpu: assign the mixers to the CTLs per interface
      drm/msm/dpu: enable 3D merge when there are more mixers than interfaces

Jun Nie (1):
      drm/msm/dpu: enable quad-pipe for DSC and dual-DSI case

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c         | 64 ++++++++++++++++--------
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h         |  6 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c      | 43 ++++------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h      |  2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h |  7 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h   |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h      |  2 +-
 7 files changed, 63 insertions(+), 63 deletions(-)
---
base-commit: 820493753c467135a7083379f0d547a942b56db3
change-id: 20261003-dpu-quad-pipe-fixed-4adc8e47fcea

Best regards,
--  
With best wishes
Dmitry

