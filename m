Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE8BCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9017410E45B;
	Mon, 12 Oct 2026 12:23:33 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22D9110F052
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:23:22 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0AMW2275884
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=9Tl8k+BUtJHQINnzIvG/Hxt0
 atXp7wqqlJKLES8ZXeE=; b=bfF2DObP1GUQk3MjpGiaDuYbdQIZtU7V482r3uZf
 1rTwWpH862AfblPqofka9my1B311hvWsKg1IvCIwO0TBv6y+e7QMOqZxCnv8dJZX
 +MxS8v2qhBxszLRlKUw7m90iQXw88S9oOh9tfYFQHApFYfuxY0CHLWhkaqq5zYMr
 4Glea8rF6Nxkn38K9jl10RVrmlXHyU3J5kJGGunH7tJOY3Xf5SPYnvyfjBdGl+CL
 XI0V1E1TiiW6a4jsCA2WeKjubNAI7irfgSJYxLxjyisiNjDukiFVCjwm5Ee/USYH
 uM9A+q5x8EyBu0jAygtn4LcQeB1cvdjFc+inxAIsl4heuw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8udq19d1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:23:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb71b1443so400644385a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 05:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791807801; x=1792412601;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9Tl8k+BUtJHQINnzIvG/Hxt0atXp7wqqlJKLES8ZXeE=;
 b=Qb/QI/mMBHh7EobT/WX3K8/H2FksT0vB2hWSeKHPHrRo764t1zB1cEs5ndQXboJEx/
 eSMw94OGPGGLMLX4Rw9JzLQpWIyDCZVUf/Y4HZ5D02c+ExPmBbxblRDPT+gEmp3O7o8B
 y+hyhCBooZGmaDhzeAM0GnqufES5NnsRcAUJjeTHi4tITRmwFG5IPF1SmOs0ATNMxGXK
 1Ax6vTFAmcA4AQMQp8xlTBNOKgjVAs3A9+r1GJ8FBLZ/BmbOAyNjsyyV8wgBdpfgMgd4
 WfOe0HzIBuXI3mUGkrOCfq1eD4KaIHKaXbzm8secFBJ6wjXmC4oP4Nn824j5jTgHHg3a
 Eywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791807801; x=1792412601;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9Tl8k+BUtJHQINnzIvG/Hxt0atXp7wqqlJKLES8ZXeE=;
 b=GX1GoQQnoLojwCak7NFnD+ps/Gb0hFLAqcn1oXQH0+NgKS7tn7EwJSL3O++aLETATQ
 hNoJKb2TwNHMUGAsEOUrkcSRb/7fIu2edsPDRR1nXcmT/1zMh0B2QSibuaq2KLORX9BB
 KXqNQUDl7t2zftbEAk4t88EhxeLPBs+iyIZrWWuZLVSRUyTJHnUhUq0LudLGCIxI5EBu
 nwWRzEF7q9kzfBAFhghJj7N7pQnH98EpthJ+F/wAlbmQAl/rLNgvFUqh+/G3OqtZNfIo
 3MmYo4VfIogIitJZNNqpO4BP/ycr1z29ND7H68i6/R+39A3cAue9zDYw2KgeGDjhrp/7
 ybAw==
X-Forwarded-Encrypted: i=1;
 AKwUvByV5Ub21HdugFRKqKrtlDSHXfO6VL4OXyhypq7QyHKWKm32F+4DmU/LuIhpIEAflyqGicqN9cydXCk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKoH70ebhaF2P1hVBT2HcdtJ6EJ8bGZAn48y32fyGNmN0uCijZE
 zVifsz6CexSV/8Fg5EB8IKNb5F2wSDZsLhXskmnzFv3W3LMswPosygqvojrO/a7ShhifvrD6Ye3
 XUPUXOVBBXOApQCqddb5p45bOc4KBXjJXuei9g4jLzFRIzi+Ess2buci5t5TChqfvII/8z8Y=
X-Gm-Gg: AYBFou3fTRYjDHNPd6zGWsm/hombj7igBKWJVWU90IoSom9NA6AYdUuABOsK2mX4obT
 uPNET/8mXjRYLatVyRtZGg9tOzK1ElNciFteF2t8q8VrXzMS1RAPFwzt10Wtog31l/T9rt1pATO
 or0M8B+DIXrRYXOqzJAmrr5drL6r3Xs2kyzHricyZx+5jOQDzCsYs7RGt+UlUp2sUf2LbsOwC4r
 jrZuRVJVr9ad7t0BDmJCMg9u7XCxEpbnIPIrgHNr00iH+RPCQpEaVHNVEnqPBCscWw0as+Ta/Qw
 vUI+GrImyd/3v2WDWMySVZw7ljL9N0J2sYNMzHpTJUfWHbB0p5m+Bfiv32ELyYmVo7sfstRR/wP
 NMxmDk7we2D+3Zbu9DlqRWKK3u7fee+Nk7fcFkfXA9u2x+sjWOJhvnu+El9riwGDP6HIs4Xhu1w
 vZYj3Q7HZ5TGl6
X-Received: by 2002:a05:620a:44c3:b0:93b:d79e:18fb with SMTP id
 af79cd13be357-93ebd4a86b8mr1671170885a.62.1791807800375; 
 Mon, 12 Oct 2026 05:23:20 -0700 (PDT)
X-Received: by 2002:a05:620a:44c3:b0:93b:d79e:18fb with SMTP id
 af79cd13be357-93ebd4a86b8mr1671165285a.62.1791807799753; 
 Mon, 12 Oct 2026 05:23:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcddeccd5esm2790210e87.82.2026.10.12.05.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 05:23:17 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:23:15 +0300
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
Subject: Re: [PATCH v7 08/35] drm/msm/dp: add support to send ACT packets for
 MST
Message-ID: <fx5njelx53gciz6rguzjybxgbyxbfqweelsuy4j3aab2n5awrf@n27xvmre7ztu>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-8-4b81473185e7@oss.qualcomm.com>
 <aolbmfnrk6qkfifib6bmhslaro5z2734ydfip4mnn3go4efpsy@2d4m6nnh7ogv>
 <3c28f89e-8b49-4937-b4c8-66da180a5706@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c28f89e-8b49-4937-b4c8-66da180a5706@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=evJKXYpX c=1 sm=1 tr=0 ts=6accd139 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=ecUC0MPj5Ne1r6wDHHIA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfX+ZgIwWIgUC3M
 Ai74/rbJsuH1F3OiA8y+3xq8hgZ1mJN15LRXFbhIlpYYLcur7JyRIpkU1oxgwyE++Si9H3t551q
 tANjs54NJCgJ+2zSmypx6WBRzZqClbI=
X-Proofpoint-GUID: n567Di4KFnHGQ-LAw5Xwzh32o4BvT5Dp
X-Proofpoint-ORIG-GUID: n567Di4KFnHGQ-LAw5Xwzh32o4BvT5Dp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OSBTYWx0ZWRfX1teEkgLXmZ//
 WZT+JhTK7mdce4YqCk9tQeKxhwbzBFNymSUy9sqrIAzqDw6T2W1tqv3Q3Cg0hhuntY+B+GQs/mA
 87zVXE8qqkX6Ch03GEwyBrnO9wwQPx0NgD8iVC4wq7qhxdXTqzzWa9UQYJKvQRD04T6Evck+NUk
 wsP0FlUoIkR2clSTWxp1ZyvtmMe0vy2dq7Y3uFfML52NVwQGU2D/d3OVZtlKNHbKnPuWzeRjWJa
 l/JEkqk0mBSbAfc1wguwd/FnAC0X8aVRG0eSh4bU7g/cQio2tc2UFdFf7NyHckfElhmxYh1XD9I
 k9U2tdTXdT9zIK67MmJNVSCkMPlF1SDlMdgCigt40fKyTxhZmyVGMogRZU3xQhAx+GxRY9YK9r3
 arSwyodfKhcuhqlhpTjZ4si+/4Ok3YFMZ8zYuv4TlHCBO+OATHhLHirDtAILTyer/CzuXJeJKHN
 gk+2NOF79hcoevLLEvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120049
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

On Mon, Oct 12, 2026 at 04:44:06PM +0800, Yongxing Mou wrote:
> 
> 
> On 10/1/2026 6:32 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 29, 2026 at 12:25:32PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > Whenever virtual channel slot allocation changes, the DP
> > > source must send the action control trigger sequence to notify
> > > the sink about the same. This would be applicable during the
> > > start and stop of the pixel stream. Add the infrastructure
> > > to be able to send ACT packets for the DP controller when
> > > operating in MST mode.
> > > 
> > > Add REG_DP_MST_ACT, the ACT trigger register used by this sequence.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 44 ++++++++++++++++++++++++++++++++++++-
> > >   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 ++++-
> > >   drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
> > >   drivers/gpu/drm/msm/dp/dp_display.h |  1 +
> > >   drivers/gpu/drm/msm/dp/dp_reg.h     |  1 +
> > >   5 files changed, 51 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > index e1614bc49a7c..65d22505c2b6 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > @@ -142,6 +142,7 @@ struct msm_dp_ctrl_private {
> > >   	bool core_clks_on;
> > >   	bool link_clks_on;
> > >   	bool stream_clks_on[DP_STREAM_MAX];
> > > +	bool mst_active;
> > 
> > I really don't like the idea of having this flag in two locations. Here
> > and in the msm_dp_display_private. Can we have it in one place only?
> > 
> These two fields are intended to represent different states with different
> lifetimes.
> 
> msm_dp::mst_active tracks whether the DP connection has an active MST
> session. The controller field records whether the current controller/link is
> operating in MST mode and remains valid until the link is shut down.
> 
> I agree that using mst_active for both fields makes them look like
> duplicated state. I propose renaming the controller field to mst_mode while
> keeping the display-side field as mst_active.
> 
> Would you agree with this change?

What is the difference between these two? I.e. what os the difference
between those two?

> > >   };
> > 
> > [...]
> > 
> > >   static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> > > index 83117e7619f3..472429d09200 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.h
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> > > @@ -19,6 +19,7 @@ struct msm_dp {
> > >   	struct drm_bridge *bridge;
> > >   	bool audio_enabled;
> > >   	bool power_on;
> > > +	bool mst_active;
> > >   	unsigned int connector_type;
> > >   	bool is_edp;
> > 
> 

-- 
With best wishes
Dmitry
