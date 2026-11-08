Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7374C606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CYbjHCC5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QoCMlsbX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78EF910E6F6;
	Sun,  8 Nov 2026 19:21:09 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9197110E5BF
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 19:20:57 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A8HoZ211013461
 for <dri-devel@lists.freedesktop.org>; Sun, 8 Nov 2026 19:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=zlzWWaYK/j7SpOXqtX7DHJ/k
 vUzD/3AsfJhk/toPE/c=; b=CYbjHCC5/XcAw9g32iaHHYMZfGqyuF7cVVhZC4is
 6lD1ZYT1yl+5xQtI1cUlPeZ6KQGxBWBMPLnbaWRnEZ5I2WuyeYn5SN3WkwI//gKX
 U2Zxayj+Y+eh2mE2QxFldnf+ge3ZTJC9ACHGfq3yL7uw+N5DbKbhA3gtzKZ+Ne17
 I9bvQ9YmfvHSvkWrQnV7JoyDO4amI8iknEgpNtJTuI9pb8XNU63Su9g24F3sjdwE
 xopduHPcRoJPoghlmpHYdfgFGA4wmkBktza9o42BwJTrnGieBP8bbtO7ky3Nql+B
 TxNtiGZ75/XRD/ZWIBcyQlHHrtOq5LThkYf3uxBD+kxjrw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsvc6kgj3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 19:20:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f322ef7d3so50564085a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 11:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794165656; x=1794770456;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zlzWWaYK/j7SpOXqtX7DHJ/kvUzD/3AsfJhk/toPE/c=;
 b=QoCMlsbXW/buhljyvR+xYL9KXIrhZcl0O3IFfcYkyTbmS0j6F/v739KailD+45tk2I
 RooSHK+LjkP8gwV4D24alcC+NsonCGH+8h8PA/qr9mfgWUDaLR50T3505aVONvmNDmqL
 jZIawWnlPbNV9gsQsd6Lr2hmgGgF42r5P1FmECmpanVe2buRUhrRyCUsmJu4sfhpCDMf
 MdwxmGKDIat6xXoOgXQ1c0n3hUAlA/oDGVOL6uZ1P61iffn4VKaqjgxDGDisMwyHvVg2
 UVKRXBBPJflGp07kx0lAwK+5gTOK3eck+koqpsof3Xewwo99nNS2kCvZLm7CfYSsBQRd
 TXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794165656; x=1794770456;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zlzWWaYK/j7SpOXqtX7DHJ/kvUzD/3AsfJhk/toPE/c=;
 b=UO0k11Msco44yp18Qc1H5vW+FGqG+2fHvXv3HSxGAf4J2zw9CVdrm3xgxwfv/bMH+o
 Luj4QdpgR5zbycQvyzdS+N4jshbzjjdXoKWfDEI4wzPQ726mP4mkCUtlpY+7Bl10W7Ct
 xskud+Qx+KUC26+zp0k2bwU2N25a+a+oYHCJKz+5fi9PYbGYYqqdlCjXtQY8OWyAE9LB
 iwXTDE4IiBeQRwkoh947anRRuODhk8TaTVFW1V2lOpWsFnBEnGn5WjDKrnWay/XYnS0b
 iUBTv+pWDp7XOpCmjns+5BeM/cQUxd6H1xkkbM+W9I57RQbDfMdJVI6i0+J5sALu5i1t
 6ahw==
X-Forwarded-Encrypted: i=1;
 AL+hErGuCHakE+QUAVCssUi7EZF53l2HnCgIt4FfkS0hEwbtsvY2w4abN7W0VNojU2v3Q7LK1rrie6wmu2k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8yKzPRPI18aS3j/inI81SiUemtDKqlXDQsE5DyDFKebToZEbKe
 ZnDPaoE41JkAFQnre+N+mC3APcl7wHl7v68e/OU/FNQfoi6ohadI6cdf/LD5MBTDAvn0XK/3u3x
 vbT9KF/Wbtoxm8tJHQy8tboZtgyvBYXN45F5mhnXjdvgg4PusbobzHIUwIiT5ydEAE+f5apU=
X-Gm-Gg: AYBFou3ndHzABPZ9/689A+wqXJ8t4VvbSx7kEbH7CLVIgJLkEWs2epHrpcrm8W1m6BH
 OizeJaR+v6NwIQ5bJ6iK+wgACoQw+o1xVibG101gwKjeW4JRrmi0qkDVFMOeo+o+DzoQUAV19wG
 8Br1qSPEqES9J06LHbaZRVc6Ej/E/2cN0czsNB90p39S5TwM0goTA/9FFRnDRWwk6NdPOgCYOC8
 r7MBL4PaEmBJiSvCeNbcpadMjh9S/oj9zwJS6x6dYvN6b32rn2r2JkpTmybStIBLFGrde3xhl53
 voY3Pb7FgrB7Jbz02aSPxbRS0BYbrEVGI27Y/nZ+ehchL/wIa2aE6CTLV7LEV4KNR9FqzwyJvsC
 KB9UJd0AzJohPdDwBbF8FfXcQHeER9IIzdTmr7TkyB1PpiH00HfwjgZjeG/jMH5wy/hwNL7rJds
 BNawwzMS0B0ue9FJNPkIHzyXuWekk1oIruGP+Wi6p1zLsyrniwCEdTBBJWC0Jc
X-Received: by 2002:a05:620a:3711:b0:93f:3646:7a53 with SMTP id
 af79cd13be357-947842db1d8mr292300185a.83.1794165655784; 
 Sun, 08 Nov 2026 11:20:55 -0800 (PST)
X-Received: by 2002:a05:620a:3711:b0:93f:3646:7a53 with SMTP id
 af79cd13be357-947842db1d8mr292298185a.83.1794165655282; 
 Sun, 08 Nov 2026 11:20:55 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c14b7fc371sm468860e87.20.2026.11.08.11.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 11:20:54 -0800 (PST)
Date: Sun, 8 Nov 2026 21:20:51 +0200
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
Subject: Re: [PATCH v7 13/35] drm/msm/dp: add support for MST channel slot
 allocation
Message-ID: <jwmtxurikcc2qsahg4rq63earm75puu46isd5du2s6356oe6eh@7umfzpxmoebv>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-13-4b81473185e7@oss.qualcomm.com>
 <agm7esy726no4u4cntecmllz5kxdtxaue7xcn7vdhkuh73lxau@r6mqybgiyl7f>
 <ab5ebfa2-9687-48ba-8403-186e517126d2@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab5ebfa2-9687-48ba-8403-186e517126d2@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDA3NyBTYWx0ZWRfX2XoTsBhgdfjd
 AgrO645qLPxtgnCpy7Jg7vxcwcGrSnF/BiTN4NIE5aWB52e5gUQE6PX0fBNIiczjd7ZRGvygZws
 x6bAjKiyUaJdSTXH/ahLSJYiKAD1/rZkP8btt1Ot+Zm7KA464/0o0ERcJSlmJOf/wRg5H0jLost
 E6Q1lPd+xTKm5xq/2/1nUPTfmAFJ1z2GoILpW2Nd9tzJUdOKjDArRD3c6VWrr9sB3oYcU2k4d8T
 IsEcNSRJZIcLmcl0+5nIVyD6SW4FVr5aW9v4naoK3gGPiM3c8NBKPilJMqUi79h8gFQmUxXZTiS
 EVoAlIwNPE+8q4Y0j1oYLgM41C7ieYG7tSCi7z5r0lCP/qgBhN7XGMkN3FjC8YjvMoGHmRka6K8
 CTWR+uK4TfEMoGf0ogCAtqasC/OkYkckAN/O5vaGaGc8p+3tz36bcwy69YNZWGAaPXUov374hnt
 aioQ1/7wTkJz/C5VgsQ==
X-Authority-Analysis: v=2.4 cv=WOjqzXsR c=1 sm=1 tr=0 ts=6af0cb98 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=xEe2GtBaY6AeIktA6SYA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA4MDA3NyBTYWx0ZWRfX+JVP9G732DZm
 F3dOoam9eIbRbdbXxKCn6f1Th3wCBZz86qZVLd8yN++I43Wex4r3r9sYmnu/qBsivZT73hwiCtG
 9tqCo2DW1xyQm7QYmBRP//A6WkEEAVA=
X-Proofpoint-ORIG-GUID: BkNq2GbRCO7aSnNfZtZh81PLr9BWV9dL
X-Proofpoint-GUID: BkNq2GbRCO7aSnNfZtZh81PLr9BWV9dL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-08_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611080077
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

On Thu, Oct 15, 2026 at 09:24:52PM +0800, Yongxing Mou wrote:
> 
> 
> On 10/1/2026 6:52 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 29, 2026 at 12:25:37PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > DP MST streams share 64 MTP slots in a time-multiplexed manner. Add
> > > support for calculating the rate governor, slot allocation, and slot
> > > reservation in the DP controller.
> > > 
> > > Each MST stream can reserve its slots by calling
> > > msm_dp_display_set_stream_info() from its bridge callbacks.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 187 ++++++++++++++++++++++++++++++++++++
> > >   drivers/gpu/drm/msm/dp/dp_ctrl.h    |   4 +
> > >   drivers/gpu/drm/msm/dp/dp_display.c |  13 +++
> > >   drivers/gpu/drm/msm/dp/dp_display.h |   2 +
> > >   4 files changed, 206 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > index 929e0f94f8dd..02732bd4efa1 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > @@ -83,6 +83,7 @@
> > >   #define MR_LINK_PRBS7 0x100
> > >   #define MR_LINK_CUSTOM80 0x200
> > >   #define MR_LINK_TRAINING4  0x40
> > > +#define DP_MAX_TIME_SLOTS 64
> > >   enum {
> > >   	DP_TRAINING_NONE,
> > > @@ -119,6 +120,12 @@ struct msm_dp_vc_tu_mapping_table {
> > >   	u8 tu_size_minus1;
> > >   };
> > > +struct msm_dp_mst_ch_slot_info {
> > > +	u32 start_slot;
> > > +	u32 tot_slots;
> > > +	u32 pbn;
> > > +};
> > 
> > How other drivers handle slot programming? Is it something to be shared
> > between the drivers? If so, maybe it would be better to update MST
> > helpers. Or, asking differently, why do we store it this way? I don't
> start_slot, tot_slots, and pbn come from the MST atomic state. The MSM DP
> hardware uses start_slot and tot_slots to program the per-stream timeslot
> registers, while pbn is used to calculate the rate governor. Therefore,
> mst_ch_info[] is a cached copy added to make these values easily accessible
> to dp_ctrl.c.
>
> Source hardware programming differs across vendors. Intel does not
> explicitly program per-stream absolute start-slot or slot-mask registers
> like QCOM does. Nouveau submits each head's allocation through its NVIF/VCPI
> interface, while AMD converts the complete allocation table into SAT entries
> and programs them into the source hardware. Therefore, DRM MST helpers can
> handle the common payload allocation and slot-shifting logic, but source
> hardware programming remains driver-specific.
> 
> Without mst_ch_info[], we would need to construct a temporary complete
> allocation table from the MST atomic state during stream enable/disable and
> pass it through dp_display.c to dp_ctrl.c. Specifically, this would require
> extending msm_dp_display_enable_helper(), msm_dp_display_disable_helper(),
> and msm_dp_ctrl_on_stream(). msm_dp_ctrl_mst_timeslot_setup() would then use
> this table to program the timeslot registers for all streams, while the
> current stream's pbn would be passed to the rate governor calculation.

Would it be better if the MST helpers provided this table? Would it be
useful for any other driver?

-- 
With best wishes
Dmitry
