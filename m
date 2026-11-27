Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FDB606A336
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZSBRKhgI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HcCBiXLt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C6AC11255A;
	Fri, 27 Nov 2026 11:53:35 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9672311255A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:53:23 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARAsH8o3609882
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=NvFCw+bmf8mxbl0IMnWpK6+a
 hat2YBHhwXRgKcWA70Y=; b=ZSBRKhgItTfJJ5eGZq+gQQci4hJVvlNYV9R5Peih
 CJ+cWDXcpQtM+zwe9+Fej0v6vNY4MN0/mF9WPnbMVHikU9mTIKbE7uTmf28gfaAu
 twH1UsP0rhrLzdHWgTjvDYpK+8/2R4FZJRDAtfkwbKyGE6jRGmML+dcC2CQ8lW2M
 vxp155bdXqRCYgXxBcXPcelss8Id5r1IHuLPkjjRqDZZOqmMCQeV9bORvLC6OHD/
 eRdsuO8rhM7zwHqpGmCcnHX+Gn8qT88h/ua4JAomxQ6OctC/HjGeUjH4BDdN9Of8
 brG0i7pBSKvCqOaHHurHjdhrn0+1iPqPWnBS/azfiiH56w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73dh9g3q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:53:22 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9495c71055bso589650485a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 03:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795780402; x=1796385202;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NvFCw+bmf8mxbl0IMnWpK6+ahat2YBHhwXRgKcWA70Y=;
 b=HcCBiXLtygaPE06ZG/mLi0xwNEsomk3V9JmDQ8hhcSimqquGt9rp1jqHs7ibEQ6u/A
 K5AoPNuatfJlgJs3AW5svcR1ANXcgzI1vbUYpGQgp06+TCgwpp1BZXKEwQQc9D/kJEpZ
 fdiJWjN16jRXTojn9js/5xqDWgKkK5LVCjd6CK2H8pCRmy7IrKzlCESsSzctJ3ZfmFfw
 F+3AU2q+pa5DyghEvBnOEz4+9oP4Jt0JbaIW4yTKB6DGo+9nq1mxN0h/Q3ihu5xu8/Ar
 r5YPEkdwfAdl0GBWeThv+GIh4AM9xixB9JP96Z5cIdxUQFwXYK85MO9ep4vF9DLjmYya
 z3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795780402; x=1796385202;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NvFCw+bmf8mxbl0IMnWpK6+ahat2YBHhwXRgKcWA70Y=;
 b=lfBpqaXxl69f+fIjabPCwp+ZpeboBZeW5hr3EfFjyfCdfg7x9Pf6LwJSBoldQX/CFb
 g3L5giSVEp1O/DpfVm492IUmejzDX8V6w9MytyxklmS50ihFDNrysTdymj+B8rve8ovF
 HoBWADFr69Svh+KG55qVscuG74y+vDjFWwLejmJK4WMobnOAuOTxLs+MXx4uEOnnRzqT
 kcy7e+3x+7sNzrwKXY2am0WwAKoXuyCk2GpxJH83Ycw295yDr3xOhgpOMbKy4SU9/s+d
 dryf5ePBVs+VOvAtXHwFol4Uw1BWAruXxxODx6M1nmkV1yxgquczJft/Ygpf+J+/zPne
 fVRg==
X-Forwarded-Encrypted: i=1;
 AL+hErGsSaXtAiVjLl1W6qZdxzDJug9mr76r14EpKcN2Ya4N7A687s7m0Y/IiD/Px+w7fiiWipCMsghnJsI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8N3uqJ4MJN4grB5n52Z/C+83sCkzoVlLgd9+OA2yktZgMzXafp
 IqSbIjtrHLcHHEgWWJxkZYrxKKvJO6k8P7c0XfWGXlPeqJMz/c8Sq1zNw3CVLvy+bfX4VnonucV
 G+m3+6Zsb2kNamQ8RCKc1mzxYezmDy5PFUZANwbgRQMsD5vBGNKFKHjw13oyL3iSIrFhceR4=
X-Gm-Gg: AZFdTZdAM16znZGjH6uG6PxZfzCgc4vPZoVoOcX7RAC3hrBMpGIRoC0ngaahB5xzP63
 f5RzYZ+e/NwIiTSrsKy/di4Eyi7jLvH8iZVBeUwyWIa5OMmFYnSBma/3nlh1xBWmVidDgCrytjB
 7oqflsf8w3JOCO9zYSjBpZlQdSYXjkv5zYR5AneaSrvHALcbKIpaVDYCUo/EZ05O6DG4nTVam7A
 YIIQv97r+gGxzIZUYgcvJo9Loo3pknb40m+dTqE0DuHJrDSsU1npSX2uluY7OImYl4goZjFtZZR
 BxBpLB4DCvWgxxlPFQFmfjVomgGo8bgyiSQURigQ2Pkew1IBgA5YpgZysNIE4aqdrYAiVGgm+Xy
 Nf5AJznCRVes4clT1/q5ehKPUG33tcM+2ql922RMyw3iEr2bzhLou7thivnnavtLTjOztbPMYRD
 1WVk5iNESDMgig9QSjGi95Qw5UbzH3ejO41y9Hn6Frm22m3/Sw8u8FOQmJ3G1yNw==
X-Received: by 2002:a05:620a:1d05:b0:93f:5445:c661 with SMTP id
 af79cd13be357-949bab4d2d5mr4286070485a.57.1795780401873; 
 Fri, 27 Nov 2026 03:53:21 -0800 (PST)
X-Received: by 2002:a05:620a:1d05:b0:93f:5445:c661 with SMTP id
 af79cd13be357-949bab4d2d5mr4286064485a.57.1795780401434; 
 Fri, 27 Nov 2026 03:53:21 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1bd081f29sm5910701e87.84.2026.11.27.03.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 03:53:20 -0800 (PST)
Date: Fri, 27 Nov 2026 13:53:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jean-Francois Bobier <jean-francois.bobier@laposte.net>
Cc: linux-arm-msm@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Xilin Wu <sophon@radxa.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Saim Shujah <saimzst@gmail.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/msm/dp: don't gate link-training fallback on the
 controller's HPD block
Message-ID: <tldbqtuls37jgdkbqpi5ytizqhhxmzejbh3iujjg2coptvxgrh@klt2bt2gstza>
References: <20261005131432.22840-1-jean-francois.bobier@laposte.net>
 <20261005131432.22840-2-jean-francois.bobier@laposte.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005131432.22840-2-jean-francois.bobier@laposte.net>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NyBTYWx0ZWRfX2GGzZ7Dixp8k
 Dfz/7Z+4k6cq128mJNiWGse9XTm26t1hMDCihpq5GUfJit3dhmJI3582aDV+4/rY18FWNisLDcb
 eUN00cHmCweewNv+MpaIQqe6PEJ/Wbtx4hGnOgdIyTKW08Lwr9Z1Q7MGJkEv+8RMaQPp6Wn4Yle
 TCmyy9WTxdBm7IJcWsnKRGgCW4X4CwOq4k5j+FVZuv7c4kZBZD5B+h4SiKnYZDquRFMr0l/kk2S
 j1KP0+c4I4Qnn1pGkcAfYjq4gyQM9BXu5BPczMdZpgEOs+DW75+lmrEXm6nmMWYKedwSLQ54EHy
 P2BO4TAouyN0Hr4QgtqUxCZUYUo5sFc3CzpS8SgYnwQ3Mplokr4L3ffvohbATp5QK7DCAfwmfhO
 1EdJU4tmZjDaWHHeQueVcdx9JFZklSvSNznspcUz5gJIM46eXpw7w54pjW1g0qsl5GdYvO4ysit
 fLwFh4dU3VXiIUZlGyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NyBTYWx0ZWRfX5WHvfsiW91ix
 y50uWhvY1fYryIsyoEtwvU+YvJnJBwDTrP/vy/C5JfV3xyNpHtynsBh20FaQEQaX499ADjjIKY7
 x2Bl03LrApfzL0gxkbw0gygn4upRyLc=
X-Authority-Analysis: v=2.4 cv=FfiiV5+6 c=1 sm=1 tr=0 ts=6b096f32 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=AVbMHacnAAAA:8
 a=EUspDBNiAAAA:8 a=6AKRNlzo6MLLK9Xf-kYA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Z8w8RPyABVWp4NBWd0ke:22
X-Proofpoint-GUID: fjkj1z7rxzg7b1ZFngS7Qz_hYZwmERzx
X-Proofpoint-ORIG-GUID: fjkj1z7rxzg7b1ZFngS7Qz_hYZwmERzx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270047
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

On Mon, Oct 05, 2026 at 03:14:30PM +0200, Jean-Francois Bobier wrote:
> msm_dp_ctrl_setup_main_link()'s retry loop is what implements DP link

Nit: msm_dp_ctrl_on_link()

> fallback: on a training failure it shifts the link rate down HBR3 -> HBR2
> -> HBR -> RBR and then, if clock recovery succeeded on at least half the
> lanes, reduces the lane count. Both failure branches guard that with
> 
> 	if (!msm_dp_aux_is_link_connected(ctrl->aux))
> 		break;
> 
> which reads REG_DP_DP_HPD_INT_STATUS, i.e. the DP controller's own HPD
> block. That is only meaningful when the block is wired to a real HPD
> signal.
> 
> On a USB-C port it is not. HPD arrives out of band: the Type-C port
> driver owns it and hands it over through a drm_dp_hpd_bridge, and the
> controller's HPD register reads DISCONNECTED for the entire time a sink
> is attached. msm_dp_bridge_hpd_notify() already shows this, logging the
> register beside the bridge's own verdict -- on sm8250 (OnePlus 8T) every
> attach reports
> 
> 	msm_dp_bridge_hpd_notify: type=10 link hpd_link_status=0x0, status=1
> 
> So the guard is always true, the loop always breaks on the first failed
> attempt, and the rate/lane fallback is dead on every Type-C DP board.
> msm_dp_ctrl_setup_main_link() then returns -ECONNRESET and the mode set

Nit: msm_dp_ctrl_on_link()

> fails outright.
> 
> The cost is real. With a 4K sink attached directly (4 DP lanes, no USB3),
> a board that can only carry two DP lanes to the connector trains lanes 0
> and 1 and never lanes 2 and 3:
> 
> 	v_level 3: DPCD 0x202 = 0x11 (lanes 0,1 CR_DONE)
> 	           DPCD 0x203 = 0x00 (lanes 2,3 nothing)
> 	link training #1 on phy 0 failed. ret=-11
> 	Failed link training (rc=-104)
> 
> A fallback to two lanes would have trained -- clock recovery was already
> good on exactly the lanes that remain, so
> msm_dp_ctrl_clock_recovery_any_ok() would have passed -- but it is never
> reached. The same sink works through a dock, because the Type-C alternate
> mode negotiates two DP lanes up front and the first attempt succeeds.
> 
> Use the DPCD read the loop already performs as the liveness test instead.
> It expresses the intent directly -- a sink that has gone away cannot
> answer AUX -- and it carries no assumption about where HPD comes from.
> drm_dp_dpcd_read_link_status() returns 0 on success and a negative errno
> on failure.
> 
> Signed-off-by: Jean-Francois Bobier <jean-francois.bobier@laposte.net>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 

Fixes: 231a04fcc6cb ("drm/msm/dp: deinitialize mainlink if link training failed")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
