Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508C910ED64A
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA3610EDB8;
	Fri, 27 Mar 2026 11:37:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GOpVqoch";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SJAcAed0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA16B10EDB8
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:37:33 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R6vpKE298526
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +a5ZQma2kAd5vKCJCtMoVZAC0VFz4erj2keRHs7f2W8=; b=GOpVqochwzetJKv0
 D+IMNd+m+R/HQJ1Pd/ZtVrnjiD8oFwv0G1cxvl+ThEBLoq+bX1MKZtYKX2bR04/s
 2Jw2Mi2Kkz8m8ifDpUdcxx13JbAnc0TCYgXlyIkrqT+eX5b87D0dWW/gwAas4k1o
 o8mxN9JDg+B5TYaz3EJKWiW0toGP6B7AkjeMN1rSVcpxI40Mjyxul7VucmCWVKFl
 o5G5XTvrk7O1F32ydnIqn6qOv+ldfshU0SfKuw7WoAAkXBCYFxkwaiog+rQjYHkO
 DRW43drsB0oXKNhbi/qaPLcLl9qBXyKlFjUzfLMKgslFyV53kJ4hh+/ZWrXAk+P2
 1t3wrA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5bd8twc6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:37:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cfc644ff12so43751185a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 04:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774611452; x=1775216252;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+a5ZQma2kAd5vKCJCtMoVZAC0VFz4erj2keRHs7f2W8=;
 b=SJAcAed0rxs7tEzTrOCQno/pSED5mLk2Xjsfj1/mOwtDofcIC+8Lv9BKTV8eRMyBb7
 U0s37U8j/6DEw+b5wA0+VJ99xxUHqTFUQXErMG+27gqXB894uj12IjvDF+8BtMV2SrcM
 lgNnK8BPlQgtSlwNnGHEM2kJUP48Twau0bAq31nZ0opOLM+Sg/pHhBmDSWvP8oE4a9hz
 AWCJHxaGl3rnO/FHNMg/kbu5Nj69nL+9lI9q/s3cBdtTS16ESb4TTamWBP6L46s9ytB4
 KYvGsnakXS4FhKJVEhE85/SPdwNtJH542Oudihoa/9YeKbrDiOEA0Ya/hcR3tpPNdbEo
 SmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774611452; x=1775216252;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+a5ZQma2kAd5vKCJCtMoVZAC0VFz4erj2keRHs7f2W8=;
 b=QuNmGLPvjnxXqhvGo0cPVhKvdwSF/yDD9QS+cf+iEIqtz52xAeKiIbazWEB01L2D8T
 fIMD+U+UnGdou/SDEL5MUZgZUOuyMTox3ZEHTP0MvjXXPaTjE8YwohOM3yAV0ciGrrJW
 7GnZhF6jrVSe16WN11/LQt0E0oi+Cbau16LSx/Y2Oikc6D/njjmhNl4KqUZZyNyTp67H
 4Az+Lklo3fLWQGb631BTFDD4xcXEtYjQpk6ahOwupVl6h9J756ORT30jOx3WNA2q8/k8
 BS7y93e4EpOGvO0CgOxIPRfk5y/R4TCSnvkZSwhv5tWLdTSFJxDvLI90oKKOmBfgn/F/
 +imw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtA5Z3gU7Sm4YBQS4rm+QXLn+rcXT7npaLsiL5Vfk/gHiE4sG1RrFGjyUybZ3Nt3sgL/VDqjaItiA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3hkxV20PiXX+0AtnZnxS3Xk9r/jQsREoskzkTuuRcUTKYHRky
 YWT8L04QD8YhU7NZRzXHTpx8RaCX464YBRu8vxqxGLkdfWvxT4FAiFCLV4eDMxpEvfD1TiSGybX
 96CETH9OFypAV91bAKUvmr3uNRzD0aIeVatoOZaMzOawX613cP4s8HWl8xHdLIjmWlM76+ck=
X-Gm-Gg: ATEYQzwlRXg9h6zPp8UnPpADD4mzwygTQZ7hvfiDAUMohwXRsjsOwJeh9iCrvm51UEr
 0OVgZLYm1RbfliMPtuURLKEcEAvsi+//LyA2CvKnl1y3f5mUSOZcIICbTAiGl7PWjOrUlSgxxHV
 cqOWV/tXUQ+aDlMnar77tB8yQlxdWYGY737ZqIoLQCoUoL4TmQ+P6sG4eXCCuxYjT4jGHe2EVFm
 yYpk1oHm2yho1NQThXOZwtaSbhMbuJOcMJjZ4NHZKzqH/EEG7rVmDZ4phLdv4NXStDvsUPE3dKd
 750FaHoyEf6MJym2vwZETS0VM7Z+zJZPBPXygYBDUioHCTrHpALj0PmXUAoKYONXIRKrom4QwMP
 8CiiRlqbnaC5oitnAFdBv4ZkMQ/zVNbq9ZzPMwXM8Sb3sWPvbHZ1BwJMopoghPO2bHC3gVk4waJ
 dqdKI=
X-Received: by 2002:a05:620a:4049:b0:8cf:c757:f1d1 with SMTP id
 af79cd13be357-8d01c82312cmr168557485a.8.1774611451936; 
 Fri, 27 Mar 2026 04:37:31 -0700 (PDT)
X-Received: by 2002:a05:620a:4049:b0:8cf:c757:f1d1 with SMTP id
 af79cd13be357-8d01c82312cmr168554785a.8.1774611451432; 
 Fri, 27 Mar 2026 04:37:31 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66ad6752daesm2132479a12.19.2026.03.27.04.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 04:37:30 -0700 (PDT)
Message-ID: <438fd5f0-8a03-4d86-bc5a-6fd32c7a6480@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 12:37:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/17] drm/msm/a8xx: Fix the ticks used in submit traces
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-2-2b53c38d2101@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-2-2b53c38d2101@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA4MCBTYWx0ZWRfX0EavJNW2I4UN
 Vx7A3wg2U4rY/Ug51vI/8hsSaqDFTTni3+6pBrmk+HPQNr6uYdkqutqVpJbAYKBBDhzla2tys2O
 U5utJnptnG6WVFELlExBp3XMsJa3UjMzDlu7wUp9H7TtDDMMMIbI3SXAJKaXPMvrFDo25yZ4d/X
 /f4GHeSY7gqAYwG9Q+3s50owFRU1JFJFELaY7dhDbMo/mWunSO49w5ak/AsYcK2fWdTxvnoL89l
 D6I7eH1CNCa54YMW1epJv5n2Egl/eCS43fIOkfqEyN0+RqZLZat4J6xmSps+HqIkmHsKlRM1rWZ
 tGEtfhmW+elcygiGNOORFKzs4/cEGigG4XTRbY2uEymqz44PlLgn9Yzac5elGOdWkH7o1y8Hz/F
 mRsBA0fw9v1uR2ADTQPKZlTKyU/uP9x7LsNy8+t4ZdNkEg4AmVrwuIuJr83+tEDTzRsIg9LP/9q
 1M9IcXd05l+2iS+rw1g==
X-Proofpoint-ORIG-GUID: cMgSnrmUUHESMgx4hNEnmuRUXOxvIno8
X-Authority-Analysis: v=2.4 cv=BZrVE7t2 c=1 sm=1 tr=0 ts=69c66bfc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=XWSmCzMQkrl5bhrDGzoA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: cMgSnrmUUHESMgx4hNEnmuRUXOxvIno8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270080
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

On 3/27/26 1:13 AM, Akhil P Oommen wrote:
> GMU_ALWAYS_ON_COUNTER_* registers got moved in A8x, but currently, A6x
> register offsets are used in the submit traces instead of A8x offsets.
> To fix this, refactor a bit and use adreno_gpu->funcs->get_timestamp()
> everywhere.
> 
> While we are at it, update a8xx_gmu_get_timestamp() to use the GMU AO
> counter.

Which I assume does not need the GMU to be in any particular state, just
have its clocks enabled?

Konrad
