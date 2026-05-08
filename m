Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD00CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 10:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DA8910E5D5;
	Fri,  8 May 2026 10:06:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eTAydDuR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PUGV0Ss7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 173C510F431
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 10:06:52 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6485siuP4069586
 for <dri-devel@lists.freedesktop.org>; Fri, 8 May 2026 10:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LGR4LdbXleQPAwUEukrHDtQmkBd3wkefeJbVg2vCkPg=; b=eTAydDuRGhO5RWFD
 nDo3QtXnS9lNLSwxdMF6eVpaDOqkcshNTPpJszckkdoMEQ4Njgt+EH4oWrwNS8g1
 DPygtMIkkPvkXGMz5t4PIPDDr/1Bcb/J2N8gCrsIHNL1Oc0eB+3qms/Giw4CXteD
 U7U41C5NlqUvgTAf/V3OHsUcB6aoJN+fih9k3SJgQUGrISRncPL72IhqLma/LKbI
 +0qTTNdflf6jtMAoOrZ3GGnrjnigTOY8MEIlr8vVJT91UGsp0KJf5n1AAXge7IBT
 mZmdePQhe60GrOEJtm5GcUUV2Sv1wNX/Ts+3cuwEQGwrFi9qvf6u8IXqQFMWIB/4
 dncPEA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e12sp2dy1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 10:06:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d8c183c2eso7560081cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 03:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778234810; x=1778839610;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LGR4LdbXleQPAwUEukrHDtQmkBd3wkefeJbVg2vCkPg=;
 b=PUGV0Ss7GDgKAoadmbXniNvLgfCyRrk2WdKN7vB4wqvefi+YlaB0HP9vG0UEF7EjYB
 6vU34zYwU6qMrmefLw5FZy0gscuJ9GBpbvR/XgmET5jMhn8vyI0ktKSCVuHZ1bm5wEdw
 wml2wovnsbtULkbvt/vQINUmD9JEEUvKh8YlkG3PWNzLorL3QI4F0IkmtaM4hhjPirFi
 /CFpZ/i/o2ksRDVZ1fnYFn9QC2ZxKg7CJHcDrOvuqQe6kfNNYHbg3RfzXqkGY4GX5jYy
 3GAX5EGpUKwggrgZ4nsJkMT5vHs3InScqKiFQnok37l0DGrAR/J6fHZpxUVFj89+szTY
 RZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778234810; x=1778839610;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LGR4LdbXleQPAwUEukrHDtQmkBd3wkefeJbVg2vCkPg=;
 b=cfT8t7VymInFnNHylq0JB10/icvwVB03AxDYPSfo0GvGnzHNz0b2IssN5X9G9Hpfbo
 of6hQ2DZCnfcwZp2xXs3twkWZMCjmXffKpmXqsFSaqUN2Abu0F7di5WfGJ3pdZTApDsG
 3PiZBCo21I+kye60lOnjGdwrPHUiiOlPREAGUNgGitepe4sgQXKGSZU/5abCsKS4VSRQ
 BD8IvA8A0rQ42NXWPGnaBGEGJ5HbU0rZwvsXPRITxkPq31LuSC4FvBb6yB3OWUdOFG3e
 qcU4i8PLvL+Y8Rdyz/Ysm8ObshJLdjsqSjSuj+WfMHgm/xsH9qLEa5yHSv8MrgMqkGJS
 GcLQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8G7vSonOIC4qGYlFkRjFBKWCzZvwK9GVnRhLH+BaUGhwsm5jePphB1HgBH6Di0r0pltsXLeEFe2q4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLj5HzX1vGxx546pO04IrguZBIz8pUwe+mgR3gVrJ1wkD4+IFg
 qdGTKHlPYBv+IGIaf/QD4FZgP42OIx1ffw1WIJRhb3vYeTue2HR4ydQRDLN1hDOIDxQ3TPz0P2m
 /J5EJGD2EdQMsfdW6AH4QiYVz+6oVNipHP5NbP3XJIsnhhsc8hrEQ7z0UwWxHEpsRVVw6j1E=
X-Gm-Gg: AeBDieuF65jP2o+31AFn9ROb1OV2zGUtB31NPUE3klMalv2AobBzUYyUUvT8iU3tTal
 A4u8+7uAazP+t4APxtpjnGIaFcmDR4RWFTqVTjDRMId/jw8WFKmqXQXdpJK4/DrBtJrIHaz0tTD
 VVB7buBbAcZFenHZaKNvd3qUwXyJaGjllpTsKmEFdopPaHHeVLcnZaLkSZAKy+3mVFa4IFjlGRu
 nq1Jln+yRydn+oFQ/JCXHv+nEOGdX1IEGZ5rv9ek4LgZUzzShi06McT53NIeEWYvbqWhDY4p6Yz
 i+AM9c5LFOSFxM9Fq/xOLvqQZFFL24DwdsfLq0uZewQjA7tFrBRpYwPQWFIS7ZrnrMmIjhpLUMM
 YHXSOo9gEOk8VDYleBrx533XuX3U5u+adQh9gRWoSymdIlbvFdxwcp2hDbh3S4u1GQ2b4z6myjL
 HEHRg=
X-Received: by 2002:ac8:7d47:0:b0:50b:5286:f756 with SMTP id
 d75a77b69052e-514628a96d1mr116851261cf.6.1778234810638; 
 Fri, 08 May 2026 03:06:50 -0700 (PDT)
X-Received: by 2002:ac8:7d47:0:b0:50b:5286:f756 with SMTP id
 d75a77b69052e-514628a96d1mr116850751cf.6.1778234810224; 
 Fri, 08 May 2026 03:06:50 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67ef0e1c2f9sm476346a12.28.2026.05.08.03.06.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 03:06:49 -0700 (PDT)
Message-ID: <f4641fd1-9fdd-4908-914c-932943d58754@oss.qualcomm.com>
Date: Fri, 8 May 2026 12:06:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/29] soc: qcom: ubwc: add helper controlling AMSBC
 enablement
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
 <20260507-ubwc-rework-v4-4-c19593d20c1d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260507-ubwc-rework-v4-4-c19593d20c1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwNCBTYWx0ZWRfXyH5SWnmR5e1u
 OVjoEnJ/qauyddXiphAjdo/tWUQ/fhiRmR7twdNxsdKuUMxXwOtmlKKR94MCUAZxzY6EEmt+YNA
 zQCY+cAsH5nDAIAsE7OhL/cMeCtiJmqSV+9Ifo6UmLgST0ZYg2TriSw7twHwL8JNW5A3pWnUd47
 fIMWWAm7u5y7bWvbJ6feQN6CUSjkHDJSKywmQVfp8AXfAwPIzVNO3oTxlYW23o95NzmuoWjD/hT
 8xssxRwBQijvMFb3kpUpc59A908uKbGZFE/R+mQBNBcjg7kXrqYplC8HIVxAi7mAjw545hn3DEN
 3z+ox9EkVoqrcXeaXjF15W9XTagNIJHKKfkArWj+DrlwThwnvhNMVePwO0c2LLWa1/gZU9EeIgB
 YG6UkhnxkHeTKpmwAbnnctZ4ZWT9UxBJFsPkJW5hT5xCoGGOjiFXh3xEDbKnPRx3NPue3c2ZEJ3
 LhMXz8z8Vw9Nu1/C3wQ==
X-Proofpoint-ORIG-GUID: tHmTEkTabC5Lh5Ft2Ob8sxxFCwl7Z5pj
X-Authority-Analysis: v=2.4 cv=Wu4b99fv c=1 sm=1 tr=0 ts=69fdb5bb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=NqI5fCEo7b1so1Dk8qgA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: tHmTEkTabC5Lh5Ft2Ob8sxxFCwl7Z5pj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080104
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

On 5/7/26 3:03 PM, Dmitry Baryshkov wrote:
> Adreno and MDSS drivers need to know whether to enable AMSBC. Add
> separate helper, describing that feature.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
