Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDC2606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D1mfuL7S;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iBjHg6n0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2532210E3E1;
	Tue, 27 Oct 2026 11:52:00 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E029410E3E1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:51:48 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RAeDDa3012241
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=4W3OqlKiBwfz5eOJMTRV/rIc
 RtmzZqXVHzyrSvnxP1E=; b=D1mfuL7SsPPdywV1ReO5FFA7LhAPLjwRRqGIXf5P
 zHtT9DGm5cK7aTPGPks/P9Tp3ff5LKQNkHUi1YVw4uQZDKdHMtxyca9OI4ORMxWA
 M0qHs20gmke7Jm1Ro6H3/CpWT8JkzH30zVEyPPuQ0OswNev4I7RQ381fWXOClVRR
 kQX9ZFhdwY6v6uMd2DyCDn12HCMkp8yv0W+efd9Ulldrq7jkk9bxcvNyyaiHrIm1
 yOCyBIWEwV9qfwg1kOiGI/p/GoLgs/KhI2n87VNnAom40WMY+IqIvknE8yLyux3S
 7OOPInAJcEHMHv+WquBkag64NvySmob2o+UL6KSZatGoeQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hje3daukj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:51:48 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5ec17386b57so4105564e0c.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 04:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793101907; x=1793706707;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4W3OqlKiBwfz5eOJMTRV/rIcRtmzZqXVHzyrSvnxP1E=;
 b=iBjHg6n0QuUyUt1RqWcIDXp2tHE0naIztZKKDu1ROn8GUytEnGO/e20llpl1EmHfQZ
 SFTEhuHTJ+0IeauVbqM8A7hs/FHXihSv5QZUueaAMMhKfBYM8R2CGsnCQSJVaStQ427t
 CUd2WTpoW5b5p3ii3eNgfET8Dr5lVANQMzYab+UQ5kfMRwlf0O2qIfZ7OVCqJbTPDBmO
 5AcM2Oq6XAuh7v3IPoxJRuPbL+mygOUrmSgK3aB6SNkADbR5NxaPrVH/oSip6wkQMG2t
 kfxzZvArMvcOsV+7ytILflCbR9ZtCNki+qZupcwKJeDOhR2r20NI9RUSy84zr9q1nN5D
 DATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793101907; x=1793706707;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4W3OqlKiBwfz5eOJMTRV/rIcRtmzZqXVHzyrSvnxP1E=;
 b=q6xUp0/+4l2KpUb0SEd0J354HyuEYeKRIbCEmWTHCZgJJ+sYiAwmzS1iegKFMXdFf8
 dluyOSGEAkr3HreOd8Qe9ManzUhPBZo71qV5HmtkYY5bVVqY8CzN2ern6BOuxXI7yZj3
 Ivc1LWkqoVs3T70vgXCa1SxzgpsgAe1TyURSL7kEVHhgjC5xaG4eRU+TwtADQsq9tOWF
 9Q3amsqx5q4cE29RKoM6GnyuSM0vVvEj51PSoaXvUn2z2zUSRGRg5AE+yE+PdtwnwmFQ
 w4FpoxGAxGpXJAbwHHdTZ18hOiutU26bsRoOewGxkPOmV/6MkB1IzztaPFkkSqC8Q4wD
 Kw1g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVNWigAUU6KT04P/6BOTnCg2KIwRBIeYiXmBq928wEr7r0u1a/TLprmro0+YCUhIIYqO1SF7eA8wA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIKtJbU5jbIbCwMaKYhTuTWf2WaSDY7bJyw3fC/VvhsUpKB5qzm
 +bkp443rhe/GG9fSk/APyV4zuxwqTEsCibSK0NQFBtz9I3544KPcCuylT69fDuNUJ6r8NCL0zye
 GZDbma++g5H6SAF3W/cvyv+pjrJ30x8FR30u7Wg3QCr94RkHxjlJwzzJdO3AdqPd9XCEL0cA=
X-Gm-Gg: AYBFou3X55VMO2DeNatEaJbcq1SHHQpGb/t+DY17ZP5slAx4Uz3YdmrBNQfdaqFNyzN
 NV6o+38RaymQMZlGU2dkLyhKRB1iEilb8GVuh9/jTvSS16BgLzZwxL2dYxz6Aj5xvUQpISejdB9
 D7fSPMh/ELO3zOue+j2uHVgaKxzW1XvxFPLDwvlMnJFnDZ94lpvIULrTNsEikyY5j12D26v92jK
 C/wUg6VvTYNdPlOBnK3YPj2J3t5Bmk4CYMBdQtLh/vXaXYb+l7DU22QmQtsAOiUHr7MnROtGXKP
 lqsZq75jly67XGCiTMMmlmdfcEQPVbKUxE+wneQrPhQDPfQhzSR4wxdE4r7hCtkYsPAzUVEJVk0
 qoUxp1WkFV6kyo7lSrZmRxDOPyFvdKm4vVYzydHsXFRwnQ70uvN7e0Gd/292ejhNWCT43BtqY1l
 PmOOAemKqgrN/s
X-Received: by 2002:a05:6122:6990:b0:5ea:e324:7c15 with SMTP id
 71dfb90a1353d-5ec232ae080mr3936899e0c.15.1793101907198; 
 Tue, 27 Oct 2026 04:51:47 -0700 (PDT)
X-Received: by 2002:a05:6122:6990:b0:5ea:e324:7c15 with SMTP id
 71dfb90a1353d-5ec232ae080mr3936868e0c.15.1793101906693; 
 Tue, 27 Oct 2026 04:51:46 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac70993e89sm24077941fa.9.2026.10.27.04.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:51:45 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:51:43 +0200
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
Subject: Re: [PATCH 04/13] drm/msm/dcp: Add IPCC power notification
Message-ID: <t3vxg46g7jac5th3hrrs3zchss6lzmgm2ga5qkro4cepr3qmnb@ddosuavblhuy>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-4-48aad0fe4f72@oss.qualcomm.com>
 <u7pcn75yh435vuuwqezml37bqfzdztvrywggbmkydkilwe5yzp@myijo4wd2bob>
 <db88a83c-29e6-4fb9-a874-15c0f186e14d@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db88a83c-29e6-4fb9-a874-15c0f186e14d@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfXyncwlS5oQe8o
 lAn5xsx8w3ij028wRPwqU6UjyXPrTbInCKavaByvBt09/AzMS+UteeqdkcmSqyFS2p+2v2Bk4zD
 sfRD0b0J/JI1VsF15y5kJq6nfk79Nq8=
X-Proofpoint-GUID: u2p91h4ny5jC69C64f3apYr3UaNuJTfY
X-Proofpoint-ORIG-GUID: u2p91h4ny5jC69C64f3apYr3UaNuJTfY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfX1iyRvi3J9h2K
 RzfjO1UKIogXfctEC5/hTMIWAzRaDeg5lPoB6aXYMhPxdhkXZpizPEYDXaINl0WACWT4B4YfIHd
 cR2za/OxFWR/pJPwvpcx8A8vUdQ3u/5Cbv7/EYITwY0ajtAnm1DFjHgQABw9yv5asRQZItiDjhw
 8OVcFbhzU/UwbFKyGy+KJmJIJh3HbAw6ePzppC9UP9JsHFxmDm/u8hUoGEn+8I810CH6D3dG72m
 AQ6QsNSaiuIYpTh6va/DWGbE1CbHK25rjxIwzQnZlpwRF2Le/FcVHPMoRUlJfy8RoVLBUaw7F+z
 +BtOPrL4gFZnXJX6FZ6uxudlez0dKCcTx07amk49/xKYs7irsxecfyQpzjR9saSVgJTkdFoMNQf
 JrpQvStehK/k3JmbMGHsZbA0QCNGck9dwtCx0C7gOz20WFhnzPLeRiq5IzWjwVe3NqbotnYrsSm
 ch8xUHou3y+mFgFGxpA==
X-Authority-Analysis: v=2.4 cv=SN/Xx+vH c=1 sm=1 tr=0 ts=6ae09054 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=75pfyCq1Idx6z_e0LXYA:9 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270047
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

On Fri, Oct 23, 2026 at 12:37:30PM +0530, Jayant Shekhar wrote:
> 
> On 15-10-2026 18:12, Dmitry Baryshkov wrote:
> > On Thu, Oct 15, 2026 at 01:08:24PM +0530, Jayant Shekhar wrote:
> > > DCP may be power-collapsed while the VirtIO transport remains available.
> > > The host therefore needs the platform IPCC channel to wake the firmware and
> > > to receive notification that it can service HFI queues.
> > Is it allowed per the VirtIO spec?
> > 
> 
> As we discussed, its not compatible, will address in v2.
> 
> 
> > > Add the IPCC mailbox client and power-notify interrupt handling. Wake DCP
> > > before VirtIO queue activity, wait for the firmware acknowledgment, and
> > > notify the response queue when the IPCC receive path completes.
> > Don't describe patch contents. Describe your design decisions. The
> > reasons for the flags, init/deinit functions, etc.
> > 
> > > Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> > > Assisted-by: LLM
> > > ---
> > >   drivers/gpu/drm/msm/Makefile       |   1 +
> > >   drivers/gpu/drm/msm/dcp/dcp_drv.h  |   1 +
> > >   drivers/gpu/drm/msm/dcp/dcp_ipcc.c | 212 +++++++++++++++++++++++++++++++++++++
> > >   drivers/gpu/drm/msm/dcp/dcp_ipcc.h |  56 ++++++++++
> > >   4 files changed, 270 insertions(+)
> > > 
> > > +
> > > +/**
> > > + * struct dcp_ipcc - DCP IPCC power-notification state
> > > + * @client: Mailbox client used for APSS-to-DCP notifications.
> > > + * @power_chan: Mailbox channel carrying power notifications.
> > > + * @resp_vq: VirtIO response queue notified by the IPCC receive path.
> > > + * @power_notify_done: Completion for the firmware acknowledgment.
> > > + * @power_notify_lock: Serializes power notifications and teardown.
> > > + * @power_notify_pending: Indicates an outstanding acknowledgment.
> > > + * @state_lock: Protects shutdown state and response queue access.
> > > + * @shutting_down: Prevents callbacks from accessing teardown state.
> > What is going to access it during teardown? Can we shutdown in a logical
> > way, so that there are no accessors after starting the teardown?
> > 
> 
> The access can come from dcp_ipcc_handle_rx(), which is invoked by either
> the power-notify IRQ handler or the mailbox RX callback. An RX callback may
> already be running when teardown begins. Without protection, it could
> complete power_notify_done or notify resp_vq after the queue has been
> detached.

THat's what I called correct sequencing. Make sure that events are
properly ordered. That is, disable / mask hardware event reporting, make
sure that the events are processed and completed, then teardown. See how
IRQs are being freed.

> 
> 
> > > + * @power_notify_irq_wake: Whether IRQ wake was enabled.
> > > + * @power_notify_irq: Power-notify acknowledgment IRQ number.
> > > + */
> > > +struct dcp_ipcc {
> > > +	struct mbox_client client;
> > > +	struct mbox_chan *power_chan;
> > > +	struct virtqueue *resp_vq;
> > > +	struct completion power_notify_done;
> > > +	/* Serializes power notifications and teardown. */
> > > +	struct mutex power_notify_lock;
> > > +	atomic_t power_notify_pending;
> > > +	/* Protects shutdown state and response queue access. */
> > > +	spinlock_t state_lock;
> > > +	bool shutting_down;
> > > +	bool power_notify_irq_wake;
> > > +	int power_notify_irq;
> > > +};
> > > +
> > > +int dcp_ipcc_init(struct dcp_ipcc *ipcc, struct device *dev);
> > > +void dcp_ipcc_set_resp_vq(struct dcp_ipcc *ipcc, struct virtqueue *resp_vq);
> > > +void dcp_ipcc_deinit(struct dcp_ipcc *ipcc);
> > > +int dcp_ipcc_send_power_notify(struct dcp_ipcc *ipcc);
> > > +
> > > +#endif /* __DCP_IPCC_H__ */
> > > 
> > > -- 
> > > 2.43.0
> > > 

-- 
With best wishes
Dmitry
