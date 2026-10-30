Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14950606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mLtXrypl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e3/8AOp2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C87112690;
	Fri, 30 Oct 2026 08:36:09 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90E8410E881
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:35:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U8F1fn2721658
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BJ0hT9AzGdYr5QX4etV6d2dPIaVRRzNFWlNbAyzQgZE=; b=mLtXryplGnXfHaLA
 tmlbdaxGFX25tKXAXCGF4UqGa8w5dlXHMM7JB4ie0etfTPDjxg6yk7/dfD/x1Dzm
 BKhqDdRokrMVx04iYqWr2pBijZXMvPLzB/e7m3zGdfrQehS7k29aZX/XEMCZ4QqX
 kE5SgeaXYu92h61JFBZkWJPOmegtnHNGTSWxJwP7R54oP/ZRP+j9xrFfBU70u5sX
 1MBbWKdbm8qgdJ+qI0hLI3GgpjUQWQTHg6sGgx5au5R2PVEVbeKZa+BuAYPkL1qb
 VVZN9+9vrNMWbiCDuzMMPULbbELRgyKVK6dfECks65MPcr25TokrC9f5V3WQ9At8
 gDAy1w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qj14y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:35:41 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c84695584so1504616d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 01:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793349341; x=1793954141;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BJ0hT9AzGdYr5QX4etV6d2dPIaVRRzNFWlNbAyzQgZE=;
 b=e3/8AOp2wlX9i45hQJ6er1MTBunQNFLG7RN18vXSDu5v9cjqe2mACxAaWVShgonKF1
 1/D6LChIPl6QlMhlKV3om2Nik/E3/VkJX/jyz/EDeO6HbuVEozPyioVbkwDgMGcUO3Ex
 Lb/THOOL/b3Mt/oo84JHCHW43Or50a3Xw0HW1mMVTXLjpP/2mTLdpD7iynnDBEEEZVPa
 u4e1Osw3fUhQGSqwQ2jKQ+4E52TlHL3G/S7/ODq6KicKQutnrMzDz+RXtNAsquR3pW8X
 c/R2suXFXvoQeMmiohul6w/8dxNSi+kMxteXW6pwO92gUk/1V/4vTAGAfAkZ02sJtzpA
 m4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793349341; x=1793954141;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BJ0hT9AzGdYr5QX4etV6d2dPIaVRRzNFWlNbAyzQgZE=;
 b=rC5o+SS1yWTGknrpEwj6YCHYDyV0MALpMk3alD6MDTpjKC6FXfOtw+G2Azjn0kDCdT
 KCf4JP+laPrec4yA1VEjo2lVWC9nf88WyuQxUNMTKL90W6mMrcA0EWui5BIvwcBaTUBc
 SoYpaLqmxuYfvoZYP3gZp1zTW6xCV6Vl9AN0T1ZGS9BK9K2Ut8tfSO8hlCJUV3bFmu+E
 s3uayBuValfuZRanQ2gO+0d5a1ggCQ6MMqnl+MT/HBfX7YEKGcqHFvP0uIehviQD1/MC
 HbiwjpWpIYhNtZGPqean4S0oFO6nsfULCgDtStN8hxiFTzkKh7DpMHqJ4+OKHVYPWI0e
 N+IQ==
X-Gm-Message-State: AFq9FYL0Ztq9NvtI29iUDUUScoelrSz2z+wuptWHFkyPyGbP6XKXu+SO
 BGrs+f/QXDa7DxgKmVsOF1ANGezAES/H172M9r65WBT+hltOaif2IeA674xL/sBh10YQEPHRx0f
 y8g89FH1PU/Or6CDVMm5D7NItqnwVmHN2jFtBiHZfvmU7WM8EKIfW92M0YIf+0ZDtxBBpywAjKh
 Opydo=
X-Gm-Gg: AYBFou3Np/nFW/GMJ3cf0bjlaVDalGk+7NcA78qH0S6fqTA5HI8mviLxpUA2bouzP6q
 h7jOd4lDRqHEdobFRqha03u3deRrEC8VWr6Z/FUTd5vMRIegSN8UA0BX+M+TJs+dhZUZox2DHPf
 5WjwbJxKc1v72dUgcgM0HYmTdJgFzcJb7O/u0f33YJ0Gyx58NeNWJUFRcqwAeMfl+B4cxn+VC7+
 GtXIplFvvrC2Zx67Enh5Uq3ncRGS13PxPjzNLG2XtoYd8nNZywcwriUnqQQmLx4mR0By3KYttJr
 fUeheJNjjfFlxqhQ/esryuITPrPiEeUcYeYQyqWVx49fXYifOCjhM0HXEpxf1MfGB/qhywc4IDm
 v0Jw+rEaPkXDdhzdeO+ttL8LkoTf2xTk6LLhXfW3TPYlMsKi9X0ThfXu9AkNws4B8vzlI+08=
X-Received: by 2002:a05:622b:4d:10b0:535:f9db:3b86 with SMTP id
 d75a77b69052e-542b687ae13mr24294201cf.3.1793349340706; 
 Fri, 30 Oct 2026 01:35:40 -0700 (PDT)
X-Received: by 2002:a05:622b:4d:10b0:535:f9db:3b86 with SMTP id
 d75a77b69052e-542b687ae13mr24293851cf.3.1793349340133; 
 Fri, 30 Oct 2026 01:35:40 -0700 (PDT)
Received: from [192.168.226.64] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabe4cf60sm39225666b.53.2026.10.30.01.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 01:35:39 -0700 (PDT)
Message-ID: <067b2a6f-9e16-4f8f-bec2-5ee2de10125e@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 09:35:37 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/qcom: Use identity domain for GPU and display
To: Rob Clark <robin.clark@oss.qualcomm.com>, iommu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20261029212344.346069-1-robin.clark@oss.qualcomm.com>
 <20261029212344.346069-2-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261029212344.346069-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XbESL9s1O3jd78FR-X3U336flbM7ZNM0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfX9J+4vsOzLFfc
 8ziD6HcFAJ/1woeMWiLxcq5pTww+/08bTzIbRnQsBLYdoLwYnhsXJ/X8GHzmrYXTbKYFUlwI03S
 cUBcvhKelbeip3dNAOl5IjAJ+Kk8MbA=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae456dd cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=nPYanoZRiyYWTCGofB4A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: XbESL9s1O3jd78FR-X3U336flbM7ZNM0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfXwHrd1IxiBx7Z
 2S2NUKclTODDaSE5E7VGja5+ybbppIXxtiUMM2+hV2DE6FYdH2dZ89UybcAgk2XvKx7AAsp4h1Z
 RnLQ0ynrKU+Nokzj7uydI6s7h+qYThopOYn5zjPWwZTHC9BLQDe8duJgzalYApP5zUiEo8oeoVN
 5SfWfAnnHrLPi92/cNZKyyjUPQZD+o9Jav7FOKmIE5SJQsVCWIYD06IRtq82AhxZfPrRPggw3lc
 okv3inzf45aHqFq5LN+w1jKuRKXLabOKrriQlmYqj2OnQaqTxSP57soNiz6wF7M/ZZFIgqB6RjO
 Pmes/1OMBeI9GVsL5iaZ67zXoGNPDLNtB5vKrNfwniIDNgihLpStMh1lfAGe7wAkPVFtXG0oBc0
 lh1ZEeoGVqN27Zn7Y7ankrh/bsYX1KHNS4nEbnRV9HP8VeslgEUOvPy8ZLA87PUxt1T8/+n2fOg
 ZRF8ik9hshplVC0A6NQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300034
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 10:23 PM, Rob Clark wrote:
> Similar to commit 0e764a01015d ("iommu/arm-smmu: Allow client devices to
> select direct mapping") for arm-smmu-qcom, match GPU and display compat
> strings to pick identity domain time.
> 
> The drm/msm driver attaches it's own domain, which it manages directly,
> so we don't want an iommu managed domain interfering.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

fwiw I'm not sure we have any devices with this driver and mdp4
but anyway

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
