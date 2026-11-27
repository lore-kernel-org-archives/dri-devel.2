Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18274606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J1JeHqHW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U7I8qB+y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 225CA112D88;
	Fri, 27 Nov 2026 20:21:49 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A803112D91
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:21:38 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJAtAB3982326
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FTlq7GHXu5G3li22pVfzinks
 Vn7ret/unNe16lYihL8=; b=J1JeHqHWBSTXS+pQ6GMIXgEGMf+5zeOjvjEzJIRR
 lkH6M5YruAkk53g+9BVQ4Y5WCV/qyxuOCGXdoc/ukd68CJ8IMEUgMZpGHhqO68Ll
 ZgBS9h3TP9wfIaO2UO03HMsXwu934LJ8CrcouNw2UB1mJBecG2QcnzCG2OVM0uuy
 hCaGFd/wlvZtP4+tpsYg3BPLdaxFPj0pHGxyeIAPxDPvEuo0t0N2yywGWqRZXoKk
 Xm6bQxUZ7sTIBlJIgz0XC+zuBxhAzGxqSdynMr17IUMeY3YWfBP1qhj4pqzMAGOi
 eivYbttTNwRevEX8GnXnw0II2HF4Dnmd1VkJYT1iIizIcg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7f6d88f4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:21:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9495a1f5e47so1253100785a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795810897; x=1796415697;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FTlq7GHXu5G3li22pVfzinksVn7ret/unNe16lYihL8=;
 b=U7I8qB+ybF74TFFR+sICL5IcI6BdI2SlVEaixmgO1ogC4eRGiaD+MdJrCOLHIzzR4K
 5mxU7QtSzTtE2YHqDEAaNZfoQT5y1FzwSvSJtmEiR6Uylojkcngm69xKg6Hlg/rHxpjf
 Uaeyyy/70Jq8rJNACOh4sgvsPmiwXWa0vOoLjP1u1/VHxZsX+0OfqDKDedBjhl1Qd9nh
 ZZDRMk79xxt1bFKRqs+xKp0W53V/ZF7vgBKQC5q+kmsoQfH5jnqVod+GcSzJt+aOC+ea
 u3AxIcKf0C/QQfWGRZdjqjDUkbeBCr2tyM1f5i/I+oPQ+9bZItr9eEuQlulQbpRJ8ZHM
 DPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795810897; x=1796415697;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FTlq7GHXu5G3li22pVfzinksVn7ret/unNe16lYihL8=;
 b=G029kr+tzLIqzZJL527gkUg/T9OHG/GBshPVSsAi17Tmd4VIjdgPCJRcKVvmKSvw1b
 x+ja8t0wnq07apM1NLyMjRFbC2k95pyPeL7SGN838RiGRmnJo1hjN0T7AnHhTV2RZV5b
 snONFnL4HAHiFaVj/+1M+dl3B7WvykclsYH9//7WxtBtghBq6iCBF1rXGO9jM9JZmzvk
 OECOJQF1mCwh2e8jVnJKui/xFgLrnyhXwuX7kcBu1uhDRkuVeZoHWsC38s83j4I7EC9i
 PiUVBLzVRN//jAtrUU5M5NhFN5b+saT1HgEB+wEB+lJxwoougI6SXNKxMbqnJrx621rc
 C0cw==
X-Forwarded-Encrypted: i=1;
 AL+hErFImTy9kBn/mNl17aNioO2WxtHYrwEoJW9USFTlfC5xh5XHgqorKoCEhJ7cqGSzCH1058Qp0dZ/KIE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Y3Gf/+LzJfjFgRD5vVh1pbAUhS6jnGLDQ9Fsbd6OmfeVHbhpj
 G/JMf7bzyJIa+JDjf7L44M/aGyp48IAig74ce0Bf9EbXCyNTeBcI15jQ/QTmteXv7HhuELlZEpr
 Dv2MQ9NAnUgVnHROW6C9Dy7JHck819x8kC6KBgu1mx0wYFn2+rN5PxTjy/n2A6V5pF51fUp8=
X-Gm-Gg: AZFdTZeANcUCmUVIzM3cXDuiG1AEvvUNyTWJAVhu8y5u+Ag268vU4gHc1/Eq2l7veIc
 wrlqCE/1rFQHHFbnq/SRUXlcBYKfDFESXGblO97I6GoFdjnk7YgvSGU8Fu/pdsFHOFEzWem0FIW
 uziz1x8AYhAuJbBWocOpjmButaA+h62b4dbtUAX57eaVyWZm7RPE2uLF+XFHy7zwpp3prtOYLWM
 A7M/PxxskvrUMO6ww7qUPPd6dIfq7Ke2VF/vfpyp7gVILxS21OqKUrML/XiKHnyCDQv8Jq1zVuT
 YVDzlKiXkO8JpsxC3B1Q30MuDV6QggNJXv5DAGqmSW4GMKlVrbrDBKklwoxZPkauV3OrdEGDePn
 Sbn+NEXG8GfDFRGCXGuypKY6GyD9C4D4iWqKOAyFlPhLStK8i6biZ8p0rk4ZyDwHJxfdNLTyyHN
 HekYrAZ4Lr29V84ev0h5DTx1UQ7ZJ01ycyGrmcgZj3/21uCJpcxBBCqm+vE2zSRw==
X-Received: by 2002:a05:620a:4454:b0:93f:18ba:bf78 with SMTP id
 af79cd13be357-949bab1bf42mr4865028885a.69.1795810896762; 
 Fri, 27 Nov 2026 12:21:36 -0800 (PST)
X-Received: by 2002:a05:620a:4454:b0:93f:18ba:bf78 with SMTP id
 af79cd13be357-949bab1bf42mr4865021785a.69.1795810896262; 
 Fri, 27 Nov 2026 12:21:36 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae80572914sm61011211fa.39.2026.11.27.12.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:21:35 -0800 (PST)
Date: Fri, 27 Nov 2026 22:21:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jesse Casco <jesse.casco@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jim Martin <jimmartin@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/msm/dp: stop the rate-set fallback at the lowest
 table entry
Message-ID: <2ks7dqx56coix2wshyo5qin66c6xhzx6bj7kip3sqnx634k7sp@a643crz3ajki>
References: <20261120192050.73315-1-jesse.casco@gmail.com>
 <20261120192050.73315-3-jesse.casco@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120192050.73315-3-jesse.casco@gmail.com>
X-Proofpoint-ORIG-GUID: JCwowt_pOd-ZYttNBKMCDHMQtk2j7p_m
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX2PhqCTXhkZz8
 SbXJ/OyFS9SUQWgT1RroJS/LpC4Am8WTXbXLD69dMIkudy45/acQ8jar/oyB8+wOIonxD37L66Y
 TeHd6UHItd8tzh3nS3WLUMJAOzS1H7A=
X-Authority-Analysis: v=2.4 cv=IKqXmQvG c=1 sm=1 tr=0 ts=6b09e651 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=eFTfMnBmEVDiW-N_mhIA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: JCwowt_pOd-ZYttNBKMCDHMQtk2j7p_m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX8glqBY/Y6oN9
 fMavw4UueVmGhzHl4Q6OBpHuq3wteRgoZLG9fX0Xz9gWv7+WqNTO9REH5Qp3I9Aj9KKo/bblETT
 pNfHLXOcrJ80SbYqk4xgtxcc1b1tMGCu6YJ7OUbV2Hmil2PsvcHXFYMKE++7RNmHqMe8fei6JoC
 TW5CCqJSpPhxG3vAe0nMJCtiOyFD6LU2MVVka2M+p1nrYUYMYYlhwSMLVKmHE0hK5h8Wlgn1GX8
 czK07H8FMicKJHE6w5psIbdgRj2ul4tio4wCFDaFaCHuLcLfj0AqDceOVGNBQH40Myr4lwokshc
 99FGK80T+HiQWMTQJots8BJcA2nvh/BSAkJ/n8E+Q5D/HLtQ1471Y/oA8Mj8gnxpPEE9bpyLVkH
 bbQ7qzU/741GfBAo7xIDPPBN1/Pqt2/XGwOAQxfwDkrxATP6h1i6KmaZpwnAyP/86TxM4iP2hJx
 NRKT90YXxBnGdJKUSYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270081
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

On Fri, Nov 20, 2026 at 02:20:50PM -0500, Jesse Casco wrote:
> When the sink is driven through LINK_RATE_SET and rate_set has reached
> index 0, msm_dp_ctrl_link_rate_down_shift() falls through to the legacy
> switch. If the lowest entry of the sink's SUPPORTED_LINK_RATES table is
> one of the standard rates above RBR, the source drops to the next
> standard rate while LINK_RATE_SET still selects index 0, so source and
> sink train at different rates.
> 
> There is nothing lower to try once the table is exhausted, so fail the
> down-shift instead.
> 
> Fixes: ed100aa239be ("drm/msm/dp: Enable support for eDP v1.4+ link rates table")
> Signed-off-by: Jesse Casco <jesse.casco@gmail.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
