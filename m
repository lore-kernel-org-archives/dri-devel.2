Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5D606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dSx13RSA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZBEcPvFH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777F410E0DA;
	Mon, 26 Oct 2026 10:18:07 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73C8C10E0DA
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:17:56 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4abPw2222724
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=78XFvnCPVHn0LabnIkSaSmfw
 7iCeIi7jK9513VDUmZ0=; b=dSx13RSAlAAD4EUSzR9AAOMLfIHAGtEyMLOfHTRS
 pN1Vr8xV5aPEqcZmnOE3vw7Xw9+63iVXiEiPsBrFbnxmiJwqMyMPdo/DqFUzAqr8
 RFjb/wlh3sKurhr2fnnUukWrR3BZhHqQ6XmUmStb8r82aNvCS/EiKDAI0q/nGBuc
 ZpksdOnmhTL6RGYy2D8KTRlt85jKkJcXOjJlVwUsZmrGJK03ka8ft6g80aQJRAlM
 H0Uquj7iyHtk8J6zPfdK47S6h2LwhINz8FAes8aYQWRTbDKcJDFZcoXeqZIbKY+c
 nhWGRw78uQYZcMREksvGT+NUr0ZnHfX7P86zYTo0o7/STA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd9n5r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:17:55 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eac74b0596so2914713e0c.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 03:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793009875; x=1793614675;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=78XFvnCPVHn0LabnIkSaSmfw7iCeIi7jK9513VDUmZ0=;
 b=ZBEcPvFHv92SYe1uS4ss2mE2JwN1JLEmB7l8s9wgl97szmlal7LEEwM54yz4Yu2YLr
 mP6qR7wQnqNNn65O7hQFNn6gB7t8DXWyRDF8Awn+H8pfGb7EMYH5GTGXrlAodB3SafFD
 Ath20C6g4YZ+z4NITGAnunKHpOYHaCuZAl0Ic3xwpbMUnUzaLEzE5MUmyC0VyM6z1t7t
 DAoA69KoSBQEO1mCX2sSNldTAZqsGxgTTklQE42fmCdyS8uPSu+xQUOhjPWruymy8kCY
 o4pa13+Mm30svzgqupNgW+GIOPOtGoELtT0zux+32FRc7zrkcYtZooy1R+G8UUNuNn0J
 mnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793009875; x=1793614675;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=78XFvnCPVHn0LabnIkSaSmfw7iCeIi7jK9513VDUmZ0=;
 b=RFtPeyp0Kn2zhVzHelRadgs8PCwObZxkxPORGAFSpNxC1j9C0CitEjjw1v/guWXrkC
 OppQM0nljWtcSgjRDafByQxZyxKjFD+2hb0ao0xOwQhMlo2auWi1LgICs2jK0UG1/xN6
 cdkrKtlpQLzHMPREgQpk/mmU6q4cX5gUvZV6X+3C5cdHtpX1Ms3hBuVaPtAlhUG5H2H3
 kKAwKFrjHMbKAoeUifqMSXhjiERlHZ08O6y94Irz/h9KFq1a2glRyjhPkXvQ1KGFMjiu
 0tnqz+YezYpn//zDf5EsInPkIjW9/GsRftzYBTCwg3eFx0K+bCZ5LFG5raUvwp3sPA9q
 SWtg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXXo8UyNldfWEAmJYJpqqCiSy2IWHLfLe8wzABm5iEnDHAaMR+pTr/ldGKqJDrJNZFgGY0B//Lk1g=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIf7ruuttqdDaXHSqAA+yUNJ2pewHHH95Z7tbNciht/TKlbejvW
 4Y63SjDo1bZ2RVbeoUuZyFI+KTcZ0nUEtQaWlZxNf/rq7u/7ZdgiloM8YVMH5Rm6UTSttJp9pjb
 qqvgF4TtCeF5M6J99jrqCwO7/lfzpKN8abL83K50hxtY/iVt6XcIgZDK61GQio6Ro4Pu3Kf8=
X-Gm-Gg: AYBFou3n8fhnaQyP2uSXMI1XPN0obuS0KPA+YfEqqos5Zaa9KC92BZud097Uwe+zmMq
 okzMz6rOxXmICf0ZCDzQSvwA5uZEgET4v06fNnyLlfRWgFWZiz5AL2zMo0OpUbimj5xToB8deVU
 jjX04U+BL825V8OebY4V0YXAZRadB7fv+eV/eisDtxCUuItdxGk169XFMn+50L2SAFLkm4mT8EP
 ksXk7bD89jP7XdTyJudRlQ8VItxcYbI0RfeKqRjH6qiehEaGsBM5fecijPjxTXpPDZtJaU2lAzg
 5dPCQFLhKXZN9DSX861WdYv2Z1CfYV1ZFmpB9MPXC+bLmaqvDAn+uR5GLX5DeTBEa9nuL/ieGhf
 O5F2KQjC+Z/1HVdZ4AN85BCGquKnTtjr6Ko9Pv3uxYDNqIQ9JySaOF/sOuv83XNEkOcHaA6dUi9
 IOyD78R1z7b6Ku
X-Received: by 2002:a05:6122:130e:b0:5ec:20e8:45ff with SMTP id
 71dfb90a1353d-5ec23319c0amr2162240e0c.21.1793009874701; 
 Mon, 26 Oct 2026 03:17:54 -0700 (PDT)
X-Received: by 2002:a05:6122:130e:b0:5ec:20e8:45ff with SMTP id
 71dfb90a1353d-5ec23319c0amr2162205e0c.21.1793009874219; 
 Mon, 26 Oct 2026 03:17:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709d0606sm17076351fa.14.2026.10.26.03.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 03:17:53 -0700 (PDT)
Date: Mon, 26 Oct 2026 12:17:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH 06/13] drm/msm/dcp: Add planes, CRTCs, and HFI event
 routing
Message-ID: <rdaviyavkytkblgqjqp334mtluji4t6ybron73wm3uv5hdbvjf@5uxq5hb4fclw>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-6-48aad0fe4f72@oss.qualcomm.com>
 <x2ppnksfdan6yehawencv53qttcxznr367iuaw3ltwttkoffkx@ccrzx7alvdpm>
 <7ea3f000-086c-49d2-8409-04d5aa6e9ded@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ea3f000-086c-49d2-8409-04d5aa6e9ded@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: OGlD0X40fpEc64FUcnpQ9DhsWZ16JFbg
X-Proofpoint-GUID: OGlD0X40fpEc64FUcnpQ9DhsWZ16JFbg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfX0yAMOqJPD+QA
 3f270aIjUV65bNzRNKA/Jly5vLUoAoEVZCqGXVd0HLmVgr3/W45DxbBYkCX7Q/qfll9zjG2yqed
 sn+lHSwiooo6XLY0lZH3sSZgZCJpldTLSzDhQGl/5y6z1LLGgg5xIAmkcq9BfChpNS0btGqDeVX
 uNa0vO3S90+OtcdQZ0XNM3tnxpk1xSzrdSnvGniwC7TJ6XX43s19QjLLmYL3NJaT/ePABBnSS7c
 6OIIFqXadp3M+906YQfDTKIg+kNRbncc4QhTlrDb1cuRhzc/ltfPn42enL5Qlp/u3QyXDMyeT0s
 XizI77Gdvr2F8620XMOXglGH1JgSkDsWiemCF5n9MxOmmWYPzdCZGnLRk7OMhXwgTQBXz1on6P0
 XEYIM+vtJ3w7ouprLEf8+qUmUnDw+FQbhtQ+pJGZOeghSwsOS9e/uGa+YdczJLnprUX5MaSvLNI
 gye9X5068Ls01j/W13g==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf28d3 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=_9fECkkFWEdeBB18FusA:9 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfX+lbvNe56bvIs
 E6SOB6NHfdyYs5b1BznrfsxHX0ghuo7Tzy2HMuNID+2e7r2QyEw9vOpKXvyHM+ju8UfhvI+J3Pz
 /5hkyNwWR57hsuUY6bFt4SAPM1TxNM0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260040
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

On Fri, Oct 23, 2026 at 12:41:15PM +0530, Jayant Shekhar wrote:
> 
> On 15-10-2026 18:48, Dmitry Baryshkov wrote:
> > On Thu, Oct 15, 2026 at 01:08:26PM +0530, Jayant Shekhar wrote:
> > > The firmware-owned DCP pipeline still needs normal DRM atomic objects and
> > > event handling so it can participate in the MSM DRM device.
> > > 
> > > Add DCP plane and CRTC objects, validate framebuffer and plane state,
> > > allocate firmware display pipes, calculate bandwidth and clock votes, and
> > > translate visible planes and CRTC state into HFI commands. Route VSYNC and
> > > frame-scan completion events back to DRM and retain CRTC-local display
> > > session state.
> > > 
> > > Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> > > Assisted-by: LLM
> > > ---
> > >   drivers/gpu/drm/msm/Makefile           |    3 +
> > >   drivers/gpu/drm/msm/dcp/dcp_crtc.c     |  733 ++++++++++++++++++++++
> > >   drivers/gpu/drm/msm/dcp/dcp_crtc.h     |  104 ++++
> > >   drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c  |   27 +
> > >   drivers/gpu/drm/msm/dcp/dcp_dpu_kms.h  |   49 ++
> > >   drivers/gpu/drm/msm/dcp/dcp_hfi.h      |    2 +
> > >   drivers/gpu/drm/msm/dcp/dcp_hfi_core.c |   21 +
> > >   drivers/gpu/drm/msm/dcp/dcp_plane.c    | 1073 ++++++++++++++++++++++++++++++++
> > >   drivers/gpu/drm/msm/dcp/dcp_plane.h    |   60 ++
> > >   9 files changed, 2072 insertions(+)
> > > 

> > > *p++ = lid;
> > > +	for (i = 0; i < HFI_MAX_PLANES; i++)
> > > +		*p++ = lower_32_bits(iova[i]);
> > > +	for (i = 0; i < HFI_MAX_PLANES; i++)
> > > +		*p++ = upper_32_bits(iova[i]);
> > Who has invented this? Splitting addresses into two distinct arrays.
> > 
> 
> The field order is defined by the firmware HFI ABI, not chosen by the
> driver. struct hfi_plane_buff defines the wire layout as:
> 
> u32 addr_l[HFI_MAX_PLANES];
> u32 addr_h[HFI_MAX_PLANES];
> ..

can it be fixed before it is landed? If somebody made a strange decision
it doesn't mean that it can't be changed.


-- 
With best wishes
Dmitry
