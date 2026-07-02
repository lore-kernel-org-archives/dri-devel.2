Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F17C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 02:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43CB010E406;
	Thu,  2 Jul 2026 02:38:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l27H+qwL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VpoK+hB1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4687D10E406
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 02:38:07 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KPZg2945428
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Jul 2026 02:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=aAocksvrvPiuDLZfb8BX1Ap+
 0GdsKT9KorXLJ830nKw=; b=l27H+qwLr0JagE3CWYagpwkMQQFOAO5shE+X50T3
 8FZ6qoFlq5MvKzsnmKa4vRr0+GHJMGZpNDk4rx2O8KdqUeHLMaJrabCHk3nUMkS+
 +y2XutBQfw+51/3ZnAWZ5IU9g3DyxGE8DyFcjNxBig2b9vtOPgpgLQ4ISATWh9nr
 79596mtWdj82JC6vpQXgpc+6qJhphdQH3pdWkYslF1uznoWM9URigPjz3twe/YDG
 eyKgVJmUeu91cjrK7P8crnyc41rygd8osv5+1mFe/Wt2agUWRv5nA6xMC1c3+ikX
 ak/cty4vrCpTBvMfhTNoQKEROxrYMSR6uYmqP6IhO1VDjA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f502uv01p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 02:38:06 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c889d1eebafso2295225a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 19:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782959885; x=1783564685;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aAocksvrvPiuDLZfb8BX1Ap+0GdsKT9KorXLJ830nKw=;
 b=VpoK+hB18S1rjjXD1o9k1ley9dgwHjaZXuodwP+dwvNvaiDmbNqgm1UwmPf/pmY7On
 wHHxVeC518tWk02W/y96RAtyoqqzjegwmEPDNK9kD5GPVNt03QKbjoC8/NMN/6Z028pt
 eOUX8d71h8nAVKFcANMldgtK1zmGzMy6FXYGulCjknL29I8bIuBRz+LRRcx5wtCDi2rN
 aXhkgaKmClePiio9tRR8Se25Pi0RnrMufLjvdZqBq9RI273VdWszPIfsN7772v9mNyLZ
 AlmklE6qNDdXJUeoEgTPS5p8r0D+x9Z/1Kbu/7nkJIf39P434bQvo1yW/S3CyU40ORi3
 sLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782959885; x=1783564685;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aAocksvrvPiuDLZfb8BX1Ap+0GdsKT9KorXLJ830nKw=;
 b=PC3PPj4nB2cQLykItLuzH+llj0FmU2tYPTl6EieyWXwUSdy8+PmVQJh7YdjfPb0BpQ
 phSYDRngYBEKPnE7OtzY24QHGTbsPI1SPUcUIqlAZlBMKImxHxASV1U0eVc1relO/MC9
 8wdwKpvDSidLUi3bT1NLD9SbBVUIFnawdPBus5krjDIVxMMHTpWCOKjCLLdIwoK0BgmM
 2uskYAGruvV3pYt6Axh9NsIpG6mqXaCS3nppWTKq77F2q6w8ktVFKFE/quwNc/gdrNyk
 IoHXDa9IGX19IaYfeRjGL3mJ0RR0el2unY8zjDAfnMgTRJRJdwnJhTyyFPZTpF9pK7Bv
 me+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+b2PXTgrwt7MTzfsSvFuPi/iy5t4gwoAln7Vx8XTRxxh/tjCQBeiXJW88gI4f0tRas78bZBxlcXf8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjIavtP+ZydF5L1VXPp/aOZiwTyYRi14sjyu2SzlEJJl24uSaX
 gTM4ajHJSmYpkGLTHKsSSAgBXKm7X37GXtNku+6HUHpAjLdOkHQ5v1llpMMgGhKb33zWqtRA/bD
 cAGLLLSsV232+LAr3mmzBDrOfovnY5VudN7P6kMCQ+StkcWdMtm21zijeuZS8LgKwKw6DiWo=
X-Gm-Gg: AfdE7cl3kcpIcRTTbcQ4HFjwt3h8njWQedRS3KbEKuODUMZhGDy+96rkyOrhojd8VM4
 8GVGdkUhcpF3opEo2HajZtYlPGPxe0EUx12JWLjUHz4lxE+AdW8bEgmpGW0ClZ+7tazVvkM+Yok
 IlmHEjHDHBTnQu2Z+jh3LelTB6eMECKA8GIb0oW8V5vCr/pzhEDv3Jg+74d3FWAiV12jj2/QvYc
 6yfw8NVCXdd/pzY3B8dQSJOl/XN2KFiXqW1mE8RY/4Sb6vstnOoteqy/Fn2RqnB+6Iryb5iONfX
 H1bTN2EJyqVjPl+TjiF32D1j9do8OqjpRBgo4Bq9RaFy39fVrLgIgNlq7lz+KmOkRiF17abinG3
 H7ihU6f4heAKmIb8uaPTd5xW1Sc2hjua4uBrivifGB/iYqI7wgYpQSqQP/io=
X-Received: by 2002:a05:6a21:398f:b0:3bf:e449:332a with SMTP id
 adf61e73a8af0-3bff3ffd7bfmr4105592637.3.1782959885042; 
 Wed, 01 Jul 2026 19:38:05 -0700 (PDT)
X-Received: by 2002:a05:6a21:398f:b0:3bf:e449:332a with SMTP id
 adf61e73a8af0-3bff3ffd7bfmr4105560637.3.1782959884515; 
 Wed, 01 Jul 2026 19:38:04 -0700 (PDT)
Received: from hu-yutlin-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c85b345sm4458728c88.10.2026.07.01.19.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 19:38:04 -0700 (PDT)
Date: Wed, 1 Jul 2026 19:38:02 -0700
From: Eddie Lin <eddie.lin@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] misc: fastrpc: fix memory leak in
 fastrpc_channel_ctx_free
Message-ID: <20260702023802.vsma2ler3idkj7ru@hu-yutlin-lv.qualcomm.com>
References: <20260617-fastrpc-cctx-cleanup-v2-1-be87c021114a@oss.qualcomm.com>
 <8798249b-631f-410e-8b1a-fb1c35545134@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8798249b-631f-410e-8b1a-fb1c35545134@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAyNCBTYWx0ZWRfX1Vcy1rL9RftA
 iRUszUEgt9QGy4Ymi+o8EWaFF5SSBZtn1Kn33C1Iy+ONRUC66swUq8nh3LpTaa6L68U5p0jevTP
 nJVFVRxbYd1W4xPXS05y4lI/0Yc5jdE=
X-Proofpoint-GUID: Xt_qa26jec1eKFQ-EQ0wNzm3MvZISKB0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAyNCBTYWx0ZWRfX8we8O5UM06Gj
 H5IYQTGg2IwdfZ4HuiHkTKR58qsnk3Y2HG5IQj0TT93/fzjbylZewPgN85wCqC5HCdAn309kFSc
 AiqxDNYXpohe4++8zZe6xGjLr85JTO71SfysdCeEx9D7BU9SkJLO2mpwCmmUy5adLXMlyRGRIOR
 Pp4ygI15ut/ifJvCALx5F3RyxOuHLyCytDTYVhgcDJg4OHxKsBw9apXYE8p4HNHF51HQLAzK+Es
 U6CN3YE+NACTV0hBgiWi4PSn/QvBIpn47Zb4xPxznYwWjidhKRgMfa0+M0yVRIN1mAHG9840Rj+
 DKVgGqOGDXqSKTgI5x3pbAssUrwrVs93JrvK6iAHVg7SQp2iGPbi1Ogggr3k+FXOTpcY8e8ufbF
 KttwrS6l3pXDrcTxfPLTQ9IQxYOzlthF/J2x1lAGlgxzAcwYK7eeJv9DEAW29HscPyzVGqYU1vn
 O5njCTjPhc5Os/Ghp8w==
X-Proofpoint-ORIG-GUID: Xt_qa26jec1eKFQ-EQ0wNzm3MvZISKB0
X-Authority-Analysis: v=2.4 cv=PbLPQChd c=1 sm=1 tr=0 ts=6a45cf0e cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ADK-pmORIISXle8dMtUA:9
 a=CjuIK1q_8ugA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020024
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

Thanks for the review! 
I've addressed the comment and sent out v3.

On Wed, Jul 01, 2026 at 05:05:40PM +0530, Ekansh Gupta wrote:
> On 17-06-2026 16:39, Eddie Lin wrote:
> > The 'ctx_idr' is initialized but never destroyed when
> > the channel context is freed, leading to a memory leak.
> > Add idr_destroy() to properly clean up the IDR resources.
> > 
> > Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eddie Lin <eddie.lin@oss.qualcomm.com>
> > ---
> > This patch fixes a memory leak in the FastRPC driver by destroying the
> > IDR associated with the channel context during cleanup.
> Looks to be duplicate information. Please remove this.> ---
> > Changes in v2:
> > - Added Fixes tag.
> > - Added Cc: stable@vger.kernel.org.
> > - Removed duplicate description from cover letter.
> > - Link to v1: https://patch.msgid.link/20260611-fastrpc-cctx-cleanup-v1-1-28097444116c@oss.qualcomm.com
> > ---
> >  drivers/misc/fastrpc.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > index a9b2ae44c06f..7727850e9240 100644
> > --- a/drivers/misc/fastrpc.c
> > +++ b/drivers/misc/fastrpc.c
> > @@ -492,6 +492,7 @@ static void fastrpc_channel_ctx_free(struct kref *ref)
> >  
> >  	cctx = container_of(ref, struct fastrpc_channel_ctx, refcount);
> >  
> > +	idr_destroy(&cctx->ctx_idr);
> >  	kfree(cctx);
> >  }
> >  
> > 
> > ---
> > base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
> > change-id: 20260611-fastrpc-cctx-cleanup-bfd20aa7b8a0
> > 
> > Best regards,
> > --  
> > Eddie Lin <eddie.lin@oss.qualcomm.com>
> > 
> 
