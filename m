Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139CECA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:47:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6731410E6F7;
	Sat,  3 Oct 2026 00:47:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L/Q6ytf8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DO+79YZ6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 735A310E6F7
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:47:10 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Ne7Ja3812245
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1ZcxU10TAc9LTeYRglm1g/5Bzo8itS+vHj6k+ekfAkQ=; b=L/Q6ytf8kWv9eKaD
 xtQE0v7LF3Fw6PfttVeQgX3/zHCGQDa8tRjgtvmlCP/SgXsbjn6q8ibAAxVHx7sh
 jStM0GEul9bIF8qNtm5E0+qCEcABPZGoUsIShQlUDW4c8kYsw5dqDTiJPyDUEFIF
 prGYDqLKIluJ7V2Egi6UD1Fl7jpscIhzmq5QWpv6ZHfktYNyiN1jDl1Mqcoq87yb
 1mlLtmI1yjjj+jEfg+/wa66KCv4kVPji7Em/cne5B6zHl2rVbx0PthAOOcDil3fB
 w1/EKzWsnjp10k7GGxLkTNnwLR0xSkwPLdWH6pHNM6Mza70lVhLGH4QEKplnRkw6
 0d69cA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h256mv5t8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:47:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e82060977so26530085a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790988429; x=1791593229;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1ZcxU10TAc9LTeYRglm1g/5Bzo8itS+vHj6k+ekfAkQ=;
 b=DO+79YZ6na5T80jWXvvH0vXDpLdJ2oV3D+RSXVMJnlb9pv5fIpnaaK6REip2cZ3KON
 Z4H1NjvMF5GS8gw+R3QiuFzaCwl/L16CN6pZSf+Yjp2WIK+kY+/LVMNqL1dJUhjbvOLU
 koCVHDGQfs/hkhxToiEmhmcL4sOXq6QuvsgIqGAbXYZmVGXT6VYJyCvTW08en1e8HKeg
 vHjX4b6Ko+6Tf3cNv34pc9U+gLM6HnWqQ8qfXYBJrjtU6pDXKxHRRZ2F4yNhGIdtgxMi
 +6nCxpeR9TwIvyAR4oYs8luuFNQU/UWXoyuoeTI8J/i7J6P6jD/FErnTXoBuF2FsIilJ
 YLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790988429; x=1791593229;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1ZcxU10TAc9LTeYRglm1g/5Bzo8itS+vHj6k+ekfAkQ=;
 b=0Yoiwckcf94HU3rWlrCkdnJR0F27ljLn8chdrsrIsEKGabxV1y3SHaiauX7SoMxRhm
 fY3wR0qtnNeQWbsVvtvaSpZGhD2QiHQ52n/GOWeN3duY1x4wgwMSPziuebhKnVzpTjkT
 yONFPpjUrxKI6+TClOmPePrrrLWJDLLxYb0zS8x7ba//l1ZdFORHFcY18+6rX4ucQqYC
 YaxxVIz4DOAqxC8cfUG7Xx/TJAKheMFd/GxZhk1TGarZThqlZVANupy/KqDDFeSl5iF4
 mrIWBzXp4zIta5Y42RZ7f/R+repGEACwgpz6EcGpQjgVWUu760wDaq77we1or4t3dpZE
 KPuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwmdVGy1h9f27NNJH0pYxst5SJ8/nlOzBMTTmz5kPJ76KH912qj7j1lear8gJT01SgeTVNiX5G1hU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mj9RmKMt56xZM9NbkAXEhnm/74G+JxRYOra6PvdrslEMtYfGCN
 kGregWBhRUw5aptgWZzIuLfCbmcA6wX37hKvkANJYqpn1oQS650LsxN01uvA+8OWEL5n6CBMreP
 PbRt+VYKyqAigefuC5M366qf38PUjCLTDmxnm0MWA1/1hNNOBOIxqIqN0W/s8wKvggj5h0O0=
X-Gm-Gg: AYBFou2cHnI81nsnB/9AjClJzxUra6RcBYPx94VbfaiAQGCScIq2snjXQv3WGA4ZWih
 Lxx0jBqmZWcwRDJMHDw1JiQehbNdFbFngg+zkBW/2Nc07HwAqNv+DM+cBSLFOwhIk6UA2mg8lk1
 xDoYavs+nnWKY6FrY+LMs2u2cgxhMT76QXHFXQeoLk2UC+AiD1lsR8Cp0IB2X5iGKlXKnosjT+h
 m34U/nBRG8TVonCM99qQi9C2R88Z3yTyeP+OGgix3t6DKSKPXKXFot/G7HnmkynpeAU8TrreG5D
 hE0ajyMLNSI03P2FGY5FoYni/LcGA20YBQ7Hn9/AymLrW4/UySzKbu3cppJ6xzNObz3Yf1Ghz5o
 RxmTyBKN72E4TajyBYeU5koKcMf1vJkI1qE4T7C49Asc46Jzjjx79h0k9+DMb1QZ9bd6tBJFwl1
 oKemYnEzSB41ga
X-Received: by 2002:a05:620a:1a10:b0:93c:65e3:df81 with SMTP id
 af79cd13be357-93cb5a5be1bmr1444375185a.13.1790988428812; 
 Fri, 02 Oct 2026 17:47:08 -0700 (PDT)
X-Received: by 2002:a05:620a:1a10:b0:93c:65e3:df81 with SMTP id
 af79cd13be357-93cb5a5be1bmr1444372585a.13.1790988428238; 
 Fri, 02 Oct 2026 17:47:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c71911bsm1160748e87.11.2026.10.02.17.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:47:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: abhinav.kumar@linux.dev, Wentao Liang <vulab@iscas.ac.cn>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, jesszhan0024@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 lumag@kernel.org, marijn.suijten@somainline.org,
 robin.clark@oss.qualcomm.com, sean@poorly.run, simona@ffwll.ch,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi: Fix VM leak in dsi_tx_buf_alloc_6g()
Date: Sat,  3 Oct 2026 03:46:55 +0300
Message-ID: <179098834079.3641559.2074719170971578581.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916175738.2089950-1-vulab@iscas.ac.cn>
References: <20260916175738.2089950-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfX3bk0Kq8+4bE1
 +xMeW9xSf77bMpy+tt+mHHqY2dlX0n60N4Rqd8Zgn+rIFfLzSSA88A9DgHVTryukny1X3JMA07a
 AzsGIcJAAgEEXBIvsdAF1Fvr9ZCLr78=
X-Proofpoint-ORIG-GUID: eyp0iZyt7YbdICfgoH7SpaTrSOrBgCOJ
X-Authority-Analysis: v=2.4 cv=b80ncdGx c=1 sm=1 tr=0 ts=6ac0508d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8
 a=nOZalv0Y895iF468lBgA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: eyp0iZyt7YbdICfgoH7SpaTrSOrBgCOJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfXxhE30cKOAYoA
 kfEactL8+vUmV/KQ4zwQ9PUX6rhJoFBEJ4bI1ZG1sc2z/4emj2dPu/lQYlXwQ2XkRwCi9DtflWt
 9CNpYBUDaw5Dtsa34cKa9RVXYAIF4rc/O4iq6gxjTS1xphqc0hV4Z2Z6nxnssywbc9bhc1ELwKK
 DFfFTGMarQ+vE5LbL883nUY3gPFyVAm0vHLt5a+wd+6sm91qFJUATcCbF1YIbPpbH+vNfyJP7Rc
 sB6wjbB/Twzl5VjLufSFOqPnCDljcadlmMqrGVn8DAS8LuwPysKWJSp/l+mFntwaf7iNcbwZCZG
 Zwc1xqy318lzCa95trk92CvTSk2Kj2vvVray7s6R5bKybGfW2WLaPbcdp0qZb57HnZlyuS1PakA
 +96kN4r0HqBT47zIFdJ0cNSpEoPNfuDg2EmR/iPm4xXCHAUOTFhdOVtLXVEOqhykDdst2NlrpoN
 p1bx7UbYm+MRLmZPsRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030002
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

On Wed, 16 Sep 2026 17:57:38 +0000, Wentao Liang wrote:
> dsi_tx_buf_alloc_6g() takes a reference to the kms VM with
> drm_gpuvm_get() and stores it in msm_host->vm.  If
> msm_gem_kernel_new() fails, the function returns early without
> dropping that reference.  Since msm_host->tx_gem_obj is cleared on
> the error path, msm_dsi_tx_buf_free() will never see a non-NULL
> tx_gem_obj and thus never calls drm_gpuvm_put(), leaking the VM
> reference.
> 
> [...]

Applied to ttt, thanks!

[1/1] drm/msm/dsi: Fix VM leak in dsi_tx_buf_alloc_6g()
      https://gitlab.freedesktop.org/lumag/msm/-/commit/ab91ba61871a

Best regards,
-- 
With best wishes
Dmitry


