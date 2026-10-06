Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ADECA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 06:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04EE310E29E;
	Tue,  6 Oct 2026 06:55:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aDZqlX1t";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IzxHSd4j";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E91ED10E29E
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 06:55:09 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966eDXu1083626
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 06:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /klLpSgzFnLd9VTNITlyPIZJqJOaOloP8mGS3oXlikQ=; b=aDZqlX1tlbtC7s92
 v09FL/s4tnWEIRpYmhhf4OT0QIkc5dvDvl/0GvMfFZuxju0XJWgFVo+WF+jvHv4i
 F4kHDtLdEEhC1qDEMP0KgEzJ/VIHdrWT7DWQ6F4r8y7Qmn01wrY+DUqizG0Zh5Hc
 8aZtssO1dGzSzUJ4X3Ijb4DuX9gMIyQWL3qWYiyl8ofiWHwn+nEZB4Gcz+bGlrim
 fu8K2dEX90JZH4LCKBwtNK6kJZRz3UNk33Q0MBXAsSY8MFa4PQm+2F2FyCz+DkCP
 0whJYmisVle2wfRbmQr/yg1RhqCz15P+yBgzlkfD0nT7J6rV1ki3FHb6Thk0mnJs
 rGaWow==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cuu3gkt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 06:55:09 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7bf45388253so2368649137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 23:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791269708; x=1791874508;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/klLpSgzFnLd9VTNITlyPIZJqJOaOloP8mGS3oXlikQ=;
 b=IzxHSd4jnHe9uUU4lcRj/o2JyVdTGMqtUkL8l19PAK69C5yZzA8y4TNH4G1LA+UMVT
 zS04rBVeRAD5iO7W4Ew6HPCXwTTfsYR8gNKGvkbwfV0uDfMYkc6fiYYY6oRlmyRvlGi5
 wnmiwyvAiDtELr8WgFCQKMxT61je4HlaVYjtiiua2EtApwMnLzMb28tUooJRXge+wGyJ
 /0CtK5jQP/NtHM0hm4UlHK+REdEv/CFwXzMFdVXQP9luBHEJBn+uzyR//ZLx3VQjBipb
 ec3GhkwMOjPVLFCKYqBXKXgTghL952eOTnxgtFW5KGwsM0PGSMF1sLcAEUAT2CK8/HKE
 RRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791269708; x=1791874508;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/klLpSgzFnLd9VTNITlyPIZJqJOaOloP8mGS3oXlikQ=;
 b=WtUAnBS6EDgYEAf/26gZKg2ZQRSwe4gcpnrXAL4AdCmBPzpOa/Epqfw+u8AyjqSxAW
 cuLAB3AHZ9NX70nbdIVuABbkGZXeNWBcoXHwwQsh0QspaW9zfFop46vGTp46Zvw/j8My
 VVWeGZXgDTSCwq+T9ftxTwFTKf6nU2swXC/hqG65Olj90D/8F9FZ25wV5zN1d4tmPMnz
 clu2PNVXXlrg2SmnmsBJHIkO7KRdOgQlg7yzYJeYHyDCBQgq9q7/2puj+Vv1y3HWhqEK
 l0YmchFXUbuuTJWTiA2BLz+nSrmlPaF2Ep5KiOQpX8+/jDW0plYiqE1eXGSlbCLcMi2f
 WS0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzGbbK9H6A9FmAGUe3YLOeBG4nq8S0rT1c0vzr/IqPcEKpuWtnIy1wWNEkq8BdBsFhB2qY6Jf2zBE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJUsFFW03bni8uwBOFoyBbbANya1iGzxzXmCzaKjkc1Ew7d6Qgv
 y8lLd2MEx3jzOaCrtsqCYsTrmEcjOYcK5cEfAdyoJNbajjc838kQDH4fdDcMmcVJCs8uJ1jWP5U
 X1xrOtBrdwhwLvHsfKaO8+f9K0+pffc7Zb/gYsHvucaVakZOh07QfQgGPmJ5QXS2L498eM5JRyn
 gkG/URmg==
X-Gm-Gg: AYBFou0bDk8LhTHyKofy/I1dcDA62smQ/JEMtW+9WGTBuNoGXHnPe5slZ6Vq9Dhv9yh
 wJYk6cZHbUihLOHl/ulTTm0RFv+4LUUOoZGfPZ98dKlvsB3t7QEmG4OipfQJpggSjR/WAPko7hE
 AtreAcKOCoADdjbvBnzKOc16QITQ45qcg07sriKaLn52R47dR6AHlYNCziHl61fGwwmPFsmLL1e
 606gSo/Vr2T36bkc4/9Z1Psw6p5unZLaQNcON8eCdCZAO+epu3uFmDuDEAyMzgJ4R5yXH6+2G+L
 x9ibQItZiEhEuyWV7HtHuCorK+DX/gvff7V7tvZTsTalWhkBV7JsO1vtnzv/SKa4HPxmFHs80J2
 jZVK9RyMPLVyAcOFXXw5cZfBcTPPqz1CWi2cJyOFBDcPyf0kZ7y3oxCo/qsMuQ27MYH/Wh3gT1y
 SXmXDtzjeicEfQ
X-Received: by 2002:a05:6102:510b:b0:7a7:ad9f:53e2 with SMTP id
 ada2fe7eead31-7c8765bc290mr110184137.1.1791269708422; 
 Mon, 05 Oct 2026 23:55:08 -0700 (PDT)
X-Received: by 2002:a05:6102:510b:b0:7a7:ad9f:53e2 with SMTP id
 ada2fe7eead31-7c8765bc290mr110168137.1.1791269707990; 
 Mon, 05 Oct 2026 23:55:07 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e303fabsm52162651fa.21.2026.10.05.23.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 23:55:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drm/msm: default separate_gpu_kms to auto selection
Date: Tue,  6 Oct 2026 09:55:03 +0300
Message-ID: <179126968612.1110179.1912784063733436296.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928-separate_gpu_kms-v4-1-3f33175de133@oss.qualcomm.com>
References: <20260928-separate_gpu_kms-v4-1-3f33175de133@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAyNyBTYWx0ZWRfX9XlBT6c5BonP
 x36N4cxaPGqgpuisATfNjymXxyZheFPH5biZWQjoJvEVjmUZnrPQnWtuBoSfLdvyTkS8vOXxjp5
 +fJ2bObaBrL+bgy1SvwCo2TWkj7vyyI=
X-Authority-Analysis: v=2.4 cv=aKRlOr9m c=1 sm=1 tr=0 ts=6ac49b4d cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=e5mUnYsNAAAA:8
 a=wOLXV0KxhkujVNyKNgIA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=crWF4MFLhNY0qMRaF8an:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: fD33V3OQDVABqwK9mGUafBGQW_PoftEn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAyNyBTYWx0ZWRfX4qVe1NFy+1Vg
 PBN8diXmMjk720esqoEseNfMFFrZaJ3+Vr3fmT8PvYEDVf3teNM+LNG+XWWPErrE++P8Grb1ZBR
 oNb3BcKQ5cawUOGnQKw8Uz9etdBb2RZNnu0pOodFVnN8lGf8ns/7BgUvEG/7Y45XpL7l+FfZolP
 noQofqkR3JFsXbmGLs8RopX4c9MVi7ooW3ll0z9OmhnFPvI7KgINyQ4s2xp15rbrlltNGxsjU5Q
 5IbyaSXw8rD8YcpdhCrPwawmti7ir8/IsQ3mjdHuShhb3/QQi9hikpveAst+ZjB6chyQvs5TNon
 2oA/phuC7MBLFNRy3rtDyyYecBZPl0WXwuPtd/sO0uZ6wjCBS4IPMGfdNTyy0xZS2WRsPtA/Xa5
 OA5i7j6X7AKLaECv3Mkyc7u474eL+ZrsMpdKLcW8SeqKGrTJjxrlFIQ+y69MSTGTQ6aD8W5btzW
 rEskWkcfMdSIk1Mbsqg==
X-Proofpoint-GUID: fD33V3OQDVABqwK9mGUafBGQW_PoftEn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
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

On Mon, 28 Sep 2026 12:28:45 +0530, Mahadevan P wrote:
> On platforms with multiple display subsystems, such as SA8775P, the GPU
> binds to the first display subsystem that probes. This implicit binding
> prevents subsequent display subsystems from probing successfully,
> breaking multi-display support.
> 
> Use the tristate separate_gpu_kms module parameter with the default
> value set to auto (-1). In auto mode, the driver selects the binding
> behavior based on the number of GPUs and display subsystems. This allows
> display subsystems to probe independently when required, while
> preserving the existing single-card behavior on simpler systems.
> 
> [...]

Applied to msm-next, thanks!

[1/1] drm/msm: default separate_gpu_kms to auto selection
      https://gitlab.freedesktop.org/lumag/msm/-/commit/cf27afc3bd6e

Best regards,
-- 
With best wishes
Dmitry


