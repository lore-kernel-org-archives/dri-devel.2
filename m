Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8483C88E75
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 23:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A3210F76E;
	Mon, 14 Sep 2026 23:08:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CWYERCwE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EaD0QPyn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F96510F770
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 23:08:46 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN05WC2827288
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 23:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=EOf9jLDathiKO1GdPmBUWCGG
 kUylbrTzUgoCUbTBCZE=; b=CWYERCwErA9YwhYo+x2NFwrUzqRRohzsoxsqdi1a
 95MeXnHD1MH/ik6G9oONeC1tThhdKaRMj1ngfDplCwnOWI226dqbLP4lFEeDg/fG
 6Cvz3pFB85SdkdccAYBTibDxN05WnUe/QbLbJf9MJWz0Nx20vIsi16L/n9mhwjL2
 s0ZQeRgNJHf2ahzIVZQjuU8sQsJ2Y3bD+6fH0Imm2kZQ6z2DXiiJr1oT7qjYE6Cv
 7u+1iP5g84Sg3fhmr7a76kJKDQNvqPv/ZOtiNXqVIAkwrc+PGn/4j6NtqFbczyvD
 UAZ0jCXrn62A285mppAxpCuoFQjQweEA4LxxXHMvTKgPQQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpn41s57s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 23:08:45 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6751db2792dso899932137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 16:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789427324; x=1790032124;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EOf9jLDathiKO1GdPmBUWCGGkUylbrTzUgoCUbTBCZE=;
 b=EaD0QPynGJ4NWLHrDlvVprt+iszM0Dds03pTkwpAKs4sgXjUX0AS8TnMEacc5jqy1O
 eXNXCjvRIGjDbOk7EmRUq5bJiOzPsJ92+1q0TwTOw77AG+lZOcPUUpwWy2137I4VPFei
 C1sXuaAxmFDr2hKAAJoDkMze4Fuw7qNiklxjo5BOUYyim1eInkhQ+EWO313k4rAG4KnE
 wukvSkr7cl4vChvFf1WjAIP4yuU3dJjuBJYlrqF6bxsOZE+fby5fPe6GP8xQJSjQGb+a
 3/4tRSkjrmX6RxpVg8WsmdosyOkXFYhoYXVF4hQ82Ak1AnMbKL06RAOERKtRLWlgrBfy
 WRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789427324; x=1790032124;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EOf9jLDathiKO1GdPmBUWCGGkUylbrTzUgoCUbTBCZE=;
 b=UAPeocA/DYWSdcF/ZLnv0lzgzGW7vfwyR5FZh/iNZDY8mz1pTF/fh6AdtF6G6wryIK
 EFdkhgx2FRmwufb9AkkI5Ua7uUE4WcVhq/ps0gZMWVGRK079LZbx8V+zM8nQhdqk4rnc
 e0lIFNY+eFFkUff8/6bkXsKM7GWvSViYpV1a+0O8lUYswol7TUoGKNYOLOYD6xxczeeN
 ejMCUFJhMb2mJUXjEP9bpN6icUmyomYEi3Pz1UND6HKIO7PUKzFs5sV/KYfn9lbYvdV4
 EJYmq/8ijNBuAYMxHxDE+NyxJWFQjp4KdGUeXgD9TetnxgBSqG4tR0WgymtIhtgtU/G8
 4CJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwB+EJ/yC/RbZmYaY0FpnJShxPF3ISVHQLK5kDiMykoUFMGuJ9AHTL/IfH7YS5neIfhyzzV/0C7SzA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l9rX39Z4NivwHqSUbt0C7k0beEujgXHfVIhvbz3h7MAz0VaXKO
 PQ2yH+cOngLTEeeWKLkQm8nPXURbgdc+3mXp/W5R+UgBTVyi94SCztDw0AG+XZGy9H/OUZF14yI
 NUq9AmsnA2C5aAF2WZDOu2yjl1Bb6lwDv5Wr+9xtZqmJsUH1TLLJZs3CRukbl6OEUh1q82qY=
X-Gm-Gg: AYBFou3nX5KIr3gzgnnGx+s3JD9lc5/ht9DS2BDUGFFbkf1NpVfYP0euu0sK7Xqhbix
 SAja4BOYABMHd0I4ALiFDvIcH+rBCUnSnQOBJUQvZ47eaVVNqEm4cfpJGieDBb2baIwsnHNey9S
 Zxo0oTzn+ncVRYlBZYf3U32BlObL979X+q6P1MrT4IqR6WWIV3+TNwxxZ1/W8OK37ZSO9VckGfY
 50lJrmS2jw5Jds5wdYsfu2rzr/pPAvx4hlYKC8FlSivDBRIajfYR9x5W7BFjqpNpjzHFyGsvuZN
 v6T67p4z+DqjKAcOkLXKBqP6T1FPrMMZUzJV4pDG73yfuGEKlXY9i8GESH68WmwuLPxzGNX6PQC
 HCcPdoWxoQOE0ojVbW9PnAM26C6XbRilViQ6ZHDseT4K9E2Xda0Un0f1S2grFbtd0wnZ5csyPg/
 86bdF2PIytehD7
X-Received: by 2002:a05:6102:160b:b0:785:e069:6c5 with SMTP id
 ada2fe7eead31-79b5adb091dmr5457422137.8.1789427324377; 
 Mon, 14 Sep 2026 16:08:44 -0700 (PDT)
X-Received: by 2002:a05:6102:160b:b0:785:e069:6c5 with SMTP id
 ada2fe7eead31-79b5adb091dmr5457408137.8.1789427323825; 
 Mon, 14 Sep 2026 16:08:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5b433b5a6sm22229601fa.4.2026.09.14.16.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 16:08:41 -0700 (PDT)
Date: Tue, 15 Sep 2026 02:08:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Saim Shujah <saimzst@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: clear pending flush state before physical
 cleanup
Message-ID: <3mhqndcw4defdpdo7t5wgb4ysh5cai6b7rq4sargypesxr67bj@6ibdnfmgyrol>
References: <20260826182459.1506522-1-saimzst@gmail.com>
 <wyoltftfpoxowxs4g4uwa2vi2pnspubn4vw4l2y52bwrhcjvew@xh3og5yp7uaq>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wyoltftfpoxowxs4g4uwa2vi2pnspubn4vw4l2y52bwrhcjvew@xh3og5yp7uaq>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMzMSBTYWx0ZWRfX7BJdOxpbqckz
 vm8RPchanGSKajDsMDsAi47bXDkzbdcK8bNDNxjL3pE9aEDieLNhgKmvVPKfy7xxBHoDMPb7D7o
 kS8m5I0oP4mB5nvsTPhcOuGUTpTPpyPGScP9jkWdujGbTcF37XKGU0zxL/A+0KqIUjDdvmZF2pc
 W6P/j/2zEO0rANhdwGOWVNg5Y/HjhCfw9za0kMr1hvcjCxGKne3EopOD7kq+6+p3ALBehuOHrcU
 qJx0SVTPyzDfXbrtG7eL/5nFhumNf17Uroi10xWUFf5PbHuE2o8eEBGsY4O+6ZpqnCDHRSmvMWC
 rYG+oAjfPNDBnUj/wdMnVsQEd7YMIfyruLrrhdVWlcBAEe4V/4MTqVQ/Qp5mbFPbbQTm4oUtizT
 sfgu+KXWI2CLdHHZHs4ddknsM8+53hO1argCoBlFaNF94YTMX8YNCXmNw4Ys1c2XmsCpoGzHlLU
 524E6GB+4FQA1PWhHnQ==
X-Proofpoint-GUID: QF5IhZfMFb8nAoJbhZ9OR--b-pdHPM32
X-Authority-Analysis: v=2.4 cv=cqQOAF4i c=1 sm=1 tr=0 ts=6aa87e7d cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=pG1nA-xtObB0exEfb0QA:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-ORIG-GUID: QF5IhZfMFb8nAoJbhZ9OR--b-pdHPM32
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMzMSBTYWx0ZWRfX4inYmVS16ZWo
 bTVEjmpBEi28qkhyKpgPo5MyJEQmYDU5N1d1oMD7U3KO0GenyVRFq6vQvxOGaWTFVadcwdFQ52z
 JDd7NnYeVRddHXk5kQ7MqG6Xo1nB60I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140331
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

On Mon, Sep 14, 2026 at 12:59:30AM +0300, Dmitry Baryshkov wrote:
> On Wed, Aug 26, 2026 at 11:24:59PM +0500, Saim Shujah wrote:
> > Hardware can consume an active-frame CTL flush while the cached software
> > pending-flush mask retains the submitted bits. Video-mode disable stops the
> > timing engine before physical cleanup, which then adds teardown bits to the
> > stale cached mask.
> > 
> > The teardown trigger can replay source-pipe bits after timing
> > stops, leaving one pending and preventing the first commit after re-enable.
> > 
> > Clear the cached pending-flush bookkeeping before constructing the teardown
> > state. clear_pending_flush() updates software bookkeeping only; it does not
> > write the hardware CTL_FLUSH register.
> > 
> > Fixes: 22cb02bc96ff ("drm/msm/disp/dpu: reset the datapath after timing engine disable")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Saim Shujah <saimzst@gmail.com>
> > ---
> >  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Unfortunately this patch breaks several IGT tests on sc7180:

kms_plane_alpha_blend@constant-alpha-max
kms_plane_alpha_blend@constant-alpha-mid
kms_rotation_crc@cursor-rotation-180
kms_rotation_crc@primary-rotation-180

-- 
With best wishes
Dmitry
