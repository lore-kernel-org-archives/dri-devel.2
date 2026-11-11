Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CAC606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DGfjdUv4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RDOVLtv2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0082910FB75;
	Wed, 11 Nov 2026 14:06:58 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4FC010FBD6
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:06:45 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABCZ0AI2338048
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=VNI21V2lgtz8Hzxic3v5KFi0
 FrkQQXKocGAVFanNboI=; b=DGfjdUv4+0wwjmeFWoYwb2ro+r/udE3aAA/oqPIw
 ZKWbQgx2p9MmF/XtqTK8XexmCYHJOR7R/XRdRSTqGcu0HBlrXXXpt3/Nd5VS6/kO
 lso3tYXcgIEoYmwFeRDrpKM+UQlHiFM1zwieAElsE+Vv5Rc4IwnfgZZpxUtudSin
 lBcwKuyvjdygaE4mj4rCSyRdR345eGIajAF21QoB8T4C/Kce8aLTEjUnxDmJWlqz
 WW+3dMRg+8ADOF57x7GKIkKYuspxTxafAMVTkWNATRAyS5cen7N/CbJdz6xOeoKF
 1Uihh/sP0TXwyTHX6d6U899uXiR5q5j8kX/SRUFNbU6uMQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnmaxqf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:06:44 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-999bc06bfd0so2256739241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 06:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794406004; x=1795010804;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VNI21V2lgtz8Hzxic3v5KFi0FrkQQXKocGAVFanNboI=;
 b=RDOVLtv2P93j9O0943sMLAmaPHBqRdKZgL4oZX0zSIfEHPVPB+cMmweIJYGse/vOMI
 ugjDkxW6R9h2B1tUYEu3+PkLU8djDHURdIKzUre+tbNcWtipaqqIhONNoRVAOHHyPyLI
 q7ZN6A8e13ruTVHYLWxviMxIjjLgYVi3tuwRMXVoK68UjjhHWMUltJcL+B0Ap1l9BrRj
 nZTESO0Id0ec9VfuTnjciDmvuCUvNZ5pZo9kAYy7+AZ/H4aiybiqj/8u6ObuvhqjnX/Q
 mswa+a+74EvH0wKzgTnVwDzwWX1CQONO177PXRD293QRWiaav9QPR1B/mtNmuE+ErTfK
 Nv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794406004; x=1795010804;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VNI21V2lgtz8Hzxic3v5KFi0FrkQQXKocGAVFanNboI=;
 b=w+oEmA7fPzNizV8ILBtUz2wdz7wYoyvhYGxDm1o3Dz2/5eAY+rypB2FExtj6liaW7z
 MirxG7sINAz55Yafywh58b4xr4Y2Q4E5woo4VqCcQCcEq75nQpLoK85MS6iF9HqrEkEo
 Oe7SLyplu4/QUVXSsBcWOak0qiJHFwlgMGLklR7Sgs86ZZKn+cFzmHDOOGyBQGPg1yGq
 FFB5JirdAcJd9kDxPOrcy5f5NjTIXMungoNqpV1paV61+On7upH0a2fw7ssJlzCGoY+7
 p2u6rvqyO9vo/clBSUmJTbM5jKPbTCvSfC61+A0clhK3R9B6bcw4JlBKBKIZpHmtnIMC
 P1uw==
X-Forwarded-Encrypted: i=1;
 AL+hErG9O4DyXkCcdaWqhCQeJUSlAe5mla7ZSvK7rlxnA08DhNmWCGZZA1a7Dt6cPj7gefYUN7SGiBdnuCg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Agp4PYS1OTRD3OaJGCZ7u/Igczu1SeRt+boJoD4UjEu20sngv
 PKZD9IzMEKh9f/Pj+30rD79TTP61nrkWM1CzRgqhpeu2/OTx7VUbl/9m2qafz0xdNlfP1cf7m6N
 zmecxTMVFI2hu36YUAbiQOeSbc5GMmKahpa9uQdKOD6BBm6264e1R+KYdYHGsZVYm1faA1XY=
X-Gm-Gg: AYBFou0rsDHJMuVn70B91i1uUdqcSbQb5RVfwyf/wMSOv9QEOzA8uXzsijdiuFln0UQ
 dPKo/IU+I01F4onVUnJ+NKiqEAd/D8ttRFwbwTUu554DzU0rFhG22EDFr+eOIjsgGWv9spVtzZb
 YQ4xQlcJtJiWurbhbf6fpYSo3v4UZLc3Iy+gtGny3TN1vstZnWs2w6LiEzEH67IUYglCK9MKx/o
 /z02LEBjapkcSOa5C/EghCae4oGoG9llj02LsNFaHdgPFvy+gWhjvCs3vYfflLU2eZVRumMls+3
 l/2IuKgneCTks2Yos4mgUqaQDwG3S8F1swKy2g80+P20pjcaNyDv7PNWvbNQjwjZcXRY+kT1gWk
 XQN8knlhkyJddoUxQdSI0s5+m3kDovQqrAuIKr2Xh1wqnYfK22+BBgg1N9b9oIS9xu20qfOT6wJ
 A5dn8dZifFDXmaFcTw5vXUfMOts0GASViv1yc2N9wnduYej0VhW8pKs4Uk9xsxYg==
X-Received: by 2002:a05:6122:179b:b0:5ea:d10f:2394 with SMTP id
 71dfb90a1353d-5ee1c40c764mr813239e0c.10.1794406004212; 
 Wed, 11 Nov 2026 06:06:44 -0800 (PST)
X-Received: by 2002:a05:6122:179b:b0:5ea:d10f:2394 with SMTP id
 71dfb90a1353d-5ee1c40c764mr813200e0c.10.1794406003823; 
 Wed, 11 Nov 2026 06:06:43 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c159702ae0sm815407e87.20.2026.11.11.06.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:06:42 -0800 (PST)
Date: Wed, 11 Nov 2026 16:06:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: naidu nama <naidu.nama@oss.qualcomm.com>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, mani@kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, irlied@gmail.com, simona@ffwll.ch,
 Saurabh Anand <saurabh.anand@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 quic_riteshk@quicinc.com, quic_vproddut@quicinc.com,
 quic_mkuntuma@quicinc.com, mahadevan.p@oss.qualcomm.com
Subject: Re: [PATCH v2 2/3] drm/msm/dp: Remove redundant force_link_train flag
Message-ID: <gfzdwaeouexratptiktpzodi44x6ztsfttqajzr5wxtrluyqjx@axwlv5jlakcc>
References: <20261111104434.2222182-1-naidu.nama@oss.qualcomm.com>
 <20261111104434.2222182-3-naidu.nama@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111104434.2222182-3-naidu.nama@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 8baRjimApFJn8dipp3nBREi8rFbqUD48
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX6J2ct2/uLygh
 oR3vuUYftSSbHG3GmbN4sYvm4CmXOkiiZv6bCliNxUtmtcL27+W/VcHbmPlfUgmnvA3FhxAc51y
 1zfd5T29xYlG8AzLiVV3xzV9x6hnjG4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX7l49G4mVFNjC
 bsoBAs8NZ1zERa6Mf5wqLMqeaJCBeh9Mkr3EGvxPx8XJjUR4jU5c0fApPSrkLzEK/SWInugJ/jF
 7vAbNk0YjVBKlmiO5EEHo2ZqMJm2S7eC4VCE/pQqOXPuoNcxHsoVs9HKEDTCMSqXZMMvEKtgQF6
 UsCC6fsfgCJXlCzQOw9jwiWOibMYMQcNQ8TqhV15/hyyBacyveydAVcmEzuBNwrTYyeOZgLofod
 y/hZawGU5ui1ugIbevg4HbOlXdgv52OgIstcrDTh3G3bB/J8WkFFr0vAZLHyeaTEsZGe2YjfUHM
 6Z2QYZ+5aYArBXSqICwDko3cmiOS1vCnZwX7iEbUH13EqeUFoKgMSVAFz7ZemwOjiDsvwNQiM6/
 i1/sU0BjmQxFgjmoe/PAyC0rsM1NAjTJE/DUcIFNgbjYMkaLAZhzxaVJmyBpHW7/e4Auqqn8Awv
 ddm/TV2zJ0hrnSweK+A==
X-Proofpoint-GUID: 8baRjimApFJn8dipp3nBREi8rFbqUD48
X-Authority-Analysis: v=2.4 cv=MpzHeGae c=1 sm=1 tr=0 ts=6af47674 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=uVK0n7524QBmBBgzDoUA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110056
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

On Wed, Nov 11, 2026 at 04:13:54PM +0530, naidu nama wrote:
> From: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
> 
> force_link_train is always false when passed to
> msm_dp_ctrl_prepare_stream_on(): the initial link is trained by
> msm_dp_ctrl_on_link(), and the flag is cleared before stream preparation.
> For active streams, it is never set.
> 
> Remove the dead flag and parameter. Stream preparation still retrains
> when channel equalization is incomplete.
> 
> Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 5 ++---
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    | 3 +--
>  drivers/gpu/drm/msm/dp/dp_display.c | 4 +---
>  3 files changed, 4 insertions(+), 8 deletions(-)

The same SoB comment.

-- 
With best wishes
Dmitry
