Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FED606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PV8EPPlP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bvDC3D5Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AC6310EA7F;
	Wed, 11 Nov 2026 16:51:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCBD910FC41
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:51:13 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF0HGC2316234
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=wBAAd6ypHpzxF2jT/1bccNXb
 O5jGvqIht6KXoRaEevU=; b=PV8EPPlP8R/QMTcciijD/zUP18PFiVlwC2PX/1xK
 mK2XDM36iH6gCRs02RXJ3lGqQvXO3dG+90bDX9RTuy2jw3vDxkX/axOKDZZLgtvs
 MhrwT/WBJnBDGNJ4koKsYc1bsZqI07HYvkVx802EzJ/dntPT5/TVnFRdKD08C5jJ
 dqHrE3SL3Uk8zLb5JenoxGP8gV0qxQUsDLI1ak72okG4CjWmQSnrVp/dI8U2KVy2
 +6zEcPtoSUdAZzvza3iewWEafmj4HcKRLwbJzJQaAdeqY0yhWyH/hl54jADuF2D3
 VSDRd2Mqi8aFju0vS/VTlBW8BrmoCcV5/MWIgo0U7F30RQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdrh3s6b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:51:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f2005ce21so652194085a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794415872; x=1795020672;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wBAAd6ypHpzxF2jT/1bccNXbO5jGvqIht6KXoRaEevU=;
 b=bvDC3D5YmYrLbf7CZvMurc7jccKZXYrtGoWync/Z/6sxST7dHpHBwxA6/AYlDKcmZa
 ygkN2gA6SQsJ4F1cuUXqV/GwfUMhbpOAbwLfNrzLRsefqt7FjBuFCsDXSklr0bEMWxJm
 eSnhK+Q3K4XPkBhkHSIan87azfRK1ju5UFi51ly7QzfbugQcXoL+2wHVKgk7D3G2KuI6
 0QM+lJ0BUxGS7SQwed5m4FSUi/l5caz38FqC0HART0cJOQV/75nGDqlMJwqPKHcWcCtZ
 Ai8+QlW5SSvzaUjAoOSUx/8xeLiBQuy5M0Fuz5i5chXPjbsd0ejeR1MQomu42hor3kvU
 KU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794415872; x=1795020672;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wBAAd6ypHpzxF2jT/1bccNXbO5jGvqIht6KXoRaEevU=;
 b=IknFl7X5j9775fiKLIFaJtUaL9364h+Q7bll4kRA3dHNkart3QV7JZoet0gweEtAF5
 aHCdUeoFF2cLIIJ3pAF+3d5kHY3Qd6fstG6SkJEZA5k3wSi3o0cCs4UCbLA4UlqouuWh
 WoMa6bPePGvfZ4+jBzu8m3S+HnIonU/utaYHB2Ac2vxmwuzbTyGutFV64nhOEtoNxM3u
 ipUd0u+OeG/I3xBotkVtMOcvMKmE46IdeJ8+n5Y1kVbKw/fKtd1WdXrpbCadUv0v2Gb0
 XkkaIOhJDwLsT6mE5y1948s0x62tRDFQsMxwoE3ke48ZEa2Jeb3kH+jgs2yZ8Z+StOle
 54yg==
X-Forwarded-Encrypted: i=1;
 AL+hErGr+BjZ3gZlrO+JqY3rjtKYH+1aU2CWfqwOiT/vhmLBE3KKlwxobYSICON/AAFNVw44VL/vYbwe9kM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+S5+I/vbqllKxlGrJTYFaBqpiKYoS7kOVoQgeamU87a+LPz+/v
 yACOhPbb6ejerV+4I0uHDIwLKj6i/rx698HNNY8tci2lDKZd7ZiCNN7m+kaVQp+dUZOxoDnhd0H
 DpkeprfEtCtpyOIPLIEQavfkr7JG8XPyKq/vdazBJ/9cHwRrAWNQOlnkTSXUgX5Q9QujomFw=
X-Gm-Gg: AYBFou08UogsdiU6f/D5vEoCVW7lng8jgyXct5DpB6QsOh0FZmOIdkjmz3niQNCXtGO
 P1vYpnWh/F/zXuYWWPFAxW/QBOBTQFVZ8Fe+nnszjngKD9T1KCtqaunjOQaN9z3L8oyyYBVmhnd
 Uoq5nfKeQI2HWkV6qsVZCDJrx51JfRBSmN+2NjTHtIyzPtBrIcu0DH+eKO2EwBwopwQqUlIyh8c
 qiz+Ju9gMeGDTGwLbzJZr1lbulMf7lya8qNlImeHY7UeqLUaTY6aB8GM06xgELUbETzP8HiGPP/
 gCd/bGxS4a1fxci4ZAR0JH5h9I8WZ8stXV+wCIZyQ5HfKjj/wdJpIOASpDpTJctfc0OYgGf0mxj
 9QkctxpRocCiA7An7/u2EKin7zSzg4a3/tHrAfgw6BZOZSp7KkjpdkOixrxmTFYt2SNMZtzBds+
 rNoTp5NbqTcPQTxXG9ScKnDBSJV4FM6iZ1GsM3dOhxrMPrRfKrSfHUcvS0zFKidA==
X-Received: by 2002:a05:620a:6cc5:b0:93c:7e9c:3bba with SMTP id
 af79cd13be357-947aff8a94fmr488371985a.41.1794415871999; 
 Wed, 11 Nov 2026 08:51:11 -0800 (PST)
X-Received: by 2002:a05:620a:6cc5:b0:93c:7e9c:3bba with SMTP id
 af79cd13be357-947aff8a94fmr488367185a.41.1794415871533; 
 Wed, 11 Nov 2026 08:51:11 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c15ead140csm400318e87.22.2026.11.11.08.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 08:51:09 -0800 (PST)
Date: Wed, 11 Nov 2026 18:51:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] drm/msm/dpu: keep SSPP priority order for split
 planes on DPU < 5.0
Message-ID: <f7rshy2tnugyeuvjuxje23qnx256x7rqed2sswt5ewfaqntz42@ajnsw2t4sor2>
References: <20261010-pipe_order-v1-0-9d8bd29fd78a@oss.qualcomm.com>
 <20261010-pipe_order-v1-1-9d8bd29fd78a@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010-pipe_order-v1-1-9d8bd29fd78a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX+jxy0fzLilH1
 5xZmKZRk92JI3movAFljoMoBQ68rmwy53fOl97Fv//vIfgJECKCxiqQ+Z0YM2l5ExFLlm+V2NCA
 B1pKajCxCd1ZfRqVRIWD7xQCy2Z7LFA=
X-Authority-Analysis: v=2.4 cv=PoQG/AM3 c=1 sm=1 tr=0 ts=6af49d00 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=vBrEaMr6vtUGFZbctIQA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: cAxh1LT0kIDwxYe56VAm6-et_knlGqY6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfXx1xzJm9t25C3
 IAYPk5CNsooWJF9/1iOeC6awzCOalU8SN9nyQN0csIjdtNum3t++tgNoo0wyqY/Mmu7flxvRky7
 Z4YD2/vOPj7ftdhu3V8NSTImM3ga2NSOnZ3xMT6AIoga92FuS6sccN0YrBtvyMLOk6Ml2+qvoNQ
 Na1RfK1pPzoJ075RjjjTf+RJHHSJlrOhkPI68Rwu0l/v/DPy295KMhrDoBkPPVs0vH671N2cSXM
 1fJYu0KZ8ujDVIJI5pCmqwIB2DyJlLjO9zWPKsdsjZWNIkfa59na5VD77f99gZzOl7U6Y+4/079
 ul62Fpp9FbMBsBAbt3WzvhG2v7NBPr8h+MlWJCOg1JX8YHU6dj3X3m3RVe/SC/tD3GAMikIg6ou
 cLYUOOiqkxJRNuPpMs7vz8K7TtqJoMNMsRKuuOztYFgkF0mrdJRhJdakk4I6DHlINT67kcVA0ZJ
 i6Gq+NzDxAdNhOI6Vfw==
X-Proofpoint-ORIG-GUID: cAxh1LT0kIDwxYe56VAm6-et_knlGqY6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110067
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

On Sat, Oct 10, 2026 at 07:08:21PM +0530, Mahadevan P wrote:
> Before DPU 5.0, the layer mixer places the higher priority SSPP on
> the left of a source-split pair. Priority follows the SSPP index
> (VIG, RGB, DMA), while allocation prefers DMA, RGB, then VIG.
> 
> Swap the two SSPPs when the right one has the lower index. Both are
> reserved with the same requirements. Same-SSPP parallel multirect
> already puts RECT_0, the higher priority rectangle, on the left.
> 
> Fixes: 8c62a31607f6 ("drm/msm/dpu: allow using two SSPP blocks for a single plane")
> Assisted-by: LLM
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
