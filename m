Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5146ACA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:25:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B6210F8CA;
	Fri,  2 Oct 2026 15:25:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="khiZ+nsb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kqtVZLhZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBEB010F8C3
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 15:25:44 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692FGtKS2120562
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 15:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=r9D7+CFu3eRB8x/qjlqDxylX
 MyCw58C2x2mnI/2qAak=; b=khiZ+nsb7J/+R5GykhAtoR4Zu2+3GQ1d/AyzsQ/I
 YVKRzFd2k7sGoji4APi7o7CQGAOoqXU+qdSJ622v3mYiD6BFEauK/oWN8fU/ER0o
 GJbR9BMpQDYf3yJ+hg8lRbv07FlVg2ILlZvVmiGxNRH6t5yrtKM2Acr2FMJjKDAO
 b8lN/YXc+jky/6cWhiHaGO3HEUivgNTeG9czJzsfDlr3XR2Hxulp3+iOmRHyxIeK
 6HDTL7HuvUsZadnqeEKQyp9nFot5nB+hVJIZCA6LzigJZ8mcUb/57a4BnQpXpTul
 jx89+WwXExDfzm2YNPCfGla7QdOhBvbompEaVplxJ+pOgg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20sh2vng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 15:25:43 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7c0bad5ec1cso289364137.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 08:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790954743; x=1791559543;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r9D7+CFu3eRB8x/qjlqDxylXMyCw58C2x2mnI/2qAak=;
 b=kqtVZLhZwfqb+K44cBkZa+i0uHPLHytKjdNRgSl0kcjQmnd3yAMB7PO9IFntJ30iU1
 RKEfyQowvXa8njKmUUxBQD9ipZd15DgjB53Ee6uDHxAw+DQBrK+yJNWeSuIoV35OiodI
 3duX9DWm0tS0O5Ft4S+KTCBNZ2Q7V4WMvk558co46GPLD3xA6oWU1PjrtpchDOZ2VvMk
 bsz7kR21y7FpjyoCQQZ4jmoc6xYi/QHhoVzqdV7L/jKmGFQodPWNE6vVZKNZgmmkGOLF
 pumJ8q15lt1xiSrOT2RNgOwcIf2bkmoCXoBpd4iVhyljldd1QpCiqArcAn3iqNN6o3OH
 Z//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790954743; x=1791559543;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r9D7+CFu3eRB8x/qjlqDxylXMyCw58C2x2mnI/2qAak=;
 b=K4vSK9axKSLOwkOfH9m+kVkf9qtZCEJVVq1gcQaxcmipCFaYCUFmmsGcffc0NoJAO+
 f3jLsaxF9ThCoWl6bzzJQ0dOfNWCi0e2vkeMXfjw4VNsPxo2XRIBiAAj05Uey42dm8++
 yGvEjt9K/bUHReXci9VgX9/WZX5GaP6bckIy6cdK2ZDXJuEZP99D4dJReBp+a1U0N09U
 tSJR6spLFmoVta0Y829iLv+VaehJNjYqBJSDOqd6IxfBrHW1eWv5sykXwlRWEMixeVbI
 bI+qKDp9aHwg5J1W6HlaOiR5VN9MzKYjximhDtZp4F+MUDpRzoWT2xkvwRU10OdqLsEo
 PWow==
X-Forwarded-Encrypted: i=1;
 AKwUvByvXAjpuyFX07amlxcDTJLAvk7qL0Sljorlnw8LA9o9lRpdOAJqAwny6sKvwp/7u6s3xBy15x2xFPs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKdMRC6U/UUeOdLs+BqEEUDzMe9OLWzoJZiHQ1kPCuLyby7rJBP
 V7HreDbCR/cuuM+je7wSe/nSk/KvxI1eW7Q2vY4YTgz7aBRQkOEg7i2T/DBj5XXmh3cAyXlNBoN
 fIcIhyO9x3v3ELz1PTMmdbAkJc8/ZNiSDtLFSasMZ41Y1whr0X76JxHlIsb9e8GMV9Y9N27Q=
X-Gm-Gg: AYBFou1Xfc8TUhn4Ho+nkYuQJS6pajsd0csO0WQx/GO1EyEPMXVBYD20sztd/CgBpKD
 yiRb2eV64kF0qLTC4G5ErEzZdITIUmKnCwL1rvToH5KxaZ+733684KO7fgMbDb5o7H9ha4upzU+
 o12mvKvoQMg1utaVCaEQ9UGUB9x+NejXEXmqBy60CDFkNxn5ziET7TS6XEUIOSCsSmm8v9JWKlc
 f/Jz5TLNuYl97kUuCGGbUkRvm7V+cdhcHZYszHlamhf6SrRFj+/mPrI/llTNJ2NupDezss/SDIf
 VbjRcNya4DOLIVLkNhDuxnoR/J85cdzntMR2+O4NJ2IrpwRAqRT/0je+w7TDEOpoD2NfR7K3M8e
 MNAo7o7D0bWrfraRY2OqAheqqdcHNrnbfHw2Dqx09Tyf7uTdYEl9ID2Pvz8hzWZvPS+NT6Vm6Mp
 3VmfLyD0m89Hvk
X-Received: by 2002:a05:6102:3754:b0:7a7:c789:881 with SMTP id
 ada2fe7eead31-7c0f4271c17mr639290137.6.1790954742823; 
 Fri, 02 Oct 2026 08:25:42 -0700 (PDT)
X-Received: by 2002:a05:6102:3754:b0:7a7:c789:881 with SMTP id
 ada2fe7eead31-7c0f4271c17mr639285137.6.1790954742344; 
 Fri, 02 Oct 2026 08:25:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e2f7dbcsm10637261fa.12.2026.10.02.08.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 08:25:40 -0700 (PDT)
Date: Fri, 2 Oct 2026 18:25:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Joonhoe Kim <26rote@gmail.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/msm/dpu: disable the slave encoder before the
 master
Message-ID: <4fh64kdk36hfgbespinsa57l735mhnol7vbko52oj77xw255b5@harvnua7k2oh>
References: <20261002130712.50612-1-26rote@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002130712.50612-1-26rote@gmail.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfX73qCiQmkeTqX
 E+3Gy4z1TBZEg8lbD4MChZD+6TqyjsWqAlQoaGVaytZn2bUzk6N/4SgJN8FSD4WgA4wssXVA24L
 j5Ghw3oEobxMg0ANVVCjj0IZUtJ0LE8=
X-Authority-Analysis: v=2.4 cv=IpmL47/g c=1 sm=1 tr=0 ts=6abfccf7 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=e2OdPLLIgFw-C6oMEugA:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfX3I0R4QmhG3YV
 mDTvoovwgm1yi7zjkutAWI2s8Hk828LDbe4KX9Ygoo1/CTaODLGBJlX337+ktt4e+wr6Ybt1o9E
 KfNvDRoiqsYLwwqPR2KtLgHoESEzm63cgQ+h+PeqM4peU0b+nmhdzmBVY4n/4TH8lO6uVtxdiom
 dJikwpGMbsjV3SKhXri3wtnnNFYPMLy00pZcuHGktwx/W9t5Iz00AIncw9hwnszcAO0oDbGYt6A
 O0rOrd/8or0m8HK3qJxfiokC7EbRCm5lBm9NWQHyGVM6v4G+46lJHEXhRJffZbME3DqJfudUmGw
 H/zQ8a7B/XC1Uokq7nt7XCQTHiHpWov6m2y3VBMIQcadVWwpv8SfKY+tICuHus9WIN1PuDsRjsv
 h8tVsmY60LvBx06LE5WCUd0JFOa7vcQ3McsrDqyd3Y2IXHGzUSMy69O4KpqTgyLml8v7yjysYJa
 hfpsWJK2rGHJYy3GlIw==
X-Proofpoint-GUID: ZRr-Tsd7OfsOUNdvCSli7eMwq7zIGxdH
X-Proofpoint-ORIG-GUID: ZRr-Tsd7OfsOUNdvCSli7eMwq7zIGxdH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020061
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

On Fri, Oct 02, 2026 at 10:07:12PM +0900, Joonhoe Kim wrote:
> dpu_encoder_virt_atomic_disable() disables the physical encoders in
> phys_encs[] order, i.e. the master first. With a split display (two
> interfaces on one CTL, e.g. bonded DSI) the master's
> dpu_encoder_helper_phys_cleanup() then resets the shared CTL while the
> slave's timing engine is still running, and the source pipe is left
> stalled half-way through the slave's next frame.
> 
> A power collapse of the MDSS core GDSC clears the stall, so it normally
> goes unnoticed. When MDSS stays powered across the disable (a full
> modeset, or an active DP controller), the next enable scans out
> nothing: black screen with the backlight on.
> 
> Disable the slave before the master, as atomic_enable() enables them in
> that order. The slave's cleanup still resets the CTL while the master is
> running, but the last reset, from the master's cleanup, now happens with
> both timing engines stopped.
> 
> Tested on a Lenovo Legion Tab Y700 gen 5 (SM8850, bonded DSI video-mode
> panel) with MDSS kept active:
> 
>   echo on > /sys/bus/platform/devices/9800000.display-subsystem/power/control
> 
> DPMS off/on: black 10/10 before, picture 10/10 after. Full modesets were
> not retested with this version. Only tested on this device.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Fixes: 22cb02bc96ff ("drm/msm/disp/dpu: reset the datapath after timing engine disable")
> Assisted-by: LLM
> Signed-off-by: Joonhoe Kim <26rote@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
