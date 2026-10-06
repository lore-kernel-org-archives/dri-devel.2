Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEACCA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 06:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0439510F1E8;
	Tue,  6 Oct 2026 06:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WPIh6dBG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LNpNrKuR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37E7B10F1E8
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 06:55:09 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966dwVY3432573
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 06:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y5PxqJ40x2v8dJl0fOyaxhba7K80AnLZ15CfFkyJEmI=; b=WPIh6dBG//0+31dy
 XBH768JezKqmM2il0PgBIx7FTxSpYClSIBd853bhStaR0G4H45OIZV9gf7g9uC7a
 4sMB4+shGa6STqpzWevWK30nXo9Vpkkc3EAlwgxSG17WnKxtQ1MQa38UgB2p0tZJ
 rdc74oFujh88EufvP4DSwOC8rMHeE7rqSTGzMvXFqWV9yz9lWogQ57rHLqkZgIDR
 +iKmLKxck7BjE1U8pIlkwV0CdQqy6LSE7bI1KBdUqTe9UIFFghdi2T4tbWw+hmhj
 cqzqAS1iAcIxj4fMeHqm6l4Vi//2EviPQ1r9vdmVs3xVRCO9Lr36aweqXm2rnPI/
 E/jc4A==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cvnkg9s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 06:55:08 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-98c77235b99so1590735241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 23:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791269708; x=1791874508;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y5PxqJ40x2v8dJl0fOyaxhba7K80AnLZ15CfFkyJEmI=;
 b=LNpNrKuRB4Y1aoPaXISzjip8s0NjCnhLoNfZr2YMhlmzLn1u6je1TCigru4rKnZeW3
 iSX/uzU3JfdYnN+SQDklbudsrIa1SyFVyHi9ig7IcEIU41m/xOUk15Q29Khu3/9OO7rh
 2Gi6QOLacIbbEwKmfOxqHSomPeMMuzJVFoBsupZW+2f51JvY7c8h/Xnn7TkZEEVoitHP
 S6Ab9p3e/EB0FZ2ACScVoaObwHpHXGWXABcMuXqK7YrWE25BSg6s8vswV0J+7CMoxl0B
 hyvXih1nkhZHoRHG7SZVE+VYiY+tSmWc5Wram6Zw9tg1OuaylmOtS7JQSTRDoVrupNPU
 97kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791269708; x=1791874508;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y5PxqJ40x2v8dJl0fOyaxhba7K80AnLZ15CfFkyJEmI=;
 b=1fcS9bBPxTDo6SVWokEV5wVsZ/hwQnxk7lN+gN18PaMormvNgDfok8hLL6dN4/qyvA
 E/7XkGOCRDXli4OQ1Fxa/0JfFFV0Zc9NVvth+hi5saGGK1QGxW7+LACUPXy2UKj7NnzK
 k+Ci4OFqvkUf7nuwwnvKSbME/emuN4r78O3/GB1PKhXJj/pPbyGqgh68SyrFOueKM1qQ
 HMocfnCt9bmb3ACe74zXl6ZER+i60wciyOcP09yXSzpkapkamTFcO8oWO7cecGLkE1Fb
 /Wh8rkR1mExslpplx9JpDoHo6xtyCtJKmC9/6YN7fEa4NHcBrZW9ZQJLu/1+fGgVfwF7
 SL6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQ/4V4kmDIlZXOsnk3Kflr9Br3NHVLyelrGMle1qG/sDrg029LrVUOjEX9/yscZ6rHIUsGCS+jUCI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJK9oGN1RMwQ7wsJZ6XlNp09KcOt38eLz/aFnPAJZzOye/Uyz9Y
 8ZOQf2aKnykkzeevtdWS/aPCQW71V84mhVoodEZEoyOUPH+274GKxirUaQe0XR2bqemyn5wwT+0
 wM1Jmfv6tR2xp9Kb6e3rE/FHda0b6Ko8yGKj6NWbpCE7KO0U/z5+q427Qfb/UAZCz4Tj2RFs=
X-Gm-Gg: AYBFou3epxXAc/2g6G+mym7sdUafzFuOh3oAjUgjLU5zIYyNCoQ6NOxu2GZHRY+5Yli
 22C+fHEb5aY1To1Ug4uUEQ8YulQGEvY4JGj+YbWPvKFHVQ/oqj4owGNEdO/TlpVFAm19X0ytO51
 wP0iRxPp5FJkqj6vNKklW1085nVOY7i3JvIQqHpPQcQf10QhbygzWfzYCE5F7j1qdH/e071sOYh
 bV2ZjDhPXf4nDhJkLnyjx2fAjqXFDzcvsjfcVGbj4DmuJuvuXtT28hfZh0pIUuEQNtSLK4BOq4W
 Z8k7VUGwQkcmJrUIdrgzknsuELTAW+Q2ZlhR9JaEiJfW8p2EnDbXGFHBaOrs5FLiEco8dJkQk0a
 fZ2v1RUHbzoYbLFxAT2qcErJqRvAGIJLh9MyU0DjYOqEAeHCwtj/oQ/XuEgxPRD7BUSk3mb5ptd
 FBoj7NvvAFLzap
X-Received: by 2002:a05:6102:1359:b0:7b7:39ec:51d5 with SMTP id
 ada2fe7eead31-7c7e0d83003mr382408137.24.1791269706994; 
 Mon, 05 Oct 2026 23:55:06 -0700 (PDT)
X-Received: by 2002:a05:6102:1359:b0:7b7:39ec:51d5 with SMTP id
 ada2fe7eead31-7c7e0d83003mr382403137.24.1791269706528; 
 Mon, 05 Oct 2026 23:55:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a87e303fabsm52162651fa.21.2026.10.05.23.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 23:55:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org,
 Joonhoe Kim <26rote@gmail.com>
Cc: abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/msm/dpu: disable the slave encoder before the
 master
Date: Tue,  6 Oct 2026 09:55:02 +0300
Message-ID: <179126968609.1110179.6720784693254574991.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261002130712.50612-1-26rote@gmail.com>
References: <20261002130712.50612-1-26rote@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xfC98UQ1zzY9PVuHDQ9mO9emO4jB6SuF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAyNyBTYWx0ZWRfX0r8w42ZZwgPm
 a75WQjIzJCdKdQwOvHiWh0SxSh/NEazIfO2bR9p07wRYR387EtH2JPH9M+gP8XLvZRAOJvzuNtF
 K4+qGxp8BAxv6aGtbSdNaLGHTWIJY0mwlX/eddnbl2YyTKkgG+WYnRmVQwAlFPoKj+o2/vAmZQX
 QUxrBCufJNdxM4pG7BuP96yf0UVK4zXQPorsOyXMrF9RpkwzDSl6XfUP1G2pu3jWjq+PGIl7vhN
 MzX02S5yv2FasvT9LrVAP1mdbOPqou+DjazRYTYtxU4PU+KNcOwlxwclPhzyrGeD4y0P3Lj6aPi
 tuvS4aaCpZwao62Y0AHgnq13DYE2F7WzKMsegVRd7i2I85BAdM8m4QPaAYg27nc2pe1gKh4vbTq
 IgIOP7LCz0Ffb47s4jF/2SDtfuH8ok2pMVnMdYPNjws2axbeAkVeiFpqXWqukkqpax85Ir/hxVQ
 mORqSkgw2BFpD8LwDKg==
X-Proofpoint-GUID: xfC98UQ1zzY9PVuHDQ9mO9emO4jB6SuF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAyNyBTYWx0ZWRfXzTzJY8v0QYtO
 rlnOKZhINTgEQfVg0NrocheuT8G/WLUDRJKHjNy3pE3Hpe09vL5gDGPTqAX+P8REgPJwlOCZ+Y8
 2uJrn6SYKXIqfU3WKpeLnKl7bTQ2lHA=
X-Authority-Analysis: v=2.4 cv=ZYeIpcVA c=1 sm=1 tr=0 ts=6ac49b4c cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=e5mUnYsNAAAA:8
 a=Nj1YSEbt09hXx5T6n98A:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
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

On Fri, 02 Oct 2026 22:07:12 +0900, Joonhoe Kim wrote:
> dpu_encoder_virt_atomic_disable() disables the physical encoders in
> phys_encs[] order, i.e. the master first. With a split display (two
> interfaces on one CTL, e.g. bonded DSI) the master's
> dpu_encoder_helper_phys_cleanup() then resets the shared CTL while the
> slave's timing engine is still running, and the source pipe is left
> stalled half-way through the slave's next frame.
> 
> [...]

Applied to msm-next, thanks!

[1/1] drm/msm/dpu: disable the slave encoder before the master
      https://gitlab.freedesktop.org/lumag/msm/-/commit/32d04280ddeb

Best regards,
-- 
With best wishes
Dmitry


