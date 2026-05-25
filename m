Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8416CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 243AC10E5D7;
	Mon, 25 May 2026 08:16:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ctBjD0x9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CIi4E/9M";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 159F110E44E
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:16:28 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64P6VjGW1202108
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=PzwDc42oSGK3wA8tbXCjeEPz
 RyLZP/AG0iE+6Xq9eIc=; b=ctBjD0x9LC09J09cPaX0KfmqpZxW/9OirY5FgEZI
 SU/Rxw6roTXO11ufnW4IeJwchJ4rzZqjLjmWyZ6mhX5TvGh2k0RK53+vCuz86SzU
 Wg4xXAvaVuS3f66Ey8Twjp2cTp0aRW3MPsxyDScb3fj2nx1TLcMvutXyCBO7uHOu
 yEXQGIHYcTldGzM+9N6TC+UDGV7cwhib9G4SehuKybwffjhgnchXDBbcb0zY6kjL
 5MsxqCKAG384s82RXLvJkXdVrdvbRqKQMJ+M6vt1HgZO93rfcb6A/4LkmWi18DJd
 UCA8qBnu8Ke4C96fK9+QfQFtwHjYK9r8OytfqfnTM0w9Zg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4aswrn4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:16:26 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50fbc70cfbdso54192341cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 01:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779696986; x=1780301786;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PzwDc42oSGK3wA8tbXCjeEPzRyLZP/AG0iE+6Xq9eIc=;
 b=CIi4E/9MqO/b9rs8RiWQmAQiYk7hsJFPFxFsIFOgTIAU3lP4Wq5YBcYFiwGYhgrdJ2
 /v/WtsJ/k4gINhcbV3NLvStUa5Reqk4IEljjxylLrarVu6GcCld6lqPu1AzxUYg37nm5
 MqiyuMlKTswV/DxmJDOaIlj1V5LdpAyziq8Av7zdUe4vA2IwwB7v89OVulaqZ5kf4TKR
 7qkkOCI9TQ3gj7shY3wYFZdAMrMqyQBLOhkm+8s4qxO5bUCtIcy750jixaqj+JydQxZ3
 e41Ha2n6KwwPWAKT3JceZK5AUmKsq443nWBfMzWh3QQ7A3J3qxyVP9wbc9WQ47Q/xyM3
 TXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779696986; x=1780301786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PzwDc42oSGK3wA8tbXCjeEPzRyLZP/AG0iE+6Xq9eIc=;
 b=bDiE5XFsonhPnIe9Utr28W/Ta87BWIScNWOvSHqawB+S3BgI2GJAj2s04KGqilM/bu
 6ZcTNvUJlBzFv4jnH+dKwZ+vL7BRp46214M3PQdxxF9HS38awRo4+AeUj6VfHP2y/X99
 Lg+SOwpPvH59F9WJw1wvuAN4WISyG/yCBDvpfdZI3dR5sRSp9DomZwjR6C+RCTIrdi3y
 i9Y6vMzfnbULJhArQ2pY9U2crZQHpK6haPXgneLBXH+P+NMAzqYMOYAYZG4Q2i5Lxjvi
 8QGg+Yr0fPlo2U9DVizDJYf5uXTTuwwNDqCkAVj7vT9AVtoHVhTxtml6YP85fE/oNlh9
 zkBA==
X-Forwarded-Encrypted: i=1;
 AFNElJ//F5IaOgxjlLQGXLQXzFHgqOCz0FvemyuZenw0y3HdKW7x5FWAikN+wlBkVGy94GNPXUGAosiJuME=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJrHlU0OIs1KAB0HPa8FN9MPbLMhMWhv2j0qb1CWxIU6WivrnZ
 SJTZ0dLt6UbZjmLVUnBOcwWayWcHC4r1fI66OnbjLEyZjQP75qBi7SEVALCvKi42Lr6leqPVY6z
 sv9q/bkzsAV1gY7JH5ZTQgeNSYKDME8qMvQAm535uynslhjcPQQhHDcv3aQb8OhpHDX2t49M=
X-Gm-Gg: Acq92OEAxkq8IjUz0rRKbQcuPPOIKrrplMjAab1VD7N/JfBqvCEZtml+tiNaOjyhqNX
 TTzcwr+ilEjgd92X5vT9AWFILJ3jIP7MvOyubB0xstnlLTt3PdD2xscOmWB0bauiOFeSdFXEFc+
 T0TXS6oldjqkF95piq36CaRw8vaemyX1ZttRQ9MWfRtYfw47QL4jOvnX8OSJxhKNTCgBXAPlQgL
 c07q5fmREn5o/5UZxjooMZIo0KRq7MQnFspj3sh7xddkypL+QERO6XQSBAuRp2Npn3m09+//2Yi
 7XdXY09dvWKDUQgFIhyo1icxUX5T95AlrsFYxhAH1MdKvBtDgFFnQAw2aGQrx4OHJngJfia0/45
 7dOjXStcD+bKsNoK9tn7/ArG7TVmtm0U/jU9vMgcMm+n1QXHwOQ66YqDRo6h86frAhb4r5OAeMc
 LuHNLLzm32GuORVd0Rv3cbSCefvPiZyewW8Y1Q5xYMPn87+Q==
X-Received: by 2002:a05:622a:144a:b0:516:e3fc:ed8 with SMTP id
 d75a77b69052e-516e3fc1314mr105077431cf.46.1779696986386; 
 Mon, 25 May 2026 01:16:26 -0700 (PDT)
X-Received: by 2002:a05:622a:144a:b0:516:e3fc:ed8 with SMTP id
 d75a77b69052e-516e3fc1314mr105077201cf.46.1779696985957; 
 Mon, 25 May 2026 01:16:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395dca5e9f0sm21947981fa.10.2026.05.25.01.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 01:16:24 -0700 (PDT)
Date: Mon, 25 May 2026 11:16:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v4 14/39] drm/msm/dp: introduce max_streams for DP
 controller MST support
Message-ID: <35ihusx26kilj57jz4pvb2skjfp7illtdsx6gpso5icwaq5ppy@wuersq2gjjkv>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
 <20260410-msm-dp-mst-v4-14-b20518dea8de@oss.qualcomm.com>
 <s32w4u44y4jhuk4c4qxsytat2pdiskzuvbozklhofpjh54r7pc@2i6vvbaen2ur>
 <0e39dd9f-9858-49cb-a052-7d0791b694af@oss.qualcomm.com>
 <p3jfi2cxevvdtqathqrpnxdkzrwuna3hojovfjvdni7zvjec24@pyvaubeq77qk>
 <33ab5c3f-5a6d-4d81-b310-760ac519bfd1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33ab5c3f-5a6d-4d81-b310-760ac519bfd1@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA4MiBTYWx0ZWRfX6DrElCL5MW39
 cbsEiZDQHL1CSzAK7oLNB45OAH21Y3hlcB2HlnBec8/VI/bTbZnD5XqPzDa09dtDRArialXCkzV
 K774ZraSFP/h2c/p/LWCXmGUTZhZYvhxDcipedaBJ69BPrcZv+SJa/OA3ZhARd5YQkb3Ft/G3Zh
 loa0qKUeGlVX/2Pwz03G62YnepiM1X08zmC9zJ9YK8chcvrkp8KDJbWNeRL01+o+0H91xb8AKhV
 QB5SmhCxFbIbU3iFVyPe+qyLGwDhqkXjiX8JBv5etwWzp9Ucq9kLNleSpj6c5Kbj42IlXSMJnWH
 i0d8tJK3eVnXLC/F1aTnijw2E/W2PJRH0nlyCyTG76dDjSCU+gWB2zUlrgY/jE4TmePfqUcTUH9
 LXmYJNwv8giLb7X3k/n+TVgKSEj5rXr/2ClKHHHezICcZ5ytn6Zj2EZU/qk20ZR67KiM2y6f62U
 idRgIZaKTgTbwpG5XMA==
X-Proofpoint-ORIG-GUID: 5lzkwyNwB3upTmFbhBBZ1TYNu0ZxlSe-
X-Proofpoint-GUID: 5lzkwyNwB3upTmFbhBBZ1TYNu0ZxlSe-
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a14055b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=COk6AnOGAAAA:8
 a=2bpceZPf395pHnZbQo4A:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250082
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

On Fri, May 22, 2026 at 03:58:06PM +0800, Yongxing Mou wrote:
> 
> 
> On 5/21/2026 8:07 PM, Dmitry Baryshkov wrote:
> > On Thu, May 21, 2026 at 07:34:32PM +0800, Yongxing Mou wrote:
> > > 
> > > 
> > > On 4/12/2026 1:59 AM, Dmitry Baryshkov wrote:
> > > > On Fri, Apr 10, 2026 at 05:33:49PM +0800, Yongxing Mou wrote:
> > > > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > @@ -2740,7 +2741,8 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
> > > > >    	if (rc)
> > > > >    		return rc;
> > > > > -	for (i = DP_STREAM_0; i < DP_STREAM_MAX; i++) {
> > > > > +	ctrl->num_pixel_clks = 0;
> > > > > +	for (i = DP_STREAM_0; i < max_stream; i++) {
> > > > 
> > > > Why? I think the code was fine with getting up to DP_STREAM_MAX clocks.
> > > Sure.. will change max_stream -> DP_STREAM_MAX next version.
> > > > In fact, I'd rather use that instead of the hardcoded value for
> > > > determining how many streams can be there. Think of the old DTs which
> > > > didn't have extra stream clocks. We still need to support those.
> > > > 
> > > The current logic only assigns num streams to dp->max_stream when
> > > desc->mst_streams == num_pixel_clks, otherwise set to 1 which mean sst.
> > > I would like to introduce a switch in the driver to control the number of
> > > streams, rather than having it fully determined by the DTs.
> > 
> > Why?
> > 
> 1. In some scenarios, even if the hardware supports up to 4-stream MST, we
> may not want to enable all streams (e.g., LeMans: 2xDSI + 4xMST + 2xMST, but
> it only has a 6-layer mixer).

6 layer mixers, not 6-layer mixer (the latter means the mixer which
supports 6 blending layers).

Even with 6 LMs, there is no reason to prevent users from using the
hardware in the way they want. Any artifical limitations are NAKed.

> 2. Currently, the DTs for all platforms have already been merged, and for
> some legacy platforms, not sure if all platforms MST will work.

You are a part of the display team of the SoC manufacturer. You can test
the platforms and make sure that MST will work. I should be able to help
you with some of those, maybe except the MSM8998 / SDM660 generation.

> If my understanding is incorrect, please feel free to correct me. Thanks.
> > > Do you think it would be acceptable to use:
> > > dp->max_stream = min(num_pixel_clks, desc->mst_streams)?
> > 
> > We know that num_pixel_clks <= desc->mst_streams. Otherwise DT is wrong
> > and should not have been comitted. So, the min(a,b) has a known return
> > value of num_pixel_clks.
> > 
> > > 
> > > > >    		ctrl->pixel_clk[i] = devm_clk_get(dev, pixel_clks[i]);
> > > > >    		if (i == 0 && IS_ERR(ctrl->pixel_clk[i]))
> > 
> 

-- 
With best wishes
Dmitry
