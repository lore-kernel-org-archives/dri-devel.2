Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859B606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O8zZQdAf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dgNbtXSm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B964C10E3CA;
	Wed, 11 Nov 2026 14:22:25 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EDD910E179
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:22:14 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABEGwLV1573250
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=5vxRVg3BVpCwTSewYkaACukS
 mJoTpCO+UQbfXLbns6s=; b=O8zZQdAf558lWfuKtUjSfXEXCDjb+g/Hw1jL+Og6
 LFn8nqrcCreO2Q5cOMI6GlRJJCFYdqNzmzhOWnik0VQ0CUQ9JLK1JHzyLzA6HKqD
 Sf7iLfN18wm/9b3bvEgP70WFNV69TfgGsfZZk+0ixsih/swZK7Wlfg8VE5lTvYIQ
 SkxvA7i+LxTwJVsYLptUbz17Jhp8ZsVeKupkLLsD+9kCBmKyfeDy8vzS4MlaX9Ht
 lT77MbdVPSkDpsTXMYbw0sdlIoiyOxm8O4EWxWgcLySaghIu3Xuv4UBPwLf1xIoJ
 V8cveGJGSPLyP4NxL9dbOeGOJfzVQYdX715XwMXZ65XCmQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvk7psm8e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 14:22:13 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5e93fab204bso3231503e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 06:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794406933; x=1795011733;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5vxRVg3BVpCwTSewYkaACukSmJoTpCO+UQbfXLbns6s=;
 b=dgNbtXSmns3a6z/mSPLKYew6dzGkoLkjFjTjOUNLdUfBk8jo78kbZz4L6dTq+I3cq1
 58dJe3RcuLepLjdqI110CxGs64lWMxvVc8lswlGRJLUIiLPpT9JkNMKlDEV4gQxn9Rhc
 iu3fhI7FKWOtTZP8yytH6lVPa0lS7Sc7V0eRGbKQ/Rjj8wL2rTP88D6AhujEUSLArsha
 b8xvWB9eZ/qp3YLSttZOuJtoqa6Rv1pYGp7D4aLzIoutJ0ioA3pLVrV9rI8yc1A1bWnu
 XaBJKTmFmJd6U9eTvQkBhrumEfWzIKqouTablJTYiwoMepXxr0DR98I3eCj7t+78ptSI
 I7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794406933; x=1795011733;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5vxRVg3BVpCwTSewYkaACukSmJoTpCO+UQbfXLbns6s=;
 b=DRzT4jmQTh/gOBvzV+YTsW5nSkKZFeAAPIQfiUNwUyhNp1ZXSjnETlk5YK3RpgFVl0
 7Bvi27u9fscp8hl10rdXSZS9ukFPnZKiPtPj2SSlSWl5y20z+6dvVLVmufDFAAZ1M1qJ
 38EGPvIWy+6X7BP9c8DCANNrdGm5ktVSW2NlumpMGLsbPet9Jf+2URyjSGmrqKZi35yH
 Vvo80IdEqu21eMcqxWPNMTKCkCisZZlOdBuBkTHCdVPDZV9nAos+6KAnve8a70YMelyz
 HGaqTMkXTNjd2rltpA2ptO7PQ4lzxh4rwQo/LjTGOqd78VEB82I3prE9/uimaYr/6+LW
 3ewg==
X-Forwarded-Encrypted: i=1;
 AL+hErGj8FsPOPSUpjaGkzIsbiM5T5B3fLiyD8ki4UyI6U8N6XZ2dg1YkVdo90hsqEZxGUtmxFCVVWQCz7A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/a5Uvdui6M1SoeGzK3DCp/rmROGxC3/dAG96c7+On3Y/aFfxR7
 2bZ4ZXPA9o+mBT3qVHsvVctZoWjpesgdGiClaxIw9LCKH8HYIPUlsy08EoWXoWwjWyErtr1vRed
 AcbKlgwWGmybHYokw/QZEqEhQ69BB5Wi5QAhMmR3zVt+8hOZQvxi8UNoGYfxXaMrZ5qDnSGU=
X-Gm-Gg: AYBFou1+4GkGUhwv2KukyzUWY3wlLikYoaXgEIzaKED+sIQF/FuLiPXFPMoPe/5nj8n
 2MNlfb2UKpD11/C+89no3+O7YpEFCE8ErQNn9XK/zcE5hDrSg+HO9QFJVzx/KlZWLgtyCYJ+x8f
 uUaNnmRiGGuTUZjfU2W2dmEQuDOumu5LZelma5Am0QiVAW/uDIrjOylmP6FUCGr9LYwyrvLFbQJ
 6J8l5Aro9lPYD8mKz8Jf1oTT1znFvQ235JV5YH9vk39kw88LlIx6xbGcRZhysU0uWU+omuAEMYp
 MhP7T+WIZ6yiuCCrmMcmRb9nMO0FkeFEwzFnM+f6+EQKG/ZOuC3G7gP54Jnfvoj4BJy9Z/0CWMo
 6rx3TC4X+/Cqd//IdtG45EbiLSfINk7kqBcb65ERkyhdvc5NOOlA78IC9y9/KIWg6M+yNYbCMU7
 uyxBlkOUzQvZt7Cem2zkAUYxpCnfKHdGUwrXwZVrRIbvryDDGlv7vT5ncrflTgCQ==
X-Received: by 2002:a05:6122:2224:b0:5ec:bdfa:8f56 with SMTP id
 71dfb90a1353d-5ee1c3f41a2mr936975e0c.11.1794406932762; 
 Wed, 11 Nov 2026 06:22:12 -0800 (PST)
X-Received: by 2002:a05:6122:2224:b0:5ec:bdfa:8f56 with SMTP id
 71dfb90a1353d-5ee1c3f41a2mr936927e0c.11.1794406932097; 
 Wed, 11 Nov 2026 06:22:12 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae11c1d591sm4895501fa.38.2026.11.11.06.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:22:10 -0800 (PST)
Date: Wed, 11 Nov 2026 16:22:08 +0200
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
Message-ID: <y446bfbdgsqqwuu3masamj33cvcksp2xdeltvaeojpolgga3fg@awtfd4bgpy7h>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-8-4b81473185e7@oss.qualcomm.com>
 <aolbmfnrk6qkfifib6bmhslaro5z2734ydfip4mnn3go4efpsy@2d4m6nnh7ogv>
 <3c28f89e-8b49-4937-b4c8-66da180a5706@oss.qualcomm.com>
 <fx5njelx53gciz6rguzjybxgbyxbfqweelsuy4j3aab2n5awrf@n27xvmre7ztu>
 <ebf962ad-6b55-4741-bbb3-783f56c1106f@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebf962ad-6b55-4741-bbb3-783f56c1106f@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NyBTYWx0ZWRfX/G7TPThf0VOy
 Lab0/ZhTHlb8RTu7Fcv6wS3cEd+5qq8zNQcf6pYB5AlPigDF15irXQ+8iRsFldqfqJhaUmtue/M
 CqkmokiinxSc7h8oQN0PbyRcskYDHzA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NyBTYWx0ZWRfX7yiBGxVEG+IH
 Fc4ctDDi1Xm5FqQ1l+0ifGnbOephhMOQCe9OCiv69zw3Wyx/E/i6HphTKWM7SplyTtfajxq2BYS
 LKNJhE34Ni9UCuPl/sZumI1TwoVxc7U665jOyZKXSYgWMkSrOLGVlpI10HpAC9U0dGkTkLgDfu2
 iovM2JFEuoS7z28qcJaqHtGCOikm2s/+dYGFtuNqeFtM1tjn56GfSxwlWSuprPH6pKLvOpIoDuo
 s4ED9+/QKMubgvGbXG/sJjHiwtPqC03O3rggGRu9Wwx/w4OxKOuKCBdClweVjdyFUMZz+rYJiqi
 ouJKlHXHWduQeXCqUmScclYKW/pyGYZDdlqqdcy99Ymw/Bmnt7fQprRxQogsl8b5uZdS6I75Mxc
 QXYnFS3gslis5fPM2OXZ0flP/O8j8Om44g3cSX3zvA1sPq8wIgCEZu3jMC/w/FqphmPkzhsqk4C
 lO4ItuOtAvvt1gnJ4Bg==
X-Proofpoint-GUID: ArdZUVFTMM-UX_X7Oe1vQ7--Q3meT3Ug
X-Proofpoint-ORIG-GUID: ArdZUVFTMM-UX_X7Oe1vQ7--Q3meT3Ug
X-Authority-Analysis: v=2.4 cv=BpcIUoX5 c=1 sm=1 tr=0 ts=6af47a15 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=oFVhhI-gopzdmxxvu7MA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_03,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110057
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

On Thu, Oct 15, 2026 at 06:28:52PM +0800, Yongxing Mou wrote:
> 
> 
> On 10/12/2026 8:23 PM, Dmitry Baryshkov wrote:
> > On Mon, Oct 12, 2026 at 04:44:06PM +0800, Yongxing Mou wrote:
> > > 
> > > 
> > > On 10/1/2026 6:32 PM, Dmitry Baryshkov wrote:
> > > > On Tue, Sep 29, 2026 at 12:25:32PM +0800, Yongxing Mou wrote:
> > > > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > 
> > > > > Whenever virtual channel slot allocation changes, the DP
> > > > > source must send the action control trigger sequence to notify
> > > > > the sink about the same. This would be applicable during the
> > > > > start and stop of the pixel stream. Add the infrastructure
> > > > > to be able to send ACT packets for the DP controller when
> > > > > operating in MST mode.
> > > > > 
> > > > > Add REG_DP_MST_ACT, the ACT trigger register used by this sequence.
> > > > > 
> > > > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > > ---
> > > > >    drivers/gpu/drm/msm/dp/dp_ctrl.c    | 44 ++++++++++++++++++++++++++++++++++++-
> > > > >    drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 ++++-
> > > > >    drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
> > > > >    drivers/gpu/drm/msm/dp/dp_display.h |  1 +
> > > > >    drivers/gpu/drm/msm/dp/dp_reg.h     |  1 +
> > > > >    5 files changed, 51 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > > index e1614bc49a7c..65d22505c2b6 100644
> > > > > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > > > @@ -142,6 +142,7 @@ struct msm_dp_ctrl_private {
> > > > >    	bool core_clks_on;
> > > > >    	bool link_clks_on;
> > > > >    	bool stream_clks_on[DP_STREAM_MAX];
> > > > > +	bool mst_active;
> > > > 
> > > > I really don't like the idea of having this flag in two locations. Here
> > > > and in the msm_dp_display_private. Can we have it in one place only?
> > > > 
> > > These two fields are intended to represent different states with different
> > > lifetimes.
> > > 
> > > msm_dp::mst_active tracks whether the DP connection has an active MST
> > > session. The controller field records whether the current controller/link is
> > > operating in MST mode and remains valid until the link is shut down.
> > > 
> > > I agree that using mst_active for both fields makes them look like
> > > duplicated state. I propose renaming the controller field to mst_mode while
> > > keeping the display-side field as mst_active.
> > > 
> > > Would you agree with this change?
> > 
> > What is the difference between these two? I.e. what os the difference
> > between those two?
> > 
> The difference between these two states mainly shows up during unplug.
> mst_active is cleared when dp_display starts handling the unplug, while
> dp_ctrl needs to keep the MST state until all streams are disabled and the
> link is shut down.
> 
> So there is a period during teardown where these two states are different,
> which is expected.
> 
> My concern with keeping only one state is that we would need to pass the MST
> mode through multiple dp_ctrl APIs, which would make the code more
> complicated. Would it make sense to keep this state in dp_ctrl and rename it
> to mst_mode to make the distinction clearer?

Sorry for the delayed response. How would the driver behave while those
two disagree? What happens if the user unplugs the MST sink and then,
without stopping the display, plugs in the SST sink?


-- 
With best wishes
Dmitry
