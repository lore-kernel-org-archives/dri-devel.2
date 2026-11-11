Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96F9606A32E
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZBUrBT7R;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Pskru8Ib
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D04FC10E179;
	Wed, 11 Nov 2026 14:23:07 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6809510E179
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:22:56 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABEJUeh2224203
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ysdktN+OG/bhbACTJfJokpiJ
 lx6njf29pO0caat3PyA=; b=ZBUrBT7R7nChmFfL9Em+yy6bBU7MgIeRY4sx8I6Y
 GSVnyLaYeIcWg4E2yHxRVRK2FCxWDioeSVErJkNJfrB614anq0bOTc/Fhhq3mZij
 X1Cz3lCKfPmxU8nS3Q+liJd0QeSNLHWg1zbd7kY/jfZH8Jp5qfOw7gSwxYWRx+2F
 4HBytILd0vYxWnG7SYzrY6/HCQi/98emI2LOSaTAk1DFes88E2XEd3Fj0G277cIu
 JflNyuLVcAK4Aqn2a0Zs8uqL3YFGxpbBqjvdcCFQiJ+p5MY8L7Zb+iiLvQJMkVwY
 p187A3E+ysiJrWPPm2qgG65r6vY9GCb5zxBs2L1T3miXeA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdrh319h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:22:55 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91eb3a63064so69229666d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 06:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794406974; x=1795011774;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ysdktN+OG/bhbACTJfJokpiJlx6njf29pO0caat3PyA=;
 b=Pskru8IbsAVedjl8aAYfL1MIinjxRo+n2XqkB3MNo1pWg4W/Sn9Z0SigzKTlyex96q
 MgZdMUCN48Z+nxaU9Wp8cAkWjMpwFS+zx3NAYQvxLEqbonjdSkd24JMuSKb+/iQfwOBO
 U239rBleFDnwXo6IF2WrtOozmloSBt0N5gswgR3CAWYA9kKM9bX0r1eXQfA6OvwtbfJr
 USR6YdDEvFjm8Zfg4Kuoi2VNST3IZbwTjjQ44V+q+BRUtjhsTRyZaiLVbU7RfJEkTuI0
 9eLvr1iERtT2L5NY9lysnt4KOf6Jr84nJAjchgEtlOGOHbB3s3BKLNx6LB+WyPC+eXZ7
 cpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794406974; x=1795011774;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ysdktN+OG/bhbACTJfJokpiJlx6njf29pO0caat3PyA=;
 b=LSYDpWyYxmR0wp/3c2a58U7uky2lpLwlQopCyhGiFADazMBu9o2vAeNLBC1oSWpG9Z
 SeaNijPZecGBZhLsPSJSr4cONCQCbBxhxFd7Wmrza0J0nToeRTmPrHEBHUoLf/pn5Y+Q
 Cs4s70HhXDwXL6mGdBhimh5gyWeSS+b3sZY1rAqi9W5K/MJR0PgyYorpGgGlA6MjWBqh
 ecTg1RDOrKikYWVR8liMe2Zd/30sB0zUpPKJrQzKuHdlSnTbmN4EKqs6NFCNuATfEEV+
 iCr2xsbswuV7eYgBjjgg6gXcVxSPmWgoUkWjmKeJs3K7QqqyMlLIwtoPWppi0ARCa+he
 cFRw==
X-Forwarded-Encrypted: i=1;
 AL+hErFz3B/zWw69cx3uYly7K3G9gmSH2K+qbQJ3SOfbTjyndYdH6isKg/0z6ICXL0ripFFB0LVZpeCVjQ0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8AiNZgHXOQyP1GuSyNPqlECV4SJDBsT+/KxKRBY8jt8hs3anJL
 idcLsl6+1hwiSxOP7L7Lb8NxG7fIFkRAsDesZQ88uXPuBNH26h+6W0/3hkfCHCoPVdI4BVo60Hy
 k/BK3gYK9hSfv6OyvlKmm3jsD3hVtlaeJ1HudpIte0K69zr1rpwo/aItH7yvG1ztBHLWYjSI=
X-Gm-Gg: AYBFou2N/Iu+73/JzAkT6CtsASHsFb0Nv2dpPV00mDGsYj6rK7zgumPMI51Mhd2WOLv
 N2CpdnMnUE9fb9siIRTWdleDvrqz8AtJqMpm/HoP9gsZLZt4t9Fv0Wom61+Rdlb2EEnPCF1VQJW
 7/11zDKU7jHDModJsBpHJOw1WjZ34+LzIzr7TYj3o1PbfVATnt4gIj3EmYq0ndXOIYNxdHLp2qC
 8yJZ9qc+AM3+xhsGIAXHqwiblJmSkSjzpijmrv7Jr7U0tDLrLIiSr131c3s9Pe7ETPSjgnTusDd
 tjrxmdIdvCeq3FGxlU4eUGhdAn4u8HRundXkxaYfAKKb3Eig52eUNZZV3yNqTWguuAbmK/38wzU
 1Vb03MPzSW4HiiQwliURtLo8s0kSCNnSb9oc9juCiMMU5fNcOgb/F0BOkWUfQ6vTrfl58jldcz3
 etOfCiGeHACzA/23LG14dWV7cBgKszq7Kc4fkMrrIyiiJZ6q7xHoDn5Bq4UjzN7w==
X-Received: by 2002:a05:6214:20eb:b0:91e:b57e:5426 with SMTP id
 6a1803df08f44-91f04016859mr40853806d6.12.1794406974436; 
 Wed, 11 Nov 2026 06:22:54 -0800 (PST)
X-Received: by 2002:a05:6214:20eb:b0:91e:b57e:5426 with SMTP id
 6a1803df08f44-91f04016859mr40853226d6.12.1794406973772; 
 Wed, 11 Nov 2026 06:22:53 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae091739edsm11368481fa.1.2026.11.11.06.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:22:52 -0800 (PST)
Date: Wed, 11 Nov 2026 16:22:51 +0200
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
Message-ID: <s426afxolcgqb2pf4e2xv2s2g2cpn5minmubt4dcpwtcw4dwku@cwznffsa64xb>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-13-4b81473185e7@oss.qualcomm.com>
 <agm7esy726no4u4cntecmllz5kxdtxaue7xcn7vdhkuh73lxau@r6mqybgiyl7f>
 <ab5ebfa2-9687-48ba-8403-186e517126d2@oss.qualcomm.com>
 <jwmtxurikcc2qsahg4rq63earm75puu46isd5du2s6356oe6eh@7umfzpxmoebv>
 <661383c5-41c5-495a-94ab-ffd1b99d7f9d@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <661383c5-41c5-495a-94ab-ffd1b99d7f9d@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX7NkifQVG2U5Q
 tv4FTbQUEjnFDXDT3wYsAcmj6/bCj0xsM/EmKLBXZmWtX9VFAg/1Iuo0hY04nSF+/1iL4p21o1g
 jBXOxJ0wad7Qpe18Q5pjeCPOn41ixac=
X-Authority-Analysis: v=2.4 cv=PoQG/AM3 c=1 sm=1 tr=0 ts=6af47a3f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=u6R0oCwwweFeSL41B3gA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: U_xCHdFsk4tv6aJheind0tDcYhN2PL6g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX4ZulLLrcTDdc
 JgU1fjv8qPfLJ7M0rv3qW3htt9ldQfrFzkon+x7qNKYXojVvAJgj3hUM5S5EHsI9jpG03UJ+42e
 ZqOaShTvQirPhPQNh1T3ktoUrJq3RNeRpszI7kMo+Ayv6+77hrU1YbAvv54O49R7JMONgB4IAI/
 Cw2Wta29l5aTZcGHwxQCL48dXM+Fv+2RpYYdgB9kVsqdY57NqPojxj6v5fssfxlx0tSogMhX+/X
 6t4V7PyYXKzg/0gFmsxelO2QdnbknMwa1iAyKPTdVilWzKpjFTXXnOe6SGlgfcnzmyUoaVF/Gfp
 mFud9jmdDsuDwpOwYIYL20ZuY7PjlrS+qax2qppS4LWeHesb5VqCR7hMBhd+98j7OMYWKfEyd/2
 Eui500r4+/UPLze8MLRN3Ql6ZXZhxAQVW3L5AtnZnTSWq/DeghJ0GrJDIxYDCUYkLUmJVlh/bzd
 kKpyK538UWcR3Ahonnw==
X-Proofpoint-ORIG-GUID: U_xCHdFsk4tv6aJheind0tDcYhN2PL6g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_03,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110056
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

On Tue, Nov 10, 2026 at 05:40:07PM +0800, Yongxing Mou wrote:
> 
> 
> On 11/9/2026 3:20 AM, Dmitry Baryshkov wrote:
> > On Thu, Oct 15, 2026 at 09:24:52PM +0800, Yongxing Mou wrote:
> > > 
> > > 
> > > On 10/1/2026 6:52 PM, Dmitry Baryshkov wrote:
> > > > On Tue, Sep 29, 2026 at 12:25:37PM +0800, Yongxing Mou wrote:
> > > > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > 
> > > > > DP MST streams share 64 MTP slots in a time-multiplexed manner. Add
> > > > > support for calculating the rate governor, slot allocation, and slot
> > > > > reservation in the DP controller.
> > > > > 
> > > > > Each MST stream can reserve its slots by calling
> > > > > msm_dp_display_set_stream_info() from its bridge callbacks.
> > > > > 
> > > > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > > ---
> > > > >    drivers/gpu/drm/msm/dp/dp_ctrl.c    | 187 ++++++++++++++++++++++++++++++++++++
> > > > >    drivers/gpu/drm/msm/dp/dp_ctrl.h    |   4 +
> > > > >    drivers/gpu/drm/msm/dp/dp_display.c |  13 +++
> > > > >    drivers/gpu/drm/msm/dp/dp_display.h |   2 +
> > > > >    4 files changed, 206 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > > index 929e0f94f8dd..02732bd4efa1 100644
> > > > > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > > @@ -83,6 +83,7 @@
> > > > >    #define MR_LINK_PRBS7 0x100
> > > > >    #define MR_LINK_CUSTOM80 0x200
> > > > >    #define MR_LINK_TRAINING4  0x40
> > > > > +#define DP_MAX_TIME_SLOTS 64
> > > > >    enum {
> > > > >    	DP_TRAINING_NONE,
> > > > > @@ -119,6 +120,12 @@ struct msm_dp_vc_tu_mapping_table {
> > > > >    	u8 tu_size_minus1;
> > > > >    };
> > > > > +struct msm_dp_mst_ch_slot_info {
> > > > > +	u32 start_slot;
> > > > > +	u32 tot_slots;
> > > > > +	u32 pbn;
> > > > > +};
> > > > 
> > > > How other drivers handle slot programming? Is it something to be shared
> > > > between the drivers? If so, maybe it would be better to update MST
> > > > helpers. Or, asking differently, why do we store it this way? I don't
> > > start_slot, tot_slots, and pbn come from the MST atomic state. The MSM DP
> > > hardware uses start_slot and tot_slots to program the per-stream timeslot
> > > registers, while pbn is used to calculate the rate governor. Therefore,
> > > mst_ch_info[] is a cached copy added to make these values easily accessible
> > > to dp_ctrl.c.
> > > 
> > > Source hardware programming differs across vendors. Intel does not
> > > explicitly program per-stream absolute start-slot or slot-mask registers
> > > like QCOM does. Nouveau submits each head's allocation through its NVIF/VCPI
> > > interface, while AMD converts the complete allocation table into SAT entries
> > > and programs them into the source hardware. Therefore, DRM MST helpers can
> > > handle the common payload allocation and slot-shifting logic, but source
> > > hardware programming remains driver-specific.
> > > 
> > > Without mst_ch_info[], we would need to construct a temporary complete
> > > allocation table from the MST atomic state during stream enable/disable and
> > > pass it through dp_display.c to dp_ctrl.c. Specifically, this would require
> > > extending msm_dp_display_enable_helper(), msm_dp_display_disable_helper(),
> > > and msm_dp_ctrl_on_stream(). msm_dp_ctrl_mst_timeslot_setup() would then use
> > > this table to program the timeslot registers for all streams, while the
> > > current stream's pbn would be passed to the rate governor calculation.
> > 
> > Would it be better if the MST helpers provided this table? Would it be
> > useful for any other driver?
> > 
> I don't think this would be useful to other drivers. The table is indexed by
> the MSM source stream ID and is only needed because the MSM DP hardware
> requires an absolute start slot and a 64-bit slot mask per stream, as well
> as the PBN for the rate governor calculation.
> 
> Other MST drivers operate directly on drm_dp_mst_topology_state::payloads
> and don't need a source-stream-indexed representation. A common MST helper
> for this would therefore have only one user, while the hardware-specific
> translation would still remain in the MSM driver.
> 
> In the next version, I've dropped the cached mst_ch_info[] array following
> your earlier comment. dp_mst_drm.c now builds a small on-stack table from
> the MST payload states in the stream enable/disable paths, and dp_ctrl only
> translates that table into the hardware timeslot configuration and rate
> governor inputs.
> 

OK.


-- 
With best wishes
Dmitry
