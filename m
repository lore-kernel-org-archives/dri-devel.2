Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA10DF99C88
	for <dri-devel@archiver.kernel.org>; Sat, 18 Apr 2026 15:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C2C410E095;
	Sat, 18 Apr 2026 15:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y4edaRWi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T0pzalkv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 065FE10E33C
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 15:49:37 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63IA1NGh701254
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 15:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Z0VY8RVhtghe7kLXnB/ZJHlb
 XDKlFoNE8WK6EfPBUsc=; b=Y4edaRWiJ6seoYfn3p1K6ABfdL5982i3mmGG4krh
 s0o5Tiqhwm5ZVXpoYSMs2Ejk0x8kIaIp+xYbDQUGXUv0YKFsO3l/3yRnrWHaGmIU
 24BC4L9XbHb+cvRDKUIV/yvyGYK5PiTKQUzKA+lNGrtnggpkwhlWO0fC4Ygf4dI0
 HkLJLw+1saMDvdgh1KD1b5i0TSqUEn6/hasIgtHtZuqyE5gh3uBUFAjUxWLSgBrS
 P8Cskyf2sLNJSdC74FPC5ukVF5UNkVw5p98vZVHmJVlIMVLpPcQhloMCw4i3O68n
 U9j6UFfzAFmuzMvFSu8qVDpMfpU/DVpU9FV2LC4/8ccLLg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm1hx148x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 15:49:36 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-953cccadb32so1882939241.2
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 08:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776527376; x=1777132176;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z0VY8RVhtghe7kLXnB/ZJHlbXDKlFoNE8WK6EfPBUsc=;
 b=T0pzalkv9aG4T0qH3GYIbQQm/JyaBf+LysZOzFzsGGzNi6ReVNWdCyWBZCtfpvefC7
 fVXUMub4cXpoblvcT/VJBidMrgsXsGjbd3zrO7T3n4V64TQmaYMgKqdOqf6GHw3NsK5S
 vLAg3tfj1NVFrbotYzaoZO312k+9JkZh6IRnBmSUMR9CtdhF6rvxrdBNyDSRbRoCcOSp
 1B6gScAQ0WmNnUbP5VYdToUEMsU3E2XvQcWsvIy4VRglOQr4r19AqZMKU2JaVaw5SyL6
 en0/WCgSB6373AyHe76biIq9igeFbWFR3ftG//tkjBHgxzMwZhZwot2PCBmx7B4UwIZt
 t77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776527376; x=1777132176;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z0VY8RVhtghe7kLXnB/ZJHlbXDKlFoNE8WK6EfPBUsc=;
 b=UvwzKBuKNUJyz6JYsKmoaDX+HHoGDwv56FzWK6dezaIcij4w0lofekGpvGnmF5rvq8
 5V7/EZY8BpeV4LFtBGnoz3ruOlGKKZIiLCAEDDU3/OlZPP46nxy0LzYwiRGss3S7a6ig
 FTt70Oy4PcyPaDi9V3zjCm7NE5lnPZ4jlq9pV9ATl6FRoslgHSeUPOchHEIpBAKsj3kb
 c+/7zBTmi0YS8UpFbXJBPpeXHCPpQlKRuD5iSJrlvcfEBRt66QFl5Ce4o+OacNuBa3kf
 0dbX710tIUpoOMHcRbtuEcRe+pACS2Jtt4pxxv9528XmPQH9gFcbozYeidNNDnenbJot
 TKaw==
X-Gm-Message-State: AOJu0Yxo3vvRyJiF1XwCvmSGQJfXR3D6ibSnu5YxMsKiPDjEqRf3nqAM
 TJz3i8BefWoTc77PwVlY2h+r0d7C8HYdLT5g+3OWdgeQ5LUmx2o43/aPyIrB4EOjihAzJjW2Hzg
 My/sy8tFFTwAe3c0tdybzRwn6yCiwmUA4zXr1TO0xj9lLIyOlBYTt1lrvzkR0OlFgSzCHHLQ=
X-Gm-Gg: AeBDieuNucaIEzznNAVkbt6UC+VRHxahH5AscVVhrKlczavnT6RopFQ+IfCMkZtHaO/
 8wzYp5e7mokcxEuCssJGmUWWLtAhHULV04UfK0rSujBFMjNjg+vZAn1Osd6k2fVpj/4hNiIq9Gy
 a0SijMs5mj3bRWqjBGLLr5ibFUmk4sMzb0WxS5z4rDI8LF0acgA3+zRIvcCfJOv16edzF2XBAEA
 1WTdbiej63eRg+YSXKL+mc98KiFwf5x9ncrBu/M6cKjpFVh+KlOaath6BsEB5AEF8SLSz4G4xTk
 eBbCe1UA/ijCN1oS97YbTUkPyZ9O1TlO6UhAt4czilmnS9KK5Uk7OVcUN980AFJQGkORDvu7Snk
 Kr21KJnTgvndXPBBN5/koqBSR+EPfsFkCAZ+PO/nPgtHxJTxhcF3L+BzQ960mCT1NKqLP4XKh1p
 2Le5EgkNi8p/TULGBELuq+Vr+t5939PCh+s26EOn3uMY5Umw==
X-Received: by 2002:a05:6102:2912:b0:5ff:e39d:9f93 with SMTP id
 ada2fe7eead31-616f4e774e9mr3399715137.11.1776527376345; 
 Sat, 18 Apr 2026 08:49:36 -0700 (PDT)
X-Received: by 2002:a05:6102:2912:b0:5ff:e39d:9f93 with SMTP id
 ada2fe7eead31-616f4e774e9mr3399702137.11.1776527375912; 
 Sat, 18 Apr 2026 08:49:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb6f0d49sm11771471fa.19.2026.04.18.08.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 08:49:34 -0700 (PDT)
Date: Sat, 18 Apr 2026 18:49:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm: Correct modparam description
Message-ID: <il6i7pazbbum5vxufwnhpkt6p2vh4kuxfhqs4bd34dfdp22pj2@z6hhdpeczrkb>
References: <20260418150847.157246-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418150847.157246-1-robin.clark@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: omSlfTibXBXiihYflETTESNFxwG3xk3v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDE1NyBTYWx0ZWRfX6huPCO7XS7eG
 DT1X3AJv0sPTJQEOVmjWLtJIeav8ubKdPptNYWoza+zhAI64LfXpHpmpn0urbHQX9nChtLw36pN
 FILJQp5Vh4EWSEV4NeclqKhRgGn3fZpQENwjvV3zYQ5f4G0La2DJkdTyzwAikO/uLR6EgNuSyOf
 fdnaO7OgDKZZhMoYxiPibG3CleCt5+5Yqv25d9Ff9dfP45g4TGTSeaJgp3Wble+PByRby/nlYRL
 lVVc6Q1UmPehDmGkBhjTnlxb+vNk4wHTofWWmroWOqysGREVB7M6gENOmJ8422OgpkNhXdQkJBl
 ldXOHiJlNLeabQoxL2vblit2y836fT3JFSaSOofvuvUSOgtw/yl6eqKt/OjTIbpvA3zKEOa83sj
 IU9fKe078X8fzdfP2FDI3d2rReCLk9T4QWGKbO+umeV+q2o2qhE+kbvuazWQLGKKsHwh4gT6/NC
 Uwrrp1ee/2Qx6GncU5Q==
X-Proofpoint-GUID: omSlfTibXBXiihYflETTESNFxwG3xk3v
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=69e3a810 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=eahPDGdU4WHvPLAXGaEA:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_04,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604180157
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

On Sat, Apr 18, 2026 at 08:08:47AM -0700, Rob Clark wrote:
> Preemption is enabled for gen8 as well.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
