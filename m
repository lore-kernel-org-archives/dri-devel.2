Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFA1CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03CB210F06C;
	Wed, 20 May 2026 13:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="E1B3pF5B";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WnFrFViQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D48D10F06C
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:41:34 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K9oVx31178167
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 b7n7dWS2wat70wUeGbGJzPfb5sbFNJlaG958cf6x0YY=; b=E1B3pF5B06Z6KbVA
 AUG2Tblfo/TiSDGZv98kSjz1r2L4uvQBiFhwNsgJZ6q+frt7pZ6+QoK9SOMwsvZT
 7wXdrZbwkFu4tVBFjp/sadCJIi1/LaY6WRQXhiSa4diypy5VtQDz0QAWo8YpV0BD
 lcePAllJCk4D47/yp+ukh8S9xssibPjak+dUvoxlaKONIc6/BkC3n/kC4qzvU7uQ
 Gd7Jr/pm5lUmoY8PefK5DCcxtStUsMLbAJnYfb1ADjND69Nr05gWaFNHvW5wpvAN
 SbbGkf0CIBB8jwfo72c+OyfgzeQIiWOwFlTJQYIjPmx1dxAcK335bPLXop9d5X+Z
 NcuEfw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ap6rtnj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:41:33 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-575242b4308so12716277e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779284492; x=1779889292;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7n7dWS2wat70wUeGbGJzPfb5sbFNJlaG958cf6x0YY=;
 b=WnFrFViQtHvLPG/VZMC6kZX4g2OjXHPQLI9JuRL9uCstRbTQR9zG6t0rqmZxOHb067
 FmhKkWpfzRjEpj/XN9zksRRHx4SfN6XmdEroN+QYewK3iwEpkxo+dprnzj8Ma+GDx5zE
 ghCNsMAIByXh9+BHdyiyrARFA+MISz8o/H1s2i9npXEivYmBd7NkHMXnLKeJ2QdF5bDC
 PftRVw3/26bm9RaOTGI8WvrsMn9BvzDmlbEh9Ct6jH9idWhRLsxID4dI7hldqKJItWhJ
 y18DArI42WRKyManzFF0SfJFgbe3bjviYVv+cmqWwPy8M0+Fjxp6YofihnOb/eewL6yt
 O1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779284492; x=1779889292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b7n7dWS2wat70wUeGbGJzPfb5sbFNJlaG958cf6x0YY=;
 b=IQcOBoSiPveP3xyvJhsz1gRigb8bzLWo/wup4PNmnPb5KLL/zXQCZ5leoQMMrjD7Zq
 nyPnsXgZFoGQIFeWmUB2XjxxaHq1Lmb3nar9I/l3y0ZXh+Dy8m99gPI+xRlVarCiUsTZ
 ILMVzz/eGNmwBRaiYewQQO0zkbllDLY449k0Cxcv9cXtUXOLBNmae/N4ZCApNSC8dTUX
 kIU0UcbBZN5xOr8GpWS7i3RHhnZdD99g9RBrJABtkneLo+OJMnsw8ajjFlDKW5n/qp1C
 ueLeiabaZY7oPAtgFsQc1pV4Dw874Ef5+wY9D0IXgxiSZOoBb5Aiehd6JjDDnDCJ8bPJ
 thqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9u5NsDTcERxok0x5QuLgnzO2OqHaeSoNy5VN5MLzU+HvA+2yzvGr8WJNbvZx5aGQaDW726DNFxeWo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwObbkZujuaFaiIWIiktEdmpCBJt3MGysdW2bhtm/lFysCMfYLb
 w3y+U7sopQ8dT91lq7InnsOiVi4buooA+RH64SCEHOV/v+jObeicdxNZ4gTXm5mOShaPcELxh2z
 bSu715xr9oMmXGCGsYz/Vt3BwfjOB7xnL0Kei+HjaqcxDOxQTW9qkVN47O0OS6gWVFm2OTuo=
X-Gm-Gg: Acq92OGUiLi12Sr6o6HLk8pV3xvMSKqksZReMASejd5ZlrVCjQ/CPeZNbp5kETduK2X
 NhIF7p26kgqsO/9qwXsq8rPAQFWrrSdDcj/zh+6X4JKKf86XZNnvBIQjSRI34sEktk6NboDKyJA
 Dibj8Tl8lW0JSn5J3Nw6Fp3UVR75+ZaRkjmlLXYuRK6d6hFYhrrt7awiiu1YRv+T8Uld73G/u4/
 O+362BcT8tIj3sj2thV/L2DkG8JdGEIghp0ZeisOHbtr2fTvznMhkqP8br5J3DrfyXimIEhYkTh
 szEZ1E2biHKtBbAHafKmRBYEs2gYo+xYIPbOObqhWIq+Leq6Ef6skTpAMncwJ0Jx/SqSi7EeFL9
 LZqLwzVZq6TQ/zvuk0zDQA91ZsGnLVvA9Qw11U+NtyOg1EHhlZZLk+swwV/oPWGqrsRQmyqSZzg
 klTyyssm0HMY35w/4ebGFlE288R4mRTuihjW4mKKLsiCuSrA==
X-Received: by 2002:a05:6122:6e0e:b0:56a:ef51:4cae with SMTP id
 71dfb90a1353d-5760be6ea63mr14515208e0c.4.1779284492594; 
 Wed, 20 May 2026 06:41:32 -0700 (PDT)
X-Received: by 2002:a05:6122:6e0e:b0:56a:ef51:4cae with SMTP id
 71dfb90a1353d-5760be6ea63mr14515135e0c.4.1779284492107; 
 Wed, 20 May 2026 06:41:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164bc3fcsm4997008e87.48.2026.05.20.06.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 06:41:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Jun Nie <jun.nie@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20] drm/msm/dpu: Enable quad-pipe for DSC and dual-DSI
 case
Date: Wed, 20 May 2026 16:41:29 +0300
Message-ID: <177928444226.2567181.13284983255649878415.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415-msm-next-quad-pipe-split-v20-1-bc1fdf140b81@linaro.org>
References: <20260415-msm-next-quad-pipe-split-v20-1-bc1fdf140b81@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: r24R3geo7WSmB5qU0avu5sCuQmWmamII
X-Proofpoint-ORIG-GUID: r24R3geo7WSmB5qU0avu5sCuQmWmamII
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEzMyBTYWx0ZWRfXy7FC6RDF3qAS
 MdLrah6kEQlpkmjuSFjr+XqyreAWgNhuFGZXH5eyS4dpnu7JGco6Zbp/VJHn/nomMw2XeX0av6F
 oOdVzKZVWrQJz5hjfACNz/Ykrm1rzBor747+/S0xI7v/gVrwO/HmfTziEwkdFMy77LtLqHURf33
 MPaMQspG+jvz2az8k7OsS5pnEHLYmVY5K8Rh6yphf0FFLRDHtXl1C2B4evGaAnJrl4wgoRx+XLh
 41z1+TzRYF4jE1+0bKkHzROyajUAU9YpkDc5GBJoTcdq8sEDMqRNjYlZibn3YPMGzSnNGQ+wOSr
 qzGeTBUDBgktn9VcqLYWgdJWVn2htttZ7RTGIZNUFVBz3VygxFArrpkmGhylER+L2Z1qlpHvPnP
 Aqlhwn9ZB4BiwEdE4YUeQR9Q2rgod9V7uPhw7vcKu1F06Q+W9tG00L/ahV0Rbeb+zdy6NXot1h5
 mpQOduA68AvS66qYsAw==
X-Authority-Analysis: v=2.4 cv=FesHAp+6 c=1 sm=1 tr=0 ts=6a0dba0d cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=e5mUnYsNAAAA:8
 a=pM-ujc6r0VUMniopd6IA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200133
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

On Wed, 15 Apr 2026 11:15:11 +0800, Jun Nie wrote:
> To support high-resolution cases that exceed the width constrain
> or scenarios that surpass the maximum MDP clock rate, additional
> pipes are necessary to enable parallel data processing within
> the width constraints and MDP clock rate.
> 
> Expand pipe array size to 4. Request 4 mixers and 4 DSCs for
> high-resolution cases where dual interfaces are enabled for virtual
> plane case. More use cases can be incorporated later if quad-pipe
> capabilities are required.
> 
> [...]

Applied to msm-next, thanks!

[1/1] drm/msm/dpu: Enable quad-pipe for DSC and dual-DSI case
      https://gitlab.freedesktop.org/lumag/msm/-/commit/218eb06a72bf

Best regards,
-- 
With best wishes
Dmitry


