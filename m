Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B02C55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E257A10E688;
	Thu, 30 Jul 2026 13:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JtDGpmHE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L+QpCWkm";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F7FB10E15F
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:58:21 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UDcA6l837965
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=HAQjGeRZHjyUwhLQVrzoyan+
 i2a1c9ZmrG0BP4f4QSE=; b=JtDGpmHEJRmAYidb7xSW8UbrE6V3u1IQjp+WDhkr
 XsgLWPuDjJe//HelvH+nb5W4sUwseM2j5J1QJ7M4iFam4BlMoZ/5ou+24aoJITmc
 n1FiKdbsXbu4FZSJPzkCNpJCnfgUEbacSyeut+7NkPh+7IoiVIKMKTudfbhxRoXH
 OSFgsCpvJOYDJP/vjdvZ9GbyFzQmpAsd0jUTCB3zb4O6ATuUuZHxtvTtxTjcF3GG
 TwrGNkBlKvGg9kJLChk+4LbaSFCWrmkcTH1I3xF4QHRpl3V+kp+q5LUe9gD4YjtB
 +oi/x297yj3NAjW6h2d2iKiWwxTEgQxh6ZH1xl8EgBFeAg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr7nq82hw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:58:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c20762d21so26716361cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785419900; x=1786024700;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HAQjGeRZHjyUwhLQVrzoyan+i2a1c9ZmrG0BP4f4QSE=;
 b=L+QpCWkmE+Q1wceOAoxplelr2EIUeWrWvBdLZck7CC5ILCVn8cdgz1oIHQdFJ/buFN
 wXCzBqsIhkk0cOrnF4eYL6KmediQ4cJ7AGC/n8oiVzjPoUXoZqNAPCjJ/RmISLPabb20
 8RcctZJdwwKHF/776M2HxzS5T/thbKRbp0R9SRsw6JyRlCn2TLOQEduWSuJGbtk2pk5q
 iK81jlvcK8jHJy2Nupr63NA8EYsq36u+ZQOPZk58qOpzVyoAiSIajTZA9tL5YhXGkhWx
 O7O83DiViaslECrExLdBjwYqJAaf7v+leEfvILzVP7rFeeosdsvZrJUkbKbb70Y1CMVf
 Hygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785419900; x=1786024700;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HAQjGeRZHjyUwhLQVrzoyan+i2a1c9ZmrG0BP4f4QSE=;
 b=VAZzyCwZz5MnQ9qAc6HAR6NmdkqEGVE2kImSR4GYOxDePhSI5hwtYq1cbOvIFzzirl
 1NtlBshK3KTqBD8F2S1e56KwPzuU1n1PV/Oiyr7zOHnCDhnc3fuxEG+ElQxmTxU6/ANm
 3vxTaeWnNHRyjow84+dxOD4Xtr8nE7SEpLIQY2Ng2iqj3eqtViGpKhUmf6Xy5iZxgnC/
 zzmbLcOdYP+xqBehQf4Lcei6ZuXVHbAU+HRmLHudlcxWxvee8zLsH5Gtimivjxn9KiKO
 5lsS1DaUccFLAA6i8u2846oLRs1tL400JKk/InwAdOixWnVzi0DRwDYHCRWWIcMRDDC8
 3fMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrdxtCZjXRRs16xpX1dkCphYpMxL1Pc9z9d1arI3qCp2Ptu6VMzMsLqemywG0KS0AwPSrX94EhAXdc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAYNEbHCZpkYksqY4hcEJu3J7dapnAkGSZA8Nam4L78Y4VNcL8
 zhoo/0k2pIdPT2D/XTFFX5k80JGeWLPFYfeE09C82YZjRV6A7vtiprYcFJiZLFmOtA1lWial9xm
 cJoKkAs9H7ldFrpL2DBJkUmHVhFhVxl58qspnanFQBvObI/2NjaQcwXCTS1IduqYz/qYdRu8=
X-Gm-Gg: AR+sD12j+SV0wizOSsv10BJ92QdjOXw0do3Y+3Fhhoj6JbWXoQsj4bdHAAU/QP5n0OB
 +PitdejxRsI+UKX+pq2vdHxzfnTuVO2lXjjDe6tWbzWDHKkPJ7JWU7PctT3tJvAsYgHNDEuOrXW
 XSs5jJfekomGdQGzMgNTKQRJzDhyObnkxo4OX2kswK9g10Yvle2pThrKp+6GBGABPT4M4M2MCqw
 KvDX5XZW70dJytY4Dk+RG1Iqlnx81zIOYCosDyWH9N5UPr7QPxIMF5WVgiFrkZwhTV2wF3+RoLt
 pw0PpNFFGyqqnBbIA4RZwItKApYyuYv9Mh0w5JwXz0x6Aq5jCjKlMsSOP1pZLf/ZvqOj7djE3ci
 C+iJqgfVLy/VVIVAOD6XCZHUEnAB0Ycx7DkZ3deM29vYLOEvoD/fg080khJlXn0b7raPOIvS9sl
 LoYEADlocd3zyvsQ==
X-Received: by 2002:a05:622a:281:b0:51c:7b12:1200 with SMTP id
 d75a77b69052e-52b386c480emr27808701cf.78.1785419899873; 
 Thu, 30 Jul 2026 06:58:19 -0700 (PDT)
X-Received: by 2002:a05:622a:281:b0:51c:7b12:1200 with SMTP id
 d75a77b69052e-52b386c480emr27807931cf.78.1785419899145; 
 Thu, 30 Jul 2026 06:58:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2db94febasm343902e87.19.2026.07.30.06.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:58:17 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:58:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Joerg Roedel <jroedel@suse.de>, Russell King <linux@armlinux.org.uk>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, linux-arm-msm@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 3/3] drm/msm: detach the ARM DMA mapping before attaching
 our own domain
Message-ID: <h3rfonvwkxkmschyypytwgwxbmnq4rou4iyk6iq577c5tcfdl2@zrz3xhfzpmlr>
References: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
 <20260730-fix-qcom-smmu-v1-3-b12fa067804e@oss.qualcomm.com>
 <8e55ef12-6c4a-42b4-923b-238b3739ea51@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e55ef12-6c4a-42b4-923b-238b3739ea51@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=HIvz0Itv c=1 sm=1 tr=0 ts=6a6b587c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=iwl2vSsomdHTBBcAHCgA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: xhmxre-DhKfex6TyJj5cdT3-huMnkScI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNiBTYWx0ZWRfX+qQHGHgmZs7l
 4ZYRU5lD/IaT2YBQLy4vbTpdwvYtEEuZIrpeOyqSutyQwIDp83KCgMi/P48hOBjS3ItCNZk+MNp
 030wCfDzLQUhMEPiuhfnd7oVzSZAIJs=
X-Proofpoint-ORIG-GUID: xhmxre-DhKfex6TyJj5cdT3-huMnkScI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNiBTYWx0ZWRfX51xwvkjC+kyn
 DrfpKFX8iQkXJkfkVyrqhP6a7EfQjy6EzPHYROmxXnvq5PEPxwWXtvmlhIOFj/cWjbkmUHphsOm
 qpDYaew/meij9BlnbMypfsJNB+JAFlmshoAtUUDKbGksgxXW3bBf2lGbCbKQgK7VnAmQli06U2V
 OoOYHWNCoMeJiMa4IvyTuYcUvt90mMoFX9ihEaMQxAjniTrV6LFWixO6slAsOt3E5Ca+s067w1u
 L413Ivwk1qTIP8cHqCLDPrMdOVXdCKlnB88ygWuh1rVlpal2Eu6qqetE5do8YrvnDdrEYUwA6ke
 P7GNcN/Nq64jowVY0C03zLOMMIcwLDtxWNMLr3Q/lAoIrodqljxMTbxHH1mPpA/z4zgRo3sgHZp
 8ZSemIn2c6lg5WHyPhCuMe64UaNNuwTyQfKKO/tQYrihCA9q6FXVTSL8rScv+NHssRzdifHv7NF
 3VGLkp4D+r0/8Noiogg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300106
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

On Thu, Jul 30, 2026 at 03:42:58PM +0200, Konrad Dybcio wrote:
> On 7/30/26 3:29 PM, Dmitry Baryshkov wrote:
> > On ARM32 with CONFIG_ARM_DMA_USE_IOMMU, arch_setup_dma_ops() creates a
> > dma_iommu_mapping for every IOMMU-backed device and attaches its domain
> > to the device's IOMMU group. That domain is neither the group's default
> > nor its blocking domain, so when msm_iommu_new() later attaches the
> > domain the driver manages itself, __iommu_attach_group() refuses it:
> 
> [...]
> 
> > +#if defined(CONFIG_ARM_DMA_USE_IOMMU)
> > +#include <asm/dma-iommu.h>
> > +#else
> > +#define arm_iommu_detach_device(...)	({ })
> > +#define arm_iommu_release_mapping(...)	({ })
> > +#define to_dma_iommu_mapping(dev)	NULL
> > +#endif
> 
> I see this is prior art, but should we support this config being off?

Yes. For example, on arm64.

-- 
With best wishes
Dmitry
