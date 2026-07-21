Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88AA8C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8B010E1DD;
	Tue, 21 Jul 2026 18:50:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zb/b3xou";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RAb5JutS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D29410E3BF
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:50:11 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LHROtN2446214
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fxC8wePi6tkBj4RJjKl1UeH/
 A/kptp+3A5mz2gNO7yg=; b=Zb/b3xouFz4nyp0/go8oLtuwEUoKD9C0cirnBLfW
 aVwEUGt1yadY44wTqGfBAnPYInHpvYnQCnm0BrX0DHrG2YTQyRmP1HUa/JVkz1gT
 jdAhrHFsJmuhWzmZomIFrbGMO7Fwa22JCp2DiQwTOli7FKlcOkTtOYA8PQlx4dP8
 Tg7BPZoDr02ZNZISLp4EJ07jZs4MkUp5xZtT8s596MTRKOX0RexUDkpifaCEyzRu
 GaB55z7KMzHgPiEU/m5zbJjMfOcimRAeskZzNR5oEobYIQeqct73F5OtVCaXkBzw
 rQi9cvx7jLWr500P5ppA3Kwcp66BDvk18k5BHsD3rVNeYw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6d0cey-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:50:10 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-73a8aba30a4so5568749137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784659809; x=1785264609;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fxC8wePi6tkBj4RJjKl1UeH/A/kptp+3A5mz2gNO7yg=;
 b=RAb5JutSkMFzdpzWcP5PKzMdScwjrQENTpWXZ2Lw+FvVRlOiuwcs28Ab8xaP9VM9d+
 TXGIypIMPrtxJJ9Y5cRo1s+9GejsnLrGr4uUDVMl+l9ykk55G0vzw8VpFtL6hfzi5YHJ
 w8uIntNJi28zssUCIm54+EQaQpTlNrn46lXQx2+GWzl84230SgckJl0pR8HExnNdvZyG
 xU1fPNCBqq/KQ3/J6F9ucnqwTrqUZC3VOOeln0USLHg5467kW6pbRom1ruJ1TBHzM0sf
 sFl6hfzSexLq6K0m8g98ZJuSbyyQ0G0LqvzO8L3MqiADuu4Fs4WozKIvW09adweubIJV
 2yxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659809; x=1785264609;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fxC8wePi6tkBj4RJjKl1UeH/A/kptp+3A5mz2gNO7yg=;
 b=jrkVs/lRpcJVFZrhs43NENDrSnwannYWJsftwe04VNR0RBy5cJwCMG9tUblll84936
 S2OxKAUDpus+Oa5nG+Fs92lzaNKepYvepCAAQWw1kMMhrPNgER7B6veGZjFTUfhQTODQ
 AwP5Tc86YJQLJ0gQzY2YxJuAQlC5B7yvK/vV0a3PdmujpQMm5tbTJRFWjH0lMkGZvFXT
 cUqxjL/VLaEwLBI9MeU0dKBY81duwcbvyow0hhQJ+G+KCLHgmVsTJpwVwvgqKApyiB9m
 bU2GPTKCPzR8yThpfQFQXGFgKkVPSuc37k2Wbbau6yFBJLc/70RLT4S2GdYL7ja4wzBx
 NHWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RolBIjUFYGutcCtsMCTcGfqJB3J/H8i8CBo32nXTxF4+vnT4f7dfIoq4wj+83C90AUEbX9k/jtMdbk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSmU1PlL6XDFY0T8aXeuGfB+CNnt9qpp3HSr5k9NGG+UAMAYAL
 +hs7mxvt/v4jcxlcgi02MDGA51bqNzgvxDXkje3Nf6TiwZuSVwvjBOlciNIItbXUV+PE0zBtCHc
 /a9/PzSDQ56tCUsgeUOCyL3jewVLsRjPhhjNnLYY1ZAgt3MBA9lvKmY9NKwegf/d6CLUSbpM=
X-Gm-Gg: AR+sD12cYzkrFgdNN8bNXpnav3n2YAbbV5/VfDaoltmRqck/MB5CdEULHpCMJFSHXhi
 B59E+W2KzaYkNSAsKoM8NlFNwy2QbUkV5nOHfZGA0cpiY9JTbX0CPSek16oX8NZL95bpRDQESPu
 5dP6C9l+v6sS9ISg3eKqr7ZgqQuShQNte37Bmup7rWtKAthcAhJP1iFOIRpnm5VPQm4FHhK/yHM
 AXwwkl/hKgM+SgDOsBC72BbofTwL5zUqi73Azk28nUJmrN7e8pbulmp0xmLnIoGz5UAjySnQAux
 NaxeU0nfZUcI5ZWwlunaqtDnoxIawVK72hLRrD+qZ+YkKARazAn9bUgxXBQ5GyyRDgrHIzNJtc2
 OdVAd++VyPxGH02Qpjnbvc3vynbVdeGpyE7pAFBxdE0Bg1nAcKLfvABQXCm1j1PpxG5uSCdTW3P
 7s6FYYRj7GA/nZ5w==
X-Received: by 2002:a05:6102:18cd:b0:738:8b5c:a41a with SMTP id
 ada2fe7eead31-74ad17da68fmr341891137.18.1784659809465; 
 Tue, 21 Jul 2026 11:50:09 -0700 (PDT)
X-Received: by 2002:a05:6102:18cd:b0:738:8b5c:a41a with SMTP id
 ada2fe7eead31-74ad17da68fmr341878137.18.1784659809037; 
 Tue, 21 Jul 2026 11:50:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39ef6888542sm721611fa.1.2026.07.21.11.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:50:06 -0700 (PDT)
Date: Tue, 21 Jul 2026 21:50:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev, freedreno@lists.freedesktop.org,
 linux-arm-msm@umbar.lan
Cc: Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v8 06/15] drm/msm/dp: split link setup from source params
Message-ID: <2ysoleroryfoh3tosv54iyq5t6556k4uf2hkp67fofy7gizkhp@3koilwev3czy>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
 <20260720-dp_mstclean-v8-6-bea261bf4e7d@oss.qualcomm.com>
 <20260720062728.89BAC1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720062728.89BAC1F000E9@smtp.kernel.org>
X-Proofpoint-GUID: PjYTlZsgt53j6DyNOi-9g6Fwzr4qQ0MG
X-Proofpoint-ORIG-GUID: PjYTlZsgt53j6DyNOi-9g6Fwzr4qQ0MG
X-Authority-Analysis: v=2.4 cv=XaG5Co55 c=1 sm=1 tr=0 ts=6a5fbf62 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=mEP0jwSp7JUOxKfJe-kA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE5NyBTYWx0ZWRfXxj1TKhTiDiiY
 IOy012lRL662+kYcFeZf4IW13j8OOC+yuu4kPd2fzqjfu8Botl00RQkrxhKwbnyOyvjY7iI7j75
 N+6AVOfdRuV95o7HOWyV+tKhPHqKKt9M03nxFz9eTYxsaAAVABrGToVKeuS+UejWLKlJdRlwZp9
 /4nxUcxS91BYzRbjnFcH+u7OR0eG7y1SYbKajznwgRvymTBqBzyjfxPLvtkQ/uG39xTvp0ibmye
 WyqF2PxSA4OEAtB9yJxLGwDba/C2l7dK9al6c2ePhJBbKHqD8HfvSAw3+3mA5eAmh12iS2bbHyE
 zKvjbZp9pg/xN29/QCPSowz5P0I4vVg3uTF6vqUG86PlDlNhRFDcDq1K8/k+9iPT2NqJ9r7Vp5I
 22GeMQqjxJErzjll9IrT+b1586OptlveWIdsApAl62H1wHbqvlq496b2eiljJ7qVy01p7V/9ibB
 1Q6quThmGjVBdjK6zrg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE5NyBTYWx0ZWRfX1+czKvpX0KSt
 K7tCAKOReI8HcuTMsE8d9HMLBRWJeO4xx6W+zIxP6VzMicI/w8VASaZ/eQLskzOufcCzzRkN/AO
 Dx4T2ZmKVDu81sqJoltSXiJaGvBzdJQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210197
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

On Mon, Jul 20, 2026 at 06:27:28AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> By splitting the link setup from the stream setup here, are we exposing an
> incomplete read-modify-write in msm_dp_ctrl_config_ctrl_streams()?
> 
> When MST programs the link and stream settings separately,
> msm_dp_ctrl_config_ctrl_streams() will be called independently. Looking at
> msm_dp_ctrl_config_ctrl_streams():
> 
> drivers/gpu/drm/msm/dp/dp_ctrl.c:msm_dp_ctrl_config_ctrl_streams() {
>     ...
>     config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
> 
>     if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
>         config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
> 
>     tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
>                                           msm_dp_panel->msm_dp_mode.bpp);
> 
>     config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
>     ...
> }
> 
> Since this function reads the register and bitwise-ORs the new values
> without clearing the existing stream-specific bitfields (like the BPC or
> YUV bits), won't this cause bit accumulation and hardware state corruption
> across multiple streams if the link isn't reset in between?

This deserves a comment or a fix.

-- 
With best wishes
Dmitry
