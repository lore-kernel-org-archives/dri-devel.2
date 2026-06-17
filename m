Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A850CD98EE
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB46610E99C;
	Wed, 17 Jun 2026 09:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RfMeHfXC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="THWLgpe9";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9F8E10E99C
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 09:09:00 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8V7902291400
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 09:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=VN3qeIiBcSYhjGDki3/bjTA0
 cHq2yUWAS4Dqv51Ypwo=; b=RfMeHfXCjDmhbEpYZAEq0vqqR9EX0zbmyIcoY1B9
 fJkiqsqFUrc7+LPPi5lGlR5AlXLGuWTtUgweyCi/OdYNBKlWhBdyYn0187qRTYfR
 XgM7Z0hFXb1pNTAf4q42cGCwq/tHIGeMXDGYEjjCYhh5ZiPhaDf4BNkReanym/c3
 kDeveXBXKxlK41AlSxhZPJv8YBhrWhsj9bFfKFnZ3WmWtnyafRIKctmE/4rZzBz6
 wnMacJA6Oyz2vm9s/Ek/uirFsrqvY0pm7LKPD27PiM6xQHedlK9HHUNu25vr2cc5
 SMgJw7x7Q53Vgv3j7M1XMs+as8/whTvfQ9fb4HrGvPitBg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueevjd43-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 09:08:59 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bc7296c59so1466707eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 02:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781687338; x=1782292138;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VN3qeIiBcSYhjGDki3/bjTA0cHq2yUWAS4Dqv51Ypwo=;
 b=THWLgpe9wG65QqWLYFj8yyMU2E3grTWoFFcGev4slykuZTMn0FaUoDxZq1QpUwjIty
 BxLudIMXTIq5Sp9MOrt1N88QR+6VST33UFoCm5/GY4RAef1lWGxPWeyxEBCuzOmd0U2T
 Qo8yA7uCqTkBPszyqGO7a2yVXVwEi018j1l/bWcpfecfj9olyENCKdGjc0MlUYdIxGIy
 meg6MTz51MzzB6LNTLGabZq3Aa1JsTNqkS27C+vEJ3A7Qga1AWg5AMdptk++F2wtWGgY
 iT3W3BHiqeIhIoLtG5ZX1bNKh/4lGgd14q/7TMLe4mvxi5AXiz3UDRmRU90t3/S975Ng
 GoMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781687338; x=1782292138;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VN3qeIiBcSYhjGDki3/bjTA0cHq2yUWAS4Dqv51Ypwo=;
 b=LHXtassgyAek16j2W3CaBtxN/2kvwDhhLAwyc3n/52D6sx7l9xO2RXJhW5DSiIO57Z
 sOqgFKS3DLeNytuU+VA8B6PglhLIvUchWOWCRNgPv7h8v+gMeOEPaKMvLBRQfUMS5i8b
 q8Y/3QcxjmgmPTcgVnnmf+36InFlB40WhF694MKwFoAluFdlA5ZZQnybyW6bU5rNLeEQ
 BoaVT0WkaNNvrvAARThALdSywh+R5NzM3FgOH0xZvspd8+3+6aLgixLpI5IrywPqpUNy
 jTn46hj6HrXdvqnVtIKh7SOfwH6NCdbvOr+jNmu0b8d6pV8cHWFvFzqDe5UeIHGQqICj
 G1rw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+T4nl686jqHSoaLOsS+4/ngsNd2Mm999ZxAmt2SWuY3Xfd5IoPk3cT2W/+Q1XLyHrhU7Jvp5b1v0o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzlnsAUwTz+W0qYiURC6SCMyCe5JPcVjjYYY3ahszoCU8qxOJ3S
 bbukxXe1i4YFFFbdRxctKCkR+tRCuWLd6qaK0WIEmLgdqj9OEEU6ZlbF1cXMMFEdoMjRjPtViPD
 1RmHhZSSDiyNaTxhQGzbiwvr0mmp9G7FWoH46KGD5A2V8NPnZsE/mMvIj7pypUkLQlrWTcyc=
X-Gm-Gg: AfdE7ckdoB9gM6MTVPFpdqb2WGjV6EJbmF9Iz4yI/2HkKoKCsyr3/hC0fCpHpYBSv7N
 C322Ctz8NnaRDqjpjz7ZtWCHYq02KWmOc0XBQ95bb47qc3el3TNCr9ebTWDt/7YRi92Ksx1taxe
 KvWZ+KjjqnVrNuVOL4wZYXJZwrlp8nS2s1B8B0bM1wMSlTqPkY2fcozV1Y4zlUd7ApYv20nmFjK
 ku9eS4pA6Mudwd99zzvgKlv/I7IJ5zCClcJPiaNXqGtbrXocrDBNoLsYjjzzdY+G98R4CJLLl82
 oU4x864h6HDhIpi65FlXAFXG1zjGUK7FjY2B6vqIeCJ1Te+JQ58XyYcznws1AU5wVDgDyze5v5+
 5nitL+Foo17L1aTUgnP3Amai47anj1loRMV11m75/HwBweQHz1mZ6iIK0WRg=
X-Received: by 2002:a05:693c:6391:10b0:30b:d865:4bdf with SMTP id
 5a478bee46e88-30bd865534emr357823eec.23.1781687338183; 
 Wed, 17 Jun 2026 02:08:58 -0700 (PDT)
X-Received: by 2002:a05:693c:6391:10b0:30b:d865:4bdf with SMTP id
 5a478bee46e88-30bd865534emr357805eec.23.1781687337602; 
 Wed, 17 Jun 2026 02:08:57 -0700 (PDT)
Received: from hu-yutlin-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30bd8ab412fsm1347950eec.31.2026.06.17.02.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 02:08:57 -0700 (PDT)
Date: Wed, 17 Jun 2026 02:08:55 -0700
From: Eddie Lin <eddie.lin@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: fastrpc: fix memory leak in fastrpc_channel_ctx_free
Message-ID: <20260617090855.ssteqlkldi3la4ex@hu-yutlin-lv.qualcomm.com>
References: <20260611-fastrpc-cctx-cleanup-v1-1-28097444116c@oss.qualcomm.com>
 <tiug7vw6ozzel3oed62qzogcjxo36h5vfy2d7xwlfqjecqptuv@m35i37kapu7s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tiug7vw6ozzel3oed62qzogcjxo36h5vfy2d7xwlfqjecqptuv@m35i37kapu7s>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA4NSBTYWx0ZWRfX1yvlfikLF7EW
 GyCTTZhigAortwZYmSnkGsY3yhUhKCKV8aFB0ehnlTqozauWcHF6wl8KikCrGakPw3hxdaFft9h
 AV3MZiCqi1aH9lkkCElpUv2BA7+/rydE37B800s09tW5eui6jgUbNbdHTURm/XR5218gRTUFEH5
 BLodZZe1fUpRozO68aY4DabQBKF8yo86Le+iqoStWn1If5Gbncow+OPkVCS/wcHZrjAMuoEad8e
 d8pRVh/d++rsFrNZY1RBfJrRhCvsawh5LzPxue616ViCUguDyvVdSl7mfirQ6+LGVpLcixJavml
 fJZCdFX5jtOgzT5JYfKRJ1TW31RmM1po6h1JmaGWJBKxHgqpZ32ydldhvfTjHzR2lWNkOfUbOeJ
 6VYwf9cLoJBMDg/If2NMZUzA5Jnj3E4Ngxc3fQlyLJ2DpuWKBlPOIgbZuZQAnR2KiJGv6gdd5IJ
 VNTK1oQ7ti6YNMDL4Ew==
X-Authority-Analysis: v=2.4 cv=LM1WhpW9 c=1 sm=1 tr=0 ts=6a32642b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=A19_TmA_pFzYmWefrn8A:9 a=CjuIK1q_8ugA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: w2G7baRnkl_Nfm-CvZHBZmrWWktO0gij
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA4NSBTYWx0ZWRfX7rXmGkilpZKY
 KuK8lNse7srvOonUGTgd1zNksrNt2rmydSP4pQ6i2bkdxMFwThYYlxbNaKEk+H98943TvaVk91/
 YAXSMJibHHPhYSe35VPSKIJGz8NfzkI=
X-Proofpoint-ORIG-GUID: w2G7baRnkl_Nfm-CvZHBZmrWWktO0gij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170085
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

Thanks for the review.

I will address these points in v2, specifically adding the Fixes tag,
adding cc:stable, and cleaning up the cover letter to reflect that
this is a single patch.

Best regards,
Eddie Lin

On Fri, Jun 12, 2026 at 03:44:42AM +0300, Dmitry Baryshkov wrote:
> On Thu, Jun 11, 2026 at 02:21:44AM -0700, Eddie Lin wrote:
> > The 'ctx_idr' is initialized but never destroyed when
> > the channel context is freed, leading to a memory leak.
> > Add idr_destroy() to properly clean up the IDR resources.
> > 
> > Signed-off-by: Eddie Lin <eddie.lin@oss.qualcomm.com>
> 
> Missing Fixes and cc:stable.
> 
> > ---
> > This patch series fixes a memory leak in the FastRPC driver.
> 
> It's a single patch, there is no series.
> 
> > The channel context's IDR was not being destroyed during cleanup.
> 
> Duplicate info.
> 
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
> -- 
> With best wishes
> Dmitry
