Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15A9CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B36810E15F;
	Wed, 20 May 2026 13:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jpvxiULw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NQjY0U4+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3F0910E15F
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:41:32 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDT26q1954028
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zve/zXZSQu9ewSFMNF1c0IzqgKRUTh4QdO7vTEXhftk=; b=jpvxiULwPOz82sms
 igPRtDxlFWiWqsSC6sQUYD0MvfZNE7nL50KYz3mmvEZjHoKvqKCLwM+kPU+asrse
 KAF2Jwr+K1m3un/1IMGaMH2YMpk7uTcYtxPG3rgKb0Gx5FBBnMcbyzXLsVv5sh4c
 hJHZDJHTU+awxApLAxVopnh3y/eK6LghsXk3Nqv6XfItXV0Trg+/gyGqKpUku3p5
 sBLXwmfzWCirTODCPneCqX+je3xx/sLPbpAZIIHaLp5cSejhfNB762hCPig5WTxe
 gWrQZZy3/I3+RMJid0SyAK+EJ+f25bhpa0uFaXppSVpCcvZ1Gh+3c0JUUNUtvqTE
 SCnYFg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3xw08n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:41:32 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-63146b7289bso13847286137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779284491; x=1779889291;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zve/zXZSQu9ewSFMNF1c0IzqgKRUTh4QdO7vTEXhftk=;
 b=NQjY0U4+yXxE1c9cXgcczTpAu8Jz78cgjzPNb25gR1ZaerPS63Gvrw/0W9CCZYuvMs
 F+KJ0oRR8ZMqjeLAiCZSpmwsnfoXPasGvCfWT88OiOjBgeYJRr7spmEoi6HVXUZGo+sX
 7rQcw8R9m4NJwTQFXJpM4tbRkaN+dmj/OMh/JMUL4w4fGl2RGjLTK3NjuL6Eh7CUKHTV
 NXZ34lSj0+5p67dXDgFU11ONj+KYkgusLLanFvHab3SfvjF8DIlyo+fm09R6Y9Ain2OS
 oagxp2f6ptiUd9oiV6tEluigjNqdC4KfkEcTFAyiqzNnfqLmUjJAq/LgpjbpL+iAKsqO
 /E2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779284491; x=1779889291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zve/zXZSQu9ewSFMNF1c0IzqgKRUTh4QdO7vTEXhftk=;
 b=iOwxTqVk1FAvyibwOowty2hf2wPdY2hcTmnlXypV8IS9MtvTKg6h5E6ThsCQv9KwVW
 FYa/RvKig2LRzuRw3Aby6Qd+EwSlBPE8ls1kGPKzt7yVLlCJnr2PJHXci5VwLi4V5Hdh
 K3OgspVbhnrMtRfLyVCs6KOcVJ4gEnkuVGUTTLPcEiNwCGelPx0AhoiXrZuV/kc80/Ub
 OY1M+jqbm7A7q5dVf6I2sQVbps3dJTgELRlS8nML38NhpYOs2q98KtQDGTedgCeHctse
 FjdH5JA1W6ShxiK5J8T2NyaqvJI4juavPHB2GwD8ruOgaxwoMlDWVi1LQbeqXJKwmcx3
 EnsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dRbXl2nY6ANdmeN6WrzfDd85PRv6QziG5PhG8hAbYS+RrSuVmufAMiL0479Hltjx64gs7uj1j9Cw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzy4oY7dDikAS4SdRmRsJCWBFjg23RflqIBBTzEs9MwWW/Jcuas
 pMTDnJJv+ENUe8g6uATIscb8BZEtzMayYt5hSNlT8j2qRkUMOIRlwZc8HXUWVDd/S/W73sFluM9
 EiRNO2mbU5+jgZn7baukWgQjdjD0pao9VTi62DWYass3U0nCjqOWa9TXhpF/Wy4agaCcVGfw=
X-Gm-Gg: Acq92OEV5VJq6x7YsaA1ZdF3VHdS3vUSNC3wrXzh+LayEoV95zhS8UAnJJlCFwfxoIN
 lcczIfT0/Pu6IaexwdsYevLI0dqmp0ebhbW9IW77cdA9UxXjDDeEeooDGUbbLRMp05Bn8XAPOZH
 2JQh6DWPHVzqxr4A5x5SQRV9Y4uyfmGJ6FnJpOs+66z3EjnL3EvqHAjgypLNyo7GBmurnCJIQYY
 rYUb89XdjEqG3mXtuGrUlJJRfDCCnZB/aNmKzVWDwKbBQqK4tGHzPa0RtsEVurumcZci6M/o5fi
 aws7FVpNJH8I6xzXa9Qshv5pdErmtbmacS0BTWhLEwllK6CZWhzhWZSnQsB9+8HzvjEzPJ2lHyZ
 k2uo48mTSxVrY9hB9JbRkS9PwAk0vStweSU6Fj3SLFnbGoMnrqgA5/KjhDC87ppcoy29kkC6nD+
 lMyC0amFCE7L+tgK70MlbOvNL6NGGYDn3T9LHSTi0ROzl6Jw==
X-Received: by 2002:a05:6102:c91:b0:634:d97f:7ee7 with SMTP id
 ada2fe7eead31-638b566d9ebmr11136839137.7.1779284491062; 
 Wed, 20 May 2026 06:41:31 -0700 (PDT)
X-Received: by 2002:a05:6102:c91:b0:634:d97f:7ee7 with SMTP id
 ada2fe7eead31-638b566d9ebmr11136825137.7.1779284490627; 
 Wed, 20 May 2026 06:41:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164bc3fcsm4997008e87.48.2026.05.20.06.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:41:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 00/29] soc/qcom/ubwc: rework UBWC configuration database
Date: Wed, 20 May 2026 16:41:28 +0300
Message-ID: <177928444223.2567181.6568362729287940658.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WaY8rUhX c=1 sm=1 tr=0 ts=6a0dba0c cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=e5mUnYsNAAAA:8
 a=siFjc1WQvlhzSZbc8bwA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: 0X5HAmvYSEcrOj1LyM9Sdj9ZHD74XvMp
X-Proofpoint-ORIG-GUID: 0X5HAmvYSEcrOj1LyM9Sdj9ZHD74XvMp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzMSBTYWx0ZWRfX451keATQFmru
 8/tULM4eTAQWDuHQOIoNW5QD+D2PycvRPkYRm+4bHcdlgvCgPVxb2vC6ry3PGJU/F8tpP8rJNtl
 q6lGAjalFHFwLvcSPwP1NZobWEFa1W3p7NnPq45JFoQfz0FJMbrZ3zYGE8DTfa5X7g9tbOKZHwa
 oEe3C5QT34AC54Wl9uNcWhf2TiQxIFyhP6GG7zyLFXYVVRORJjP83CjLeJiKBZnma/fKNoeD3iY
 hBXtuLT6CC7al7i51ZNNtG/cSqsoApT/wn84j8JH+pPIRXHb1Nyrcs57wAM9G7wHzX4DbZcCPiO
 dGOLrOqv2AtMsfe1GmV69ntjncElRssAu8p+P/W9QeXniCrXBt6afeee2Fk9kDQr1/ZBB7WxbWL
 T7PYqld/DJZhWyaweCx/2EO7Ccyd+WTWExz97nQLcn9pHJ5jv7onIa/1gPJTw4hNyQBKCPSWEOo
 lG747cE8M04daRPvz4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200131
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

On Thu, 07 May 2026 16:02:56 +0300, Dmitry Baryshkov wrote:
> Currently we store several settings in the configuration database. Some
> of them are incorrect or not completely matching the expected
> configuration settings. Others are directly derivable from the UBWC
> version. Rework how we handle the values in the database, trimming it
> down to the UBWC version, HBB and several flags.
> 
> The series includes patches for drm/msm as well as for the soc/qcom. My
> suggestion would be to either create an immutable tag for the first
> batch of soc/qcom patches, which we can pull into drm/msm or to ack
> merging the first patches through drm/msm tree directly.
> 
> [...]

Applied to msm-next, thanks!

[01/29] drm/msm/mdss: correct UBWC programming sequences
        https://gitlab.freedesktop.org/lumag/msm/-/commit/93e1290f429d

Best regards,
-- 
With best wishes
Dmitry


