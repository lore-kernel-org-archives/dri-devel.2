Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEEDCA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 06:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17EA810E0BB;
	Tue,  6 Oct 2026 06:55:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RYSlbwsw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cjfZsAIe";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFC9F10F1F2
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 06:55:11 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966eCvJ3269502
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 06:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IokViRR90jEHy3wGwjRgMoWYS3qEdf6BP5tz0llnJKU=; b=RYSlbwsw9/qX/ekU
 DLjFBkKAUvBbcf6biTe3/NdtANjwzK16p/1GV2DLzzhsUSKT70TiZWkd7MJFJhqX
 GopBAGzApDUbqGvTzClepIG8zUxG2992fE7Pt0Sm+si/4Htpqgv9svb3zBjNLY1J
 rlTq6pvjNOeHhXQxdFnRlQUPYgwRTrbKRmCKkU/CzXULhRMz1wMZtlPSqSNpDTTq
 BPHD8yMCtf7VvR5hPUVRD5vxQ8oyEI2c3noy82bV+aAV3SFtQ+NQE1D5jaBhwcqZ
 Aw2qQS1JRyMrodqropKWysiOvEetF5O+JMgbi2whIFhGVzS5mTDBkVC85gbjy1zQ
 abE9Og==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4fkujqyx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 06:55:10 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7bfee69e500so2475657137.2
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 23:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791269710; x=1791874510;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IokViRR90jEHy3wGwjRgMoWYS3qEdf6BP5tz0llnJKU=;
 b=cjfZsAIe5aFFCDFBS4wMup+HMq1jVLnInXCNpMkzmLPl+iec5PqFBq6AQQzrFcxcPv
 3SqvJpMtMCbDnBjFV71q7ec6N/Vul16l+RX5E2TmuCrpJpP9QrDRhGNWVLTM9p19rvQt
 qBRrL1axpvJq1fHsEK6R/qjCgOggTFivFBJlp2XEvrfZQEXn7M/0+3BaBv3s7mvSnrGC
 Fxhghp1sgOdIx0XQAL+0PGx55jckkcnjnOnoEVKZPU/m8274RF3xJAzZqjqvyKZBsv32
 bDfsm4S0W8Of5wLjYxaxDHDory9Bxk9iP9x5McGzmf2I6m7iug4N8Op24nC6aU7y+zsd
 P7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791269710; x=1791874510;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IokViRR90jEHy3wGwjRgMoWYS3qEdf6BP5tz0llnJKU=;
 b=zj/aWE/ndAl5a4j8PSVmE+xUn9ZiZbdf1o8S1QkIORbjWOqj772i9/sJUKFix1ftNj
 stsY/1mtBKeMIuX1FEp/wnCTjllYyULptgDdMH+aLPaLx+NcIQLv6JxGCVkWM7d2b9Te
 2gQDbgwMrvyYqh8MQ56cSNvGxmoTQULI/YW8pMRmufs5+uGKhwQm8oDexhXXplAAezJb
 r2DljY781QPuzYeLt1rh6EwHwYixhLdrj/ZgET4tBN7OIcMagi9gDnFU84kMGQooZ1xy
 gkwgisFPs9EzMt/wshb3sM7Ek22U7+MirY5ovZ3YG33ZUczxD0dYT089NX/8o7MxWAjs
 DfLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWSFpdE/oftsFkGoIRzmjP3LfRqXSOzIAuNN8jS41YtSoqfRbHpjMcUeZaXiVGiXqCbBZCIVP1Zxo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL0oM6IrNNNCsaLC87mRjde+BVRPeihT2qmp9TfBW0ByQNZrHtp
 KTbkjS2CurYaZO9gF1KqywNmW0MptwygFWMTPTQpRtGVtMdebd9EHFv/KhWuPn3nw/znr82faAt
 LxIiz7iSTTiUprw2VG0wXvSwurgEun+A8Y4IeJfqVKzQciz7hmimAL/PdZsCYDyQu9fVBb6U=
X-Gm-Gg: AYBFou1nYg4yUB19UxEAr/IQdcVmhQ/yJ9Zppqvt9tTy7cJGvyeyfoWqhe10hMyCOOM
 P+aSuyZX7+eR938ytzMwSkRmiln7s/wcR+DlIRv1w/i/LBNL80Rf7vDJXSrBzBXoufAb/Ue+83y
 iqfQ/QH0Kn3WIs1lHLi5RB28ugq+fBvRCK4ZiSoRinQPA88JzHImkoi6Ah6lb38+urJGxpzoeLd
 JPipp24HYkcM1V9mLXvfF0NdtuHXqMC3kzgBLeN4wtW9pIkNRkwklQ2fHhuOqFbnF3wmUof6You
 pq9oKIu/dEcEtdQNiYGYbTuRFpOhOML+IONE28QKA0+xGmizDkH1aJhwMjcqCyN0+ZUEhpYpR3b
 DOoGTz1GdTBL/tPNlhETK40ZHAfNWwU2rRe4NTshG8Pa25shYNMZkpREc2FCB26s4IJgO+fAxSX
 DhaIWeVsF3SrLU
X-Received: by 2002:a05:6102:91d:b0:7c3:450d:2431 with SMTP id
 ada2fe7eead31-7c3450d2a55mr2443726137.2.1791269710054; 
 Mon, 05 Oct 2026 23:55:10 -0700 (PDT)
X-Received: by 2002:a05:6102:91d:b0:7c3:450d:2431 with SMTP id
 ada2fe7eead31-7c3450d2a55mr2443720137.2.1791269709601; 
 Mon, 05 Oct 2026 23:55:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e303fabsm52162651fa.21.2026.10.05.23.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 23:55:08 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Oleg Keri <okerixx@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: don't report link training success after a
 reinit
Date: Tue,  6 Oct 2026 09:55:04 +0300
Message-ID: <179126968610.1110179.13947180112289626975.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925125314.16563-1-okerixx@gmail.com>
References: <20260925125314.16563-1-okerixx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HtPjiETS c=1 sm=1 tr=0 ts=6ac49b4e cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8
 a=m9j_GCGoi3mryc8sS7EA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=crWF4MFLhNY0qMRaF8an:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: HE5JKwWyrHL-rNc2y7rQMQrn4foDonW1
X-Proofpoint-ORIG-GUID: HE5JKwWyrHL-rNc2y7rQMQrn4foDonW1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAyNyBTYWx0ZWRfX3U53nBC2O2ZO
 YATgd4fRoFLhUsCfgfxy/QFz6HW0FJ2BtQePRTiH3KMBIKos/BefwPGF4jhWqBciGtjlTFhkrlX
 F+sTUuNf9gXxcbOX1SH4oYfNO6c9kQs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAyNyBTYWx0ZWRfX4Hw/5BBPL4Ot
 Auk8K1MXBS1q1rND6HUUUGmrO1OGf+3O0uBzAZaEiOslmmG43SjCIiujV2YbW44OIRQtIexd6Ta
 z4JrISjXWCTeiG6sA/6Uw0SVo2SREKntHrqRjntlil1hwt/lBuY4GG4ldCRQkL2AwsuSGBDomZk
 U6YWxQPEjWwqrgj1XXr11FxNRagk7nzZDfTFrxsApm85nLClfKyXPc3xaz1GZZpT5ZQmd/Kt8D/
 XAoWGwdpm3cOzvtthLyoPnqYq1yA+OMxUhTuhC+fmRnH67oRspAWu57g1WHJSbFbYPJGbCrj4bl
 j2bbk9duw3CyXTVzJJtYd9fesxGEfmejhP/BlYJoqfPh/e+ODt3ut/XR+fpJLac0k4XnJ/5Asq+
 V6kUouppeQKHC0vjFzg5NPG8xP91SFw9YDVYEXauF5sH8+Apnns4PcgO+JWQCHAfgSO8y2YwThS
 CF77MwSxyrFM/Tssj/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060027
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

On Fri, 25 Sep 2026 14:53:14 +0200, Oleg Keri wrote:
> When every training attempt fails, the retry loop in
> msm_dp_ctrl_on_link() ends on a successful
> msm_dp_ctrl_reinitialize_mainlink(), leaving rc at 0. The caller then
> enables the stream on an untrained link and the display stays dark.
> 
> The retry counter only reaches zero in that case, so treat it as a
> training failure.
> 
> [...]

Applied to msm-next, thanks!

[1/1] drm/msm/dp: don't report link training success after a reinit
      https://gitlab.freedesktop.org/lumag/msm/-/commit/a47987366e7f

Best regards,
-- 
With best wishes
Dmitry


