Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB58606A323
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BYkqWIL/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ed3pD8B+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3DD810F3FF;
	Tue, 27 Oct 2026 11:37:19 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB01910F402
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:37:08 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RAe3Zt2524812
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=d9Gksr16Ym7a6rQh3BsSgLKt
 bW1PN6uAQD1PHStu3Cg=; b=BYkqWIL/vT76gUwo2BPV8+qHrr6gTQHtEF/qsZzV
 t9k7/HNQeqhwS+OHKqnDsMIWulbLG2pqkKIwvCy+qUpRSxC99/XxZBrYFP4cxZ7l
 /Q5YOmpG3L271QH2G5vKyPoPM1U+Mq8rSMuRfxu5hdQR1Oyw80YcKP/fbSWdHayk
 T1s4ECD6OiTjnRcPlz4xyWeEWk5/6k+IM1aG5CEfYWk//wv8JxvDfs9IpI340eXV
 4UYya+dCPcGYNtZp5Y0LWnfYkoc75+7VeOWSCho+8Jf88hndccM3tEwzSWSew6Ic
 bV2hVKl418/lToGDeg8NuPuK+BK//WEAdS2VFXbsnHzZsw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw20v62-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:37:07 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7c124d17880so925848137.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 04:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793101027; x=1793705827;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d9Gksr16Ym7a6rQh3BsSgLKtbW1PN6uAQD1PHStu3Cg=;
 b=ed3pD8B+vwLMY68Uo0Qv+WhoMOegIhWKuQzuEH8PvsY7eAS0SvdkRWs2YcbOnAqBtp
 dnTHLudK3n6jYFks5fpf8vNlWy8/BWHOezBDRIMfqh8JbISuazC6XgFyUk9NDK2GamF6
 CAaelYq5b7AnOAL52isMq9Y3G/8oA2Qsv54GTOLHVCCPzM0u6yMZ5Pbbxvc46+M1Pfg4
 XSyhtH8jXdCwxW+sDAwQPevMA4GwOEsjM7tNlQs3t53rUgDBP9XudWGj3SR5quNJVVMl
 wC/XJbqZUa/n8co1ZvXKQhDP6E7CjL8glG5TRNuNn8Qa4RDX2jIedjHPZD2TTTxRTrGf
 zG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793101027; x=1793705827;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d9Gksr16Ym7a6rQh3BsSgLKtbW1PN6uAQD1PHStu3Cg=;
 b=JDTp3SnK5PKN+qA05ZEzWhvONndzrp8tS86GKm90v7hP3YLuf54g+cw2CBTDpyjvsp
 NEbqLnjn+hYgcZUpwBjVYuvEIL4y0sDvcZql3nmAjBbQ/QQpVL2fNgnAPiKGRX/nDhNm
 uqmwho3k9vNRjlzzs5sY5xyG5nKYLukAlz48oP0tHn9nE7CiMb4R5nZpFaLabBcgHzv9
 QlKIlxv7HckUYX0Vk2vuKnUsKoEn9DOjlTj6vpSXfh/UL4TTxHbVM5bLeSAliCSlJeHc
 55Jk3gmq/5m/BeiFYGLnwjvCng/m0S1Zk99mVIcKOnmb0wJLp8KD+IcOPUciYefBnE0m
 j5IA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzi7eyzaXUT+tzViiXM75ToZke0obECiJ8KET8R0lij/so7H3pQNAXrmeFA3Rdt6+7A38Ruzu9Ge7M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK1IYKseNILLxSz6H3Fj+ZpmC+uCLyxP+fi7Tl9ks+IjMNizQtv
 VC0oHaZNh15moy3gBoKuOiYxbhLL56sVNVOiGh8RAbpQBNl9NkoaOudt4z/1qqPmd/mjZhbTy5A
 sTOapsnQ3iuYrh2cdHAWP0X4Walfps/qzteXhQQy48mOB0Y1v2o0Ebqp1/zuXgeys1iD0HzU=
X-Gm-Gg: AYBFou0MbuS2adh2wc1J2ySmLepGg63rEZu8XlguQ9xxlhuS/z2FyU6zmIcv8rAyYYl
 GtMw6Ps3sL7q+iyB3z1S3vP5WZl5r92woK5OeIReq5ZakPjnYsnN7yVJW8RaTq3hNiU9PrX7F/A
 D8hdUf15wL30QMJCD51H2pLoDPsjRnvL6KnJ7jaMQKoUKq72bC+WZVRERYfc2+QfIiCEzy5is97
 ma61bV4UWSatB0qpHHcMtQTEvLvVCQzFSoGbT6jQwh0xxVSU5pKJrisE/HPSeCd5/sktvO096cj
 BZ0Z61OiRDWbtOMtaNGQnu92K4r5VNd1iMLQYRGFpsPgk3gH6lE6PclrXAiCXRWC/LX3wkyqZDm
 ANCTK2ShSydCj37QrJMtqD/6iCjsKRT0YDaPJNt3sRM6mZCDXGADZWpAevxNZLxKRkmNBmdYEyG
 uLwYzz9jizG6n2
X-Received: by 2002:a05:6102:644a:b0:7cc:25bc:3b20 with SMTP id
 ada2fe7eead31-7ce5ccaae68mr2852921137.7.1793101026945; 
 Tue, 27 Oct 2026 04:37:06 -0700 (PDT)
X-Received: by 2002:a05:6102:644a:b0:7cc:25bc:3b20 with SMTP id
 ada2fe7eead31-7ce5ccaae68mr2852880137.7.1793101026222; 
 Tue, 27 Oct 2026 04:37:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a8930dsm2093206e87.46.2026.10.27.04.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:37:04 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:37:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 21/23] drm/msm: Support KMS backends without a display
 IRQ
Message-ID: <jmsh74ugfivd6ffwiqvofwnkkxnu5z67hqdei7jarhrftvkgac@hq2e5s2aj7fr>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-21-7cf014efdee1@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-21-7cf014efdee1@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfXxPbZim6O5gV+
 WDPtVBodhE+7SCWIcjkBfp9Dvqc7NRK8QUauCcGWq/nN2xjgGQPd/FSZ8gUJyfnFKtFwPmMj9tL
 nxeT08wB1e3CGc/gX/9S/MTx41iFYHZwWhYKGzmLj2dQg51Urhdobg+UXeQfdxyeiLSi1T/HWIU
 h1tJXswS3Uoxem025JggzJTmIJWY0U1fEfmwcMNnwbd2pJ4yasBd7yb2+49XoHhAFIJGuOUROrX
 plzIym8I98FG9TM4C81whu+hI1aMuzheIHOOTLcwtkCQFr2F1NUihBvhi7AiZdanEs3Ubgs4NXY
 fbuQoq1KOBYYsdHFsX6xwIYzaTyue4vSg7nsYYrRoa2mayevoA7crBpLvPzRvcVA603Pf8MLuDX
 Oa2jpXLs7dfyePTwauk3zvrymbTW+arfyhykihI0SmY0QdL/ya4u7pCMkfoybRtt0nwtLQy4l+4
 rmZtsANuyGJSOSgnang==
X-Proofpoint-GUID: rkkzh01loOEHdTzGOMN9GauOP4f4K9y2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NiBTYWx0ZWRfX1VY+R38WZaw6
 MwgKXIfzBp0x2GPmckwVTJwF6QnQsxYA1dRsZ3nFWgbnIY88qLnN3krMoR/DEEJYWuGJJ+5M2bO
 isRvylJswuSGwqp5fBOFklblypR0Wlk=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae08ce3 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=auR94sGctrba0TjZuGkA:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: rkkzh01loOEHdTzGOMN9GauOP4f4K9y2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270046
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 11:51:31AM +0530, Jayant Shekhar wrote:
> Some MSM KMS backends receive display events through firmware or

Which ones?

> another transport and therefore have no host-visible display interrupt.
> Rejecting such a backend during common KMS initialization prevents
> it from using the MSM DRM framework.
> 
> Allow KMS backends to use IRQ_NOTCONNECTED. DCP receives VSYNC and
> frame-scan completion as asynchronous HFI events over VirtIO; its IPCC
> interrupt is reserved for power-notify acknowledgments. Existing
> IRQ-backed KMS implementations retain their current request and
> teardown flow.

With the commit message fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry
