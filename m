Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4441061B1B
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02DA810E4AE;
	Mon, 30 Mar 2026 18:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lg4mFrYV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FIwS3TSk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89D0810E23B
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:42:30 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UF02Nr2391788
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=tmSly2krkyEPd3C1QckzdIz2
 IUKLQUpW62wr+IkZxLo=; b=Lg4mFrYVXlfkHbSHjzYG742sLp8Hw8PbBuqXveTw
 o7U+tcLPv3gt3ouVf0nNtzUc+oQB2a0tDB/7h8AIW9t7DUCmi6mVGSYfMRtNTQBM
 rlbXmLr1nN5nMQFlGGnG1LoeJBut5sP41sHthsDK6u9ugV6QfjmhQ6mJtmR2Dm1h
 fGQV66ppZo8A4qNnaxbBHuvA3IF/IeJmiL/I+OhmESb5H9BbUFPGXGHJmme1TQbg
 iUqA2IW8fY8zQawH9rh5/SKWVVbCcoOM26JOdG7Jzb/g1H0Ul3ZGUSt1bn2O1FWZ
 5wv92hzXy9B8Y2T+uuw2V0bTSuVdks569KQI67RrlBxbbw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7ue7gw7e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 18:42:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b52a2d70cso143835741cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774896149; x=1775500949;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tmSly2krkyEPd3C1QckzdIz2IUKLQUpW62wr+IkZxLo=;
 b=FIwS3TSkNZq05uT5zNgo2XRHLMF27d2PLC1mCXDLVctjH3HTkm4t2PjvK5CDm6SJAk
 zwTlq0pWqoef9KVqmMo2QwO26ZST6/TuBDg2yV3/yKIiYAtaSaf6RPC9kD+KnnFgC/yn
 HBT8gxQfSEGjfZ9YHXlwBV5KySTuf303z4R6vNgcHljIDy08OIrGSNgWRP5IxSsbF8c2
 xLhYTg51Ooj4CPY2fvIVoxYSG3Uu+cExZN3J1Dyvf/0/VV3lyfxEwTpHAUg95iODf8oq
 6a0L/aLNVfijdIge2LE+LgsGkF5zaycksmzLSLkg7Mg9smtNZapYyphOFT9Y5zyFFwCo
 u6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774896149; x=1775500949;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tmSly2krkyEPd3C1QckzdIz2IUKLQUpW62wr+IkZxLo=;
 b=ILFSSWqQOyoTR/XrCjEnN0Sborjg1MbqNaR2lqUS8wHNUWeBPhif92TCTrpyRdzRl8
 bdTSVaIiUzJnDrAseSJKz2eZlSu7HVqz9ogtvSgNcUyJAjk1Z4I23b+XtgXRuvCuClt9
 79Hu7WLCRFMWS41NW9Fi8UZS8PGAXw/5SL7NQGO2WYy1P+RGcBHSyR08gkfiHoKghklH
 4dL5Imb1em/7fcQ1WSCg1rgZxD5DRP3XAE99jpT2TglzVxNyWxKSjrzRDrOjuzdb9hzi
 fX3khnp8f+rzwN6BGzXRx7AwcKRgLfXx96H0o1CbxhlJ6IHNpflTrRl7nbUsKgTkXBqC
 68pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfUuRnnnrfVaKdPOpNpIaXxIhi1QZSm3JotTTRX7wUzhL+3BGz6QYH8Oool4jnE878JbMmqoyzAtU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywh+MNvtMYPbS19E33zoVIj6ftE3glbD3+CJtL/FG+cKApb1UK/
 8goAUZ4xX/z+KJbHP/PiXQy9v5rOo2c8LwxoXyEVbNiBhO+f6ksd4xhG0X3HnAuqU1ztjZkDd9X
 tvC1GZ74vnLoBYpQBUj09k7pGaunZjERS+JR427tnY4tox24zqHIiZ3vMgKieCYRPdmwwScs=
X-Gm-Gg: ATEYQzyZCVqZ7TqpYBiW0E3O8HPAVmWsqMVzjIxrYn31KAicXUl2lglRnSbkyizug2d
 Q5H+xE9rE21LDCEah8P0VP4akXIx1bKqyWqjvV6MB6Fpn54jsb3OIJ9qQC5/bqWd2yxuqETvdzd
 V8YtfdtckCtyObxPKCFdm92uUFUyndPYwbrzgSCoE4DaROYfC/q5Gnawz1lX9m17iXqdGUEy8Lv
 b6Wpy2LzWTpnKOBAtbdcmN0d41X+T+qcocoVbdBZXBzgAfQqdxa1UVpPWo1wcu2oV8Y8VAzf1mG
 P/lB688KlD128FqEXQmSswKWQvrJGaeobo1H9OSSUTXccBFQgOomQAo23RSbQ/5p0+zXrNh18WT
 X2zHit0sh9ZfEt9pLR6q3DnF/Jgkas6OROMlXeDmYQJiKXIxNlq/kjtlNv9CV+MLPx0jDGrwuRV
 N2PmWmI7DvJfzYvNUAt3uuJsrx1E1F53xkoa0=
X-Received: by 2002:ac8:5914:0:b0:509:172f:bd5 with SMTP id
 d75a77b69052e-50ba380a2bamr194038031cf.4.1774896148922; 
 Mon, 30 Mar 2026 11:42:28 -0700 (PDT)
X-Received: by 2002:ac8:5914:0:b0:509:172f:bd5 with SMTP id
 d75a77b69052e-50ba380a2bamr194037551cf.4.1774896148325; 
 Mon, 30 Mar 2026 11:42:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13f435bsm1815809e87.9.2026.03.30.11.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 11:42:27 -0700 (PDT)
Date: Mon, 30 Mar 2026 21:42:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Ritesh Kumar <quic_riteshk@quicinc.com>, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, sean@poorly.run,
 marijn.suijten@somainline.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, quic_mahap@quicinc.com, konradybcio@kernel.org,
 mani@kernel.org, James.Bottomley@hansenpartnership.com,
 martin.petersen@oracle.com, vkoul@kernel.org, kishon@kernel.org,
 cros-qcom-dts-watchers@chromium.org, linux-phy@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 quic_vproddut@quicinc.com
Subject: Re: [PATCH v4 1/2] dt-bindings: phy: qcom-edp: Add reference clock
 for sa8775p eDP PHY
Message-ID: <yex4vskdbtvodzkkxbs6yxkeiz5bb3x32f5nx5qklf6oyexroq@zspg26phklt2>
References: <20260128114853.2543416-1-quic_riteshk@quicinc.com>
 <20260128114853.2543416-2-quic_riteshk@quicinc.com>
 <gurq34svc5p52bqx5qwkgjmschzcbklmssjzmu2tg5wzgppkft@c6nrw2ageyp2>
 <c77ff64f-57d1-4495-bfbd-986644aad71d@quicinc.com>
 <acqGFwaVFQ3ZNmlR@baldur>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acqGFwaVFQ3ZNmlR@baldur>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE1NSBTYWx0ZWRfX9uZGdnOM4CW1
 cqdjctrgKmhiAL6qBbLmUhuiVu70/MKytjxLTf39y/egIpJDC8luYsOSJDCKUGgK0Fy9hAs6YML
 JVnjU6azAvV2HJD706/xr/4M07dSBrvrkphC2iCF1M9Lbz3iz3Yc61gHwh021DM3wtZkdtSCH35
 YYSvulE72G4Ui4A3cPlgfBE7aLuX8PlGBtQ/U6re7guW31AJfHGqJUjeUSoguyeewUWMLcgUizT
 AZBn9rDIOBKSBV0AEqRU/Zkyf7w0CiL4bgXF1Aj5GrWc2XP3qldRHZrUrRkb8puR8BsMOQSfOuq
 CW2/jymzV2SIJta06CGSwadZT/WPze5s3QGiYE/NOBTujNaGT1aFuaILdT3419F45sS+/iHolYs
 brr/T18TVDKxKKmSuFjsquj8zP+8rLRuhRpXqAeg+W82xFMXGsKvDNPJMX/BZzrHfz5oSSUUngc
 VmBOCpsc680SawBjGXQ==
X-Proofpoint-GUID: XTFt8R_yPR7DnX7IP-yToJf6plC6CSjQ
X-Authority-Analysis: v=2.4 cv=G7sR0tk5 c=1 sm=1 tr=0 ts=69cac416 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Ns0KfnHm5iy1vUwMj8cA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: XTFt8R_yPR7DnX7IP-yToJf6plC6CSjQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300155
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

On Mon, Mar 30, 2026 at 09:28:40AM -0500, Bjorn Andersson wrote:
> On Wed, Mar 11, 2026 at 06:37:31PM +0530, Ritesh Kumar wrote:
> > 
> > On 3/5/2026 12:27 AM, Bjorn Andersson wrote:
> > > On Wed, Jan 28, 2026 at 05:18:49PM +0530, Ritesh Kumar wrote:
> > > > The initial sa8775p eDP PHY binding contribution missed adding support for
> > > > voting on the eDP reference clock. This went unnoticed because the UFS PHY
> > > > driver happened to enable the same clock.
> > > > > After commit 77d2fa54a945 ("scsi: ufs: qcom : Refactor
> > > phy_power_on/off
> > > > calls"), the eDP reference clock is no longer kept enabled, which results
> > > > in the following PHY power-on failure:
> > > > > phy phy-aec2a00.phy.10: phy poweron failed --> -110
> > > > > To fix this, explicit voting for the eDP reference clock is
> > > required.
> > > > This patch adds the eDP reference clock for sa8775p eDP PHY and updates
> > > > the corresponding example node.
> > > > > Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
> > > 
> > > Is there any reason why you didn't follow up on this patch Ritesh?
> > > Looks like it's ready to be merged.
> > 
> > I was waiting for patch to merge as there is no pending comments.
> > 
> 
> It's been two months now, if you want your patches to be merged please
> show that - ask the maintainer for a status update, ask a colleague to
> send a reviewed-by...
> 
> Perhaps the maintainer lost track of your change?
> 
> Perhaps it's not clear that the change "need" an Ack from e.g. Dmitry
> and then it should be merged by Vinod? Because you're changing two
> different subsystems but leave it up to the maintainers to figure out
> how to deal with this...
> 
> 
> Either way, show that you want this to be merged, don't just wait until
> the situation resolves itself.

For merging through linux-phy:

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Vinod, please pick it up through your tree.

-- 
With best wishes
Dmitry
