Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78869C4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C836A10EC58;
	Wed, 22 Jul 2026 06:47:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RVv4zsQ1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I5nSNmsw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65DC010EC58
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:47:25 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53fxP4027287
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=4HIgg+cAUIBu82rEBIKTHLC0
 oAMQkhK8PpibsSCULDI=; b=RVv4zsQ14AR8ddWCZC62vuMvCiMr9+pZAnOfQy8T
 m8KgZQGXsw7XWXHl54mAkKhUSFPcmxLelpEIC2hO2dzUiqaPKNSqhuMb47JCnwkY
 jP/M5Yf3T6DG3QRP/i9w0/Y62bPMVGH7HTLjrUi3+coETR0OHFlaqyZc6I5HctlT
 jk49fh3VWaLszWgBEBAY8UjtDAVw7aTWkZCOsbvUXz06a6ROLdT91e6XYcY+HqDY
 JMUsL6znu/a+1LJJdT1aYt0G9gv6UizBCJa+WlREq37htnqiS2ADK43PrBmYpgSF
 LK/0armdjZMTHiIexOxDsPaMQlwdEVLTTk4r/MMcYzc5GQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9bsbwx0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:47:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so295233561cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702844; x=1785307644;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4HIgg+cAUIBu82rEBIKTHLC0oAMQkhK8PpibsSCULDI=;
 b=I5nSNmswunJtbixVcG/ys6aSrC7RpwIiasHGJ4T0W98UBM8kJ88GN5dPzLoBIjkjiu
 3EIO4mrbNDTTCT3GXbv1U57y0Jbi9dCRQSfc90t1e1rV23Arb5TkJwEFECHAxUXenOcG
 pLDpVD3e4QC8dWj1W5mvXv7MfJsGZiUXvdUEM0YRIvRswRZNYmgH9XGZIxmcoUXBlf4B
 CWXzspbti39U00BVK1Jjm/DYnhiNhErFHE9IxEUFcVAk4SSaHSbzRJhKr74imE2QAQa+
 iXPKY50sjI5a5Ttjz6ajmkbTOtrpfq/Lyyhm54u/4KEiPO0QnO7/hNmExxAOJ8R6381u
 UmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702844; x=1785307644;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4HIgg+cAUIBu82rEBIKTHLC0oAMQkhK8PpibsSCULDI=;
 b=HphFPg7Zt4pJqb02YTflZGVe2W4Rs4/hOJ2xZ+FJRvCr1j/rYYSldGfJygoexLkzZ9
 2dve/otZ1MMYUaopDBmiaUBQVo6yN1KKIdITAFDjDGsjRYbNCSq345CF8eK/sES8e9AD
 Tl8SgQq53JRu+5ML6rPitr5IhLsU+N//+momBCRjYhKqNOMWCN9tUR5hUQuiowYm4IMq
 lq5dtJ/wuj1YWEgFEFQKRyhaNnWfs2oUWWir76bsleWogkom95hgU6qg9ZTxkD1ItL0e
 nPcnWNpeO4hkr0SyyhHvogcKlrtufSpZcZK146BF83MLEQPmOPfQL+yEJFOMWFLcD+DU
 AFEw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzXCkYZ8j0NXuJ6aVJD2+FIrjXuBuXqALT4ihya3eKRL11QU5hTyz8LXIoJRPnI/ECKjBcjnpHpME=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQvcrae8emqf+BlB5adX4/7HigyB5RFTM0q32i/S1Lflu/XO5f
 3mDA+HWtRPDkWoOv51gb8wj42F4VtP3x1eyKKbjpNv7SxAxy5OM5JRsXiGhAxdP6ertmX4laI2D
 Af0ubaoQyS7RnOIMtGMTPOoxyro+lpNDtR/7bOXI98an67EIOgKwSXxyEetc4UH4pZfkYO2I=
X-Gm-Gg: AR+sD133s/OUa4422m/FyUrUQm78yRMhf6HYCW36xeEBjhRImOrsqCxe0fqVjLt8ydH
 mET8tbIz6nn1ezPWoRnBFjLIxpuTGGBJGHfBw8oLAhoqEBsv2fjhj+y8idshIhSAdxsEpoyT64T
 Drv8TIFqBs6KHiU8OTE4pgzqvOqzl2iFK7+nsYOnn2ZvIogGHUQ7gXgzNcj6QeslPxfKDFBbr50
 e9lfZAcessdNlmu7C+7qxlQ1rVB9yj7Od5O5AKGjIWvUmuPbWxjMmo9cqDXUd6ecJd8pl9W1BZP
 fn+hFqq5sYHXLXjlmhVPUlK7jbhX3nUJKur6fSh/SwVwtPtVPkP7cQhiI7rG5kFTAU17gObGZs7
 dCZuMvS2irFBlykSZh/SXz45B69A1K+nlVUQDFR1Zp/EAGBJgoGMDM9ts+qOWkCFxC2I9HRrgCR
 DCGKHaNwgkKG/nYQ==
X-Received: by 2002:ac8:5c88:0:b0:517:a7ff:935f with SMTP id
 d75a77b69052e-5213c8e343cmr223366581cf.9.1784702843665; 
 Tue, 21 Jul 2026 23:47:23 -0700 (PDT)
X-Received: by 2002:ac8:5c88:0:b0:517:a7ff:935f with SMTP id
 d75a77b69052e-5213c8e343cmr223366211cf.9.1784702843171; 
 Tue, 21 Jul 2026 23:47:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39ef68883dbsm2999371fa.2.2026.07.21.23.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:47:20 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:47:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v8 03/39] drm/display: bridge_connector: Pass HDMI
 capabilities through caps struct
Message-ID: <zp7qqyaiir2npq3kzf23kqu26y3cr2fa7bdqtqnca2xggd3fvw@f4plbn6lzqng>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-3-d79890d00b6a@collabora.com>
 <eqnr2hfclbdkry2jqe2kuufss5kus6qpjblewq35upnjwlhxhl@4awqxpwrnxk2>
 <f74ffd53-5776-4fae-a6fe-eeace5c3fc5f@collabora.com>
 <20260708-bold-ruby-potoo-c6c949@houat>
 <dfe104fb-a132-4871-9dc0-52c157a2f08c@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfe104fb-a132-4871-9dc0-52c157a2f08c@collabora.com>
X-Proofpoint-ORIG-GUID: gNMKTbfJep7NH0odJJcq9Hu0Yar5A6eS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MSBTYWx0ZWRfXx7RbywlWG6Tg
 5SnqFmCbPwbqY0rltjMezilBbBmmC8dR6g6IS5FkuoSEhSqDRD8a9upHnPnxkZgbXvBtMKfdjeb
 VMwmrbs6dU8iXmIjC6Aq/P0rMK/Z8PY4m1+Cp6a8wHOFhKP1p+DOTXypUqirgpUBkRa+dXBMEC+
 VcXs/f8v//+iQUyfvnyvUqGVNLkJyiaACm2fR3Gb0ULKLoUNJ6ul+2EQDFIZWCj5Rm1bjRu3/8y
 7hC0QayaCUZcTxwdLj4QssddB8ZZduAQzBauZPmwthwUnIsmjfb42vtRTx3LuccAx5wvHEEwn0t
 NvqGGIaTfgJq7uTgi5BJydVnAQskT3TrJWQHWbkICTcn4nVFcg4isJeuL2HM2I/mqIQ1OJGNUhZ
 cSKZi36eRhxYZ1R8/uBWDnW8qs5rBHgD7Jydma5mmgz5E11ZrOXStIs4/f8NqbmNwOccMB0CD2m
 H/MIf+woUKbU6nNfr1A==
X-Proofpoint-GUID: gNMKTbfJep7NH0odJJcq9Hu0Yar5A6eS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MSBTYWx0ZWRfX8TcvE3LQihE3
 FJ9nPfN6Nu3cRM8bn42fYeKeoci/91G7zXJDwW1LbVfRDD41KkMAIx4YnZd6GjcdVMf++5kdPq1
 4eShDbHGL7Wd/mMP9bSKZib8Jn00sWw=
X-Authority-Analysis: v=2.4 cv=QK1YgALL c=1 sm=1 tr=0 ts=6a60677c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=agHu-2L6Iul8mJwuYagA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220061
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

On Wed, Jul 08, 2026 at 01:19:23PM +0300, Cristian Ciocaltea wrote:
> On 7/8/26 9:46 AM, Maxime Ripard wrote:
> > On Fri, Jul 03, 2026 at 10:55:09PM +0300, Cristian Ciocaltea wrote:
> >> On 7/3/26 5:19 PM, Dmitry Baryshkov wrote:
> >>> On Thu, Jul 02, 2026 at 05:46:16PM +0300, Cristian Ciocaltea wrote:
> >>>> Switch drm_bridge_connector_init() to
> >>>> drmm_connector_hdmi_init_with_caps(), collecting the bridge's HDMI
> >>>> properties into a stack drm_connector_hdmi_caps so future HDMI 2.x
> >>>> capabilities can be plumbed without growing the argument list.
> >>>>
> >>>> Introduce struct drm_bridge::supported_hdmi_ver to let bridges declare
> >>>> the HDMI specification version they are conformant with, and forward it
> >>>> to the connector layer through the new caps struct so HDMI 2.x features
> >>>> can be gated on real source capability rather than guesswork.
> >>>
> >>> And it's left uninitialized by the bridges, which doesn't mean anything.
> >>> If you don't want to touch all bridge drivers in one commit, please
> >>> provide some migration path and hopefully get rid of it by the end of
> >>> the series. 
> >>
> >> Sure, one question though: at the end of the migration, would it be fine to
> >> stick with drmm_connector_hdmi_init_with_caps() and just drop
> >> drmm_connector_hdmi_init()?  Otherwise I'll rename it back.
> > 
> > Absolutely, it doesn't make any sense to keep both variants.
> 
> I was referring to whether option 3 might be the preferred choice in the context
> of the earlier patch discussion.

Plesae exuse my ignorance, what is option 3?

-- 
With best wishes
Dmitry
