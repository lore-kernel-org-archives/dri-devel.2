Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D01FF60F4
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B4510E25B;
	Tue, 31 Mar 2026 17:56:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LGrdtndK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jazHwV+N";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6836310E25B
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 17:56:13 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VGdRMv2724190
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 17:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=MCRugPqLYDDnJKePiagOBNR7
 ITOuQlv7yXrdfNsjxWg=; b=LGrdtndKWiteP5dEpa+YYymmgDQLA+QvshnBpBEJ
 KYozNYCbI3ymcYYiX00Ri2P+u23uzRjFp1d9q1LVzoLil+B5Gi8+cNuGaFZ+6x7x
 F5uSj1L6u0xVrmlQtWMKsuiTA4ltgxYp4N7o3ZP0FWFalust2rlWRH5p8uz5XgdE
 A7IOQQiscH2IEJG0ZUUuc7z5pq0Y0br8MM+P6CcxbRr5nXE43drAbeKPAtzN0Wox
 D1w2MjlZ8qJGBoScYamCSWRlKlN8e6HlyHvIxt0LYBv4qxyKNUEa08imYSf4WpTG
 GnNiL/HEqez+F0/XPIlyLa4dxvoqSE4Cq+f/xADYG31epA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d84bfkybq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 17:56:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b31cff27fso55485491cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 10:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774979772; x=1775584572;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MCRugPqLYDDnJKePiagOBNR7ITOuQlv7yXrdfNsjxWg=;
 b=jazHwV+Np1tdJwO+1pnwMrgTjR6hBo+MCW6u402nPj7yiPV941GeJRLSgoUGclf27/
 uHaMdO/4dft3fXk8a3ZzmQiEVEPNzb+wgQL0y2TDFJwmaT7Fp92rK4mXwo7+69lWuQkj
 aedMkKjegtHCNtR8yT2zSDWlfkLWDguJPFOAQAeAce+qpM/51HTOkGhqd5eQe8yBQp/R
 agY2hgeLFpT6hjriUkGCc7mICW2zS8sCnkFJVs7BgiNueyeo32TC8c/CMFoavIx242XZ
 9Z1YxSf//Q55OR+mahNniMq5dmq4hZQVOtKudAoxPotJyDADBlzAJ6/PLe2qT5jOIT4k
 aEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774979772; x=1775584572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MCRugPqLYDDnJKePiagOBNR7ITOuQlv7yXrdfNsjxWg=;
 b=G9ygGJ8Z+jssGOZ18mgiYIxPvxdyLXASwzJi/4xew9q36x8KBZCp01h4/OXpAHSojl
 27mGuh+UmrVpTtQdurvAPfdRKxFPrzgqYz6fYR5rNxYCzYQVc0cTcIJe6zNHhgoZ0grS
 2ANuItbWpRxvnPtMJYHXaBPCvs9pHgcgxl94BBrZwwG1g8ubE/ftv+IkWEdtyRsympEj
 Nz872tRDhUYSXXsRwPBYmyuD7XJP5/U5yQiH5jB7pdanD+8zOWullSoTYP5bBKZUrrVG
 YUIRVAJ7twuzSzs9OC6O49FwTTXHtXU9rF5HnkKRegwit09K39AOvASwd5mPyPSWEl/Z
 m32Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPXa/tYKo3T+Ams32ofP3TrH/qhx6OC7Xrmd2IyODBN5YF3wH8rSeGW9rNCTnfNSpEjrQKk2GlsSA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzhyqOWl6Y6FqdWzOElBwFTjWYkuuohTO26Ynr173oOXEMxlJNZ
 PE+oJlbVKvePjAyS028L2hSx31g6Dl6y0VOXVC3SZeCpWQgXvKIjo3ZbpavMHKpB2Vr9jBi2qiG
 VWq5zBwThyRAn7cKcJMkq9gQBcX0Fk6FpqIBksZG+OtiBB1fdpEx6pvL86O8WvMe6SGY+WaQ=
X-Gm-Gg: ATEYQzyvYLYX3xlbsUaPBX4OE6+soiM4pX/awQJ+VXA3NKa4OKIO9SEAImH0WlWVuxX
 yzq57w/ZFj+mAO92xEbLsG4/yhR4i5bm/Iq6p6l8NP0aorVLCb9AkUzq1E5JPlPy6Fqr1HoInHt
 XYEeOtRl2pgzELl4nFmthmUt/nODaT+nKbOVFvRX+xW1ggB4DdyrTK++A2l8ZtR0NZP7CHEtyDx
 L2HA1KA8UNnMyv6+kH7z0pYWI21KkIMi0QsismaAUv7pK1b/GwJKt+UyiuQ94iz4u7v8xZSp0k/
 j9ewPnGc84aNg4i7oZCG6/+JYhiySgYxR4fggKWDBFjeLibUDQF3+H0ibvxpEd7q4AA/tw2XjoT
 yRQin64KmN+IdbE0BMi0gV2e8rrbzSWQPuegPK6LAVpjQH+e8cy1VjOeOnwKxtVnifWoKhEshmQ
 UGv3Cb9HmJbO+GIpiyI4pmrxpB6EmwzOMVzps=
X-Received: by 2002:ac8:7f4c:0:b0:50b:4e57:d3e0 with SMTP id
 d75a77b69052e-50d3bd95174mr7175881cf.59.1774979771827; 
 Tue, 31 Mar 2026 10:56:11 -0700 (PDT)
X-Received: by 2002:ac8:7f4c:0:b0:50b:4e57:d3e0 with SMTP id
 d75a77b69052e-50d3bd95174mr7175441cf.59.1774979771353; 
 Tue, 31 Mar 2026 10:56:11 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cc0b1a3c7sm1640311fa.36.2026.03.31.10.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 10:56:10 -0700 (PDT)
Date: Tue, 31 Mar 2026 20:56:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: eliza: Use Eliza-specific CWB array
Message-ID: <luo2sjt5wkgoqtym5nfhvvrup677wnzbdwjxafgj3wdigblb34@cbjhnco2rhbw>
References: <20260331161156.211623-2-krzysztof.kozlowski@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331161156.211623-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=INwPywvG c=1 sm=1 tr=0 ts=69cc0abc cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=hKC7iyroczjhHUBRElgA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE3MiBTYWx0ZWRfX5JEGucu8C2TX
 53zpbDlYY2dEpYD49Vtoge9/DxfzDn9kVKbCjm9N1T4d6F/0Z+5T4AoTXaaePUeCJ8CjrKYtgGF
 zrAxu/R7yOLiOYHHvrhEMbLO9L8viCatT4VtItBnmnJS1TU/0l0RSHI3CMh0UncFVyph9t0Izt5
 j++o5X3ZPqdZbSU0Fy8DpYWvBY8nxKe71hDBoyMHsP+cyi9ybPhvhPE/BZcoUPCYXLM+urfgScn
 nkc4kaVk0AVo5NDiK83NP6FyZRQK8crvp6IQeAeNx+5L3eayk/VqIWKcjznr3hugEBtChtm7CQM
 MOdMrMG50VDToZsReiZCTaTnxdXutT01Xx4ZHuadWtTO5pZ8yn+/8M6GQ+va/qViDCl4bKpFJ1o
 p9jhBc/sswyfrTbkBSXTnwRG86iACnVKSRMBiPp4WDmPzvmvITi+qExD8z+LS0jO+n7hFb9RQ1h
 uxpWnX++tDbCPRjGxRQ==
X-Proofpoint-GUID: EWd-is589ilMoZvbXDHDKQMyQi8wpein
X-Proofpoint-ORIG-GUID: EWd-is589ilMoZvbXDHDKQMyQi8wpein
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310172
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

On Tue, Mar 31, 2026 at 06:11:57PM +0200, Krzysztof Kozlowski wrote:
> The driver references CWB array from SM8650, but should use the Eliza
> specific, which has different register space sizes.  This should not
> have noticeable impact on function but is indeed confusing, since the
> Eliza table is used for .cwb_count.
> 
> Fixes: 0eb707bbc7fc ("drm/msm/dpu: Add support for Eliza SoC")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Fix for a patch in next.
> ---
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
