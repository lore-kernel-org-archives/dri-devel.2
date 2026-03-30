Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722E9FB3D05
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:39:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5B1F10E501;
	Mon, 30 Mar 2026 10:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HwCDMRH1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KI+dj0Kr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B09310E5BF
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:39:24 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U6sVWQ3526846
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=a9i9wrLS9XNkBua3QA++xjrO
 xjkkqC29YQgu3tBNhLI=; b=HwCDMRH1XWzCE4KKq7grLfD1WJmh6yWbX6Or3xeL
 9eFlssE1zhIJeOvFHZIQquZoeMezdrdbpJcU0xOI3Hcx4XByF2kSPPmy+wzi5kco
 XZqu0JgzcCQTPOcZeqaapt8cLMA+sBR4jN4Px9a/gfArg1XRvXhoTOawtj/sWU7H
 aiwrNKuot13cm9t7gd1pVcDHLjgAjXOUcJNd/+CX2pwqppBZHtn3f7rfqeUoqZqQ
 jHbeTG4Db+aRdmElmheQ+1XcEZAZqH+3o2WfmRZ3BE+Pc18V2NjopIFgWJDOlilY
 EWsh6q8QJnpKGXxNXbRWAafS/SbG7h5+MbeELmwzlXxQ7Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d6v9c3pv6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:39:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50925fed647so142399521cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 03:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774867163; x=1775471963;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a9i9wrLS9XNkBua3QA++xjrOxjkkqC29YQgu3tBNhLI=;
 b=KI+dj0KrswQpQhfyY56oe4bX6U/E5fEt5Tzw7KVCiUJ3Dw5KtlfB5ZVmiUB4W+amFM
 EdcyeD/XVzOtYSUIs6ZYcfWbzI+uvOkFkElUCLfhQ0YGgs/QB17vXSGg52APUdjau65e
 i75qkkmMCrJHAHvphjsXwOko37dhrER3VgIdjLqISVtO2JfzQX9kpMQyAjlZdp8fk4qO
 gu9LgCeK6orYMC8UBQWbyTHGLyKnL2KzbLWEV/+WSsOYnNaEwkKrJ+Bn2rSgQaWzStxB
 pyWs9YjrBODiYAYnAqrjhZXgIpPsh1zsXoo4vKt9xp6d/tm5/OltBSbg5dKAFeEd8SVz
 r1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774867163; x=1775471963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a9i9wrLS9XNkBua3QA++xjrOxjkkqC29YQgu3tBNhLI=;
 b=RQmuU9MgPg+4L/6AupjxJjESYn1R12rpMYcBg3vKtjGig05/ujMjM9o+m/aWf1O5GB
 r45kIiun/ohFeEH7jObX868Woch7xRasrVSr8kCzclCNnq8cKex7zmDdwq7wQwgFIxNY
 YZFm15Q1OHjiKZ5C3wIyjanj1X4ssGQw+5lkM4GZ0DWWGwm5VhXNXED4abPGfsMc5Rt2
 SYiPOqbGnDPrwJ31JDJds4Q+oD6LKBR0NOJz31grSLSjGX7QinpFi5OPEdaUYDawCuzj
 8UUxwtgOtJriBcENt6fBw3QxSr5jinHMwb5PAwU7uO/G7ApIlh8QNo7xPlVFzNTTEiZz
 Or/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy8wAd2tXIR/7A82DfB00NSJrC9shM1Y+2dgKj/t+9zDQ7i4MoV9HP3BCYthNOKaUIs/zhnb8/iO4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzustiZt7sGuMRG9jS79NyAXgCr5TZBanHBUOv94T2hSFrC3miA
 NsK+oq5n/rzckHllbTuoAse3SWM27X+s/vZmczwFvE/5OuLxzD940NqSoSp1OTjg6itkuMairVz
 4HVEQ/cahtWwGVd2YSyfL7uGgxiL2R7Ezm1ywY9TRS+utRC8qXAWWiDo4VQp8HH9bVZm2GxI=
X-Gm-Gg: ATEYQzyVNGJfJ0MfSQHN3ZlE1Hgxvgqj2rR62tSPb6DB7J8zWgf3ZXevVETZ3xL0QTd
 RhC0RrBLNyKVG6RvDU38Mfbk7sf1a6KwJBwXnLz7wU96g9tS+N3GeR5x/cPvoi/8BZXxKEzRBv5
 c+LI5Cg+PyqPKZPtp8ZYMyJP4Tf8cbNs19/V2PKrDHMt6jPRrsQwE79nCRAuMJ6bX27lAjDFvlE
 EEP18f/nmGiPDHbs7OfAnOLdqpkcUjJfJmzSRM/sEkSzgrRhnnEVUYPgx4D3MhIC4CngoxO+c7/
 wJG2fwEe6jjsIUFLKt9rUlAO1BuBFWczejjcsvQx8rZpBpklEJOgG4NfRv+qYrfUbCn85kHvEXI
 S4KRIEnsfGlGMCRD8T0fDrJ4r43DD8ulBRj/KAMm+wkbcmH/4sfteqCPXjhAizgCfXHmOQNlxVd
 rY88xlF94lxhetj1hWO7QpoAsHpkqdV1xQMPs=
X-Received: by 2002:ac8:5814:0:b0:50b:526c:541c with SMTP id
 d75a77b69052e-50ba3990f78mr156194601cf.50.1774867162607; 
 Mon, 30 Mar 2026 03:39:22 -0700 (PDT)
X-Received: by 2002:ac8:5814:0:b0:50b:526c:541c with SMTP id
 d75a77b69052e-50ba3990f78mr156194271cf.50.1774867162120; 
 Mon, 30 Mar 2026 03:39:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c838dece4sm14492121fa.35.2026.03.30.03.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 03:39:21 -0700 (PDT)
Date: Mon, 30 Mar 2026 13:39:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 14/38] drm/msm/dp: Add support for programming
 p1/p2/p3 register blocks
Message-ID: <ssiui2np2gvy3euj77t6rzpnvwzd6plnxaed6xpn3awj3fzswd@utphaip4lr7p>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-14-01faacfcdedd@oss.qualcomm.com>
 <34he7xawyuq5z4iiyq4y4ehkjhfalx2vxhtejgyxly4zgyqma7@4uqoas4sz3nl>
 <bd0fa742-fcba-47a8-81fa-aa43d9ff4edd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd0fa742-fcba-47a8-81fa-aa43d9ff4edd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4MyBTYWx0ZWRfX8cJ5F5j5n8Sp
 hE5TcQtE7nmvuK96FNx6UsTjEnbdQmUZaG454+8PotXzdjjY5znIiqfBTDCcEo4mVJKiSJOvpL6
 I6E5pfb3iHduOKrVb0hji4nFsdG5vMNAZshEHaOSdZ8bFDG0VCM4/oSWdnKMne1tMFS211bkU2M
 EAZ8i9s/UZq4tV9rC2B/JQmX2AK8ksjLzxH2HAe4oKIRevG6kjJePTI10sSWLF4qMiFYwncphZK
 Jx9tmxKWDIq1ZwqbUhUUOKL8Dfm16CLx+6bvMT2uR7rgVyivsW9v+srbZ6ZJ1i21LZX3LgRKKTY
 6u0uvfekNRqjmdMvrRxzCUE+qlYu/5Ntj/vmJ0GKnLAfTJU4rg62lzXXF7X2sthpTTGlUggVmqO
 +vAx1hWLl6UBVbi32DqDh1lOw3q/1GqhdHuThNtUrOcoHJeFWpiMYX5PDFsX3co1buWJueFEwsW
 x0t7KHNftjWFMGuHxEg==
X-Authority-Analysis: v=2.4 cv=EIQLElZC c=1 sm=1 tr=0 ts=69ca52db cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=M3gvwMrBDJyNMj2JsOwA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6rj6hamFY04XZcwWGcbZcGjZdznxC3e4
X-Proofpoint-ORIG-GUID: 6rj6hamFY04XZcwWGcbZcGjZdznxC3e4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300083
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

On Mon, Mar 30, 2026 at 06:27:41PM +0800, Yongxing Mou wrote:
> 
> 
> On 8/26/2025 1:59 AM, Dmitry Baryshkov wrote:
> > On Mon, Aug 25, 2025 at 10:16:00PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > QCS8300 supports 4-stream MST. This patch adds support for the additional
> > > pixel register blocks (p1, p2, p3), enabling multi-stream configurations.
> > > 
> > > To reduce code duplication, introduce helper functions msm_dp_read_pn and
> > > msm_dp_write_pn. All pixel clocks (PCLKs) share the same register layout,
> > > but use different base addresses.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_display.c | 39 +++++++++++++--------
> > >   drivers/gpu/drm/msm/dp/dp_panel.c   | 68 ++++++++++++++++++-------------------
> > >   2 files changed, 59 insertions(+), 48 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > index 3422f18bdec71a99407edfe943d31957d0e8847a..935a0c57a928b15a1e9a6f1fab2576b7b09acb8e 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > @@ -84,8 +84,8 @@ struct msm_dp_display_private {
> > >   	void __iomem *link_base;
> > >   	size_t link_len;
> > > -	void __iomem *p0_base;
> > > -	size_t p0_len;
> > > +	void __iomem *pixel_base[DP_STREAM_MAX];
> > > +	size_t pixel_len;
> > >   	int max_stream;
> > >   };
> > > @@ -619,7 +619,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
> > >   		goto error_link;
> > >   	}
> > > -	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->p0_base);
> > > +	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->pixel_base);
> > 
> > Why do we need to pass pixel base here? Shouldn't it be pixel_base[P0]?
> > 
> In the current implementation, dp->panel holds the full
> pixel_base[DP_STREAM_MAX] instead of just the pixel base corresponding to
> itself, so this likely needs to be revisited.
> 
> > >   	if (IS_ERR(dp->panel)) {
> > >   		rc = PTR_ERR(dp->panel);
> > >   		DRM_ERROR("failed to initialize panel, rc = %d\n", rc);
> > > @@ -937,8 +937,8 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
> > >   				    msm_dp_display->aux_base, "dp_aux");
> > >   	msm_disp_snapshot_add_block(disp_state, msm_dp_display->link_len,
> > >   				    msm_dp_display->link_base, "dp_link");
> > > -	msm_disp_snapshot_add_block(disp_state, msm_dp_display->p0_len,
> > > -				    msm_dp_display->p0_base, "dp_p0");
> > > +	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
> > > +				    msm_dp_display->pixel_base[0], "dp_p0");
> > 
> > This should add all blocks used on this platform.
> > 
> Let mark to be done here. Since a helper function is required here to check
> whether the pixel clocks for stream 1/2/3 are really enabled.

I don't understand the comment.

> > >   }
> > >   void msm_dp_display_set_psr(struct msm_dp *msm_dp_display, bool enter)
> > > @@ -1181,12 +1181,13 @@ static void __iomem *msm_dp_ioremap(struct platform_device *pdev, int idx, size_
> > >   #define DP_DEFAULT_AUX_SIZE	0x0200
> > >   #define DP_DEFAULT_LINK_OFFSET	0x0400
> > >   #define DP_DEFAULT_LINK_SIZE	0x0C00
> > > -#define DP_DEFAULT_P0_OFFSET	0x1000
> > > -#define DP_DEFAULT_P0_SIZE	0x0400
> > > +#define DP_DEFAULT_PIXEL_OFFSET	0x1000
> > > +#define DP_DEFAULT_PIXEL_SIZE	0x0400
> > 
> > No need to touch this. It's only required for legacy bindings.
> > 
> Thanks, will fix it.
> > >   static int msm_dp_display_get_io(struct msm_dp_display_private *display)
> > >   {
> > >   	struct platform_device *pdev = display->msm_dp_display.pdev;
> > > +	int i;
> > >   	display->ahb_base = msm_dp_ioremap(pdev, 0, &display->ahb_len);
> > >   	if (IS_ERR(display->ahb_base))
> > > @@ -1206,7 +1207,7 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
> > >   		 * reg is specified, so fill in the sub-region offsets and
> > >   		 * lengths based on this single region.
> > >   		 */
> > > -		if (display->ahb_len < DP_DEFAULT_P0_OFFSET + DP_DEFAULT_P0_SIZE) {
> > > +		if (display->ahb_len < DP_DEFAULT_PIXEL_OFFSET + DP_DEFAULT_PIXEL_SIZE) {
> > >   			DRM_ERROR("legacy memory region not large enough\n");
> > >   			return -EINVAL;
> > >   		}
> > > @@ -1216,8 +1217,10 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
> > >   		display->aux_len = DP_DEFAULT_AUX_SIZE;
> > >   		display->link_base = display->ahb_base + DP_DEFAULT_LINK_OFFSET;
> > >   		display->link_len = DP_DEFAULT_LINK_SIZE;
> > > -		display->p0_base = display->ahb_base + DP_DEFAULT_P0_OFFSET;
> > > -		display->p0_len = DP_DEFAULT_P0_SIZE;
> > > +		for (i = DP_STREAM_0; i < display->max_stream; i++)
> > > +			display->pixel_base[i] = display->ahb_base +
> > > +						 (i+1) * DP_DEFAULT_PIXEL_OFFSET;
> > > +		display->pixel_len = DP_DEFAULT_PIXEL_SIZE;
> > >   		return 0;
> > >   	}
> > > @@ -1228,10 +1231,18 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
> > >   		return PTR_ERR(display->link_base);
> > >   	}
> > > -	display->p0_base = msm_dp_ioremap(pdev, 3, &display->p0_len);
> > > -	if (IS_ERR(display->p0_base)) {
> > > -		DRM_ERROR("unable to remap p0 region: %pe\n", display->p0_base);
> > > -		return PTR_ERR(display->p0_base);
> > > +	display->pixel_base[0] = msm_dp_ioremap(pdev, 3, &display->pixel_len);
> > > +	if (IS_ERR(display->pixel_base[0])) {
> > > +		DRM_ERROR("unable to remap p0 region: %pe\n", display->pixel_base[0]);
> > > +		return PTR_ERR(display->pixel_base[0]);
> > > +	}
> > > +
> > > +	for (i = DP_STREAM_1; i < display->max_stream; i++) {
> > > +		/* pixels clk reg index start from 3*/
> > > +		display->pixel_base[i] = msm_dp_ioremap(pdev, i + 3, &display->pixel_len);
> > > +		if (IS_ERR(display->pixel_base[i]))
> > > +			DRM_DEBUG_DP("unable to remap p%d region: %pe\n", i,
> > > +					      display->pixel_base[i]);
> > >   	}
> > >   	return 0;
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> > > index eae125972934bb2fb3b716dc47ae71cd0421bd1a..e8c1cf0c7dab7217b8bfe7ecd586af33d7547ca9 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> > > @@ -26,7 +26,7 @@ struct msm_dp_panel_private {
> > >   	struct drm_dp_aux *aux;
> > >   	struct msm_dp_link *link;
> > >   	void __iomem *link_base;
> > > -	void __iomem *p0_base;
> > > +	void __iomem *pixel_base[DP_STREAM_MAX];
> > >   	bool panel_on;
> > >   };
> > > @@ -45,24 +45,24 @@ static inline void msm_dp_write_link(struct msm_dp_panel_private *panel,
> > >   	writel(data, panel->link_base + offset);
> > >   }
> > > -static inline void msm_dp_write_p0(struct msm_dp_panel_private *panel,
> > > +static inline void msm_dp_write_pn(struct msm_dp_panel_private *panel,
> > >   			       u32 offset, u32 data)
> > 
> > Is it really multiplexed on the panel level? I'd assume that each panel
> > is connected to only one stream instance... If that's not the case, such
> > details must be explained in the commit message.
> > 
> Yes, each panel is connected to only one stream instance. We just use
> **pixel_base + stream_id to determine which pixel block the request should
> be sent to. Just like your first comment, do you mean that the panel should
> only carry the pixel block address corresponding to itself, rather than the
> 4 blocks?

Yes.


-- 
With best wishes
Dmitry
