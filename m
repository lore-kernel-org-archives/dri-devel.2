Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066DFCD4F3D
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 23:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DAC10E043;
	Sun, 17 May 2026 23:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UX6B8bSt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eJMtyzX2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41E5210E043
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 23:08:57 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64HLGeZF647347
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 23:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=2+QMreGSKWDtvbWKY0kKo3Q8
 eK91rzJiOdDRbt2/z2U=; b=UX6B8bStAfL+AxDCZQ9SGk3YOJra027naAtlG3Ud
 EyR7zaqw1/o7s1dvGMtw0dxMAq3hw/NBWRGtkG4IvaFMEpsYNRaGY/TjxkJHs8Sg
 5alUELVpfYk0OqUxCxTE4h+axvltTPUUzKqze97xTyyW/m4sGk424R4plAwJcrK3
 MMhAMUEY/a6j4tge/YYR3iXawtO32LrX5hwj5useLSm+UnznV8etwVIxukPJq+kD
 6qbayiSjGnY3ZxV7O3TkigwTnxV/rYg2sR64ZQi6zx2dzxuSgPVKy+PyzWeUH9k5
 sxIu81g3MOoiOQgguJA766dKL96UbmV97tu5ry7Rw11ezA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6h01krs2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 23:08:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50f13da9684so18760641cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 16:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779059335; x=1779664135;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2+QMreGSKWDtvbWKY0kKo3Q8eK91rzJiOdDRbt2/z2U=;
 b=eJMtyzX2DVTz1EREHJRaXNwr4azF/u4diLMu3Bte7wpDPmPpUg6ff4jb5d22BkDvXN
 U7ZO7/PEQQ213B3ZFn1i4eMGkS34nt5XShACTVATBoX+Q0ypVqoJVAKWYGB0rs8EtQhO
 7bnpHWU5pNOhvDDm3omddZHSkb5lzls//aGCMOZsf1wiVoA3VnGfod2TpfTgCWZPaHO5
 UH3lAioL8CcoOjmvz8v8HBXSQgPLwGLO2gP4/tLjxv/gDyZVFlBSRHVXrxu0I9uDOJgo
 p7+fyJwofVmv0SYfAGwAwFsU9oXMuXSgXL2S9RocDs/i7Q5VdjWrEp1sa+daJ3F8hIM5
 Nuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779059335; x=1779664135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2+QMreGSKWDtvbWKY0kKo3Q8eK91rzJiOdDRbt2/z2U=;
 b=lXcC58q8O7oVCHax7nP3sJoAJll6KR0v6CS0hwsYnMews5NhsolEzLWUPQWVjnT703
 kSmlyq+bakD+rOBTrKNEiOK9j/cJFI1fwcCIxwImvc1N4SQUmI5Fi6pRsnKXFMMteFey
 ilfjrbkMYnMWurkoa1nZVflf4X5m4DHsLIlQWxIX5vroP0Jc7vPo84rB4WZfuhiGar10
 GfVOCblEDgT+VJgqQ0wdTSGmGK+bpPzsQrc9vCx/BN52v1APxXitVDdvqF5OAl38Yy8X
 YXJ+oFVpSvTneKe35qqBgYwZJv74rvPTdq4V1MO22FpHT2fG3R4vVi7kqpkytvl8kYkZ
 a6xw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GgZgwzUs8waHaSvTvw8i+RmypyXDo5HZ9kfybTR9btXORiTbR6oiztQ9aS8IbGb7BGhyrMT4oal8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcmiUyLm7M23zEdv44p+wVP3yL7mExB43FCQ33sFdHrghQRv6p
 ivQP1op+oDw1YFIJXOslBZ7O6HXOOKYXMYNwhzDvjIGxsaDvdzmMSw2n4JGnsDt8WKO+0gS+TaP
 HJUk47remiXTlOLO134zO8jHLK13jvb8yBooiLzMn9mXH6CDgIQJSOHYl9bHcrrnBsm19PmM=
X-Gm-Gg: Acq92OFhyFwTRS193ZpS0ebXYnzr6wAH673NJ6TA/0zTL6xiqpmieZRNdOUgQkqZ+qY
 q1VZjo6xfRdunkSHL/Vnex76gvpYtxO+Yc+VYo+CJjm/Cs/d8oLmGgBl5Kc0nRvWHJzhVFgA/Oq
 UxLJGUAZL28XbRtxRhQazEMtYT8Ps3eMFaR7AXvbdhARw3LYY5h9lW1loHovGSJ3bBAAYOIgjGW
 /MMNdx1fJPJnM3vEGX+Q7HdGB4YfQW/VzqnZCALrGCKzD219eCAyel3H2FwWC7TSGDXWyY6w9hY
 FFmawqk3BgFM7FOM6+BrwPgABxiTNGB7lrUQ+77SYf+fvpSeohTsqG7JgSIWiR8MnNtIGM/UAXd
 2hAZ7nGclbf72A2ZPZJc1Nx2gzf6WC3klOTX1PeTAkXJ2YPnVjsECn5XKguCQY2mBYSe0StF1/z
 YZS6swh//T9yKYIbgpEQAbKRwQYHTi6F9HfTo=
X-Received: by 2002:a05:622a:8584:b0:50d:83d7:686c with SMTP id
 d75a77b69052e-5165a1dbf16mr142646611cf.31.1779059335445; 
 Sun, 17 May 2026 16:08:55 -0700 (PDT)
X-Received: by 2002:a05:622a:8584:b0:50d:83d7:686c with SMTP id
 d75a77b69052e-5165a1dbf16mr142646311cf.31.1779059334966; 
 Sun, 17 May 2026 16:08:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c8b2sm2933313e87.17.2026.05.17.16.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 16:08:52 -0700 (PDT)
Date: Mon, 18 May 2026 02:08:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ekansh.gupta@oss.qualcomm.com
Subject: Re: [PATCH] fastrpc: Reduce log level for DSP info and reserved
 memory messages
Message-ID: <cg526ebtmnboqpw5aabwrtmoc7fhnvc57dmjax5zltcjonnazv@pynuwgpx3bi5>
References: <20260514062825.50172-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514062825.50172-1-jianping.li@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: q9hSQw0FxXimaJQ4KMQK74WPgWrcvfZK
X-Authority-Analysis: v=2.4 cv=XbG5Co55 c=1 sm=1 tr=0 ts=6a0a4a88 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=R5-0t05Agtt0UhhjQosA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: q9hSQw0FxXimaJQ4KMQK74WPgWrcvfZK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDI1MSBTYWx0ZWRfX9GBkj9lH/JsF
 t/FPs2L7wLlYjyqG1etK9OoELS4Chb00clYPOzW77EIIJX18Iqs6s/n/vupB6iNN2Mj2ACH+alp
 V/xO4gYsl78yxr/KKR7UPn6JX4H30vjvRSxJdCOzocDqf8KkpbwxouSWimwwyHWZ4z4ZgCs2VaW
 DZc3K++AGw2jERYYreYZ19nh12nDsrfVj5eD7woxhJ2mFi9iL4/LTMYRaNi21Y0NXqkH16iHUiZ
 oE166lof2zvuW2WejQxRunccS6dZpr9EtfbDwj4w5HloWv/gFi+wr9BvaQ4w9DWBN8OQ4ITBukv
 mBZSlxz4jyRtJXiaiQ+R9iXu12IYE9C1as73iIGRwq4uBCmRRLjneqW27P776L74aOJ6hKJHQH4
 +CytL3Tk9O0Cz1xiAP8KkTBexTjr0f4L41EzU1t0DL4BDPjQx6rHYSD9xYvZUWZ09MQIdJah1uq
 Jrs6kLOwy0VJAeWUIOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_06,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170251
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

On Thu, May 14, 2026 at 02:28:25PM +0800, Jianping Li wrote:
> On some platforms (e.g. QCS615 Talos), fastrpc may temporarily fail
> to retrieve DSP attributes during boot, resulting in repeated

temporarily? What does it mean? Should there be any sync with the DSP,
letting the FastRPC driver know when it's safe to retrieve the
information?

> "Error: dsp information is incorrect" messages printed on the
> console.
> 
> These messages are observed continuously during boot when metadata
> flashing is enabled as part of RC releases, causing unnecessary
> log noise.
> 
> Similarly, the absence of reserved DMA memory is a valid
> configuration and does not represent an error condition.
> 
> Since these scenarios are expected and do not indicate a failure,
> downgrade the log level from dev_err/dev_info to dev_dbg to avoid
> flooding the console.
> 
> No functional change intended.
> 
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
-- 
With best wishes
Dmitry
